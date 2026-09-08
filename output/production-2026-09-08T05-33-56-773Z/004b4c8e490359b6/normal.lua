return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, upvalueValues, vm, upvalueRefCounts, createClosure4, releaseUpvalues, createClosure0, currentUpvalueId, createClosure, allocUpvalue, createClosure3, releaseUpvalue, createClosure5, createUpvalueProxy)
        createClosure0 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function()
                return vm(entryId, {}, captures, gcProxy)
            end
            return closure
        end
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        upvalueValues = {}
        currentUpvalueId = 0
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return -2055729
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -2055729
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
        upvalueRefCounts = {}
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
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if upvalueRefCounts[upvalueId] == 0 then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
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
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, ReturnVal, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33
            while state do
                if state <= 51 then
                    if state <= 38 then
                        if state <= 37 then
                            if state <= 36 then
                                -- root entry 3278879 -> 1, states 1-36
                                if state <= 18 then
                                    if state <= 9 then
                                        if state <= 5 then
                                            if state <= 3 then
                                                if state <= 2 then
                                                    if state <= 1 then
                                                        if state == 1 then -- entry 3278879 -> 1
                                                            r24 = allocUpvalue()
                                                            state = true
                                                            upvalueValues[r24] = state
                                                            r6 = "string"
                                                            ReturnVal = _env[r6]
                                                            r26 = allocUpvalue()
                                                            r6 = "gmatch"
                                                            state = ReturnVal[r6]
                                                            r6 = allocUpvalue()
                                                            upvalueValues[r6] = state
                                                            state = createClosure0(37, {})
                                                            upvalueValues[r26] = state
                                                            r30 = allocUpvalue()
                                                            state = false
                                                            upvalueValues[r30] = state
                                                            r14 = "pcall"
                                                            r27 = _env[r14]
                                                            r17 = createClosure5(38, {
                                                                r30
                                                            })
                                                            r14 = r27(r17)
                                                            state = r14 and (2) or (3)
                                                            r2 = args
                                                            ReturnVal = r14
                                                        end
                                                    else
                                                        if state == 2 then
                                                            r27 = upvalueValues[r30]
                                                            ReturnVal = r27
                                                            state = 3
                                                        end
                                                    end
                                                else
                                                    if state == 3 then
                                                        r27 = ReturnVal
                                                        r14 = "math"
                                                        ReturnVal = _env[r14]
                                                        r14 = "random"
                                                        state = ReturnVal[r14]
                                                        r14 = allocUpvalue()
                                                        upvalueValues[r14] = state
                                                        r17 = "table"
                                                        ReturnVal = _env[r17]
                                                        r17 = "concat"
                                                        state = ReturnVal[r17]
                                                        r1 = state
                                                        r17 = state
                                                        r5 = "table"
                                                        r16 = _env[r5]
                                                        state = r16 and (4) or (5)
                                                        r32 = r16
                                                    end
                                                end
                                            else
                                                if state <= 4 then
                                                    if state == 4 then
                                                        r28 = "table"
                                                        r5 = _env[r28]
                                                        r28 = "unpack"
                                                        r16 = r5[r28]
                                                        r32 = r16
                                                        state = 5
                                                    end
                                                else
                                                    if state == 5 then
                                                        state = r1
                                                        state = r32 and (6) or (7)
                                                        ReturnVal = r32
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 7 then
                                                if state <= 6 then
                                                    if state == 6 then
                                                        r32 = allocUpvalue()
                                                        upvalueValues[r32] = ReturnVal
                                                        state = upvalueValues[r14]
                                                        r16 = 65
                                                        r1 = 3
                                                        ReturnVal = state(r1, r16)
                                                        r11 = createClosure0(39, {})
                                                        r1 = allocUpvalue()
                                                        upvalueValues[r1] = ReturnVal
                                                        r28 = "pcall"
                                                        ReturnVal = _env[r28]
                                                        r28 = {
                                                            ReturnVal(r11)
                                                        }
                                                        state = 0
                                                        r16 = state
                                                        state = 0
                                                        r5 = state
                                                        state = {
                                                            unpack(r28)
                                                        }
                                                        r28 = state
                                                        ReturnVal = 2
                                                        state = r28[ReturnVal]
                                                        r11 = state
                                                        ReturnVal = "tonumber"
                                                        state = _env[ReturnVal]
                                                        r20 = upvalueValues[r6]
                                                        r10 = "tostring"
                                                        r23 = _env[r10]
                                                        r10 = r23(r11)
                                                        r23 = ":(%d*):"
                                                        r18 = r20(r10, r23)
                                                        r20 = {
                                                            r18()
                                                        }
                                                        ReturnVal = state(unpack(r20))
                                                        r20 = allocUpvalue()
                                                        upvalueValues[r20] = ReturnVal
                                                        r18 = upvalueValues[r1]
                                                        r23 = r18
                                                        r18 = 1
                                                        r10 = r18
                                                        r18 = 0
                                                        r13 = r10 < r18
                                                        ReturnVal = 1
                                                        r18 = ReturnVal - r10
                                                        state = 8
                                                    end
                                                else
                                                    if state == 7 then
                                                        r1 = "unpack"
                                                        r32 = _env[r1]
                                                        ReturnVal = r32
                                                        state = 6
                                                    end
                                                end
                                            else
                                                if state <= 8 then
                                                    if state == 8 then
                                                        r3 = not r13
                                                        r18 = r18 + r10
                                                        ReturnVal = r18 <= r23
                                                        ReturnVal = r3 and ReturnVal
                                                        r3 = r18 >= r23
                                                        r3 = r13 and r3
                                                        ReturnVal = r3 or ReturnVal
                                                        r3 = (9)
                                                        state = ReturnVal and r3
                                                        ReturnVal = (10)
                                                        state = state or ReturnVal
                                                    end
                                                else
                                                    if state == 9 then
                                                        r3 = allocUpvalue()
                                                        upvalueValues[r3] = r18
                                                        r33 = "math"
                                                        ReturnVal = _env[r33]
                                                        r33 = "random"
                                                        state = ReturnVal[r33]
                                                        r9 = 100
                                                        r33 = 1
                                                        ReturnVal = state(r33, r9)
                                                        r33 = allocUpvalue()
                                                        upvalueValues[r33] = ReturnVal
                                                        state = upvalueValues[r14]
                                                        r22 = 255
                                                        r9 = 0
                                                        ReturnVal = state(r9, r22)
                                                        r9 = allocUpvalue()
                                                        upvalueValues[r9] = ReturnVal
                                                        state = upvalueValues[r14]
                                                        r8 = upvalueValues[r33]
                                                        r22 = 1
                                                        ReturnVal = state(r22, r8)
                                                        r22 = allocUpvalue()
                                                        upvalueValues[r22] = ReturnVal
                                                        ReturnVal = upvalueValues[r14]
                                                        r21 = 2
                                                        r19 = 1
                                                        r8 = ReturnVal(r19, r21)
                                                        ReturnVal = 1
                                                        state = r8 == ReturnVal
                                                        r8 = allocUpvalue()
                                                        upvalueValues[r8] = state
                                                        r7 = "tostring"
                                                        r29 = _env[r7]
                                                        r25 = upvalueValues[r14]
                                                        state = "gsub"
                                                        state = r11[state]
                                                        r31 = 0
                                                        r12 = 10000
                                                        r15 = {
                                                            r25(r31, r12)
                                                        }
                                                        r7 = r29(unpack(r15))
                                                        r29 = ":"
                                                        r4 = r7 .. r29
                                                        r21 = ":"
                                                        r19 = r21 .. r4
                                                        ReturnVal = ":(%d*):"
                                                        state = state(r11, ReturnVal, r19)
                                                        r19 = allocUpvalue()
                                                        upvalueValues[r19] = state
                                                        r4 = createClosure4(40, {
                                                            r14,
                                                            r3,
                                                            r1,
                                                            r6,
                                                            r24,
                                                            r20,
                                                            r8,
                                                            r19,
                                                            r33,
                                                            r22,
                                                            r9,
                                                            r32
                                                        })
                                                        r21 = "pcall"
                                                        ReturnVal = _env[r21]
                                                        r21 = {
                                                            ReturnVal(r4)
                                                        }
                                                        state = {
                                                            unpack(r21)
                                                        }
                                                        r21 = state
                                                        state = upvalueValues[r8]
                                                        state = state and (11) or (12)
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 14 then
                                            if state <= 12 then
                                                if state <= 11 then
                                                    if state <= 10 then
                                                        if state == 10 then
                                                            r23 = upvalueValues[r24]
                                                            state = r23 and (13) or (14)
                                                            r18 = r23
                                                        end
                                                    else
                                                        if state == 11 then
                                                            r4 = upvalueValues[r24]
                                                            state = r4 and (15) or (16)
                                                            ReturnVal = r4
                                                        end
                                                    end
                                                else
                                                    if state == 12 then
                                                        r29 = upvalueValues[r24]
                                                        state = r29 and (17) or (18)
                                                        r4 = r29
                                                    end
                                                end
                                            else
                                                if state <= 13 then
                                                    if state == 13 then
                                                        r23 = r16 == r5
                                                        r18 = r23
                                                        state = 14
                                                    end
                                                else
                                                    if state == 14 then
                                                        upvalueValues[r24] = r18
                                                        state = upvalueValues[r24]
                                                        state = state and (19) or (20)
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 16 then
                                                if state <= 15 then
                                                    if state == 15 then
                                                        r29 = state
                                                        r15 = 1
                                                        r25 = r21[r15]
                                                        r15 = false
                                                        r7 = r25 == r15
                                                        state = r7 and (21) or (22)
                                                        r4 = r7
                                                    end
                                                else
                                                    if state == 16 then
                                                        upvalueValues[r24] = ReturnVal
                                                        state = 23
                                                    end
                                                end
                                            else
                                                if state <= 17 then
                                                    if state == 17 then
                                                        r7 = 1
                                                        r29 = r21[r7]
                                                        r4 = r29
                                                        state = 18
                                                    end
                                                else
                                                    if state == 18 then
                                                        upvalueValues[r24] = r4
                                                        r15 = upvalueValues[r22]
                                                        r31 = 1
                                                        r25 = r15 + r31
                                                        r7 = r21[r25]
                                                        r29 = r16 + r7
                                                        r7 = 256
                                                        state = r29 % r7
                                                        r16 = state
                                                        r25 = upvalueValues[r9]
                                                        r7 = r5 + r25
                                                        r25 = 256
                                                        r29 = r7 % r25
                                                        r5 = r29
                                                        state = 23
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    if state <= 27 then
                                        if state <= 23 then
                                            if state <= 21 then
                                                if state <= 20 then
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
                                                else
                                                    if state == 21 then
                                                        r15 = 2
                                                        r25 = r21[r15]
                                                        r15 = upvalueValues[r19]
                                                        r7 = r25 == r15
                                                        r4 = r7
                                                        state = 22
                                                    end
                                                end
                                            else
                                                if state <= 22 then
                                                    if state == 22 then
                                                        state = r29
                                                        ReturnVal = r4
                                                        state = 16
                                                    end
                                                else
                                                    if state == 23 then
                                                        r3 = releaseUpvalue(r3)
                                                        r22 = releaseUpvalue(r22)
                                                        r33 = releaseUpvalue(r33)
                                                        r8 = releaseUpvalue(r8)
                                                        r9 = releaseUpvalue(r9)
                                                        r19 = releaseUpvalue(r19)
                                                        r21 = nil
                                                        state = 8
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 25 then
                                                if state <= 24 then
                                                    if state == 24 then
                                                        r28 = nil
                                                        r32 = releaseUpvalue(r32)
                                                        r5 = nil
                                                        r20 = releaseUpvalue(r20)
                                                        r11 = nil
                                                        r11 = 1
                                                        r1 = releaseUpvalue(r1)
                                                        r26 = releaseUpvalue(r26)
                                                        r14 = releaseUpvalue(r14)
                                                        r1 = allocUpvalue()
                                                        r30 = releaseUpvalue(r30)
                                                        r16 = nil
                                                        r17 = nil
                                                        r27 = nil
                                                        r6 = releaseUpvalue(r6)
                                                        r6 = nil
                                                        r24 = releaseUpvalue(r24)
                                                        r24 = nil
                                                        r16 = {}
                                                        r27 = "math"
                                                        r30 = _env[r27]
                                                        r27 = "floor"
                                                        r26 = r30[r27]
                                                        r30 = allocUpvalue()
                                                        upvalueValues[r30] = r26
                                                        r14 = "math"
                                                        r27 = _env[r14]
                                                        r14 = "random"
                                                        r26 = r27[r14]
                                                        r5 = allocUpvalue()
                                                        r17 = "table"
                                                        r14 = _env[r17]
                                                        r17 = "remove"
                                                        r27 = r14[r17]
                                                        r32 = "string"
                                                        r17 = _env[r32]
                                                        r32 = "char"
                                                        r14 = r17[r32]
                                                        r28 = {}
                                                        r20 = 256
                                                        r32 = allocUpvalue()
                                                        r17 = 0
                                                        upvalueValues[r32] = r17
                                                        r17 = 2
                                                        upvalueValues[r1] = r17
                                                        r13 = r20
                                                        r17 = {}
                                                        r20 = 1
                                                        upvalueValues[r5] = r16
                                                        r3 = r20
                                                        r20 = 0
                                                        r33 = r3 < r20
                                                        r20 = r11 - r3
                                                        r16 = 0
                                                        state = 26
                                                    end
                                                else
                                                    if state == 25 then
                                                        state = createClosure4(52, {
                                                            r26
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
                                                if state <= 26 then
                                                    if state == 26 then
                                                        r20 = r20 + r3
                                                        r9 = not r33
                                                        r11 = r20 <= r13
                                                        r11 = r9 and r11
                                                        r9 = r20 >= r13
                                                        r9 = r33 and r9
                                                        r11 = r9 or r11
                                                        r9 = (27)
                                                        state = r11 and r9
                                                        r11 = (28)
                                                        state = state or r11
                                                    end
                                                else
                                                    if state == 27 then
                                                        r11 = r20
                                                        r9 = r11
                                                        r28[r11] = r9
                                                        r11 = nil
                                                        state = 26
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 32 then
                                            if state <= 30 then
                                                if state <= 29 then
                                                    if state <= 28 then
                                                        if state == 28 then
                                                            r20 = #r28
                                                            r13 = 0
                                                            r11 = r20 == r13
                                                            state = 29
                                                        end
                                                    else
                                                        if state == 29 then
                                                            r13 = #r28
                                                            r20 = 1
                                                            r11 = r26(r20, r13)
                                                            r20 = r27(r28, r11)
                                                            r13 = upvalueValues[r5]
                                                            r9 = 1
                                                            r33 = r20 - r9
                                                            r11 = nil
                                                            r3 = r14(r33)
                                                            r13[r20] = r3
                                                            r20 = nil
                                                            state = 30
                                                        end
                                                    end
                                                else
                                                    if state == 30 then
                                                        r20 = #r28
                                                        r13 = 0
                                                        r11 = r20 == r13
                                                        state = r11 and (31) or (29)
                                                    end
                                                end
                                            else
                                                if state <= 31 then
                                                    if state == 31 then
                                                        r20 = allocUpvalue()
                                                        r17 = nil
                                                        r7 = nil
                                                        r8 = "__index"
                                                        r11 = {}
                                                        r33 = "setmetatable"
                                                        r21 = "__metatable"
                                                        r28 = nil
                                                        upvalueValues[r20] = r11
                                                        r13 = createClosure0(56, {
                                                            r20,
                                                            r32,
                                                            r1,
                                                            r30
                                                        })
                                                        r3 = allocUpvalue()
                                                        r11 = allocUpvalue()
                                                        upvalueValues[r11] = r13
                                                        r13 = {}
                                                        upvalueValues[r3] = r13
                                                        r13 = _env[r33]
                                                        r30 = releaseUpvalue(r30)
                                                        r9 = {}
                                                        r19 = upvalueValues[r3]
                                                        r22 = {
                                                            [r8] = r19,
                                                            [r21] = r7
                                                        }
                                                        r33 = r13(r9, r22)
                                                        r13 = createClosure5(62, {
                                                            r3,
                                                            r20,
                                                            r5,
                                                            r32,
                                                            r1,
                                                            r11
                                                        })
                                                        r3 = releaseUpvalue(r3)
                                                        r11 = releaseUpvalue(r11)
                                                        r14 = nil
                                                        r26 = nil
                                                        r27 = nil
                                                        r6 = r33
                                                        r24 = r13
                                                        r32 = releaseUpvalue(r32)
                                                        r30 = state
                                                        r5 = releaseUpvalue(r5)
                                                        r16 = nil
                                                        r1 = releaseUpvalue(r1)
                                                        r20 = releaseUpvalue(r20)
                                                        r14 = "identifyexecutor"
                                                        r27 = _env[r14]
                                                        state = r27 and (32) or (33)
                                                        r26 = r27
                                                    end
                                                else
                                                    if state == 32 then
                                                        r14 = "identifyexecutor"
                                                        r27 = _env[r14]
                                                        r14 = r27()
                                                        r27 = "lower"
                                                        r27 = r14[r27]
                                                        r27 = r27(r14)
                                                        r16 = 23293040208478
                                                        r1 = "w\239\168\141\175"
                                                        r32 = r24(r1, r16)
                                                        r17 = r6[r32]
                                                        r14 = "find"
                                                        r14 = r27[r14]
                                                        r14 = r14(r27, r17)
                                                        r26 = r14
                                                        state = 33
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 34 then
                                                if state <= 33 then
                                                    if state == 33 then
                                                        state = r30
                                                        state = r26 and (34) or (35)
                                                    end
                                                else
                                                    if state == 34 then
                                                        r30 = "loadstring"
                                                        r26 = _env[r30]
                                                        r14 = "game"
                                                        r27 = _env[r14]
                                                        r16 = 34573558169315
                                                        r1 = "\180\186\209\000\200\171\003\131q\147\1843F\139\198\012\227\130-\131\\\024H\190\173GA\214\167?\179l"
                                                        r32 = r24(r1, r16)
                                                        r17 = r6[r32]
                                                        r32 = "HttpGet"
                                                        r32 = r27[r32]
                                                        r14 = {
                                                            r32(r27, r17)
                                                        }
                                                        r30 = r26(unpack(r14))
                                                        r26 = r30()
                                                        state = 36
                                                    end
                                                end
                                            else
                                                if state <= 35 then
                                                    if state == 35 then
                                                        r30 = "loadstring"
                                                        r26 = _env[r30]
                                                        r14 = "game"
                                                        r27 = _env[r14]
                                                        r1 = "\150\025\162\172\154\236X'4m#9\241\232\225\180NK\220z\146\165(\175\213\015\220\228bh|\181"
                                                        r16 = 34651469676295
                                                        r32 = r24(r1, r16)
                                                        r17 = r6[r32]
                                                        r32 = "HttpGet"
                                                        r32 = r27[r32]
                                                        r14 = {
                                                            r32(r27, r17)
                                                        }
                                                        r30 = r26(unpack(r14))
                                                        r26 = r30()
                                                        state = 36
                                                    end
                                                else
                                                    if state == 36 then
                                                        r6 = nil
                                                        r24 = nil
                                                        ReturnVal = {}
                                                        state = nil
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure0 entry 2516866 -> 37, states 37-37
                                if state == 37 then -- entry 2516866 -> 37
                                    ReturnVal = "error"
                                    state = _env[ReturnVal]
                                    r2 = "Tamper Detected!"
                                    ReturnVal = state(r2)
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        else
                            -- createClosure5 entry 6760750 -> 38, states 38-38
                            if state == 38 then -- entry 6760750 -> 38
                                state = true
                                upvalueValues[upvalues[1]] = state
                                ReturnVal = {}
                                state = nil
                            end
                        end
                    else
                        if state <= 39 then
                            -- createClosure0 entry 5788212 -> 39, states 39-39
                            if state == 39 then -- entry 5788212 -> 39
                                r6 = 1358537
                                r24 = "kvFMdfEF"
                                r2 = r24 ^ r6
                                ReturnVal = 270197
                                state = ReturnVal - r2
                                r2 = state
                                ReturnVal = "byoYjXFFJ"
                                state = ReturnVal / r2
                                ReturnVal = {
                                    state
                                }
                                state = nil
                            end
                        else
                            -- createClosure4 entry 8439436 -> 40, states 40-51
                            if state <= 45 then
                                if state <= 42 then
                                    if state <= 41 then
                                        if state <= 40 then
                                            if state == 40 then -- entry 8439436 -> 40
                                                r24 = upvalueValues[upvalues[1]]
                                                r30 = 2
                                                r26 = 1
                                                r6 = r24(r26, r30)
                                                r24 = 1
                                                r2 = r6 == r24
                                                state = r2 and (41) or (42)
                                                ReturnVal = r2
                                            end
                                        else
                                            if state == 41 then
                                                state = ReturnVal and (43) or (44)
                                            end
                                        end
                                    else
                                        if state == 42 then
                                            r24 = upvalueValues[upvalues[2]]
                                            r6 = upvalueValues[upvalues[3]]
                                            r2 = r24 == r6
                                            ReturnVal = r2
                                            state = 41
                                        end
                                    end
                                else
                                    if state <= 44 then
                                        if state <= 43 then
                                            if state == 43 then
                                                ReturnVal = "tonumber"
                                                state = _env[ReturnVal]
                                                r2 = upvalueValues[upvalues[4]]
                                                r26 = "tostring"
                                                r6 = _env[r26]
                                                r17 = "pcall"
                                                r14 = _env[r17]
                                                r32 = createClosure3(69, {})
                                                r17 = {
                                                    r14(r32)
                                                }
                                                r27 = {
                                                    unpack(r17)
                                                }
                                                r14 = 2
                                                r30 = r27[r14]
                                                r26 = r6(r30)
                                                r6 = ":(%d*):"
                                                r24 = r2(r26, r6)
                                                r2 = {
                                                    r24()
                                                }
                                                ReturnVal = state(unpack(r2))
                                                r2 = ReturnVal
                                                r24 = upvalueValues[upvalues[5]]
                                                state = r24 and (45) or (46)
                                                ReturnVal = r24
                                            end
                                        else
                                            if state == 44 then
                                                state = upvalueValues[upvalues[7]]
                                                state = state and (47) or (48)
                                            end
                                        end
                                    else
                                        if state == 45 then
                                            r6 = upvalueValues[upvalues[6]]
                                            r24 = r6 == r2
                                            ReturnVal = r24
                                            state = 46
                                        end
                                    end
                                end
                            else
                                if state <= 48 then
                                    if state <= 47 then
                                        if state <= 46 then
                                            if state == 46 then
                                                upvalueValues[upvalues[5]] = ReturnVal
                                                r2 = nil
                                                state = 44
                                            end
                                        else
                                            if state == 47 then
                                                r2 = "error"
                                                state = _env[r2]
                                                r24 = upvalueValues[upvalues[8]]
                                                r6 = 0
                                                r2 = state(r24, r6)
                                                state = 48
                                            end
                                        end
                                    else
                                        if state == 48 then
                                            state = {}
                                            r2 = state
                                            r6 = upvalueValues[upvalues[9]]
                                            r26 = r6
                                            r6 = 1
                                            r30 = r6
                                            r6 = 0
                                            r27 = r30 < r6
                                            r24 = 1
                                            r6 = r24 - r30
                                            state = 49
                                        end
                                    end
                                else
                                    if state <= 50 then
                                        if state <= 49 then
                                            if state == 49 then
                                                r6 = r6 + r30
                                                r14 = not r27
                                                r24 = r6 <= r26
                                                r24 = r14 and r24
                                                r14 = r6 >= r26
                                                r14 = r27 and r14
                                                r24 = r14 or r24
                                                r14 = (50)
                                                state = r24 and r14
                                                r24 = (51)
                                                state = state or r24
                                            end
                                        else
                                            if state == 50 then
                                                r24 = r6
                                                state = upvalueValues[upvalues[1]]
                                                r17 = 0
                                                r32 = 255
                                                r14 = state(r17, r32)
                                                r2[r24] = r14
                                                r24 = nil
                                                state = 49
                                            end
                                        end
                                    else
                                        if state == 51 then
                                            state = upvalueValues[upvalues[10]]
                                            r24 = upvalueValues[upvalues[11]]
                                            r2[state] = r24
                                            state = upvalueValues[upvalues[12]]
                                            r24 = {
                                                state(r2)
                                            }
                                            ReturnVal = {
                                                unpack(r24)
                                            }
                                            state = nil
                                        end
                                    end
                                end
                            end
                        end
                    end
                else
                    if state <= 61 then
                        if state <= 55 then
                            -- createClosure4 entry 7888830 -> 52, states 52-55
                            if state <= 53 then
                                if state <= 52 then
                                    if state == 52 then -- entry 7888830 -> 52
                                        state = 53
                                    end
                                else
                                    if state == 53 then
                                        state = true
                                        state = state and (54) or (55)
                                    end
                                end
                            else
                                if state <= 54 then
                                    if state == 54 then
                                        ReturnVal = "l2"
                                        state = _env[ReturnVal]
                                        r2 = "l1"
                                        ReturnVal = _env[r2]
                                        r2 = "l1"
                                        _env[r2] = state
                                        r2 = "l2"
                                        _env[r2] = ReturnVal
                                        r2 = upvalueValues[upvalues[1]]
                                        r24 = r2()
                                        state = 53
                                    end
                                else
                                    if state == 55 then
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            end
                        else
                            -- createClosure0 entry 11470653 -> 56, states 56-61
                            if state <= 58 then
                                if state <= 57 then
                                    if state <= 56 then
                                        if state == 56 then -- entry 11470653 -> 56
                                            r2 = upvalueValues[upvalues[1]]
                                            ReturnVal = #r2
                                            r2 = 0
                                            state = ReturnVal == r2
                                            state = state and (57) or (58)
                                        end
                                    else
                                        if state == 57 then
                                            r24 = upvalueValues[upvalues[2]]
                                            r6 = 73
                                            r2 = r24 * r6
                                            r24 = 19103885288127
                                            ReturnVal = r2 + r24
                                            r2 = 35184372088832
                                            state = ReturnVal % r2
                                            upvalueValues[upvalues[2]] = state
                                            r2 = upvalueValues[upvalues[3]]
                                            r24 = 1
                                            ReturnVal = r2 ~= r24
                                            state = 59
                                        end
                                    end
                                else
                                    if state == 58 then
                                        r6 = "table"
                                        r24 = _env[r6]
                                        r6 = "remove"
                                        r2 = r24[r6]
                                        r6 = upvalueValues[upvalues[1]]
                                        r24 = {
                                            r2(r6)
                                        }
                                        ReturnVal = {
                                            unpack(r24)
                                        }
                                        state = nil
                                    end
                                end
                            else
                                if state <= 60 then
                                    if state <= 59 then
                                        if state == 59 then
                                            r24 = upvalueValues[upvalues[3]]
                                            r6 = 48
                                            r2 = r24 * r6
                                            r24 = 257
                                            ReturnVal = r2 % r24
                                            upvalueValues[upvalues[3]] = ReturnVal
                                            state = 60
                                        end
                                    else
                                        if state == 60 then
                                            r24 = upvalueValues[upvalues[3]]
                                            r6 = 1
                                            r2 = r24 ~= r6
                                            state = r2 and (61) or (59)
                                        end
                                    end
                                else
                                    if state == 61 then
                                        r24 = upvalueValues[upvalues[3]]
                                        r6 = 32
                                        r32 = 2
                                        r2 = r24 % r6
                                        r26 = upvalueValues[upvalues[4]]
                                        r14 = upvalueValues[upvalues[2]]
                                        r11 = upvalueValues[upvalues[3]]
                                        r28 = r11 - r2
                                        r11 = 32
                                        r5 = r28 / r11
                                        r16 = 13
                                        r1 = r16 - r5
                                        r17 = r32 ^ r1
                                        r27 = r14 / r17
                                        r30 = r26(r27)
                                        r26 = 4294967296
                                        r6 = r30 % r26
                                        r30 = 2
                                        r32 = 256
                                        r26 = r30 ^ r2
                                        r24 = r6 / r26
                                        r17 = 1
                                        r26 = upvalueValues[upvalues[4]]
                                        r14 = r24 % r17
                                        r17 = 4294967296
                                        r27 = r14 * r17
                                        r30 = r26(r27)
                                        r26 = upvalueValues[upvalues[4]]
                                        r14 = 65536
                                        r27 = r26(r24)
                                        r6 = r30 + r27
                                        r30 = 65536
                                        r26 = r6 % r30
                                        r27 = r6 - r26
                                        r30 = r27 / r14
                                        r14 = 256
                                        r27 = r26 % r14
                                        r17 = r26 - r27
                                        r14 = r17 / r32
                                        r16 = 256
                                        r2 = nil
                                        r24 = nil
                                        r32 = 256
                                        r17 = r30 % r32
                                        r6 = nil
                                        r1 = r30 - r17
                                        r30 = nil
                                        r32 = r1 / r16
                                        r1 = {
                                            r27,
                                            r14,
                                            r17,
                                            r32
                                        }
                                        r26 = nil
                                        r17 = nil
                                        r27 = nil
                                        r14 = nil
                                        r32 = nil
                                        upvalueValues[upvalues[1]] = r1
                                        state = 58
                                    end
                                end
                            end
                        end
                    else
                        if state <= 68 then
                            -- createClosure5 entry 1527406 -> 62, states 62-68
                            if state <= 65 then
                                if state <= 63 then
                                    if state <= 62 then
                                        if state == 62 then -- entry 1527406 -> 62
                                            r2 = args[1]
                                            r24 = args[2]
                                            state = upvalueValues[upvalues[1]]
                                            r6 = state
                                            state = r6[r24]
                                            state = state and (63) or (64)
                                        end
                                    else
                                        if state == 63 then
                                            state = 65
                                        end
                                    end
                                else
                                    if state <= 64 then
                                        if state == 64 then
                                            state = {}
                                            upvalueValues[upvalues[2]] = state
                                            ReturnVal = upvalueValues[upvalues[3]]
                                            r26 = ReturnVal
                                            r30 = 35184372088832
                                            ReturnVal = r24 % r30
                                            upvalueValues[upvalues[4]] = ReturnVal
                                            r14 = 255
                                            r27 = r24 % r14
                                            r14 = 2
                                            r30 = r27 + r14
                                            upvalueValues[upvalues[5]] = r30
                                            r17 = "string"
                                            r14 = _env[r17]
                                            r17 = "len"
                                            r27 = r14[r17]
                                            r14 = r27(r2)
                                            r1 = 1
                                            r16 = r1
                                            r27 = ""
                                            r6[r24] = r27
                                            r1 = 0
                                            r5 = r16 < r1
                                            r17 = 1
                                            r1 = r17 - r16
                                            r32 = r14
                                            r27 = 227
                                            state = 66
                                        end
                                    else
                                        if state == 65 then
                                            ReturnVal = {
                                                r24
                                            }
                                            state = nil
                                        end
                                    end
                                end
                            else
                                if state <= 67 then
                                    if state <= 66 then
                                        if state == 66 then
                                            r1 = r1 + r16
                                            r17 = r1 <= r32
                                            r28 = not r5
                                            r17 = r28 and r17
                                            r28 = r1 >= r32
                                            r28 = r5 and r28
                                            r17 = r28 or r17
                                            r28 = (67)
                                            state = r17 and r28
                                            r17 = (68)
                                            state = state or r17
                                        end
                                    else
                                        if state == 67 then
                                            r10 = "string"
                                            r23 = _env[r10]
                                            r17 = r1
                                            r10 = "byte"
                                            r18 = r23[r10]
                                            r23 = r18(r2, r17)
                                            r18 = upvalueValues[upvalues[6]]
                                            r17 = nil
                                            r10 = r18()
                                            r20 = r23 + r10
                                            r11 = r20 + r27
                                            r20 = 256
                                            r28 = r11 % r20
                                            r27 = r28
                                            r20 = r6[r24]
                                            r10 = 1
                                            r23 = r27 + r10
                                            r18 = r26[r23]
                                            r11 = r20 .. r18
                                            r6[r24] = r11
                                            state = 66
                                        end
                                    end
                                else
                                    if state == 68 then
                                        r26 = nil
                                        r14 = nil
                                        r27 = nil
                                        state = 65
                                    end
                                end
                            end
                        else
                            -- createClosure3 entry 9351996 -> 69, states 69-69
                            if state == 69 then -- entry 9351996 -> 69
                                r6 = 9619106
                                r24 = "9S"
                                r2 = r24 ^ r6
                                ReturnVal = 14164333
                                state = ReturnVal - r2
                                r2 = state
                                ReturnVal = "jO1uPxb68fiaJC"
                                state = ReturnVal / r2
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