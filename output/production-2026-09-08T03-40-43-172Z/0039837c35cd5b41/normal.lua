return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, currentUpvalueId, createClosure7, createClosure2, createClosure1, createClosure3, createClosure4, releaseUpvalue, upvalueValues, createClosure0, createClosure, createUpvalueProxy, vm, releaseUpvalues, upvalueRefCounts, allocUpvalue)
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
                upvalueRefCounts[upvalueId], captureIndex = upvalueRefCounts[upvalueId] - (1), captureIndex + (1)
                if upvalueRefCounts[upvalueId] == 0 then
                    upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
                end
                upvalueId = captures[captureIndex]
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
        createClosure0 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function()
                return vm(entryId, {}, captures, gcProxy)
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
                    return -3946715
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -3946715
                    end
                })
            end
        end
        upvalueRefCounts = {}
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
        currentUpvalueId = 0
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if 0 == upvalueRefCounts[upvalueId] then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, ReturnVal, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33
            while state do
                if state <= 62 then
                    if state <= 40 then
                        if state <= 38 then
                            if state <= 37 then
                                -- root entry 13973977 -> 1, states 1-37
                                if state <= 19 then
                                    if state <= 10 then
                                        if state <= 5 then
                                            if state <= 3 then
                                                if state <= 2 then
                                                    if state <= 1 then
                                                        if state == 1 then -- entry 13973977 -> 1
                                                            r11 = allocUpvalue()
                                                            r2 = allocUpvalue()
                                                            r33 = allocUpvalue()
                                                            state = true
                                                            upvalueValues[r33] = state
                                                            r30 = "string"
                                                            ReturnVal = _env[r30]
                                                            r30 = "gmatch"
                                                            state = ReturnVal[r30]
                                                            r30 = allocUpvalue()
                                                            upvalueValues[r30] = state
                                                            state = createClosure2(38, {})
                                                            r27 = createClosure2(39, {
                                                                r2
                                                            })
                                                            upvalueValues[r11] = state
                                                            state = false
                                                            upvalueValues[r2] = state
                                                            r10 = "pcall"
                                                            r19 = _env[r10]
                                                            r10 = r19(r27)
                                                            state = r10 and (2) or (3)
                                                            r5 = args
                                                            ReturnVal = r10
                                                        end
                                                    else
                                                        if state == 2 then
                                                            r19 = upvalueValues[r2]
                                                            ReturnVal = r19
                                                            state = 3
                                                        end
                                                    end
                                                else
                                                    if state == 3 then
                                                        r19 = ReturnVal
                                                        r10 = "math"
                                                        ReturnVal = _env[r10]
                                                        r10 = "random"
                                                        state = ReturnVal[r10]
                                                        r10 = allocUpvalue()
                                                        upvalueValues[r10] = state
                                                        r27 = "table"
                                                        ReturnVal = _env[r27]
                                                        r27 = "concat"
                                                        state = ReturnVal[r27]
                                                        r27 = state
                                                        r26 = state
                                                        r21 = "table"
                                                        r18 = _env[r21]
                                                        state = r18 and (4) or (5)
                                                        r23 = r18
                                                    end
                                                end
                                            else
                                                if state <= 4 then
                                                    if state == 4 then
                                                        r15 = "table"
                                                        r21 = _env[r15]
                                                        r15 = "unpack"
                                                        r18 = r21[r15]
                                                        r23 = r18
                                                        state = 5
                                                    end
                                                else
                                                    if state == 5 then
                                                        state = r26
                                                        state = r23 and (6) or (7)
                                                        ReturnVal = r23
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 8 then
                                                if state <= 7 then
                                                    if state <= 6 then
                                                        if state == 6 then
                                                            r23 = allocUpvalue()
                                                            upvalueValues[r23] = ReturnVal
                                                            state = upvalueValues[r10]
                                                            r26 = 3
                                                            r18 = 65
                                                            ReturnVal = state(r26, r18)
                                                            r26 = allocUpvalue()
                                                            r16 = createClosure0(40, {})
                                                            upvalueValues[r26] = ReturnVal
                                                            state = 0
                                                            r15 = "pcall"
                                                            ReturnVal = _env[r15]
                                                            r15 = {
                                                                ReturnVal(r16)
                                                            }
                                                            r18 = state
                                                            state = 0
                                                            r21 = state
                                                            state = {
                                                                unpack(r15)
                                                            }
                                                            r15 = state
                                                            ReturnVal = 2
                                                            state = r15[ReturnVal]
                                                            r16 = state
                                                            ReturnVal = "tonumber"
                                                            state = _env[ReturnVal]
                                                            r12 = upvalueValues[r30]
                                                            r14 = "tostring"
                                                            r28 = _env[r14]
                                                            r14 = r28(r16)
                                                            r28 = ":(%d*):"
                                                            r32 = r12(r14, r28)
                                                            r12 = {
                                                                r32()
                                                            }
                                                            ReturnVal = state(unpack(r12))
                                                            r12 = allocUpvalue()
                                                            upvalueValues[r12] = ReturnVal
                                                            r32 = upvalueValues[r26]
                                                            r28 = r32
                                                            r32 = 1
                                                            r14 = r32
                                                            r32 = 0
                                                            r3 = r14 < r32
                                                            ReturnVal = 1
                                                            r32 = ReturnVal - r14
                                                            state = 8
                                                        end
                                                    else
                                                        if state == 7 then
                                                            r26 = "unpack"
                                                            r23 = _env[r26]
                                                            ReturnVal = r23
                                                            state = 6
                                                        end
                                                    end
                                                else
                                                    if state == 8 then
                                                        r20 = not r3
                                                        r32 = r32 + r14
                                                        ReturnVal = r32 <= r28
                                                        ReturnVal = r20 and ReturnVal
                                                        r20 = r32 >= r28
                                                        r20 = r3 and r20
                                                        ReturnVal = r20 or ReturnVal
                                                        r20 = (9)
                                                        state = ReturnVal and r20
                                                        ReturnVal = (10)
                                                        state = state or ReturnVal
                                                    end
                                                end
                                            else
                                                if state <= 9 then
                                                    if state == 9 then
                                                        r20 = allocUpvalue()
                                                        upvalueValues[r20] = r32
                                                        r25 = "math"
                                                        ReturnVal = _env[r25]
                                                        r25 = "random"
                                                        state = ReturnVal[r25]
                                                        r25 = 1
                                                        r17 = 100
                                                        ReturnVal = state(r25, r17)
                                                        r25 = allocUpvalue()
                                                        upvalueValues[r25] = ReturnVal
                                                        state = upvalueValues[r10]
                                                        r6 = 255
                                                        r17 = 0
                                                        ReturnVal = state(r17, r6)
                                                        r17 = allocUpvalue()
                                                        upvalueValues[r17] = ReturnVal
                                                        state = upvalueValues[r10]
                                                        r29 = upvalueValues[r25]
                                                        r6 = 1
                                                        ReturnVal = state(r6, r29)
                                                        r6 = allocUpvalue()
                                                        upvalueValues[r6] = ReturnVal
                                                        ReturnVal = upvalueValues[r10]
                                                        r22 = 1
                                                        r4 = 2
                                                        r29 = ReturnVal(r22, r4)
                                                        ReturnVal = 1
                                                        state = r29 == ReturnVal
                                                        r29 = allocUpvalue()
                                                        upvalueValues[r29] = state
                                                        r9 = "tostring"
                                                        r13 = _env[r9]
                                                        r1 = upvalueValues[r10]
                                                        r31 = 10000
                                                        r8 = 0
                                                        r24 = {
                                                            r1(r8, r31)
                                                        }
                                                        state = "gsub"
                                                        state = r16[state]
                                                        r9 = r13(unpack(r24))
                                                        r13 = ":"
                                                        r7 = r9 .. r13
                                                        r4 = ":"
                                                        r22 = r4 .. r7
                                                        ReturnVal = ":(%d*):"
                                                        state = state(r16, ReturnVal, r22)
                                                        r22 = allocUpvalue()
                                                        upvalueValues[r22] = state
                                                        r7 = createClosure0(41, {
                                                            r10,
                                                            r20,
                                                            r26,
                                                            r30,
                                                            r33,
                                                            r12,
                                                            r29,
                                                            r22,
                                                            r25,
                                                            r6,
                                                            r17,
                                                            r23
                                                        })
                                                        r4 = "pcall"
                                                        ReturnVal = _env[r4]
                                                        r4 = {
                                                            ReturnVal(r7)
                                                        }
                                                        state = {
                                                            unpack(r4)
                                                        }
                                                        r4 = state
                                                        state = upvalueValues[r29]
                                                        state = state and (11) or (12)
                                                    end
                                                else
                                                    if state == 10 then
                                                        r28 = upvalueValues[r33]
                                                        state = r28 and (13) or (14)
                                                        r32 = r28
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 15 then
                                            if state <= 13 then
                                                if state <= 12 then
                                                    if state <= 11 then
                                                        if state == 11 then
                                                            r7 = upvalueValues[r33]
                                                            state = r7 and (15) or (16)
                                                            ReturnVal = r7
                                                        end
                                                    else
                                                        if state == 12 then
                                                            r13 = upvalueValues[r33]
                                                            state = r13 and (17) or (18)
                                                            r7 = r13
                                                        end
                                                    end
                                                else
                                                    if state == 13 then
                                                        r28 = r18 == r21
                                                        r32 = r28
                                                        state = 14
                                                    end
                                                end
                                            else
                                                if state <= 14 then
                                                    if state == 14 then
                                                        upvalueValues[r33] = r32
                                                        state = upvalueValues[r33]
                                                        state = state and (19) or (20)
                                                    end
                                                else
                                                    if state == 15 then
                                                        r13 = state
                                                        r24 = 1
                                                        r1 = r4[r24]
                                                        r24 = false
                                                        r9 = r1 == r24
                                                        state = r9 and (21) or (22)
                                                        r7 = r9
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 17 then
                                                if state <= 16 then
                                                    if state == 16 then
                                                        upvalueValues[r33] = ReturnVal
                                                        state = 23
                                                    end
                                                else
                                                    if state == 17 then
                                                        r9 = 1
                                                        r13 = r4[r9]
                                                        r7 = r13
                                                        state = 18
                                                    end
                                                end
                                            else
                                                if state <= 18 then
                                                    if state == 18 then
                                                        upvalueValues[r33] = r7
                                                        r24 = upvalueValues[r6]
                                                        r8 = 1
                                                        r1 = r24 + r8
                                                        r9 = r4[r1]
                                                        r13 = r18 + r9
                                                        r9 = 256
                                                        state = r13 % r9
                                                        r18 = state
                                                        r1 = upvalueValues[r17]
                                                        r9 = r21 + r1
                                                        r1 = 256
                                                        r13 = r9 % r1
                                                        r21 = r13
                                                        state = 23
                                                    end
                                                else
                                                    if state == 19 then
                                                        state = 24
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    if state <= 28 then
                                        if state <= 24 then
                                            if state <= 22 then
                                                if state <= 21 then
                                                    if state <= 20 then
                                                        if state == 20 then
                                                            state = true
                                                            state = 25
                                                        end
                                                    else
                                                        if state == 21 then
                                                            r24 = 2
                                                            r1 = r4[r24]
                                                            r24 = upvalueValues[r22]
                                                            r9 = r1 == r24
                                                            r7 = r9
                                                            state = 22
                                                        end
                                                    end
                                                else
                                                    if state == 22 then
                                                        state = r13
                                                        ReturnVal = r7
                                                        state = 16
                                                    end
                                                end
                                            else
                                                if state <= 23 then
                                                    if state == 23 then
                                                        r6 = releaseUpvalue(r6)
                                                        r4 = nil
                                                        r29 = releaseUpvalue(r29)
                                                        r25 = releaseUpvalue(r25)
                                                        r17 = releaseUpvalue(r17)
                                                        r22 = releaseUpvalue(r22)
                                                        r20 = releaseUpvalue(r20)
                                                        state = 8
                                                    end
                                                else
                                                    if state == 24 then
                                                        r12 = releaseUpvalue(r12)
                                                        r26 = releaseUpvalue(r26)
                                                        r23 = releaseUpvalue(r23)
                                                        r30 = releaseUpvalue(r30)
                                                        r26 = allocUpvalue()
                                                        r2 = releaseUpvalue(r2)
                                                        r11 = releaseUpvalue(r11)
                                                        r11 = allocUpvalue()
                                                        r33 = releaseUpvalue(r33)
                                                        r10 = releaseUpvalue(r10)
                                                        r33 = nil
                                                        upvalueValues[r11] = r33
                                                        r33 = allocUpvalue()
                                                        r30 = nil
                                                        upvalueValues[r33] = r30
                                                        r19 = nil
                                                        r19 = "math"
                                                        r2 = _env[r19]
                                                        r19 = "floor"
                                                        r30 = r2[r19]
                                                        r2 = allocUpvalue()
                                                        upvalueValues[r2] = r30
                                                        r10 = "math"
                                                        r19 = _env[r10]
                                                        r10 = "random"
                                                        r30 = r19[r10]
                                                        r18 = nil
                                                        r18 = {}
                                                        r27 = nil
                                                        r27 = "table"
                                                        r10 = _env[r27]
                                                        r27 = "remove"
                                                        r19 = r10[r27]
                                                        r23 = "string"
                                                        r27 = _env[r23]
                                                        r23 = "char"
                                                        r10 = r27[r23]
                                                        r23 = allocUpvalue()
                                                        r27 = 0
                                                        upvalueValues[r23] = r27
                                                        r21 = nil
                                                        r21 = allocUpvalue()
                                                        r27 = 2
                                                        upvalueValues[r26] = r27
                                                        r27 = {}
                                                        upvalueValues[r21] = r18
                                                        r15 = nil
                                                        r15 = {}
                                                        r12 = 256
                                                        r3 = r12
                                                        r12 = 1
                                                        r20 = r12
                                                        r12 = 0
                                                        r25 = r20 < r12
                                                        r16 = nil
                                                        r16 = 1
                                                        r12 = r16 - r20
                                                        r18 = 0
                                                        state = 26
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 26 then
                                                if state <= 25 then
                                                    if state == 25 then
                                                        state = createClosure2(53, {
                                                            r11
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
                                                        r17 = not r25
                                                        r12 = r12 + r20
                                                        r16 = r12 <= r3
                                                        r16 = r17 and r16
                                                        r17 = r12 >= r3
                                                        r17 = r25 and r17
                                                        r16 = r17 or r16
                                                        r17 = (27)
                                                        state = r16 and r17
                                                        r16 = (28)
                                                        state = state or r16
                                                    end
                                                end
                                            else
                                                if state <= 27 then
                                                    if state == 27 then
                                                        r16 = r12
                                                        r17 = r16
                                                        r15[r16] = r17
                                                        r16 = nil
                                                        state = 26
                                                    end
                                                else
                                                    if state == 28 then
                                                        r12 = #r15
                                                        r3 = 0
                                                        r16 = r12 == r3
                                                        state = 29
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 33 then
                                            if state <= 31 then
                                                if state <= 30 then
                                                    if state <= 29 then
                                                        if state == 29 then
                                                            r12 = 1
                                                            r3 = #r15
                                                            r16 = r30(r12, r3)
                                                            r12 = r19(r15, r16)
                                                            r3 = upvalueValues[r21]
                                                            r17 = 1
                                                            r16 = nil
                                                            r25 = r12 - r17
                                                            r20 = r10(r25)
                                                            r3[r12] = r20
                                                            r12 = nil
                                                            state = 30
                                                        end
                                                    else
                                                        if state == 30 then
                                                            r12 = #r15
                                                            r3 = 0
                                                            r16 = r12 == r3
                                                            state = r16 and (31) or (29)
                                                        end
                                                    end
                                                else
                                                    if state == 31 then
                                                        r12 = allocUpvalue()
                                                        r16 = {}
                                                        r20 = allocUpvalue()
                                                        upvalueValues[r12] = r16
                                                        r16 = allocUpvalue()
                                                        r3 = createClosure4(57, {
                                                            r12,
                                                            r23,
                                                            r26,
                                                            r2
                                                        })
                                                        upvalueValues[r16] = r3
                                                        r17 = {}
                                                        r3 = {}
                                                        upvalueValues[r20] = r3
                                                        r25 = "setmetatable"
                                                        r3 = _env[r25]
                                                        r22 = upvalueValues[r20]
                                                        r4 = "__metatable"
                                                        r9 = nil
                                                        r29 = "__index"
                                                        r6 = {
                                                            [r29] = r22,
                                                            [r4] = r9
                                                        }
                                                        r25 = r3(r17, r6)
                                                        r3 = createClosure7(63, {
                                                            r20,
                                                            r12,
                                                            r21,
                                                            r23,
                                                            r26,
                                                            r16
                                                        })
                                                        r21 = releaseUpvalue(r21)
                                                        r23 = releaseUpvalue(r23)
                                                        r2 = releaseUpvalue(r2)
                                                        upvalueValues[r33] = r25
                                                        r26 = releaseUpvalue(r26)
                                                        r12 = releaseUpvalue(r12)
                                                        r16 = releaseUpvalue(r16)
                                                        upvalueValues[r11] = r3
                                                        r20 = releaseUpvalue(r20)
                                                        r2 = "game"
                                                        r30 = nil
                                                        r30 = _env[r2]
                                                        r10 = nil
                                                        r10 = upvalueValues[r33]
                                                        r27 = nil
                                                        r27 = upvalueValues[r11]
                                                        r18 = nil
                                                        r18 = 6085679549201
                                                        r26 = "6j6\207\214\031\029"
                                                        r23 = r27(r26, r18)
                                                        r2 = "GetService"
                                                        r2 = r30[r2]
                                                        r19 = nil
                                                        r19 = r10[r23]
                                                        r2 = r2(r30, r19)
                                                        r19 = "game"
                                                        r30 = _env[r19]
                                                        r27 = upvalueValues[r33]
                                                        r23 = upvalueValues[r11]
                                                        r21 = 24791882525976
                                                        r18 = "\014\143p\211\242\214\175<\137 "
                                                        r26 = r23(r18, r21)
                                                        r10 = r27[r26]
                                                        r19 = "GetService"
                                                        r19 = r30[r19]
                                                        r19 = r19(r30, r10)
                                                        r30 = allocUpvalue()
                                                        upvalueValues[r30] = r19
                                                        r27 = upvalueValues[r33]
                                                        r23 = upvalueValues[r11]
                                                        r18 = "\135\249Hy\175Y\202?\031\198\190"
                                                        r21 = 733571088725
                                                        r26 = r23(r18, r21)
                                                        r10 = r27[r26]
                                                        r19 = r2[r10]
                                                        r10 = allocUpvalue()
                                                        upvalueValues[r10] = r19
                                                        r19 = upvalueValues[r10]
                                                        r26 = upvalueValues[r33]
                                                        r18 = upvalueValues[r11]
                                                        r27 = "WaitForChild"
                                                        r27 = r19[r27]
                                                        r15 = nil
                                                        r15 = "\243/\185\027\172\177)\001m"
                                                        r16 = 8734318268387
                                                        r21 = r18(r15, r16)
                                                        r23 = r26[r21]
                                                        r27 = r27(r19, r23)
                                                        r23 = upvalueValues[r33]
                                                        r26 = upvalueValues[r11]
                                                        r21 = "\031\147U\177\167\248_\161\203\152T?\157+\187\249"
                                                        r15 = 3446238152260
                                                        r18 = r26(r21, r15)
                                                        r19 = r23[r18]
                                                        r23 = allocUpvalue()
                                                        upvalueValues[r23] = r19
                                                        r26 = upvalueValues[r33]
                                                        r18 = upvalueValues[r11]
                                                        r16 = 10999772451842
                                                        r15 = "\029\192\186W\232v\207\255$\216G\228l\135\222"
                                                        r21 = r18(r15, r16)
                                                        r19 = r26[r21]
                                                        r26 = allocUpvalue()
                                                        upvalueValues[r26] = r19
                                                        r18 = upvalueValues[r33]
                                                        r21 = upvalueValues[r11]
                                                        r12 = 31280084203749
                                                        r16 = "n\206t\140ov0\136.\135\184\146hqCfu\011\236\017(\176\160\135)\162\159>\134@r"
                                                        r15 = r21(r16, r12)
                                                        r19 = r18[r15]
                                                        r18 = allocUpvalue()
                                                        upvalueValues[r18] = r19
                                                        r21 = upvalueValues[r33]
                                                        r15 = upvalueValues[r11]
                                                        r3 = 20870367258102
                                                        r12 = "\187/\022B\154\170&\235\240+YOb\244\026`\183\201\177\221\2407`\149Q\152\213X_\195:*f%U85\243\225\252\182QK\159\001\027\242\160M\t\235\138\016\198\224\244\1761:\014\198n6\247\244N\190]\255\016\141r\015N\156\\\179"
                                                        r16 = r15(r12, r3)
                                                        r15 = createClosure4(70, {
                                                            r30,
                                                            r33,
                                                            r11
                                                        })
                                                        r19 = r21[r16]
                                                        r21 = allocUpvalue()
                                                        upvalueValues[r21] = r19
                                                        r19 = allocUpvalue()
                                                        upvalueValues[r19] = r15
                                                        r16 = state
                                                        r3 = "isfile"
                                                        r12 = _env[r3]
                                                        state = r12 and (32) or (33)
                                                        r15 = r12
                                                    end
                                                end
                                            else
                                                if state <= 32 then
                                                    if state == 32 then
                                                        r3 = "isfile"
                                                        r12 = _env[r3]
                                                        r20 = upvalueValues[r23]
                                                        r3 = r12(r20)
                                                        r15 = r3
                                                        state = 33
                                                    end
                                                else
                                                    if state == 33 then
                                                        state = r16
                                                        state = r15 and (34) or (35)
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 35 then
                                                if state <= 34 then
                                                    if state == 34 then
                                                        r16 = "readfile"
                                                        r15 = _env[r16]
                                                        r12 = upvalueValues[r23]
                                                        r16 = r15(r12)
                                                        r3 = "tostring"
                                                        r12 = _env[r3]
                                                        r17 = upvalueValues[r10]
                                                        r29 = upvalueValues[r33]
                                                        r22 = upvalueValues[r11]
                                                        r9 = "\194Z\186U\210:"
                                                        r1 = 28568901137399
                                                        r4 = r22(r9, r1)
                                                        r6 = r29[r4]
                                                        r20 = r17[r6]
                                                        r3 = r12(r20)
                                                        r15 = r16 == r3
                                                        state = r15 and (36) or (37)
                                                    end
                                                else
                                                    if state == 35 then
                                                        r12 = "Instance"
                                                        r16 = _env[r12]
                                                        r3 = upvalueValues[r33]
                                                        r20 = upvalueValues[r11]
                                                        r6 = "\212/\012"
                                                        r29 = 18203717673244
                                                        r17 = r20(r6, r29)
                                                        r12 = r3[r17]
                                                        r15 = r16[r12]
                                                        r3 = upvalueValues[r33]
                                                        r20 = upvalueValues[r11]
                                                        r6 = "\168\250\188\155<)\232\2311"
                                                        r29 = 18072338604255
                                                        r17 = r20(r6, r29)
                                                        r12 = r3[r17]
                                                        r16 = r15(r12)
                                                        r15 = allocUpvalue()
                                                        upvalueValues[r15] = r16
                                                        r16 = upvalueValues[r15]
                                                        r3 = upvalueValues[r33]
                                                        r20 = upvalueValues[r11]
                                                        r29 = 12334003295855
                                                        r6 = "0\168t|"
                                                        r17 = r20(r6, r29)
                                                        r12 = r3[r17]
                                                        r20 = upvalueValues[r33]
                                                        r17 = upvalueValues[r11]
                                                        r22 = 8474411519850
                                                        r29 = "\166\228N\019\178~\148\127\218"
                                                        r6 = r17(r29, r22)
                                                        r3 = r20[r6]
                                                        r16[r12] = r3
                                                        r16 = upvalueValues[r15]
                                                        r3 = upvalueValues[r33]
                                                        r20 = upvalueValues[r11]
                                                        r29 = 11984404731340
                                                        r6 = "\019\147\222r\2289i\175B\180GG"
                                                        r17 = r20(r6, r29)
                                                        r12 = r3[r17]
                                                        r3 = false
                                                        r16[r12] = r3
                                                        r16 = upvalueValues[r15]
                                                        r3 = upvalueValues[r33]
                                                        r20 = upvalueValues[r11]
                                                        r6 = "\131sQ\003\179\203"
                                                        r29 = 18867052143185
                                                        r17 = r20(r6, r29)
                                                        r12 = r3[r17]
                                                        r3 = r27
                                                        r16[r12] = r3
                                                        r3 = "Instance"
                                                        r12 = _env[r3]
                                                        r20 = upvalueValues[r33]
                                                        r17 = upvalueValues[r11]
                                                        r22 = 32115366361706
                                                        r29 = "Aw["
                                                        r6 = r17(r29, r22)
                                                        r3 = r20[r6]
                                                        r16 = r12[r3]
                                                        r20 = upvalueValues[r33]
                                                        r17 = upvalueValues[r11]
                                                        r29 = "\127\232\206\251/"
                                                        r22 = 3997981230917
                                                        r6 = r17(r29, r22)
                                                        r3 = r20[r6]
                                                        r12 = r16(r3)
                                                        r3 = upvalueValues[r33]
                                                        r20 = upvalueValues[r11]
                                                        r6 = "u\234\211\024"
                                                        r29 = 21785075541920
                                                        r17 = r20(r6, r29)
                                                        r16 = r3[r17]
                                                        r17 = "UDim2"
                                                        r20 = _env[r17]
                                                        r6 = upvalueValues[r33]
                                                        r29 = upvalueValues[r11]
                                                        r9 = 29651966309871
                                                        r4 = "&]\017"
                                                        r22 = r29(r4, r9)
                                                        r17 = r6[r22]
                                                        r3 = r20[r17]
                                                        r17 = 0
                                                        r22 = 150
                                                        r29 = 0
                                                        r6 = 300
                                                        r20 = r3(r17, r6, r29, r22)
                                                        r12[r16] = r20
                                                        r3 = upvalueValues[r33]
                                                        r20 = upvalueValues[r11]
                                                        r29 = 6544513649639
                                                        r6 = "4\230\r\214\142\015\129\248"
                                                        r17 = r20(r6, r29)
                                                        r16 = r3[r17]
                                                        r17 = "UDim2"
                                                        r20 = _env[r17]
                                                        r6 = upvalueValues[r33]
                                                        r29 = upvalueValues[r11]
                                                        r9 = 30938250836038
                                                        r4 = "\186\143\194"
                                                        r22 = r29(r4, r9)
                                                        r17 = r6[r22]
                                                        r3 = r20[r17]
                                                        r17 = 0.5
                                                        r6 = -150
                                                        r22 = -75
                                                        r29 = 0.5
                                                        r20 = r3(r17, r6, r29, r22)
                                                        r12[r16] = r20
                                                        r3 = upvalueValues[r33]
                                                        r20 = upvalueValues[r11]
                                                        r29 = 29370148631916
                                                        r6 = "c\030\193\191\179\158\019\148-Ec\174\167\170\024\007"
                                                        r17 = r20(r6, r29)
                                                        r16 = r3[r17]
                                                        r17 = "Color3"
                                                        r20 = _env[r17]
                                                        r6 = upvalueValues[r33]
                                                        r29 = upvalueValues[r11]
                                                        r4 = "z\166\228\176\149`A"
                                                        r9 = 34176429293098
                                                        r22 = r29(r4, r9)
                                                        r17 = r6[r22]
                                                        r3 = r20[r17]
                                                        r17 = 25
                                                        r29 = 25
                                                        r6 = 25
                                                        r20 = r3(r17, r6, r29)
                                                        r12[r16] = r20
                                                        r3 = upvalueValues[r33]
                                                        r20 = upvalueValues[r11]
                                                        r29 = 25573077479044
                                                        r6 = "\"\128\018\165\145\022m?\197u\243\018\190\219>"
                                                        r17 = r20(r6, r29)
                                                        r16 = r3[r17]
                                                        r3 = 0
                                                        r12[r16] = r3
                                                        r3 = upvalueValues[r33]
                                                        r20 = upvalueValues[r11]
                                                        r6 = "\255\178\024\181\2521"
                                                        r29 = 2802120639768
                                                        r17 = r20(r6, r29)
                                                        r16 = r3[r17]
                                                        r3 = upvalueValues[r15]
                                                        r20 = "Instance"
                                                        r12[r16] = r3
                                                        r3 = _env[r20]
                                                        r17 = upvalueValues[r33]
                                                        r6 = upvalueValues[r11]
                                                        r22 = "\001\238\142"
                                                        r4 = 5077736737084
                                                        r29 = r6(r22, r4)
                                                        r20 = r17[r29]
                                                        r16 = r3[r20]
                                                        r17 = upvalueValues[r33]
                                                        r6 = upvalueValues[r11]
                                                        r4 = 15180587916189
                                                        r22 = "p:m\251\139oS"
                                                        r29 = r6(r22, r4)
                                                        r20 = r17[r29]
                                                        r3 = r16(r20)
                                                        r16 = allocUpvalue()
                                                        upvalueValues[r16] = r3
                                                        r3 = upvalueValues[r16]
                                                        r17 = upvalueValues[r33]
                                                        r6 = upvalueValues[r11]
                                                        r22 = "\012n\185\130"
                                                        r4 = 3535691728494
                                                        r29 = r6(r22, r4)
                                                        r20 = r17[r29]
                                                        r29 = "UDim2"
                                                        r6 = _env[r29]
                                                        r22 = upvalueValues[r33]
                                                        r4 = upvalueValues[r11]
                                                        r24 = 13812055021855
                                                        r1 = "\249\148H"
                                                        r9 = r4(r1, r24)
                                                        r29 = r22[r9]
                                                        r17 = r6[r29]
                                                        r22 = 0
                                                        r4 = 0
                                                        r9 = 35
                                                        r29 = 0.8
                                                        r6 = r17(r29, r22, r4, r9)
                                                        r3[r20] = r6
                                                        r3 = upvalueValues[r16]
                                                        r17 = upvalueValues[r33]
                                                        r6 = upvalueValues[r11]
                                                        r4 = 18626826068449
                                                        r22 = "\022\211\165\210!\003\249\030"
                                                        r29 = r6(r22, r4)
                                                        r20 = r17[r29]
                                                        r29 = "UDim2"
                                                        r6 = _env[r29]
                                                        r22 = upvalueValues[r33]
                                                        r4 = upvalueValues[r11]
                                                        r24 = 14535464180336
                                                        r1 = "j\179\236"
                                                        r9 = r4(r1, r24)
                                                        r29 = r22[r9]
                                                        r17 = r6[r29]
                                                        r9 = 0
                                                        r22 = 0
                                                        r4 = 0.15
                                                        r29 = 0.1
                                                        r6 = r17(r29, r22, r4, r9)
                                                        r3[r20] = r6
                                                        r3 = upvalueValues[r16]
                                                        r17 = upvalueValues[r33]
                                                        r6 = upvalueValues[r11]
                                                        r4 = 9907767120389
                                                        r22 = "e\n\245\231Zi\179\205\250\226\254\012\214:\253"
                                                        r29 = r6(r22, r4)
                                                        r20 = r17[r29]
                                                        r6 = upvalueValues[r33]
                                                        r29 = upvalueValues[r11]
                                                        r9 = 4312821237720
                                                        r4 = "\187\251\225\192\205\150\172\202$\137\031f\208\213\221]\168"
                                                        r22 = r29(r4, r9)
                                                        r17 = r6[r22]
                                                        r3[r20] = r17
                                                        r3 = upvalueValues[r16]
                                                        r17 = upvalueValues[r33]
                                                        r6 = upvalueValues[r11]
                                                        r4 = 33327433628831
                                                        r22 = "\006r;`\137\r(\172B\251iw\004\216{\138"
                                                        r29 = r6(r22, r4)
                                                        r20 = r17[r29]
                                                        ReturnVal = {}
                                                        r29 = "Color3"
                                                        r6 = _env[r29]
                                                        r22 = upvalueValues[r33]
                                                        r4 = upvalueValues[r11]
                                                        r24 = 29358568486247
                                                        r1 = "\147\197\007\162\0310\189"
                                                        r9 = r4(r1, r24)
                                                        r29 = r22[r9]
                                                        r17 = r6[r29]
                                                        r4 = 45
                                                        r29 = 45
                                                        r22 = 45
                                                        r6 = r17(r29, r22, r4)
                                                        r3[r20] = r6
                                                        r3 = upvalueValues[r16]
                                                        r17 = upvalueValues[r33]
                                                        r6 = upvalueValues[r11]
                                                        r4 = 24237625256982
                                                        r22 = "\022\190\234\223\152\144&Y\189\002"
                                                        r29 = r6(r22, r4)
                                                        r20 = r17[r29]
                                                        r29 = "Color3"
                                                        r6 = _env[r29]
                                                        r22 = upvalueValues[r33]
                                                        r4 = upvalueValues[r11]
                                                        r24 = 1954516992910
                                                        r1 = "B\169D#\223Y\198"
                                                        r9 = r4(r1, r24)
                                                        r29 = r22[r9]
                                                        r17 = r6[r29]
                                                        r4 = 255
                                                        r22 = 255
                                                        r29 = 255
                                                        r6 = r17(r29, r22, r4)
                                                        r3[r20] = r6
                                                        r3 = upvalueValues[r16]
                                                        r17 = upvalueValues[r33]
                                                        r6 = upvalueValues[r11]
                                                        r22 = "\170Ck\155\143\216\136\168\025\147"
                                                        r4 = 22743097518430
                                                        r29 = r6(r22, r4)
                                                        r20 = r17[r29]
                                                        r17 = true
                                                        r3[r20] = r17
                                                        r3 = upvalueValues[r16]
                                                        r17 = upvalueValues[r33]
                                                        r6 = upvalueValues[r11]
                                                        r4 = 9942805254677
                                                        r22 = "u\185Gv\015S"
                                                        r29 = r6(r22, r4)
                                                        r20 = r17[r29]
                                                        r17 = r12
                                                        r3[r20] = r17
                                                        r8 = 19427465323350
                                                        r17 = "Instance"
                                                        r20 = _env[r17]
                                                        r6 = upvalueValues[r33]
                                                        r29 = upvalueValues[r11]
                                                        r9 = 27448553337325
                                                        r4 = "\138LR"
                                                        r22 = r29(r4, r9)
                                                        r17 = r6[r22]
                                                        r3 = r20[r17]
                                                        r6 = upvalueValues[r33]
                                                        r29 = upvalueValues[r11]
                                                        r30 = releaseUpvalue(r30)
                                                        r4 = "\244\204f\163\172\241IV\031["
                                                        r9 = 5762443102843
                                                        r22 = r29(r4, r9)
                                                        r17 = r6[r22]
                                                        r20 = r3(r17)
                                                        r17 = upvalueValues[r33]
                                                        r6 = upvalueValues[r11]
                                                        r4 = 28015143858933
                                                        r22 = "\201[|>"
                                                        r29 = r6(r22, r4)
                                                        r3 = r17[r29]
                                                        r29 = "UDim2"
                                                        r6 = _env[r29]
                                                        r22 = upvalueValues[r33]
                                                        r4 = upvalueValues[r11]
                                                        r24 = 4598184527965
                                                        r1 = "l\201\135"
                                                        r9 = r4(r1, r24)
                                                        r29 = r22[r9]
                                                        r17 = r6[r29]
                                                        r4 = 0
                                                        r29 = 0.35
                                                        r22 = 0
                                                        r9 = 35
                                                        r6 = r17(r29, r22, r4, r9)
                                                        r20[r3] = r6
                                                        r1 = "\139q\250"
                                                        r17 = upvalueValues[r33]
                                                        r6 = upvalueValues[r11]
                                                        r4 = 14236854622693
                                                        r22 = "\141S\148$|\026\203\150"
                                                        r29 = r6(r22, r4)
                                                        r3 = r17[r29]
                                                        r29 = "UDim2"
                                                        r6 = _env[r29]
                                                        r2 = nil
                                                        r22 = upvalueValues[r33]
                                                        r4 = upvalueValues[r11]
                                                        r24 = 4815176485058
                                                        r9 = r4(r1, r24)
                                                        r29 = r22[r9]
                                                        r17 = r6[r29]
                                                        r22 = 0
                                                        r29 = 0.1
                                                        r9 = 0
                                                        r4 = 0.55
                                                        r6 = r17(r29, r22, r4, r9)
                                                        r20[r3] = r6
                                                        r17 = upvalueValues[r33]
                                                        r6 = upvalueValues[r11]
                                                        r22 = "\188\207\r\188"
                                                        r4 = 23465236671150
                                                        r29 = r6(r22, r4)
                                                        r3 = r17[r29]
                                                        r6 = upvalueValues[r33]
                                                        r29 = upvalueValues[r11]
                                                        r9 = 11167848895568
                                                        r4 = "Ki\214$\027\2066\195\141\172"
                                                        r22 = r29(r4, r9)
                                                        r17 = r6[r22]
                                                        r20[r3] = r17
                                                        r17 = upvalueValues[r33]
                                                        r6 = upvalueValues[r11]
                                                        r22 = "\131\219\025g\143@\131\004%\001\244\181$\232\200\158"
                                                        r4 = 8813157732359
                                                        r29 = r6(r22, r4)
                                                        r3 = r17[r29]
                                                        r29 = "Color3"
                                                        r6 = _env[r29]
                                                        r22 = upvalueValues[r33]
                                                        r4 = upvalueValues[r11]
                                                        r24 = 10065940107855
                                                        r1 = "\002\0273\234\176\187M"
                                                        r9 = r4(r1, r24)
                                                        r29 = r22[r9]
                                                        r17 = r6[r29]
                                                        r22 = 200
                                                        r29 = 0
                                                        r4 = 0
                                                        r6 = r17(r29, r22, r4)
                                                        r20[r3] = r6
                                                        r17 = upvalueValues[r33]
                                                        r6 = upvalueValues[r11]
                                                        r22 = "\1918\251s#\026\130\211e\130"
                                                        r4 = 5635443100224
                                                        r29 = r6(r22, r4)
                                                        r3 = r17[r29]
                                                        r29 = "Color3"
                                                        r6 = _env[r29]
                                                        r22 = upvalueValues[r33]
                                                        r4 = upvalueValues[r11]
                                                        r24 = 15357671381999
                                                        r1 = "\163\230\019\224\176.\198"
                                                        r9 = r4(r1, r24)
                                                        r29 = r22[r9]
                                                        r17 = r6[r29]
                                                        r4 = 255
                                                        r22 = 255
                                                        r29 = 255
                                                        r6 = r17(r29, r22, r4)
                                                        r20[r3] = r6
                                                        r17 = upvalueValues[r33]
                                                        r6 = upvalueValues[r11]
                                                        r4 = 5819818855062
                                                        r22 = "\129\182\002\127\014\198\003{\145C"
                                                        r29 = r6(r22, r4)
                                                        r3 = r17[r29]
                                                        r17 = true
                                                        r20[r3] = r17
                                                        r17 = upvalueValues[r33]
                                                        r6 = upvalueValues[r11]
                                                        r22 = "Z\023s\212\206J"
                                                        r4 = 35005591748524
                                                        r29 = r6(r22, r4)
                                                        r3 = r17[r29]
                                                        r17 = r12
                                                        r20[r3] = r17
                                                        r6 = "Instance"
                                                        r17 = _env[r6]
                                                        r29 = upvalueValues[r33]
                                                        r22 = upvalueValues[r11]
                                                        r1 = 14349728569882
                                                        r9 = "*\215e"
                                                        r4 = r22(r9, r1)
                                                        r6 = r29[r4]
                                                        r3 = r17[r6]
                                                        r29 = upvalueValues[r33]
                                                        r22 = upvalueValues[r11]
                                                        r9 = "\132f\241K\183\167-\141\177s"
                                                        r1 = 31392896334106
                                                        r4 = r22(r9, r1)
                                                        r6 = r29[r4]
                                                        r17 = r3(r6)
                                                        r6 = upvalueValues[r33]
                                                        r29 = upvalueValues[r11]
                                                        r9 = 2623340283077
                                                        r4 = "<\147\168\251"
                                                        r22 = r29(r4, r9)
                                                        r3 = r6[r22]
                                                        r22 = "UDim2"
                                                        r29 = _env[r22]
                                                        r4 = upvalueValues[r33]
                                                        r9 = upvalueValues[r11]
                                                        r24 = "o\237\004"
                                                        r1 = r9(r24, r8)
                                                        r22 = r4[r1]
                                                        r6 = r29[r22]
                                                        r1 = 35
                                                        r22 = 0.35
                                                        r9 = 0
                                                        r4 = 0
                                                        r29 = r6(r22, r4, r9, r1)
                                                        r17[r3] = r29
                                                        r6 = upvalueValues[r33]
                                                        r29 = upvalueValues[r11]
                                                        r9 = 11389112145079
                                                        r4 = "\215.\030N\0140\191h"
                                                        r22 = r29(r4, r9)
                                                        r3 = r6[r22]
                                                        r22 = "UDim2"
                                                        r29 = _env[r22]
                                                        r4 = upvalueValues[r33]
                                                        r9 = upvalueValues[r11]
                                                        r24 = "\255\169@"
                                                        r8 = 6159032027956
                                                        r1 = r9(r24, r8)
                                                        r22 = r4[r1]
                                                        r6 = r29[r22]
                                                        r22 = 0.55
                                                        r1 = 0
                                                        r9 = 0.55
                                                        r4 = 0
                                                        r29 = r6(r22, r4, r9, r1)
                                                        r17[r3] = r29
                                                        r6 = upvalueValues[r33]
                                                        r29 = upvalueValues[r11]
                                                        r9 = 33239520345206
                                                        r4 = "z9]_"
                                                        r22 = r29(r4, r9)
                                                        r3 = r6[r22]
                                                        r29 = upvalueValues[r33]
                                                        r22 = upvalueValues[r11]
                                                        r1 = 30015938229913
                                                        r9 = "gi\152_\159\203\152\030\001\\xG"
                                                        r4 = r22(r9, r1)
                                                        r6 = r29[r4]
                                                        r17[r3] = r6
                                                        r6 = upvalueValues[r33]
                                                        r29 = upvalueValues[r11]
                                                        r9 = 20694496208292
                                                        r4 = "B\128\131[\170\2307\r5@\219\174\228Wa\224"
                                                        r22 = r29(r4, r9)
                                                        r3 = r6[r22]
                                                        r22 = "Color3"
                                                        r29 = _env[r22]
                                                        r4 = upvalueValues[r33]
                                                        r9 = upvalueValues[r11]
                                                        r24 = "\236\202W\199Wm\211"
                                                        r8 = 7962915360380
                                                        r1 = r9(r24, r8)
                                                        r22 = r4[r1]
                                                        r6 = r29[r22]
                                                        r22 = 0
                                                        r27 = nil
                                                        r4 = 120
                                                        r9 = 255
                                                        r29 = r6(r22, r4, r9)
                                                        r17[r3] = r29
                                                        r6 = upvalueValues[r33]
                                                        r29 = upvalueValues[r11]
                                                        r9 = 34328759467633
                                                        r4 = "OR\221\134\189a*\217\233\026"
                                                        r22 = r29(r4, r9)
                                                        r3 = r6[r22]
                                                        r22 = "Color3"
                                                        r29 = _env[r22]
                                                        r4 = upvalueValues[r33]
                                                        r9 = upvalueValues[r11]
                                                        r24 = "\131\175<Z\012nc"
                                                        r8 = 18837557731907
                                                        r1 = r9(r24, r8)
                                                        r22 = r4[r1]
                                                        r6 = r29[r22]
                                                        r4 = 255
                                                        r22 = 255
                                                        r9 = 255
                                                        r29 = r6(r22, r4, r9)
                                                        r17[r3] = r29
                                                        r6 = upvalueValues[r33]
                                                        r29 = upvalueValues[r11]
                                                        r9 = 2137111741411
                                                        r4 = "\199tTG\245{ \178\131\152"
                                                        r22 = r29(r4, r9)
                                                        r3 = r6[r22]
                                                        r6 = true
                                                        r17[r3] = r6
                                                        r6 = upvalueValues[r33]
                                                        r29 = upvalueValues[r11]
                                                        r4 = "D2RL%\012"
                                                        r9 = 23382012619400
                                                        r22 = r29(r4, r9)
                                                        r3 = r6[r22]
                                                        r6 = r12
                                                        r9 = "\176\127T\163#r\128\137\2404\240|\207\129\148\205z"
                                                        r12 = nil
                                                        r17[r3] = r6
                                                        r29 = upvalueValues[r33]
                                                        r22 = upvalueValues[r11]
                                                        r1 = 20792074724818
                                                        r4 = r22(r9, r1)
                                                        r6 = r29[r4]
                                                        r29 = createClosure4(71, {
                                                            r16,
                                                            r33,
                                                            r11,
                                                            r26,
                                                            r19,
                                                            r15,
                                                            r23,
                                                            r10,
                                                            r21
                                                        })
                                                        r3 = r20[r6]
                                                        r6 = "Connect"
                                                        r6 = r3[r6]
                                                        r1 = 30970766129237
                                                        r20 = nil
                                                        r6 = r6(r3, r29)
                                                        r15 = releaseUpvalue(r15)
                                                        r29 = upvalueValues[r33]
                                                        r10 = releaseUpvalue(r10)
                                                        r23 = releaseUpvalue(r23)
                                                        r22 = upvalueValues[r11]
                                                        r9 = "\tl|\192\153\210\130\004\189_\254\027ri?\161\026"
                                                        r4 = r22(r9, r1)
                                                        r6 = r29[r4]
                                                        r16 = releaseUpvalue(r16)
                                                        r29 = createClosure1(77, {
                                                            r18,
                                                            r19,
                                                            r33,
                                                            r11
                                                        })
                                                        r18 = releaseUpvalue(r18)
                                                        r26 = releaseUpvalue(r26)
                                                        r3 = r17[r6]
                                                        r19 = releaseUpvalue(r19)
                                                        r33 = releaseUpvalue(r33)
                                                        r6 = "Connect"
                                                        r6 = r3[r6]
                                                        r6 = r6(r3, r29)
                                                        r17 = nil
                                                        r21 = releaseUpvalue(r21)
                                                        r11 = releaseUpvalue(r11)
                                                        state = nil
                                                    end
                                                end
                                            else
                                                if state <= 36 then
                                                    if state == 36 then
                                                        r15 = upvalueValues[r19]
                                                        r20 = upvalueValues[r33]
                                                        r17 = upvalueValues[r11]
                                                        r22 = 20889552102911
                                                        r29 = "\011?@\197\211\190J\148\211h\tR\195"
                                                        r6 = r17(r29, r22)
                                                        r3 = r20[r6]
                                                        r17 = upvalueValues[r33]
                                                        r6 = upvalueValues[r11]
                                                        r4 = 25494036344415
                                                        r22 = "\154p\011\2187\015\134\015\246*X#\249@I\143\232$\148"
                                                        r29 = r6(r22, r4)
                                                        r20 = r17[r29]
                                                        r17 = 3
                                                        r12 = r15(r3, r20, r17)
                                                        r12 = "loadstring"
                                                        r15 = _env[r12]
                                                        ReturnVal = {}
                                                        r20 = "game"
                                                        r3 = _env[r20]
                                                        r6 = "HttpGet"
                                                        r6 = r3[r6]
                                                        r17 = upvalueValues[r21]
                                                        r20 = {
                                                            r6(r3, r17)
                                                        }
                                                        r12 = r15(unpack(r20))
                                                        r15 = r12()
                                                        state = nil
                                                    end
                                                else
                                                    if state == 37 then
                                                        r16 = nil
                                                        state = 35
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure2 entry 2642480 -> 38, states 38-38
                                if state == 38 then -- entry 2642480 -> 38
                                    ReturnVal = "error"
                                    state = _env[ReturnVal]
                                    r5 = "Tamper Detected!"
                                    ReturnVal = state(r5)
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        else
                            if state <= 39 then
                                -- createClosure2 entry 15499143 -> 39, states 39-39
                                if state == 39 then -- entry 15499143 -> 39
                                    state = true
                                    upvalueValues[upvalues[1]] = state
                                    ReturnVal = {}
                                    state = nil
                                end
                            else
                                -- createClosure0 entry 4282014 -> 40, states 40-40
                                if state == 40 then -- entry 4282014 -> 40
                                    r33 = "X9YMUM0RJA"
                                    r30 = 11714988
                                    r5 = r33 ^ r30
                                    ReturnVal = 9516346
                                    state = ReturnVal - r5
                                    r5 = state
                                    ReturnVal = "iCxLEkyxwAS"
                                    state = ReturnVal / r5
                                    ReturnVal = {
                                        state
                                    }
                                    state = nil
                                end
                            end
                        end
                    else
                        if state <= 56 then
                            if state <= 52 then
                                -- createClosure0 entry 10496922 -> 41, states 41-52
                                if state <= 46 then
                                    if state <= 43 then
                                        if state <= 42 then
                                            if state <= 41 then
                                                if state == 41 then -- entry 10496922 -> 41
                                                    r33 = upvalueValues[upvalues[1]]
                                                    r11 = 1
                                                    r2 = 2
                                                    r30 = r33(r11, r2)
                                                    r33 = 1
                                                    r5 = r30 == r33
                                                    state = r5 and (42) or (43)
                                                    ReturnVal = r5
                                                end
                                            else
                                                if state == 42 then
                                                    state = ReturnVal and (44) or (45)
                                                end
                                            end
                                        else
                                            if state == 43 then
                                                r33 = upvalueValues[upvalues[2]]
                                                r30 = upvalueValues[upvalues[3]]
                                                r5 = r33 == r30
                                                ReturnVal = r5
                                                state = 42
                                            end
                                        end
                                    else
                                        if state <= 45 then
                                            if state <= 44 then
                                                if state == 44 then
                                                    r23 = createClosure3(81, {})
                                                    ReturnVal = "tonumber"
                                                    state = _env[ReturnVal]
                                                    r5 = upvalueValues[upvalues[4]]
                                                    r11 = "tostring"
                                                    r30 = _env[r11]
                                                    r27 = "pcall"
                                                    r10 = _env[r27]
                                                    r27 = {
                                                        r10(r23)
                                                    }
                                                    r19 = {
                                                        unpack(r27)
                                                    }
                                                    r10 = 2
                                                    r2 = r19[r10]
                                                    r11 = r30(r2)
                                                    r30 = ":(%d*):"
                                                    r33 = r5(r11, r30)
                                                    r5 = {
                                                        r33()
                                                    }
                                                    ReturnVal = state(unpack(r5))
                                                    r5 = ReturnVal
                                                    r33 = upvalueValues[upvalues[5]]
                                                    state = r33 and (46) or (47)
                                                    ReturnVal = r33
                                                end
                                            else
                                                if state == 45 then
                                                    state = upvalueValues[upvalues[7]]
                                                    state = state and (48) or (49)
                                                end
                                            end
                                        else
                                            if state == 46 then
                                                r30 = upvalueValues[upvalues[6]]
                                                r33 = r30 == r5
                                                ReturnVal = r33
                                                state = 47
                                            end
                                        end
                                    end
                                else
                                    if state <= 49 then
                                        if state <= 48 then
                                            if state <= 47 then
                                                if state == 47 then
                                                    r5 = nil
                                                    upvalueValues[upvalues[5]] = ReturnVal
                                                    state = 45
                                                end
                                            else
                                                if state == 48 then
                                                    r5 = "error"
                                                    state = _env[r5]
                                                    r33 = upvalueValues[upvalues[8]]
                                                    r30 = 0
                                                    r5 = state(r33, r30)
                                                    state = 49
                                                end
                                            end
                                        else
                                            if state == 49 then
                                                r30 = upvalueValues[upvalues[9]]
                                                r11 = r30
                                                state = {}
                                                r5 = state
                                                r30 = 1
                                                r2 = r30
                                                r30 = 0
                                                r19 = r2 < r30
                                                r33 = 1
                                                r30 = r33 - r2
                                                state = 50
                                            end
                                        end
                                    else
                                        if state <= 51 then
                                            if state <= 50 then
                                                if state == 50 then
                                                    r30 = r30 + r2
                                                    r33 = r30 <= r11
                                                    r10 = not r19
                                                    r33 = r10 and r33
                                                    r10 = r30 >= r11
                                                    r10 = r19 and r10
                                                    r33 = r10 or r33
                                                    r10 = (51)
                                                    state = r33 and r10
                                                    r33 = (52)
                                                    state = state or r33
                                                end
                                            else
                                                if state == 51 then
                                                    r33 = r30
                                                    state = upvalueValues[upvalues[1]]
                                                    r27 = 0
                                                    r23 = 255
                                                    r10 = state(r27, r23)
                                                    r5[r33] = r10
                                                    r33 = nil
                                                    state = 50
                                                end
                                            end
                                        else
                                            if state == 52 then
                                                state = upvalueValues[upvalues[10]]
                                                r33 = upvalueValues[upvalues[11]]
                                                r5[state] = r33
                                                state = upvalueValues[upvalues[12]]
                                                r33 = {
                                                    state(r5)
                                                }
                                                ReturnVal = {
                                                    unpack(r33)
                                                }
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure2 entry 15926487 -> 53, states 53-56
                                if state <= 54 then
                                    if state <= 53 then
                                        if state == 53 then -- entry 15926487 -> 53
                                            state = 54
                                        end
                                    else
                                        if state == 54 then
                                            state = true
                                            state = state and (55) or (56)
                                        end
                                    end
                                else
                                    if state <= 55 then
                                        if state == 55 then
                                            ReturnVal = "l2"
                                            state = _env[ReturnVal]
                                            r5 = "l1"
                                            ReturnVal = _env[r5]
                                            r5 = "l1"
                                            _env[r5] = state
                                            r5 = "l2"
                                            _env[r5] = ReturnVal
                                            r5 = upvalueValues[upvalues[1]]
                                            r33 = r5()
                                            state = 54
                                        end
                                    else
                                        if state == 56 then
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                end
                            end
                        else
                            -- createClosure4 entry 6378163 -> 57, states 57-62
                            if state <= 59 then
                                if state <= 58 then
                                    if state <= 57 then
                                        if state == 57 then -- entry 6378163 -> 57
                                            r5 = upvalueValues[upvalues[1]]
                                            ReturnVal = #r5
                                            r5 = 0
                                            state = ReturnVal == r5
                                            state = state and (58) or (59)
                                        end
                                    else
                                        if state == 58 then
                                            r33 = upvalueValues[upvalues[2]]
                                            r30 = 253
                                            r5 = r33 * r30
                                            r33 = 29819198748219
                                            ReturnVal = r5 + r33
                                            r5 = 35184372088832
                                            state = ReturnVal % r5
                                            upvalueValues[upvalues[2]] = state
                                            r5 = upvalueValues[upvalues[3]]
                                            r33 = 1
                                            ReturnVal = r5 ~= r33
                                            state = 60
                                        end
                                    end
                                else
                                    if state == 59 then
                                        r30 = "table"
                                        r33 = _env[r30]
                                        r30 = "remove"
                                        r5 = r33[r30]
                                        r30 = upvalueValues[upvalues[1]]
                                        r33 = {
                                            r5(r30)
                                        }
                                        ReturnVal = {
                                            unpack(r33)
                                        }
                                        state = nil
                                    end
                                end
                            else
                                if state <= 61 then
                                    if state <= 60 then
                                        if state == 60 then
                                            r33 = upvalueValues[upvalues[3]]
                                            r30 = 103
                                            r5 = r33 * r30
                                            r33 = 257
                                            ReturnVal = r5 % r33
                                            upvalueValues[upvalues[3]] = ReturnVal
                                            state = 61
                                        end
                                    else
                                        if state == 61 then
                                            r33 = upvalueValues[upvalues[3]]
                                            r30 = 1
                                            r5 = r33 ~= r30
                                            state = r5 and (62) or (60)
                                        end
                                    end
                                else
                                    if state == 62 then
                                        r30 = 32
                                        r33 = upvalueValues[upvalues[3]]
                                        r5 = r33 % r30
                                        r11 = upvalueValues[upvalues[4]]
                                        r23 = 2
                                        r10 = upvalueValues[upvalues[2]]
                                        r16 = upvalueValues[upvalues[3]]
                                        r15 = r16 - r5
                                        r16 = 32
                                        r21 = r15 / r16
                                        r18 = 13
                                        r26 = r18 - r21
                                        r27 = r23 ^ r26
                                        r19 = r10 / r27
                                        r2 = r11(r19)
                                        r11 = 4294967296
                                        r30 = r2 % r11
                                        r2 = 2
                                        r11 = r2 ^ r5
                                        r27 = 1
                                        r33 = r30 / r11
                                        r11 = upvalueValues[upvalues[4]]
                                        r10 = r33 % r27
                                        r27 = 4294967296
                                        r19 = r10 * r27
                                        r2 = r11(r19)
                                        r11 = upvalueValues[upvalues[4]]
                                        r19 = r11(r33)
                                        r30 = r2 + r19
                                        r2 = 65536
                                        r11 = r30 % r2
                                        r19 = r30 - r11
                                        r10 = 65536
                                        r2 = r19 / r10
                                        r10 = 256
                                        r19 = r11 % r10
                                        r27 = r11 - r19
                                        r23 = 256
                                        r10 = r27 / r23
                                        r18 = 256
                                        r33 = nil
                                        r23 = 256
                                        r11 = nil
                                        r27 = r2 % r23
                                        r30 = nil
                                        r26 = r2 - r27
                                        r23 = r26 / r18
                                        r26 = {
                                            r19,
                                            r10,
                                            r27,
                                            r23
                                        }
                                        r27 = nil
                                        r23 = nil
                                        upvalueValues[upvalues[1]] = r26
                                        r2 = nil
                                        r10 = nil
                                        r5 = nil
                                        r19 = nil
                                        state = 59
                                    end
                                end
                            end
                        end
                    end
                else
                    if state <= 76 then
                        if state <= 70 then
                            if state <= 69 then
                                -- createClosure7 entry 15093424 -> 63, states 63-69
                                if state <= 66 then
                                    if state <= 64 then
                                        if state <= 63 then
                                            if state == 63 then -- entry 15093424 -> 63
                                                r33 = args[2]
                                                r5 = args[1]
                                                state = upvalueValues[upvalues[1]]
                                                r30 = state
                                                state = r30[r33]
                                                state = state and (64) or (65)
                                            end
                                        else
                                            if state == 64 then
                                                state = 66
                                            end
                                        end
                                    else
                                        if state <= 65 then
                                            if state == 65 then
                                                state = {}
                                                upvalueValues[upvalues[2]] = state
                                                ReturnVal = upvalueValues[upvalues[3]]
                                                r11 = ReturnVal
                                                r2 = 35184372088832
                                                ReturnVal = r33 % r2
                                                upvalueValues[upvalues[4]] = ReturnVal
                                                r10 = 255
                                                r19 = r33 % r10
                                                r10 = 2
                                                r2 = r19 + r10
                                                upvalueValues[upvalues[5]] = r2
                                                r27 = "string"
                                                r10 = _env[r27]
                                                r27 = "len"
                                                r19 = r10[r27]
                                                r10 = r19(r5)
                                                r19 = ""
                                                r30[r33] = r19
                                                r26 = 1
                                                r18 = r26
                                                r26 = 0
                                                r21 = r18 < r26
                                                r27 = 1
                                                r26 = r27 - r18
                                                r23 = r10
                                                r19 = 62
                                                state = 67
                                            end
                                        else
                                            if state == 66 then
                                                ReturnVal = {
                                                    r33
                                                }
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    if state <= 68 then
                                        if state <= 67 then
                                            if state == 67 then
                                                r26 = r26 + r18
                                                r15 = not r21
                                                r27 = r26 <= r23
                                                r27 = r15 and r27
                                                r15 = r26 >= r23
                                                r15 = r21 and r15
                                                r27 = r15 or r27
                                                r15 = (68)
                                                state = r27 and r15
                                                r27 = (69)
                                                state = state or r27
                                            end
                                        else
                                            if state == 68 then
                                                r14 = "string"
                                                r28 = _env[r14]
                                                r27 = r26
                                                r14 = "byte"
                                                r32 = r28[r14]
                                                r28 = r32(r5, r27)
                                                r32 = upvalueValues[upvalues[6]]
                                                r14 = r32()
                                                r12 = r28 + r14
                                                r16 = r12 + r19
                                                r14 = 1
                                                r12 = 256
                                                r27 = nil
                                                r15 = r16 % r12
                                                r19 = r15
                                                r12 = r30[r33]
                                                r28 = r19 + r14
                                                r32 = r11[r28]
                                                r16 = r12 .. r32
                                                r30[r33] = r16
                                                state = 67
                                            end
                                        end
                                    else
                                        if state == 69 then
                                            r19 = nil
                                            r11 = nil
                                            r10 = nil
                                            state = 66
                                        end
                                    end
                                end
                            else
                                -- createClosure4 entry 13442488 -> 70, states 70-70
                                if state == 70 then -- entry 13442488 -> 70
                                    r5 = allocUpvalue()
                                    upvalueValues[r5] = args[1]
                                    r33 = allocUpvalue()
                                    r30 = allocUpvalue()
                                    upvalueValues[r33] = args[2]
                                    upvalueValues[r30] = args[3]
                                    r11 = createClosure1(82, {
                                        upvalues[1],
                                        upvalues[2],
                                        upvalues[3],
                                        r5,
                                        r33,
                                        r30
                                    })
                                    ReturnVal = "pcall"
                                    state = _env[ReturnVal]
                                    r30 = releaseUpvalue(r30)
                                    ReturnVal = state(r11)
                                    ReturnVal = {}
                                    r5 = releaseUpvalue(r5)
                                    r33 = releaseUpvalue(r33)
                                    state = nil
                                end
                            end
                        else
                            -- createClosure4 entry 15513006 -> 71, states 71-76
                            if state <= 73 then
                                if state <= 72 then
                                    if state <= 71 then
                                        if state == 71 then -- entry 15513006 -> 71
                                            r5 = upvalueValues[upvalues[1]]
                                            r30 = upvalueValues[upvalues[2]]
                                            r11 = upvalueValues[upvalues[3]]
                                            r10 = 24880209259841
                                            r19 = "\250\214\129\212"
                                            r2 = r11(r19, r10)
                                            r33 = r30[r2]
                                            ReturnVal = r5[r33]
                                            r5 = upvalueValues[upvalues[4]]
                                            state = ReturnVal == r5
                                            state = state and (72) or (73)
                                        end
                                    else
                                        if state == 72 then
                                            state = upvalueValues[upvalues[5]]
                                            r33 = upvalueValues[upvalues[2]]
                                            r30 = upvalueValues[upvalues[3]]
                                            r19 = 33324817874078
                                            r2 = "\158\220\rb\213\026\195"
                                            r11 = r30(r2, r19)
                                            r5 = r33[r11]
                                            r30 = upvalueValues[upvalues[2]]
                                            r11 = upvalueValues[upvalues[3]]
                                            r10 = 13056255956927
                                            r19 = "\187\015y*\199\160\215\019\\xN]\018\014)s\201\227(;q\142\142\233\224\235g'\008e\224"
                                            r2 = r11(r19, r10)
                                            r33 = r30[r2]
                                            r30 = 3
                                            ReturnVal = state(r5, r33, r30)
                                            r5 = "task"
                                            ReturnVal = _env[r5]
                                            r33 = upvalueValues[upvalues[2]]
                                            r30 = upvalueValues[upvalues[3]]
                                            r2 = "*T\203\191"
                                            r19 = 30642652362685
                                            r11 = r30(r2, r19)
                                            r5 = r33[r11]
                                            state = ReturnVal[r5]
                                            r5 = 0.5
                                            ReturnVal = state(r5)
                                            state = upvalueValues[upvalues[6]]
                                            ReturnVal = "Destroy"
                                            ReturnVal = state[ReturnVal]
                                            ReturnVal = ReturnVal(state)
                                            ReturnVal = "writefile"
                                            state = _env[ReturnVal]
                                            state = state and (74) or (75)
                                        end
                                    end
                                else
                                    if state == 73 then
                                        state = upvalueValues[upvalues[5]]
                                        r33 = upvalueValues[upvalues[2]]
                                        r30 = upvalueValues[upvalues[3]]
                                        r2 = "\t\197\007\140\131"
                                        r19 = 17654440501276
                                        r11 = r30(r2, r19)
                                        r5 = r33[r11]
                                        r30 = upvalueValues[upvalues[2]]
                                        r11 = upvalueValues[upvalues[3]]
                                        r10 = 9695134896546
                                        r19 = "%A\249\252\195R\rwDO\210\168ZJ"
                                        r2 = r11(r19, r10)
                                        r33 = r30[r2]
                                        r30 = 3
                                        ReturnVal = state(r5, r33, r30)
                                        state = 76
                                    end
                                end
                            else
                                if state <= 75 then
                                    if state <= 74 then
                                        if state == 74 then
                                            ReturnVal = "writefile"
                                            state = _env[ReturnVal]
                                            r5 = upvalueValues[upvalues[7]]
                                            r30 = "tostring"
                                            r33 = _env[r30]
                                            r2 = upvalueValues[upvalues[8]]
                                            r10 = upvalueValues[upvalues[2]]
                                            r27 = upvalueValues[upvalues[3]]
                                            r18 = 26155589644179
                                            r26 = "\2338\163\029g6"
                                            r23 = r27(r26, r18)
                                            r19 = r10[r23]
                                            r11 = r2[r19]
                                            r30 = {
                                                r33(r11)
                                            }
                                            ReturnVal = state(r5, unpack(r30))
                                            state = 75
                                        end
                                    else
                                        if state == 75 then
                                            ReturnVal = "loadstring"
                                            state = _env[ReturnVal]
                                            r33 = "game"
                                            r5 = _env[r33]
                                            r11 = "HttpGet"
                                            r11 = r5[r11]
                                            r30 = upvalueValues[upvalues[9]]
                                            r33 = {
                                                r11(r5, r30)
                                            }
                                            ReturnVal = state(unpack(r33))
                                            state = ReturnVal()
                                            state = 76
                                        end
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
                        if state <= 81 then
                            if state <= 80 then
                                -- createClosure1 entry 6207965 -> 77, states 77-80
                                if state <= 78 then
                                    if state <= 77 then
                                        if state == 77 then -- entry 6207965 -> 77
                                            ReturnVal = "setclipboard"
                                            state = _env[ReturnVal]
                                            state = state and (78) or (79)
                                        end
                                    else
                                        if state == 78 then
                                            ReturnVal = "setclipboard"
                                            state = _env[ReturnVal]
                                            r5 = upvalueValues[upvalues[1]]
                                            ReturnVal = state(r5)
                                            state = upvalueValues[upvalues[2]]
                                            r33 = upvalueValues[upvalues[3]]
                                            r30 = upvalueValues[upvalues[4]]
                                            r19 = 5935305067211
                                            r2 = "\255f\133\166\247J"
                                            r11 = r30(r2, r19)
                                            r5 = r33[r11]
                                            r30 = upvalueValues[upvalues[3]]
                                            r11 = upvalueValues[upvalues[4]]
                                            r19 = "\245\244\025\016\181\194l.\156jJ\209\016(\213\030~s6\215\180"
                                            r10 = 20862983792115
                                            r2 = r11(r19, r10)
                                            r33 = r30[r2]
                                            r30 = 4
                                            ReturnVal = state(r5, r33, r30)
                                            state = 80
                                        end
                                    end
                                else
                                    if state <= 79 then
                                        if state == 79 then
                                            state = upvalueValues[upvalues[2]]
                                            r33 = upvalueValues[upvalues[3]]
                                            r30 = upvalueValues[upvalues[4]]
                                            r19 = 4599551756381
                                            r2 = "\147\\8\n\209\012\004d%~\024"
                                            r11 = r30(r2, r19)
                                            r5 = r33[r11]
                                            r11 = upvalueValues[upvalues[3]]
                                            r2 = upvalueValues[upvalues[4]]
                                            r10 = "-\247|\0040,"
                                            r27 = 16001245191451
                                            r19 = r2(r10, r27)
                                            r30 = r11[r19]
                                            r11 = upvalueValues[upvalues[1]]
                                            r33 = r30 .. r11
                                            r30 = 5
                                            ReturnVal = state(r5, r33, r30)
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
                                -- createClosure3 entry 9962969 -> 81, states 81-81
                                if state == 81 then -- entry 9962969 -> 81
                                    r30 = 8842014
                                    r33 = "dwd8SMKPcUua"
                                    r5 = r33 ^ r30
                                    ReturnVal = 15103686
                                    state = ReturnVal - r5
                                    r5 = state
                                    ReturnVal = "2ujUgw27To"
                                    state = ReturnVal / r5
                                    ReturnVal = {
                                        state
                                    }
                                    state = nil
                                end
                            end
                        else
                            -- createClosure1 entry 10176417 -> 82, states 82-82
                            if state == 82 then -- entry 10176417 -> 82
                                state = upvalueValues[upvalues[1]]
                                r33 = upvalueValues[upvalues[2]]
                                r30 = upvalueValues[upvalues[3]]
                                r19 = 18791969432110
                                r2 = "\138\127\226\tN\0168\022\158B\177z:\147\251\154"
                                r11 = r30(r2, r19)
                                r5 = r33[r11]
                                r11 = upvalueValues[upvalues[2]]
                                r2 = upvalueValues[upvalues[3]]
                                r10 = "1\188C\"2"
                                r27 = 19450801365857
                                r19 = r2(r10, r27)
                                r30 = r11[r19]
                                r11 = upvalueValues[upvalues[4]]
                                r19 = upvalueValues[upvalues[2]]
                                r10 = upvalueValues[upvalues[3]]
                                r23 = "\165\146\231\221"
                                r26 = 19924804019262
                                r27 = r10(r23, r26)
                                r2 = r19[r27]
                                r19 = upvalueValues[upvalues[5]]
                                r27 = upvalueValues[upvalues[2]]
                                r23 = upvalueValues[upvalues[3]]
                                r21 = 3811455469294
                                r18 = "\134\2517\221RW\218\240"
                                r26 = r23(r18, r21)
                                r10 = r27[r26]
                                ReturnVal = "SetCore"
                                ReturnVal = state[ReturnVal]
                                r26 = upvalueValues[upvalues[6]]
                                r18 = 3
                                r27 = r26 or r18
                                r33 = {
                                    [r30] = r11,
                                    [r2] = r19,
                                    [r10] = r27
                                }
                                ReturnVal = ReturnVal(state, r5, r33)
                                r23 = state
                                ReturnVal = {}
                                state = nil
                            end
                        end
                    end
                end
            end
            state = #gcProxy
            return unpack(ReturnVal)
        end
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)