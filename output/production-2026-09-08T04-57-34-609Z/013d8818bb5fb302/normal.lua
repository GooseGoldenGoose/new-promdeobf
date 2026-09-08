return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, createClosure3, createClosure4, releaseUpvalues, createClosure1, createClosure, createUpvalueProxy, createClosure5, currentUpvalueId, releaseUpvalue, allocUpvalue, upvalueRefCounts, createClosure2, vm, upvalueValues)
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if upvalueRefCounts[upvalueId] == 0 then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = upvalueRefCounts[captures[captureIndex]] + (1)
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return -3384594
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -3384594
                    end
                })
            end
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
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, ReturnVal, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33
            while state do
                if state <= 56 then
                    if state <= 43 then
                        if state <= 42 then
                            if state <= 41 then
                                -- root entry 8033377 -> 1, states 1-41
                                if state <= 21 then
                                    if state <= 11 then
                                        if state <= 6 then
                                            if state <= 3 then
                                                if state <= 2 then
                                                    if state <= 1 then
                                                        if state == 1 then -- entry 8033377 -> 1
                                                            r15 = allocUpvalue()
                                                            r28 = createClosure5(42, {
                                                                r15
                                                            })
                                                            r18 = allocUpvalue()
                                                            state = true
                                                            upvalueValues[r18] = state
                                                            r21 = allocUpvalue()
                                                            r31 = "string"
                                                            ReturnVal = _env[r31]
                                                            r31 = "gmatch"
                                                            state = ReturnVal[r31]
                                                            r31 = allocUpvalue()
                                                            upvalueValues[r31] = state
                                                            state = createClosure2(43, {})
                                                            upvalueValues[r21] = state
                                                            state = false
                                                            upvalueValues[r15] = state
                                                            r24 = "pcall"
                                                            r32 = _env[r24]
                                                            r24 = r32(r28)
                                                            state = r24 and (2) or (3)
                                                            r3 = args
                                                            ReturnVal = r24
                                                        end
                                                    else
                                                        if state == 2 then
                                                            r32 = upvalueValues[r15]
                                                            ReturnVal = r32
                                                            state = 3
                                                        end
                                                    end
                                                else
                                                    if state == 3 then
                                                        r32 = ReturnVal
                                                        r24 = "math"
                                                        ReturnVal = _env[r24]
                                                        r24 = "random"
                                                        state = ReturnVal[r24]
                                                        r24 = allocUpvalue()
                                                        upvalueValues[r24] = state
                                                        r28 = "table"
                                                        ReturnVal = _env[r28]
                                                        r28 = "concat"
                                                        state = ReturnVal[r28]
                                                        r30 = state
                                                        r28 = state
                                                        r11 = "table"
                                                        r22 = _env[r11]
                                                        state = r22 and (4) or (5)
                                                        r2 = r22
                                                    end
                                                end
                                            else
                                                if state <= 5 then
                                                    if state <= 4 then
                                                        if state == 4 then
                                                            r25 = "table"
                                                            r11 = _env[r25]
                                                            r25 = "unpack"
                                                            r22 = r11[r25]
                                                            r2 = r22
                                                            state = 5
                                                        end
                                                    else
                                                        if state == 5 then
                                                            state = r30
                                                            state = r2 and (6) or (7)
                                                            ReturnVal = r2
                                                        end
                                                    end
                                                else
                                                    if state == 6 then
                                                        r2 = allocUpvalue()
                                                        upvalueValues[r2] = ReturnVal
                                                        state = upvalueValues[r24]
                                                        r22 = 65
                                                        r30 = 3
                                                        ReturnVal = state(r30, r22)
                                                        r30 = allocUpvalue()
                                                        upvalueValues[r30] = ReturnVal
                                                        state = 0
                                                        r22 = state
                                                        r1 = createClosure4(44, {})
                                                        state = 0
                                                        r25 = "pcall"
                                                        ReturnVal = _env[r25]
                                                        r25 = {
                                                            ReturnVal(r1)
                                                        }
                                                        r11 = state
                                                        state = {
                                                            unpack(r25)
                                                        }
                                                        r25 = state
                                                        ReturnVal = 2
                                                        state = r25[ReturnVal]
                                                        r1 = state
                                                        ReturnVal = "tonumber"
                                                        state = _env[ReturnVal]
                                                        r26 = upvalueValues[r31]
                                                        r10 = "tostring"
                                                        r8 = _env[r10]
                                                        r10 = r8(r1)
                                                        r8 = ":(%d*):"
                                                        r16 = r26(r10, r8)
                                                        r26 = {
                                                            r16()
                                                        }
                                                        ReturnVal = state(unpack(r26))
                                                        r26 = allocUpvalue()
                                                        upvalueValues[r26] = ReturnVal
                                                        r16 = upvalueValues[r30]
                                                        r8 = r16
                                                        r16 = 1
                                                        r10 = r16
                                                        r16 = 0
                                                        r13 = r10 < r16
                                                        ReturnVal = 1
                                                        r16 = ReturnVal - r10
                                                        state = 8
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 9 then
                                                if state <= 8 then
                                                    if state <= 7 then
                                                        if state == 7 then
                                                            r30 = "unpack"
                                                            r2 = _env[r30]
                                                            ReturnVal = r2
                                                            state = 6
                                                        end
                                                    else
                                                        if state == 8 then
                                                            r16 = r16 + r10
                                                            ReturnVal = r16 <= r8
                                                            r17 = not r13
                                                            ReturnVal = r17 and ReturnVal
                                                            r17 = r16 >= r8
                                                            r17 = r13 and r17
                                                            ReturnVal = r17 or ReturnVal
                                                            r17 = (9)
                                                            state = ReturnVal and r17
                                                            ReturnVal = (10)
                                                            state = state or ReturnVal
                                                        end
                                                    end
                                                else
                                                    if state == 9 then
                                                        r17 = allocUpvalue()
                                                        upvalueValues[r17] = r16
                                                        r9 = "math"
                                                        ReturnVal = _env[r9]
                                                        r9 = "random"
                                                        state = ReturnVal[r9]
                                                        r29 = 100
                                                        r9 = 1
                                                        ReturnVal = state(r9, r29)
                                                        r9 = allocUpvalue()
                                                        upvalueValues[r9] = ReturnVal
                                                        state = upvalueValues[r24]
                                                        r29 = 0
                                                        r7 = 255
                                                        ReturnVal = state(r29, r7)
                                                        r29 = allocUpvalue()
                                                        upvalueValues[r29] = ReturnVal
                                                        state = upvalueValues[r24]
                                                        r27 = upvalueValues[r9]
                                                        r7 = 1
                                                        ReturnVal = state(r7, r27)
                                                        r7 = allocUpvalue()
                                                        upvalueValues[r7] = ReturnVal
                                                        ReturnVal = upvalueValues[r24]
                                                        r23 = 1
                                                        r5 = 2
                                                        r27 = ReturnVal(r23, r5)
                                                        ReturnVal = 1
                                                        state = r27 == ReturnVal
                                                        r27 = allocUpvalue()
                                                        upvalueValues[r27] = state
                                                        r6 = "tostring"
                                                        r14 = _env[r6]
                                                        r33 = upvalueValues[r24]
                                                        r19 = 0
                                                        r20 = 10000
                                                        r4 = {
                                                            r33(r19, r20)
                                                        }
                                                        r6 = r14(unpack(r4))
                                                        state = "gsub"
                                                        state = r1[state]
                                                        r14 = ":"
                                                        r12 = r6 .. r14
                                                        r5 = ":"
                                                        r23 = r5 .. r12
                                                        ReturnVal = ":(%d*):"
                                                        state = state(r1, ReturnVal, r23)
                                                        r23 = allocUpvalue()
                                                        upvalueValues[r23] = state
                                                        r5 = "pcall"
                                                        ReturnVal = _env[r5]
                                                        r12 = createClosure5(45, {
                                                            r24,
                                                            r17,
                                                            r30,
                                                            r31,
                                                            r18,
                                                            r26,
                                                            r27,
                                                            r23,
                                                            r9,
                                                            r7,
                                                            r29,
                                                            r2
                                                        })
                                                        r5 = {
                                                            ReturnVal(r12)
                                                        }
                                                        state = {
                                                            unpack(r5)
                                                        }
                                                        r5 = state
                                                        state = upvalueValues[r27]
                                                        state = state and (11) or (12)
                                                    end
                                                end
                                            else
                                                if state <= 10 then
                                                    if state == 10 then
                                                        r8 = upvalueValues[r18]
                                                        state = r8 and (13) or (14)
                                                        r16 = r8
                                                    end
                                                else
                                                    if state == 11 then
                                                        r12 = upvalueValues[r18]
                                                        state = r12 and (15) or (16)
                                                        ReturnVal = r12
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 16 then
                                            if state <= 14 then
                                                if state <= 13 then
                                                    if state <= 12 then
                                                        if state == 12 then
                                                            r14 = upvalueValues[r18]
                                                            state = r14 and (17) or (18)
                                                            r12 = r14
                                                        end
                                                    else
                                                        if state == 13 then
                                                            r8 = r22 == r11
                                                            r16 = r8
                                                            state = 14
                                                        end
                                                    end
                                                else
                                                    if state == 14 then
                                                        upvalueValues[r18] = r16
                                                        state = upvalueValues[r18]
                                                        state = state and (19) or (20)
                                                    end
                                                end
                                            else
                                                if state <= 15 then
                                                    if state == 15 then
                                                        r14 = state
                                                        r4 = 1
                                                        r33 = r5[r4]
                                                        r4 = false
                                                        r6 = r33 == r4
                                                        state = r6 and (21) or (22)
                                                        r12 = r6
                                                    end
                                                else
                                                    if state == 16 then
                                                        upvalueValues[r18] = ReturnVal
                                                        state = 23
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 19 then
                                                if state <= 18 then
                                                    if state <= 17 then
                                                        if state == 17 then
                                                            r6 = 1
                                                            r14 = r5[r6]
                                                            r12 = r14
                                                            state = 18
                                                        end
                                                    else
                                                        if state == 18 then
                                                            upvalueValues[r18] = r12
                                                            r4 = upvalueValues[r7]
                                                            r19 = 1
                                                            r33 = r4 + r19
                                                            r6 = r5[r33]
                                                            r14 = r22 + r6
                                                            r6 = 256
                                                            state = r14 % r6
                                                            r22 = state
                                                            r33 = upvalueValues[r29]
                                                            r6 = r11 + r33
                                                            r33 = 256
                                                            r14 = r6 % r33
                                                            r11 = r14
                                                            state = 23
                                                        end
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
                                                        r4 = 2
                                                        r33 = r5[r4]
                                                        r4 = upvalueValues[r23]
                                                        r6 = r33 == r4
                                                        r12 = r6
                                                        state = 22
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    if state <= 31 then
                                        if state <= 26 then
                                            if state <= 24 then
                                                if state <= 23 then
                                                    if state <= 22 then
                                                        if state == 22 then
                                                            state = r14
                                                            ReturnVal = r12
                                                            state = 16
                                                        end
                                                    else
                                                        if state == 23 then
                                                            r5 = nil
                                                            r17 = releaseUpvalue(r17)
                                                            r27 = releaseUpvalue(r27)
                                                            r29 = releaseUpvalue(r29)
                                                            r23 = releaseUpvalue(r23)
                                                            r9 = releaseUpvalue(r9)
                                                            r7 = releaseUpvalue(r7)
                                                            state = 8
                                                        end
                                                    end
                                                else
                                                    if state == 24 then
                                                        r1 = nil
                                                        r15 = releaseUpvalue(r15)
                                                        r26 = releaseUpvalue(r26)
                                                        r31 = releaseUpvalue(r31)
                                                        r11 = nil
                                                        r32 = nil
                                                        r32 = "math"
                                                        r18 = releaseUpvalue(r18)
                                                        r26 = 256
                                                        r13 = r26
                                                        r18 = nil
                                                        r31 = nil
                                                        r30 = releaseUpvalue(r30)
                                                        r24 = releaseUpvalue(r24)
                                                        r21 = releaseUpvalue(r21)
                                                        r30 = allocUpvalue()
                                                        r22 = nil
                                                        r22 = {}
                                                        r2 = releaseUpvalue(r2)
                                                        r15 = _env[r32]
                                                        r32 = "floor"
                                                        r21 = r15[r32]
                                                        r15 = allocUpvalue()
                                                        upvalueValues[r15] = r21
                                                        r24 = "math"
                                                        r32 = _env[r24]
                                                        r24 = "random"
                                                        r21 = r32[r24]
                                                        r28 = nil
                                                        r28 = "table"
                                                        r24 = _env[r28]
                                                        r28 = "remove"
                                                        r32 = r24[r28]
                                                        r11 = allocUpvalue()
                                                        r2 = "string"
                                                        r28 = _env[r2]
                                                        r2 = "char"
                                                        r24 = r28[r2]
                                                        r2 = allocUpvalue()
                                                        r25 = nil
                                                        r25 = {}
                                                        r28 = 0
                                                        upvalueValues[r2] = r28
                                                        r28 = 2
                                                        upvalueValues[r30] = r28
                                                        r28 = {}
                                                        upvalueValues[r11] = r22
                                                        r26 = 1
                                                        r17 = r26
                                                        r26 = 0
                                                        r9 = r17 < r26
                                                        r1 = 1
                                                        r26 = r1 - r17
                                                        r22 = 0
                                                        state = 26
                                                    end
                                                end
                                            else
                                                if state <= 25 then
                                                    if state == 25 then
                                                        state = createClosure1(57, {
                                                            r21
                                                        })
                                                        r8 = {
                                                            state()
                                                        }
                                                        ReturnVal = {
                                                            unpack(r8)
                                                        }
                                                        state = nil
                                                    end
                                                else
                                                    if state == 26 then
                                                        r26 = r26 + r17
                                                        r1 = r26 <= r13
                                                        r29 = not r9
                                                        r1 = r29 and r1
                                                        r29 = r26 >= r13
                                                        r29 = r9 and r29
                                                        r1 = r29 or r1
                                                        r29 = (27)
                                                        state = r1 and r29
                                                        r1 = (28)
                                                        state = state or r1
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 29 then
                                                if state <= 28 then
                                                    if state <= 27 then
                                                        if state == 27 then
                                                            r1 = r26
                                                            r29 = r1
                                                            r25[r1] = r29
                                                            r1 = nil
                                                            state = 26
                                                        end
                                                    else
                                                        if state == 28 then
                                                            r26 = #r25
                                                            r13 = 0
                                                            r1 = r26 == r13
                                                            state = 29
                                                        end
                                                    end
                                                else
                                                    if state == 29 then
                                                        r26 = 1
                                                        r13 = #r25
                                                        r1 = r21(r26, r13)
                                                        r26 = r32(r25, r1)
                                                        r13 = upvalueValues[r11]
                                                        r29 = 1
                                                        r9 = r26 - r29
                                                        r17 = r24(r9)
                                                        r13[r26] = r17
                                                        r1 = nil
                                                        r26 = nil
                                                        state = 30
                                                    end
                                                end
                                            else
                                                if state <= 30 then
                                                    if state == 30 then
                                                        r26 = #r25
                                                        r13 = 0
                                                        r1 = r26 == r13
                                                        state = r1 and (31) or (29)
                                                    end
                                                else
                                                    if state == 31 then
                                                        r1 = {}
                                                        r17 = allocUpvalue()
                                                        r26 = allocUpvalue()
                                                        upvalueValues[r26] = r1
                                                        r22 = nil
                                                        r13 = createClosure1(61, {
                                                            r26,
                                                            r2,
                                                            r30,
                                                            r15
                                                        })
                                                        r1 = allocUpvalue()
                                                        upvalueValues[r1] = r13
                                                        r13 = {}
                                                        r15 = releaseUpvalue(r15)
                                                        upvalueValues[r17] = r13
                                                        r5 = "__metatable"
                                                        r27 = "__index"
                                                        r21 = nil
                                                        r24 = nil
                                                        r9 = "setmetatable"
                                                        r25 = nil
                                                        r13 = _env[r9]
                                                        r23 = upvalueValues[r17]
                                                        r29 = {}
                                                        r6 = nil
                                                        r7 = {
                                                            [r27] = r23,
                                                            [r5] = r6
                                                        }
                                                        r9 = r13(r29, r7)
                                                        r13 = createClosure3(67, {
                                                            r17,
                                                            r26,
                                                            r11,
                                                            r2,
                                                            r30,
                                                            r1
                                                        })
                                                        r15 = "pairs"
                                                        r21 = _env[r15]
                                                        r11 = releaseUpvalue(r11)
                                                        r17 = releaseUpvalue(r17)
                                                        r30 = releaseUpvalue(r30)
                                                        r26 = releaseUpvalue(r26)
                                                        r1 = releaseUpvalue(r1)
                                                        r2 = releaseUpvalue(r2)
                                                        r2 = "getgc"
                                                        r28 = nil
                                                        r28 = _env[r2]
                                                        r30 = true
                                                        r2 = {
                                                            r28(r30)
                                                        }
                                                        r28 = {
                                                            r21(unpack(r2))
                                                        }
                                                        r32 = nil
                                                        r32 = r28[2]
                                                        r15 = r28[1]
                                                        r24 = r28[3]
                                                        r18 = r9
                                                        r31 = r13
                                                        state = 32
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 36 then
                                            if state <= 34 then
                                                if state <= 33 then
                                                    if state <= 32 then
                                                        if state == 32 then
                                                            r24, r28 = r15(r32, r24)
                                                            state = r24 and (33) or (34)
                                                        end
                                                    else
                                                        if state == 33 then
                                                            r22 = "typeof"
                                                            r30 = _env[r22]
                                                            r22 = r30(r28)
                                                            r1 = 33897642605992
                                                            r25 = "E\205\195\129."
                                                            r11 = r31(r25, r1)
                                                            r30 = r18[r11]
                                                            r2 = r22 == r30
                                                            state = r2 and (35) or (36)
                                                            r21 = r24
                                                        end
                                                    end
                                                else
                                                    if state == 34 then
                                                        r18 = nil
                                                        r31 = nil
                                                        ReturnVal = {}
                                                        state = nil
                                                    end
                                                end
                                            else
                                                if state <= 35 then
                                                    if state == 35 then
                                                        r30 = "pairs"
                                                        r2 = _env[r30]
                                                        r25 = {
                                                            r2(r28)
                                                        }
                                                        r11 = r25[3]
                                                        r30 = r25[1]
                                                        r22 = r25[2]
                                                        state = 37
                                                    end
                                                else
                                                    if state == 36 then
                                                        r21 = nil
                                                        r28 = nil
                                                        state = 32
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 39 then
                                                if state <= 38 then
                                                    if state <= 37 then
                                                        if state == 37 then
                                                            r11 = r30(r22, r11)
                                                            state = r11 and (38) or (39)
                                                        end
                                                    else
                                                        if state == 38 then
                                                            r1 = "tostring"
                                                            r25 = _env[r1]
                                                            r2 = r11
                                                            r1 = r25(r2)
                                                            r25 = "lower"
                                                            r25 = r1[r25]
                                                            r25 = r25(r1)
                                                            r1 = "find"
                                                            r1 = r25[r1]
                                                            r29 = 9713187541419
                                                            r17 = "\008\233y\255\215|\224D"
                                                            r13 = r31(r17, r29)
                                                            r26 = r18[r13]
                                                            r1 = r1(r25, r26)
                                                            state = r1 and (40) or (41)
                                                        end
                                                    end
                                                else
                                                    if state == 39 then
                                                        state = 36
                                                    end
                                                end
                                            else
                                                if state <= 40 then
                                                    if state == 40 then
                                                        r1 = "print"
                                                        r25 = _env[r1]
                                                        r17 = "F\173y\150\186)\200\1754i\219\r8\137h\150\159\158\240^\2027)"
                                                        r29 = 12415634544277
                                                        r13 = r31(r17, r29)
                                                        r26 = r18[r13]
                                                        r1 = r25(r26, r2)
                                                        state = 41
                                                    end
                                                else
                                                    if state == 41 then
                                                        r2 = nil
                                                        state = 37
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure5 entry 15506715 -> 42, states 42-42
                                if state == 42 then -- entry 15506715 -> 42
                                    state = true
                                    upvalueValues[upvalues[1]] = state
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        else
                            -- createClosure2 entry 5877762 -> 43, states 43-43
                            if state == 43 then -- entry 5877762 -> 43
                                ReturnVal = "error"
                                state = _env[ReturnVal]
                                r3 = "Tamper Detected!"
                                ReturnVal = state(r3)
                                ReturnVal = {}
                                state = nil
                            end
                        end
                    else
                        if state <= 44 then
                            -- createClosure4 entry 3361416 -> 44, states 44-44
                            if state == 44 then -- entry 3361416 -> 44
                                r31 = 4547536
                                r18 = "CLfn"
                                r3 = r18 ^ r31
                                ReturnVal = 12341473
                                state = ReturnVal - r3
                                r3 = state
                                ReturnVal = "6fPrnRB9cRs"
                                state = ReturnVal / r3
                                ReturnVal = {
                                    state
                                }
                                state = nil
                            end
                        else
                            -- createClosure5 entry 14945958 -> 45, states 45-56
                            if state <= 50 then
                                if state <= 47 then
                                    if state <= 46 then
                                        if state <= 45 then
                                            if state == 45 then -- entry 14945958 -> 45
                                                r18 = upvalueValues[upvalues[1]]
                                                r21 = 1
                                                r15 = 2
                                                r31 = r18(r21, r15)
                                                r18 = 1
                                                r3 = r31 == r18
                                                state = r3 and (46) or (47)
                                                ReturnVal = r3
                                            end
                                        else
                                            if state == 46 then
                                                state = ReturnVal and (48) or (49)
                                            end
                                        end
                                    else
                                        if state == 47 then
                                            r18 = upvalueValues[upvalues[2]]
                                            r31 = upvalueValues[upvalues[3]]
                                            r3 = r18 == r31
                                            ReturnVal = r3
                                            state = 46
                                        end
                                    end
                                else
                                    if state <= 49 then
                                        if state <= 48 then
                                            if state == 48 then
                                                ReturnVal = "tonumber"
                                                state = _env[ReturnVal]
                                                r2 = createClosure1(74, {})
                                                r3 = upvalueValues[upvalues[4]]
                                                r21 = "tostring"
                                                r31 = _env[r21]
                                                r28 = "pcall"
                                                r24 = _env[r28]
                                                r28 = {
                                                    r24(r2)
                                                }
                                                r32 = {
                                                    unpack(r28)
                                                }
                                                r24 = 2
                                                r15 = r32[r24]
                                                r21 = r31(r15)
                                                r31 = ":(%d*):"
                                                r18 = r3(r21, r31)
                                                r3 = {
                                                    r18()
                                                }
                                                ReturnVal = state(unpack(r3))
                                                r3 = ReturnVal
                                                r18 = upvalueValues[upvalues[5]]
                                                state = r18 and (50) or (51)
                                                ReturnVal = r18
                                            end
                                        else
                                            if state == 49 then
                                                state = upvalueValues[upvalues[7]]
                                                state = state and (52) or (53)
                                            end
                                        end
                                    else
                                        if state == 50 then
                                            r31 = upvalueValues[upvalues[6]]
                                            r18 = r31 == r3
                                            ReturnVal = r18
                                            state = 51
                                        end
                                    end
                                end
                            else
                                if state <= 53 then
                                    if state <= 52 then
                                        if state <= 51 then
                                            if state == 51 then
                                                r3 = nil
                                                upvalueValues[upvalues[5]] = ReturnVal
                                                state = 49
                                            end
                                        else
                                            if state == 52 then
                                                r3 = "error"
                                                state = _env[r3]
                                                r18 = upvalueValues[upvalues[8]]
                                                r31 = 0
                                                r3 = state(r18, r31)
                                                state = 53
                                            end
                                        end
                                    else
                                        if state == 53 then
                                            state = {}
                                            r3 = state
                                            r31 = upvalueValues[upvalues[9]]
                                            r21 = r31
                                            r31 = 1
                                            r15 = r31
                                            r31 = 0
                                            r32 = r15 < r31
                                            r18 = 1
                                            r31 = r18 - r15
                                            state = 54
                                        end
                                    end
                                else
                                    if state <= 55 then
                                        if state <= 54 then
                                            if state == 54 then
                                                r24 = not r32
                                                r31 = r31 + r15
                                                r18 = r31 <= r21
                                                r18 = r24 and r18
                                                r24 = r31 >= r21
                                                r24 = r32 and r24
                                                r18 = r24 or r18
                                                r24 = (55)
                                                state = r18 and r24
                                                r18 = (56)
                                                state = state or r18
                                            end
                                        else
                                            if state == 55 then
                                                r18 = r31
                                                state = upvalueValues[upvalues[1]]
                                                r2 = 255
                                                r28 = 0
                                                r24 = state(r28, r2)
                                                r3[r18] = r24
                                                r18 = nil
                                                state = 54
                                            end
                                        end
                                    else
                                        if state == 56 then
                                            state = upvalueValues[upvalues[10]]
                                            r18 = upvalueValues[upvalues[11]]
                                            r3[state] = r18
                                            state = upvalueValues[upvalues[12]]
                                            r18 = {
                                                state(r3)
                                            }
                                            ReturnVal = {
                                                unpack(r18)
                                            }
                                            state = nil
                                        end
                                    end
                                end
                            end
                        end
                    end
                else
                    if state <= 66 then
                        if state <= 60 then
                            -- createClosure1 entry 15839796 -> 57, states 57-60
                            if state <= 58 then
                                if state <= 57 then
                                    if state == 57 then -- entry 15839796 -> 57
                                        state = 58
                                    end
                                else
                                    if state == 58 then
                                        state = true
                                        state = state and (59) or (60)
                                    end
                                end
                            else
                                if state <= 59 then
                                    if state == 59 then
                                        ReturnVal = "l2"
                                        state = _env[ReturnVal]
                                        r3 = "l1"
                                        ReturnVal = _env[r3]
                                        r3 = "l1"
                                        _env[r3] = state
                                        r3 = "l2"
                                        _env[r3] = ReturnVal
                                        r3 = upvalueValues[upvalues[1]]
                                        r18 = r3()
                                        state = 58
                                    end
                                else
                                    if state == 60 then
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            end
                        else
                            -- createClosure1 entry 15723537 -> 61, states 61-66
                            if state <= 63 then
                                if state <= 62 then
                                    if state <= 61 then
                                        if state == 61 then -- entry 15723537 -> 61
                                            r3 = upvalueValues[upvalues[1]]
                                            ReturnVal = #r3
                                            r3 = 0
                                            state = ReturnVal == r3
                                            state = state and (62) or (63)
                                        end
                                    else
                                        if state == 62 then
                                            r18 = upvalueValues[upvalues[2]]
                                            r31 = 241
                                            r3 = r18 * r31
                                            r18 = 22191835244637
                                            ReturnVal = r3 + r18
                                            r3 = 35184372088832
                                            state = ReturnVal % r3
                                            upvalueValues[upvalues[2]] = state
                                            r3 = upvalueValues[upvalues[3]]
                                            r18 = 1
                                            ReturnVal = r3 ~= r18
                                            state = 64
                                        end
                                    end
                                else
                                    if state == 63 then
                                        r31 = "table"
                                        r18 = _env[r31]
                                        r31 = "remove"
                                        r3 = r18[r31]
                                        r31 = upvalueValues[upvalues[1]]
                                        r18 = {
                                            r3(r31)
                                        }
                                        ReturnVal = {
                                            unpack(r18)
                                        }
                                        state = nil
                                    end
                                end
                            else
                                if state <= 65 then
                                    if state <= 64 then
                                        if state == 64 then
                                            r18 = upvalueValues[upvalues[3]]
                                            r31 = 186
                                            r3 = r18 * r31
                                            r18 = 257
                                            ReturnVal = r3 % r18
                                            upvalueValues[upvalues[3]] = ReturnVal
                                            state = 65
                                        end
                                    else
                                        if state == 65 then
                                            r18 = upvalueValues[upvalues[3]]
                                            r31 = 1
                                            r3 = r18 ~= r31
                                            state = r3 and (66) or (64)
                                        end
                                    end
                                else
                                    if state == 66 then
                                        r31 = 32
                                        r18 = upvalueValues[upvalues[3]]
                                        r3 = r18 % r31
                                        r2 = 2
                                        r21 = upvalueValues[upvalues[4]]
                                        r24 = upvalueValues[upvalues[2]]
                                        r1 = upvalueValues[upvalues[3]]
                                        r25 = r1 - r3
                                        r1 = 32
                                        r11 = r25 / r1
                                        r22 = 13
                                        r30 = r22 - r11
                                        r28 = r2 ^ r30
                                        r32 = r24 / r28
                                        r15 = r21(r32)
                                        r21 = 4294967296
                                        r31 = r15 % r21
                                        r15 = 2
                                        r28 = 1
                                        r21 = r15 ^ r3
                                        r18 = r31 / r21
                                        r21 = upvalueValues[upvalues[4]]
                                        r24 = r18 % r28
                                        r28 = 4294967296
                                        r32 = r24 * r28
                                        r15 = r21(r32)
                                        r21 = upvalueValues[upvalues[4]]
                                        r32 = r21(r18)
                                        r22 = 256
                                        r3 = nil
                                        r31 = r15 + r32
                                        r15 = 65536
                                        r24 = 65536
                                        r21 = r31 % r15
                                        r32 = r31 - r21
                                        r2 = 256
                                        r15 = r32 / r24
                                        r24 = 256
                                        r32 = r21 % r24
                                        r28 = r21 - r32
                                        r24 = r28 / r2
                                        r21 = nil
                                        r2 = 256
                                        r28 = r15 % r2
                                        r30 = r15 - r28
                                        r18 = nil
                                        r31 = nil
                                        r2 = r30 / r22
                                        r30 = {
                                            r32,
                                            r24,
                                            r28,
                                            r2
                                        }
                                        r24 = nil
                                        r15 = nil
                                        r2 = nil
                                        upvalueValues[upvalues[1]] = r30
                                        r32 = nil
                                        r28 = nil
                                        state = 63
                                    end
                                end
                            end
                        end
                    else
                        if state <= 73 then
                            -- createClosure3 entry 12579778 -> 67, states 67-73
                            if state <= 70 then
                                if state <= 68 then
                                    if state <= 67 then
                                        if state == 67 then -- entry 12579778 -> 67
                                            r3 = args[1]
                                            r18 = args[2]
                                            state = upvalueValues[upvalues[1]]
                                            r31 = state
                                            state = r31[r18]
                                            state = state and (68) or (69)
                                        end
                                    else
                                        if state == 68 then
                                            state = 70
                                        end
                                    end
                                else
                                    if state <= 69 then
                                        if state == 69 then
                                            state = {}
                                            upvalueValues[upvalues[2]] = state
                                            ReturnVal = upvalueValues[upvalues[3]]
                                            r21 = ReturnVal
                                            r15 = 35184372088832
                                            ReturnVal = r18 % r15
                                            upvalueValues[upvalues[4]] = ReturnVal
                                            r24 = 255
                                            r32 = r18 % r24
                                            r24 = 2
                                            r15 = r32 + r24
                                            r30 = 1
                                            upvalueValues[upvalues[5]] = r15
                                            r22 = r30
                                            r28 = "string"
                                            r24 = _env[r28]
                                            r28 = "len"
                                            r32 = r24[r28]
                                            r24 = r32(r3)
                                            r32 = ""
                                            r31[r18] = r32
                                            r30 = 0
                                            r11 = r22 < r30
                                            r28 = 1
                                            r30 = r28 - r22
                                            r2 = r24
                                            r32 = 192
                                            state = 71
                                        end
                                    else
                                        if state == 70 then
                                            ReturnVal = {
                                                r18
                                            }
                                            state = nil
                                        end
                                    end
                                end
                            else
                                if state <= 72 then
                                    if state <= 71 then
                                        if state == 71 then
                                            r30 = r30 + r22
                                            r25 = not r11
                                            r28 = r30 <= r2
                                            r28 = r25 and r28
                                            r25 = r30 >= r2
                                            r25 = r11 and r25
                                            r28 = r25 or r28
                                            r25 = (72)
                                            state = r28 and r25
                                            r28 = (73)
                                            state = state or r28
                                        end
                                    else
                                        if state == 72 then
                                            r10 = "string"
                                            r8 = _env[r10]
                                            r28 = r30
                                            r10 = "byte"
                                            r16 = r8[r10]
                                            r8 = r16(r3, r28)
                                            r16 = upvalueValues[upvalues[6]]
                                            r10 = r16()
                                            r26 = r8 + r10
                                            r1 = r26 + r32
                                            r10 = 1
                                            r28 = nil
                                            r26 = 256
                                            r25 = r1 % r26
                                            r32 = r25
                                            r26 = r31[r18]
                                            r8 = r32 + r10
                                            r16 = r21[r8]
                                            r1 = r26 .. r16
                                            r31[r18] = r1
                                            state = 71
                                        end
                                    end
                                else
                                    if state == 73 then
                                        r21 = nil
                                        r32 = nil
                                        r24 = nil
                                        state = 70
                                    end
                                end
                            end
                        else
                            -- createClosure1 entry 12709862 -> 74, states 74-74
                            if state == 74 then -- entry 12709862 -> 74
                                r31 = 16635040
                                r18 = "qK"
                                r3 = r18 ^ r31
                                ReturnVal = 2781463
                                state = ReturnVal - r3
                                r3 = state
                                ReturnVal = "xXuD"
                                state = ReturnVal / r3
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
        upvalueRefCounts = {}
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