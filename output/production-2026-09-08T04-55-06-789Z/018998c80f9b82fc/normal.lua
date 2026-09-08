return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, createClosure1, releaseUpvalues, upvalueRefCounts, createClosure4, createUpvalueProxy, createClosure0, createClosure, createClosure5, createClosure6, allocUpvalue, upvalueValues, releaseUpvalue, createClosure3, vm, createClosure2, currentUpvalueId)
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        currentUpvalueId = 0
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
        createClosure0 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function()
                return vm(entryId, {}, captures, gcProxy)
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
                    return -3464363
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -3464363
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
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, ReturnVal, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61
            while state do
                if state <= 99 then
                    if state <= 48 then
                        if state <= 35 then
                            if state <= 34 then
                                if state <= 33 then
                                    -- root entry 15023923 -> 1, states 1-33
                                    if state <= 17 then
                                        if state <= 9 then
                                            if state <= 5 then
                                                if state <= 3 then
                                                    if state <= 2 then
                                                        if state <= 1 then
                                                            if state == 1 then -- entry 15023923 -> 1
                                                                r57 = allocUpvalue()
                                                                r3 = allocUpvalue()
                                                                r10 = allocUpvalue()
                                                                state = true
                                                                upvalueValues[r57] = state
                                                                r32 = "string"
                                                                ReturnVal = _env[r32]
                                                                r32 = "gmatch"
                                                                state = ReturnVal[r32]
                                                                r4 = createClosure2(34, {
                                                                    r10
                                                                })
                                                                r32 = allocUpvalue()
                                                                upvalueValues[r32] = state
                                                                state = createClosure0(35, {})
                                                                upvalueValues[r3] = state
                                                                state = false
                                                                upvalueValues[r10] = state
                                                                r33 = "pcall"
                                                                r60 = _env[r33]
                                                                r33 = r60(r4)
                                                                state = r33 and (2) or (3)
                                                                r7 = args
                                                                ReturnVal = r33
                                                            end
                                                        else
                                                            if state == 2 then
                                                                r60 = upvalueValues[r10]
                                                                ReturnVal = r60
                                                                state = 3
                                                            end
                                                        end
                                                    else
                                                        if state == 3 then
                                                            r60 = ReturnVal
                                                            r33 = "math"
                                                            ReturnVal = _env[r33]
                                                            r33 = "random"
                                                            state = ReturnVal[r33]
                                                            r33 = allocUpvalue()
                                                            upvalueValues[r33] = state
                                                            r4 = "table"
                                                            ReturnVal = _env[r4]
                                                            r4 = "concat"
                                                            state = ReturnVal[r4]
                                                            r4 = state
                                                            r18 = state
                                                            r23 = "table"
                                                            r50 = _env[r23]
                                                            state = r50 and (4) or (5)
                                                            r51 = r50
                                                        end
                                                    end
                                                else
                                                    if state <= 4 then
                                                        if state == 4 then
                                                            r22 = "table"
                                                            r23 = _env[r22]
                                                            r22 = "unpack"
                                                            r50 = r23[r22]
                                                            r51 = r50
                                                            state = 5
                                                        end
                                                    else
                                                        if state == 5 then
                                                            state = r18
                                                            state = r51 and (6) or (7)
                                                            ReturnVal = r51
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 7 then
                                                    if state <= 6 then
                                                        if state == 6 then
                                                            r51 = allocUpvalue()
                                                            upvalueValues[r51] = ReturnVal
                                                            state = upvalueValues[r33]
                                                            r18 = 3
                                                            r50 = 65
                                                            ReturnVal = state(r18, r50)
                                                            r54 = createClosure5(36, {})
                                                            r18 = allocUpvalue()
                                                            upvalueValues[r18] = ReturnVal
                                                            r22 = "pcall"
                                                            ReturnVal = _env[r22]
                                                            r22 = {
                                                                ReturnVal(r54)
                                                            }
                                                            state = 0
                                                            r50 = state
                                                            state = 0
                                                            r23 = state
                                                            state = {
                                                                unpack(r22)
                                                            }
                                                            r22 = state
                                                            ReturnVal = 2
                                                            state = r22[ReturnVal]
                                                            r54 = state
                                                            ReturnVal = "tonumber"
                                                            state = _env[ReturnVal]
                                                            r19 = upvalueValues[r32]
                                                            r47 = "tostring"
                                                            r45 = _env[r47]
                                                            r47 = r45(r54)
                                                            r45 = ":(%d*):"
                                                            r20 = r19(r47, r45)
                                                            r19 = {
                                                                r20()
                                                            }
                                                            ReturnVal = state(unpack(r19))
                                                            r19 = allocUpvalue()
                                                            upvalueValues[r19] = ReturnVal
                                                            r20 = upvalueValues[r18]
                                                            r45 = r20
                                                            r20 = 1
                                                            r47 = r20
                                                            r20 = 0
                                                            r6 = r47 < r20
                                                            ReturnVal = 1
                                                            r20 = ReturnVal - r47
                                                            state = 8
                                                        end
                                                    else
                                                        if state == 7 then
                                                            r18 = "unpack"
                                                            r51 = _env[r18]
                                                            ReturnVal = r51
                                                            state = 6
                                                        end
                                                    end
                                                else
                                                    if state <= 8 then
                                                        if state == 8 then
                                                            r1 = not r6
                                                            r20 = r20 + r47
                                                            ReturnVal = r20 <= r45
                                                            ReturnVal = r1 and ReturnVal
                                                            r1 = r20 >= r45
                                                            r1 = r6 and r1
                                                            ReturnVal = r1 or ReturnVal
                                                            r1 = (9)
                                                            state = ReturnVal and r1
                                                            ReturnVal = (10)
                                                            state = state or ReturnVal
                                                        end
                                                    else
                                                        if state == 9 then
                                                            r1 = allocUpvalue()
                                                            upvalueValues[r1] = r20
                                                            r40 = "math"
                                                            ReturnVal = _env[r40]
                                                            r40 = "random"
                                                            state = ReturnVal[r40]
                                                            r30 = 100
                                                            r40 = 1
                                                            ReturnVal = state(r40, r30)
                                                            r40 = allocUpvalue()
                                                            upvalueValues[r40] = ReturnVal
                                                            state = upvalueValues[r33]
                                                            r30 = 0
                                                            r43 = 255
                                                            ReturnVal = state(r30, r43)
                                                            r30 = allocUpvalue()
                                                            upvalueValues[r30] = ReturnVal
                                                            state = upvalueValues[r33]
                                                            r42 = upvalueValues[r40]
                                                            r43 = 1
                                                            ReturnVal = state(r43, r42)
                                                            r43 = allocUpvalue()
                                                            upvalueValues[r43] = ReturnVal
                                                            ReturnVal = upvalueValues[r33]
                                                            r12 = 2
                                                            r44 = 1
                                                            r42 = ReturnVal(r44, r12)
                                                            ReturnVal = 1
                                                            state = r42 == ReturnVal
                                                            r42 = allocUpvalue()
                                                            upvalueValues[r42] = state
                                                            r55 = "tostring"
                                                            r2 = _env[r55]
                                                            r46 = upvalueValues[r33]
                                                            r24 = 0
                                                            r53 = 10000
                                                            r61 = {
                                                                r46(r24, r53)
                                                            }
                                                            r55 = r2(unpack(r61))
                                                            r2 = ":"
                                                            r14 = r55 .. r2
                                                            state = "gsub"
                                                            state = r54[state]
                                                            r12 = ":"
                                                            r44 = r12 .. r14
                                                            ReturnVal = ":(%d*):"
                                                            state = state(r54, ReturnVal, r44)
                                                            r44 = allocUpvalue()
                                                            upvalueValues[r44] = state
                                                            r14 = createClosure4(37, {
                                                                r33,
                                                                r1,
                                                                r18,
                                                                r32,
                                                                r57,
                                                                r19,
                                                                r42,
                                                                r44,
                                                                r40,
                                                                r43,
                                                                r30,
                                                                r51
                                                            })
                                                            r12 = "pcall"
                                                            ReturnVal = _env[r12]
                                                            r12 = {
                                                                ReturnVal(r14)
                                                            }
                                                            state = {
                                                                unpack(r12)
                                                            }
                                                            r12 = state
                                                            state = upvalueValues[r42]
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
                                                            r45 = upvalueValues[r57]
                                                            state = r45 and (13) or (14)
                                                            r20 = r45
                                                        end
                                                    else
                                                        if state == 11 then
                                                            r14 = upvalueValues[r57]
                                                            state = r14 and (15) or (16)
                                                            ReturnVal = r14
                                                        end
                                                    end
                                                else
                                                    if state <= 12 then
                                                        if state == 12 then
                                                            r2 = upvalueValues[r57]
                                                            state = r2 and (17) or (18)
                                                            r14 = r2
                                                        end
                                                    else
                                                        if state == 13 then
                                                            r45 = r50 == r23
                                                            r20 = r45
                                                            state = 14
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 15 then
                                                    if state <= 14 then
                                                        if state == 14 then
                                                            upvalueValues[r57] = r20
                                                            state = upvalueValues[r57]
                                                            state = state and (19) or (20)
                                                        end
                                                    else
                                                        if state == 15 then
                                                            r2 = state
                                                            r61 = 1
                                                            r46 = r12[r61]
                                                            r61 = false
                                                            r55 = r46 == r61
                                                            state = r55 and (21) or (22)
                                                            r14 = r55
                                                        end
                                                    end
                                                else
                                                    if state <= 16 then
                                                        if state == 16 then
                                                            upvalueValues[r57] = ReturnVal
                                                            state = 23
                                                        end
                                                    else
                                                        if state == 17 then
                                                            r55 = 1
                                                            r2 = r12[r55]
                                                            r14 = r2
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
                                                            upvalueValues[r57] = r14
                                                            r61 = upvalueValues[r43]
                                                            r24 = 1
                                                            r46 = r61 + r24
                                                            r55 = r12[r46]
                                                            r2 = r50 + r55
                                                            r55 = 256
                                                            state = r2 % r55
                                                            r50 = state
                                                            r46 = upvalueValues[r30]
                                                            r55 = r23 + r46
                                                            r46 = 256
                                                            r2 = r55 % r46
                                                            r23 = r2
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
                                                            r61 = 2
                                                            r46 = r12[r61]
                                                            r61 = upvalueValues[r44]
                                                            r55 = r46 == r61
                                                            r14 = r55
                                                            state = 22
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 23 then
                                                    if state <= 22 then
                                                        if state == 22 then
                                                            state = r2
                                                            ReturnVal = r14
                                                            state = 16
                                                        end
                                                    else
                                                        if state == 23 then
                                                            r42 = releaseUpvalue(r42)
                                                            r43 = releaseUpvalue(r43)
                                                            r44 = releaseUpvalue(r44)
                                                            r40 = releaseUpvalue(r40)
                                                            r12 = nil
                                                            r1 = releaseUpvalue(r1)
                                                            r30 = releaseUpvalue(r30)
                                                            state = 8
                                                        end
                                                    end
                                                else
                                                    if state <= 24 then
                                                        if state == 24 then
                                                            r51 = releaseUpvalue(r51)
                                                            r10 = releaseUpvalue(r10)
                                                            r3 = releaseUpvalue(r3)
                                                            r19 = releaseUpvalue(r19)
                                                            r33 = releaseUpvalue(r33)
                                                            r57 = releaseUpvalue(r57)
                                                            r32 = releaseUpvalue(r32)
                                                            r19 = 256
                                                            r6 = r19
                                                            r3 = allocUpvalue()
                                                            r18 = releaseUpvalue(r18)
                                                            r57 = nil
                                                            upvalueValues[r3] = r57
                                                            r23 = nil
                                                            r23 = allocUpvalue()
                                                            r57 = allocUpvalue()
                                                            r32 = nil
                                                            upvalueValues[r57] = r32
                                                            r60 = nil
                                                            r60 = "math"
                                                            r10 = _env[r60]
                                                            r60 = "floor"
                                                            r32 = r10[r60]
                                                            r10 = allocUpvalue()
                                                            upvalueValues[r10] = r32
                                                            r33 = "math"
                                                            r60 = _env[r33]
                                                            r33 = "random"
                                                            r32 = r60[r33]
                                                            r22 = nil
                                                            r22 = {}
                                                            r4 = nil
                                                            r4 = "table"
                                                            r33 = _env[r4]
                                                            r4 = "remove"
                                                            r60 = r33[r4]
                                                            r19 = 1
                                                            r51 = "string"
                                                            r4 = _env[r51]
                                                            r50 = nil
                                                            r50 = {}
                                                            r51 = "char"
                                                            r33 = r4[r51]
                                                            r51 = allocUpvalue()
                                                            r4 = 0
                                                            upvalueValues[r51] = r4
                                                            r18 = allocUpvalue()
                                                            r4 = 2
                                                            upvalueValues[r18] = r4
                                                            r4 = {}
                                                            upvalueValues[r23] = r50
                                                            r1 = r19
                                                            r19 = 0
                                                            r40 = r1 < r19
                                                            r54 = nil
                                                            r54 = 1
                                                            r19 = r54 - r1
                                                            r50 = 0
                                                            state = 26
                                                        end
                                                    else
                                                        if state == 25 then
                                                            state = createClosure1(49, {
                                                                r3
                                                            })
                                                            r45 = {
                                                                state()
                                                            }
                                                            ReturnVal = {
                                                                unpack(r45)
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
                                                            r19 = r19 + r1
                                                            r30 = not r40
                                                            r54 = r19 <= r6
                                                            r54 = r30 and r54
                                                            r30 = r19 >= r6
                                                            r30 = r40 and r30
                                                            r54 = r30 or r54
                                                            r30 = (27)
                                                            state = r54 and r30
                                                            r54 = (28)
                                                            state = state or r54
                                                        end
                                                    else
                                                        if state == 27 then
                                                            r54 = r19
                                                            r30 = r54
                                                            r22[r54] = r30
                                                            r54 = nil
                                                            state = 26
                                                        end
                                                    end
                                                else
                                                    if state <= 28 then
                                                        if state == 28 then
                                                            r19 = #r22
                                                            r6 = 0
                                                            r54 = r19 == r6
                                                            state = 29
                                                        end
                                                    else
                                                        if state == 29 then
                                                            r6 = #r22
                                                            r19 = 1
                                                            r54 = r32(r19, r6)
                                                            r19 = r60(r22, r54)
                                                            r6 = upvalueValues[r23]
                                                            r30 = 1
                                                            r40 = r19 - r30
                                                            r54 = nil
                                                            r1 = r33(r40)
                                                            r6[r19] = r1
                                                            r19 = nil
                                                            state = 30
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 31 then
                                                    if state <= 30 then
                                                        if state == 30 then
                                                            r19 = #r22
                                                            r6 = 0
                                                            r54 = r19 == r6
                                                            state = r54 and (31) or (29)
                                                        end
                                                    else
                                                        if state == 31 then
                                                            r30 = {}
                                                            r54 = {}
                                                            r19 = allocUpvalue()
                                                            upvalueValues[r19] = r54
                                                            r54 = allocUpvalue()
                                                            r6 = createClosure1(53, {
                                                                r19,
                                                                r51,
                                                                r18,
                                                                r10
                                                            })
                                                            r1 = allocUpvalue()
                                                            upvalueValues[r54] = r6
                                                            r6 = {}
                                                            upvalueValues[r1] = r6
                                                            r40 = "setmetatable"
                                                            r6 = _env[r40]
                                                            r44 = upvalueValues[r1]
                                                            r42 = "__index"
                                                            r12 = "__metatable"
                                                            r55 = nil
                                                            r43 = {
                                                                [r42] = r44,
                                                                [r12] = r55
                                                            }
                                                            r40 = r6(r30, r43)
                                                            upvalueValues[r3] = r40
                                                            r6 = createClosure6(59, {
                                                                r1,
                                                                r19,
                                                                r23,
                                                                r51,
                                                                r18,
                                                                r54
                                                            })
                                                            r51 = releaseUpvalue(r51)
                                                            r54 = releaseUpvalue(r54)
                                                            r23 = releaseUpvalue(r23)
                                                            r19 = releaseUpvalue(r19)
                                                            r1 = releaseUpvalue(r1)
                                                            r10 = releaseUpvalue(r10)
                                                            r18 = releaseUpvalue(r18)
                                                            upvalueValues[r57] = r6
                                                            r10 = "game"
                                                            r32 = nil
                                                            r32 = _env[r10]
                                                            r33 = nil
                                                            r33 = upvalueValues[r3]
                                                            r4 = nil
                                                            r4 = upvalueValues[r57]
                                                            r50 = nil
                                                            r50 = 31476354840897
                                                            r18 = "\207\2470\216\1858u"
                                                            r51 = r4(r18, r50)
                                                            r60 = nil
                                                            r60 = r33[r51]
                                                            r10 = "GetService"
                                                            r10 = r32[r10]
                                                            r10 = r10(r32, r60)
                                                            r60 = "game"
                                                            r32 = _env[r60]
                                                            r4 = upvalueValues[r3]
                                                            r51 = upvalueValues[r57]
                                                            r60 = "GetService"
                                                            r60 = r32[r60]
                                                            r23 = 30313561913123
                                                            r50 = "\127}{\1467\028\155v5\222"
                                                            r18 = r51(r50, r23)
                                                            r33 = r4[r18]
                                                            r60 = r60(r32, r33)
                                                            r51 = upvalueValues[r3]
                                                            r18 = upvalueValues[r57]
                                                            r22 = nil
                                                            r22 = 32460216220427
                                                            r23 = "\220\141\025\1489*\245\n\233\241\197"
                                                            r50 = r18(r23, r22)
                                                            r4 = r51[r50]
                                                            r33 = r10[r4]
                                                            r51 = upvalueValues[r3]
                                                            r18 = upvalueValues[r57]
                                                            r23 = "\006~:\239\158\015\016\200j"
                                                            r22 = 577116422412
                                                            r50 = r18(r23, r22)
                                                            r4 = r51[r50]
                                                            r60 = r33[r4]
                                                            r32 = not r60
                                                            state = r32 and (32) or (33)
                                                        end
                                                    end
                                                else
                                                    if state <= 32 then
                                                        if state == 32 then
                                                            r4 = upvalueValues[r3]
                                                            r51 = upvalueValues[r57]
                                                            r50 = "8y`\154X\254\224}\145\237\006"
                                                            r23 = 8200373276394
                                                            r18 = r51(r50, r23)
                                                            r33 = r4[r18]
                                                            r60 = r10[r33]
                                                            r4 = upvalueValues[r3]
                                                            r51 = upvalueValues[r57]
                                                            r23 = 11235188102255
                                                            r50 = "\244\208\217\\\198A\189\006M\191\031d\190\017"
                                                            r18 = r51(r50, r23)
                                                            r33 = r4[r18]
                                                            r32 = r60[r33]
                                                            r60 = "Wait"
                                                            r60 = r32[r60]
                                                            r60 = r60(r32)
                                                            state = 33
                                                        end
                                                    else
                                                        if state == 33 then
                                                            r60 = "loadstring"
                                                            r32 = _env[r60]
                                                            r4 = "game"
                                                            r33 = _env[r4]
                                                            r18 = upvalueValues[r3]
                                                            r50 = upvalueValues[r57]
                                                            r54 = 28665585988644
                                                            r22 = "\170\143\018\221\208\204\222w\188\020\245D\003\006X\167\220\\\173\002\135\212\196\130\191p\199f\218\008\221\249\222\137'\174x\t)%\021\253\200\003\168\132W+\000\133X\234\132\243nt\242\149\016\021\030D|\250\249\250\146\226\160\136\249\186\217\217"
                                                            r23 = r50(r22, r54)
                                                            r51 = r18[r23]
                                                            r18 = "HttpGet"
                                                            r18 = r33[r18]
                                                            r4 = {
                                                                r18(r33, r51)
                                                            }
                                                            r60 = r32(unpack(r4))
                                                            r32 = r60()
                                                            r60 = allocUpvalue()
                                                            upvalueValues[r60] = r32
                                                            r4 = upvalueValues[r3]
                                                            r51 = upvalueValues[r57]
                                                            r23 = 17506021613527
                                                            r50 = "El\227\169\017\143V)\152"
                                                            r18 = r51(r50, r23)
                                                            r33 = r4[r18]
                                                            r4 = createClosure5(66, {
                                                                r60,
                                                                r3,
                                                                r57
                                                            })
                                                            r32 = {
                                                                [r33] = r4
                                                            }
                                                            ReturnVal = {
                                                                r32
                                                            }
                                                            state = nil
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure2 entry 7212843 -> 34, states 34-34
                                    if state == 34 then -- entry 7212843 -> 34
                                        state = true
                                        upvalueValues[upvalues[1]] = state
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            else
                                -- createClosure0 entry 1408566 -> 35, states 35-35
                                if state == 35 then -- entry 1408566 -> 35
                                    ReturnVal = "error"
                                    state = _env[ReturnVal]
                                    r7 = "Tamper Detected!"
                                    ReturnVal = state(r7)
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        else
                            if state <= 36 then
                                -- createClosure5 entry 5176549 -> 36, states 36-36
                                if state == 36 then -- entry 5176549 -> 36
                                    r32 = 6090238
                                    r57 = "VruKAcGaOOP"
                                    r7 = r57 ^ r32
                                    ReturnVal = 14847439
                                    state = ReturnVal - r7
                                    r7 = state
                                    ReturnVal = "9Haq"
                                    state = ReturnVal / r7
                                    ReturnVal = {
                                        state
                                    }
                                    state = nil
                                end
                            else
                                -- createClosure4 entry 7519561 -> 37, states 37-48
                                if state <= 42 then
                                    if state <= 39 then
                                        if state <= 38 then
                                            if state <= 37 then
                                                if state == 37 then -- entry 7519561 -> 37
                                                    r57 = upvalueValues[upvalues[1]]
                                                    r10 = 2
                                                    r3 = 1
                                                    r32 = r57(r3, r10)
                                                    r57 = 1
                                                    r7 = r32 == r57
                                                    state = r7 and (38) or (39)
                                                    ReturnVal = r7
                                                end
                                            else
                                                if state == 38 then
                                                    state = ReturnVal and (40) or (41)
                                                end
                                            end
                                        else
                                            if state == 39 then
                                                r57 = upvalueValues[upvalues[2]]
                                                r32 = upvalueValues[upvalues[3]]
                                                r7 = r57 == r32
                                                ReturnVal = r7
                                                state = 38
                                            end
                                        end
                                    else
                                        if state <= 41 then
                                            if state <= 40 then
                                                if state == 40 then
                                                    r51 = createClosure1(100, {})
                                                    ReturnVal = "tonumber"
                                                    state = _env[ReturnVal]
                                                    r7 = upvalueValues[upvalues[4]]
                                                    r3 = "tostring"
                                                    r32 = _env[r3]
                                                    r4 = "pcall"
                                                    r33 = _env[r4]
                                                    r4 = {
                                                        r33(r51)
                                                    }
                                                    r60 = {
                                                        unpack(r4)
                                                    }
                                                    r33 = 2
                                                    r10 = r60[r33]
                                                    r3 = r32(r10)
                                                    r32 = ":(%d*):"
                                                    r57 = r7(r3, r32)
                                                    r7 = {
                                                        r57()
                                                    }
                                                    ReturnVal = state(unpack(r7))
                                                    r7 = ReturnVal
                                                    r57 = upvalueValues[upvalues[5]]
                                                    state = r57 and (42) or (43)
                                                    ReturnVal = r57
                                                end
                                            else
                                                if state == 41 then
                                                    state = upvalueValues[upvalues[7]]
                                                    state = state and (44) or (45)
                                                end
                                            end
                                        else
                                            if state == 42 then
                                                r32 = upvalueValues[upvalues[6]]
                                                r57 = r32 == r7
                                                ReturnVal = r57
                                                state = 43
                                            end
                                        end
                                    end
                                else
                                    if state <= 45 then
                                        if state <= 44 then
                                            if state <= 43 then
                                                if state == 43 then
                                                    upvalueValues[upvalues[5]] = ReturnVal
                                                    r7 = nil
                                                    state = 41
                                                end
                                            else
                                                if state == 44 then
                                                    r7 = "error"
                                                    state = _env[r7]
                                                    r57 = upvalueValues[upvalues[8]]
                                                    r32 = 0
                                                    r7 = state(r57, r32)
                                                    state = 45
                                                end
                                            end
                                        else
                                            if state == 45 then
                                                state = {}
                                                r7 = state
                                                r32 = upvalueValues[upvalues[9]]
                                                r3 = r32
                                                r32 = 1
                                                r10 = r32
                                                r32 = 0
                                                r60 = r10 < r32
                                                r57 = 1
                                                r32 = r57 - r10
                                                state = 46
                                            end
                                        end
                                    else
                                        if state <= 47 then
                                            if state <= 46 then
                                                if state == 46 then
                                                    r33 = not r60
                                                    r32 = r32 + r10
                                                    r57 = r32 <= r3
                                                    r57 = r33 and r57
                                                    r33 = r32 >= r3
                                                    r33 = r60 and r33
                                                    r57 = r33 or r57
                                                    r33 = (47)
                                                    state = r57 and r33
                                                    r57 = (48)
                                                    state = state or r57
                                                end
                                            else
                                                if state == 47 then
                                                    r57 = r32
                                                    state = upvalueValues[upvalues[1]]
                                                    r51 = 255
                                                    r4 = 0
                                                    r33 = state(r4, r51)
                                                    r7[r57] = r33
                                                    r57 = nil
                                                    state = 46
                                                end
                                            end
                                        else
                                            if state == 48 then
                                                state = upvalueValues[upvalues[10]]
                                                r57 = upvalueValues[upvalues[11]]
                                                r7[state] = r57
                                                state = upvalueValues[upvalues[12]]
                                                r57 = {
                                                    state(r7)
                                                }
                                                ReturnVal = {
                                                    unpack(r57)
                                                }
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    else
                        if state <= 58 then
                            if state <= 52 then
                                -- createClosure1 entry 15859314 -> 49, states 49-52
                                if state <= 50 then
                                    if state <= 49 then
                                        if state == 49 then -- entry 15859314 -> 49
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
                                            r7 = "l1"
                                            ReturnVal = _env[r7]
                                            r7 = "l1"
                                            _env[r7] = state
                                            r7 = "l2"
                                            _env[r7] = ReturnVal
                                            r7 = upvalueValues[upvalues[1]]
                                            r57 = r7()
                                            state = 50
                                        end
                                    else
                                        if state == 52 then
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                end
                            else
                                -- createClosure1 entry 12875095 -> 53, states 53-58
                                if state <= 55 then
                                    if state <= 54 then
                                        if state <= 53 then
                                            if state == 53 then -- entry 12875095 -> 53
                                                r7 = upvalueValues[upvalues[1]]
                                                ReturnVal = #r7
                                                r7 = 0
                                                state = ReturnVal == r7
                                                state = state and (54) or (55)
                                            end
                                        else
                                            if state == 54 then
                                                r57 = upvalueValues[upvalues[2]]
                                                r32 = 53
                                                r7 = r57 * r32
                                                r57 = 26379099320315
                                                ReturnVal = r7 + r57
                                                r7 = 35184372088832
                                                state = ReturnVal % r7
                                                upvalueValues[upvalues[2]] = state
                                                r7 = upvalueValues[upvalues[3]]
                                                r57 = 1
                                                ReturnVal = r7 ~= r57
                                                state = 56
                                            end
                                        end
                                    else
                                        if state == 55 then
                                            r32 = "table"
                                            r57 = _env[r32]
                                            r32 = "remove"
                                            r7 = r57[r32]
                                            r32 = upvalueValues[upvalues[1]]
                                            r57 = {
                                                r7(r32)
                                            }
                                            ReturnVal = {
                                                unpack(r57)
                                            }
                                            state = nil
                                        end
                                    end
                                else
                                    if state <= 57 then
                                        if state <= 56 then
                                            if state == 56 then
                                                r57 = upvalueValues[upvalues[3]]
                                                r32 = 247
                                                r7 = r57 * r32
                                                r57 = 257
                                                ReturnVal = r7 % r57
                                                upvalueValues[upvalues[3]] = ReturnVal
                                                state = 57
                                            end
                                        else
                                            if state == 57 then
                                                r57 = upvalueValues[upvalues[3]]
                                                r32 = 1
                                                r7 = r57 ~= r32
                                                state = r7 and (58) or (56)
                                            end
                                        end
                                    else
                                        if state == 58 then
                                            r32 = 32
                                            r57 = upvalueValues[upvalues[3]]
                                            r7 = r57 % r32
                                            r51 = 2
                                            r3 = upvalueValues[upvalues[4]]
                                            r33 = upvalueValues[upvalues[2]]
                                            r54 = upvalueValues[upvalues[3]]
                                            r22 = r54 - r7
                                            r54 = 32
                                            r23 = r22 / r54
                                            r50 = 13
                                            r18 = r50 - r23
                                            r4 = r51 ^ r18
                                            r60 = r33 / r4
                                            r10 = r3(r60)
                                            r3 = 4294967296
                                            r32 = r10 % r3
                                            r10 = 2
                                            r3 = r10 ^ r7
                                            r57 = r32 / r3
                                            r3 = upvalueValues[upvalues[4]]
                                            r4 = 1
                                            r33 = r57 % r4
                                            r4 = 4294967296
                                            r60 = r33 * r4
                                            r10 = r3(r60)
                                            r3 = upvalueValues[upvalues[4]]
                                            r60 = r3(r57)
                                            r32 = r10 + r60
                                            r10 = 65536
                                            r3 = r32 % r10
                                            r33 = 65536
                                            r51 = 256
                                            r60 = r32 - r3
                                            r10 = r60 / r33
                                            r50 = 256
                                            r33 = 256
                                            r32 = nil
                                            r60 = r3 % r33
                                            r7 = nil
                                            r4 = r3 - r60
                                            r33 = r4 / r51
                                            r51 = 256
                                            r57 = nil
                                            r4 = r10 % r51
                                            r3 = nil
                                            r18 = r10 - r4
                                            r10 = nil
                                            r51 = r18 / r50
                                            r18 = {
                                                r60,
                                                r33,
                                                r4,
                                                r51
                                            }
                                            r4 = nil
                                            r33 = nil
                                            upvalueValues[upvalues[1]] = r18
                                            r60 = nil
                                            r51 = nil
                                            state = 55
                                        end
                                    end
                                end
                            end
                        else
                            if state <= 65 then
                                -- createClosure6 entry 9214264 -> 59, states 59-65
                                if state <= 62 then
                                    if state <= 60 then
                                        if state <= 59 then
                                            if state == 59 then -- entry 9214264 -> 59
                                                r57 = args[2]
                                                state = upvalueValues[upvalues[1]]
                                                r32 = state
                                                state = r32[r57]
                                                r7 = args[1]
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
                                                r3 = ReturnVal
                                                r10 = 35184372088832
                                                ReturnVal = r57 % r10
                                                upvalueValues[upvalues[4]] = ReturnVal
                                                r33 = 255
                                                r60 = r57 % r33
                                                r33 = 2
                                                r10 = r60 + r33
                                                upvalueValues[upvalues[5]] = r10
                                                r4 = "string"
                                                r33 = _env[r4]
                                                r4 = "len"
                                                r60 = r33[r4]
                                                r33 = r60(r7)
                                                r18 = 1
                                                r50 = r18
                                                r60 = ""
                                                r32[r57] = r60
                                                r18 = 0
                                                r23 = r50 < r18
                                                r4 = 1
                                                r18 = r4 - r50
                                                r51 = r33
                                                r60 = 170
                                                state = 63
                                            end
                                        else
                                            if state == 62 then
                                                ReturnVal = {
                                                    r57
                                                }
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    if state <= 64 then
                                        if state <= 63 then
                                            if state == 63 then
                                                r18 = r18 + r50
                                                r22 = not r23
                                                r4 = r18 <= r51
                                                r4 = r22 and r4
                                                r22 = r18 >= r51
                                                r22 = r23 and r22
                                                r4 = r22 or r4
                                                r22 = (64)
                                                state = r4 and r22
                                                r4 = (65)
                                                state = state or r4
                                            end
                                        else
                                            if state == 64 then
                                                r4 = r18
                                                r47 = "string"
                                                r45 = _env[r47]
                                                r47 = "byte"
                                                r20 = r45[r47]
                                                r45 = r20(r7, r4)
                                                r20 = upvalueValues[upvalues[6]]
                                                r47 = r20()
                                                r4 = nil
                                                r19 = r45 + r47
                                                r54 = r19 + r60
                                                r19 = 256
                                                r22 = r54 % r19
                                                r60 = r22
                                                r19 = r32[r57]
                                                r47 = 1
                                                r45 = r60 + r47
                                                r20 = r3[r45]
                                                r54 = r19 .. r20
                                                r32[r57] = r54
                                                state = 63
                                            end
                                        end
                                    else
                                        if state == 65 then
                                            r33 = nil
                                            r60 = nil
                                            r3 = nil
                                            state = 62
                                        end
                                    end
                                end
                            else
                                -- createClosure5 entry 1662171 -> 66, states 66-99
                                if state <= 82 then
                                    if state <= 74 then
                                        if state <= 70 then
                                            if state <= 68 then
                                                if state <= 67 then
                                                    if state <= 66 then
                                                        if state == 66 then -- entry 1662171 -> 66
                                                            r57 = allocUpvalue()
                                                            r32 = allocUpvalue()
                                                            upvalueValues[r57] = args[2]
                                                            upvalueValues[r32] = args[3]
                                                            state = upvalueValues[upvalues[1]]
                                                            r7 = args[1]
                                                            r10 = upvalueValues[upvalues[2]]
                                                            r60 = upvalueValues[upvalues[3]]
                                                            r51 = 7993892064906
                                                            r4 = "\003\188\029y\234\177\198\240\144\016\\\195\230\147\177\004\199"
                                                            r33 = r60(r4, r51)
                                                            r3 = r10[r33]
                                                            ReturnVal = "Window"
                                                            ReturnVal = state[ReturnVal]
                                                            ReturnVal = ReturnVal(state, r3)
                                                            r3 = allocUpvalue()
                                                            upvalueValues[r3] = ReturnVal
                                                            r10 = "Instance"
                                                            ReturnVal = _env[r10]
                                                            r60 = upvalueValues[upvalues[2]]
                                                            r33 = upvalueValues[upvalues[3]]
                                                            r18 = 1372150907518
                                                            r51 = "mF\001"
                                                            r4 = r33(r51, r18)
                                                            r10 = r60[r4]
                                                            state = ReturnVal[r10]
                                                            r60 = upvalueValues[upvalues[2]]
                                                            r33 = upvalueValues[upvalues[3]]
                                                            r18 = 5575054805540
                                                            r51 = "\r\014\227\136\140\224U\229I\197\191\129\164"
                                                            r4 = r33(r51, r18)
                                                            r10 = r60[r4]
                                                            r33 = "game"
                                                            r60 = _env[r33]
                                                            ReturnVal = state(r10, r60)
                                                            r10 = allocUpvalue()
                                                            r60 = allocUpvalue()
                                                            upvalueValues[r10] = ReturnVal
                                                            state = {}
                                                            upvalueValues[r60] = state
                                                            ReturnVal = upvalueValues[r10]
                                                            r4 = upvalueValues[upvalues[2]]
                                                            r51 = upvalueValues[upvalues[3]]
                                                            r50 = "`\135L\150\210"
                                                            r23 = 18974171865731
                                                            r18 = r51(r50, r23)
                                                            r33 = r4[r18]
                                                            state = ReturnVal[r33]
                                                            ReturnVal = "Connect"
                                                            ReturnVal = state[ReturnVal]
                                                            r33 = createClosure2(101, {
                                                                r57,
                                                                upvalues[2],
                                                                upvalues[3],
                                                                r32
                                                            })
                                                            ReturnVal = ReturnVal(state, r33)
                                                            r4 = "game"
                                                            r33 = _env[r4]
                                                            r51 = upvalueValues[upvalues[2]]
                                                            r18 = upvalueValues[upvalues[3]]
                                                            r22 = 5994747071207
                                                            r23 = "\143s\015\139Z>qIf"
                                                            r50 = r18(r23, r22)
                                                            r4 = r51[r50]
                                                            ReturnVal = r33[r4]
                                                            r4 = upvalueValues[upvalues[2]]
                                                            r51 = upvalueValues[upvalues[3]]
                                                            r50 = "A`\149\131D\142\155\006|$"
                                                            r23 = 22903657474473
                                                            r18 = r51(r50, r23)
                                                            r33 = r4[r18]
                                                            state = ReturnVal[r33]
                                                            r33 = createClosure5(106, {
                                                                r60,
                                                                upvalues[2],
                                                                upvalues[3]
                                                            })
                                                            ReturnVal = "Connect"
                                                            ReturnVal = state[ReturnVal]
                                                            ReturnVal = ReturnVal(state, r33)
                                                            r33 = ReturnVal
                                                            r51 = "game"
                                                            r4 = _env[r51]
                                                            r18 = upvalueValues[upvalues[2]]
                                                            r50 = upvalueValues[upvalues[3]]
                                                            r54 = 17223293493076
                                                            r22 = "=\157+\142k\252G\227h"
                                                            r23 = r50(r22, r54)
                                                            r51 = r18[r23]
                                                            ReturnVal = r4[r51]
                                                            r51 = upvalueValues[upvalues[2]]
                                                            r18 = upvalueValues[upvalues[3]]
                                                            r22 = 7792631811628
                                                            r23 = "\216,\015\251\153\187^\201\239\241\012\150"
                                                            r50 = r18(r23, r22)
                                                            r4 = r51[r50]
                                                            state = ReturnVal[r4]
                                                            r4 = createClosure4(111, {
                                                                r60,
                                                                r10,
                                                                upvalues[2],
                                                                upvalues[3]
                                                            })
                                                            ReturnVal = "Connect"
                                                            ReturnVal = state[ReturnVal]
                                                            ReturnVal = ReturnVal(state, r4)
                                                            r4 = allocUpvalue()
                                                            state = 0
                                                            upvalueValues[r4] = state
                                                            state = upvalueValues[r3]
                                                            r50 = upvalueValues[upvalues[2]]
                                                            r23 = upvalueValues[upvalues[3]]
                                                            r19 = 13515276228757
                                                            r54 = "\r;\153\007\133"
                                                            r22 = r23(r54, r19)
                                                            r18 = r50[r22]
                                                            r22 = "Color3"
                                                            r23 = _env[r22]
                                                            r54 = upvalueValues[upvalues[2]]
                                                            r19 = upvalueValues[upvalues[3]]
                                                            r45 = "\169\184$\254}Qs"
                                                            r47 = 2921821619536
                                                            r20 = r19(r45, r47)
                                                            r22 = r54[r20]
                                                            r50 = r23[r22]
                                                            r19 = 255
                                                            r54 = 255
                                                            r22 = 255
                                                            r23 = r50(r22, r54, r19)
                                                            r22 = upvalueValues[upvalues[2]]
                                                            r54 = upvalueValues[upvalues[3]]
                                                            r20 = "\180\142\175X\021\139d"
                                                            r45 = 29432139642249
                                                            r19 = r54(r20, r45)
                                                            r50 = r22[r19]
                                                            r54 = upvalueValues[upvalues[2]]
                                                            r19 = upvalueValues[upvalues[3]]
                                                            r47 = 14092392651170
                                                            r45 = "\254\214\\\012\211\2421\247VX\144\192!9\t4"
                                                            r20 = r19(r45, r47)
                                                            r22 = r54[r20]
                                                            r51 = {
                                                                [r18] = r23,
                                                                [r50] = r22
                                                            }
                                                            ReturnVal = "Log"
                                                            ReturnVal = state[ReturnVal]
                                                            ReturnVal = ReturnVal(state, r51)
                                                            state = upvalueValues[r3]
                                                            r50 = upvalueValues[upvalues[2]]
                                                            r23 = upvalueValues[upvalues[3]]
                                                            r54 = "\016,\r\227\r"
                                                            r19 = 11122194895931
                                                            r22 = r23(r54, r19)
                                                            r18 = r50[r22]
                                                            r22 = "Color3"
                                                            r23 = _env[r22]
                                                            r54 = upvalueValues[upvalues[2]]
                                                            r19 = upvalueValues[upvalues[3]]
                                                            r47 = 5482955639289
                                                            r45 = "a\020\244\201\252\157\130"
                                                            r20 = r19(r45, r47)
                                                            r22 = r54[r20]
                                                            ReturnVal = "Log"
                                                            ReturnVal = state[ReturnVal]
                                                            r50 = r23[r22]
                                                            r19 = 255
                                                            r54 = 255
                                                            r22 = 255
                                                            r23 = r50(r22, r54, r19)
                                                            r22 = upvalueValues[upvalues[2]]
                                                            r54 = upvalueValues[upvalues[3]]
                                                            r20 = "\247!\203\174\149\169\255"
                                                            r45 = 7573606550982
                                                            r19 = r54(r20, r45)
                                                            r50 = r22[r19]
                                                            r19 = upvalueValues[upvalues[2]]
                                                            r20 = upvalueValues[upvalues[3]]
                                                            r47 = "?5\128\171\190\158\157\248?\244"
                                                            r6 = 28628216509459
                                                            r45 = r20(r47, r6)
                                                            r54 = r19[r45]
                                                            r20 = upvalueValues[r4]
                                                            r47 = upvalueValues[upvalues[2]]
                                                            r6 = upvalueValues[upvalues[3]]
                                                            r30 = 13476847704195
                                                            r40 = "\219\030\178G\134A;\213\137\183C\135\154[M-@l\194\148\199\253\193]\026\135:\132\205\167\171K.\229Z|xH\146\\e\182,\223\163\015$\140\147\014t\228\186<;8W\144e\001\221\137w$"
                                                            r1 = r6(r40, r30)
                                                            r45 = r47[r1]
                                                            r19 = r20 .. r45
                                                            r22 = r54 .. r19
                                                            r51 = {
                                                                [r18] = r23,
                                                                [r50] = r22
                                                            }
                                                            ReturnVal = ReturnVal(state, r51)
                                                            r51 = allocUpvalue()
                                                            upvalueValues[r51] = ReturnVal
                                                            ReturnVal = "pairs"
                                                            state = _env[ReturnVal]
                                                            r23 = upvalueValues[r57]
                                                            r22 = {
                                                                state(r23)
                                                            }
                                                            ReturnVal = r22[1]
                                                            state = upvalueValues[r60]
                                                            r18 = r22[2]
                                                            r50 = r22[3]
                                                            r22 = allocUpvalue()
                                                            upvalueValues[r22] = state
                                                            r19 = allocUpvalue()
                                                            r54 = allocUpvalue()
                                                            state = 0
                                                            upvalueValues[r54] = state
                                                            state = 0
                                                            upvalueValues[r19] = state
                                                            r23 = ReturnVal
                                                            state = 67
                                                        end
                                                    else
                                                        if state == 67 then
                                                            state = true
                                                            state = state and (68) or (69)
                                                        end
                                                    end
                                                else
                                                    if state == 68 then
                                                        r45 = {
                                                            r23(r18, r50)
                                                        }
                                                        state = nil
                                                        r20 = state
                                                        state = r45[1]
                                                        r50 = state
                                                        ReturnVal = r45[2]
                                                        r47 = nil
                                                        r45 = r50 == r47
                                                        state = r45 and (70) or (71)
                                                        r20 = ReturnVal
                                                    end
                                                end
                                            else
                                                if state <= 69 then
                                                    if state == 69 then
                                                        r47 = createClosure6(114, {
                                                            upvalues[2],
                                                            upvalues[3]
                                                        })
                                                        r20 = allocUpvalue()
                                                        upvalueValues[r20] = r47
                                                        r6 = "tick"
                                                        r47 = _env[r6]
                                                        r6 = r47()
                                                        r1 = allocUpvalue()
                                                        r47 = {}
                                                        r43 = createClosure3(115, {
                                                            r57,
                                                            upvalues[2],
                                                            upvalues[3],
                                                            r3,
                                                            r32,
                                                            r1,
                                                            r22,
                                                            r19,
                                                            r4,
                                                            r54,
                                                            r51,
                                                            r20
                                                        })
                                                        upvalueValues[r1] = r47
                                                        r40 = "pcall"
                                                        r47 = _env[r40]
                                                        r42 = {
                                                            r47(r43)
                                                        }
                                                        r40 = r42[1]
                                                        r30 = r42[2]
                                                        r43 = "pairs"
                                                        r47 = _env[r43]
                                                        r12 = upvalueValues[r22]
                                                        r14 = {
                                                            r47(r12)
                                                        }
                                                        r47 = {}
                                                        r43 = r14[1]
                                                        r44 = r14[3]
                                                        r42 = r14[2]
                                                        state = 72
                                                    end
                                                else
                                                    if state == 70 then
                                                        r20 = nil
                                                        state = 69
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 72 then
                                                if state <= 71 then
                                                    if state == 71 then
                                                        r20 = nil
                                                        r47 = upvalueValues[r54]
                                                        r6 = 1
                                                        r45 = r47 + r6
                                                        upvalueValues[r54] = r45
                                                        state = 67
                                                    end
                                                else
                                                    if state == 72 then
                                                        r12 = true
                                                        state = r12 and (73) or (74)
                                                    end
                                                end
                                            else
                                                if state <= 73 then
                                                    if state == 73 then
                                                        r55 = {
                                                            r43(r42, r44)
                                                        }
                                                        r14 = r55[1]
                                                        r2 = r55[2]
                                                        r44 = r14
                                                        r46 = nil
                                                        r55 = r44 == r46
                                                        state = r55 and (75) or (76)
                                                        r12 = nil
                                                        r12 = r2
                                                    end
                                                else
                                                    if state == 74 then
                                                        r12 = r47
                                                        upvalueValues[r60] = r12
                                                        state = r40 and (77) or (78)
                                                        r55 = "Disconnect"
                                                        r55 = r33[r55]
                                                        r55 = r55(r33)
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 78 then
                                            if state <= 76 then
                                                if state <= 75 then
                                                    if state == 75 then
                                                        r12 = nil
                                                        state = 74
                                                    end
                                                else
                                                    if state == 76 then
                                                        r61 = upvalueValues[upvalues[2]]
                                                        r24 = upvalueValues[upvalues[3]]
                                                        r11 = 21255270180521
                                                        r13 = "\133N\001@"
                                                        r53 = r24(r13, r11)
                                                        r46 = r61[r53]
                                                        r55 = r12[r46]
                                                        r47[r44] = r55
                                                        r12 = nil
                                                        state = 72
                                                    end
                                                end
                                            else
                                                if state <= 77 then
                                                    if state == 77 then
                                                        r55 = upvalueValues[r3]
                                                        r53 = upvalueValues[upvalues[2]]
                                                        r13 = upvalueValues[upvalues[3]]
                                                        r36 = "\016\244x\221\176"
                                                        r41 = 35077021401038
                                                        r11 = r13(r36, r41)
                                                        r24 = r53[r11]
                                                        r11 = "Color3"
                                                        r13 = _env[r11]
                                                        r36 = upvalueValues[upvalues[2]]
                                                        r41 = upvalueValues[upvalues[3]]
                                                        r5 = "\178\136\006\".\219\196"
                                                        r8 = 23229307890240
                                                        r49 = r41(r5, r8)
                                                        r11 = r36[r49]
                                                        r53 = r13[r11]
                                                        r41 = 255
                                                        r36 = 255
                                                        r11 = 255
                                                        r13 = r53(r11, r36, r41)
                                                        r11 = upvalueValues[upvalues[2]]
                                                        r36 = upvalueValues[upvalues[3]]
                                                        r5 = 19005634011794
                                                        r49 = "\167\188\128\166\137\177\024"
                                                        r41 = r36(r49, r5)
                                                        r53 = r11[r41]
                                                        r36 = upvalueValues[upvalues[2]]
                                                        r41 = upvalueValues[upvalues[3]]
                                                        r8 = 23053650078191
                                                        r5 = "\195\146\130\246\201{\232\194G\198Qu\182"
                                                        r49 = r41(r5, r8)
                                                        r11 = r36[r49]
                                                        r61 = {
                                                            [r24] = r13,
                                                            [r53] = r11
                                                        }
                                                        r46 = "Log"
                                                        r46 = r55[r46]
                                                        r46 = r46(r55, r61)
                                                        r55 = upvalueValues[r3]
                                                        r53 = upvalueValues[upvalues[2]]
                                                        r13 = upvalueValues[upvalues[3]]
                                                        r41 = 14918931946275
                                                        r36 = "_6\021\031S"
                                                        r11 = r13(r36, r41)
                                                        r24 = r53[r11]
                                                        r11 = "Color3"
                                                        r13 = _env[r11]
                                                        r36 = upvalueValues[upvalues[2]]
                                                        r41 = upvalueValues[upvalues[3]]
                                                        r5 = "G\187\151\152\005\252\216"
                                                        r8 = 4303096317907
                                                        r49 = r41(r5, r8)
                                                        r11 = r36[r49]
                                                        r53 = r13[r11]
                                                        r36 = 255
                                                        r41 = 255
                                                        r11 = 255
                                                        r13 = r53(r11, r36, r41)
                                                        r11 = upvalueValues[upvalues[2]]
                                                        r36 = upvalueValues[upvalues[3]]
                                                        r49 = "An\230\168\028X\183"
                                                        r5 = 34513912184519
                                                        r41 = r36(r49, r5)
                                                        r53 = r11[r41]
                                                        r36 = upvalueValues[upvalues[2]]
                                                        r46 = "Log"
                                                        r46 = r55[r46]
                                                        r41 = upvalueValues[upvalues[3]]
                                                        r8 = 34283701796444
                                                        r5 = "3\206+\141\223\237\r\148\185\01465\012\003\2055\206\022\180J\230"
                                                        r49 = r41(r5, r8)
                                                        r11 = r36[r49]
                                                        r61 = {
                                                            [r24] = r13,
                                                            [r53] = r11
                                                        }
                                                        r46 = r46(r55, r61)
                                                        r46 = "pairs"
                                                        r55 = _env[r46]
                                                        r53 = upvalueValues[r57]
                                                        r13 = {
                                                            r55(r53)
                                                        }
                                                        r61 = r13[2]
                                                        r46 = r13[1]
                                                        r24 = r13[3]
                                                        r55 = upvalueValues[r60]
                                                        r11 = upvalueValues[upvalues[2]]
                                                        r36 = upvalueValues[upvalues[3]]
                                                        r5 = 22485359208678
                                                        r49 = ",\238 \029\133\148"
                                                        r41 = r36(r49, r5)
                                                        r13 = r11[r41]
                                                        r41 = upvalueValues[upvalues[2]]
                                                        r49 = upvalueValues[upvalues[3]]
                                                        r48 = 10417230009074
                                                        r8 = "\187R\158lA\208"
                                                        r5 = r49(r8, r48)
                                                        r11 = {}
                                                        r36 = r41[r5]
                                                        r41 = {}
                                                        r5 = upvalueValues[upvalues[2]]
                                                        r8 = upvalueValues[upvalues[3]]
                                                        r34 = 24458846628989
                                                        r17 = "Z\203,v\144\245\237"
                                                        r48 = r8(r17, r34)
                                                        r49 = r5[r48]
                                                        r5 = {}
                                                        r48 = upvalueValues[upvalues[2]]
                                                        r17 = upvalueValues[upvalues[3]]
                                                        r27 = 28386907452322
                                                        r37 = "\251\255\212\2296\203\210e"
                                                        r34 = r17(r37, r27)
                                                        r8 = r48[r34]
                                                        r34 = upvalueValues[upvalues[2]]
                                                        r37 = upvalueValues[upvalues[3]]
                                                        r48 = {}
                                                        r35 = 20106118243474
                                                        r52 = "/\153\174<4\142"
                                                        r27 = r37(r52, r35)
                                                        r17 = r34[r27]
                                                        r34 = {}
                                                        r27 = upvalueValues[upvalues[2]]
                                                        r52 = upvalueValues[upvalues[3]]
                                                        r25 = "\192\166\141\160x\167"
                                                        r31 = 28638571443223
                                                        r35 = r52(r25, r31)
                                                        r37 = r27[r35]
                                                        r35 = upvalueValues[upvalues[2]]
                                                        r25 = upvalueValues[upvalues[3]]
                                                        r9 = 236493013102
                                                        r28 = "\025\153\217\231\003~"
                                                        r31 = r25(r28, r9)
                                                        r52 = r35[r31]
                                                        r35 = {}
                                                        r31 = upvalueValues[upvalues[2]]
                                                        r27 = {}
                                                        r28 = upvalueValues[upvalues[3]]
                                                        r15 = "k\014v\162R~<S\211"
                                                        r16 = 15195434130339
                                                        r9 = r28(r15, r16)
                                                        r25 = r31[r9]
                                                        r31 = {}
                                                        r9 = upvalueValues[upvalues[2]]
                                                        r15 = upvalueValues[upvalues[3]]
                                                        r26 = 14231828765155
                                                        r58 = "\026c\188]\158"
                                                        r16 = r15(r58, r26)
                                                        r28 = r9[r16]
                                                        r9 = {}
                                                        r16 = upvalueValues[upvalues[2]]
                                                        r58 = upvalueValues[upvalues[3]]
                                                        r59 = 16019659087139
                                                        r21 = "\230\025|\182\020\226\193\181\219"
                                                        r26 = r58(r21, r59)
                                                        r15 = r16[r26]
                                                        r16 = {}
                                                        r26 = upvalueValues[upvalues[2]]
                                                        r21 = upvalueValues[upvalues[3]]
                                                        r38 = "\170\011v7"
                                                        r39 = 27508043510281
                                                        r59 = r21(r38, r39)
                                                        r58 = r26[r59]
                                                        r26 = {}
                                                        r59 = upvalueValues[upvalues[2]]
                                                        r38 = upvalueValues[upvalues[3]]
                                                        r56 = 7617717898715
                                                        r29 = "\231iG\217\198\188\213\169"
                                                        r39 = r38(r29, r56)
                                                        r21 = r59[r39]
                                                        r59 = {}
                                                        r53 = {
                                                            [r13] = r11,
                                                            [r36] = r41,
                                                            [r49] = r5,
                                                            [r8] = r48,
                                                            [r17] = r34,
                                                            [r37] = r27,
                                                            [r52] = r35,
                                                            [r25] = r31,
                                                            [r28] = r9,
                                                            [r15] = r16,
                                                            [r58] = r26,
                                                            [r21] = r59
                                                        }
                                                        r13 = allocUpvalue()
                                                        upvalueValues[r13] = r53
                                                        state = 79
                                                    end
                                                else
                                                    if state == 78 then
                                                        r55 = upvalueValues[r3]
                                                        r53 = upvalueValues[upvalues[2]]
                                                        r13 = upvalueValues[upvalues[3]]
                                                        r49 = "\207UWu\017"
                                                        r5 = 11592601310486
                                                        r41 = r13(r49, r5)
                                                        r24 = r53[r41]
                                                        r41 = "Color3"
                                                        r13 = _env[r41]
                                                        r49 = upvalueValues[upvalues[2]]
                                                        r5 = upvalueValues[upvalues[3]]
                                                        r17 = "\218\224b$\014\173\219"
                                                        r34 = 21727769962373
                                                        r8 = r5(r17, r34)
                                                        r41 = r49[r8]
                                                        r53 = r13[r41]
                                                        r5 = 65
                                                        r49 = 65
                                                        r41 = 255
                                                        r13 = r53(r41, r49, r5)
                                                        r41 = upvalueValues[upvalues[2]]
                                                        r49 = upvalueValues[upvalues[3]]
                                                        r17 = 4477466920996
                                                        r8 = "\198\000\192c\254\209\026"
                                                        r5 = r49(r8, r17)
                                                        r46 = "Log"
                                                        r46 = r55[r46]
                                                        r53 = r41[r5]
                                                        r5 = upvalueValues[upvalues[2]]
                                                        r8 = upvalueValues[upvalues[3]]
                                                        r34 = "03\251\137\020\214\243\017\233"
                                                        r52 = 12403425203855
                                                        r17 = r8(r34, r52)
                                                        r49 = r5[r17]
                                                        r41 = r49 .. r30
                                                        r61 = {
                                                            [r24] = r13,
                                                            [r53] = r41
                                                        }
                                                        r46 = r46(r55, r61)
                                                        r55 = upvalueValues[r3]
                                                        r46 = "Complete"
                                                        r46 = r55[r46]
                                                        r46 = r46(r55)
                                                        state = 80
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 80 then
                                                if state <= 79 then
                                                    if state == 79 then
                                                        r53 = true
                                                        state = r53 and (81) or (82)
                                                    end
                                                else
                                                    if state == 80 then
                                                        r22 = releaseUpvalue(r22)
                                                        r57 = releaseUpvalue(r57)
                                                        r42 = nil
                                                        r23 = nil
                                                        r18 = nil
                                                        r44 = nil
                                                        r30 = nil
                                                        r60 = releaseUpvalue(r60)
                                                        r19 = releaseUpvalue(r19)
                                                        r1 = releaseUpvalue(r1)
                                                        r43 = nil
                                                        r50 = nil
                                                        r6 = nil
                                                        ReturnVal = {}
                                                        r10 = releaseUpvalue(r10)
                                                        r3 = releaseUpvalue(r3)
                                                        r51 = releaseUpvalue(r51)
                                                        r33 = nil
                                                        r54 = releaseUpvalue(r54)
                                                        r32 = releaseUpvalue(r32)
                                                        r40 = nil
                                                        r7 = nil
                                                        r4 = releaseUpvalue(r4)
                                                        r47 = nil
                                                        r20 = releaseUpvalue(r20)
                                                        state = nil
                                                    end
                                                end
                                            else
                                                if state <= 81 then
                                                    if state == 81 then
                                                        r41 = {
                                                            r46(r61, r24)
                                                        }
                                                        r11 = r41[1]
                                                        r24 = r11
                                                        r36 = r41[2]
                                                        r49 = nil
                                                        r41 = r24 == r49
                                                        state = r41 and (83) or (84)
                                                        r53 = nil
                                                        r53 = r36
                                                    end
                                                else
                                                    if state == 82 then
                                                        r5 = createClosure4(132, {
                                                            r32,
                                                            upvalues[2],
                                                            upvalues[3],
                                                            r13
                                                        })
                                                        r41 = "pcall"
                                                        r53 = _env[r41]
                                                        r8 = {
                                                            r53(r5)
                                                        }
                                                        r41 = r8[1]
                                                        r49 = r8[2]
                                                        r8 = "tick"
                                                        r5 = _env[r8]
                                                        r8 = r5()
                                                        r53 = r8 - r6
                                                        r5 = nil
                                                        r48 = 60
                                                        r8 = r53 < r48
                                                        state = r8 and (85) or (86)
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    if state <= 91 then
                                        if state <= 87 then
                                            if state <= 85 then
                                                if state <= 84 then
                                                    if state <= 83 then
                                                        if state == 83 then
                                                            r53 = nil
                                                            r41 = nil
                                                            state = 82
                                                        end
                                                    else
                                                        if state == 84 then
                                                            r49 = r55[r24]
                                                            r41 = r49
                                                            r5 = upvalueValues[r13]
                                                            r48 = upvalueValues[upvalues[2]]
                                                            r17 = upvalueValues[upvalues[3]]
                                                            r27 = 28774748599383
                                                            r37 = "I\189\185c\149\145"
                                                            r34 = r17(r37, r27)
                                                            r8 = r48[r34]
                                                            r49 = r5[r8]
                                                            r17 = upvalueValues[r13]
                                                            r37 = upvalueValues[upvalues[2]]
                                                            r27 = upvalueValues[upvalues[3]]
                                                            r35 = "}\168\230_|:"
                                                            r25 = 18151557013764
                                                            r52 = r27(r35, r25)
                                                            r34 = r37[r52]
                                                            r48 = r17[r34]
                                                            r8 = #r48
                                                            r48 = 1
                                                            r5 = r8 + r48
                                                            r17 = upvalueValues[upvalues[2]]
                                                            r34 = upvalueValues[upvalues[3]]
                                                            r27 = "\200\128'\007\163"
                                                            r52 = 3925428651811
                                                            r37 = r34(r27, r52)
                                                            r48 = r17[r37]
                                                            r37 = "Color3"
                                                            r34 = _env[r37]
                                                            r27 = upvalueValues[upvalues[2]]
                                                            r52 = upvalueValues[upvalues[3]]
                                                            r31 = 593233559828
                                                            r25 = "&\193\205xy.\254"
                                                            r35 = r52(r25, r31)
                                                            r37 = r27[r35]
                                                            r17 = r34[r37]
                                                            r27 = "unpack"
                                                            r37 = _env[r27]
                                                            r25 = upvalueValues[upvalues[2]]
                                                            r31 = upvalueValues[upvalues[3]]
                                                            r15 = 22887463184801
                                                            r9 = "(%GI0"
                                                            r28 = r31(r9, r15)
                                                            r35 = r25[r28]
                                                            r52 = r53[r35]
                                                            r27 = {
                                                                r37(r52)
                                                            }
                                                            r34 = r17(unpack(r27))
                                                            r37 = upvalueValues[upvalues[2]]
                                                            r27 = upvalueValues[upvalues[3]]
                                                            r35 = "\205\0044\151"
                                                            r25 = 11355334317223
                                                            r52 = r27(r35, r25)
                                                            r17 = r37[r52]
                                                            r27 = upvalueValues[upvalues[2]]
                                                            r52 = upvalueValues[upvalues[3]]
                                                            r31 = 13079046264778
                                                            r25 = "d\253\149\r\211\188\018\1968\250\237a\143"
                                                            r35 = r52(r25, r31)
                                                            r37 = r27[r35]
                                                            r27 = true
                                                            r8 = {
                                                                [r48] = r34,
                                                                [r17] = r41,
                                                                [r37] = r27
                                                            }
                                                            r49[r5] = r8
                                                            r5 = upvalueValues[r13]
                                                            r48 = upvalueValues[upvalues[2]]
                                                            r17 = upvalueValues[upvalues[3]]
                                                            r37 = "\230\174{\1592\r"
                                                            r27 = 12603801605
                                                            r34 = r17(r37, r27)
                                                            r8 = r48[r34]
                                                            r49 = r5[r8]
                                                            r17 = upvalueValues[r13]
                                                            r37 = upvalueValues[upvalues[2]]
                                                            r27 = upvalueValues[upvalues[3]]
                                                            r25 = 12229084403262
                                                            r35 = "Q\131\028\230$J"
                                                            r52 = r27(r35, r25)
                                                            r34 = r37[r52]
                                                            r48 = r17[r34]
                                                            r8 = #r48
                                                            r48 = 1
                                                            r5 = r8 + r48
                                                            r17 = upvalueValues[upvalues[2]]
                                                            r34 = upvalueValues[upvalues[3]]
                                                            r27 = "U\134~\020\149x"
                                                            r52 = 3857334568708
                                                            r37 = r34(r27, r52)
                                                            r48 = r17[r37]
                                                            r37 = "CFrame"
                                                            r34 = _env[r37]
                                                            r27 = upvalueValues[upvalues[2]]
                                                            r52 = upvalueValues[upvalues[3]]
                                                            r25 = "\005\235\243"
                                                            r31 = 21267873982127
                                                            r35 = r52(r25, r31)
                                                            r37 = r27[r35]
                                                            r17 = r34[r37]
                                                            r27 = "unpack"
                                                            r37 = _env[r27]
                                                            r25 = upvalueValues[upvalues[2]]
                                                            r31 = upvalueValues[upvalues[3]]
                                                            r9 = "\245\255G[\224("
                                                            r15 = 12121733699084
                                                            r28 = r31(r9, r15)
                                                            r35 = r25[r28]
                                                            r52 = r53[r35]
                                                            r27 = {
                                                                r37(r52)
                                                            }
                                                            r34 = r17(unpack(r27))
                                                            r37 = upvalueValues[upvalues[2]]
                                                            r27 = upvalueValues[upvalues[3]]
                                                            r35 = "\177.\237\206"
                                                            r25 = 27086642475333
                                                            r52 = r27(r35, r25)
                                                            r17 = r37[r52]
                                                            r27 = upvalueValues[upvalues[2]]
                                                            r52 = upvalueValues[upvalues[3]]
                                                            r25 = "\249\178\156\180"
                                                            r31 = 5089135888705
                                                            r35 = r52(r25, r31)
                                                            r37 = r27[r35]
                                                            r35 = "Vector3"
                                                            r52 = _env[r35]
                                                            r25 = upvalueValues[upvalues[2]]
                                                            r31 = upvalueValues[upvalues[3]]
                                                            r9 = "Me?"
                                                            r15 = 35175383777275
                                                            r28 = r31(r9, r15)
                                                            r35 = r25[r28]
                                                            r27 = r52[r35]
                                                            r25 = "unpack"
                                                            r35 = _env[r25]
                                                            r9 = upvalueValues[upvalues[2]]
                                                            r15 = upvalueValues[upvalues[3]]
                                                            r58 = "\151\012\151+"
                                                            r26 = 6821202316392
                                                            r16 = r15(r58, r26)
                                                            r28 = r9[r16]
                                                            r31 = r53[r28]
                                                            r25 = {
                                                                r35(r31)
                                                            }
                                                            r52 = r27(unpack(r25))
                                                            r8 = {
                                                                [r48] = r34,
                                                                [r17] = r41,
                                                                [r37] = r52
                                                            }
                                                            r49[r5] = r8
                                                            r8 = upvalueValues[upvalues[2]]
                                                            r48 = upvalueValues[upvalues[3]]
                                                            r34 = "\195D\207e\227f'"
                                                            r37 = 9392232222997
                                                            r17 = r48(r34, r37)
                                                            r5 = r8[r17]
                                                            r49 = r53[r5]
                                                            state = r49 and (87) or (88)
                                                        end
                                                    end
                                                else
                                                    if state == 85 then
                                                        r17 = "string"
                                                        r48 = _env[r17]
                                                        r34 = upvalueValues[upvalues[2]]
                                                        r37 = upvalueValues[upvalues[3]]
                                                        r35 = 20507408131405
                                                        r52 = "\140\220\191\221\203\206"
                                                        r27 = r37(r52, r35)
                                                        r17 = r34[r27]
                                                        r8 = r48[r17]
                                                        r34 = upvalueValues[upvalues[2]]
                                                        r37 = upvalueValues[upvalues[3]]
                                                        r52 = "\000\026\011u\208}\004\024\249\230\232\160\165\203D4O"
                                                        r35 = 7355525041505
                                                        r27 = r37(r52, r35)
                                                        r17 = r34[r27]
                                                        r48 = r8(r17, r53)
                                                        r5 = r48
                                                        state = 89
                                                    end
                                                end
                                            else
                                                if state <= 86 then
                                                    if state == 86 then
                                                        r17 = 3600
                                                        r8 = r53 < r17
                                                        state = r8 and (90) or (91)
                                                    end
                                                else
                                                    if state == 87 then
                                                        r5 = upvalueValues[r13]
                                                        r48 = upvalueValues[upvalues[2]]
                                                        r17 = upvalueValues[upvalues[3]]
                                                        r27 = 34504923856579
                                                        r37 = "07Y\231D%x"
                                                        r34 = r17(r37, r27)
                                                        r8 = r48[r34]
                                                        r49 = r5[r8]
                                                        r17 = upvalueValues[r13]
                                                        r37 = upvalueValues[upvalues[2]]
                                                        r27 = upvalueValues[upvalues[3]]
                                                        r25 = 5920532024004
                                                        r35 = "\127\202\166<\208\147\014"
                                                        r52 = r27(r35, r25)
                                                        r34 = r37[r52]
                                                        r48 = r17[r34]
                                                        r8 = #r48
                                                        r48 = 1
                                                        r5 = r8 + r48
                                                        r17 = upvalueValues[upvalues[2]]
                                                        r34 = upvalueValues[upvalues[3]]
                                                        r27 = "n\2410\210"
                                                        r52 = 31877591431676
                                                        r37 = r34(r27, r52)
                                                        r48 = r17[r37]
                                                        r34 = upvalueValues[upvalues[2]]
                                                        r37 = upvalueValues[upvalues[3]]
                                                        r52 = "\151\138\153\031\019\136P\242"
                                                        r35 = 9737781760438
                                                        r27 = r37(r52, r35)
                                                        r17 = r34[r27]
                                                        r27 = upvalueValues[upvalues[2]]
                                                        r52 = upvalueValues[upvalues[3]]
                                                        r31 = 30379378652994
                                                        r25 = "\190\128\247\242\029\134n"
                                                        r35 = r52(r25, r31)
                                                        r37 = r27[r35]
                                                        r34 = r53[r37]
                                                        r8 = {
                                                            [r48] = r41,
                                                            [r17] = r34
                                                        }
                                                        r49[r5] = r8
                                                        state = 88
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 89 then
                                                if state <= 88 then
                                                    if state == 88 then
                                                        r5 = upvalueValues[r13]
                                                        r48 = upvalueValues[upvalues[2]]
                                                        r17 = upvalueValues[upvalues[3]]
                                                        r37 = "\182\r\154\023u\165\133`"
                                                        r27 = 25080126778782
                                                        r34 = r17(r37, r27)
                                                        r8 = r48[r34]
                                                        r49 = r5[r8]
                                                        r17 = upvalueValues[r13]
                                                        r37 = upvalueValues[upvalues[2]]
                                                        r27 = upvalueValues[upvalues[3]]
                                                        r35 = "\202\016$\223/\1952\134"
                                                        r25 = 29843900003913
                                                        r52 = r27(r35, r25)
                                                        r34 = r37[r52]
                                                        r48 = r17[r34]
                                                        r8 = #r48
                                                        r48 = 1
                                                        r5 = r8 + r48
                                                        r17 = upvalueValues[upvalues[2]]
                                                        r34 = upvalueValues[upvalues[3]]
                                                        r27 = "0\223\133\248"
                                                        r52 = 23833577991002
                                                        r37 = r34(r27, r52)
                                                        r48 = r17[r37]
                                                        r34 = upvalueValues[upvalues[2]]
                                                        r37 = upvalueValues[upvalues[3]]
                                                        r35 = 25316619791884
                                                        r52 = "\237\\\190b\191!\200\177"
                                                        r27 = r37(r52, r35)
                                                        r17 = r34[r27]
                                                        r27 = upvalueValues[upvalues[2]]
                                                        r52 = upvalueValues[upvalues[3]]
                                                        r25 = "#\132{\186\235\015\178"
                                                        r31 = 9854962029037
                                                        r35 = r52(r25, r31)
                                                        r37 = r27[r35]
                                                        r34 = r53[r37]
                                                        r27 = upvalueValues[upvalues[2]]
                                                        r52 = upvalueValues[upvalues[3]]
                                                        r25 = "U\217\018'\018\000 \130p<\234u"
                                                        r31 = 2881034650941
                                                        r35 = r52(r25, r31)
                                                        r37 = r27[r35]
                                                        r35 = upvalueValues[upvalues[2]]
                                                        r25 = upvalueValues[upvalues[3]]
                                                        r28 = "\168\220Sm7\249\201\169\236\153\240\179"
                                                        r9 = 6151906790192
                                                        r31 = r25(r28, r9)
                                                        r52 = r35[r31]
                                                        r27 = r53[r52]
                                                        r35 = upvalueValues[upvalues[2]]
                                                        r25 = upvalueValues[upvalues[3]]
                                                        r9 = 2178633434102
                                                        r28 = "\132\012\177\246\132\201\000`\174\240\226"
                                                        r31 = r25(r28, r9)
                                                        r52 = r35[r31]
                                                        r31 = upvalueValues[upvalues[2]]
                                                        r28 = upvalueValues[upvalues[3]]
                                                        r16 = 10498752549656
                                                        r15 = "%#I\030\226\188\193\203{\179\192"
                                                        r9 = r28(r15, r16)
                                                        r25 = r31[r9]
                                                        r35 = r53[r25]
                                                        r8 = {
                                                            [r48] = r41,
                                                            [r17] = r34,
                                                            [r37] = r27,
                                                            [r52] = r35
                                                        }
                                                        r49[r5] = r8
                                                        r5 = upvalueValues[r13]
                                                        r48 = upvalueValues[upvalues[2]]
                                                        r17 = upvalueValues[upvalues[3]]
                                                        r27 = 34926655389575
                                                        r37 = "\142\255\192tA\171"
                                                        r34 = r17(r37, r27)
                                                        r8 = r48[r34]
                                                        r49 = r5[r8]
                                                        r17 = upvalueValues[r13]
                                                        r37 = upvalueValues[upvalues[2]]
                                                        r27 = upvalueValues[upvalues[3]]
                                                        r25 = 20330190464250
                                                        r35 = "\003/\204\031\023$"
                                                        r52 = r27(r35, r25)
                                                        r34 = r37[r52]
                                                        r48 = r17[r34]
                                                        r8 = #r48
                                                        r48 = 1
                                                        r5 = r8 + r48
                                                        r17 = upvalueValues[upvalues[2]]
                                                        r34 = upvalueValues[upvalues[3]]
                                                        r52 = 14424181217852
                                                        r27 = "{r\246K\253\144"
                                                        r37 = r34(r27, r52)
                                                        r48 = r17[r37]
                                                        r37 = "CFrame"
                                                        r34 = _env[r37]
                                                        r27 = upvalueValues[upvalues[2]]
                                                        r52 = upvalueValues[upvalues[3]]
                                                        r31 = 335516844188
                                                        r25 = "d6\016"
                                                        r35 = r52(r25, r31)
                                                        r37 = r27[r35]
                                                        r17 = r34[r37]
                                                        r27 = "unpack"
                                                        r37 = _env[r27]
                                                        r25 = upvalueValues[upvalues[2]]
                                                        r31 = upvalueValues[upvalues[3]]
                                                        r15 = 8033281543836
                                                        r9 = "H\131\185y2\161"
                                                        r28 = r31(r9, r15)
                                                        r35 = r25[r28]
                                                        r52 = r53[r35]
                                                        r27 = {
                                                            r37(r52)
                                                        }
                                                        r34 = r17(unpack(r27))
                                                        r37 = upvalueValues[upvalues[2]]
                                                        r27 = upvalueValues[upvalues[3]]
                                                        r25 = 25779515535076
                                                        r35 = "\177\127{0"
                                                        r52 = r27(r35, r25)
                                                        r17 = r37[r52]
                                                        r8 = {
                                                            [r48] = r34,
                                                            [r17] = r41
                                                        }
                                                        r49[r5] = r8
                                                        r5 = upvalueValues[r13]
                                                        r48 = upvalueValues[upvalues[2]]
                                                        r17 = upvalueValues[upvalues[3]]
                                                        r27 = 13414563108966
                                                        r37 = "\250H\221\007F\222"
                                                        r34 = r17(r37, r27)
                                                        r8 = r48[r34]
                                                        r49 = r5[r8]
                                                        r17 = upvalueValues[r13]
                                                        r37 = upvalueValues[upvalues[2]]
                                                        r27 = upvalueValues[upvalues[3]]
                                                        r35 = "\205\t\219\170\131\174"
                                                        r25 = 8045885361826
                                                        r52 = r27(r35, r25)
                                                        r34 = r37[r52]
                                                        r48 = r17[r34]
                                                        r8 = #r48
                                                        r48 = 1
                                                        r5 = r8 + r48
                                                        r17 = upvalueValues[upvalues[2]]
                                                        r34 = upvalueValues[upvalues[3]]
                                                        r52 = 2824227833123
                                                        r27 = "(\157\243\247n\181@\148"
                                                        r37 = r34(r27, r52)
                                                        r48 = r17[r37]
                                                        r37 = upvalueValues[upvalues[2]]
                                                        r27 = upvalueValues[upvalues[3]]
                                                        r35 = "\157\015\165\164^\190\207?"
                                                        r25 = 17271897694058
                                                        r52 = r27(r35, r25)
                                                        r34 = r37[r52]
                                                        r17 = r53[r34]
                                                        r37 = upvalueValues[upvalues[2]]
                                                        r27 = upvalueValues[upvalues[3]]
                                                        r35 = ")\015\181\228"
                                                        r25 = 29313759343954
                                                        r52 = r27(r35, r25)
                                                        r34 = r37[r52]
                                                        r8 = {
                                                            [r48] = r17,
                                                            [r34] = r41
                                                        }
                                                        r49[r5] = r8
                                                        r5 = upvalueValues[r13]
                                                        r48 = upvalueValues[upvalues[2]]
                                                        r17 = upvalueValues[upvalues[3]]
                                                        r27 = 14945961532207
                                                        r37 = "\135\187\177\141\025Q"
                                                        r34 = r17(r37, r27)
                                                        r8 = r48[r34]
                                                        r49 = r5[r8]
                                                        r17 = upvalueValues[r13]
                                                        r37 = upvalueValues[upvalues[2]]
                                                        r27 = upvalueValues[upvalues[3]]
                                                        r35 = "-\0146\197\145C"
                                                        r25 = 9174168064176
                                                        r52 = r27(r35, r25)
                                                        r34 = r37[r52]
                                                        r48 = r17[r34]
                                                        r8 = #r48
                                                        r48 = 1
                                                        r5 = r8 + r48
                                                        r8 = r41
                                                        r49[r5] = r8
                                                        r5 = upvalueValues[r13]
                                                        r48 = upvalueValues[upvalues[2]]
                                                        r17 = upvalueValues[upvalues[3]]
                                                        r37 = "L\191ivw\238\194Zq"
                                                        r27 = 34402895249044
                                                        r34 = r17(r37, r27)
                                                        r8 = r48[r34]
                                                        r49 = r5[r8]
                                                        r17 = upvalueValues[r13]
                                                        r37 = upvalueValues[upvalues[2]]
                                                        r27 = upvalueValues[upvalues[3]]
                                                        r35 = "\011\012\r\249F\237\2038\203"
                                                        r25 = 14936973204267
                                                        r52 = r27(r35, r25)
                                                        r34 = r37[r52]
                                                        r48 = r17[r34]
                                                        r8 = #r48
                                                        r48 = 1
                                                        r5 = r8 + r48
                                                        r17 = upvalueValues[upvalues[2]]
                                                        r34 = upvalueValues[upvalues[3]]
                                                        r27 = "\254pL\142&i\031\017\213\185"
                                                        r52 = 15995370380568
                                                        r37 = r34(r27, r52)
                                                        r48 = r17[r37]
                                                        r37 = upvalueValues[upvalues[2]]
                                                        r27 = upvalueValues[upvalues[3]]
                                                        r25 = 8610755366825
                                                        r35 = "T\173\247\014\255-\149?kF"
                                                        r52 = r27(r35, r25)
                                                        r34 = r37[r52]
                                                        r17 = r53[r34]
                                                        r37 = upvalueValues[upvalues[2]]
                                                        r27 = upvalueValues[upvalues[3]]
                                                        r25 = 14257524955631
                                                        r35 = "X\209\001\132"
                                                        r52 = r27(r35, r25)
                                                        r34 = r37[r52]
                                                        r8 = {
                                                            [r48] = r17,
                                                            [r34] = r41
                                                        }
                                                        r49[r5] = r8
                                                        r8 = upvalueValues[upvalues[2]]
                                                        r48 = upvalueValues[upvalues[3]]
                                                        r34 = "\001~\185\251\181"
                                                        r37 = 21915902404573
                                                        r17 = r48(r34, r37)
                                                        r5 = r8[r17]
                                                        r49 = r53[r5]
                                                        state = r49 and (92) or (93)
                                                    end
                                                else
                                                    if state == 89 then
                                                        r8 = not r41
                                                        state = r8 and (94) or (95)
                                                    end
                                                end
                                            else
                                                if state <= 90 then
                                                    if state == 90 then
                                                        r34 = "math"
                                                        r17 = _env[r34]
                                                        r37 = upvalueValues[upvalues[2]]
                                                        r27 = upvalueValues[upvalues[3]]
                                                        r25 = 31901624334855
                                                        r35 = "T\027i\251\176"
                                                        r52 = r27(r35, r25)
                                                        r34 = r37[r52]
                                                        r8 = r17[r34]
                                                        r37 = 60
                                                        r34 = r53 / r37
                                                        r17 = r8(r34)
                                                        r34 = 60
                                                        r8 = r53 % r34
                                                        r27 = "string"
                                                        r37 = _env[r27]
                                                        r52 = upvalueValues[upvalues[2]]
                                                        r35 = upvalueValues[upvalues[3]]
                                                        r28 = 14093601167778
                                                        r31 = "\230*W]m\209"
                                                        r25 = r35(r31, r28)
                                                        r27 = r52[r25]
                                                        r34 = r37[r27]
                                                        r52 = upvalueValues[upvalues[2]]
                                                        r35 = upvalueValues[upvalues[3]]
                                                        r31 = "\000\167\179\031\193OI\187}\170\143\023FG\179\202\169\152\171\222g"
                                                        r28 = 28559414277107
                                                        r25 = r35(r31, r28)
                                                        r27 = r52[r25]
                                                        r37 = r34(r27, r17, r8)
                                                        r5 = r37
                                                        r8 = nil
                                                        r17 = nil
                                                        state = 89
                                                    end
                                                else
                                                    if state == 91 then
                                                        r34 = "math"
                                                        r17 = _env[r34]
                                                        r27 = upvalueValues[upvalues[2]]
                                                        r52 = upvalueValues[upvalues[3]]
                                                        r31 = 21056926410317
                                                        r25 = "\236\249\137\203|"
                                                        r35 = r52(r25, r31)
                                                        r34 = r27[r35]
                                                        r8 = r17[r34]
                                                        r27 = 3600
                                                        r34 = r53 / r27
                                                        r17 = r8(r34)
                                                        r27 = "math"
                                                        r34 = _env[r27]
                                                        r52 = upvalueValues[upvalues[2]]
                                                        r35 = upvalueValues[upvalues[3]]
                                                        r31 = "\166- &L"
                                                        r28 = 14424838216253
                                                        r25 = r35(r31, r28)
                                                        r27 = r52[r25]
                                                        r8 = r34[r27]
                                                        r35 = 3600
                                                        r52 = r53 % r35
                                                        r35 = 60
                                                        r27 = r52 / r35
                                                        r34 = r8(r27)
                                                        r52 = "string"
                                                        r27 = _env[r52]
                                                        r35 = upvalueValues[upvalues[2]]
                                                        r25 = upvalueValues[upvalues[3]]
                                                        r9 = 10816872190892
                                                        r28 = "P?\146\147H\026"
                                                        r31 = r25(r28, r9)
                                                        r52 = r35[r31]
                                                        r8 = r27[r52]
                                                        r35 = upvalueValues[upvalues[2]]
                                                        r25 = upvalueValues[upvalues[3]]
                                                        r9 = 289182171270
                                                        r28 = "\190=\251+\014\224\1385>YH1\209\021GE\254\234\157"
                                                        r31 = r25(r28, r9)
                                                        r52 = r35[r31]
                                                        r27 = r8(r52, r17, r34)
                                                        r5 = r27
                                                        r17 = nil
                                                        r34 = nil
                                                        state = 89
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 95 then
                                            if state <= 93 then
                                                if state <= 92 then
                                                    if state == 92 then
                                                        r5 = upvalueValues[r13]
                                                        r48 = upvalueValues[upvalues[2]]
                                                        r17 = upvalueValues[upvalues[3]]
                                                        r27 = 5303974693285
                                                        r37 = "s\237`Z\129"
                                                        r34 = r17(r37, r27)
                                                        r8 = r48[r34]
                                                        r49 = r5[r8]
                                                        r17 = upvalueValues[r13]
                                                        r37 = upvalueValues[upvalues[2]]
                                                        r27 = upvalueValues[upvalues[3]]
                                                        r25 = 23995306716069
                                                        r35 = "\nK\167\218\131"
                                                        r52 = r27(r35, r25)
                                                        r34 = r37[r52]
                                                        r48 = r17[r34]
                                                        r8 = #r48
                                                        r48 = 1
                                                        r5 = r8 + r48
                                                        r17 = upvalueValues[upvalues[2]]
                                                        r34 = upvalueValues[upvalues[3]]
                                                        r27 = "R7\185!"
                                                        r52 = 17110908952351
                                                        r37 = r34(r27, r52)
                                                        r48 = r17[r37]
                                                        r27 = upvalueValues[upvalues[2]]
                                                        r52 = upvalueValues[upvalues[3]]
                                                        r31 = 30384101472068
                                                        r25 = "5\215\245X\143"
                                                        r35 = r52(r25, r31)
                                                        r37 = r27[r35]
                                                        r34 = r53[r37]
                                                        r27 = upvalueValues[upvalues[2]]
                                                        r52 = upvalueValues[upvalues[3]]
                                                        r25 = "W \199\134"
                                                        r31 = 18654834631150
                                                        r35 = r52(r25, r31)
                                                        r37 = r27[r35]
                                                        r17 = r34[r37]
                                                        r37 = upvalueValues[upvalues[2]]
                                                        r27 = upvalueValues[upvalues[3]]
                                                        r25 = 5760114854522
                                                        r35 = "\213p6\221"
                                                        r52 = r27(r35, r25)
                                                        r34 = r37[r52]
                                                        r27 = upvalueValues[upvalues[2]]
                                                        r52 = upvalueValues[upvalues[3]]
                                                        r31 = 20516349175121
                                                        r25 = "\152\194\242I!\160\146\024\"\169o"
                                                        r35 = r52(r25, r31)
                                                        r37 = r27[r35]
                                                        r52 = upvalueValues[upvalues[2]]
                                                        r35 = upvalueValues[upvalues[3]]
                                                        r28 = 28509796660187
                                                        r31 = ".\159\029<@"
                                                        r25 = r35(r31, r28)
                                                        r27 = r52[r25]
                                                        r8 = {
                                                            [r48] = r17,
                                                            [r34] = r41,
                                                            [r37] = r27
                                                        }
                                                        r49[r5] = r8
                                                        r5 = upvalueValues[r13]
                                                        r48 = upvalueValues[upvalues[2]]
                                                        r17 = upvalueValues[upvalues[3]]
                                                        r37 = "{N\254q\225\178],J"
                                                        r27 = 8641149505463
                                                        r34 = r17(r37, r27)
                                                        r8 = r48[r34]
                                                        r49 = r5[r8]
                                                        r17 = upvalueValues[r13]
                                                        r37 = upvalueValues[upvalues[2]]
                                                        r27 = upvalueValues[upvalues[3]]
                                                        r35 = "\176\149_\000\135\180\031\234\197"
                                                        r25 = 26668255965314
                                                        r52 = r27(r35, r25)
                                                        r34 = r37[r52]
                                                        r48 = r17[r34]
                                                        r8 = #r48
                                                        r48 = 1
                                                        r5 = r8 + r48
                                                        r17 = upvalueValues[upvalues[2]]
                                                        r34 = upvalueValues[upvalues[3]]
                                                        r52 = 30688430110674
                                                        r27 = "\011\180\026H"
                                                        r37 = r34(r27, r52)
                                                        r48 = r17[r37]
                                                        r27 = upvalueValues[upvalues[2]]
                                                        r52 = upvalueValues[upvalues[3]]
                                                        r31 = 19139902071504
                                                        r25 = "/\1424\173\216"
                                                        r35 = r52(r25, r31)
                                                        r37 = r27[r35]
                                                        r34 = r53[r37]
                                                        r27 = upvalueValues[upvalues[2]]
                                                        r52 = upvalueValues[upvalues[3]]
                                                        r25 = "\171\243&\\"
                                                        r31 = 26410539249674
                                                        r35 = r52(r25, r31)
                                                        r37 = r27[r35]
                                                        r17 = r34[r37]
                                                        r37 = upvalueValues[upvalues[2]]
                                                        r27 = upvalueValues[upvalues[3]]
                                                        r25 = 15834248469709
                                                        r35 = "\202\005\169\231"
                                                        r52 = r27(r35, r25)
                                                        r34 = r37[r52]
                                                        r27 = upvalueValues[upvalues[2]]
                                                        r52 = upvalueValues[upvalues[3]]
                                                        r31 = 33564083289357
                                                        r25 = "\208\234\134&}\211|"
                                                        r35 = r52(r25, r31)
                                                        r37 = r27[r35]
                                                        r25 = upvalueValues[upvalues[2]]
                                                        r31 = upvalueValues[upvalues[3]]
                                                        r9 = "\002\2381\142\232"
                                                        r15 = 26746056110246
                                                        r28 = r31(r9, r15)
                                                        r35 = r25[r28]
                                                        r52 = r53[r35]
                                                        r25 = upvalueValues[upvalues[2]]
                                                        r31 = upvalueValues[upvalues[3]]
                                                        r15 = 23867530013546
                                                        r9 = "\194*Z\r\025\021j"
                                                        r28 = r31(r9, r15)
                                                        r35 = r25[r28]
                                                        r27 = r52[r35]
                                                        r35 = upvalueValues[upvalues[2]]
                                                        r25 = upvalueValues[upvalues[3]]
                                                        r9 = 24159226719218
                                                        r28 = "\148\131\210\244\155\186\158do\168\204\173"
                                                        r31 = r25(r28, r9)
                                                        r52 = r35[r31]
                                                        r28 = upvalueValues[upvalues[2]]
                                                        r9 = upvalueValues[upvalues[3]]
                                                        r58 = 4976247113997
                                                        r16 = "\190\226\139\130."
                                                        r15 = r9(r16, r58)
                                                        r31 = r28[r15]
                                                        r25 = r53[r31]
                                                        r28 = upvalueValues[upvalues[2]]
                                                        r9 = upvalueValues[upvalues[3]]
                                                        r58 = 31913415375372
                                                        r16 = "\227\217\2055S\165\231\183p9X\169"
                                                        r15 = r9(r16, r58)
                                                        r31 = r28[r15]
                                                        r35 = r25[r31]
                                                        r31 = upvalueValues[upvalues[2]]
                                                        r28 = upvalueValues[upvalues[3]]
                                                        r15 = "HX\181\n\246\250\130\243\156j\171"
                                                        r16 = 26983454568725
                                                        r9 = r28(r15, r16)
                                                        r25 = r31[r9]
                                                        r28 = upvalueValues[upvalues[2]]
                                                        r9 = upvalueValues[upvalues[3]]
                                                        r58 = 22248144808056
                                                        r16 = "\232\027\194\189\\"
                                                        r15 = r9(r16, r58)
                                                        r31 = r28[r15]
                                                        r8 = {
                                                            [r48] = r17,
                                                            [r34] = r41,
                                                            [r37] = r27,
                                                            [r52] = r35,
                                                            [r25] = r31
                                                        }
                                                        r49[r5] = r8
                                                        state = 93
                                                    end
                                                else
                                                    if state == 93 then
                                                        r8 = upvalueValues[upvalues[2]]
                                                        r48 = upvalueValues[upvalues[3]]
                                                        r34 = "\238M\217\198"
                                                        r37 = 26042802630495
                                                        r17 = r48(r34, r37)
                                                        r5 = r8[r17]
                                                        r49 = r53[r5]
                                                        state = r49 and (96) or (97)
                                                    end
                                                end
                                            else
                                                if state <= 94 then
                                                    if state == 94 then
                                                        r8 = upvalueValues[r3]
                                                        r35 = upvalueValues[upvalues[2]]
                                                        r25 = upvalueValues[upvalues[3]]
                                                        r28 = "\208\137\151\153\221"
                                                        r9 = 1253720359495
                                                        r31 = r25(r28, r9)
                                                        r52 = r35[r31]
                                                        r31 = "Color3"
                                                        r25 = _env[r31]
                                                        r28 = upvalueValues[upvalues[2]]
                                                        r9 = upvalueValues[upvalues[3]]
                                                        r16 = "\154\135>\165\255\177\180"
                                                        r58 = 5307641252263
                                                        r15 = r9(r16, r58)
                                                        r31 = r28[r15]
                                                        r35 = r25[r31]
                                                        r17 = "Log"
                                                        r17 = r8[r17]
                                                        r9 = 65
                                                        r28 = 65
                                                        r31 = 255
                                                        r25 = r35(r31, r28, r9)
                                                        r31 = upvalueValues[upvalues[2]]
                                                        r28 = upvalueValues[upvalues[3]]
                                                        r15 = "\224`.W\205\236e"
                                                        r16 = 13393519056988
                                                        r9 = r28(r15, r16)
                                                        r35 = r31[r9]
                                                        r9 = upvalueValues[upvalues[2]]
                                                        r15 = upvalueValues[upvalues[3]]
                                                        r26 = 24022144691122
                                                        r58 = "\t!\015\138\1748\138\127\240\0068S\165\021\146\019y\156\022d"
                                                        r16 = r15(r58, r26)
                                                        r28 = r9[r16]
                                                        r31 = r28 .. r49
                                                        r34 = {
                                                            [r52] = r25,
                                                            [r35] = r31
                                                        }
                                                        r17 = r17(r8, r34)
                                                        state = 95
                                                    end
                                                else
                                                    if state == 95 then
                                                        r8 = upvalueValues[r3]
                                                        r35 = upvalueValues[upvalues[2]]
                                                        r25 = upvalueValues[upvalues[3]]
                                                        r9 = 33947623898560
                                                        r28 = "\140\238\213\236\005"
                                                        r24 = nil
                                                        r13 = releaseUpvalue(r13)
                                                        r31 = r25(r28, r9)
                                                        r52 = r35[r31]
                                                        r31 = "Color3"
                                                        r25 = _env[r31]
                                                        r28 = upvalueValues[upvalues[2]]
                                                        r17 = "Log"
                                                        r9 = upvalueValues[upvalues[3]]
                                                        r16 = "\196\196\187L;lu"
                                                        r58 = 30489539688309
                                                        r15 = r9(r16, r58)
                                                        r9 = 84
                                                        r49 = nil
                                                        r31 = r28[r15]
                                                        r35 = r25[r31]
                                                        r15 = "\152\176\197\254\219\235F"
                                                        r31 = 84
                                                        r28 = 255
                                                        r26 = 8294612766486
                                                        r55 = nil
                                                        r17 = r8[r17]
                                                        r25 = r35(r31, r28, r9)
                                                        r31 = upvalueValues[upvalues[2]]
                                                        r28 = upvalueValues[upvalues[3]]
                                                        r16 = 1172301611553
                                                        r9 = r28(r15, r16)
                                                        r35 = r31[r9]
                                                        r9 = upvalueValues[upvalues[2]]
                                                        r58 = "[\237\185\1613'\232\189"
                                                        r15 = upvalueValues[upvalues[3]]
                                                        r61 = nil
                                                        r41 = nil
                                                        r16 = r15(r58, r26)
                                                        r28 = r9[r16]
                                                        r31 = r28 .. r5
                                                        r34 = {
                                                            [r52] = r25,
                                                            [r35] = r31
                                                        }
                                                        r17 = r17(r8, r34)
                                                        r8 = upvalueValues[r3]
                                                        r53 = nil
                                                        r17 = "Complete"
                                                        r46 = nil
                                                        r17 = r8[r17]
                                                        r5 = nil
                                                        r17 = r17(r8)
                                                        state = 80
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 97 then
                                                if state <= 96 then
                                                    if state == 96 then
                                                        r8 = upvalueValues[upvalues[2]]
                                                        r48 = upvalueValues[upvalues[3]]
                                                        r34 = "\194\206@\005"
                                                        r37 = 6745043995716
                                                        r17 = r48(r34, r37)
                                                        r5 = r8[r17]
                                                        r48 = upvalueValues[upvalues[2]]
                                                        r17 = upvalueValues[upvalues[3]]
                                                        r27 = 31422312872232
                                                        r37 = "_\007|$\245JVnv"
                                                        r34 = r17(r37, r27)
                                                        r8 = r48[r34]
                                                        r37 = upvalueValues[upvalues[2]]
                                                        r27 = upvalueValues[upvalues[3]]
                                                        r35 = "\202CqH"
                                                        r25 = 25261325774323
                                                        r52 = r27(r35, r25)
                                                        r34 = r37[r52]
                                                        r17 = r53[r34]
                                                        r37 = upvalueValues[upvalues[2]]
                                                        r27 = upvalueValues[upvalues[3]]
                                                        r35 = "\134\253]B\250\157o"
                                                        r25 = 21682017216368
                                                        r52 = r27(r35, r25)
                                                        r34 = r37[r52]
                                                        r48 = r17[r34]
                                                        r34 = upvalueValues[upvalues[2]]
                                                        r37 = upvalueValues[upvalues[3]]
                                                        r52 = "uf\192U8\227\213\148\167\207j"
                                                        r35 = 12233311163968
                                                        r27 = r37(r52, r35)
                                                        r17 = r34[r27]
                                                        r27 = "Vector3"
                                                        r37 = _env[r27]
                                                        r52 = upvalueValues[upvalues[2]]
                                                        r35 = upvalueValues[upvalues[3]]
                                                        r31 = "r\1720"
                                                        r28 = 33872081141148
                                                        r25 = r35(r31, r28)
                                                        r27 = r52[r25]
                                                        r34 = r37[r27]
                                                        r52 = "unpack"
                                                        r27 = _env[r52]
                                                        r28 = upvalueValues[upvalues[2]]
                                                        r9 = upvalueValues[upvalues[3]]
                                                        r58 = 755170066783
                                                        r16 = "\152{\255\220"
                                                        r15 = r9(r16, r58)
                                                        r31 = r28[r15]
                                                        r25 = r53[r31]
                                                        r28 = upvalueValues[upvalues[2]]
                                                        r9 = upvalueValues[upvalues[3]]
                                                        r58 = 34149213568541
                                                        r16 = "c\230\155\003}1\028!M2 "
                                                        r15 = r9(r16, r58)
                                                        r31 = r28[r15]
                                                        r35 = r25[r31]
                                                        r52 = {
                                                            r27(r35)
                                                        }
                                                        r37 = r34(unpack(r52))
                                                        r27 = upvalueValues[upvalues[2]]
                                                        r52 = upvalueValues[upvalues[3]]
                                                        r31 = 3991683729218
                                                        r25 = ".\1843\231\012t\161\031"
                                                        r35 = r52(r25, r31)
                                                        r34 = r27[r35]
                                                        r25 = upvalueValues[upvalues[2]]
                                                        r31 = upvalueValues[upvalues[3]]
                                                        r9 = "C\151\164\250"
                                                        r15 = 24750476799237
                                                        r28 = r31(r9, r15)
                                                        r35 = r25[r28]
                                                        r52 = r53[r35]
                                                        r25 = upvalueValues[upvalues[2]]
                                                        r31 = upvalueValues[upvalues[3]]
                                                        r15 = 16075750432061
                                                        r9 = "\198S\012<\246\143\"Z"
                                                        r28 = r31(r9, r15)
                                                        r35 = r25[r28]
                                                        r27 = r52[r35]
                                                        r35 = upvalueValues[upvalues[2]]
                                                        r25 = upvalueValues[upvalues[3]]
                                                        r9 = 34375785201287
                                                        r28 = "-\223\250\235\137"
                                                        r31 = r25(r28, r9)
                                                        r52 = r35[r31]
                                                        r31 = "Vector3"
                                                        r25 = _env[r31]
                                                        r28 = upvalueValues[upvalues[2]]
                                                        r9 = upvalueValues[upvalues[3]]
                                                        r16 = "b\212t"
                                                        r58 = 8220939325172
                                                        r15 = r9(r16, r58)
                                                        r31 = r28[r15]
                                                        r35 = r25[r31]
                                                        r28 = "unpack"
                                                        r31 = _env[r28]
                                                        r58 = upvalueValues[upvalues[2]]
                                                        r26 = upvalueValues[upvalues[3]]
                                                        r38 = 21835865286584
                                                        r59 = "N\215p\005"
                                                        r21 = r26(r59, r38)
                                                        r16 = r58[r21]
                                                        r15 = r53[r16]
                                                        r58 = upvalueValues[upvalues[2]]
                                                        r26 = upvalueValues[upvalues[3]]
                                                        r59 = "\219\244\239\"\204"
                                                        r38 = 19707762271193
                                                        r21 = r26(r59, r38)
                                                        r16 = r58[r21]
                                                        r9 = r15[r16]
                                                        r28 = {
                                                            r31(r9)
                                                        }
                                                        r25 = r35(unpack(r28))
                                                        r31 = upvalueValues[upvalues[2]]
                                                        r28 = upvalueValues[upvalues[3]]
                                                        r15 = ")\018\240\254U3"
                                                        r16 = 1546363880144
                                                        r9 = r28(r15, r16)
                                                        r35 = r31[r9]
                                                        r9 = "Vector3"
                                                        r28 = _env[r9]
                                                        r15 = upvalueValues[upvalues[2]]
                                                        r16 = upvalueValues[upvalues[3]]
                                                        r21 = 30477014792047
                                                        r26 = "\029I\191"
                                                        r58 = r16(r26, r21)
                                                        r9 = r15[r58]
                                                        r31 = r28[r9]
                                                        r15 = "unpack"
                                                        r9 = _env[r15]
                                                        r21 = upvalueValues[upvalues[2]]
                                                        r59 = upvalueValues[upvalues[3]]
                                                        r29 = 11191646131291
                                                        r39 = "Hs2\002"
                                                        r38 = r59(r39, r29)
                                                        r26 = r21[r38]
                                                        r58 = r53[r26]
                                                        r21 = upvalueValues[upvalues[2]]
                                                        r59 = upvalueValues[upvalues[3]]
                                                        r39 = "F\252xo\233;"
                                                        r29 = 32234793990818
                                                        r38 = r59(r39, r29)
                                                        r26 = r21[r38]
                                                        r16 = r58[r26]
                                                        r15 = {
                                                            r9(r16)
                                                        }
                                                        r28 = r31(unpack(r15))
                                                        r49 = {
                                                            [r5] = r41,
                                                            [r8] = r48,
                                                            [r17] = r37,
                                                            [r34] = r27,
                                                            [r52] = r25,
                                                            [r35] = r28
                                                        }
                                                        r34 = upvalueValues[upvalues[2]]
                                                        r37 = upvalueValues[upvalues[3]]
                                                        r35 = 14432544758336
                                                        r52 = "\216\004\006\142"
                                                        r27 = r37(r52, r35)
                                                        r17 = r34[r27]
                                                        r48 = r53[r17]
                                                        r34 = upvalueValues[upvalues[2]]
                                                        r37 = upvalueValues[upvalues[3]]
                                                        r35 = 2417813292133
                                                        r52 = "\007L\242l\238\176\023z"
                                                        r27 = r37(r52, r35)
                                                        r17 = r34[r27]
                                                        r8 = r48[r17]
                                                        r37 = "Enum"
                                                        r34 = _env[r37]
                                                        r27 = upvalueValues[upvalues[2]]
                                                        r52 = upvalueValues[upvalues[3]]
                                                        r31 = 12884670355311
                                                        r25 = "s\002Nd\156\185x\027"
                                                        r35 = r52(r25, r31)
                                                        r37 = r27[r35]
                                                        r17 = r34[r37]
                                                        r37 = upvalueValues[upvalues[2]]
                                                        r27 = upvalueValues[upvalues[3]]
                                                        r25 = 12812255942478
                                                        r35 = "`s\158\159\242\205\129\170"
                                                        r52 = r27(r35, r25)
                                                        r34 = r37[r52]
                                                        r48 = r17[r34]
                                                        r5 = r8 == r48
                                                        state = r5 and (98) or (99)
                                                    end
                                                else
                                                    if state == 97 then
                                                        r41 = nil
                                                        r53 = nil
                                                        state = 79
                                                    end
                                                end
                                            else
                                                if state <= 98 then
                                                    if state == 98 then
                                                        r8 = upvalueValues[upvalues[2]]
                                                        r48 = upvalueValues[upvalues[3]]
                                                        r34 = "\237\029\192\176s\144"
                                                        r37 = 29163869402380
                                                        r17 = r48(r34, r37)
                                                        r5 = r8[r17]
                                                        r34 = upvalueValues[upvalues[2]]
                                                        r37 = upvalueValues[upvalues[3]]
                                                        r35 = 1567828280026
                                                        r52 = "\181\181s\222"
                                                        r27 = r37(r52, r35)
                                                        r17 = r34[r27]
                                                        r48 = r53[r17]
                                                        r34 = upvalueValues[upvalues[2]]
                                                        r37 = upvalueValues[upvalues[3]]
                                                        r52 = "\167\2145L\139\142"
                                                        r35 = 1787110572864
                                                        r27 = r37(r52, r35)
                                                        r17 = r34[r27]
                                                        r8 = r48[r17]
                                                        r49[r5] = r8
                                                        state = 99
                                                    end
                                                else
                                                    if state == 99 then
                                                        r8 = upvalueValues[r13]
                                                        r17 = upvalueValues[upvalues[2]]
                                                        r34 = upvalueValues[upvalues[3]]
                                                        r27 = "\0053\245\207"
                                                        r52 = 34140116516377
                                                        r37 = r34(r27, r52)
                                                        r48 = r17[r37]
                                                        r5 = r8[r48]
                                                        r34 = upvalueValues[r13]
                                                        r27 = upvalueValues[upvalues[2]]
                                                        r52 = upvalueValues[upvalues[3]]
                                                        r31 = 33481243655398
                                                        r25 = "\195\201\229:"
                                                        r35 = r52(r25, r31)
                                                        r37 = r27[r35]
                                                        r17 = r34[r37]
                                                        r48 = #r17
                                                        r17 = 1
                                                        r8 = r48 + r17
                                                        r34 = upvalueValues[upvalues[2]]
                                                        r37 = upvalueValues[upvalues[3]]
                                                        r52 = "\025\143>\174"
                                                        r35 = 28770565141589
                                                        r27 = r37(r52, r35)
                                                        r17 = r34[r27]
                                                        r27 = upvalueValues[upvalues[2]]
                                                        r52 = upvalueValues[upvalues[3]]
                                                        r25 = "\189\225_\019"
                                                        r31 = 21203889235601
                                                        r35 = r52(r25, r31)
                                                        r37 = r27[r35]
                                                        r34 = r49[r37]
                                                        r48 = {
                                                            [r17] = r34
                                                        }
                                                        r5[r8] = r48
                                                        r8 = upvalueValues[r13]
                                                        r17 = upvalueValues[upvalues[2]]
                                                        r34 = upvalueValues[upvalues[3]]
                                                        r52 = 24339674180678
                                                        r27 = "\207Pft\132\007\025 "
                                                        r37 = r34(r27, r52)
                                                        r48 = r17[r37]
                                                        r5 = r8[r48]
                                                        r34 = upvalueValues[r13]
                                                        r27 = upvalueValues[upvalues[2]]
                                                        r52 = upvalueValues[upvalues[3]]
                                                        r25 = "\250\196vK\003\246s\227"
                                                        r31 = 331237032090
                                                        r35 = r52(r25, r31)
                                                        r37 = r27[r35]
                                                        r17 = r34[r37]
                                                        r48 = #r17
                                                        r17 = 1
                                                        r8 = r48 + r17
                                                        r48 = r49
                                                        r5[r8] = r48
                                                        r49 = nil
                                                        state = 97
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
                    if state <= 113 then
                        if state <= 105 then
                            if state <= 100 then
                                -- createClosure1 entry 11234891 -> 100, states 100-100
                                if state == 100 then -- entry 11234891 -> 100
                                    r32 = 9954072
                                    r57 = "KVmZwXcpu"
                                    r7 = r57 ^ r32
                                    ReturnVal = 13779005
                                    state = ReturnVal - r7
                                    r7 = state
                                    ReturnVal = "Bb"
                                    state = ReturnVal / r7
                                    ReturnVal = {
                                        state
                                    }
                                    state = nil
                                end
                            else
                                -- createClosure2 entry 6393984 -> 101, states 101-105
                                if state <= 103 then
                                    if state <= 102 then
                                        if state <= 101 then
                                            if state == 101 then -- entry 6393984 -> 101
                                                r7 = args[1]
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                state = ReturnVal[r7]
                                                r57 = state
                                                r32 = upvalueValues[upvalues[2]]
                                                r3 = upvalueValues[upvalues[3]]
                                                r33 = 23988978477986
                                                r60 = "\011\244\008\182\214"
                                                r10 = r3(r60, r33)
                                                ReturnVal = r32[r10]
                                                state = r57[ReturnVal]
                                                r32 = state
                                                state = upvalueValues[upvalues[4]]
                                                r10 = upvalueValues[upvalues[2]]
                                                r60 = upvalueValues[upvalues[3]]
                                                r4 = "\156\255\208!}\153\012o#_"
                                                r51 = 24142101556202
                                                r33 = r60(r4, r51)
                                                r3 = r10[r33]
                                                r23 = upvalueValues[upvalues[2]]
                                                r22 = upvalueValues[upvalues[3]]
                                                r19 = "5\207\196\173\004"
                                                r20 = 29607348680154
                                                r54 = r22(r19, r20)
                                                r50 = r23[r54]
                                                r18 = r57[r50]
                                                r23 = upvalueValues[upvalues[2]]
                                                r22 = upvalueValues[upvalues[3]]
                                                r20 = 22731470580057
                                                r19 = "\215-\196<\005"
                                                r54 = r22(r19, r20)
                                                r50 = r23[r54]
                                                r51 = r18 == r50
                                                r60 = state
                                                r4 = state
                                                state = r51 and (102) or (103)
                                                r33 = r51
                                            end
                                        else
                                            if state == 102 then
                                                r18 = upvalueValues[upvalues[2]]
                                                r50 = upvalueValues[upvalues[3]]
                                                r22 = "\200~\228\018\217\250"
                                                r54 = 23483633429175
                                                r23 = r50(r22, r54)
                                                r51 = r18[r23]
                                                r33 = r51
                                                state = 103
                                            end
                                        end
                                    else
                                        if state == 103 then
                                            state = r4
                                            state = r33 and (104) or (105)
                                            r10 = r33
                                        end
                                    end
                                else
                                    if state <= 104 then
                                        if state == 104 then
                                            state = r60
                                            r23 = "s\242\164"
                                            r32 = nil
                                            r4 = "CFrame"
                                            r33 = _env[r4]
                                            r51 = upvalueValues[upvalues[2]]
                                            r18 = upvalueValues[upvalues[3]]
                                            r22 = 27675145794135
                                            r50 = r18(r23, r22)
                                            r4 = r51[r50]
                                            r60 = r33[r4]
                                            r51 = "unpack"
                                            r4 = _env[r51]
                                            r23 = upvalueValues[upvalues[2]]
                                            ReturnVal = "InvokeServer"
                                            ReturnVal = state[ReturnVal]
                                            r22 = upvalueValues[upvalues[3]]
                                            r20 = 32884800568273
                                            r19 = "o\211\149\203Q\163"
                                            r54 = r22(r19, r20)
                                            r50 = r23[r54]
                                            r18 = r57[r50]
                                            r51 = {
                                                r4(r18)
                                            }
                                            r33 = r60(unpack(r51))
                                            r51 = "game"
                                            r4 = _env[r51]
                                            r18 = upvalueValues[upvalues[2]]
                                            r50 = upvalueValues[upvalues[3]]
                                            r22 = "\161\022A\229\1463:L\191"
                                            r54 = 34811799928658
                                            r23 = r50(r22, r54)
                                            r51 = r18[r23]
                                            r7 = nil
                                            r57 = nil
                                            r60 = r4[r51]
                                            ReturnVal = ReturnVal(state, r3, r10, r33, r60)
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    else
                                        if state == 105 then
                                            r10 = r32
                                            state = 104
                                        end
                                    end
                                end
                            end
                        else
                            if state <= 110 then
                                -- createClosure5 entry 9596846 -> 106, states 106-110
                                if state <= 108 then
                                    if state <= 107 then
                                        if state <= 106 then
                                            if state == 106 then -- entry 9596846 -> 106
                                                r7 = args[1]
                                                state = upvalueValues[upvalues[1]]
                                                r32 = upvalueValues[upvalues[1]]
                                                r57 = #r32
                                                r32 = 1
                                                ReturnVal = r57 + r32
                                                r57 = {}
                                                state[ReturnVal] = r57
                                                r57 = upvalueValues[upvalues[2]]
                                                r32 = upvalueValues[upvalues[3]]
                                                r60 = 33785570409844
                                                r10 = "Y\188\213\232T"
                                                r3 = r32(r10, r60)
                                                ReturnVal = r57[r3]
                                                state = r7[ReturnVal]
                                                r4 = upvalueValues[upvalues[2]]
                                                r51 = upvalueValues[upvalues[3]]
                                                r23 = 14004579998073
                                                r50 = "T8n7V"
                                                r18 = r51(r50, r23)
                                                r33 = r4[r18]
                                                r60 = r7[r33]
                                                r4 = upvalueValues[upvalues[2]]
                                                r51 = upvalueValues[upvalues[3]]
                                                r50 = "{A\198\205\177"
                                                r23 = 1132409405967
                                                r18 = r51(r50, r23)
                                                r33 = r4[r18]
                                                r10 = r60 == r33
                                                r57 = state
                                                r3 = state
                                                state = r10 and (107) or (108)
                                                r32 = r10
                                            end
                                        else
                                            if state == 107 then
                                                r60 = upvalueValues[upvalues[2]]
                                                r33 = upvalueValues[upvalues[3]]
                                                r18 = 20584799741297
                                                r51 = "\029\160\r\174\000\014"
                                                r4 = r33(r51, r18)
                                                r10 = r60[r4]
                                                r32 = r10
                                                state = 108
                                            end
                                        end
                                    else
                                        if state == 108 then
                                            state = r3
                                            state = r32 and (109) or (110)
                                            ReturnVal = r32
                                        end
                                    end
                                else
                                    if state <= 109 then
                                        if state == 109 then
                                            r32 = ReturnVal
                                            state = upvalueValues[upvalues[1]]
                                            r3 = upvalueValues[upvalues[1]]
                                            ReturnVal = #r3
                                            r60 = upvalueValues[upvalues[2]]
                                            r33 = upvalueValues[upvalues[3]]
                                            r51 = "\177\016\025\241"
                                            r18 = 16597904596529
                                            r4 = r33(r51, r18)
                                            r10 = r60[r4]
                                            r18 = "\217\185!\012"
                                            r33 = upvalueValues[upvalues[2]]
                                            r57 = nil
                                            r4 = upvalueValues[upvalues[3]]
                                            r50 = 8749208424426
                                            r51 = r4(r18, r50)
                                            r60 = r33[r51]
                                            r3 = {
                                                [r10] = r32,
                                                [r60] = r7
                                            }
                                            r7 = nil
                                            state[ReturnVal] = r3
                                            r32 = nil
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    else
                                        if state == 110 then
                                            ReturnVal = r57
                                            state = 109
                                        end
                                    end
                                end
                            else
                                -- createClosure4 entry 7036778 -> 111, states 111-113
                                if state <= 112 then
                                    if state <= 111 then
                                        if state == 111 then -- entry 7036778 -> 111
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r7 = args[1]
                                            state = ReturnVal[r7]
                                            state = state and (112) or (113)
                                        end
                                    else
                                        if state == 112 then
                                            state = upvalueValues[upvalues[2]]
                                            ReturnVal = "Fire"
                                            ReturnVal = state[ReturnVal]
                                            r32 = upvalueValues[upvalues[1]]
                                            r57 = r32[r7]
                                            ReturnVal = ReturnVal(state, r57)
                                            r57 = "table"
                                            ReturnVal = _env[r57]
                                            r32 = upvalueValues[upvalues[3]]
                                            r3 = upvalueValues[upvalues[4]]
                                            r60 = "\016\019\147\208&\179"
                                            r33 = 32156295527037
                                            r10 = r3(r60, r33)
                                            r57 = r32[r10]
                                            state = ReturnVal[r57]
                                            r57 = upvalueValues[upvalues[1]]
                                            r3 = upvalueValues[upvalues[1]]
                                            r32 = r3[r7]
                                            ReturnVal = state(r57, r32)
                                            state = 113
                                        end
                                    end
                                else
                                    if state == 113 then
                                        r7 = nil
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            end
                        end
                    else
                        if state <= 131 then
                            if state <= 114 then
                                -- createClosure6 entry 9636500 -> 114, states 114-114
                                if state == 114 then -- entry 9636500 -> 114
                                    r57 = args[2]
                                    r7 = args[1]
                                    r32 = args[3]
                                    state = r7 / r57
                                    r3 = state
                                    r10 = "math"
                                    ReturnVal = _env[r10]
                                    r60 = upvalueValues[upvalues[1]]
                                    r33 = upvalueValues[upvalues[2]]
                                    r51 = "\"\170)9\r"
                                    r18 = 8945757458501
                                    r4 = r33(r51, r18)
                                    r10 = r60[r4]
                                    state = ReturnVal[r10]
                                    r10 = r32 * r3
                                    ReturnVal = state(r10)
                                    r10 = ReturnVal
                                    state = r32 - r10
                                    r60 = state
                                    r33 = "string"
                                    ReturnVal = _env[r33]
                                    r4 = upvalueValues[upvalues[1]]
                                    r51 = upvalueValues[upvalues[2]]
                                    r23 = 34203271314999
                                    r50 = "\152\016\218"
                                    r18 = r51(r50, r23)
                                    r33 = r4[r18]
                                    state = ReturnVal[r33]
                                    r4 = upvalueValues[upvalues[1]]
                                    r51 = upvalueValues[upvalues[2]]
                                    r23 = 32451019586311
                                    r50 = "\190\142b\171r\204"
                                    r18 = r51(r50, r23)
                                    r33 = r4[r18]
                                    ReturnVal = state(r33, r10)
                                    r33 = ReturnVal
                                    r4 = "string"
                                    ReturnVal = _env[r4]
                                    r51 = upvalueValues[upvalues[1]]
                                    r18 = upvalueValues[upvalues[2]]
                                    r22 = 32934735936488
                                    r23 = "\031hQ"
                                    r50 = r18(r23, r22)
                                    r4 = r51[r50]
                                    state = ReturnVal[r4]
                                    r51 = upvalueValues[upvalues[1]]
                                    r18 = upvalueValues[upvalues[2]]
                                    r22 = 23161000782369
                                    r23 = "\162\028PF\230g"
                                    r50 = r18(r23, r22)
                                    r4 = r51[r50]
                                    ReturnVal = state(r4, r60)
                                    r4 = ReturnVal
                                    r51 = "string"
                                    ReturnVal = _env[r51]
                                    r18 = upvalueValues[upvalues[1]]
                                    r50 = upvalueValues[upvalues[2]]
                                    r54 = 26873996161250
                                    r22 = "\237@\156\136\131-"
                                    r23 = r50(r22, r54)
                                    r51 = r18[r23]
                                    state = ReturnVal[r51]
                                    r18 = upvalueValues[upvalues[1]]
                                    r50 = upvalueValues[upvalues[2]]
                                    r54 = 20481834411329
                                    r22 = "\253\001H\132}M"
                                    r23 = r50(r22, r54)
                                    r51 = r18[r23]
                                    ReturnVal = {
                                        state(r51, r33, r4)
                                    }
                                    ReturnVal = {
                                        unpack(ReturnVal)
                                    }
                                    state = nil
                                end
                            else
                                -- createClosure3 entry 13677267 -> 115, states 115-131
                                if state <= 123 then
                                    if state <= 119 then
                                        if state <= 117 then
                                            if state <= 116 then
                                                if state <= 115 then
                                                    if state == 115 then -- entry 13677267 -> 115
                                                        state = createClosure2(133, {
                                                            upvalues[1],
                                                            upvalues[2],
                                                            upvalues[3],
                                                            upvalues[4],
                                                            upvalues[5],
                                                            upvalues[6]
                                                        })
                                                        ReturnVal = state()
                                                        r7 = "task"
                                                        ReturnVal = _env[r7]
                                                        r57 = upvalueValues[upvalues[2]]
                                                        r32 = upvalueValues[upvalues[3]]
                                                        r60 = 4179724814234
                                                        r10 = "\235\167\008P"
                                                        r3 = r32(r10, r60)
                                                        r7 = r57[r3]
                                                        state = ReturnVal[r7]
                                                        ReturnVal = state()
                                                        ReturnVal = "pairs"
                                                        state = _env[ReturnVal]
                                                        r32 = upvalueValues[upvalues[1]]
                                                        r3 = {
                                                            state(r32)
                                                        }
                                                        r7 = r3[2]
                                                        r57 = r3[3]
                                                        ReturnVal = r3[1]
                                                        state = {}
                                                        r3 = state
                                                        r32 = ReturnVal
                                                        state = 116
                                                    end
                                                else
                                                    if state == 116 then
                                                        state = true
                                                        state = state and (117) or (118)
                                                    end
                                                end
                                            else
                                                if state == 117 then
                                                    r60 = {
                                                        r32(r7, r57)
                                                    }
                                                    ReturnVal = r60[2]
                                                    state = nil
                                                    r10 = state
                                                    state = r60[1]
                                                    r57 = state
                                                    r33 = nil
                                                    r60 = r57 == r33
                                                    state = r60 and (119) or (120)
                                                    r10 = ReturnVal
                                                end
                                            end
                                        else
                                            if state <= 118 then
                                                if state == 118 then
                                                    r10 = upvalueValues[upvalues[5]]
                                                    r4 = upvalueValues[upvalues[2]]
                                                    r51 = upvalueValues[upvalues[3]]
                                                    r23 = 12309512722020
                                                    r50 = "\204wP\232P"
                                                    r18 = r51(r50, r23)
                                                    r33 = r4[r18]
                                                    r60 = "InvokeServer"
                                                    r60 = r10[r60]
                                                    r18 = "game"
                                                    r57 = nil
                                                    r51 = _env[r18]
                                                    r6 = 873750069654
                                                    r50 = upvalueValues[upvalues[2]]
                                                    r47 = "\194\199\255\194Mv*J%"
                                                    r23 = upvalueValues[upvalues[3]]
                                                    r7 = nil
                                                    r45 = r23(r47, r6)
                                                    r18 = r50[r45]
                                                    r4 = r51[r18]
                                                    r60 = r60(r10, r33, r3, r4)
                                                    r33 = "task"
                                                    r60 = _env[r33]
                                                    r4 = upvalueValues[upvalues[2]]
                                                    r51 = upvalueValues[upvalues[3]]
                                                    r23 = 25962660409145
                                                    r50 = "\215N*\158"
                                                    r18 = r51(r50, r23)
                                                    r32 = nil
                                                    r33 = r4[r18]
                                                    r10 = r60[r33]
                                                    r3 = nil
                                                    ReturnVal = {}
                                                    r33 = 2
                                                    r60 = r10(r33)
                                                    state = nil
                                                end
                                            else
                                                if state == 119 then
                                                    r33 = nil
                                                    r4 = nil
                                                    r10 = nil
                                                    r50 = nil
                                                    r60 = nil
                                                    r23 = nil
                                                    r51 = nil
                                                    r18 = nil
                                                    state = 118
                                                end
                                            end
                                        end
                                    else
                                        if state <= 121 then
                                            if state <= 120 then
                                                if state == 120 then
                                                    r54 = upvalueValues[upvalues[7]]
                                                    r20 = upvalueValues[upvalues[7]]
                                                    r19 = #r20
                                                    r22 = r54[r19]
                                                    r60 = r22
                                                    r20 = upvalueValues[upvalues[2]]
                                                    r45 = upvalueValues[upvalues[3]]
                                                    r6 = "C\173\156M"
                                                    r1 = 7033957649611
                                                    r47 = r45(r6, r1)
                                                    r19 = r20[r47]
                                                    r54 = r60[r19]
                                                    r20 = upvalueValues[upvalues[2]]
                                                    r45 = upvalueValues[upvalues[3]]
                                                    r6 = "p\214^\026D"
                                                    r1 = 30273687975697
                                                    r47 = r45(r6, r1)
                                                    r19 = r20[r47]
                                                    r22 = r54[r19]
                                                    r40 = upvalueValues[upvalues[2]]
                                                    r30 = upvalueValues[upvalues[3]]
                                                    r42 = "\156\229\191\134"
                                                    r44 = 20777629410763
                                                    r43 = r30(r42, r44)
                                                    r1 = r40[r43]
                                                    r6 = r60[r1]
                                                    r40 = upvalueValues[upvalues[2]]
                                                    r30 = upvalueValues[upvalues[3]]
                                                    r42 = "\176\030s\1878"
                                                    r44 = 15783166074037
                                                    r43 = r30(r42, r44)
                                                    r1 = r40[r43]
                                                    r47 = r6[r1]
                                                    r1 = upvalueValues[upvalues[2]]
                                                    r40 = upvalueValues[upvalues[3]]
                                                    r43 = "\156\004\210\189\210"
                                                    r42 = 12312609379941
                                                    r30 = r40(r43, r42)
                                                    r6 = r1[r30]
                                                    r45 = r47 == r6
                                                    r54 = state
                                                    r20 = state
                                                    state = r45 and (121) or (122)
                                                    r19 = r45
                                                    r33 = r22
                                                end
                                            else
                                                if state == 121 then
                                                    r47 = upvalueValues[upvalues[2]]
                                                    r6 = upvalueValues[upvalues[3]]
                                                    r40 = "^\176\216h!\157"
                                                    r30 = 28570261238776
                                                    r1 = r6(r40, r30)
                                                    r45 = r47[r1]
                                                    r19 = r45
                                                    state = 122
                                                end
                                            end
                                        else
                                            if state <= 122 then
                                                if state == 122 then
                                                    state = r20
                                                    state = r19 and (123) or (124)
                                                    r22 = r19
                                                end
                                            else
                                                if state == 123 then
                                                    r4 = r22
                                                    state = r54
                                                    r54 = "pairs"
                                                    r22 = _env[r54]
                                                    r45 = upvalueValues[upvalues[7]]
                                                    r47 = {
                                                        r22(r45)
                                                    }
                                                    r54 = r47[1]
                                                    r19 = r47[2]
                                                    r20 = r47[3]
                                                    r18 = r19
                                                    r51 = r54
                                                    r50 = r20
                                                    state = 125
                                                end
                                            end
                                        end
                                    end
                                else
                                    if state <= 127 then
                                        if state <= 125 then
                                            if state <= 124 then
                                                if state == 124 then
                                                    r22 = r33
                                                    state = 123
                                                end
                                            else
                                                if state == 125 then
                                                    r22 = true
                                                    state = r22 and (126) or (127)
                                                end
                                            end
                                        else
                                            if state <= 126 then
                                                if state == 126 then
                                                    r20 = {
                                                        r51(r18, r50)
                                                    }
                                                    r54 = r20[1]
                                                    r19 = r20[2]
                                                    r50 = r54
                                                    r45 = nil
                                                    r20 = r50 == r45
                                                    state = r20 and (128) or (129)
                                                    r22 = nil
                                                    r22 = r19
                                                end
                                            else
                                                if state == 127 then
                                                    r20 = upvalueValues[upvalues[8]]
                                                    r45 = 1
                                                    r22 = r20 + r45
                                                    upvalueValues[upvalues[8]] = r22
                                                    r20 = upvalueValues[upvalues[8]]
                                                    upvalueValues[upvalues[9]] = r20
                                                    r6 = "math"
                                                    r47 = _env[r6]
                                                    r1 = upvalueValues[upvalues[2]]
                                                    r40 = upvalueValues[upvalues[3]]
                                                    r43 = "\028\2169\028l"
                                                    r42 = 31492082858312
                                                    r30 = r40(r43, r42)
                                                    r6 = r1[r30]
                                                    r45 = r47[r6]
                                                    r40 = upvalueValues[upvalues[9]]
                                                    r30 = upvalueValues[upvalues[10]]
                                                    r1 = r40 / r30
                                                    r40 = 100
                                                    r6 = r1 * r40
                                                    r47 = r45(r6)
                                                    r45 = upvalueValues[upvalues[11]]
                                                    r23 = r47
                                                    r42 = "/\224#w\228"
                                                    r14 = 4735906171037
                                                    r55 = 7429905665411
                                                    r24 = 12485812704950
                                                    r61 = "\244\129"
                                                    r47 = "Edit"
                                                    r4 = nil
                                                    r60 = nil
                                                    r40 = upvalueValues[upvalues[2]]
                                                    r30 = upvalueValues[upvalues[3]]
                                                    r44 = 7002857049276
                                                    r43 = r30(r42, r44)
                                                    r1 = r40[r43]
                                                    r40 = upvalueValues[upvalues[11]]
                                                    r10 = nil
                                                    r30 = "GetColor"
                                                    r30 = r40[r30]
                                                    r30 = r30(r40)
                                                    r43 = upvalueValues[upvalues[2]]
                                                    r42 = upvalueValues[upvalues[3]]
                                                    r12 = ");<B>\012W"
                                                    r44 = r42(r12, r14)
                                                    r40 = r43[r44]
                                                    r2 = "\142\131\196\023\142\0244`8\024"
                                                    r33 = nil
                                                    r44 = upvalueValues[upvalues[2]]
                                                    r12 = upvalueValues[upvalues[3]]
                                                    r14 = r12(r2, r55)
                                                    r51 = nil
                                                    r42 = r44[r14]
                                                    r50 = nil
                                                    r2 = upvalueValues[upvalues[2]]
                                                    r55 = upvalueValues[upvalues[3]]
                                                    r46 = r55(r61, r24)
                                                    r14 = r2[r46]
                                                    r2 = upvalueValues[upvalues[12]]
                                                    r46 = upvalueValues[upvalues[9]]
                                                    r47 = r45[r47]
                                                    r24 = 20
                                                    r18 = nil
                                                    r61 = upvalueValues[upvalues[10]]
                                                    r55 = r2(r46, r61, r24)
                                                    r12 = r14 .. r55
                                                    r44 = r23 .. r12
                                                    r43 = r42 .. r44
                                                    r23 = nil
                                                    r6 = {
                                                        [r1] = r30,
                                                        [r40] = r43
                                                    }
                                                    r47 = r47(r45, r6)
                                                    state = 116
                                                end
                                            end
                                        end
                                    else
                                        if state <= 129 then
                                            if state <= 128 then
                                                if state == 128 then
                                                    r22 = nil
                                                    state = 127
                                                end
                                            else
                                                if state == 129 then
                                                    r6 = upvalueValues[upvalues[2]]
                                                    r1 = upvalueValues[upvalues[3]]
                                                    r30 = "\174\140P\002"
                                                    r43 = 12755089512243
                                                    r40 = r1(r30, r43)
                                                    r47 = r6[r40]
                                                    r45 = r22[r47]
                                                    r20 = r45 == r4
                                                    state = r20 and (130) or (131)
                                                end
                                            end
                                        else
                                            if state <= 130 then
                                                if state == 130 then
                                                    r45 = #r3
                                                    r47 = 1
                                                    r20 = r45 + r47
                                                    r6 = upvalueValues[upvalues[2]]
                                                    r1 = upvalueValues[upvalues[3]]
                                                    r30 = "\162>'\162"
                                                    r43 = 25827885608699
                                                    r40 = r1(r30, r43)
                                                    r47 = r6[r40]
                                                    r45 = r22[r47]
                                                    r3[r20] = r45
                                                    state = 131
                                                end
                                            else
                                                if state == 131 then
                                                    r22 = nil
                                                    state = 125
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            if state <= 132 then
                                -- createClosure4 entry 11085411 -> 132, states 132-132
                                if state == 132 then -- entry 11085411 -> 132
                                    state = upvalueValues[upvalues[1]]
                                    r57 = upvalueValues[upvalues[2]]
                                    r32 = upvalueValues[upvalues[3]]
                                    r10 = "\168\170\007\160B\175l\239\168"
                                    r60 = 17441830002617
                                    r3 = r32(r10, r60)
                                    r7 = r57[r3]
                                    r32 = upvalueValues[upvalues[4]]
                                    r10 = upvalueValues[upvalues[2]]
                                    r60 = upvalueValues[upvalues[3]]
                                    r4 = "\018\177PlR^"
                                    r51 = 14416627849785
                                    r33 = r60(r4, r51)
                                    r3 = r10[r33]
                                    r57 = r32[r3]
                                    ReturnVal = "InvokeServer"
                                    ReturnVal = state[ReturnVal]
                                    ReturnVal = ReturnVal(state, r7, r57)
                                    state = upvalueValues[upvalues[1]]
                                    r57 = upvalueValues[upvalues[2]]
                                    r32 = upvalueValues[upvalues[3]]
                                    r60 = 22013254248458
                                    r10 = "<7\210\183\027\229G\177\162S"
                                    r3 = r32(r10, r60)
                                    r7 = r57[r3]
                                    r32 = upvalueValues[upvalues[4]]
                                    r10 = upvalueValues[upvalues[2]]
                                    r60 = upvalueValues[upvalues[3]]
                                    ReturnVal = "InvokeServer"
                                    ReturnVal = state[ReturnVal]
                                    r4 = "\173u\161%bn"
                                    r51 = 29675141166586
                                    r33 = r60(r4, r51)
                                    r3 = r10[r33]
                                    r57 = r32[r3]
                                    ReturnVal = ReturnVal(state, r7, r57)
                                    state = upvalueValues[upvalues[1]]
                                    r57 = upvalueValues[upvalues[2]]
                                    r32 = upvalueValues[upvalues[3]]
                                    r60 = 13104336885718
                                    r10 = " \168O-\225D\003\253\245\234\206"
                                    r3 = r32(r10, r60)
                                    r7 = r57[r3]
                                    ReturnVal = "InvokeServer"
                                    ReturnVal = state[ReturnVal]
                                    r32 = upvalueValues[upvalues[4]]
                                    r10 = upvalueValues[upvalues[2]]
                                    r60 = upvalueValues[upvalues[3]]
                                    r4 = "\163\2547\222\179\198\191"
                                    r51 = 22768424331626
                                    r33 = r60(r4, r51)
                                    r3 = r10[r33]
                                    r57 = r32[r3]
                                    ReturnVal = ReturnVal(state, r7, r57)
                                    state = upvalueValues[upvalues[1]]
                                    r57 = upvalueValues[upvalues[2]]
                                    r32 = upvalueValues[upvalues[3]]
                                    r60 = 28639982646296
                                    r10 = "2\022\247\232-\227\194_\217\132\168\230"
                                    r3 = r32(r10, r60)
                                    r7 = r57[r3]
                                    r32 = upvalueValues[upvalues[4]]
                                    r10 = upvalueValues[upvalues[2]]
                                    r60 = upvalueValues[upvalues[3]]
                                    r51 = 17096020614936
                                    r4 = "}\190dQ\176\151`4"
                                    r33 = r60(r4, r51)
                                    r3 = r10[r33]
                                    ReturnVal = "InvokeServer"
                                    ReturnVal = state[ReturnVal]
                                    r57 = r32[r3]
                                    ReturnVal = ReturnVal(state, r7, r57)
                                    state = upvalueValues[upvalues[1]]
                                    r57 = upvalueValues[upvalues[2]]
                                    r32 = upvalueValues[upvalues[3]]
                                    r60 = 12334529025647
                                    r10 = "\2265\011\164\195\247\202ez\241"
                                    r3 = r32(r10, r60)
                                    r7 = r57[r3]
                                    r32 = upvalueValues[upvalues[4]]
                                    r10 = upvalueValues[upvalues[2]]
                                    ReturnVal = "InvokeServer"
                                    ReturnVal = state[ReturnVal]
                                    r60 = upvalueValues[upvalues[3]]
                                    r51 = 9531360973142
                                    r4 = "0k\003\2103V"
                                    r33 = r60(r4, r51)
                                    r3 = r10[r33]
                                    r57 = r32[r3]
                                    ReturnVal = ReturnVal(state, r7, r57)
                                    state = upvalueValues[upvalues[1]]
                                    r57 = upvalueValues[upvalues[2]]
                                    r32 = upvalueValues[upvalues[3]]
                                    r60 = 16287433727392
                                    r10 = "\005\244\149\230Q\250XZ\225)"
                                    r3 = r32(r10, r60)
                                    r7 = r57[r3]
                                    r32 = upvalueValues[upvalues[4]]
                                    r10 = upvalueValues[upvalues[2]]
                                    ReturnVal = "InvokeServer"
                                    ReturnVal = state[ReturnVal]
                                    r60 = upvalueValues[upvalues[3]]
                                    r51 = 20555468350819
                                    r4 = "\253^\200kc\231"
                                    r33 = r60(r4, r51)
                                    r3 = r10[r33]
                                    r57 = r32[r3]
                                    ReturnVal = ReturnVal(state, r7, r57)
                                    state = upvalueValues[upvalues[1]]
                                    r57 = upvalueValues[upvalues[2]]
                                    r32 = upvalueValues[upvalues[3]]
                                    r10 = "\230d\016\2244\007\209~&"
                                    r60 = 31367226259726
                                    r3 = r32(r10, r60)
                                    r7 = r57[r3]
                                    r32 = upvalueValues[upvalues[4]]
                                    r10 = upvalueValues[upvalues[2]]
                                    r60 = upvalueValues[upvalues[3]]
                                    r4 = "\007\140C\024\222\237"
                                    r51 = 810823893369
                                    r33 = r60(r4, r51)
                                    r3 = r10[r33]
                                    r57 = r32[r3]
                                    ReturnVal = "InvokeServer"
                                    ReturnVal = state[ReturnVal]
                                    r32 = true
                                    ReturnVal = ReturnVal(state, r7, r57, r32)
                                    state = upvalueValues[upvalues[1]]
                                    r57 = upvalueValues[upvalues[2]]
                                    r32 = upvalueValues[upvalues[3]]
                                    r10 = "\1326\224\0017\007m\n\"\207\244c\216"
                                    r60 = 22101832230963
                                    r3 = r32(r10, r60)
                                    r7 = r57[r3]
                                    r32 = upvalueValues[upvalues[4]]
                                    r10 = upvalueValues[upvalues[2]]
                                    r60 = upvalueValues[upvalues[3]]
                                    r51 = 26659868946558
                                    r4 = "E\143\242/\186]}}\015"
                                    r33 = r60(r4, r51)
                                    r3 = r10[r33]
                                    ReturnVal = "InvokeServer"
                                    ReturnVal = state[ReturnVal]
                                    r57 = r32[r3]
                                    ReturnVal = ReturnVal(state, r7, r57)
                                    state = upvalueValues[upvalues[1]]
                                    r57 = upvalueValues[upvalues[2]]
                                    r32 = upvalueValues[upvalues[3]]
                                    r60 = 12002470041045
                                    r10 = "\207\186\218\185QY\145\219\131\227)\131~\214"
                                    r3 = r32(r10, r60)
                                    r7 = r57[r3]
                                    r32 = upvalueValues[upvalues[4]]
                                    r10 = upvalueValues[upvalues[2]]
                                    ReturnVal = "InvokeServer"
                                    ReturnVal = state[ReturnVal]
                                    r60 = upvalueValues[upvalues[3]]
                                    r51 = 19152254132950
                                    r4 = "\135\137m\002\207"
                                    r33 = r60(r4, r51)
                                    r3 = r10[r33]
                                    r57 = r32[r3]
                                    ReturnVal = ReturnVal(state, r7, r57)
                                    state = upvalueValues[upvalues[1]]
                                    r57 = upvalueValues[upvalues[2]]
                                    r32 = upvalueValues[upvalues[3]]
                                    r60 = 5908041616063
                                    r10 = "d\238\014R\025\221\231)\138\006\178"
                                    r3 = r32(r10, r60)
                                    r7 = r57[r3]
                                    r32 = upvalueValues[upvalues[4]]
                                    r10 = upvalueValues[upvalues[2]]
                                    ReturnVal = "InvokeServer"
                                    ReturnVal = state[ReturnVal]
                                    r60 = upvalueValues[upvalues[3]]
                                    r4 = "\029\230\025g\003\029\208\244\187"
                                    r51 = 14420283333178
                                    r33 = r60(r4, r51)
                                    r3 = r10[r33]
                                    r57 = r32[r3]
                                    ReturnVal = ReturnVal(state, r7, r57)
                                    state = upvalueValues[upvalues[1]]
                                    r57 = upvalueValues[upvalues[2]]
                                    r32 = upvalueValues[upvalues[3]]
                                    r60 = 32036924488262
                                    r10 = "g\235\147\250\140\160\206\237g\131+_"
                                    r3 = r32(r10, r60)
                                    r7 = r57[r3]
                                    r32 = upvalueValues[upvalues[4]]
                                    r10 = upvalueValues[upvalues[2]]
                                    r60 = upvalueValues[upvalues[3]]
                                    r4 = "\218\228R\151"
                                    r51 = 18720297558541
                                    r33 = r60(r4, r51)
                                    r3 = r10[r33]
                                    r57 = r32[r3]
                                    ReturnVal = "InvokeServer"
                                    ReturnVal = state[ReturnVal]
                                    ReturnVal = ReturnVal(state, r7, r57)
                                    state = upvalueValues[upvalues[1]]
                                    r57 = upvalueValues[upvalues[2]]
                                    r32 = upvalueValues[upvalues[3]]
                                    ReturnVal = "InvokeServer"
                                    ReturnVal = state[ReturnVal]
                                    r60 = 8399780630343
                                    r10 = "\252Mi\004\134\016\144."
                                    r3 = r32(r10, r60)
                                    r7 = r57[r3]
                                    r32 = upvalueValues[upvalues[4]]
                                    r10 = upvalueValues[upvalues[2]]
                                    r60 = upvalueValues[upvalues[3]]
                                    r51 = 33604752768288
                                    r4 = "m]\tL*\006\194\006"
                                    r33 = r60(r4, r51)
                                    r3 = r10[r33]
                                    r57 = r32[r3]
                                    ReturnVal = ReturnVal(state, r7, r57)
                                    ReturnVal = {}
                                    state = nil
                                end
                            else
                                -- createClosure2 entry 4172718 -> 133, states 133-141
                                if state <= 137 then
                                    if state <= 135 then
                                        if state <= 134 then
                                            if state <= 133 then
                                                if state == 133 then -- entry 4172718 -> 133
                                                    ReturnVal = "pairs"
                                                    state = _env[ReturnVal]
                                                    r32 = upvalueValues[upvalues[1]]
                                                    r3 = {
                                                        state(r32)
                                                    }
                                                    ReturnVal = r3[1]
                                                    r7 = r3[2]
                                                    r32 = ReturnVal
                                                    r57 = r3[3]
                                                    r3 = {
                                                        r32(r7, r57)
                                                    }
                                                    state = r3[1]
                                                    ReturnVal = r3[2]
                                                    r3 = state
                                                    r10 = ReturnVal
                                                    ReturnVal = nil
                                                    state = r3 ~= ReturnVal
                                                    state = state and (134) or (135)
                                                end
                                            else
                                                if state == 134 then
                                                    r60 = upvalueValues[upvalues[2]]
                                                    r33 = upvalueValues[upvalues[3]]
                                                    r51 = "\204\245&\132\184"
                                                    r18 = 11460262106328
                                                    r4 = r33(r51, r18)
                                                    ReturnVal = r60[r4]
                                                    state = r10[ReturnVal]
                                                    r60 = state
                                                    r4 = state
                                                    r23 = upvalueValues[upvalues[2]]
                                                    r22 = upvalueValues[upvalues[3]]
                                                    r19 = "\146*\130\1785"
                                                    r20 = 19364769850169
                                                    r54 = r22(r19, r20)
                                                    r50 = r23[r54]
                                                    r18 = r10[r50]
                                                    r23 = upvalueValues[upvalues[2]]
                                                    r22 = upvalueValues[upvalues[3]]
                                                    r19 = "\219w\212\195\165"
                                                    r20 = 18182262874386
                                                    r54 = r22(r19, r20)
                                                    r50 = r23[r54]
                                                    r51 = r18 == r50
                                                    state = r51 and (136) or (137)
                                                    r33 = r51
                                                end
                                            end
                                        else
                                            if state == 135 then
                                                r32 = nil
                                                r3 = nil
                                                r7 = nil
                                                r57 = nil
                                                r10 = nil
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    else
                                        if state <= 136 then
                                            if state == 136 then
                                                r18 = upvalueValues[upvalues[2]]
                                                r50 = upvalueValues[upvalues[3]]
                                                r22 = "a\132\245\169\008a"
                                                r54 = 11087689929771
                                                r23 = r50(r22, r54)
                                                r51 = r18[r23]
                                                r33 = r51
                                                state = 137
                                            end
                                        else
                                            if state == 137 then
                                                state = r4
                                                state = r33 and (138) or (139)
                                                ReturnVal = r33
                                            end
                                        end
                                    end
                                else
                                    if state <= 139 then
                                        if state <= 138 then
                                            if state == 138 then
                                                r33 = ReturnVal
                                                r4 = upvalueValues[upvalues[4]]
                                                ReturnVal = r4[r33]
                                                state = not ReturnVal
                                                state = state and (140) or (141)
                                            end
                                        else
                                            if state == 139 then
                                                ReturnVal = r60
                                                state = 138
                                            end
                                        end
                                    else
                                        if state <= 140 then
                                            if state == 140 then
                                                state = upvalueValues[upvalues[5]]
                                                r51 = upvalueValues[upvalues[2]]
                                                r18 = upvalueValues[upvalues[3]]
                                                r23 = "\160\148M\021\174\000\186\016\131\164"
                                                r22 = 25359516921376
                                                r50 = r18(r23, r22)
                                                r4 = r51[r50]
                                                r50 = "CFrame"
                                                r18 = _env[r50]
                                                r23 = upvalueValues[upvalues[2]]
                                                r22 = upvalueValues[upvalues[3]]
                                                r20 = 5901548243644
                                                r19 = "S4@"
                                                r54 = r22(r19, r20)
                                                r50 = r23[r54]
                                                r23 = -800
                                                r51 = r18[r50]
                                                r50 = 0
                                                r22 = 0
                                                r18 = r51(r50, r23, r22)
                                                r23 = "game"
                                                r50 = _env[r23]
                                                r22 = upvalueValues[upvalues[2]]
                                                r54 = upvalueValues[upvalues[3]]
                                                r20 = "\"\018\t\213\177*\188f\237"
                                                r45 = 9688888234399
                                                r19 = r54(r20, r45)
                                                ReturnVal = "InvokeServer"
                                                ReturnVal = state[ReturnVal]
                                                r23 = r22[r19]
                                                r51 = r50[r23]
                                                ReturnVal = ReturnVal(state, r4, r33, r18, r51)
                                                state = upvalueValues[upvalues[6]]
                                                r51 = upvalueValues[upvalues[4]]
                                                r4 = #r51
                                                r51 = 1
                                                ReturnVal = r4 + r51
                                                r4 = r33
                                                state[ReturnVal] = r4
                                                state = 141
                                            end
                                        else
                                            if state == 141 then
                                                r33 = nil
                                                r60 = nil
                                                state = 135
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
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if 0 == upvalueRefCounts[upvalueId] then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
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