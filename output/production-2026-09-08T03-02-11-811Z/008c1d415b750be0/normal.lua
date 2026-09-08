return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, upvalueRefCounts, allocUpvalue, createClosure4, createUpvalueProxy, createClosure5, createClosure3, createClosure, createClosure1, createClosure0, releaseUpvalue, createClosure2, upvalueValues, releaseUpvalues, currentUpvalueId, vm)
        createClosure = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(...)
                return vm(entryId, {
                    ...
                }, captures, gcProxy)
            end
            return closure
        end
        allocUpvalue = function()
            currentUpvalueId = currentUpvalueId + (1)
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
                    return -2433453
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -2433453
                    end
                })
            end
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
        createClosure0 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function()
                return vm(entryId, {}, captures, gcProxy)
            end
            return closure
        end
        upvalueValues = {}
        currentUpvalueId = 0
        vm = function(state, args, upvalues, gcProxy)
            
            local r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, ReturnVal, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86, r87, r88, r89, r90, r91, r92, r93, r94, r95, r96, r97, r98, r99
            while state do
                if state <= 56 then
                    if state <= 34 then
                        if state <= 32 then
                            if state <= 31 then
                                -- root entry 10007141 -> 1, states 1-31
                                if state <= 16 then
                                    if state <= 8 then
                                        if state <= 4 then
                                            if state <= 2 then
                                                if state <= 1 then
                                                    if state == 1 then -- entry 10007141 -> 1
                                                        r4 = allocUpvalue()
                                                        r40 = allocUpvalue()
                                                        state = true
                                                        upvalueValues[r40] = state
                                                        r68 = "string"
                                                        ReturnVal = _env[r68]
                                                        r68 = "gmatch"
                                                        state = ReturnVal[r68]
                                                        r68 = allocUpvalue()
                                                        r98 = allocUpvalue()
                                                        upvalueValues[r68] = state
                                                        r82 = createClosure0(32, {
                                                            r98
                                                        })
                                                        state = createClosure3(33, {})
                                                        upvalueValues[r4] = state
                                                        state = false
                                                        upvalueValues[r98] = state
                                                        r48 = "pcall"
                                                        r20 = _env[r48]
                                                        r48 = r20(r82)
                                                        state = r48 and (2) or (3)
                                                        r55 = args
                                                        ReturnVal = r48
                                                    end
                                                else
                                                    if state == 2 then
                                                        r20 = upvalueValues[r98]
                                                        ReturnVal = r20
                                                        state = 3
                                                    end
                                                end
                                            else
                                                if state <= 3 then
                                                    if state == 3 then
                                                        r20 = ReturnVal
                                                        r48 = "math"
                                                        ReturnVal = _env[r48]
                                                        r48 = "random"
                                                        state = ReturnVal[r48]
                                                        r48 = allocUpvalue()
                                                        upvalueValues[r48] = state
                                                        r82 = "table"
                                                        ReturnVal = _env[r82]
                                                        r82 = "concat"
                                                        state = ReturnVal[r82]
                                                        r81 = state
                                                        r82 = state
                                                        r26 = "table"
                                                        r86 = _env[r26]
                                                        state = r86 and (4) or (5)
                                                        r97 = r86
                                                    end
                                                else
                                                    if state == 4 then
                                                        r71 = "table"
                                                        r26 = _env[r71]
                                                        r71 = "unpack"
                                                        r86 = r26[r71]
                                                        r97 = r86
                                                        state = 5
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 6 then
                                                if state <= 5 then
                                                    if state == 5 then
                                                        state = r81
                                                        state = r97 and (6) or (7)
                                                        ReturnVal = r97
                                                    end
                                                else
                                                    if state == 6 then
                                                        r97 = allocUpvalue()
                                                        upvalueValues[r97] = ReturnVal
                                                        state = upvalueValues[r48]
                                                        r81 = 3
                                                        r86 = 65
                                                        ReturnVal = state(r81, r86)
                                                        r81 = allocUpvalue()
                                                        upvalueValues[r81] = ReturnVal
                                                        state = 0
                                                        r86 = state
                                                        r71 = "pcall"
                                                        ReturnVal = _env[r71]
                                                        state = 0
                                                        r21 = createClosure4(34, {})
                                                        r71 = {
                                                            ReturnVal(r21)
                                                        }
                                                        r26 = state
                                                        state = {
                                                            unpack(r71)
                                                        }
                                                        r71 = state
                                                        ReturnVal = 2
                                                        state = r71[ReturnVal]
                                                        r21 = state
                                                        ReturnVal = "tonumber"
                                                        state = _env[ReturnVal]
                                                        r31 = upvalueValues[r68]
                                                        r59 = "tostring"
                                                        r75 = _env[r59]
                                                        r59 = r75(r21)
                                                        r75 = ":(%d*):"
                                                        r47 = r31(r59, r75)
                                                        r31 = {
                                                            r47()
                                                        }
                                                        ReturnVal = state(unpack(r31))
                                                        r31 = allocUpvalue()
                                                        upvalueValues[r31] = ReturnVal
                                                        r47 = upvalueValues[r81]
                                                        r75 = r47
                                                        r47 = 1
                                                        r59 = r47
                                                        r47 = 0
                                                        r30 = r59 < r47
                                                        ReturnVal = 1
                                                        r47 = ReturnVal - r59
                                                        state = 8
                                                    end
                                                end
                                            else
                                                if state <= 7 then
                                                    if state == 7 then
                                                        r81 = "unpack"
                                                        r97 = _env[r81]
                                                        ReturnVal = r97
                                                        state = 6
                                                    end
                                                else
                                                    if state == 8 then
                                                        r47 = r47 + r59
                                                        ReturnVal = r47 <= r75
                                                        r79 = not r30
                                                        ReturnVal = r79 and ReturnVal
                                                        r79 = r47 >= r75
                                                        r79 = r30 and r79
                                                        ReturnVal = r79 or ReturnVal
                                                        r79 = (9)
                                                        state = ReturnVal and r79
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
                                                        r79 = allocUpvalue()
                                                        upvalueValues[r79] = r47
                                                        r35 = "math"
                                                        ReturnVal = _env[r35]
                                                        r35 = "random"
                                                        state = ReturnVal[r35]
                                                        r92 = 100
                                                        r35 = 1
                                                        ReturnVal = state(r35, r92)
                                                        r35 = allocUpvalue()
                                                        upvalueValues[r35] = ReturnVal
                                                        state = upvalueValues[r48]
                                                        r10 = 255
                                                        r92 = 0
                                                        ReturnVal = state(r92, r10)
                                                        r92 = allocUpvalue()
                                                        upvalueValues[r92] = ReturnVal
                                                        state = upvalueValues[r48]
                                                        r52 = upvalueValues[r35]
                                                        r10 = 1
                                                        ReturnVal = state(r10, r52)
                                                        r10 = allocUpvalue()
                                                        upvalueValues[r10] = ReturnVal
                                                        ReturnVal = upvalueValues[r48]
                                                        r44 = 2
                                                        r67 = 1
                                                        r52 = ReturnVal(r67, r44)
                                                        ReturnVal = 1
                                                        state = r52 == ReturnVal
                                                        r52 = allocUpvalue()
                                                        upvalueValues[r52] = state
                                                        r33 = "tostring"
                                                        r78 = _env[r33]
                                                        r29 = upvalueValues[r48]
                                                        r72 = 0
                                                        r17 = 10000
                                                        r23 = {
                                                            r29(r72, r17)
                                                        }
                                                        r33 = r78(unpack(r23))
                                                        state = "gsub"
                                                        state = r21[state]
                                                        r78 = ":"
                                                        r38 = r33 .. r78
                                                        r44 = ":"
                                                        r67 = r44 .. r38
                                                        ReturnVal = ":(%d*):"
                                                        state = state(r21, ReturnVal, r67)
                                                        r67 = allocUpvalue()
                                                        r38 = createClosure3(35, {
                                                            r48,
                                                            r79,
                                                            r81,
                                                            r68,
                                                            r40,
                                                            r31,
                                                            r52,
                                                            r67,
                                                            r35,
                                                            r10,
                                                            r92,
                                                            r97
                                                        })
                                                        upvalueValues[r67] = state
                                                        r44 = "pcall"
                                                        ReturnVal = _env[r44]
                                                        r44 = {
                                                            ReturnVal(r38)
                                                        }
                                                        state = {
                                                            unpack(r44)
                                                        }
                                                        r44 = state
                                                        state = upvalueValues[r52]
                                                        state = state and (11) or (12)
                                                    end
                                                else
                                                    if state == 10 then
                                                        r75 = upvalueValues[r40]
                                                        state = r75 and (13) or (14)
                                                        r47 = r75
                                                    end
                                                end
                                            else
                                                if state <= 11 then
                                                    if state == 11 then
                                                        r38 = upvalueValues[r40]
                                                        state = r38 and (15) or (16)
                                                        ReturnVal = r38
                                                    end
                                                else
                                                    if state == 12 then
                                                        r78 = upvalueValues[r40]
                                                        state = r78 and (17) or (18)
                                                        r38 = r78
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 14 then
                                                if state <= 13 then
                                                    if state == 13 then
                                                        r75 = r86 == r26
                                                        r47 = r75
                                                        state = 14
                                                    end
                                                else
                                                    if state == 14 then
                                                        upvalueValues[r40] = r47
                                                        state = upvalueValues[r40]
                                                        state = state and (19) or (20)
                                                    end
                                                end
                                            else
                                                if state <= 15 then
                                                    if state == 15 then
                                                        r78 = state
                                                        r23 = 1
                                                        r29 = r44[r23]
                                                        r23 = false
                                                        r33 = r29 == r23
                                                        state = r33 and (21) or (22)
                                                        r38 = r33
                                                    end
                                                else
                                                    if state == 16 then
                                                        upvalueValues[r40] = ReturnVal
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
                                                        r33 = 1
                                                        r78 = r44[r33]
                                                        r38 = r78
                                                        state = 18
                                                    end
                                                else
                                                    if state == 18 then
                                                        upvalueValues[r40] = r38
                                                        r23 = upvalueValues[r10]
                                                        r72 = 1
                                                        r29 = r23 + r72
                                                        r33 = r44[r29]
                                                        r78 = r86 + r33
                                                        r33 = 256
                                                        state = r78 % r33
                                                        r86 = state
                                                        r29 = upvalueValues[r92]
                                                        r33 = r26 + r29
                                                        r29 = 256
                                                        r78 = r33 % r29
                                                        r26 = r78
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
                                                        r23 = 2
                                                        r29 = r44[r23]
                                                        r23 = upvalueValues[r67]
                                                        r33 = r29 == r23
                                                        r38 = r33
                                                        state = 22
                                                    end
                                                else
                                                    if state == 22 then
                                                        state = r78
                                                        ReturnVal = r38
                                                        state = 16
                                                    end
                                                end
                                            else
                                                if state <= 23 then
                                                    if state == 23 then
                                                        r67 = releaseUpvalue(r67)
                                                        r52 = releaseUpvalue(r52)
                                                        r44 = nil
                                                        r92 = releaseUpvalue(r92)
                                                        r10 = releaseUpvalue(r10)
                                                        r35 = releaseUpvalue(r35)
                                                        r79 = releaseUpvalue(r79)
                                                        state = 8
                                                    end
                                                else
                                                    if state == 24 then
                                                        r98 = releaseUpvalue(r98)
                                                        r81 = releaseUpvalue(r81)
                                                        r31 = releaseUpvalue(r31)
                                                        r40 = releaseUpvalue(r40)
                                                        r68 = releaseUpvalue(r68)
                                                        r86 = nil
                                                        r86 = {}
                                                        r97 = releaseUpvalue(r97)
                                                        r48 = releaseUpvalue(r48)
                                                        r4 = releaseUpvalue(r4)
                                                        r4 = allocUpvalue()
                                                        r40 = nil
                                                        upvalueValues[r4] = r40
                                                        r81 = allocUpvalue()
                                                        r40 = allocUpvalue()
                                                        r68 = nil
                                                        upvalueValues[r40] = r68
                                                        r20 = nil
                                                        r20 = "math"
                                                        r98 = _env[r20]
                                                        r26 = nil
                                                        r26 = allocUpvalue()
                                                        r20 = "floor"
                                                        r68 = r98[r20]
                                                        r98 = allocUpvalue()
                                                        upvalueValues[r98] = r68
                                                        r48 = "math"
                                                        r20 = _env[r48]
                                                        r48 = "random"
                                                        r68 = r20[r48]
                                                        r31 = 256
                                                        r30 = r31
                                                        r82 = nil
                                                        r82 = "table"
                                                        r48 = _env[r82]
                                                        r82 = "remove"
                                                        r20 = r48[r82]
                                                        r97 = "string"
                                                        r82 = _env[r97]
                                                        r97 = "char"
                                                        r48 = r82[r97]
                                                        r71 = nil
                                                        r71 = {}
                                                        r97 = allocUpvalue()
                                                        r82 = 0
                                                        upvalueValues[r97] = r82
                                                        r31 = 1
                                                        r82 = 2
                                                        upvalueValues[r81] = r82
                                                        r82 = {}
                                                        upvalueValues[r26] = r86
                                                        r79 = r31
                                                        r31 = 0
                                                        r35 = r79 < r31
                                                        r21 = nil
                                                        r21 = 1
                                                        r31 = r21 - r79
                                                        r86 = 0
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
                                                            r4
                                                        })
                                                        r75 = {
                                                            state()
                                                        }
                                                        ReturnVal = {
                                                            unpack(r75)
                                                        }
                                                        state = nil
                                                    end
                                                else
                                                    if state == 26 then
                                                        r92 = not r35
                                                        r31 = r31 + r79
                                                        r21 = r31 <= r30
                                                        r21 = r92 and r21
                                                        r92 = r31 >= r30
                                                        r92 = r35 and r92
                                                        r21 = r92 or r21
                                                        r92 = (27)
                                                        state = r21 and r92
                                                        r21 = (28)
                                                        state = state or r21
                                                    end
                                                end
                                            else
                                                if state <= 27 then
                                                    if state == 27 then
                                                        r21 = r31
                                                        r92 = r21
                                                        r71[r21] = r92
                                                        r21 = nil
                                                        state = 26
                                                    end
                                                else
                                                    if state == 28 then
                                                        r31 = #r71
                                                        r30 = 0
                                                        r21 = r31 == r30
                                                        state = 29
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 30 then
                                                if state <= 29 then
                                                    if state == 29 then
                                                        r31 = 1
                                                        r30 = #r71
                                                        r21 = r68(r31, r30)
                                                        r31 = r20(r71, r21)
                                                        r92 = 1
                                                        r21 = nil
                                                        r30 = upvalueValues[r26]
                                                        r35 = r31 - r92
                                                        r79 = r48(r35)
                                                        r30[r31] = r79
                                                        r31 = nil
                                                        state = 30
                                                    end
                                                else
                                                    if state == 30 then
                                                        r31 = #r71
                                                        r30 = 0
                                                        r21 = r31 == r30
                                                        state = r21 and (31) or (29)
                                                    end
                                                end
                                            else
                                                if state == 31 then
                                                    r44 = "__metatable"
                                                    r21 = {}
                                                    r31 = allocUpvalue()
                                                    r30 = createClosure1(51, {
                                                        r31,
                                                        r97,
                                                        r81,
                                                        r98
                                                    })
                                                    upvalueValues[r31] = r21
                                                    r21 = allocUpvalue()
                                                    upvalueValues[r21] = r30
                                                    r86 = nil
                                                    r52 = "__index"
                                                    r48 = nil
                                                    r33 = nil
                                                    r30 = {}
                                                    r79 = allocUpvalue()
                                                    r92 = {}
                                                    r35 = "setmetatable"
                                                    r71 = nil
                                                    r98 = releaseUpvalue(r98)
                                                    upvalueValues[r79] = r30
                                                    r30 = _env[r35]
                                                    r67 = upvalueValues[r79]
                                                    r10 = {
                                                        [r52] = r67,
                                                        [r44] = r33
                                                    }
                                                    r35 = r30(r92, r10)
                                                    ReturnVal = {}
                                                    r30 = createClosure4(57, {
                                                        r79,
                                                        r31,
                                                        r26,
                                                        r97,
                                                        r81,
                                                        r21
                                                    })
                                                    r79 = releaseUpvalue(r79)
                                                    r26 = releaseUpvalue(r26)
                                                    upvalueValues[r40] = r35
                                                    r21 = releaseUpvalue(r21)
                                                    r31 = releaseUpvalue(r31)
                                                    r81 = releaseUpvalue(r81)
                                                    r97 = releaseUpvalue(r97)
                                                    upvalueValues[r4] = r30
                                                    r98 = "game"
                                                    r68 = nil
                                                    r68 = _env[r98]
                                                    r48 = upvalueValues[r40]
                                                    r82 = nil
                                                    r82 = upvalueValues[r4]
                                                    r86 = 10474624504589
                                                    r81 = "m\212\183h\229\191?"
                                                    r97 = r82(r81, r86)
                                                    r98 = "GetService"
                                                    r98 = r68[r98]
                                                    r20 = nil
                                                    r20 = r48[r97]
                                                    r98 = r98(r68, r20)
                                                    r68 = allocUpvalue()
                                                    upvalueValues[r68] = r98
                                                    r20 = upvalueValues[r68]
                                                    r82 = upvalueValues[r40]
                                                    r97 = upvalueValues[r4]
                                                    r26 = 20678028584348
                                                    r86 = "\146\235\144\170/8=\021\205\014="
                                                    r81 = r97(r86, r26)
                                                    r48 = r82[r81]
                                                    r98 = r20[r48]
                                                    r20 = allocUpvalue()
                                                    upvalueValues[r20] = r98
                                                    r98 = createClosure2(64, {
                                                        r40,
                                                        r4
                                                    })
                                                    r48 = "SendMessageEMBED"
                                                    _env[r48] = r98
                                                    r98 = createClosure4(65, {
                                                        r40,
                                                        r4
                                                    })
                                                    r48 = "GetUserIp"
                                                    _env[r48] = r98
                                                    r48 = createClosure5(66, {
                                                        r40,
                                                        r4
                                                    })
                                                    r98 = allocUpvalue()
                                                    upvalueValues[r98] = r48
                                                    r48 = createClosure0(70, {
                                                        r40,
                                                        r4,
                                                        r68,
                                                        r20,
                                                        r98
                                                    })
                                                    r82 = "Log"
                                                    _env[r82] = r48
                                                    r48 = createClosure(71, {
                                                        r40,
                                                        r4
                                                    })
                                                    r20 = releaseUpvalue(r20)
                                                    r82 = "RunCommandFlow"
                                                    _env[r82] = r48
                                                    r68 = releaseUpvalue(r68)
                                                    r82 = "Log"
                                                    r48 = _env[r82]
                                                    r98 = releaseUpvalue(r98)
                                                    r82 = r48()
                                                    r82 = "RunCommandFlow"
                                                    r48 = _env[r82]
                                                    r82 = r48()
                                                    r4 = releaseUpvalue(r4)
                                                    r40 = releaseUpvalue(r40)
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure0 entry 8545613 -> 32, states 32-32
                                if state == 32 then -- entry 8545613 -> 32
                                    state = true
                                    upvalueValues[upvalues[1]] = state
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        else
                            if state <= 33 then
                                -- createClosure3 entry 2774556 -> 33, states 33-33
                                if state == 33 then -- entry 2774556 -> 33
                                    ReturnVal = "error"
                                    state = _env[ReturnVal]
                                    r55 = "Tamper Detected!"
                                    ReturnVal = state(r55)
                                    ReturnVal = {}
                                    state = nil
                                end
                            else
                                -- createClosure4 entry 2469851 -> 34, states 34-34
                                if state == 34 then -- entry 2469851 -> 34
                                    r40 = "Z4tKfLDVtBsz"
                                    r68 = 5745544
                                    r55 = r40 ^ r68
                                    ReturnVal = 16554977
                                    state = ReturnVal - r55
                                    r55 = state
                                    ReturnVal = "npYUlF37L0Orf"
                                    state = ReturnVal / r55
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
                                -- createClosure3 entry 5016125 -> 35, states 35-46
                                if state <= 40 then
                                    if state <= 37 then
                                        if state <= 36 then
                                            if state <= 35 then
                                                if state == 35 then -- entry 5016125 -> 35
                                                    r40 = upvalueValues[upvalues[1]]
                                                    r4 = 1
                                                    r98 = 2
                                                    r68 = r40(r4, r98)
                                                    r40 = 1
                                                    r55 = r68 == r40
                                                    state = r55 and (36) or (37)
                                                    ReturnVal = r55
                                                end
                                            else
                                                if state == 36 then
                                                    state = ReturnVal and (38) or (39)
                                                end
                                            end
                                        else
                                            if state == 37 then
                                                r40 = upvalueValues[upvalues[2]]
                                                r68 = upvalueValues[upvalues[3]]
                                                r55 = r40 == r68
                                                ReturnVal = r55
                                                state = 36
                                            end
                                        end
                                    else
                                        if state <= 39 then
                                            if state <= 38 then
                                                if state == 38 then
                                                    ReturnVal = "tonumber"
                                                    state = _env[ReturnVal]
                                                    r97 = createClosure4(72, {})
                                                    r55 = upvalueValues[upvalues[4]]
                                                    r4 = "tostring"
                                                    r68 = _env[r4]
                                                    r82 = "pcall"
                                                    r48 = _env[r82]
                                                    r82 = {
                                                        r48(r97)
                                                    }
                                                    r20 = {
                                                        unpack(r82)
                                                    }
                                                    r48 = 2
                                                    r98 = r20[r48]
                                                    r4 = r68(r98)
                                                    r68 = ":(%d*):"
                                                    r40 = r55(r4, r68)
                                                    r55 = {
                                                        r40()
                                                    }
                                                    ReturnVal = state(unpack(r55))
                                                    r55 = ReturnVal
                                                    r40 = upvalueValues[upvalues[5]]
                                                    state = r40 and (40) or (41)
                                                    ReturnVal = r40
                                                end
                                            else
                                                if state == 39 then
                                                    state = upvalueValues[upvalues[7]]
                                                    state = state and (42) or (43)
                                                end
                                            end
                                        else
                                            if state == 40 then
                                                r68 = upvalueValues[upvalues[6]]
                                                r40 = r68 == r55
                                                ReturnVal = r40
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
                                                    r55 = nil
                                                    state = 39
                                                end
                                            else
                                                if state == 42 then
                                                    r55 = "error"
                                                    state = _env[r55]
                                                    r40 = upvalueValues[upvalues[8]]
                                                    r68 = 0
                                                    r55 = state(r40, r68)
                                                    state = 43
                                                end
                                            end
                                        else
                                            if state == 43 then
                                                state = {}
                                                r55 = state
                                                r68 = upvalueValues[upvalues[9]]
                                                r4 = r68
                                                r68 = 1
                                                r98 = r68
                                                r68 = 0
                                                r20 = r98 < r68
                                                r40 = 1
                                                r68 = r40 - r98
                                                state = 44
                                            end
                                        end
                                    else
                                        if state <= 45 then
                                            if state <= 44 then
                                                if state == 44 then
                                                    r48 = not r20
                                                    r68 = r68 + r98
                                                    r40 = r68 <= r4
                                                    r40 = r48 and r40
                                                    r48 = r68 >= r4
                                                    r48 = r20 and r48
                                                    r40 = r48 or r40
                                                    r48 = (45)
                                                    state = r40 and r48
                                                    r40 = (46)
                                                    state = state or r40
                                                end
                                            else
                                                if state == 45 then
                                                    state = upvalueValues[upvalues[1]]
                                                    r40 = r68
                                                    r82 = 0
                                                    r97 = 255
                                                    r48 = state(r82, r97)
                                                    r55[r40] = r48
                                                    r40 = nil
                                                    state = 44
                                                end
                                            end
                                        else
                                            if state == 46 then
                                                state = upvalueValues[upvalues[10]]
                                                r40 = upvalueValues[upvalues[11]]
                                                r55[state] = r40
                                                state = upvalueValues[upvalues[12]]
                                                r40 = {
                                                    state(r55)
                                                }
                                                ReturnVal = {
                                                    unpack(r40)
                                                }
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure3 entry 6286817 -> 47, states 47-50
                                if state <= 48 then
                                    if state <= 47 then
                                        if state == 47 then -- entry 6286817 -> 47
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
                                            r55 = "l1"
                                            ReturnVal = _env[r55]
                                            r55 = "l1"
                                            _env[r55] = state
                                            r55 = "l2"
                                            _env[r55] = ReturnVal
                                            r55 = upvalueValues[upvalues[1]]
                                            r40 = r55()
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
                            -- createClosure1 entry 14078666 -> 51, states 51-56
                            if state <= 53 then
                                if state <= 52 then
                                    if state <= 51 then
                                        if state == 51 then -- entry 14078666 -> 51
                                            r55 = upvalueValues[upvalues[1]]
                                            ReturnVal = #r55
                                            r55 = 0
                                            state = ReturnVal == r55
                                            state = state and (52) or (53)
                                        end
                                    else
                                        if state == 52 then
                                            r40 = upvalueValues[upvalues[2]]
                                            r68 = 25
                                            r55 = r40 * r68
                                            r40 = 29268877014331
                                            ReturnVal = r55 + r40
                                            r55 = 35184372088832
                                            state = ReturnVal % r55
                                            upvalueValues[upvalues[2]] = state
                                            r55 = upvalueValues[upvalues[3]]
                                            r40 = 1
                                            ReturnVal = r55 ~= r40
                                            state = 54
                                        end
                                    end
                                else
                                    if state == 53 then
                                        r68 = "table"
                                        r40 = _env[r68]
                                        r68 = "remove"
                                        r55 = r40[r68]
                                        r68 = upvalueValues[upvalues[1]]
                                        r40 = {
                                            r55(r68)
                                        }
                                        ReturnVal = {
                                            unpack(r40)
                                        }
                                        state = nil
                                    end
                                end
                            else
                                if state <= 55 then
                                    if state <= 54 then
                                        if state == 54 then
                                            r40 = upvalueValues[upvalues[3]]
                                            r68 = 163
                                            r55 = r40 * r68
                                            r40 = 257
                                            ReturnVal = r55 % r40
                                            upvalueValues[upvalues[3]] = ReturnVal
                                            state = 55
                                        end
                                    else
                                        if state == 55 then
                                            r40 = upvalueValues[upvalues[3]]
                                            r68 = 1
                                            r55 = r40 ~= r68
                                            state = r55 and (56) or (54)
                                        end
                                    end
                                else
                                    if state == 56 then
                                        r40 = upvalueValues[upvalues[3]]
                                        r68 = 32
                                        r55 = r40 % r68
                                        r97 = 2
                                        r4 = upvalueValues[upvalues[4]]
                                        r48 = upvalueValues[upvalues[2]]
                                        r21 = upvalueValues[upvalues[3]]
                                        r71 = r21 - r55
                                        r21 = 32
                                        r26 = r71 / r21
                                        r86 = 13
                                        r81 = r86 - r26
                                        r82 = r97 ^ r81
                                        r20 = r48 / r82
                                        r82 = 1
                                        r98 = r4(r20)
                                        r4 = 4294967296
                                        r68 = r98 % r4
                                        r98 = 2
                                        r4 = r98 ^ r55
                                        r40 = r68 / r4
                                        r4 = upvalueValues[upvalues[4]]
                                        r48 = r40 % r82
                                        r86 = 256
                                        r82 = 4294967296
                                        r55 = nil
                                        r20 = r48 * r82
                                        r48 = 65536
                                        r98 = r4(r20)
                                        r4 = upvalueValues[upvalues[4]]
                                        r20 = r4(r40)
                                        r68 = r98 + r20
                                        r98 = 65536
                                        r4 = r68 % r98
                                        r97 = 256
                                        r40 = nil
                                        r20 = r68 - r4
                                        r98 = r20 / r48
                                        r48 = 256
                                        r68 = nil
                                        r20 = r4 % r48
                                        r82 = r4 - r20
                                        r48 = r82 / r97
                                        r97 = 256
                                        r82 = r98 % r97
                                        r81 = r98 - r82
                                        r4 = nil
                                        r98 = nil
                                        r97 = r81 / r86
                                        r81 = {
                                            r20,
                                            r48,
                                            r82,
                                            r97
                                        }
                                        r97 = nil
                                        r48 = nil
                                        upvalueValues[upvalues[1]] = r81
                                        r82 = nil
                                        r20 = nil
                                        state = 53
                                    end
                                end
                            end
                        end
                    end
                else
                    if state <= 69 then
                        if state <= 64 then
                            if state <= 63 then
                                -- createClosure4 entry 9507375 -> 57, states 57-63
                                if state <= 60 then
                                    if state <= 58 then
                                        if state <= 57 then
                                            if state == 57 then -- entry 9507375 -> 57
                                                state = upvalueValues[upvalues[1]]
                                                r68 = state
                                                r40 = args[2]
                                                r55 = args[1]
                                                state = r68[r40]
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
                                                r4 = ReturnVal
                                                r98 = 35184372088832
                                                ReturnVal = r40 % r98
                                                upvalueValues[upvalues[4]] = ReturnVal
                                                r81 = 1
                                                r86 = r81
                                                r48 = 255
                                                r20 = r40 % r48
                                                r48 = 2
                                                r98 = r20 + r48
                                                upvalueValues[upvalues[5]] = r98
                                                r82 = "string"
                                                r48 = _env[r82]
                                                r82 = "len"
                                                r20 = r48[r82]
                                                r48 = r20(r55)
                                                r20 = ""
                                                r68[r40] = r20
                                                r81 = 0
                                                r26 = r86 < r81
                                                r82 = 1
                                                r81 = r82 - r86
                                                r97 = r48
                                                r20 = 93
                                                state = 61
                                            end
                                        else
                                            if state == 60 then
                                                ReturnVal = {
                                                    r40
                                                }
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    if state <= 62 then
                                        if state <= 61 then
                                            if state == 61 then
                                                r81 = r81 + r86
                                                r71 = not r26
                                                r82 = r81 <= r97
                                                r82 = r71 and r82
                                                r71 = r81 >= r97
                                                r71 = r26 and r71
                                                r82 = r71 or r82
                                                r71 = (62)
                                                state = r82 and r71
                                                r82 = (63)
                                                state = state or r82
                                            end
                                        else
                                            if state == 62 then
                                                r82 = r81
                                                r59 = "string"
                                                r75 = _env[r59]
                                                r59 = "byte"
                                                r47 = r75[r59]
                                                r75 = r47(r55, r82)
                                                r47 = upvalueValues[upvalues[6]]
                                                r82 = nil
                                                r59 = r47()
                                                r31 = r75 + r59
                                                r21 = r31 + r20
                                                r31 = 256
                                                r71 = r21 % r31
                                                r20 = r71
                                                r31 = r68[r40]
                                                r59 = 1
                                                r75 = r20 + r59
                                                r47 = r4[r75]
                                                r21 = r31 .. r47
                                                r68[r40] = r21
                                                state = 61
                                            end
                                        end
                                    else
                                        if state == 63 then
                                            r4 = nil
                                            r20 = nil
                                            r48 = nil
                                            state = 60
                                        end
                                    end
                                end
                            else
                                -- createClosure2 entry 16740604 -> 64, states 64-64
                                if state == 64 then -- entry 16740604 -> 64
                                    r55 = args[1]
                                    ReturnVal = "game"
                                    state = _env[ReturnVal]
                                    r4 = upvalueValues[upvalues[1]]
                                    r48 = "_L\243M\008^Q$>\185\011"
                                    r98 = upvalueValues[upvalues[2]]
                                    r82 = 5643744725572
                                    r20 = r98(r48, r82)
                                    r48 = "\168/\143\227\002\020\177\210`D\r\n"
                                    r40 = args[2]
                                    ReturnVal = "GetService"
                                    ReturnVal = state[ReturnVal]
                                    r68 = r4[r20]
                                    ReturnVal = ReturnVal(state, r68)
                                    r4 = upvalueValues[upvalues[1]]
                                    r68 = ReturnVal
                                    r98 = upvalueValues[upvalues[2]]
                                    r82 = 3732846708426
                                    r20 = r98(r48, r82)
                                    ReturnVal = r4[r20]
                                    r98 = upvalueValues[upvalues[1]]
                                    r20 = upvalueValues[upvalues[2]]
                                    r97 = 14286590679548
                                    r82 = "'\169\251\221,RN\198\028\245\tyU\020L\\"
                                    r48 = r20(r82, r97)
                                    r4 = r98[r48]
                                    r98 = upvalueValues[upvalues[1]]
                                    state = {
                                        [ReturnVal] = r4
                                    }
                                    r4 = state
                                    r20 = upvalueValues[upvalues[2]]
                                    r97 = 34342921207416
                                    r82 = ";\138.\135fb"
                                    r48 = r20(r82, r97)
                                    ReturnVal = r98[r48]
                                    r82 = upvalueValues[upvalues[1]]
                                    r97 = upvalueValues[upvalues[2]]
                                    r86 = "\200h(H*"
                                    r26 = 32169854302852
                                    r81 = r97(r86, r26)
                                    r48 = r82[r81]
                                    r81 = upvalueValues[upvalues[1]]
                                    r86 = upvalueValues[upvalues[2]]
                                    r71 = "#\237V\192\177"
                                    r21 = 28932845417632
                                    r26 = r86(r71, r21)
                                    r97 = r81[r26]
                                    r82 = r40[r97]
                                    r81 = upvalueValues[upvalues[1]]
                                    r86 = upvalueValues[upvalues[2]]
                                    r71 = "\205\184\170;\219\017\173\214\007)\150"
                                    r21 = 7023834090694
                                    r26 = r86(r71, r21)
                                    r97 = r81[r26]
                                    r26 = upvalueValues[upvalues[1]]
                                    r71 = upvalueValues[upvalues[2]]
                                    r31 = "3e\231\008R\251\021\197=\208\238"
                                    r47 = 2103147922387
                                    r21 = r71(r31, r47)
                                    r86 = r26[r21]
                                    r81 = r40[r86]
                                    r26 = upvalueValues[upvalues[1]]
                                    r71 = upvalueValues[upvalues[2]]
                                    r31 = "\"\199\151B\028"
                                    r47 = 13706565196014
                                    r21 = r71(r31, r47)
                                    r86 = r26[r21]
                                    r21 = upvalueValues[upvalues[1]]
                                    r31 = upvalueValues[upvalues[2]]
                                    r75 = "\156\250g\140C"
                                    r59 = 6431965367219
                                    r47 = r31(r75, r59)
                                    r71 = r21[r47]
                                    r26 = r40[r71]
                                    r21 = upvalueValues[upvalues[1]]
                                    r31 = upvalueValues[upvalues[2]]
                                    r59 = 5598527015471
                                    r75 = "C\134\175\252\213\151"
                                    r47 = r31(r75, r59)
                                    r71 = r21[r47]
                                    r47 = upvalueValues[upvalues[1]]
                                    r75 = upvalueValues[upvalues[2]]
                                    r79 = 17381321007005
                                    r30 = "\213I\248J\014\026"
                                    r59 = r75(r30, r79)
                                    r31 = r47[r59]
                                    r21 = r40[r31]
                                    r47 = upvalueValues[upvalues[1]]
                                    r75 = upvalueValues[upvalues[2]]
                                    r79 = 17943682310307
                                    r30 = "\237^\188 \023^"
                                    r59 = r75(r30, r79)
                                    r31 = r47[r59]
                                    r59 = upvalueValues[upvalues[1]]
                                    r30 = upvalueValues[upvalues[2]]
                                    r35 = "\137K\011;"
                                    r92 = 16809825590931
                                    r79 = r30(r35, r92)
                                    r75 = r59[r79]
                                    r35 = upvalueValues[upvalues[1]]
                                    r92 = upvalueValues[upvalues[2]]
                                    r52 = "\188\253\250\221\203!"
                                    r67 = 10981089858553
                                    r10 = r92(r52, r67)
                                    r79 = r35[r10]
                                    r30 = r40[r79]
                                    r35 = upvalueValues[upvalues[1]]
                                    r92 = upvalueValues[upvalues[2]]
                                    r67 = 13347912669255
                                    r52 = "\171\166\005\026"
                                    r10 = r92(r52, r67)
                                    r79 = r35[r10]
                                    r59 = r30[r79]
                                    r47 = {
                                        [r75] = r59
                                    }
                                    r20 = {
                                        [r48] = r82,
                                        [r97] = r81,
                                        [r86] = r26,
                                        [r71] = r21,
                                        [r31] = r47
                                    }
                                    r98 = {
                                        r20
                                    }
                                    state = {
                                        [ReturnVal] = r98
                                    }
                                    r98 = state
                                    state = "JSONEncode"
                                    state = r68[state]
                                    state = state(r68, r98)
                                    r20 = state
                                    ReturnVal = "request"
                                    state = _env[ReturnVal]
                                    r97 = upvalueValues[upvalues[1]]
                                    r81 = upvalueValues[upvalues[2]]
                                    r71 = 5009349069084
                                    r26 = "x\185\211"
                                    r86 = r81(r26, r71)
                                    r82 = r97[r86]
                                    r47 = 33161052486737
                                    r81 = upvalueValues[upvalues[1]]
                                    r86 = upvalueValues[upvalues[2]]
                                    r21 = 7163920157959
                                    r71 = "@.\007-VS"
                                    r26 = r86(r71, r21)
                                    r97 = r81[r26]
                                    r86 = upvalueValues[upvalues[1]]
                                    r26 = upvalueValues[upvalues[2]]
                                    r31 = 22514648213748
                                    r21 = "\145\131\143\235"
                                    r71 = r26(r21, r31)
                                    r81 = r86[r71]
                                    r31 = "6/p\181\007\142s"
                                    r75 = 16782556601990
                                    r26 = upvalueValues[upvalues[1]]
                                    r98 = nil
                                    r71 = upvalueValues[upvalues[2]]
                                    r68 = nil
                                    r21 = r71(r31, r47)
                                    r86 = r26[r21]
                                    r71 = upvalueValues[upvalues[1]]
                                    r47 = "\223m\017\198"
                                    r21 = upvalueValues[upvalues[2]]
                                    r40 = nil
                                    r31 = r21(r47, r75)
                                    r26 = r71[r31]
                                    r48 = {
                                        [r82] = r55,
                                        [r97] = r81,
                                        [r86] = r4,
                                        [r26] = r20
                                    }
                                    r4 = nil
                                    r55 = nil
                                    ReturnVal = state(r48)
                                    r20 = nil
                                    r48 = ReturnVal
                                    r48 = nil
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        else
                            if state <= 65 then
                                -- createClosure4 entry 758351 -> 65, states 65-65
                                if state == 65 then -- entry 758351 -> 65
                                    ReturnVal = "request"
                                    state = _env[ReturnVal]
                                    r68 = upvalueValues[upvalues[1]]
                                    r4 = upvalueValues[upvalues[2]]
                                    r20 = "w\211\212"
                                    r48 = 5269059881365
                                    r98 = r4(r20, r48)
                                    r40 = r68[r98]
                                    r4 = upvalueValues[upvalues[1]]
                                    r98 = upvalueValues[upvalues[2]]
                                    r82 = 8495347126131
                                    r48 = "{\207\149\133\161E=\221\160%\186\003Ah\194\201w\022&-\216\150"
                                    r20 = r98(r48, r82)
                                    r68 = r4[r20]
                                    r98 = upvalueValues[upvalues[1]]
                                    r20 = upvalueValues[upvalues[2]]
                                    r97 = 1188218602025
                                    r82 = "\031\148\181 \2557"
                                    r48 = r20(r82, r97)
                                    r4 = r98[r48]
                                    r20 = upvalueValues[upvalues[1]]
                                    r48 = upvalueValues[upvalues[2]]
                                    r81 = 14458903419468
                                    r97 = "\190\218\137"
                                    r82 = r48(r97, r81)
                                    r98 = r20[r82]
                                    r55 = {
                                        [r40] = r68,
                                        [r4] = r98
                                    }
                                    ReturnVal = state(r55)
                                    r55 = ReturnVal
                                    ReturnVal = "game"
                                    state = _env[ReturnVal]
                                    r68 = upvalueValues[upvalues[1]]
                                    r4 = upvalueValues[upvalues[2]]
                                    ReturnVal = "GetService"
                                    ReturnVal = state[ReturnVal]
                                    r48 = 12179469194791
                                    r20 = "Z \133\0113\r\131\138\137\196\012"
                                    r98 = r4(r20, r48)
                                    r40 = r68[r98]
                                    ReturnVal = ReturnVal(state, r40)
                                    r4 = upvalueValues[upvalues[1]]
                                    r98 = upvalueValues[upvalues[2]]
                                    r82 = 33646440168755
                                    r48 = "66\026L"
                                    r20 = r98(r48, r82)
                                    state = "JSONDecode"
                                    state = ReturnVal[state]
                                    r68 = r4[r20]
                                    r40 = r55[r68]
                                    state = state(ReturnVal, r40)
                                    r40 = state
                                    r68 = upvalueValues[upvalues[1]]
                                    r4 = upvalueValues[upvalues[2]]
                                    r48 = 8543408328586
                                    r20 = "\022\t\021G\244"
                                    r98 = r4(r20, r48)
                                    ReturnVal = r68[r98]
                                    state = r40[ReturnVal]
                                    ReturnVal = {
                                        state
                                    }
                                    state = nil
                                end
                            else
                                -- createClosure5 entry 10253228 -> 66, states 66-69
                                if state <= 67 then
                                    if state <= 66 then
                                        if state == 66 then -- entry 10253228 -> 66
                                            r55 = args[1]
                                            state = {}
                                            r68 = state
                                            r40 = args[2]
                                            ReturnVal = "ipairs"
                                            state = _env[ReturnVal]
                                            r20 = {
                                                state(r55)
                                            }
                                            r4 = r20[2]
                                            ReturnVal = r20[1]
                                            r98 = r20[3]
                                            r20 = ReturnVal
                                            state = 67
                                        end
                                    else
                                        if state == 67 then
                                            r98, r82 = r20(r4, r98)
                                            state = r98 and (68) or (69)
                                        end
                                    end
                                else
                                    if state <= 68 then
                                        if state == 68 then
                                            r48 = r98
                                            r81 = "table"
                                            r97 = _env[r81]
                                            r86 = upvalueValues[upvalues[1]]
                                            r26 = upvalueValues[upvalues[2]]
                                            r31 = 25094667464101
                                            r21 = "\225\209$nEL"
                                            r71 = r26(r21, r31)
                                            r81 = r86[r71]
                                            state = r97[r81]
                                            r75 = 8936692568129
                                            r47 = "\240[.@"
                                            r26 = "string"
                                            r86 = _env[r26]
                                            r71 = upvalueValues[upvalues[1]]
                                            r48 = nil
                                            r21 = upvalueValues[upvalues[2]]
                                            r31 = r21(r47, r75)
                                            r26 = r71[r31]
                                            r81 = r86[r26]
                                            r26 = r82 + r40
                                            r82 = nil
                                            r86 = {
                                                r81(r26)
                                            }
                                            r97 = state(r68, unpack(r86))
                                            state = 67
                                        end
                                    else
                                        if state == 69 then
                                            r98 = "table"
                                            r4 = _env[r98]
                                            r20 = upvalueValues[upvalues[1]]
                                            r48 = upvalueValues[upvalues[2]]
                                            r81 = 29221436912935
                                            r97 = "{\244\177<\161c"
                                            r82 = r48(r97, r81)
                                            r98 = r20[r82]
                                            state = r4[r98]
                                            r4 = {
                                                state(r68)
                                            }
                                            ReturnVal = {
                                                unpack(r4)
                                            }
                                            state = nil
                                        end
                                    end
                                end
                            end
                        end
                    else
                        if state <= 71 then
                            if state <= 70 then
                                -- createClosure0 entry 14093138 -> 70, states 70-70
                                if state == 70 then -- entry 14093138 -> 70
                                    r55 = upvalueValues[upvalues[1]]
                                    r4 = "\\\014\156\251\186Fb\145w\180O\151+gg\005\0040\021Q\236\225\160\216`?~\167\161\147\175\193\137\142\r.\242"
                                    r98 = 30738412206057
                                    r40 = upvalueValues[upvalues[2]]
                                    r20 = "game"
                                    r68 = r40(r4, r98)
                                    ReturnVal = r55[r68]
                                    r68 = "tostring"
                                    r40 = _env[r68]
                                    r98 = _env[r20]
                                    r48 = upvalueValues[upvalues[1]]
                                    r82 = upvalueValues[upvalues[2]]
                                    r86 = 12669539276555
                                    r81 = "\172\175\248\166\131.}"
                                    r97 = r82(r81, r86)
                                    r20 = r48[r97]
                                    r4 = r98[r20]
                                    r68 = r40(r4)
                                    r98 = upvalueValues[upvalues[1]]
                                    r20 = upvalueValues[upvalues[2]]
                                    r97 = 8323655503652
                                    r82 = "\184,\218"
                                    r48 = r20(r82, r97)
                                    r4 = r98[r48]
                                    r82 = "game"
                                    r48 = _env[r82]
                                    r97 = upvalueValues[upvalues[1]]
                                    r81 = upvalueValues[upvalues[2]]
                                    r26 = "\212\171\181\246N"
                                    r71 = 29896961308257
                                    r86 = r81(r26, r71)
                                    r82 = r97[r86]
                                    r20 = r48[r82]
                                    r82 = upvalueValues[upvalues[1]]
                                    r97 = upvalueValues[upvalues[2]]
                                    r86 = "g\145"
                                    r26 = 9655021490575
                                    r81 = r97(r86, r26)
                                    r48 = r82[r81]
                                    r98 = r20 .. r48
                                    r40 = r4 .. r98
                                    r55 = r68 .. r40
                                    state = ReturnVal .. r55
                                    r55 = state
                                    ReturnVal = "GetUserIp"
                                    state = _env[ReturnVal]
                                    ReturnVal = state()
                                    r40 = ReturnVal
                                    r68 = "game"
                                    ReturnVal = _env[r68]
                                    r98 = upvalueValues[upvalues[1]]
                                    r20 = upvalueValues[upvalues[2]]
                                    r68 = "GetService"
                                    r82 = "\205\242^\1294\140\163\029\003\255\128\200s\177T)\213\143"
                                    r97 = 2072128816068
                                    r48 = r20(r82, r97)
                                    r20 = "game"
                                    r4 = r98[r48]
                                    r68 = ReturnVal[r68]
                                    r68 = r68(ReturnVal, r4)
                                    r98 = _env[r20]
                                    r48 = upvalueValues[upvalues[1]]
                                    r82 = upvalueValues[upvalues[2]]
                                    r86 = 1736423293736
                                    r81 = "\178|\224J\177?3"
                                    r97 = r82(r81, r86)
                                    r20 = r48[r97]
                                    r4 = r98[r20]
                                    ReturnVal = "GetProductInfo"
                                    ReturnVal = r68[ReturnVal]
                                    ReturnVal = ReturnVal(r68, r4)
                                    r4 = upvalueValues[upvalues[1]]
                                    r98 = upvalueValues[upvalues[2]]
                                    r82 = 11758169412963
                                    r48 = "t}\129\008"
                                    r20 = r98(r48, r82)
                                    r68 = r4[r20]
                                    state = ReturnVal[r68]
                                    r98 = 106
                                    r20 = 106
                                    ReturnVal = upvalueValues[upvalues[3]]
                                    r68 = state
                                    r4 = "GetPlayers"
                                    r4 = ReturnVal[r4]
                                    r4 = r4(ReturnVal)
                                    state = #r4
                                    r4 = state
                                    r77 = 77
                                    r84 = 56
                                    r41 = 105
                                    o10 = 60
                                    r51 = 37
                                    o6 = 74
                                    o4 = 109
                                    r72 = 101
                                    r31 = 89
                                    o19 = 100
                                    r89 = 93
                                    o12 = 78
                                    r35 = 101
                                    r18 = 93
                                    r78 = 109
                                    r57 = 59
                                    r33 = 91
                                    r16 = 42
                                    r12 = 72
                                    o14 = 72
                                    r54 = 47
                                    o3 = 74
                                    r13 = 97
                                    r2 = 66
                                    r65 = 43
                                    r63 = 74
                                    r64 = 91
                                    r5 = 63
                                    r32 = 43
                                    r10 = 37
                                    o20 = 101
                                    r73 = 72
                                    o21 = 111
                                    r80 = 39
                                    r79 = 89
                                    o25 = 68
                                    r62 = 45
                                    r37 = 46
                                    r49 = 94
                                    r36 = 47
                                    o7 = 72
                                    r56 = 72
                                    o9 = 94
                                    r25 = 38
                                    r3 = 72
                                    r67 = 102
                                    r60 = 39
                                    r53 = 47
                                    o18 = 57
                                    r70 = 78
                                    r19 = 105
                                    r61 = 107
                                    r42 = 40
                                    r85 = 39
                                    o2 = 58
                                    o8 = 62
                                    r1 = 99
                                    o11 = 69
                                    r74 = 41
                                    r47 = 101
                                    r30 = 36
                                    r66 = 79
                                    r11 = 75
                                    r76 = 99
                                    r29 = 88
                                    r88 = 45
                                    r28 = 47
                                    o15 = 110
                                    r7 = 105
                                    r38 = 37
                                    o1 = 43
                                    r45 = 43
                                    r34 = 95
                                    r83 = 78
                                    o13 = 40
                                    r6 = 47
                                    r92 = 99
                                    r26 = 90
                                    r23 = 94
                                    r39 = 107
                                    r91 = 109
                                    r58 = 38
                                    r14 = 89
                                    r17 = 101
                                    r71 = 95
                                    r21 = 105
                                    r8 = 68
                                    r52 = 87
                                    o22 = 91
                                    r96 = 107
                                    r22 = 44
                                    o5 = 59
                                    r50 = 46
                                    o24 = 96
                                    o23 = 58
                                    r93 = 90
                                    r43 = 58
                                    r46 = 41
                                    r97 = 48
                                    r99 = 65
                                    r27 = 47
                                    r44 = 95
                                    r69 = 66
                                    r24 = 55
                                    r86 = 37
                                    o17 = 78
                                    o16 = 55
                                    r94 = 42
                                    r48 = 102
                                    r75 = 104
                                    r15 = 37
                                    r82 = 105
                                    r81 = 37
                                    r95 = 47
                                    r9 = 45
                                    r87 = 45
                                    ReturnVal = 94
                                    r59 = 90
                                    r90 = 105
                                    state = {
                                        ReturnVal,
                                        r98,
                                        r20,
                                        r48,
                                        r82,
                                        r97,
                                        r81,
                                        r86,
                                        r26,
                                        r71,
                                        r21,
                                        r31,
                                        r47,
                                        r75,
                                        r59,
                                        r30,
                                        r79,
                                        r35,
                                        r92,
                                        r10,
                                        r52,
                                        r67,
                                        r44,
                                        r38,
                                        r78,
                                        r33,
                                        r29,
                                        r23,
                                        r72,
                                        r17,
                                        r13,
                                        r19,
                                        r15,
                                        r85,
                                        r74,
                                        r62,
                                        r27,
                                        r16,
                                        r22,
                                        r54,
                                        r46,
                                        r60,
                                        r53,
                                        r37,
                                        r32,
                                        r25,
                                        r95,
                                        r45,
                                        r58,
                                        r88,
                                        r87,
                                        r36,
                                        r51,
                                        r43,
                                        r77,
                                        r80,
                                        r41,
                                        r7,
                                        r90,
                                        r18,
                                        r5,
                                        r64,
                                        r14,
                                        r89,
                                        r93,
                                        r12,
                                        r1,
                                        r11,
                                        r42,
                                        r65,
                                        r94,
                                        r2,
                                        r8,
                                        r73,
                                        r6,
                                        r84,
                                        r96,
                                        r28,
                                        r91,
                                        r3,
                                        r57,
                                        r83,
                                        r99,
                                        r63,
                                        r56,
                                        r69,
                                        r76,
                                        r61,
                                        r70,
                                        r66,
                                        r39,
                                        r50,
                                        r24,
                                        r49,
                                        r9,
                                        r34,
                                        o1,
                                        o2,
                                        o3,
                                        o4,
                                        o5,
                                        o6,
                                        o7,
                                        o8,
                                        o9,
                                        o10,
                                        o11,
                                        o12,
                                        o13,
                                        o14,
                                        o15,
                                        o16,
                                        o17,
                                        o18,
                                        o19,
                                        o20,
                                        o21,
                                        o22,
                                        o23,
                                        o24,
                                        o25
                                    }
                                    r20 = upvalueValues[upvalues[1]]
                                    r98 = state
                                    r48 = upvalueValues[upvalues[2]]
                                    r97 = "\235\129\031\226\020"
                                    r81 = 15778694012083
                                    r82 = r48(r97, r81)
                                    ReturnVal = r20[r82]
                                    r48 = upvalueValues[upvalues[1]]
                                    r82 = upvalueValues[upvalues[2]]
                                    r86 = 8168388660955
                                    r81 = "60\205 K\214\014\225\029\160\146\203\195@\021"
                                    r97 = r82(r81, r86)
                                    r20 = r48[r97]
                                    r82 = upvalueValues[upvalues[1]]
                                    r97 = upvalueValues[upvalues[2]]
                                    r26 = 17356696428434
                                    r86 = "\nx\204`5\2342\241\197hQ"
                                    r81 = r97(r86, r26)
                                    r48 = r82[r81]
                                    r97 = upvalueValues[upvalues[1]]
                                    r81 = upvalueValues[upvalues[2]]
                                    r71 = 33160015019089
                                    r26 = ")P\199\209^\155?LT@\149b9hHb\176A\243\199\155\142\238\149\002\167x"
                                    r86 = r81(r26, r71)
                                    r82 = r97[r86]
                                    r81 = upvalueValues[upvalues[1]]
                                    r86 = upvalueValues[upvalues[2]]
                                    r71 = "Ou\239?="
                                    r21 = 26112070971263
                                    r26 = r86(r71, r21)
                                    r97 = r81[r26]
                                    r26 = upvalueValues[upvalues[1]]
                                    r71 = upvalueValues[upvalues[2]]
                                    r31 = "\006\228y\202Ry"
                                    r47 = 34166522035750
                                    r21 = r71(r31, r47)
                                    r86 = r26[r21]
                                    r31 = upvalueValues[upvalues[1]]
                                    r47 = upvalueValues[upvalues[2]]
                                    r30 = 8956732788810
                                    r59 = "\197\174P\012"
                                    r75 = r47(r59, r30)
                                    r21 = r31[r75]
                                    r47 = upvalueValues[upvalues[1]]
                                    r75 = upvalueValues[upvalues[2]]
                                    r79 = 4275611551686
                                    r30 = "\181\255\184\132\020\030\242/_\130jfr\206{\151"
                                    r59 = r75(r30, r79)
                                    r31 = r47[r59]
                                    r75 = upvalueValues[upvalues[1]]
                                    r59 = upvalueValues[upvalues[2]]
                                    r35 = 3991498999618
                                    r79 = "\008j\2411\011"
                                    r30 = r59(r79, r35)
                                    r47 = r75[r30]
                                    r30 = upvalueValues[upvalues[1]]
                                    r79 = upvalueValues[upvalues[2]]
                                    r92 = "\2030\195\031\180V\182\"\152P\131\024\239\017\135\127\027)\249{\008\208"
                                    r10 = 16120652946770
                                    r35 = r79(r92, r10)
                                    r59 = r30[r35]
                                    r35 = upvalueValues[upvalues[4]]
                                    r10 = upvalueValues[upvalues[1]]
                                    r52 = upvalueValues[upvalues[2]]
                                    r44 = "6&\028W"
                                    r38 = 26790259765435
                                    r67 = r52(r44, r38)
                                    r92 = r10[r67]
                                    r79 = r35[r92]
                                    r10 = upvalueValues[upvalues[1]]
                                    r52 = upvalueValues[upvalues[2]]
                                    r38 = 1968179381140
                                    r44 = "*\223"
                                    r67 = r52(r44, r38)
                                    r92 = r10[r67]
                                    r67 = upvalueValues[upvalues[1]]
                                    r44 = upvalueValues[upvalues[2]]
                                    r78 = "\137/X\"\019\223\236|O\128t\238xT,\021\239>c}\158\168\141\190\008i"
                                    r33 = 32903209548761
                                    r38 = r44(r78, r33)
                                    r52 = r67[r38]
                                    r38 = upvalueValues[upvalues[4]]
                                    r33 = upvalueValues[upvalues[1]]
                                    r29 = upvalueValues[upvalues[2]]
                                    r72 = "\216eF\011\n\200A\217\170.\170"
                                    r17 = 32059319663184
                                    r23 = r29(r72, r17)
                                    r78 = r33[r23]
                                    r44 = r38[r78]
                                    r33 = upvalueValues[upvalues[1]]
                                    r29 = upvalueValues[upvalues[2]]
                                    r17 = 10463526523656
                                    r72 = "\232\007"
                                    r23 = r29(r72, r17)
                                    r78 = r33[r23]
                                    r23 = upvalueValues[upvalues[1]]
                                    r72 = upvalueValues[upvalues[2]]
                                    r13 = "\237\150\178\148\252\127|w\162\n\211\240\162\213vXc1\211\212\006\203\164f"
                                    r19 = 34091428167171
                                    r17 = r72(r13, r19)
                                    r29 = r23[r17]
                                    r17 = upvalueValues[upvalues[1]]
                                    r13 = upvalueValues[upvalues[2]]
                                    r85 = 11333850977437
                                    r15 = "\148"
                                    r19 = r13(r15, r85)
                                    r72 = r17[r19]
                                    r23 = r40 .. r72
                                    r33 = r29 .. r23
                                    r38 = r78 .. r33
                                    r67 = r44 .. r38
                                    r10 = r52 .. r67
                                    r35 = r92 .. r10
                                    r30 = r79 .. r35
                                    r75 = r59 .. r30
                                    r30 = upvalueValues[upvalues[1]]
                                    r79 = upvalueValues[upvalues[2]]
                                    r10 = 22642995718447
                                    r92 = "1V\154\159\183\011"
                                    r35 = r79(r92, r10)
                                    r59 = r30[r35]
                                    r30 = false
                                    r71 = {
                                        [r21] = r31,
                                        [r47] = r75,
                                        [r59] = r30
                                    }
                                    r47 = upvalueValues[upvalues[1]]
                                    r75 = upvalueValues[upvalues[2]]
                                    r79 = 32553496230710
                                    r30 = "\211T}\149"
                                    r59 = r75(r30, r79)
                                    r31 = r47[r59]
                                    r75 = upvalueValues[upvalues[1]]
                                    r59 = upvalueValues[upvalues[2]]
                                    r35 = 19877259322408
                                    r79 = "J\231(\133/:-B\229F|sU`\228M"
                                    r30 = r59(r79, r35)
                                    r47 = r75[r30]
                                    r59 = upvalueValues[upvalues[1]]
                                    r30 = upvalueValues[upvalues[2]]
                                    r92 = 12553291093717
                                    r35 = "\189\232\238n\154"
                                    r79 = r30(r35, r92)
                                    r75 = r59[r79]
                                    r79 = upvalueValues[upvalues[1]]
                                    r35 = upvalueValues[upvalues[2]]
                                    r10 = "v\134\t\150\008\132\175\203\nB_\210+4\225\003\162\135\190<\203"
                                    r52 = 6305816693624
                                    r92 = r35(r10, r52)
                                    r30 = r79[r92]
                                    r92 = "tostring"
                                    r35 = _env[r92]
                                    r92 = r35(r4)
                                    r52 = upvalueValues[upvalues[1]]
                                    r67 = upvalueValues[upvalues[2]]
                                    r78 = 13914324130127
                                    r38 = "D\253"
                                    r44 = r67(r38, r78)
                                    r10 = r52[r44]
                                    r44 = upvalueValues[upvalues[1]]
                                    r38 = upvalueValues[upvalues[2]]
                                    r33 = "!8g\209p\029\025\199\166\173\170\144\161w\224\018$s\244e4\"|\210"
                                    r29 = 8107331194559
                                    r78 = r38(r33, r29)
                                    r67 = r44[r78]
                                    r78 = upvalueValues[upvalues[1]]
                                    r33 = upvalueValues[upvalues[2]]
                                    r72 = 18975355986564
                                    r23 = "\127\141\202\008\027^\135\214\145?^\214U\184"
                                    r29 = r33(r23, r72)
                                    r38 = r78[r29]
                                    r29 = upvalueValues[upvalues[1]]
                                    r23 = upvalueValues[upvalues[2]]
                                    r17 = "$y\176\127"
                                    r13 = 22237979633779
                                    r72 = r23(r17, r13)
                                    r33 = r29[r72]
                                    r78 = r55 .. r33
                                    r44 = r38 .. r78
                                    r52 = r67 .. r44
                                    r35 = r10 .. r52
                                    r79 = r92 .. r35
                                    r59 = r30 .. r79
                                    r79 = upvalueValues[upvalues[1]]
                                    r35 = upvalueValues[upvalues[2]]
                                    r52 = 2819920397601
                                    r10 = "\147rH\008\247\144"
                                    r92 = r35(r10, r52)
                                    r30 = r79[r92]
                                    r79 = false
                                    r21 = {
                                        [r31] = r47,
                                        [r75] = r59,
                                        [r30] = r79
                                    }
                                    r67 = 5204174784887
                                    r23 = "game"
                                    r29 = 12724732352293
                                    r19 = "\004\236x45\139*"
                                    r81 = 65280
                                    r15 = 22560871229705
                                    r75 = upvalueValues[upvalues[1]]
                                    r59 = upvalueValues[upvalues[2]]
                                    r35 = 28630377477140
                                    r79 = "\017\221\167H"
                                    r30 = r59(r79, r35)
                                    r47 = r75[r30]
                                    r52 = "\t\210\176\205\222\169G\246XA;\134\018F\003\232\179\176\234*\189\184\150"
                                    r59 = upvalueValues[upvalues[1]]
                                    r30 = upvalueValues[upvalues[2]]
                                    r92 = 24310108449848
                                    r35 = "\178\216f\194\224\028\216y\187\220\2322]\239"
                                    r79 = r30(r35, r92)
                                    r38 = "\242\205"
                                    r92 = "\022\165\187\130]"
                                    r40 = nil
                                    r75 = r59[r79]
                                    r10 = 4556343691337
                                    r4 = nil
                                    r30 = upvalueValues[upvalues[1]]
                                    r79 = upvalueValues[upvalues[2]]
                                    r35 = r79(r92, r10)
                                    r59 = r30[r35]
                                    r35 = upvalueValues[upvalues[1]]
                                    r92 = upvalueValues[upvalues[2]]
                                    r10 = r92(r52, r67)
                                    r79 = r35[r10]
                                    r52 = upvalueValues[upvalues[1]]
                                    r67 = upvalueValues[upvalues[2]]
                                    r78 = 4904430356715
                                    r44 = r67(r38, r78)
                                    r10 = r52[r44]
                                    r44 = upvalueValues[upvalues[1]]
                                    r38 = upvalueValues[upvalues[2]]
                                    r33 = "\140\130\025\145`]\015@#\"\159\2458\175\205\129\011\160Ua\187\1738\197\029\176\215\218\004\011\239#\219mP\198%I\254\220\213\129\236{\130\167\250\137og\206=\008\184f\027'\2434\235\021\134\215\202"
                                    r78 = r38(r33, r29)
                                    r67 = r44[r78]
                                    r78 = "tostring"
                                    r38 = _env[r78]
                                    r29 = _env[r23]
                                    r72 = upvalueValues[upvalues[1]]
                                    r17 = upvalueValues[upvalues[2]]
                                    r13 = r17(r19, r15)
                                    r23 = r72[r13]
                                    r33 = r29[r23]
                                    r78 = r38(r33)
                                    r33 = upvalueValues[upvalues[1]]
                                    r29 = upvalueValues[upvalues[2]]
                                    r17 = 2880073286973
                                    r72 = "\236"
                                    r23 = r29(r72, r17)
                                    r38 = r33[r23]
                                    r44 = r78 .. r38
                                    r52 = r67 .. r44
                                    r92 = r10 .. r52
                                    r35 = r68 .. r92
                                    r30 = r79 .. r35
                                    r52 = "Y\153To\2155"
                                    r67 = 3652431234724
                                    r55 = nil
                                    r35 = upvalueValues[upvalues[1]]
                                    r92 = upvalueValues[upvalues[2]]
                                    r10 = r92(r52, r67)
                                    r79 = r35[r10]
                                    r35 = false
                                    r31 = {
                                        [r47] = r75,
                                        [r59] = r30,
                                        [r79] = r35
                                    }
                                    r26 = {
                                        r71,
                                        r21,
                                        r31
                                    }
                                    r21 = upvalueValues[upvalues[1]]
                                    r31 = upvalueValues[upvalues[2]]
                                    r59 = 21543021160239
                                    r75 = "\151\134\136w\250\171"
                                    r47 = r31(r75, r59)
                                    r71 = r21[r47]
                                    r47 = upvalueValues[upvalues[1]]
                                    r75 = upvalueValues[upvalues[2]]
                                    r30 = "\138jR\004"
                                    r79 = 11836806075783
                                    r59 = r75(r30, r79)
                                    r31 = r47[r59]
                                    r75 = upvalueValues[upvalues[1]]
                                    r59 = upvalueValues[upvalues[2]]
                                    r35 = 7928042786411
                                    r79 = "\142\203\028\006\207\012QtL7'n"
                                    r30 = r59(r79, r35)
                                    r47 = r75[r30]
                                    r21 = {
                                        [r31] = r47
                                    }
                                    r68 = nil
                                    state = {
                                        [ReturnVal] = r20,
                                        [r48] = r82,
                                        [r97] = r81,
                                        [r86] = r26,
                                        [r71] = r21
                                    }
                                    r20 = state
                                    ReturnVal = "SendMessageEMBED"
                                    state = _env[ReturnVal]
                                    r48 = upvalueValues[upvalues[5]]
                                    r97 = 10
                                    r82 = r48(r98, r97)
                                    ReturnVal = state(r82, r20)
                                    r98 = nil
                                    r20 = nil
                                    ReturnVal = {}
                                    state = nil
                                end
                            else
                                -- createClosure entry 13815029 -> 71, states 71-71
                                if state == 71 then -- entry 13815029 -> 71
                                    ReturnVal = "loadstring"
                                    state = _env[ReturnVal]
                                    r55 = {
                                        select(1, unpack(args))
                                    }
                                    r68 = "game"
                                    r40 = _env[r68]
                                    r98 = upvalueValues[upvalues[1]]
                                    r20 = upvalueValues[upvalues[2]]
                                    r82 = "~-fh\197\245\r\205\138r\207}a0\\\024\154\007\217\137\200\024\031\195\022\201a\006\164\020Z{\134\002\138\249Q\162\254\134F\025\130v\152\015\255yq\216=n{\209\224#\138\164\017O\165\019wIH\024\158vJN\137(\129B\254?\136\227\173u\028\195\130\159\247\143\247\"\252\002"
                                    r97 = 25534520159858
                                    r48 = r20(r82, r97)
                                    r4 = r98[r48]
                                    r98 = "HttpGet"
                                    r98 = r40[r98]
                                    r68 = {
                                        r98(r40, r4)
                                    }
                                    ReturnVal = state(unpack(r68))
                                    state = ReturnVal()
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        else
                            -- createClosure4 entry 1799324 -> 72, states 72-72
                            if state == 72 then -- entry 1799324 -> 72
                                r40 = "dtAyokz25u7Lk"
                                r68 = 4293754
                                r55 = r40 ^ r68
                                ReturnVal = 4753650
                                state = ReturnVal - r55
                                r55 = state
                                ReturnVal = "yG"
                                state = ReturnVal / r55
                                ReturnVal = {
                                    state
                                }
                                state = nil
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
                upvalueRefCounts[upvalueId], captureIndex = upvalueRefCounts[upvalueId] - (1), captureIndex + (1)
                if 0 == upvalueRefCounts[upvalueId] then
                    upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
                end
                upvalueId = captures[captureIndex]
            end
        end
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if 0 == upvalueRefCounts[upvalueId] then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
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
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)