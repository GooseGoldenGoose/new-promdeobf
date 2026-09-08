return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, releaseUpvalue, vm, createClosure2, createClosure6, createClosure4, createClosure7, createClosure0, allocUpvalue, createClosure3, createClosure, createClosure1, createClosure5, currentUpvalueId, createUpvalueProxy, upvalueValues, releaseUpvalues, upvalueRefCounts)
        createClosure = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(...)
                return vm(entryId, {
                    ...
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
                    return -3437010
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -3437010
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
        upvalueValues = {}
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
        currentUpvalueId = 0
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
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, ReturnVal, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43
            while state do
                if state <= 146 then
                    if state <= 64 then
                        if state <= 46 then
                            if state <= 33 then
                                if state <= 32 then
                                    if state <= 31 then
                                        -- root entry 8397644 -> 1, states 1-31
                                        if state <= 16 then
                                            if state <= 8 then
                                                if state <= 4 then
                                                    if state <= 2 then
                                                        if state <= 1 then
                                                            if state == 1 then -- entry 8397644 -> 1
                                                                r27 = allocUpvalue()
                                                                r2 = allocUpvalue()
                                                                state = true
                                                                upvalueValues[r27] = state
                                                                r36 = "string"
                                                                ReturnVal = _env[r36]
                                                                r39 = allocUpvalue()
                                                                r3 = createClosure0(32, {
                                                                    r39
                                                                })
                                                                r36 = "gmatch"
                                                                state = ReturnVal[r36]
                                                                r36 = allocUpvalue()
                                                                upvalueValues[r36] = state
                                                                state = createClosure1(33, {})
                                                                upvalueValues[r2] = state
                                                                state = false
                                                                upvalueValues[r39] = state
                                                                r26 = "pcall"
                                                                r8 = _env[r26]
                                                                r26 = r8(r3)
                                                                state = r26 and (2) or (3)
                                                                r14 = args
                                                                ReturnVal = r26
                                                            end
                                                        else
                                                            if state == 2 then
                                                                r8 = upvalueValues[r39]
                                                                ReturnVal = r8
                                                                state = 3
                                                            end
                                                        end
                                                    else
                                                        if state <= 3 then
                                                            if state == 3 then
                                                                r8 = ReturnVal
                                                                r26 = "math"
                                                                ReturnVal = _env[r26]
                                                                r26 = "random"
                                                                state = ReturnVal[r26]
                                                                r26 = allocUpvalue()
                                                                upvalueValues[r26] = state
                                                                r3 = "table"
                                                                ReturnVal = _env[r3]
                                                                r3 = "concat"
                                                                state = ReturnVal[r3]
                                                                r3 = state
                                                                r22 = state
                                                                r37 = "table"
                                                                r11 = _env[r37]
                                                                state = r11 and (4) or (5)
                                                                r43 = r11
                                                            end
                                                        else
                                                            if state == 4 then
                                                                r5 = "table"
                                                                r37 = _env[r5]
                                                                r5 = "unpack"
                                                                r11 = r37[r5]
                                                                r43 = r11
                                                                state = 5
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 6 then
                                                        if state <= 5 then
                                                            if state == 5 then
                                                                state = r22
                                                                state = r43 and (6) or (7)
                                                                ReturnVal = r43
                                                            end
                                                        else
                                                            if state == 6 then
                                                                r43 = allocUpvalue()
                                                                upvalueValues[r43] = ReturnVal
                                                                r38 = createClosure2(34, {})
                                                                state = upvalueValues[r26]
                                                                r11 = 65
                                                                r22 = 3
                                                                ReturnVal = state(r22, r11)
                                                                r22 = allocUpvalue()
                                                                upvalueValues[r22] = ReturnVal
                                                                state = 0
                                                                r11 = state
                                                                state = 0
                                                                r5 = "pcall"
                                                                ReturnVal = _env[r5]
                                                                r5 = {
                                                                    ReturnVal(r38)
                                                                }
                                                                r37 = state
                                                                state = {
                                                                    unpack(r5)
                                                                }
                                                                r5 = state
                                                                ReturnVal = 2
                                                                state = r5[ReturnVal]
                                                                r38 = state
                                                                ReturnVal = "tonumber"
                                                                state = _env[ReturnVal]
                                                                r41 = upvalueValues[r36]
                                                                r15 = "tostring"
                                                                r28 = _env[r15]
                                                                r15 = r28(r38)
                                                                r28 = ":(%d*):"
                                                                r42 = r41(r15, r28)
                                                                r41 = {
                                                                    r42()
                                                                }
                                                                ReturnVal = state(unpack(r41))
                                                                r41 = allocUpvalue()
                                                                upvalueValues[r41] = ReturnVal
                                                                r42 = upvalueValues[r22]
                                                                r28 = r42
                                                                r42 = 1
                                                                r15 = r42
                                                                r42 = 0
                                                                r32 = r15 < r42
                                                                ReturnVal = 1
                                                                r42 = ReturnVal - r15
                                                                state = 8
                                                            end
                                                        end
                                                    else
                                                        if state <= 7 then
                                                            if state == 7 then
                                                                r22 = "unpack"
                                                                r43 = _env[r22]
                                                                ReturnVal = r43
                                                                state = 6
                                                            end
                                                        else
                                                            if state == 8 then
                                                                r42 = r42 + r15
                                                                ReturnVal = r42 <= r28
                                                                r24 = not r32
                                                                ReturnVal = r24 and ReturnVal
                                                                r24 = r42 >= r28
                                                                r24 = r32 and r24
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
                                                                upvalueValues[r24] = r42
                                                                r30 = "math"
                                                                ReturnVal = _env[r30]
                                                                r30 = "random"
                                                                state = ReturnVal[r30]
                                                                r30 = 1
                                                                r40 = 100
                                                                ReturnVal = state(r30, r40)
                                                                r30 = allocUpvalue()
                                                                upvalueValues[r30] = ReturnVal
                                                                state = upvalueValues[r26]
                                                                r1 = 255
                                                                r40 = 0
                                                                ReturnVal = state(r40, r1)
                                                                r40 = allocUpvalue()
                                                                upvalueValues[r40] = ReturnVal
                                                                state = upvalueValues[r26]
                                                                r29 = upvalueValues[r30]
                                                                r1 = 1
                                                                ReturnVal = state(r1, r29)
                                                                r1 = allocUpvalue()
                                                                upvalueValues[r1] = ReturnVal
                                                                ReturnVal = upvalueValues[r26]
                                                                r31 = 2
                                                                r18 = 1
                                                                r29 = ReturnVal(r18, r31)
                                                                ReturnVal = 1
                                                                state = r29 == ReturnVal
                                                                r29 = allocUpvalue()
                                                                upvalueValues[r29] = state
                                                                r19 = "tostring"
                                                                r35 = _env[r19]
                                                                state = "gsub"
                                                                state = r38[state]
                                                                r17 = upvalueValues[r26]
                                                                r7 = 10000
                                                                r4 = 0
                                                                r12 = {
                                                                    r17(r4, r7)
                                                                }
                                                                r19 = r35(unpack(r12))
                                                                r35 = ":"
                                                                r34 = r19 .. r35
                                                                r31 = ":"
                                                                r18 = r31 .. r34
                                                                ReturnVal = ":(%d*):"
                                                                state = state(r38, ReturnVal, r18)
                                                                r18 = allocUpvalue()
                                                                upvalueValues[r18] = state
                                                                r34 = createClosure5(35, {
                                                                    r26,
                                                                    r24,
                                                                    r22,
                                                                    r36,
                                                                    r27,
                                                                    r41,
                                                                    r29,
                                                                    r18,
                                                                    r30,
                                                                    r1,
                                                                    r40,
                                                                    r43
                                                                })
                                                                r31 = "pcall"
                                                                ReturnVal = _env[r31]
                                                                r31 = {
                                                                    ReturnVal(r34)
                                                                }
                                                                state = {
                                                                    unpack(r31)
                                                                }
                                                                r31 = state
                                                                state = upvalueValues[r29]
                                                                state = state and (11) or (12)
                                                            end
                                                        else
                                                            if state == 10 then
                                                                r28 = upvalueValues[r27]
                                                                state = r28 and (13) or (14)
                                                                r42 = r28
                                                            end
                                                        end
                                                    else
                                                        if state <= 11 then
                                                            if state == 11 then
                                                                r34 = upvalueValues[r27]
                                                                state = r34 and (15) or (16)
                                                                ReturnVal = r34
                                                            end
                                                        else
                                                            if state == 12 then
                                                                r35 = upvalueValues[r27]
                                                                state = r35 and (17) or (18)
                                                                r34 = r35
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 14 then
                                                        if state <= 13 then
                                                            if state == 13 then
                                                                r28 = r11 == r37
                                                                r42 = r28
                                                                state = 14
                                                            end
                                                        else
                                                            if state == 14 then
                                                                upvalueValues[r27] = r42
                                                                state = upvalueValues[r27]
                                                                state = state and (19) or (20)
                                                            end
                                                        end
                                                    else
                                                        if state <= 15 then
                                                            if state == 15 then
                                                                r35 = state
                                                                r12 = 1
                                                                r17 = r31[r12]
                                                                r12 = false
                                                                r19 = r17 == r12
                                                                state = r19 and (21) or (22)
                                                                r34 = r19
                                                            end
                                                        else
                                                            if state == 16 then
                                                                upvalueValues[r27] = ReturnVal
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
                                                                r19 = 1
                                                                r35 = r31[r19]
                                                                r34 = r35
                                                                state = 18
                                                            end
                                                        else
                                                            if state == 18 then
                                                                upvalueValues[r27] = r34
                                                                r12 = upvalueValues[r1]
                                                                r4 = 1
                                                                r17 = r12 + r4
                                                                r19 = r31[r17]
                                                                r35 = r11 + r19
                                                                r19 = 256
                                                                state = r35 % r19
                                                                r11 = state
                                                                r17 = upvalueValues[r40]
                                                                r19 = r37 + r17
                                                                r17 = 256
                                                                r35 = r19 % r17
                                                                r37 = r35
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
                                                                r12 = 2
                                                                r17 = r31[r12]
                                                                r12 = upvalueValues[r18]
                                                                r19 = r17 == r12
                                                                r34 = r19
                                                                state = 22
                                                            end
                                                        else
                                                            if state == 22 then
                                                                state = r35
                                                                ReturnVal = r34
                                                                state = 16
                                                            end
                                                        end
                                                    else
                                                        if state <= 23 then
                                                            if state == 23 then
                                                                r24 = releaseUpvalue(r24)
                                                                r1 = releaseUpvalue(r1)
                                                                r18 = releaseUpvalue(r18)
                                                                r29 = releaseUpvalue(r29)
                                                                r30 = releaseUpvalue(r30)
                                                                r40 = releaseUpvalue(r40)
                                                                r31 = nil
                                                                state = 8
                                                            end
                                                        else
                                                            if state == 24 then
                                                                r27 = releaseUpvalue(r27)
                                                                r26 = releaseUpvalue(r26)
                                                                r39 = releaseUpvalue(r39)
                                                                r41 = releaseUpvalue(r41)
                                                                r22 = releaseUpvalue(r22)
                                                                r2 = releaseUpvalue(r2)
                                                                r43 = releaseUpvalue(r43)
                                                                r11 = nil
                                                                r11 = {}
                                                                r36 = releaseUpvalue(r36)
                                                                r2 = allocUpvalue()
                                                                r27 = nil
                                                                upvalueValues[r2] = r27
                                                                r22 = allocUpvalue()
                                                                r27 = allocUpvalue()
                                                                r36 = nil
                                                                upvalueValues[r27] = r36
                                                                r8 = nil
                                                                r8 = "math"
                                                                r39 = _env[r8]
                                                                r8 = "floor"
                                                                r36 = r39[r8]
                                                                r39 = allocUpvalue()
                                                                upvalueValues[r39] = r36
                                                                r26 = "math"
                                                                r8 = _env[r26]
                                                                r26 = "random"
                                                                r36 = r8[r26]
                                                                r3 = nil
                                                                r3 = "table"
                                                                r26 = _env[r3]
                                                                r3 = "remove"
                                                                r8 = r26[r3]
                                                                r43 = "string"
                                                                r3 = _env[r43]
                                                                r43 = "char"
                                                                r26 = r3[r43]
                                                                r37 = nil
                                                                r37 = allocUpvalue()
                                                                r43 = allocUpvalue()
                                                                r3 = 0
                                                                upvalueValues[r43] = r3
                                                                r3 = 2
                                                                upvalueValues[r22] = r3
                                                                upvalueValues[r37] = r11
                                                                r3 = {}
                                                                r5 = nil
                                                                r5 = {}
                                                                r41 = 256
                                                                r32 = r41
                                                                r41 = 1
                                                                r24 = r41
                                                                r41 = 0
                                                                r30 = r24 < r41
                                                                r38 = nil
                                                                r38 = 1
                                                                r41 = r38 - r24
                                                                r11 = 0
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
                                                                state = createClosure5(47, {
                                                                    r2
                                                                })
                                                                r28 = {
                                                                    state()
                                                                }
                                                                ReturnVal = {
                                                                    unpack(r28)
                                                                }
                                                                state = nil
                                                            end
                                                        else
                                                            if state == 26 then
                                                                r40 = not r30
                                                                r41 = r41 + r24
                                                                r38 = r41 <= r32
                                                                r38 = r40 and r38
                                                                r40 = r41 >= r32
                                                                r40 = r30 and r40
                                                                r38 = r40 or r38
                                                                r40 = (27)
                                                                state = r38 and r40
                                                                r38 = (28)
                                                                state = state or r38
                                                            end
                                                        end
                                                    else
                                                        if state <= 27 then
                                                            if state == 27 then
                                                                r38 = r41
                                                                r40 = r38
                                                                r5[r38] = r40
                                                                r38 = nil
                                                                state = 26
                                                            end
                                                        else
                                                            if state == 28 then
                                                                r41 = #r5
                                                                r32 = 0
                                                                r38 = r41 == r32
                                                                state = 29
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 30 then
                                                        if state <= 29 then
                                                            if state == 29 then
                                                                r32 = #r5
                                                                r41 = 1
                                                                r38 = r36(r41, r32)
                                                                r41 = r8(r5, r38)
                                                                r38 = nil
                                                                r32 = upvalueValues[r37]
                                                                r40 = 1
                                                                r30 = r41 - r40
                                                                r24 = r26(r30)
                                                                r32[r41] = r24
                                                                r41 = nil
                                                                state = 30
                                                            end
                                                        else
                                                            if state == 30 then
                                                                r41 = #r5
                                                                r32 = 0
                                                                r38 = r41 == r32
                                                                state = r38 and (31) or (29)
                                                            end
                                                        end
                                                    else
                                                        if state == 31 then
                                                            r31 = "__metatable"
                                                            r41 = allocUpvalue()
                                                            r32 = createClosure0(51, {
                                                                r41,
                                                                r43,
                                                                r22,
                                                                r39
                                                            })
                                                            r38 = {}
                                                            upvalueValues[r41] = r38
                                                            r19 = nil
                                                            r38 = allocUpvalue()
                                                            r29 = "__index"
                                                            r40 = {}
                                                            r24 = allocUpvalue()
                                                            upvalueValues[r38] = r32
                                                            r32 = {}
                                                            r26 = nil
                                                            r39 = releaseUpvalue(r39)
                                                            upvalueValues[r24] = r32
                                                            r30 = "setmetatable"
                                                            r32 = _env[r30]
                                                            r18 = upvalueValues[r24]
                                                            r8 = nil
                                                            r1 = {
                                                                [r29] = r18,
                                                                [r31] = r19
                                                            }
                                                            r30 = r32(r40, r1)
                                                            r8 = "task"
                                                            r32 = createClosure7(57, {
                                                                r24,
                                                                r41,
                                                                r37,
                                                                r43,
                                                                r22,
                                                                r38
                                                            })
                                                            upvalueValues[r27] = r30
                                                            r41 = releaseUpvalue(r41)
                                                            r43 = releaseUpvalue(r43)
                                                            r38 = releaseUpvalue(r38)
                                                            r37 = releaseUpvalue(r37)
                                                            r22 = releaseUpvalue(r22)
                                                            upvalueValues[r2] = r32
                                                            r24 = releaseUpvalue(r24)
                                                            r39 = _env[r8]
                                                            r26 = upvalueValues[r27]
                                                            r3 = nil
                                                            r3 = upvalueValues[r2]
                                                            r22 = "@\204\n\232o"
                                                            r11 = nil
                                                            r11 = 30322711263016
                                                            r43 = r3(r22, r11)
                                                            r8 = r26[r43]
                                                            r36 = nil
                                                            r36 = r39[r8]
                                                            r8 = createClosure5(64, {
                                                                r27,
                                                                r2
                                                            })
                                                            r39 = r36(r8)
                                                            r39 = "game"
                                                            r36 = _env[r39]
                                                            r26 = upvalueValues[r27]
                                                            r3 = upvalueValues[r2]
                                                            r11 = 34198938811957
                                                            r22 = "s\192 XQ\025#\181\198z\145"
                                                            r43 = r3(r22, r11)
                                                            r39 = "GetService"
                                                            r39 = r36[r39]
                                                            r8 = r26[r43]
                                                            r39 = r39(r36, r8)
                                                            r36 = allocUpvalue()
                                                            r8 = "game"
                                                            upvalueValues[r36] = r39
                                                            r39 = _env[r8]
                                                            r3 = upvalueValues[r27]
                                                            r8 = "GetService"
                                                            r43 = upvalueValues[r2]
                                                            r37 = 26823539699914
                                                            r11 = ":\234\001\2139\199:"
                                                            r22 = r43(r11, r37)
                                                            r26 = r3[r22]
                                                            r8 = r39[r8]
                                                            r8 = r8(r39, r26)
                                                            r26 = "game"
                                                            r39 = _env[r26]
                                                            r43 = upvalueValues[r27]
                                                            r22 = upvalueValues[r2]
                                                            r5 = nil
                                                            r5 = 34437041258147
                                                            r37 = "\163#\004\247\190i\236g\170p\135\014\027\239\148%r\190"
                                                            r11 = r22(r37, r5)
                                                            r3 = r43[r11]
                                                            r26 = "GetService"
                                                            r26 = r39[r26]
                                                            r26 = r26(r39, r3)
                                                            r3 = "game"
                                                            r39 = _env[r3]
                                                            r22 = upvalueValues[r27]
                                                            r11 = upvalueValues[r2]
                                                            r38 = 16690961440348
                                                            r5 = "4\174\171\142\127\191s\144\212\176O.]J]\209"
                                                            r37 = r11(r5, r38)
                                                            r43 = r22[r37]
                                                            r3 = "GetService"
                                                            r3 = r39[r3]
                                                            r3 = r3(r39, r43)
                                                            r39 = allocUpvalue()
                                                            upvalueValues[r39] = r3
                                                            r22 = upvalueValues[r27]
                                                            r11 = upvalueValues[r2]
                                                            r38 = 27163928162665
                                                            r5 = "B\165%\247\001\007&\005\200\212\222"
                                                            r37 = r11(r5, r38)
                                                            r43 = r22[r37]
                                                            r3 = r8[r43]
                                                            r43 = allocUpvalue()
                                                            r19 = "\017f\012\246\228\216L"
                                                            upvalueValues[r43] = r3
                                                            r22 = upvalueValues[r43]
                                                            r37 = upvalueValues[r27]
                                                            r5 = upvalueValues[r2]
                                                            r41 = "+\251l\228\243\168"
                                                            r32 = 14871704574733
                                                            r38 = r5(r41, r32)
                                                            r11 = r37[r38]
                                                            r3 = r22[r11]
                                                            r22 = allocUpvalue()
                                                            upvalueValues[r22] = r3
                                                            r11 = upvalueValues[r43]
                                                            r5 = upvalueValues[r27]
                                                            r38 = upvalueValues[r2]
                                                            r24 = 22675724167487
                                                            r32 = "\1587\190\200Z\181~,\192b\231"
                                                            r41 = r38(r32, r24)
                                                            r37 = r5[r41]
                                                            r3 = r11[r37]
                                                            r11 = allocUpvalue()
                                                            upvalueValues[r11] = r3
                                                            r37 = upvalueValues[r43]
                                                            r38 = upvalueValues[r27]
                                                            r41 = upvalueValues[r2]
                                                            r40 = 23312439749223
                                                            r24 = "\207\227\139\219"
                                                            r32 = r41(r24, r40)
                                                            r5 = r38[r32]
                                                            r3 = r37[r5]
                                                            r37 = allocUpvalue()
                                                            upvalueValues[r37] = r3
                                                            r5 = upvalueValues[r43]
                                                            r41 = upvalueValues[r27]
                                                            r32 = upvalueValues[r2]
                                                            r1 = 32468252769039
                                                            r40 = "\014\252f\179\1771]\245F\139"
                                                            r24 = r32(r40, r1)
                                                            r38 = r41[r24]
                                                            r3 = r5[r38]
                                                            r5 = allocUpvalue()
                                                            upvalueValues[r5] = r3
                                                            r3 = createClosure4(65, {
                                                                r43,
                                                                r27,
                                                                r2
                                                            })
                                                            r38 = r3()
                                                            r3 = allocUpvalue()
                                                            upvalueValues[r3] = r38
                                                            r38 = createClosure1(70, {
                                                                r39,
                                                                r27,
                                                                r2
                                                            })
                                                            r41 = r38()
                                                            r38 = allocUpvalue()
                                                            upvalueValues[r38] = r41
                                                            r32 = "GetProductInfo"
                                                            r32 = r26[r32]
                                                            r1 = "game"
                                                            r40 = _env[r1]
                                                            r29 = upvalueValues[r27]
                                                            r18 = upvalueValues[r2]
                                                            r17 = 22736951175515
                                                            r31 = r18(r19, r17)
                                                            r1 = r29[r31]
                                                            r24 = r40[r1]
                                                            r31 = 28850313671802
                                                            r32 = r32(r26, r24)
                                                            r40 = upvalueValues[r27]
                                                            r1 = upvalueValues[r2]
                                                            r18 = "r\177T\023"
                                                            r29 = r1(r18, r31)
                                                            r24 = r40[r29]
                                                            r41 = r32[r24]
                                                            r24 = createClosure2(89, {
                                                                r27,
                                                                r2
                                                            })
                                                            r32 = allocUpvalue()
                                                            upvalueValues[r32] = r41
                                                            r19 = "]x\222\131\130\151\191\147\240\234\151\187\171\178\147\171s4}.\027\191g\026`:\008m\017\221\131EJ\239\008\189\228\182\169\254f\152\171\014A\134\208H9\238\165}\136\240*P\193ePs2\145\169\143\160CO6\212\170xA\183)/\199G[J\236[8q\008\230\141\024\006\252\214J\140\191\023\183\251\13625\220\165-\031\222c\238\202=4\140p\008\211\212\160|\005{,>\231"
                                                            r41 = allocUpvalue()
                                                            upvalueValues[r41] = r24
                                                            r24 = createClosure4(122, {
                                                                r27,
                                                                r2
                                                            })
                                                            r29 = upvalueValues[r27]
                                                            r18 = upvalueValues[r2]
                                                            r17 = 29105493521649
                                                            r31 = r18(r19, r17)
                                                            r1 = r29[r31]
                                                            r19 = "\234ak"
                                                            r29 = createClosure5(129, {
                                                                r41,
                                                                r27,
                                                                r2,
                                                                r22,
                                                                r11,
                                                                r37,
                                                                r5,
                                                                r3,
                                                                r38,
                                                                r32,
                                                                r36
                                                            })
                                                            r18 = {
                                                                r29()
                                                            }
                                                            r40 = r24(r1, unpack(r18))
                                                            r1 = "Instance"
                                                            r40 = _env[r1]
                                                            r43 = releaseUpvalue(r43)
                                                            r29 = upvalueValues[r27]
                                                            r18 = upvalueValues[r2]
                                                            r17 = 19737619588071
                                                            r31 = r18(r19, r17)
                                                            r1 = r29[r31]
                                                            r7 = 34891995168631
                                                            r4 = 27311584113069
                                                            r12 = 27926555325132
                                                            r20 = 8831415750672
                                                            r25 = 29158781056266
                                                            r23 = "\186\252\149\193@\191\000"
                                                            r8 = nil
                                                            r24 = r40[r1]
                                                            r29 = upvalueValues[r27]
                                                            r19 = "\021\171\164P\206\172\235\151\011"
                                                            r18 = upvalueValues[r2]
                                                            r17 = 10605686444874
                                                            r31 = r18(r19, r17)
                                                            r1 = r29[r31]
                                                            r40 = r24(r1)
                                                            r24 = allocUpvalue()
                                                            upvalueValues[r24] = r40
                                                            r29 = "Instance"
                                                            r1 = _env[r29]
                                                            ReturnVal = {}
                                                            r18 = upvalueValues[r27]
                                                            r31 = upvalueValues[r2]
                                                            r17 = "C\236\175"
                                                            r19 = r31(r17, r12)
                                                            r29 = r18[r19]
                                                            r40 = r1[r29]
                                                            r18 = upvalueValues[r27]
                                                            r31 = upvalueValues[r2]
                                                            r17 = "\235]\004\131p"
                                                            r12 = 16978190737122
                                                            r19 = r31(r17, r12)
                                                            r29 = r18[r19]
                                                            r1 = r40(r29)
                                                            r40 = allocUpvalue()
                                                            upvalueValues[r40] = r1
                                                            r18 = "Instance"
                                                            r29 = _env[r18]
                                                            r31 = upvalueValues[r27]
                                                            r19 = upvalueValues[r2]
                                                            r12 = "\018f\008"
                                                            r17 = r19(r12, r4)
                                                            r18 = r31[r17]
                                                            r1 = r29[r18]
                                                            r31 = upvalueValues[r27]
                                                            r19 = upvalueValues[r2]
                                                            r4 = 18318518018386
                                                            r12 = "!\004}F\157\026%\177"
                                                            r17 = r19(r12, r4)
                                                            r18 = r31[r17]
                                                            r29 = r1(r18)
                                                            r31 = "Instance"
                                                            r18 = _env[r31]
                                                            r19 = upvalueValues[r27]
                                                            r17 = upvalueValues[r2]
                                                            r4 = "\027\249\021"
                                                            r12 = r17(r4, r7)
                                                            r31 = r19[r12]
                                                            r1 = r18[r31]
                                                            r19 = upvalueValues[r27]
                                                            r17 = upvalueValues[r2]
                                                            r7 = 21232705529503
                                                            r4 = "\217\222+\176\150\133A"
                                                            r12 = r17(r4, r7)
                                                            r31 = r19[r12]
                                                            r19 = "Instance"
                                                            r18 = r1(r31)
                                                            r1 = allocUpvalue()
                                                            upvalueValues[r1] = r18
                                                            r31 = _env[r19]
                                                            r17 = upvalueValues[r27]
                                                            r12 = upvalueValues[r2]
                                                            r7 = "\237\214\185"
                                                            r4 = r12(r7, r25)
                                                            r19 = r17[r4]
                                                            r18 = r31[r19]
                                                            r17 = upvalueValues[r27]
                                                            r12 = upvalueValues[r2]
                                                            r7 = "\186kZH\230Z5\178\252\136"
                                                            r25 = 4713759131795
                                                            r4 = r12(r7, r25)
                                                            r19 = r17[r4]
                                                            r31 = r18(r19)
                                                            r17 = "Instance"
                                                            r19 = _env[r17]
                                                            r12 = upvalueValues[r27]
                                                            r4 = upvalueValues[r2]
                                                            r16 = 24304261377077
                                                            r25 = "\024\174b"
                                                            r7 = r4(r25, r16)
                                                            r17 = r12[r7]
                                                            r18 = r19[r17]
                                                            r12 = upvalueValues[r27]
                                                            r4 = upvalueValues[r2]
                                                            r16 = 19882081035306
                                                            r25 = "\236\128\141)\014\134\248\192\189~"
                                                            r7 = r4(r25, r16)
                                                            r17 = r12[r7]
                                                            r19 = r18(r17)
                                                            r18 = upvalueValues[r24]
                                                            r12 = upvalueValues[r27]
                                                            r4 = upvalueValues[r2]
                                                            r25 = "J\157y\253"
                                                            r16 = 6585524997114
                                                            r7 = r4(r25, r16)
                                                            r17 = r12[r7]
                                                            r4 = upvalueValues[r27]
                                                            r7 = upvalueValues[r2]
                                                            r16 = "\152t\177\157\180\254\136.\019"
                                                            r25 = r7(r16, r20)
                                                            r12 = r4[r25]
                                                            r18[r17] = r12
                                                            r18 = upvalueValues[r24]
                                                            r12 = upvalueValues[r27]
                                                            r4 = upvalueValues[r2]
                                                            r16 = 3543712417394
                                                            r25 = "\236\130\231d\200g"
                                                            r7 = r4(r25, r16)
                                                            r17 = r12[r7]
                                                            r25 = "game"
                                                            r7 = _env[r25]
                                                            r16 = upvalueValues[r27]
                                                            r20 = upvalueValues[r2]
                                                            r13 = 23584124627686
                                                            r21 = r20(r23, r13)
                                                            r25 = r16[r21]
                                                            r4 = r7[r25]
                                                            r25 = upvalueValues[r27]
                                                            r16 = upvalueValues[r2]
                                                            r23 = 32722773539717
                                                            r21 = "\170Bs\177\185G-'\239$\135"
                                                            r20 = r16(r21, r23)
                                                            r7 = r25[r20]
                                                            r12 = r4[r7]
                                                            r4 = "WaitForChild"
                                                            r4 = r12[r4]
                                                            r25 = upvalueValues[r27]
                                                            r16 = upvalueValues[r2]
                                                            r23 = 26863170171101
                                                            r21 = "\251\203\166\233\135'\004\220\228"
                                                            r20 = r16(r21, r23)
                                                            r7 = r25[r20]
                                                            r4 = r4(r12, r7)
                                                            r18[r17] = r4
                                                            r18 = upvalueValues[r40]
                                                            r12 = upvalueValues[r27]
                                                            r4 = upvalueValues[r2]
                                                            r16 = 21735517153161
                                                            r25 = "\007\008\201\224"
                                                            r7 = r4(r25, r16)
                                                            r17 = r12[r7]
                                                            r4 = upvalueValues[r27]
                                                            r7 = upvalueValues[r2]
                                                            r20 = 8982338293846
                                                            r16 = "\135q\252V|N\022l"
                                                            r25 = r7(r16, r20)
                                                            r12 = r4[r25]
                                                            r18[r17] = r12
                                                            r18 = upvalueValues[r40]
                                                            r12 = upvalueValues[r27]
                                                            r4 = upvalueValues[r2]
                                                            r16 = 8664197402562
                                                            r25 = "K\219\212\016%\244"
                                                            r7 = r4(r25, r16)
                                                            r17 = r12[r7]
                                                            r12 = upvalueValues[r24]
                                                            r18[r17] = r12
                                                            r18 = upvalueValues[r40]
                                                            r12 = upvalueValues[r27]
                                                            r4 = upvalueValues[r2]
                                                            r3 = releaseUpvalue(r3)
                                                            r25 = "\199\229\011\203\000i\207\194M\228\1904X\002\2234"
                                                            r16 = 23491408980667
                                                            r7 = r4(r25, r16)
                                                            r17 = r12[r7]
                                                            r7 = "Color3"
                                                            r4 = _env[r7]
                                                            r25 = upvalueValues[r27]
                                                            r16 = upvalueValues[r2]
                                                            r23 = 22661592656184
                                                            r21 = "X $C\127\158\025"
                                                            r20 = r16(r21, r23)
                                                            r7 = r25[r20]
                                                            r12 = r4[r7]
                                                            r25 = 40
                                                            r16 = 40
                                                            r7 = 40
                                                            r4 = r12(r7, r25, r16)
                                                            r18[r17] = r4
                                                            r18 = upvalueValues[r40]
                                                            r37 = releaseUpvalue(r37)
                                                            r12 = upvalueValues[r27]
                                                            r4 = upvalueValues[r2]
                                                            r25 = "Xr\133\205f\165Pq"
                                                            r16 = 28371517764507
                                                            r7 = r4(r25, r16)
                                                            r17 = r12[r7]
                                                            r7 = "UDim2"
                                                            r4 = _env[r7]
                                                            r25 = upvalueValues[r27]
                                                            r16 = upvalueValues[r2]
                                                            r21 = "w+\220"
                                                            r23 = 9854423929324
                                                            r20 = r16(r21, r23)
                                                            r7 = r25[r20]
                                                            r25 = -200
                                                            r20 = -75
                                                            r12 = r4[r7]
                                                            r16 = 0.5
                                                            r7 = 0.5
                                                            r4 = r12(r7, r25, r16, r20)
                                                            r18[r17] = r4
                                                            r18 = upvalueValues[r40]
                                                            r12 = upvalueValues[r27]
                                                            r4 = upvalueValues[r2]
                                                            r25 = "~\177j\161"
                                                            r16 = 22173163743317
                                                            r7 = r4(r25, r16)
                                                            r17 = r12[r7]
                                                            r7 = "UDim2"
                                                            r4 = _env[r7]
                                                            r32 = releaseUpvalue(r32)
                                                            r25 = upvalueValues[r27]
                                                            r16 = upvalueValues[r2]
                                                            r23 = 14630953769629
                                                            r21 = "\165,\189"
                                                            r20 = r16(r21, r23)
                                                            r7 = r25[r20]
                                                            r12 = r4[r7]
                                                            r16 = 0
                                                            r25 = 400
                                                            r20 = 150
                                                            r7 = 0
                                                            r4 = r12(r7, r25, r16, r20)
                                                            r18[r17] = r4
                                                            r18 = upvalueValues[r40]
                                                            r12 = upvalueValues[r27]
                                                            r4 = upvalueValues[r2]
                                                            r25 = "\175i\255\156\t\1504\1272\149\205"
                                                            r16 = 7648101715433
                                                            r7 = r4(r25, r16)
                                                            r17 = r12[r7]
                                                            r7 = "Vector2"
                                                            r4 = _env[r7]
                                                            r25 = upvalueValues[r27]
                                                            r16 = upvalueValues[r2]
                                                            r21 = "\208\222\237"
                                                            r23 = 6769720740944
                                                            r20 = r16(r21, r23)
                                                            r7 = r25[r20]
                                                            r12 = r4[r7]
                                                            r5 = releaseUpvalue(r5)
                                                            r25 = 0.5
                                                            r7 = 0.5
                                                            r4 = r12(r7, r25)
                                                            r18[r17] = r4
                                                            r17 = upvalueValues[r27]
                                                            r12 = upvalueValues[r2]
                                                            r7 = "\219\155%m\026\n}\026\196\133:\209"
                                                            r25 = 19317838947107
                                                            r4 = r12(r7, r25)
                                                            r18 = r17[r4]
                                                            r4 = "UDim"
                                                            r12 = _env[r4]
                                                            r7 = upvalueValues[r27]
                                                            r25 = upvalueValues[r2]
                                                            r21 = 8851998380058
                                                            r20 = "\218\251\234"
                                                            r16 = r25(r20, r21)
                                                            r4 = r7[r16]
                                                            r17 = r12[r4]
                                                            r7 = 0
                                                            r4 = 0.1
                                                            r12 = r17(r4, r7)
                                                            r29[r18] = r12
                                                            r17 = upvalueValues[r27]
                                                            r12 = upvalueValues[r2]
                                                            r25 = 26507340329015
                                                            r7 = "\029\177\248\167\027k"
                                                            r4 = r12(r7, r25)
                                                            r18 = r17[r4]
                                                            r17 = upvalueValues[r40]
                                                            r29[r18] = r17
                                                            r18 = upvalueValues[r1]
                                                            r12 = upvalueValues[r27]
                                                            r4 = upvalueValues[r2]
                                                            r25 = "\175\129\159e"
                                                            r16 = 29923525391982
                                                            r7 = r4(r25, r16)
                                                            r17 = r12[r7]
                                                            r4 = upvalueValues[r27]
                                                            r7 = upvalueValues[r2]
                                                            r20 = 1594181599974
                                                            r16 = "\"\152je\167S"
                                                            r25 = r7(r16, r20)
                                                            r12 = r4[r25]
                                                            r18[r17] = r12
                                                            r18 = upvalueValues[r1]
                                                            r12 = upvalueValues[r27]
                                                            r4 = upvalueValues[r2]
                                                            r25 = "\2416 |k,"
                                                            r16 = 8301158977305
                                                            r7 = r4(r25, r16)
                                                            r17 = r12[r7]
                                                            r12 = upvalueValues[r40]
                                                            r18[r17] = r12
                                                            r18 = upvalueValues[r1]
                                                            r36 = releaseUpvalue(r36)
                                                            r12 = upvalueValues[r27]
                                                            r4 = upvalueValues[r2]
                                                            r16 = 22050737416220
                                                            r25 = "\197\157\130\214~\223\007\t\216B[\135x\011z\231"
                                                            r7 = r4(r25, r16)
                                                            r17 = r12[r7]
                                                            r7 = "Color3"
                                                            r4 = _env[r7]
                                                            r25 = upvalueValues[r27]
                                                            r16 = upvalueValues[r2]
                                                            r23 = 19912699618360
                                                            r21 = "o\184\232\178\159\028\217"
                                                            r20 = r16(r21, r23)
                                                            r7 = r25[r20]
                                                            r12 = r4[r7]
                                                            r16 = 60
                                                            r7 = 60
                                                            r25 = 60
                                                            r4 = r12(r7, r25, r16)
                                                            r18[r17] = r4
                                                            r18 = upvalueValues[r1]
                                                            r12 = upvalueValues[r27]
                                                            r4 = upvalueValues[r2]
                                                            r25 = "\137\240\160\191|q\223\129"
                                                            r16 = 8008782040721
                                                            r7 = r4(r25, r16)
                                                            r17 = r12[r7]
                                                            r7 = "UDim2"
                                                            r4 = _env[r7]
                                                            r25 = upvalueValues[r27]
                                                            r16 = upvalueValues[r2]
                                                            r21 = "\162\014\222"
                                                            r23 = 8099070840507
                                                            r20 = r16(r21, r23)
                                                            r7 = r25[r20]
                                                            r12 = r4[r7]
                                                            r20 = 0
                                                            r16 = 0.2
                                                            r25 = 0
                                                            r7 = 0.1
                                                            r4 = r12(r7, r25, r16, r20)
                                                            r18[r17] = r4
                                                            r18 = upvalueValues[r1]
                                                            r12 = upvalueValues[r27]
                                                            r4 = upvalueValues[r2]
                                                            r25 = "V\232P\244"
                                                            r16 = 13887108569410
                                                            r7 = r4(r25, r16)
                                                            r17 = r12[r7]
                                                            r7 = "UDim2"
                                                            r4 = _env[r7]
                                                            r25 = upvalueValues[r27]
                                                            r16 = upvalueValues[r2]
                                                            r23 = 12722541172516
                                                            r21 = "\138\223y"
                                                            r20 = r16(r21, r23)
                                                            r7 = r25[r20]
                                                            r12 = r4[r7]
                                                            r16 = 0.2
                                                            r20 = 0
                                                            r25 = 0
                                                            r7 = 0.8
                                                            r4 = r12(r7, r25, r16, r20)
                                                            r18[r17] = r4
                                                            r18 = upvalueValues[r1]
                                                            r12 = upvalueValues[r27]
                                                            r4 = upvalueValues[r2]
                                                            r25 = "\225\204\165\149"
                                                            r16 = 32403332233968
                                                            r7 = r4(r25, r16)
                                                            r17 = r12[r7]
                                                            r25 = "Enum"
                                                            r7 = _env[r25]
                                                            r16 = upvalueValues[r27]
                                                            r20 = upvalueValues[r2]
                                                            r13 = 33769189604717
                                                            r23 = "q]5\204"
                                                            r21 = r20(r23, r13)
                                                            r25 = r16[r21]
                                                            r4 = r7[r25]
                                                            r25 = upvalueValues[r27]
                                                            r16 = upvalueValues[r2]
                                                            r21 = "\201 \030z\235\134"
                                                            r23 = 19308066169631
                                                            r20 = r16(r21, r23)
                                                            r7 = r25[r20]
                                                            r12 = r4[r7]
                                                            r18[r17] = r12
                                                            r18 = upvalueValues[r1]
                                                            r12 = upvalueValues[r27]
                                                            r4 = upvalueValues[r2]
                                                            r25 = "iQv$\165\188\157\190\015x\"\226\027\249\217"
                                                            r16 = 6050375879425
                                                            r7 = r4(r25, r16)
                                                            r17 = r12[r7]
                                                            r4 = upvalueValues[r27]
                                                            r38 = releaseUpvalue(r38)
                                                            r7 = upvalueValues[r2]
                                                            r16 = "\208\014\185\250\154J~\007q"
                                                            r20 = 2128529916895
                                                            r25 = r7(r16, r20)
                                                            r12 = r4[r25]
                                                            r18[r17] = r12
                                                            r11 = releaseUpvalue(r11)
                                                            r18 = upvalueValues[r1]
                                                            r12 = upvalueValues[r27]
                                                            r4 = upvalueValues[r2]
                                                            r25 = "\166(\168k"
                                                            r16 = 7707818692101
                                                            r7 = r4(r25, r16)
                                                            r17 = r12[r7]
                                                            r4 = upvalueValues[r27]
                                                            r7 = upvalueValues[r2]
                                                            r20 = 3588777313927
                                                            r16 = ""
                                                            r25 = r7(r16, r20)
                                                            r12 = r4[r25]
                                                            r18[r17] = r12
                                                            r18 = upvalueValues[r1]
                                                            r12 = upvalueValues[r27]
                                                            r4 = upvalueValues[r2]
                                                            r16 = 28991700104380
                                                            r25 = "\131]\011\157\002h`\242@\166"
                                                            r7 = r4(r25, r16)
                                                            r17 = r12[r7]
                                                            r7 = "Color3"
                                                            r4 = _env[r7]
                                                            r25 = upvalueValues[r27]
                                                            r16 = upvalueValues[r2]
                                                            r21 = "\146\249\210\194j\198x"
                                                            r23 = 29443335861646
                                                            r20 = r16(r21, r23)
                                                            r7 = r25[r20]
                                                            r12 = r4[r7]
                                                            r16 = 255
                                                            r25 = 255
                                                            r7 = 255
                                                            r4 = r12(r7, r25, r16)
                                                            r18[r17] = r4
                                                            r18 = upvalueValues[r1]
                                                            r12 = upvalueValues[r27]
                                                            r4 = upvalueValues[r2]
                                                            r16 = 12571115607773
                                                            r25 = "\138D\025\205\147\004\245\182B2"
                                                            r7 = r4(r25, r16)
                                                            r17 = r12[r7]
                                                            r12 = true
                                                            r18[r17] = r12
                                                            r17 = upvalueValues[r27]
                                                            r12 = upvalueValues[r2]
                                                            r25 = 2471525401726
                                                            r7 = "\240\150\187v"
                                                            r4 = r12(r7, r25)
                                                            r18 = r17[r4]
                                                            r12 = upvalueValues[r27]
                                                            r4 = upvalueValues[r2]
                                                            r16 = 17750372737097
                                                            r25 = "\000\2461|)\228R\242\184#\248\133"
                                                            r7 = r4(r25, r16)
                                                            r17 = r12[r7]
                                                            r31[r18] = r17
                                                            r17 = upvalueValues[r27]
                                                            r12 = upvalueValues[r2]
                                                            r7 = "o\151\249\022W\245"
                                                            r25 = 48336158742
                                                            r4 = r12(r7, r25)
                                                            r18 = r17[r4]
                                                            r17 = upvalueValues[r40]
                                                            r31[r18] = r17
                                                            r17 = upvalueValues[r27]
                                                            r12 = upvalueValues[r2]
                                                            r25 = 30843043182618
                                                            r7 = ">\031\254\152\0294\238\219\002\248\162\017\127P\228="
                                                            r4 = r12(r7, r25)
                                                            r39 = releaseUpvalue(r39)
                                                            r18 = r17[r4]
                                                            r4 = "Color3"
                                                            r12 = _env[r4]
                                                            r7 = upvalueValues[r27]
                                                            r25 = upvalueValues[r2]
                                                            r20 = "p\029\158\191\151\166\021"
                                                            r21 = 27604796682806
                                                            r16 = r25(r20, r21)
                                                            r4 = r7[r16]
                                                            r17 = r12[r4]
                                                            r25 = 255
                                                            r4 = 80
                                                            r7 = 80
                                                            r12 = r17(r4, r7, r25)
                                                            r31[r18] = r12
                                                            r17 = upvalueValues[r27]
                                                            r12 = upvalueValues[r2]
                                                            r7 = "l\127o\196J\134\224\238"
                                                            r25 = 22221499918443
                                                            r4 = r12(r7, r25)
                                                            r18 = r17[r4]
                                                            r4 = "UDim2"
                                                            r12 = _env[r4]
                                                            r7 = upvalueValues[r27]
                                                            r25 = upvalueValues[r2]
                                                            r20 = "\015Q "
                                                            r21 = 10289624847031
                                                            r16 = r25(r20, r21)
                                                            r4 = r7[r16]
                                                            r17 = r12[r4]
                                                            r16 = 0
                                                            r7 = 0
                                                            r25 = 0.5
                                                            r4 = 0.1
                                                            r12 = r17(r4, r7, r25, r16)
                                                            r31[r18] = r12
                                                            r10 = 3348589577751
                                                            r9 = 34818517221205
                                                            r33 = 11608757179677
                                                            r13 = "\183\169\196\218(@e\231F\205"
                                                            r17 = upvalueValues[r27]
                                                            r12 = upvalueValues[r2]
                                                            r7 = "\130\2300T"
                                                            r25 = 68526293023
                                                            r4 = r12(r7, r25)
                                                            r18 = r17[r4]
                                                            r23 = 8920524673081
                                                            r4 = "UDim2"
                                                            r12 = _env[r4]
                                                            r7 = upvalueValues[r27]
                                                            r25 = upvalueValues[r2]
                                                            r21 = 28991220659388
                                                            r20 = "59\196"
                                                            r16 = r25(r20, r21)
                                                            r4 = r7[r16]
                                                            r17 = r12[r4]
                                                            r7 = 0
                                                            r25 = 0.2
                                                            r16 = 0
                                                            r4 = 0.8
                                                            r12 = r17(r4, r7, r25, r16)
                                                            r29 = nil
                                                            r31[r18] = r12
                                                            r17 = upvalueValues[r27]
                                                            r12 = upvalueValues[r2]
                                                            r7 = "\187m\004\188"
                                                            r25 = 29607463794139
                                                            r4 = r12(r7, r25)
                                                            r18 = r17[r4]
                                                            r7 = "Enum"
                                                            r4 = _env[r7]
                                                            r25 = upvalueValues[r27]
                                                            r16 = upvalueValues[r2]
                                                            r21 = "G\253Re"
                                                            r20 = r16(r21, r23)
                                                            r7 = r25[r20]
                                                            r12 = r4[r7]
                                                            r7 = upvalueValues[r27]
                                                            r25 = upvalueValues[r2]
                                                            r20 = "aY\031\196\012\021\000y\2034"
                                                            r21 = 20314188899571
                                                            r16 = r25(r20, r21)
                                                            r4 = r7[r16]
                                                            r17 = r12[r4]
                                                            r31[r18] = r17
                                                            r17 = upvalueValues[r27]
                                                            r12 = upvalueValues[r2]
                                                            r7 = "M;\146Y"
                                                            r25 = 24346617097289
                                                            r4 = r12(r7, r25)
                                                            r18 = r17[r4]
                                                            r12 = upvalueValues[r27]
                                                            r4 = upvalueValues[r2]
                                                            r16 = 10514706289440
                                                            r25 = "\011`\174\130\176;"
                                                            r7 = r4(r25, r16)
                                                            r17 = r12[r7]
                                                            r31[r18] = r17
                                                            r17 = upvalueValues[r27]
                                                            r12 = upvalueValues[r2]
                                                            r25 = 28615347876877
                                                            r7 = "\172\159)\195\221\166\r\130Sf"
                                                            r4 = r12(r7, r25)
                                                            r18 = r17[r4]
                                                            r4 = "Color3"
                                                            r12 = _env[r4]
                                                            r7 = upvalueValues[r27]
                                                            r25 = upvalueValues[r2]
                                                            r20 = "\223\1578\142\246L\231"
                                                            r21 = 11212982408293
                                                            r16 = r25(r20, r21)
                                                            r4 = r7[r16]
                                                            r17 = r12[r4]
                                                            r25 = 255
                                                            r4 = 255
                                                            r7 = 255
                                                            r12 = r17(r4, r7, r25)
                                                            r31[r18] = r12
                                                            r17 = upvalueValues[r27]
                                                            r12 = upvalueValues[r2]
                                                            r25 = 30427405907800
                                                            r7 = "\151!\147\157\146m\197|\148m"
                                                            r4 = r12(r7, r25)
                                                            r18 = r17[r4]
                                                            r17 = true
                                                            r31[r18] = r17
                                                            r17 = upvalueValues[r27]
                                                            r12 = upvalueValues[r2]
                                                            r7 = "[m\220\249"
                                                            r25 = 1439757812382
                                                            r4 = r12(r7, r25)
                                                            r18 = r17[r4]
                                                            r12 = upvalueValues[r27]
                                                            r4 = upvalueValues[r2]
                                                            r16 = 19312053248800
                                                            r25 = "}\028\221@\240z\203+\209\230y\170S"
                                                            r7 = r4(r25, r16)
                                                            r17 = r12[r7]
                                                            r19[r18] = r17
                                                            r17 = upvalueValues[r27]
                                                            r12 = upvalueValues[r2]
                                                            r7 = "\254\180\024\023\240\141"
                                                            r25 = 9130142388379
                                                            r4 = r12(r7, r25)
                                                            r18 = r17[r4]
                                                            r17 = upvalueValues[r40]
                                                            r19[r18] = r17
                                                            r17 = upvalueValues[r27]
                                                            r12 = upvalueValues[r2]
                                                            r7 = "\145\198\004\169\145f\1400\133\t\146\254\000\190\n\222"
                                                            r25 = 14162298984898
                                                            r4 = r12(r7, r25)
                                                            r18 = r17[r4]
                                                            r4 = "Color3"
                                                            r12 = _env[r4]
                                                            r7 = upvalueValues[r27]
                                                            r25 = upvalueValues[r2]
                                                            r20 = "o\194\233\248\144]c"
                                                            r21 = 16531013377553
                                                            r16 = r25(r20, r21)
                                                            r4 = r7[r16]
                                                            r17 = r12[r4]
                                                            r7 = 80
                                                            r25 = 80
                                                            r4 = 255
                                                            r12 = r17(r4, r7, r25)
                                                            r19[r18] = r12
                                                            r22 = releaseUpvalue(r22)
                                                            r17 = upvalueValues[r27]
                                                            r12 = upvalueValues[r2]
                                                            r7 = "\139;\127\182\233\169\189\255"
                                                            r25 = 7714959887880
                                                            r4 = r12(r7, r25)
                                                            r18 = r17[r4]
                                                            r4 = "UDim2"
                                                            r12 = _env[r4]
                                                            r7 = upvalueValues[r27]
                                                            r25 = upvalueValues[r2]
                                                            r20 = "\160\2080"
                                                            r21 = 33470365170913
                                                            r16 = r25(r20, r21)
                                                            r4 = r7[r16]
                                                            r17 = r12[r4]
                                                            r7 = 0
                                                            r25 = 0.75
                                                            r4 = 0.1
                                                            r16 = 0
                                                            r12 = r17(r4, r7, r25, r16)
                                                            r19[r18] = r12
                                                            r17 = upvalueValues[r27]
                                                            r12 = upvalueValues[r2]
                                                            r7 = "S_\166E"
                                                            r25 = 22581389256979
                                                            r4 = r12(r7, r25)
                                                            r18 = r17[r4]
                                                            r4 = "UDim2"
                                                            r12 = _env[r4]
                                                            r7 = upvalueValues[r27]
                                                            r25 = upvalueValues[r2]
                                                            r21 = 9843489821159
                                                            r20 = "\219\0200"
                                                            r16 = r25(r20, r21)
                                                            r4 = r7[r16]
                                                            r17 = r12[r4]
                                                            r7 = 0
                                                            r25 = 0.2
                                                            r4 = 0.8
                                                            r16 = 0
                                                            r12 = r17(r4, r7, r25, r16)
                                                            r19[r18] = r12
                                                            r17 = upvalueValues[r27]
                                                            r12 = upvalueValues[r2]
                                                            r25 = 5993811757799
                                                            r7 = "\153\173\n\172"
                                                            r4 = r12(r7, r25)
                                                            r18 = r17[r4]
                                                            r7 = "Enum"
                                                            r4 = _env[r7]
                                                            r25 = upvalueValues[r27]
                                                            r16 = upvalueValues[r2]
                                                            r23 = 26170166570906
                                                            r21 = "\005\230\180\173"
                                                            r20 = r16(r21, r23)
                                                            r7 = r25[r20]
                                                            r12 = r4[r7]
                                                            r7 = upvalueValues[r27]
                                                            r25 = upvalueValues[r2]
                                                            r21 = 3650817820324
                                                            r20 = "\239\160\239\191F\128<7\2493"
                                                            r16 = r25(r20, r21)
                                                            r4 = r7[r16]
                                                            r17 = r12[r4]
                                                            r19[r18] = r17
                                                            r17 = upvalueValues[r27]
                                                            r12 = upvalueValues[r2]
                                                            r7 = "\144\207\159\002"
                                                            r25 = 252775514229
                                                            r4 = r12(r7, r25)
                                                            r18 = r17[r4]
                                                            r12 = upvalueValues[r27]
                                                            r4 = upvalueValues[r2]
                                                            r16 = 3556910089848
                                                            r25 = "\223\240\159\232\179\157\231q\165s|\186"
                                                            r7 = r4(r25, r16)
                                                            r17 = r12[r7]
                                                            r19[r18] = r17
                                                            r17 = upvalueValues[r27]
                                                            r12 = upvalueValues[r2]
                                                            r25 = 6122343222050
                                                            r7 = ".6\031\209\136\226dM\195\200"
                                                            r4 = r12(r7, r25)
                                                            r18 = r17[r4]
                                                            r4 = "Color3"
                                                            r12 = _env[r4]
                                                            r7 = upvalueValues[r27]
                                                            r25 = upvalueValues[r2]
                                                            r20 = "\1936(\131\205\1900"
                                                            r21 = 18003148267711
                                                            r16 = r25(r20, r21)
                                                            r4 = r7[r16]
                                                            r17 = r12[r4]
                                                            r25 = 255
                                                            r4 = 255
                                                            r7 = 255
                                                            r12 = r17(r4, r7, r25)
                                                            r19[r18] = r12
                                                            r17 = upvalueValues[r27]
                                                            r12 = upvalueValues[r2]
                                                            r25 = 3605246248590
                                                            r7 = "\169\249\152{R\001\157(P\230"
                                                            r4 = r12(r7, r25)
                                                            r18 = r17[r4]
                                                            r17 = true
                                                            r19[r18] = r17
                                                            r17 = "game"
                                                            r18 = _env[r17]
                                                            r41 = releaseUpvalue(r41)
                                                            r4 = upvalueValues[r27]
                                                            r7 = upvalueValues[r2]
                                                            r17 = "GetService"
                                                            r17 = r18[r17]
                                                            r16 = "18\204\231D\163\231\247\200\230\161m\152(x\193"
                                                            r20 = 1781014299453
                                                            r25 = r7(r16, r20)
                                                            r12 = r4[r25]
                                                            r17 = r17(r18, r12)
                                                            r12 = allocUpvalue()
                                                            r17 = allocUpvalue()
                                                            r18 = false
                                                            upvalueValues[r17] = r18
                                                            r18 = nil
                                                            upvalueValues[r12] = r18
                                                            r4 = allocUpvalue()
                                                            r18 = nil
                                                            upvalueValues[r4] = r18
                                                            r7 = createClosure3(130, {
                                                                r27,
                                                                r2,
                                                                r12,
                                                                r40,
                                                                r4
                                                            })
                                                            r18 = allocUpvalue()
                                                            upvalueValues[r18] = r7
                                                            r25 = upvalueValues[r40]
                                                            r20 = upvalueValues[r27]
                                                            r21 = upvalueValues[r2]
                                                            r23 = r21(r13, r9)
                                                            r16 = r20[r23]
                                                            r7 = r25[r16]
                                                            r25 = "Connect"
                                                            r25 = r7[r25]
                                                            r16 = createClosure3(131, {
                                                                r27,
                                                                r2,
                                                                r17,
                                                                r12,
                                                                r40,
                                                                r4
                                                            })
                                                            r25 = r25(r7, r16)
                                                            r25 = upvalueValues[r40]
                                                            r20 = upvalueValues[r27]
                                                            r21 = upvalueValues[r2]
                                                            r13 = "\199\139\148\130=x\003\202s;\252\201"
                                                            r9 = 24651746618583
                                                            r23 = r21(r13, r9)
                                                            r16 = r20[r23]
                                                            r7 = r25[r16]
                                                            r25 = "Connect"
                                                            r25 = r7[r25]
                                                            r16 = createClosure4(136, {
                                                                r27,
                                                                r2,
                                                                r17,
                                                                r18
                                                            })
                                                            r25 = r25(r7, r16)
                                                            r16 = upvalueValues[r27]
                                                            r20 = upvalueValues[r2]
                                                            r13 = 5115026327885
                                                            r23 = "\196\242\235\014A\203\245\255\162\175"
                                                            r21 = r20(r23, r13)
                                                            r25 = r16[r21]
                                                            r12 = releaseUpvalue(r12)
                                                            r20 = upvalueValues[r27]
                                                            r21 = upvalueValues[r2]
                                                            r9 = 22063472601122
                                                            r13 = "\028q\201\184\164\164\171\000\183\136\026"
                                                            r23 = r21(r13, r9)
                                                            r16 = r20[r23]
                                                            r21 = upvalueValues[r27]
                                                            r4 = releaseUpvalue(r4)
                                                            r23 = upvalueValues[r2]
                                                            r9 = "\161\172\t9B\011E\150.\221"
                                                            r13 = r23(r9, r10)
                                                            r20 = r21[r13]
                                                            r23 = upvalueValues[r27]
                                                            r13 = upvalueValues[r2]
                                                            r18 = releaseUpvalue(r18)
                                                            r10 = "/]\177w\154= \170\025=\008"
                                                            r9 = r13(r10, r33)
                                                            r21 = r23[r9]
                                                            r7 = {
                                                                r25,
                                                                r16,
                                                                r20,
                                                                r21
                                                            }
                                                            r25 = allocUpvalue()
                                                            r26 = nil
                                                            upvalueValues[r25] = r7
                                                            r20 = upvalueValues[r27]
                                                            r21 = upvalueValues[r2]
                                                            r9 = 6291724323697
                                                            r13 = "\240jHw\206)\185\1398x\158j'}\172D\159"
                                                            r23 = r21(r13, r9)
                                                            r16 = r20[r23]
                                                            r7 = r31[r16]
                                                            r20 = createClosure3(143, {
                                                                r27,
                                                                r2,
                                                                r25,
                                                                r1,
                                                                r40,
                                                                r24
                                                            })
                                                            r16 = "Connect"
                                                            r16 = r7[r16]
                                                            r16 = r16(r7, r20)
                                                            r17 = releaseUpvalue(r17)
                                                            r25 = releaseUpvalue(r25)
                                                            r1 = releaseUpvalue(r1)
                                                            r13 = "#\031\006n^\151mn\201UMRaF\022\204H"
                                                            r20 = upvalueValues[r27]
                                                            r31 = nil
                                                            r21 = upvalueValues[r2]
                                                            r40 = releaseUpvalue(r40)
                                                            r9 = 23173900872231
                                                            r23 = r21(r13, r9)
                                                            r16 = r20[r23]
                                                            r24 = releaseUpvalue(r24)
                                                            r20 = createClosure3(147, {
                                                                r27,
                                                                r2
                                                            })
                                                            r7 = r19[r16]
                                                            r16 = "Connect"
                                                            r27 = releaseUpvalue(r27)
                                                            r19 = nil
                                                            r16 = r7[r16]
                                                            r16 = r16(r7, r20)
                                                            r2 = releaseUpvalue(r2)
                                                            state = nil
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        -- createClosure0 entry 9712247 -> 32, states 32-32
                                        if state == 32 then -- entry 9712247 -> 32
                                            state = true
                                            upvalueValues[upvalues[1]] = state
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure1 entry 11563941 -> 33, states 33-33
                                    if state == 33 then -- entry 11563941 -> 33
                                        ReturnVal = "error"
                                        state = _env[ReturnVal]
                                        r14 = "Tamper Detected!"
                                        ReturnVal = state(r14)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            else
                                if state <= 34 then
                                    -- createClosure2 entry 8836893 -> 34, states 34-34
                                    if state == 34 then -- entry 8836893 -> 34
                                        r36 = 7126835
                                        r27 = "PH1zk7"
                                        r14 = r27 ^ r36
                                        ReturnVal = 13329757
                                        state = ReturnVal - r14
                                        r14 = state
                                        ReturnVal = "7XJc4OKIowUhG"
                                        state = ReturnVal / r14
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure5 entry 16367467 -> 35, states 35-46
                                    if state <= 40 then
                                        if state <= 37 then
                                            if state <= 36 then
                                                if state <= 35 then
                                                    if state == 35 then -- entry 16367467 -> 35
                                                        r27 = upvalueValues[upvalues[1]]
                                                        r39 = 2
                                                        r2 = 1
                                                        r36 = r27(r2, r39)
                                                        r27 = 1
                                                        r14 = r36 == r27
                                                        state = r14 and (36) or (37)
                                                        ReturnVal = r14
                                                    end
                                                else
                                                    if state == 36 then
                                                        state = ReturnVal and (38) or (39)
                                                    end
                                                end
                                            else
                                                if state == 37 then
                                                    r27 = upvalueValues[upvalues[2]]
                                                    r36 = upvalueValues[upvalues[3]]
                                                    r14 = r27 == r36
                                                    ReturnVal = r14
                                                    state = 36
                                                end
                                            end
                                        else
                                            if state <= 39 then
                                                if state <= 38 then
                                                    if state == 38 then
                                                        ReturnVal = "tonumber"
                                                        state = _env[ReturnVal]
                                                        r14 = upvalueValues[upvalues[4]]
                                                        r2 = "tostring"
                                                        r36 = _env[r2]
                                                        r43 = createClosure4(148, {})
                                                        r3 = "pcall"
                                                        r26 = _env[r3]
                                                        r3 = {
                                                            r26(r43)
                                                        }
                                                        r8 = {
                                                            unpack(r3)
                                                        }
                                                        r26 = 2
                                                        r39 = r8[r26]
                                                        r2 = r36(r39)
                                                        r36 = ":(%d*):"
                                                        r27 = r14(r2, r36)
                                                        r14 = {
                                                            r27()
                                                        }
                                                        ReturnVal = state(unpack(r14))
                                                        r14 = ReturnVal
                                                        r27 = upvalueValues[upvalues[5]]
                                                        state = r27 and (40) or (41)
                                                        ReturnVal = r27
                                                    end
                                                else
                                                    if state == 39 then
                                                        state = upvalueValues[upvalues[7]]
                                                        state = state and (42) or (43)
                                                    end
                                                end
                                            else
                                                if state == 40 then
                                                    r36 = upvalueValues[upvalues[6]]
                                                    r27 = r36 == r14
                                                    ReturnVal = r27
                                                    state = 41
                                                end
                                            end
                                        end
                                    else
                                        if state <= 43 then
                                            if state <= 42 then
                                                if state <= 41 then
                                                    if state == 41 then
                                                        r14 = nil
                                                        upvalueValues[upvalues[5]] = ReturnVal
                                                        state = 39
                                                    end
                                                else
                                                    if state == 42 then
                                                        r14 = "error"
                                                        state = _env[r14]
                                                        r27 = upvalueValues[upvalues[8]]
                                                        r36 = 0
                                                        r14 = state(r27, r36)
                                                        state = 43
                                                    end
                                                end
                                            else
                                                if state == 43 then
                                                    r36 = upvalueValues[upvalues[9]]
                                                    r2 = r36
                                                    state = {}
                                                    r14 = state
                                                    r36 = 1
                                                    r39 = r36
                                                    r36 = 0
                                                    r8 = r39 < r36
                                                    r27 = 1
                                                    r36 = r27 - r39
                                                    state = 44
                                                end
                                            end
                                        else
                                            if state <= 45 then
                                                if state <= 44 then
                                                    if state == 44 then
                                                        r26 = not r8
                                                        r36 = r36 + r39
                                                        r27 = r36 <= r2
                                                        r27 = r26 and r27
                                                        r26 = r36 >= r2
                                                        r26 = r8 and r26
                                                        r27 = r26 or r27
                                                        r26 = (45)
                                                        state = r27 and r26
                                                        r27 = (46)
                                                        state = state or r27
                                                    end
                                                else
                                                    if state == 45 then
                                                        state = upvalueValues[upvalues[1]]
                                                        r27 = r36
                                                        r43 = 255
                                                        r3 = 0
                                                        r26 = state(r3, r43)
                                                        r14[r27] = r26
                                                        r27 = nil
                                                        state = 44
                                                    end
                                                end
                                            else
                                                if state == 46 then
                                                    state = upvalueValues[upvalues[10]]
                                                    r27 = upvalueValues[upvalues[11]]
                                                    r14[state] = r27
                                                    state = upvalueValues[upvalues[12]]
                                                    r27 = {
                                                        state(r14)
                                                    }
                                                    ReturnVal = {
                                                        unpack(r27)
                                                    }
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            if state <= 56 then
                                if state <= 50 then
                                    -- createClosure5 entry 14591485 -> 47, states 47-50
                                    if state <= 48 then
                                        if state <= 47 then
                                            if state == 47 then -- entry 14591485 -> 47
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
                                                r14 = "l1"
                                                ReturnVal = _env[r14]
                                                r14 = "l1"
                                                _env[r14] = state
                                                r14 = "l2"
                                                _env[r14] = ReturnVal
                                                r14 = upvalueValues[upvalues[1]]
                                                r27 = r14()
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
                                    -- createClosure0 entry 11952404 -> 51, states 51-56
                                    if state <= 53 then
                                        if state <= 52 then
                                            if state <= 51 then
                                                if state == 51 then -- entry 11952404 -> 51
                                                    r14 = upvalueValues[upvalues[1]]
                                                    ReturnVal = #r14
                                                    r14 = 0
                                                    state = ReturnVal == r14
                                                    state = state and (52) or (53)
                                                end
                                            else
                                                if state == 52 then
                                                    r27 = upvalueValues[upvalues[2]]
                                                    r36 = 41
                                                    r14 = r27 * r36
                                                    r27 = 10869015696325
                                                    ReturnVal = r14 + r27
                                                    r14 = 35184372088832
                                                    state = ReturnVal % r14
                                                    upvalueValues[upvalues[2]] = state
                                                    r14 = upvalueValues[upvalues[3]]
                                                    r27 = 1
                                                    ReturnVal = r14 ~= r27
                                                    state = 54
                                                end
                                            end
                                        else
                                            if state == 53 then
                                                r36 = "table"
                                                r27 = _env[r36]
                                                r36 = "remove"
                                                r14 = r27[r36]
                                                r36 = upvalueValues[upvalues[1]]
                                                r27 = {
                                                    r14(r36)
                                                }
                                                ReturnVal = {
                                                    unpack(r27)
                                                }
                                                state = nil
                                            end
                                        end
                                    else
                                        if state <= 55 then
                                            if state <= 54 then
                                                if state == 54 then
                                                    r27 = upvalueValues[upvalues[3]]
                                                    r36 = 108
                                                    r14 = r27 * r36
                                                    r27 = 257
                                                    ReturnVal = r14 % r27
                                                    upvalueValues[upvalues[3]] = ReturnVal
                                                    state = 55
                                                end
                                            else
                                                if state == 55 then
                                                    r27 = upvalueValues[upvalues[3]]
                                                    r36 = 1
                                                    r14 = r27 ~= r36
                                                    state = r14 and (56) or (54)
                                                end
                                            end
                                        else
                                            if state == 56 then
                                                r36 = 32
                                                r27 = upvalueValues[upvalues[3]]
                                                r14 = r27 % r36
                                                r2 = upvalueValues[upvalues[4]]
                                                r43 = 2
                                                r26 = upvalueValues[upvalues[2]]
                                                r38 = upvalueValues[upvalues[3]]
                                                r5 = r38 - r14
                                                r38 = 32
                                                r37 = r5 / r38
                                                r11 = 13
                                                r22 = r11 - r37
                                                r3 = r43 ^ r22
                                                r8 = r26 / r3
                                                r39 = r2(r8)
                                                r2 = 4294967296
                                                r36 = r39 % r2
                                                r39 = 2
                                                r2 = r39 ^ r14
                                                r3 = 1
                                                r27 = r36 / r2
                                                r2 = upvalueValues[upvalues[4]]
                                                r26 = r27 % r3
                                                r3 = 4294967296
                                                r8 = r26 * r3
                                                r26 = 65536
                                                r39 = r2(r8)
                                                r2 = upvalueValues[upvalues[4]]
                                                r8 = r2(r27)
                                                r36 = r39 + r8
                                                r43 = 256
                                                r39 = 65536
                                                r2 = r36 % r39
                                                r8 = r36 - r2
                                                r39 = r8 / r26
                                                r26 = 256
                                                r8 = r2 % r26
                                                r3 = r2 - r8
                                                r26 = r3 / r43
                                                r11 = 256
                                                r27 = nil
                                                r43 = 256
                                                r3 = r39 % r43
                                                r14 = nil
                                                r2 = nil
                                                r22 = r39 - r3
                                                r43 = r22 / r11
                                                r39 = nil
                                                r22 = {
                                                    r8,
                                                    r26,
                                                    r3,
                                                    r43
                                                }
                                                r36 = nil
                                                r43 = nil
                                                r8 = nil
                                                r3 = nil
                                                r26 = nil
                                                upvalueValues[upvalues[1]] = r22
                                                state = 53
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 63 then
                                    -- createClosure7 entry 12444847 -> 57, states 57-63
                                    if state <= 60 then
                                        if state <= 58 then
                                            if state <= 57 then
                                                if state == 57 then -- entry 12444847 -> 57
                                                    r14 = args[1]
                                                    state = upvalueValues[upvalues[1]]
                                                    r36 = state
                                                    r27 = args[2]
                                                    state = r36[r27]
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
                                                    r2 = ReturnVal
                                                    r39 = 35184372088832
                                                    ReturnVal = r27 % r39
                                                    upvalueValues[upvalues[4]] = ReturnVal
                                                    r26 = 255
                                                    r8 = r27 % r26
                                                    r26 = 2
                                                    r39 = r8 + r26
                                                    upvalueValues[upvalues[5]] = r39
                                                    r3 = "string"
                                                    r26 = _env[r3]
                                                    r3 = "len"
                                                    r8 = r26[r3]
                                                    r26 = r8(r14)
                                                    r8 = ""
                                                    r36[r27] = r8
                                                    r22 = 1
                                                    r11 = r22
                                                    r22 = 0
                                                    r37 = r11 < r22
                                                    r3 = 1
                                                    r22 = r3 - r11
                                                    r43 = r26
                                                    r8 = 97
                                                    state = 61
                                                end
                                            else
                                                if state == 60 then
                                                    ReturnVal = {
                                                        r27
                                                    }
                                                    state = nil
                                                end
                                            end
                                        end
                                    else
                                        if state <= 62 then
                                            if state <= 61 then
                                                if state == 61 then
                                                    r22 = r22 + r11
                                                    r3 = r22 <= r43
                                                    r5 = not r37
                                                    r3 = r5 and r3
                                                    r5 = r22 >= r43
                                                    r5 = r37 and r5
                                                    r3 = r5 or r3
                                                    r5 = (62)
                                                    state = r3 and r5
                                                    r3 = (63)
                                                    state = state or r3
                                                end
                                            else
                                                if state == 62 then
                                                    r15 = "string"
                                                    r28 = _env[r15]
                                                    r3 = r22
                                                    r15 = "byte"
                                                    r42 = r28[r15]
                                                    r28 = r42(r14, r3)
                                                    r42 = upvalueValues[upvalues[6]]
                                                    r15 = r42()
                                                    r41 = r28 + r15
                                                    r38 = r41 + r8
                                                    r41 = 256
                                                    r5 = r38 % r41
                                                    r8 = r5
                                                    r41 = r36[r27]
                                                    r15 = 1
                                                    r28 = r8 + r15
                                                    r42 = r2[r28]
                                                    r38 = r41 .. r42
                                                    r36[r27] = r38
                                                    r3 = nil
                                                    state = 61
                                                end
                                            end
                                        else
                                            if state == 63 then
                                                r2 = nil
                                                r8 = nil
                                                r26 = nil
                                                state = 60
                                            end
                                        end
                                    end
                                else
                                    -- createClosure5 entry 6542339 -> 64, states 64-64
                                    if state == 64 then -- entry 6542339 -> 64
                                        ReturnVal = "hookfunction"
                                        state = _env[ReturnVal]
                                        r27 = "print"
                                        r14 = _env[r27]
                                        r27 = createClosure1(149, {
                                            upvalues[1],
                                            upvalues[2]
                                        })
                                        ReturnVal = state(r14, r27)
                                        ReturnVal = "hookfunction"
                                        state = _env[ReturnVal]
                                        r27 = "warn"
                                        r14 = _env[r27]
                                        r27 = createClosure3(156, {
                                            upvalues[1],
                                            upvalues[2]
                                        })
                                        ReturnVal = state(r14, r27)
                                        r27 = "error"
                                        ReturnVal = "hookfunction"
                                        state = _env[ReturnVal]
                                        r14 = _env[r27]
                                        r27 = createClosure5(163, {
                                            upvalues[1],
                                            upvalues[2]
                                        })
                                        ReturnVal = state(r14, r27)
                                        r14 = allocUpvalue()
                                        state = nil
                                        upvalueValues[r14] = state
                                        ReturnVal = "hookfunction"
                                        state = _env[ReturnVal]
                                        r36 = "writefile"
                                        r27 = _env[r36]
                                        r36 = createClosure5(170, {
                                            upvalues[1],
                                            upvalues[2],
                                            r14
                                        })
                                        ReturnVal = state(r27, r36)
                                        upvalueValues[r14] = ReturnVal
                                        state = nil
                                        r27 = state
                                        r36 = "hookfunction"
                                        state = _env[r36]
                                        r39 = "appendfile"
                                        r2 = _env[r39]
                                        r39 = createClosure2(181, {
                                            upvalues[1],
                                            upvalues[2]
                                        })
                                        r36 = state(r2, r39)
                                        r27 = r36
                                        r43 = "\191\001%\030\030\2367\006\129\234h\0012\152S"
                                        r39 = "game"
                                        r2 = _env[r39]
                                        r8 = upvalueValues[upvalues[1]]
                                        r27 = nil
                                        r26 = upvalueValues[upvalues[2]]
                                        r22 = 23295744338527
                                        r3 = r26(r43, r22)
                                        r39 = r8[r3]
                                        state = r2[r39]
                                        r39 = createClosure6(192, {
                                            upvalues[1],
                                            upvalues[2]
                                        })
                                        r2 = "Connect"
                                        r2 = state[r2]
                                        r2 = r2(state, r39)
                                        r2 = "getgenv"
                                        state = _env[r2]
                                        r2 = state()
                                        r39 = upvalueValues[upvalues[1]]
                                        r8 = upvalueValues[upvalues[2]]
                                        r43 = 9773298127303
                                        r3 = "\234[\195s_\203\238\250\131\243\133\0024"
                                        r26 = r8(r3, r43)
                                        state = r39[r26]
                                        r39 = nil
                                        r2[state] = r39
                                        r2 = "getgenv"
                                        state = _env[r2]
                                        r2 = state()
                                        r39 = upvalueValues[upvalues[1]]
                                        r8 = upvalueValues[upvalues[2]]
                                        r3 = "\177\\\246\164N\143\223\145\026\nN\140\189"
                                        r43 = 7489536183711
                                        r26 = r8(r3, r43)
                                        state = r39[r26]
                                        r39 = nil
                                        r2[state] = r39
                                        r2 = "getgenv"
                                        state = _env[r2]
                                        r2 = state()
                                        r39 = upvalueValues[upvalues[1]]
                                        r8 = upvalueValues[upvalues[2]]
                                        r3 = "\143\029.\192\030\133\185\171\144\nC\168"
                                        r43 = 13055294461887
                                        r26 = r8(r3, r43)
                                        r14 = releaseUpvalue(r14)
                                        state = r39[r26]
                                        r39 = nil
                                        r2[state] = r39
                                        r2 = "getgenv"
                                        state = _env[r2]
                                        r2 = state()
                                        r39 = upvalueValues[upvalues[1]]
                                        r8 = upvalueValues[upvalues[2]]
                                        r3 = "7f\184\130\165\234F\176 \182\168\202"
                                        r43 = 18261203984695
                                        r26 = r8(r3, r43)
                                        state = r39[r26]
                                        r39 = nil
                                        r2[state] = r39
                                        r2 = "getgenv"
                                        state = _env[r2]
                                        r2 = state()
                                        r39 = upvalueValues[upvalues[1]]
                                        r8 = upvalueValues[upvalues[2]]
                                        r3 = "G\141G\250\168\254\163\020\173\160"
                                        r43 = 22724232800597
                                        r26 = r8(r3, r43)
                                        state = r39[r26]
                                        ReturnVal = {}
                                        r39 = nil
                                        r2[state] = r39
                                        r2 = "getgenv"
                                        state = _env[r2]
                                        r2 = state()
                                        r39 = upvalueValues[upvalues[1]]
                                        r8 = upvalueValues[upvalues[2]]
                                        r3 = "\221\138\167\244\227\246\243g\188Jx\231\148"
                                        r43 = 11535122863355
                                        r26 = r8(r3, r43)
                                        state = r39[r26]
                                        r39 = createClosure1(207, {})
                                        r2[state] = r39
                                        r8 = "game"
                                        r39 = _env[r8]
                                        r26 = upvalueValues[upvalues[1]]
                                        r3 = upvalueValues[upvalues[2]]
                                        r11 = 1210331234867
                                        r22 = "`\233(X\241h\242"
                                        r43 = r3(r22, r11)
                                        r8 = r26[r43]
                                        r2 = r39[r8]
                                        r8 = upvalueValues[upvalues[1]]
                                        r26 = upvalueValues[upvalues[2]]
                                        r22 = 18557119865281
                                        r43 = "\243\135\028'\153\202\174o\199\166"
                                        r3 = r26(r43, r22)
                                        r39 = r8[r3]
                                        state = r2[r39]
                                        r2 = "Connect"
                                        r2 = state[r2]
                                        r39 = createClosure2(211, {
                                            upvalues[1],
                                            upvalues[2]
                                        })
                                        r2 = r2(state, r39)
                                        state = nil
                                        r2 = state
                                        r39 = "hookmetamethod"
                                        state = _env[r39]
                                        r26 = "game"
                                        r8 = _env[r26]
                                        r3 = upvalueValues[upvalues[1]]
                                        r43 = upvalueValues[upvalues[2]]
                                        r37 = 9055979442297
                                        r11 = "\135m\136/\214\212pv\015\133"
                                        r22 = r43(r11, r37)
                                        r26 = r3[r22]
                                        r22 = createClosure(218, {
                                            upvalues[1],
                                            upvalues[2]
                                        })
                                        r43 = "newcclosure"
                                        r3 = _env[r43]
                                        r43 = {
                                            r3(r22)
                                        }
                                        r39 = state(r8, r26, unpack(r43))
                                        r2 = r39
                                        r2 = nil
                                        state = nil
                                    end
                                end
                            end
                        end
                    else
                        if state <= 129 then
                            if state <= 121 then
                                if state <= 88 then
                                    if state <= 69 then
                                        -- createClosure4 entry 11761451 -> 65, states 65-69
                                        if state <= 67 then
                                            if state <= 66 then
                                                if state <= 65 then
                                                    if state == 65 then -- entry 11761451 -> 65
                                                        r27 = state
                                                        r39 = upvalueValues[upvalues[1]]
                                                        r26 = upvalueValues[upvalues[2]]
                                                        r3 = upvalueValues[upvalues[3]]
                                                        r11 = 10787096417183
                                                        r22 = "\220\169\153\025\174\231\172O\156P\140%jn"
                                                        r43 = r3(r22, r11)
                                                        r8 = r26[r43]
                                                        r2 = r39[r8]
                                                        r3 = "Enum"
                                                        r26 = _env[r3]
                                                        r43 = upvalueValues[upvalues[2]]
                                                        r22 = upvalueValues[upvalues[3]]
                                                        r5 = 34038048243178
                                                        r37 = "\206\244{\252\218\195d\214\156\252m]\232#"
                                                        r11 = r22(r37, r5)
                                                        r3 = r43[r11]
                                                        r8 = r26[r3]
                                                        r3 = upvalueValues[upvalues[2]]
                                                        r43 = upvalueValues[upvalues[3]]
                                                        r11 = "\153\241T\165\005\186~"
                                                        r37 = 20673233266074
                                                        r22 = r43(r11, r37)
                                                        r26 = r3[r22]
                                                        r39 = r8[r26]
                                                        r36 = r2 == r39
                                                        state = r36 and (66) or (67)
                                                        r14 = r36
                                                    end
                                                else
                                                    if state == 66 then
                                                        r2 = upvalueValues[upvalues[2]]
                                                        r39 = upvalueValues[upvalues[3]]
                                                        r26 = ",\017\147\133$\2199"
                                                        r3 = 12399595837070
                                                        r8 = r39(r26, r3)
                                                        r36 = r2[r8]
                                                        r14 = r36
                                                        state = 67
                                                    end
                                                end
                                            else
                                                if state == 67 then
                                                    state = r27
                                                    state = r14 and (68) or (69)
                                                    ReturnVal = r14
                                                end
                                            end
                                        else
                                            if state <= 68 then
                                                if state == 68 then
                                                    ReturnVal = {
                                                        ReturnVal
                                                    }
                                                    state = nil
                                                end
                                            else
                                                if state == 69 then
                                                    r27 = upvalueValues[upvalues[2]]
                                                    r36 = upvalueValues[upvalues[3]]
                                                    r39 = "\n\221\016\232ZRb\127\196\129"
                                                    r8 = 20448300344625
                                                    r2 = r36(r39, r8)
                                                    r14 = r27[r2]
                                                    ReturnVal = r14
                                                    state = 68
                                                end
                                            end
                                        end
                                    else
                                        -- createClosure1 entry 4213248 -> 70, states 70-88
                                        if state <= 79 then
                                            if state <= 74 then
                                                if state <= 72 then
                                                    if state <= 71 then
                                                        if state <= 70 then
                                                            if state == 70 then -- entry 4213248 -> 70
                                                                r2 = upvalueValues[upvalues[1]]
                                                                r8 = upvalueValues[upvalues[2]]
                                                                r26 = upvalueValues[upvalues[3]]
                                                                r43 = "\193\242\026\244q\176p\204\220\148\167\183"
                                                                r22 = 22276703758469
                                                                r3 = r26(r43, r22)
                                                                r39 = r8[r3]
                                                                r36 = r2[r39]
                                                                r27 = state
                                                                state = r36 and (71) or (72)
                                                                r14 = r36
                                                            end
                                                        else
                                                            if state == 71 then
                                                                r26 = state
                                                                r43 = upvalueValues[upvalues[1]]
                                                                r11 = upvalueValues[upvalues[2]]
                                                                r37 = upvalueValues[upvalues[3]]
                                                                r41 = 9150434431141
                                                                r38 = "\242\182E\r\152\247\220\142\246\2278\249\148\182\129"
                                                                r5 = r37(r38, r41)
                                                                r22 = r11[r5]
                                                                r3 = r43[r22]
                                                                r2 = state
                                                                state = r3 and (73) or (74)
                                                                r8 = r3
                                                            end
                                                        end
                                                    else
                                                        if state == 72 then
                                                            state = r27
                                                            state = r14 and (75) or (76)
                                                            ReturnVal = r14
                                                        end
                                                    end
                                                else
                                                    if state <= 73 then
                                                        if state == 73 then
                                                            r39 = not r8
                                                            state = r26
                                                            state = r39 and (77) or (78)
                                                            r36 = r39
                                                        end
                                                    else
                                                        if state == 74 then
                                                            r43 = upvalueValues[upvalues[1]]
                                                            r11 = upvalueValues[upvalues[2]]
                                                            r37 = upvalueValues[upvalues[3]]
                                                            r38 = "\029\131\255\131\255\186~\159ag\146w"
                                                            r41 = 15067409046376
                                                            r5 = r37(r38, r41)
                                                            r22 = r11[r5]
                                                            r3 = r43[r22]
                                                            r8 = r3
                                                            state = 73
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 77 then
                                                    if state <= 76 then
                                                        if state <= 75 then
                                                            if state == 75 then
                                                                ReturnVal = {
                                                                    ReturnVal
                                                                }
                                                                state = nil
                                                            end
                                                        else
                                                            if state == 76 then
                                                                r2 = state
                                                                r8 = upvalueValues[upvalues[1]]
                                                                r3 = upvalueValues[upvalues[2]]
                                                                r43 = upvalueValues[upvalues[3]]
                                                                r11 = "\140\172\253\185\014\146.\222\222\241\226\145\131\005@"
                                                                r37 = 16639970614852
                                                                r22 = r43(r11, r37)
                                                                r26 = r3[r22]
                                                                r39 = r8[r26]
                                                                r27 = state
                                                                state = r39 and (79) or (80)
                                                                r36 = r39
                                                            end
                                                        end
                                                    else
                                                        if state == 77 then
                                                            r8 = upvalueValues[upvalues[2]]
                                                            r26 = upvalueValues[upvalues[3]]
                                                            r43 = "\229\019_c\000t"
                                                            r22 = 32050001885772
                                                            r3 = r26(r43, r22)
                                                            r39 = r8[r3]
                                                            r36 = r39
                                                            state = 78
                                                        end
                                                    end
                                                else
                                                    if state <= 78 then
                                                        if state == 78 then
                                                            state = r2
                                                            r14 = r36
                                                            state = 72
                                                        end
                                                    else
                                                        if state == 79 then
                                                            r8 = state
                                                            r3 = upvalueValues[upvalues[1]]
                                                            r22 = upvalueValues[upvalues[2]]
                                                            r11 = upvalueValues[upvalues[3]]
                                                            r38 = 28122703508263
                                                            r5 = "p\181\146\218-\192I\159\128O\216\129"
                                                            r37 = r11(r5, r38)
                                                            r43 = r22[r37]
                                                            r26 = r3[r43]
                                                            state = r26 and (81) or (82)
                                                            r39 = r26
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 84 then
                                                if state <= 82 then
                                                    if state <= 81 then
                                                        if state <= 80 then
                                                            if state == 80 then
                                                                state = r2
                                                                state = r36 and (83) or (84)
                                                                r14 = r36
                                                            end
                                                        else
                                                            if state == 81 then
                                                                r3 = upvalueValues[upvalues[2]]
                                                                r43 = upvalueValues[upvalues[3]]
                                                                r37 = 15126833765251
                                                                r11 = "0\022"
                                                                r22 = r43(r11, r37)
                                                                r26 = r3[r22]
                                                                r39 = r26
                                                                state = 82
                                                            end
                                                        end
                                                    else
                                                        if state == 82 then
                                                            state = r8
                                                            r36 = r39
                                                            state = 80
                                                        end
                                                    end
                                                else
                                                    if state <= 83 then
                                                        if state == 83 then
                                                            state = r27
                                                            ReturnVal = r14
                                                            state = 75
                                                        end
                                                    else
                                                        if state == 84 then
                                                            r3 = upvalueValues[upvalues[1]]
                                                            r22 = upvalueValues[upvalues[2]]
                                                            r11 = upvalueValues[upvalues[3]]
                                                            r5 = "\234\190B\155N\030\228\227\021\1707\226N\021"
                                                            r38 = 4179831310234
                                                            r37 = r11(r5, r38)
                                                            r43 = r22[r37]
                                                            r26 = r3[r43]
                                                            r2 = state
                                                            r8 = state
                                                            state = r26 and (85) or (86)
                                                            r39 = r26
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 86 then
                                                    if state <= 85 then
                                                        if state == 85 then
                                                            r3 = upvalueValues[upvalues[2]]
                                                            r43 = upvalueValues[upvalues[3]]
                                                            r11 = "P\012M\137\026\161\021"
                                                            r37 = 4473454266403
                                                            r22 = r43(r11, r37)
                                                            r26 = r3[r22]
                                                            r39 = r26
                                                            state = 86
                                                        end
                                                    else
                                                        if state == 86 then
                                                            state = r8
                                                            state = r39 and (87) or (88)
                                                            r36 = r39
                                                        end
                                                    end
                                                else
                                                    if state <= 87 then
                                                        if state == 87 then
                                                            state = r2
                                                            r14 = r36
                                                            state = 83
                                                        end
                                                    else
                                                        if state == 88 then
                                                            r8 = upvalueValues[upvalues[2]]
                                                            r26 = upvalueValues[upvalues[3]]
                                                            r22 = 16337165000119
                                                            r43 = "\018U\145ad?\023"
                                                            r3 = r26(r43, r22)
                                                            r39 = r8[r3]
                                                            r36 = r39
                                                            state = 87
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure2 entry 12036739 -> 89, states 89-121
                                    if state <= 105 then
                                        if state <= 97 then
                                            if state <= 93 then
                                                if state <= 91 then
                                                    if state <= 90 then
                                                        if state <= 89 then
                                                            if state == 89 then -- entry 12036739 -> 89
                                                                r27 = state
                                                                r2 = "syn"
                                                                r36 = _env[r2]
                                                                state = r36 and (90) or (91)
                                                                r14 = r36
                                                            end
                                                        else
                                                            if state == 90 then
                                                                r26 = "is_sirhurt_closure"
                                                                r8 = _env[r26]
                                                                r39 = not r8
                                                                r2 = state
                                                                state = r39 and (92) or (93)
                                                                r36 = r39
                                                            end
                                                        end
                                                    else
                                                        if state == 91 then
                                                            state = r27
                                                            state = r14 and (94) or (95)
                                                            ReturnVal = r14
                                                        end
                                                    end
                                                else
                                                    if state <= 92 then
                                                        if state == 92 then
                                                            r8 = state
                                                            r43 = "pebc_execute"
                                                            r3 = _env[r43]
                                                            r26 = not r3
                                                            state = r26 and (96) or (97)
                                                            r39 = r26
                                                        end
                                                    else
                                                        if state == 93 then
                                                            state = r2
                                                            r14 = r36
                                                            state = 91
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 95 then
                                                    if state <= 94 then
                                                        if state == 94 then
                                                            ReturnVal = {
                                                                ReturnVal
                                                            }
                                                            state = nil
                                                        end
                                                    else
                                                        if state == 95 then
                                                            r2 = state
                                                            r27 = state
                                                            r8 = state
                                                            r3 = "secure_load"
                                                            r26 = _env[r3]
                                                            state = r26 and (98) or (99)
                                                            r39 = r26
                                                        end
                                                    end
                                                else
                                                    if state <= 96 then
                                                        if state == 96 then
                                                            r3 = upvalueValues[upvalues[1]]
                                                            r43 = upvalueValues[upvalues[2]]
                                                            r11 = "\205\141\243\152\253\251\219\228\250"
                                                            r37 = 3604499285646
                                                            r22 = r43(r11, r37)
                                                            r26 = r3[r22]
                                                            r39 = r26
                                                            state = 97
                                                        end
                                                    else
                                                        if state == 97 then
                                                            state = r8
                                                            r36 = r39
                                                            state = 93
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 101 then
                                                if state <= 99 then
                                                    if state <= 98 then
                                                        if state == 98 then
                                                            r3 = upvalueValues[upvalues[1]]
                                                            r43 = upvalueValues[upvalues[2]]
                                                            r11 = "R\028\143\208J\168\151\234"
                                                            r37 = 2235317486608
                                                            r22 = r43(r11, r37)
                                                            r26 = r3[r22]
                                                            r39 = r26
                                                            state = 99
                                                        end
                                                    else
                                                        if state == 99 then
                                                            state = r8
                                                            state = r39 and (100) or (101)
                                                            r36 = r39
                                                        end
                                                    end
                                                else
                                                    if state <= 100 then
                                                        if state == 100 then
                                                            state = r2
                                                            state = r36 and (102) or (103)
                                                            r14 = r36
                                                        end
                                                    else
                                                        if state == 101 then
                                                            r8 = state
                                                            r22 = "pebc_execute"
                                                            r43 = _env[r22]
                                                            r3 = state
                                                            state = r43 and (104) or (105)
                                                            r26 = r43
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 103 then
                                                    if state <= 102 then
                                                        if state == 102 then
                                                            state = r27
                                                            ReturnVal = r14
                                                            state = 94
                                                        end
                                                    else
                                                        if state == 103 then
                                                            r8 = state
                                                            r2 = state
                                                            r3 = "identifyexecutor"
                                                            r26 = _env[r3]
                                                            r3 = r26()
                                                            state = r3 and (106) or (107)
                                                            r39 = r3
                                                        end
                                                    end
                                                else
                                                    if state <= 104 then
                                                        if state == 104 then
                                                            r22 = upvalueValues[upvalues[1]]
                                                            r11 = upvalueValues[upvalues[2]]
                                                            r38 = 2721921025267
                                                            r5 = "\167\022\148\025\232\006\163v\152'%\216"
                                                            r37 = r11(r5, r38)
                                                            r43 = r22[r37]
                                                            r26 = r43
                                                            state = 105
                                                        end
                                                    else
                                                        if state == 105 then
                                                            state = r3
                                                            state = r26 and (108) or (109)
                                                            r39 = r26
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 113 then
                                            if state <= 109 then
                                                if state <= 107 then
                                                    if state <= 106 then
                                                        if state == 106 then
                                                            r22 = state
                                                            r3 = state
                                                            r37 = "identifyexecutor"
                                                            r11 = _env[r37]
                                                            r37 = r11()
                                                            r38 = upvalueValues[upvalues[1]]
                                                            r41 = upvalueValues[upvalues[2]]
                                                            r11 = "find"
                                                            r11 = r37[r11]
                                                            r15 = 1736487732008
                                                            r28 = "\\h@\252F\n\244{o\153"
                                                            r42 = r41(r28, r15)
                                                            r5 = r38[r42]
                                                            r11 = r11(r37, r5)
                                                            state = r11 and (110) or (111)
                                                            r43 = r11
                                                        end
                                                    else
                                                        if state == 107 then
                                                            state = r8
                                                            state = r39 and (112) or (113)
                                                            r36 = r39
                                                        end
                                                    end
                                                else
                                                    if state <= 108 then
                                                        if state == 108 then
                                                            state = r8
                                                            r36 = r39
                                                            state = 100
                                                        end
                                                    else
                                                        if state == 109 then
                                                            r22 = state
                                                            r37 = "KRNL_LOADED"
                                                            r11 = _env[r37]
                                                            r3 = state
                                                            state = r11 and (114) or (115)
                                                            r43 = r11
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 111 then
                                                    if state <= 110 then
                                                        if state == 110 then
                                                            r37 = upvalueValues[upvalues[1]]
                                                            r5 = upvalueValues[upvalues[2]]
                                                            r41 = "\224\022\007\222\031\002o[\2206u"
                                                            r42 = 11430662821066
                                                            r38 = r5(r41, r42)
                                                            r11 = r37[r38]
                                                            r43 = r11
                                                            state = 111
                                                        end
                                                    else
                                                        if state == 111 then
                                                            state = r22
                                                            state = r43 and (116) or (117)
                                                            r26 = r43
                                                        end
                                                    end
                                                else
                                                    if state <= 112 then
                                                        if state == 112 then
                                                            state = r2
                                                            r14 = r36
                                                            state = 102
                                                        end
                                                    else
                                                        if state == 113 then
                                                            r8 = upvalueValues[upvalues[1]]
                                                            r26 = upvalueValues[upvalues[2]]
                                                            r43 = "\241\157\031\225n\020\150\236J\139\210"
                                                            r22 = 18427449188740
                                                            r3 = r26(r43, r22)
                                                            r39 = r8[r3]
                                                            r36 = r39
                                                            state = 112
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 117 then
                                                if state <= 115 then
                                                    if state <= 114 then
                                                        if state == 114 then
                                                            r37 = upvalueValues[upvalues[1]]
                                                            r5 = upvalueValues[upvalues[2]]
                                                            r41 = "\213.\165Z"
                                                            r42 = 19791495226368
                                                            r38 = r5(r41, r42)
                                                            r11 = r37[r38]
                                                            r43 = r11
                                                            state = 115
                                                        end
                                                    else
                                                        if state == 115 then
                                                            state = r22
                                                            state = r43 and (118) or (119)
                                                            r26 = r43
                                                        end
                                                    end
                                                else
                                                    if state <= 116 then
                                                        if state == 116 then
                                                            state = r3
                                                            r39 = r26
                                                            state = 107
                                                        end
                                                    else
                                                        if state == 117 then
                                                            r22 = upvalueValues[upvalues[1]]
                                                            r11 = upvalueValues[upvalues[2]]
                                                            r38 = 20269357999326
                                                            r5 = "\2063)\182Z[|\253\212\188\195"
                                                            r37 = r11(r5, r38)
                                                            r43 = r22[r37]
                                                            r26 = r43
                                                            state = 116
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 119 then
                                                    if state <= 118 then
                                                        if state == 118 then
                                                            state = r3
                                                            r39 = r26
                                                            state = 108
                                                        end
                                                    else
                                                        if state == 119 then
                                                            r22 = state
                                                            r37 = "is_sirhurt_closure"
                                                            r11 = _env[r37]
                                                            state = r11 and (120) or (121)
                                                            r43 = r11
                                                        end
                                                    end
                                                else
                                                    if state <= 120 then
                                                        if state == 120 then
                                                            r37 = upvalueValues[upvalues[1]]
                                                            r5 = upvalueValues[upvalues[2]]
                                                            r41 = "q:?E\172\248\195"
                                                            r42 = 21016688846394
                                                            r38 = r5(r41, r42)
                                                            r11 = r37[r38]
                                                            r43 = r11
                                                            state = 121
                                                        end
                                                    else
                                                        if state == 121 then
                                                            state = r22
                                                            r26 = r43
                                                            state = 118
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 128 then
                                    -- createClosure4 entry 1073581 -> 122, states 122-128
                                    if state <= 125 then
                                        if state <= 123 then
                                            if state <= 122 then
                                                if state == 122 then -- entry 1073581 -> 122
                                                    r27 = args[2]
                                                    r2 = "http_request"
                                                    r36 = _env[r2]
                                                    state = r36 and (123) or (124)
                                                    r14 = args[1]
                                                    ReturnVal = r36
                                                end
                                            else
                                                if state == 123 then
                                                    r39 = upvalueValues[upvalues[1]]
                                                    r8 = upvalueValues[upvalues[2]]
                                                    r3 = "\173iv"
                                                    r43 = 35141062590443
                                                    r26 = r8(r3, r43)
                                                    r2 = r39[r26]
                                                    r8 = upvalueValues[upvalues[1]]
                                                    r26 = upvalueValues[upvalues[2]]
                                                    r22 = 5918801251012
                                                    r43 = "\230\247MC"
                                                    r3 = r26(r43, r22)
                                                    r39 = r8[r3]
                                                    r26 = upvalueValues[upvalues[1]]
                                                    r3 = upvalueValues[upvalues[2]]
                                                    r11 = 26722658644123
                                                    r22 = "\015`Z\170n\178"
                                                    r43 = r3(r22, r11)
                                                    r8 = r26[r43]
                                                    r3 = upvalueValues[upvalues[1]]
                                                    r43 = upvalueValues[upvalues[2]]
                                                    r37 = 32424943254267
                                                    r11 = "O\151\1652"
                                                    r22 = r43(r11, r37)
                                                    r26 = r3[r22]
                                                    r43 = upvalueValues[upvalues[1]]
                                                    r22 = upvalueValues[upvalues[2]]
                                                    r5 = 16705897668195
                                                    r37 = "\190\151\153W\208\174I"
                                                    r11 = r22(r37, r5)
                                                    r3 = r43[r11]
                                                    r11 = upvalueValues[upvalues[1]]
                                                    r37 = upvalueValues[upvalues[2]]
                                                    r38 = "\147\244D\234\250\180\129{\152\189~)"
                                                    r41 = 25576334798469
                                                    r5 = r37(r38, r41)
                                                    r22 = r11[r5]
                                                    r37 = upvalueValues[upvalues[1]]
                                                    r5 = upvalueValues[upvalues[2]]
                                                    r42 = 17913804415125
                                                    r41 = "\019\030\136\200q\185\140/h\224\143\003dU\185@"
                                                    r38 = r5(r41, r42)
                                                    r11 = r37[r38]
                                                    r43 = {
                                                        [r22] = r11
                                                    }
                                                    r36 = {
                                                        [r2] = r14,
                                                        [r39] = r27,
                                                        [r8] = r26,
                                                        [r3] = r43
                                                    }
                                                    r14 = nil
                                                    r27 = nil
                                                    state = ReturnVal(r36)
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state <= 124 then
                                                if state == 124 then
                                                    r2 = state
                                                    r8 = "request"
                                                    r39 = _env[r8]
                                                    state = r39 and (125) or (126)
                                                    r36 = r39
                                                end
                                            else
                                                if state == 125 then
                                                    state = r2
                                                    ReturnVal = r36
                                                    state = 123
                                                end
                                            end
                                        end
                                    else
                                        if state <= 127 then
                                            if state <= 126 then
                                                if state == 126 then
                                                    r8 = state
                                                    r3 = "HttpPost"
                                                    r26 = _env[r3]
                                                    state = r26 and (127) or (128)
                                                    r39 = r26
                                                end
                                            else
                                                if state == 127 then
                                                    state = r8
                                                    r36 = r39
                                                    state = 125
                                                end
                                            end
                                        else
                                            if state == 128 then
                                                r43 = "syn"
                                                r3 = _env[r43]
                                                r22 = upvalueValues[upvalues[1]]
                                                r11 = upvalueValues[upvalues[2]]
                                                r5 = "\129\141\203\232?\138\197"
                                                r38 = 3410218894900
                                                r37 = r11(r5, r38)
                                                r43 = r22[r37]
                                                r26 = r3[r43]
                                                r39 = r26
                                                state = 127
                                            end
                                        end
                                    end
                                else
                                    -- createClosure5 entry 16515147 -> 129, states 129-129
                                    if state == 129 then -- entry 16515147 -> 129
                                        state = upvalueValues[upvalues[1]]
                                        ReturnVal = state()
                                        r14 = ReturnVal
                                        r27 = upvalueValues[upvalues[2]]
                                        r36 = upvalueValues[upvalues[3]]
                                        r8 = 10840263037879
                                        r39 = ":\166\172R1\142YK\031?"
                                        r2 = r36(r39, r8)
                                        ReturnVal = r27[r2]
                                        r36 = upvalueValues[upvalues[2]]
                                        r2 = upvalueValues[upvalues[3]]
                                        r26 = 5006136068379
                                        r8 = "7+\221\029\001\246\145\145X\226-2AS\234\21526\242\191\189\219%/\n\158\227\015f\150y\169\245S\154<\251U\217\028\162\145\000\217\225\208T\251b\140\186\173B3\244\199\131\131\t2\131\152\226\029-\142>\218\166\180\217"
                                        r39 = r2(r8, r26)
                                        r27 = r36[r39]
                                        r2 = upvalueValues[upvalues[2]]
                                        r39 = upvalueValues[upvalues[3]]
                                        r26 = "\196\020(A\002\173\223"
                                        r3 = 3071555847574
                                        r8 = r39(r26, r3)
                                        r36 = r2[r8]
                                        r39 = upvalueValues[upvalues[2]]
                                        r8 = upvalueValues[upvalues[3]]
                                        r43 = 25907672084256
                                        r3 = ""
                                        r26 = r8(r3, r43)
                                        r2 = r39[r26]
                                        state = {
                                            [ReturnVal] = r27,
                                            [r36] = r2
                                        }
                                        r27 = state
                                        state = {}
                                        r2 = upvalueValues[upvalues[2]]
                                        r39 = upvalueValues[upvalues[3]]
                                        r3 = 1871765848935
                                        r26 = "\006\176\002\128\185\213"
                                        r8 = r39(r26, r3)
                                        ReturnVal = r2[r8]
                                        r8 = upvalueValues[upvalues[2]]
                                        r26 = upvalueValues[upvalues[3]]
                                        r22 = 19711526462426
                                        r43 = "\211u\"\132"
                                        r3 = r26(r43, r22)
                                        r39 = r8[r3]
                                        r26 = upvalueValues[upvalues[2]]
                                        r3 = upvalueValues[upvalues[3]]
                                        r11 = 18846003487303
                                        r22 = "\tc\186\208\2026\235\140\231\197\185l\164\216\243\153\217\210\004\247\023\153\222I\144\020Ax"
                                        r43 = r3(r22, r11)
                                        r8 = r26[r43]
                                        r3 = upvalueValues[upvalues[2]]
                                        r43 = upvalueValues[upvalues[3]]
                                        r37 = 16998599630571
                                        r11 = "\020\017\231"
                                        r22 = r43(r11, r37)
                                        r26 = r3[r22]
                                        r43 = upvalueValues[upvalues[2]]
                                        r22 = upvalueValues[upvalues[3]]
                                        r5 = 23891357789045
                                        r37 = "A\021\239o\152\145\001\182\151SUl\129;\213\200\178\146"
                                        r11 = r22(r37, r5)
                                        r3 = r43[r11]
                                        r2 = {
                                            [r39] = r8,
                                            [r26] = r3
                                        }
                                        r8 = upvalueValues[upvalues[2]]
                                        r26 = upvalueValues[upvalues[3]]
                                        r43 = "\020\202\020\155\015\198\253]O\003\172"
                                        r22 = 23319457753706
                                        r3 = r26(r43, r22)
                                        r39 = r8[r3]
                                        r3 = "string"
                                        r26 = _env[r3]
                                        r43 = upvalueValues[upvalues[2]]
                                        r22 = upvalueValues[upvalues[3]]
                                        r37 = "\004\235\140\168\166["
                                        r5 = 33335764630691
                                        r11 = r22(r37, r5)
                                        r3 = r43[r11]
                                        r8 = r26[r3]
                                        r43 = upvalueValues[upvalues[2]]
                                        r22 = upvalueValues[upvalues[3]]
                                        r37 = "\218\008\"\216\164\239yK>B&D\226+\239\2358\219\187\160\227,\243\170\006\232B\141\178\128R%i8\206=\156\161\173.\171\206G\205G\154\156\255\144J\135\130\145G\140\227\006\173\169\192y13\158\250RA\192>\028\197\147\242\214\206|\247\231\249\250Bi|\199\147Us\181\167\021\235\211(\184H\189\193\0305 \180\156\128\179\215\201X\026\207Ym\166\241\200\2123'\187\202\162\029\191?\155\201Q\172Q,&UM \021\007Z\245\171\154\209\029\002\133\132\181A\230g\136\018\029\185n\192\245k\207}\143g,l\154\005_\021\233V\190yW\2173}2f\145\251\222\153\155\030\144\214\180\198\255\221\023-\228RcDY\189n\246Y\245\174\nP\233\179\027l_\239u\003\183D\016Y+\218\251\015\209kh\241\180\242\017\138M?\216/3\213\193=\232$\157\252\206\214'Wy\157\167S\137\213(\131aj\003\219\238b(*\193\210`V\014SNY>:K\178\021\224E"
                                        r5 = 11443936859344
                                        r11 = r22(r37, r5)
                                        r3 = r43[r11]
                                        r43 = upvalueValues[upvalues[4]]
                                        r22 = upvalueValues[upvalues[5]]
                                        r11 = upvalueValues[upvalues[6]]
                                        r37 = upvalueValues[upvalues[4]]
                                        r5 = upvalueValues[upvalues[7]]
                                        r38 = upvalueValues[upvalues[8]]
                                        r41 = upvalueValues[upvalues[9]]
                                        r15 = "game"
                                        r28 = _env[r15]
                                        r32 = upvalueValues[upvalues[2]]
                                        r24 = upvalueValues[upvalues[3]]
                                        r40 = "c\152\133zt\198H"
                                        r1 = 16985399336677
                                        r30 = r24(r40, r1)
                                        r15 = r32[r30]
                                        r42 = r28[r15]
                                        r28 = upvalueValues[upvalues[10]]
                                        r24 = "game"
                                        r32 = _env[r24]
                                        r30 = upvalueValues[upvalues[2]]
                                        r40 = upvalueValues[upvalues[3]]
                                        r29 = "\128\242*so\146\022"
                                        r18 = 1755891827505
                                        r1 = r40(r29, r18)
                                        r24 = r30[r1]
                                        r15 = r32[r24]
                                        r26 = r8(r3, r43, r22, r11, r37, r5, r38, r41, r42, r28, r15, r14)
                                        r36 = state
                                        r3 = upvalueValues[upvalues[2]]
                                        r43 = upvalueValues[upvalues[3]]
                                        r11 = " \224sf"
                                        r37 = 13679254345953
                                        r22 = r43(r11, r37)
                                        r8 = r3[r22]
                                        r43 = upvalueValues[upvalues[2]]
                                        r22 = upvalueValues[upvalues[3]]
                                        r5 = 19707320361944
                                        r37 = "V\223\192k"
                                        r11 = r22(r37, r5)
                                        r3 = r43[r11]
                                        r22 = upvalueValues[upvalues[2]]
                                        r11 = upvalueValues[upvalues[3]]
                                        r38 = 21547387053873
                                        r5 = "D\160\142i\198"
                                        r37 = r11(r5, r38)
                                        r43 = r22[r37]
                                        r11 = "tonumber"
                                        r22 = _env[r11]
                                        r5 = upvalueValues[upvalues[2]]
                                        r38 = upvalueValues[upvalues[3]]
                                        r28 = 34695943192348
                                        r42 = "M\nI\027\239>h:"
                                        r41 = r38(r42, r28)
                                        r37 = r5[r41]
                                        r11 = r22(r37)
                                        r37 = upvalueValues[upvalues[2]]
                                        r5 = upvalueValues[upvalues[3]]
                                        r41 = "\219{\228\183h\151\177\209r"
                                        r42 = 21443808093953
                                        r38 = r5(r41, r42)
                                        r22 = r37[r38]
                                        r38 = upvalueValues[upvalues[2]]
                                        r41 = upvalueValues[upvalues[3]]
                                        r15 = 32978049874940
                                        r28 = "!_$"
                                        r42 = r41(r28, r15)
                                        r5 = r38[r42]
                                        r42 = upvalueValues[upvalues[2]]
                                        r28 = upvalueValues[upvalues[3]]
                                        r32 = "\254\172L\248\247\188;a\141\028\129\243\148=u\024\196|\155t-\202l\027X\166\255\243\016M\237\201J\225v\024\205\245\152|\192\223:\175\228\242\237\203|\237\237\165\000\176\228"
                                        r24 = 19780929102843
                                        r15 = r28(r32, r24)
                                        r41 = r42[r15]
                                        r28 = upvalueValues[upvalues[4]]
                                        r32 = upvalueValues[upvalues[2]]
                                        r24 = upvalueValues[upvalues[3]]
                                        r1 = 4686885177478
                                        r40 = "\200\225K\019\245#2\001\149\t\206\242\197PNN:\245\246\180\220\169\158\227\129&\200\195\2155\t\249"
                                        r30 = r24(r40, r1)
                                        r15 = r32[r30]
                                        r42 = r28 .. r15
                                        r38 = r41 .. r42
                                        r37 = {
                                            [r5] = r38
                                        }
                                        state = {
                                            [ReturnVal] = r2,
                                            [r39] = r26,
                                            [r8] = r3,
                                            [r43] = r11,
                                            [r22] = r37
                                        }
                                        r2 = state
                                        ReturnVal = "__set_list"
                                        state = _env[ReturnVal]
                                        r8 = {
                                            r2
                                        }
                                        r39 = 1
                                        ReturnVal = state(r36, r39, r8)
                                        ReturnVal = upvalueValues[upvalues[2]]
                                        r39 = upvalueValues[upvalues[3]]
                                        r3 = 1203896664624
                                        r26 = "-=\139\203\186S"
                                        r8 = r39(r26, r3)
                                        state = ReturnVal[r8]
                                        ReturnVal = r36
                                        r27[state] = ReturnVal
                                        state = upvalueValues[upvalues[11]]
                                        r39 = "JSONEncode"
                                        r39 = state[r39]
                                        ReturnVal = {
                                            r39(state, r27)
                                        }
                                        ReturnVal = {
                                            unpack(ReturnVal)
                                        }
                                        state = nil
                                    end
                                end
                            end
                        else
                            if state <= 135 then
                                if state <= 130 then
                                    -- createClosure3 entry 5943929 -> 130, states 130-130
                                    if state == 130 then -- entry 5943929 -> 130
                                        r14 = args[1]
                                        r36 = upvalueValues[upvalues[1]]
                                        r2 = upvalueValues[upvalues[2]]
                                        r26 = 10423572845301
                                        r8 = "\172m\176\008\020\164\127j"
                                        r39 = r2(r8, r26)
                                        r27 = r36[r39]
                                        ReturnVal = r14[r27]
                                        r27 = upvalueValues[upvalues[3]]
                                        state = ReturnVal - r27
                                        r27 = state
                                        state = upvalueValues[upvalues[4]]
                                        r36 = upvalueValues[upvalues[1]]
                                        r2 = upvalueValues[upvalues[2]]
                                        r26 = 25826746167034
                                        r8 = "bZ>\186\135\001Y\137"
                                        r39 = r2(r8, r26)
                                        ReturnVal = r36[r39]
                                        r39 = "UDim2"
                                        r2 = _env[r39]
                                        r8 = upvalueValues[upvalues[1]]
                                        r26 = upvalueValues[upvalues[2]]
                                        r22 = 12070639146484
                                        r43 = ".\n\240"
                                        r3 = r26(r43, r22)
                                        r39 = r8[r3]
                                        r36 = r2[r39]
                                        r26 = upvalueValues[upvalues[5]]
                                        r43 = upvalueValues[upvalues[1]]
                                        r22 = upvalueValues[upvalues[2]]
                                        r5 = 10492099138325
                                        r37 = "q"
                                        r11 = r22(r37, r5)
                                        r3 = r43[r11]
                                        r8 = r26[r3]
                                        r3 = upvalueValues[upvalues[1]]
                                        r43 = upvalueValues[upvalues[2]]
                                        r37 = 19633594737590
                                        r11 = "\022\005<\001\216"
                                        r22 = r43(r11, r37)
                                        r26 = r3[r22]
                                        r39 = r8[r26]
                                        r43 = upvalueValues[upvalues[5]]
                                        r11 = upvalueValues[upvalues[1]]
                                        r37 = upvalueValues[upvalues[2]]
                                        r38 = ":"
                                        r41 = 6493730851791
                                        r5 = r37(r38, r41)
                                        r22 = r11[r5]
                                        r3 = r43[r22]
                                        r22 = upvalueValues[upvalues[1]]
                                        r11 = upvalueValues[upvalues[2]]
                                        r38 = 19412623811407
                                        r5 = "\181\218<i1."
                                        r37 = r11(r5, r38)
                                        r43 = r22[r37]
                                        r26 = r3[r43]
                                        r22 = upvalueValues[upvalues[1]]
                                        r11 = upvalueValues[upvalues[2]]
                                        r38 = 4763411531946
                                        r5 = "5"
                                        r37 = r11(r5, r38)
                                        r43 = r22[r37]
                                        r3 = r27[r43]
                                        r8 = r26 + r3
                                        r43 = upvalueValues[upvalues[5]]
                                        r11 = upvalueValues[upvalues[1]]
                                        r37 = upvalueValues[upvalues[2]]
                                        r41 = 30840347949081
                                        r38 = "-"
                                        r5 = r37(r38, r41)
                                        r22 = r11[r5]
                                        r3 = r43[r22]
                                        r22 = upvalueValues[upvalues[1]]
                                        r11 = upvalueValues[upvalues[2]]
                                        r38 = 29927330100848
                                        r5 = "w\130\215\161-"
                                        r37 = r11(r5, r38)
                                        r43 = r22[r37]
                                        r26 = r3[r43]
                                        r11 = upvalueValues[upvalues[5]]
                                        r5 = upvalueValues[upvalues[1]]
                                        r38 = upvalueValues[upvalues[2]]
                                        r42 = "T"
                                        r28 = 33378759408823
                                        r41 = r38(r42, r28)
                                        r37 = r5[r41]
                                        r22 = r11[r37]
                                        r37 = upvalueValues[upvalues[1]]
                                        r5 = upvalueValues[upvalues[2]]
                                        r41 = "+\206f\157\138\144"
                                        r42 = 6868958252158
                                        r38 = r5(r41, r42)
                                        r11 = r37[r38]
                                        r43 = r22[r11]
                                        r37 = upvalueValues[upvalues[1]]
                                        r5 = upvalueValues[upvalues[2]]
                                        r41 = "\193"
                                        r42 = 25170363919816
                                        r38 = r5(r41, r42)
                                        r11 = r37[r38]
                                        r22 = r27[r11]
                                        r3 = r43 + r22
                                        r2 = r36(r39, r8, r26, r3)
                                        r27 = nil
                                        state[ReturnVal] = r2
                                        r14 = nil
                                        ReturnVal = {}
                                        state = nil
                                    end
                                else
                                    -- createClosure3 entry 8650588 -> 131, states 131-135
                                    if state <= 133 then
                                        if state <= 132 then
                                            if state <= 131 then
                                                if state == 131 then -- entry 8650588 -> 131
                                                    r14 = allocUpvalue()
                                                    upvalueValues[r14] = args[1]
                                                    r2 = upvalueValues[r14]
                                                    r8 = upvalueValues[upvalues[1]]
                                                    r26 = upvalueValues[upvalues[2]]
                                                    r43 = "\193\220r8:\255\159\243rh\2018\150"
                                                    r22 = 26181011500959
                                                    r3 = r26(r43, r22)
                                                    r39 = r8[r3]
                                                    r36 = r2[r39]
                                                    r26 = "Enum"
                                                    r8 = _env[r26]
                                                    r3 = upvalueValues[upvalues[1]]
                                                    r43 = upvalueValues[upvalues[2]]
                                                    r37 = 34300506308196
                                                    r11 = "\236(X\131g\019\254\175y\024\188\194>"
                                                    r22 = r43(r11, r37)
                                                    r26 = r3[r22]
                                                    r39 = r8[r26]
                                                    r26 = upvalueValues[upvalues[1]]
                                                    r3 = upvalueValues[upvalues[2]]
                                                    r22 = "\139\011.\141\241g%\014\184Ot\233"
                                                    r11 = 13796444100888
                                                    r43 = r3(r22, r11)
                                                    r8 = r26[r43]
                                                    r2 = r39[r8]
                                                    r27 = r36 == r2
                                                    state = r27 and (132) or (133)
                                                    ReturnVal = r27
                                                end
                                            else
                                                if state == 132 then
                                                    state = ReturnVal and (134) or (135)
                                                end
                                            end
                                        else
                                            if state == 133 then
                                                r2 = upvalueValues[r14]
                                                r8 = upvalueValues[upvalues[1]]
                                                r26 = upvalueValues[upvalues[2]]
                                                r22 = 7527652789681
                                                r43 = "r\177rh\152\017E\191\181\150\224Qv"
                                                r3 = r26(r43, r22)
                                                r39 = r8[r3]
                                                r36 = r2[r39]
                                                r26 = "Enum"
                                                r8 = _env[r26]
                                                r3 = upvalueValues[upvalues[1]]
                                                r43 = upvalueValues[upvalues[2]]
                                                r37 = 6831094090860
                                                r11 = "\211\229\166\154\167\133\019qbDe\027\185"
                                                r22 = r43(r11, r37)
                                                r26 = r3[r22]
                                                r39 = r8[r26]
                                                r26 = upvalueValues[upvalues[1]]
                                                r3 = upvalueValues[upvalues[2]]
                                                r11 = 12082437166586
                                                r22 = "\188\249\236B\194"
                                                r43 = r3(r22, r11)
                                                r8 = r26[r43]
                                                r2 = r39[r8]
                                                r27 = r36 == r2
                                                ReturnVal = r27
                                                state = 132
                                            end
                                        end
                                    else
                                        if state <= 134 then
                                            if state == 134 then
                                                state = true
                                                upvalueValues[upvalues[3]] = state
                                                r27 = upvalueValues[r14]
                                                r2 = upvalueValues[upvalues[1]]
                                                r39 = upvalueValues[upvalues[2]]
                                                r3 = 30109042046660
                                                r26 = "\167\207\209\128BZ\208\251"
                                                r8 = r39(r26, r3)
                                                r36 = r2[r8]
                                                ReturnVal = r27[r36]
                                                upvalueValues[upvalues[4]] = ReturnVal
                                                r36 = upvalueValues[upvalues[5]]
                                                r39 = upvalueValues[upvalues[1]]
                                                r8 = upvalueValues[upvalues[2]]
                                                r3 = "\196\247\131\199\191\213\132\139"
                                                r43 = 16674583912020
                                                r26 = r8(r3, r43)
                                                r2 = r39[r26]
                                                r27 = r36[r2]
                                                upvalueValues[upvalues[6]] = r27
                                                r2 = upvalueValues[r14]
                                                r8 = upvalueValues[upvalues[1]]
                                                r26 = upvalueValues[upvalues[2]]
                                                r43 = "Zg\001\1407\219\000"
                                                r22 = 18076248940769
                                                r3 = r26(r43, r22)
                                                r39 = r8[r3]
                                                r36 = r2[r39]
                                                r39 = createClosure4(225, {
                                                    r14,
                                                    upvalues[1],
                                                    upvalues[2],
                                                    upvalues[3]
                                                })
                                                r2 = "Connect"
                                                r2 = r36[r2]
                                                r2 = r2(r36, r39)
                                                state = 135
                                            end
                                        else
                                            if state == 135 then
                                                ReturnVal = {}
                                                r14 = releaseUpvalue(r14)
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 142 then
                                    -- createClosure4 entry 9556501 -> 136, states 136-142
                                    if state <= 139 then
                                        if state <= 137 then
                                            if state <= 136 then
                                                if state == 136 then -- entry 9556501 -> 136
                                                    r14 = args[1]
                                                    r26 = upvalueValues[upvalues[1]]
                                                    r3 = upvalueValues[upvalues[2]]
                                                    r22 = "\241\2132,\203\148\137\246\199\230\214\209\226"
                                                    r11 = 26447744970779
                                                    r43 = r3(r22, r11)
                                                    r8 = r26[r43]
                                                    r39 = r14[r8]
                                                    r43 = "Enum"
                                                    r3 = _env[r43]
                                                    r22 = upvalueValues[upvalues[1]]
                                                    r11 = upvalueValues[upvalues[2]]
                                                    r38 = 1147800617494
                                                    r5 = "\207\162\019 \205\168;C\165\190_[\183"
                                                    r37 = r11(r5, r38)
                                                    r43 = r22[r37]
                                                    r26 = r3[r43]
                                                    r43 = upvalueValues[upvalues[1]]
                                                    r22 = upvalueValues[upvalues[2]]
                                                    r5 = 28256992867174
                                                    r37 = "\205\000\r\1357q\029\020m\028\245\154\215"
                                                    r11 = r22(r37, r5)
                                                    r3 = r43[r11]
                                                    r8 = r26[r3]
                                                    r2 = r39 == r8
                                                    r36 = state
                                                    state = r2 and (137) or (138)
                                                    r27 = r2
                                                end
                                            else
                                                if state == 137 then
                                                    state = r36
                                                    state = r27 and (139) or (140)
                                                    ReturnVal = r27
                                                end
                                            end
                                        else
                                            if state <= 138 then
                                                if state == 138 then
                                                    r26 = upvalueValues[upvalues[1]]
                                                    r3 = upvalueValues[upvalues[2]]
                                                    r11 = 28228759270233
                                                    r22 = "\237/x\000I\141\173\244\\\002\213\144\238"
                                                    r43 = r3(r22, r11)
                                                    r8 = r26[r43]
                                                    r39 = r14[r8]
                                                    r43 = "Enum"
                                                    r3 = _env[r43]
                                                    r22 = upvalueValues[upvalues[1]]
                                                    r11 = upvalueValues[upvalues[2]]
                                                    r38 = 11571373462796
                                                    r5 = "\1577\011\145q\162L\191\128\188ORJ"
                                                    r37 = r11(r5, r38)
                                                    r43 = r22[r37]
                                                    r26 = r3[r43]
                                                    r43 = upvalueValues[upvalues[1]]
                                                    r22 = upvalueValues[upvalues[2]]
                                                    r37 = "\243\014\172\221P"
                                                    r5 = 18899366945376
                                                    r11 = r22(r37, r5)
                                                    r3 = r43[r11]
                                                    r8 = r26[r3]
                                                    r2 = r39 == r8
                                                    r27 = r2
                                                    state = 137
                                                end
                                            else
                                                if state == 139 then
                                                    r27 = upvalueValues[upvalues[3]]
                                                    ReturnVal = r27
                                                    state = 140
                                                end
                                            end
                                        end
                                    else
                                        if state <= 141 then
                                            if state <= 140 then
                                                if state == 140 then
                                                    state = ReturnVal and (141) or (142)
                                                end
                                            else
                                                if state == 141 then
                                                    state = upvalueValues[upvalues[4]]
                                                    ReturnVal = state(r14)
                                                    state = 142
                                                end
                                            end
                                        else
                                            if state == 142 then
                                                r14 = nil
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    -- createClosure3 entry 141387 -> 143, states 143-146
                                    if state <= 144 then
                                        if state <= 143 then
                                            if state == 143 then -- entry 141387 -> 143
                                                r14 = "table"
                                                ReturnVal = _env[r14]
                                                r27 = upvalueValues[upvalues[1]]
                                                r36 = upvalueValues[upvalues[2]]
                                                r39 = "\t\219\245T"
                                                r8 = 8112001109697
                                                r2 = r36(r39, r8)
                                                r14 = r27[r2]
                                                state = ReturnVal[r14]
                                                r14 = upvalueValues[upvalues[3]]
                                                r36 = upvalueValues[upvalues[4]]
                                                r39 = upvalueValues[upvalues[1]]
                                                r8 = upvalueValues[upvalues[2]]
                                                r3 = "\186e\225\240"
                                                r43 = 7264733023542
                                                r26 = r8(r3, r43)
                                                r2 = r39[r26]
                                                r27 = r36[r2]
                                                ReturnVal = state(r14, r27)
                                                state = ReturnVal and (144) or (145)
                                            end
                                        else
                                            if state == 144 then
                                                state = upvalueValues[upvalues[5]]
                                                ReturnVal = "Destroy"
                                                ReturnVal = state[ReturnVal]
                                                ReturnVal = ReturnVal(state)
                                                r39 = ".\221\197"
                                                r14 = "Instance"
                                                ReturnVal = _env[r14]
                                                r8 = 1034682319329
                                                r27 = upvalueValues[upvalues[1]]
                                                r36 = upvalueValues[upvalues[2]]
                                                r2 = r36(r39, r8)
                                                r14 = r27[r2]
                                                r39 = "\189\206\179\251\226"
                                                state = ReturnVal[r14]
                                                r27 = upvalueValues[upvalues[1]]
                                                r8 = 6306388413304
                                                r36 = upvalueValues[upvalues[2]]
                                                r2 = r36(r39, r8)
                                                r14 = r27[r2]
                                                ReturnVal = state(r14)
                                                r14 = allocUpvalue()
                                                r27 = "Instance"
                                                upvalueValues[r14] = ReturnVal
                                                r8 = "\1914\175"
                                                ReturnVal = _env[r27]
                                                r36 = upvalueValues[upvalues[1]]
                                                r2 = upvalueValues[upvalues[2]]
                                                r26 = 14133691275701
                                                r39 = r2(r8, r26)
                                                r27 = r36[r39]
                                                state = ReturnVal[r27]
                                                r8 = "\149\168\237\1857\159s\186"
                                                r36 = upvalueValues[upvalues[1]]
                                                r2 = upvalueValues[upvalues[2]]
                                                r26 = 26205046239146
                                                r39 = r2(r8, r26)
                                                r27 = r36[r39]
                                                ReturnVal = state(r27)
                                                r27 = ReturnVal
                                                r36 = "Instance"
                                                ReturnVal = _env[r36]
                                                r2 = upvalueValues[upvalues[1]]
                                                r39 = upvalueValues[upvalues[2]]
                                                r3 = 5940533529294
                                                r26 = "3\006&"
                                                r8 = r39(r26, r3)
                                                r36 = r2[r8]
                                                state = ReturnVal[r36]
                                                r2 = upvalueValues[upvalues[1]]
                                                r39 = upvalueValues[upvalues[2]]
                                                r26 = "\210`q\154\184N\131S\251\173"
                                                r3 = 5130330671444
                                                r8 = r39(r26, r3)
                                                r36 = r2[r8]
                                                ReturnVal = state(r36)
                                                r36 = "Instance"
                                                ReturnVal = _env[r36]
                                                r2 = upvalueValues[upvalues[1]]
                                                r39 = upvalueValues[upvalues[2]]
                                                r3 = 25321180442127
                                                r26 = "%\151\217"
                                                r8 = r39(r26, r3)
                                                r36 = r2[r8]
                                                state = ReturnVal[r36]
                                                r2 = upvalueValues[upvalues[1]]
                                                r39 = upvalueValues[upvalues[2]]
                                                r3 = 19736977630182
                                                r26 = "y\150u\221'\175)\024o\245"
                                                r8 = r39(r26, r3)
                                                r36 = r2[r8]
                                                ReturnVal = state(r36)
                                                r36 = "Instance"
                                                ReturnVal = _env[r36]
                                                r2 = upvalueValues[upvalues[1]]
                                                r39 = upvalueValues[upvalues[2]]
                                                r26 = "\209i;"
                                                r3 = 12657983461126
                                                r8 = r39(r26, r3)
                                                r36 = r2[r8]
                                                state = ReturnVal[r36]
                                                r2 = upvalueValues[upvalues[1]]
                                                r39 = upvalueValues[upvalues[2]]
                                                r3 = 32152274549372
                                                r26 = "?\174o\219\146\187\138\1481\215"
                                                r8 = r39(r26, r3)
                                                r36 = r2[r8]
                                                r8 = "\169\136\1925"
                                                ReturnVal = state(r36)
                                                state = upvalueValues[r14]
                                                r36 = upvalueValues[upvalues[1]]
                                                r2 = upvalueValues[upvalues[2]]
                                                r26 = 31819414813153
                                                r39 = r2(r8, r26)
                                                ReturnVal = r36[r39]
                                                r2 = upvalueValues[upvalues[1]]
                                                r39 = upvalueValues[upvalues[2]]
                                                r3 = 7582653418954
                                                r26 = "9\nd\230\248\1740\236\131\190\194"
                                                r8 = r39(r26, r3)
                                                r36 = r2[r8]
                                                state[ReturnVal] = r36
                                                state = upvalueValues[r14]
                                                r36 = upvalueValues[upvalues[1]]
                                                r8 = "\006>\191D\127\189"
                                                r2 = upvalueValues[upvalues[2]]
                                                r26 = 13642486356176
                                                r39 = r2(r8, r26)
                                                ReturnVal = r36[r39]
                                                r8 = "\012Ij\151\191U\196\2376\181_I:\177n\024"
                                                r36 = upvalueValues[upvalues[6]]
                                                state[ReturnVal] = r36
                                                state = upvalueValues[r14]
                                                r36 = upvalueValues[upvalues[1]]
                                                r2 = upvalueValues[upvalues[2]]
                                                r26 = 14711291648706
                                                r39 = r2(r8, r26)
                                                ReturnVal = r36[r39]
                                                r39 = "Color3"
                                                r2 = _env[r39]
                                                r8 = upvalueValues[upvalues[1]]
                                                r26 = upvalueValues[upvalues[2]]
                                                r22 = 28677489947689
                                                r43 = "r\147\006\191\189\170\220"
                                                r3 = r26(r43, r22)
                                                r39 = r8[r3]
                                                r36 = r2[r39]
                                                r8 = 40
                                                r39 = 40
                                                r26 = 40
                                                r2 = r36(r39, r8, r26)
                                                state[ReturnVal] = r2
                                                state = upvalueValues[r14]
                                                r8 = "\160\151\164\184\157\031\182 "
                                                r36 = upvalueValues[upvalues[1]]
                                                r2 = upvalueValues[upvalues[2]]
                                                r26 = 33967888104905
                                                r39 = r2(r8, r26)
                                                ReturnVal = r36[r39]
                                                r39 = "UDim2"
                                                r2 = _env[r39]
                                                r8 = upvalueValues[upvalues[1]]
                                                r26 = upvalueValues[upvalues[2]]
                                                r43 = "A\252;"
                                                r22 = 33040316103705
                                                r3 = r26(r43, r22)
                                                r39 = r8[r3]
                                                r8 = -200
                                                r3 = -100
                                                r36 = r2[r39]
                                                r39 = 0.5
                                                r26 = 0.5
                                                r2 = r36(r39, r8, r26, r3)
                                                state[ReturnVal] = r2
                                                state = upvalueValues[r14]
                                                r36 = upvalueValues[upvalues[1]]
                                                r2 = upvalueValues[upvalues[2]]
                                                r8 = "\144/\029\155"
                                                r26 = 18144864461057
                                                r39 = r2(r8, r26)
                                                ReturnVal = r36[r39]
                                                r39 = "UDim2"
                                                r2 = _env[r39]
                                                r8 = upvalueValues[upvalues[1]]
                                                r26 = upvalueValues[upvalues[2]]
                                                r43 = "\015\0288"
                                                r22 = 25231260970469
                                                r3 = r26(r43, r22)
                                                r39 = r8[r3]
                                                r8 = 400
                                                r36 = r2[r39]
                                                r39 = 0
                                                r26 = 0
                                                r3 = 200
                                                r2 = r36(r39, r8, r26, r3)
                                                state[ReturnVal] = r2
                                                state = upvalueValues[r14]
                                                r8 = "G\181L\251\158\175.\190|u\167"
                                                r36 = upvalueValues[upvalues[1]]
                                                r2 = upvalueValues[upvalues[2]]
                                                r26 = 34188116737584
                                                r39 = r2(r8, r26)
                                                ReturnVal = r36[r39]
                                                r39 = "Vector2"
                                                r2 = _env[r39]
                                                r8 = upvalueValues[upvalues[1]]
                                                r26 = upvalueValues[upvalues[2]]
                                                r22 = 11217485223015
                                                r43 = "1\202\176"
                                                r3 = r26(r43, r22)
                                                r39 = r8[r3]
                                                r36 = r2[r39]
                                                r39 = 0.5
                                                r8 = 0.5
                                                r2 = r36(r39, r8)
                                                r8 = 18275648135486
                                                state[ReturnVal] = r2
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                r39 = "\225<\028\157\017@X\220t\225\247\192"
                                                r36 = upvalueValues[upvalues[2]]
                                                r2 = r36(r39, r8)
                                                state = ReturnVal[r2]
                                                r2 = "UDim"
                                                r36 = _env[r2]
                                                r39 = upvalueValues[upvalues[1]]
                                                r8 = upvalueValues[upvalues[2]]
                                                r43 = 10575118095164
                                                r3 = "mi\194"
                                                r26 = r8(r3, r43)
                                                r2 = r39[r26]
                                                r8 = 30116852168392
                                                ReturnVal = r36[r2]
                                                r39 = 0
                                                r2 = 0.1
                                                r36 = ReturnVal(r2, r39)
                                                r39 = "\140b\213\1362\146"
                                                r27[state] = r36
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                r36 = upvalueValues[upvalues[2]]
                                                r2 = r36(r39, r8)
                                                state = ReturnVal[r2]
                                                ReturnVal = upvalueValues[r14]
                                                r27[state] = ReturnVal
                                                state = createClosure4(228, {
                                                    upvalues[1],
                                                    upvalues[2],
                                                    r14
                                                })
                                                r2 = upvalueValues[upvalues[1]]
                                                r36 = state
                                                r39 = upvalueValues[upvalues[2]]
                                                r3 = 18090382287079
                                                r26 = "\219\214j\156@H\243\185\249\180\141"
                                                r8 = r39(r26, r3)
                                                ReturnVal = r2[r8]
                                                r39 = upvalueValues[upvalues[1]]
                                                r8 = upvalueValues[upvalues[2]]
                                                r43 = 35012013047727
                                                r3 = "\214Y\133l\012\155K\181\130\008\209SO\187\159\1859\017\185\212\249\251~ 9l]r\134Ar\156UbV\205\020\000\030\253"
                                                r26 = r8(r3, r43)
                                                r2 = r39[r26]
                                                r26 = "UDim2"
                                                r8 = _env[r26]
                                                r3 = upvalueValues[upvalues[1]]
                                                r43 = upvalueValues[upvalues[2]]
                                                r37 = 11400079299772
                                                r11 = "B\2551"
                                                r22 = r43(r11, r37)
                                                r26 = r3[r22]
                                                r39 = r8[r26]
                                                r43 = 0.1
                                                r3 = 0
                                                r22 = 0
                                                r26 = 0.1
                                                r8 = {
                                                    r39(r26, r3, r43, r22)
                                                }
                                                state = r36(ReturnVal, r2, unpack(r8))
                                                r39 = upvalueValues[upvalues[1]]
                                                r2 = state
                                                r8 = upvalueValues[upvalues[2]]
                                                r43 = 31732868659640
                                                r3 = "\227\001=X7\128\154\142ls\215\249"
                                                r26 = r8(r3, r43)
                                                ReturnVal = r39[r26]
                                                r8 = upvalueValues[upvalues[1]]
                                                r26 = upvalueValues[upvalues[2]]
                                                r22 = 14538932591218
                                                r43 = "\215B\007\233K\196\186\160\197IT3(0kF*4K\239O\179G\219\237\217\016\027"
                                                r3 = r26(r43, r22)
                                                r39 = r8[r3]
                                                r3 = "UDim2"
                                                r26 = _env[r3]
                                                r43 = upvalueValues[upvalues[1]]
                                                r22 = upvalueValues[upvalues[2]]
                                                r5 = 4893197142246
                                                r37 = "w\244\238"
                                                r11 = r22(r37, r5)
                                                r3 = r43[r11]
                                                r14 = releaseUpvalue(r14)
                                                r8 = r26[r3]
                                                r22 = 0.4
                                                r11 = 0
                                                r43 = 0
                                                r3 = 0.1
                                                r26 = {
                                                    r8(r3, r43, r22, r11)
                                                }
                                                state = r36(ReturnVal, r39, unpack(r26))
                                                r8 = upvalueValues[upvalues[1]]
                                                r39 = state
                                                r26 = upvalueValues[upvalues[2]]
                                                r43 = "Uj\221\193\245\023\002\133c\012\127z\161"
                                                r22 = 30516384659330
                                                r3 = r26(r43, r22)
                                                ReturnVal = r8[r3]
                                                r26 = upvalueValues[upvalues[1]]
                                                r3 = upvalueValues[upvalues[2]]
                                                r11 = 12394876589707
                                                r22 = "6w\2299\134\165`\169\1417\252}\193\245\003\143)\001\016\2038\164\1979"
                                                r43 = r3(r22, r11)
                                                r8 = r26[r43]
                                                r43 = "UDim2"
                                                r3 = _env[r43]
                                                r22 = upvalueValues[upvalues[1]]
                                                r11 = upvalueValues[upvalues[2]]
                                                r38 = 23038061603303
                                                r5 = "\220\186\193"
                                                r37 = r11(r5, r38)
                                                r43 = r22[r37]
                                                r26 = r3[r43]
                                                r11 = 0.7
                                                r22 = 0
                                                r37 = 0
                                                r43 = 0.1
                                                r3 = {
                                                    r26(r43, r22, r11, r37)
                                                }
                                                state = r36(ReturnVal, r8, unpack(r3))
                                                r26 = allocUpvalue()
                                                r8 = state
                                                r37 = 20563273524583
                                                state = createClosure5(229, {
                                                    upvalues[6]
                                                })
                                                r27 = nil
                                                upvalueValues[r26] = state
                                                r3 = upvalueValues[upvalues[1]]
                                                r43 = upvalueValues[upvalues[2]]
                                                r11 = "_\188\143\024\000J^\156\189\141\n\190@7b\160H"
                                                r22 = r43(r11, r37)
                                                ReturnVal = r3[r22]
                                                r3 = createClosure0(230, {
                                                    upvalues[1],
                                                    upvalues[2],
                                                    r26
                                                })
                                                state = r2[ReturnVal]
                                                r2 = nil
                                                ReturnVal = "Connect"
                                                ReturnVal = state[ReturnVal]
                                                ReturnVal = ReturnVal(state, r3)
                                                r3 = upvalueValues[upvalues[1]]
                                                r43 = upvalueValues[upvalues[2]]
                                                r37 = 34255546842703
                                                r11 = "\236\201\246\026\190Q\165\223l`\144`\031>\253\227&"
                                                r22 = r43(r11, r37)
                                                ReturnVal = r3[r22]
                                                state = r39[ReturnVal]
                                                r3 = createClosure3(231, {
                                                    upvalues[1],
                                                    upvalues[2],
                                                    r26
                                                })
                                                ReturnVal = "Connect"
                                                ReturnVal = state[ReturnVal]
                                                ReturnVal = ReturnVal(state, r3)
                                                r3 = upvalueValues[upvalues[1]]
                                                r43 = upvalueValues[upvalues[2]]
                                                r37 = 21973739333624
                                                r11 = "\253z`\196+\255\182\174\254\170\154\184:\209\202#\181"
                                                r22 = r43(r11, r37)
                                                ReturnVal = r3[r22]
                                                r3 = createClosure5(232, {
                                                    upvalues[1],
                                                    upvalues[2],
                                                    r26
                                                })
                                                state = r8[ReturnVal]
                                                r8 = nil
                                                ReturnVal = "Connect"
                                                r36 = nil
                                                r26 = releaseUpvalue(r26)
                                                ReturnVal = state[ReturnVal]
                                                r39 = nil
                                                ReturnVal = ReturnVal(state, r3)
                                                state = 146
                                            end
                                        end
                                    else
                                        if state <= 145 then
                                            if state == 145 then
                                                state = upvalueValues[upvalues[4]]
                                                r14 = upvalueValues[upvalues[1]]
                                                r27 = upvalueValues[upvalues[2]]
                                                r39 = 27045224034609
                                                r2 = "\n\131{\133"
                                                r36 = r27(r2, r39)
                                                ReturnVal = r14[r36]
                                                r27 = upvalueValues[upvalues[1]]
                                                r36 = upvalueValues[upvalues[2]]
                                                r8 = 19427957941078
                                                r39 = "l\142\003L\198\207\153\211\163\128H\251"
                                                r2 = r36(r39, r8)
                                                r14 = r27[r2]
                                                state[ReturnVal] = r14
                                                ReturnVal = "wait"
                                                state = _env[ReturnVal]
                                                r14 = 1
                                                ReturnVal = state(r14)
                                                state = upvalueValues[upvalues[4]]
                                                r14 = upvalueValues[upvalues[1]]
                                                r27 = upvalueValues[upvalues[2]]
                                                r39 = 27469096563191
                                                r2 = "\219\250p\018"
                                                r36 = r27(r2, r39)
                                                ReturnVal = r14[r36]
                                                r27 = upvalueValues[upvalues[1]]
                                                r36 = upvalueValues[upvalues[2]]
                                                r8 = 26860283572443
                                                r39 = ""
                                                r2 = r36(r39, r8)
                                                r14 = r27[r2]
                                                state[ReturnVal] = r14
                                                state = 146
                                            end
                                        else
                                            if state == 146 then
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                else
                    if state <= 210 then
                        if state <= 169 then
                            if state <= 155 then
                                if state <= 148 then
                                    if state <= 147 then
                                        -- createClosure3 entry 14927526 -> 147, states 147-147
                                        if state == 147 then -- entry 14927526 -> 147
                                            ReturnVal = "setclipboard"
                                            state = _env[ReturnVal]
                                            r27 = upvalueValues[upvalues[1]]
                                            r36 = upvalueValues[upvalues[2]]
                                            r39 = "\212\241\018\215\205!\207\020!h\160lF\025\004\228\238H\189\253\234Sq\189'X\168\026\206"
                                            r8 = 33862167313816
                                            r2 = r36(r39, r8)
                                            r14 = r27[r2]
                                            ReturnVal = state(r14)
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    else
                                        -- createClosure4 entry 12785887 -> 148, states 148-148
                                        if state == 148 then -- entry 12785887 -> 148
                                            r27 = "di"
                                            r36 = 13074595
                                            r14 = r27 ^ r36
                                            ReturnVal = 5802084
                                            state = ReturnVal - r14
                                            r14 = state
                                            ReturnVal = "yXGmzxjDSdrnpB"
                                            state = ReturnVal / r14
                                            ReturnVal = {
                                                state
                                            }
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure1 entry 1594773 -> 149, states 149-155
                                    if state <= 152 then
                                        if state <= 150 then
                                            if state <= 149 then
                                                if state == 149 then -- entry 1594773 -> 149
                                                    r14 = args[1]
                                                    r27 = "string"
                                                    ReturnVal = _env[r27]
                                                    r36 = upvalueValues[upvalues[1]]
                                                    r2 = upvalueValues[upvalues[2]]
                                                    r8 = "\018\159\192\023"
                                                    r26 = 8208856600302
                                                    r39 = r2(r8, r26)
                                                    r27 = r36[r39]
                                                    state = ReturnVal[r27]
                                                    r27 = "lower"
                                                    r27 = r14[r27]
                                                    r27 = r27(r14)
                                                    r2 = upvalueValues[upvalues[1]]
                                                    r39 = upvalueValues[upvalues[2]]
                                                    r3 = 8169827634908
                                                    r26 = "\193\152K\244"
                                                    r8 = r39(r26, r3)
                                                    r36 = r2[r8]
                                                    ReturnVal = state(r27, r36)
                                                    state = ReturnVal and (150) or (151)
                                                end
                                            else
                                                if state == 150 then
                                                    state = 152
                                                end
                                            end
                                        else
                                            if state <= 151 then
                                                if state == 151 then
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            else
                                                if state == 152 then
                                                    state = true
                                                    state = state and (153) or (154)
                                                end
                                            end
                                        end
                                    else
                                        if state <= 154 then
                                            if state <= 153 then
                                                if state == 153 then
                                                    state = 152
                                                end
                                            else
                                                if state == 154 then
                                                    state = 155
                                                end
                                            end
                                        else
                                            if state == 155 then
                                                r14 = nil
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 162 then
                                    -- createClosure3 entry 12418274 -> 156, states 156-162
                                    if state <= 159 then
                                        if state <= 157 then
                                            if state <= 156 then
                                                if state == 156 then -- entry 12418274 -> 156
                                                    r14 = args[1]
                                                    r27 = "string"
                                                    ReturnVal = _env[r27]
                                                    r36 = upvalueValues[upvalues[1]]
                                                    r2 = upvalueValues[upvalues[2]]
                                                    r26 = 10738697606024
                                                    r8 = "\152\218\203\141"
                                                    r39 = r2(r8, r26)
                                                    r27 = r36[r39]
                                                    state = ReturnVal[r27]
                                                    r27 = "lower"
                                                    r27 = r14[r27]
                                                    r27 = r27(r14)
                                                    r2 = upvalueValues[upvalues[1]]
                                                    r39 = upvalueValues[upvalues[2]]
                                                    r3 = 18436185760137
                                                    r26 = "\227\001\211D"
                                                    r8 = r39(r26, r3)
                                                    r36 = r2[r8]
                                                    ReturnVal = state(r27, r36)
                                                    state = ReturnVal and (157) or (158)
                                                end
                                            else
                                                if state == 157 then
                                                    state = 159
                                                end
                                            end
                                        else
                                            if state <= 158 then
                                                if state == 158 then
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            else
                                                if state == 159 then
                                                    state = true
                                                    state = state and (160) or (161)
                                                end
                                            end
                                        end
                                    else
                                        if state <= 161 then
                                            if state <= 160 then
                                                if state == 160 then
                                                    state = 159
                                                end
                                            else
                                                if state == 161 then
                                                    state = 162
                                                end
                                            end
                                        else
                                            if state == 162 then
                                                r14 = nil
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    -- createClosure5 entry 16717057 -> 163, states 163-169
                                    if state <= 166 then
                                        if state <= 164 then
                                            if state <= 163 then
                                                if state == 163 then -- entry 16717057 -> 163
                                                    r14 = args[1]
                                                    r27 = "string"
                                                    ReturnVal = _env[r27]
                                                    r36 = upvalueValues[upvalues[1]]
                                                    r2 = upvalueValues[upvalues[2]]
                                                    r26 = 8487905857392
                                                    r8 = "Vo\159\172"
                                                    r39 = r2(r8, r26)
                                                    r27 = r36[r39]
                                                    state = ReturnVal[r27]
                                                    r27 = "lower"
                                                    r27 = r14[r27]
                                                    r27 = r27(r14)
                                                    r2 = upvalueValues[upvalues[1]]
                                                    r39 = upvalueValues[upvalues[2]]
                                                    r3 = 15234696600502
                                                    r26 = "8\191\176\221"
                                                    r8 = r39(r26, r3)
                                                    r36 = r2[r8]
                                                    ReturnVal = state(r27, r36)
                                                    state = ReturnVal and (164) or (165)
                                                end
                                            else
                                                if state == 164 then
                                                    state = 166
                                                end
                                            end
                                        else
                                            if state <= 165 then
                                                if state == 165 then
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            else
                                                if state == 166 then
                                                    state = true
                                                    state = state and (167) or (168)
                                                end
                                            end
                                        end
                                    else
                                        if state <= 168 then
                                            if state <= 167 then
                                                if state == 167 then
                                                    state = 166
                                                end
                                            else
                                                if state == 168 then
                                                    state = 169
                                                end
                                            end
                                        else
                                            if state == 169 then
                                                r14 = nil
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            if state <= 191 then
                                if state <= 180 then
                                    -- createClosure5 entry 11977323 -> 170, states 170-180
                                    if state <= 175 then
                                        if state <= 172 then
                                            if state <= 171 then
                                                if state <= 170 then
                                                    if state == 170 then -- entry 11977323 -> 170
                                                        r27 = args[2]
                                                        r14 = args[1]
                                                        r39 = "string"
                                                        r2 = _env[r39]
                                                        r8 = upvalueValues[upvalues[1]]
                                                        r26 = upvalueValues[upvalues[2]]
                                                        r22 = 33664200506684
                                                        r43 = "\191\164$z"
                                                        r3 = r26(r43, r22)
                                                        r39 = r8[r3]
                                                        r36 = r2[r39]
                                                        r26 = "string"
                                                        r8 = _env[r26]
                                                        r3 = upvalueValues[upvalues[1]]
                                                        r43 = upvalueValues[upvalues[2]]
                                                        r11 = "O\223\240\202w"
                                                        r37 = 18133499339004
                                                        r22 = r43(r11, r37)
                                                        r26 = r3[r22]
                                                        r39 = r8[r26]
                                                        r8 = r39(r27)
                                                        r26 = upvalueValues[upvalues[1]]
                                                        r3 = upvalueValues[upvalues[2]]
                                                        r11 = 31017259169899
                                                        r22 = "x=\193j"
                                                        r43 = r3(r22, r11)
                                                        r39 = r26[r43]
                                                        r2 = r36(r8, r39)
                                                        state = r2 and (171) or (172)
                                                        ReturnVal = r2
                                                    end
                                                else
                                                    if state == 171 then
                                                        state = ReturnVal and (173) or (174)
                                                    end
                                                end
                                            else
                                                if state == 172 then
                                                    r2 = state
                                                    r26 = "string"
                                                    r8 = _env[r26]
                                                    r3 = upvalueValues[upvalues[1]]
                                                    r43 = upvalueValues[upvalues[2]]
                                                    r37 = 12841736525659
                                                    r11 = "d\134\220\134"
                                                    r22 = r43(r11, r37)
                                                    r26 = r3[r22]
                                                    r39 = r8[r26]
                                                    r43 = "string"
                                                    r3 = _env[r43]
                                                    r22 = upvalueValues[upvalues[1]]
                                                    r11 = upvalueValues[upvalues[2]]
                                                    r38 = 21241375155875
                                                    r5 = "\139\178\216\241d"
                                                    r37 = r11(r5, r38)
                                                    r43 = r22[r37]
                                                    r26 = r3[r43]
                                                    r3 = r26(r27)
                                                    r43 = upvalueValues[upvalues[1]]
                                                    r22 = upvalueValues[upvalues[2]]
                                                    r5 = 31309990639859
                                                    r37 = "j!"
                                                    r11 = r22(r37, r5)
                                                    r26 = r43[r11]
                                                    r8 = r39(r3, r26)
                                                    state = r8 and (175) or (176)
                                                    r36 = r8
                                                end
                                            end
                                        else
                                            if state <= 174 then
                                                if state <= 173 then
                                                    if state == 173 then
                                                        state = 177
                                                    end
                                                else
                                                    if state == 174 then
                                                        state = upvalueValues[upvalues[3]]
                                                        ReturnVal = {
                                                            state(r14, r27)
                                                        }
                                                        ReturnVal = {
                                                            unpack(ReturnVal)
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            else
                                                if state == 175 then
                                                    state = r2
                                                    ReturnVal = r36
                                                    state = 171
                                                end
                                            end
                                        end
                                    else
                                        if state <= 178 then
                                            if state <= 177 then
                                                if state <= 176 then
                                                    if state == 176 then
                                                        r26 = "string"
                                                        r8 = _env[r26]
                                                        r3 = upvalueValues[upvalues[1]]
                                                        r43 = upvalueValues[upvalues[2]]
                                                        r11 = "fC\143\164"
                                                        r37 = 19863492142113
                                                        r22 = r43(r11, r37)
                                                        r26 = r3[r22]
                                                        r39 = r8[r26]
                                                        r43 = "string"
                                                        r3 = _env[r43]
                                                        r22 = upvalueValues[upvalues[1]]
                                                        r11 = upvalueValues[upvalues[2]]
                                                        r5 = "\159\255\147)\160"
                                                        r38 = 28919661638810
                                                        r37 = r11(r5, r38)
                                                        r43 = r22[r37]
                                                        r26 = r3[r43]
                                                        r3 = r26(r27)
                                                        r43 = upvalueValues[upvalues[1]]
                                                        r22 = upvalueValues[upvalues[2]]
                                                        r5 = 4098632943476
                                                        r37 = "X\210\246\027\202\\\014\027\197Z\236\215\1648)E\219\226\208\175\235\221\147\181\161\152^\179'G\231\132u"
                                                        r11 = r22(r37, r5)
                                                        r26 = r43[r11]
                                                        r8 = r39(r3, r26)
                                                        r36 = r8
                                                        state = 175
                                                    end
                                                else
                                                    if state == 177 then
                                                        state = true
                                                        state = state and (178) or (179)
                                                    end
                                                end
                                            else
                                                if state == 178 then
                                                    state = 177
                                                end
                                            end
                                        else
                                            if state <= 179 then
                                                if state == 179 then
                                                    state = 180
                                                end
                                            else
                                                if state == 180 then
                                                    r27 = nil
                                                    r14 = nil
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure2 entry 15340215 -> 181, states 181-191
                                    if state <= 186 then
                                        if state <= 183 then
                                            if state <= 182 then
                                                if state <= 181 then
                                                    if state == 181 then -- entry 15340215 -> 181
                                                        r27 = args[2]
                                                        r39 = "string"
                                                        r2 = _env[r39]
                                                        r8 = upvalueValues[upvalues[1]]
                                                        r26 = upvalueValues[upvalues[2]]
                                                        r14 = args[1]
                                                        r43 = "K\208L\151"
                                                        r22 = 25142959369660
                                                        r3 = r26(r43, r22)
                                                        r39 = r8[r3]
                                                        r36 = r2[r39]
                                                        r26 = "string"
                                                        r8 = _env[r26]
                                                        r3 = upvalueValues[upvalues[1]]
                                                        r43 = upvalueValues[upvalues[2]]
                                                        r11 = "\015\1858\180~"
                                                        r37 = 10636543775577
                                                        r22 = r43(r11, r37)
                                                        r26 = r3[r22]
                                                        r39 = r8[r26]
                                                        r8 = r39(r27)
                                                        r26 = upvalueValues[upvalues[1]]
                                                        r3 = upvalueValues[upvalues[2]]
                                                        r22 = "\129Z\208A"
                                                        r11 = 15655669898362
                                                        r43 = r3(r22, r11)
                                                        r39 = r26[r43]
                                                        r2 = r36(r8, r39)
                                                        state = r2 and (182) or (183)
                                                        ReturnVal = r2
                                                    end
                                                else
                                                    if state == 182 then
                                                        state = ReturnVal and (184) or (185)
                                                    end
                                                end
                                            else
                                                if state == 183 then
                                                    r26 = "string"
                                                    r8 = _env[r26]
                                                    r3 = upvalueValues[upvalues[1]]
                                                    r43 = upvalueValues[upvalues[2]]
                                                    r37 = 17676394733607
                                                    r11 = "\138\253\133\193"
                                                    r22 = r43(r11, r37)
                                                    r26 = r3[r22]
                                                    r39 = r8[r26]
                                                    r43 = "string"
                                                    r3 = _env[r43]
                                                    r22 = upvalueValues[upvalues[1]]
                                                    r11 = upvalueValues[upvalues[2]]
                                                    r38 = 340388462750
                                                    r5 = "\1501\136\178\145"
                                                    r37 = r11(r5, r38)
                                                    r43 = r22[r37]
                                                    r26 = r3[r43]
                                                    r3 = r26(r27)
                                                    r43 = upvalueValues[upvalues[1]]
                                                    r22 = upvalueValues[upvalues[2]]
                                                    r37 = "\155\224"
                                                    r5 = 15619035421801
                                                    r11 = r22(r37, r5)
                                                    r26 = r43[r11]
                                                    r8 = r39(r3, r26)
                                                    r2 = state
                                                    state = r8 and (186) or (187)
                                                    r36 = r8
                                                end
                                            end
                                        else
                                            if state <= 185 then
                                                if state <= 184 then
                                                    if state == 184 then
                                                        state = 188
                                                    end
                                                else
                                                    if state == 185 then
                                                        ReturnVal = {}
                                                        state = nil
                                                    end
                                                end
                                            else
                                                if state == 186 then
                                                    state = r2
                                                    ReturnVal = r36
                                                    state = 182
                                                end
                                            end
                                        end
                                    else
                                        if state <= 189 then
                                            if state <= 188 then
                                                if state <= 187 then
                                                    if state == 187 then
                                                        r26 = "string"
                                                        r8 = _env[r26]
                                                        r3 = upvalueValues[upvalues[1]]
                                                        r43 = upvalueValues[upvalues[2]]
                                                        r11 = "=}C\025"
                                                        r37 = 5984762727138
                                                        r22 = r43(r11, r37)
                                                        r26 = r3[r22]
                                                        r39 = r8[r26]
                                                        r43 = "string"
                                                        r3 = _env[r43]
                                                        r22 = upvalueValues[upvalues[1]]
                                                        r11 = upvalueValues[upvalues[2]]
                                                        r5 = "\131\128_\248\168"
                                                        r38 = 31332883691774
                                                        r37 = r11(r5, r38)
                                                        r43 = r22[r37]
                                                        r26 = r3[r43]
                                                        r3 = r26(r27)
                                                        r43 = upvalueValues[upvalues[1]]
                                                        r22 = upvalueValues[upvalues[2]]
                                                        r37 = "\132\251\001\255\190N\248EK\254h\156t\191m\028e\028x\193\143\196\140\177eB5(\021Y\157\176<"
                                                        r5 = 17596548194306
                                                        r11 = r22(r37, r5)
                                                        r26 = r43[r11]
                                                        r8 = r39(r3, r26)
                                                        r36 = r8
                                                        state = 186
                                                    end
                                                else
                                                    if state == 188 then
                                                        state = true
                                                        state = state and (189) or (190)
                                                    end
                                                end
                                            else
                                                if state == 189 then
                                                    state = 188
                                                end
                                            end
                                        else
                                            if state <= 190 then
                                                if state == 190 then
                                                    state = 191
                                                end
                                            else
                                                if state == 191 then
                                                    r27 = nil
                                                    r14 = nil
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 206 then
                                    -- createClosure6 entry 9756996 -> 192, states 192-206
                                    if state <= 199 then
                                        if state <= 195 then
                                            if state <= 193 then
                                                if state <= 192 then
                                                    if state == 192 then -- entry 9756996 -> 192
                                                        r36 = state
                                                        r39 = state
                                                        r14 = args[1]
                                                        state = r14 and (193) or (194)
                                                        r2 = r14
                                                    end
                                                else
                                                    if state == 193 then
                                                        r3 = upvalueValues[upvalues[1]]
                                                        r43 = upvalueValues[upvalues[2]]
                                                        r11 = "W\028\154+\247p\143\185\004"
                                                        r37 = 10725608493954
                                                        r22 = r43(r11, r37)
                                                        r26 = r3[r22]
                                                        r8 = "IsA"
                                                        r8 = r14[r8]
                                                        r8 = r8(r14, r26)
                                                        r2 = r8
                                                        state = 194
                                                    end
                                                end
                                            else
                                                if state <= 194 then
                                                    if state == 194 then
                                                        state = r39
                                                        state = r2 and (195) or (196)
                                                        r27 = r2
                                                    end
                                                else
                                                    if state == 195 then
                                                        state = r36
                                                        state = r27 and (197) or (198)
                                                        ReturnVal = r27
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 197 then
                                                if state <= 196 then
                                                    if state == 196 then
                                                        r39 = state
                                                        r3 = upvalueValues[upvalues[1]]
                                                        r43 = upvalueValues[upvalues[2]]
                                                        r37 = 23389352585867
                                                        r11 = "4\001\158=\214\201\234\200\001c"
                                                        r22 = r43(r11, r37)
                                                        r8 = "IsA"
                                                        r8 = r14[r8]
                                                        r26 = r3[r22]
                                                        r8 = r8(r14, r26)
                                                        state = r8 and (199) or (200)
                                                        r2 = r8
                                                    end
                                                else
                                                    if state == 197 then
                                                        r2 = "string"
                                                        r36 = _env[r2]
                                                        r39 = upvalueValues[upvalues[1]]
                                                        r8 = upvalueValues[upvalues[2]]
                                                        r3 = "\021Tt\229"
                                                        r43 = 21594624190279
                                                        r26 = r8(r3, r43)
                                                        r2 = r39[r26]
                                                        r27 = r36[r2]
                                                        r8 = "string"
                                                        r39 = _env[r8]
                                                        r26 = upvalueValues[upvalues[1]]
                                                        r3 = upvalueValues[upvalues[2]]
                                                        r22 = "t\169\029\150\128"
                                                        r11 = 1603470492394
                                                        r43 = r3(r22, r11)
                                                        r8 = r26[r43]
                                                        r2 = r39[r8]
                                                        r3 = upvalueValues[upvalues[1]]
                                                        r43 = upvalueValues[upvalues[2]]
                                                        r11 = "\143\011\008]"
                                                        r37 = 31935210682902
                                                        r22 = r43(r11, r37)
                                                        r26 = r3[r22]
                                                        r8 = r14[r26]
                                                        r39 = r2(r8)
                                                        r8 = upvalueValues[upvalues[1]]
                                                        r26 = upvalueValues[upvalues[2]]
                                                        r43 = "\143Z\170z"
                                                        r22 = 29803480806966
                                                        r3 = r26(r43, r22)
                                                        r2 = r8[r3]
                                                        r36 = r27(r39, r2)
                                                        ReturnVal = r36
                                                        state = 198
                                                    end
                                                end
                                            else
                                                if state <= 198 then
                                                    if state == 198 then
                                                        state = ReturnVal and (201) or (202)
                                                    end
                                                else
                                                    if state == 199 then
                                                        state = r39
                                                        r27 = r2
                                                        state = 195
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 203 then
                                            if state <= 201 then
                                                if state <= 200 then
                                                    if state == 200 then
                                                        r3 = upvalueValues[upvalues[1]]
                                                        r43 = upvalueValues[upvalues[2]]
                                                        r37 = 1612499419886
                                                        r11 = "\147\216\1541\231\130'"
                                                        r22 = r43(r11, r37)
                                                        r8 = "IsA"
                                                        r8 = r14[r8]
                                                        r26 = r3[r22]
                                                        r8 = r8(r14, r26)
                                                        r2 = r8
                                                        state = 199
                                                    end
                                                else
                                                    if state == 201 then
                                                        state = 203
                                                    end
                                                end
                                            else
                                                if state <= 202 then
                                                    if state == 202 then
                                                        ReturnVal = {}
                                                        state = nil
                                                    end
                                                else
                                                    if state == 203 then
                                                        state = true
                                                        state = state and (204) or (205)
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 205 then
                                                if state <= 204 then
                                                    if state == 204 then
                                                        state = 203
                                                    end
                                                else
                                                    if state == 205 then
                                                        state = 206
                                                    end
                                                end
                                            else
                                                if state == 206 then
                                                    r14 = nil
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure1 entry 1682268 -> 207, states 207-210
                                    if state <= 208 then
                                        if state <= 207 then
                                            if state == 207 then -- entry 1682268 -> 207
                                                state = 208
                                            end
                                        else
                                            if state == 208 then
                                                state = true
                                                state = state and (209) or (210)
                                            end
                                        end
                                    else
                                        if state <= 209 then
                                            if state == 209 then
                                                state = 208
                                            end
                                        else
                                            if state == 210 then
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    else
                        if state <= 228 then
                            if state <= 224 then
                                if state <= 217 then
                                    -- createClosure2 entry 11354219 -> 211, states 211-217
                                    if state <= 214 then
                                        if state <= 212 then
                                            if state <= 211 then
                                                if state == 211 then -- entry 11354219 -> 211
                                                    r14 = args[1]
                                                    r36 = "string"
                                                    r27 = _env[r36]
                                                    r2 = upvalueValues[upvalues[1]]
                                                    r39 = upvalueValues[upvalues[2]]
                                                    r3 = 24376859405399
                                                    r26 = "\253BUh\012"
                                                    r8 = r39(r26, r3)
                                                    r36 = r2[r8]
                                                    ReturnVal = r27[r36]
                                                    r39 = upvalueValues[upvalues[1]]
                                                    r8 = upvalueValues[upvalues[2]]
                                                    r43 = 22451706390742
                                                    r3 = "\252\149\186X"
                                                    r26 = r8(r3, r43)
                                                    r2 = r39[r26]
                                                    r36 = r14[r2]
                                                    r27 = ReturnVal(r36)
                                                    r36 = upvalueValues[upvalues[1]]
                                                    r2 = upvalueValues[upvalues[2]]
                                                    r26 = 14682738399925
                                                    r8 = "\148>\181Q\220\1909K\168\228\025\166F*$J"
                                                    r39 = r2(r8, r26)
                                                    ReturnVal = r36[r39]
                                                    state = r27 ~= ReturnVal
                                                    state = state and (212) or (213)
                                                end
                                            else
                                                if state == 212 then
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state <= 213 then
                                                if state == 213 then
                                                    state = 214
                                                end
                                            else
                                                if state == 214 then
                                                    state = true
                                                    state = state and (215) or (216)
                                                end
                                            end
                                        end
                                    else
                                        if state <= 216 then
                                            if state <= 215 then
                                                if state == 215 then
                                                    state = 214
                                                end
                                            else
                                                if state == 216 then
                                                    state = 217
                                                end
                                            end
                                        else
                                            if state == 217 then
                                                r14 = nil
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    -- createClosure entry 2822095 -> 218, states 218-224
                                    if state <= 221 then
                                        if state <= 219 then
                                            if state <= 218 then
                                                if state == 218 then -- entry 2822095 -> 218
                                                    r27 = {
                                                        select(2, unpack(args))
                                                    }
                                                    r14 = args[1]
                                                    ReturnVal = "getnamecallmethod"
                                                    state = _env[ReturnVal]
                                                    ReturnVal = state()
                                                    r36 = ReturnVal
                                                    r39 = "string"
                                                    r2 = _env[r39]
                                                    r8 = upvalueValues[upvalues[1]]
                                                    r26 = upvalueValues[upvalues[2]]
                                                    r22 = 16186995924337
                                                    r43 = "\176\031\027\200\017"
                                                    r3 = r26(r43, r22)
                                                    r39 = r8[r3]
                                                    ReturnVal = r2[r39]
                                                    r2 = ReturnVal(r36)
                                                    r39 = upvalueValues[upvalues[1]]
                                                    r8 = upvalueValues[upvalues[2]]
                                                    r43 = 18781371359785
                                                    r3 = "\140\235\210T\189\224\221,\212pn\170q"
                                                    r26 = r8(r3, r43)
                                                    ReturnVal = r39[r26]
                                                    state = r2 == ReturnVal
                                                    state = state and (219) or (220)
                                                end
                                            else
                                                if state == 219 then
                                                    state = 221
                                                end
                                            end
                                        else
                                            if state <= 220 then
                                                if state == 220 then
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            else
                                                if state == 221 then
                                                    state = true
                                                    state = state and (222) or (223)
                                                end
                                            end
                                        end
                                    else
                                        if state <= 223 then
                                            if state <= 222 then
                                                if state == 222 then
                                                    state = 221
                                                end
                                            else
                                                if state == 223 then
                                                    state = 224
                                                end
                                            end
                                        else
                                            if state == 224 then
                                                r14 = nil
                                                r36 = nil
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 227 then
                                    -- createClosure4 entry 13389040 -> 225, states 225-227
                                    if state <= 226 then
                                        if state <= 225 then
                                            if state == 225 then -- entry 13389040 -> 225
                                                r14 = upvalueValues[upvalues[1]]
                                                r36 = upvalueValues[upvalues[2]]
                                                r2 = upvalueValues[upvalues[3]]
                                                r26 = 21094836528735
                                                r8 = "\246\215\205\149z\022-q$2a\255\234\151"
                                                r39 = r2(r8, r26)
                                                r27 = r36[r39]
                                                ReturnVal = r14[r27]
                                                r2 = "Enum"
                                                r36 = _env[r2]
                                                r39 = upvalueValues[upvalues[2]]
                                                r8 = upvalueValues[upvalues[3]]
                                                r43 = 20325401732344
                                                r3 = "\226\241\179?f\131\227)#\138\231L\230\236"
                                                r26 = r8(r3, r43)
                                                r2 = r39[r26]
                                                r27 = r36[r2]
                                                r2 = upvalueValues[upvalues[2]]
                                                r39 = upvalueValues[upvalues[3]]
                                                r3 = 18329024454999
                                                r26 = "Fl\159"
                                                r8 = r39(r26, r3)
                                                r36 = r2[r8]
                                                r14 = r27[r36]
                                                state = ReturnVal == r14
                                                state = state and (226) or (227)
                                            end
                                        else
                                            if state == 226 then
                                                state = false
                                                upvalueValues[upvalues[4]] = state
                                                state = 227
                                            end
                                        end
                                    else
                                        if state == 227 then
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure4 entry 1474292 -> 228, states 228-228
                                    if state == 228 then -- entry 1474292 -> 228
                                        r2 = "Instance"
                                        ReturnVal = _env[r2]
                                        r14 = args[1]
                                        r27 = args[2]
                                        r36 = args[3]
                                        r39 = upvalueValues[upvalues[1]]
                                        r8 = upvalueValues[upvalues[2]]
                                        r3 = "\000L\228"
                                        r43 = 23390674463372
                                        r26 = r8(r3, r43)
                                        r2 = r39[r26]
                                        state = ReturnVal[r2]
                                        r39 = upvalueValues[upvalues[1]]
                                        r8 = upvalueValues[upvalues[2]]
                                        r43 = 32638590712670
                                        r3 = "O\252\031\133+\t\190\199X\024"
                                        r26 = r8(r3, r43)
                                        r2 = r39[r26]
                                        ReturnVal = state(r2)
                                        r2 = ReturnVal
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r39 = upvalueValues[upvalues[2]]
                                        r26 = "\164BCV"
                                        r3 = 33465441746143
                                        r8 = r39(r26, r3)
                                        state = ReturnVal[r8]
                                        ReturnVal = r14
                                        r2[state] = ReturnVal
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r39 = upvalueValues[upvalues[2]]
                                        r26 = "/\143\254\255+T"
                                        r3 = 34999431643049
                                        r8 = r39(r26, r3)
                                        state = ReturnVal[r8]
                                        ReturnVal = upvalueValues[upvalues[3]]
                                        r2[state] = ReturnVal
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r39 = upvalueValues[upvalues[2]]
                                        r26 = "\246\014c\181\178\251_y\130\150y\022\r\016A\217"
                                        r3 = 3745942931152
                                        r8 = r39(r26, r3)
                                        state = ReturnVal[r8]
                                        r8 = "Color3"
                                        r39 = _env[r8]
                                        r26 = upvalueValues[upvalues[1]]
                                        r3 = upvalueValues[upvalues[2]]
                                        r22 = "\132\025\157p\169\192\203"
                                        r11 = 6393070750625
                                        r43 = r3(r22, r11)
                                        r8 = r26[r43]
                                        ReturnVal = r39[r8]
                                        r3 = 80
                                        r26 = 255
                                        r8 = 80
                                        r39 = ReturnVal(r8, r26, r3)
                                        r2[state] = r39
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r39 = upvalueValues[upvalues[2]]
                                        r26 = "\2186\171g\174\254\182\025"
                                        r3 = 7079792561376
                                        r8 = r39(r26, r3)
                                        state = ReturnVal[r8]
                                        ReturnVal = r36
                                        r2[state] = ReturnVal
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r39 = upvalueValues[upvalues[2]]
                                        r3 = 4780625250482
                                        r26 = "\204T\252o"
                                        r8 = r39(r26, r3)
                                        state = ReturnVal[r8]
                                        r8 = "UDim2"
                                        r39 = _env[r8]
                                        r26 = upvalueValues[upvalues[1]]
                                        r3 = upvalueValues[upvalues[2]]
                                        r11 = 12699459163929
                                        r22 = "Lej"
                                        r43 = r3(r22, r11)
                                        r8 = r26[r43]
                                        ReturnVal = r39[r8]
                                        r43 = 0
                                        r26 = 0
                                        r3 = 0.2
                                        r8 = 0.8
                                        r39 = ReturnVal(r8, r26, r3, r43)
                                        r2[state] = r39
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r39 = upvalueValues[upvalues[2]]
                                        r26 = "6'\019\003"
                                        r3 = 21213483837078
                                        r8 = r39(r26, r3)
                                        state = ReturnVal[r8]
                                        r26 = "Enum"
                                        r8 = _env[r26]
                                        r3 = upvalueValues[upvalues[1]]
                                        r43 = upvalueValues[upvalues[2]]
                                        r37 = 30985671506012
                                        r11 = "=\\@\000"
                                        r22 = r43(r11, r37)
                                        r26 = r3[r22]
                                        r39 = r8[r26]
                                        r26 = upvalueValues[upvalues[1]]
                                        r3 = upvalueValues[upvalues[2]]
                                        r11 = 18639992693223
                                        r22 = "\2410\231S\181\191\230s\242\203"
                                        r43 = r3(r22, r11)
                                        r8 = r26[r43]
                                        ReturnVal = r39[r8]
                                        r2[state] = ReturnVal
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r39 = upvalueValues[upvalues[2]]
                                        r26 = "\"\163\177\249"
                                        r3 = 26343814524907
                                        r8 = r39(r26, r3)
                                        state = ReturnVal[r8]
                                        ReturnVal = r27
                                        r2[state] = ReturnVal
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r39 = upvalueValues[upvalues[2]]
                                        r3 = 21122479842923
                                        r26 = "\147n;\140\021\138\188\182\236&"
                                        r8 = r39(r26, r3)
                                        state = ReturnVal[r8]
                                        r8 = "Color3"
                                        r39 = _env[r8]
                                        r26 = upvalueValues[upvalues[1]]
                                        r3 = upvalueValues[upvalues[2]]
                                        r11 = 3192598234574
                                        r22 = "\142^\145\030\215\213O"
                                        r43 = r3(r22, r11)
                                        r8 = r26[r43]
                                        ReturnVal = r39[r8]
                                        r26 = 255
                                        r3 = 255
                                        r8 = 255
                                        r39 = ReturnVal(r8, r26, r3)
                                        r2[state] = r39
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r39 = upvalueValues[upvalues[2]]
                                        r26 = "\138\1423\247\252l\031\\\179b"
                                        r3 = 3817425880817
                                        r8 = r39(r26, r3)
                                        state = ReturnVal[r8]
                                        ReturnVal = true
                                        r2[state] = ReturnVal
                                        ReturnVal = {
                                            r2
                                        }
                                        state = nil
                                    end
                                end
                            end
                        else
                            if state <= 230 then
                                if state <= 229 then
                                    -- createClosure5 entry 16362303 -> 229, states 229-229
                                    if state == 229 then -- entry 16362303 -> 229
                                        state = upvalueValues[upvalues[1]]
                                        ReturnVal = "Destroy"
                                        ReturnVal = state[ReturnVal]
                                        ReturnVal = ReturnVal(state)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                else
                                    -- createClosure0 entry 3605576 -> 230, states 230-230
                                    if state == 230 then -- entry 3605576 -> 230
                                        ReturnVal = "loadstring"
                                        state = _env[ReturnVal]
                                        r27 = "game"
                                        r14 = _env[r27]
                                        r2 = upvalueValues[upvalues[1]]
                                        r39 = upvalueValues[upvalues[2]]
                                        r26 = "\153$\171~'\021\179A[y~\140\156`\2193\244\019\233\188\241k\128\157\252\008Bs\022\180#\188-\220)\018\232\1359\020\218l\007f\029O\183\227|&\201\197\029\156\242b\209\199\234\019\218gch\017\241\030n\180VO\146"
                                        r3 = 11398621222075
                                        r8 = r39(r26, r3)
                                        r36 = r2[r8]
                                        r2 = "HttpGet"
                                        r2 = r14[r2]
                                        r27 = {
                                            r2(r14, r36)
                                        }
                                        ReturnVal = state(unpack(r27))
                                        state = ReturnVal()
                                        state = upvalueValues[upvalues[3]]
                                        ReturnVal = state()
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            else
                                if state <= 231 then
                                    -- createClosure3 entry 2293675 -> 231, states 231-231
                                    if state == 231 then -- entry 2293675 -> 231
                                        ReturnVal = "loadstring"
                                        state = _env[ReturnVal]
                                        r27 = "game"
                                        r14 = _env[r27]
                                        r2 = upvalueValues[upvalues[1]]
                                        r39 = upvalueValues[upvalues[2]]
                                        r26 = "\1273\236f^\181{%\180\030\211\205Do2\193\\n'o\203\200}\028D\13798{@\250\202ti`A\017\188e\159\194@\194)\236\163CF\197ypZ;\150\210\181\217\194c\226\205\214O\031\170\169{\165_rR\137*"
                                        r3 = 3654549554853
                                        r8 = r39(r26, r3)
                                        r36 = r2[r8]
                                        r2 = "HttpGet"
                                        r2 = r14[r2]
                                        r27 = {
                                            r2(r14, r36)
                                        }
                                        ReturnVal = state(unpack(r27))
                                        state = ReturnVal()
                                        state = upvalueValues[upvalues[3]]
                                        ReturnVal = state()
                                        ReturnVal = {}
                                        state = nil
                                    end
                                else
                                    -- createClosure5 entry 8887276 -> 232, states 232-232
                                    if state == 232 then -- entry 8887276 -> 232
                                        ReturnVal = "loadstring"
                                        state = _env[ReturnVal]
                                        r27 = "game"
                                        r14 = _env[r27]
                                        r2 = upvalueValues[upvalues[1]]
                                        r39 = upvalueValues[upvalues[2]]
                                        r26 = "hdn\155L\225\024\186\175t\229\150cT\007\221$Q\176GRi\170\181Qk\195~A\008\255\189_\241\234{\196\235\017\146-\137\193\192\167\189\222%\202\236E\207\\\223\246\017w\193\022\021\236\024\167?\184\232\173}7\209\244\008\163\137"
                                        r3 = 29188026905879
                                        r8 = r39(r26, r3)
                                        r36 = r2[r8]
                                        r2 = "HttpGet"
                                        r2 = r14[r2]
                                        r27 = {
                                            r2(r14, r36)
                                        }
                                        ReturnVal = state(unpack(r27))
                                        state = ReturnVal()
                                        state = upvalueValues[upvalues[3]]
                                        ReturnVal = state()
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