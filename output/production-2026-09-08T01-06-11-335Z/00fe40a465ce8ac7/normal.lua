return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, createUpvalueProxy, createClosure, createClosure7, createClosure0, allocUpvalue, releaseUpvalue, createClosure6, createClosure1, createClosure5, currentUpvalueId, vm, upvalueValues, createClosure4, releaseUpvalues, createClosure2, upvalueRefCounts, createClosure3)
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
                upvalueRefCounts[upvalueId], captureIndex = upvalueRefCounts[upvalueId] - (1), (1) + captureIndex
                if upvalueRefCounts[upvalueId] == 0 then
                    upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
                end
                upvalueId = captures[captureIndex]
            end
        end
        currentUpvalueId = 0
        createClosure0 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function()
                return vm(entryId, {}, captures, gcProxy)
            end
            return closure
        end
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if upvalueRefCounts[upvalueId] == 0 then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
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
        upvalueRefCounts = {}
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
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
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, ReturnVal, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85
            while state do
                if state <= 117 then
                    if state <= 70 then
                        if state <= 49 then
                            if state <= 36 then
                                if state <= 35 then
                                    if state <= 34 then
                                        -- root entry 15865051 -> 1, states 1-34
                                        if state <= 17 then
                                            if state <= 9 then
                                                if state <= 5 then
                                                    if state <= 3 then
                                                        if state <= 2 then
                                                            if state <= 1 then
                                                                if state == 1 then -- entry 15865051 -> 1
                                                                    r29 = allocUpvalue()
                                                                    r12 = allocUpvalue()
                                                                    state = true
                                                                    upvalueValues[r29] = state
                                                                    r33 = "string"
                                                                    ReturnVal = _env[r33]
                                                                    r33 = "gmatch"
                                                                    state = ReturnVal[r33]
                                                                    r33 = allocUpvalue()
                                                                    upvalueValues[r33] = state
                                                                    r70 = allocUpvalue()
                                                                    state = createClosure2(35, {})
                                                                    upvalueValues[r12] = state
                                                                    state = false
                                                                    upvalueValues[r70] = state
                                                                    r37 = "pcall"
                                                                    r85 = _env[r37]
                                                                    r6 = createClosure5(36, {
                                                                        r70
                                                                    })
                                                                    r37 = r85(r6)
                                                                    state = r37 and (2) or (3)
                                                                    r66 = args
                                                                    ReturnVal = r37
                                                                end
                                                            else
                                                                if state == 2 then
                                                                    r85 = upvalueValues[r70]
                                                                    ReturnVal = r85
                                                                    state = 3
                                                                end
                                                            end
                                                        else
                                                            if state == 3 then
                                                                r85 = ReturnVal
                                                                r37 = "math"
                                                                ReturnVal = _env[r37]
                                                                r37 = "random"
                                                                state = ReturnVal[r37]
                                                                r37 = allocUpvalue()
                                                                upvalueValues[r37] = state
                                                                r6 = "table"
                                                                ReturnVal = _env[r6]
                                                                r6 = "concat"
                                                                state = ReturnVal[r6]
                                                                r38 = state
                                                                r6 = state
                                                                r82 = "table"
                                                                r57 = _env[r82]
                                                                state = r57 and (4) or (5)
                                                                r21 = r57
                                                            end
                                                        end
                                                    else
                                                        if state <= 4 then
                                                            if state == 4 then
                                                                r45 = "table"
                                                                r82 = _env[r45]
                                                                r45 = "unpack"
                                                                r57 = r82[r45]
                                                                r21 = r57
                                                                state = 5
                                                            end
                                                        else
                                                            if state == 5 then
                                                                state = r38
                                                                state = r21 and (6) or (7)
                                                                ReturnVal = r21
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 7 then
                                                        if state <= 6 then
                                                            if state == 6 then
                                                                r21 = allocUpvalue()
                                                                upvalueValues[r21] = ReturnVal
                                                                state = upvalueValues[r37]
                                                                r38 = 3
                                                                r57 = 65
                                                                ReturnVal = state(r38, r57)
                                                                r38 = allocUpvalue()
                                                                r2 = createClosure4(37, {})
                                                                upvalueValues[r38] = ReturnVal
                                                                r45 = "pcall"
                                                                ReturnVal = _env[r45]
                                                                state = 0
                                                                r57 = state
                                                                state = 0
                                                                r45 = {
                                                                    ReturnVal(r2)
                                                                }
                                                                r82 = state
                                                                state = {
                                                                    unpack(r45)
                                                                }
                                                                r45 = state
                                                                ReturnVal = 2
                                                                state = r45[ReturnVal]
                                                                r2 = state
                                                                ReturnVal = "tonumber"
                                                                state = _env[ReturnVal]
                                                                r54 = upvalueValues[r33]
                                                                r47 = "tostring"
                                                                r5 = _env[r47]
                                                                r47 = r5(r2)
                                                                r5 = ":(%d*):"
                                                                r83 = r54(r47, r5)
                                                                r54 = {
                                                                    r83()
                                                                }
                                                                ReturnVal = state(unpack(r54))
                                                                r54 = allocUpvalue()
                                                                upvalueValues[r54] = ReturnVal
                                                                r83 = upvalueValues[r38]
                                                                r5 = r83
                                                                r83 = 1
                                                                r47 = r83
                                                                r83 = 0
                                                                r14 = r47 < r83
                                                                ReturnVal = 1
                                                                r83 = ReturnVal - r47
                                                                state = 8
                                                            end
                                                        else
                                                            if state == 7 then
                                                                r38 = "unpack"
                                                                r21 = _env[r38]
                                                                ReturnVal = r21
                                                                state = 6
                                                            end
                                                        end
                                                    else
                                                        if state <= 8 then
                                                            if state == 8 then
                                                                r83 = r83 + r47
                                                                ReturnVal = r83 <= r5
                                                                r27 = not r14
                                                                ReturnVal = r27 and ReturnVal
                                                                r27 = r83 >= r5
                                                                r27 = r14 and r27
                                                                ReturnVal = r27 or ReturnVal
                                                                r27 = (9)
                                                                state = ReturnVal and r27
                                                                ReturnVal = (10)
                                                                state = state or ReturnVal
                                                            end
                                                        else
                                                            if state == 9 then
                                                                r27 = allocUpvalue()
                                                                upvalueValues[r27] = r83
                                                                r43 = "math"
                                                                ReturnVal = _env[r43]
                                                                r43 = "random"
                                                                state = ReturnVal[r43]
                                                                r51 = 100
                                                                r43 = 1
                                                                ReturnVal = state(r43, r51)
                                                                r43 = allocUpvalue()
                                                                upvalueValues[r43] = ReturnVal
                                                                state = upvalueValues[r37]
                                                                r51 = 0
                                                                r40 = 255
                                                                ReturnVal = state(r51, r40)
                                                                r51 = allocUpvalue()
                                                                upvalueValues[r51] = ReturnVal
                                                                state = upvalueValues[r37]
                                                                r11 = upvalueValues[r43]
                                                                r40 = 1
                                                                ReturnVal = state(r40, r11)
                                                                r40 = allocUpvalue()
                                                                upvalueValues[r40] = ReturnVal
                                                                ReturnVal = upvalueValues[r37]
                                                                r75 = 1
                                                                r60 = 2
                                                                r11 = ReturnVal(r75, r60)
                                                                ReturnVal = 1
                                                                state = r11 == ReturnVal
                                                                r11 = allocUpvalue()
                                                                upvalueValues[r11] = state
                                                                r61 = "tostring"
                                                                r18 = _env[r61]
                                                                r50 = upvalueValues[r37]
                                                                r63 = 0
                                                                r55 = 10000
                                                                r48 = {
                                                                    r50(r63, r55)
                                                                }
                                                                r61 = r18(unpack(r48))
                                                                r18 = ":"
                                                                r23 = r61 .. r18
                                                                r60 = ":"
                                                                r75 = r60 .. r23
                                                                state = "gsub"
                                                                state = r2[state]
                                                                ReturnVal = ":(%d*):"
                                                                state = state(r2, ReturnVal, r75)
                                                                r75 = allocUpvalue()
                                                                upvalueValues[r75] = state
                                                                r23 = createClosure1(38, {
                                                                    r37,
                                                                    r27,
                                                                    r38,
                                                                    r33,
                                                                    r29,
                                                                    r54,
                                                                    r11,
                                                                    r75,
                                                                    r43,
                                                                    r40,
                                                                    r51,
                                                                    r21
                                                                })
                                                                r60 = "pcall"
                                                                ReturnVal = _env[r60]
                                                                r60 = {
                                                                    ReturnVal(r23)
                                                                }
                                                                state = {
                                                                    unpack(r60)
                                                                }
                                                                r60 = state
                                                                state = upvalueValues[r11]
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
                                                                r5 = upvalueValues[r29]
                                                                state = r5 and (13) or (14)
                                                                r83 = r5
                                                            end
                                                        else
                                                            if state == 11 then
                                                                r23 = upvalueValues[r29]
                                                                state = r23 and (15) or (16)
                                                                ReturnVal = r23
                                                            end
                                                        end
                                                    else
                                                        if state <= 12 then
                                                            if state == 12 then
                                                                r18 = upvalueValues[r29]
                                                                state = r18 and (17) or (18)
                                                                r23 = r18
                                                            end
                                                        else
                                                            if state == 13 then
                                                                r5 = r57 == r82
                                                                r83 = r5
                                                                state = 14
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 15 then
                                                        if state <= 14 then
                                                            if state == 14 then
                                                                upvalueValues[r29] = r83
                                                                state = upvalueValues[r29]
                                                                state = state and (19) or (20)
                                                            end
                                                        else
                                                            if state == 15 then
                                                                r18 = state
                                                                r48 = 1
                                                                r50 = r60[r48]
                                                                r48 = false
                                                                r61 = r50 == r48
                                                                state = r61 and (21) or (22)
                                                                r23 = r61
                                                            end
                                                        end
                                                    else
                                                        if state <= 16 then
                                                            if state == 16 then
                                                                upvalueValues[r29] = ReturnVal
                                                                state = 23
                                                            end
                                                        else
                                                            if state == 17 then
                                                                r61 = 1
                                                                r18 = r60[r61]
                                                                r23 = r18
                                                                state = 18
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 26 then
                                                if state <= 22 then
                                                    if state <= 20 then
                                                        if state <= 19 then
                                                            if state <= 18 then
                                                                if state == 18 then
                                                                    upvalueValues[r29] = r23
                                                                    r48 = upvalueValues[r40]
                                                                    r63 = 1
                                                                    r50 = r48 + r63
                                                                    r61 = r60[r50]
                                                                    r18 = r57 + r61
                                                                    r61 = 256
                                                                    state = r18 % r61
                                                                    r57 = state
                                                                    r50 = upvalueValues[r51]
                                                                    r61 = r82 + r50
                                                                    r50 = 256
                                                                    r18 = r61 % r50
                                                                    r82 = r18
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
                                                                r48 = 2
                                                                r50 = r60[r48]
                                                                r48 = upvalueValues[r75]
                                                                r61 = r50 == r48
                                                                r23 = r61
                                                                state = 22
                                                            end
                                                        else
                                                            if state == 22 then
                                                                state = r18
                                                                ReturnVal = r23
                                                                state = 16
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 24 then
                                                        if state <= 23 then
                                                            if state == 23 then
                                                                r43 = releaseUpvalue(r43)
                                                                r40 = releaseUpvalue(r40)
                                                                r27 = releaseUpvalue(r27)
                                                                r75 = releaseUpvalue(r75)
                                                                r60 = nil
                                                                r11 = releaseUpvalue(r11)
                                                                r51 = releaseUpvalue(r51)
                                                                state = 8
                                                            end
                                                        else
                                                            if state == 24 then
                                                                r54 = releaseUpvalue(r54)
                                                                r37 = releaseUpvalue(r37)
                                                                r38 = releaseUpvalue(r38)
                                                                r21 = releaseUpvalue(r21)
                                                                r70 = releaseUpvalue(r70)
                                                                r29 = releaseUpvalue(r29)
                                                                r12 = releaseUpvalue(r12)
                                                                r33 = releaseUpvalue(r33)
                                                                r82 = nil
                                                                r82 = allocUpvalue()
                                                                r12 = allocUpvalue()
                                                                r29 = nil
                                                                upvalueValues[r12] = r29
                                                                r29 = allocUpvalue()
                                                                r33 = nil
                                                                upvalueValues[r29] = r33
                                                                r85 = nil
                                                                r85 = "math"
                                                                r70 = _env[r85]
                                                                r85 = "floor"
                                                                r33 = r70[r85]
                                                                r70 = allocUpvalue()
                                                                upvalueValues[r70] = r33
                                                                r57 = nil
                                                                r57 = {}
                                                                r37 = "math"
                                                                r85 = _env[r37]
                                                                r54 = 256
                                                                r37 = "random"
                                                                r33 = r85[r37]
                                                                r14 = r54
                                                                r6 = nil
                                                                r6 = "table"
                                                                r37 = _env[r6]
                                                                r54 = 1
                                                                r6 = "remove"
                                                                r85 = r37[r6]
                                                                r27 = r54
                                                                r38 = allocUpvalue()
                                                                r21 = "string"
                                                                r6 = _env[r21]
                                                                r21 = "char"
                                                                r37 = r6[r21]
                                                                r21 = allocUpvalue()
                                                                r6 = 0
                                                                upvalueValues[r21] = r6
                                                                r54 = 0
                                                                r43 = r27 < r54
                                                                r6 = 2
                                                                upvalueValues[r38] = r6
                                                                upvalueValues[r82] = r57
                                                                r6 = {}
                                                                r45 = nil
                                                                r45 = {}
                                                                r2 = nil
                                                                r2 = 1
                                                                r54 = r2 - r27
                                                                r57 = 0
                                                                state = 26
                                                            end
                                                        end
                                                    else
                                                        if state <= 25 then
                                                            if state == 25 then
                                                                state = createClosure4(50, {
                                                                    r12
                                                                })
                                                                r5 = {
                                                                    state()
                                                                }
                                                                ReturnVal = {
                                                                    unpack(r5)
                                                                }
                                                                state = nil
                                                            end
                                                        else
                                                            if state == 26 then
                                                                r54 = r54 + r27
                                                                r51 = not r43
                                                                r2 = r54 <= r14
                                                                r2 = r51 and r2
                                                                r51 = r54 >= r14
                                                                r51 = r43 and r51
                                                                r2 = r51 or r2
                                                                r51 = (27)
                                                                state = r2 and r51
                                                                r2 = (28)
                                                                state = state or r2
                                                            end
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 30 then
                                                    if state <= 28 then
                                                        if state <= 27 then
                                                            if state == 27 then
                                                                r2 = r54
                                                                r51 = r2
                                                                r45[r2] = r51
                                                                r2 = nil
                                                                state = 26
                                                            end
                                                        else
                                                            if state == 28 then
                                                                r54 = #r45
                                                                r14 = 0
                                                                r2 = r54 == r14
                                                                state = 29
                                                            end
                                                        end
                                                    else
                                                        if state <= 29 then
                                                            if state == 29 then
                                                                r14 = #r45
                                                                r54 = 1
                                                                r2 = r33(r54, r14)
                                                                r54 = r85(r45, r2)
                                                                r51 = 1
                                                                r2 = nil
                                                                r14 = upvalueValues[r82]
                                                                r43 = r54 - r51
                                                                r27 = r37(r43)
                                                                r14[r54] = r27
                                                                r54 = nil
                                                                state = 30
                                                            end
                                                        else
                                                            if state == 30 then
                                                                r54 = #r45
                                                                r14 = 0
                                                                r2 = r54 == r14
                                                                state = r2 and (31) or (29)
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 32 then
                                                        if state <= 31 then
                                                            if state == 31 then
                                                                r2 = {}
                                                                r54 = allocUpvalue()
                                                                r27 = allocUpvalue()
                                                                upvalueValues[r54] = r2
                                                                r2 = allocUpvalue()
                                                                r14 = createClosure1(54, {
                                                                    r54,
                                                                    r21,
                                                                    r38,
                                                                    r70
                                                                })
                                                                upvalueValues[r2] = r14
                                                                r14 = {}
                                                                upvalueValues[r27] = r14
                                                                r43 = "setmetatable"
                                                                r14 = _env[r43]
                                                                r51 = {}
                                                                r75 = upvalueValues[r27]
                                                                r60 = "__metatable"
                                                                r61 = nil
                                                                r11 = "__index"
                                                                r40 = {
                                                                    [r11] = r75,
                                                                    [r60] = r61
                                                                }
                                                                r43 = r14(r51, r40)
                                                                upvalueValues[r29] = r43
                                                                r14 = createClosure7(60, {
                                                                    r27,
                                                                    r54,
                                                                    r82,
                                                                    r21,
                                                                    r38,
                                                                    r2
                                                                })
                                                                r27 = releaseUpvalue(r27)
                                                                r82 = releaseUpvalue(r82)
                                                                r2 = releaseUpvalue(r2)
                                                                r70 = releaseUpvalue(r70)
                                                                r38 = releaseUpvalue(r38)
                                                                upvalueValues[r12] = r14
                                                                r54 = releaseUpvalue(r54)
                                                                r21 = releaseUpvalue(r21)
                                                                r70 = upvalueValues[r29]
                                                                r85 = nil
                                                                r85 = upvalueValues[r12]
                                                                r6 = nil
                                                                r6 = "\029\024Te[U\139\209"
                                                                r21 = 13877751437630
                                                                r37 = nil
                                                                r37 = r85(r6, r21)
                                                                r33 = nil
                                                                r33 = r70[r37]
                                                                r70 = allocUpvalue()
                                                                upvalueValues[r70] = r33
                                                                r85 = "game"
                                                                r33 = _env[r85]
                                                                r6 = upvalueValues[r29]
                                                                r21 = upvalueValues[r12]
                                                                r57 = nil
                                                                r57 = "]\030\159)\194\162\t"
                                                                r82 = 18632655512036
                                                                r38 = r21(r57, r82)
                                                                r85 = "GetService"
                                                                r85 = r33[r85]
                                                                r37 = r6[r38]
                                                                r85 = r85(r33, r37)
                                                                r37 = "game"
                                                                r33 = _env[r37]
                                                                r21 = upvalueValues[r29]
                                                                r38 = upvalueValues[r12]
                                                                r45 = nil
                                                                r45 = 1308086272609
                                                                r82 = "\135\020y\235\233\1917\224\211\243"
                                                                r57 = r38(r82, r45)
                                                                r6 = r21[r57]
                                                                r37 = "GetService"
                                                                r37 = r33[r37]
                                                                r37 = r37(r33, r6)
                                                                r6 = "game"
                                                                r33 = _env[r6]
                                                                r38 = upvalueValues[r29]
                                                                r57 = upvalueValues[r12]
                                                                r2 = 28494378251220
                                                                r45 = "\197\144\208\tSB\152z\164\206m\160\215B\r)"
                                                                r82 = r57(r45, r2)
                                                                r21 = r38[r82]
                                                                r6 = "GetService"
                                                                r6 = r33[r6]
                                                                r6 = r6(r33, r21)
                                                                r21 = "game"
                                                                r33 = _env[r21]
                                                                r57 = upvalueValues[r29]
                                                                r82 = upvalueValues[r12]
                                                                r54 = 8613140615082
                                                                r2 = "\165\232\006\233\205\1531\169\020\214\183\173?J\187\232\004"
                                                                r45 = r82(r2, r54)
                                                                r21 = "GetService"
                                                                r21 = r33[r21]
                                                                r38 = r57[r45]
                                                                r21 = r21(r33, r38)
                                                                r33 = allocUpvalue()
                                                                upvalueValues[r33] = r21
                                                                r38 = "game"
                                                                r21 = _env[r38]
                                                                r82 = upvalueValues[r29]
                                                                r45 = upvalueValues[r12]
                                                                r14 = 14806426049262
                                                                r54 = "\205\247:\001\241,\200w\162_\175L"
                                                                r2 = r45(r54, r14)
                                                                r57 = r82[r2]
                                                                r38 = "GetService"
                                                                r38 = r21[r38]
                                                                r38 = r38(r21, r57)
                                                                r21 = allocUpvalue()
                                                                upvalueValues[r21] = r38
                                                                r57 = "game"
                                                                r38 = _env[r57]
                                                                r45 = upvalueValues[r29]
                                                                r2 = upvalueValues[r12]
                                                                r27 = 24186447178750
                                                                r14 = "d\141\146\242\231\178\150\150\143"
                                                                r54 = r2(r14, r27)
                                                                r57 = "GetService"
                                                                r57 = r38[r57]
                                                                r82 = r45[r54]
                                                                r57 = r57(r38, r82)
                                                                r38 = allocUpvalue()
                                                                upvalueValues[r38] = r57
                                                                r45 = upvalueValues[r29]
                                                                r2 = upvalueValues[r12]
                                                                r14 = "\205h\030\r\244K\233ab\rA"
                                                                r27 = 25577792401030
                                                                r54 = r2(r14, r27)
                                                                r82 = r45[r54]
                                                                r57 = r85[r82]
                                                                r82 = allocUpvalue()
                                                                upvalueValues[r82] = r57
                                                                r57 = createClosure1(67, {
                                                                    r29,
                                                                    r12
                                                                })
                                                                r54 = "Instance"
                                                                r2 = _env[r54]
                                                                r14 = upvalueValues[r29]
                                                                r27 = upvalueValues[r12]
                                                                r40 = "\024\018\008"
                                                                r11 = 19387611898692
                                                                r51 = r27(r40, r11)
                                                                r54 = r14[r51]
                                                                r45 = r2[r54]
                                                                r14 = upvalueValues[r29]
                                                                r27 = upvalueValues[r12]
                                                                r11 = 15815506992324
                                                                r40 = "\212EW\004\014l0Q\234"
                                                                r51 = r27(r40, r11)
                                                                r54 = r14[r51]
                                                                r2 = r45(r54)
                                                                r45 = allocUpvalue()
                                                                upvalueValues[r45] = r2
                                                                r2 = upvalueValues[r45]
                                                                r14 = upvalueValues[r29]
                                                                r27 = upvalueValues[r12]
                                                                r11 = 15055821740898
                                                                r40 = "\024V\241\222"
                                                                r51 = r27(r40, r11)
                                                                r54 = r14[r51]
                                                                r14 = r57()
                                                                r2[r54] = r14
                                                                r2 = upvalueValues[r45]
                                                                r14 = upvalueValues[r29]
                                                                r27 = upvalueValues[r12]
                                                                r11 = 14447169346119
                                                                r40 = "\188\237\251\140C\026/\196\205\030\030\023"
                                                                r51 = r27(r40, r11)
                                                                r54 = r14[r51]
                                                                r14 = false
                                                                r2[r54] = r14
                                                                r2 = upvalueValues[r45]
                                                                r14 = upvalueValues[r29]
                                                                r27 = upvalueValues[r12]
                                                                r40 = "\253\197\t\251\233\007"
                                                                r11 = 4191750703007
                                                                r51 = r27(r40, r11)
                                                                r54 = r14[r51]
                                                                r27 = "game"
                                                                r14 = _env[r27]
                                                                r40 = upvalueValues[r29]
                                                                r11 = upvalueValues[r12]
                                                                r60 = "1*p/^\t\140"
                                                                r61 = 29256792519991
                                                                r75 = r11(r60, r61)
                                                                r51 = r40[r75]
                                                                r27 = "GetService"
                                                                r27 = r14[r27]
                                                                r27 = r27(r14, r51)
                                                                r2[r54] = r27
                                                                r14 = "Instance"
                                                                r54 = _env[r14]
                                                                r27 = upvalueValues[r29]
                                                                r51 = upvalueValues[r12]
                                                                r75 = 34441607380646
                                                                r11 = "\133\155j"
                                                                r40 = r51(r11, r75)
                                                                r14 = r27[r40]
                                                                r2 = r54[r14]
                                                                r27 = upvalueValues[r29]
                                                                r51 = upvalueValues[r12]
                                                                r75 = 33954830859715
                                                                r11 = "\012A\172\233\200"
                                                                r40 = r51(r11, r75)
                                                                r14 = r27[r40]
                                                                r54 = r2(r14)
                                                                r14 = upvalueValues[r29]
                                                                r27 = upvalueValues[r12]
                                                                r40 = "\020\131\228\165"
                                                                r11 = 28218309653332
                                                                r51 = r27(r40, r11)
                                                                r2 = r14[r51]
                                                                r51 = "UDim2"
                                                                r27 = _env[r51]
                                                                r40 = upvalueValues[r29]
                                                                r11 = upvalueValues[r12]
                                                                r61 = 30690372089811
                                                                r60 = "~\n\184"
                                                                r75 = r11(r60, r61)
                                                                r51 = r40[r75]
                                                                r14 = r27[r51]
                                                                r51 = 0
                                                                r11 = 0
                                                                r75 = 150
                                                                r40 = 250
                                                                r27 = r14(r51, r40, r11, r75)
                                                                r54[r2] = r27
                                                                r14 = upvalueValues[r29]
                                                                r27 = upvalueValues[r12]
                                                                r11 = 16451833355756
                                                                r40 = "\245f\n\135B\133aJ"
                                                                r51 = r27(r40, r11)
                                                                r2 = r14[r51]
                                                                r51 = "UDim2"
                                                                r27 = _env[r51]
                                                                r40 = upvalueValues[r29]
                                                                r11 = upvalueValues[r12]
                                                                r60 = "k\233\161"
                                                                r61 = 18053153595606
                                                                r75 = r11(r60, r61)
                                                                r51 = r40[r75]
                                                                r75 = -75
                                                                r14 = r27[r51]
                                                                r40 = -125
                                                                r11 = 0.5
                                                                r51 = 0.5
                                                                r27 = r14(r51, r40, r11, r75)
                                                                r54[r2] = r27
                                                                r14 = upvalueValues[r29]
                                                                r27 = upvalueValues[r12]
                                                                r11 = 12739613464364
                                                                r40 = "\144\151\143=\137\242+!\236\tL\131Dj\196m"
                                                                r51 = r27(r40, r11)
                                                                r2 = r14[r51]
                                                                r51 = "Color3"
                                                                r27 = _env[r51]
                                                                r40 = upvalueValues[r29]
                                                                r11 = upvalueValues[r12]
                                                                r61 = 19478569296750
                                                                r60 = "\232?V\169\019\213\236"
                                                                r75 = r11(r60, r61)
                                                                r51 = r40[r75]
                                                                r14 = r27[r51]
                                                                r51 = 25
                                                                r11 = 30
                                                                r40 = 25
                                                                r27 = r14(r51, r40, r11)
                                                                r54[r2] = r27
                                                                r14 = upvalueValues[r29]
                                                                r27 = upvalueValues[r12]
                                                                r40 = "-\138\014\231\2436\148\216\199(>  \rp"
                                                                r11 = 25305815379463
                                                                r51 = r27(r40, r11)
                                                                r2 = r14[r51]
                                                                r14 = 0
                                                                r54[r2] = r14
                                                                r14 = upvalueValues[r29]
                                                                r27 = upvalueValues[r12]
                                                                r11 = 11357520991400
                                                                r40 = "\152\156bh\011\221"
                                                                r51 = r27(r40, r11)
                                                                r2 = r14[r51]
                                                                r14 = upvalueValues[r45]
                                                                r54[r2] = r14
                                                                r27 = "Instance"
                                                                r14 = _env[r27]
                                                                r51 = upvalueValues[r29]
                                                                r40 = upvalueValues[r12]
                                                                r75 = "\2276\162"
                                                                r60 = 17185769512770
                                                                r11 = r40(r75, r60)
                                                                r27 = r51[r11]
                                                                r2 = r14[r27]
                                                                r51 = upvalueValues[r29]
                                                                r40 = upvalueValues[r12]
                                                                r75 = "wn\243\193g\130\205\221"
                                                                r60 = 19906765661237
                                                                r11 = r40(r75, r60)
                                                                r27 = r51[r11]
                                                                r14 = r2(r27)
                                                                r27 = upvalueValues[r29]
                                                                r51 = upvalueValues[r12]
                                                                r11 = "\183t\170\223ybE\129\207\190gy"
                                                                r75 = 30077359404725
                                                                r40 = r51(r11, r75)
                                                                r2 = r27[r40]
                                                                r40 = "UDim"
                                                                r51 = _env[r40]
                                                                r11 = upvalueValues[r29]
                                                                r75 = upvalueValues[r12]
                                                                r61 = "\150\170`"
                                                                r50 = 31063520950401
                                                                r60 = r75(r61, r50)
                                                                r40 = r11[r60]
                                                                r27 = r51[r40]
                                                                r11 = 10
                                                                r40 = 0
                                                                r51 = r27(r40, r11)
                                                                r14[r2] = r51
                                                                r27 = upvalueValues[r29]
                                                                r51 = upvalueValues[r12]
                                                                r75 = 3355049068058
                                                                r11 = "\212?&\180\151\238"
                                                                r40 = r51(r11, r75)
                                                                r2 = r27[r40]
                                                                r27 = r54
                                                                r14[r2] = r27
                                                                r51 = "Instance"
                                                                r27 = _env[r51]
                                                                r40 = upvalueValues[r29]
                                                                r11 = upvalueValues[r12]
                                                                r60 = "\219\139\142"
                                                                r61 = 31385445677334
                                                                r75 = r11(r60, r61)
                                                                r51 = r40[r75]
                                                                r2 = r27[r51]
                                                                r40 = upvalueValues[r29]
                                                                r11 = upvalueValues[r12]
                                                                r61 = 24373527096405
                                                                r60 = "\179\222\191yc6\167V\174"
                                                                r75 = r11(r60, r61)
                                                                r51 = r40[r75]
                                                                r27 = r2(r51)
                                                                r51 = upvalueValues[r29]
                                                                r40 = upvalueValues[r12]
                                                                r75 = "\209y\225\169"
                                                                r60 = 11968189683141
                                                                r11 = r40(r75, r60)
                                                                r2 = r51[r11]
                                                                r11 = "UDim2"
                                                                r40 = _env[r11]
                                                                r75 = upvalueValues[r29]
                                                                r60 = upvalueValues[r12]
                                                                r48 = 11007499621381
                                                                r50 = "=Y\227"
                                                                r61 = r60(r50, r48)
                                                                r11 = r75[r61]
                                                                r51 = r40[r11]
                                                                r60 = 0
                                                                r75 = 0
                                                                r11 = 1
                                                                r61 = 30
                                                                r40 = r51(r11, r75, r60, r61)
                                                                r27[r2] = r40
                                                                r51 = upvalueValues[r29]
                                                                r40 = upvalueValues[r12]
                                                                r75 = "\197\160\246\162\251\022\\y\217\163\210\182M\185;\130"
                                                                r60 = 13375602169940
                                                                r11 = r40(r75, r60)
                                                                r2 = r51[r11]
                                                                r11 = "Color3"
                                                                r40 = _env[r11]
                                                                r75 = upvalueValues[r29]
                                                                r60 = upvalueValues[r12]
                                                                r48 = 2361609995339
                                                                r50 = "A\199\184.c/\175"
                                                                r61 = r60(r50, r48)
                                                                r11 = r75[r61]
                                                                r51 = r40[r11]
                                                                r60 = 35
                                                                r11 = 30
                                                                r75 = 30
                                                                r40 = r51(r11, r75, r60)
                                                                r27[r2] = r40
                                                                r51 = upvalueValues[r29]
                                                                r40 = upvalueValues[r12]
                                                                r75 = "\209;\201\028"
                                                                r60 = 9599283532150
                                                                r11 = r40(r75, r60)
                                                                r2 = r51[r11]
                                                                r40 = upvalueValues[r29]
                                                                r11 = upvalueValues[r12]
                                                                r61 = 8328830209830
                                                                r60 = "Q\154\145\184\200\155\011\005\030;|\004\226Y\184^\2046"
                                                                r75 = r11(r60, r61)
                                                                r51 = r40[r75]
                                                                r27[r2] = r51
                                                                r51 = upvalueValues[r29]
                                                                r40 = upvalueValues[r12]
                                                                r60 = 18616194884060
                                                                r75 = "`'\244\r\134\229^H\192g"
                                                                r11 = r40(r75, r60)
                                                                r2 = r51[r11]
                                                                r11 = "Color3"
                                                                r40 = _env[r11]
                                                                r75 = upvalueValues[r29]
                                                                r60 = upvalueValues[r12]
                                                                r50 = "\237\231isr\238:"
                                                                r48 = 29375784875375
                                                                r61 = r60(r50, r48)
                                                                r11 = r75[r61]
                                                                r51 = r40[r11]
                                                                r75 = 255
                                                                r60 = 255
                                                                r11 = 255
                                                                r40 = r51(r11, r75, r60)
                                                                r27[r2] = r40
                                                                r51 = upvalueValues[r29]
                                                                r40 = upvalueValues[r12]
                                                                r75 = "yas\193 Z\155$"
                                                                r60 = 27716442108522
                                                                r11 = r40(r75, r60)
                                                                r2 = r51[r11]
                                                                r51 = 16
                                                                r27[r2] = r51
                                                                r51 = upvalueValues[r29]
                                                                r40 = upvalueValues[r12]
                                                                r60 = 34431701876385
                                                                r75 = "\028\244\000="
                                                                r11 = r40(r75, r60)
                                                                r2 = r51[r11]
                                                                r75 = "Enum"
                                                                r11 = _env[r75]
                                                                r60 = upvalueValues[r29]
                                                                r61 = upvalueValues[r12]
                                                                r63 = 9247234511058
                                                                r48 = "\004\237\018\255"
                                                                r50 = r61(r48, r63)
                                                                r75 = r60[r50]
                                                                r40 = r11[r75]
                                                                r75 = upvalueValues[r29]
                                                                r60 = upvalueValues[r12]
                                                                r48 = 6979239349425
                                                                r50 = "vE\018I,\001\194\234\1557"
                                                                r61 = r60(r50, r48)
                                                                r11 = r75[r61]
                                                                r51 = r40[r11]
                                                                r27[r2] = r51
                                                                r51 = upvalueValues[r29]
                                                                r40 = upvalueValues[r12]
                                                                r75 = "\214A\197\134\222\136"
                                                                r60 = 3439080474177
                                                                r11 = r40(r75, r60)
                                                                r2 = r51[r11]
                                                                r51 = r54
                                                                r27[r2] = r51
                                                                r40 = "Instance"
                                                                r51 = _env[r40]
                                                                r11 = upvalueValues[r29]
                                                                r75 = upvalueValues[r12]
                                                                r50 = 3319654925833
                                                                r61 = "\r\129\196"
                                                                r60 = r75(r61, r50)
                                                                r40 = r11[r60]
                                                                r2 = r51[r40]
                                                                r11 = upvalueValues[r29]
                                                                r75 = upvalueValues[r12]
                                                                r61 = "\156zUD\246\025N{"
                                                                r50 = 6236474624856
                                                                r60 = r75(r61, r50)
                                                                r40 = r11[r60]
                                                                r51 = r2(r40)
                                                                r40 = upvalueValues[r29]
                                                                r11 = upvalueValues[r12]
                                                                r60 = "\187eL\149\236\135\178~M\007\168g"
                                                                r61 = 2209539245060
                                                                r75 = r11(r60, r61)
                                                                r2 = r40[r75]
                                                                r75 = "UDim"
                                                                r11 = _env[r75]
                                                                r60 = upvalueValues[r29]
                                                                r61 = upvalueValues[r12]
                                                                r63 = 31537964579166
                                                                r48 = "\172\209\243"
                                                                r50 = r61(r48, r63)
                                                                r75 = r60[r50]
                                                                r40 = r11[r75]
                                                                r75 = 0
                                                                r60 = 10
                                                                r11 = r40(r75, r60)
                                                                r51[r2] = r11
                                                                r40 = upvalueValues[r29]
                                                                r11 = upvalueValues[r12]
                                                                r60 = "\226\154\242F\"v"
                                                                r61 = 1742474625835
                                                                r75 = r11(r60, r61)
                                                                r2 = r40[r75]
                                                                r40 = r27
                                                                r51[r2] = r40
                                                                r11 = "Instance"
                                                                r40 = _env[r11]
                                                                r75 = upvalueValues[r29]
                                                                r60 = upvalueValues[r12]
                                                                r50 = "P\251\189"
                                                                r48 = 18661372600817
                                                                r61 = r60(r50, r48)
                                                                r11 = r75[r61]
                                                                r2 = r40[r11]
                                                                r75 = upvalueValues[r29]
                                                                r60 = upvalueValues[r12]
                                                                r50 = "3\232\203y&\177\151"
                                                                r48 = 14406746069556
                                                                r61 = r60(r50, r48)
                                                                r11 = r75[r61]
                                                                r40 = r2(r11)
                                                                r2 = allocUpvalue()
                                                                upvalueValues[r2] = r40
                                                                r40 = upvalueValues[r2]
                                                                r75 = upvalueValues[r29]
                                                                r60 = upvalueValues[r12]
                                                                r48 = 14482088090199
                                                                r50 = "sv\193\164"
                                                                r61 = r60(r50, r48)
                                                                r11 = r75[r61]
                                                                r61 = "UDim2"
                                                                r60 = _env[r61]
                                                                r50 = upvalueValues[r29]
                                                                r48 = upvalueValues[r12]
                                                                r30 = 2955569792352
                                                                r55 = "\012G\002"
                                                                r63 = r48(r55, r30)
                                                                r61 = r50[r63]
                                                                r75 = r60[r61]
                                                                r48 = 0
                                                                r50 = 200
                                                                r61 = 0
                                                                r63 = 30
                                                                r60 = r75(r61, r50, r48, r63)
                                                                r40[r11] = r60
                                                                r40 = upvalueValues[r2]
                                                                r75 = upvalueValues[r29]
                                                                r60 = upvalueValues[r12]
                                                                r50 = "\158\175\170\000WK\161\232"
                                                                r48 = 4528189360188
                                                                r61 = r60(r50, r48)
                                                                r11 = r75[r61]
                                                                r61 = "UDim2"
                                                                r60 = _env[r61]
                                                                r50 = upvalueValues[r29]
                                                                r48 = upvalueValues[r12]
                                                                r30 = 25839609081600
                                                                r55 = "Yqk"
                                                                r63 = r48(r55, r30)
                                                                r61 = r50[r63]
                                                                r50 = -100
                                                                r75 = r60[r61]
                                                                r48 = 0
                                                                r63 = 40
                                                                r61 = 0.5
                                                                r60 = r75(r61, r50, r48, r63)
                                                                r40[r11] = r60
                                                                r40 = upvalueValues[r2]
                                                                r75 = upvalueValues[r29]
                                                                r60 = upvalueValues[r12]
                                                                r48 = 20141339305123
                                                                r50 = "&\202\188\237g=\192\020%U\18525\179\215\155"
                                                                r61 = r60(r50, r48)
                                                                r11 = r75[r61]
                                                                r61 = "Color3"
                                                                r60 = _env[r61]
                                                                r50 = upvalueValues[r29]
                                                                r48 = upvalueValues[r12]
                                                                r30 = 24434955021426
                                                                r55 = "\015\023_=!\031P"
                                                                r63 = r48(r55, r30)
                                                                r61 = r50[r63]
                                                                r75 = r60[r61]
                                                                r50 = 45
                                                                r61 = 45
                                                                r48 = 50
                                                                r60 = r75(r61, r50, r48)
                                                                r40[r11] = r60
                                                                r40 = upvalueValues[r2]
                                                                r75 = upvalueValues[r29]
                                                                r60 = upvalueValues[r12]
                                                                r50 = "\251m\166.\017\232\216*\128}iK_U\205"
                                                                r48 = 20732596381110
                                                                r61 = r60(r50, r48)
                                                                r11 = r75[r61]
                                                                r60 = upvalueValues[r29]
                                                                r61 = upvalueValues[r12]
                                                                r48 = "b\238\014\030\r>\188\202\237"
                                                                r63 = 16020488166692
                                                                r50 = r61(r48, r63)
                                                                r75 = r60[r50]
                                                                r40[r11] = r75
                                                                r40 = upvalueValues[r2]
                                                                r75 = upvalueValues[r29]
                                                                r60 = upvalueValues[r12]
                                                                r50 = "v\163\212H"
                                                                r48 = 27790004105868
                                                                r61 = r60(r50, r48)
                                                                r11 = r75[r61]
                                                                r60 = upvalueValues[r29]
                                                                r61 = upvalueValues[r12]
                                                                r63 = 16933669953229
                                                                r48 = ""
                                                                r50 = r61(r48, r63)
                                                                r75 = r60[r50]
                                                                r40[r11] = r75
                                                                r40 = upvalueValues[r2]
                                                                r75 = upvalueValues[r29]
                                                                r60 = upvalueValues[r12]
                                                                r48 = 5209643157881
                                                                r50 = "\199\151\244?$h\222B$a"
                                                                r61 = r60(r50, r48)
                                                                r11 = r75[r61]
                                                                r61 = "Color3"
                                                                r60 = _env[r61]
                                                                r50 = upvalueValues[r29]
                                                                r48 = upvalueValues[r12]
                                                                r30 = 4573821683793
                                                                r55 = "(\2039Ves\172"
                                                                r63 = r48(r55, r30)
                                                                r61 = r50[r63]
                                                                r75 = r60[r61]
                                                                r48 = 220
                                                                r61 = 200
                                                                r50 = 200
                                                                r60 = r75(r61, r50, r48)
                                                                r40[r11] = r60
                                                                r40 = upvalueValues[r2]
                                                                r75 = upvalueValues[r29]
                                                                r60 = upvalueValues[r12]
                                                                r50 = "W\t\132\144d/\015\004"
                                                                r48 = 27941169590995
                                                                r61 = r60(r50, r48)
                                                                r11 = r75[r61]
                                                                r75 = 14
                                                                r40[r11] = r75
                                                                r40 = upvalueValues[r2]
                                                                r75 = upvalueValues[r29]
                                                                r60 = upvalueValues[r12]
                                                                r50 = "\158l\244\248"
                                                                r48 = 18585245344206
                                                                r61 = r60(r50, r48)
                                                                r11 = r75[r61]
                                                                r50 = "Enum"
                                                                r61 = _env[r50]
                                                                r48 = upvalueValues[r29]
                                                                r63 = upvalueValues[r12]
                                                                r26 = 6935431679133
                                                                r30 = ":\173\182\198"
                                                                r55 = r63(r30, r26)
                                                                r50 = r48[r55]
                                                                r60 = r61[r50]
                                                                r50 = upvalueValues[r29]
                                                                r48 = upvalueValues[r12]
                                                                r55 = "\004X\239\229q\217"
                                                                r30 = 2356081017929
                                                                r63 = r48(r55, r30)
                                                                r61 = r50[r63]
                                                                r75 = r60[r61]
                                                                r40[r11] = r75
                                                                r40 = upvalueValues[r2]
                                                                r75 = upvalueValues[r29]
                                                                r60 = upvalueValues[r12]
                                                                r50 = "\000\209\219\190\179~"
                                                                r48 = 26914075554036
                                                                r61 = r60(r50, r48)
                                                                r11 = r75[r61]
                                                                r75 = r54
                                                                r40[r11] = r75
                                                                r75 = "Instance"
                                                                r11 = _env[r75]
                                                                r60 = upvalueValues[r29]
                                                                r61 = upvalueValues[r12]
                                                                r63 = 25551626563194
                                                                r48 = "\133\165c"
                                                                r50 = r61(r48, r63)
                                                                r75 = r60[r50]
                                                                r40 = r11[r75]
                                                                r60 = upvalueValues[r29]
                                                                r61 = upvalueValues[r12]
                                                                r63 = 31731865893304
                                                                r48 = "\174x\000EOt\189\017"
                                                                r50 = r61(r48, r63)
                                                                r75 = r60[r50]
                                                                r11 = r40(r75)
                                                                r75 = upvalueValues[r29]
                                                                r60 = upvalueValues[r12]
                                                                r48 = 19446145557343
                                                                r50 = "\135\139\030\249%@\247\238c\134\246\169"
                                                                r61 = r60(r50, r48)
                                                                r40 = r75[r61]
                                                                r61 = "UDim"
                                                                r60 = _env[r61]
                                                                r50 = upvalueValues[r29]
                                                                r48 = upvalueValues[r12]
                                                                r30 = 24798956334363
                                                                r55 = "\222\187y"
                                                                r63 = r48(r55, r30)
                                                                r61 = r50[r63]
                                                                r75 = r60[r61]
                                                                r61 = 0
                                                                r50 = 10
                                                                r60 = r75(r61, r50)
                                                                r11[r40] = r60
                                                                r75 = upvalueValues[r29]
                                                                r60 = upvalueValues[r12]
                                                                r50 = "\246\004\232j\180\154"
                                                                r48 = 5794728299146
                                                                r61 = r60(r50, r48)
                                                                r40 = r75[r61]
                                                                r75 = upvalueValues[r2]
                                                                r11[r40] = r75
                                                                r60 = "Instance"
                                                                r75 = _env[r60]
                                                                r61 = upvalueValues[r29]
                                                                r50 = upvalueValues[r12]
                                                                r63 = "\150\025<"
                                                                r55 = 26425384906769
                                                                r48 = r50(r63, r55)
                                                                r60 = r61[r48]
                                                                r40 = r75[r60]
                                                                r61 = upvalueValues[r29]
                                                                r50 = upvalueValues[r12]
                                                                r63 = "\023\004\031\195\004\160\011\226\147}"
                                                                r55 = 28238036824925
                                                                r48 = r50(r63, r55)
                                                                r60 = r61[r48]
                                                                r75 = r40(r60)
                                                                r60 = upvalueValues[r29]
                                                                r61 = upvalueValues[r12]
                                                                r48 = "'\016kO"
                                                                r63 = 9114383224980
                                                                r50 = r61(r48, r63)
                                                                r40 = r60[r50]
                                                                r50 = "UDim2"
                                                                r61 = _env[r50]
                                                                r48 = upvalueValues[r29]
                                                                r63 = upvalueValues[r12]
                                                                r26 = 32661859531625
                                                                r30 = "\\v\002"
                                                                r55 = r63(r30, r26)
                                                                r50 = r48[r55]
                                                                r60 = r61[r50]
                                                                r63 = 0
                                                                r48 = 90
                                                                r55 = 35
                                                                r50 = 0
                                                                r61 = r60(r50, r48, r63, r55)
                                                                r75[r40] = r61
                                                                r60 = upvalueValues[r29]
                                                                r61 = upvalueValues[r12]
                                                                r63 = 30447576069986
                                                                r48 = "C(\206\003/^\187v"
                                                                r50 = r61(r48, r63)
                                                                r40 = r60[r50]
                                                                r50 = "UDim2"
                                                                r61 = _env[r50]
                                                                r48 = upvalueValues[r29]
                                                                r63 = upvalueValues[r12]
                                                                r30 = "\025\148'"
                                                                r26 = 5467975715314
                                                                r55 = r63(r30, r26)
                                                                r50 = r48[r55]
                                                                r60 = r61[r50]
                                                                r55 = 100
                                                                r63 = 0
                                                                r48 = 20
                                                                r50 = 0
                                                                r61 = r60(r50, r48, r63, r55)
                                                                r75[r40] = r61
                                                                r60 = upvalueValues[r29]
                                                                r61 = upvalueValues[r12]
                                                                r63 = 34404334157460
                                                                r48 = "\007\146V\251\236\148N\127\176\014\211\201^\134L@"
                                                                r50 = r61(r48, r63)
                                                                r40 = r60[r50]
                                                                r50 = "Color3"
                                                                r61 = _env[r50]
                                                                r48 = upvalueValues[r29]
                                                                r63 = upvalueValues[r12]
                                                                r26 = 13924576565588
                                                                r30 = "\158h\154K+9\134"
                                                                r55 = r63(r30, r26)
                                                                r50 = r48[r55]
                                                                r60 = r61[r50]
                                                                r63 = 50
                                                                r48 = 50
                                                                r50 = 140
                                                                r61 = r60(r50, r48, r63)
                                                                r75[r40] = r61
                                                                r60 = upvalueValues[r29]
                                                                r61 = upvalueValues[r12]
                                                                r48 = "t\021K\006"
                                                                r63 = 19874721784870
                                                                r50 = r61(r48, r63)
                                                                r40 = r60[r50]
                                                                r61 = upvalueValues[r29]
                                                                r50 = upvalueValues[r12]
                                                                r55 = 13702050142444
                                                                r63 = "@\007\140\008Z\177\191G"
                                                                r48 = r50(r63, r55)
                                                                r60 = r61[r48]
                                                                r75[r40] = r60
                                                                r60 = upvalueValues[r29]
                                                                r61 = upvalueValues[r12]
                                                                r48 = "k[K\234\229|\217h,\008"
                                                                r63 = 16880146374324
                                                                r50 = r61(r48, r63)
                                                                r40 = r60[r50]
                                                                r50 = "Color3"
                                                                r61 = _env[r50]
                                                                r48 = upvalueValues[r29]
                                                                r63 = upvalueValues[r12]
                                                                r30 = "\199\001\212\160\163\213\250"
                                                                r26 = 24402911145059
                                                                r55 = r63(r30, r26)
                                                                r50 = r48[r55]
                                                                r60 = r61[r50]
                                                                r63 = 220
                                                                r48 = 220
                                                                r50 = 255
                                                                r61 = r60(r50, r48, r63)
                                                                r75[r40] = r61
                                                                r60 = upvalueValues[r29]
                                                                r61 = upvalueValues[r12]
                                                                r48 = "\162\225\004\246\185\250\176_"
                                                                r63 = 4357287135213
                                                                r50 = r61(r48, r63)
                                                                r40 = r60[r50]
                                                                r60 = 14
                                                                r75[r40] = r60
                                                                r60 = upvalueValues[r29]
                                                                r61 = upvalueValues[r12]
                                                                r63 = 1837113574231
                                                                r48 = "\153\193-\191"
                                                                r50 = r61(r48, r63)
                                                                r40 = r60[r50]
                                                                r48 = "Enum"
                                                                r50 = _env[r48]
                                                                r63 = upvalueValues[r29]
                                                                r55 = upvalueValues[r12]
                                                                r8 = 13653494077653
                                                                r26 = "+r\221\241"
                                                                r30 = r55(r26, r8)
                                                                r48 = r63[r30]
                                                                r61 = r50[r48]
                                                                r48 = upvalueValues[r29]
                                                                r63 = upvalueValues[r12]
                                                                r26 = 25089883516323
                                                                r30 = "\141\236\167\145Y\005v\030\251\""
                                                                r55 = r63(r30, r26)
                                                                r50 = r48[r55]
                                                                r60 = r61[r50]
                                                                r75[r40] = r60
                                                                r60 = upvalueValues[r29]
                                                                r61 = upvalueValues[r12]
                                                                r63 = 17857601740923
                                                                r48 = "B\214\228[\238m"
                                                                r50 = r61(r48, r63)
                                                                r40 = r60[r50]
                                                                r60 = r54
                                                                r75[r40] = r60
                                                                r61 = "Instance"
                                                                r60 = _env[r61]
                                                                r50 = upvalueValues[r29]
                                                                r48 = upvalueValues[r12]
                                                                r30 = 6259126078306
                                                                r55 = "\184\207\249"
                                                                r63 = r48(r55, r30)
                                                                r61 = r50[r63]
                                                                r40 = r60[r61]
                                                                r50 = upvalueValues[r29]
                                                                r48 = upvalueValues[r12]
                                                                r55 = "z\127\134\005\190\254Zf"
                                                                r30 = 6839181380720
                                                                r63 = r48(r55, r30)
                                                                r61 = r50[r63]
                                                                r60 = r40(r61)
                                                                r61 = upvalueValues[r29]
                                                                r50 = upvalueValues[r12]
                                                                r55 = 23067244915189
                                                                r63 = "2m1\141H\225\224\223\227\023)H"
                                                                r48 = r50(r63, r55)
                                                                r40 = r61[r48]
                                                                r48 = "UDim"
                                                                r50 = _env[r48]
                                                                r63 = upvalueValues[r29]
                                                                r55 = upvalueValues[r12]
                                                                r8 = 10832947762100
                                                                r26 = "~\178A"
                                                                r30 = r55(r26, r8)
                                                                r48 = r63[r30]
                                                                r61 = r50[r48]
                                                                r63 = 10
                                                                r48 = 0
                                                                r50 = r61(r48, r63)
                                                                r60[r40] = r50
                                                                r61 = upvalueValues[r29]
                                                                r50 = upvalueValues[r12]
                                                                r55 = 34780350971715
                                                                r63 = "\196\209t,2\202"
                                                                r48 = r50(r63, r55)
                                                                r40 = r61[r48]
                                                                r61 = r75
                                                                r60[r40] = r61
                                                                r50 = "Instance"
                                                                r61 = _env[r50]
                                                                r48 = upvalueValues[r29]
                                                                r63 = upvalueValues[r12]
                                                                r30 = "z\162\150"
                                                                r26 = 6468118154179
                                                                r55 = r63(r30, r26)
                                                                r50 = r48[r55]
                                                                r40 = r61[r50]
                                                                r48 = upvalueValues[r29]
                                                                r63 = upvalueValues[r12]
                                                                r26 = 17768379457618
                                                                r30 = "\252\237\225\144!^\178\132\023\139"
                                                                r55 = r63(r30, r26)
                                                                r50 = r48[r55]
                                                                r61 = r40(r50)
                                                                r50 = upvalueValues[r29]
                                                                r48 = upvalueValues[r12]
                                                                r30 = 1952059884428
                                                                r55 = "\197>\151\176"
                                                                r63 = r48(r55, r30)
                                                                r40 = r50[r63]
                                                                r63 = "UDim2"
                                                                r48 = _env[r63]
                                                                r55 = upvalueValues[r29]
                                                                r30 = upvalueValues[r12]
                                                                r41 = 33382193708216
                                                                r8 = "\228/P"
                                                                r26 = r30(r8, r41)
                                                                r63 = r55[r26]
                                                                r50 = r48[r63]
                                                                r26 = 35
                                                                r63 = 0
                                                                r55 = 90
                                                                r30 = 0
                                                                r48 = r50(r63, r55, r30, r26)
                                                                r61[r40] = r48
                                                                r50 = upvalueValues[r29]
                                                                r48 = upvalueValues[r12]
                                                                r55 = "\184\235F\030H\194\240\021"
                                                                r30 = 8135633915596
                                                                r63 = r48(r55, r30)
                                                                r40 = r50[r63]
                                                                r63 = "UDim2"
                                                                r48 = _env[r63]
                                                                r55 = upvalueValues[r29]
                                                                r30 = upvalueValues[r12]
                                                                r41 = 33683925794117
                                                                r8 = "r#F"
                                                                r26 = r30(r8, r41)
                                                                r63 = r55[r26]
                                                                r50 = r48[r63]
                                                                r55 = -110
                                                                r30 = 0
                                                                r63 = 1
                                                                r26 = 100
                                                                r48 = r50(r63, r55, r30, r26)
                                                                r61[r40] = r48
                                                                r50 = upvalueValues[r29]
                                                                r48 = upvalueValues[r12]
                                                                r30 = 17643967160344
                                                                r55 = "\164U\0294u\030\166\219\213O\158\212u\016\167)"
                                                                r63 = r48(r55, r30)
                                                                r40 = r50[r63]
                                                                r63 = "Color3"
                                                                r48 = _env[r63]
                                                                r55 = upvalueValues[r29]
                                                                r30 = upvalueValues[r12]
                                                                r41 = 32934590266344
                                                                r8 = "\205\155\030\177v49"
                                                                r26 = r30(r8, r41)
                                                                r63 = r55[r26]
                                                                r50 = r48[r63]
                                                                r55 = 130
                                                                r30 = 70
                                                                r63 = 70
                                                                r48 = r50(r63, r55, r30)
                                                                r61[r40] = r48
                                                                r50 = upvalueValues[r29]
                                                                r48 = upvalueValues[r12]
                                                                r30 = 4294281988047
                                                                r55 = "MST\173"
                                                                r63 = r48(r55, r30)
                                                                r40 = r50[r63]
                                                                r48 = upvalueValues[r29]
                                                                r63 = upvalueValues[r12]
                                                                r30 = "\014\134B\146\003\151"
                                                                r26 = 8884979961897
                                                                r55 = r63(r30, r26)
                                                                r50 = r48[r55]
                                                                r61[r40] = r50
                                                                r50 = upvalueValues[r29]
                                                                r48 = upvalueValues[r12]
                                                                r30 = 25988254986053
                                                                r55 = "\135ND[\231\023DB\210\\"
                                                                r63 = r48(r55, r30)
                                                                r40 = r50[r63]
                                                                r63 = "Color3"
                                                                r48 = _env[r63]
                                                                r55 = upvalueValues[r29]
                                                                r30 = upvalueValues[r12]
                                                                r8 = "\163&\241\026,\"w"
                                                                r41 = 13408665229411
                                                                r26 = r30(r8, r41)
                                                                r63 = r55[r26]
                                                                r50 = r48[r63]
                                                                r30 = 220
                                                                r63 = 220
                                                                r55 = 255
                                                                r48 = r50(r63, r55, r30)
                                                                r61[r40] = r48
                                                                r50 = upvalueValues[r29]
                                                                r48 = upvalueValues[r12]
                                                                r30 = 6362467388306
                                                                r55 = ":l\240\187Ru@\135"
                                                                r63 = r48(r55, r30)
                                                                r40 = r50[r63]
                                                                r50 = 14
                                                                r61[r40] = r50
                                                                r50 = upvalueValues[r29]
                                                                r48 = upvalueValues[r12]
                                                                r55 = "o\019\170/"
                                                                r30 = 21251458950823
                                                                r63 = r48(r55, r30)
                                                                r40 = r50[r63]
                                                                r55 = "Enum"
                                                                r63 = _env[r55]
                                                                r30 = upvalueValues[r29]
                                                                r26 = upvalueValues[r12]
                                                                r65 = 18876640944726
                                                                r41 = "u\247\001H"
                                                                r8 = r26(r41, r65)
                                                                r55 = r30[r8]
                                                                r48 = r63[r55]
                                                                r55 = upvalueValues[r29]
                                                                r30 = upvalueValues[r12]
                                                                r8 = "\187v\251\028\188a**\152\191"
                                                                r41 = 5582429456935
                                                                r26 = r30(r8, r41)
                                                                r63 = r55[r26]
                                                                r50 = r48[r63]
                                                                r61[r40] = r50
                                                                r50 = upvalueValues[r29]
                                                                r48 = upvalueValues[r12]
                                                                r55 = "\237\246\134bf\162"
                                                                r30 = 35176035516412
                                                                r63 = r48(r55, r30)
                                                                r40 = r50[r63]
                                                                r50 = r54
                                                                r61[r40] = r50
                                                                r48 = "Instance"
                                                                r50 = _env[r48]
                                                                r63 = upvalueValues[r29]
                                                                r55 = upvalueValues[r12]
                                                                r26 = "T\172A"
                                                                r8 = 3566990624381
                                                                r30 = r55(r26, r8)
                                                                r48 = r63[r30]
                                                                r40 = r50[r48]
                                                                r63 = upvalueValues[r29]
                                                                r55 = upvalueValues[r12]
                                                                r8 = 19284479599380
                                                                r26 = "5\154c\132yU\239\242"
                                                                r30 = r55(r26, r8)
                                                                r48 = r63[r30]
                                                                r50 = r40(r48)
                                                                r48 = upvalueValues[r29]
                                                                r63 = upvalueValues[r12]
                                                                r26 = 16871809785520
                                                                r30 = "r\026/S\164_\194p\232\240|\134"
                                                                r55 = r63(r30, r26)
                                                                r40 = r48[r55]
                                                                r55 = "UDim"
                                                                r63 = _env[r55]
                                                                r30 = upvalueValues[r29]
                                                                r26 = upvalueValues[r12]
                                                                r65 = 27969901785824
                                                                r41 = "\2444\214"
                                                                r8 = r26(r41, r65)
                                                                r55 = r30[r8]
                                                                r48 = r63[r55]
                                                                r55 = 0
                                                                r30 = 10
                                                                r63 = r48(r55, r30)
                                                                r50[r40] = r63
                                                                r48 = upvalueValues[r29]
                                                                r63 = upvalueValues[r12]
                                                                r26 = 23641766734593
                                                                r30 = "\176\212\007\213\234\224"
                                                                r55 = r63(r30, r26)
                                                                r40 = r48[r55]
                                                                r48 = r61
                                                                r50[r40] = r48
                                                                r63 = "Instance"
                                                                r48 = _env[r63]
                                                                r55 = upvalueValues[r29]
                                                                r30 = upvalueValues[r12]
                                                                r8 = "\011\222J"
                                                                r41 = 18708923376136
                                                                r26 = r30(r8, r41)
                                                                r63 = r55[r26]
                                                                r40 = r48[r63]
                                                                r55 = upvalueValues[r29]
                                                                r30 = upvalueValues[r12]
                                                                r8 = "\224R0*\219Zq\001\007"
                                                                r41 = 6439023758262
                                                                r26 = r30(r8, r41)
                                                                r63 = r55[r26]
                                                                r48 = r40(r63)
                                                                r40 = allocUpvalue()
                                                                upvalueValues[r40] = r48
                                                                r48 = upvalueValues[r40]
                                                                r55 = upvalueValues[r29]
                                                                r30 = upvalueValues[r12]
                                                                r8 = "\224\158S@"
                                                                r41 = 13547278162084
                                                                r26 = r30(r8, r41)
                                                                r63 = r55[r26]
                                                                r55 = r57()
                                                                r48[r63] = r55
                                                                r48 = upvalueValues[r40]
                                                                r55 = upvalueValues[r29]
                                                                r30 = upvalueValues[r12]
                                                                r8 = "\131\233Nv%\192x\200%\187\025\136"
                                                                r41 = 1382153011843
                                                                r26 = r30(r8, r41)
                                                                r63 = r55[r26]
                                                                r55 = false
                                                                r48[r63] = r55
                                                                r48 = upvalueValues[r40]
                                                                r55 = upvalueValues[r29]
                                                                r30 = upvalueValues[r12]
                                                                r41 = 12698149836569
                                                                r8 = "\011\161du\tg\202"
                                                                r26 = r30(r8, r41)
                                                                r63 = r55[r26]
                                                                r55 = false
                                                                r48[r63] = r55
                                                                r48 = upvalueValues[r40]
                                                                r55 = upvalueValues[r29]
                                                                r30 = upvalueValues[r12]
                                                                r41 = 20386459542805
                                                                r8 = "\133\242\154\188\237\132"
                                                                r26 = r30(r8, r41)
                                                                r63 = r55[r26]
                                                                r30 = "game"
                                                                r55 = _env[r30]
                                                                r8 = upvalueValues[r29]
                                                                r41 = upvalueValues[r12]
                                                                r42 = 24449397927033
                                                                r1 = "8\030\169.e\242\011"
                                                                r65 = r41(r1, r42)
                                                                r30 = "GetService"
                                                                r30 = r55[r30]
                                                                r26 = r8[r65]
                                                                r30 = r30(r55, r26)
                                                                r48[r63] = r30
                                                                r55 = "Instance"
                                                                r63 = _env[r55]
                                                                r30 = upvalueValues[r29]
                                                                r26 = upvalueValues[r12]
                                                                r41 = "l\180\011"
                                                                r65 = 23531097598669
                                                                r8 = r26(r41, r65)
                                                                r55 = r30[r8]
                                                                r48 = r63[r55]
                                                                r30 = upvalueValues[r29]
                                                                r26 = upvalueValues[r12]
                                                                r65 = 19982438409305
                                                                r41 = "}\173\137k\159"
                                                                r8 = r26(r41, r65)
                                                                r55 = r30[r8]
                                                                r63 = r48(r55)
                                                                r48 = allocUpvalue()
                                                                upvalueValues[r48] = r63
                                                                r63 = upvalueValues[r48]
                                                                r30 = upvalueValues[r29]
                                                                r26 = upvalueValues[r12]
                                                                r41 = "\129t\232\171"
                                                                r65 = 30917516081213
                                                                r8 = r26(r41, r65)
                                                                r55 = r30[r8]
                                                                r8 = "UDim2"
                                                                r26 = _env[r8]
                                                                r41 = upvalueValues[r29]
                                                                r65 = upvalueValues[r12]
                                                                r52 = 6115104951071
                                                                r42 = "\203f\\"
                                                                r1 = r65(r42, r52)
                                                                r8 = r41[r1]
                                                                r30 = r26[r8]
                                                                r8 = 0
                                                                r1 = 200
                                                                r41 = 300
                                                                r65 = 0
                                                                r26 = r30(r8, r41, r65, r1)
                                                                r63[r55] = r26
                                                                r63 = upvalueValues[r48]
                                                                r30 = upvalueValues[r29]
                                                                r26 = upvalueValues[r12]
                                                                r41 = "\000\138VU\229\140\208\006"
                                                                r65 = 21934498293734
                                                                r8 = r26(r41, r65)
                                                                r55 = r30[r8]
                                                                r8 = "UDim2"
                                                                r26 = _env[r8]
                                                                r41 = upvalueValues[r29]
                                                                r65 = upvalueValues[r12]
                                                                r42 = "'\011D"
                                                                r52 = 29115337684213
                                                                r1 = r65(r42, r52)
                                                                r8 = r41[r1]
                                                                r30 = r26[r8]
                                                                r41 = -150
                                                                r1 = -100
                                                                r65 = 0.5
                                                                r8 = 0.5
                                                                r26 = r30(r8, r41, r65, r1)
                                                                r63[r55] = r26
                                                                r63 = upvalueValues[r48]
                                                                r30 = upvalueValues[r29]
                                                                r26 = upvalueValues[r12]
                                                                r41 = "n\207\145\238\252\217't\137\245\204\193\226\198\022\155"
                                                                r65 = 14250738883052
                                                                r8 = r26(r41, r65)
                                                                r55 = r30[r8]
                                                                r8 = "Color3"
                                                                r26 = _env[r8]
                                                                r41 = upvalueValues[r29]
                                                                r65 = upvalueValues[r12]
                                                                r42 = "g\019\153\212r\241d"
                                                                r52 = 20434051982635
                                                                r1 = r65(r42, r52)
                                                                r8 = r41[r1]
                                                                r30 = r26[r8]
                                                                r65 = 30
                                                                r8 = 25
                                                                r41 = 25
                                                                r26 = r30(r8, r41, r65)
                                                                r63[r55] = r26
                                                                r63 = upvalueValues[r48]
                                                                r30 = upvalueValues[r29]
                                                                r26 = upvalueValues[r12]
                                                                r41 = "\228\007q\134\165\169B\131\133\252|a\128\196\185"
                                                                r65 = 11574932739341
                                                                r8 = r26(r41, r65)
                                                                r55 = r30[r8]
                                                                r30 = 0
                                                                r63[r55] = r30
                                                                r63 = upvalueValues[r48]
                                                                r30 = upvalueValues[r29]
                                                                r26 = upvalueValues[r12]
                                                                r65 = 12000957044180
                                                                r41 = "f@U\251\191u"
                                                                r8 = r26(r41, r65)
                                                                r55 = r30[r8]
                                                                r30 = upvalueValues[r40]
                                                                r63[r55] = r30
                                                                r30 = "Instance"
                                                                r55 = _env[r30]
                                                                r26 = upvalueValues[r29]
                                                                r8 = upvalueValues[r12]
                                                                r1 = 24728333987067
                                                                r65 = "\228\140a"
                                                                r41 = r8(r65, r1)
                                                                r30 = r26[r41]
                                                                r63 = r55[r30]
                                                                r26 = upvalueValues[r29]
                                                                r8 = upvalueValues[r12]
                                                                r1 = 20459912701239
                                                                r65 = "\169\196\187\254\151\207\204\232"
                                                                r41 = r8(r65, r1)
                                                                r30 = r26[r41]
                                                                r55 = r63(r30)
                                                                r30 = upvalueValues[r29]
                                                                r26 = upvalueValues[r12]
                                                                r41 = "\195 \239%X\235y\016\240\194\133\213"
                                                                r65 = 2804839925018
                                                                r8 = r26(r41, r65)
                                                                r63 = r30[r8]
                                                                r8 = "UDim"
                                                                r26 = _env[r8]
                                                                r41 = upvalueValues[r29]
                                                                r65 = upvalueValues[r12]
                                                                r42 = "\205\210\244"
                                                                r52 = 2952627111262
                                                                r1 = r65(r42, r52)
                                                                r8 = r41[r1]
                                                                r30 = r26[r8]
                                                                r8 = 0
                                                                r41 = 10
                                                                r26 = r30(r8, r41)
                                                                r55[r63] = r26
                                                                r30 = upvalueValues[r29]
                                                                r26 = upvalueValues[r12]
                                                                r65 = 26822380105930
                                                                r41 = "4#\234\"+6"
                                                                r8 = r26(r41, r65)
                                                                r63 = r30[r8]
                                                                r30 = upvalueValues[r48]
                                                                r55[r63] = r30
                                                                r26 = "Instance"
                                                                r30 = _env[r26]
                                                                r8 = upvalueValues[r29]
                                                                r41 = upvalueValues[r12]
                                                                r1 = "2\031X"
                                                                r42 = 24056298875842
                                                                r65 = r41(r1, r42)
                                                                r26 = r8[r65]
                                                                r63 = r30[r26]
                                                                r8 = upvalueValues[r29]
                                                                r41 = upvalueValues[r12]
                                                                r42 = 21829268055989
                                                                r1 = "\175S\0129\128"
                                                                r65 = r41(r1, r42)
                                                                r26 = r8[r65]
                                                                r30 = r63(r26)
                                                                r26 = upvalueValues[r29]
                                                                r8 = upvalueValues[r12]
                                                                r65 = "H\028\020\020"
                                                                r1 = 32404809562865
                                                                r41 = r8(r65, r1)
                                                                r63 = r26[r41]
                                                                r41 = "UDim2"
                                                                r8 = _env[r41]
                                                                r65 = upvalueValues[r29]
                                                                r1 = upvalueValues[r12]
                                                                r56 = 24047962287038
                                                                r52 = "*\238w"
                                                                r42 = r1(r52, r56)
                                                                r41 = r65[r42]
                                                                r26 = r8[r41]
                                                                r65 = 0
                                                                r42 = 30
                                                                r1 = 0
                                                                r41 = 1
                                                                r8 = r26(r41, r65, r1, r42)
                                                                r30[r63] = r8
                                                                r26 = upvalueValues[r29]
                                                                r8 = upvalueValues[r12]
                                                                r1 = 25396258680370
                                                                r65 = "\165\230\007\156\171X\011!\221\245\197\243[\001\130\252"
                                                                r41 = r8(r65, r1)
                                                                r63 = r26[r41]
                                                                r41 = "Color3"
                                                                r8 = _env[r41]
                                                                r65 = upvalueValues[r29]
                                                                r1 = upvalueValues[r12]
                                                                r52 = "N.\227\213\212\144\207"
                                                                r56 = 16504917057029
                                                                r42 = r1(r52, r56)
                                                                r41 = r65[r42]
                                                                r26 = r8[r41]
                                                                r1 = 35
                                                                r65 = 30
                                                                r41 = 30
                                                                r8 = r26(r41, r65, r1)
                                                                r30[r63] = r8
                                                                r26 = upvalueValues[r29]
                                                                r8 = upvalueValues[r12]
                                                                r65 = "\142\164X\016an\207\201\236\021\004\219\253\192\148"
                                                                r1 = 5735399983726
                                                                r41 = r8(r65, r1)
                                                                r63 = r26[r41]
                                                                r26 = 0
                                                                r30[r63] = r26
                                                                r26 = upvalueValues[r29]
                                                                r8 = upvalueValues[r12]
                                                                r1 = 18181788360978
                                                                r65 = "qt\023\017m\139"
                                                                r41 = r8(r65, r1)
                                                                r63 = r26[r41]
                                                                r26 = upvalueValues[r48]
                                                                r30[r63] = r26
                                                                r8 = "Instance"
                                                                r26 = _env[r8]
                                                                r41 = upvalueValues[r29]
                                                                r65 = upvalueValues[r12]
                                                                r52 = 4962311702790
                                                                r42 = "\026\142\197"
                                                                r1 = r65(r42, r52)
                                                                r8 = r41[r1]
                                                                r63 = r26[r8]
                                                                r41 = upvalueValues[r29]
                                                                r65 = upvalueValues[r12]
                                                                r42 = "\184\147d\187\151\173q\180"
                                                                r52 = 24444323359862
                                                                r1 = r65(r42, r52)
                                                                r8 = r41[r1]
                                                                r26 = r63(r8)
                                                                r8 = upvalueValues[r29]
                                                                r41 = upvalueValues[r12]
                                                                r1 = "\206\024\253?~L\169J\241*\149$"
                                                                r42 = 24620812119240
                                                                r65 = r41(r1, r42)
                                                                r63 = r8[r65]
                                                                r65 = "UDim"
                                                                r41 = _env[r65]
                                                                r1 = upvalueValues[r29]
                                                                r42 = upvalueValues[r12]
                                                                r4 = 18509589864875
                                                                r56 = "nxT"
                                                                r52 = r42(r56, r4)
                                                                r65 = r1[r52]
                                                                r8 = r41[r65]
                                                                r65 = 0
                                                                r1 = 10
                                                                r41 = r8(r65, r1)
                                                                r26[r63] = r41
                                                                r8 = upvalueValues[r29]
                                                                r41 = upvalueValues[r12]
                                                                r42 = 25826476371706
                                                                r1 = "\234l]\000i\023"
                                                                r65 = r41(r1, r42)
                                                                r63 = r8[r65]
                                                                r8 = r30
                                                                r26[r63] = r8
                                                                r41 = "Instance"
                                                                r8 = _env[r41]
                                                                r65 = upvalueValues[r29]
                                                                r1 = upvalueValues[r12]
                                                                r52 = ">\139W"
                                                                r56 = 2134589850593
                                                                r42 = r1(r52, r56)
                                                                r41 = r65[r42]
                                                                r63 = r8[r41]
                                                                r65 = upvalueValues[r29]
                                                                r1 = upvalueValues[r12]
                                                                r52 = "\248\197\005_\153\154\019\236\235"
                                                                r56 = 3711677302464
                                                                r42 = r1(r52, r56)
                                                                r41 = r65[r42]
                                                                r8 = r63(r41)
                                                                r41 = upvalueValues[r29]
                                                                r65 = upvalueValues[r12]
                                                                r42 = "J\155\178\195"
                                                                r52 = 15091502209907
                                                                r1 = r65(r42, r52)
                                                                r63 = r41[r1]
                                                                r1 = "UDim2"
                                                                r65 = _env[r1]
                                                                r42 = upvalueValues[r29]
                                                                r52 = upvalueValues[r12]
                                                                r53 = 25665687465647
                                                                r4 = "\204\027\138"
                                                                r56 = r52(r4, r53)
                                                                r1 = r42[r56]
                                                                r41 = r65[r1]
                                                                r56 = 0
                                                                r42 = 0
                                                                r1 = 0.8
                                                                r52 = 1
                                                                r65 = r41(r1, r42, r52, r56)
                                                                r8[r63] = r65
                                                                r41 = upvalueValues[r29]
                                                                r65 = upvalueValues[r12]
                                                                r52 = 23694115711769
                                                                r42 = "\138\005!\212\175\209\217\020\019\225\153\129\2178\191\180j\197\169Tu\223"
                                                                r1 = r65(r42, r52)
                                                                r63 = r41[r1]
                                                                r41 = 1
                                                                r8[r63] = r41
                                                                r41 = upvalueValues[r29]
                                                                r65 = upvalueValues[r12]
                                                                r42 = "\019\199\006\226"
                                                                r52 = 10824646185904
                                                                r1 = r65(r42, r52)
                                                                r63 = r41[r1]
                                                                r65 = upvalueValues[r29]
                                                                r1 = upvalueValues[r12]
                                                                r56 = 31780792416719
                                                                r52 = "\129l\002\222\128\206^\250\194\158\173\201\005\176m\174\214\130"
                                                                r42 = r1(r52, r56)
                                                                r41 = r65[r42]
                                                                r8[r63] = r41
                                                                r41 = upvalueValues[r29]
                                                                r65 = upvalueValues[r12]
                                                                r52 = 10444241900287
                                                                r42 = "\019\t\230\234\147h\0037\015\150"
                                                                r1 = r65(r42, r52)
                                                                r63 = r41[r1]
                                                                r1 = "Color3"
                                                                r65 = _env[r1]
                                                                r42 = upvalueValues[r29]
                                                                r52 = upvalueValues[r12]
                                                                r4 = "q\251\131wdDu"
                                                                r53 = 4755611781286
                                                                r56 = r52(r4, r53)
                                                                r1 = r42[r56]
                                                                r41 = r65[r1]
                                                                r52 = 255
                                                                r42 = 255
                                                                r1 = 255
                                                                r65 = r41(r1, r42, r52)
                                                                r8[r63] = r65
                                                                r41 = upvalueValues[r29]
                                                                r65 = upvalueValues[r12]
                                                                r52 = 10847159194555
                                                                r42 = "QJ\162\156\242\028{_"
                                                                r1 = r65(r42, r52)
                                                                r63 = r41[r1]
                                                                r41 = 16
                                                                r8[r63] = r41
                                                                r41 = upvalueValues[r29]
                                                                r65 = upvalueValues[r12]
                                                                r52 = 30878293899306
                                                                r42 = "G\255\188\186"
                                                                r1 = r65(r42, r52)
                                                                r63 = r41[r1]
                                                                r42 = "Enum"
                                                                r1 = _env[r42]
                                                                r52 = upvalueValues[r29]
                                                                r56 = upvalueValues[r12]
                                                                r19 = 16330544520628
                                                                r53 = "A\139k\138"
                                                                r4 = r56(r53, r19)
                                                                r42 = r52[r4]
                                                                r65 = r1[r42]
                                                                r42 = upvalueValues[r29]
                                                                r52 = upvalueValues[r12]
                                                                r4 = ",E\011\223\187O\150\162\026\216"
                                                                r53 = 22848116238735
                                                                r56 = r52(r4, r53)
                                                                r1 = r42[r56]
                                                                r41 = r65[r1]
                                                                r8[r63] = r41
                                                                r41 = upvalueValues[r29]
                                                                r65 = upvalueValues[r12]
                                                                r42 = "\168\004q\160\242\021"
                                                                r52 = 20422255781157
                                                                r1 = r65(r42, r52)
                                                                r63 = r41[r1]
                                                                r41 = r30
                                                                r8[r63] = r41
                                                                r65 = "Instance"
                                                                r41 = _env[r65]
                                                                r1 = upvalueValues[r29]
                                                                r42 = upvalueValues[r12]
                                                                r56 = "\141w\027"
                                                                r4 = 1606085133035
                                                                r52 = r42(r56, r4)
                                                                r65 = r1[r52]
                                                                r63 = r41[r65]
                                                                r1 = upvalueValues[r29]
                                                                r42 = upvalueValues[r12]
                                                                r4 = 25652956163753
                                                                r56 = "\185\142U\129\215\167\206WO\232"
                                                                r52 = r42(r56, r4)
                                                                r65 = r1[r52]
                                                                r41 = r63(r65)
                                                                r63 = allocUpvalue()
                                                                upvalueValues[r63] = r41
                                                                r41 = upvalueValues[r63]
                                                                r1 = upvalueValues[r29]
                                                                r42 = upvalueValues[r12]
                                                                r56 = "\208S\212\234"
                                                                r4 = 23374882892420
                                                                r52 = r42(r56, r4)
                                                                r65 = r1[r52]
                                                                r52 = "UDim2"
                                                                r42 = _env[r52]
                                                                r56 = upvalueValues[r29]
                                                                r4 = upvalueValues[r12]
                                                                r24 = 28428465238966
                                                                r19 = "S\t\006"
                                                                r53 = r4(r19, r24)
                                                                r52 = r56[r53]
                                                                r1 = r42[r52]
                                                                r56 = 30
                                                                r53 = 30
                                                                r4 = 0
                                                                r52 = 0
                                                                r42 = r1(r52, r56, r4, r53)
                                                                r41[r65] = r42
                                                                r41 = upvalueValues[r63]
                                                                r1 = upvalueValues[r29]
                                                                r42 = upvalueValues[r12]
                                                                r4 = 14524882934379
                                                                r56 = "\213ycgg\209\"\170"
                                                                r52 = r42(r56, r4)
                                                                r65 = r1[r52]
                                                                r52 = "UDim2"
                                                                r42 = _env[r52]
                                                                r56 = upvalueValues[r29]
                                                                r4 = upvalueValues[r12]
                                                                r19 = "U\220)"
                                                                r24 = 10019778843193
                                                                r53 = r4(r19, r24)
                                                                r52 = r56[r53]
                                                                r1 = r42[r52]
                                                                r56 = -60
                                                                r53 = 0
                                                                r52 = 1
                                                                r4 = 0
                                                                r42 = r1(r52, r56, r4, r53)
                                                                r41[r65] = r42
                                                                r41 = upvalueValues[r63]
                                                                r1 = upvalueValues[r29]
                                                                r42 = upvalueValues[r12]
                                                                r56 = "\216m\127\178\n!\252\238tx\168\212 j4;"
                                                                r4 = 25648902696615
                                                                r52 = r42(r56, r4)
                                                                r65 = r1[r52]
                                                                r52 = "Color3"
                                                                r42 = _env[r52]
                                                                r56 = upvalueValues[r29]
                                                                r4 = upvalueValues[r12]
                                                                r24 = 3388473132585
                                                                r19 = "\006\183\239\184\160\218\163"
                                                                r53 = r4(r19, r24)
                                                                r52 = r56[r53]
                                                                r1 = r42[r52]
                                                                r56 = 40
                                                                r52 = 40
                                                                r4 = 45
                                                                r42 = r1(r52, r56, r4)
                                                                r41[r65] = r42
                                                                r41 = upvalueValues[r63]
                                                                r1 = upvalueValues[r29]
                                                                r42 = upvalueValues[r12]
                                                                r4 = 231665418347
                                                                r56 = "\139\216\168\025"
                                                                r52 = r42(r56, r4)
                                                                r65 = r1[r52]
                                                                r42 = upvalueValues[r29]
                                                                r52 = upvalueValues[r12]
                                                                r53 = 6969447648429
                                                                r4 = "\ndV"
                                                                r56 = r52(r4, r53)
                                                                r1 = r42[r56]
                                                                r41[r65] = r1
                                                                r41 = upvalueValues[r63]
                                                                r1 = upvalueValues[r29]
                                                                r42 = upvalueValues[r12]
                                                                r56 = "\211\151\tesz4\206|\141"
                                                                r4 = 9123873116312
                                                                r52 = r42(r56, r4)
                                                                r65 = r1[r52]
                                                                r52 = "Color3"
                                                                r42 = _env[r52]
                                                                r56 = upvalueValues[r29]
                                                                r4 = upvalueValues[r12]
                                                                r19 = "p/\129\193T\215\224"
                                                                r24 = 18413453795710
                                                                r53 = r4(r19, r24)
                                                                r52 = r56[r53]
                                                                r1 = r42[r52]
                                                                r4 = 255
                                                                r52 = 255
                                                                r56 = 255
                                                                r42 = r1(r52, r56, r4)
                                                                r41[r65] = r42
                                                                r41 = upvalueValues[r63]
                                                                r1 = upvalueValues[r29]
                                                                r42 = upvalueValues[r12]
                                                                r4 = 11931759351220
                                                                r56 = "\230\230H_y{\004\190"
                                                                r52 = r42(r56, r4)
                                                                r65 = r1[r52]
                                                                r1 = 20
                                                                r41[r65] = r1
                                                                r41 = upvalueValues[r63]
                                                                r1 = upvalueValues[r29]
                                                                r42 = upvalueValues[r12]
                                                                r56 = "N\190l,"
                                                                r4 = 33568196476175
                                                                r52 = r42(r56, r4)
                                                                r65 = r1[r52]
                                                                r56 = "Enum"
                                                                r52 = _env[r56]
                                                                r4 = upvalueValues[r29]
                                                                r53 = upvalueValues[r12]
                                                                r7 = 7849893809735
                                                                r24 = "\023\130~\005"
                                                                r19 = r53(r24, r7)
                                                                r56 = r4[r19]
                                                                r42 = r52[r56]
                                                                r56 = upvalueValues[r29]
                                                                r4 = upvalueValues[r12]
                                                                r24 = 30441349216095
                                                                r19 = "\210\026\244k\174D\135\242_)"
                                                                r53 = r4(r19, r24)
                                                                r52 = r56[r53]
                                                                r1 = r42[r52]
                                                                r41[r65] = r1
                                                                r41 = upvalueValues[r63]
                                                                r1 = upvalueValues[r29]
                                                                r42 = upvalueValues[r12]
                                                                r4 = 24210300742665
                                                                r56 = "\242\214\197'\138>"
                                                                r52 = r42(r56, r4)
                                                                r65 = r1[r52]
                                                                r1 = r30
                                                                r41[r65] = r1
                                                                r1 = "Instance"
                                                                r65 = _env[r1]
                                                                r42 = upvalueValues[r29]
                                                                r52 = upvalueValues[r12]
                                                                r53 = 9984483676713
                                                                r4 = "\130\015\210"
                                                                r56 = r52(r4, r53)
                                                                r1 = r42[r56]
                                                                r41 = r65[r1]
                                                                r42 = upvalueValues[r29]
                                                                r52 = upvalueValues[r12]
                                                                r53 = 34153026518559
                                                                r4 = "9\127\028\186{\153*C"
                                                                r56 = r52(r4, r53)
                                                                r1 = r42[r56]
                                                                r65 = r41(r1)
                                                                r1 = upvalueValues[r29]
                                                                r42 = upvalueValues[r12]
                                                                r4 = 4117430847357
                                                                r56 = "\1708\1860g5v\235\191>[0"
                                                                r52 = r42(r56, r4)
                                                                r41 = r1[r52]
                                                                r52 = "UDim"
                                                                r42 = _env[r52]
                                                                r56 = upvalueValues[r29]
                                                                r4 = upvalueValues[r12]
                                                                r19 = "\146\208\005"
                                                                r24 = 465799037144
                                                                r53 = r4(r19, r24)
                                                                r52 = r56[r53]
                                                                r1 = r42[r52]
                                                                r56 = 10
                                                                r52 = 0
                                                                r42 = r1(r52, r56)
                                                                r65[r41] = r42
                                                                r1 = upvalueValues[r29]
                                                                r42 = upvalueValues[r12]
                                                                r4 = 22662770125113
                                                                r56 = "\138\183B\158\144\019"
                                                                r52 = r42(r56, r4)
                                                                r41 = r1[r52]
                                                                r1 = upvalueValues[r63]
                                                                r65[r41] = r1
                                                                r42 = "Instance"
                                                                r1 = _env[r42]
                                                                r52 = upvalueValues[r29]
                                                                r56 = upvalueValues[r12]
                                                                r19 = 14942077049645
                                                                r53 = "\1813w"
                                                                r4 = r56(r53, r19)
                                                                r42 = r52[r4]
                                                                r41 = r1[r42]
                                                                r52 = upvalueValues[r29]
                                                                r56 = upvalueValues[r12]
                                                                r53 = "\153\030(\237G\220\193\167\0236"
                                                                r19 = 32246591453863
                                                                r4 = r56(r53, r19)
                                                                r42 = r52[r4]
                                                                r1 = r41(r42)
                                                                r42 = upvalueValues[r29]
                                                                r52 = upvalueValues[r12]
                                                                r53 = 33107012041784
                                                                r4 = "\192\143\005)"
                                                                r56 = r52(r4, r53)
                                                                r41 = r42[r56]
                                                                r56 = "UDim2"
                                                                r52 = _env[r56]
                                                                r4 = upvalueValues[r29]
                                                                r53 = upvalueValues[r12]
                                                                r7 = 19697688830932
                                                                r24 = "\229^\022"
                                                                r19 = r53(r24, r7)
                                                                r56 = r4[r19]
                                                                r42 = r52[r56]
                                                                r53 = 0
                                                                r19 = 30
                                                                r4 = 30
                                                                r56 = 0
                                                                r52 = r42(r56, r4, r53, r19)
                                                                r1[r41] = r52
                                                                r42 = upvalueValues[r29]
                                                                r52 = upvalueValues[r12]
                                                                r4 = "\133G\143\243RM\016v"
                                                                r53 = 7909378559587
                                                                r56 = r52(r4, r53)
                                                                r41 = r42[r56]
                                                                r56 = "UDim2"
                                                                r52 = _env[r56]
                                                                r4 = upvalueValues[r29]
                                                                r53 = upvalueValues[r12]
                                                                r7 = 28800933835875
                                                                r24 = "\215\222\176"
                                                                r19 = r53(r24, r7)
                                                                r56 = r4[r19]
                                                                r42 = r52[r56]
                                                                r4 = -30
                                                                r56 = 1
                                                                r19 = 0
                                                                r53 = 0
                                                                r52 = r42(r56, r4, r53, r19)
                                                                r1[r41] = r52
                                                                r42 = upvalueValues[r29]
                                                                r52 = upvalueValues[r12]
                                                                r53 = 843861246344
                                                                r4 = "\168j\132\017\150\1938J\174f\180\028\228%\180:"
                                                                r56 = r52(r4, r53)
                                                                r41 = r42[r56]
                                                                r56 = "Color3"
                                                                r52 = _env[r56]
                                                                r4 = upvalueValues[r29]
                                                                r53 = upvalueValues[r12]
                                                                r7 = 30757494798322
                                                                r24 = "\140oM\248\237\029\151"
                                                                r19 = r53(r24, r7)
                                                                r56 = r4[r19]
                                                                r42 = r52[r56]
                                                                r4 = 50
                                                                r53 = 50
                                                                r56 = 140
                                                                r52 = r42(r56, r4, r53)
                                                                r1[r41] = r52
                                                                r42 = upvalueValues[r29]
                                                                r52 = upvalueValues[r12]
                                                                r4 = "\231\200$\200"
                                                                r53 = 14038817511817
                                                                r56 = r52(r4, r53)
                                                                r41 = r42[r56]
                                                                r52 = upvalueValues[r29]
                                                                r56 = upvalueValues[r12]
                                                                r19 = 2449946379380
                                                                r53 = "\223"
                                                                r4 = r56(r53, r19)
                                                                r42 = r52[r4]
                                                                r1[r41] = r42
                                                                r42 = upvalueValues[r29]
                                                                r52 = upvalueValues[r12]
                                                                r53 = 21226078873244
                                                                r4 = "\015\004\233\223\r\133>\234\255e"
                                                                r56 = r52(r4, r53)
                                                                r41 = r42[r56]
                                                                r56 = "Color3"
                                                                r52 = _env[r56]
                                                                r4 = upvalueValues[r29]
                                                                r53 = upvalueValues[r12]
                                                                r24 = ":\194f'Q\202B"
                                                                r7 = 2229328299022
                                                                r19 = r53(r24, r7)
                                                                r56 = r4[r19]
                                                                r42 = r52[r56]
                                                                r53 = 220
                                                                r56 = 255
                                                                r4 = 220
                                                                r52 = r42(r56, r4, r53)
                                                                r1[r41] = r52
                                                                r42 = upvalueValues[r29]
                                                                r52 = upvalueValues[r12]
                                                                r53 = 30878411618346
                                                                r4 = "\222>\152\230\234\186\131O"
                                                                r56 = r52(r4, r53)
                                                                r41 = r42[r56]
                                                                r42 = 20
                                                                r1[r41] = r42
                                                                r42 = upvalueValues[r29]
                                                                r52 = upvalueValues[r12]
                                                                r4 = "\140\166j\147"
                                                                r53 = 566589702407
                                                                r56 = r52(r4, r53)
                                                                r41 = r42[r56]
                                                                r4 = "Enum"
                                                                r56 = _env[r4]
                                                                r53 = upvalueValues[r29]
                                                                r19 = upvalueValues[r12]
                                                                r73 = 12249107142215
                                                                r7 = "\153\208\255\167"
                                                                r24 = r19(r7, r73)
                                                                r4 = r53[r24]
                                                                r52 = r56[r4]
                                                                r4 = upvalueValues[r29]
                                                                r53 = upvalueValues[r12]
                                                                r7 = 21342942209746
                                                                r24 = "\t\182Z\187es\006R\005\136"
                                                                r19 = r53(r24, r7)
                                                                r56 = r4[r19]
                                                                r42 = r52[r56]
                                                                r1[r41] = r42
                                                                r42 = upvalueValues[r29]
                                                                r52 = upvalueValues[r12]
                                                                r53 = 3955062834993
                                                                r4 = "\240\176z\"\206\163"
                                                                r56 = r52(r4, r53)
                                                                r41 = r42[r56]
                                                                r42 = r30
                                                                r1[r41] = r42
                                                                r52 = "Instance"
                                                                r42 = _env[r52]
                                                                r56 = upvalueValues[r29]
                                                                r4 = upvalueValues[r12]
                                                                r24 = 12480772560563
                                                                r19 = "(\005\243"
                                                                r53 = r4(r19, r24)
                                                                r52 = r56[r53]
                                                                r41 = r42[r52]
                                                                r56 = upvalueValues[r29]
                                                                r4 = upvalueValues[r12]
                                                                r24 = 28312389874559
                                                                r19 = "\223\164\251\131\199\r\205\247"
                                                                r53 = r4(r19, r24)
                                                                r52 = r56[r53]
                                                                r42 = r41(r52)
                                                                r52 = upvalueValues[r29]
                                                                r56 = upvalueValues[r12]
                                                                r53 = "\172A\169n\235Z\213\130\237\007\189\248"
                                                                r19 = 13078935951306
                                                                r4 = r56(r53, r19)
                                                                r41 = r52[r4]
                                                                r4 = "UDim"
                                                                r56 = _env[r4]
                                                                r53 = upvalueValues[r29]
                                                                r19 = upvalueValues[r12]
                                                                r73 = 30894226356274
                                                                r7 = "V\251P"
                                                                r24 = r19(r7, r73)
                                                                r4 = r53[r24]
                                                                r52 = r56[r4]
                                                                r53 = 10
                                                                r4 = 0
                                                                r56 = r52(r4, r53)
                                                                r42[r41] = r56
                                                                r52 = upvalueValues[r29]
                                                                r56 = upvalueValues[r12]
                                                                r19 = 5059777120564
                                                                r53 = "j\030\ri}C"
                                                                r4 = r56(r53, r19)
                                                                r41 = r52[r4]
                                                                r52 = r1
                                                                r42[r41] = r52
                                                                r56 = "Instance"
                                                                r52 = _env[r56]
                                                                r4 = upvalueValues[r29]
                                                                r53 = upvalueValues[r12]
                                                                r7 = 11462760322265
                                                                r24 = "b\234\192"
                                                                r19 = r53(r24, r7)
                                                                r56 = r4[r19]
                                                                r41 = r52[r56]
                                                                r4 = upvalueValues[r29]
                                                                r53 = upvalueValues[r12]
                                                                r7 = 3559748077177
                                                                r24 = "c\142\250\205`"
                                                                r19 = r53(r24, r7)
                                                                r56 = r4[r19]
                                                                r52 = r41(r56)
                                                                r41 = allocUpvalue()
                                                                upvalueValues[r41] = r52
                                                                r52 = upvalueValues[r41]
                                                                r4 = upvalueValues[r29]
                                                                r53 = upvalueValues[r12]
                                                                r7 = 316754247827
                                                                r24 = "@\213f6"
                                                                r19 = r53(r24, r7)
                                                                r56 = r4[r19]
                                                                r19 = "UDim2"
                                                                r53 = _env[r19]
                                                                r24 = upvalueValues[r29]
                                                                r7 = upvalueValues[r12]
                                                                r35 = 488688976099
                                                                r76 = "\249\023\169"
                                                                r73 = r7(r76, r35)
                                                                r19 = r24[r73]
                                                                r4 = r53[r19]
                                                                r73 = 170
                                                                r24 = 120
                                                                r7 = 0
                                                                r19 = 0
                                                                r53 = r4(r19, r24, r7, r73)
                                                                r52[r56] = r53
                                                                r52 = upvalueValues[r41]
                                                                r4 = upvalueValues[r29]
                                                                r53 = upvalueValues[r12]
                                                                r24 = "\170\149\210\029\1850EP"
                                                                r7 = 13544231753891
                                                                r19 = r53(r24, r7)
                                                                r56 = r4[r19]
                                                                r19 = "UDim2"
                                                                r53 = _env[r19]
                                                                r24 = upvalueValues[r29]
                                                                r7 = upvalueValues[r12]
                                                                r76 = "\007\135\131"
                                                                r35 = 34469780766387
                                                                r73 = r7(r76, r35)
                                                                r19 = r24[r73]
                                                                r4 = r53[r19]
                                                                r24 = 0
                                                                r19 = 0
                                                                r73 = 30
                                                                r7 = 0
                                                                r53 = r4(r19, r24, r7, r73)
                                                                r52[r56] = r53
                                                                r52 = upvalueValues[r41]
                                                                r4 = upvalueValues[r29]
                                                                r53 = upvalueValues[r12]
                                                                r24 = "5\196\219Z7;\232\247u\130\209\205\255a\166\012"
                                                                r7 = 4606119823456
                                                                r19 = r53(r24, r7)
                                                                r56 = r4[r19]
                                                                r19 = "Color3"
                                                                r53 = _env[r19]
                                                                r24 = upvalueValues[r29]
                                                                r7 = upvalueValues[r12]
                                                                r35 = 14010030791035
                                                                r76 = "f\184L6\163\234\183"
                                                                r73 = r7(r76, r35)
                                                                r19 = r24[r73]
                                                                r4 = r53[r19]
                                                                r7 = 35
                                                                r19 = 30
                                                                r24 = 30
                                                                r53 = r4(r19, r24, r7)
                                                                r52[r56] = r53
                                                                r52 = upvalueValues[r41]
                                                                r4 = upvalueValues[r29]
                                                                r53 = upvalueValues[r12]
                                                                r7 = 21948178802668
                                                                r24 = "\002#5\201\143\128$\206\241\132)u\137\025\182"
                                                                r19 = r53(r24, r7)
                                                                r56 = r4[r19]
                                                                r4 = 0
                                                                r52[r56] = r4
                                                                r52 = upvalueValues[r41]
                                                                r4 = upvalueValues[r29]
                                                                r53 = upvalueValues[r12]
                                                                r7 = 19548196873102
                                                                r24 = "\159.\01876\239"
                                                                r19 = r53(r24, r7)
                                                                r56 = r4[r19]
                                                                r4 = upvalueValues[r48]
                                                                r52[r56] = r4
                                                                r4 = "Instance"
                                                                r56 = _env[r4]
                                                                r53 = upvalueValues[r29]
                                                                r19 = upvalueValues[r12]
                                                                r73 = 11072250139683
                                                                r7 = "\243\254\247"
                                                                r24 = r19(r7, r73)
                                                                r4 = r53[r24]
                                                                r52 = r56[r4]
                                                                r53 = upvalueValues[r29]
                                                                r19 = upvalueValues[r12]
                                                                r73 = 19870818739237
                                                                r7 = "\188]4bg`\230\023"
                                                                r24 = r19(r7, r73)
                                                                r4 = r53[r24]
                                                                r56 = r52(r4)
                                                                r4 = upvalueValues[r29]
                                                                r53 = upvalueValues[r12]
                                                                r7 = 4061513598819
                                                                r24 = "\143\235eL\147*\193|0s\215Y"
                                                                r19 = r53(r24, r7)
                                                                r52 = r4[r19]
                                                                r19 = "UDim"
                                                                r53 = _env[r19]
                                                                r24 = upvalueValues[r29]
                                                                r7 = upvalueValues[r12]
                                                                r35 = 18981628699271
                                                                r76 = "3v\175"
                                                                r73 = r7(r76, r35)
                                                                r19 = r24[r73]
                                                                r4 = r53[r19]
                                                                r24 = 10
                                                                r19 = 0
                                                                r53 = r4(r19, r24)
                                                                r56[r52] = r53
                                                                r4 = upvalueValues[r29]
                                                                r53 = upvalueValues[r12]
                                                                r7 = 13487380469896
                                                                r24 = "\2367=\019\025R"
                                                                r19 = r53(r24, r7)
                                                                r52 = r4[r19]
                                                                r4 = upvalueValues[r41]
                                                                r56[r52] = r4
                                                                r53 = "Instance"
                                                                r4 = _env[r53]
                                                                r19 = upvalueValues[r29]
                                                                r24 = upvalueValues[r12]
                                                                r73 = "\027M\017"
                                                                r76 = 4905374861548
                                                                r7 = r24(r73, r76)
                                                                r53 = r19[r7]
                                                                r52 = r4[r53]
                                                                r19 = upvalueValues[r29]
                                                                r24 = upvalueValues[r12]
                                                                r76 = 14554751408761
                                                                r73 = "-\164\251U\185\161$\140%0g8"
                                                                r7 = r24(r73, r76)
                                                                r53 = r19[r7]
                                                                r4 = r52(r53)
                                                                r53 = upvalueValues[r29]
                                                                r19 = upvalueValues[r12]
                                                                r7 = "+T\254\210LS\151\156J\027/\150\213"
                                                                r73 = 27526197981713
                                                                r24 = r19(r7, r73)
                                                                r52 = r53[r24]
                                                                r7 = "Enum"
                                                                r24 = _env[r7]
                                                                r73 = upvalueValues[r29]
                                                                r76 = upvalueValues[r12]
                                                                r9 = 7355321240929
                                                                r39 = "\141\0261\240\181\140d\2253-\171\248_"
                                                                r35 = r76(r39, r9)
                                                                r7 = r73[r35]
                                                                r19 = r24[r7]
                                                                r7 = upvalueValues[r29]
                                                                r73 = upvalueValues[r12]
                                                                r39 = 596458176789
                                                                r35 = "\207\031\004C+\216z1"
                                                                r76 = r73(r35, r39)
                                                                r24 = r7[r76]
                                                                r53 = r19[r24]
                                                                r4[r52] = r53
                                                                r53 = upvalueValues[r29]
                                                                r19 = upvalueValues[r12]
                                                                r73 = 29755526280735
                                                                r7 = "\195w\231,\219`\224"
                                                                r24 = r19(r7, r73)
                                                                r52 = r53[r24]
                                                                r24 = "UDim"
                                                                r19 = _env[r24]
                                                                r7 = upvalueValues[r29]
                                                                r73 = upvalueValues[r12]
                                                                r39 = 3049360770443
                                                                r35 = "\143\190\r"
                                                                r76 = r73(r35, r39)
                                                                r24 = r7[r76]
                                                                r53 = r19[r24]
                                                                r7 = 5
                                                                r24 = 0
                                                                r19 = r53(r24, r7)
                                                                r4[r52] = r19
                                                                r53 = upvalueValues[r29]
                                                                r19 = upvalueValues[r12]
                                                                r7 = "\154\130@\230h\192"
                                                                r73 = 1163047879197
                                                                r24 = r19(r7, r73)
                                                                r52 = r53[r24]
                                                                r53 = upvalueValues[r41]
                                                                r4[r52] = r53
                                                                r19 = "Instance"
                                                                r53 = _env[r19]
                                                                r24 = upvalueValues[r29]
                                                                r7 = upvalueValues[r12]
                                                                r35 = 6820261317735
                                                                r76 = "\193R\241"
                                                                r73 = r7(r76, r35)
                                                                r19 = r24[r73]
                                                                r52 = r53[r19]
                                                                r24 = upvalueValues[r29]
                                                                r7 = upvalueValues[r12]
                                                                r35 = 24392302980190
                                                                r76 = "i\183\141f\024"
                                                                r73 = r7(r76, r35)
                                                                r19 = r24[r73]
                                                                r53 = r52(r19)
                                                                r52 = allocUpvalue()
                                                                upvalueValues[r52] = r53
                                                                r53 = upvalueValues[r52]
                                                                r24 = upvalueValues[r29]
                                                                r7 = upvalueValues[r12]
                                                                r35 = 5118110730575
                                                                r76 = ")\"\194\134"
                                                                r73 = r7(r76, r35)
                                                                r19 = r24[r73]
                                                                r73 = "UDim2"
                                                                r7 = _env[r73]
                                                                r76 = upvalueValues[r29]
                                                                r35 = upvalueValues[r12]
                                                                r25 = 19301033878299
                                                                r9 = "l\0111"
                                                                r39 = r35(r9, r25)
                                                                r73 = r76[r39]
                                                                r24 = r7[r73]
                                                                r73 = 0
                                                                r76 = 180
                                                                r39 = 170
                                                                r35 = 0
                                                                r7 = r24(r73, r76, r35, r39)
                                                                r53[r19] = r7
                                                                r53 = upvalueValues[r52]
                                                                r24 = upvalueValues[r29]
                                                                r7 = upvalueValues[r12]
                                                                r35 = 17520320749534
                                                                r76 = "{-\011\"_\224\140\\"
                                                                r73 = r7(r76, r35)
                                                                r19 = r24[r73]
                                                                r73 = "UDim2"
                                                                r7 = _env[r73]
                                                                r76 = upvalueValues[r29]
                                                                r35 = upvalueValues[r12]
                                                                r9 = "\175\217 "
                                                                r25 = 18197046681881
                                                                r39 = r35(r9, r25)
                                                                r73 = r76[r39]
                                                                r24 = r7[r73]
                                                                r35 = 0
                                                                r39 = 30
                                                                r76 = 120
                                                                r73 = 0
                                                                r7 = r24(r73, r76, r35, r39)
                                                                r53[r19] = r7
                                                                r53 = upvalueValues[r52]
                                                                r24 = upvalueValues[r29]
                                                                r7 = upvalueValues[r12]
                                                                r76 = "W\218D~\r\014\201A\198\247\202S\228\191\137\203"
                                                                r35 = 15010888145741
                                                                r73 = r7(r76, r35)
                                                                r19 = r24[r73]
                                                                r73 = "Color3"
                                                                r7 = _env[r73]
                                                                r76 = upvalueValues[r29]
                                                                r35 = upvalueValues[r12]
                                                                r9 = "U\255%@\t\135\174"
                                                                r25 = 22580097886482
                                                                r39 = r35(r9, r25)
                                                                r73 = r76[r39]
                                                                r24 = r7[r73]
                                                                r35 = 40
                                                                r73 = 35
                                                                r76 = 35
                                                                r7 = r24(r73, r76, r35)
                                                                r53[r19] = r7
                                                                r53 = upvalueValues[r52]
                                                                r24 = upvalueValues[r29]
                                                                r7 = upvalueValues[r12]
                                                                r35 = 29659807020531
                                                                r76 = "1\2551\135\r\184\154\238\2421\241\144\218\003\014"
                                                                r73 = r7(r76, r35)
                                                                r19 = r24[r73]
                                                                r24 = 0
                                                                r53[r19] = r24
                                                                r53 = upvalueValues[r52]
                                                                r24 = upvalueValues[r29]
                                                                r7 = upvalueValues[r12]
                                                                r35 = 18570636222919
                                                                r76 = "\246i\217b\221\006"
                                                                r73 = r7(r76, r35)
                                                                r19 = r24[r73]
                                                                r24 = upvalueValues[r48]
                                                                r53[r19] = r24
                                                                r24 = "Instance"
                                                                r19 = _env[r24]
                                                                r7 = upvalueValues[r29]
                                                                r73 = upvalueValues[r12]
                                                                r35 = "]j9"
                                                                r39 = 22896852134310
                                                                r76 = r73(r35, r39)
                                                                r24 = r7[r76]
                                                                r53 = r19[r24]
                                                                r7 = upvalueValues[r29]
                                                                r73 = upvalueValues[r12]
                                                                r39 = 30148495996630
                                                                r35 = "R\129\227T\157\130\011\230"
                                                                r76 = r73(r35, r39)
                                                                r24 = r7[r76]
                                                                r19 = r53(r24)
                                                                r24 = upvalueValues[r29]
                                                                r7 = upvalueValues[r12]
                                                                r35 = 32114867976810
                                                                r76 = "\211/\199\226\215\233\217^\178\030\196\156"
                                                                r73 = r7(r76, r35)
                                                                r53 = r24[r73]
                                                                r73 = "UDim"
                                                                r7 = _env[r73]
                                                                r76 = upvalueValues[r29]
                                                                r35 = upvalueValues[r12]
                                                                r25 = 22182260795481
                                                                r9 = "\151ty"
                                                                r39 = r35(r9, r25)
                                                                r73 = r76[r39]
                                                                r24 = r7[r73]
                                                                r76 = 10
                                                                r73 = 0
                                                                r7 = r24(r73, r76)
                                                                r19[r53] = r7
                                                                r24 = upvalueValues[r29]
                                                                r7 = upvalueValues[r12]
                                                                r76 = "\2537p\232\213|"
                                                                r35 = 34754615820087
                                                                r73 = r7(r76, r35)
                                                                r53 = r24[r73]
                                                                r24 = upvalueValues[r52]
                                                                r19[r53] = r24
                                                                r7 = upvalueValues[r29]
                                                                r73 = upvalueValues[r12]
                                                                r39 = 10940526662630
                                                                r35 = "~\212\178\016\012+"
                                                                r76 = r73(r35, r39)
                                                                r24 = r7[r76]
                                                                r73 = upvalueValues[r29]
                                                                r76 = upvalueValues[r12]
                                                                r9 = 8946067492933
                                                                r39 = "\173!n\176\181\151\228\139"
                                                                r35 = r76(r39, r9)
                                                                r7 = r73[r35]
                                                                r76 = upvalueValues[r29]
                                                                r35 = upvalueValues[r12]
                                                                r25 = 19118440604358
                                                                r9 = "\192\1984,\209\222\240\018;s\255\017"
                                                                r39 = r35(r9, r25)
                                                                r73 = r76[r39]
                                                                r53 = {
                                                                    r24,
                                                                    r7,
                                                                    r73
                                                                }
                                                                r24 = {}
                                                                r73 = allocUpvalue()
                                                                r7 = allocUpvalue()
                                                                upvalueValues[r7] = r24
                                                                r24 = nil
                                                                upvalueValues[r73] = r24
                                                                r35 = "ipairs"
                                                                r76 = _env[r35]
                                                                r25 = {
                                                                    r76(r53)
                                                                }
                                                                r24 = createClosure6(71, {
                                                                    r29,
                                                                    r12,
                                                                    r41,
                                                                    r52,
                                                                    r7,
                                                                    r73
                                                                })
                                                                r35 = r25[1]
                                                                r9 = r25[3]
                                                                r39 = r25[2]
                                                                state = 32
                                                            end
                                                        else
                                                            if state == 32 then
                                                                r9, r25 = r35(r39, r9)
                                                                state = r9 and (33) or (34)
                                                            end
                                                        end
                                                    else
                                                        if state <= 33 then
                                                            if state == 33 then
                                                                r76 = r9
                                                                r28 = r24(r25, r76)
                                                                r25 = nil
                                                                r76 = nil
                                                                state = 32
                                                            end
                                                        else
                                                            if state == 34 then
                                                                r35 = upvalueValues[r7]
                                                                r3 = 34464230506160
                                                                r64 = "\169\185[\023\163\251"
                                                                r9 = upvalueValues[r29]
                                                                r25 = upvalueValues[r12]
                                                                r28 = r25(r64, r3)
                                                                r3 = "[\230E"
                                                                r62 = 25202438483415
                                                                r39 = r9[r28]
                                                                r76 = r35[r39]
                                                                r9 = "Instance"
                                                                r39 = _env[r9]
                                                                r25 = upvalueValues[r29]
                                                                r28 = upvalueValues[r12]
                                                                r74 = 4241195485110
                                                                r64 = r28(r3, r74)
                                                                r9 = r25[r64]
                                                                r4 = nil
                                                                r35 = r39[r9]
                                                                r31 = "{\142["
                                                                r25 = upvalueValues[r29]
                                                                r28 = upvalueValues[r12]
                                                                r3 = "^V\195m\024\0276$\014\210"
                                                                r74 = 16484553956860
                                                                r64 = r28(r3, r74)
                                                                r9 = r25[r64]
                                                                r39 = r35(r9)
                                                                r35 = allocUpvalue()
                                                                upvalueValues[r35] = r39
                                                                r39 = upvalueValues[r35]
                                                                r25 = upvalueValues[r29]
                                                                r28 = upvalueValues[r12]
                                                                r3 = "?\031\192\145"
                                                                r74 = 34720508722983
                                                                r64 = r28(r3, r74)
                                                                r9 = r25[r64]
                                                                r64 = "UDim2"
                                                                r28 = _env[r64]
                                                                r3 = upvalueValues[r29]
                                                                r74 = upvalueValues[r12]
                                                                r34 = r74(r31, r62)
                                                                r64 = r3[r34]
                                                                r62 = 2841775605035
                                                                r31 = "\172\228 "
                                                                r25 = r28[r64]
                                                                r64 = 0
                                                                r3 = 100
                                                                r34 = 35
                                                                r74 = 0
                                                                r28 = r25(r64, r3, r74, r34)
                                                                r39[r9] = r28
                                                                r3 = "\"\147\221\199+\251w\251"
                                                                r39 = upvalueValues[r35]
                                                                r25 = upvalueValues[r29]
                                                                r28 = upvalueValues[r12]
                                                                r74 = 10517428622113
                                                                r64 = r28(r3, r74)
                                                                r9 = r25[r64]
                                                                r64 = "UDim2"
                                                                r28 = _env[r64]
                                                                r3 = upvalueValues[r29]
                                                                r74 = upvalueValues[r12]
                                                                r34 = r74(r31, r62)
                                                                r64 = r3[r34]
                                                                r25 = r28[r64]
                                                                r3 = -50
                                                                r34 = 10
                                                                r64 = 0.5
                                                                r74 = 0
                                                                r28 = r25(r64, r3, r74, r34)
                                                                r39[r9] = r28
                                                                r39 = upvalueValues[r35]
                                                                r25 = upvalueValues[r29]
                                                                r28 = upvalueValues[r12]
                                                                r3 = "Y\1947o`x;)\192x\138H\2049\248\158"
                                                                r74 = 12142357272086
                                                                r64 = r28(r3, r74)
                                                                r9 = r25[r64]
                                                                r31 = "\225\220A\243\2117_"
                                                                r64 = "Color3"
                                                                r28 = _env[r64]
                                                                r3 = upvalueValues[r29]
                                                                r74 = upvalueValues[r12]
                                                                r62 = 11370564588718
                                                                r34 = r74(r31, r62)
                                                                r64 = r3[r34]
                                                                r3 = 130
                                                                r25 = r28[r64]
                                                                r64 = 70
                                                                r74 = 70
                                                                r28 = r25(r64, r3, r74)
                                                                r39[r9] = r28
                                                                r62 = 5389236111821
                                                                r39 = upvalueValues[r35]
                                                                r25 = upvalueValues[r29]
                                                                r28 = upvalueValues[r12]
                                                                r3 = "\203\245\171c"
                                                                r34 = 4200386774947
                                                                r74 = 30539717588877
                                                                r64 = r28(r3, r74)
                                                                r9 = r25[r64]
                                                                r28 = upvalueValues[r29]
                                                                r64 = upvalueValues[r12]
                                                                r31 = "\239\006\016\005A\023_"
                                                                r74 = "\221W\140O\191\026,\219P\211E\\\187"
                                                                r3 = r64(r74, r34)
                                                                r25 = r28[r3]
                                                                r39[r9] = r25
                                                                r39 = upvalueValues[r35]
                                                                r25 = upvalueValues[r29]
                                                                r3 = "$\250\135'\138\128\178\03101"
                                                                r28 = upvalueValues[r12]
                                                                r74 = 31524734450007
                                                                r64 = r28(r3, r74)
                                                                r9 = r25[r64]
                                                                r64 = "Color3"
                                                                r28 = _env[r64]
                                                                r3 = upvalueValues[r29]
                                                                r74 = upvalueValues[r12]
                                                                r34 = r74(r31, r62)
                                                                r64 = r3[r34]
                                                                r62 = "\014o\151\175"
                                                                r3 = 255
                                                                r25 = r28[r64]
                                                                r64 = 220
                                                                r74 = 220
                                                                r28 = r25(r64, r3, r74)
                                                                r81 = 6485306280907
                                                                r78 = 34842910293856
                                                                r22 = 9928077726223
                                                                r77 = 35027992936375
                                                                r54 = nil
                                                                r39[r9] = r28
                                                                r39 = upvalueValues[r35]
                                                                r25 = upvalueValues[r29]
                                                                r28 = upvalueValues[r12]
                                                                r13 = 2818852521248
                                                                r3 = "\206\1312\211r\189\186K"
                                                                r74 = 14455462976075
                                                                r64 = r28(r3, r74)
                                                                r9 = r25[r64]
                                                                r25 = 14
                                                                r39[r9] = r25
                                                                r3 = "\198\216U\179"
                                                                r39 = upvalueValues[r35]
                                                                r74 = 31505420351822
                                                                r25 = upvalueValues[r29]
                                                                r28 = upvalueValues[r12]
                                                                r27 = nil
                                                                r64 = r28(r3, r74)
                                                                r3 = "Enum"
                                                                r9 = r25[r64]
                                                                r64 = _env[r3]
                                                                r74 = upvalueValues[r29]
                                                                r34 = upvalueValues[r12]
                                                                r31 = r34(r62, r13)
                                                                r3 = r74[r31]
                                                                r28 = r64[r3]
                                                                r62 = 19185974092518
                                                                r31 = "c\238\211\162\225\171"
                                                                r3 = upvalueValues[r29]
                                                                r74 = upvalueValues[r12]
                                                                r34 = r74(r31, r62)
                                                                r64 = r3[r34]
                                                                r25 = r28[r64]
                                                                r39[r9] = r25
                                                                r39 = upvalueValues[r35]
                                                                r25 = upvalueValues[r29]
                                                                r3 = "\132)\185\019kX"
                                                                r28 = upvalueValues[r12]
                                                                r74 = 14872370371341
                                                                r64 = r28(r3, r74)
                                                                r9 = r25[r64]
                                                                r25 = r76
                                                                r39[r9] = r25
                                                                r34 = 23145321064985
                                                                r31 = "\226\181\245"
                                                                r25 = "Instance"
                                                                r9 = _env[r25]
                                                                r28 = upvalueValues[r29]
                                                                r64 = upvalueValues[r12]
                                                                r74 = "xw\153"
                                                                r3 = r64(r74, r34)
                                                                r34 = 18880609100375
                                                                r25 = r28[r3]
                                                                r39 = r9[r25]
                                                                r28 = upvalueValues[r29]
                                                                r64 = upvalueValues[r12]
                                                                r74 = "g:\149I\155M\015\194"
                                                                r3 = r64(r74, r34)
                                                                r25 = r28[r3]
                                                                r62 = 30469678298988
                                                                r9 = r39(r25)
                                                                r25 = upvalueValues[r29]
                                                                r3 = "\239\220\193vXN\160\207\018\021\236?"
                                                                r28 = upvalueValues[r12]
                                                                r74 = 30354188367670
                                                                r64 = r28(r3, r74)
                                                                r39 = r25[r64]
                                                                r64 = "UDim"
                                                                r28 = _env[r64]
                                                                r3 = upvalueValues[r29]
                                                                r74 = upvalueValues[r12]
                                                                r34 = r74(r31, r62)
                                                                r13 = "\23067"
                                                                r64 = r3[r34]
                                                                r25 = r28[r64]
                                                                r64 = 0
                                                                r31 = 21592160921414
                                                                r3 = 10
                                                                r28 = r25(r64, r3)
                                                                r9[r39] = r28
                                                                r3 = "\152v\016L\155a"
                                                                r25 = upvalueValues[r29]
                                                                r28 = upvalueValues[r12]
                                                                r74 = 18145487839489
                                                                r64 = r28(r3, r74)
                                                                r34 = "\194\196\250"
                                                                r39 = r25[r64]
                                                                r25 = upvalueValues[r35]
                                                                r28 = "Instance"
                                                                r9[r39] = r25
                                                                r25 = _env[r28]
                                                                r64 = upvalueValues[r29]
                                                                r3 = upvalueValues[r12]
                                                                r46 = 32502328408863
                                                                r74 = r3(r34, r31)
                                                                r28 = r64[r74]
                                                                r31 = 11555730937093
                                                                r39 = r25[r28]
                                                                r34 = "\195\158\246\174t\026\210"
                                                                r64 = upvalueValues[r29]
                                                                r3 = upvalueValues[r12]
                                                                r74 = r3(r34, r31)
                                                                r28 = r64[r74]
                                                                r34 = "\152l\131["
                                                                r31 = 1344435061362
                                                                r25 = r39(r28)
                                                                r39 = allocUpvalue()
                                                                upvalueValues[r39] = r25
                                                                r25 = upvalueValues[r39]
                                                                r64 = upvalueValues[r29]
                                                                r3 = upvalueValues[r12]
                                                                r74 = r3(r34, r31)
                                                                r28 = r64[r74]
                                                                r74 = "UDim2"
                                                                r3 = _env[r74]
                                                                r34 = upvalueValues[r29]
                                                                r31 = upvalueValues[r12]
                                                                r62 = r31(r13, r78)
                                                                r74 = r34[r62]
                                                                r31 = 0
                                                                r34 = 100
                                                                r64 = r3[r74]
                                                                r62 = 30
                                                                r13 = "\245S\143"
                                                                r74 = 0
                                                                r3 = r64(r74, r34, r31, r62)
                                                                r25[r28] = r3
                                                                r25 = upvalueValues[r39]
                                                                r84 = 15945839860993
                                                                r44 = "\137\214\138\148\1979\174~)\147\151\211\240Ib\0070"
                                                                r34 = "|\254\187\127\031d\018\212"
                                                                r78 = 7723336502796
                                                                r42 = nil
                                                                r31 = 21458669823752
                                                                r64 = upvalueValues[r29]
                                                                r3 = upvalueValues[r12]
                                                                r74 = r3(r34, r31)
                                                                r28 = r64[r74]
                                                                r74 = "UDim2"
                                                                r3 = _env[r74]
                                                                r34 = upvalueValues[r29]
                                                                r31 = upvalueValues[r12]
                                                                r62 = r31(r13, r78)
                                                                r31 = 0
                                                                r74 = r34[r62]
                                                                r64 = r3[r74]
                                                                r62 = 50
                                                                r34 = -50
                                                                r74 = 0.5
                                                                r3 = r64(r74, r34, r31, r62)
                                                                r31 = 18719320957452
                                                                r34 = "\2155_\188Jc\127f\240oB\rvoBp"
                                                                r25[r28] = r3
                                                                r25 = upvalueValues[r39]
                                                                r64 = upvalueValues[r29]
                                                                r3 = upvalueValues[r12]
                                                                r74 = r3(r34, r31)
                                                                r28 = r64[r74]
                                                                r74 = "Color3"
                                                                r3 = _env[r74]
                                                                r34 = upvalueValues[r29]
                                                                r31 = upvalueValues[r12]
                                                                r13 = "\132\224\140G\153\198\021"
                                                                r78 = 3297131202047
                                                                r62 = r31(r13, r78)
                                                                r31 = 50
                                                                r74 = r34[r62]
                                                                r34 = 45
                                                                r64 = r3[r74]
                                                                r74 = 45
                                                                r3 = r64(r74, r34, r31)
                                                                r25[r28] = r3
                                                                r25 = upvalueValues[r39]
                                                                r64 = upvalueValues[r29]
                                                                r3 = upvalueValues[r12]
                                                                r34 = "q>\185\195"
                                                                r31 = 7003194920125
                                                                r62 = 22960516458947
                                                                r74 = r3(r34, r31)
                                                                r28 = r64[r74]
                                                                r3 = upvalueValues[r29]
                                                                r31 = ""
                                                                r74 = upvalueValues[r12]
                                                                r34 = r74(r31, r62)
                                                                r31 = 19781685158907
                                                                r64 = r3[r34]
                                                                r34 = "\015_\012\181\006\211\237\2040\203\029\236\182\253\233"
                                                                r25[r28] = r64
                                                                r25 = upvalueValues[r39]
                                                                r64 = upvalueValues[r29]
                                                                r3 = upvalueValues[r12]
                                                                r74 = r3(r34, r31)
                                                                r31 = "\250\023{>\166\185\254\000"
                                                                r28 = r64[r74]
                                                                r3 = upvalueValues[r29]
                                                                r74 = upvalueValues[r12]
                                                                r62 = 6539331537893
                                                                r34 = r74(r31, r62)
                                                                r64 = r3[r34]
                                                                r25[r28] = r64
                                                                r25 = upvalueValues[r39]
                                                                r64 = upvalueValues[r29]
                                                                r31 = 12978582837147
                                                                r3 = upvalueValues[r12]
                                                                r34 = "\220$\221\208\222J\196\027\216y"
                                                                r74 = r3(r34, r31)
                                                                r28 = r64[r74]
                                                                r13 = "4\148\003x\187R@"
                                                                r74 = "Color3"
                                                                r3 = _env[r74]
                                                                r34 = upvalueValues[r29]
                                                                r31 = upvalueValues[r12]
                                                                r78 = 30299113781021
                                                                r62 = r31(r13, r78)
                                                                r74 = r34[r62]
                                                                r34 = 200
                                                                r64 = r3[r74]
                                                                r31 = 220
                                                                r74 = 200
                                                                r3 = r64(r74, r34, r31)
                                                                r25[r28] = r3
                                                                r25 = upvalueValues[r39]
                                                                r64 = upvalueValues[r29]
                                                                r34 = "\240\011Z\228/\212\1853"
                                                                r3 = upvalueValues[r12]
                                                                r31 = 9381107159312
                                                                r74 = r3(r34, r31)
                                                                r31 = 25120940109233
                                                                r28 = r64[r74]
                                                                r64 = 12
                                                                r34 = "\129\003\233\215"
                                                                r25[r28] = r64
                                                                r25 = upvalueValues[r39]
                                                                r64 = upvalueValues[r29]
                                                                r3 = upvalueValues[r12]
                                                                r74 = r3(r34, r31)
                                                                r28 = r64[r74]
                                                                r34 = "Enum"
                                                                r74 = _env[r34]
                                                                r31 = upvalueValues[r29]
                                                                r62 = upvalueValues[r12]
                                                                r78 = "\205kXA"
                                                                r13 = r62(r78, r81)
                                                                r34 = r31[r13]
                                                                r3 = r74[r34]
                                                                r13 = "H5b\254\180\211"
                                                                r34 = upvalueValues[r29]
                                                                r31 = upvalueValues[r12]
                                                                r78 = 4736452642973
                                                                r62 = r31(r13, r78)
                                                                r74 = r34[r62]
                                                                r31 = 29321326900565
                                                                r13 = "m\014\185"
                                                                r64 = r3[r74]
                                                                r62 = 2825668625699
                                                                r25[r28] = r64
                                                                r25 = upvalueValues[r39]
                                                                r64 = upvalueValues[r29]
                                                                r34 = "G\016\197hb\163"
                                                                r3 = upvalueValues[r12]
                                                                r74 = r3(r34, r31)
                                                                r28 = r64[r74]
                                                                r31 = "[{\251"
                                                                r64 = r76
                                                                r25[r28] = r64
                                                                r64 = "Instance"
                                                                r28 = _env[r64]
                                                                r3 = upvalueValues[r29]
                                                                r74 = upvalueValues[r12]
                                                                r34 = r74(r31, r62)
                                                                r62 = 10125688754795
                                                                r64 = r3[r34]
                                                                r25 = r28[r64]
                                                                r3 = upvalueValues[r29]
                                                                r31 = "\016x\031\209\002\226\187\164"
                                                                r74 = upvalueValues[r12]
                                                                r34 = r74(r31, r62)
                                                                r64 = r3[r34]
                                                                r28 = r25(r64)
                                                                r64 = upvalueValues[r29]
                                                                r34 = "J\194\022\215@\133\195\199\025`6\149"
                                                                r3 = upvalueValues[r12]
                                                                r31 = 8592417771425
                                                                r74 = r3(r34, r31)
                                                                r25 = r64[r74]
                                                                r74 = "UDim"
                                                                r3 = _env[r74]
                                                                r34 = upvalueValues[r29]
                                                                r31 = upvalueValues[r12]
                                                                r78 = 34331088993906
                                                                r62 = r31(r13, r78)
                                                                r74 = r34[r62]
                                                                r64 = r3[r74]
                                                                r13 = 27778391880327
                                                                r34 = 10
                                                                r31 = 12944541276043
                                                                r74 = 0
                                                                r3 = r64(r74, r34)
                                                                r28[r25] = r3
                                                                r64 = upvalueValues[r29]
                                                                r34 = "\138\160\162\021\146\031"
                                                                r3 = upvalueValues[r12]
                                                                r74 = r3(r34, r31)
                                                                r25 = r64[r74]
                                                                r64 = upvalueValues[r39]
                                                                r3 = "Instance"
                                                                r28[r25] = r64
                                                                r64 = _env[r3]
                                                                r74 = upvalueValues[r29]
                                                                r34 = upvalueValues[r12]
                                                                r62 = "\217z\134"
                                                                r31 = r34(r62, r13)
                                                                r3 = r74[r31]
                                                                r62 = "?\129\146\030\015V\183Y\031\194"
                                                                r25 = r64[r3]
                                                                r74 = upvalueValues[r29]
                                                                r13 = 14019087260032
                                                                r34 = upvalueValues[r12]
                                                                r31 = r34(r62, r13)
                                                                r62 = 905490235813
                                                                r3 = r74[r31]
                                                                r64 = r25(r3)
                                                                r3 = upvalueValues[r29]
                                                                r74 = upvalueValues[r12]
                                                                r31 = "\240\208\170c"
                                                                r34 = r74(r31, r62)
                                                                r25 = r3[r34]
                                                                r34 = "UDim2"
                                                                r74 = _env[r34]
                                                                r31 = upvalueValues[r29]
                                                                r62 = upvalueValues[r12]
                                                                r81 = 11474628875487
                                                                r78 = "gw\241"
                                                                r13 = r62(r78, r81)
                                                                r34 = r31[r13]
                                                                r3 = r74[r34]
                                                                r31 = 100
                                                                r62 = 0
                                                                r34 = 0
                                                                r13 = 35
                                                                r74 = r3(r34, r31, r62, r13)
                                                                r64[r25] = r74
                                                                r31 = "\177\145\150)\244\025\190\189"
                                                                r3 = upvalueValues[r29]
                                                                r74 = upvalueValues[r12]
                                                                r62 = 9188903538870
                                                                r34 = r74(r31, r62)
                                                                r25 = r3[r34]
                                                                r34 = "UDim2"
                                                                r74 = _env[r34]
                                                                r31 = upvalueValues[r29]
                                                                r62 = upvalueValues[r12]
                                                                r78 = "\177\245f"
                                                                r81 = 31375168534802
                                                                r13 = r62(r78, r81)
                                                                r34 = r31[r13]
                                                                r62 = 0
                                                                r13 = 85
                                                                r3 = r74[r34]
                                                                r34 = 0.5
                                                                r31 = -50
                                                                r74 = r3(r34, r31, r62, r13)
                                                                r31 = "\149\206\159k\188\027\207[\196\025\210(/3S!"
                                                                r62 = 29620116714976
                                                                r64[r25] = r74
                                                                r3 = upvalueValues[r29]
                                                                r74 = upvalueValues[r12]
                                                                r34 = r74(r31, r62)
                                                                r25 = r3[r34]
                                                                r58 = "x`\159"
                                                                r10 = 21525358061351
                                                                r16 = "/\170\180"
                                                                r34 = "Color3"
                                                                r74 = _env[r34]
                                                                r81 = 30781064460285
                                                                r26 = nil
                                                                r31 = upvalueValues[r29]
                                                                r62 = upvalueValues[r12]
                                                                r78 = "\250\189\167i\198\171\131"
                                                                r13 = r62(r78, r81)
                                                                r34 = r31[r13]
                                                                r62 = 130
                                                                r3 = r74[r34]
                                                                r34 = 70
                                                                r31 = 90
                                                                r74 = r3(r34, r31, r62)
                                                                r31 = "\165\017\028\213"
                                                                r13 = 30964551792722
                                                                r64[r25] = r74
                                                                r3 = upvalueValues[r29]
                                                                r62 = 7746527383063
                                                                r74 = upvalueValues[r12]
                                                                r34 = r74(r31, r62)
                                                                r62 = "\018\165\248\156{]\242\132j"
                                                                r25 = r3[r34]
                                                                r74 = upvalueValues[r29]
                                                                r34 = upvalueValues[r12]
                                                                r31 = r34(r62, r13)
                                                                r3 = r74[r31]
                                                                r64[r25] = r3
                                                                r31 = "\128^\222\178\131\0300\210\177/"
                                                                r3 = upvalueValues[r29]
                                                                r74 = upvalueValues[r12]
                                                                r62 = 30439602648926
                                                                r34 = r74(r31, r62)
                                                                r25 = r3[r34]
                                                                r34 = "Color3"
                                                                r74 = _env[r34]
                                                                r31 = upvalueValues[r29]
                                                                r62 = upvalueValues[r12]
                                                                r78 = "\018\175\193\002\222\160\208"
                                                                r81 = 29205197206815
                                                                r13 = r62(r78, r81)
                                                                r62 = 255
                                                                r34 = r31[r13]
                                                                r3 = r74[r34]
                                                                r31 = 220
                                                                r34 = 220
                                                                r74 = r3(r34, r31, r62)
                                                                r64[r25] = r74
                                                                r31 = "\141\002\236\132V\"\214["
                                                                r3 = upvalueValues[r29]
                                                                r74 = upvalueValues[r12]
                                                                r62 = 3503516190303
                                                                r34 = r74(r31, r62)
                                                                r25 = r3[r34]
                                                                r62 = 13974551517547
                                                                r3 = 14
                                                                r31 = "\000H\236\014"
                                                                r64[r25] = r3
                                                                r3 = upvalueValues[r29]
                                                                r74 = upvalueValues[r12]
                                                                r34 = r74(r31, r62)
                                                                r31 = "Enum"
                                                                r25 = r3[r34]
                                                                r34 = _env[r31]
                                                                r62 = upvalueValues[r29]
                                                                r13 = upvalueValues[r12]
                                                                r81 = "\180\180>]"
                                                                r78 = r13(r81, r46)
                                                                r31 = r62[r78]
                                                                r74 = r34[r31]
                                                                r31 = upvalueValues[r29]
                                                                r62 = upvalueValues[r12]
                                                                r78 = "\171l\228\250\008\236"
                                                                r81 = 10506711110428
                                                                r13 = r62(r78, r81)
                                                                r34 = r31[r13]
                                                                r3 = r74[r34]
                                                                r64[r25] = r3
                                                                r3 = upvalueValues[r29]
                                                                r74 = upvalueValues[r12]
                                                                r13 = "I\204\215"
                                                                r62 = 1750695871279
                                                                r31 = "\162\249t\195}\226"
                                                                r46 = 12214383154743
                                                                r34 = r74(r31, r62)
                                                                r25 = r3[r34]
                                                                r3 = r76
                                                                r64[r25] = r3
                                                                r74 = "Instance"
                                                                r3 = _env[r74]
                                                                r34 = upvalueValues[r29]
                                                                r31 = upvalueValues[r12]
                                                                r78 = 17099641462554
                                                                r62 = r31(r13, r78)
                                                                r74 = r34[r62]
                                                                r25 = r3[r74]
                                                                r81 = ".1\225"
                                                                r71 = "\161y\229\006\220\137\018"
                                                                r36 = 23892274441077
                                                                r13 = "\183\164\2445\190\240\231\002"
                                                                r34 = upvalueValues[r29]
                                                                r31 = upvalueValues[r12]
                                                                r78 = 17046042664705
                                                                r62 = r31(r13, r78)
                                                                r56 = nil
                                                                r13 = 14729278708426
                                                                r74 = r34[r62]
                                                                r3 = r25(r74)
                                                                r74 = upvalueValues[r29]
                                                                r62 = "\166\021jWF\223l\014:\011\189M"
                                                                r34 = upvalueValues[r12]
                                                                r31 = r34(r62, r13)
                                                                r25 = r74[r31]
                                                                r31 = "UDim"
                                                                r34 = _env[r31]
                                                                r62 = upvalueValues[r29]
                                                                r13 = upvalueValues[r12]
                                                                r78 = r13(r81, r46)
                                                                r31 = r62[r78]
                                                                r62 = 10
                                                                r74 = r34[r31]
                                                                r31 = 0
                                                                r34 = r74(r31, r62)
                                                                r46 = 18699689435651
                                                                r3[r25] = r34
                                                                r74 = upvalueValues[r29]
                                                                r34 = upvalueValues[r12]
                                                                r62 = "\134z\0263\138i"
                                                                r13 = 26427149824018
                                                                r31 = r34(r62, r13)
                                                                r25 = r74[r31]
                                                                r74 = r64
                                                                r3[r25] = r74
                                                                r74 = upvalueValues[r7]
                                                                r31 = upvalueValues[r29]
                                                                r62 = upvalueValues[r12]
                                                                r81 = 4665846728828
                                                                r78 = "\140\195\184\193:X\158>"
                                                                r13 = r62(r78, r81)
                                                                r34 = r31[r13]
                                                                r31 = "Instance"
                                                                r25 = r74[r34]
                                                                r34 = _env[r31]
                                                                r62 = upvalueValues[r29]
                                                                r13 = upvalueValues[r12]
                                                                r81 = "\210\217\028"
                                                                r78 = r13(r81, r46)
                                                                r31 = r62[r78]
                                                                r74 = r34[r31]
                                                                r81 = "D\246?\\\207M\251"
                                                                r62 = upvalueValues[r29]
                                                                r51 = nil
                                                                r13 = upvalueValues[r12]
                                                                r46 = 31163602466991
                                                                r78 = r13(r81, r46)
                                                                r31 = r62[r78]
                                                                r34 = r74(r31)
                                                                r24 = nil
                                                                r74 = allocUpvalue()
                                                                upvalueValues[r74] = r34
                                                                r46 = 33987173629394
                                                                r34 = upvalueValues[r74]
                                                                r62 = upvalueValues[r29]
                                                                r13 = upvalueValues[r12]
                                                                r81 = "\142\020}\161"
                                                                r78 = r13(r81, r46)
                                                                r31 = r62[r78]
                                                                r78 = "UDim2"
                                                                r13 = _env[r78]
                                                                r81 = upvalueValues[r29]
                                                                r46 = upvalueValues[r12]
                                                                r49 = r46(r58, r10)
                                                                r78 = r81[r49]
                                                                r46 = 0
                                                                r62 = r13[r78]
                                                                r49 = 30
                                                                r78 = 0
                                                                r81 = 100
                                                                r13 = r62(r78, r81, r46, r49)
                                                                r34[r31] = r13
                                                                r34 = upvalueValues[r74]
                                                                r58 = "e}\014"
                                                                r10 = 7395219295603
                                                                r81 = "\236\198Q8\223\018=\211"
                                                                r3 = nil
                                                                r62 = upvalueValues[r29]
                                                                r13 = upvalueValues[r12]
                                                                r46 = 6104919116570
                                                                r78 = r13(r81, r46)
                                                                r31 = r62[r78]
                                                                r78 = "UDim2"
                                                                r13 = _env[r78]
                                                                r81 = upvalueValues[r29]
                                                                r46 = upvalueValues[r12]
                                                                r49 = r46(r58, r10)
                                                                r78 = r81[r49]
                                                                r62 = r13[r78]
                                                                r81 = -50
                                                                r46 = 0
                                                                r49 = 10
                                                                r78 = 0.5
                                                                r13 = r62(r78, r81, r46, r49)
                                                                r34[r31] = r13
                                                                r34 = upvalueValues[r74]
                                                                r46 = 20672074950042
                                                                r62 = upvalueValues[r29]
                                                                r13 = upvalueValues[r12]
                                                                r81 = "\214b\206\172\199\203\001\000\147\012\231\164\205\156\161\152"
                                                                r78 = r13(r81, r46)
                                                                r31 = r62[r78]
                                                                r78 = "Color3"
                                                                r13 = _env[r78]
                                                                r81 = upvalueValues[r29]
                                                                r46 = upvalueValues[r12]
                                                                r58 = " \145\166+$\250D"
                                                                r10 = 19049460392614
                                                                r49 = r46(r58, r10)
                                                                r78 = r81[r49]
                                                                r62 = r13[r78]
                                                                r46 = 50
                                                                r81 = 45
                                                                r78 = 45
                                                                r13 = r62(r78, r81, r46)
                                                                r34[r31] = r13
                                                                r34 = upvalueValues[r74]
                                                                r57 = nil
                                                                r62 = upvalueValues[r29]
                                                                r13 = upvalueValues[r12]
                                                                r46 = 35173611175930
                                                                r81 = "\187\138\164\241"
                                                                r78 = r13(r81, r46)
                                                                r31 = r62[r78]
                                                                r13 = upvalueValues[r29]
                                                                r46 = ""
                                                                r78 = upvalueValues[r12]
                                                                r49 = 34691162226458
                                                                r81 = r78(r46, r49)
                                                                r62 = r13[r81]
                                                                r34[r31] = r62
                                                                r34 = upvalueValues[r74]
                                                                r62 = upvalueValues[r29]
                                                                r46 = 19954950628428
                                                                r13 = upvalueValues[r12]
                                                                r81 = "v\178\221T\191\205~_\250 O\031\198\003\213"
                                                                r78 = r13(r81, r46)
                                                                r31 = r62[r78]
                                                                r13 = upvalueValues[r29]
                                                                r46 = "\234\017\169\219%9n\158\130W"
                                                                r78 = upvalueValues[r12]
                                                                r49 = 11463867962586
                                                                r81 = r78(r46, r49)
                                                                r62 = r13[r81]
                                                                r46 = 8695693660113
                                                                r34[r31] = r62
                                                                r34 = upvalueValues[r74]
                                                                r62 = upvalueValues[r29]
                                                                r13 = upvalueValues[r12]
                                                                r81 = "\003S\165f\229\211\171\005\212\018"
                                                                r78 = r13(r81, r46)
                                                                r31 = r62[r78]
                                                                r78 = "Color3"
                                                                r13 = _env[r78]
                                                                r81 = upvalueValues[r29]
                                                                r46 = upvalueValues[r12]
                                                                r10 = 16145747058014
                                                                r58 = "!\004\025\129\236?\222"
                                                                r49 = r46(r58, r10)
                                                                r78 = r81[r49]
                                                                r62 = r13[r78]
                                                                r46 = 220
                                                                r81 = 200
                                                                r78 = 200
                                                                r13 = r62(r78, r81, r46)
                                                                r46 = 5899612572347
                                                                r34[r31] = r13
                                                                r34 = upvalueValues[r74]
                                                                r62 = upvalueValues[r29]
                                                                r13 = upvalueValues[r12]
                                                                r81 = "\027#]\221^\222\190\001"
                                                                r78 = r13(r81, r46)
                                                                r31 = r62[r78]
                                                                r62 = 12
                                                                r34[r31] = r62
                                                                r46 = 4292386015182
                                                                r34 = upvalueValues[r74]
                                                                r62 = upvalueValues[r29]
                                                                r13 = upvalueValues[r12]
                                                                r81 = "g\004'\165"
                                                                r78 = r13(r81, r46)
                                                                r31 = r62[r78]
                                                                r81 = "Enum"
                                                                r78 = _env[r81]
                                                                r46 = upvalueValues[r29]
                                                                r49 = upvalueValues[r12]
                                                                r10 = "\139\129\177w"
                                                                r58 = r49(r10, r36)
                                                                r81 = r46[r58]
                                                                r13 = r78[r81]
                                                                r81 = upvalueValues[r29]
                                                                r46 = upvalueValues[r12]
                                                                r10 = 1679792259854
                                                                r58 = "\231\144S\222\254\183"
                                                                r49 = r46(r58, r10)
                                                                r78 = r81[r49]
                                                                r62 = r13[r78]
                                                                r46 = 34731988680493
                                                                r34[r31] = r62
                                                                r34 = upvalueValues[r74]
                                                                r72 = 10521878074147
                                                                r81 = "6E\154\151\160\028"
                                                                r37 = nil
                                                                r62 = upvalueValues[r29]
                                                                r13 = upvalueValues[r12]
                                                                r78 = r13(r81, r46)
                                                                r31 = r62[r78]
                                                                r62 = r25
                                                                r34[r31] = r62
                                                                r62 = "Instance"
                                                                r46 = "k$\161"
                                                                r31 = _env[r62]
                                                                r13 = upvalueValues[r29]
                                                                r78 = upvalueValues[r12]
                                                                r49 = 17913099542677
                                                                r81 = r78(r46, r49)
                                                                r62 = r13[r81]
                                                                r46 = "\t\178\235\238\229m\150\002"
                                                                r34 = r31[r62]
                                                                r13 = upvalueValues[r29]
                                                                r78 = upvalueValues[r12]
                                                                r49 = 5183308466541
                                                                r81 = r78(r46, r49)
                                                                r62 = r13[r81]
                                                                r31 = r34(r62)
                                                                r46 = 13522168092824
                                                                r62 = upvalueValues[r29]
                                                                r13 = upvalueValues[r12]
                                                                r81 = "\196:\022\159%\144:\1509p1)"
                                                                r78 = r13(r81, r46)
                                                                r34 = r62[r78]
                                                                r78 = "UDim"
                                                                r13 = _env[r78]
                                                                r81 = upvalueValues[r29]
                                                                r46 = upvalueValues[r12]
                                                                r10 = 15231055846324
                                                                r58 = "\029t\218"
                                                                r49 = r46(r58, r10)
                                                                r78 = r81[r49]
                                                                r62 = r13[r78]
                                                                r78 = 0
                                                                r81 = 10
                                                                r13 = r62(r78, r81)
                                                                r31[r34] = r13
                                                                r62 = upvalueValues[r29]
                                                                r46 = 15690019576970
                                                                r13 = upvalueValues[r12]
                                                                r81 = "\024\224N\183#\192"
                                                                r78 = r13(r81, r46)
                                                                r34 = r62[r78]
                                                                r62 = upvalueValues[r74]
                                                                r31[r34] = r62
                                                                r67 = 17465405218756
                                                                r13 = "Instance"
                                                                r62 = _env[r13]
                                                                r78 = upvalueValues[r29]
                                                                r81 = upvalueValues[r12]
                                                                r49 = "T\205D"
                                                                r58 = 15272863964103
                                                                r46 = r81(r49, r58)
                                                                r13 = r78[r46]
                                                                r34 = r62[r13]
                                                                r78 = upvalueValues[r29]
                                                                r81 = upvalueValues[r12]
                                                                r58 = 32330697325263
                                                                r49 = "\189D?\171\236\211\tE|\031"
                                                                r46 = r81(r49, r58)
                                                                r13 = r78[r46]
                                                                r46 = "g\001\143\200"
                                                                r62 = r34(r13)
                                                                r13 = upvalueValues[r29]
                                                                r78 = upvalueValues[r12]
                                                                r49 = 32736062241675
                                                                r81 = r78(r46, r49)
                                                                r34 = r13[r81]
                                                                r81 = "UDim2"
                                                                r78 = _env[r81]
                                                                r46 = upvalueValues[r29]
                                                                r49 = upvalueValues[r12]
                                                                r10 = "\025'^"
                                                                r36 = 30002142672530
                                                                r58 = r49(r10, r36)
                                                                r81 = r46[r58]
                                                                r13 = r78[r81]
                                                                r46 = 100
                                                                r58 = 35
                                                                r49 = 0
                                                                r81 = 0
                                                                r78 = r13(r81, r46, r49, r58)
                                                                r62[r34] = r78
                                                                r36 = 23978839960478
                                                                r69 = 22609394624800
                                                                r46 = "\168\172\187<Q\195\014\190"
                                                                r13 = upvalueValues[r29]
                                                                r9 = nil
                                                                r78 = upvalueValues[r12]
                                                                r49 = 9360708374790
                                                                r81 = r78(r46, r49)
                                                                r34 = r13[r81]
                                                                r81 = "UDim2"
                                                                r78 = _env[r81]
                                                                r46 = upvalueValues[r29]
                                                                r49 = upvalueValues[r12]
                                                                r10 = "\255Tr"
                                                                r58 = r49(r10, r36)
                                                                r81 = r46[r58]
                                                                r13 = r78[r81]
                                                                r49 = 0
                                                                r10 = "\144^\137\183_\252A"
                                                                r58 = 45
                                                                r11 = nil
                                                                r46 = -50
                                                                r81 = 0.5
                                                                r78 = r13(r81, r46, r49, r58)
                                                                r62[r34] = r78
                                                                r46 = "{\175\146\2114e\018\186f\1980\255\171\165=\008"
                                                                r13 = upvalueValues[r29]
                                                                r78 = upvalueValues[r12]
                                                                r49 = 34667989401359
                                                                r81 = r78(r46, r49)
                                                                r34 = r13[r81]
                                                                r81 = "Color3"
                                                                r78 = _env[r81]
                                                                r46 = upvalueValues[r29]
                                                                r49 = upvalueValues[r12]
                                                                r36 = 28060397810442
                                                                r58 = r49(r10, r36)
                                                                r81 = r46[r58]
                                                                r13 = r78[r81]
                                                                r46 = 70
                                                                r49 = 130
                                                                r81 = 100
                                                                r78 = r13(r81, r46, r49)
                                                                r62[r34] = r78
                                                                r46 = "GE\"\171"
                                                                r13 = upvalueValues[r29]
                                                                r78 = upvalueValues[r12]
                                                                r49 = 19958070322253
                                                                r81 = r78(r46, r49)
                                                                r34 = r13[r81]
                                                                r78 = upvalueValues[r29]
                                                                r81 = upvalueValues[r12]
                                                                r49 = "U2\194\179`\184\151\179G\226\220"
                                                                r58 = 33470790925538
                                                                r46 = r81(r49, r58)
                                                                r13 = r78[r46]
                                                                r62[r34] = r13
                                                                r36 = 26062989438824
                                                                r10 = "\191\167\176[\ra#"
                                                                r46 = "\180\176jth\217\199\208\153\024"
                                                                r13 = upvalueValues[r29]
                                                                r78 = upvalueValues[r12]
                                                                r49 = 14401383766578
                                                                r81 = r78(r46, r49)
                                                                r34 = r13[r81]
                                                                r81 = "Color3"
                                                                r78 = _env[r81]
                                                                r14 = nil
                                                                r46 = upvalueValues[r29]
                                                                r49 = upvalueValues[r12]
                                                                r58 = r49(r10, r36)
                                                                r81 = r46[r58]
                                                                r46 = 200
                                                                r13 = r78[r81]
                                                                r49 = 255
                                                                r81 = 220
                                                                r78 = r13(r81, r46, r49)
                                                                r62[r34] = r78
                                                                r13 = upvalueValues[r29]
                                                                r78 = upvalueValues[r12]
                                                                r46 = ")\161\240\187\018\231`\175"
                                                                r49 = 5681638132309
                                                                r81 = r78(r46, r49)
                                                                r34 = r13[r81]
                                                                r13 = 14
                                                                r46 = "\187\008\142\238"
                                                                r62[r34] = r13
                                                                r13 = upvalueValues[r29]
                                                                r78 = upvalueValues[r12]
                                                                r49 = 35073458733004
                                                                r81 = r78(r46, r49)
                                                                r46 = "Enum"
                                                                r34 = r13[r81]
                                                                r81 = _env[r46]
                                                                r49 = upvalueValues[r29]
                                                                r58 = upvalueValues[r12]
                                                                r36 = "k\217\160\136"
                                                                r10 = r58(r36, r22)
                                                                r36 = 5670877203024
                                                                r53 = nil
                                                                r46 = r49[r10]
                                                                r76 = nil
                                                                r78 = r81[r46]
                                                                r46 = upvalueValues[r29]
                                                                r49 = upvalueValues[r12]
                                                                r10 = "\026{\183\210\211\133"
                                                                r58 = r49(r10, r36)
                                                                r81 = r46[r58]
                                                                r46 = "\242\202w\234\189\158"
                                                                r13 = r78[r81]
                                                                r62[r34] = r13
                                                                r13 = upvalueValues[r29]
                                                                r78 = upvalueValues[r12]
                                                                r49 = 34580248854246
                                                                r81 = r78(r46, r49)
                                                                r34 = r13[r81]
                                                                r13 = r25
                                                                r62[r34] = r13
                                                                r78 = "Instance"
                                                                r13 = _env[r78]
                                                                r81 = upvalueValues[r29]
                                                                r46 = upvalueValues[r12]
                                                                r10 = 29883028354651
                                                                r58 = "\131\205\028"
                                                                r49 = r46(r58, r10)
                                                                r78 = r81[r49]
                                                                r34 = r13[r78]
                                                                r81 = upvalueValues[r29]
                                                                r46 = upvalueValues[r12]
                                                                r10 = 17134745165610
                                                                r58 = "\185Q]\255\222\174\162o"
                                                                r49 = r46(r58, r10)
                                                                r78 = r81[r49]
                                                                r13 = r34(r78)
                                                                r78 = upvalueValues[r29]
                                                                r81 = upvalueValues[r12]
                                                                r49 = "0\018\133Y\213\250\023]\132\131\187r"
                                                                r58 = 8091570409143
                                                                r46 = r81(r49, r58)
                                                                r34 = r78[r46]
                                                                r46 = "UDim"
                                                                r81 = _env[r46]
                                                                r49 = upvalueValues[r29]
                                                                r58 = upvalueValues[r12]
                                                                r36 = "\224\001\018"
                                                                r22 = 10844403323833
                                                                r10 = r58(r36, r22)
                                                                r46 = r49[r10]
                                                                r78 = r81[r46]
                                                                r46 = 0
                                                                r49 = 10
                                                                r81 = r78(r46, r49)
                                                                r13[r34] = r81
                                                                r78 = upvalueValues[r29]
                                                                r81 = upvalueValues[r12]
                                                                r49 = "\201F\242u\244v"
                                                                r58 = 23034357754342
                                                                r46 = r81(r49, r58)
                                                                r34 = r78[r46]
                                                                r78 = r62
                                                                r13[r34] = r78
                                                                r78 = upvalueValues[r7]
                                                                r46 = upvalueValues[r29]
                                                                r49 = upvalueValues[r12]
                                                                r36 = 12383956424326
                                                                r10 = "\1987\147\187\172B)\207\129\184\142D"
                                                                r58 = r49(r10, r36)
                                                                r81 = r46[r58]
                                                                r46 = "Instance"
                                                                r34 = r78[r81]
                                                                r81 = _env[r46]
                                                                r49 = upvalueValues[r29]
                                                                r58 = upvalueValues[r12]
                                                                r36 = "\149>\191"
                                                                r22 = 34736677764911
                                                                r10 = r58(r36, r22)
                                                                r46 = r49[r10]
                                                                r78 = r81[r46]
                                                                r49 = upvalueValues[r29]
                                                                r58 = upvalueValues[r12]
                                                                r36 = "\233\226\146.\136\208#\022\230\241"
                                                                r22 = 24714150014196
                                                                r10 = r58(r36, r22)
                                                                r46 = r49[r10]
                                                                r81 = r78(r46)
                                                                r78 = allocUpvalue()
                                                                upvalueValues[r78] = r81
                                                                r81 = upvalueValues[r78]
                                                                r49 = upvalueValues[r29]
                                                                r58 = upvalueValues[r12]
                                                                r22 = 11931572999604
                                                                r36 = "\016U[\166"
                                                                r10 = r58(r36, r22)
                                                                r46 = r49[r10]
                                                                r10 = "UDim2"
                                                                r58 = _env[r10]
                                                                r36 = upvalueValues[r29]
                                                                r22 = upvalueValues[r12]
                                                                r20 = r22(r16, r67)
                                                                r10 = r36[r20]
                                                                r49 = r58[r10]
                                                                r20 = 35
                                                                r36 = 100
                                                                r22 = 0
                                                                r10 = 0
                                                                r58 = r49(r10, r36, r22, r20)
                                                                r81[r46] = r58
                                                                r81 = upvalueValues[r78]
                                                                r49 = upvalueValues[r29]
                                                                r58 = upvalueValues[r12]
                                                                r22 = 29897458480738
                                                                r36 = "\173\1971\242\161h\240]"
                                                                r10 = r58(r36, r22)
                                                                r46 = r49[r10]
                                                                r10 = "UDim2"
                                                                r58 = _env[r10]
                                                                r36 = upvalueValues[r29]
                                                                r22 = upvalueValues[r12]
                                                                r67 = 25453741092428
                                                                r16 = "t\160\007"
                                                                r20 = r22(r16, r67)
                                                                r10 = r36[r20]
                                                                r49 = r58[r10]
                                                                r36 = -50
                                                                r10 = 0.5
                                                                r22 = 0
                                                                r20 = 10
                                                                r58 = r49(r10, r36, r22, r20)
                                                                r81[r46] = r58
                                                                r81 = upvalueValues[r78]
                                                                r49 = upvalueValues[r29]
                                                                r58 = upvalueValues[r12]
                                                                r36 = "8@\244\138\168\135\008\223\202AL\185\021\157\211\011"
                                                                r22 = 32696461065081
                                                                r10 = r58(r36, r22)
                                                                r46 = r49[r10]
                                                                r10 = "Color3"
                                                                r58 = _env[r10]
                                                                r36 = upvalueValues[r29]
                                                                r22 = upvalueValues[r12]
                                                                r16 = "zREu\199\198\222"
                                                                r67 = 10403105968876
                                                                r20 = r22(r16, r67)
                                                                r10 = r36[r20]
                                                                r49 = r58[r10]
                                                                r22 = 50
                                                                r36 = 150
                                                                r10 = 50
                                                                r58 = r49(r10, r36, r22)
                                                                r81[r46] = r58
                                                                r81 = upvalueValues[r78]
                                                                r49 = upvalueValues[r29]
                                                                r58 = upvalueValues[r12]
                                                                r36 = "l\007\167\207"
                                                                r22 = 5542232951316
                                                                r10 = r58(r36, r22)
                                                                r46 = r49[r10]
                                                                r58 = upvalueValues[r29]
                                                                r10 = upvalueValues[r12]
                                                                r22 = "h\132\181\205:\253Aa\230\018\163\229\196\211\172\212"
                                                                r20 = 29842786285128
                                                                r36 = r10(r22, r20)
                                                                r49 = r58[r36]
                                                                r81[r46] = r49
                                                                r81 = upvalueValues[r78]
                                                                r49 = upvalueValues[r29]
                                                                r58 = upvalueValues[r12]
                                                                r36 = "\165\014+\226\230Wb\247\\\029"
                                                                r22 = 7954796105336
                                                                r10 = r58(r36, r22)
                                                                r46 = r49[r10]
                                                                r10 = "Color3"
                                                                r58 = _env[r10]
                                                                r36 = upvalueValues[r29]
                                                                r22 = upvalueValues[r12]
                                                                r16 = "\242?\\\202}\029\236"
                                                                r67 = 360003535015
                                                                r20 = r22(r16, r67)
                                                                r10 = r36[r20]
                                                                r49 = r58[r10]
                                                                r22 = 220
                                                                r10 = 220
                                                                r36 = 255
                                                                r58 = r49(r10, r36, r22)
                                                                r81[r46] = r58
                                                                r81 = upvalueValues[r78]
                                                                r59 = 28012257309428
                                                                r80 = "\2491\030Kb\231\187\131Rx\145\201\2342\220&J"
                                                                r49 = upvalueValues[r29]
                                                                r58 = upvalueValues[r12]
                                                                r8 = nil
                                                                r36 = "}\128\150\151\144a\208)"
                                                                r22 = 4019122554703
                                                                r10 = r58(r36, r22)
                                                                r46 = r49[r10]
                                                                r49 = 14
                                                                r81[r46] = r49
                                                                r81 = upvalueValues[r78]
                                                                r49 = upvalueValues[r29]
                                                                r58 = upvalueValues[r12]
                                                                r22 = 31933636082198
                                                                r36 = "+\195a@"
                                                                r10 = r58(r36, r22)
                                                                r46 = r49[r10]
                                                                r36 = "Enum"
                                                                r10 = _env[r36]
                                                                r22 = upvalueValues[r29]
                                                                r20 = upvalueValues[r12]
                                                                r67 = "\238\130\232\255"
                                                                r16 = r20(r67, r77)
                                                                r36 = r22[r16]
                                                                r58 = r10[r36]
                                                                r36 = upvalueValues[r29]
                                                                r22 = upvalueValues[r12]
                                                                r67 = 32079520365146
                                                                r16 = "\004\225fN\153|"
                                                                r20 = r22(r16, r67)
                                                                r10 = r36[r20]
                                                                r49 = r58[r10]
                                                                r81[r46] = r49
                                                                r81 = upvalueValues[r78]
                                                                r49 = upvalueValues[r29]
                                                                r58 = upvalueValues[r12]
                                                                r36 = "\211 YM\170\129"
                                                                r22 = 16707334299235
                                                                r10 = r58(r36, r22)
                                                                r46 = r49[r10]
                                                                r49 = r34
                                                                r81[r46] = r49
                                                                r16 = "\219\005\021"
                                                                r15 = "\244\r\189\170\002\194pl\\v\212"
                                                                r67 = 3811677800174
                                                                r49 = "Instance"
                                                                r46 = _env[r49]
                                                                r58 = upvalueValues[r29]
                                                                r10 = upvalueValues[r12]
                                                                r20 = 33314411773081
                                                                r22 = "\178\012\137"
                                                                r36 = r10(r22, r20)
                                                                r49 = r58[r36]
                                                                r81 = r46[r49]
                                                                r58 = upvalueValues[r29]
                                                                r10 = upvalueValues[r12]
                                                                r20 = 11296532042892
                                                                r22 = "\141s{\011\145\224n\028"
                                                                r36 = r10(r22, r20)
                                                                r49 = r58[r36]
                                                                r36 = "\155w\147\194T\206<\219\214#\200\249"
                                                                r34 = nil
                                                                r46 = r81(r49)
                                                                r49 = upvalueValues[r29]
                                                                r58 = upvalueValues[r12]
                                                                r22 = 7585951649228
                                                                r10 = r58(r36, r22)
                                                                r81 = r49[r10]
                                                                r10 = "UDim"
                                                                r58 = _env[r10]
                                                                r36 = upvalueValues[r29]
                                                                r22 = upvalueValues[r12]
                                                                r20 = r22(r16, r67)
                                                                r10 = r36[r20]
                                                                r49 = r58[r10]
                                                                r36 = 10
                                                                r10 = 0
                                                                r58 = r49(r10, r36)
                                                                r46[r81] = r58
                                                                r16 = "\188\016\186"
                                                                r36 = "\181Y~\132\212&"
                                                                r20 = 17514029375451
                                                                r49 = upvalueValues[r29]
                                                                r58 = upvalueValues[r12]
                                                                r22 = 11185618670680
                                                                r25 = nil
                                                                r10 = r58(r36, r22)
                                                                r81 = r49[r10]
                                                                r49 = upvalueValues[r78]
                                                                r46[r81] = r49
                                                                r58 = upvalueValues[r29]
                                                                r10 = upvalueValues[r12]
                                                                r22 = "\175\205s\160\214\254\137\202h\194V\200\181\168\t\249\188"
                                                                r36 = r10(r22, r20)
                                                                r49 = r58[r36]
                                                                r58 = createClosure3(72, {
                                                                    r82,
                                                                    r29,
                                                                    r12
                                                                })
                                                                r81 = r75[r49]
                                                                r67 = 23057088965104
                                                                r49 = "Connect"
                                                                r85 = nil
                                                                r49 = r81[r49]
                                                                r49 = r49(r81, r58)
                                                                r58 = upvalueValues[r29]
                                                                r10 = upvalueValues[r12]
                                                                r22 = "\127\138\203\219$\031\186\006\243\203\217\014\029!\189\183\n"
                                                                r20 = 10581495419711
                                                                r36 = r10(r22, r20)
                                                                r49 = r58[r36]
                                                                r81 = r61[r49]
                                                                r58 = createClosure5(73, {
                                                                    r2,
                                                                    r29,
                                                                    r12,
                                                                    r70,
                                                                    r45,
                                                                    r40,
                                                                    r82
                                                                })
                                                                r49 = "Connect"
                                                                r49 = r81[r49]
                                                                r49 = r49(r81, r58)
                                                                r49 = allocUpvalue()
                                                                r81 = false
                                                                upvalueValues[r49] = r81
                                                                r10 = "TweenInfo"
                                                                r58 = _env[r10]
                                                                r36 = upvalueValues[r29]
                                                                r22 = upvalueValues[r12]
                                                                r20 = r22(r16, r67)
                                                                r10 = r36[r20]
                                                                r81 = r58[r10]
                                                                r16 = "Enum"
                                                                r20 = _env[r16]
                                                                r67 = upvalueValues[r29]
                                                                r77 = upvalueValues[r12]
                                                                r68 = 14467285834320
                                                                r17 = r77(r15, r68)
                                                                r16 = r67[r17]
                                                                r22 = r20[r16]
                                                                r16 = upvalueValues[r29]
                                                                r67 = upvalueValues[r12]
                                                                r15 = 31057022253182
                                                                r17 = "\149\220$C"
                                                                r77 = r67(r17, r15)
                                                                r20 = r16[r77]
                                                                r36 = r22[r20]
                                                                r10 = 0.2
                                                                r67 = "Enum"
                                                                r16 = _env[r67]
                                                                r68 = "\220R!\218U3\167'\151\187\231\150UM\229"
                                                                r77 = upvalueValues[r29]
                                                                r17 = upvalueValues[r12]
                                                                r65 = nil
                                                                r15 = r17(r68, r69)
                                                                r67 = r77[r15]
                                                                r20 = r16[r67]
                                                                r67 = upvalueValues[r29]
                                                                r77 = upvalueValues[r12]
                                                                r68 = 3997063743301
                                                                r15 = "IE\246\233/"
                                                                r17 = r77(r15, r68)
                                                                r16 = r67[r17]
                                                                r22 = r20[r16]
                                                                r67 = "\185\015\211\210\132R\196h\178\193\149\t\243\210\224\187I"
                                                                r77 = 7804223163954
                                                                r50 = nil
                                                                r58 = r81(r10, r36, r22)
                                                                r81 = allocUpvalue()
                                                                upvalueValues[r81] = r58
                                                                r10 = upvalueValues[r63]
                                                                r22 = upvalueValues[r29]
                                                                r20 = upvalueValues[r12]
                                                                r16 = r20(r67, r77)
                                                                r36 = r22[r16]
                                                                r58 = r10[r36]
                                                                r36 = createClosure4(77, {
                                                                    r49,
                                                                    r21,
                                                                    r48,
                                                                    r81,
                                                                    r29,
                                                                    r12,
                                                                    r63,
                                                                    r41,
                                                                    r52
                                                                })
                                                                r10 = "Connect"
                                                                r10 = r58[r10]
                                                                r10 = r10(r58, r36)
                                                                r36 = upvalueValues[r29]
                                                                r22 = upvalueValues[r12]
                                                                r49 = releaseUpvalue(r49)
                                                                r67 = 1949489152907
                                                                r16 = "\155\n/4\148I\251\246\180\188\217\017[\227\225=\198"
                                                                r20 = r22(r16, r67)
                                                                r10 = r36[r20]
                                                                r58 = r1[r10]
                                                                r36 = createClosure0(81, {
                                                                    r21,
                                                                    r48,
                                                                    r81,
                                                                    r29,
                                                                    r12,
                                                                    r40
                                                                })
                                                                r21 = releaseUpvalue(r21)
                                                                r10 = "Connect"
                                                                r10 = r58[r10]
                                                                r10 = r10(r58, r36)
                                                                r20 = allocUpvalue()
                                                                r58 = nil
                                                                upvalueValues[r20] = r58
                                                                r58 = allocUpvalue()
                                                                r10 = nil
                                                                upvalueValues[r58] = r10
                                                                r10 = allocUpvalue()
                                                                r36 = nil
                                                                upvalueValues[r10] = r36
                                                                r36 = allocUpvalue()
                                                                r22 = nil
                                                                upvalueValues[r36] = r22
                                                                r40 = releaseUpvalue(r40)
                                                                r67 = upvalueValues[r29]
                                                                r77 = upvalueValues[r12]
                                                                r15 = "\234\175Y\235ct\026\226\005\229"
                                                                r68 = 7950684458614
                                                                r17 = r77(r15, r68)
                                                                r16 = r67[r17]
                                                                r67 = createClosure4(95, {
                                                                    r29,
                                                                    r12,
                                                                    r20,
                                                                    r10,
                                                                    r48,
                                                                    r36
                                                                })
                                                                r22 = r30[r16]
                                                                r16 = "Connect"
                                                                r16 = r22[r16]
                                                                r15 = "\187\163\166\135\214\195LdF\193\236\190"
                                                                r60 = nil
                                                                r16 = r16(r22, r67)
                                                                r67 = upvalueValues[r29]
                                                                r77 = upvalueValues[r12]
                                                                r68 = 28665402176548
                                                                r17 = r77(r15, r68)
                                                                r16 = r67[r17]
                                                                r67 = createClosure2(100, {
                                                                    r29,
                                                                    r12,
                                                                    r58
                                                                })
                                                                r22 = r30[r16]
                                                                r16 = "Connect"
                                                                r16 = r22[r16]
                                                                r16 = r16(r22, r67)
                                                                r67 = upvalueValues[r29]
                                                                r77 = upvalueValues[r12]
                                                                r15 = "\157\018\182\174\178\239\131\153\011e\170u"
                                                                r68 = 215394353252
                                                                r17 = r77(r15, r68)
                                                                r16 = r67[r17]
                                                                r22 = r6[r16]
                                                                r28 = nil
                                                                r67 = createClosure5(105, {
                                                                    r58,
                                                                    r20,
                                                                    r29,
                                                                    r12,
                                                                    r10,
                                                                    r48,
                                                                    r36
                                                                })
                                                                r16 = "Connect"
                                                                r16 = r22[r16]
                                                                r16 = r16(r22, r67)
                                                                r16 = allocUpvalue()
                                                                r58 = releaseUpvalue(r58)
                                                                r67 = createClosure2(110, {
                                                                    r82,
                                                                    r29,
                                                                    r12
                                                                })
                                                                r22 = false
                                                                upvalueValues[r16] = r22
                                                                r22 = allocUpvalue()
                                                                r77 = createClosure3(118, {
                                                                    r22,
                                                                    r82,
                                                                    r29,
                                                                    r12,
                                                                    r33
                                                                })
                                                                upvalueValues[r22] = r67
                                                                r67 = allocUpvalue()
                                                                upvalueValues[r67] = r77
                                                                r17 = upvalueValues[r35]
                                                                r68 = upvalueValues[r29]
                                                                r45 = releaseUpvalue(r45)
                                                                r69 = upvalueValues[r12]
                                                                r32 = r69(r80, r59)
                                                                r15 = r68[r32]
                                                                r77 = r17[r15]
                                                                r48 = releaseUpvalue(r48)
                                                                r15 = createClosure2(133, {
                                                                    r16,
                                                                    r22,
                                                                    r82,
                                                                    r29,
                                                                    r12,
                                                                    r35,
                                                                    r67,
                                                                    r39
                                                                })
                                                                r17 = "Connect"
                                                                r17 = r77[r17]
                                                                r17 = r17(r77, r15)
                                                                r15 = upvalueValues[r29]
                                                                r68 = upvalueValues[r12]
                                                                r39 = releaseUpvalue(r39)
                                                                r32 = "\221UeH\230\230!q\134\239\014\230Q9<1~"
                                                                r80 = 28371279115163
                                                                r69 = r68(r32, r80)
                                                                r17 = r15[r69]
                                                                r15 = createClosure1(141, {
                                                                    r67
                                                                })
                                                                r70 = releaseUpvalue(r70)
                                                                r77 = r64[r17]
                                                                r17 = "Connect"
                                                                r17 = r77[r17]
                                                                r17 = r17(r77, r15)
                                                                r59 = 30296067471131
                                                                r80 = "l\1352\235l.\031\135\030^\019R)\008"
                                                                r17 = upvalueValues[r82]
                                                                r68 = upvalueValues[r29]
                                                                r13 = nil
                                                                ReturnVal = {}
                                                                r69 = upvalueValues[r12]
                                                                r32 = r69(r80, r59)
                                                                r15 = r68[r32]
                                                                r77 = r17[r15]
                                                                r15 = createClosure3(142, {
                                                                    r16,
                                                                    r35,
                                                                    r29,
                                                                    r12
                                                                })
                                                                r17 = "Connect"
                                                                r17 = r77[r17]
                                                                r17 = r17(r77, r15)
                                                                r36 = releaseUpvalue(r36)
                                                                r80 = 4825078646982
                                                                r32 = "Iq\130\199z\1376\207r\168l\001=\229\tmX"
                                                                r15 = upvalueValues[r29]
                                                                r68 = upvalueValues[r12]
                                                                r19 = nil
                                                                r69 = r68(r32, r80)
                                                                r17 = r15[r69]
                                                                r77 = r62[r17]
                                                                r15 = createClosure2(145, {
                                                                    r74,
                                                                    r29,
                                                                    r12,
                                                                    r82,
                                                                    r33
                                                                })
                                                                r17 = "Connect"
                                                                r17 = r77[r17]
                                                                r17 = r17(r77, r15)
                                                                r17 = allocUpvalue()
                                                                r77 = false
                                                                upvalueValues[r17] = r77
                                                                r15 = createClosure3(154, {
                                                                    r29,
                                                                    r12
                                                                })
                                                                r16 = releaseUpvalue(r16)
                                                                r77 = allocUpvalue()
                                                                upvalueValues[r77] = r15
                                                                r68 = upvalueValues[r78]
                                                                r32 = upvalueValues[r29]
                                                                r80 = upvalueValues[r12]
                                                                r6 = nil
                                                                r61 = nil
                                                                r59 = r80(r44, r72)
                                                                r69 = r32[r59]
                                                                r15 = r68[r69]
                                                                r44 = "I,:\210\022P"
                                                                r68 = "Connect"
                                                                r62 = nil
                                                                r69 = createClosure2(155, {
                                                                    r17,
                                                                    r78,
                                                                    r29,
                                                                    r12,
                                                                    r82,
                                                                    r38,
                                                                    r77
                                                                })
                                                                r68 = r15[r68]
                                                                r68 = r68(r15, r69)
                                                                r68 = upvalueValues[r7]
                                                                r20 = releaseUpvalue(r20)
                                                                r10 = releaseUpvalue(r10)
                                                                r32 = upvalueValues[r29]
                                                                r80 = upvalueValues[r12]
                                                                r72 = 5380950526409
                                                                r59 = r80(r44, r72)
                                                                r69 = r32[r59]
                                                                r46 = nil
                                                                r15 = r68[r69]
                                                                r69 = upvalueValues[r29]
                                                                r81 = releaseUpvalue(r81)
                                                                r17 = releaseUpvalue(r17)
                                                                r32 = upvalueValues[r12]
                                                                r59 = "\244,\002\223\225\027X"
                                                                r44 = 28529126323172
                                                                r80 = r32(r59, r44)
                                                                r38 = releaseUpvalue(r38)
                                                                r68 = r69[r80]
                                                                r69 = true
                                                                r1 = nil
                                                                r15[r68] = r69
                                                                r68 = upvalueValues[r29]
                                                                r69 = upvalueValues[r12]
                                                                r78 = releaseUpvalue(r78)
                                                                r59 = 6510744292311
                                                                r80 = "\194\193\025\003\031\185"
                                                                r32 = r69(r80, r59)
                                                                r33 = releaseUpvalue(r33)
                                                                r15 = r68[r32]
                                                                upvalueValues[r73] = r15
                                                                r69 = upvalueValues[r41]
                                                                r32 = "GetChildren"
                                                                r32 = r69[r32]
                                                                r32 = r32(r69)
                                                                r69 = 1
                                                                r68 = r32[r69]
                                                                r67 = releaseUpvalue(r67)
                                                                r44 = "z\1621\243\006\r\163\152\229\016\228\2438\252\020\147"
                                                                r72 = 15902828600557
                                                                r32 = upvalueValues[r29]
                                                                r31 = nil
                                                                r73 = releaseUpvalue(r73)
                                                                r80 = upvalueValues[r12]
                                                                r59 = r80(r44, r72)
                                                                r69 = r32[r59]
                                                                r35 = releaseUpvalue(r35)
                                                                r82 = releaseUpvalue(r82)
                                                                r41 = releaseUpvalue(r41)
                                                                r59 = "Color3"
                                                                r80 = _env[r59]
                                                                r44 = upvalueValues[r29]
                                                                r72 = upvalueValues[r12]
                                                                r79 = r72(r71, r84)
                                                                r59 = r44[r79]
                                                                r52 = releaseUpvalue(r52)
                                                                r32 = r80[r59]
                                                                r72 = 70
                                                                r75 = nil
                                                                r44 = 60
                                                                r59 = 60
                                                                r80 = r32(r59, r44, r72)
                                                                r64 = nil
                                                                r74 = releaseUpvalue(r74)
                                                                r68[r69] = r80
                                                                r2 = releaseUpvalue(r2)
                                                                r12 = releaseUpvalue(r12)
                                                                r77 = releaseUpvalue(r77)
                                                                r63 = releaseUpvalue(r63)
                                                                r7 = releaseUpvalue(r7)
                                                                r29 = releaseUpvalue(r29)
                                                                r30 = nil
                                                                r22 = releaseUpvalue(r22)
                                                                r55 = nil
                                                                state = nil
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        -- createClosure2 entry 9373182 -> 35, states 35-35
                                        if state == 35 then -- entry 9373182 -> 35
                                            ReturnVal = "error"
                                            state = _env[ReturnVal]
                                            r66 = "Tamper Detected!"
                                            ReturnVal = state(r66)
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure5 entry 14257822 -> 36, states 36-36
                                    if state == 36 then -- entry 14257822 -> 36
                                        state = true
                                        upvalueValues[upvalues[1]] = state
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            else
                                if state <= 37 then
                                    -- createClosure4 entry 2796017 -> 37, states 37-37
                                    if state == 37 then -- entry 2796017 -> 37
                                        r29 = "XiwDieJ18Lb"
                                        r33 = 12348747
                                        r66 = r29 ^ r33
                                        ReturnVal = 16692072
                                        state = ReturnVal - r66
                                        r66 = state
                                        ReturnVal = "pqftzZvFYFBxNhV"
                                        state = ReturnVal / r66
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure1 entry 2522472 -> 38, states 38-49
                                    if state <= 43 then
                                        if state <= 40 then
                                            if state <= 39 then
                                                if state <= 38 then
                                                    if state == 38 then -- entry 2522472 -> 38
                                                        r29 = upvalueValues[upvalues[1]]
                                                        r12 = 1
                                                        r70 = 2
                                                        r33 = r29(r12, r70)
                                                        r29 = 1
                                                        r66 = r33 == r29
                                                        state = r66 and (39) or (40)
                                                        ReturnVal = r66
                                                    end
                                                else
                                                    if state == 39 then
                                                        state = ReturnVal and (41) or (42)
                                                    end
                                                end
                                            else
                                                if state == 40 then
                                                    r29 = upvalueValues[upvalues[2]]
                                                    r33 = upvalueValues[upvalues[3]]
                                                    r66 = r29 == r33
                                                    ReturnVal = r66
                                                    state = 39
                                                end
                                            end
                                        else
                                            if state <= 42 then
                                                if state <= 41 then
                                                    if state == 41 then
                                                        ReturnVal = "tonumber"
                                                        state = _env[ReturnVal]
                                                        r66 = upvalueValues[upvalues[4]]
                                                        r12 = "tostring"
                                                        r33 = _env[r12]
                                                        r6 = "pcall"
                                                        r37 = _env[r6]
                                                        r21 = createClosure0(166, {})
                                                        r6 = {
                                                            r37(r21)
                                                        }
                                                        r85 = {
                                                            unpack(r6)
                                                        }
                                                        r37 = 2
                                                        r70 = r85[r37]
                                                        r12 = r33(r70)
                                                        r33 = ":(%d*):"
                                                        r29 = r66(r12, r33)
                                                        r66 = {
                                                            r29()
                                                        }
                                                        ReturnVal = state(unpack(r66))
                                                        r66 = ReturnVal
                                                        r29 = upvalueValues[upvalues[5]]
                                                        state = r29 and (43) or (44)
                                                        ReturnVal = r29
                                                    end
                                                else
                                                    if state == 42 then
                                                        state = upvalueValues[upvalues[7]]
                                                        state = state and (45) or (46)
                                                    end
                                                end
                                            else
                                                if state == 43 then
                                                    r33 = upvalueValues[upvalues[6]]
                                                    r29 = r33 == r66
                                                    ReturnVal = r29
                                                    state = 44
                                                end
                                            end
                                        end
                                    else
                                        if state <= 46 then
                                            if state <= 45 then
                                                if state <= 44 then
                                                    if state == 44 then
                                                        upvalueValues[upvalues[5]] = ReturnVal
                                                        r66 = nil
                                                        state = 42
                                                    end
                                                else
                                                    if state == 45 then
                                                        r66 = "error"
                                                        state = _env[r66]
                                                        r29 = upvalueValues[upvalues[8]]
                                                        r33 = 0
                                                        r66 = state(r29, r33)
                                                        state = 46
                                                    end
                                                end
                                            else
                                                if state == 46 then
                                                    r33 = upvalueValues[upvalues[9]]
                                                    r12 = r33
                                                    state = {}
                                                    r66 = state
                                                    r33 = 1
                                                    r70 = r33
                                                    r33 = 0
                                                    r85 = r70 < r33
                                                    r29 = 1
                                                    r33 = r29 - r70
                                                    state = 47
                                                end
                                            end
                                        else
                                            if state <= 48 then
                                                if state <= 47 then
                                                    if state == 47 then
                                                        r37 = not r85
                                                        r33 = r33 + r70
                                                        r29 = r33 <= r12
                                                        r29 = r37 and r29
                                                        r37 = r33 >= r12
                                                        r37 = r85 and r37
                                                        r29 = r37 or r29
                                                        r37 = (48)
                                                        state = r29 and r37
                                                        r29 = (49)
                                                        state = state or r29
                                                    end
                                                else
                                                    if state == 48 then
                                                        state = upvalueValues[upvalues[1]]
                                                        r29 = r33
                                                        r6 = 0
                                                        r21 = 255
                                                        r37 = state(r6, r21)
                                                        r66[r29] = r37
                                                        r29 = nil
                                                        state = 47
                                                    end
                                                end
                                            else
                                                if state == 49 then
                                                    state = upvalueValues[upvalues[10]]
                                                    r29 = upvalueValues[upvalues[11]]
                                                    r66[state] = r29
                                                    state = upvalueValues[upvalues[12]]
                                                    r29 = {
                                                        state(r66)
                                                    }
                                                    ReturnVal = {
                                                        unpack(r29)
                                                    }
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            if state <= 59 then
                                if state <= 53 then
                                    -- createClosure4 entry 4652201 -> 50, states 50-53
                                    if state <= 51 then
                                        if state <= 50 then
                                            if state == 50 then -- entry 4652201 -> 50
                                                state = 51
                                            end
                                        else
                                            if state == 51 then
                                                state = true
                                                state = state and (52) or (53)
                                            end
                                        end
                                    else
                                        if state <= 52 then
                                            if state == 52 then
                                                ReturnVal = "l2"
                                                state = _env[ReturnVal]
                                                r66 = "l1"
                                                ReturnVal = _env[r66]
                                                r66 = "l1"
                                                _env[r66] = state
                                                r66 = "l2"
                                                _env[r66] = ReturnVal
                                                r66 = upvalueValues[upvalues[1]]
                                                r29 = r66()
                                                state = 51
                                            end
                                        else
                                            if state == 53 then
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    -- createClosure1 entry 5093850 -> 54, states 54-59
                                    if state <= 56 then
                                        if state <= 55 then
                                            if state <= 54 then
                                                if state == 54 then -- entry 5093850 -> 54
                                                    r66 = upvalueValues[upvalues[1]]
                                                    ReturnVal = #r66
                                                    r66 = 0
                                                    state = ReturnVal == r66
                                                    state = state and (55) or (56)
                                                end
                                            else
                                                if state == 55 then
                                                    r29 = upvalueValues[upvalues[2]]
                                                    r33 = 245
                                                    r66 = r29 * r33
                                                    r29 = 29785322386989
                                                    ReturnVal = r66 + r29
                                                    r66 = 35184372088832
                                                    state = ReturnVal % r66
                                                    upvalueValues[upvalues[2]] = state
                                                    r66 = upvalueValues[upvalues[3]]
                                                    r29 = 1
                                                    ReturnVal = r66 ~= r29
                                                    state = 57
                                                end
                                            end
                                        else
                                            if state == 56 then
                                                r33 = "table"
                                                r29 = _env[r33]
                                                r33 = "remove"
                                                r66 = r29[r33]
                                                r33 = upvalueValues[upvalues[1]]
                                                r29 = {
                                                    r66(r33)
                                                }
                                                ReturnVal = {
                                                    unpack(r29)
                                                }
                                                state = nil
                                            end
                                        end
                                    else
                                        if state <= 58 then
                                            if state <= 57 then
                                                if state == 57 then
                                                    r29 = upvalueValues[upvalues[3]]
                                                    r33 = 182
                                                    r66 = r29 * r33
                                                    r29 = 257
                                                    ReturnVal = r66 % r29
                                                    upvalueValues[upvalues[3]] = ReturnVal
                                                    state = 58
                                                end
                                            else
                                                if state == 58 then
                                                    r29 = upvalueValues[upvalues[3]]
                                                    r33 = 1
                                                    r66 = r29 ~= r33
                                                    state = r66 and (59) or (57)
                                                end
                                            end
                                        else
                                            if state == 59 then
                                                r21 = 2
                                                r29 = upvalueValues[upvalues[3]]
                                                r33 = 32
                                                r66 = r29 % r33
                                                r12 = upvalueValues[upvalues[4]]
                                                r37 = upvalueValues[upvalues[2]]
                                                r2 = upvalueValues[upvalues[3]]
                                                r45 = r2 - r66
                                                r2 = 32
                                                r82 = r45 / r2
                                                r57 = 13
                                                r38 = r57 - r82
                                                r6 = r21 ^ r38
                                                r85 = r37 / r6
                                                r6 = 1
                                                r70 = r12(r85)
                                                r12 = 4294967296
                                                r33 = r70 % r12
                                                r70 = 2
                                                r12 = r70 ^ r66
                                                r29 = r33 / r12
                                                r12 = upvalueValues[upvalues[4]]
                                                r37 = r29 % r6
                                                r6 = 4294967296
                                                r85 = r37 * r6
                                                r70 = r12(r85)
                                                r12 = upvalueValues[upvalues[4]]
                                                r85 = r12(r29)
                                                r33 = r70 + r85
                                                r37 = 65536
                                                r70 = 65536
                                                r12 = r33 % r70
                                                r85 = r33 - r12
                                                r57 = 256
                                                r29 = nil
                                                r70 = r85 / r37
                                                r37 = 256
                                                r21 = 256
                                                r85 = r12 % r37
                                                r6 = r12 - r85
                                                r37 = r6 / r21
                                                r21 = 256
                                                r6 = r70 % r21
                                                r33 = nil
                                                r38 = r70 - r6
                                                r21 = r38 / r57
                                                r70 = nil
                                                r38 = {
                                                    r85,
                                                    r37,
                                                    r6,
                                                    r21
                                                }
                                                r12 = nil
                                                r66 = nil
                                                upvalueValues[upvalues[1]] = r38
                                                r6 = nil
                                                r85 = nil
                                                r21 = nil
                                                r37 = nil
                                                state = 56
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 66 then
                                    -- createClosure7 entry 8058158 -> 60, states 60-66
                                    if state <= 63 then
                                        if state <= 61 then
                                            if state <= 60 then
                                                if state == 60 then -- entry 8058158 -> 60
                                                    r29 = args[2]
                                                    state = upvalueValues[upvalues[1]]
                                                    r33 = state
                                                    r66 = args[1]
                                                    state = r33[r29]
                                                    state = state and (61) or (62)
                                                end
                                            else
                                                if state == 61 then
                                                    state = 63
                                                end
                                            end
                                        else
                                            if state <= 62 then
                                                if state == 62 then
                                                    state = {}
                                                    upvalueValues[upvalues[2]] = state
                                                    ReturnVal = upvalueValues[upvalues[3]]
                                                    r12 = ReturnVal
                                                    r70 = 35184372088832
                                                    ReturnVal = r29 % r70
                                                    upvalueValues[upvalues[4]] = ReturnVal
                                                    r37 = 255
                                                    r85 = r29 % r37
                                                    r37 = 2
                                                    r70 = r85 + r37
                                                    upvalueValues[upvalues[5]] = r70
                                                    r6 = "string"
                                                    r37 = _env[r6]
                                                    r38 = 1
                                                    r6 = "len"
                                                    r85 = r37[r6]
                                                    r37 = r85(r66)
                                                    r57 = r38
                                                    r85 = ""
                                                    r33[r29] = r85
                                                    r38 = 0
                                                    r82 = r57 < r38
                                                    r6 = 1
                                                    r38 = r6 - r57
                                                    r85 = 136
                                                    r21 = r37
                                                    state = 64
                                                end
                                            else
                                                if state == 63 then
                                                    ReturnVal = {
                                                        r29
                                                    }
                                                    state = nil
                                                end
                                            end
                                        end
                                    else
                                        if state <= 65 then
                                            if state <= 64 then
                                                if state == 64 then
                                                    r38 = r38 + r57
                                                    r45 = not r82
                                                    r6 = r38 <= r21
                                                    r6 = r45 and r6
                                                    r45 = r38 >= r21
                                                    r45 = r82 and r45
                                                    r6 = r45 or r6
                                                    r45 = (65)
                                                    state = r6 and r45
                                                    r6 = (66)
                                                    state = state or r6
                                                end
                                            else
                                                if state == 65 then
                                                    r6 = r38
                                                    r47 = "string"
                                                    r5 = _env[r47]
                                                    r47 = "byte"
                                                    r83 = r5[r47]
                                                    r5 = r83(r66, r6)
                                                    r83 = upvalueValues[upvalues[6]]
                                                    r47 = r83()
                                                    r54 = r5 + r47
                                                    r6 = nil
                                                    r2 = r54 + r85
                                                    r54 = 256
                                                    r45 = r2 % r54
                                                    r85 = r45
                                                    r54 = r33[r29]
                                                    r47 = 1
                                                    r5 = r85 + r47
                                                    r83 = r12[r5]
                                                    r2 = r54 .. r83
                                                    r33[r29] = r2
                                                    state = 64
                                                end
                                            end
                                        else
                                            if state == 66 then
                                                r12 = nil
                                                r37 = nil
                                                r85 = nil
                                                state = 63
                                            end
                                        end
                                    end
                                else
                                    -- createClosure1 entry 12126525 -> 67, states 67-70
                                    if state <= 68 then
                                        if state <= 67 then
                                            if state == 67 then -- entry 12126525 -> 67
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                r66 = upvalueValues[upvalues[2]]
                                                r12 = 33776156015984
                                                r33 = "\nY\231\151\236\143\197\243/X.Uq\172Wi\015b\224\019\n\029\160\221\026\017\152\154\149G:\025\249\135\234\025\131e\014\027\195\216\020\027\204e\1763\158\206\254\246\242\167\190\210\242\025\242\235\179\242"
                                                r29 = r66(r33, r12)
                                                state = ReturnVal[r29]
                                                r66 = state
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                r29 = upvalueValues[upvalues[2]]
                                                r70 = 30137600128721
                                                r12 = ""
                                                r33 = r29(r12, r70)
                                                state = ReturnVal[r33]
                                                r29 = state
                                                r33 = 32
                                                r12 = r33
                                                r33 = 1
                                                r70 = r33
                                                r33 = 0
                                                r85 = r70 < r33
                                                ReturnVal = 1
                                                r33 = ReturnVal - r70
                                                state = 68
                                            end
                                        else
                                            if state == 68 then
                                                r33 = r33 + r70
                                                r37 = not r85
                                                ReturnVal = r33 <= r12
                                                ReturnVal = r37 and ReturnVal
                                                r37 = r33 >= r12
                                                r37 = r85 and r37
                                                ReturnVal = r37 or ReturnVal
                                                r37 = (69)
                                                state = ReturnVal and r37
                                                ReturnVal = (70)
                                                state = state or ReturnVal
                                            end
                                        end
                                    else
                                        if state <= 69 then
                                            if state == 69 then
                                                r37 = r33
                                                r38 = "math"
                                                r21 = _env[r38]
                                                r57 = upvalueValues[upvalues[1]]
                                                r82 = upvalueValues[upvalues[2]]
                                                r2 = "\218Xx\154\003j"
                                                r54 = 16254584888721
                                                r45 = r82(r2, r54)
                                                r38 = r57[r45]
                                                r6 = r21[r38]
                                                r83 = 19776501326841
                                                ReturnVal = "sub"
                                                ReturnVal = r66[ReturnVal]
                                                r37 = nil
                                                r57 = #r66
                                                r38 = 1
                                                r21 = r6(r38, r57)
                                                r57 = "math"
                                                r38 = _env[r57]
                                                r82 = upvalueValues[upvalues[1]]
                                                r45 = upvalueValues[upvalues[2]]
                                                r54 = "\235\225\142o\0018"
                                                r2 = r45(r54, r83)
                                                r57 = r82[r2]
                                                r6 = r38[r57]
                                                r82 = #r66
                                                r57 = 1
                                                r38 = {
                                                    r6(r57, r82)
                                                }
                                                ReturnVal = ReturnVal(r66, r21, unpack(r38))
                                                state = r29 .. ReturnVal
                                                r29 = state
                                                state = 68
                                            end
                                        else
                                            if state == 70 then
                                                ReturnVal = {
                                                    r29
                                                }
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    else
                        if state <= 94 then
                            if state <= 76 then
                                if state <= 72 then
                                    if state <= 71 then
                                        -- createClosure6 entry 12310766 -> 71, states 71-71
                                        if state == 71 then -- entry 12310766 -> 71
                                            r29 = args[2]
                                            r66 = allocUpvalue()
                                            upvalueValues[r66] = args[1]
                                            r33 = "Instance"
                                            ReturnVal = _env[r33]
                                            r12 = upvalueValues[upvalues[1]]
                                            r70 = upvalueValues[upvalues[2]]
                                            r37 = "E\016\214"
                                            r6 = 22012776802314
                                            r85 = r70(r37, r6)
                                            r33 = r12[r85]
                                            state = ReturnVal[r33]
                                            r12 = upvalueValues[upvalues[1]]
                                            r70 = upvalueValues[upvalues[2]]
                                            r6 = 28816886232170
                                            r37 = "\167a\149\146'U\186\210\158\215"
                                            r85 = r70(r37, r6)
                                            r33 = r12[r85]
                                            ReturnVal = state(r33)
                                            r33 = allocUpvalue()
                                            upvalueValues[r33] = ReturnVal
                                            state = upvalueValues[r33]
                                            r12 = upvalueValues[upvalues[1]]
                                            r70 = upvalueValues[upvalues[2]]
                                            r37 = "$\172\142e"
                                            r6 = 23179954203178
                                            r85 = r70(r37, r6)
                                            ReturnVal = r12[r85]
                                            r85 = "UDim2"
                                            r70 = _env[r85]
                                            r37 = upvalueValues[upvalues[1]]
                                            r6 = upvalueValues[upvalues[2]]
                                            r38 = "\239X\250"
                                            r57 = 5810033412753
                                            r21 = r6(r38, r57)
                                            r85 = r37[r21]
                                            r37 = -10
                                            r12 = r70[r85]
                                            r6 = 0
                                            r21 = 30
                                            r85 = 1
                                            r70 = r12(r85, r37, r6, r21)
                                            state[ReturnVal] = r70
                                            state = upvalueValues[r33]
                                            r12 = upvalueValues[upvalues[1]]
                                            r70 = upvalueValues[upvalues[2]]
                                            r6 = 7119894596851
                                            r37 = "]\244\251\029E\206\r\182"
                                            r85 = r70(r37, r6)
                                            ReturnVal = r12[r85]
                                            r85 = "UDim2"
                                            r70 = _env[r85]
                                            r37 = upvalueValues[upvalues[1]]
                                            r6 = upvalueValues[upvalues[2]]
                                            r57 = 28085329064726
                                            r38 = "\131\176\127"
                                            r21 = r6(r38, r57)
                                            r85 = r37[r21]
                                            r12 = r70[r85]
                                            r45 = 1
                                            r82 = r29 - r45
                                            r45 = 35
                                            r57 = r82 * r45
                                            r38 = 5
                                            r21 = r38 + r57
                                            r6 = 0
                                            r85 = 0
                                            r37 = 5
                                            r70 = r12(r85, r37, r6, r21)
                                            state[ReturnVal] = r70
                                            state = upvalueValues[r33]
                                            r12 = upvalueValues[upvalues[1]]
                                            r70 = upvalueValues[upvalues[2]]
                                            r37 = "m\208\213x\005\185g\1448z\133\194\129\148#Q"
                                            r6 = 20364784821515
                                            r85 = r70(r37, r6)
                                            ReturnVal = r12[r85]
                                            r85 = "Color3"
                                            r70 = _env[r85]
                                            r37 = upvalueValues[upvalues[1]]
                                            r6 = upvalueValues[upvalues[2]]
                                            r57 = 34646092578565
                                            r38 = ",Y\157\154\170\235X"
                                            r21 = r6(r38, r57)
                                            r85 = r37[r21]
                                            r12 = r70[r85]
                                            r37 = 40
                                            r6 = 45
                                            r85 = 40
                                            r70 = r12(r85, r37, r6)
                                            state[ReturnVal] = r70
                                            state = upvalueValues[r33]
                                            r12 = upvalueValues[upvalues[1]]
                                            r70 = upvalueValues[upvalues[2]]
                                            r6 = 256278216823
                                            r37 = "\233\161\195\153"
                                            r85 = r70(r37, r6)
                                            ReturnVal = r12[r85]
                                            r12 = upvalueValues[r66]
                                            state[ReturnVal] = r12
                                            state = upvalueValues[r33]
                                            r12 = upvalueValues[upvalues[1]]
                                            r70 = upvalueValues[upvalues[2]]
                                            r37 = "jK\218D\187*Z5P\249"
                                            r6 = 20961242998304
                                            r85 = r70(r37, r6)
                                            ReturnVal = r12[r85]
                                            r85 = "Color3"
                                            r70 = _env[r85]
                                            r37 = upvalueValues[upvalues[1]]
                                            r6 = upvalueValues[upvalues[2]]
                                            r38 = "\132\006k\020o\238\129"
                                            r57 = 29217246754085
                                            r21 = r6(r38, r57)
                                            r85 = r37[r21]
                                            r12 = r70[r85]
                                            r37 = 255
                                            r6 = 255
                                            r85 = 255
                                            r70 = r12(r85, r37, r6)
                                            state[ReturnVal] = r70
                                            state = upvalueValues[r33]
                                            r12 = upvalueValues[upvalues[1]]
                                            r70 = upvalueValues[upvalues[2]]
                                            r6 = 3305638987267
                                            r37 = "\018\252:\207"
                                            r85 = r70(r37, r6)
                                            ReturnVal = r12[r85]
                                            r37 = "Enum"
                                            r85 = _env[r37]
                                            r6 = upvalueValues[upvalues[1]]
                                            r21 = upvalueValues[upvalues[2]]
                                            r82 = 22124290877502
                                            r57 = "\197=\208\144"
                                            r38 = r21(r57, r82)
                                            r37 = r6[r38]
                                            r70 = r85[r37]
                                            r37 = upvalueValues[upvalues[1]]
                                            r6 = upvalueValues[upvalues[2]]
                                            r38 = ".\162\151\167\tA_\200z\155"
                                            r57 = 853135966605
                                            r21 = r6(r38, r57)
                                            r85 = r37[r21]
                                            r12 = r70[r85]
                                            state[ReturnVal] = r12
                                            state = upvalueValues[r33]
                                            r12 = upvalueValues[upvalues[1]]
                                            r70 = upvalueValues[upvalues[2]]
                                            r37 = "\230\246YP\217\026v\158"
                                            r6 = 27697941967457
                                            r85 = r70(r37, r6)
                                            ReturnVal = r12[r85]
                                            r12 = 14
                                            state[ReturnVal] = r12
                                            state = upvalueValues[r33]
                                            r12 = upvalueValues[upvalues[1]]
                                            r70 = upvalueValues[upvalues[2]]
                                            r6 = 27242401608077
                                            r37 = "\008M?\202\159\031"
                                            r85 = r70(r37, r6)
                                            ReturnVal = r12[r85]
                                            r12 = upvalueValues[upvalues[3]]
                                            state[ReturnVal] = r12
                                            r12 = "Instance"
                                            ReturnVal = _env[r12]
                                            r70 = upvalueValues[upvalues[1]]
                                            r85 = upvalueValues[upvalues[2]]
                                            r6 = ";\135s"
                                            r21 = 20154169861289
                                            r37 = r85(r6, r21)
                                            r12 = r70[r37]
                                            state = ReturnVal[r12]
                                            r70 = upvalueValues[upvalues[1]]
                                            r85 = upvalueValues[upvalues[2]]
                                            r21 = 10033890628160
                                            r6 = "\176?])\012\199`\218"
                                            r37 = r85(r6, r21)
                                            r12 = r70[r37]
                                            ReturnVal = state(r12)
                                            r12 = ReturnVal
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r70 = upvalueValues[upvalues[2]]
                                            r37 = "\211\020\201\225hui\173\171\185S\\"
                                            r6 = 10255076201127
                                            r85 = r70(r37, r6)
                                            state = ReturnVal[r85]
                                            r85 = "UDim"
                                            r70 = _env[r85]
                                            r37 = upvalueValues[upvalues[1]]
                                            r6 = upvalueValues[upvalues[2]]
                                            r57 = 35165058007031
                                            r38 = "iF\236"
                                            r21 = r6(r38, r57)
                                            r85 = r37[r21]
                                            ReturnVal = r70[r85]
                                            r37 = 8
                                            r85 = 0
                                            r70 = ReturnVal(r85, r37)
                                            r12[state] = r70
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r70 = upvalueValues[upvalues[2]]
                                            r37 = "l\024\181\253\224D"
                                            r6 = 32613988514643
                                            r85 = r70(r37, r6)
                                            state = ReturnVal[r85]
                                            ReturnVal = upvalueValues[r33]
                                            r12[state] = ReturnVal
                                            r70 = "Instance"
                                            ReturnVal = _env[r70]
                                            r85 = upvalueValues[upvalues[1]]
                                            r37 = upvalueValues[upvalues[2]]
                                            r21 = "\238\"!"
                                            r38 = 4730511116442
                                            r6 = r37(r21, r38)
                                            r70 = r85[r6]
                                            state = ReturnVal[r70]
                                            r85 = upvalueValues[upvalues[1]]
                                            r37 = upvalueValues[upvalues[2]]
                                            r38 = 18551322124734
                                            r21 = "\146 \249K\130"
                                            r6 = r37(r21, r38)
                                            r70 = r85[r6]
                                            ReturnVal = state(r70)
                                            r70 = allocUpvalue()
                                            upvalueValues[r70] = ReturnVal
                                            state = upvalueValues[r70]
                                            r85 = upvalueValues[upvalues[1]]
                                            r37 = upvalueValues[upvalues[2]]
                                            r21 = "\019\022\198\187"
                                            r38 = 20326468543737
                                            r6 = r37(r21, r38)
                                            ReturnVal = r85[r6]
                                            r6 = "UDim2"
                                            r37 = _env[r6]
                                            r21 = upvalueValues[upvalues[1]]
                                            r38 = upvalueValues[upvalues[2]]
                                            r45 = 34879007113073
                                            r82 = "[\245B"
                                            r57 = r38(r82, r45)
                                            r6 = r21[r57]
                                            r85 = r37[r6]
                                            r38 = 1
                                            r57 = 0
                                            r6 = 1
                                            r21 = 0
                                            r37 = r85(r6, r21, r38, r57)
                                            state[ReturnVal] = r37
                                            state = upvalueValues[r70]
                                            r85 = upvalueValues[upvalues[1]]
                                            r37 = upvalueValues[upvalues[2]]
                                            r21 = "\226\2529\156\234\022\232w\028\207\227\246\141\143c\174\218'\1823\171 "
                                            r38 = 15481817996329
                                            r6 = r37(r21, r38)
                                            ReturnVal = r85[r6]
                                            r85 = 1
                                            state[ReturnVal] = r85
                                            state = upvalueValues[r70]
                                            r85 = upvalueValues[upvalues[1]]
                                            r37 = upvalueValues[upvalues[2]]
                                            r38 = 7324357234002
                                            r21 = "\136oL\029v(`"
                                            r6 = r37(r21, r38)
                                            ReturnVal = r85[r6]
                                            r85 = false
                                            state[ReturnVal] = r85
                                            state = upvalueValues[r70]
                                            r85 = upvalueValues[upvalues[1]]
                                            r37 = upvalueValues[upvalues[2]]
                                            r21 = "\015#\127\223\147g"
                                            r38 = 34449250827945
                                            r6 = r37(r21, r38)
                                            ReturnVal = r85[r6]
                                            r85 = upvalueValues[upvalues[4]]
                                            state[ReturnVal] = r85
                                            state = upvalueValues[upvalues[5]]
                                            ReturnVal = upvalueValues[r66]
                                            r85 = upvalueValues[r70]
                                            state[ReturnVal] = r85
                                            ReturnVal = upvalueValues[r33]
                                            r37 = upvalueValues[upvalues[1]]
                                            r6 = upvalueValues[upvalues[2]]
                                            r57 = 26422344658959
                                            r38 = "g\205A\251\189\200|;\249c\197\220\193:<\012f"
                                            r21 = r6(r38, r57)
                                            r85 = r37[r21]
                                            state = ReturnVal[r85]
                                            ReturnVal = "Connect"
                                            ReturnVal = state[ReturnVal]
                                            r85 = createClosure2(167, {
                                                upvalues[6],
                                                r66,
                                                upvalues[5],
                                                upvalues[1],
                                                upvalues[2],
                                                r70,
                                                r33,
                                                upvalues[3]
                                            })
                                            ReturnVal = ReturnVal(state, r85)
                                            state = upvalueValues[r70]
                                            ReturnVal = {
                                                state
                                            }
                                            state = nil
                                        end
                                    else
                                        -- createClosure3 entry 1167541 -> 72, states 72-72
                                        if state == 72 then -- entry 1167541 -> 72
                                            state = upvalueValues[upvalues[1]]
                                            ReturnVal = "Kick"
                                            ReturnVal = state[ReturnVal]
                                            r29 = upvalueValues[upvalues[2]]
                                            r33 = upvalueValues[upvalues[3]]
                                            r70 = "\128)]\190x+\149\190"
                                            r85 = 9482555003199
                                            r12 = r33(r70, r85)
                                            r66 = r29[r12]
                                            ReturnVal = ReturnVal(state, r66)
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure5 entry 4526135 -> 73, states 73-76
                                    if state <= 74 then
                                        if state <= 73 then
                                            if state == 73 then -- entry 4526135 -> 73
                                                r66 = upvalueValues[upvalues[1]]
                                                r33 = upvalueValues[upvalues[2]]
                                                r12 = upvalueValues[upvalues[3]]
                                                r37 = 12212685641270
                                                r85 = "\214]\174\160"
                                                r70 = r12(r85, r37)
                                                r29 = r33[r70]
                                                ReturnVal = r66[r29]
                                                r66 = upvalueValues[upvalues[4]]
                                                state = ReturnVal == r66
                                                state = state and (74) or (75)
                                            end
                                        else
                                            if state == 74 then
                                                state = upvalueValues[upvalues[5]]
                                                ReturnVal = "Destroy"
                                                ReturnVal = state[ReturnVal]
                                                ReturnVal = ReturnVal(state)
                                                state = upvalueValues[upvalues[6]]
                                                r66 = upvalueValues[upvalues[2]]
                                                r29 = upvalueValues[upvalues[3]]
                                                r70 = 26617300185194
                                                r12 = "\026\200l;B\201Y"
                                                r33 = r29(r12, r70)
                                                ReturnVal = r66[r33]
                                                r66 = true
                                                state[ReturnVal] = r66
                                                state = 76
                                            end
                                        end
                                    else
                                        if state <= 75 then
                                            if state == 75 then
                                                state = upvalueValues[upvalues[7]]
                                                r29 = upvalueValues[upvalues[2]]
                                                r33 = upvalueValues[upvalues[3]]
                                                r85 = 18673065828855
                                                r70 = "=06\014\1672\210\193\014SP\148:~\023\170\028q\193\247E\229X\174\244\004\219\128N$|u\002\178\136\237\189@\199\226\000"
                                                r12 = r33(r70, r85)
                                                r66 = r29[r12]
                                                ReturnVal = "Kick"
                                                ReturnVal = state[ReturnVal]
                                                ReturnVal = ReturnVal(state, r66)
                                                state = 76
                                            end
                                        else
                                            if state == 76 then
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 80 then
                                    -- createClosure4 entry 10240353 -> 77, states 77-80
                                    if state <= 78 then
                                        if state <= 77 then
                                            if state == 77 then -- entry 10240353 -> 77
                                                state = upvalueValues[upvalues[1]]
                                                state = state and (78) or (79)
                                            end
                                        else
                                            if state == 78 then
                                                state = upvalueValues[upvalues[2]]
                                                r66 = upvalueValues[upvalues[3]]
                                                r29 = upvalueValues[upvalues[4]]
                                                r70 = upvalueValues[upvalues[5]]
                                                r85 = upvalueValues[upvalues[6]]
                                                r6 = "\228\222\183\179"
                                                r21 = 4890427738341
                                                r37 = r85(r6, r21)
                                                r12 = r70[r37]
                                                r37 = "UDim2"
                                                r85 = _env[r37]
                                                r6 = upvalueValues[upvalues[5]]
                                                r21 = upvalueValues[upvalues[6]]
                                                r57 = "\247\157R"
                                                r82 = 33894522240423
                                                r38 = r21(r57, r82)
                                                r37 = r6[r38]
                                                r70 = r85[r37]
                                                r21 = 0
                                                r6 = 300
                                                r38 = 200
                                                r37 = 0
                                                r85 = r70(r37, r6, r21, r38)
                                                ReturnVal = "Create"
                                                ReturnVal = state[ReturnVal]
                                                r33 = {
                                                    [r12] = r85
                                                }
                                                ReturnVal = ReturnVal(state, r66, r29, r33)
                                                r66 = ReturnVal
                                                state = "Play"
                                                state = r66[state]
                                                state = state(r66)
                                                r29 = upvalueValues[upvalues[5]]
                                                r33 = upvalueValues[upvalues[6]]
                                                r70 = "\162\254\020\019\153\186/\197\154"
                                                r85 = 33257964256382
                                                r12 = r33(r70, r85)
                                                ReturnVal = r29[r12]
                                                state = r66[ReturnVal]
                                                ReturnVal = "Wait"
                                                ReturnVal = state[ReturnVal]
                                                ReturnVal = ReturnVal(state)
                                                r37 = 9113256104083
                                                r85 = 2402516714590
                                                r70 = "\239\190G\175"
                                                state = upvalueValues[upvalues[7]]
                                                r29 = upvalueValues[upvalues[5]]
                                                r33 = upvalueValues[upvalues[6]]
                                                r66 = nil
                                                r12 = r33(r70, r85)
                                                ReturnVal = r29[r12]
                                                r33 = upvalueValues[upvalues[5]]
                                                r12 = upvalueValues[upvalues[6]]
                                                r85 = "\250\173P"
                                                r70 = r12(r85, r37)
                                                r29 = r33[r70]
                                                state[ReturnVal] = r29
                                                state = upvalueValues[upvalues[8]]
                                                r29 = upvalueValues[upvalues[5]]
                                                r33 = upvalueValues[upvalues[6]]
                                                r70 = "\165\241t\243\154\206o"
                                                r85 = 3615825118867
                                                r12 = r33(r70, r85)
                                                ReturnVal = r29[r12]
                                                r29 = true
                                                state[ReturnVal] = r29
                                                state = upvalueValues[upvalues[9]]
                                                r29 = upvalueValues[upvalues[5]]
                                                r33 = upvalueValues[upvalues[6]]
                                                r85 = 32245302999719
                                                r70 = "\204\178\135\244\158\202\179"
                                                r12 = r33(r70, r85)
                                                ReturnVal = r29[r12]
                                                r29 = true
                                                state[ReturnVal] = r29
                                                state = false
                                                upvalueValues[upvalues[1]] = state
                                                state = 80
                                            end
                                        end
                                    else
                                        if state <= 79 then
                                            if state == 79 then
                                                ReturnVal = upvalueValues[upvalues[2]]
                                                r29 = upvalueValues[upvalues[3]]
                                                r33 = upvalueValues[upvalues[4]]
                                                r85 = upvalueValues[upvalues[5]]
                                                r37 = upvalueValues[upvalues[6]]
                                                r21 = "b=\223\232"
                                                r38 = 17068052209419
                                                r6 = r37(r21, r38)
                                                r70 = r85[r6]
                                                r6 = "UDim2"
                                                r37 = _env[r6]
                                                r21 = upvalueValues[upvalues[5]]
                                                r38 = upvalueValues[upvalues[6]]
                                                r82 = "\226\215\206"
                                                r45 = 3975828653883
                                                r57 = r38(r82, r45)
                                                r6 = r21[r57]
                                                r85 = r37[r6]
                                                r57 = 30
                                                r21 = 300
                                                r6 = 0
                                                r38 = 0
                                                r37 = r85(r6, r21, r38, r57)
                                                r12 = {
                                                    [r70] = r37
                                                }
                                                r66 = "Create"
                                                r66 = ReturnVal[r66]
                                                r66 = r66(ReturnVal, r29, r33, r12)
                                                ReturnVal = upvalueValues[upvalues[8]]
                                                r33 = upvalueValues[upvalues[5]]
                                                r12 = upvalueValues[upvalues[6]]
                                                r37 = 1080053465590
                                                r85 = "\144\190\181F2\237M"
                                                r70 = r12(r85, r37)
                                                r29 = r33[r70]
                                                r33 = false
                                                ReturnVal[r29] = r33
                                                ReturnVal = upvalueValues[upvalues[9]]
                                                r33 = upvalueValues[upvalues[5]]
                                                r12 = upvalueValues[upvalues[6]]
                                                r37 = 13817316186402
                                                r85 = "*\004r\005\179\167\238"
                                                r70 = r12(r85, r37)
                                                r29 = r33[r70]
                                                r33 = false
                                                ReturnVal[r29] = r33
                                                ReturnVal = "Play"
                                                ReturnVal = r66[ReturnVal]
                                                ReturnVal = ReturnVal(r66)
                                                r33 = upvalueValues[upvalues[5]]
                                                r12 = upvalueValues[upvalues[6]]
                                                r37 = 3819449485042
                                                r85 = "nR\030\018yZ\180\237\134"
                                                r70 = r12(r85, r37)
                                                r29 = r33[r70]
                                                ReturnVal = r66[r29]
                                                r29 = "Wait"
                                                r29 = ReturnVal[r29]
                                                r29 = r29(ReturnVal)
                                                r37 = 33159573830737
                                                r66 = nil
                                                ReturnVal = upvalueValues[upvalues[7]]
                                                r33 = upvalueValues[upvalues[5]]
                                                r12 = upvalueValues[upvalues[6]]
                                                r85 = "\130X0}"
                                                r70 = r12(r85, r37)
                                                r29 = r33[r70]
                                                r12 = upvalueValues[upvalues[5]]
                                                r70 = upvalueValues[upvalues[6]]
                                                r6 = 30524650502022
                                                r37 = "\007"
                                                r85 = r70(r37, r6)
                                                r33 = r12[r85]
                                                ReturnVal[r29] = r33
                                                ReturnVal = true
                                                upvalueValues[upvalues[1]] = ReturnVal
                                                state = 80
                                            end
                                        else
                                            if state == 80 then
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    -- createClosure0 entry 4366593 -> 81, states 81-94
                                    if state <= 87 then
                                        if state <= 84 then
                                            if state <= 82 then
                                                if state <= 81 then
                                                    if state == 81 then -- entry 4366593 -> 81
                                                        state = upvalueValues[upvalues[1]]
                                                        r66 = upvalueValues[upvalues[2]]
                                                        r29 = upvalueValues[upvalues[3]]
                                                        r70 = upvalueValues[upvalues[4]]
                                                        r85 = upvalueValues[upvalues[5]]
                                                        r21 = 9271733768413
                                                        r6 = "\135MQ\216"
                                                        r37 = r85(r6, r21)
                                                        r12 = r70[r37]
                                                        r37 = "UDim2"
                                                        r85 = _env[r37]
                                                        r6 = upvalueValues[upvalues[4]]
                                                        r21 = upvalueValues[upvalues[5]]
                                                        r57 = "-\168\004"
                                                        r82 = 2926230046034
                                                        r38 = r21(r57, r82)
                                                        r37 = r6[r38]
                                                        r70 = r85[r37]
                                                        ReturnVal = "Create"
                                                        ReturnVal = state[ReturnVal]
                                                        r21 = 0
                                                        r37 = 0
                                                        r38 = 0
                                                        r6 = 300
                                                        r85 = r70(r37, r6, r21, r38)
                                                        r37 = upvalueValues[upvalues[4]]
                                                        r6 = upvalueValues[upvalues[5]]
                                                        r57 = 5761166953082
                                                        r38 = "\002@\152\251\242rI`\179V:\\\014V\1528\138\168\245/A)"
                                                        r21 = r6(r38, r57)
                                                        r70 = r37[r21]
                                                        r37 = 1
                                                        r33 = {
                                                            [r12] = r85,
                                                            [r70] = r37
                                                        }
                                                        ReturnVal = ReturnVal(state, r66, r29, r33)
                                                        r66 = ReturnVal
                                                        state = "Play"
                                                        state = r66[state]
                                                        state = state(r66)
                                                        ReturnVal = "pairs"
                                                        state = _env[ReturnVal]
                                                        r12 = upvalueValues[upvalues[2]]
                                                        r85 = "GetDescendants"
                                                        r85 = r12[r85]
                                                        r70 = {
                                                            r85(r12)
                                                        }
                                                        r12 = {
                                                            state(unpack(r70))
                                                        }
                                                        r29 = r12[2]
                                                        ReturnVal = r12[1]
                                                        r33 = r12[3]
                                                        r12 = ReturnVal
                                                        state = 82
                                                    end
                                                else
                                                    if state == 82 then
                                                        r33, r85 = r12(r29, r33)
                                                        state = r33 and (83) or (84)
                                                    end
                                                end
                                            else
                                                if state <= 83 then
                                                    if state == 83 then
                                                        r6 = upvalueValues[upvalues[4]]
                                                        r21 = upvalueValues[upvalues[5]]
                                                        r57 = "Ol}\148\139\0248\192\000"
                                                        r82 = 20457352439094
                                                        r38 = r21(r57, r82)
                                                        r37 = r6[r38]
                                                        state = "IsA"
                                                        state = r85[state]
                                                        state = state(r85, r37)
                                                        state = state and (85) or (86)
                                                        r70 = r33
                                                    end
                                                else
                                                    if state == 84 then
                                                        r33 = upvalueValues[upvalues[4]]
                                                        r12 = upvalueValues[upvalues[5]]
                                                        r85 = "\181\195\231zRY*\169\166"
                                                        r37 = 21143935886965
                                                        r70 = r12(r85, r37)
                                                        r29 = r33[r70]
                                                        state = r66[r29]
                                                        r29 = "Wait"
                                                        r29 = state[r29]
                                                        r29 = r29(state)
                                                        r85 = "\026\195\210kB\166\226"
                                                        state = upvalueValues[upvalues[6]]
                                                        r66 = nil
                                                        r33 = upvalueValues[upvalues[4]]
                                                        r12 = upvalueValues[upvalues[5]]
                                                        r37 = 10400191746794
                                                        r70 = r12(r85, r37)
                                                        r29 = r33[r70]
                                                        r33 = false
                                                        state[r29] = r33
                                                        ReturnVal = {}
                                                        state = nil
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 86 then
                                                if state <= 85 then
                                                    if state == 85 then
                                                        r38 = upvalueValues[upvalues[4]]
                                                        r57 = upvalueValues[upvalues[5]]
                                                        r45 = "@\182\163|\153\"+\128="
                                                        r2 = 20440259421486
                                                        r82 = r57(r45, r2)
                                                        r6 = "IsA"
                                                        r6 = r85[r6]
                                                        r21 = r38[r82]
                                                        r6 = r6(r85, r21)
                                                        state = r6 and (87) or (88)
                                                        r37 = r6
                                                    end
                                                else
                                                    if state == 86 then
                                                        r85 = nil
                                                        r70 = nil
                                                        state = 82
                                                    end
                                                end
                                            else
                                                if state == 87 then
                                                    state = r37 and (89) or (90)
                                                end
                                            end
                                        end
                                    else
                                        if state <= 91 then
                                            if state <= 89 then
                                                if state <= 88 then
                                                    if state == 88 then
                                                        r21 = state
                                                        r82 = upvalueValues[upvalues[4]]
                                                        r45 = upvalueValues[upvalues[5]]
                                                        r54 = "z\156t\254,%j\139\r\207"
                                                        r83 = 15243721972666
                                                        r2 = r45(r54, r83)
                                                        r38 = "IsA"
                                                        r38 = r85[r38]
                                                        r57 = r82[r2]
                                                        r38 = r38(r85, r57)
                                                        state = r38 and (91) or (92)
                                                        r6 = r38
                                                    end
                                                else
                                                    if state == 89 then
                                                        state = upvalueValues[upvalues[1]]
                                                        r6 = upvalueValues[upvalues[3]]
                                                        r57 = upvalueValues[upvalues[4]]
                                                        r82 = upvalueValues[upvalues[5]]
                                                        r54 = 32652945062757
                                                        r2 = "B'3\225\204+\1959)t\019>o\tB\185"
                                                        r45 = r82(r2, r54)
                                                        r38 = r57[r45]
                                                        r45 = upvalueValues[upvalues[4]]
                                                        r2 = upvalueValues[upvalues[5]]
                                                        r83 = "\213L\171\191\008\226\155\008\208Y\178\160j\134\238`\247\186\002\"{\185"
                                                        r5 = 6676650052645
                                                        r54 = r2(r83, r5)
                                                        r82 = r45[r54]
                                                        r37 = "Create"
                                                        r37 = state[r37]
                                                        r57 = 1
                                                        r45 = 1
                                                        r21 = {
                                                            [r38] = r57,
                                                            [r82] = r45
                                                        }
                                                        r37 = r37(state, r85, r6, r21)
                                                        state = "Play"
                                                        state = r37[state]
                                                        state = state(r37)
                                                        state = 93
                                                    end
                                                end
                                            else
                                                if state <= 90 then
                                                    if state == 90 then
                                                        r6 = upvalueValues[upvalues[4]]
                                                        r21 = upvalueValues[upvalues[5]]
                                                        state = "IsA"
                                                        state = r85[state]
                                                        r57 = "U`\226\213t"
                                                        r82 = 14527541582444
                                                        r38 = r21(r57, r82)
                                                        r37 = r6[r38]
                                                        state = state(r85, r37)
                                                        state = state and (94) or (93)
                                                    end
                                                else
                                                    if state == 91 then
                                                        state = r21
                                                        r37 = r6
                                                        state = 87
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 93 then
                                                if state <= 92 then
                                                    if state == 92 then
                                                        r82 = upvalueValues[upvalues[4]]
                                                        r45 = upvalueValues[upvalues[5]]
                                                        r54 = "j\135\021E\031\255\231"
                                                        r83 = 31038847858805
                                                        r2 = r45(r54, r83)
                                                        r57 = r82[r2]
                                                        r38 = "IsA"
                                                        r38 = r85[r38]
                                                        r38 = r38(r85, r57)
                                                        r6 = r38
                                                        state = 91
                                                    end
                                                else
                                                    if state == 93 then
                                                        state = 86
                                                    end
                                                end
                                            else
                                                if state == 94 then
                                                    state = upvalueValues[upvalues[1]]
                                                    r6 = upvalueValues[upvalues[3]]
                                                    r57 = upvalueValues[upvalues[4]]
                                                    r82 = upvalueValues[upvalues[5]]
                                                    r54 = 20525661922646
                                                    r2 = "\178tw\029M\233\163\128\"\175-\n\176@q3\018\168\149/wv"
                                                    r45 = r82(r2, r54)
                                                    r38 = r57[r45]
                                                    r37 = "Create"
                                                    r37 = state[r37]
                                                    r57 = 1
                                                    r21 = {
                                                        [r38] = r57
                                                    }
                                                    r37 = r37(state, r85, r6, r21)
                                                    state = "Play"
                                                    state = r37[state]
                                                    state = state(r37)
                                                    state = 93
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            if state <= 104 then
                                if state <= 99 then
                                    -- createClosure4 entry 12525329 -> 95, states 95-99
                                    if state <= 97 then
                                        if state <= 96 then
                                            if state <= 95 then
                                                if state == 95 then -- entry 12525329 -> 95
                                                    r66 = allocUpvalue()
                                                    upvalueValues[r66] = args[1]
                                                    r12 = upvalueValues[r66]
                                                    r85 = upvalueValues[upvalues[1]]
                                                    r37 = upvalueValues[upvalues[2]]
                                                    r21 = "S\203wS\151e\181\2276\156\131\180\129"
                                                    r38 = 25140999630267
                                                    r6 = r37(r21, r38)
                                                    r70 = r85[r6]
                                                    r33 = r12[r70]
                                                    r37 = "Enum"
                                                    r85 = _env[r37]
                                                    r6 = upvalueValues[upvalues[1]]
                                                    r21 = upvalueValues[upvalues[2]]
                                                    r82 = 18204414910749
                                                    r57 = "+\166\201+\160\139f\164D\214s\253\251"
                                                    r38 = r21(r57, r82)
                                                    r37 = r6[r38]
                                                    r70 = r85[r37]
                                                    r37 = upvalueValues[upvalues[1]]
                                                    r6 = upvalueValues[upvalues[2]]
                                                    r38 = "\235\025\180\222\229,\158\143{\232\209$"
                                                    r57 = 12841112196955
                                                    r21 = r6(r38, r57)
                                                    r85 = r37[r21]
                                                    r12 = r70[r85]
                                                    r29 = r33 == r12
                                                    state = r29 and (96) or (97)
                                                    ReturnVal = r29
                                                end
                                            else
                                                if state == 96 then
                                                    state = ReturnVal and (98) or (99)
                                                end
                                            end
                                        else
                                            if state == 97 then
                                                r12 = upvalueValues[r66]
                                                r85 = upvalueValues[upvalues[1]]
                                                r37 = upvalueValues[upvalues[2]]
                                                r38 = 23851149765474
                                                r21 = "\223\029\128n\215T\135\\CR\238\187\151"
                                                r6 = r37(r21, r38)
                                                r70 = r85[r6]
                                                r33 = r12[r70]
                                                r37 = "Enum"
                                                r85 = _env[r37]
                                                r6 = upvalueValues[upvalues[1]]
                                                r21 = upvalueValues[upvalues[2]]
                                                r57 = "\213V\193<\221\154\029A\229\249\000\159\233"
                                                r82 = 16278007061916
                                                r38 = r21(r57, r82)
                                                r37 = r6[r38]
                                                r70 = r85[r37]
                                                r37 = upvalueValues[upvalues[1]]
                                                r6 = upvalueValues[upvalues[2]]
                                                r38 = "\205#g\248\135"
                                                r57 = 15243628911546
                                                r21 = r6(r38, r57)
                                                r85 = r37[r21]
                                                r12 = r70[r85]
                                                r29 = r33 == r12
                                                ReturnVal = r29
                                                state = 96
                                            end
                                        end
                                    else
                                        if state <= 98 then
                                            if state == 98 then
                                                state = true
                                                upvalueValues[upvalues[3]] = state
                                                r29 = upvalueValues[r66]
                                                r12 = upvalueValues[upvalues[1]]
                                                r70 = upvalueValues[upvalues[2]]
                                                r6 = 32964405869558
                                                r37 = "$\136\233\229<\212\171\195"
                                                r85 = r70(r37, r6)
                                                r33 = r12[r85]
                                                ReturnVal = r29[r33]
                                                upvalueValues[upvalues[4]] = ReturnVal
                                                r33 = upvalueValues[upvalues[5]]
                                                r70 = upvalueValues[upvalues[1]]
                                                r85 = upvalueValues[upvalues[2]]
                                                r21 = 19893832180783
                                                r6 = "\139\241KOt\023\222\174"
                                                r37 = r85(r6, r21)
                                                r12 = r70[r37]
                                                r29 = r33[r12]
                                                upvalueValues[upvalues[6]] = r29
                                                r12 = upvalueValues[r66]
                                                r85 = upvalueValues[upvalues[1]]
                                                r37 = upvalueValues[upvalues[2]]
                                                r38 = 12304559822433
                                                r21 = "F\159\008\139\008G\154"
                                                r6 = r37(r21, r38)
                                                r70 = r85[r6]
                                                r33 = r12[r70]
                                                r70 = createClosure2(179, {
                                                    r66,
                                                    upvalues[1],
                                                    upvalues[2],
                                                    upvalues[3]
                                                })
                                                r12 = "Connect"
                                                r12 = r33[r12]
                                                r12 = r12(r33, r70)
                                                state = 99
                                            end
                                        else
                                            if state == 99 then
                                                ReturnVal = {}
                                                r66 = releaseUpvalue(r66)
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    -- createClosure2 entry 10305477 -> 100, states 100-104
                                    if state <= 102 then
                                        if state <= 101 then
                                            if state <= 100 then
                                                if state == 100 then -- entry 10305477 -> 100
                                                    r66 = args[1]
                                                    r70 = upvalueValues[upvalues[1]]
                                                    r85 = upvalueValues[upvalues[2]]
                                                    r6 = "\2194\226\164\134\030\030\201\0318?\re"
                                                    r21 = 27689110336093
                                                    r37 = r85(r6, r21)
                                                    r12 = r70[r37]
                                                    r33 = r66[r12]
                                                    r37 = "Enum"
                                                    r85 = _env[r37]
                                                    r6 = upvalueValues[upvalues[1]]
                                                    r21 = upvalueValues[upvalues[2]]
                                                    r82 = 11359815013545
                                                    r57 = "(t\218\202m\137\234\031\201?)o\137"
                                                    r38 = r21(r57, r82)
                                                    r37 = r6[r38]
                                                    r70 = r85[r37]
                                                    r37 = upvalueValues[upvalues[1]]
                                                    r6 = upvalueValues[upvalues[2]]
                                                    r38 = "\t~\226\255d\155\200\162,\161\211\148\139"
                                                    r57 = 24005680573354
                                                    r21 = r6(r38, r57)
                                                    r85 = r37[r21]
                                                    r12 = r70[r85]
                                                    r29 = r33 == r12
                                                    state = r29 and (101) or (102)
                                                    ReturnVal = r29
                                                end
                                            else
                                                if state == 101 then
                                                    state = ReturnVal and (103) or (104)
                                                end
                                            end
                                        else
                                            if state == 102 then
                                                r70 = upvalueValues[upvalues[1]]
                                                r85 = upvalueValues[upvalues[2]]
                                                r6 = "0\252d\2456\163\029\1806\157\162/s"
                                                r21 = 29638599489001
                                                r37 = r85(r6, r21)
                                                r12 = r70[r37]
                                                r33 = r66[r12]
                                                r37 = "Enum"
                                                r85 = _env[r37]
                                                r6 = upvalueValues[upvalues[1]]
                                                r21 = upvalueValues[upvalues[2]]
                                                r57 = "m\200\025\219\011`P\209=\029\135\015\207"
                                                r82 = 20631548798343
                                                r38 = r21(r57, r82)
                                                r37 = r6[r38]
                                                r70 = r85[r37]
                                                r37 = upvalueValues[upvalues[1]]
                                                r6 = upvalueValues[upvalues[2]]
                                                r57 = 26931910619389
                                                r38 = "\147\133\229\146\204"
                                                r21 = r6(r38, r57)
                                                r85 = r37[r21]
                                                r12 = r70[r85]
                                                r29 = r33 == r12
                                                ReturnVal = r29
                                                state = 101
                                            end
                                        end
                                    else
                                        if state <= 103 then
                                            if state == 103 then
                                                state = r66
                                                upvalueValues[upvalues[3]] = state
                                                state = 104
                                            end
                                        else
                                            if state == 104 then
                                                r66 = nil
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 109 then
                                    -- createClosure5 entry 1633931 -> 105, states 105-109
                                    if state <= 107 then
                                        if state <= 106 then
                                            if state <= 105 then
                                                if state == 105 then -- entry 1633931 -> 105
                                                    r66 = args[1]
                                                    r33 = upvalueValues[upvalues[1]]
                                                    r29 = r66 == r33
                                                    state = r29 and (106) or (107)
                                                    ReturnVal = r29
                                                end
                                            else
                                                if state == 106 then
                                                    r29 = upvalueValues[upvalues[2]]
                                                    ReturnVal = r29
                                                    state = 107
                                                end
                                            end
                                        else
                                            if state == 107 then
                                                state = ReturnVal and (108) or (109)
                                            end
                                        end
                                    else
                                        if state <= 108 then
                                            if state == 108 then
                                                r33 = upvalueValues[upvalues[3]]
                                                r12 = upvalueValues[upvalues[4]]
                                                r37 = 5904529132221
                                                r85 = "w\160\188\231zz\183\139"
                                                r70 = r12(r85, r37)
                                                r29 = r33[r70]
                                                ReturnVal = r66[r29]
                                                r29 = upvalueValues[upvalues[5]]
                                                state = ReturnVal - r29
                                                r29 = state
                                                state = upvalueValues[upvalues[6]]
                                                r33 = upvalueValues[upvalues[3]]
                                                r12 = upvalueValues[upvalues[4]]
                                                r85 = "\245\202)\193 \200\165\205"
                                                r37 = 12187797952043
                                                r70 = r12(r85, r37)
                                                ReturnVal = r33[r70]
                                                r70 = "UDim2"
                                                r12 = _env[r70]
                                                r85 = upvalueValues[upvalues[3]]
                                                r37 = upvalueValues[upvalues[4]]
                                                r21 = "\232\174\209"
                                                r38 = 15459116325918
                                                r6 = r37(r21, r38)
                                                r70 = r85[r6]
                                                r33 = r12[r70]
                                                r37 = upvalueValues[upvalues[7]]
                                                r21 = upvalueValues[upvalues[3]]
                                                r38 = upvalueValues[upvalues[4]]
                                                r45 = 1759004902195
                                                r82 = "\018"
                                                r57 = r38(r82, r45)
                                                r6 = r21[r57]
                                                r85 = r37[r6]
                                                r6 = upvalueValues[upvalues[3]]
                                                r21 = upvalueValues[upvalues[4]]
                                                r82 = 9656370909584
                                                r57 = "\151\210\252C>"
                                                r38 = r21(r57, r82)
                                                r37 = r6[r38]
                                                r70 = r85[r37]
                                                r21 = upvalueValues[upvalues[7]]
                                                r57 = upvalueValues[upvalues[3]]
                                                r82 = upvalueValues[upvalues[4]]
                                                r54 = 22135766378563
                                                r2 = "\171"
                                                r45 = r82(r2, r54)
                                                r38 = r57[r45]
                                                r6 = r21[r38]
                                                r38 = upvalueValues[upvalues[3]]
                                                r57 = upvalueValues[upvalues[4]]
                                                r2 = 16286546484640
                                                r45 = "=I\031\011\162o"
                                                r82 = r57(r45, r2)
                                                r21 = r38[r82]
                                                r37 = r6[r21]
                                                r38 = upvalueValues[upvalues[3]]
                                                r57 = upvalueValues[upvalues[4]]
                                                r45 = "\227"
                                                r2 = 30182032848614
                                                r82 = r57(r45, r2)
                                                r21 = r38[r82]
                                                r6 = r29[r21]
                                                r85 = r37 + r6
                                                r21 = upvalueValues[upvalues[7]]
                                                r57 = upvalueValues[upvalues[3]]
                                                r82 = upvalueValues[upvalues[4]]
                                                r54 = 8095330160313
                                                r2 = "\238"
                                                r45 = r82(r2, r54)
                                                r38 = r57[r45]
                                                r6 = r21[r38]
                                                r38 = upvalueValues[upvalues[3]]
                                                r57 = upvalueValues[upvalues[4]]
                                                r45 = "\160x\231\031\156"
                                                r2 = 26686738231434
                                                r82 = r57(r45, r2)
                                                r21 = r38[r82]
                                                r37 = r6[r21]
                                                r57 = upvalueValues[upvalues[7]]
                                                r45 = upvalueValues[upvalues[3]]
                                                r2 = upvalueValues[upvalues[4]]
                                                r83 = "O"
                                                r5 = 2948345202012
                                                r54 = r2(r83, r5)
                                                r82 = r45[r54]
                                                r38 = r57[r82]
                                                r82 = upvalueValues[upvalues[3]]
                                                r45 = upvalueValues[upvalues[4]]
                                                r83 = 33236329790580
                                                r54 = "T\247\136j@}"
                                                r2 = r45(r54, r83)
                                                r57 = r82[r2]
                                                r21 = r38[r57]
                                                r82 = upvalueValues[upvalues[3]]
                                                r45 = upvalueValues[upvalues[4]]
                                                r54 = "\017"
                                                r83 = 9706781036968
                                                r2 = r45(r54, r83)
                                                r57 = r82[r2]
                                                r38 = r29[r57]
                                                r6 = r21 + r38
                                                r12 = r33(r70, r85, r37, r6)
                                                r29 = nil
                                                state[ReturnVal] = r12
                                                state = 109
                                            end
                                        else
                                            if state == 109 then
                                                r66 = nil
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    -- createClosure2 entry 10462648 -> 110, states 110-117
                                    if state <= 113 then
                                        if state <= 111 then
                                            if state <= 110 then
                                                if state == 110 then -- entry 10462648 -> 110
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    r29 = upvalueValues[upvalues[2]]
                                                    r33 = upvalueValues[upvalues[3]]
                                                    r70 = "5J\195\194~\161\251\224\143"
                                                    r85 = 15789457398968
                                                    r12 = r33(r70, r85)
                                                    r66 = r29[r12]
                                                    state = ReturnVal[r66]
                                                    r66 = state
                                                    state = r66 and (111) or (112)
                                                end
                                            else
                                                if state == 111 then
                                                    ReturnVal = "pairs"
                                                    state = _env[ReturnVal]
                                                    r70 = "GetChildren"
                                                    r70 = r66[r70]
                                                    r12 = {
                                                        r70(r66)
                                                    }
                                                    r70 = {
                                                        state(unpack(r12))
                                                    }
                                                    ReturnVal = r70[1]
                                                    r29 = r70[2]
                                                    r12 = ReturnVal
                                                    r33 = r70[3]
                                                    state = 113
                                                end
                                            end
                                        else
                                            if state <= 112 then
                                                if state == 112 then
                                                    state = nil
                                                    r29 = nil
                                                    ReturnVal = {
                                                        state,
                                                        r29
                                                    }
                                                    state = nil
                                                end
                                            else
                                                if state == 113 then
                                                    r33, r85 = r12(r29, r33)
                                                    state = r33 and (114) or (115)
                                                end
                                            end
                                        end
                                    else
                                        if state <= 115 then
                                            if state <= 114 then
                                                if state == 114 then
                                                    r6 = upvalueValues[upvalues[2]]
                                                    state = "IsA"
                                                    state = r85[state]
                                                    r21 = upvalueValues[upvalues[3]]
                                                    r82 = 21903107467223
                                                    r57 = "\197[\217\163"
                                                    r38 = r21(r57, r82)
                                                    r37 = r6[r38]
                                                    state = state(r85, r37)
                                                    state = state and (116) or (117)
                                                    r70 = r33
                                                end
                                            else
                                                if state == 115 then
                                                    state = 112
                                                end
                                            end
                                        else
                                            if state <= 116 then
                                                if state == 116 then
                                                    r6 = upvalueValues[upvalues[2]]
                                                    r21 = upvalueValues[upvalues[3]]
                                                    r82 = 25984788115268
                                                    r57 = "\003wu\198"
                                                    r38 = r21(r57, r82)
                                                    r37 = r6[r38]
                                                    state = r85[r37]
                                                    r21 = upvalueValues[upvalues[2]]
                                                    r38 = upvalueValues[upvalues[3]]
                                                    r45 = 31033086326898
                                                    r82 = "\222E4"
                                                    r57 = r38(r82, r45)
                                                    r6 = r21[r57]
                                                    r38 = upvalueValues[upvalues[2]]
                                                    r57 = upvalueValues[upvalues[3]]
                                                    r2 = 19683141231565
                                                    r45 = ""
                                                    r82 = r57(r45, r2)
                                                    r21 = r38[r82]
                                                    r38 = "gsub"
                                                    r38 = state[r38]
                                                    r37 = {
                                                        r38(state, r6, r21)
                                                    }
                                                    ReturnVal = {
                                                        r85,
                                                        unpack(r37)
                                                    }
                                                    state = nil
                                                end
                                            else
                                                if state == 117 then
                                                    r70 = nil
                                                    r85 = nil
                                                    state = 113
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                else
                    if state <= 178 then
                        if state <= 153 then
                            if state <= 141 then
                                if state <= 140 then
                                    if state <= 132 then
                                        -- createClosure3 entry 6272453 -> 118, states 118-132
                                        if state <= 125 then
                                            if state <= 121 then
                                                if state <= 119 then
                                                    if state <= 118 then
                                                        if state == 118 then -- entry 6272453 -> 118
                                                            state = upvalueValues[upvalues[1]]
                                                            r29 = {
                                                                state()
                                                            }
                                                            ReturnVal = r29[1]
                                                            r66 = r29[2]
                                                            r29 = ReturnVal
                                                            r33 = not r29
                                                            state = r33 and (119) or (120)
                                                            ReturnVal = r33
                                                        end
                                                    else
                                                        if state == 119 then
                                                            state = ReturnVal and (121) or (122)
                                                        end
                                                    end
                                                else
                                                    if state <= 120 then
                                                        if state == 120 then
                                                            r70 = upvalueValues[upvalues[2]]
                                                            r37 = upvalueValues[upvalues[3]]
                                                            r6 = upvalueValues[upvalues[4]]
                                                            r57 = 10694248190835
                                                            r38 = "\176\228ne\003\182R\211\129"
                                                            r21 = r6(r38, r57)
                                                            r85 = r37[r21]
                                                            r12 = r70[r85]
                                                            r33 = not r12
                                                            ReturnVal = r33
                                                            state = 119
                                                        end
                                                    else
                                                        if state == 121 then
                                                            ReturnVal = {}
                                                            state = nil
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 123 then
                                                    if state <= 122 then
                                                        if state == 122 then
                                                            r33 = allocUpvalue()
                                                            state = false
                                                            upvalueValues[r33] = state
                                                            ReturnVal = upvalueValues[upvalues[2]]
                                                            r70 = upvalueValues[upvalues[3]]
                                                            r85 = upvalueValues[upvalues[4]]
                                                            r6 = "R\000\164r\164\233\146\211k"
                                                            r21 = 8153274044116
                                                            r37 = r85(r6, r21)
                                                            r12 = r70[r37]
                                                            state = ReturnVal[r12]
                                                            r12 = state
                                                            state = "FindFirstChild"
                                                            state = r12[state]
                                                            state = state(r12, r66)
                                                            state = state and (123) or (124)
                                                        end
                                                    else
                                                        if state == 123 then
                                                            state = r12[r66]
                                                            r85 = upvalueValues[upvalues[3]]
                                                            r37 = upvalueValues[upvalues[4]]
                                                            r38 = 34531227221711
                                                            r21 = "\024\168;=`\185\005\"\207/\170\218"
                                                            r6 = r37(r21, r38)
                                                            ReturnVal = "FindFirstChild"
                                                            ReturnVal = state[ReturnVal]
                                                            r70 = r85[r6]
                                                            ReturnVal = ReturnVal(state, r70)
                                                            r70 = allocUpvalue()
                                                            upvalueValues[r70] = ReturnVal
                                                            state = upvalueValues[r70]
                                                            state = state and (125) or (126)
                                                        end
                                                    end
                                                else
                                                    if state <= 124 then
                                                        if state == 124 then
                                                            ReturnVal = upvalueValues[r33]
                                                            state = not ReturnVal
                                                            state = state and (127) or (128)
                                                        end
                                                    else
                                                        if state == 125 then
                                                            r85 = createClosure4(182, {
                                                                r70,
                                                                r33
                                                            })
                                                            ReturnVal = "pcall"
                                                            state = _env[ReturnVal]
                                                            ReturnVal = state(r85)
                                                            state = 126
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 129 then
                                                if state <= 127 then
                                                    if state <= 126 then
                                                        if state == 126 then
                                                            r70 = releaseUpvalue(r70)
                                                            state = 124
                                                        end
                                                    else
                                                        if state == 127 then
                                                            state = upvalueValues[upvalues[5]]
                                                            r85 = upvalueValues[upvalues[3]]
                                                            r37 = upvalueValues[upvalues[4]]
                                                            r21 = ">\255g-\149\01417\231\231\220x"
                                                            r38 = 34563909041887
                                                            r6 = r37(r21, r38)
                                                            ReturnVal = "FindFirstChild"
                                                            ReturnVal = state[ReturnVal]
                                                            r70 = r85[r6]
                                                            ReturnVal = ReturnVal(state, r70)
                                                            r70 = ReturnVal
                                                            state = r70 and (129) or (130)
                                                        end
                                                    end
                                                else
                                                    if state <= 128 then
                                                        if state == 128 then
                                                            r29 = nil
                                                            r66 = nil
                                                            r12 = nil
                                                            ReturnVal = {}
                                                            r33 = releaseUpvalue(r33)
                                                            state = nil
                                                        end
                                                    else
                                                        if state == 129 then
                                                            r85 = upvalueValues[upvalues[3]]
                                                            r37 = upvalueValues[upvalues[4]]
                                                            r38 = 21537887332141
                                                            r21 = "\148X\026\198\030\202\155\246\212\215~a"
                                                            r6 = r37(r21, r38)
                                                            state = "FindFirstChild"
                                                            state = r70[state]
                                                            ReturnVal = r85[r6]
                                                            r85 = allocUpvalue()
                                                            state = state(r70, ReturnVal)
                                                            upvalueValues[r85] = state
                                                            state = upvalueValues[r85]
                                                            state = state and (131) or (132)
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 131 then
                                                    if state <= 130 then
                                                        if state == 130 then
                                                            r70 = nil
                                                            state = 128
                                                        end
                                                    else
                                                        if state == 131 then
                                                            r37 = createClosure0(183, {
                                                                r85
                                                            })
                                                            ReturnVal = "pcall"
                                                            state = _env[ReturnVal]
                                                            ReturnVal = state(r37)
                                                            state = 132
                                                        end
                                                    end
                                                else
                                                    if state == 132 then
                                                        r85 = releaseUpvalue(r85)
                                                        state = 130
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        -- createClosure2 entry 4075766 -> 133, states 133-140
                                        if state <= 136 then
                                            if state <= 134 then
                                                if state <= 133 then
                                                    if state == 133 then -- entry 4075766 -> 133
                                                        ReturnVal = upvalueValues[upvalues[1]]
                                                        state = not ReturnVal
                                                        state = state and (134) or (135)
                                                    end
                                                else
                                                    if state == 134 then
                                                        state = upvalueValues[upvalues[2]]
                                                        ReturnVal = state()
                                                        r66 = ReturnVal
                                                        r29 = not r66
                                                        state = r29 and (136) or (137)
                                                        ReturnVal = r29
                                                    end
                                                end
                                            else
                                                if state <= 135 then
                                                    if state == 135 then
                                                        ReturnVal = false
                                                        upvalueValues[upvalues[1]] = ReturnVal
                                                        r66 = upvalueValues[upvalues[6]]
                                                        r33 = upvalueValues[upvalues[4]]
                                                        r12 = upvalueValues[upvalues[5]]
                                                        r85 = "_\016\221\\\228K\144\160_\154#\026\t(\231u"
                                                        r37 = 7110587469039
                                                        r70 = r12(r85, r37)
                                                        r29 = r33[r70]
                                                        r70 = "Color3"
                                                        r12 = _env[r70]
                                                        r85 = upvalueValues[upvalues[4]]
                                                        r37 = upvalueValues[upvalues[5]]
                                                        r38 = 25422933913150
                                                        r21 = "\230\134\205\007H}\201"
                                                        r6 = r37(r21, r38)
                                                        r70 = r85[r6]
                                                        r33 = r12[r70]
                                                        r37 = 70
                                                        r85 = 130
                                                        r70 = 70
                                                        r12 = r33(r70, r85, r37)
                                                        r66[r29] = r12
                                                        r66 = upvalueValues[upvalues[6]]
                                                        r33 = upvalueValues[upvalues[4]]
                                                        r12 = upvalueValues[upvalues[5]]
                                                        r85 = "\223\144,B"
                                                        r37 = 32244109769382
                                                        r70 = r12(r85, r37)
                                                        r29 = r33[r70]
                                                        r12 = upvalueValues[upvalues[4]]
                                                        r70 = upvalueValues[upvalues[5]]
                                                        r6 = 33797325716858
                                                        r37 = "\198\027\233\031\n8\131\151\168\187\181[C"
                                                        r85 = r70(r37, r6)
                                                        r33 = r12[r85]
                                                        r66[r29] = r33
                                                        state = 138
                                                    end
                                                else
                                                    if state == 136 then
                                                        state = ReturnVal and (139) or (140)
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 138 then
                                                if state <= 137 then
                                                    if state == 137 then
                                                        r12 = upvalueValues[upvalues[3]]
                                                        r85 = upvalueValues[upvalues[4]]
                                                        r37 = upvalueValues[upvalues[5]]
                                                        r21 = "\162\196\207K\191\021\024\2371"
                                                        r38 = 27068647272764
                                                        r6 = r37(r21, r38)
                                                        r70 = r85[r6]
                                                        r33 = r12[r70]
                                                        r29 = not r33
                                                        ReturnVal = r29
                                                        state = 136
                                                    end
                                                else
                                                    if state == 138 then
                                                        ReturnVal = {}
                                                        state = nil
                                                    end
                                                end
                                            else
                                                if state <= 139 then
                                                    if state == 139 then
                                                        ReturnVal = {}
                                                        state = nil
                                                    end
                                                else
                                                    if state == 140 then
                                                        r21 = "~\203k\154\194\253\249"
                                                        state = true
                                                        upvalueValues[upvalues[1]] = state
                                                        ReturnVal = upvalueValues[upvalues[6]]
                                                        r33 = upvalueValues[upvalues[4]]
                                                        r12 = upvalueValues[upvalues[5]]
                                                        r37 = 32897702345687
                                                        r85 = "/\129\143\234e/\162P\029M\198B\012\209\202\220"
                                                        r70 = r12(r85, r37)
                                                        r38 = 16833565777566
                                                        r66 = nil
                                                        r29 = r33[r70]
                                                        r70 = "Color3"
                                                        r12 = _env[r70]
                                                        r85 = upvalueValues[upvalues[4]]
                                                        r37 = upvalueValues[upvalues[5]]
                                                        r6 = r37(r21, r38)
                                                        r70 = r85[r6]
                                                        r33 = r12[r70]
                                                        r85 = 50
                                                        r37 = 50
                                                        r70 = 140
                                                        r12 = r33(r70, r85, r37)
                                                        ReturnVal[r29] = r12
                                                        ReturnVal = upvalueValues[upvalues[6]]
                                                        r33 = upvalueValues[upvalues[4]]
                                                        r12 = upvalueValues[upvalues[5]]
                                                        r85 = "\153\2151\r"
                                                        r37 = 21522874656550
                                                        r70 = r12(r85, r37)
                                                        r29 = r33[r70]
                                                        r12 = upvalueValues[upvalues[4]]
                                                        r70 = upvalueValues[upvalues[5]]
                                                        r37 = "\248\150\191E\217_\2288M\155JP"
                                                        r6 = 18344879038814
                                                        r85 = r70(r37, r6)
                                                        r33 = r12[r85]
                                                        ReturnVal[r29] = r33
                                                        r29 = "spawn"
                                                        ReturnVal = _env[r29]
                                                        r33 = createClosure1(184, {
                                                            upvalues[1],
                                                            upvalues[2],
                                                            upvalues[3],
                                                            upvalues[4],
                                                            upvalues[5],
                                                            upvalues[6],
                                                            upvalues[7],
                                                            upvalues[8]
                                                        })
                                                        r29 = ReturnVal(r33)
                                                        state = 138
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure1 entry 266650 -> 141, states 141-141
                                    if state == 141 then -- entry 266650 -> 141
                                        state = upvalueValues[upvalues[1]]
                                        ReturnVal = state()
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            else
                                if state <= 144 then
                                    -- createClosure3 entry 9723197 -> 142, states 142-144
                                    if state <= 143 then
                                        if state <= 142 then
                                            if state == 142 then -- entry 9723197 -> 142
                                                state = upvalueValues[upvalues[1]]
                                                state = state and (143) or (144)
                                            end
                                        else
                                            if state == 143 then
                                                state = false
                                                upvalueValues[upvalues[1]] = state
                                                ReturnVal = upvalueValues[upvalues[2]]
                                                r29 = upvalueValues[upvalues[3]]
                                                r33 = upvalueValues[upvalues[4]]
                                                r85 = 8319734648610
                                                r70 = "N\173\226\140\019\022\024\201\240*\127\016\170O\031S"
                                                r12 = r33(r70, r85)
                                                r66 = r29[r12]
                                                r12 = "Color3"
                                                r33 = _env[r12]
                                                r70 = upvalueValues[upvalues[3]]
                                                r85 = upvalueValues[upvalues[4]]
                                                r21 = 8976364425299
                                                r6 = "h^y\127w2\240"
                                                r37 = r85(r6, r21)
                                                r12 = r70[r37]
                                                r29 = r33[r12]
                                                r70 = 130
                                                r85 = 70
                                                r12 = 70
                                                r33 = r29(r12, r70, r85)
                                                ReturnVal[r66] = r33
                                                ReturnVal = upvalueValues[upvalues[2]]
                                                r29 = upvalueValues[upvalues[3]]
                                                r33 = upvalueValues[upvalues[4]]
                                                r70 = "\149\187x>"
                                                r85 = 17014802833139
                                                r12 = r33(r70, r85)
                                                r66 = r29[r12]
                                                r33 = upvalueValues[upvalues[3]]
                                                r12 = upvalueValues[upvalues[4]]
                                                r37 = 34304522763878
                                                r85 = "\216T5\200H\170X@\030\031\196\246\224"
                                                r70 = r12(r85, r37)
                                                r29 = r33[r70]
                                                ReturnVal[r66] = r29
                                                state = 144
                                            end
                                        end
                                    else
                                        if state == 144 then
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure2 entry 9633845 -> 145, states 145-153
                                    if state <= 149 then
                                        if state <= 147 then
                                            if state <= 146 then
                                                if state <= 145 then
                                                    if state == 145 then -- entry 9633845 -> 145
                                                        ReturnVal = upvalueValues[upvalues[1]]
                                                        r29 = upvalueValues[upvalues[2]]
                                                        r33 = upvalueValues[upvalues[3]]
                                                        r70 = "\128\183\176F"
                                                        r85 = 1513571959488
                                                        r12 = r33(r70, r85)
                                                        r66 = r29[r12]
                                                        state = ReturnVal[r66]
                                                        r66 = state
                                                        r29 = upvalueValues[upvalues[2]]
                                                        r33 = upvalueValues[upvalues[3]]
                                                        r85 = 9814398865882
                                                        r70 = ""
                                                        r12 = r33(r70, r85)
                                                        ReturnVal = r29[r12]
                                                        state = r66 ~= ReturnVal
                                                        state = state and (146) or (147)
                                                    end
                                                else
                                                    if state == 146 then
                                                        state = upvalueValues[upvalues[4]]
                                                        r33 = upvalueValues[upvalues[2]]
                                                        r12 = upvalueValues[upvalues[3]]
                                                        r37 = 12978352691099
                                                        r85 = "\250\003\215\250\143"
                                                        r70 = r12(r85, r37)
                                                        r29 = r33[r70]
                                                        ReturnVal = "FindFirstChild"
                                                        ReturnVal = state[ReturnVal]
                                                        ReturnVal = ReturnVal(state, r29)
                                                        r29 = ReturnVal
                                                        state = r29 and (148) or (149)
                                                        ReturnVal = r29
                                                    end
                                                end
                                            else
                                                if state == 147 then
                                                    r66 = nil
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state <= 148 then
                                                if state == 148 then
                                                    r37 = upvalueValues[upvalues[2]]
                                                    r6 = upvalueValues[upvalues[3]]
                                                    r57 = 860427092368
                                                    r38 = "_\160\198\149\029\169M\243\226"
                                                    r21 = r6(r38, r57)
                                                    r85 = r37[r21]
                                                    r70 = "IsA"
                                                    r70 = r29[r70]
                                                    r70 = r70(r29, r85)
                                                    r12 = state
                                                    state = r70 and (150) or (151)
                                                    r33 = r70
                                                end
                                            else
                                                if state == 149 then
                                                    state = ReturnVal and (152) or (153)
                                                end
                                            end
                                        end
                                    else
                                        if state <= 151 then
                                            if state <= 150 then
                                                if state == 150 then
                                                    r37 = upvalueValues[upvalues[2]]
                                                    r6 = upvalueValues[upvalues[3]]
                                                    r57 = 9193935802553
                                                    r38 = "\138xN\031\002"
                                                    r21 = r6(r38, r57)
                                                    r85 = r37[r21]
                                                    r70 = r29[r85]
                                                    r33 = r70
                                                    state = 151
                                                end
                                            else
                                                if state == 151 then
                                                    state = r12
                                                    ReturnVal = r33
                                                    state = 149
                                                end
                                            end
                                        else
                                            if state <= 152 then
                                                if state == 152 then
                                                    r12 = upvalueValues[upvalues[2]]
                                                    r70 = upvalueValues[upvalues[3]]
                                                    r37 = "\222\132AM\173caw\234d"
                                                    r6 = 34516240023240
                                                    r85 = r70(r37, r6)
                                                    r33 = r12[r85]
                                                    ReturnVal = 1
                                                    r12 = 2
                                                    r85 = 3
                                                    r70 = 0
                                                    state = {
                                                        [ReturnVal] = r33,
                                                        [r12] = r70,
                                                        [r85] = r66
                                                    }
                                                    r33 = allocUpvalue()
                                                    r12 = createClosure4(192, {
                                                        upvalues[5],
                                                        upvalues[2],
                                                        upvalues[3],
                                                        r33
                                                    })
                                                    upvalueValues[r33] = state
                                                    ReturnVal = "pcall"
                                                    state = _env[ReturnVal]
                                                    ReturnVal = state(r12)
                                                    r33 = releaseUpvalue(r33)
                                                    state = 153
                                                end
                                            else
                                                if state == 153 then
                                                    r29 = nil
                                                    state = 147
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            if state <= 165 then
                                if state <= 154 then
                                    -- createClosure3 entry 3553335 -> 154, states 154-154
                                    if state == 154 then -- entry 3553335 -> 154
                                        r66 = allocUpvalue()
                                        upvalueValues[r66] = args[1]
                                        r33 = createClosure4(193, {
                                            r66,
                                            upvalues[1],
                                            upvalues[2]
                                        })
                                        ReturnVal = "pcall"
                                        state = _env[ReturnVal]
                                        r12 = {
                                            state(r33)
                                        }
                                        ReturnVal = r12[1]
                                        r33 = ReturnVal
                                        ReturnVal = {
                                            r33
                                        }
                                        r29 = r12[2]
                                        state = nil
                                    end
                                else
                                    -- createClosure2 entry 4888145 -> 155, states 155-165
                                    if state <= 160 then
                                        if state <= 157 then
                                            if state <= 156 then
                                                if state <= 155 then
                                                    if state == 155 then -- entry 4888145 -> 155
                                                        ReturnVal = upvalueValues[upvalues[1]]
                                                        state = not ReturnVal
                                                        upvalueValues[upvalues[1]] = state
                                                        ReturnVal = upvalueValues[upvalues[2]]
                                                        r29 = upvalueValues[upvalues[3]]
                                                        r33 = upvalueValues[upvalues[4]]
                                                        r70 = ">\169\205\131"
                                                        r85 = 22601085626652
                                                        r12 = r33(r70, r85)
                                                        r66 = r29[r12]
                                                        r33 = state
                                                        r70 = state
                                                        r85 = upvalueValues[upvalues[1]]
                                                        state = r85 and (156) or (157)
                                                        r12 = r85
                                                    end
                                                else
                                                    if state == 156 then
                                                        r37 = upvalueValues[upvalues[3]]
                                                        r6 = upvalueValues[upvalues[4]]
                                                        r57 = 15390077213694
                                                        r38 = "Y(\"l=\015\193\152P)\1358\000\245\210"
                                                        r21 = r6(r38, r57)
                                                        r85 = r37[r21]
                                                        r12 = r85
                                                        state = 157
                                                    end
                                                end
                                            else
                                                if state == 157 then
                                                    state = r70
                                                    state = r12 and (158) or (159)
                                                    r29 = r12
                                                end
                                            end
                                        else
                                            if state <= 159 then
                                                if state <= 158 then
                                                    if state == 158 then
                                                        ReturnVal[r66] = r29
                                                        ReturnVal = upvalueValues[upvalues[2]]
                                                        state = r33
                                                        r29 = upvalueValues[upvalues[3]]
                                                        r33 = upvalueValues[upvalues[4]]
                                                        r85 = 9154982547623
                                                        r70 = "\134\231?8?A\230\011 \220T\189s-\022\r"
                                                        r12 = r33(r70, r85)
                                                        r66 = r29[r12]
                                                        r70 = state
                                                        r33 = state
                                                        r85 = upvalueValues[upvalues[1]]
                                                        state = r85 and (160) or (161)
                                                        r12 = r85
                                                    end
                                                else
                                                    if state == 159 then
                                                        r70 = upvalueValues[upvalues[3]]
                                                        r85 = upvalueValues[upvalues[4]]
                                                        r6 = "A\023%\142@\249\t\219\245\221bH\008\151F\175"
                                                        r21 = 19102982382271
                                                        r37 = r85(r6, r21)
                                                        r12 = r70[r37]
                                                        r29 = r12
                                                        state = 158
                                                    end
                                                end
                                            else
                                                if state == 160 then
                                                    r6 = "Color3"
                                                    r37 = _env[r6]
                                                    r21 = upvalueValues[upvalues[3]]
                                                    r38 = upvalueValues[upvalues[4]]
                                                    r82 = "\017\131E\141\156\008\242"
                                                    r45 = 4455113295898
                                                    r57 = r38(r82, r45)
                                                    r6 = r21[r57]
                                                    r85 = r37[r6]
                                                    r6 = 50
                                                    r21 = 200
                                                    r38 = 50
                                                    r37 = r85(r6, r21, r38)
                                                    r12 = r37
                                                    state = 161
                                                end
                                            end
                                        end
                                    else
                                        if state <= 163 then
                                            if state <= 162 then
                                                if state <= 161 then
                                                    if state == 161 then
                                                        state = r70
                                                        state = r12 and (162) or (163)
                                                        r29 = r12
                                                    end
                                                else
                                                    if state == 162 then
                                                        ReturnVal[r66] = r29
                                                        ReturnVal = upvalueValues[upvalues[1]]
                                                        state = r33
                                                        state = ReturnVal and (164) or (165)
                                                    end
                                                end
                                            else
                                                if state == 163 then
                                                    r85 = "Color3"
                                                    r70 = _env[r85]
                                                    r37 = upvalueValues[upvalues[3]]
                                                    r6 = upvalueValues[upvalues[4]]
                                                    r38 = "\226T>\250\141\1458"
                                                    r57 = 4687512537222
                                                    r21 = r6(r38, r57)
                                                    r85 = r37[r21]
                                                    r12 = r70[r85]
                                                    r6 = 50
                                                    r37 = 50
                                                    r85 = 200
                                                    r70 = r12(r85, r37, r6)
                                                    r29 = r70
                                                    state = 162
                                                end
                                            end
                                        else
                                            if state <= 164 then
                                                if state == 164 then
                                                    r66 = "spawn"
                                                    ReturnVal = _env[r66]
                                                    r29 = createClosure3(196, {
                                                        upvalues[1],
                                                        upvalues[5],
                                                        upvalues[3],
                                                        upvalues[4],
                                                        upvalues[6],
                                                        upvalues[7],
                                                        upvalues[2]
                                                    })
                                                    r66 = ReturnVal(r29)
                                                    state = 165
                                                end
                                            else
                                                if state == 165 then
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 166 then
                                    -- createClosure0 entry 9753978 -> 166, states 166-166
                                    if state == 166 then -- entry 9753978 -> 166
                                        r33 = 8308162
                                        r29 = "TsvUB"
                                        r66 = r29 ^ r33
                                        ReturnVal = 7369321
                                        state = ReturnVal - r66
                                        r66 = state
                                        ReturnVal = "TcYdLha2h"
                                        state = ReturnVal / r66
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure2 entry 5784863 -> 167, states 167-178
                                    if state <= 172 then
                                        if state <= 169 then
                                            if state <= 168 then
                                                if state <= 167 then
                                                    if state == 167 then -- entry 5784863 -> 167
                                                        ReturnVal = upvalueValues[upvalues[1]]
                                                        r66 = upvalueValues[upvalues[2]]
                                                        state = ReturnVal ~= r66
                                                        state = state and (168) or (169)
                                                    end
                                                else
                                                    if state == 168 then
                                                        state = upvalueValues[upvalues[1]]
                                                        state = state and (170) or (171)
                                                    end
                                                end
                                            else
                                                if state == 169 then
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state <= 171 then
                                                if state <= 170 then
                                                    if state == 170 then
                                                        ReturnVal = upvalueValues[upvalues[3]]
                                                        r66 = upvalueValues[upvalues[1]]
                                                        state = ReturnVal[r66]
                                                        r66 = upvalueValues[upvalues[4]]
                                                        r29 = upvalueValues[upvalues[5]]
                                                        r70 = 16270424743320
                                                        r12 = "\170\209\208D\189\234;"
                                                        r33 = r29(r12, r70)
                                                        ReturnVal = r66[r33]
                                                        r66 = false
                                                        state[ReturnVal] = r66
                                                        state = 171
                                                    end
                                                else
                                                    if state == 171 then
                                                        state = upvalueValues[upvalues[6]]
                                                        r66 = upvalueValues[upvalues[4]]
                                                        r29 = upvalueValues[upvalues[5]]
                                                        r12 = "\207\211g\129#S$"
                                                        r70 = 18383319327088
                                                        r33 = r29(r12, r70)
                                                        ReturnVal = r66[r33]
                                                        r66 = true
                                                        state[ReturnVal] = r66
                                                        state = upvalueValues[upvalues[2]]
                                                        upvalueValues[upvalues[1]] = state
                                                        ReturnVal = upvalueValues[upvalues[7]]
                                                        r29 = upvalueValues[upvalues[4]]
                                                        r33 = upvalueValues[upvalues[5]]
                                                        r85 = 13250749356058
                                                        r70 = "v9\201g\127+\138\160Oq@\226\169<\139\203"
                                                        r12 = r33(r70, r85)
                                                        r66 = r29[r12]
                                                        r12 = "Color3"
                                                        r33 = _env[r12]
                                                        r70 = upvalueValues[upvalues[4]]
                                                        r85 = upvalueValues[upvalues[5]]
                                                        r6 = "\248\154a\157\212U\186"
                                                        r21 = 9902938870275
                                                        r37 = r85(r6, r21)
                                                        r12 = r70[r37]
                                                        r29 = r33[r12]
                                                        r70 = 60
                                                        r12 = 60
                                                        r85 = 70
                                                        r33 = r29(r12, r70, r85)
                                                        ReturnVal[r66] = r33
                                                        r66 = "pairs"
                                                        ReturnVal = _env[r66]
                                                        r12 = upvalueValues[upvalues[8]]
                                                        r85 = "GetChildren"
                                                        r85 = r12[r85]
                                                        r70 = {
                                                            r85(r12)
                                                        }
                                                        r12 = {
                                                            ReturnVal(unpack(r70))
                                                        }
                                                        r66 = r12[1]
                                                        r33 = r12[3]
                                                        r29 = r12[2]
                                                        state = 172
                                                    end
                                                end
                                            else
                                                if state == 172 then
                                                    r33, r70 = r66(r29, r33)
                                                    state = r33 and (173) or (174)
                                                end
                                            end
                                        end
                                    else
                                        if state <= 175 then
                                            if state <= 174 then
                                                if state <= 173 then
                                                    if state == 173 then
                                                        r85 = state
                                                        r21 = upvalueValues[upvalues[4]]
                                                        r38 = upvalueValues[upvalues[5]]
                                                        r82 = "\138*\174\\\128\148\151\000\176y"
                                                        r45 = 6378901441434
                                                        r57 = r38(r82, r45)
                                                        r6 = r21[r57]
                                                        r37 = "IsA"
                                                        r37 = r70[r37]
                                                        r37 = r37(r70, r6)
                                                        state = r37 and (175) or (176)
                                                        r12 = r33
                                                        ReturnVal = r37
                                                    end
                                                else
                                                    if state == 174 then
                                                        state = 169
                                                    end
                                                end
                                            else
                                                if state == 175 then
                                                    r6 = upvalueValues[upvalues[7]]
                                                    r37 = r70 ~= r6
                                                    ReturnVal = r37
                                                    state = 176
                                                end
                                            end
                                        else
                                            if state <= 177 then
                                                if state <= 176 then
                                                    if state == 176 then
                                                        state = r85
                                                        state = ReturnVal and (177) or (178)
                                                    end
                                                else
                                                    if state == 177 then
                                                        r85 = upvalueValues[upvalues[4]]
                                                        r37 = upvalueValues[upvalues[5]]
                                                        r21 = "\n\211\187_\204\204\253\223\158Y\142\t\131J\253S"
                                                        r38 = 19060782768811
                                                        r6 = r37(r21, r38)
                                                        ReturnVal = r85[r6]
                                                        r6 = "Color3"
                                                        r37 = _env[r6]
                                                        r21 = upvalueValues[upvalues[4]]
                                                        r38 = upvalueValues[upvalues[5]]
                                                        r82 = "R\146\\6.,E"
                                                        r45 = 17022833483510
                                                        r57 = r38(r82, r45)
                                                        r6 = r21[r57]
                                                        r85 = r37[r6]
                                                        r38 = 45
                                                        r6 = 40
                                                        r21 = 40
                                                        r37 = r85(r6, r21, r38)
                                                        r70[ReturnVal] = r37
                                                        state = 178
                                                    end
                                                end
                                            else
                                                if state == 178 then
                                                    r12 = nil
                                                    r70 = nil
                                                    state = 172
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    else
                        if state <= 192 then
                            if state <= 183 then
                                if state <= 182 then
                                    if state <= 181 then
                                        -- createClosure2 entry 997883 -> 179, states 179-181
                                        if state <= 180 then
                                            if state <= 179 then
                                                if state == 179 then -- entry 997883 -> 179
                                                    r66 = upvalueValues[upvalues[1]]
                                                    r33 = upvalueValues[upvalues[2]]
                                                    r12 = upvalueValues[upvalues[3]]
                                                    r85 = "\246A\163\236{\253\008\127\194\t\192}\227\245"
                                                    r37 = 14848085990146
                                                    r70 = r12(r85, r37)
                                                    r29 = r33[r70]
                                                    ReturnVal = r66[r29]
                                                    r12 = "Enum"
                                                    r33 = _env[r12]
                                                    r70 = upvalueValues[upvalues[2]]
                                                    r85 = upvalueValues[upvalues[3]]
                                                    r6 = "\190\027\178\029\170\139\180V+-\183\221\216x"
                                                    r21 = 23869660834667
                                                    r37 = r85(r6, r21)
                                                    r12 = r70[r37]
                                                    r29 = r33[r12]
                                                    r12 = upvalueValues[upvalues[2]]
                                                    r70 = upvalueValues[upvalues[3]]
                                                    r6 = 13384613288024
                                                    r37 = "\179\2332"
                                                    r85 = r70(r37, r6)
                                                    r33 = r12[r85]
                                                    r66 = r29[r33]
                                                    state = ReturnVal == r66
                                                    state = state and (180) or (181)
                                                end
                                            else
                                                if state == 180 then
                                                    state = false
                                                    upvalueValues[upvalues[4]] = state
                                                    state = 181
                                                end
                                            end
                                        else
                                            if state == 181 then
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    else
                                        -- createClosure4 entry 14629985 -> 182, states 182-182
                                        if state == 182 then -- entry 14629985 -> 182
                                            state = upvalueValues[upvalues[1]]
                                            ReturnVal = "FireServer"
                                            ReturnVal = state[ReturnVal]
                                            ReturnVal = ReturnVal(state)
                                            state = true
                                            upvalueValues[upvalues[2]] = state
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure0 entry 8017234 -> 183, states 183-183
                                    if state == 183 then -- entry 8017234 -> 183
                                        state = upvalueValues[upvalues[1]]
                                        ReturnVal = "FireServer"
                                        ReturnVal = state[ReturnVal]
                                        ReturnVal = ReturnVal(state)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            else
                                if state <= 191 then
                                    -- createClosure1 entry 10869034 -> 184, states 184-191
                                    if state <= 187 then
                                        if state <= 185 then
                                            if state <= 184 then
                                                if state == 184 then -- entry 10869034 -> 184
                                                    state = 185
                                                end
                                            else
                                                if state == 185 then
                                                    state = upvalueValues[upvalues[1]]
                                                    state = state and (186) or (187)
                                                end
                                            end
                                        else
                                            if state <= 186 then
                                                if state == 186 then
                                                    r29 = upvalueValues[upvalues[2]]
                                                    r33 = r29()
                                                    r66 = not r33
                                                    state = r66 and (188) or (189)
                                                    ReturnVal = r66
                                                end
                                            else
                                                if state == 187 then
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        end
                                    else
                                        if state <= 189 then
                                            if state <= 188 then
                                                if state == 188 then
                                                    state = ReturnVal and (190) or (191)
                                                end
                                            else
                                                if state == 189 then
                                                    r33 = upvalueValues[upvalues[3]]
                                                    r70 = upvalueValues[upvalues[4]]
                                                    r85 = upvalueValues[upvalues[5]]
                                                    r6 = "N\237.C\024tM]\147"
                                                    r21 = 8581104308123
                                                    r37 = r85(r6, r21)
                                                    r12 = r70[r37]
                                                    r29 = r33[r12]
                                                    r66 = not r29
                                                    ReturnVal = r66
                                                    state = 188
                                                end
                                            end
                                        else
                                            if state <= 190 then
                                                if state == 190 then
                                                    state = false
                                                    upvalueValues[upvalues[1]] = state
                                                    ReturnVal = upvalueValues[upvalues[6]]
                                                    r29 = upvalueValues[upvalues[4]]
                                                    r33 = upvalueValues[upvalues[5]]
                                                    r85 = 21738269009802
                                                    r70 = "\203\2550\208O\006\017\242\\\232B\020\0233\253V"
                                                    r12 = r33(r70, r85)
                                                    r66 = r29[r12]
                                                    r12 = "Color3"
                                                    r33 = _env[r12]
                                                    r70 = upvalueValues[upvalues[4]]
                                                    r85 = upvalueValues[upvalues[5]]
                                                    r21 = 24249408187420
                                                    r6 = "\159\238|\136\226X\174"
                                                    r37 = r85(r6, r21)
                                                    r12 = r70[r37]
                                                    r29 = r33[r12]
                                                    r12 = 70
                                                    r70 = 130
                                                    r85 = 70
                                                    r33 = r29(r12, r70, r85)
                                                    ReturnVal[r66] = r33
                                                    ReturnVal = upvalueValues[upvalues[6]]
                                                    r29 = upvalueValues[upvalues[4]]
                                                    r33 = upvalueValues[upvalues[5]]
                                                    r70 = "\219\145\214\025"
                                                    r85 = 20768902260167
                                                    r12 = r33(r70, r85)
                                                    r66 = r29[r12]
                                                    r33 = upvalueValues[upvalues[4]]
                                                    r12 = upvalueValues[upvalues[5]]
                                                    r37 = 2013013230505
                                                    r85 = "'\220m\214\1819\226(\130\137\176E\""
                                                    r70 = r12(r85, r37)
                                                    r29 = r33[r70]
                                                    ReturnVal[r66] = r29
                                                    r66 = nil
                                                    state = 187
                                                end
                                            else
                                                if state == 191 then
                                                    ReturnVal = upvalueValues[upvalues[7]]
                                                    r29 = ReturnVal()
                                                    r29 = state
                                                    r12 = "tonumber"
                                                    r33 = _env[r12]
                                                    r85 = upvalueValues[upvalues[8]]
                                                    r6 = upvalueValues[upvalues[4]]
                                                    r21 = upvalueValues[upvalues[5]]
                                                    r57 = "\008vD\220"
                                                    r82 = 26008413089615
                                                    r38 = r21(r57, r82)
                                                    r37 = r6[r38]
                                                    r70 = r85[r37]
                                                    r12 = r33(r70)
                                                    r33 = 0.1
                                                    ReturnVal = r12 or r33
                                                    r66 = ReturnVal
                                                    r33 = "task"
                                                    r29 = _env[r33]
                                                    r12 = upvalueValues[upvalues[4]]
                                                    r70 = upvalueValues[upvalues[5]]
                                                    r6 = 30425273169751
                                                    r37 = "G\027\173`"
                                                    r85 = r70(r37, r6)
                                                    r33 = r12[r85]
                                                    ReturnVal = r29[r33]
                                                    r70 = "math"
                                                    r12 = _env[r70]
                                                    r85 = upvalueValues[upvalues[4]]
                                                    r37 = upvalueValues[upvalues[5]]
                                                    r38 = 24148779609069
                                                    r21 = "\232t\207"
                                                    r6 = r37(r21, r38)
                                                    r70 = r85[r6]
                                                    r33 = r12[r70]
                                                    r70 = 0
                                                    r12 = {
                                                        r33(r70, r66)
                                                    }
                                                    r66 = nil
                                                    r29 = ReturnVal(unpack(r12))
                                                    state = 185
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure4 entry 12310085 -> 192, states 192-192
                                    if state == 192 then -- entry 12310085 -> 192
                                        state = upvalueValues[upvalues[1]]
                                        r29 = upvalueValues[upvalues[2]]
                                        ReturnVal = "WaitForChild"
                                        ReturnVal = state[ReturnVal]
                                        r33 = upvalueValues[upvalues[3]]
                                        r70 = "\014\188\248J\222($@R\210\178\146"
                                        r85 = 28872684401796
                                        r12 = r33(r70, r85)
                                        r66 = r29[r12]
                                        ReturnVal = ReturnVal(state, r66)
                                        state = "WaitForChild"
                                        state = ReturnVal[state]
                                        r29 = upvalueValues[upvalues[2]]
                                        r33 = upvalueValues[upvalues[3]]
                                        r70 = "\206\157\255I\155{h \246\181\1274"
                                        r85 = 1078210970102
                                        r12 = r33(r70, r85)
                                        r66 = r29[r12]
                                        state = state(ReturnVal, r66)
                                        r29 = "unpack"
                                        r66 = _env[r29]
                                        r33 = upvalueValues[upvalues[4]]
                                        ReturnVal = "FireServer"
                                        ReturnVal = state[ReturnVal]
                                        r29 = {
                                            r66(r33)
                                        }
                                        ReturnVal = ReturnVal(state, unpack(r29))
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            end
                        else
                            if state <= 223 then
                                if state <= 195 then
                                    -- createClosure4 entry 3572415 -> 193, states 193-195
                                    if state <= 194 then
                                        if state <= 193 then
                                            if state == 193 then -- entry 3572415 -> 193
                                                r29 = upvalueValues[upvalues[1]]
                                                r33 = nil
                                                r66 = r29 ~= r33
                                                state = r66 and (194) or (195)
                                                ReturnVal = r66
                                            end
                                        else
                                            if state == 194 then
                                                r33 = upvalueValues[upvalues[1]]
                                                r70 = upvalueValues[upvalues[2]]
                                                r85 = upvalueValues[upvalues[3]]
                                                r21 = 32229570263712
                                                r6 = "\165\180\184H\005\130"
                                                r37 = r85(r6, r21)
                                                r12 = r70[r37]
                                                r29 = r33[r12]
                                                r33 = nil
                                                r66 = r29 ~= r33
                                                ReturnVal = r66
                                                state = 195
                                            end
                                        end
                                    else
                                        if state == 195 then
                                            ReturnVal = {
                                                ReturnVal
                                            }
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure3 entry 14409303 -> 196, states 196-223
                                    if state <= 209 then
                                        if state <= 202 then
                                            if state <= 199 then
                                                if state <= 197 then
                                                    if state <= 196 then
                                                        if state == 196 then -- entry 14409303 -> 196
                                                            state = 197
                                                        end
                                                    else
                                                        if state == 197 then
                                                            state = upvalueValues[upvalues[1]]
                                                            state = state and (198) or (199)
                                                        end
                                                    end
                                                else
                                                    if state <= 198 then
                                                        if state == 198 then
                                                            r29 = upvalueValues[upvalues[2]]
                                                            r12 = upvalueValues[upvalues[3]]
                                                            r70 = upvalueValues[upvalues[4]]
                                                            r37 = "\161\1720\1656\000\021$\145"
                                                            r6 = 11167995778128
                                                            r85 = r70(r37, r6)
                                                            r33 = r12[r85]
                                                            r66 = r29[r33]
                                                            state = r66 and (200) or (201)
                                                            ReturnVal = r66
                                                        end
                                                    else
                                                        if state == 199 then
                                                            ReturnVal = {}
                                                            state = nil
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 201 then
                                                    if state <= 200 then
                                                        if state == 200 then
                                                            r29 = upvalueValues[upvalues[2]]
                                                            r12 = upvalueValues[upvalues[3]]
                                                            r70 = upvalueValues[upvalues[4]]
                                                            r6 = 30463526385513
                                                            r37 = "q\208_2UqW\2515"
                                                            r85 = r70(r37, r6)
                                                            r33 = r12[r85]
                                                            r66 = r29[r33]
                                                            r12 = upvalueValues[upvalues[3]]
                                                            r70 = upvalueValues[upvalues[4]]
                                                            r37 = "6\\F\246\\\185\253\025\143\253\029\134\017YP\226"
                                                            r6 = 35112785723358
                                                            r85 = r70(r37, r6)
                                                            r33 = r12[r85]
                                                            r29 = "FindFirstChild"
                                                            r29 = r66[r29]
                                                            r29 = r29(r66, r33)
                                                            ReturnVal = r29
                                                            state = 201
                                                        end
                                                    else
                                                        if state == 201 then
                                                            r66 = allocUpvalue()
                                                            upvalueValues[r66] = ReturnVal
                                                            state = upvalueValues[upvalues[5]]
                                                            r33 = upvalueValues[upvalues[3]]
                                                            r12 = upvalueValues[upvalues[4]]
                                                            ReturnVal = "FindFirstChild"
                                                            ReturnVal = state[ReturnVal]
                                                            r37 = 132403298365
                                                            r85 = "uFd9I\249"
                                                            r70 = r12(r85, r37)
                                                            r29 = r33[r70]
                                                            ReturnVal = ReturnVal(state, r29)
                                                            r29 = ReturnVal
                                                            r33 = upvalueValues[upvalues[5]]
                                                            r85 = upvalueValues[upvalues[3]]
                                                            r37 = upvalueValues[upvalues[4]]
                                                            r12 = "FindFirstChild"
                                                            r12 = r33[r12]
                                                            r21 = "\005\237\149"
                                                            r38 = 2389741749336
                                                            r6 = r37(r21, r38)
                                                            r70 = r85[r6]
                                                            r12 = r12(r33, r70)
                                                            state = r12 and (202) or (203)
                                                            ReturnVal = r12
                                                        end
                                                    end
                                                else
                                                    if state == 202 then
                                                        r12 = state
                                                        r85 = upvalueValues[upvalues[5]]
                                                        r6 = upvalueValues[upvalues[3]]
                                                        r21 = upvalueValues[upvalues[4]]
                                                        r57 = "\224\241\159"
                                                        r82 = 25351347531293
                                                        r38 = r21(r57, r82)
                                                        r37 = r6[r38]
                                                        r70 = r85[r37]
                                                        r6 = upvalueValues[upvalues[3]]
                                                        r21 = upvalueValues[upvalues[4]]
                                                        r57 = "\001\004 X\rp\181"
                                                        r82 = 32376513067748
                                                        r38 = r21(r57, r82)
                                                        r37 = r6[r38]
                                                        r85 = "FindFirstChild"
                                                        r85 = r70[r85]
                                                        r85 = r85(r70, r37)
                                                        state = r85 and (204) or (205)
                                                        r33 = r85
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 206 then
                                                if state <= 204 then
                                                    if state <= 203 then
                                                        if state == 203 then
                                                            r33 = ReturnVal
                                                            r70 = upvalueValues[upvalues[6]]
                                                            r85 = r70(r29)
                                                            r12 = not r85
                                                            state = r12 and (206) or (207)
                                                            ReturnVal = r12
                                                        end
                                                    else
                                                        if state == 204 then
                                                            r21 = upvalueValues[upvalues[5]]
                                                            r57 = upvalueValues[upvalues[3]]
                                                            r82 = upvalueValues[upvalues[4]]
                                                            r54 = 1002695360978
                                                            r2 = "3\003;"
                                                            r45 = r82(r2, r54)
                                                            r38 = r57[r45]
                                                            r6 = r21[r38]
                                                            r38 = upvalueValues[upvalues[3]]
                                                            r57 = upvalueValues[upvalues[4]]
                                                            r45 = "v\236\006\245\2437\008"
                                                            r2 = 18538254557624
                                                            r82 = r57(r45, r2)
                                                            r21 = r38[r82]
                                                            r37 = r6[r21]
                                                            r38 = upvalueValues[upvalues[3]]
                                                            r57 = upvalueValues[upvalues[4]]
                                                            r2 = 27488208433664
                                                            r45 = "\212\205\246AF"
                                                            r82 = r57(r45, r2)
                                                            r21 = r38[r82]
                                                            r6 = "FindFirstChild"
                                                            r6 = r37[r6]
                                                            r6 = r6(r37, r21)
                                                            r85 = state
                                                            state = r6 and (208) or (209)
                                                            r70 = r6
                                                        end
                                                    end
                                                else
                                                    if state <= 205 then
                                                        if state == 205 then
                                                            state = r12
                                                            ReturnVal = r33
                                                            state = 203
                                                        end
                                                    else
                                                        if state == 206 then
                                                            r70 = upvalueValues[upvalues[6]]
                                                            r85 = r70(r33)
                                                            r12 = not r85
                                                            ReturnVal = r12
                                                            state = 207
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 208 then
                                                    if state <= 207 then
                                                        if state == 207 then
                                                            state = ReturnVal and (210) or (211)
                                                        end
                                                    else
                                                        if state == 208 then
                                                            r38 = upvalueValues[upvalues[5]]
                                                            r82 = upvalueValues[upvalues[3]]
                                                            r45 = upvalueValues[upvalues[4]]
                                                            r54 = "\0038\147"
                                                            r83 = 9322430025973
                                                            r2 = r45(r54, r83)
                                                            r57 = r82[r2]
                                                            r21 = r38[r57]
                                                            r57 = upvalueValues[upvalues[3]]
                                                            r82 = upvalueValues[upvalues[4]]
                                                            r2 = "\145\147u\161AmT"
                                                            r54 = 27514618982924
                                                            r45 = r82(r2, r54)
                                                            r38 = r57[r45]
                                                            r6 = r21[r38]
                                                            r38 = upvalueValues[upvalues[3]]
                                                            r57 = upvalueValues[upvalues[4]]
                                                            r45 = "\242\132D\001\012"
                                                            r2 = 9318639161587
                                                            r82 = r57(r45, r2)
                                                            r21 = r38[r82]
                                                            r37 = r6[r21]
                                                            r38 = upvalueValues[upvalues[3]]
                                                            r57 = upvalueValues[upvalues[4]]
                                                            r6 = "FindFirstChild"
                                                            r6 = r37[r6]
                                                            r2 = 8442580684635
                                                            r45 = "\137\143%\024\233k\026U"
                                                            r82 = r57(r45, r2)
                                                            r21 = r38[r82]
                                                            r6 = r6(r37, r21)
                                                            r70 = r6
                                                            state = 209
                                                        end
                                                    end
                                                else
                                                    if state == 209 then
                                                        state = r85
                                                        r33 = r70
                                                        state = 205
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 216 then
                                            if state <= 213 then
                                                if state <= 211 then
                                                    if state <= 210 then
                                                        if state == 210 then
                                                            state = false
                                                            upvalueValues[upvalues[1]] = state
                                                            ReturnVal = upvalueValues[upvalues[7]]
                                                            r70 = upvalueValues[upvalues[3]]
                                                            r85 = upvalueValues[upvalues[4]]
                                                            r21 = 32339697629907
                                                            r6 = "\133\250\213\\"
                                                            r37 = r85(r6, r21)
                                                            r12 = r70[r37]
                                                            r82 = 10133678215790
                                                            r85 = upvalueValues[upvalues[3]]
                                                            r37 = upvalueValues[upvalues[4]]
                                                            r66 = releaseUpvalue(r66)
                                                            r21 = "+\226\245k\248\150\025j\139x\133\160\031\253Vl"
                                                            r38 = 10832211137460
                                                            r6 = r37(r21, r38)
                                                            r33 = nil
                                                            r70 = r85[r6]
                                                            ReturnVal[r12] = r70
                                                            ReturnVal = upvalueValues[upvalues[7]]
                                                            r70 = upvalueValues[upvalues[3]]
                                                            r85 = upvalueValues[upvalues[4]]
                                                            r21 = 18256979550517
                                                            r6 = "H\242O\n\023\152a\168+b\176\160i\252X&"
                                                            r37 = r85(r6, r21)
                                                            r12 = r70[r37]
                                                            r37 = "Color3"
                                                            r85 = _env[r37]
                                                            r6 = upvalueValues[upvalues[3]]
                                                            r21 = upvalueValues[upvalues[4]]
                                                            r57 = ".\179\218\130]\139\217"
                                                            r38 = r21(r57, r82)
                                                            r37 = r6[r38]
                                                            r70 = r85[r37]
                                                            r6 = 50
                                                            r21 = 50
                                                            r37 = 200
                                                            r29 = nil
                                                            r85 = r70(r37, r6, r21)
                                                            ReturnVal[r12] = r85
                                                            state = 199
                                                        end
                                                    else
                                                        if state == 211 then
                                                            ReturnVal = upvalueValues[r66]
                                                            state = ReturnVal and (212) or (213)
                                                        end
                                                    end
                                                else
                                                    if state <= 212 then
                                                        if state == 212 then
                                                            ReturnVal = upvalueValues[upvalues[6]]
                                                            r12 = ReturnVal(r29)
                                                            state = r12 and (214) or (215)
                                                        end
                                                    else
                                                        if state == 213 then
                                                            r38 = 9465546133815
                                                            r33 = nil
                                                            r70 = "task"
                                                            r12 = _env[r70]
                                                            r85 = upvalueValues[upvalues[3]]
                                                            r37 = upvalueValues[upvalues[4]]
                                                            r21 = "\130z\131D"
                                                            r6 = r37(r21, r38)
                                                            r70 = r85[r6]
                                                            r29 = nil
                                                            r66 = releaseUpvalue(r66)
                                                            ReturnVal = r12[r70]
                                                            r70 = 0.3
                                                            r12 = ReturnVal(r70)
                                                            state = 197
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 215 then
                                                    if state <= 214 then
                                                        if state == 214 then
                                                            r12 = "pairs"
                                                            ReturnVal = _env[r12]
                                                            r6 = "GetChildren"
                                                            r6 = r29[r6]
                                                            r37 = {
                                                                r6(r29)
                                                            }
                                                            r6 = {
                                                                ReturnVal(unpack(r37))
                                                            }
                                                            r12 = r6[1]
                                                            r85 = r6[3]
                                                            r70 = r6[2]
                                                            state = 216
                                                        end
                                                    else
                                                        if state == 215 then
                                                            ReturnVal = upvalueValues[upvalues[6]]
                                                            r12 = ReturnVal(r33)
                                                            state = r12 and (217) or (218)
                                                        end
                                                    end
                                                else
                                                    if state == 216 then
                                                        r85, r6 = r12(r70, r85)
                                                        state = r85 and (219) or (220)
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 220 then
                                                if state <= 218 then
                                                    if state <= 217 then
                                                        if state == 217 then
                                                            r12 = "pairs"
                                                            ReturnVal = _env[r12]
                                                            r6 = "GetChildren"
                                                            r6 = r33[r6]
                                                            r37 = {
                                                                r6(r33)
                                                            }
                                                            r6 = {
                                                                ReturnVal(unpack(r37))
                                                            }
                                                            r85 = r6[3]
                                                            r12 = r6[1]
                                                            r70 = r6[2]
                                                            state = 221
                                                        end
                                                    else
                                                        if state == 218 then
                                                            state = 213
                                                        end
                                                    end
                                                else
                                                    if state <= 219 then
                                                        if state == 219 then
                                                            r54 = 11692638229828
                                                            ReturnVal = allocUpvalue()
                                                            r37 = r85
                                                            upvalueValues[ReturnVal] = r6
                                                            r6 = ReturnVal
                                                            r38 = createClosure2(224, {
                                                                r66,
                                                                r6
                                                            })
                                                            r21 = "pcall"
                                                            r2 = "k\226+\251"
                                                            r37 = nil
                                                            ReturnVal = _env[r21]
                                                            r21 = ReturnVal(r38)
                                                            r38 = "task"
                                                            r21 = _env[r38]
                                                            r57 = upvalueValues[upvalues[3]]
                                                            r82 = upvalueValues[upvalues[4]]
                                                            r45 = r82(r2, r54)
                                                            r6 = releaseUpvalue(r6)
                                                            r38 = r57[r45]
                                                            ReturnVal = r21[r38]
                                                            r21 = ReturnVal()
                                                            state = 216
                                                        end
                                                    else
                                                        if state == 220 then
                                                            state = 215
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 222 then
                                                    if state <= 221 then
                                                        if state == 221 then
                                                            r85, r6 = r12(r70, r85)
                                                            state = r85 and (222) or (223)
                                                        end
                                                    else
                                                        if state == 222 then
                                                            r37 = r85
                                                            r2 = "\244mI\152"
                                                            ReturnVal = allocUpvalue()
                                                            upvalueValues[ReturnVal] = r6
                                                            r6 = ReturnVal
                                                            r21 = "pcall"
                                                            ReturnVal = _env[r21]
                                                            r38 = createClosure1(225, {
                                                                r66,
                                                                r6
                                                            })
                                                            r21 = ReturnVal(r38)
                                                            r54 = 27450915353070
                                                            r38 = "task"
                                                            r37 = nil
                                                            r21 = _env[r38]
                                                            r6 = releaseUpvalue(r6)
                                                            r57 = upvalueValues[upvalues[3]]
                                                            r82 = upvalueValues[upvalues[4]]
                                                            r45 = r82(r2, r54)
                                                            r38 = r57[r45]
                                                            ReturnVal = r21[r38]
                                                            r21 = ReturnVal()
                                                            state = 221
                                                        end
                                                    end
                                                else
                                                    if state == 223 then
                                                        state = 218
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 224 then
                                    -- createClosure2 entry 13054213 -> 224, states 224-224
                                    if state == 224 then -- entry 13054213 -> 224
                                        ReturnVal = "firetouchinterest"
                                        state = _env[ReturnVal]
                                        r66 = upvalueValues[upvalues[1]]
                                        r29 = upvalueValues[upvalues[2]]
                                        r33 = 0
                                        ReturnVal = state(r66, r29, r33)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                else
                                    -- createClosure1 entry 1444290 -> 225, states 225-225
                                    if state == 225 then -- entry 1444290 -> 225
                                        ReturnVal = "firetouchinterest"
                                        state = _env[ReturnVal]
                                        r66 = upvalueValues[upvalues[1]]
                                        r29 = upvalueValues[upvalues[2]]
                                        r33 = 0
                                        ReturnVal = state(r66, r29, r33)
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
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return -923535
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -923535
                    end
                })
            end
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
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)