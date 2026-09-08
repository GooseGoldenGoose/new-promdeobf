return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, createClosure5, vm, createClosure, createClosure4, createClosure0, upvalueRefCounts, createUpvalueProxy, upvalueValues, createClosure2, allocUpvalue, releaseUpvalue, currentUpvalueId, createClosure3, releaseUpvalues)
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
        upvalueRefCounts = {}
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = upvalueRefCounts[captures[captureIndex]] + (1)
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return 133395
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 133395
                    end
                })
            end
        end
        allocUpvalue = function()
            currentUpvalueId = currentUpvalueId + (1)
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, ReturnVal, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33
            while state do
                if state <= 50 then
                    if state <= 37 then
                        if state <= 36 then
                            if state <= 35 then
                                -- root entry 6802786 -> 1, states 1-35
                                if state <= 18 then
                                    if state <= 9 then
                                        if state <= 5 then
                                            if state <= 3 then
                                                if state <= 2 then
                                                    if state <= 1 then
                                                        if state == 1 then -- entry 6802786 -> 1
                                                            r16 = allocUpvalue()
                                                            state = true
                                                            upvalueValues[r16] = state
                                                            r15 = "string"
                                                            ReturnVal = _env[r15]
                                                            r15 = "gmatch"
                                                            state = ReturnVal[r15]
                                                            r15 = allocUpvalue()
                                                            upvalueValues[r15] = state
                                                            r28 = allocUpvalue()
                                                            state = createClosure2(36, {})
                                                            upvalueValues[r28] = state
                                                            r24 = allocUpvalue()
                                                            state = false
                                                            upvalueValues[r24] = state
                                                            r26 = "pcall"
                                                            r10 = _env[r26]
                                                            r23 = createClosure0(37, {
                                                                r24
                                                            })
                                                            r26 = r10(r23)
                                                            state = r26 and (2) or (3)
                                                            r30 = args
                                                            ReturnVal = r26
                                                        end
                                                    else
                                                        if state == 2 then
                                                            r10 = upvalueValues[r24]
                                                            ReturnVal = r10
                                                            state = 3
                                                        end
                                                    end
                                                else
                                                    if state == 3 then
                                                        r10 = ReturnVal
                                                        r26 = "math"
                                                        ReturnVal = _env[r26]
                                                        r26 = "random"
                                                        state = ReturnVal[r26]
                                                        r26 = allocUpvalue()
                                                        upvalueValues[r26] = state
                                                        r23 = "table"
                                                        ReturnVal = _env[r23]
                                                        r23 = "concat"
                                                        state = ReturnVal[r23]
                                                        r21 = state
                                                        r23 = state
                                                        r4 = "table"
                                                        r18 = _env[r4]
                                                        state = r18 and (4) or (5)
                                                        r1 = r18
                                                    end
                                                end
                                            else
                                                if state <= 4 then
                                                    if state == 4 then
                                                        r32 = "table"
                                                        r4 = _env[r32]
                                                        r32 = "unpack"
                                                        r18 = r4[r32]
                                                        r1 = r18
                                                        state = 5
                                                    end
                                                else
                                                    if state == 5 then
                                                        state = r21
                                                        state = r1 and (6) or (7)
                                                        ReturnVal = r1
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 7 then
                                                if state <= 6 then
                                                    if state == 6 then
                                                        r1 = allocUpvalue()
                                                        upvalueValues[r1] = ReturnVal
                                                        state = upvalueValues[r26]
                                                        r18 = 65
                                                        r21 = 3
                                                        ReturnVal = state(r21, r18)
                                                        state = 0
                                                        r21 = allocUpvalue()
                                                        upvalueValues[r21] = ReturnVal
                                                        r18 = state
                                                        r32 = "pcall"
                                                        ReturnVal = _env[r32]
                                                        state = 0
                                                        r7 = createClosure5(38, {})
                                                        r32 = {
                                                            ReturnVal(r7)
                                                        }
                                                        r4 = state
                                                        state = {
                                                            unpack(r32)
                                                        }
                                                        r32 = state
                                                        ReturnVal = 2
                                                        state = r32[ReturnVal]
                                                        r7 = state
                                                        ReturnVal = "tonumber"
                                                        state = _env[ReturnVal]
                                                        r19 = upvalueValues[r15]
                                                        r22 = "tostring"
                                                        r27 = _env[r22]
                                                        r22 = r27(r7)
                                                        r27 = ":(%d*):"
                                                        r12 = r19(r22, r27)
                                                        r19 = {
                                                            r12()
                                                        }
                                                        ReturnVal = state(unpack(r19))
                                                        r19 = allocUpvalue()
                                                        upvalueValues[r19] = ReturnVal
                                                        r12 = upvalueValues[r21]
                                                        r27 = r12
                                                        r12 = 1
                                                        r22 = r12
                                                        r12 = 0
                                                        r2 = r22 < r12
                                                        ReturnVal = 1
                                                        r12 = ReturnVal - r22
                                                        state = 8
                                                    end
                                                else
                                                    if state == 7 then
                                                        r21 = "unpack"
                                                        r1 = _env[r21]
                                                        ReturnVal = r1
                                                        state = 6
                                                    end
                                                end
                                            else
                                                if state <= 8 then
                                                    if state == 8 then
                                                        r6 = not r2
                                                        r12 = r12 + r22
                                                        ReturnVal = r12 <= r27
                                                        ReturnVal = r6 and ReturnVal
                                                        r6 = r12 >= r27
                                                        r6 = r2 and r6
                                                        ReturnVal = r6 or ReturnVal
                                                        r6 = (9)
                                                        state = ReturnVal and r6
                                                        ReturnVal = (10)
                                                        state = state or ReturnVal
                                                    end
                                                else
                                                    if state == 9 then
                                                        r6 = allocUpvalue()
                                                        upvalueValues[r6] = r12
                                                        r3 = "math"
                                                        ReturnVal = _env[r3]
                                                        r3 = "random"
                                                        state = ReturnVal[r3]
                                                        r3 = 1
                                                        r25 = 100
                                                        ReturnVal = state(r3, r25)
                                                        r3 = allocUpvalue()
                                                        upvalueValues[r3] = ReturnVal
                                                        state = upvalueValues[r26]
                                                        r9 = 255
                                                        r25 = 0
                                                        ReturnVal = state(r25, r9)
                                                        r25 = allocUpvalue()
                                                        upvalueValues[r25] = ReturnVal
                                                        state = upvalueValues[r26]
                                                        r33 = upvalueValues[r3]
                                                        r9 = 1
                                                        ReturnVal = state(r9, r33)
                                                        r9 = allocUpvalue()
                                                        upvalueValues[r9] = ReturnVal
                                                        ReturnVal = upvalueValues[r26]
                                                        r11 = 1
                                                        r14 = 2
                                                        r33 = ReturnVal(r11, r14)
                                                        ReturnVal = 1
                                                        state = r33 == ReturnVal
                                                        r33 = allocUpvalue()
                                                        upvalueValues[r33] = state
                                                        r29 = "tostring"
                                                        r31 = _env[r29]
                                                        r20 = upvalueValues[r26]
                                                        r5 = 10000
                                                        r13 = 0
                                                        r17 = {
                                                            r20(r13, r5)
                                                        }
                                                        r29 = r31(unpack(r17))
                                                        state = "gsub"
                                                        state = r7[state]
                                                        r31 = ":"
                                                        r8 = r29 .. r31
                                                        r14 = ":"
                                                        r11 = r14 .. r8
                                                        ReturnVal = ":(%d*):"
                                                        state = state(r7, ReturnVal, r11)
                                                        r11 = allocUpvalue()
                                                        upvalueValues[r11] = state
                                                        r8 = createClosure4(39, {
                                                            r26,
                                                            r6,
                                                            r21,
                                                            r15,
                                                            r16,
                                                            r19,
                                                            r33,
                                                            r11,
                                                            r3,
                                                            r9,
                                                            r25,
                                                            r1
                                                        })
                                                        r14 = "pcall"
                                                        ReturnVal = _env[r14]
                                                        r14 = {
                                                            ReturnVal(r8)
                                                        }
                                                        state = {
                                                            unpack(r14)
                                                        }
                                                        r14 = state
                                                        state = upvalueValues[r33]
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
                                                            r27 = upvalueValues[r16]
                                                            state = r27 and (13) or (14)
                                                            r12 = r27
                                                        end
                                                    else
                                                        if state == 11 then
                                                            r8 = upvalueValues[r16]
                                                            state = r8 and (15) or (16)
                                                            ReturnVal = r8
                                                        end
                                                    end
                                                else
                                                    if state == 12 then
                                                        r31 = upvalueValues[r16]
                                                        state = r31 and (17) or (18)
                                                        r8 = r31
                                                    end
                                                end
                                            else
                                                if state <= 13 then
                                                    if state == 13 then
                                                        r27 = r18 == r4
                                                        r12 = r27
                                                        state = 14
                                                    end
                                                else
                                                    if state == 14 then
                                                        upvalueValues[r16] = r12
                                                        state = upvalueValues[r16]
                                                        state = state and (19) or (20)
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 16 then
                                                if state <= 15 then
                                                    if state == 15 then
                                                        r31 = state
                                                        r17 = 1
                                                        r20 = r14[r17]
                                                        r17 = false
                                                        r29 = r20 == r17
                                                        state = r29 and (21) or (22)
                                                        r8 = r29
                                                    end
                                                else
                                                    if state == 16 then
                                                        upvalueValues[r16] = ReturnVal
                                                        state = 23
                                                    end
                                                end
                                            else
                                                if state <= 17 then
                                                    if state == 17 then
                                                        r29 = 1
                                                        r31 = r14[r29]
                                                        r8 = r31
                                                        state = 18
                                                    end
                                                else
                                                    if state == 18 then
                                                        upvalueValues[r16] = r8
                                                        r17 = upvalueValues[r9]
                                                        r13 = 1
                                                        r20 = r17 + r13
                                                        r29 = r14[r20]
                                                        r31 = r18 + r29
                                                        r29 = 256
                                                        state = r31 % r29
                                                        r18 = state
                                                        r20 = upvalueValues[r25]
                                                        r29 = r4 + r20
                                                        r20 = 256
                                                        r31 = r29 % r20
                                                        r4 = r31
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
                                                        r17 = 2
                                                        r20 = r14[r17]
                                                        r17 = upvalueValues[r11]
                                                        r29 = r20 == r17
                                                        r8 = r29
                                                        state = 22
                                                    end
                                                end
                                            else
                                                if state <= 22 then
                                                    if state == 22 then
                                                        state = r31
                                                        ReturnVal = r8
                                                        state = 16
                                                    end
                                                else
                                                    if state == 23 then
                                                        r25 = releaseUpvalue(r25)
                                                        r33 = releaseUpvalue(r33)
                                                        r9 = releaseUpvalue(r9)
                                                        r11 = releaseUpvalue(r11)
                                                        r3 = releaseUpvalue(r3)
                                                        r6 = releaseUpvalue(r6)
                                                        r14 = nil
                                                        state = 8
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 25 then
                                                if state <= 24 then
                                                    if state == 24 then
                                                        r16 = releaseUpvalue(r16)
                                                        r24 = releaseUpvalue(r24)
                                                        r15 = releaseUpvalue(r15)
                                                        r19 = releaseUpvalue(r19)
                                                        r21 = releaseUpvalue(r21)
                                                        r1 = releaseUpvalue(r1)
                                                        r28 = releaseUpvalue(r28)
                                                        r26 = releaseUpvalue(r26)
                                                        r28 = allocUpvalue()
                                                        r16 = nil
                                                        upvalueValues[r28] = r16
                                                        r16 = allocUpvalue()
                                                        r15 = nil
                                                        upvalueValues[r16] = r15
                                                        r21 = allocUpvalue()
                                                        r18 = nil
                                                        r18 = {}
                                                        r10 = nil
                                                        r10 = "math"
                                                        r24 = _env[r10]
                                                        r4 = nil
                                                        r4 = allocUpvalue()
                                                        r10 = "floor"
                                                        r15 = r24[r10]
                                                        r24 = allocUpvalue()
                                                        upvalueValues[r24] = r15
                                                        r26 = "math"
                                                        r10 = _env[r26]
                                                        r26 = "random"
                                                        r15 = r10[r26]
                                                        r23 = nil
                                                        r23 = "table"
                                                        r26 = _env[r23]
                                                        r23 = "remove"
                                                        r10 = r26[r23]
                                                        r1 = "string"
                                                        r23 = _env[r1]
                                                        r19 = 256
                                                        r1 = "char"
                                                        r26 = r23[r1]
                                                        r1 = allocUpvalue()
                                                        r23 = 0
                                                        upvalueValues[r1] = r23
                                                        r23 = 2
                                                        upvalueValues[r21] = r23
                                                        r32 = nil
                                                        r32 = {}
                                                        upvalueValues[r4] = r18
                                                        r2 = r19
                                                        r19 = 1
                                                        r6 = r19
                                                        r23 = {}
                                                        r19 = 0
                                                        r3 = r6 < r19
                                                        r7 = nil
                                                        r7 = 1
                                                        r19 = r7 - r6
                                                        r18 = 0
                                                        state = 26
                                                    end
                                                else
                                                    if state == 25 then
                                                        state = createClosure5(51, {
                                                            r28
                                                        })
                                                        r27 = {
                                                            state()
                                                        }
                                                        ReturnVal = {
                                                            unpack(r27)
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            else
                                                if state <= 26 then
                                                    if state == 26 then
                                                        r25 = not r3
                                                        r19 = r19 + r6
                                                        r7 = r19 <= r2
                                                        r7 = r25 and r7
                                                        r25 = r19 >= r2
                                                        r25 = r3 and r25
                                                        r7 = r25 or r7
                                                        r25 = (27)
                                                        state = r7 and r25
                                                        r7 = (28)
                                                        state = state or r7
                                                    end
                                                else
                                                    if state == 27 then
                                                        r7 = r19
                                                        r25 = r7
                                                        r32[r7] = r25
                                                        r7 = nil
                                                        state = 26
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 31 then
                                            if state <= 29 then
                                                if state <= 28 then
                                                    if state == 28 then
                                                        r19 = #r32
                                                        r2 = 0
                                                        r7 = r19 == r2
                                                        state = 29
                                                    end
                                                else
                                                    if state == 29 then
                                                        r2 = #r32
                                                        r19 = 1
                                                        r7 = r15(r19, r2)
                                                        r19 = r10(r32, r7)
                                                        r2 = upvalueValues[r4]
                                                        r25 = 1
                                                        r3 = r19 - r25
                                                        r6 = r26(r3)
                                                        r7 = nil
                                                        r2[r19] = r6
                                                        r19 = nil
                                                        state = 30
                                                    end
                                                end
                                            else
                                                if state <= 30 then
                                                    if state == 30 then
                                                        r19 = #r32
                                                        r2 = 0
                                                        r7 = r19 == r2
                                                        state = r7 and (31) or (29)
                                                    end
                                                else
                                                    if state == 31 then
                                                        r14 = "__metatable"
                                                        r19 = allocUpvalue()
                                                        r7 = {}
                                                        r2 = createClosure5(55, {
                                                            r19,
                                                            r1,
                                                            r21,
                                                            r24
                                                        })
                                                        r3 = "setmetatable"
                                                        r24 = releaseUpvalue(r24)
                                                        r18 = nil
                                                        upvalueValues[r19] = r7
                                                        r7 = allocUpvalue()
                                                        r25 = {}
                                                        r6 = allocUpvalue()
                                                        upvalueValues[r7] = r2
                                                        r2 = {}
                                                        upvalueValues[r6] = r2
                                                        r24 = "pcall"
                                                        r23 = nil
                                                        r33 = "__index"
                                                        r32 = nil
                                                        r2 = _env[r3]
                                                        r11 = upvalueValues[r6]
                                                        r29 = nil
                                                        r9 = {
                                                            [r33] = r11,
                                                            [r14] = r29
                                                        }
                                                        r3 = r2(r25, r9)
                                                        r2 = createClosure2(61, {
                                                            r6,
                                                            r19,
                                                            r4,
                                                            r1,
                                                            r21,
                                                            r7
                                                        })
                                                        r21 = releaseUpvalue(r21)
                                                        r6 = releaseUpvalue(r6)
                                                        upvalueValues[r28] = r3
                                                        r4 = releaseUpvalue(r4)
                                                        r7 = releaseUpvalue(r7)
                                                        r26 = nil
                                                        r26 = createClosure4(68, {
                                                            r28,
                                                            r16
                                                        })
                                                        upvalueValues[r16] = r2
                                                        r19 = releaseUpvalue(r19)
                                                        r1 = releaseUpvalue(r1)
                                                        r15 = nil
                                                        r15 = _env[r24]
                                                        r23 = {
                                                            r15(r26)
                                                        }
                                                        r24 = r23[1]
                                                        r26 = state
                                                        state = r24 and (32) or (33)
                                                        r10 = nil
                                                        r15 = r24
                                                        r10 = r23[2]
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 33 then
                                                if state <= 32 then
                                                    if state == 32 then
                                                        r15 = r10
                                                        state = 33
                                                    end
                                                else
                                                    if state == 33 then
                                                        state = r26
                                                        state = r15 and (34) or (35)
                                                    end
                                                end
                                            else
                                                if state <= 34 then
                                                    if state == 34 then
                                                        r26 = "print"
                                                        r15 = _env[r26]
                                                        r1 = upvalueValues[r28]
                                                        r21 = upvalueValues[r16]
                                                        r32 = 15390960163838
                                                        r4 = "\019\234\156\212\184_=\232@~V\169\203\143\220x\152\170q"
                                                        r18 = r21(r4, r32)
                                                        r23 = r1[r18]
                                                        r26 = r15(r23)
                                                        state = 35
                                                    end
                                                else
                                                    if state == 35 then
                                                        r10 = nil
                                                        ReturnVal = {}
                                                        r24 = nil
                                                        r16 = releaseUpvalue(r16)
                                                        r28 = releaseUpvalue(r28)
                                                        state = nil
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure2 entry 6128737 -> 36, states 36-36
                                if state == 36 then -- entry 6128737 -> 36
                                    ReturnVal = "error"
                                    state = _env[ReturnVal]
                                    r30 = "Tamper Detected!"
                                    ReturnVal = state(r30)
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        else
                            -- createClosure0 entry 14630110 -> 37, states 37-37
                            if state == 37 then -- entry 14630110 -> 37
                                state = true
                                upvalueValues[upvalues[1]] = state
                                ReturnVal = {}
                                state = nil
                            end
                        end
                    else
                        if state <= 38 then
                            -- createClosure5 entry 15633278 -> 38, states 38-38
                            if state == 38 then -- entry 15633278 -> 38
                                r15 = 6558653
                                r16 = "02Gl224MxRGym"
                                r30 = r16 ^ r15
                                ReturnVal = 6606992
                                state = ReturnVal - r30
                                r30 = state
                                ReturnVal = "Ed1"
                                state = ReturnVal / r30
                                ReturnVal = {
                                    state
                                }
                                state = nil
                            end
                        else
                            -- createClosure4 entry 3254301 -> 39, states 39-50
                            if state <= 44 then
                                if state <= 41 then
                                    if state <= 40 then
                                        if state <= 39 then
                                            if state == 39 then -- entry 3254301 -> 39
                                                r16 = upvalueValues[upvalues[1]]
                                                r28 = 1
                                                r24 = 2
                                                r15 = r16(r28, r24)
                                                r16 = 1
                                                r30 = r15 == r16
                                                state = r30 and (40) or (41)
                                                ReturnVal = r30
                                            end
                                        else
                                            if state == 40 then
                                                state = ReturnVal and (42) or (43)
                                            end
                                        end
                                    else
                                        if state == 41 then
                                            r16 = upvalueValues[upvalues[2]]
                                            r15 = upvalueValues[upvalues[3]]
                                            r30 = r16 == r15
                                            ReturnVal = r30
                                            state = 40
                                        end
                                    end
                                else
                                    if state <= 43 then
                                        if state <= 42 then
                                            if state == 42 then
                                                ReturnVal = "tonumber"
                                                state = _env[ReturnVal]
                                                r30 = upvalueValues[upvalues[4]]
                                                r28 = "tostring"
                                                r15 = _env[r28]
                                                r23 = "pcall"
                                                r26 = _env[r23]
                                                r1 = createClosure3(69, {})
                                                r23 = {
                                                    r26(r1)
                                                }
                                                r10 = {
                                                    unpack(r23)
                                                }
                                                r26 = 2
                                                r24 = r10[r26]
                                                r28 = r15(r24)
                                                r15 = ":(%d*):"
                                                r16 = r30(r28, r15)
                                                r30 = {
                                                    r16()
                                                }
                                                ReturnVal = state(unpack(r30))
                                                r30 = ReturnVal
                                                r16 = upvalueValues[upvalues[5]]
                                                state = r16 and (44) or (45)
                                                ReturnVal = r16
                                            end
                                        else
                                            if state == 43 then
                                                state = upvalueValues[upvalues[7]]
                                                state = state and (46) or (47)
                                            end
                                        end
                                    else
                                        if state == 44 then
                                            r15 = upvalueValues[upvalues[6]]
                                            r16 = r15 == r30
                                            ReturnVal = r16
                                            state = 45
                                        end
                                    end
                                end
                            else
                                if state <= 47 then
                                    if state <= 46 then
                                        if state <= 45 then
                                            if state == 45 then
                                                upvalueValues[upvalues[5]] = ReturnVal
                                                r30 = nil
                                                state = 43
                                            end
                                        else
                                            if state == 46 then
                                                r30 = "error"
                                                state = _env[r30]
                                                r16 = upvalueValues[upvalues[8]]
                                                r15 = 0
                                                r30 = state(r16, r15)
                                                state = 47
                                            end
                                        end
                                    else
                                        if state == 47 then
                                            state = {}
                                            r30 = state
                                            r15 = upvalueValues[upvalues[9]]
                                            r28 = r15
                                            r15 = 1
                                            r24 = r15
                                            r15 = 0
                                            r10 = r24 < r15
                                            r16 = 1
                                            r15 = r16 - r24
                                            state = 48
                                        end
                                    end
                                else
                                    if state <= 49 then
                                        if state <= 48 then
                                            if state == 48 then
                                                r15 = r15 + r24
                                                r26 = not r10
                                                r16 = r15 <= r28
                                                r16 = r26 and r16
                                                r26 = r15 >= r28
                                                r26 = r10 and r26
                                                r16 = r26 or r16
                                                r26 = (49)
                                                state = r16 and r26
                                                r16 = (50)
                                                state = state or r16
                                            end
                                        else
                                            if state == 49 then
                                                state = upvalueValues[upvalues[1]]
                                                r23 = 0
                                                r1 = 255
                                                r26 = state(r23, r1)
                                                r16 = r15
                                                r30[r16] = r26
                                                r16 = nil
                                                state = 48
                                            end
                                        end
                                    else
                                        if state == 50 then
                                            state = upvalueValues[upvalues[10]]
                                            r16 = upvalueValues[upvalues[11]]
                                            r30[state] = r16
                                            state = upvalueValues[upvalues[12]]
                                            r16 = {
                                                state(r30)
                                            }
                                            ReturnVal = {
                                                unpack(r16)
                                            }
                                            state = nil
                                        end
                                    end
                                end
                            end
                        end
                    end
                else
                    if state <= 67 then
                        if state <= 60 then
                            if state <= 54 then
                                -- createClosure5 entry 15435446 -> 51, states 51-54
                                if state <= 52 then
                                    if state <= 51 then
                                        if state == 51 then -- entry 15435446 -> 51
                                            state = 52
                                        end
                                    else
                                        if state == 52 then
                                            state = true
                                            state = state and (53) or (54)
                                        end
                                    end
                                else
                                    if state <= 53 then
                                        if state == 53 then
                                            ReturnVal = "l2"
                                            state = _env[ReturnVal]
                                            r30 = "l1"
                                            ReturnVal = _env[r30]
                                            r30 = "l1"
                                            _env[r30] = state
                                            r30 = "l2"
                                            _env[r30] = ReturnVal
                                            r30 = upvalueValues[upvalues[1]]
                                            r16 = r30()
                                            state = 52
                                        end
                                    else
                                        if state == 54 then
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                end
                            else
                                -- createClosure5 entry 372497 -> 55, states 55-60
                                if state <= 57 then
                                    if state <= 56 then
                                        if state <= 55 then
                                            if state == 55 then -- entry 372497 -> 55
                                                r30 = upvalueValues[upvalues[1]]
                                                ReturnVal = #r30
                                                r30 = 0
                                                state = ReturnVal == r30
                                                state = state and (56) or (57)
                                            end
                                        else
                                            if state == 56 then
                                                r16 = upvalueValues[upvalues[2]]
                                                r15 = 197
                                                r30 = r16 * r15
                                                r16 = 3646567040673
                                                ReturnVal = r30 + r16
                                                r30 = 35184372088832
                                                state = ReturnVal % r30
                                                upvalueValues[upvalues[2]] = state
                                                r30 = upvalueValues[upvalues[3]]
                                                r16 = 1
                                                ReturnVal = r30 ~= r16
                                                state = 58
                                            end
                                        end
                                    else
                                        if state == 57 then
                                            r15 = "table"
                                            r16 = _env[r15]
                                            r15 = "remove"
                                            r30 = r16[r15]
                                            r15 = upvalueValues[upvalues[1]]
                                            r16 = {
                                                r30(r15)
                                            }
                                            ReturnVal = {
                                                unpack(r16)
                                            }
                                            state = nil
                                        end
                                    end
                                else
                                    if state <= 59 then
                                        if state <= 58 then
                                            if state == 58 then
                                                r16 = upvalueValues[upvalues[3]]
                                                r15 = 206
                                                r30 = r16 * r15
                                                r16 = 257
                                                ReturnVal = r30 % r16
                                                upvalueValues[upvalues[3]] = ReturnVal
                                                state = 59
                                            end
                                        else
                                            if state == 59 then
                                                r16 = upvalueValues[upvalues[3]]
                                                r15 = 1
                                                r30 = r16 ~= r15
                                                state = r30 and (60) or (58)
                                            end
                                        end
                                    else
                                        if state == 60 then
                                            r15 = 32
                                            r16 = upvalueValues[upvalues[3]]
                                            r1 = 2
                                            r30 = r16 % r15
                                            r28 = upvalueValues[upvalues[4]]
                                            r26 = upvalueValues[upvalues[2]]
                                            r7 = upvalueValues[upvalues[3]]
                                            r32 = r7 - r30
                                            r7 = 32
                                            r4 = r32 / r7
                                            r18 = 13
                                            r21 = r18 - r4
                                            r23 = r1 ^ r21
                                            r10 = r26 / r23
                                            r23 = 1
                                            r24 = r28(r10)
                                            r28 = 4294967296
                                            r15 = r24 % r28
                                            r24 = 2
                                            r28 = r24 ^ r30
                                            r16 = r15 / r28
                                            r28 = upvalueValues[upvalues[4]]
                                            r1 = 256
                                            r26 = r16 % r23
                                            r23 = 4294967296
                                            r10 = r26 * r23
                                            r24 = r28(r10)
                                            r28 = upvalueValues[upvalues[4]]
                                            r10 = r28(r16)
                                            r18 = 256
                                            r30 = nil
                                            r26 = 65536
                                            r15 = r24 + r10
                                            r24 = 65536
                                            r28 = r15 % r24
                                            r10 = r15 - r28
                                            r24 = r10 / r26
                                            r26 = 256
                                            r10 = r28 % r26
                                            r23 = r28 - r10
                                            r26 = r23 / r1
                                            r1 = 256
                                            r23 = r24 % r1
                                            r21 = r24 - r23
                                            r16 = nil
                                            r28 = nil
                                            r1 = r21 / r18
                                            r15 = nil
                                            r24 = nil
                                            r21 = {
                                                r10,
                                                r26,
                                                r23,
                                                r1
                                            }
                                            r23 = nil
                                            upvalueValues[upvalues[1]] = r21
                                            r26 = nil
                                            r1 = nil
                                            r10 = nil
                                            state = 57
                                        end
                                    end
                                end
                            end
                        else
                            -- createClosure2 entry 4692880 -> 61, states 61-67
                            if state <= 64 then
                                if state <= 62 then
                                    if state <= 61 then
                                        if state == 61 then -- entry 4692880 -> 61
                                            r16 = args[2]
                                            state = upvalueValues[upvalues[1]]
                                            r15 = state
                                            state = r15[r16]
                                            r30 = args[1]
                                            state = state and (62) or (63)
                                        end
                                    else
                                        if state == 62 then
                                            state = 64
                                        end
                                    end
                                else
                                    if state <= 63 then
                                        if state == 63 then
                                            state = {}
                                            upvalueValues[upvalues[2]] = state
                                            ReturnVal = upvalueValues[upvalues[3]]
                                            r28 = ReturnVal
                                            r24 = 35184372088832
                                            ReturnVal = r16 % r24
                                            upvalueValues[upvalues[4]] = ReturnVal
                                            r26 = 255
                                            r10 = r16 % r26
                                            r26 = 2
                                            r24 = r10 + r26
                                            upvalueValues[upvalues[5]] = r24
                                            r23 = "string"
                                            r26 = _env[r23]
                                            r23 = "len"
                                            r10 = r26[r23]
                                            r26 = r10(r30)
                                            r21 = 1
                                            r18 = r21
                                            r10 = ""
                                            r15[r16] = r10
                                            r21 = 0
                                            r4 = r18 < r21
                                            r23 = 1
                                            r21 = r23 - r18
                                            r1 = r26
                                            r10 = 214
                                            state = 65
                                        end
                                    else
                                        if state == 64 then
                                            ReturnVal = {
                                                r16
                                            }
                                            state = nil
                                        end
                                    end
                                end
                            else
                                if state <= 66 then
                                    if state <= 65 then
                                        if state == 65 then
                                            r32 = not r4
                                            r21 = r21 + r18
                                            r23 = r21 <= r1
                                            r23 = r32 and r23
                                            r32 = r21 >= r1
                                            r32 = r4 and r32
                                            r23 = r32 or r23
                                            r32 = (66)
                                            state = r23 and r32
                                            r23 = (67)
                                            state = state or r23
                                        end
                                    else
                                        if state == 66 then
                                            r23 = r21
                                            r22 = "string"
                                            r27 = _env[r22]
                                            r22 = "byte"
                                            r12 = r27[r22]
                                            r27 = r12(r30, r23)
                                            r12 = upvalueValues[upvalues[6]]
                                            r22 = r12()
                                            r19 = r27 + r22
                                            r7 = r19 + r10
                                            r19 = 256
                                            r32 = r7 % r19
                                            r10 = r32
                                            r19 = r15[r16]
                                            r22 = 1
                                            r27 = r10 + r22
                                            r12 = r28[r27]
                                            r7 = r19 .. r12
                                            r15[r16] = r7
                                            r23 = nil
                                            state = 65
                                        end
                                    end
                                else
                                    if state == 67 then
                                        r10 = nil
                                        r26 = nil
                                        r28 = nil
                                        state = 64
                                    end
                                end
                            end
                        end
                    else
                        if state <= 68 then
                            -- createClosure4 entry 9247641 -> 68, states 68-68
                            if state == 68 then -- entry 9247641 -> 68
                                ReturnVal = "rawget"
                                state = _env[ReturnVal]
                                r16 = "debug"
                                r30 = _env[r16]
                                r15 = upvalueValues[upvalues[1]]
                                r28 = upvalueValues[upvalues[2]]
                                r10 = "\136\253\244z\246\242\187"
                                r26 = 34290092539487
                                r24 = r28(r10, r26)
                                r16 = r15[r24]
                                ReturnVal = {
                                    state(r30, r16)
                                }
                                ReturnVal = {
                                    unpack(ReturnVal)
                                }
                                state = nil
                            end
                        else
                            -- createClosure3 entry 16623629 -> 69, states 69-69
                            if state == 69 then -- entry 16623629 -> 69
                                r15 = 15696533
                                r16 = "znskTwh"
                                r30 = r16 ^ r15
                                ReturnVal = 13464601
                                state = ReturnVal - r30
                                r30 = state
                                ReturnVal = "GCr"
                                state = ReturnVal / r30
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
        currentUpvalueId = 0
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
        createClosure = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(...)
                return vm(entryId, {
                    ...
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
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)