return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, upvalueRefCounts, upvalueValues, releaseUpvalue, createClosure0, createClosure2, createUpvalueProxy, createClosure5, createClosure7, vm, createClosure6, releaseUpvalues, createClosure3, createClosure4, createClosure1, createClosure, allocUpvalue, currentUpvalueId)
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
        upvalueRefCounts = {}
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
        createClosure1 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1)
                return vm(entryId, {
                    arg1
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
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return 1353548
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 1353548
                    end
                })
            end
        end
        upvalueValues = {}
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, r9, ReturnVal, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56
            while state do
                if state <= 102 then
                    if state <= 80 then
                        if state <= 52 then
                            if state <= 35 then
                                if state <= 34 then
                                    if state <= 33 then
                                        -- root entry 4652074 -> 1, states 1-33
                                        if state <= 17 then
                                            if state <= 9 then
                                                if state <= 5 then
                                                    if state <= 3 then
                                                        if state <= 2 then
                                                            if state <= 1 then
                                                                if state == 1 then -- entry 4652074 -> 1
                                                                    r20 = allocUpvalue()
                                                                    state = true
                                                                    upvalueValues[r20] = state
                                                                    r3 = "string"
                                                                    ReturnVal = _env[r3]
                                                                    r3 = "gmatch"
                                                                    state = ReturnVal[r3]
                                                                    r47 = allocUpvalue()
                                                                    r3 = allocUpvalue()
                                                                    r55 = allocUpvalue()
                                                                    upvalueValues[r3] = state
                                                                    state = createClosure0(34, {})
                                                                    r15 = createClosure4(35, {
                                                                        r47
                                                                    })
                                                                    upvalueValues[r55] = state
                                                                    state = false
                                                                    upvalueValues[r47] = state
                                                                    r21 = "pcall"
                                                                    r22 = _env[r21]
                                                                    r21 = r22(r15)
                                                                    state = r21 and (2) or (3)
                                                                    r11 = args
                                                                    ReturnVal = r21
                                                                end
                                                            else
                                                                if state == 2 then
                                                                    r22 = upvalueValues[r47]
                                                                    ReturnVal = r22
                                                                    state = 3
                                                                end
                                                            end
                                                        else
                                                            if state == 3 then
                                                                r22 = ReturnVal
                                                                r21 = "math"
                                                                ReturnVal = _env[r21]
                                                                r21 = "random"
                                                                state = ReturnVal[r21]
                                                                r21 = allocUpvalue()
                                                                upvalueValues[r21] = state
                                                                r15 = "table"
                                                                ReturnVal = _env[r15]
                                                                r15 = "concat"
                                                                state = ReturnVal[r15]
                                                                r15 = state
                                                                r17 = state
                                                                r40 = "table"
                                                                r36 = _env[r40]
                                                                state = r36 and (4) or (5)
                                                                r43 = r36
                                                            end
                                                        end
                                                    else
                                                        if state <= 4 then
                                                            if state == 4 then
                                                                r41 = "table"
                                                                r40 = _env[r41]
                                                                r41 = "unpack"
                                                                r36 = r40[r41]
                                                                r43 = r36
                                                                state = 5
                                                            end
                                                        else
                                                            if state == 5 then
                                                                state = r17
                                                                state = r43 and (6) or (7)
                                                                ReturnVal = r43
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 7 then
                                                        if state <= 6 then
                                                            if state == 6 then
                                                                r43 = allocUpvalue()
                                                                upvalueValues[r43] = ReturnVal
                                                                state = upvalueValues[r21]
                                                                r36 = 65
                                                                r17 = 3
                                                                ReturnVal = state(r17, r36)
                                                                r17 = allocUpvalue()
                                                                upvalueValues[r17] = ReturnVal
                                                                r41 = "pcall"
                                                                ReturnVal = _env[r41]
                                                                r34 = createClosure2(36, {})
                                                                state = 0
                                                                r41 = {
                                                                    ReturnVal(r34)
                                                                }
                                                                r36 = state
                                                                state = 0
                                                                r40 = state
                                                                state = {
                                                                    unpack(r41)
                                                                }
                                                                r41 = state
                                                                ReturnVal = 2
                                                                state = r41[ReturnVal]
                                                                r34 = state
                                                                ReturnVal = "tonumber"
                                                                state = _env[ReturnVal]
                                                                r27 = upvalueValues[r3]
                                                                r51 = "tostring"
                                                                r50 = _env[r51]
                                                                r51 = r50(r34)
                                                                r50 = ":(%d*):"
                                                                r56 = r27(r51, r50)
                                                                r27 = {
                                                                    r56()
                                                                }
                                                                ReturnVal = state(unpack(r27))
                                                                r27 = allocUpvalue()
                                                                upvalueValues[r27] = ReturnVal
                                                                r56 = upvalueValues[r17]
                                                                r50 = r56
                                                                r56 = 1
                                                                r51 = r56
                                                                r56 = 0
                                                                r16 = r51 < r56
                                                                ReturnVal = 1
                                                                r56 = ReturnVal - r51
                                                                state = 8
                                                            end
                                                        else
                                                            if state == 7 then
                                                                r17 = "unpack"
                                                                r43 = _env[r17]
                                                                ReturnVal = r43
                                                                state = 6
                                                            end
                                                        end
                                                    else
                                                        if state <= 8 then
                                                            if state == 8 then
                                                                r35 = not r16
                                                                r56 = r56 + r51
                                                                ReturnVal = r56 <= r50
                                                                ReturnVal = r35 and ReturnVal
                                                                r35 = r56 >= r50
                                                                r35 = r16 and r35
                                                                ReturnVal = r35 or ReturnVal
                                                                r35 = (9)
                                                                state = ReturnVal and r35
                                                                ReturnVal = (10)
                                                                state = state or ReturnVal
                                                            end
                                                        else
                                                            if state == 9 then
                                                                r35 = allocUpvalue()
                                                                upvalueValues[r35] = r56
                                                                r10 = "math"
                                                                ReturnVal = _env[r10]
                                                                r10 = "random"
                                                                state = ReturnVal[r10]
                                                                r6 = 100
                                                                r10 = 1
                                                                ReturnVal = state(r10, r6)
                                                                r10 = allocUpvalue()
                                                                upvalueValues[r10] = ReturnVal
                                                                state = upvalueValues[r21]
                                                                r48 = 255
                                                                r6 = 0
                                                                ReturnVal = state(r6, r48)
                                                                r6 = allocUpvalue()
                                                                upvalueValues[r6] = ReturnVal
                                                                state = upvalueValues[r21]
                                                                r7 = upvalueValues[r10]
                                                                r48 = 1
                                                                ReturnVal = state(r48, r7)
                                                                r48 = allocUpvalue()
                                                                upvalueValues[r48] = ReturnVal
                                                                ReturnVal = upvalueValues[r21]
                                                                r37 = 1
                                                                r9 = 2
                                                                r7 = ReturnVal(r37, r9)
                                                                ReturnVal = 1
                                                                state = r7 == ReturnVal
                                                                r7 = allocUpvalue()
                                                                upvalueValues[r7] = state
                                                                r5 = "tostring"
                                                                r14 = _env[r5]
                                                                r31 = upvalueValues[r21]
                                                                r45 = 10000
                                                                r28 = 0
                                                                r54 = {
                                                                    r31(r28, r45)
                                                                }
                                                                r5 = r14(unpack(r54))
                                                                r14 = ":"
                                                                r44 = r5 .. r14
                                                                r9 = ":"
                                                                r37 = r9 .. r44
                                                                state = "gsub"
                                                                state = r34[state]
                                                                ReturnVal = ":(%d*):"
                                                                state = state(r34, ReturnVal, r37)
                                                                r37 = allocUpvalue()
                                                                r44 = createClosure2(37, {
                                                                    r21,
                                                                    r35,
                                                                    r17,
                                                                    r3,
                                                                    r20,
                                                                    r27,
                                                                    r7,
                                                                    r37,
                                                                    r10,
                                                                    r48,
                                                                    r6,
                                                                    r43
                                                                })
                                                                upvalueValues[r37] = state
                                                                r9 = "pcall"
                                                                ReturnVal = _env[r9]
                                                                r9 = {
                                                                    ReturnVal(r44)
                                                                }
                                                                state = {
                                                                    unpack(r9)
                                                                }
                                                                r9 = state
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
                                                                r50 = upvalueValues[r20]
                                                                state = r50 and (13) or (14)
                                                                r56 = r50
                                                            end
                                                        else
                                                            if state == 11 then
                                                                r44 = upvalueValues[r20]
                                                                state = r44 and (15) or (16)
                                                                ReturnVal = r44
                                                            end
                                                        end
                                                    else
                                                        if state <= 12 then
                                                            if state == 12 then
                                                                r14 = upvalueValues[r20]
                                                                state = r14 and (17) or (18)
                                                                r44 = r14
                                                            end
                                                        else
                                                            if state == 13 then
                                                                r50 = r36 == r40
                                                                r56 = r50
                                                                state = 14
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 15 then
                                                        if state <= 14 then
                                                            if state == 14 then
                                                                upvalueValues[r20] = r56
                                                                state = upvalueValues[r20]
                                                                state = state and (19) or (20)
                                                            end
                                                        else
                                                            if state == 15 then
                                                                r54 = 1
                                                                r31 = r9[r54]
                                                                r54 = false
                                                                r5 = r31 == r54
                                                                r14 = state
                                                                state = r5 and (21) or (22)
                                                                r44 = r5
                                                            end
                                                        end
                                                    else
                                                        if state <= 16 then
                                                            if state == 16 then
                                                                upvalueValues[r20] = ReturnVal
                                                                state = 23
                                                            end
                                                        else
                                                            if state == 17 then
                                                                r5 = 1
                                                                r14 = r9[r5]
                                                                r44 = r14
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
                                                                upvalueValues[r20] = r44
                                                                r54 = upvalueValues[r48]
                                                                r28 = 1
                                                                r31 = r54 + r28
                                                                r5 = r9[r31]
                                                                r14 = r36 + r5
                                                                r5 = 256
                                                                state = r14 % r5
                                                                r36 = state
                                                                r31 = upvalueValues[r6]
                                                                r5 = r40 + r31
                                                                r31 = 256
                                                                r14 = r5 % r31
                                                                r40 = r14
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
                                                                r54 = 2
                                                                r31 = r9[r54]
                                                                r54 = upvalueValues[r37]
                                                                r5 = r31 == r54
                                                                r44 = r5
                                                                state = 22
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 23 then
                                                        if state <= 22 then
                                                            if state == 22 then
                                                                state = r14
                                                                ReturnVal = r44
                                                                state = 16
                                                            end
                                                        else
                                                            if state == 23 then
                                                                r7 = releaseUpvalue(r7)
                                                                r35 = releaseUpvalue(r35)
                                                                r10 = releaseUpvalue(r10)
                                                                r9 = nil
                                                                r37 = releaseUpvalue(r37)
                                                                r6 = releaseUpvalue(r6)
                                                                r48 = releaseUpvalue(r48)
                                                                state = 8
                                                            end
                                                        end
                                                    else
                                                        if state <= 24 then
                                                            if state == 24 then
                                                                r27 = releaseUpvalue(r27)
                                                                r17 = releaseUpvalue(r17)
                                                                r43 = releaseUpvalue(r43)
                                                                r20 = releaseUpvalue(r20)
                                                                r47 = releaseUpvalue(r47)
                                                                r21 = releaseUpvalue(r21)
                                                                r55 = releaseUpvalue(r55)
                                                                r3 = releaseUpvalue(r3)
                                                                r17 = allocUpvalue()
                                                                r55 = allocUpvalue()
                                                                r20 = nil
                                                                upvalueValues[r55] = r20
                                                                r20 = allocUpvalue()
                                                                r3 = nil
                                                                upvalueValues[r20] = r3
                                                                r22 = nil
                                                                r22 = "math"
                                                                r47 = _env[r22]
                                                                r22 = "floor"
                                                                r3 = r47[r22]
                                                                r47 = allocUpvalue()
                                                                upvalueValues[r47] = r3
                                                                r41 = nil
                                                                r41 = {}
                                                                r21 = "math"
                                                                r22 = _env[r21]
                                                                r36 = nil
                                                                r36 = {}
                                                                r21 = "random"
                                                                r3 = r22[r21]
                                                                r15 = nil
                                                                r15 = "table"
                                                                r21 = _env[r15]
                                                                r15 = "remove"
                                                                r22 = r21[r15]
                                                                r43 = "string"
                                                                r15 = _env[r43]
                                                                r40 = nil
                                                                r40 = allocUpvalue()
                                                                r43 = "char"
                                                                r21 = r15[r43]
                                                                r27 = 256
                                                                r43 = allocUpvalue()
                                                                r15 = 0
                                                                upvalueValues[r43] = r15
                                                                r15 = 2
                                                                upvalueValues[r17] = r15
                                                                r16 = r27
                                                                r15 = {}
                                                                r27 = 1
                                                                upvalueValues[r40] = r36
                                                                r35 = r27
                                                                r27 = 0
                                                                r10 = r35 < r27
                                                                r34 = nil
                                                                r34 = 1
                                                                r27 = r34 - r35
                                                                r36 = 0
                                                                state = 26
                                                            end
                                                        else
                                                            if state == 25 then
                                                                state = createClosure4(49, {
                                                                    r55
                                                                })
                                                                r50 = {
                                                                    state()
                                                                }
                                                                ReturnVal = {
                                                                    unpack(r50)
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
                                                                r27 = r27 + r35
                                                                r6 = not r10
                                                                r34 = r27 <= r16
                                                                r34 = r6 and r34
                                                                r6 = r27 >= r16
                                                                r6 = r10 and r6
                                                                r34 = r6 or r34
                                                                r6 = (27)
                                                                state = r34 and r6
                                                                r34 = (28)
                                                                state = state or r34
                                                            end
                                                        else
                                                            if state == 27 then
                                                                r34 = r27
                                                                r6 = r34
                                                                r41[r34] = r6
                                                                r34 = nil
                                                                state = 26
                                                            end
                                                        end
                                                    else
                                                        if state <= 28 then
                                                            if state == 28 then
                                                                r27 = #r41
                                                                r16 = 0
                                                                r34 = r27 == r16
                                                                state = 29
                                                            end
                                                        else
                                                            if state == 29 then
                                                                r27 = 1
                                                                r16 = #r41
                                                                r34 = r3(r27, r16)
                                                                r27 = r22(r41, r34)
                                                                r16 = upvalueValues[r40]
                                                                r6 = 1
                                                                r10 = r27 - r6
                                                                r35 = r21(r10)
                                                                r34 = nil
                                                                r16[r27] = r35
                                                                r27 = nil
                                                                state = 30
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 31 then
                                                        if state <= 30 then
                                                            if state == 30 then
                                                                r27 = #r41
                                                                r16 = 0
                                                                r34 = r27 == r16
                                                                state = r34 and (31) or (29)
                                                            end
                                                        else
                                                            if state == 31 then
                                                                r6 = {}
                                                                r34 = {}
                                                                r27 = allocUpvalue()
                                                                upvalueValues[r27] = r34
                                                                r16 = createClosure1(53, {
                                                                    r27,
                                                                    r43,
                                                                    r17,
                                                                    r47
                                                                })
                                                                r34 = allocUpvalue()
                                                                upvalueValues[r34] = r16
                                                                r16 = {}
                                                                r35 = allocUpvalue()
                                                                upvalueValues[r35] = r16
                                                                r10 = "setmetatable"
                                                                r16 = _env[r10]
                                                                r37 = upvalueValues[r35]
                                                                r9 = "__metatable"
                                                                r7 = "__index"
                                                                r5 = nil
                                                                r48 = {
                                                                    [r7] = r37,
                                                                    [r9] = r5
                                                                }
                                                                r10 = r16(r6, r48)
                                                                upvalueValues[r20] = r10
                                                                r16 = createClosure3(59, {
                                                                    r35,
                                                                    r27,
                                                                    r40,
                                                                    r43,
                                                                    r17,
                                                                    r34
                                                                })
                                                                upvalueValues[r55] = r16
                                                                r47 = releaseUpvalue(r47)
                                                                r27 = releaseUpvalue(r27)
                                                                r34 = releaseUpvalue(r34)
                                                                r40 = releaseUpvalue(r40)
                                                                r17 = releaseUpvalue(r17)
                                                                r43 = releaseUpvalue(r43)
                                                                r47 = "game"
                                                                r3 = nil
                                                                r3 = _env[r47]
                                                                r21 = nil
                                                                r21 = upvalueValues[r20]
                                                                r15 = nil
                                                                r15 = upvalueValues[r55]
                                                                r17 = "\017\192YIIq]\151\197o\132\138\168)A\148\247\169\017"
                                                                r36 = nil
                                                                r36 = 25964964687674
                                                                r43 = r15(r17, r36)
                                                                r35 = releaseUpvalue(r35)
                                                                r22 = nil
                                                                r22 = r21[r43]
                                                                r47 = "GetService"
                                                                r47 = r3[r47]
                                                                r47 = r47(r3, r22)
                                                                r3 = "GetClientId"
                                                                r3 = r47[r3]
                                                                r3 = r3(r47)
                                                                r21 = upvalueValues[r20]
                                                                r15 = upvalueValues[r55]
                                                                r36 = 9145117069474
                                                                r17 = "\245\164p\192\145<TF\244ru\016s\186\252\133-\222\158\169\152\174\240i\192d\204Rn\2091\2490\177\128\204"
                                                                r43 = r15(r17, r36)
                                                                r22 = r21[r43]
                                                                r15 = upvalueValues[r20]
                                                                r43 = upvalueValues[r55]
                                                                r40 = 18884627063385
                                                                r36 = "\234?\127\155\021\168\131\130\203T8I\190$\238f\228x\229\194\012\207\221\129g\151\141G\211\0229\219.m[\164"
                                                                r17 = r43(r36, r40)
                                                                r21 = r15[r17]
                                                                r43 = upvalueValues[r20]
                                                                r17 = upvalueValues[r55]
                                                                r41 = nil
                                                                r41 = 32926493637604
                                                                r40 = "\163\1917C9n_\179\232e\133\008  c\186\204\233\168y2\212\188\197\231H0\160P\219\251~\183q\220\157"
                                                                r36 = r17(r40, r41)
                                                                r15 = r43[r36]
                                                                r47 = {
                                                                    r22,
                                                                    r21,
                                                                    r15
                                                                }
                                                                r22 = allocUpvalue()
                                                                upvalueValues[r22] = r47
                                                                r47 = createClosure4(66, {
                                                                    r22
                                                                })
                                                                r21 = "CheckHWID"
                                                                _env[r21] = r47
                                                                r21 = "loadstring"
                                                                r47 = _env[r21]
                                                                r43 = "game"
                                                                r15 = _env[r43]
                                                                r36 = upvalueValues[r20]
                                                                r40 = upvalueValues[r55]
                                                                r34 = "\218\151g\198E;\130&\207\025k\1322\195\146\145\199\183\157\132\194\197\209Z\180\208ED\199\137\139\208\142\211\220-j\219\180Z--\253&z{\137O^\n\188\2403\164N\185N\161\172mya\202(\153\204'\021B\128\162\002\156\170Y\160?\004\161\207 \007\228q\014\0203\200\188\245\249\226\247{\145\186\011\011\248XV\234]o"
                                                                r27 = 31404792903967
                                                                r41 = r40(r34, r27)
                                                                r17 = r36[r41]
                                                                r36 = "HttpGet"
                                                                r36 = r15[r36]
                                                                r43 = {
                                                                    r36(r15, r17)
                                                                }
                                                                r21 = r47(unpack(r43))
                                                                r47 = r21()
                                                                r43 = upvalueValues[r20]
                                                                r17 = upvalueValues[r55]
                                                                r40 = "\238gb#\236Z\133\r\198\238\146\192\176\127\254\002\2416\144a\196\194\242U\015\1285\1505\007|I\030\247\002\174\250\006\022\tw\204~R\207\216\149\"\160Du\139\144\004"
                                                                r41 = 2980069229931
                                                                r36 = r17(r40, r41)
                                                                r15 = r43[r36]
                                                                r36 = "Vector2"
                                                                r17 = _env[r36]
                                                                r40 = upvalueValues[r20]
                                                                r41 = upvalueValues[r55]
                                                                r16 = 19172516422367
                                                                r27 = "\144\219-"
                                                                r34 = r41(r27, r16)
                                                                r36 = r40[r34]
                                                                r43 = r17[r36]
                                                                r40 = 310
                                                                r36 = 310
                                                                r17 = r43(r36, r40)
                                                                r41 = "Enum"
                                                                r40 = _env[r41]
                                                                r34 = upvalueValues[r20]
                                                                r27 = upvalueValues[r55]
                                                                r6 = 12101929784835
                                                                r35 = "!+\214\247\211ns"
                                                                r16 = r27(r35, r6)
                                                                r41 = r34[r16]
                                                                r36 = r40[r41]
                                                                r41 = upvalueValues[r20]
                                                                r34 = upvalueValues[r55]
                                                                r35 = 14300622625283
                                                                r16 = ","
                                                                r27 = r34(r16, r35)
                                                                r40 = r41[r27]
                                                                r43 = r36[r40]
                                                                r21 = "CreateWindow"
                                                                r21 = r47[r21]
                                                                r21 = r21(r47, r15, r17, r43)
                                                                r9 = allocUpvalue()
                                                                r43 = upvalueValues[r20]
                                                                r17 = upvalueValues[r55]
                                                                r41 = 12795616319302
                                                                r40 = "\233\182\215c\231"
                                                                r36 = r17(r40, r41)
                                                                r15 = r43[r36]
                                                                r47 = "CreateTab"
                                                                r47 = r21[r47]
                                                                r47 = r47(r21, r15)
                                                                r17 = upvalueValues[r20]
                                                                r36 = upvalueValues[r55]
                                                                r34 = 19899087168562
                                                                r41 = "<\202\134\202\139\004v\148Z\181}\244\251+\216>\140\148S\227\024\164c\005"
                                                                r40 = r36(r41, r34)
                                                                r43 = r17[r40]
                                                                r36 = upvalueValues[r20]
                                                                r40 = upvalueValues[r55]
                                                                r15 = "CreateSector"
                                                                r15 = r47[r15]
                                                                r27 = 31466450106684
                                                                r34 = "\131`\211\212"
                                                                r41 = r40(r34, r27)
                                                                r17 = r36[r41]
                                                                r15 = r15(r47, r43, r17)
                                                                r17 = "game"
                                                                r43 = _env[r17]
                                                                r40 = upvalueValues[r20]
                                                                r41 = upvalueValues[r55]
                                                                r16 = 23407578606228
                                                                r27 = "\007\024\225*\254\222\175"
                                                                r34 = r41(r27, r16)
                                                                r36 = r40[r34]
                                                                r17 = "GetService"
                                                                r17 = r43[r17]
                                                                r17 = r17(r43, r36)
                                                                r36 = "game"
                                                                r43 = _env[r36]
                                                                r41 = upvalueValues[r20]
                                                                r34 = upvalueValues[r55]
                                                                r35 = 32224625015453
                                                                r16 = "\\?\1367\232\247\133K\138\192"
                                                                r27 = r34(r16, r35)
                                                                r36 = "GetService"
                                                                r36 = r43[r36]
                                                                r40 = r41[r27]
                                                                r36 = r36(r43, r40)
                                                                r43 = allocUpvalue()
                                                                upvalueValues[r43] = r36
                                                                r41 = upvalueValues[r20]
                                                                r34 = upvalueValues[r55]
                                                                r35 = 12184664430121
                                                                r16 = "s\249\003,\020\161\136LYl\183"
                                                                r27 = r34(r16, r35)
                                                                r40 = r41[r27]
                                                                r36 = r17[r40]
                                                                r40 = allocUpvalue()
                                                                upvalueValues[r40] = r36
                                                                r27 = "game"
                                                                r34 = _env[r27]
                                                                r16 = upvalueValues[r20]
                                                                r35 = upvalueValues[r55]
                                                                r7 = 15886644501733
                                                                r48 = "\1735n<][C"
                                                                r6 = r35(r48, r7)
                                                                r27 = r16[r6]
                                                                r41 = r34[r27]
                                                                r27 = upvalueValues[r20]
                                                                r16 = upvalueValues[r55]
                                                                r48 = 34241538735688
                                                                r6 = "\015\2449V\242~\128\238\184\194J"
                                                                r35 = r16(r6, r48)
                                                                r16 = allocUpvalue()
                                                                r34 = r27[r35]
                                                                r37 = allocUpvalue()
                                                                r36 = r41[r34]
                                                                r48 = allocUpvalue()
                                                                r27 = allocUpvalue()
                                                                r41 = "GetMouse"
                                                                r41 = r36[r41]
                                                                r41 = r41(r36)
                                                                r36 = allocUpvalue()
                                                                upvalueValues[r36] = r41
                                                                r34 = allocUpvalue()
                                                                r41 = false
                                                                upvalueValues[r34] = r41
                                                                r41 = 0.16574
                                                                upvalueValues[r27] = r41
                                                                r6 = allocUpvalue()
                                                                r41 = 0.12
                                                                upvalueValues[r16] = r41
                                                                r35 = allocUpvalue()
                                                                r41 = 0.17
                                                                upvalueValues[r35] = r41
                                                                r7 = allocUpvalue()
                                                                r41 = 0.001
                                                                upvalueValues[r6] = r41
                                                                r41 = 0.185
                                                                upvalueValues[r48] = r41
                                                                r41 = 0.1
                                                                upvalueValues[r7] = r41
                                                                r41 = 0.01
                                                                upvalueValues[r37] = r41
                                                                r41 = 0.01
                                                                upvalueValues[r9] = r41
                                                                r5 = "getgenv"
                                                                r41 = _env[r5]
                                                                r5 = r41()
                                                                r31 = upvalueValues[r20]
                                                                r54 = upvalueValues[r55]
                                                                r45 = "*\217\215"
                                                                r42 = 7429259267459
                                                                r28 = r54(r45, r42)
                                                                r41 = r31[r28]
                                                                r54 = upvalueValues[r20]
                                                                r28 = upvalueValues[r55]
                                                                r18 = 12736076568362
                                                                r42 = "\252"
                                                                r45 = r28(r42, r18)
                                                                r31 = r54[r45]
                                                                r5[r41] = r31
                                                                r31 = upvalueValues[r20]
                                                                r54 = upvalueValues[r55]
                                                                r42 = 29559764809156
                                                                r45 = "r\025\240\006\224\030\248\025"
                                                                r28 = r54(r45, r42)
                                                                r5 = r31[r28]
                                                                r31 = createClosure1(74, {
                                                                    r20,
                                                                    r55,
                                                                    r40,
                                                                    r43,
                                                                    r34,
                                                                    r27,
                                                                    r48,
                                                                    r37,
                                                                    r6,
                                                                    r36
                                                                })
                                                                r41 = "AddButton"
                                                                r41 = r15[r41]
                                                                r41 = r41(r15, r5, r31)
                                                                r31 = upvalueValues[r20]
                                                                r54 = upvalueValues[r55]
                                                                r45 = "tDO2\234\2109\028r\165"
                                                                r42 = 24098967202773
                                                                r28 = r54(r45, r42)
                                                                r5 = r31[r28]
                                                                r54 = "tostring"
                                                                r31 = _env[r54]
                                                                r28 = upvalueValues[r27]
                                                                r54 = r31(r28)
                                                                r41 = "AddTextbox"
                                                                r41 = r15[r41]
                                                                r31 = createClosure5(75, {
                                                                    r27
                                                                })
                                                                r41 = r41(r15, r5, r54, r31)
                                                                r31 = upvalueValues[r20]
                                                                r54 = upvalueValues[r55]
                                                                r45 = "E\161a\168\1764\nv\0157K\233\218\022\177\"A\204\0124\225"
                                                                r42 = 4426483894285
                                                                r28 = r54(r45, r42)
                                                                r41 = "AddTextbox"
                                                                r41 = r15[r41]
                                                                r5 = r31[r28]
                                                                r54 = "tostring"
                                                                r31 = _env[r54]
                                                                r28 = upvalueValues[r16]
                                                                r54 = r31(r28)
                                                                r31 = createClosure4(78, {
                                                                    r16
                                                                })
                                                                r41 = r41(r15, r5, r54, r31)
                                                                r31 = upvalueValues[r20]
                                                                r54 = upvalueValues[r55]
                                                                r42 = 12217452074553
                                                                r45 = "\173u\131\203d\185\001K\237F\028Jdq*\004G\243\140"
                                                                r28 = r54(r45, r42)
                                                                r5 = r31[r28]
                                                                r54 = "tostring"
                                                                r31 = _env[r54]
                                                                r28 = upvalueValues[r35]
                                                                r41 = "AddTextbox"
                                                                r41 = r15[r41]
                                                                r54 = r31(r28)
                                                                r31 = createClosure6(81, {
                                                                    r35
                                                                })
                                                                r41 = r41(r15, r5, r54, r31)
                                                                r31 = upvalueValues[r20]
                                                                r54 = upvalueValues[r55]
                                                                r45 = "\214v\227\190#\184\143ON\161\172Ca\162"
                                                                r42 = 1967175844756
                                                                r28 = r54(r45, r42)
                                                                r5 = r31[r28]
                                                                r54 = "tostring"
                                                                r31 = _env[r54]
                                                                r28 = upvalueValues[r48]
                                                                r41 = "AddTextbox"
                                                                r41 = r15[r41]
                                                                r54 = r31(r28)
                                                                r31 = createClosure6(84, {
                                                                    r48
                                                                })
                                                                r41 = r41(r15, r5, r54, r31)
                                                                r31 = upvalueValues[r20]
                                                                r54 = upvalueValues[r55]
                                                                r45 = "\231\248G\211\005M\182\136\132es#\134\203\135\142\025r\169"
                                                                r42 = 19679752430540
                                                                r28 = r54(r45, r42)
                                                                r41 = "AddTextbox"
                                                                r41 = r15[r41]
                                                                r5 = r31[r28]
                                                                r54 = "tostring"
                                                                r31 = _env[r54]
                                                                r28 = upvalueValues[r7]
                                                                r54 = r31(r28)
                                                                r31 = createClosure6(87, {
                                                                    r7
                                                                })
                                                                r41 = r41(r15, r5, r54, r31)
                                                                r31 = upvalueValues[r20]
                                                                r54 = upvalueValues[r55]
                                                                r42 = 20106180043922
                                                                r45 = "\220\161\253\147\023\215\017\246\135\016\022\156S\176\165\162)=\240\012T"
                                                                r28 = r54(r45, r42)
                                                                r5 = r31[r28]
                                                                r54 = "tostring"
                                                                r31 = _env[r54]
                                                                r41 = "AddTextbox"
                                                                r41 = r15[r41]
                                                                r28 = upvalueValues[r37]
                                                                r54 = r31(r28)
                                                                r31 = createClosure2(90, {
                                                                    r37
                                                                })
                                                                r41 = r41(r15, r5, r54, r31)
                                                                r31 = upvalueValues[r20]
                                                                r54 = upvalueValues[r55]
                                                                r42 = 15359217556464
                                                                r45 = "\008\156\015:\165Fr\229\024\022\141a\rc\189cK?M"
                                                                r28 = r54(r45, r42)
                                                                r5 = r31[r28]
                                                                r54 = "tostring"
                                                                r31 = _env[r54]
                                                                r28 = upvalueValues[r9]
                                                                r54 = r31(r28)
                                                                r31 = createClosure6(93, {
                                                                    r9
                                                                })
                                                                r41 = "AddTextbox"
                                                                r41 = r15[r41]
                                                                r41 = r41(r15, r5, r54, r31)
                                                                r31 = upvalueValues[r20]
                                                                r54 = upvalueValues[r55]
                                                                r42 = 31074441869446
                                                                r45 = "\213\003\146P\190h+\018\027\004z\209i\215\164"
                                                                r28 = r54(r45, r42)
                                                                r5 = r31[r28]
                                                                r28 = upvalueValues[r20]
                                                                r45 = upvalueValues[r55]
                                                                r52 = 25194773753300
                                                                r18 = ".\237\005\031\245@"
                                                                r42 = r45(r18, r52)
                                                                r54 = r28[r42]
                                                                r45 = upvalueValues[r20]
                                                                r42 = upvalueValues[r55]
                                                                r2 = 735541625174
                                                                r52 = "-\242\027"
                                                                r18 = r42(r52, r2)
                                                                r28 = r45[r18]
                                                                r31 = {
                                                                    r54,
                                                                    r28
                                                                }
                                                                r28 = upvalueValues[r20]
                                                                r45 = upvalueValues[r55]
                                                                r18 = "\216\220-"
                                                                r52 = 31937325349399
                                                                r42 = r45(r18, r52)
                                                                r41 = "AddDropdown"
                                                                r41 = r15[r41]
                                                                r54 = r28[r42]
                                                                r45 = createClosure6(96, {
                                                                    r20,
                                                                    r55
                                                                })
                                                                r28 = false
                                                                r41 = r41(r15, r5, r31, r54, r28, r45)
                                                                r31 = upvalueValues[r20]
                                                                r54 = upvalueValues[r55]
                                                                r42 = 7538972904886
                                                                r45 = "\163\225\210\152\r9L"
                                                                r28 = r54(r45, r42)
                                                                r5 = r31[r28]
                                                                r28 = upvalueValues[r20]
                                                                r45 = upvalueValues[r55]
                                                                r52 = 28331252528008
                                                                r18 = "O\255+\007"
                                                                r42 = r45(r18, r52)
                                                                r54 = r28[r42]
                                                                r45 = upvalueValues[r20]
                                                                r41 = "AddDropdown"
                                                                r41 = r15[r41]
                                                                r42 = upvalueValues[r55]
                                                                r2 = 23294651591263
                                                                r52 = "\024\241ov>H\213$\1438\221\195`\178&I"
                                                                r18 = r42(r52, r2)
                                                                r28 = r45[r18]
                                                                r42 = upvalueValues[r20]
                                                                r18 = upvalueValues[r55]
                                                                r24 = 31885223737855
                                                                r2 = "\233\238\151C\208\227D\254\185."
                                                                r52 = r18(r2, r24)
                                                                r45 = r42[r52]
                                                                r18 = upvalueValues[r20]
                                                                r52 = upvalueValues[r55]
                                                                r23 = 32862800100294
                                                                r24 = "D3\182\031\022M\168\177\208p"
                                                                r2 = r52(r24, r23)
                                                                r42 = r18[r2]
                                                                r52 = upvalueValues[r20]
                                                                r2 = upvalueValues[r55]
                                                                r19 = 16705388322403
                                                                r23 = "\222\007\161\018\185"
                                                                r24 = r2(r23, r19)
                                                                r18 = r52[r24]
                                                                r31 = {
                                                                    r54,
                                                                    r28,
                                                                    r45,
                                                                    r42,
                                                                    r18
                                                                }
                                                                r28 = upvalueValues[r20]
                                                                r45 = upvalueValues[r55]
                                                                r52 = 282521895043
                                                                r18 = "\231A;sl^\140\205q\011C\194\237eN\236"
                                                                r42 = r45(r18, r52)
                                                                r54 = r28[r42]
                                                                r45 = createClosure4(97, {
                                                                    r20,
                                                                    r55
                                                                })
                                                                r28 = false
                                                                r41 = r41(r15, r5, r31, r54, r28, r45)
                                                                r31 = upvalueValues[r20]
                                                                r54 = upvalueValues[r55]
                                                                r42 = 8658133110719
                                                                r45 = "\23911\157w\204\129\136\194^"
                                                                r28 = r54(r45, r42)
                                                                r5 = r31[r28]
                                                                r41 = "AddToggle"
                                                                r41 = r15[r41]
                                                                r54 = createClosure1(98, {
                                                                    r20,
                                                                    r55
                                                                })
                                                                r31 = false
                                                                r41 = r41(r15, r5, r31, r54)
                                                                r31 = upvalueValues[r20]
                                                                r54 = upvalueValues[r55]
                                                                r42 = 4738892236958
                                                                r45 = "\172\247b"
                                                                r28 = r54(r45, r42)
                                                                r5 = r31[r28]
                                                                r41 = "AddToggle"
                                                                r41 = r15[r41]
                                                                r54 = createClosure4(99, {
                                                                    r20,
                                                                    r55
                                                                })
                                                                r31 = false
                                                                r41 = r41(r15, r5, r31, r54)
                                                                r31 = upvalueValues[r20]
                                                                r54 = upvalueValues[r55]
                                                                r42 = 571684716810
                                                                r45 = "\221l+$\018}\151\222\253\0086\141"
                                                                r28 = r54(r45, r42)
                                                                r41 = "AddToggle"
                                                                r41 = r15[r41]
                                                                r5 = r31[r28]
                                                                r54 = createClosure6(100, {
                                                                    r20,
                                                                    r55
                                                                })
                                                                r31 = false
                                                                r41 = r41(r15, r5, r31, r54)
                                                                r31 = upvalueValues[r20]
                                                                r54 = upvalueValues[r55]
                                                                r45 = "1\247\227\217\196\168\249\187\255\207\218\147"
                                                                r42 = 12646526031616
                                                                r28 = r54(r45, r42)
                                                                r5 = r31[r28]
                                                                r41 = "AddToggle"
                                                                r41 = r15[r41]
                                                                r54 = createClosure3(101, {
                                                                    r20,
                                                                    r55
                                                                })
                                                                r31 = true
                                                                r41 = r41(r15, r5, r31, r54)
                                                                r31 = upvalueValues[r20]
                                                                r54 = upvalueValues[r55]
                                                                r45 = "\153\202\157\156\245\222K\130\133\249\227"
                                                                r42 = 7726075055629
                                                                r28 = r54(r45, r42)
                                                                r5 = r31[r28]
                                                                r31 = createClosure3(102, {
                                                                    r20,
                                                                    r55
                                                                })
                                                                r41 = "AddButton"
                                                                r41 = r15[r41]
                                                                r41 = r41(r15, r5, r31)
                                                                r31 = upvalueValues[r20]
                                                                r54 = upvalueValues[r55]
                                                                r45 = "\227\217\136\015V.\232\135\224\131Y\003\134\221)%"
                                                                r42 = 28216348242771
                                                                r28 = r54(r45, r42)
                                                                r5 = r31[r28]
                                                                r41 = "AddTextbox"
                                                                r41 = r15[r41]
                                                                r54 = upvalueValues[r20]
                                                                r28 = upvalueValues[r55]
                                                                r18 = 32920848825313
                                                                r42 = "\197V\016\216+i\198"
                                                                r45 = r28(r42, r18)
                                                                r31 = r54[r45]
                                                                r54 = createClosure5(103, {
                                                                    r20,
                                                                    r55
                                                                })
                                                                r41 = r41(r15, r5, r31, r54)
                                                                r31 = upvalueValues[r20]
                                                                r54 = upvalueValues[r55]
                                                                r42 = 24969301486955
                                                                r45 = "X\242\170k\031\216\011~"
                                                                r28 = r54(r45, r42)
                                                                r5 = r31[r28]
                                                                r41 = "CreateTab"
                                                                r41 = r21[r41]
                                                                r41 = r41(r21, r5)
                                                                r5 = "CreateSector"
                                                                r5 = r41[r5]
                                                                r54 = upvalueValues[r20]
                                                                r28 = upvalueValues[r55]
                                                                r18 = 34502728072898
                                                                r42 = "t\227\129\196\019X\"\201<~\169\207\240y\153\172"
                                                                r45 = r28(r42, r18)
                                                                r31 = r54[r45]
                                                                r28 = upvalueValues[r20]
                                                                r45 = upvalueValues[r55]
                                                                r52 = 15087187762033
                                                                r18 = "\026y\129\147"
                                                                r42 = r45(r18, r52)
                                                                r54 = r28[r42]
                                                                r5 = r5(r41, r31, r54)
                                                                r28 = upvalueValues[r20]
                                                                r45 = upvalueValues[r55]
                                                                r18 = "\016\019\177\217\218]\198D{\178\143\022\n\130\154\199"
                                                                r52 = 18116181909748
                                                                r42 = r45(r18, r52)
                                                                r54 = r28[r42]
                                                                r28 = createClosure4(104, {
                                                                    r20,
                                                                    r55
                                                                })
                                                                r31 = "AddButton"
                                                                r31 = r5[r31]
                                                                r31 = r31(r5, r54, r28)
                                                                r28 = upvalueValues[r20]
                                                                r31 = "AddButton"
                                                                r31 = r5[r31]
                                                                r45 = upvalueValues[r55]
                                                                r52 = 12070561306100
                                                                r18 = "I\137}\236\192\1685\230\180\159"
                                                                r42 = r45(r18, r52)
                                                                r54 = r28[r42]
                                                                r28 = createClosure2(107, {
                                                                    r20,
                                                                    r55
                                                                })
                                                                r31 = r31(r5, r54, r28)
                                                                r28 = upvalueValues[r20]
                                                                r45 = upvalueValues[r55]
                                                                r52 = 12792156919620
                                                                r18 = "[\029\173\194/\245]\015t>,\168\127\229\249\233t\205\226"
                                                                r42 = r45(r18, r52)
                                                                r54 = r28[r42]
                                                                r45 = upvalueValues[r20]
                                                                r31 = "CreateSector"
                                                                r31 = r41[r31]
                                                                r42 = upvalueValues[r55]
                                                                r2 = 33704290876750
                                                                r52 = "c\t\17710"
                                                                r18 = r42(r52, r2)
                                                                r28 = r45[r18]
                                                                r31 = r31(r41, r54, r28)
                                                                r54 = allocUpvalue()
                                                                r28 = allocUpvalue()
                                                                r45 = createClosure6(108, {
                                                                    r28,
                                                                    r20,
                                                                    r55,
                                                                    r54
                                                                })
                                                                upvalueValues[r54] = r31
                                                                r31 = {}
                                                                upvalueValues[r28] = r31
                                                                r31 = allocUpvalue()
                                                                upvalueValues[r31] = r45
                                                                r45 = upvalueValues[r54]
                                                                r18 = upvalueValues[r54]
                                                                r2 = upvalueValues[r20]
                                                                r24 = upvalueValues[r55]
                                                                r49 = 7860696223308
                                                                r19 = "\241F)F\r\207}\232\\"
                                                                r23 = r24(r19, r49)
                                                                r52 = r2[r23]
                                                                r42 = r18[r52]
                                                                r2 = upvalueValues[r20]
                                                                r24 = upvalueValues[r55]
                                                                r19 = "\156WW\242\152\207\231T\021\024"
                                                                r49 = 22542887708929
                                                                r23 = r24(r19, r49)
                                                                r52 = r2[r23]
                                                                r2 = createClosure5(109, {
                                                                    r31,
                                                                    r20,
                                                                    r55
                                                                })
                                                                r18 = r42(r45, r52, r2)
                                                                r52 = upvalueValues[r20]
                                                                r2 = upvalueValues[r55]
                                                                r23 = "\195\248\212\0173\127\003\154\132\205"
                                                                r19 = 16080738360640
                                                                r24 = r2(r23, r19)
                                                                r18 = r52[r24]
                                                                r2 = upvalueValues[r20]
                                                                r24 = upvalueValues[r55]
                                                                r49 = 33129702751299
                                                                r19 = "\215\141\201P6"
                                                                r23 = r24(r19, r49)
                                                                r52 = r2[r23]
                                                                r42 = "CreateSector"
                                                                r42 = r47[r42]
                                                                r42 = r42(r47, r18, r52)
                                                                r52 = "getgenv"
                                                                r18 = _env[r52]
                                                                r52 = r18()
                                                                r2 = upvalueValues[r20]
                                                                r24 = upvalueValues[r55]
                                                                r19 = "ry\214\234\154\170SU\152\219\163\\\216CX\218\177\006\002"
                                                                r49 = 24687225531623
                                                                r23 = r24(r19, r49)
                                                                r18 = r2[r23]
                                                                r23 = upvalueValues[r20]
                                                                r19 = upvalueValues[r55]
                                                                r13 = "\232\248\144p\018Yn\195%k"
                                                                r4 = 28727264392257
                                                                r49 = r19(r13, r4)
                                                                r24 = r23[r49]
                                                                r19 = upvalueValues[r20]
                                                                r49 = upvalueValues[r55]
                                                                r38 = 20749597763006
                                                                r4 = "#n\201\220\022\129\015^\199]\180\165\129\211`\217"
                                                                r13 = r49(r4, r38)
                                                                r23 = r19[r13]
                                                                r49 = upvalueValues[r20]
                                                                r13 = upvalueValues[r55]
                                                                r26 = 16140681190748
                                                                r38 = "\146q\192\208&\203\182\220\199]"
                                                                r4 = r13(r38, r26)
                                                                r19 = r49[r4]
                                                                r4 = upvalueValues[r20]
                                                                r38 = upvalueValues[r55]
                                                                r33 = 25869170765582
                                                                r53 = "%\229\142\182\142\128\207'"
                                                                r26 = r38(r53, r33)
                                                                r13 = r4[r26]
                                                                r49 = 0.1485436
                                                                r4 = false
                                                                r2 = {
                                                                    [r24] = r23,
                                                                    [r19] = r49,
                                                                    [r13] = r4
                                                                }
                                                                r52[r18] = r2
                                                                r52 = "getgenv"
                                                                r18 = _env[r52]
                                                                r52 = r18()
                                                                r2 = upvalueValues[r20]
                                                                r24 = upvalueValues[r55]
                                                                r49 = 28475672818636
                                                                r19 = "\r\229\145M\020\137\183M\145\138rh . Nv\155E{\127\212`^\159Ti\007\t\235\\"
                                                                r23 = r24(r19, r49)
                                                                r18 = r2[r23]
                                                                r23 = upvalueValues[r20]
                                                                r19 = upvalueValues[r55]
                                                                r13 = "\167\204\174\149bl\153"
                                                                r4 = 22953354422720
                                                                r49 = r19(r13, r4)
                                                                r24 = r23[r49]
                                                                r49 = upvalueValues[r20]
                                                                r13 = upvalueValues[r55]
                                                                r38 = "\r\135\161U"
                                                                r26 = 18901146903137
                                                                r4 = r13(r38, r26)
                                                                r19 = r49[r4]
                                                                r4 = upvalueValues[r20]
                                                                r38 = upvalueValues[r55]
                                                                r33 = 26212149538733
                                                                r53 = "\221Z\133\175"
                                                                r26 = r38(r53, r33)
                                                                r13 = r4[r26]
                                                                r26 = upvalueValues[r20]
                                                                r53 = upvalueValues[r55]
                                                                r8 = "\026\012\148\157&M?\159\235\158\021n"
                                                                r29 = 30501569296251
                                                                r33 = r53(r8, r29)
                                                                r38 = r26[r33]
                                                                r33 = upvalueValues[r20]
                                                                r8 = upvalueValues[r55]
                                                                r12 = "\187\224\172\240PW\200p\233"
                                                                r46 = 8686076284876
                                                                r29 = r8(r12, r46)
                                                                r53 = r33[r29]
                                                                r29 = upvalueValues[r20]
                                                                r12 = upvalueValues[r55]
                                                                r39 = 25530505522800
                                                                r25 = "\144\192f\231i"
                                                                r46 = r12(r25, r39)
                                                                r8 = r29[r46]
                                                                r46 = "Color3"
                                                                r12 = _env[r46]
                                                                r25 = upvalueValues[r20]
                                                                r39 = upvalueValues[r55]
                                                                r30 = "N\200\n\011}\190\133"
                                                                r1 = 10404384953068
                                                                r32 = r39(r30, r1)
                                                                r46 = r25[r32]
                                                                r29 = r12[r46]
                                                                r25 = 120
                                                                r39 = 250
                                                                r46 = 200
                                                                r12 = r29(r46, r25, r39)
                                                                r23 = true
                                                                r49 = false
                                                                r4 = 60
                                                                r26 = 0.1
                                                                r33 = 0.2
                                                                r2 = {
                                                                    [r24] = r23,
                                                                    [r19] = r49,
                                                                    [r13] = r4,
                                                                    [r38] = r26,
                                                                    [r53] = r33,
                                                                    [r8] = r12
                                                                }
                                                                r52[r18] = r2
                                                                r2 = upvalueValues[r20]
                                                                r24 = upvalueValues[r55]
                                                                r19 = "]\193<\153\222\143"
                                                                r49 = 26802258194624
                                                                r23 = r24(r19, r49)
                                                                r18 = "AddButton"
                                                                r18 = r42[r18]
                                                                r52 = r2[r23]
                                                                r2 = createClosure5(110, {
                                                                    r20,
                                                                    r55
                                                                })
                                                                r18 = r18(r42, r52, r2)
                                                                r2 = upvalueValues[r20]
                                                                r24 = upvalueValues[r55]
                                                                r19 = "Q\154\209\228\185[j\015\200\178\024\239\207\229\179Ui"
                                                                r49 = 18454599541137
                                                                r23 = r24(r19, r49)
                                                                r24 = createClosure6(111, {
                                                                    r20,
                                                                    r55
                                                                })
                                                                r18 = "AddToggle"
                                                                r18 = r42[r18]
                                                                r52 = r2[r23]
                                                                r2 = false
                                                                r18 = r18(r42, r52, r2, r24)
                                                                r2 = upvalueValues[r20]
                                                                r24 = upvalueValues[r55]
                                                                r18 = "AddTextbox"
                                                                r18 = r42[r18]
                                                                r19 = "/\144\170?o;#\011|\169"
                                                                r49 = 21625906374486
                                                                r23 = r24(r19, r49)
                                                                r52 = r2[r23]
                                                                r24 = "tostring"
                                                                r2 = _env[r24]
                                                                r13 = "getgenv"
                                                                r49 = _env[r13]
                                                                r13 = r49()
                                                                r4 = upvalueValues[r20]
                                                                r38 = upvalueValues[r55]
                                                                r53 = "\251t4\161!k\164\ti*<b\157H\019#\137\003e"
                                                                r33 = 19616663004078
                                                                r26 = r38(r53, r33)
                                                                r49 = r4[r26]
                                                                r19 = r13[r49]
                                                                r13 = upvalueValues[r20]
                                                                r4 = upvalueValues[r55]
                                                                r53 = 13229155063824
                                                                r26 = "\246\177\203\223_\216\213D\r="
                                                                r38 = r4(r26, r53)
                                                                r49 = r13[r38]
                                                                r23 = r19[r49]
                                                                r24 = r2(r23)
                                                                r2 = createClosure4(114, {
                                                                    r20,
                                                                    r55
                                                                })
                                                                r18 = r18(r42, r52, r24, r2)
                                                                r2 = upvalueValues[r20]
                                                                r24 = upvalueValues[r55]
                                                                r19 = "\003iO\136"
                                                                r49 = 3053310150029
                                                                r23 = r24(r19, r49)
                                                                r52 = r2[r23]
                                                                r24 = "tostring"
                                                                r2 = _env[r24]
                                                                r13 = "getgenv"
                                                                r49 = _env[r13]
                                                                r13 = r49()
                                                                r4 = upvalueValues[r20]
                                                                r38 = upvalueValues[r55]
                                                                r33 = 16682591084120
                                                                r53 = "4E\007\226b\2377(\000\194v4\128\136\208\008\216B7n\212<\136\129@#\204\170\233\004\228"
                                                                r26 = r38(r53, r33)
                                                                r49 = r4[r26]
                                                                r18 = "AddTextbox"
                                                                r18 = r42[r18]
                                                                r19 = r13[r49]
                                                                r13 = upvalueValues[r20]
                                                                r4 = upvalueValues[r55]
                                                                r53 = 3547676673
                                                                r26 = ">\189\207\177"
                                                                r38 = r4(r26, r53)
                                                                r49 = r13[r38]
                                                                r23 = r19[r49]
                                                                r24 = r2(r23)
                                                                r2 = createClosure5(117, {
                                                                    r20,
                                                                    r55
                                                                })
                                                                r18 = r18(r42, r52, r24, r2)
                                                                r2 = upvalueValues[r20]
                                                                r24 = upvalueValues[r55]
                                                                r19 = "r|\011\000\180\182\026*+q\222"
                                                                r49 = 27520946303503
                                                                r23 = r24(r19, r49)
                                                                r52 = r2[r23]
                                                                r23 = upvalueValues[r20]
                                                                r19 = upvalueValues[r55]
                                                                r13 = "`\218\231\011"
                                                                r4 = 6486537653196
                                                                r49 = r19(r13, r4)
                                                                r24 = r23[r49]
                                                                r19 = upvalueValues[r20]
                                                                r49 = upvalueValues[r55]
                                                                r38 = 32759219960726
                                                                r4 = "\175\000A&jc\230\144\023\246~\178\019\163\246\179"
                                                                r13 = r49(r4, r38)
                                                                r23 = r19[r13]
                                                                r49 = upvalueValues[r20]
                                                                r13 = upvalueValues[r55]
                                                                r26 = 15193195518882
                                                                r38 = "\182\194\204\007s\t\167[\193p"
                                                                r4 = r13(r38, r26)
                                                                r19 = r49[r4]
                                                                r13 = upvalueValues[r20]
                                                                r4 = upvalueValues[r55]
                                                                r53 = 29219318461734
                                                                r26 = "U8~\229:\018T6\233\177"
                                                                r38 = r4(r26, r53)
                                                                r49 = r13[r38]
                                                                r2 = {
                                                                    r24,
                                                                    r23,
                                                                    r19,
                                                                    r49
                                                                }
                                                                r23 = upvalueValues[r20]
                                                                r19 = upvalueValues[r55]
                                                                r13 = "\012\155B\229\247\029\030\141q\206\001,\174\196af"
                                                                r4 = 20607278491004
                                                                r49 = r19(r13, r4)
                                                                r24 = r23[r49]
                                                                r19 = createClosure4(120, {
                                                                    r20,
                                                                    r55
                                                                })
                                                                r18 = "AddDropdown"
                                                                r18 = r42[r18]
                                                                r23 = false
                                                                r18 = r18(r42, r52, r2, r24, r23, r19)
                                                                r2 = upvalueValues[r20]
                                                                r24 = upvalueValues[r55]
                                                                r49 = 2566750389419
                                                                r19 = "@566\\\231\234\178"
                                                                r23 = r24(r19, r49)
                                                                r52 = r2[r23]
                                                                r24 = createClosure2(121, {
                                                                    r20,
                                                                    r55
                                                                })
                                                                r18 = "AddToggle"
                                                                r18 = r42[r18]
                                                                r2 = false
                                                                r18 = r18(r42, r52, r2, r24)
                                                                r2 = upvalueValues[r20]
                                                                r24 = upvalueValues[r55]
                                                                r49 = 24630453693645
                                                                r19 = "\250K\239\t"
                                                                r23 = r24(r19, r49)
                                                                r52 = r2[r23]
                                                                r18 = "AddToggle"
                                                                r18 = r42[r18]
                                                                r24 = createClosure5(124, {
                                                                    r20,
                                                                    r55
                                                                })
                                                                r2 = false
                                                                r18 = r18(r42, r52, r2, r24)
                                                                r2 = upvalueValues[r20]
                                                                r24 = upvalueValues[r55]
                                                                r19 = "\230\161\127\020"
                                                                r49 = 27749504955001
                                                                r23 = r24(r19, r49)
                                                                r52 = r2[r23]
                                                                r18 = "AddToggle"
                                                                r18 = r15[r18]
                                                                r24 = createClosure2(127, {
                                                                    r20,
                                                                    r55
                                                                })
                                                                r2 = false
                                                                r18 = r18(r15, r52, r2, r24)
                                                                r52 = "loadstring"
                                                                r18 = _env[r52]
                                                                r24 = "game"
                                                                r2 = _env[r24]
                                                                r19 = upvalueValues[r20]
                                                                r49 = upvalueValues[r55]
                                                                r38 = 15678153088132
                                                                r4 = "\254>K\229\200\184\192<B\005\1476\229\023j\170'\248h\128i\156K\176in}\159\212\203\163\132\176\022>\229\027: \015\178Q\216\024\164\227\171e\239\196\005\018\186.C\132r\134\147\137"
                                                                r13 = r49(r4, r38)
                                                                r23 = r19[r13]
                                                                r19 = "HttpGet"
                                                                r19 = r2[r19]
                                                                r24 = {
                                                                    r19(r2, r23)
                                                                }
                                                                r52 = r18(unpack(r24))
                                                                r18 = r52()
                                                                r52 = "CheckHWID"
                                                                r18 = _env[r52]
                                                                r52 = r18(r3)
                                                                state = r52 and (32) or (33)
                                                            end
                                                        end
                                                    else
                                                        if state <= 32 then
                                                            if state == 32 then
                                                                r52 = "print"
                                                                r18 = _env[r52]
                                                                r24 = upvalueValues[r20]
                                                                r23 = upvalueValues[r55]
                                                                r49 = "\135\231\193\222"
                                                                r13 = 15895741881578
                                                                r19 = r23(r49, r13)
                                                                r2 = r24[r19]
                                                                r52 = r18(r2)
                                                                state = 33
                                                            end
                                                        else
                                                            if state == 33 then
                                                                r6 = releaseUpvalue(r6)
                                                                r37 = releaseUpvalue(r37)
                                                                r40 = releaseUpvalue(r40)
                                                                r7 = releaseUpvalue(r7)
                                                                r31 = releaseUpvalue(r31)
                                                                r27 = releaseUpvalue(r27)
                                                                r20 = releaseUpvalue(r20)
                                                                ReturnVal = {}
                                                                r41 = nil
                                                                r5 = nil
                                                                r9 = releaseUpvalue(r9)
                                                                r35 = releaseUpvalue(r35)
                                                                r3 = nil
                                                                r43 = releaseUpvalue(r43)
                                                                r54 = releaseUpvalue(r54)
                                                                r15 = nil
                                                                r17 = nil
                                                                r16 = releaseUpvalue(r16)
                                                                r34 = releaseUpvalue(r34)
                                                                r22 = releaseUpvalue(r22)
                                                                r48 = releaseUpvalue(r48)
                                                                r47 = nil
                                                                r36 = releaseUpvalue(r36)
                                                                r21 = nil
                                                                r42 = nil
                                                                r55 = releaseUpvalue(r55)
                                                                r28 = releaseUpvalue(r28)
                                                                r45 = nil
                                                                state = nil
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        -- createClosure0 entry 8082448 -> 34, states 34-34
                                        if state == 34 then -- entry 8082448 -> 34
                                            ReturnVal = "error"
                                            state = _env[ReturnVal]
                                            r11 = "Tamper Detected!"
                                            ReturnVal = state(r11)
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure4 entry 16585994 -> 35, states 35-35
                                    if state == 35 then -- entry 16585994 -> 35
                                        state = true
                                        upvalueValues[upvalues[1]] = state
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            else
                                if state <= 48 then
                                    if state <= 36 then
                                        -- createClosure2 entry 14269286 -> 36, states 36-36
                                        if state == 36 then -- entry 14269286 -> 36
                                            r20 = "BgkeVrgKTrln8v"
                                            r3 = 13454290
                                            r11 = r20 ^ r3
                                            ReturnVal = 8931858
                                            state = ReturnVal - r11
                                            r11 = state
                                            ReturnVal = "rZhz8ddXU"
                                            state = ReturnVal / r11
                                            ReturnVal = {
                                                state
                                            }
                                            state = nil
                                        end
                                    else
                                        -- createClosure2 entry 2116229 -> 37, states 37-48
                                        if state <= 42 then
                                            if state <= 39 then
                                                if state <= 38 then
                                                    if state <= 37 then
                                                        if state == 37 then -- entry 2116229 -> 37
                                                            r20 = upvalueValues[upvalues[1]]
                                                            r47 = 2
                                                            r55 = 1
                                                            r3 = r20(r55, r47)
                                                            r20 = 1
                                                            r11 = r3 == r20
                                                            state = r11 and (38) or (39)
                                                            ReturnVal = r11
                                                        end
                                                    else
                                                        if state == 38 then
                                                            state = ReturnVal and (40) or (41)
                                                        end
                                                    end
                                                else
                                                    if state == 39 then
                                                        r20 = upvalueValues[upvalues[2]]
                                                        r3 = upvalueValues[upvalues[3]]
                                                        r11 = r20 == r3
                                                        ReturnVal = r11
                                                        state = 38
                                                    end
                                                end
                                            else
                                                if state <= 41 then
                                                    if state <= 40 then
                                                        if state == 40 then
                                                            r43 = createClosure2(128, {})
                                                            ReturnVal = "tonumber"
                                                            state = _env[ReturnVal]
                                                            r11 = upvalueValues[upvalues[4]]
                                                            r55 = "tostring"
                                                            r3 = _env[r55]
                                                            r15 = "pcall"
                                                            r21 = _env[r15]
                                                            r15 = {
                                                                r21(r43)
                                                            }
                                                            r22 = {
                                                                unpack(r15)
                                                            }
                                                            r21 = 2
                                                            r47 = r22[r21]
                                                            r55 = r3(r47)
                                                            r3 = ":(%d*):"
                                                            r20 = r11(r55, r3)
                                                            r11 = {
                                                                r20()
                                                            }
                                                            ReturnVal = state(unpack(r11))
                                                            r11 = ReturnVal
                                                            r20 = upvalueValues[upvalues[5]]
                                                            state = r20 and (42) or (43)
                                                            ReturnVal = r20
                                                        end
                                                    else
                                                        if state == 41 then
                                                            state = upvalueValues[upvalues[7]]
                                                            state = state and (44) or (45)
                                                        end
                                                    end
                                                else
                                                    if state == 42 then
                                                        r3 = upvalueValues[upvalues[6]]
                                                        r20 = r3 == r11
                                                        ReturnVal = r20
                                                        state = 43
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 45 then
                                                if state <= 44 then
                                                    if state <= 43 then
                                                        if state == 43 then
                                                            r11 = nil
                                                            upvalueValues[upvalues[5]] = ReturnVal
                                                            state = 41
                                                        end
                                                    else
                                                        if state == 44 then
                                                            r11 = "error"
                                                            state = _env[r11]
                                                            r20 = upvalueValues[upvalues[8]]
                                                            r3 = 0
                                                            r11 = state(r20, r3)
                                                            state = 45
                                                        end
                                                    end
                                                else
                                                    if state == 45 then
                                                        state = {}
                                                        r11 = state
                                                        r3 = upvalueValues[upvalues[9]]
                                                        r55 = r3
                                                        r3 = 1
                                                        r47 = r3
                                                        r3 = 0
                                                        r22 = r47 < r3
                                                        r20 = 1
                                                        r3 = r20 - r47
                                                        state = 46
                                                    end
                                                end
                                            else
                                                if state <= 47 then
                                                    if state <= 46 then
                                                        if state == 46 then
                                                            r3 = r3 + r47
                                                            r21 = not r22
                                                            r20 = r3 <= r55
                                                            r20 = r21 and r20
                                                            r21 = r3 >= r55
                                                            r21 = r22 and r21
                                                            r20 = r21 or r20
                                                            r21 = (47)
                                                            state = r20 and r21
                                                            r20 = (48)
                                                            state = state or r20
                                                        end
                                                    else
                                                        if state == 47 then
                                                            r20 = r3
                                                            state = upvalueValues[upvalues[1]]
                                                            r15 = 0
                                                            r43 = 255
                                                            r21 = state(r15, r43)
                                                            r11[r20] = r21
                                                            r20 = nil
                                                            state = 46
                                                        end
                                                    end
                                                else
                                                    if state == 48 then
                                                        state = upvalueValues[upvalues[10]]
                                                        r20 = upvalueValues[upvalues[11]]
                                                        r11[state] = r20
                                                        state = upvalueValues[upvalues[12]]
                                                        r20 = {
                                                            state(r11)
                                                        }
                                                        ReturnVal = {
                                                            unpack(r20)
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure4 entry 6228080 -> 49, states 49-52
                                    if state <= 50 then
                                        if state <= 49 then
                                            if state == 49 then -- entry 6228080 -> 49
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
                                                r11 = "l1"
                                                ReturnVal = _env[r11]
                                                r11 = "l1"
                                                _env[r11] = state
                                                r11 = "l2"
                                                _env[r11] = ReturnVal
                                                r11 = upvalueValues[upvalues[1]]
                                                r20 = r11()
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
                            if state <= 73 then
                                if state <= 65 then
                                    if state <= 58 then
                                        -- createClosure1 entry 9722171 -> 53, states 53-58
                                        if state <= 55 then
                                            if state <= 54 then
                                                if state <= 53 then
                                                    if state == 53 then -- entry 9722171 -> 53
                                                        r11 = upvalueValues[upvalues[1]]
                                                        ReturnVal = #r11
                                                        r11 = 0
                                                        state = ReturnVal == r11
                                                        state = state and (54) or (55)
                                                    end
                                                else
                                                    if state == 54 then
                                                        r20 = upvalueValues[upvalues[2]]
                                                        r3 = 93
                                                        r11 = r20 * r3
                                                        r20 = 4530641881149
                                                        ReturnVal = r11 + r20
                                                        r11 = 35184372088832
                                                        state = ReturnVal % r11
                                                        upvalueValues[upvalues[2]] = state
                                                        r11 = upvalueValues[upvalues[3]]
                                                        r20 = 1
                                                        ReturnVal = r11 ~= r20
                                                        state = 56
                                                    end
                                                end
                                            else
                                                if state == 55 then
                                                    r3 = "table"
                                                    r20 = _env[r3]
                                                    r3 = "remove"
                                                    r11 = r20[r3]
                                                    r3 = upvalueValues[upvalues[1]]
                                                    r20 = {
                                                        r11(r3)
                                                    }
                                                    ReturnVal = {
                                                        unpack(r20)
                                                    }
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state <= 57 then
                                                if state <= 56 then
                                                    if state == 56 then
                                                        r20 = upvalueValues[upvalues[3]]
                                                        r3 = 209
                                                        r11 = r20 * r3
                                                        r20 = 257
                                                        ReturnVal = r11 % r20
                                                        upvalueValues[upvalues[3]] = ReturnVal
                                                        state = 57
                                                    end
                                                else
                                                    if state == 57 then
                                                        r20 = upvalueValues[upvalues[3]]
                                                        r3 = 1
                                                        r11 = r20 ~= r3
                                                        state = r11 and (58) or (56)
                                                    end
                                                end
                                            else
                                                if state == 58 then
                                                    r3 = 32
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r11 = r20 % r3
                                                    r55 = upvalueValues[upvalues[4]]
                                                    r43 = 2
                                                    r21 = upvalueValues[upvalues[2]]
                                                    r34 = upvalueValues[upvalues[3]]
                                                    r41 = r34 - r11
                                                    r34 = 32
                                                    r40 = r41 / r34
                                                    r36 = 13
                                                    r17 = r36 - r40
                                                    r15 = r43 ^ r17
                                                    r22 = r21 / r15
                                                    r47 = r55(r22)
                                                    r15 = 1
                                                    r55 = 4294967296
                                                    r3 = r47 % r55
                                                    r47 = 2
                                                    r43 = 256
                                                    r55 = r47 ^ r11
                                                    r20 = r3 / r55
                                                    r55 = upvalueValues[upvalues[4]]
                                                    r21 = r20 % r15
                                                    r11 = nil
                                                    r15 = 4294967296
                                                    r22 = r21 * r15
                                                    r47 = r55(r22)
                                                    r55 = upvalueValues[upvalues[4]]
                                                    r22 = r55(r20)
                                                    r3 = r47 + r22
                                                    r47 = 65536
                                                    r55 = r3 % r47
                                                    r21 = 65536
                                                    r22 = r3 - r55
                                                    r47 = r22 / r21
                                                    r21 = 256
                                                    r22 = r55 % r21
                                                    r36 = 256
                                                    r3 = nil
                                                    r15 = r55 - r22
                                                    r21 = r15 / r43
                                                    r43 = 256
                                                    r15 = r47 % r43
                                                    r55 = nil
                                                    r17 = r47 - r15
                                                    r47 = nil
                                                    r20 = nil
                                                    r43 = r17 / r36
                                                    r17 = {
                                                        r22,
                                                        r21,
                                                        r15,
                                                        r43
                                                    }
                                                    r21 = nil
                                                    r15 = nil
                                                    r43 = nil
                                                    upvalueValues[upvalues[1]] = r17
                                                    r22 = nil
                                                    state = 55
                                                end
                                            end
                                        end
                                    else
                                        -- createClosure3 entry 16617830 -> 59, states 59-65
                                        if state <= 62 then
                                            if state <= 60 then
                                                if state <= 59 then
                                                    if state == 59 then -- entry 16617830 -> 59
                                                        r11 = args[1]
                                                        r20 = args[2]
                                                        state = upvalueValues[upvalues[1]]
                                                        r3 = state
                                                        state = r3[r20]
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
                                                        r55 = ReturnVal
                                                        r47 = 35184372088832
                                                        ReturnVal = r20 % r47
                                                        upvalueValues[upvalues[4]] = ReturnVal
                                                        r21 = 255
                                                        r22 = r20 % r21
                                                        r21 = 2
                                                        r47 = r22 + r21
                                                        upvalueValues[upvalues[5]] = r47
                                                        r15 = "string"
                                                        r21 = _env[r15]
                                                        r17 = 1
                                                        r15 = "len"
                                                        r22 = r21[r15]
                                                        r21 = r22(r11)
                                                        r36 = r17
                                                        r17 = 0
                                                        r40 = r36 < r17
                                                        r22 = ""
                                                        r3[r20] = r22
                                                        r15 = 1
                                                        r17 = r15 - r36
                                                        r43 = r21
                                                        r22 = 73
                                                        state = 63
                                                    end
                                                else
                                                    if state == 62 then
                                                        ReturnVal = {
                                                            r20
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 64 then
                                                if state <= 63 then
                                                    if state == 63 then
                                                        r41 = not r40
                                                        r17 = r17 + r36
                                                        r15 = r17 <= r43
                                                        r15 = r41 and r15
                                                        r41 = r17 >= r43
                                                        r41 = r40 and r41
                                                        r15 = r41 or r15
                                                        r41 = (64)
                                                        state = r15 and r41
                                                        r15 = (65)
                                                        state = state or r15
                                                    end
                                                else
                                                    if state == 64 then
                                                        r15 = r17
                                                        r51 = "string"
                                                        r50 = _env[r51]
                                                        r51 = "byte"
                                                        r56 = r50[r51]
                                                        r50 = r56(r11, r15)
                                                        r15 = nil
                                                        r56 = upvalueValues[upvalues[6]]
                                                        r51 = r56()
                                                        r27 = r50 + r51
                                                        r34 = r27 + r22
                                                        r27 = 256
                                                        r41 = r34 % r27
                                                        r22 = r41
                                                        r27 = r3[r20]
                                                        r51 = 1
                                                        r50 = r22 + r51
                                                        r56 = r55[r50]
                                                        r34 = r27 .. r56
                                                        r3[r20] = r34
                                                        state = 63
                                                    end
                                                end
                                            else
                                                if state == 65 then
                                                    r22 = nil
                                                    r21 = nil
                                                    r55 = nil
                                                    state = 62
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure4 entry 7887914 -> 66, states 66-73
                                    if state <= 69 then
                                        if state <= 67 then
                                            if state <= 66 then
                                                if state == 66 then -- entry 7887914 -> 66
                                                    r11 = args[1]
                                                    ReturnVal = "pairs"
                                                    state = _env[ReturnVal]
                                                    r55 = upvalueValues[upvalues[1]]
                                                    r47 = {
                                                        state(r55)
                                                    }
                                                    ReturnVal = r47[1]
                                                    r55 = ReturnVal
                                                    r3 = r47[3]
                                                    r20 = r47[2]
                                                    state = 67
                                                end
                                            else
                                                if state == 67 then
                                                    state = true
                                                    state = state and (68) or (69)
                                                end
                                            end
                                        else
                                            if state <= 68 then
                                                if state == 68 then
                                                    state = nil
                                                    r47 = state
                                                    r22 = {
                                                        r55(r20, r3)
                                                    }
                                                    state = r22[1]
                                                    r3 = state
                                                    ReturnVal = r22[2]
                                                    r21 = nil
                                                    r22 = r3 == r21
                                                    state = r22 and (70) or (71)
                                                    r47 = ReturnVal
                                                end
                                            else
                                                if state == 69 then
                                                    r47 = false
                                                    ReturnVal = {
                                                        r47
                                                    }
                                                    state = nil
                                                end
                                            end
                                        end
                                    else
                                        if state <= 71 then
                                            if state <= 70 then
                                                if state == 70 then
                                                    r47 = nil
                                                    state = 69
                                                end
                                            else
                                                if state == 71 then
                                                    r22 = r11 == r47
                                                    state = r22 and (72) or (73)
                                                end
                                            end
                                        else
                                            if state <= 72 then
                                                if state == 72 then
                                                    r22 = true
                                                    ReturnVal = {
                                                        r22
                                                    }
                                                    state = nil
                                                end
                                            else
                                                if state == 73 then
                                                    r47 = nil
                                                    state = 67
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 77 then
                                    if state <= 74 then
                                        -- createClosure1 entry 12779053 -> 74, states 74-74
                                        if state == 74 then -- entry 12779053 -> 74
                                            state = createClosure0(129, {
                                                upvalues[1],
                                                upvalues[2],
                                                upvalues[3]
                                            })
                                            ReturnVal = "FindNearestEnemy"
                                            _env[ReturnVal] = state
                                            r11 = allocUpvalue()
                                            state = nil
                                            upvalueValues[r11] = state
                                            ReturnVal = upvalueValues[upvalues[4]]
                                            r3 = upvalueValues[upvalues[1]]
                                            r55 = upvalueValues[upvalues[2]]
                                            r21 = 24401294191714
                                            r22 = "[\015\203\215\177>\157\t\170"
                                            r47 = r55(r22, r21)
                                            r20 = r3[r47]
                                            state = ReturnVal[r20]
                                            r20 = createClosure0(147, {
                                                upvalues[5],
                                                r11,
                                                upvalues[1],
                                                upvalues[2],
                                                upvalues[6],
                                                upvalues[7],
                                                upvalues[8],
                                                upvalues[9]
                                            })
                                            ReturnVal = "Connect"
                                            ReturnVal = state[ReturnVal]
                                            ReturnVal = ReturnVal(state, r20)
                                            ReturnVal = upvalueValues[upvalues[10]]
                                            r3 = upvalueValues[upvalues[1]]
                                            r55 = upvalueValues[upvalues[2]]
                                            r21 = 12606576695022
                                            r22 = "4Wq\178*_\159"
                                            r47 = r55(r22, r21)
                                            r20 = r3[r47]
                                            state = ReturnVal[r20]
                                            r20 = createClosure3(152, {
                                                upvalues[1],
                                                upvalues[2],
                                                upvalues[5],
                                                r11
                                            })
                                            ReturnVal = "Connect"
                                            ReturnVal = state[ReturnVal]
                                            ReturnVal = ReturnVal(state, r20)
                                            r34 = 11571477599500
                                            r20 = "Instance"
                                            ReturnVal = _env[r20]
                                            r3 = upvalueValues[upvalues[1]]
                                            r55 = upvalueValues[upvalues[2]]
                                            r22 = "\2102U"
                                            r21 = 32061344053841
                                            r47 = r55(r22, r21)
                                            r20 = r3[r47]
                                            state = ReturnVal[r20]
                                            r3 = upvalueValues[upvalues[1]]
                                            r55 = upvalueValues[upvalues[2]]
                                            r21 = 22358100928683
                                            r22 = "Z\172\156-\127\219o\011\215"
                                            r47 = r55(r22, r21)
                                            r20 = r3[r47]
                                            ReturnVal = state(r20)
                                            r20 = ReturnVal
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r3 = upvalueValues[upvalues[2]]
                                            r47 = "\196Y\223\155"
                                            r22 = 26844043669716
                                            r55 = r3(r47, r22)
                                            state = ReturnVal[r55]
                                            r3 = upvalueValues[upvalues[1]]
                                            r55 = upvalueValues[upvalues[2]]
                                            r21 = 3349745911319
                                            r22 = "{Cr3\230\203S\177"
                                            r47 = r55(r22, r21)
                                            ReturnVal = r3[r47]
                                            r20[state] = ReturnVal
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r3 = upvalueValues[upvalues[2]]
                                            r47 = "\2497\181\177\143\157"
                                            r22 = 9623017017729
                                            r55 = r3(r47, r22)
                                            state = ReturnVal[r55]
                                            r55 = "game"
                                            r3 = _env[r55]
                                            r47 = upvalueValues[upvalues[1]]
                                            r22 = upvalueValues[upvalues[2]]
                                            r43 = 30754490988529
                                            r15 = "-\246=\143\192\174\186"
                                            r21 = r22(r15, r43)
                                            r55 = r47[r21]
                                            ReturnVal = r3[r55]
                                            r20[state] = ReturnVal
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r3 = upvalueValues[upvalues[2]]
                                            r47 = "\001RD\167Uf\242\031\192:h\143\1644"
                                            r22 = 14353161755163
                                            r55 = r3(r47, r22)
                                            state = ReturnVal[r55]
                                            r47 = "Enum"
                                            r55 = _env[r47]
                                            r22 = upvalueValues[upvalues[1]]
                                            r21 = upvalueValues[upvalues[2]]
                                            r17 = 7004521221309
                                            r43 = "\233Z\160\1880\027\168m^\133\t\227\194E"
                                            r15 = r21(r43, r17)
                                            r47 = r22[r15]
                                            r3 = r55[r47]
                                            r47 = upvalueValues[upvalues[1]]
                                            r22 = upvalueValues[upvalues[2]]
                                            r15 = "\t\144\229\0177`6"
                                            r43 = 25445530906185
                                            r21 = r22(r15, r43)
                                            r55 = r47[r21]
                                            ReturnVal = r3[r55]
                                            r3 = "Instance"
                                            r20[state] = ReturnVal
                                            ReturnVal = _env[r3]
                                            r55 = upvalueValues[upvalues[1]]
                                            r47 = upvalueValues[upvalues[2]]
                                            r21 = "\223\236\017"
                                            r15 = 34501694684866
                                            r22 = r47(r21, r15)
                                            r3 = r55[r22]
                                            state = ReturnVal[r3]
                                            r55 = upvalueValues[upvalues[1]]
                                            r47 = upvalueValues[upvalues[2]]
                                            r21 = "M\172\148k{"
                                            r15 = 23270652504660
                                            r22 = r47(r21, r15)
                                            r3 = r55[r22]
                                            ReturnVal = state(r3)
                                            r3 = ReturnVal
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r55 = upvalueValues[upvalues[2]]
                                            r22 = "9\228\188\224\022\202"
                                            r21 = 17878692339845
                                            r47 = r55(r22, r21)
                                            state = ReturnVal[r47]
                                            ReturnVal = r20
                                            r3[state] = ReturnVal
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r55 = upvalueValues[upvalues[2]]
                                            r21 = 15686276324488
                                            r22 = "\134K\165\209\188\204\134n\210\242p\180\147\014Y\187"
                                            r47 = r55(r22, r21)
                                            state = ReturnVal[r47]
                                            r47 = "Color3"
                                            r55 = _env[r47]
                                            r22 = upvalueValues[upvalues[1]]
                                            r21 = upvalueValues[upvalues[2]]
                                            r43 = "\tR\1346\tD\r"
                                            r17 = 7332480912726
                                            r15 = r21(r43, r17)
                                            r47 = r22[r15]
                                            ReturnVal = r55[r47]
                                            r21 = 0
                                            r22 = 0
                                            r47 = 0
                                            r55 = ReturnVal(r47, r22, r21)
                                            r3[state] = r55
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r55 = upvalueValues[upvalues[2]]
                                            r21 = 29484370212257
                                            r22 = "\146\170\005UJ\148\247\193\162$\024\159"
                                            r47 = r55(r22, r21)
                                            state = ReturnVal[r47]
                                            r47 = "Color3"
                                            r55 = _env[r47]
                                            r22 = upvalueValues[upvalues[1]]
                                            r21 = upvalueValues[upvalues[2]]
                                            r43 = "m\133\229w\186g6"
                                            r17 = 8972787732562
                                            r15 = r21(r43, r17)
                                            r47 = r22[r15]
                                            ReturnVal = r55[r47]
                                            r21 = 0
                                            r47 = 0
                                            r22 = 0
                                            r55 = ReturnVal(r47, r22, r21)
                                            r3[state] = r55
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r55 = upvalueValues[upvalues[2]]
                                            r21 = 5694931946075
                                            r22 = "3\191~\178\238e\167\026S\177F\158\165\174\204"
                                            r47 = r55(r22, r21)
                                            state = ReturnVal[r47]
                                            ReturnVal = 0
                                            r3[state] = ReturnVal
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r55 = upvalueValues[upvalues[2]]
                                            r21 = 18701292315140
                                            r22 = "3\011\208\185l\014i\253"
                                            r47 = r55(r22, r21)
                                            state = ReturnVal[r47]
                                            r47 = "UDim2"
                                            r55 = _env[r47]
                                            r22 = upvalueValues[upvalues[1]]
                                            r21 = upvalueValues[upvalues[2]]
                                            r43 = "[\249\190"
                                            r17 = 22158386325582
                                            r15 = r21(r43, r17)
                                            r47 = r22[r15]
                                            ReturnVal = r55[r47]
                                            r22 = 0
                                            r15 = 0
                                            r47 = 0.133798108
                                            r21 = 0.20107238
                                            r55 = ReturnVal(r47, r22, r21, r15)
                                            r3[state] = r55
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r55 = upvalueValues[upvalues[2]]
                                            r22 = "\186\228h#"
                                            r21 = 339460980894
                                            r47 = r55(r22, r21)
                                            state = ReturnVal[r47]
                                            r47 = "UDim2"
                                            r55 = _env[r47]
                                            r22 = upvalueValues[upvalues[1]]
                                            r21 = upvalueValues[upvalues[2]]
                                            r17 = 31325793024251
                                            r43 = "-\008\018"
                                            r15 = r21(r43, r17)
                                            r47 = r22[r15]
                                            ReturnVal = r55[r47]
                                            r21 = 0
                                            r15 = 70
                                            r47 = 0
                                            r22 = 80
                                            r55 = ReturnVal(r47, r22, r21, r15)
                                            r3[state] = r55
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r55 = upvalueValues[upvalues[2]]
                                            r21 = 32384237845224
                                            r22 = "=\210\179ha:"
                                            r47 = r55(r22, r21)
                                            state = ReturnVal[r47]
                                            ReturnVal = true
                                            r3[state] = ReturnVal
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r55 = upvalueValues[upvalues[2]]
                                            r21 = 7168654445834
                                            r22 = "7M-\203\209M\177\212\163"
                                            r47 = r55(r22, r21)
                                            state = ReturnVal[r47]
                                            r55 = "Instance"
                                            ReturnVal = true
                                            r3[state] = ReturnVal
                                            ReturnVal = _env[r55]
                                            r47 = upvalueValues[upvalues[1]]
                                            r22 = upvalueValues[upvalues[2]]
                                            r43 = 24652566129879
                                            r15 = "\249P\141"
                                            r21 = r22(r15, r43)
                                            r55 = r47[r21]
                                            state = ReturnVal[r55]
                                            r17 = "V\228\1452^\168\212"
                                            r36 = 8137620393677
                                            r41 = 31736348309946
                                            r47 = upvalueValues[upvalues[1]]
                                            r22 = upvalueValues[upvalues[2]]
                                            r43 = 6482883890122
                                            r15 = "\001\132\008F\016\159\150K\244\235"
                                            r21 = r22(r15, r43)
                                            r55 = r47[r21]
                                            r20 = nil
                                            ReturnVal = state(r55)
                                            r55 = ReturnVal
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r47 = upvalueValues[upvalues[2]]
                                            r15 = 21427107194617
                                            r21 = "\130\225K\003"
                                            r22 = r47(r21, r15)
                                            state = ReturnVal[r22]
                                            r47 = upvalueValues[upvalues[1]]
                                            r22 = upvalueValues[upvalues[2]]
                                            r15 = "7\147\253y"
                                            r43 = 30715415803870
                                            r21 = r22(r15, r43)
                                            ReturnVal = r47[r21]
                                            r55[state] = ReturnVal
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r47 = upvalueValues[upvalues[2]]
                                            r15 = 10141294744178
                                            r21 = "\153\2124\000H\007"
                                            r22 = r47(r21, r15)
                                            state = ReturnVal[r22]
                                            ReturnVal = r3
                                            r55[state] = ReturnVal
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r47 = upvalueValues[upvalues[2]]
                                            r15 = 17542819569641
                                            r21 = "\155x\006\141\197\187t\208S\218\023\234\214\252\007\139"
                                            r22 = r47(r21, r15)
                                            state = ReturnVal[r22]
                                            r22 = "Color3"
                                            r47 = _env[r22]
                                            r21 = upvalueValues[upvalues[1]]
                                            r15 = upvalueValues[upvalues[2]]
                                            r43 = r15(r17, r36)
                                            r22 = r21[r43]
                                            ReturnVal = r47[r22]
                                            r15 = 255
                                            r22 = 255
                                            r21 = 255
                                            r47 = ReturnVal(r22, r21, r15)
                                            r55[state] = r47
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r47 = upvalueValues[upvalues[2]]
                                            r21 = "\186M\019\238\025B-\002j\219\132\t;\021\025.\004\205!M\023\253"
                                            r15 = 6882336492676
                                            r22 = r47(r21, r15)
                                            state = ReturnVal[r22]
                                            ReturnVal = 5
                                            r55[state] = ReturnVal
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r47 = upvalueValues[upvalues[2]]
                                            r21 = "q9\015O\171X\008\163\254]\150\195"
                                            r15 = 14419791518266
                                            r22 = r47(r21, r15)
                                            state = ReturnVal[r22]
                                            r22 = "Color3"
                                            r47 = _env[r22]
                                            r21 = upvalueValues[upvalues[1]]
                                            r15 = upvalueValues[upvalues[2]]
                                            r17 = "\t[\252\159\154\148\245"
                                            r36 = 30495721322360
                                            r43 = r15(r17, r36)
                                            r22 = r21[r43]
                                            ReturnVal = r47[r22]
                                            r22 = 0
                                            r15 = 0
                                            r21 = 0
                                            r47 = ReturnVal(r22, r21, r15)
                                            r55[state] = r47
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r47 = upvalueValues[upvalues[2]]
                                            r21 = "mdFY+?rl\254\132#u\248##"
                                            r15 = 33726380162393
                                            r22 = r47(r21, r15)
                                            state = ReturnVal[r22]
                                            ReturnVal = 0
                                            r55[state] = ReturnVal
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r47 = upvalueValues[upvalues[2]]
                                            r15 = 17769537429586
                                            r21 = "\\\019\136\138\029@\019\162"
                                            r22 = r47(r21, r15)
                                            state = ReturnVal[r22]
                                            r22 = "UDim2"
                                            r47 = _env[r22]
                                            r21 = upvalueValues[upvalues[1]]
                                            r15 = upvalueValues[upvalues[2]]
                                            r17 = "$F\180"
                                            r36 = 4934366251257
                                            r43 = r15(r17, r36)
                                            r22 = r21[r43]
                                            ReturnVal = r47[r22]
                                            r43 = 0
                                            r15 = 0
                                            r21 = 0
                                            r22 = 0.326732665
                                            r47 = ReturnVal(r22, r21, r15, r43)
                                            r55[state] = r47
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r47 = upvalueValues[upvalues[2]]
                                            r21 = "\161\239+\168"
                                            r15 = 29296499045706
                                            r22 = r47(r21, r15)
                                            state = ReturnVal[r22]
                                            r22 = "UDim2"
                                            r47 = _env[r22]
                                            r21 = upvalueValues[upvalues[1]]
                                            r15 = upvalueValues[upvalues[2]]
                                            r36 = 32122699184750
                                            r17 = "\135'K"
                                            r43 = r15(r17, r36)
                                            r22 = r21[r43]
                                            ReturnVal = r47[r22]
                                            r15 = 0
                                            r22 = 0
                                            r21 = 43
                                            r43 = 43
                                            r47 = ReturnVal(r22, r21, r15, r43)
                                            r55[state] = r47
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r47 = upvalueValues[upvalues[2]]
                                            r15 = 11938887472567
                                            r21 = "QZ\1576\249"
                                            r22 = r47(r21, r15)
                                            state = ReturnVal[r22]
                                            r47 = upvalueValues[upvalues[1]]
                                            r22 = upvalueValues[upvalues[2]]
                                            r15 = "\208J)\030,\213\183\209vR$bA\r\182\198\190t^\241\211\181\025\190"
                                            r43 = 19557657846675
                                            r21 = r22(r15, r43)
                                            ReturnVal = r47[r21]
                                            r55[state] = ReturnVal
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r47 = upvalueValues[upvalues[2]]
                                            r21 = "\208\133[)!\187\239\204e\199V\243\170)\127rC"
                                            r15 = 31440021780784
                                            r22 = r47(r21, r15)
                                            state = ReturnVal[r22]
                                            ReturnVal = 0.2
                                            r55[state] = ReturnVal
                                            r47 = "Instance"
                                            ReturnVal = _env[r47]
                                            r22 = upvalueValues[upvalues[1]]
                                            r21 = upvalueValues[upvalues[2]]
                                            r43 = "\210p\243"
                                            r17 = 25167872011
                                            r15 = r21(r43, r17)
                                            r47 = r22[r15]
                                            state = ReturnVal[r47]
                                            r22 = upvalueValues[upvalues[1]]
                                            r21 = upvalueValues[upvalues[2]]
                                            r17 = 2251978097688
                                            r43 = "\250\145m\155\003j\161\194\132\000"
                                            r15 = r21(r43, r17)
                                            r47 = r22[r15]
                                            ReturnVal = state(r47)
                                            r47 = allocUpvalue()
                                            upvalueValues[r47] = ReturnVal
                                            state = upvalueValues[r47]
                                            r22 = upvalueValues[upvalues[1]]
                                            r21 = upvalueValues[upvalues[2]]
                                            r17 = 11941926000056
                                            r43 = "E\1639\139v\238"
                                            r15 = r21(r43, r17)
                                            ReturnVal = r22[r15]
                                            r22 = r3
                                            state[ReturnVal] = r22
                                            state = upvalueValues[r47]
                                            r22 = upvalueValues[upvalues[1]]
                                            r21 = upvalueValues[upvalues[2]]
                                            r17 = 7357648784738
                                            r43 = "pP~#(\156\155\186w\"+\184\243gB\159"
                                            r15 = r21(r43, r17)
                                            ReturnVal = r22[r15]
                                            r15 = "Color3"
                                            r21 = _env[r15]
                                            r43 = upvalueValues[upvalues[1]]
                                            r17 = upvalueValues[upvalues[2]]
                                            r40 = "\026%/J\132\1915"
                                            r36 = r17(r40, r41)
                                            r15 = r43[r36]
                                            r22 = r21[r15]
                                            r17 = 255
                                            r43 = 255
                                            r15 = 255
                                            r21 = r22(r15, r43, r17)
                                            state[ReturnVal] = r21
                                            state = upvalueValues[r47]
                                            r22 = upvalueValues[upvalues[1]]
                                            r21 = upvalueValues[upvalues[2]]
                                            r17 = 20914713732619
                                            r43 = "Z\174^<d\127\136hB\251\135)\174,\2481/\223\133HP\146"
                                            r15 = r21(r43, r17)
                                            ReturnVal = r22[r15]
                                            r22 = 5
                                            state[ReturnVal] = r22
                                            state = upvalueValues[r47]
                                            r22 = upvalueValues[upvalues[1]]
                                            r21 = upvalueValues[upvalues[2]]
                                            r17 = 13052580730814
                                            r43 = "\204\221\216\177\148\243\180\230\221\t\158\229"
                                            r15 = r21(r43, r17)
                                            ReturnVal = r22[r15]
                                            r15 = "Color3"
                                            r21 = _env[r15]
                                            r43 = upvalueValues[upvalues[1]]
                                            r17 = upvalueValues[upvalues[2]]
                                            r40 = "s\155\215+\172\143\218"
                                            r41 = 15253268519870
                                            r36 = r17(r40, r41)
                                            r15 = r43[r36]
                                            r22 = r21[r15]
                                            r17 = 0
                                            r43 = 0
                                            r15 = 0
                                            r21 = r22(r15, r43, r17)
                                            state[ReturnVal] = r21
                                            state = upvalueValues[r47]
                                            r22 = upvalueValues[upvalues[1]]
                                            r21 = upvalueValues[upvalues[2]]
                                            r43 = ":B\020\232\250\215\135\237\211\207\252\223\251lQ"
                                            r17 = 7888727969369
                                            r15 = r21(r43, r17)
                                            ReturnVal = r22[r15]
                                            r22 = 0
                                            state[ReturnVal] = r22
                                            state = upvalueValues[r47]
                                            r22 = upvalueValues[upvalues[1]]
                                            r21 = upvalueValues[upvalues[2]]
                                            r43 = "w\177\248y\141\164\006\189"
                                            r17 = 13392041711708
                                            r15 = r21(r43, r17)
                                            ReturnVal = r22[r15]
                                            r15 = "UDim2"
                                            r21 = _env[r15]
                                            r43 = upvalueValues[upvalues[1]]
                                            r17 = upvalueValues[upvalues[2]]
                                            r41 = 11394689438906
                                            r40 = "I\238s"
                                            r36 = r17(r40, r41)
                                            r15 = r43[r36]
                                            r22 = r21[r15]
                                            r17 = 0.18571429
                                            r15 = 0.0792079195
                                            r43 = 0
                                            r36 = 0
                                            r21 = r22(r15, r43, r17, r36)
                                            state[ReturnVal] = r21
                                            state = upvalueValues[r47]
                                            r22 = upvalueValues[upvalues[1]]
                                            r21 = upvalueValues[upvalues[2]]
                                            r17 = 5088593709377
                                            r43 = "\214\177\003\254"
                                            r15 = r21(r43, r17)
                                            ReturnVal = r22[r15]
                                            r15 = "UDim2"
                                            r21 = _env[r15]
                                            r43 = upvalueValues[upvalues[1]]
                                            r17 = upvalueValues[upvalues[2]]
                                            r41 = 20560696173926
                                            r40 = "\019\185\169"
                                            r36 = r17(r40, r41)
                                            r15 = r43[r36]
                                            r22 = r21[r15]
                                            r36 = 44
                                            r43 = 80
                                            r17 = 0
                                            r15 = 0
                                            r21 = r22(r15, r43, r17, r36)
                                            state[ReturnVal] = r21
                                            state = upvalueValues[r47]
                                            r22 = upvalueValues[upvalues[1]]
                                            r21 = upvalueValues[upvalues[2]]
                                            r43 = "7\1959g"
                                            r17 = 862883463569
                                            r15 = r21(r43, r17)
                                            ReturnVal = r22[r15]
                                            r43 = "Enum"
                                            r15 = _env[r43]
                                            r17 = upvalueValues[upvalues[1]]
                                            r36 = upvalueValues[upvalues[2]]
                                            r41 = "\180rB\019"
                                            r40 = r36(r41, r34)
                                            r43 = r17[r40]
                                            r21 = r15[r43]
                                            r43 = upvalueValues[upvalues[1]]
                                            r17 = upvalueValues[upvalues[2]]
                                            r41 = 6803431263328
                                            r40 = "p\245x\197\202H&\135x\162\197^B<\220\247'\022"
                                            r36 = r17(r40, r41)
                                            r15 = r43[r36]
                                            r22 = r21[r15]
                                            state[ReturnVal] = r22
                                            state = upvalueValues[r47]
                                            r22 = upvalueValues[upvalues[1]]
                                            r21 = upvalueValues[upvalues[2]]
                                            r17 = 31578299283824
                                            r43 = "V\005\135\142"
                                            r15 = r21(r43, r17)
                                            ReturnVal = r22[r15]
                                            r21 = upvalueValues[upvalues[1]]
                                            r15 = upvalueValues[upvalues[2]]
                                            r17 = "\226^\185\248r\230\164\167\164h\187"
                                            r36 = 21712772343678
                                            r43 = r15(r17, r36)
                                            r22 = r21[r43]
                                            state[ReturnVal] = r22
                                            state = upvalueValues[r47]
                                            r22 = upvalueValues[upvalues[1]]
                                            r21 = upvalueValues[upvalues[2]]
                                            r43 = "\015\026\225d\132\0274\143j\172"
                                            r17 = 24346250832969
                                            r15 = r21(r43, r17)
                                            ReturnVal = r22[r15]
                                            r15 = "Color3"
                                            r21 = _env[r15]
                                            r43 = upvalueValues[upvalues[1]]
                                            r17 = upvalueValues[upvalues[2]]
                                            r41 = 4531547572286
                                            r40 = "i?\170\221\n\174$"
                                            r36 = r17(r40, r41)
                                            r15 = r43[r36]
                                            r22 = r21[r15]
                                            r15 = 255
                                            r43 = 255
                                            r17 = 255
                                            r21 = r22(r15, r43, r17)
                                            state[ReturnVal] = r21
                                            state = upvalueValues[r47]
                                            r22 = upvalueValues[upvalues[1]]
                                            r21 = upvalueValues[upvalues[2]]
                                            r17 = 28595108836355
                                            r43 = "\024\155\212\184\169rOsS\150"
                                            r15 = r21(r43, r17)
                                            ReturnVal = r22[r15]
                                            r22 = true
                                            state[ReturnVal] = r22
                                            state = upvalueValues[r47]
                                            r22 = upvalueValues[upvalues[1]]
                                            r21 = upvalueValues[upvalues[2]]
                                            r43 = "\169\186{o\142\140\155i"
                                            r17 = 3581670246019
                                            r15 = r21(r43, r17)
                                            ReturnVal = r22[r15]
                                            r22 = 14
                                            state[ReturnVal] = r22
                                            state = upvalueValues[r47]
                                            r22 = upvalueValues[upvalues[1]]
                                            r21 = upvalueValues[upvalues[2]]
                                            r43 = "T\167\138\004\203\247~/\156\133,"
                                            r17 = 35027268911030
                                            r15 = r21(r43, r17)
                                            ReturnVal = r22[r15]
                                            r22 = true
                                            state[ReturnVal] = r22
                                            r22 = "Instance"
                                            ReturnVal = _env[r22]
                                            r21 = upvalueValues[upvalues[1]]
                                            r15 = upvalueValues[upvalues[2]]
                                            r17 = "\128\228\028"
                                            r36 = 27137116893532
                                            r43 = r15(r17, r36)
                                            r22 = r21[r43]
                                            state = ReturnVal[r22]
                                            r21 = upvalueValues[upvalues[1]]
                                            r15 = upvalueValues[upvalues[2]]
                                            r17 = "~\211\220\170\179\225\228?"
                                            r36 = 21351207675606
                                            r43 = r15(r17, r36)
                                            r22 = r21[r43]
                                            ReturnVal = state(r22)
                                            r22 = upvalueValues[upvalues[1]]
                                            r21 = upvalueValues[upvalues[2]]
                                            r17 = 4777263057072
                                            r43 = "u\139\011\175\167t"
                                            r15 = r21(r43, r17)
                                            state = r22[r15]
                                            r22 = r3
                                            ReturnVal[state] = r22
                                            r36 = "\146\020\023\2450u\235\027\215\155\197\178K$\001\155L"
                                            r40 = 21249243834022
                                            r22 = allocUpvalue()
                                            state = true
                                            upvalueValues[r22] = state
                                            r55 = nil
                                            ReturnVal = upvalueValues[r47]
                                            r15 = upvalueValues[upvalues[1]]
                                            r43 = upvalueValues[upvalues[2]]
                                            r17 = r43(r36, r40)
                                            r21 = r15[r17]
                                            state = ReturnVal[r21]
                                            r21 = createClosure3(158, {
                                                r22,
                                                r47,
                                                upvalues[1],
                                                upvalues[2],
                                                upvalues[5],
                                                r11
                                            })
                                            ReturnVal = "Connect"
                                            ReturnVal = state[ReturnVal]
                                            ReturnVal = ReturnVal(state, r21)
                                            r21 = "Instance"
                                            ReturnVal = _env[r21]
                                            r15 = upvalueValues[upvalues[1]]
                                            r43 = upvalueValues[upvalues[2]]
                                            r36 = "\255%e"
                                            r40 = 16741318418035
                                            r17 = r43(r36, r40)
                                            r3 = nil
                                            r21 = r15[r17]
                                            state = ReturnVal[r21]
                                            r15 = upvalueValues[upvalues[1]]
                                            r43 = upvalueValues[upvalues[2]]
                                            r40 = 7874507689554
                                            r36 = "*<\026\193\166\r1\145"
                                            r17 = r43(r36, r40)
                                            r21 = r15[r17]
                                            ReturnVal = state(r21)
                                            r21 = upvalueValues[upvalues[1]]
                                            r11 = releaseUpvalue(r11)
                                            r15 = upvalueValues[upvalues[2]]
                                            r36 = 26487110447150
                                            r17 = "\138\159\201O\203\133"
                                            r43 = r15(r17, r36)
                                            r22 = releaseUpvalue(r22)
                                            state = r21[r43]
                                            r21 = upvalueValues[r47]
                                            ReturnVal[state] = r21
                                            ReturnVal = {}
                                            r47 = releaseUpvalue(r47)
                                            state = nil
                                        end
                                    else
                                        -- createClosure5 entry 10424888 -> 75, states 75-77
                                        if state <= 76 then
                                            if state <= 75 then
                                                if state == 75 then -- entry 10424888 -> 75
                                                    r11 = args[1]
                                                    r3 = "tonumber"
                                                    r20 = _env[r3]
                                                    r3 = r20(r11)
                                                    state = r3 and (76) or (77)
                                                    ReturnVal = r3
                                                end
                                            else
                                                if state == 76 then
                                                    r11 = nil
                                                    upvalueValues[upvalues[1]] = ReturnVal
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state == 77 then
                                                r20 = upvalueValues[upvalues[1]]
                                                ReturnVal = r20
                                                state = 76
                                            end
                                        end
                                    end
                                else
                                    -- createClosure4 entry 13506743 -> 78, states 78-80
                                    if state <= 79 then
                                        if state <= 78 then
                                            if state == 78 then -- entry 13506743 -> 78
                                                r11 = args[1]
                                                r3 = "tonumber"
                                                r20 = _env[r3]
                                                r3 = r20(r11)
                                                state = r3 and (79) or (80)
                                                ReturnVal = r3
                                            end
                                        else
                                            if state == 79 then
                                                upvalueValues[upvalues[1]] = ReturnVal
                                                r11 = nil
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    else
                                        if state == 80 then
                                            r20 = upvalueValues[upvalues[1]]
                                            ReturnVal = r20
                                            state = 79
                                        end
                                    end
                                end
                            end
                        end
                    else
                        if state <= 96 then
                            if state <= 89 then
                                if state <= 86 then
                                    if state <= 83 then
                                        -- createClosure6 entry 4715344 -> 81, states 81-83
                                        if state <= 82 then
                                            if state <= 81 then
                                                if state == 81 then -- entry 4715344 -> 81
                                                    r11 = args[1]
                                                    r3 = "tonumber"
                                                    r20 = _env[r3]
                                                    r3 = r20(r11)
                                                    state = r3 and (82) or (83)
                                                    ReturnVal = r3
                                                end
                                            else
                                                if state == 82 then
                                                    r11 = nil
                                                    upvalueValues[upvalues[1]] = ReturnVal
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state == 83 then
                                                r20 = upvalueValues[upvalues[1]]
                                                ReturnVal = r20
                                                state = 82
                                            end
                                        end
                                    else
                                        -- createClosure6 entry 13966145 -> 84, states 84-86
                                        if state <= 85 then
                                            if state <= 84 then
                                                if state == 84 then -- entry 13966145 -> 84
                                                    r11 = args[1]
                                                    r3 = "tonumber"
                                                    r20 = _env[r3]
                                                    r3 = r20(r11)
                                                    state = r3 and (85) or (86)
                                                    ReturnVal = r3
                                                end
                                            else
                                                if state == 85 then
                                                    r11 = nil
                                                    upvalueValues[upvalues[1]] = ReturnVal
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state == 86 then
                                                r20 = upvalueValues[upvalues[1]]
                                                ReturnVal = r20
                                                state = 85
                                            end
                                        end
                                    end
                                else
                                    -- createClosure6 entry 4032745 -> 87, states 87-89
                                    if state <= 88 then
                                        if state <= 87 then
                                            if state == 87 then -- entry 4032745 -> 87
                                                r11 = args[1]
                                                r3 = "tonumber"
                                                r20 = _env[r3]
                                                r3 = r20(r11)
                                                state = r3 and (88) or (89)
                                                ReturnVal = r3
                                            end
                                        else
                                            if state == 88 then
                                                upvalueValues[upvalues[1]] = ReturnVal
                                                r11 = nil
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    else
                                        if state == 89 then
                                            r20 = upvalueValues[upvalues[1]]
                                            ReturnVal = r20
                                            state = 88
                                        end
                                    end
                                end
                            else
                                if state <= 95 then
                                    if state <= 92 then
                                        -- createClosure2 entry 14650988 -> 90, states 90-92
                                        if state <= 91 then
                                            if state <= 90 then
                                                if state == 90 then -- entry 14650988 -> 90
                                                    r11 = args[1]
                                                    r3 = "tonumber"
                                                    r20 = _env[r3]
                                                    r3 = r20(r11)
                                                    state = r3 and (91) or (92)
                                                    ReturnVal = r3
                                                end
                                            else
                                                if state == 91 then
                                                    r11 = nil
                                                    upvalueValues[upvalues[1]] = ReturnVal
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state == 92 then
                                                r20 = upvalueValues[upvalues[1]]
                                                ReturnVal = r20
                                                state = 91
                                            end
                                        end
                                    else
                                        -- createClosure6 entry 673274 -> 93, states 93-95
                                        if state <= 94 then
                                            if state <= 93 then
                                                if state == 93 then -- entry 673274 -> 93
                                                    r11 = args[1]
                                                    r3 = "tonumber"
                                                    r20 = _env[r3]
                                                    r3 = r20(r11)
                                                    state = r3 and (94) or (95)
                                                    ReturnVal = r3
                                                end
                                            else
                                                if state == 94 then
                                                    r11 = nil
                                                    upvalueValues[upvalues[1]] = ReturnVal
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state == 95 then
                                                r20 = upvalueValues[upvalues[1]]
                                                ReturnVal = r20
                                                state = 94
                                            end
                                        end
                                    end
                                else
                                    -- createClosure6 entry 5498648 -> 96, states 96-96
                                    if state == 96 then -- entry 5498648 -> 96
                                        r11 = args[1]
                                        ReturnVal = "getgenv"
                                        state = _env[ReturnVal]
                                        ReturnVal = state()
                                        r20 = upvalueValues[upvalues[1]]
                                        r3 = upvalueValues[upvalues[2]]
                                        r47 = "\162Q\208(L\173:\026\233\181"
                                        r22 = 1581879247584
                                        r55 = r3(r47, r22)
                                        state = r20[r55]
                                        r20 = r11
                                        ReturnVal[state] = r20
                                        r11 = nil
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            end
                        else
                            if state <= 99 then
                                if state <= 98 then
                                    if state <= 97 then
                                        -- createClosure4 entry 6444769 -> 97, states 97-97
                                        if state == 97 then -- entry 6444769 -> 97
                                            ReturnVal = "getgenv"
                                            state = _env[ReturnVal]
                                            ReturnVal = state()
                                            r11 = args[1]
                                            r20 = upvalueValues[upvalues[1]]
                                            r3 = upvalueValues[upvalues[2]]
                                            r22 = 32705696906109
                                            r47 = "~|\024\000\188\173\135;\002\178\231\216"
                                            r55 = r3(r47, r22)
                                            state = r20[r55]
                                            r20 = r11
                                            ReturnVal[state] = r20
                                            r11 = nil
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    else
                                        -- createClosure1 entry 8636114 -> 98, states 98-98
                                        if state == 98 then -- entry 8636114 -> 98
                                            r11 = args[1]
                                            r3 = "getgenv"
                                            r20 = _env[r3]
                                            r3 = r20()
                                            r55 = upvalueValues[upvalues[1]]
                                            r47 = upvalueValues[upvalues[2]]
                                            r15 = 21633729570649
                                            r21 = "S\166\128\237<\005\166;"
                                            r22 = r47(r21, r15)
                                            r20 = r55[r22]
                                            ReturnVal = r3[r20]
                                            r3 = upvalueValues[upvalues[1]]
                                            r55 = upvalueValues[upvalues[2]]
                                            r21 = 2298587857966
                                            r22 = "\135G\015r\146b\252\011"
                                            r47 = r55(r22, r21)
                                            r20 = r3[r47]
                                            state = ReturnVal[r20]
                                            r20 = upvalueValues[upvalues[1]]
                                            r3 = upvalueValues[upvalues[2]]
                                            r47 = "\158\222\198\029\146\173\163\254"
                                            r22 = 29907376961126
                                            r55 = r3(r47, r22)
                                            ReturnVal = r20[r55]
                                            r20 = r11
                                            state[ReturnVal] = r20
                                            r11 = nil
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure4 entry 2281866 -> 99, states 99-99
                                    if state == 99 then -- entry 2281866 -> 99
                                        r11 = args[1]
                                        r3 = "getgenv"
                                        r20 = _env[r3]
                                        r3 = r20()
                                        r55 = upvalueValues[upvalues[1]]
                                        r47 = upvalueValues[upvalues[2]]
                                        r15 = 19014738403990
                                        r21 = "\005\226,~f\028\007\225"
                                        r22 = r47(r21, r15)
                                        r20 = r55[r22]
                                        ReturnVal = r3[r20]
                                        r3 = upvalueValues[upvalues[1]]
                                        r55 = upvalueValues[upvalues[2]]
                                        r21 = 345534447776
                                        r22 = "\255E\132\206\153\155YG"
                                        r47 = r55(r22, r21)
                                        r20 = r3[r47]
                                        state = ReturnVal[r20]
                                        r20 = upvalueValues[upvalues[1]]
                                        r3 = upvalueValues[upvalues[2]]
                                        r22 = 19284076684051
                                        r47 = "\020\213\186"
                                        r55 = r3(r47, r22)
                                        ReturnVal = r20[r55]
                                        r20 = r11
                                        r11 = nil
                                        state[ReturnVal] = r20
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            else
                                if state <= 101 then
                                    if state <= 100 then
                                        -- createClosure6 entry 9949443 -> 100, states 100-100
                                        if state == 100 then -- entry 9949443 -> 100
                                            r11 = args[1]
                                            r3 = "getgenv"
                                            r20 = _env[r3]
                                            r3 = r20()
                                            r55 = upvalueValues[upvalues[1]]
                                            r47 = upvalueValues[upvalues[2]]
                                            r15 = 8220042137331
                                            r21 = "\014\025\\\213\005w\154\020"
                                            r22 = r47(r21, r15)
                                            r20 = r55[r22]
                                            ReturnVal = r3[r20]
                                            r3 = upvalueValues[upvalues[1]]
                                            r55 = upvalueValues[upvalues[2]]
                                            r22 = "\017\146\174\204\162\228\200`"
                                            r21 = 10586815025985
                                            r47 = r55(r22, r21)
                                            r20 = r3[r47]
                                            state = ReturnVal[r20]
                                            r20 = upvalueValues[upvalues[1]]
                                            r3 = upvalueValues[upvalues[2]]
                                            r22 = 24670651919584
                                            r47 = "V\193MG\154\204\144\170\246\202\223"
                                            r55 = r3(r47, r22)
                                            ReturnVal = r20[r55]
                                            r20 = r11
                                            r11 = nil
                                            state[ReturnVal] = r20
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    else
                                        -- createClosure3 entry 8256363 -> 101, states 101-101
                                        if state == 101 then -- entry 8256363 -> 101
                                            r3 = "getgenv"
                                            r20 = _env[r3]
                                            r11 = args[1]
                                            r3 = r20()
                                            r55 = upvalueValues[upvalues[1]]
                                            r47 = upvalueValues[upvalues[2]]
                                            r21 = "CH\"f\151n\178\225"
                                            r15 = 22804267116923
                                            r22 = r47(r21, r15)
                                            r20 = r55[r22]
                                            ReturnVal = r3[r20]
                                            r3 = upvalueValues[upvalues[1]]
                                            r55 = upvalueValues[upvalues[2]]
                                            r21 = 26637827764340
                                            r22 = "\194\190\2164cx\139`"
                                            r47 = r55(r22, r21)
                                            r20 = r3[r47]
                                            state = ReturnVal[r20]
                                            r20 = upvalueValues[upvalues[1]]
                                            r3 = upvalueValues[upvalues[2]]
                                            r22 = 32326278462157
                                            r47 = "\152\153tv\220"
                                            r55 = r3(r47, r22)
                                            ReturnVal = r20[r55]
                                            r20 = r11
                                            r11 = nil
                                            state[ReturnVal] = r20
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure3 entry 9048400 -> 102, states 102-102
                                    if state == 102 then -- entry 9048400 -> 102
                                        ReturnVal = "loadstring"
                                        state = _env[ReturnVal]
                                        r20 = "game"
                                        r11 = _env[r20]
                                        r55 = upvalueValues[upvalues[1]]
                                        r47 = upvalueValues[upvalues[2]]
                                        r15 = 6812673231972
                                        r21 = "\205\008\165\153\031\246\001\231\183;$\211Q\191\170\197^\192\163\191\181\016\253\174\195\219T\141yV\137\155\2239\026\131\233\006\142\008\200\201\008\213\209*A\207\249pJ\030\199\184\137\182\154o\243\"\004\192\134\191\159d\223\016\198\020\131\133"
                                        r22 = r47(r21, r15)
                                        r3 = r55[r22]
                                        r55 = "HttpGet"
                                        r55 = r11[r55]
                                        r20 = {
                                            r55(r11, r3)
                                        }
                                        ReturnVal = state(unpack(r20))
                                        state = ReturnVal()
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            end
                        end
                    end
                else
                    if state <= 126 then
                        if state <= 110 then
                            if state <= 107 then
                                if state <= 106 then
                                    if state <= 103 then
                                        -- createClosure5 entry 278187 -> 103, states 103-103
                                        if state == 103 then -- entry 278187 -> 103
                                            r11 = args[1]
                                            ReturnVal = "getgenv"
                                            state = _env[ReturnVal]
                                            ReturnVal = state()
                                            r20 = upvalueValues[upvalues[1]]
                                            r3 = upvalueValues[upvalues[2]]
                                            r22 = 7548214857146
                                            r47 = "\245r\170\219\153\192\r\150\153\218*'\214!W"
                                            r55 = r3(r47, r22)
                                            state = r20[r55]
                                            r47 = "tonumber"
                                            r55 = _env[r47]
                                            r47 = r55(r11)
                                            r55 = 0.16574
                                            r20 = r47 or r55
                                            ReturnVal[state] = r20
                                            r3 = state
                                            r11 = nil
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    else
                                        -- createClosure4 entry 12503955 -> 104, states 104-106
                                        if state <= 105 then
                                            if state <= 104 then
                                                if state == 104 then -- entry 12503955 -> 104
                                                    r11 = "game"
                                                    ReturnVal = _env[r11]
                                                    r11 = "IsLoaded"
                                                    r11 = ReturnVal[r11]
                                                    r11 = r11(ReturnVal)
                                                    state = not r11
                                                    state = state and (105) or (106)
                                                end
                                            else
                                                if state == 105 then
                                                    r11 = "game"
                                                    ReturnVal = _env[r11]
                                                    r20 = upvalueValues[upvalues[1]]
                                                    r3 = upvalueValues[upvalues[2]]
                                                    r22 = 22613007575330
                                                    r47 = "\nq\1828\173\209"
                                                    r55 = r3(r47, r22)
                                                    r11 = r20[r55]
                                                    state = ReturnVal[r11]
                                                    ReturnVal = "Wait"
                                                    ReturnVal = state[ReturnVal]
                                                    ReturnVal = ReturnVal(state)
                                                    state = 106
                                                end
                                            end
                                        else
                                            if state == 106 then
                                                r11 = "game"
                                                ReturnVal = _env[r11]
                                                r20 = upvalueValues[upvalues[1]]
                                                r3 = upvalueValues[upvalues[2]]
                                                r47 = "\208\238\166"
                                                r22 = 11788039411057
                                                r55 = r3(r47, r22)
                                                r11 = r20[r55]
                                                r20 = allocUpvalue()
                                                state = ReturnVal[r11]
                                                r11 = allocUpvalue()
                                                r47 = createClosure7(162, {
                                                    r11,
                                                    upvalues[1],
                                                    upvalues[2],
                                                    r20
                                                })
                                                upvalueValues[r11] = state
                                                r11 = releaseUpvalue(r11)
                                                state = nil
                                                upvalueValues[r20] = state
                                                ReturnVal = "setreadonly"
                                                state = _env[ReturnVal]
                                                r55 = "game"
                                                r3 = _env[r55]
                                                r55 = false
                                                ReturnVal = state(r3, r55, r47)
                                                upvalueValues[r20] = ReturnVal
                                                r20 = releaseUpvalue(r20)
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    -- createClosure2 entry 7671512 -> 107, states 107-107
                                    if state == 107 then -- entry 7671512 -> 107
                                        ReturnVal = "loadstring"
                                        state = _env[ReturnVal]
                                        r20 = "game"
                                        r11 = _env[r20]
                                        r55 = upvalueValues[upvalues[1]]
                                        r47 = upvalueValues[upvalues[2]]
                                        r21 = "\2354\188kZ\242\149M\179N\005b\167p\n\247\157\155\254\197\168Z\144x\230\148\231\237%y\233\194\176\184`X\132\000c.m\189'\021\169\003\204\199s\217_\2241S\253\132\148\194\158i\179I\241X\199\165q\159\197\007\214\181\023R\165* J\\v\029"
                                        r15 = 13315934722104
                                        r22 = r47(r21, r15)
                                        r3 = r55[r22]
                                        r55 = "HttpGet"
                                        r55 = r11[r55]
                                        r20 = {
                                            r55(r11, r3)
                                        }
                                        ReturnVal = state(unpack(r20))
                                        state = ReturnVal()
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            else
                                if state <= 109 then
                                    if state <= 108 then
                                        -- createClosure6 entry 1884811 -> 108, states 108-108
                                        if state == 108 then -- entry 1884811 -> 108
                                            r11 = allocUpvalue()
                                            upvalueValues[r11] = args[1]
                                            state = upvalueValues[upvalues[1]]
                                            ReturnVal = upvalueValues[r11]
                                            r55 = upvalueValues[upvalues[2]]
                                            r47 = upvalueValues[upvalues[3]]
                                            r21 = "\000\208,\220\252\151\155"
                                            r15 = 15614522580071
                                            r22 = r47(r21, r15)
                                            r3 = r55[r22]
                                            r47 = upvalueValues[upvalues[2]]
                                            r22 = upvalueValues[upvalues[3]]
                                            r43 = 7515161775531
                                            r15 = "\015\001\207\2265\031\030\190\227\242"
                                            r21 = r22(r15, r43)
                                            r55 = r47[r21]
                                            r22 = upvalueValues[upvalues[2]]
                                            r21 = upvalueValues[upvalues[3]]
                                            r17 = 3258811024877
                                            r43 = "K31G\014\027\158>%\189"
                                            r15 = r21(r43, r17)
                                            r47 = r22[r15]
                                            r15 = upvalueValues[upvalues[2]]
                                            r43 = upvalueValues[upvalues[3]]
                                            r40 = 34629260984061
                                            r36 = "cdS\\P\001\205\147F"
                                            r17 = r43(r36, r40)
                                            r21 = r15[r17]
                                            r22 = 0.18
                                            r15 = true
                                            r20 = {
                                                [r3] = r55,
                                                [r47] = r22,
                                                [r21] = r15
                                            }
                                            state[ReturnVal] = r20
                                            r3 = createClosure3(169, {
                                                r11
                                            })
                                            state = upvalueValues[upvalues[4]]
                                            ReturnVal = "AddButton"
                                            ReturnVal = state[ReturnVal]
                                            r20 = upvalueValues[r11]
                                            ReturnVal = ReturnVal(state, r20, r3)
                                            r11 = releaseUpvalue(r11)
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    else
                                        -- createClosure5 entry 10798525 -> 109, states 109-109
                                        if state == 109 then -- entry 10798525 -> 109
                                            state = upvalueValues[upvalues[1]]
                                            r20 = upvalueValues[upvalues[2]]
                                            r3 = upvalueValues[upvalues[3]]
                                            r47 = "\027\226\0296\153\199yHI\132"
                                            r22 = 16573595655
                                            r55 = r3(r47, r22)
                                            r11 = r20[r55]
                                            ReturnVal = state(r11)
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure5 entry 9191054 -> 110, states 110-110
                                    if state == 110 then -- entry 9191054 -> 110
                                        r43 = "l\169\186"
                                        r21 = 7412495994235
                                        r11 = "Drawing"
                                        ReturnVal = _env[r11]
                                        r47 = "Y{\239"
                                        r20 = upvalueValues[upvalues[1]]
                                        r3 = upvalueValues[upvalues[2]]
                                        r22 = 12959140992914
                                        r55 = r3(r47, r22)
                                        r17 = 34262985670226
                                        r11 = r20[r55]
                                        state = ReturnVal[r11]
                                        r20 = upvalueValues[upvalues[1]]
                                        r3 = upvalueValues[upvalues[2]]
                                        r47 = "\211\151S\154\226\172"
                                        r22 = 22192424364126
                                        r55 = r3(r47, r22)
                                        r11 = r20[r55]
                                        ReturnVal = state(r11)
                                        r11 = allocUpvalue()
                                        upvalueValues[r11] = ReturnVal
                                        r20 = "workspace"
                                        ReturnVal = _env[r20]
                                        r3 = upvalueValues[upvalues[1]]
                                        r55 = upvalueValues[upvalues[2]]
                                        r22 = "\250\188 \136\180\021\017\195\028\185/{]"
                                        r47 = r55(r22, r21)
                                        r20 = r3[r47]
                                        r21 = 17093164785431
                                        state = ReturnVal[r20]
                                        r20 = allocUpvalue()
                                        upvalueValues[r20] = state
                                        state = upvalueValues[r11]
                                        r3 = upvalueValues[upvalues[1]]
                                        r55 = upvalueValues[upvalues[2]]
                                        r22 = "\138\241\238\\\192\028e\004"
                                        r47 = r55(r22, r21)
                                        ReturnVal = r3[r47]
                                        r47 = "Vector2"
                                        r55 = _env[r47]
                                        r22 = upvalueValues[upvalues[1]]
                                        r21 = upvalueValues[upvalues[2]]
                                        r15 = r21(r43, r17)
                                        r47 = r22[r15]
                                        r3 = r55[r47]
                                        r15 = upvalueValues[r20]
                                        r17 = upvalueValues[upvalues[1]]
                                        r36 = upvalueValues[upvalues[2]]
                                        r34 = 20728430716340
                                        r41 = "\166gd\178\007\212\144\148+\228\199\135"
                                        r40 = r36(r41, r34)
                                        r43 = r17[r40]
                                        r21 = r15[r43]
                                        r43 = upvalueValues[upvalues[1]]
                                        r17 = upvalueValues[upvalues[2]]
                                        r41 = 29885321705052
                                        r40 = "8"
                                        r36 = r17(r40, r41)
                                        r15 = r43[r36]
                                        r22 = r21[r15]
                                        r21 = 2
                                        r47 = r22 / r21
                                        r43 = upvalueValues[r20]
                                        r36 = upvalueValues[upvalues[1]]
                                        r40 = upvalueValues[upvalues[2]]
                                        r27 = 32782904458145
                                        r34 = "u\148W}\028r1#\205\237/\153"
                                        r41 = r40(r34, r27)
                                        r17 = r36[r41]
                                        r15 = r43[r17]
                                        r17 = upvalueValues[upvalues[1]]
                                        r36 = upvalueValues[upvalues[2]]
                                        r34 = 1158581207579
                                        r41 = "V"
                                        r40 = r36(r41, r34)
                                        r43 = r17[r40]
                                        r21 = r15[r43]
                                        r15 = 2
                                        r22 = r21 / r15
                                        r55 = r3(r47, r22)
                                        r47 = "game"
                                        r17 = "\191\028\021=_\185\190\210\027|"
                                        state[ReturnVal] = r55
                                        state = createClosure2(170, {
                                            upvalues[1],
                                            upvalues[2],
                                            r20,
                                            r11
                                        })
                                        r3 = allocUpvalue()
                                        upvalueValues[r3] = state
                                        r55 = allocUpvalue()
                                        state = nil
                                        upvalueValues[r55] = state
                                        ReturnVal = _env[r47]
                                        r47 = "GetService"
                                        r21 = upvalueValues[upvalues[1]]
                                        r15 = upvalueValues[upvalues[2]]
                                        r36 = 24534129945760
                                        r43 = r15(r17, r36)
                                        r22 = r21[r43]
                                        r43 = "A\236\160w\190\207\201:0\r?\172}"
                                        r47 = ReturnVal[r47]
                                        r47 = r47(ReturnVal, r22)
                                        r17 = 2788088005906
                                        r22 = upvalueValues[upvalues[1]]
                                        r21 = upvalueValues[upvalues[2]]
                                        r15 = r21(r43, r17)
                                        ReturnVal = r22[r15]
                                        state = r47[ReturnVal]
                                        r47 = createClosure4(188, {
                                            r3,
                                            r55,
                                            r11,
                                            upvalues[1],
                                            upvalues[2]
                                        })
                                        r17 = 9595347226996
                                        ReturnVal = "Connect"
                                        ReturnVal = state[ReturnVal]
                                        ReturnVal = ReturnVal(state, r47)
                                        ReturnVal = "getrawmetatable"
                                        state = _env[ReturnVal]
                                        r22 = "game"
                                        r47 = _env[r22]
                                        ReturnVal = state(r47)
                                        r22 = upvalueValues[upvalues[1]]
                                        r47 = ReturnVal
                                        r21 = upvalueValues[upvalues[2]]
                                        r43 = "\012\003E]\207\192\0078\019\210"
                                        r15 = r21(r43, r17)
                                        ReturnVal = r22[r15]
                                        state = r47[ReturnVal]
                                        r22 = allocUpvalue()
                                        r21 = false
                                        upvalueValues[r22] = state
                                        ReturnVal = "setreadonly"
                                        state = _env[ReturnVal]
                                        ReturnVal = state(r47, r21)
                                        r17 = "m\135j\012\181w27\031\130"
                                        state = createClosure(189, {
                                            upvalues[1],
                                            upvalues[2],
                                            r55,
                                            r22
                                        })
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r15 = upvalueValues[upvalues[2]]
                                        r36 = 3496357234268
                                        r43 = r15(r17, r36)
                                        r21 = state
                                        state = ReturnVal[r43]
                                        r15 = "newcclosure"
                                        ReturnVal = _env[r15]
                                        r15 = ReturnVal(r21)
                                        r47[state] = r15
                                        state = createClosure3(200, {
                                            upvalues[1],
                                            upvalues[2],
                                            r11
                                        })
                                        r15 = state
                                        r43 = "Instance"
                                        ReturnVal = _env[r43]
                                        r17 = upvalueValues[upvalues[1]]
                                        r36 = upvalueValues[upvalues[2]]
                                        r34 = 8679204966345
                                        r41 = "`\223#"
                                        r40 = r36(r41, r34)
                                        r43 = r17[r40]
                                        state = ReturnVal[r43]
                                        r17 = upvalueValues[upvalues[1]]
                                        r36 = upvalueValues[upvalues[2]]
                                        r41 = "f.\203\228"
                                        r34 = 29999282140817
                                        r40 = r36(r41, r34)
                                        r43 = r17[r40]
                                        ReturnVal = state(r43)
                                        r43 = ReturnVal
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r17 = upvalueValues[upvalues[2]]
                                        r40 = "y\180G\159"
                                        r41 = 15159705852819
                                        r36 = r17(r40, r41)
                                        state = ReturnVal[r36]
                                        r17 = upvalueValues[upvalues[1]]
                                        r11 = releaseUpvalue(r11)
                                        r36 = upvalueValues[upvalues[2]]
                                        r34 = 32988157099009
                                        r41 = "\149Q\161^\197\217\1695\171\202\145i\r"
                                        r40 = r36(r41, r34)
                                        ReturnVal = r17[r40]
                                        r22 = releaseUpvalue(r22)
                                        r43[state] = ReturnVal
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r17 = upvalueValues[upvalues[2]]
                                        r40 = "\223:\175[S\224i!\147*N'\207\180"
                                        r41 = 13437083392113
                                        r36 = r17(r40, r41)
                                        state = ReturnVal[r36]
                                        ReturnVal = false
                                        r43[state] = ReturnVal
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r17 = upvalueValues[upvalues[2]]
                                        r41 = 22856621320595
                                        r40 = "\180\145x\226e\030"
                                        r36 = r17(r40, r41)
                                        state = ReturnVal[r36]
                                        r40 = "game"
                                        r36 = _env[r40]
                                        r34 = upvalueValues[upvalues[1]]
                                        r27 = upvalueValues[upvalues[2]]
                                        r51 = 22732780808537
                                        r50 = "\030\023Z>1\220\232"
                                        r56 = r27(r50, r51)
                                        r40 = "GetService"
                                        r40 = r36[r40]
                                        r41 = r34[r56]
                                        r40 = r40(r36, r41)
                                        r41 = upvalueValues[upvalues[1]]
                                        r34 = upvalueValues[upvalues[2]]
                                        r50 = 23032430619109
                                        r56 = "c\001\008\137\219\024\189J0_\183"
                                        r27 = r34(r56, r50)
                                        r36 = r41[r27]
                                        r17 = r40[r36]
                                        r40 = upvalueValues[upvalues[1]]
                                        r55 = releaseUpvalue(r55)
                                        r41 = upvalueValues[upvalues[2]]
                                        r3 = releaseUpvalue(r3)
                                        r27 = "\239\204\027\003\157\148b\159"
                                        r56 = 16714726415975
                                        r34 = r41(r27, r56)
                                        r36 = r40[r34]
                                        ReturnVal = r17[r36]
                                        r43[state] = ReturnVal
                                        r17 = "Instance"
                                        ReturnVal = _env[r17]
                                        r36 = upvalueValues[upvalues[1]]
                                        r40 = upvalueValues[upvalues[2]]
                                        r34 = "p\210\022"
                                        r27 = 2600301659322
                                        r41 = r40(r34, r27)
                                        r17 = r36[r41]
                                        state = ReturnVal[r17]
                                        r20 = releaseUpvalue(r20)
                                        r36 = upvalueValues[upvalues[1]]
                                        r40 = upvalueValues[upvalues[2]]
                                        r34 = "\129\1772\189g5\127\133t\128\198g9"
                                        r27 = 17143844003631
                                        r41 = r40(r34, r27)
                                        r17 = r36[r41]
                                        ReturnVal = state(r17)
                                        r17 = ReturnVal
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r36 = upvalueValues[upvalues[2]]
                                        r34 = 17483618918349
                                        r41 = "\178\213\015Q\251q"
                                        r40 = r36(r41, r34)
                                        state = ReturnVal[r40]
                                        ReturnVal = r43
                                        r17[state] = ReturnVal
                                        r27 = 23915772930944
                                        r34 = "\020\138\246M\142':\147"
                                        r36 = upvalueValues[upvalues[1]]
                                        r40 = upvalueValues[upvalues[2]]
                                        r47 = nil
                                        r41 = r40(r34, r27)
                                        ReturnVal = r36[r41]
                                        state = r43[ReturnVal]
                                        ReturnVal = "Connect"
                                        ReturnVal = state[ReturnVal]
                                        ReturnVal = ReturnVal(state, r15)
                                        r34 = "\241T\219Y\213I\142\020\222<"
                                        r27 = 21640494311261
                                        r21 = nil
                                        r36 = upvalueValues[upvalues[1]]
                                        r40 = upvalueValues[upvalues[2]]
                                        r41 = r40(r34, r27)
                                        ReturnVal = r36[r41]
                                        r43 = nil
                                        state = r17[ReturnVal]
                                        ReturnVal = "Connect"
                                        ReturnVal = state[ReturnVal]
                                        r17 = nil
                                        ReturnVal = ReturnVal(state, r15)
                                        r15 = nil
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            end
                        else
                            if state <= 119 then
                                if state <= 116 then
                                    if state <= 113 then
                                        -- createClosure6 entry 6383646 -> 111, states 111-113
                                        if state <= 112 then
                                            if state <= 111 then
                                                if state == 111 then -- entry 6383646 -> 111
                                                    r11 = args[1]
                                                    r20 = "getgenv"
                                                    ReturnVal = _env[r20]
                                                    r20 = ReturnVal()
                                                    r3 = upvalueValues[upvalues[1]]
                                                    r55 = upvalueValues[upvalues[2]]
                                                    r22 = "\235\160\255\176O$5g\172'E\235\143\252\016\025H\000\211"
                                                    r21 = 4079432746859
                                                    r47 = r55(r22, r21)
                                                    ReturnVal = r3[r47]
                                                    state = r20[ReturnVal]
                                                    r20 = upvalueValues[upvalues[1]]
                                                    r3 = upvalueValues[upvalues[2]]
                                                    r22 = 20239156339920
                                                    r47 = "8\006\011\214\019\201\173\177"
                                                    r55 = r3(r47, r22)
                                                    ReturnVal = r20[r55]
                                                    r47 = "tonumber"
                                                    r55 = _env[r47]
                                                    r47 = r55(r11)
                                                    r3 = state
                                                    state = r47 and (112) or (113)
                                                    r20 = r47
                                                end
                                            else
                                                if state == 112 then
                                                    state = r3
                                                    r11 = nil
                                                    state[ReturnVal] = r20
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state == 113 then
                                                r21 = "getgenv"
                                                r22 = _env[r21]
                                                r21 = r22()
                                                r15 = upvalueValues[upvalues[1]]
                                                r43 = upvalueValues[upvalues[2]]
                                                r36 = "j\1447\190\142\250\2475S\179\183\r\218\149_E\209\232U"
                                                r40 = 10655445734241
                                                r17 = r43(r36, r40)
                                                r22 = r15[r17]
                                                r47 = r21[r22]
                                                r21 = upvalueValues[upvalues[1]]
                                                r15 = upvalueValues[upvalues[2]]
                                                r36 = 8777222508535
                                                r17 = "\020\131zy)\154\192%"
                                                r43 = r15(r17, r36)
                                                r22 = r21[r43]
                                                r55 = r47[r22]
                                                r20 = r55
                                                state = 112
                                            end
                                        end
                                    else
                                        -- createClosure4 entry 8822925 -> 114, states 114-116
                                        if state <= 115 then
                                            if state <= 114 then
                                                if state == 114 then -- entry 8822925 -> 114
                                                    r20 = "getgenv"
                                                    ReturnVal = _env[r20]
                                                    r11 = args[1]
                                                    r20 = ReturnVal()
                                                    r3 = upvalueValues[upvalues[1]]
                                                    r55 = upvalueValues[upvalues[2]]
                                                    r22 = "\204g\163H\1333\019\242\004\130\164y\255\173\140\129%\152p"
                                                    r21 = 17418630504367
                                                    r47 = r55(r22, r21)
                                                    ReturnVal = r3[r47]
                                                    state = r20[ReturnVal]
                                                    r20 = upvalueValues[upvalues[1]]
                                                    r3 = upvalueValues[upvalues[2]]
                                                    r22 = 23113020238346
                                                    r47 = "0/\174H\001_\133\026\025\211"
                                                    r55 = r3(r47, r22)
                                                    ReturnVal = r20[r55]
                                                    r47 = "tonumber"
                                                    r55 = _env[r47]
                                                    r47 = r55(r11)
                                                    r3 = state
                                                    state = r47 and (115) or (116)
                                                    r20 = r47
                                                end
                                            else
                                                if state == 115 then
                                                    r11 = nil
                                                    state = r3
                                                    state[ReturnVal] = r20
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state == 116 then
                                                r21 = "getgenv"
                                                r22 = _env[r21]
                                                r21 = r22()
                                                r15 = upvalueValues[upvalues[1]]
                                                r43 = upvalueValues[upvalues[2]]
                                                r40 = 4443282704405
                                                r36 = "\147\172\169\195\248\253\156\020\186\r\182\233c\185L\219\245d\238"
                                                r17 = r43(r36, r40)
                                                r22 = r15[r17]
                                                r47 = r21[r22]
                                                r21 = upvalueValues[upvalues[1]]
                                                r15 = upvalueValues[upvalues[2]]
                                                r36 = 15029824740182
                                                r17 = "q\231x\206\192\135?\001Zz"
                                                r43 = r15(r17, r36)
                                                r22 = r21[r43]
                                                r55 = r47[r22]
                                                r20 = r55
                                                state = 115
                                            end
                                        end
                                    end
                                else
                                    -- createClosure5 entry 8144625 -> 117, states 117-119
                                    if state <= 118 then
                                        if state <= 117 then
                                            if state == 117 then -- entry 8144625 -> 117
                                                r11 = args[1]
                                                r20 = "getgenv"
                                                ReturnVal = _env[r20]
                                                r20 = ReturnVal()
                                                r3 = upvalueValues[upvalues[1]]
                                                r55 = upvalueValues[upvalues[2]]
                                                r22 = "\225\139\149\132\2296;_s\135\210\007\155\244y\175\143\212\166i\145Q\022*\245M,:\015\t\183"
                                                r21 = 24507226533012
                                                r47 = r55(r22, r21)
                                                ReturnVal = r3[r47]
                                                state = r20[ReturnVal]
                                                r20 = upvalueValues[upvalues[1]]
                                                r3 = upvalueValues[upvalues[2]]
                                                r22 = 12361240450684
                                                r47 = "D{\160@"
                                                r55 = r3(r47, r22)
                                                ReturnVal = r20[r55]
                                                r47 = "tonumber"
                                                r55 = _env[r47]
                                                r47 = r55(r11)
                                                r3 = state
                                                state = r47 and (118) or (119)
                                                r20 = r47
                                            end
                                        else
                                            if state == 118 then
                                                state = r3
                                                r11 = nil
                                                state[ReturnVal] = r20
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    else
                                        if state == 119 then
                                            r21 = "getgenv"
                                            r22 = _env[r21]
                                            r21 = r22()
                                            r15 = upvalueValues[upvalues[1]]
                                            r43 = upvalueValues[upvalues[2]]
                                            r36 = "\239\0088\1289\150\202 \211\156\144\174\142\025\\0\211+\188c\133\020=\221\180\156G\195\148\160t"
                                            r40 = 8682752659403
                                            r17 = r43(r36, r40)
                                            r22 = r15[r17]
                                            r47 = r21[r22]
                                            r21 = upvalueValues[upvalues[1]]
                                            r15 = upvalueValues[upvalues[2]]
                                            r17 = "RG\249\008"
                                            r36 = 19322136568613
                                            r43 = r15(r17, r36)
                                            r22 = r21[r43]
                                            r55 = r47[r22]
                                            r20 = r55
                                            state = 118
                                        end
                                    end
                                end
                            else
                                if state <= 123 then
                                    if state <= 120 then
                                        -- createClosure4 entry 15368453 -> 120, states 120-120
                                        if state == 120 then -- entry 15368453 -> 120
                                            r20 = "getgenv"
                                            ReturnVal = _env[r20]
                                            r11 = args[1]
                                            r20 = ReturnVal()
                                            r3 = upvalueValues[upvalues[1]]
                                            r55 = upvalueValues[upvalues[2]]
                                            r22 = "\229\255\216\006\167=\1504\015;r\161\245^\171\184\168\029:"
                                            r21 = 31907921951242
                                            r47 = r55(r22, r21)
                                            ReturnVal = r3[r47]
                                            state = r20[ReturnVal]
                                            r20 = upvalueValues[upvalues[1]]
                                            r3 = upvalueValues[upvalues[2]]
                                            r47 = "\029I\003p\208i\192J\"\127"
                                            r22 = 31819620121057
                                            r55 = r3(r47, r22)
                                            ReturnVal = r20[r55]
                                            r20 = r11
                                            state[ReturnVal] = r20
                                            r11 = nil
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    else
                                        -- createClosure2 entry 3233411 -> 121, states 121-123
                                        if state <= 122 then
                                            if state <= 121 then
                                                if state == 121 then -- entry 3233411 -> 121
                                                    r11 = args[1]
                                                    r20 = "getgenv"
                                                    ReturnVal = _env[r20]
                                                    r20 = ReturnVal()
                                                    r3 = upvalueValues[upvalues[1]]
                                                    r55 = upvalueValues[upvalues[2]]
                                                    r21 = 14207168764375
                                                    r22 = "YSY\133\138'\214\2321n%\225\164X\232\2051\175\028\244\014\242\222\129S3`\251in\217"
                                                    r47 = r55(r22, r21)
                                                    ReturnVal = r3[r47]
                                                    state = r20[ReturnVal]
                                                    r20 = upvalueValues[upvalues[1]]
                                                    r3 = upvalueValues[upvalues[2]]
                                                    r47 = "\249TG\026\000\004\148"
                                                    r22 = 20551020946785
                                                    r55 = r3(r47, r22)
                                                    ReturnVal = r20[r55]
                                                    r47 = "tonumber"
                                                    r55 = _env[r47]
                                                    r47 = r55(r11)
                                                    r3 = state
                                                    state = r47 and (122) or (123)
                                                    r20 = r47
                                                end
                                            else
                                                if state == 122 then
                                                    state = r3
                                                    state[ReturnVal] = r20
                                                    r11 = nil
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state == 123 then
                                                r21 = "getgenv"
                                                r22 = _env[r21]
                                                r21 = r22()
                                                r15 = upvalueValues[upvalues[1]]
                                                r43 = upvalueValues[upvalues[2]]
                                                r40 = 24207244717064
                                                r36 = "\182X\196\006\206=\203\012,]\132a:\187\003-\156p;\r\1898\001\161\144\219\224 \175\239\133"
                                                r17 = r43(r36, r40)
                                                r22 = r15[r17]
                                                r47 = r21[r22]
                                                r21 = upvalueValues[upvalues[1]]
                                                r15 = upvalueValues[upvalues[2]]
                                                r17 = "\023\1520\184)6\027"
                                                r36 = 32661768321897
                                                r43 = r15(r17, r36)
                                                r22 = r21[r43]
                                                r55 = r47[r22]
                                                r20 = r55
                                                state = 122
                                            end
                                        end
                                    end
                                else
                                    -- createClosure5 entry 5558535 -> 124, states 124-126
                                    if state <= 125 then
                                        if state <= 124 then
                                            if state == 124 then -- entry 5558535 -> 124
                                                r20 = "getgenv"
                                                ReturnVal = _env[r20]
                                                r20 = ReturnVal()
                                                r3 = upvalueValues[upvalues[1]]
                                                r11 = args[1]
                                                r55 = upvalueValues[upvalues[2]]
                                                r21 = 9262028951768
                                                r22 = "-\177(\244\r\254\245\168&\021\023(\173Q\212|^\t\170\139B\216\132\195\224:]VQ\155."
                                                r47 = r55(r22, r21)
                                                ReturnVal = r3[r47]
                                                state = r20[ReturnVal]
                                                r20 = upvalueValues[upvalues[1]]
                                                r3 = upvalueValues[upvalues[2]]
                                                r22 = 8132841950923
                                                r47 = "\202\248k\235"
                                                r55 = r3(r47, r22)
                                                ReturnVal = r20[r55]
                                                r47 = "tonumber"
                                                r55 = _env[r47]
                                                r47 = r55(r11)
                                                r3 = state
                                                state = r47 and (125) or (126)
                                                r20 = r47
                                            end
                                        else
                                            if state == 125 then
                                                state = r3
                                                state[ReturnVal] = r20
                                                r11 = nil
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    else
                                        if state == 126 then
                                            r21 = "getgenv"
                                            r22 = _env[r21]
                                            r21 = r22()
                                            r15 = upvalueValues[upvalues[1]]
                                            r43 = upvalueValues[upvalues[2]]
                                            r40 = 33407676202180
                                            r36 = "\127\r\008&z\142L\184t\012\220R\128j\234G\218R|\127\133\201\193}\254\150\130RD3K"
                                            r17 = r43(r36, r40)
                                            r22 = r15[r17]
                                            r47 = r21[r22]
                                            r21 = upvalueValues[upvalues[1]]
                                            r15 = upvalueValues[upvalues[2]]
                                            r36 = 30887935342639
                                            r17 = "-L\2465"
                                            r43 = r15(r17, r36)
                                            r22 = r21[r43]
                                            r55 = r47[r22]
                                            r20 = r55
                                            state = 125
                                        end
                                    end
                                end
                            end
                        end
                    else
                        if state <= 161 then
                            if state <= 146 then
                                if state <= 128 then
                                    if state <= 127 then
                                        -- createClosure2 entry 806796 -> 127, states 127-127
                                        if state == 127 then -- entry 806796 -> 127
                                            r11 = args[1]
                                            ReturnVal = "print"
                                            state = _env[ReturnVal]
                                            r3 = upvalueValues[upvalues[1]]
                                            r55 = upvalueValues[upvalues[2]]
                                            r22 = "\206\198t\028\219\153-}"
                                            r21 = 11452459177172
                                            r47 = r55(r22, r21)
                                            r20 = r3[r47]
                                            ReturnVal = state(r20)
                                            ReturnVal = "loadstring"
                                            state = _env[ReturnVal]
                                            r3 = "game"
                                            r20 = _env[r3]
                                            r47 = upvalueValues[upvalues[1]]
                                            r22 = upvalueValues[upvalues[2]]
                                            r15 = "\143\219\149\\\015f\234\217\227\027\223z-\230\145P]\203^/\027+\240-A&hoi\180\174\024\218\193\253\008vZ\162\192\131\150\192\167x\161\239u\170\160$j\139F\018\156w\202\rT"
                                            r43 = 13122193741790
                                            r21 = r22(r15, r43)
                                            r55 = r47[r21]
                                            r11 = nil
                                            r47 = "HttpGet"
                                            r47 = r20[r47]
                                            r3 = {
                                                r47(r20, r55)
                                            }
                                            ReturnVal = state(unpack(r3))
                                            state = ReturnVal()
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    else
                                        -- createClosure2 entry 8381075 -> 128, states 128-128
                                        if state == 128 then -- entry 8381075 -> 128
                                            r20 = "9vZ4"
                                            r3 = 2856473
                                            r11 = r20 ^ r3
                                            ReturnVal = 9561357
                                            state = ReturnVal - r11
                                            r11 = state
                                            ReturnVal = "sfZgWWZYZoRu6wa"
                                            state = ReturnVal / r11
                                            ReturnVal = {
                                                state
                                            }
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure0 entry 13441848 -> 129, states 129-146
                                    if state <= 137 then
                                        if state <= 133 then
                                            if state <= 131 then
                                                if state <= 130 then
                                                    if state <= 129 then
                                                        if state == 129 then -- entry 13441848 -> 129
                                                            r11 = "math"
                                                            ReturnVal = _env[r11]
                                                            r20 = upvalueValues[upvalues[1]]
                                                            r3 = upvalueValues[upvalues[2]]
                                                            r22 = 17041631715071
                                                            r47 = "\206[T\205"
                                                            r55 = r3(r47, r22)
                                                            r11 = r20[r55]
                                                            state = ReturnVal[r11]
                                                            r11 = state
                                                            r20 = "Vector2"
                                                            ReturnVal = _env[r20]
                                                            r3 = upvalueValues[upvalues[1]]
                                                            r55 = upvalueValues[upvalues[2]]
                                                            r21 = 6543727004647
                                                            r22 = "\134\255&"
                                                            r47 = r55(r22, r21)
                                                            r20 = r3[r47]
                                                            state = ReturnVal[r20]
                                                            r47 = "game"
                                                            r55 = _env[r47]
                                                            r21 = upvalueValues[upvalues[1]]
                                                            r15 = upvalueValues[upvalues[2]]
                                                            r47 = "GetService"
                                                            r47 = r55[r47]
                                                            r36 = 28267002999658
                                                            r17 = "DkH\253\204(\194\240\017{"
                                                            r43 = r15(r17, r36)
                                                            r22 = r21[r43]
                                                            r47 = r47(r55, r22)
                                                            r55 = "GetScreenResolution"
                                                            r55 = r47[r55]
                                                            r55 = r55(r47)
                                                            r22 = upvalueValues[upvalues[1]]
                                                            r21 = upvalueValues[upvalues[2]]
                                                            r17 = 761259573602
                                                            r43 = "\193"
                                                            r15 = r21(r43, r17)
                                                            r47 = r22[r15]
                                                            r3 = r55[r47]
                                                            r55 = 2
                                                            r20 = r3 / r55
                                                            r22 = "game"
                                                            r47 = _env[r22]
                                                            r15 = upvalueValues[upvalues[1]]
                                                            r43 = upvalueValues[upvalues[2]]
                                                            r40 = 9751524233660
                                                            r36 = "\134\173\233#\180\158\137<\177\220"
                                                            r17 = r43(r36, r40)
                                                            r22 = "GetService"
                                                            r22 = r47[r22]
                                                            r21 = r15[r17]
                                                            r22 = r22(r47, r21)
                                                            r47 = "GetScreenResolution"
                                                            r47 = r22[r47]
                                                            r47 = r47(r22)
                                                            r21 = upvalueValues[upvalues[1]]
                                                            r15 = upvalueValues[upvalues[2]]
                                                            r36 = 30103001921217
                                                            r17 = "F"
                                                            r43 = r15(r17, r36)
                                                            r22 = r21[r43]
                                                            r55 = r47[r22]
                                                            r47 = 2
                                                            r3 = r55 / r47
                                                            ReturnVal = state(r20, r3)
                                                            r20 = ReturnVal
                                                            ReturnVal = "ipairs"
                                                            state = _env[ReturnVal]
                                                            r22 = "game"
                                                            r47 = _env[r22]
                                                            r15 = upvalueValues[upvalues[1]]
                                                            r43 = upvalueValues[upvalues[2]]
                                                            r36 = "\203A?|\196n\215"
                                                            r40 = 6472773962694
                                                            r17 = r43(r36, r40)
                                                            r21 = r15[r17]
                                                            r22 = "GetService"
                                                            r22 = r47[r22]
                                                            r22 = r22(r47, r21)
                                                            r21 = "GetPlayers"
                                                            r21 = r22[r21]
                                                            r47 = {
                                                                r21(r22)
                                                            }
                                                            r22 = {
                                                                state(unpack(r47))
                                                            }
                                                            ReturnVal = r22[1]
                                                            r3 = r22[2]
                                                            r55 = r22[3]
                                                            state = nil
                                                            r22 = state
                                                            r47 = ReturnVal
                                                            state = 130
                                                        end
                                                    else
                                                        if state == 130 then
                                                            state = true
                                                            state = state and (131) or (132)
                                                        end
                                                    end
                                                else
                                                    if state == 131 then
                                                        state = nil
                                                        r21 = state
                                                        r15 = {
                                                            r47(r3, r55)
                                                        }
                                                        state = r15[1]
                                                        ReturnVal = r15[2]
                                                        r55 = state
                                                        r43 = nil
                                                        r15 = r55 == r43
                                                        state = r15 and (133) or (134)
                                                        r21 = ReturnVal
                                                    end
                                                end
                                            else
                                                if state <= 132 then
                                                    if state == 132 then
                                                        ReturnVal = {
                                                            r22
                                                        }
                                                        state = nil
                                                    end
                                                else
                                                    if state == 133 then
                                                        r21 = nil
                                                        state = 132
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 135 then
                                                if state <= 134 then
                                                    if state == 134 then
                                                        r43 = upvalueValues[upvalues[3]]
                                                        r15 = r21 ~= r43
                                                        state = r15 and (135) or (136)
                                                    end
                                                else
                                                    if state == 135 then
                                                        r17 = upvalueValues[upvalues[1]]
                                                        r36 = upvalueValues[upvalues[2]]
                                                        r34 = 22449288194261
                                                        r41 = "\153\232\020;P\022\252\181\221"
                                                        r40 = r36(r41, r34)
                                                        r43 = r17[r40]
                                                        r15 = r21[r43]
                                                        r17 = state
                                                        state = r15 and (137) or (138)
                                                        r43 = r15
                                                    end
                                                end
                                            else
                                                if state <= 136 then
                                                    if state == 136 then
                                                        r21 = nil
                                                        state = 130
                                                    end
                                                else
                                                    if state == 137 then
                                                        r40 = state
                                                        r27 = upvalueValues[upvalues[1]]
                                                        r56 = upvalueValues[upvalues[2]]
                                                        r51 = ")!\187\003\nT\189\024\207\007\172\175h\175\2194"
                                                        r16 = 3910447318812
                                                        r50 = r56(r51, r16)
                                                        r41 = "FindFirstChild"
                                                        r41 = r15[r41]
                                                        r34 = r27[r50]
                                                        r41 = r41(r15, r34)
                                                        state = r41 and (139) or (140)
                                                        r36 = r41
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 142 then
                                            if state <= 140 then
                                                if state <= 139 then
                                                    if state <= 138 then
                                                        if state == 138 then
                                                            state = r17
                                                            state = r43 and (141) or (142)
                                                        end
                                                    else
                                                        if state == 139 then
                                                            r50 = upvalueValues[upvalues[1]]
                                                            r51 = upvalueValues[upvalues[2]]
                                                            r35 = "\169L\221\170\165\230\007\019"
                                                            r10 = 11003415843843
                                                            r16 = r51(r35, r10)
                                                            r56 = r50[r16]
                                                            r27 = r15[r56]
                                                            r50 = upvalueValues[upvalues[1]]
                                                            r51 = upvalueValues[upvalues[2]]
                                                            r10 = 32565876308796
                                                            r35 = "k\160C\162\231\225"
                                                            r16 = r51(r35, r10)
                                                            r56 = r50[r16]
                                                            r34 = r27[r56]
                                                            r27 = 0
                                                            r41 = r34 > r27
                                                            r36 = r41
                                                            state = 140
                                                        end
                                                    end
                                                else
                                                    if state == 140 then
                                                        state = r40
                                                        r43 = r36
                                                        state = 138
                                                    end
                                                end
                                            else
                                                if state <= 141 then
                                                    if state == 141 then
                                                        r36 = "game"
                                                        r17 = _env[r36]
                                                        r41 = upvalueValues[upvalues[1]]
                                                        r34 = upvalueValues[upvalues[2]]
                                                        r50 = 29875412006487
                                                        r56 = "\134\203\236\175n\174*\130M"
                                                        r27 = r34(r56, r50)
                                                        r36 = "GetService"
                                                        r36 = r17[r36]
                                                        r40 = r41[r27]
                                                        r36 = r36(r17, r40)
                                                        r40 = upvalueValues[upvalues[1]]
                                                        r41 = upvalueValues[upvalues[2]]
                                                        r27 = "6\251\231\251\133\006\030\194A'\223\184>"
                                                        r56 = 20148532929702
                                                        r34 = r41(r27, r56)
                                                        r17 = r40[r34]
                                                        r43 = r36[r17]
                                                        r27 = upvalueValues[upvalues[1]]
                                                        r56 = upvalueValues[upvalues[2]]
                                                        r16 = 16266131266966
                                                        r51 = "*E\175\229,Yb\140\139\136\026\231\171\022\014q"
                                                        r50 = r56(r51, r16)
                                                        r34 = r27[r50]
                                                        r41 = r15[r34]
                                                        r27 = upvalueValues[upvalues[1]]
                                                        r56 = upvalueValues[upvalues[2]]
                                                        r16 = 27617533538876
                                                        r51 = "\012\151\236\189W2WA"
                                                        r50 = r56(r51, r16)
                                                        r34 = r27[r50]
                                                        r40 = r41[r34]
                                                        r41 = "WorldToViewportPoint"
                                                        r41 = r43[r41]
                                                        r41 = {
                                                            r41(r43, r40)
                                                        }
                                                        r36 = r41[2]
                                                        state = r36 and (143) or (144)
                                                        r17 = r41[1]
                                                    end
                                                else
                                                    if state == 142 then
                                                        r15 = nil
                                                        state = 136
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 144 then
                                                if state <= 143 then
                                                    if state == 143 then
                                                        r27 = "Vector2"
                                                        r34 = _env[r27]
                                                        r56 = upvalueValues[upvalues[1]]
                                                        r50 = upvalueValues[upvalues[2]]
                                                        r35 = 16368953728454
                                                        r16 = "z\169\160"
                                                        r51 = r50(r16, r35)
                                                        r27 = r56[r51]
                                                        r41 = r34[r27]
                                                        r50 = upvalueValues[upvalues[1]]
                                                        r51 = upvalueValues[upvalues[2]]
                                                        r35 = "f"
                                                        r10 = 19246200513282
                                                        r16 = r51(r35, r10)
                                                        r56 = r50[r16]
                                                        r27 = r17[r56]
                                                        r51 = upvalueValues[upvalues[1]]
                                                        r16 = upvalueValues[upvalues[2]]
                                                        r10 = "\220"
                                                        r6 = 11605677872412
                                                        r35 = r16(r10, r6)
                                                        r50 = r51[r35]
                                                        r56 = r17[r50]
                                                        r34 = r41(r27, r56)
                                                        r40 = r20 - r34
                                                        r34 = upvalueValues[upvalues[1]]
                                                        r27 = upvalueValues[upvalues[2]]
                                                        r51 = 28470883513289
                                                        r50 = "D:;\2554^l\131j"
                                                        r56 = r27(r50, r51)
                                                        r41 = r34[r56]
                                                        r43 = r40[r41]
                                                        r40 = r43 < r11
                                                        state = r40 and (145) or (146)
                                                    end
                                                else
                                                    if state == 144 then
                                                        r17 = nil
                                                        r36 = nil
                                                        state = 142
                                                    end
                                                end
                                            else
                                                if state <= 145 then
                                                    if state == 145 then
                                                        r34 = upvalueValues[upvalues[1]]
                                                        r27 = upvalueValues[upvalues[2]]
                                                        r51 = 33546823138565
                                                        r50 = "lzB\193\162\255\2340\171;\158\008\003@t\t"
                                                        r56 = r27(r50, r51)
                                                        r41 = r34[r56]
                                                        r40 = r15[r41]
                                                        r41 = r43
                                                        r22 = r40
                                                        r11 = r41
                                                        state = 146
                                                    end
                                                else
                                                    if state == 146 then
                                                        r43 = nil
                                                        state = 144
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 157 then
                                    if state <= 151 then
                                        -- createClosure0 entry 15589331 -> 147, states 147-151
                                        if state <= 149 then
                                            if state <= 148 then
                                                if state <= 147 then
                                                    if state == 147 then -- entry 15589331 -> 147
                                                        r11 = upvalueValues[upvalues[1]]
                                                        state = r11 and (148) or (149)
                                                        ReturnVal = r11
                                                    end
                                                else
                                                    if state == 148 then
                                                        r11 = upvalueValues[upvalues[2]]
                                                        ReturnVal = r11
                                                        state = 149
                                                    end
                                                end
                                            else
                                                if state == 149 then
                                                    state = ReturnVal and (150) or (151)
                                                end
                                            end
                                        else
                                            if state <= 150 then
                                                if state == 150 then
                                                    r11 = "workspace"
                                                    ReturnVal = _env[r11]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r3 = upvalueValues[upvalues[4]]
                                                    r22 = 13185598593020
                                                    r47 = "\203\187\230\005\191G\156S\206..\153H"
                                                    r55 = r3(r47, r22)
                                                    r11 = r20[r55]
                                                    state = ReturnVal[r11]
                                                    r20 = upvalueValues[upvalues[2]]
                                                    r11 = state
                                                    r55 = upvalueValues[upvalues[3]]
                                                    r47 = upvalueValues[upvalues[4]]
                                                    r15 = 29828901140034
                                                    r21 = "(\142B0\165\185W\191"
                                                    r22 = r47(r21, r15)
                                                    r3 = r55[r22]
                                                    ReturnVal = r20[r3]
                                                    r55 = upvalueValues[upvalues[2]]
                                                    r22 = upvalueValues[upvalues[3]]
                                                    r21 = upvalueValues[upvalues[4]]
                                                    r43 = "\023\005\"\216\023\244b\233"
                                                    r17 = 12624500709110
                                                    r15 = r21(r43, r17)
                                                    r47 = r22[r15]
                                                    r3 = r55[r47]
                                                    r55 = upvalueValues[upvalues[5]]
                                                    r20 = r3 * r55
                                                    state = ReturnVal + r20
                                                    r3 = "Vector3"
                                                    ReturnVal = _env[r3]
                                                    r55 = upvalueValues[upvalues[3]]
                                                    r47 = upvalueValues[upvalues[4]]
                                                    r20 = state
                                                    r21 = "[\193\137"
                                                    r15 = 10225851503257
                                                    r22 = r47(r21, r15)
                                                    r3 = r55[r22]
                                                    state = ReturnVal[r3]
                                                    r22 = upvalueValues[upvalues[3]]
                                                    r21 = upvalueValues[upvalues[4]]
                                                    r17 = 6829193464940
                                                    r43 = "3"
                                                    r15 = r21(r43, r17)
                                                    r47 = r22[r15]
                                                    r55 = r20[r47]
                                                    r47 = upvalueValues[upvalues[6]]
                                                    r3 = r55 + r47
                                                    r22 = upvalueValues[upvalues[3]]
                                                    r21 = upvalueValues[upvalues[4]]
                                                    r43 = "\141"
                                                    r17 = 28511145210844
                                                    r15 = r21(r43, r17)
                                                    r47 = r22[r15]
                                                    r55 = r20[r47]
                                                    r21 = upvalueValues[upvalues[3]]
                                                    r15 = upvalueValues[upvalues[4]]
                                                    r36 = 9283018150114
                                                    r17 = "\156"
                                                    r43 = r15(r17, r36)
                                                    r22 = r21[r43]
                                                    r47 = r20[r22]
                                                    ReturnVal = state(r3, r55, r47)
                                                    r47 = upvalueValues[upvalues[3]]
                                                    r3 = ReturnVal
                                                    r22 = upvalueValues[upvalues[4]]
                                                    r43 = 14258452748783
                                                    r15 = "\182mb0\153\131"
                                                    r21 = r22(r15, r43)
                                                    r55 = r47[r21]
                                                    ReturnVal = r11[r55]
                                                    r47 = upvalueValues[upvalues[3]]
                                                    r22 = upvalueValues[upvalues[4]]
                                                    r15 = "\135\209\016\160\133\224\196:"
                                                    r43 = 6062849673991
                                                    r21 = r22(r15, r43)
                                                    r55 = r47[r21]
                                                    state = ReturnVal[r55]
                                                    r47 = upvalueValues[upvalues[7]]
                                                    r22 = upvalueValues[upvalues[8]]
                                                    r55 = r47 * r22
                                                    ReturnVal = "Lerp"
                                                    ReturnVal = state[ReturnVal]
                                                    ReturnVal = ReturnVal(state, r3, r55)
                                                    r55 = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[3]]
                                                    r47 = upvalueValues[upvalues[4]]
                                                    r15 = 3658410854055
                                                    r21 = "\189\150\n!5\224"
                                                    r22 = r47(r21, r15)
                                                    state = ReturnVal[r22]
                                                    r22 = "CFrame"
                                                    r47 = _env[r22]
                                                    r21 = upvalueValues[upvalues[3]]
                                                    r15 = upvalueValues[upvalues[4]]
                                                    r17 = "'J."
                                                    r36 = 31300084463855
                                                    r43 = r15(r17, r36)
                                                    r22 = r21[r43]
                                                    ReturnVal = r47[r22]
                                                    r20 = nil
                                                    r47 = ReturnVal(r55, r3)
                                                    r11[state] = r47
                                                    r55 = nil
                                                    r3 = nil
                                                    r11 = nil
                                                    state = 151
                                                end
                                            else
                                                if state == 151 then
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        end
                                    else
                                        -- createClosure3 entry 12820328 -> 152, states 152-157
                                        if state <= 154 then
                                            if state <= 153 then
                                                if state <= 152 then
                                                    if state == 152 then -- entry 12820328 -> 152
                                                        r11 = args[1]
                                                        r3 = "getgenv"
                                                        r20 = _env[r3]
                                                        r3 = r20()
                                                        r55 = upvalueValues[upvalues[1]]
                                                        r47 = upvalueValues[upvalues[2]]
                                                        r15 = 31925413853714
                                                        r21 = "\r\165<"
                                                        r22 = r47(r21, r15)
                                                        r20 = r55[r22]
                                                        ReturnVal = r3[r20]
                                                        state = r11 == ReturnVal
                                                        state = state and (153) or (154)
                                                    end
                                                else
                                                    if state == 153 then
                                                        ReturnVal = upvalueValues[upvalues[3]]
                                                        state = not ReturnVal
                                                        upvalueValues[upvalues[3]] = state
                                                        ReturnVal = upvalueValues[upvalues[3]]
                                                        state = ReturnVal and (155) or (156)
                                                    end
                                                end
                                            else
                                                if state == 154 then
                                                    r11 = nil
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state <= 156 then
                                                if state <= 155 then
                                                    if state == 155 then
                                                        r20 = "FindNearestEnemy"
                                                        ReturnVal = _env[r20]
                                                        r20 = ReturnVal()
                                                        upvalueValues[upvalues[4]] = r20
                                                        state = 157
                                                    end
                                                else
                                                    if state == 156 then
                                                        ReturnVal = nil
                                                        upvalueValues[upvalues[4]] = ReturnVal
                                                        state = 157
                                                    end
                                                end
                                            else
                                                if state == 157 then
                                                    state = 154
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure3 entry 14439622 -> 158, states 158-161
                                    if state <= 159 then
                                        if state <= 158 then
                                            if state == 158 then -- entry 14439622 -> 158
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                state = not ReturnVal
                                                upvalueValues[upvalues[1]] = state
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                state = ReturnVal and (159) or (160)
                                            end
                                        else
                                            if state == 159 then
                                                ReturnVal = upvalueValues[upvalues[2]]
                                                r20 = upvalueValues[upvalues[3]]
                                                r3 = upvalueValues[upvalues[4]]
                                                r22 = 18289534771524
                                                r47 = "\019<+\142"
                                                r55 = r3(r47, r22)
                                                r11 = r20[r55]
                                                r3 = upvalueValues[upvalues[3]]
                                                r55 = upvalueValues[upvalues[4]]
                                                r21 = 16716150529640
                                                r22 = "0(\008f\208@\252\201\128\1630\200"
                                                r47 = r55(r22, r21)
                                                r20 = r3[r47]
                                                ReturnVal[r11] = r20
                                                ReturnVal = false
                                                upvalueValues[upvalues[5]] = ReturnVal
                                                r11 = nil
                                                upvalueValues[upvalues[6]] = r11
                                                state = 161
                                            end
                                        end
                                    else
                                        if state <= 160 then
                                            if state == 160 then
                                                r20 = upvalueValues[upvalues[2]]
                                                r55 = upvalueValues[upvalues[3]]
                                                r47 = upvalueValues[upvalues[4]]
                                                r21 = "\234b\029\223"
                                                r15 = 5622529591866
                                                r22 = r47(r21, r15)
                                                r3 = r55[r22]
                                                r47 = upvalueValues[upvalues[3]]
                                                r22 = upvalueValues[upvalues[4]]
                                                r15 = "M\214!w3MB\021\252\026\133"
                                                r43 = 14545184447093
                                                r21 = r22(r15, r43)
                                                r55 = r47[r21]
                                                r20[r3] = r55
                                                r20 = true
                                                upvalueValues[upvalues[5]] = r20
                                                r55 = "FindNearestEnemy"
                                                r3 = _env[r55]
                                                r55 = r3()
                                                upvalueValues[upvalues[6]] = r55
                                                state = 161
                                            end
                                        else
                                            if state == 161 then
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            if state <= 187 then
                                if state <= 169 then
                                    if state <= 168 then
                                        -- createClosure7 entry 12086676 -> 162, states 162-168
                                        if state <= 165 then
                                            if state <= 163 then
                                                if state <= 162 then
                                                    if state == 162 then -- entry 12086676 -> 162
                                                        r3 = args[3]
                                                        r11 = args[1]
                                                        r47 = "getcallingscript"
                                                        r55 = _env[r47]
                                                        r20 = args[2]
                                                        r47 = r55()
                                                        state = r47 and (163) or (164)
                                                        ReturnVal = r47
                                                    end
                                                else
                                                    if state == 163 then
                                                        state = ReturnVal and (165) or (166)
                                                    end
                                                end
                                            else
                                                if state <= 164 then
                                                    if state == 164 then
                                                        r47 = state
                                                        r21 = upvalueValues[upvalues[1]]
                                                        r17 = upvalueValues[upvalues[2]]
                                                        r36 = upvalueValues[upvalues[3]]
                                                        r41 = "nE\209\241\156Y\208\133"
                                                        r34 = 15794609904826
                                                        r40 = r36(r41, r34)
                                                        r43 = r17[r40]
                                                        r15 = r21(r11, r43)
                                                        r22 = not r15
                                                        state = r22 and (167) or (168)
                                                        r55 = r22
                                                    end
                                                else
                                                    if state == 165 then
                                                        state = upvalueValues[upvalues[4]]
                                                        ReturnVal = {
                                                            state(r11, r20, r3)
                                                        }
                                                        ReturnVal = {
                                                            unpack(ReturnVal)
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 167 then
                                                if state <= 166 then
                                                    if state == 166 then
                                                        r20 = nil
                                                        r11 = nil
                                                        r3 = nil
                                                        ReturnVal = {}
                                                        state = nil
                                                    end
                                                else
                                                    if state == 167 then
                                                        state = r47
                                                        ReturnVal = r55
                                                        state = 163
                                                    end
                                                end
                                            else
                                                if state == 168 then
                                                    r15 = upvalueValues[upvalues[2]]
                                                    r43 = upvalueValues[upvalues[3]]
                                                    r36 = "\127$\209S\023xn}\254"
                                                    r40 = 4134023792517
                                                    r17 = r43(r36, r40)
                                                    r21 = r15[r17]
                                                    r22 = r20 ~= r21
                                                    r55 = r22
                                                    state = 167
                                                end
                                            end
                                        end
                                    else
                                        -- createClosure3 entry 5202965 -> 169, states 169-169
                                        if state == 169 then -- entry 5202965 -> 169
                                            ReturnVal = "LoadConfig"
                                            state = _env[ReturnVal]
                                            r11 = upvalueValues[upvalues[1]]
                                            ReturnVal = state(r11)
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure2 entry 11146372 -> 170, states 170-187
                                    if state <= 178 then
                                        if state <= 174 then
                                            if state <= 172 then
                                                if state <= 171 then
                                                    if state <= 170 then
                                                        if state == 170 then -- entry 11146372 -> 170
                                                            ReturnVal = "game"
                                                            state = _env[ReturnVal]
                                                            r20 = upvalueValues[upvalues[1]]
                                                            r3 = upvalueValues[upvalues[2]]
                                                            ReturnVal = "GetService"
                                                            ReturnVal = state[ReturnVal]
                                                            r47 = "Q\221e6VL\198"
                                                            r22 = 2216111375367
                                                            r55 = r3(r47, r22)
                                                            r11 = r20[r55]
                                                            ReturnVal = ReturnVal(state, r11)
                                                            r11 = ReturnVal
                                                            r20 = upvalueValues[upvalues[1]]
                                                            r3 = upvalueValues[upvalues[2]]
                                                            r22 = 857343377807
                                                            r47 = "\187\226j\204~\189ci*\167\171"
                                                            r55 = r3(r47, r22)
                                                            ReturnVal = r20[r55]
                                                            state = r11[ReturnVal]
                                                            r20 = state
                                                            r3 = "math"
                                                            ReturnVal = _env[r3]
                                                            r55 = upvalueValues[upvalues[1]]
                                                            r47 = upvalueValues[upvalues[2]]
                                                            r15 = 603470086425
                                                            r21 = "\145\027S\159"
                                                            r22 = r47(r21, r15)
                                                            r3 = r55[r22]
                                                            state = ReturnVal[r3]
                                                            r3 = state
                                                            ReturnVal = "ipairs"
                                                            state = _env[ReturnVal]
                                                            r21 = "GetPlayers"
                                                            r21 = r11[r21]
                                                            r22 = {
                                                                r21(r11)
                                                            }
                                                            r21 = {
                                                                state(unpack(r22))
                                                            }
                                                            ReturnVal = r21[1]
                                                            r47 = r21[3]
                                                            r55 = r21[2]
                                                            state = nil
                                                            r21 = state
                                                            r22 = ReturnVal
                                                            state = 171
                                                        end
                                                    else
                                                        if state == 171 then
                                                            state = true
                                                            state = state and (172) or (173)
                                                        end
                                                    end
                                                else
                                                    if state == 172 then
                                                        state = nil
                                                        r15 = state
                                                        r43 = {
                                                            r22(r55, r47)
                                                        }
                                                        state = r43[1]
                                                        ReturnVal = r43[2]
                                                        r47 = state
                                                        r17 = nil
                                                        r43 = r47 == r17
                                                        state = r43 and (174) or (175)
                                                        r15 = ReturnVal
                                                    end
                                                end
                                            else
                                                if state <= 173 then
                                                    if state == 173 then
                                                        ReturnVal = {
                                                            r21
                                                        }
                                                        state = nil
                                                    end
                                                else
                                                    if state == 174 then
                                                        r15 = nil
                                                        state = 173
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 176 then
                                                if state <= 175 then
                                                    if state == 175 then
                                                        r36 = r15 ~= r20
                                                        r17 = state
                                                        state = r36 and (176) or (177)
                                                        r43 = r36
                                                    end
                                                else
                                                    if state == 176 then
                                                        r27 = upvalueValues[upvalues[1]]
                                                        r56 = upvalueValues[upvalues[2]]
                                                        r16 = 10076807598676
                                                        r51 = "\210\017\138\138\204\007\148\1443"
                                                        r50 = r56(r51, r16)
                                                        r34 = r27[r50]
                                                        r41 = r15[r34]
                                                        r40 = state
                                                        state = r41 and (178) or (179)
                                                        r36 = r41
                                                    end
                                                end
                                            else
                                                if state <= 177 then
                                                    if state == 177 then
                                                        state = r17
                                                        state = r43 and (180) or (181)
                                                    end
                                                else
                                                    if state == 178 then
                                                        r27 = upvalueValues[upvalues[1]]
                                                        r56 = upvalueValues[upvalues[2]]
                                                        r16 = 23400231086736
                                                        r51 = "W/\219N\151*\2150n"
                                                        r50 = r56(r51, r16)
                                                        r34 = r27[r50]
                                                        r41 = r15[r34]
                                                        r51 = "getgenv"
                                                        r50 = _env[r51]
                                                        r51 = r50()
                                                        r16 = upvalueValues[upvalues[1]]
                                                        r35 = upvalueValues[upvalues[2]]
                                                        r48 = 620043698464
                                                        r6 = "\211\024\219X\227\135o%|f\022~\001\234\016JD\207~"
                                                        r10 = r35(r6, r48)
                                                        r50 = r16[r10]
                                                        r56 = r51[r50]
                                                        r51 = upvalueValues[upvalues[1]]
                                                        r16 = upvalueValues[upvalues[2]]
                                                        r34 = "FindFirstChild"
                                                        r34 = r41[r34]
                                                        r6 = 26157545959316
                                                        r10 = "\171\153\239\192\211\184\146\151\209\015"
                                                        r35 = r16(r10, r6)
                                                        r50 = r51[r35]
                                                        r27 = r56[r50]
                                                        r34 = r34(r41, r27)
                                                        r36 = r34
                                                        state = 179
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 183 then
                                            if state <= 181 then
                                                if state <= 180 then
                                                    if state <= 179 then
                                                        if state == 179 then
                                                            state = r40
                                                            r43 = r36
                                                            state = 177
                                                        end
                                                    else
                                                        if state == 180 then
                                                            r43 = upvalueValues[upvalues[3]]
                                                            r56 = upvalueValues[upvalues[1]]
                                                            r50 = upvalueValues[upvalues[2]]
                                                            r16 = "\172^\182\226 $\011\028\215"
                                                            r35 = 21345561732819
                                                            r51 = r50(r16, r35)
                                                            r27 = r56[r51]
                                                            r34 = r15[r27]
                                                            r51 = "getgenv"
                                                            r50 = _env[r51]
                                                            r51 = r50()
                                                            r16 = upvalueValues[upvalues[1]]
                                                            r35 = upvalueValues[upvalues[2]]
                                                            r6 = "\026i\165\216~<4\000h\241\225H\251\234.f\192\2189"
                                                            r48 = 25307269230088
                                                            r10 = r35(r6, r48)
                                                            r50 = r16[r10]
                                                            r56 = r51[r50]
                                                            r51 = upvalueValues[upvalues[1]]
                                                            r16 = upvalueValues[upvalues[2]]
                                                            r10 = "I)L\233\017h\014\133b\231"
                                                            r6 = 19700438262741
                                                            r35 = r16(r10, r6)
                                                            r50 = r51[r35]
                                                            r27 = r56[r50]
                                                            r41 = r34[r27]
                                                            r27 = upvalueValues[upvalues[1]]
                                                            r56 = upvalueValues[upvalues[2]]
                                                            r16 = 6910787390610
                                                            r51 = "4/\150\202B=*\133"
                                                            r50 = r56(r51, r16)
                                                            r34 = r27[r50]
                                                            r40 = r41[r34]
                                                            r41 = "WorldToViewportPoint"
                                                            r41 = r43[r41]
                                                            r41 = {
                                                                r41(r43, r40)
                                                            }
                                                            r36 = r41[2]
                                                            state = r36 and (182) or (183)
                                                            r17 = r41[1]
                                                        end
                                                    end
                                                else
                                                    if state == 181 then
                                                        r15 = nil
                                                        state = 171
                                                    end
                                                end
                                            else
                                                if state <= 182 then
                                                    if state == 182 then
                                                        r34 = upvalueValues[upvalues[4]]
                                                        r56 = upvalueValues[upvalues[1]]
                                                        r50 = upvalueValues[upvalues[2]]
                                                        r35 = 6263578315620
                                                        r16 = "\129b\206\156G\031\166d"
                                                        r51 = r50(r16, r35)
                                                        r27 = r56[r51]
                                                        r41 = r34[r27]
                                                        r56 = "Vector2"
                                                        r27 = _env[r56]
                                                        r50 = upvalueValues[upvalues[1]]
                                                        r51 = upvalueValues[upvalues[2]]
                                                        r10 = 10385236923108
                                                        r35 = "\028\228\234"
                                                        r16 = r51(r35, r10)
                                                        r56 = r50[r16]
                                                        r34 = r27[r56]
                                                        r51 = upvalueValues[upvalues[1]]
                                                        r16 = upvalueValues[upvalues[2]]
                                                        r6 = 202088120414
                                                        r10 = "E"
                                                        r35 = r16(r10, r6)
                                                        r50 = r51[r35]
                                                        r56 = r17[r50]
                                                        r16 = upvalueValues[upvalues[1]]
                                                        r35 = upvalueValues[upvalues[2]]
                                                        r48 = 29216932754725
                                                        r6 = "c"
                                                        r10 = r35(r6, r48)
                                                        r51 = r16[r10]
                                                        r50 = r17[r51]
                                                        r27 = r34(r56, r50)
                                                        r40 = r41 - r27
                                                        r34 = upvalueValues[upvalues[1]]
                                                        r27 = upvalueValues[upvalues[2]]
                                                        r51 = 29286383826245
                                                        r50 = "`\236\254\192\247\143\020\016b"
                                                        r56 = r27(r50, r51)
                                                        r41 = r34[r56]
                                                        r43 = r40[r41]
                                                        r40 = r43 < r3
                                                        state = r40 and (184) or (185)
                                                    end
                                                else
                                                    if state == 183 then
                                                        r36 = nil
                                                        r17 = nil
                                                        state = 181
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 185 then
                                                if state <= 184 then
                                                    if state == 184 then
                                                        r34 = upvalueValues[upvalues[4]]
                                                        r56 = upvalueValues[upvalues[1]]
                                                        r50 = upvalueValues[upvalues[2]]
                                                        r16 = "\171\231\137\031\007\169"
                                                        r35 = 26414237659148
                                                        r51 = r50(r16, r35)
                                                        r27 = r56[r51]
                                                        r41 = r34[r27]
                                                        r40 = r43 <= r41
                                                        state = r40 and (186) or (187)
                                                    end
                                                else
                                                    if state == 185 then
                                                        r43 = nil
                                                        state = 183
                                                    end
                                                end
                                            else
                                                if state <= 186 then
                                                    if state == 186 then
                                                        r40 = r15
                                                        r41 = r43
                                                        r21 = r40
                                                        r3 = r41
                                                        state = 187
                                                    end
                                                else
                                                    if state == 187 then
                                                        state = 185
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 199 then
                                    if state <= 188 then
                                        -- createClosure4 entry 1823787 -> 188, states 188-188
                                        if state == 188 then -- entry 1823787 -> 188
                                            state = upvalueValues[upvalues[1]]
                                            ReturnVal = state()
                                            upvalueValues[upvalues[2]] = ReturnVal
                                            state = upvalueValues[upvalues[3]]
                                            r20 = upvalueValues[upvalues[4]]
                                            r3 = upvalueValues[upvalues[5]]
                                            r47 = "\255\147:\164\136"
                                            r22 = 16760371076732
                                            r55 = r3(r47, r22)
                                            r11 = r20[r55]
                                            r47 = "getgenv"
                                            r55 = _env[r47]
                                            r47 = r55()
                                            r22 = upvalueValues[upvalues[4]]
                                            r21 = upvalueValues[upvalues[5]]
                                            r17 = 34938514898829
                                            r43 = "\004\246\184+Gp\031\177\225Z*\179\002\193Io\012\219=-\223\240Cs\236\202\218\180\227\132k"
                                            r15 = r21(r43, r17)
                                            r55 = r22[r15]
                                            r3 = r47[r55]
                                            r47 = upvalueValues[upvalues[4]]
                                            r22 = upvalueValues[upvalues[5]]
                                            r43 = 29590346200531
                                            r15 = "\151\011\158\163\006"
                                            r21 = r22(r15, r43)
                                            r55 = r47[r21]
                                            r20 = r3[r55]
                                            state[r11] = r20
                                            state = upvalueValues[upvalues[3]]
                                            r20 = upvalueValues[upvalues[4]]
                                            r3 = upvalueValues[upvalues[5]]
                                            r47 = "D\24431FE\006"
                                            r22 = 29719512069647
                                            r55 = r3(r47, r22)
                                            r11 = r20[r55]
                                            r47 = "getgenv"
                                            r55 = _env[r47]
                                            r47 = r55()
                                            r22 = upvalueValues[upvalues[4]]
                                            r21 = upvalueValues[upvalues[5]]
                                            r43 = "\143+C\190\242u\003\190\201\027\169\217\021\140\162\161U;t\235\021)c!\004\171n\"\155\217\232"
                                            r17 = 21946567174123
                                            r15 = r21(r43, r17)
                                            r55 = r22[r15]
                                            r3 = r47[r55]
                                            r47 = upvalueValues[upvalues[4]]
                                            r22 = upvalueValues[upvalues[5]]
                                            r15 = "@h\208*.\004\161"
                                            r43 = 1818470089550
                                            r21 = r22(r15, r43)
                                            r55 = r47[r21]
                                            r20 = r3[r55]
                                            state[r11] = r20
                                            state = upvalueValues[upvalues[3]]
                                            r20 = upvalueValues[upvalues[4]]
                                            r3 = upvalueValues[upvalues[5]]
                                            r47 = "?%\030RqQ"
                                            r22 = 11628304766246
                                            r55 = r3(r47, r22)
                                            r11 = r20[r55]
                                            r47 = "getgenv"
                                            r55 = _env[r47]
                                            r47 = r55()
                                            r22 = upvalueValues[upvalues[4]]
                                            r21 = upvalueValues[upvalues[5]]
                                            r17 = 21025180739134
                                            r43 = "\203\142:\196X\022z\182\167\230\133l\2473\187\222\154\228\241\150 t\240\232\019\136wg\239\003\253"
                                            r15 = r21(r43, r17)
                                            r55 = r22[r15]
                                            r3 = r47[r55]
                                            r47 = upvalueValues[upvalues[4]]
                                            r22 = upvalueValues[upvalues[5]]
                                            r43 = 22546900822275
                                            r15 = "\2139\241\r"
                                            r21 = r22(r15, r43)
                                            r55 = r47[r21]
                                            r20 = r3[r55]
                                            state[r11] = r20
                                            state = upvalueValues[upvalues[3]]
                                            r20 = upvalueValues[upvalues[4]]
                                            r3 = upvalueValues[upvalues[5]]
                                            r22 = 6329254366083
                                            r47 = "\188r\016\2358z"
                                            r55 = r3(r47, r22)
                                            r11 = r20[r55]
                                            r47 = "getgenv"
                                            r55 = _env[r47]
                                            r47 = r55()
                                            r22 = upvalueValues[upvalues[4]]
                                            r21 = upvalueValues[upvalues[5]]
                                            r43 = "G\234\208,\004\160u{\212\170h\210@Y\018\133f\218\019\012\"\018M\141{:\216Z\018\011i"
                                            r17 = 18623713092064
                                            r15 = r21(r43, r17)
                                            r55 = r22[r15]
                                            r3 = r47[r55]
                                            r47 = upvalueValues[upvalues[4]]
                                            r22 = upvalueValues[upvalues[5]]
                                            r43 = 23705482029854
                                            r15 = "^j+\171"
                                            r21 = r22(r15, r43)
                                            r55 = r47[r21]
                                            r20 = r3[r55]
                                            state[r11] = r20
                                            state = upvalueValues[upvalues[3]]
                                            r20 = upvalueValues[upvalues[4]]
                                            r3 = upvalueValues[upvalues[5]]
                                            r22 = 8545365757835
                                            r47 = "\017\163u\154>JM\255@\147\173\240"
                                            r55 = r3(r47, r22)
                                            r11 = r20[r55]
                                            r47 = "getgenv"
                                            r55 = _env[r47]
                                            r47 = r55()
                                            r22 = upvalueValues[upvalues[4]]
                                            r21 = upvalueValues[upvalues[5]]
                                            r43 = "{\236\197 \027\159'\022&\246\191\238p;\001\181\150\131>mjR\196\174&\248P\197\198\225\007"
                                            r17 = 19481056469871
                                            r15 = r21(r43, r17)
                                            r55 = r22[r15]
                                            r3 = r47[r55]
                                            r47 = upvalueValues[upvalues[4]]
                                            r22 = upvalueValues[upvalues[5]]
                                            r43 = 24308952116279
                                            r15 = "|O\147\207\007F\204\130\164\200\1694"
                                            r21 = r22(r15, r43)
                                            r55 = r47[r21]
                                            r20 = r3[r55]
                                            state[r11] = r20
                                            state = upvalueValues[upvalues[3]]
                                            r20 = upvalueValues[upvalues[4]]
                                            r3 = upvalueValues[upvalues[5]]
                                            r22 = 18622173356511
                                            r47 = "\202\225*\220Pdc\162\238"
                                            r55 = r3(r47, r22)
                                            ReturnVal = {}
                                            r11 = r20[r55]
                                            r47 = "getgenv"
                                            r55 = _env[r47]
                                            r47 = r55()
                                            r22 = upvalueValues[upvalues[4]]
                                            r21 = upvalueValues[upvalues[5]]
                                            r17 = 7696915467776
                                            r43 = "\173\244\171E\248!\185\1712r\215\167x\236\128Sxc\208H\202\249(\\&s\008\173\015\174\031"
                                            r15 = r21(r43, r17)
                                            r55 = r22[r15]
                                            r3 = r47[r55]
                                            r47 = upvalueValues[upvalues[4]]
                                            r22 = upvalueValues[upvalues[5]]
                                            r43 = 24928995814744
                                            r15 = "t|\235\230F\171S\255\n"
                                            r21 = r22(r15, r43)
                                            r55 = r47[r21]
                                            r20 = r3[r55]
                                            state[r11] = r20
                                            state = nil
                                        end
                                    else
                                        -- createClosure entry 350303 -> 189, states 189-199
                                        if state <= 194 then
                                            if state <= 191 then
                                                if state <= 190 then
                                                    if state <= 189 then
                                                        if state == 189 then -- entry 350303 -> 189
                                                            r11 = {
                                                                select(1, unpack(args))
                                                            }
                                                            r21 = "getgenv"
                                                            r22 = _env[r21]
                                                            state = {
                                                                unpack(r11)
                                                            }
                                                            r21 = r22()
                                                            r15 = upvalueValues[upvalues[1]]
                                                            r43 = upvalueValues[upvalues[2]]
                                                            r36 = "\189\242W \026h\147\157E\182\193\1270S\247\000\254Z\244"
                                                            r40 = 29042477200595
                                                            r17 = r43(r36, r40)
                                                            r22 = r15[r17]
                                                            r47 = r21[r22]
                                                            r21 = upvalueValues[upvalues[1]]
                                                            r15 = upvalueValues[upvalues[2]]
                                                            r36 = 15051892939617
                                                            r17 = "|\246yS\136\236+\133"
                                                            r43 = r15(r17, r36)
                                                            r22 = r21[r43]
                                                            r55 = r47[r22]
                                                            r3 = not r55
                                                            r20 = state
                                                            state = r3 and (190) or (191)
                                                            ReturnVal = r3
                                                        end
                                                    else
                                                        if state == 190 then
                                                            state = ReturnVal and (192) or (193)
                                                        end
                                                    end
                                                else
                                                    if state == 191 then
                                                        r55 = state
                                                        r22 = upvalueValues[upvalues[3]]
                                                        r21 = nil
                                                        r47 = r22 == r21
                                                        state = r47 and (194) or (195)
                                                        r3 = r47
                                                    end
                                                end
                                            else
                                                if state <= 193 then
                                                    if state <= 192 then
                                                        if state == 192 then
                                                            state = upvalueValues[upvalues[4]]
                                                            ReturnVal = {
                                                                state(unpack(r11))
                                                            }
                                                            ReturnVal = {
                                                                unpack(ReturnVal)
                                                            }
                                                            state = nil
                                                        end
                                                    else
                                                        if state == 193 then
                                                            r22 = upvalueValues[upvalues[3]]
                                                            r15 = upvalueValues[upvalues[1]]
                                                            r43 = upvalueValues[upvalues[2]]
                                                            r36 = "E.\245\209\224D\171\251~"
                                                            r40 = 4496650307629
                                                            r17 = r43(r36, r40)
                                                            r21 = r15[r17]
                                                            r47 = r22[r21]
                                                            r43 = "getgenv"
                                                            r15 = _env[r43]
                                                            r43 = r15()
                                                            r17 = upvalueValues[upvalues[1]]
                                                            r36 = upvalueValues[upvalues[2]]
                                                            r41 = "\254\027\005|\191\023XS\150\155a@\014U\143\164p\164 "
                                                            r34 = 970980622788
                                                            r40 = r36(r41, r34)
                                                            r15 = r17[r40]
                                                            r21 = r43[r15]
                                                            r43 = upvalueValues[upvalues[1]]
                                                            r17 = upvalueValues[upvalues[2]]
                                                            r41 = 15348031921130
                                                            r40 = "\016R\254\140UB'\004\226\029"
                                                            r36 = r17(r40, r41)
                                                            r15 = r43[r36]
                                                            r22 = r21[r15]
                                                            r55 = r47[r22]
                                                            r22 = upvalueValues[upvalues[1]]
                                                            r21 = upvalueValues[upvalues[2]]
                                                            r17 = 33783034133875
                                                            r43 = "\146\128\187\029\008\164a\220"
                                                            r15 = r21(r43, r17)
                                                            r47 = r22[r15]
                                                            r3 = r55[r47]
                                                            r15 = upvalueValues[upvalues[3]]
                                                            r17 = upvalueValues[upvalues[1]]
                                                            r36 = upvalueValues[upvalues[2]]
                                                            r41 = "\211-\221\155\147Tm\153\159"
                                                            r34 = 27385218281936
                                                            r40 = r36(r41, r34)
                                                            r43 = r17[r40]
                                                            r21 = r15[r43]
                                                            r36 = "getgenv"
                                                            r17 = _env[r36]
                                                            r36 = r17()
                                                            r40 = upvalueValues[upvalues[1]]
                                                            r41 = upvalueValues[upvalues[2]]
                                                            r27 = "\024\177\172Y\159\216Lp\181\130\183\227j\249\243hF\006\167"
                                                            r56 = 4697789761675
                                                            r34 = r41(r27, r56)
                                                            r17 = r40[r34]
                                                            r43 = r36[r17]
                                                            r36 = upvalueValues[upvalues[1]]
                                                            r40 = upvalueValues[upvalues[2]]
                                                            r34 = "\214\229<\016\129\252j)\225g"
                                                            r27 = 1386750034565
                                                            r41 = r40(r34, r27)
                                                            r17 = r36[r41]
                                                            r15 = r43[r17]
                                                            r22 = r21[r15]
                                                            r15 = upvalueValues[upvalues[1]]
                                                            r43 = upvalueValues[upvalues[2]]
                                                            r40 = 8961217269836
                                                            r36 = "[r\160W\214^\153\246"
                                                            r17 = r43(r36, r40)
                                                            r21 = r15[r17]
                                                            r47 = r22[r21]
                                                            r43 = "getgenv"
                                                            r15 = _env[r43]
                                                            r43 = r15()
                                                            r17 = upvalueValues[upvalues[1]]
                                                            r36 = upvalueValues[upvalues[2]]
                                                            r34 = 4451932555289
                                                            r41 = "\213\177\200U^\240\136,\004B\202+\137\179\245\167\240w\249"
                                                            r40 = r36(r41, r34)
                                                            r15 = r17[r40]
                                                            r21 = r43[r15]
                                                            r43 = upvalueValues[upvalues[1]]
                                                            r17 = upvalueValues[upvalues[2]]
                                                            r41 = 30977096235096
                                                            r40 = "\189\144\241\242\179\018\162\n\213\176"
                                                            r36 = r17(r40, r41)
                                                            r15 = r43[r36]
                                                            r22 = r21[r15]
                                                            r55 = r47 * r22
                                                            ReturnVal = r3 + r55
                                                            state = 3
                                                            r20[state] = ReturnVal
                                                            state = upvalueValues[upvalues[4]]
                                                            r55 = "unpack"
                                                            r3 = _env[r55]
                                                            r55 = {
                                                                r3(r20)
                                                            }
                                                            ReturnVal = {
                                                                state(unpack(r55))
                                                            }
                                                            ReturnVal = {
                                                                unpack(ReturnVal)
                                                            }
                                                            state = nil
                                                        end
                                                    end
                                                else
                                                    if state == 194 then
                                                        state = r55
                                                        ReturnVal = r3
                                                        state = 190
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 197 then
                                                if state <= 196 then
                                                    if state <= 195 then
                                                        if state == 195 then
                                                            r43 = upvalueValues[upvalues[3]]
                                                            r36 = upvalueValues[upvalues[1]]
                                                            r40 = upvalueValues[upvalues[2]]
                                                            r27 = 29295785489737
                                                            r34 = "r\246\162\181I\239\181~\218"
                                                            r41 = r40(r34, r27)
                                                            r17 = r36[r41]
                                                            r15 = r43[r17]
                                                            r21 = not r15
                                                            r22 = state
                                                            state = r21 and (196) or (197)
                                                            r47 = r21
                                                        end
                                                    else
                                                        if state == 196 then
                                                            state = r22
                                                            r3 = r47
                                                            state = 194
                                                        end
                                                    end
                                                else
                                                    if state == 197 then
                                                        r15 = state
                                                        r36 = "getnamecallmethod"
                                                        r17 = _env[r36]
                                                        r36 = r17()
                                                        r40 = upvalueValues[upvalues[1]]
                                                        r41 = upvalueValues[upvalues[2]]
                                                        r27 = "\127\215MaOhe\145\019%"
                                                        r56 = 768892502374
                                                        r34 = r41(r27, r56)
                                                        r17 = r40[r34]
                                                        r43 = r36 ~= r17
                                                        state = r43 and (198) or (199)
                                                        r21 = r43
                                                    end
                                                end
                                            else
                                                if state <= 198 then
                                                    if state == 198 then
                                                        state = r15
                                                        r47 = r21
                                                        state = 196
                                                    end
                                                else
                                                    if state == 199 then
                                                        r36 = 2
                                                        r17 = r20[r36]
                                                        r40 = upvalueValues[upvalues[1]]
                                                        r41 = upvalueValues[upvalues[2]]
                                                        r56 = 21315471271621
                                                        r27 = "\169-~\205!<\204\031E\156\243\138\157\232"
                                                        r34 = r41(r27, r56)
                                                        r36 = r40[r34]
                                                        r43 = r17 ~= r36
                                                        r21 = r43
                                                        state = 198
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure3 entry 2256562 -> 200, states 200-200
                                    if state == 200 then -- entry 2256562 -> 200
                                        r11 = "getgenv"
                                        ReturnVal = _env[r11]
                                        r11 = ReturnVal()
                                        r20 = upvalueValues[upvalues[1]]
                                        r3 = upvalueValues[upvalues[2]]
                                        r47 = "\186\031B\132\011D\243\005!\218\028\171\008\153(X*^."
                                        r22 = 26398499729412
                                        r55 = r3(r47, r22)
                                        ReturnVal = r20[r55]
                                        state = r11[ReturnVal]
                                        r11 = upvalueValues[upvalues[1]]
                                        r20 = upvalueValues[upvalues[2]]
                                        r47 = 32795566324647
                                        r55 = "\195U\146.lg1\197"
                                        r3 = r20(r55, r47)
                                        ReturnVal = r11[r3]
                                        r47 = "getgenv"
                                        r55 = _env[r47]
                                        r47 = r55()
                                        r22 = upvalueValues[upvalues[1]]
                                        r21 = upvalueValues[upvalues[2]]
                                        r43 = "\1455\208=p\212\249\135\234\007\031\248C5\170\235\242\019\167"
                                        r17 = 15124662000514
                                        r15 = r21(r43, r17)
                                        r55 = r22[r15]
                                        r3 = r47[r55]
                                        r47 = upvalueValues[upvalues[1]]
                                        r22 = upvalueValues[upvalues[2]]
                                        r43 = 12239308379715
                                        r15 = "\178X\228\165\176d[s"
                                        r21 = r22(r15, r43)
                                        r55 = r47[r21]
                                        r20 = r3[r55]
                                        r11 = not r20
                                        state[ReturnVal] = r11
                                        state = upvalueValues[upvalues[3]]
                                        r11 = upvalueValues[upvalues[1]]
                                        r20 = upvalueValues[upvalues[2]]
                                        r47 = 20158095041706
                                        r55 = "\148J\006p\2480B"
                                        r3 = r20(r55, r47)
                                        ReturnVal = r11[r3]
                                        r55 = "getgenv"
                                        r3 = _env[r55]
                                        r55 = r3()
                                        r47 = upvalueValues[upvalues[1]]
                                        r22 = upvalueValues[upvalues[2]]
                                        r43 = 21453916382982
                                        r15 = "$#l\158\026\192t\152h\215%\015\242\150\193\198\242\008\203"
                                        r21 = r22(r15, r43)
                                        r3 = r47[r21]
                                        r20 = r55[r3]
                                        r55 = upvalueValues[upvalues[1]]
                                        r47 = upvalueValues[upvalues[2]]
                                        r15 = 30863021471779
                                        r21 = "U\211\147\213\\\172\003\027"
                                        r22 = r47(r21, r15)
                                        r3 = r55[r22]
                                        r11 = r20[r3]
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
        createClosure0 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function()
                return vm(entryId, {}, captures, gcProxy)
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
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
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
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if upvalueRefCounts[upvalueId] == 0 then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)