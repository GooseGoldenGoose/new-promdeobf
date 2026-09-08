return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, createClosure, upvalueRefCounts, createClosure5, createClosure6, createClosure4, releaseUpvalue, currentUpvalueId, createClosure1, createClosure2, createUpvalueProxy, createClosure3, createClosure0, vm, upvalueValues, releaseUpvalues, allocUpvalue)
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
                if 0 == upvalueRefCounts[upvalueId] then
                    upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
                end
                upvalueId = captures[captureIndex]
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
        currentUpvalueId = 0
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return 471702
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 471702
                    end
                })
            end
        end
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
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
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if 0 == upvalueRefCounts[upvalueId] then
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
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, ReturnVal, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33
            while state do
                if state <= 79 then
                    if state <= 60 then
                        if state <= 43 then
                            if state <= 42 then
                                if state <= 41 then
                                    -- root entry 12820037 -> 1, states 1-41
                                    if state <= 21 then
                                        if state <= 11 then
                                            if state <= 6 then
                                                if state <= 3 then
                                                    if state <= 2 then
                                                        if state <= 1 then
                                                            if state == 1 then -- entry 12820037 -> 1
                                                                r2 = allocUpvalue()
                                                                state = true
                                                                upvalueValues[r2] = state
                                                                r30 = "string"
                                                                ReturnVal = _env[r30]
                                                                r30 = "gmatch"
                                                                state = ReturnVal[r30]
                                                                r18 = allocUpvalue()
                                                                r30 = allocUpvalue()
                                                                upvalueValues[r30] = state
                                                                state = createClosure4(42, {})
                                                                r1 = allocUpvalue()
                                                                r4 = createClosure5(43, {
                                                                    r1
                                                                })
                                                                upvalueValues[r18] = state
                                                                state = false
                                                                upvalueValues[r1] = state
                                                                r11 = "pcall"
                                                                r32 = _env[r11]
                                                                r11 = r32(r4)
                                                                state = r11 and (2) or (3)
                                                                r7 = args
                                                                ReturnVal = r11
                                                            end
                                                        else
                                                            if state == 2 then
                                                                r32 = upvalueValues[r1]
                                                                ReturnVal = r32
                                                                state = 3
                                                            end
                                                        end
                                                    else
                                                        if state == 3 then
                                                            r32 = ReturnVal
                                                            r11 = "math"
                                                            ReturnVal = _env[r11]
                                                            r11 = "random"
                                                            state = ReturnVal[r11]
                                                            r11 = allocUpvalue()
                                                            upvalueValues[r11] = state
                                                            r4 = "table"
                                                            ReturnVal = _env[r4]
                                                            r4 = "concat"
                                                            state = ReturnVal[r4]
                                                            r17 = state
                                                            r4 = state
                                                            r15 = "table"
                                                            r3 = _env[r15]
                                                            state = r3 and (4) or (5)
                                                            r5 = r3
                                                        end
                                                    end
                                                else
                                                    if state <= 5 then
                                                        if state <= 4 then
                                                            if state == 4 then
                                                                r16 = "table"
                                                                r15 = _env[r16]
                                                                r16 = "unpack"
                                                                r3 = r15[r16]
                                                                r5 = r3
                                                                state = 5
                                                            end
                                                        else
                                                            if state == 5 then
                                                                state = r17
                                                                state = r5 and (6) or (7)
                                                                ReturnVal = r5
                                                            end
                                                        end
                                                    else
                                                        if state == 6 then
                                                            r5 = allocUpvalue()
                                                            upvalueValues[r5] = ReturnVal
                                                            state = upvalueValues[r11]
                                                            r3 = 65
                                                            r17 = 3
                                                            ReturnVal = state(r17, r3)
                                                            r17 = allocUpvalue()
                                                            upvalueValues[r17] = ReturnVal
                                                            state = 0
                                                            r3 = state
                                                            r16 = "pcall"
                                                            ReturnVal = _env[r16]
                                                            state = 0
                                                            r13 = createClosure5(44, {})
                                                            r16 = {
                                                                ReturnVal(r13)
                                                            }
                                                            r15 = state
                                                            state = {
                                                                unpack(r16)
                                                            }
                                                            r16 = state
                                                            ReturnVal = 2
                                                            state = r16[ReturnVal]
                                                            r13 = state
                                                            ReturnVal = "tonumber"
                                                            state = _env[ReturnVal]
                                                            r6 = upvalueValues[r30]
                                                            r12 = "tostring"
                                                            r20 = _env[r12]
                                                            r12 = r20(r13)
                                                            r20 = ":(%d*):"
                                                            r21 = r6(r12, r20)
                                                            r6 = {
                                                                r21()
                                                            }
                                                            ReturnVal = state(unpack(r6))
                                                            r6 = allocUpvalue()
                                                            upvalueValues[r6] = ReturnVal
                                                            r21 = upvalueValues[r17]
                                                            r20 = r21
                                                            r21 = 1
                                                            r12 = r21
                                                            r21 = 0
                                                            r33 = r12 < r21
                                                            ReturnVal = 1
                                                            r21 = ReturnVal - r12
                                                            state = 8
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 9 then
                                                    if state <= 8 then
                                                        if state <= 7 then
                                                            if state == 7 then
                                                                r17 = "unpack"
                                                                r5 = _env[r17]
                                                                ReturnVal = r5
                                                                state = 6
                                                            end
                                                        else
                                                            if state == 8 then
                                                                r29 = not r33
                                                                r21 = r21 + r12
                                                                ReturnVal = r21 <= r20
                                                                ReturnVal = r29 and ReturnVal
                                                                r29 = r21 >= r20
                                                                r29 = r33 and r29
                                                                ReturnVal = r29 or ReturnVal
                                                                r29 = (9)
                                                                state = ReturnVal and r29
                                                                ReturnVal = (10)
                                                                state = state or ReturnVal
                                                            end
                                                        end
                                                    else
                                                        if state == 9 then
                                                            r29 = allocUpvalue()
                                                            upvalueValues[r29] = r21
                                                            r10 = "math"
                                                            ReturnVal = _env[r10]
                                                            r10 = "random"
                                                            state = ReturnVal[r10]
                                                            r28 = 100
                                                            r10 = 1
                                                            ReturnVal = state(r10, r28)
                                                            r10 = allocUpvalue()
                                                            upvalueValues[r10] = ReturnVal
                                                            state = upvalueValues[r11]
                                                            r27 = 255
                                                            r28 = 0
                                                            ReturnVal = state(r28, r27)
                                                            r28 = allocUpvalue()
                                                            upvalueValues[r28] = ReturnVal
                                                            state = upvalueValues[r11]
                                                            r24 = upvalueValues[r10]
                                                            r27 = 1
                                                            ReturnVal = state(r27, r24)
                                                            r27 = allocUpvalue()
                                                            upvalueValues[r27] = ReturnVal
                                                            ReturnVal = upvalueValues[r11]
                                                            r26 = 2
                                                            r9 = 1
                                                            r24 = ReturnVal(r9, r26)
                                                            ReturnVal = 1
                                                            state = r24 == ReturnVal
                                                            r24 = allocUpvalue()
                                                            upvalueValues[r24] = state
                                                            r22 = "tostring"
                                                            r8 = _env[r22]
                                                            r14 = upvalueValues[r11]
                                                            r19 = 10000
                                                            r23 = 0
                                                            r31 = {
                                                                r14(r23, r19)
                                                            }
                                                            r22 = r8(unpack(r31))
                                                            state = "gsub"
                                                            state = r13[state]
                                                            r8 = ":"
                                                            r25 = r22 .. r8
                                                            r26 = ":"
                                                            r9 = r26 .. r25
                                                            ReturnVal = ":(%d*):"
                                                            state = state(r13, ReturnVal, r9)
                                                            r9 = allocUpvalue()
                                                            upvalueValues[r9] = state
                                                            r26 = "pcall"
                                                            ReturnVal = _env[r26]
                                                            r25 = createClosure5(45, {
                                                                r11,
                                                                r29,
                                                                r17,
                                                                r30,
                                                                r2,
                                                                r6,
                                                                r24,
                                                                r9,
                                                                r10,
                                                                r27,
                                                                r28,
                                                                r5
                                                            })
                                                            r26 = {
                                                                ReturnVal(r25)
                                                            }
                                                            state = {
                                                                unpack(r26)
                                                            }
                                                            r26 = state
                                                            state = upvalueValues[r24]
                                                            state = state and (11) or (12)
                                                        end
                                                    end
                                                else
                                                    if state <= 10 then
                                                        if state == 10 then
                                                            r20 = upvalueValues[r2]
                                                            state = r20 and (13) or (14)
                                                            r21 = r20
                                                        end
                                                    else
                                                        if state == 11 then
                                                            r25 = upvalueValues[r2]
                                                            state = r25 and (15) or (16)
                                                            ReturnVal = r25
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
                                                                r8 = upvalueValues[r2]
                                                                state = r8 and (17) or (18)
                                                                r25 = r8
                                                            end
                                                        else
                                                            if state == 13 then
                                                                r20 = r3 == r15
                                                                r21 = r20
                                                                state = 14
                                                            end
                                                        end
                                                    else
                                                        if state == 14 then
                                                            upvalueValues[r2] = r21
                                                            state = upvalueValues[r2]
                                                            state = state and (19) or (20)
                                                        end
                                                    end
                                                else
                                                    if state <= 15 then
                                                        if state == 15 then
                                                            r31 = 1
                                                            r14 = r26[r31]
                                                            r31 = false
                                                            r22 = r14 == r31
                                                            r8 = state
                                                            state = r22 and (21) or (22)
                                                            r25 = r22
                                                        end
                                                    else
                                                        if state == 16 then
                                                            upvalueValues[r2] = ReturnVal
                                                            state = 23
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 19 then
                                                    if state <= 18 then
                                                        if state <= 17 then
                                                            if state == 17 then
                                                                r22 = 1
                                                                r8 = r26[r22]
                                                                r25 = r8
                                                                state = 18
                                                            end
                                                        else
                                                            if state == 18 then
                                                                upvalueValues[r2] = r25
                                                                r31 = upvalueValues[r27]
                                                                r23 = 1
                                                                r14 = r31 + r23
                                                                r22 = r26[r14]
                                                                r8 = r3 + r22
                                                                r22 = 256
                                                                state = r8 % r22
                                                                r3 = state
                                                                r14 = upvalueValues[r28]
                                                                r22 = r15 + r14
                                                                r14 = 256
                                                                r8 = r22 % r14
                                                                r15 = r8
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
                                                            r31 = 2
                                                            r14 = r26[r31]
                                                            r31 = upvalueValues[r9]
                                                            r22 = r14 == r31
                                                            r25 = r22
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
                                                                state = r8
                                                                ReturnVal = r25
                                                                state = 16
                                                            end
                                                        else
                                                            if state == 23 then
                                                                r29 = releaseUpvalue(r29)
                                                                r28 = releaseUpvalue(r28)
                                                                r26 = nil
                                                                r10 = releaseUpvalue(r10)
                                                                r24 = releaseUpvalue(r24)
                                                                r27 = releaseUpvalue(r27)
                                                                r9 = releaseUpvalue(r9)
                                                                state = 8
                                                            end
                                                        end
                                                    else
                                                        if state == 24 then
                                                            r18 = releaseUpvalue(r18)
                                                            r18 = allocUpvalue()
                                                            r2 = releaseUpvalue(r2)
                                                            r6 = releaseUpvalue(r6)
                                                            r11 = releaseUpvalue(r11)
                                                            r17 = releaseUpvalue(r17)
                                                            r5 = releaseUpvalue(r5)
                                                            r2 = nil
                                                            upvalueValues[r18] = r2
                                                            r1 = releaseUpvalue(r1)
                                                            r30 = releaseUpvalue(r30)
                                                            r2 = allocUpvalue()
                                                            r30 = nil
                                                            upvalueValues[r2] = r30
                                                            r32 = nil
                                                            r32 = "math"
                                                            r1 = _env[r32]
                                                            r32 = "floor"
                                                            r30 = r1[r32]
                                                            r1 = allocUpvalue()
                                                            upvalueValues[r1] = r30
                                                            r11 = "math"
                                                            r32 = _env[r11]
                                                            r11 = "random"
                                                            r30 = r32[r11]
                                                            r4 = nil
                                                            r4 = "table"
                                                            r11 = _env[r4]
                                                            r4 = "remove"
                                                            r32 = r11[r4]
                                                            r17 = allocUpvalue()
                                                            r5 = "string"
                                                            r4 = _env[r5]
                                                            r16 = nil
                                                            r16 = {}
                                                            r15 = nil
                                                            r15 = allocUpvalue()
                                                            r5 = "char"
                                                            r11 = r4[r5]
                                                            r5 = allocUpvalue()
                                                            r4 = 0
                                                            upvalueValues[r5] = r4
                                                            r4 = 2
                                                            upvalueValues[r17] = r4
                                                            r4 = {}
                                                            r3 = nil
                                                            r3 = {}
                                                            upvalueValues[r15] = r3
                                                            r6 = 256
                                                            r33 = r6
                                                            r6 = 1
                                                            r29 = r6
                                                            r6 = 0
                                                            r10 = r29 < r6
                                                            r13 = nil
                                                            r13 = 1
                                                            r6 = r13 - r29
                                                            r3 = 0
                                                            state = 26
                                                        end
                                                    end
                                                else
                                                    if state <= 25 then
                                                        if state == 25 then
                                                            state = createClosure5(57, {
                                                                r18
                                                            })
                                                            r20 = {
                                                                state()
                                                            }
                                                            ReturnVal = {
                                                                unpack(r20)
                                                            }
                                                            state = nil
                                                        end
                                                    else
                                                        if state == 26 then
                                                            r6 = r6 + r29
                                                            r28 = not r10
                                                            r13 = r6 <= r33
                                                            r13 = r28 and r13
                                                            r28 = r6 >= r33
                                                            r28 = r10 and r28
                                                            r13 = r28 or r13
                                                            r28 = (27)
                                                            state = r13 and r28
                                                            r13 = (28)
                                                            state = state or r13
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 29 then
                                                    if state <= 28 then
                                                        if state <= 27 then
                                                            if state == 27 then
                                                                r13 = r6
                                                                r28 = r13
                                                                r16[r13] = r28
                                                                r13 = nil
                                                                state = 26
                                                            end
                                                        else
                                                            if state == 28 then
                                                                r6 = #r16
                                                                r33 = 0
                                                                r13 = r6 == r33
                                                                state = 29
                                                            end
                                                        end
                                                    else
                                                        if state == 29 then
                                                            r6 = 1
                                                            r33 = #r16
                                                            r13 = r30(r6, r33)
                                                            r6 = r32(r16, r13)
                                                            r33 = upvalueValues[r15]
                                                            r28 = 1
                                                            r10 = r6 - r28
                                                            r29 = r11(r10)
                                                            r33[r6] = r29
                                                            r13 = nil
                                                            r6 = nil
                                                            state = 30
                                                        end
                                                    end
                                                else
                                                    if state <= 30 then
                                                        if state == 30 then
                                                            r6 = #r16
                                                            r33 = 0
                                                            r13 = r6 == r33
                                                            state = r13 and (31) or (29)
                                                        end
                                                    else
                                                        if state == 31 then
                                                            r13 = {}
                                                            r30 = nil
                                                            r3 = nil
                                                            r6 = allocUpvalue()
                                                            upvalueValues[r6] = r13
                                                            r13 = allocUpvalue()
                                                            r29 = allocUpvalue()
                                                            r33 = createClosure4(61, {
                                                                r6,
                                                                r5,
                                                                r17,
                                                                r1
                                                            })
                                                            upvalueValues[r13] = r33
                                                            r10 = "setmetatable"
                                                            r32 = nil
                                                            r11 = nil
                                                            r4 = nil
                                                            r22 = nil
                                                            r16 = nil
                                                            r33 = {}
                                                            upvalueValues[r29] = r33
                                                            r28 = {}
                                                            r1 = releaseUpvalue(r1)
                                                            r33 = _env[r10]
                                                            r9 = upvalueValues[r29]
                                                            r24 = "__index"
                                                            r26 = "__metatable"
                                                            r27 = {
                                                                [r24] = r9,
                                                                [r26] = r22
                                                            }
                                                            r10 = r33(r28, r27)
                                                            upvalueValues[r2] = r10
                                                            r33 = createClosure3(67, {
                                                                r29,
                                                                r6,
                                                                r15,
                                                                r5,
                                                                r17,
                                                                r13
                                                            })
                                                            r13 = releaseUpvalue(r13)
                                                            r6 = releaseUpvalue(r6)
                                                            r29 = releaseUpvalue(r29)
                                                            r5 = releaseUpvalue(r5)
                                                            r15 = releaseUpvalue(r15)
                                                            upvalueValues[r18] = r33
                                                            r32 = state
                                                            r17 = releaseUpvalue(r17)
                                                            r1 = "_G"
                                                            r30 = _env[r1]
                                                            r1 = allocUpvalue()
                                                            upvalueValues[r1] = r30
                                                            r4 = "print"
                                                            r11 = _env[r4]
                                                            state = r11 and (32) or (33)
                                                            r30 = r11
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
                                                                state = r32
                                                                r11 = state
                                                                r32 = allocUpvalue()
                                                                upvalueValues[r32] = r30
                                                                r5 = "wait"
                                                                r4 = _env[r5]
                                                                state = r4 and (34) or (35)
                                                                r30 = r4
                                                            end
                                                        else
                                                            if state == 33 then
                                                                r11 = createClosure(74, {})
                                                                r30 = r11
                                                                state = 32
                                                            end
                                                        end
                                                    else
                                                        if state == 34 then
                                                            state = r11
                                                            r4 = state
                                                            r11 = allocUpvalue()
                                                            upvalueValues[r11] = r30
                                                            r17 = "tick"
                                                            r5 = _env[r17]
                                                            state = r5 and (36) or (37)
                                                            r30 = r5
                                                        end
                                                    end
                                                else
                                                    if state <= 35 then
                                                        if state == 35 then
                                                            r4 = createClosure3(75, {})
                                                            r30 = r4
                                                            state = 34
                                                        end
                                                    else
                                                        if state == 36 then
                                                            state = r4
                                                            r5 = state
                                                            r4 = allocUpvalue()
                                                            upvalueValues[r4] = r30
                                                            r3 = "type"
                                                            r17 = _env[r3]
                                                            state = r17 and (38) or (39)
                                                            r30 = r17
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 39 then
                                                    if state <= 38 then
                                                        if state <= 37 then
                                                            if state == 37 then
                                                                r5 = createClosure0(76, {
                                                                    r2,
                                                                    r18
                                                                })
                                                                r30 = r5
                                                                state = 36
                                                            end
                                                        else
                                                            if state == 38 then
                                                                r17 = allocUpvalue()
                                                                state = r5
                                                                r5 = allocUpvalue()
                                                                upvalueValues[r5] = r30
                                                                r30 = createClosure2(77, {
                                                                    r5,
                                                                    r2,
                                                                    r18,
                                                                    r32
                                                                })
                                                                upvalueValues[r17] = r30
                                                                r15 = upvalueValues[r1]
                                                                r30 = createClosure6(80, {
                                                                    r5,
                                                                    r2,
                                                                    r18,
                                                                    r17
                                                                })
                                                                r3 = r30(r15)
                                                                r16 = "game"
                                                                r15 = _env[r16]
                                                                r3 = r30(r15)
                                                                r16 = "workspace"
                                                                r15 = _env[r16]
                                                                r3 = r30(r15)
                                                                r3 = createClosure2(89, {
                                                                    r2,
                                                                    r18,
                                                                    r32
                                                                })
                                                                r15 = r3()
                                                                r16 = upvalueValues[r2]
                                                                r13 = upvalueValues[r18]
                                                                r33 = "#\007\197<E\241\020\160"
                                                                r29 = 7532620795315
                                                                r6 = r13(r33, r29)
                                                                r15 = r16[r6]
                                                                r16 = createClosure6(98, {
                                                                    r2,
                                                                    r18
                                                                })
                                                                r28 = "_G"
                                                                r29 = _env[r28]
                                                                r28 = r16(r15)
                                                                r33 = r29[r28]
                                                                r6 = state
                                                                state = r33 and (40) or (41)
                                                                r13 = r33
                                                            end
                                                        end
                                                    else
                                                        if state == 39 then
                                                            r17 = createClosure1(99, {
                                                                r2,
                                                                r18
                                                            })
                                                            r30 = r17
                                                            state = 38
                                                        end
                                                    end
                                                else
                                                    if state <= 40 then
                                                        if state == 40 then
                                                            r26 = 30490232354678
                                                            state = r6
                                                            r29 = "coroutine"
                                                            r6 = allocUpvalue()
                                                            r3 = nil
                                                            upvalueValues[r6] = r13
                                                            r33 = _env[r29]
                                                            r9 = "\188K\158a"
                                                            r28 = upvalueValues[r2]
                                                            r15 = nil
                                                            r27 = upvalueValues[r18]
                                                            r24 = r27(r9, r26)
                                                            r29 = r28[r24]
                                                            r13 = r33[r29]
                                                            r29 = createClosure5(100, {
                                                                r11,
                                                                r1,
                                                                r6,
                                                                r2,
                                                                r18,
                                                                r32,
                                                                r4,
                                                                r5
                                                            })
                                                            r5 = releaseUpvalue(r5)
                                                            r17 = releaseUpvalue(r17)
                                                            r32 = releaseUpvalue(r32)
                                                            r1 = releaseUpvalue(r1)
                                                            r16 = nil
                                                            r30 = nil
                                                            r33 = r13(r29)
                                                            r13 = r33()
                                                            r13 = upvalueValues[r6]
                                                            r6 = releaseUpvalue(r6)
                                                            ReturnVal = {}
                                                            r4 = releaseUpvalue(r4)
                                                            r11 = releaseUpvalue(r11)
                                                            r28 = upvalueValues[r2]
                                                            r27 = upvalueValues[r18]
                                                            r9 = "\145\140\165\244\229\015\228"
                                                            r26 = 3552234604150
                                                            r24 = r27(r9, r26)
                                                            r29 = r28[r24]
                                                            r2 = releaseUpvalue(r2)
                                                            r18 = releaseUpvalue(r18)
                                                            r33 = r13(r29)
                                                            state = nil
                                                        end
                                                    else
                                                        if state == 41 then
                                                            r33 = upvalueValues[r32]
                                                            r13 = r33
                                                            state = 40
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure4 entry 15770543 -> 42, states 42-42
                                    if state == 42 then -- entry 15770543 -> 42
                                        ReturnVal = "error"
                                        state = _env[ReturnVal]
                                        r7 = "Tamper Detected!"
                                        ReturnVal = state(r7)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            else
                                -- createClosure5 entry 16382269 -> 43, states 43-43
                                if state == 43 then -- entry 16382269 -> 43
                                    state = true
                                    upvalueValues[upvalues[1]] = state
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        else
                            if state <= 56 then
                                if state <= 44 then
                                    -- createClosure5 entry 3445964 -> 44, states 44-44
                                    if state == 44 then -- entry 3445964 -> 44
                                        r30 = 11828093
                                        r2 = "zGGj"
                                        r7 = r2 ^ r30
                                        ReturnVal = 6603120
                                        state = ReturnVal - r7
                                        r7 = state
                                        ReturnVal = "DQIYVxjbqmj"
                                        state = ReturnVal / r7
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure5 entry 7872757 -> 45, states 45-56
                                    if state <= 50 then
                                        if state <= 47 then
                                            if state <= 46 then
                                                if state <= 45 then
                                                    if state == 45 then -- entry 7872757 -> 45
                                                        r2 = upvalueValues[upvalues[1]]
                                                        r1 = 2
                                                        r18 = 1
                                                        r30 = r2(r18, r1)
                                                        r2 = 1
                                                        r7 = r30 == r2
                                                        state = r7 and (46) or (47)
                                                        ReturnVal = r7
                                                    end
                                                else
                                                    if state == 46 then
                                                        state = ReturnVal and (48) or (49)
                                                    end
                                                end
                                            else
                                                if state == 47 then
                                                    r2 = upvalueValues[upvalues[2]]
                                                    r30 = upvalueValues[upvalues[3]]
                                                    r7 = r2 == r30
                                                    ReturnVal = r7
                                                    state = 46
                                                end
                                            end
                                        else
                                            if state <= 49 then
                                                if state <= 48 then
                                                    if state == 48 then
                                                        r5 = createClosure3(120, {})
                                                        ReturnVal = "tonumber"
                                                        state = _env[ReturnVal]
                                                        r7 = upvalueValues[upvalues[4]]
                                                        r18 = "tostring"
                                                        r30 = _env[r18]
                                                        r4 = "pcall"
                                                        r11 = _env[r4]
                                                        r4 = {
                                                            r11(r5)
                                                        }
                                                        r32 = {
                                                            unpack(r4)
                                                        }
                                                        r11 = 2
                                                        r1 = r32[r11]
                                                        r18 = r30(r1)
                                                        r30 = ":(%d*):"
                                                        r2 = r7(r18, r30)
                                                        r7 = {
                                                            r2()
                                                        }
                                                        ReturnVal = state(unpack(r7))
                                                        r7 = ReturnVal
                                                        r2 = upvalueValues[upvalues[5]]
                                                        state = r2 and (50) or (51)
                                                        ReturnVal = r2
                                                    end
                                                else
                                                    if state == 49 then
                                                        state = upvalueValues[upvalues[7]]
                                                        state = state and (52) or (53)
                                                    end
                                                end
                                            else
                                                if state == 50 then
                                                    r30 = upvalueValues[upvalues[6]]
                                                    r2 = r30 == r7
                                                    ReturnVal = r2
                                                    state = 51
                                                end
                                            end
                                        end
                                    else
                                        if state <= 53 then
                                            if state <= 52 then
                                                if state <= 51 then
                                                    if state == 51 then
                                                        upvalueValues[upvalues[5]] = ReturnVal
                                                        r7 = nil
                                                        state = 49
                                                    end
                                                else
                                                    if state == 52 then
                                                        r7 = "error"
                                                        state = _env[r7]
                                                        r2 = upvalueValues[upvalues[8]]
                                                        r30 = 0
                                                        r7 = state(r2, r30)
                                                        state = 53
                                                    end
                                                end
                                            else
                                                if state == 53 then
                                                    state = {}
                                                    r7 = state
                                                    r30 = upvalueValues[upvalues[9]]
                                                    r18 = r30
                                                    r30 = 1
                                                    r1 = r30
                                                    r30 = 0
                                                    r32 = r1 < r30
                                                    r2 = 1
                                                    r30 = r2 - r1
                                                    state = 54
                                                end
                                            end
                                        else
                                            if state <= 55 then
                                                if state <= 54 then
                                                    if state == 54 then
                                                        r11 = not r32
                                                        r30 = r30 + r1
                                                        r2 = r30 <= r18
                                                        r2 = r11 and r2
                                                        r11 = r30 >= r18
                                                        r11 = r32 and r11
                                                        r2 = r11 or r2
                                                        r11 = (55)
                                                        state = r2 and r11
                                                        r2 = (56)
                                                        state = state or r2
                                                    end
                                                else
                                                    if state == 55 then
                                                        state = upvalueValues[upvalues[1]]
                                                        r2 = r30
                                                        r4 = 0
                                                        r5 = 255
                                                        r11 = state(r4, r5)
                                                        r7[r2] = r11
                                                        r2 = nil
                                                        state = 54
                                                    end
                                                end
                                            else
                                                if state == 56 then
                                                    state = upvalueValues[upvalues[10]]
                                                    r2 = upvalueValues[upvalues[11]]
                                                    r7[state] = r2
                                                    state = upvalueValues[upvalues[12]]
                                                    r2 = {
                                                        state(r7)
                                                    }
                                                    ReturnVal = {
                                                        unpack(r2)
                                                    }
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure5 entry 6135299 -> 57, states 57-60
                                if state <= 58 then
                                    if state <= 57 then
                                        if state == 57 then -- entry 6135299 -> 57
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
                                            r7 = "l1"
                                            ReturnVal = _env[r7]
                                            r7 = "l1"
                                            _env[r7] = state
                                            r7 = "l2"
                                            _env[r7] = ReturnVal
                                            r7 = upvalueValues[upvalues[1]]
                                            r2 = r7()
                                            state = 58
                                        end
                                    else
                                        if state == 60 then
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                end
                            end
                        end
                    else
                        if state <= 74 then
                            if state <= 73 then
                                if state <= 66 then
                                    -- createClosure4 entry 8384903 -> 61, states 61-66
                                    if state <= 63 then
                                        if state <= 62 then
                                            if state <= 61 then
                                                if state == 61 then -- entry 8384903 -> 61
                                                    r7 = upvalueValues[upvalues[1]]
                                                    ReturnVal = #r7
                                                    r7 = 0
                                                    state = ReturnVal == r7
                                                    state = state and (62) or (63)
                                                end
                                            else
                                                if state == 62 then
                                                    r2 = upvalueValues[upvalues[2]]
                                                    r30 = 193
                                                    r7 = r2 * r30
                                                    r2 = 16106242710859
                                                    ReturnVal = r7 + r2
                                                    r7 = 35184372088832
                                                    state = ReturnVal % r7
                                                    upvalueValues[upvalues[2]] = state
                                                    r7 = upvalueValues[upvalues[3]]
                                                    r2 = 1
                                                    ReturnVal = r7 ~= r2
                                                    state = 64
                                                end
                                            end
                                        else
                                            if state == 63 then
                                                r30 = "table"
                                                r2 = _env[r30]
                                                r30 = "remove"
                                                r7 = r2[r30]
                                                r30 = upvalueValues[upvalues[1]]
                                                r2 = {
                                                    r7(r30)
                                                }
                                                ReturnVal = {
                                                    unpack(r2)
                                                }
                                                state = nil
                                            end
                                        end
                                    else
                                        if state <= 65 then
                                            if state <= 64 then
                                                if state == 64 then
                                                    r2 = upvalueValues[upvalues[3]]
                                                    r30 = 47
                                                    r7 = r2 * r30
                                                    r2 = 257
                                                    ReturnVal = r7 % r2
                                                    upvalueValues[upvalues[3]] = ReturnVal
                                                    state = 65
                                                end
                                            else
                                                if state == 65 then
                                                    r2 = upvalueValues[upvalues[3]]
                                                    r30 = 1
                                                    r7 = r2 ~= r30
                                                    state = r7 and (66) or (64)
                                                end
                                            end
                                        else
                                            if state == 66 then
                                                r2 = upvalueValues[upvalues[3]]
                                                r30 = 32
                                                r7 = r2 % r30
                                                r5 = 2
                                                r18 = upvalueValues[upvalues[4]]
                                                r11 = upvalueValues[upvalues[2]]
                                                r13 = upvalueValues[upvalues[3]]
                                                r16 = r13 - r7
                                                r13 = 32
                                                r15 = r16 / r13
                                                r3 = 13
                                                r17 = r3 - r15
                                                r4 = r5 ^ r17
                                                r32 = r11 / r4
                                                r1 = r18(r32)
                                                r18 = 4294967296
                                                r30 = r1 % r18
                                                r1 = 2
                                                r5 = 256
                                                r18 = r1 ^ r7
                                                r2 = r30 / r18
                                                r4 = 1
                                                r18 = upvalueValues[upvalues[4]]
                                                r11 = r2 % r4
                                                r4 = 4294967296
                                                r32 = r11 * r4
                                                r1 = r18(r32)
                                                r11 = 65536
                                                r18 = upvalueValues[upvalues[4]]
                                                r32 = r18(r2)
                                                r30 = r1 + r32
                                                r1 = 65536
                                                r18 = r30 % r1
                                                r3 = 256
                                                r7 = nil
                                                r32 = r30 - r18
                                                r30 = nil
                                                r1 = r32 / r11
                                                r2 = nil
                                                r11 = 256
                                                r32 = r18 % r11
                                                r4 = r18 - r32
                                                r11 = r4 / r5
                                                r5 = 256
                                                r4 = r1 % r5
                                                r18 = nil
                                                r17 = r1 - r4
                                                r1 = nil
                                                r5 = r17 / r3
                                                r17 = {
                                                    r32,
                                                    r11,
                                                    r4,
                                                    r5
                                                }
                                                r11 = nil
                                                r5 = nil
                                                upvalueValues[upvalues[1]] = r17
                                                r4 = nil
                                                r32 = nil
                                                state = 63
                                            end
                                        end
                                    end
                                else
                                    -- createClosure3 entry 4355307 -> 67, states 67-73
                                    if state <= 70 then
                                        if state <= 68 then
                                            if state <= 67 then
                                                if state == 67 then -- entry 4355307 -> 67
                                                    r2 = args[2]
                                                    state = upvalueValues[upvalues[1]]
                                                    r30 = state
                                                    state = r30[r2]
                                                    state = state and (68) or (69)
                                                    r7 = args[1]
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
                                                    r18 = ReturnVal
                                                    r1 = 35184372088832
                                                    ReturnVal = r2 % r1
                                                    upvalueValues[upvalues[4]] = ReturnVal
                                                    r11 = 255
                                                    r32 = r2 % r11
                                                    r11 = 2
                                                    r1 = r32 + r11
                                                    upvalueValues[upvalues[5]] = r1
                                                    r4 = "string"
                                                    r11 = _env[r4]
                                                    r4 = "len"
                                                    r32 = r11[r4]
                                                    r11 = r32(r7)
                                                    r17 = 1
                                                    r3 = r17
                                                    r32 = ""
                                                    r30[r2] = r32
                                                    r17 = 0
                                                    r15 = r3 < r17
                                                    r4 = 1
                                                    r17 = r4 - r3
                                                    r5 = r11
                                                    r32 = 15
                                                    state = 71
                                                end
                                            else
                                                if state == 70 then
                                                    ReturnVal = {
                                                        r2
                                                    }
                                                    state = nil
                                                end
                                            end
                                        end
                                    else
                                        if state <= 72 then
                                            if state <= 71 then
                                                if state == 71 then
                                                    r17 = r17 + r3
                                                    r16 = not r15
                                                    r4 = r17 <= r5
                                                    r4 = r16 and r4
                                                    r16 = r17 >= r5
                                                    r16 = r15 and r16
                                                    r4 = r16 or r4
                                                    r16 = (72)
                                                    state = r4 and r16
                                                    r4 = (73)
                                                    state = state or r4
                                                end
                                            else
                                                if state == 72 then
                                                    r4 = r17
                                                    r12 = "string"
                                                    r20 = _env[r12]
                                                    r12 = "byte"
                                                    r21 = r20[r12]
                                                    r20 = r21(r7, r4)
                                                    r21 = upvalueValues[upvalues[6]]
                                                    r12 = r21()
                                                    r6 = r20 + r12
                                                    r13 = r6 + r32
                                                    r4 = nil
                                                    r6 = 256
                                                    r16 = r13 % r6
                                                    r32 = r16
                                                    r6 = r30[r2]
                                                    r12 = 1
                                                    r20 = r32 + r12
                                                    r21 = r18[r20]
                                                    r13 = r6 .. r21
                                                    r30[r2] = r13
                                                    state = 71
                                                end
                                            end
                                        else
                                            if state == 73 then
                                                r18 = nil
                                                r32 = nil
                                                r11 = nil
                                                state = 70
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure entry 5129917 -> 74, states 74-74
                                if state == 74 then -- entry 5129917 -> 74
                                    ReturnVal = {}
                                    r7 = {
                                        select(1, unpack(args))
                                    }
                                    state = nil
                                end
                            end
                        else
                            if state <= 76 then
                                if state <= 75 then
                                    -- createClosure3 entry 16547041 -> 75, states 75-75
                                    if state == 75 then -- entry 16547041 -> 75
                                        ReturnVal = {}
                                        state = nil
                                    end
                                else
                                    -- createClosure0 entry 4757789 -> 76, states 76-76
                                    if state == 76 then -- entry 4757789 -> 76
                                        r7 = "os"
                                        ReturnVal = _env[r7]
                                        r2 = upvalueValues[upvalues[1]]
                                        r30 = upvalueValues[upvalues[2]]
                                        r1 = "f\166\228s\215"
                                        r32 = 3635372017308
                                        r18 = r30(r1, r32)
                                        r7 = r2[r18]
                                        state = ReturnVal[r7]
                                        ReturnVal = {
                                            state()
                                        }
                                        ReturnVal = {
                                            unpack(ReturnVal)
                                        }
                                        state = nil
                                    end
                                end
                            else
                                -- createClosure2 entry 5759819 -> 77, states 77-79
                                if state <= 78 then
                                    if state <= 77 then
                                        if state == 77 then -- entry 5759819 -> 77
                                            r7 = args[1]
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r2 = ReturnVal(r7)
                                            r30 = upvalueValues[upvalues[2]]
                                            r18 = upvalueValues[upvalues[3]]
                                            r11 = 8965690740814
                                            r32 = "Q\184rDV"
                                            r1 = r18(r32, r11)
                                            ReturnVal = r30[r1]
                                            state = r2 == ReturnVal
                                            state = state and (78) or (79)
                                        end
                                    else
                                        if state == 78 then
                                            ReturnVal = upvalueValues[upvalues[2]]
                                            r2 = upvalueValues[upvalues[3]]
                                            r1 = 15611675679845
                                            r18 = "`\160\228\235?\156\252"
                                            r30 = r2(r18, r1)
                                            state = ReturnVal[r30]
                                            ReturnVal = createClosure0(121, {
                                                upvalues[4],
                                                upvalues[2],
                                                upvalues[3]
                                            })
                                            r7[state] = ReturnVal
                                            ReturnVal = upvalueValues[upvalues[2]]
                                            r2 = upvalueValues[upvalues[3]]
                                            r1 = 1991871021983
                                            r18 = "\190D\"\199\149cs\194\029\191"
                                            r30 = r2(r18, r1)
                                            state = ReturnVal[r30]
                                            ReturnVal = createClosure2(125, {
                                                upvalues[4],
                                                upvalues[2],
                                                upvalues[3]
                                            })
                                            r7[state] = ReturnVal
                                            state = 79
                                        end
                                    end
                                else
                                    if state == 79 then
                                        r7 = nil
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            end
                        end
                    end
                else
                    if state <= 120 then
                        if state <= 98 then
                            if state <= 97 then
                                if state <= 88 then
                                    -- createClosure6 entry 14330115 -> 80, states 80-88
                                    if state <= 84 then
                                        if state <= 82 then
                                            if state <= 81 then
                                                if state <= 80 then
                                                    if state == 80 then -- entry 14330115 -> 80
                                                        r7 = allocUpvalue()
                                                        upvalueValues[r7] = args[1]
                                                        ReturnVal = "getmetatable"
                                                        state = _env[ReturnVal]
                                                        r2 = upvalueValues[r7]
                                                        ReturnVal = state(r2)
                                                        r2 = allocUpvalue()
                                                        upvalueValues[r2] = ReturnVal
                                                        r30 = upvalueValues[r2]
                                                        state = r30 and (81) or (82)
                                                        ReturnVal = r30
                                                    end
                                                else
                                                    if state == 81 then
                                                        r18 = upvalueValues[upvalues[1]]
                                                        r32 = upvalueValues[r2]
                                                        r1 = r18(r32)
                                                        r32 = upvalueValues[upvalues[2]]
                                                        r11 = upvalueValues[upvalues[3]]
                                                        r5 = "\146>{\144\243"
                                                        r17 = 12302297192032
                                                        r4 = r11(r5, r17)
                                                        r18 = r32[r4]
                                                        r30 = r1 == r18
                                                        ReturnVal = r30
                                                        state = 82
                                                    end
                                                end
                                            else
                                                if state == 82 then
                                                    state = ReturnVal and (83) or (84)
                                                end
                                            end
                                        else
                                            if state <= 83 then
                                                if state == 83 then
                                                    state = upvalueValues[upvalues[4]]
                                                    r30 = upvalueValues[r2]
                                                    ReturnVal = state(r30)
                                                    r18 = "debug"
                                                    r30 = _env[r18]
                                                    state = r30 and (85) or (86)
                                                    ReturnVal = r30
                                                end
                                            else
                                                if state == 84 then
                                                    r7 = releaseUpvalue(r7)
                                                    r2 = releaseUpvalue(r2)
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        end
                                    else
                                        if state <= 86 then
                                            if state <= 85 then
                                                if state == 85 then
                                                    r1 = "debug"
                                                    r18 = _env[r1]
                                                    r32 = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r17 = 25179171057100
                                                    r5 = "\202\1688]tD\2467\153@\252\202"
                                                    r4 = r11(r5, r17)
                                                    r1 = r32[r4]
                                                    r30 = r18[r1]
                                                    ReturnVal = r30
                                                    state = 86
                                                end
                                            else
                                                if state == 86 then
                                                    state = ReturnVal and (87) or (88)
                                                end
                                            end
                                        else
                                            if state <= 87 then
                                                if state == 87 then
                                                    r30 = createClosure1(129, {
                                                        upvalues[2],
                                                        upvalues[3],
                                                        r7,
                                                        r2
                                                    })
                                                    ReturnVal = "pcall"
                                                    state = _env[ReturnVal]
                                                    ReturnVal = state(r30)
                                                    state = 88
                                                end
                                            else
                                                if state == 88 then
                                                    state = 84
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure2 entry 580695 -> 89, states 89-97
                                    if state <= 93 then
                                        if state <= 91 then
                                            if state <= 90 then
                                                if state <= 89 then
                                                    if state == 89 then -- entry 580695 -> 89
                                                        r2 = "debug"
                                                        r7 = _env[r2]
                                                        state = r7 and (90) or (91)
                                                        ReturnVal = r7
                                                    end
                                                else
                                                    if state == 90 then
                                                        r30 = "debug"
                                                        r2 = _env[r30]
                                                        r18 = upvalueValues[upvalues[1]]
                                                        r1 = upvalueValues[upvalues[2]]
                                                        r4 = 30962449479762
                                                        r11 = "\205\223\195\180\004\250\240"
                                                        r32 = r1(r11, r4)
                                                        r30 = r18[r32]
                                                        r7 = r2[r30]
                                                        ReturnVal = r7
                                                        state = 91
                                                    end
                                                end
                                            else
                                                if state == 91 then
                                                    r7 = allocUpvalue()
                                                    upvalueValues[r7] = ReturnVal
                                                    state = upvalueValues[r7]
                                                    state = state and (92) or (93)
                                                end
                                            end
                                        else
                                            if state <= 92 then
                                                if state == 92 then
                                                    ReturnVal = "debug"
                                                    state = _env[ReturnVal]
                                                    r2 = upvalueValues[upvalues[1]]
                                                    r30 = upvalueValues[upvalues[2]]
                                                    r1 = "\0149$}y!s"
                                                    r32 = 12890481186674
                                                    r18 = r30(r1, r32)
                                                    ReturnVal = r2[r18]
                                                    r2 = createClosure(130, {
                                                        r7,
                                                        upvalues[1],
                                                        upvalues[2],
                                                        upvalues[3]
                                                    })
                                                    state[ReturnVal] = r2
                                                    state = 93
                                                end
                                            else
                                                if state == 93 then
                                                    r30 = "debug"
                                                    r2 = _env[r30]
                                                    state = r2 and (94) or (95)
                                                    ReturnVal = r2
                                                end
                                            end
                                        end
                                    else
                                        if state <= 95 then
                                            if state <= 94 then
                                                if state == 94 then
                                                    r18 = "debug"
                                                    r30 = _env[r18]
                                                    r1 = upvalueValues[upvalues[1]]
                                                    r32 = upvalueValues[upvalues[2]]
                                                    r4 = "Ru\025\158\216\127o"
                                                    r5 = 30894200272946
                                                    r11 = r32(r4, r5)
                                                    r18 = r1[r11]
                                                    r2 = r30[r18]
                                                    ReturnVal = r2
                                                    state = 95
                                                end
                                            else
                                                if state == 95 then
                                                    state = ReturnVal and (96) or (97)
                                                end
                                            end
                                        else
                                            if state <= 96 then
                                                if state == 96 then
                                                    ReturnVal = "debug"
                                                    state = _env[ReturnVal]
                                                    r2 = upvalueValues[upvalues[1]]
                                                    r30 = upvalueValues[upvalues[2]]
                                                    r32 = 30644998797246
                                                    r1 = "\152\184%\165\128\020\028"
                                                    r18 = r30(r1, r32)
                                                    ReturnVal = r2[r18]
                                                    r2 = createClosure3(140, {
                                                        upvalues[1],
                                                        upvalues[2],
                                                        upvalues[3]
                                                    })
                                                    state[ReturnVal] = r2
                                                    state = 97
                                                end
                                            else
                                                if state == 97 then
                                                    r7 = releaseUpvalue(r7)
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure6 entry 5201411 -> 98, states 98-98
                                if state == 98 then -- entry 5201411 -> 98
                                    r7 = args[1]
                                    r2 = upvalueValues[upvalues[1]]
                                    r30 = upvalueValues[upvalues[2]]
                                    r32 = 25679253401269
                                    r1 = "3"
                                    r18 = r30(r1, r32)
                                    ReturnVal = r2[r18]
                                    r2 = createClosure3(148, {
                                        upvalues[1],
                                        upvalues[2]
                                    })
                                    r30 = "gsub"
                                    r30 = r7[r30]
                                    state = {
                                        r30(r7, ReturnVal, r2)
                                    }
                                    ReturnVal = {
                                        unpack(state)
                                    }
                                    state = nil
                                end
                            end
                        else
                            if state <= 119 then
                                if state <= 99 then
                                    -- createClosure1 entry 7220767 -> 99, states 99-99
                                    if state == 99 then -- entry 7220767 -> 99
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r7 = upvalueValues[upvalues[2]]
                                        r18 = 26705908904083
                                        r30 = "\144b:"
                                        r2 = r7(r30, r18)
                                        state = ReturnVal[r2]
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure5 entry 3485664 -> 100, states 100-119
                                    if state <= 109 then
                                        if state <= 104 then
                                            if state <= 102 then
                                                if state <= 101 then
                                                    if state <= 100 then
                                                        if state == 100 then -- entry 3485664 -> 100
                                                            state = 101
                                                        end
                                                    else
                                                        if state == 101 then
                                                            state = true
                                                            state = state and (102) or (103)
                                                        end
                                                    end
                                                else
                                                    if state == 102 then
                                                        state = upvalueValues[upvalues[1]]
                                                        r7 = 10
                                                        ReturnVal = state(r7)
                                                        r7 = "_G"
                                                        ReturnVal = _env[r7]
                                                        r7 = upvalueValues[upvalues[2]]
                                                        state = ReturnVal ~= r7
                                                        state = state and (104) or (105)
                                                    end
                                                end
                                            else
                                                if state <= 103 then
                                                    if state == 103 then
                                                        ReturnVal = {}
                                                        state = nil
                                                    end
                                                else
                                                    if state == 104 then
                                                        state = upvalueValues[upvalues[3]]
                                                        r2 = upvalueValues[upvalues[4]]
                                                        r30 = upvalueValues[upvalues[5]]
                                                        r1 = "\246p\195\168_\2121X\012\220\024\004N\204\128t\204~\147\164r\151\161q"
                                                        r32 = 3509812053602
                                                        r18 = r30(r1, r32)
                                                        r7 = r2[r18]
                                                        ReturnVal = state(r7)
                                                        state = 106
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 107 then
                                                if state <= 106 then
                                                    if state <= 105 then
                                                        if state == 105 then
                                                            r30 = "print"
                                                            r2 = _env[r30]
                                                            r30 = upvalueValues[upvalues[6]]
                                                            r7 = r2 ~= r30
                                                            state = r7 and (107) or (108)
                                                            ReturnVal = r7
                                                        end
                                                    else
                                                        if state == 106 then
                                                            state = true
                                                            state = state and (109) or (110)
                                                        end
                                                    end
                                                else
                                                    if state == 107 then
                                                        state = ReturnVal and (111) or (112)
                                                    end
                                                end
                                            else
                                                if state <= 108 then
                                                    if state == 108 then
                                                        r1 = "wait"
                                                        r18 = _env[r1]
                                                        r1 = upvalueValues[upvalues[1]]
                                                        r30 = r18 ~= r1
                                                        r2 = state
                                                        state = r30 and (113) or (114)
                                                        r7 = r30
                                                    end
                                                else
                                                    if state == 109 then
                                                        state = 106
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 114 then
                                            if state <= 112 then
                                                if state <= 111 then
                                                    if state <= 110 then
                                                        if state == 110 then
                                                            state = 105
                                                        end
                                                    else
                                                        if state == 111 then
                                                            state = upvalueValues[upvalues[3]]
                                                            r2 = upvalueValues[upvalues[4]]
                                                            r30 = upvalueValues[upvalues[5]]
                                                            r1 = "\023\235\244\021\248G\211\189%|)/;\255\182\169\202\128\004\226\129ZU\213\166\136\196W<E*\182\n"
                                                            r32 = 11734920992088
                                                            r18 = r30(r1, r32)
                                                            r7 = r2[r18]
                                                            ReturnVal = state(r7)
                                                            state = 115
                                                        end
                                                    end
                                                else
                                                    if state == 112 then
                                                        state = 101
                                                    end
                                                end
                                            else
                                                if state <= 113 then
                                                    if state == 113 then
                                                        state = r2
                                                        ReturnVal = r7
                                                        state = 107
                                                    end
                                                else
                                                    if state == 114 then
                                                        r11 = "tick"
                                                        r32 = _env[r11]
                                                        r11 = upvalueValues[upvalues[7]]
                                                        r1 = r32 ~= r11
                                                        r18 = state
                                                        state = r1 and (116) or (117)
                                                        r30 = r1
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 117 then
                                                if state <= 116 then
                                                    if state <= 115 then
                                                        if state == 115 then
                                                            state = true
                                                            state = state and (118) or (119)
                                                        end
                                                    else
                                                        if state == 116 then
                                                            state = r18
                                                            r7 = r30
                                                            state = 113
                                                        end
                                                    end
                                                else
                                                    if state == 117 then
                                                        r11 = "type"
                                                        r32 = _env[r11]
                                                        r11 = upvalueValues[upvalues[8]]
                                                        r1 = r32 ~= r11
                                                        r30 = r1
                                                        state = 116
                                                    end
                                                end
                                            else
                                                if state <= 118 then
                                                    if state == 118 then
                                                        state = 115
                                                    end
                                                else
                                                    if state == 119 then
                                                        state = 112
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure3 entry 13432306 -> 120, states 120-120
                                if state == 120 then -- entry 13432306 -> 120
                                    r30 = 6357508
                                    r2 = "nJsojrgSpV0vuFq"
                                    r7 = r2 ^ r30
                                    ReturnVal = 14674454
                                    state = ReturnVal - r7
                                    r7 = state
                                    ReturnVal = "JqCfYO"
                                    state = ReturnVal / r7
                                    ReturnVal = {
                                        state
                                    }
                                    state = nil
                                end
                            end
                        end
                    else
                        if state <= 129 then
                            if state <= 128 then
                                if state <= 124 then
                                    -- createClosure0 entry 754519 -> 121, states 121-124
                                    if state <= 122 then
                                        if state <= 121 then
                                            if state == 121 then -- entry 754519 -> 121
                                                state = upvalueValues[upvalues[1]]
                                                r2 = upvalueValues[upvalues[2]]
                                                r30 = upvalueValues[upvalues[3]]
                                                r32 = 33674419305792
                                                r1 = "|r{\211\148#\136\217\226\140\133\133I\1413\017\162\253q\159?\019\021\143vn\207pt"
                                                r18 = r30(r1, r32)
                                                r7 = r2[r18]
                                                ReturnVal = state(r7)
                                                state = 122
                                            end
                                        else
                                            if state == 122 then
                                                state = true
                                                state = state and (123) or (124)
                                            end
                                        end
                                    else
                                        if state <= 123 then
                                            if state == 123 then
                                                state = 122
                                            end
                                        else
                                            if state == 124 then
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    -- createClosure2 entry 11328165 -> 125, states 125-128
                                    if state <= 126 then
                                        if state <= 125 then
                                            if state == 125 then -- entry 11328165 -> 125
                                                state = upvalueValues[upvalues[1]]
                                                r2 = upvalueValues[upvalues[2]]
                                                r30 = upvalueValues[upvalues[3]]
                                                r32 = 1041414210020
                                                r1 = "\135\227\146\217Y]XW\025\166A\179\248\164\026\185\028H\n\018\190#_<\151\174V\173X"
                                                r18 = r30(r1, r32)
                                                r7 = r2[r18]
                                                ReturnVal = state(r7)
                                                state = 126
                                            end
                                        else
                                            if state == 126 then
                                                state = true
                                                state = state and (127) or (128)
                                            end
                                        end
                                    else
                                        if state <= 127 then
                                            if state == 127 then
                                                state = 126
                                            end
                                        else
                                            if state == 128 then
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure1 entry 12136690 -> 129, states 129-129
                                if state == 129 then -- entry 12136690 -> 129
                                    r7 = "debug"
                                    ReturnVal = _env[r7]
                                    r2 = upvalueValues[upvalues[1]]
                                    r30 = upvalueValues[upvalues[2]]
                                    r32 = 30116372395720
                                    r1 = "!\191\218>\165\242\180n7\024\192\209"
                                    r18 = r30(r1, r32)
                                    r7 = r2[r18]
                                    state = ReturnVal[r7]
                                    r7 = upvalueValues[upvalues[3]]
                                    r2 = upvalueValues[upvalues[4]]
                                    ReturnVal = state(r7, r2)
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        else
                            if state <= 147 then
                                if state <= 139 then
                                    -- createClosure entry 4204721 -> 130, states 130-139
                                    if state <= 134 then
                                        if state <= 132 then
                                            if state <= 131 then
                                                if state <= 130 then
                                                    if state == 130 then -- entry 4204721 -> 130
                                                        state = upvalueValues[upvalues[1]]
                                                        r7 = {
                                                            select(1, unpack(args))
                                                        }
                                                        ReturnVal = state(unpack(r7))
                                                        r2 = ReturnVal
                                                        state = r2 and (131) or (132)
                                                        ReturnVal = r2
                                                    end
                                                else
                                                    if state == 131 then
                                                        r11 = upvalueValues[upvalues[2]]
                                                        r4 = upvalueValues[upvalues[3]]
                                                        r17 = "\"\214\184\139\252\249"
                                                        r3 = 28140717470512
                                                        r5 = r4(r17, r3)
                                                        r32 = r11[r5]
                                                        r1 = r2[r32]
                                                        r4 = upvalueValues[upvalues[2]]
                                                        r5 = upvalueValues[upvalues[3]]
                                                        r15 = 26575687397463
                                                        r3 = "\158\163\132\161"
                                                        r17 = r5(r3, r15)
                                                        r11 = r4[r17]
                                                        r32 = "find"
                                                        r32 = r1[r32]
                                                        r32 = r32(r1, r11)
                                                        r18 = state
                                                        state = r32 and (133) or (134)
                                                        r30 = r32
                                                    end
                                                end
                                            else
                                                if state == 132 then
                                                    state = ReturnVal and (135) or (136)
                                                end
                                            end
                                        else
                                            if state <= 133 then
                                                if state == 133 then
                                                    state = r18
                                                    ReturnVal = r30
                                                    state = 132
                                                end
                                            else
                                                if state == 134 then
                                                    r4 = upvalueValues[upvalues[2]]
                                                    r5 = upvalueValues[upvalues[3]]
                                                    r3 = "\132q\128\180"
                                                    r15 = 21066332743249
                                                    r17 = r5(r3, r15)
                                                    r11 = r4[r17]
                                                    r32 = r2[r11]
                                                    r4 = upvalueValues[upvalues[2]]
                                                    r5 = upvalueValues[upvalues[3]]
                                                    r3 = "H\t\216"
                                                    r15 = 23584889678566
                                                    r17 = r5(r3, r15)
                                                    r11 = r4[r17]
                                                    r1 = r32 ~= r11
                                                    r30 = r1
                                                    state = 133
                                                end
                                            end
                                        end
                                    else
                                        if state <= 137 then
                                            if state <= 136 then
                                                if state <= 135 then
                                                    if state == 135 then
                                                        state = upvalueValues[upvalues[4]]
                                                        r18 = upvalueValues[upvalues[2]]
                                                        r1 = upvalueValues[upvalues[3]]
                                                        r11 = "\r\224u\154\193\141.\195o4\219\194\223\243\007\252\194\016\209D"
                                                        r4 = 5589493385770
                                                        r32 = r1(r11, r4)
                                                        r30 = r18[r32]
                                                        ReturnVal = state(r30)
                                                        state = 137
                                                    end
                                                else
                                                    if state == 136 then
                                                        ReturnVal = {
                                                            r2
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            else
                                                if state == 137 then
                                                    state = true
                                                    state = state and (138) or (139)
                                                end
                                            end
                                        else
                                            if state <= 138 then
                                                if state == 138 then
                                                    state = 137
                                                end
                                            else
                                                if state == 139 then
                                                    state = 136
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure3 entry 10399655 -> 140, states 140-147
                                    if state <= 143 then
                                        if state <= 141 then
                                            if state <= 140 then
                                                if state == 140 then -- entry 10399655 -> 140
                                                    r18 = upvalueValues[upvalues[1]]
                                                    r7 = args[1]
                                                    r1 = upvalueValues[upvalues[2]]
                                                    r4 = 19714899829724
                                                    r11 = "\211\019B2"
                                                    r32 = r1(r11, r4)
                                                    r30 = r18[r32]
                                                    r2 = r7 == r30
                                                    state = r2 and (141) or (142)
                                                    ReturnVal = r2
                                                end
                                            else
                                                if state == 141 then
                                                    state = ReturnVal and (143) or (144)
                                                end
                                            end
                                        else
                                            if state <= 142 then
                                                if state == 142 then
                                                    r18 = upvalueValues[upvalues[1]]
                                                    r1 = upvalueValues[upvalues[2]]
                                                    r4 = 4848677882065
                                                    r11 = "lH\023\202_\156"
                                                    r32 = r1(r11, r4)
                                                    r30 = r18[r32]
                                                    r2 = r7 == r30
                                                    ReturnVal = r2
                                                    state = 141
                                                end
                                            else
                                                if state == 143 then
                                                    state = upvalueValues[upvalues[3]]
                                                    r30 = upvalueValues[upvalues[1]]
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r32 = "\015*\143W\221m\251\130:tjM\187\028\224\131\015y}TI\017\202V\025\219\140\200"
                                                    r11 = 28441617396668
                                                    r1 = r18(r32, r11)
                                                    r2 = r30[r1]
                                                    ReturnVal = state(r2)
                                                    state = 145
                                                end
                                            end
                                        end
                                    else
                                        if state <= 145 then
                                            if state <= 144 then
                                                if state == 144 then
                                                    r7 = nil
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            else
                                                if state == 145 then
                                                    state = true
                                                    state = state and (146) or (147)
                                                end
                                            end
                                        else
                                            if state <= 146 then
                                                if state == 146 then
                                                    state = 145
                                                end
                                            else
                                                if state == 147 then
                                                    state = 144
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure3 entry 13001043 -> 148, states 148-148
                                if state == 148 then -- entry 13001043 -> 148
                                    r2 = "string"
                                    ReturnVal = _env[r2]
                                    r30 = upvalueValues[upvalues[1]]
                                    r7 = args[1]
                                    r18 = upvalueValues[upvalues[2]]
                                    r32 = "\140s\2332"
                                    r11 = 20514257347920
                                    r1 = r18(r32, r11)
                                    r2 = r30[r1]
                                    r18 = "byte"
                                    r18 = r7[r18]
                                    state = ReturnVal[r2]
                                    r18 = r18(r7)
                                    r1 = 65
                                    r30 = r18 - r1
                                    r18 = 256
                                    r2 = r30 % r18
                                    ReturnVal = {
                                        state(r2)
                                    }
                                    ReturnVal = {
                                        unpack(ReturnVal)
                                    }
                                    state = nil
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
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)