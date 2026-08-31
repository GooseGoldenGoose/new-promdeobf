return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, createClosure, releaseUpvalues, upvalueValues, vm, upvalueRefCounts, currentUpvalueId, allocUpvalue, createClosure5, createUpvalueProxy, createClosure3, releaseUpvalue)
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
                    return -1063609
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -1063609
                    end
                })
            end
        end
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, ReturnVal, r29, r30
            while state do
                if state <= 72 then
                    if state <= 70 then
                        if state <= 65 then
                            -- root entry 4393204 -> 1, states 1-65
                            if state <= 33 then
                                if state <= 17 then
                                    if state <= 9 then
                                        if state <= 5 then
                                            if state <= 3 then
                                                if state <= 2 then
                                                    if state <= 1 then
                                                        if state == 1 then -- entry 4393204 -> 1
                                                            ReturnVal = "print"
                                                            state = _env[ReturnVal]
                                                            r15 = "sample60-start"
                                                            ReturnVal = state(r15)
                                                            state = false
                                                            state = state and 2 or 3
                                                            r20 = args
                                                        end
                                                    else
                                                        if state == 2 then
                                                            state = 3
                                                        end
                                                    end
                                                else
                                                    if state == 3 then
                                                        state = 4
                                                    end
                                                end
                                            else
                                                if state <= 4 then
                                                    if state == 4 then
                                                        state = false
                                                        state = state and 5 or 6
                                                    end
                                                else
                                                    if state == 5 then
                                                        state = 4
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 7 then
                                                if state <= 6 then
                                                    if state == 6 then
                                                        r15 = 0
                                                        r25 = r15
                                                        r15 = 1
                                                        r26 = r15
                                                        r15 = 0
                                                        r2 = r26 < r15
                                                        ReturnVal = 1
                                                        r15 = ReturnVal - r26
                                                        state = 7
                                                    end
                                                else
                                                    if state == 7 then
                                                        r15 = r15 + r26
                                                        r30 = not r2
                                                        ReturnVal = r15 <= r25
                                                        ReturnVal = r30 and ReturnVal
                                                        r30 = r15 >= r25
                                                        r30 = r2 and r30
                                                        ReturnVal = r30 or ReturnVal
                                                        r30 = 8
                                                        state = ReturnVal and r30
                                                        ReturnVal = 9
                                                        state = state or ReturnVal
                                                    end
                                                end
                                            else
                                                if state <= 8 then
                                                    if state == 8 then
                                                        r30 = r15
                                                        r30 = nil
                                                        state = 7
                                                    end
                                                else
                                                    if state == 9 then
                                                        r26 = {}
                                                        ReturnVal = "pairs"
                                                        state = _env[ReturnVal]
                                                        r2 = {
                                                            state(r26)
                                                        }
                                                        r15 = r2[2]
                                                        r25 = r2[3]
                                                        ReturnVal = r2[1]
                                                        r26 = ReturnVal
                                                        state = 10
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 13 then
                                            if state <= 11 then
                                                if state <= 10 then
                                                    if state == 10 then
                                                        r25, r30 = r26(r15, r25)
                                                        state = r25 and 11 or 12
                                                    end
                                                else
                                                    if state == 11 then
                                                        r2 = r25
                                                        r30 = nil
                                                        r2 = nil
                                                        state = 10
                                                    end
                                                end
                                            else
                                                if state <= 12 then
                                                    if state == 12 then
                                                        state = true
                                                        state = 13
                                                    end
                                                else
                                                    if state == 13 then
                                                        state = 14
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 15 then
                                                if state <= 14 then
                                                    if state == 14 then
                                                        state = true
                                                        state = state and 15 or 13
                                                    end
                                                else
                                                    if state == 15 then
                                                        state = 0
                                                        r15 = allocUpvalue()
                                                        upvalueValues[r15] = state
                                                        r25 = 10
                                                        r30 = 40
                                                        r2 = 30
                                                        r26 = 20
                                                        state = {
                                                            r25,
                                                            r26,
                                                            r2,
                                                            r30
                                                        }
                                                        r25 = state
                                                        r5 = -1
                                                        r19 = 2
                                                        r27 = 3
                                                        r2 = 1
                                                        r23 = "c"
                                                        r26 = "a"
                                                        r30 = "b"
                                                        state = {
                                                            [r26] = r2,
                                                            [r30] = r19,
                                                            [r23] = r27
                                                        }
                                                        r26 = state
                                                        r2 = "value"
                                                        r30 = 3
                                                        state = {
                                                            [r2] = r30
                                                        }
                                                        r2 = state
                                                        state = "extra"
                                                        r30 = "field"
                                                        r2[state] = r30
                                                        state = "indexed"
                                                        r30 = 7
                                                        r2[state] = r30
                                                        state = createClosure5(66, {})
                                                        r30 = state
                                                        state = createClosure3(71, {})
                                                        r19 = state
                                                        r23 = 5
                                                        state = r19(r23)
                                                        r23 = state
                                                        r27 = "print"
                                                        state = _env[r27]
                                                        r3 = r30(r5)
                                                        r4 = 0
                                                        r5 = r30(r4)
                                                        r12 = 1
                                                        r4 = {
                                                            r30(r12)
                                                        }
                                                        r1 = "class"
                                                        r27 = state(r1, r3, r5, unpack(r4))
                                                        r27 = "print"
                                                        state = _env[r27]
                                                        r5 = 2
                                                        r3 = r23(r5)
                                                        r4 = 3
                                                        r5 = {
                                                            r23(r4)
                                                        }
                                                        r1 = "closure"
                                                        r27 = state(r1, r3, unpack(r5))
                                                        state = createClosure3(72, {})
                                                        r27 = "add"
                                                        r2[r27] = state
                                                        state = createClosure3(73, {})
                                                        r3 = "add"
                                                        r3 = r2[r3]
                                                        r27 = "mul"
                                                        r2[r27] = state
                                                        r27 = "print"
                                                        state = _env[r27]
                                                        r5 = 2
                                                        r3 = r3(r2, r5)
                                                        r5 = "mul"
                                                        r5 = r2[r5]
                                                        r4 = 3
                                                        r5 = r5(r2, r4)
                                                        r12 = "extra"
                                                        r4 = r2[r12]
                                                        r22 = "indexed"
                                                        r12 = r2[r22]
                                                        r1 = "namecall"
                                                        r27 = state(r1, r3, r5, r4, r12)
                                                        r1 = 6
                                                        r3 = r1
                                                        r1 = 1
                                                        r5 = r1
                                                        r1 = 0
                                                        r4 = r5 < r1
                                                        r27 = 1
                                                        r1 = r27 - r5
                                                        state = 16
                                                    end
                                                end
                                            else
                                                if state <= 16 then
                                                    if state == 16 then
                                                        r12 = not r4
                                                        r1 = r1 + r5
                                                        r27 = r1 <= r3
                                                        r27 = r12 and r27
                                                        r12 = r1 >= r3
                                                        r12 = r4 and r12
                                                        r27 = r12 or r27
                                                        r12 = 17
                                                        state = r27 and r12
                                                        r27 = 18
                                                        state = state or r27
                                                    end
                                                else
                                                    if state == 17 then
                                                        r27 = r1
                                                        r12 = 2
                                                        state = r27 == r12
                                                        state = state and 19 or 20
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
                                                        state = 0
                                                        r27 = state
                                                        r1 = "pairs"
                                                        state = _env[r1]
                                                        r4 = {
                                                            state(r26)
                                                        }
                                                        r5 = r4[3]
                                                        r1 = r4[1]
                                                        r3 = r4[2]
                                                        state = 21
                                                    end
                                                else
                                                    if state == 19 then
                                                        r27 = nil
                                                        state = 16
                                                    end
                                                end
                                            else
                                                if state <= 20 then
                                                    if state == 20 then
                                                        r12 = 5
                                                        state = r27 == r12
                                                        state = state and 22 or 23
                                                    end
                                                else
                                                    if state == 21 then
                                                        r5, r12 = r1(r3, r5)
                                                        state = r5 and 24 or 25
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 23 then
                                                if state <= 22 then
                                                    if state == 22 then
                                                        r27 = nil
                                                        state = 18
                                                    end
                                                else
                                                    if state == 23 then
                                                        r12 = upvalueValues[r15]
                                                        state = r12 + r27
                                                        upvalueValues[r15] = state
                                                        state = 26
                                                    end
                                                end
                                            else
                                                if state <= 24 then
                                                    if state == 24 then
                                                        state = r27 + r12
                                                        r27 = state
                                                        r4 = r5
                                                        r24 = "b"
                                                        r22 = r4 == r24
                                                        state = r22 and 27 or 28
                                                    end
                                                else
                                                    if state == 25 then
                                                        r3 = "print"
                                                        r1 = _env[r3]
                                                        r5 = "pairs-sum"
                                                        r3 = r1(r5, r27)
                                                        r3 = "next"
                                                        r1 = _env[r3]
                                                        r5 = r25
                                                        r3 = nil
                                                        state = 29
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 29 then
                                            if state <= 27 then
                                                if state <= 26 then
                                                    if state == 26 then
                                                        r24 = 2
                                                        r22 = r27 % r24
                                                        r24 = 0
                                                        r12 = r22 == r24
                                                        state = r12 and 30 or 31
                                                    end
                                                else
                                                    if state == 27 then
                                                        r24 = 10
                                                        r22 = r27 + r24
                                                        r27 = r22
                                                        state = 32
                                                    end
                                                end
                                            else
                                                if state <= 28 then
                                                    if state == 28 then
                                                        r10 = 0
                                                        r24 = r27 + r10
                                                        r27 = r24
                                                        state = 32
                                                    end
                                                else
                                                    if state == 29 then
                                                        r3, r12 = r1(r5, r3)
                                                        state = r3 and 33 or 34
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 31 then
                                                if state <= 30 then
                                                    if state == 30 then
                                                        r22 = "print"
                                                        r12 = _env[r22]
                                                        r10 = upvalueValues[r15]
                                                        r24 = "num-even"
                                                        r22 = r12(r24, r27, r10)
                                                        state = 35
                                                    end
                                                else
                                                    if state == 31 then
                                                        r22 = "print"
                                                        r12 = _env[r22]
                                                        r10 = upvalueValues[r15]
                                                        r24 = "num-odd"
                                                        r22 = r12(r24, r27, r10)
                                                        state = 35
                                                    end
                                                end
                                            else
                                                if state <= 32 then
                                                    if state == 32 then
                                                        r12 = nil
                                                        r4 = nil
                                                        state = 21
                                                    end
                                                else
                                                    if state == 33 then
                                                        r4 = r3
                                                        r9 = 2
                                                        r10 = r4 == r9
                                                        state = r10 and 36 or 37
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 49 then
                                    if state <= 41 then
                                        if state <= 37 then
                                            if state <= 35 then
                                                if state <= 34 then
                                                    if state == 34 then
                                                        r1 = 0
                                                        state = 38
                                                    end
                                                else
                                                    if state == 35 then
                                                        r27 = nil
                                                        state = 16
                                                    end
                                                end
                                            else
                                                if state <= 36 then
                                                    if state == 36 then
                                                        r4 = nil
                                                        r12 = nil
                                                        state = 29
                                                    end
                                                else
                                                    if state == 37 then
                                                        r9 = "print"
                                                        r10 = _env[r9]
                                                        r7 = "next"
                                                        r9 = r10(r7, r4, r12)
                                                        r9 = 3
                                                        r10 = r4 == r9
                                                        state = r10 and 39 or 40
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 39 then
                                                if state <= 38 then
                                                    if state == 38 then
                                                        r5 = 6
                                                        r3 = r1 < r5
                                                        state = r3 and 41 or 42
                                                    end
                                                else
                                                    if state == 39 then
                                                        r12 = nil
                                                        r4 = nil
                                                        state = 34
                                                    end
                                                end
                                            else
                                                if state <= 40 then
                                                    if state == 40 then
                                                        r4 = nil
                                                        r12 = nil
                                                        state = 29
                                                    end
                                                else
                                                    if state == 41 then
                                                        r5 = 1
                                                        r3 = r1 + r5
                                                        r1 = r3
                                                        r4 = 10
                                                        r5 = r1 * r4
                                                        r12 = 2
                                                        r4 = r1 == r12
                                                        state = r4 and 43 or 44
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 45 then
                                            if state <= 43 then
                                                if state <= 42 then
                                                    if state == 42 then
                                                        r5 = 0
                                                        r12 = 3
                                                        r4 = r5 >= r12
                                                        state = 45
                                                    end
                                                else
                                                    if state == 43 then
                                                        r5 = nil
                                                        state = 38
                                                    end
                                                end
                                            else
                                                if state <= 44 then
                                                    if state == 44 then
                                                        r12 = 5
                                                        r4 = r1 == r12
                                                        state = r4 and 46 or 47
                                                    end
                                                else
                                                    if state == 45 then
                                                        r12 = 1
                                                        r4 = r5 + r12
                                                        r5 = r4
                                                        r10 = "print"
                                                        r12 = _env[r10]
                                                        r9 = "repeat"
                                                        r10 = r12(r9, r5)
                                                        state = 48
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 47 then
                                                if state <= 46 then
                                                    if state == 46 then
                                                        r12 = "print"
                                                        r4 = _env[r12]
                                                        r10 = "while-break"
                                                        r12 = r4(r10, r5)
                                                        r5 = nil
                                                        state = 42
                                                    end
                                                else
                                                    if state == 47 then
                                                        r12 = "print"
                                                        r4 = _env[r12]
                                                        r10 = "while"
                                                        r12 = r4(r10, r1, r5)
                                                        state = 49
                                                    end
                                                end
                                            else
                                                if state <= 48 then
                                                    if state == 48 then
                                                        r10 = 3
                                                        r12 = r5 >= r10
                                                        state = r12 and 50 or 45
                                                    end
                                                else
                                                    if state == 49 then
                                                        r5 = nil
                                                        state = 38
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    if state <= 57 then
                                        if state <= 53 then
                                            if state <= 51 then
                                                if state <= 50 then
                                                    if state == 50 then
                                                        r10 = 2
                                                        r9 = r10
                                                        r10 = 1
                                                        r7 = r10
                                                        r10 = 0
                                                        r16 = r7 < r10
                                                        r12 = 1
                                                        r10 = r12 - r7
                                                        state = 51
                                                    end
                                                else
                                                    if state == 51 then
                                                        r8 = not r16
                                                        r10 = r10 + r7
                                                        r12 = r10 <= r9
                                                        r12 = r8 and r12
                                                        r8 = r10 >= r9
                                                        r8 = r16 and r8
                                                        r12 = r8 or r12
                                                        r8 = 52
                                                        state = r12 and r8
                                                        r12 = 53
                                                        state = state or r12
                                                    end
                                                end
                                            else
                                                if state <= 52 then
                                                    if state == 52 then
                                                        r8 = 0
                                                        r12 = r10
                                                        state = 54
                                                    end
                                                else
                                                    if state == 53 then
                                                        r10 = "ipairs"
                                                        r12 = _env[r10]
                                                        r29 = 4
                                                        r8 = 2
                                                        r28 = 6
                                                        r16 = {
                                                            r8,
                                                            r29,
                                                            r28
                                                        }
                                                        r8 = {
                                                            r12(r16)
                                                        }
                                                        r10 = r8[1]
                                                        r7 = r8[3]
                                                        r9 = r8[2]
                                                        state = 55
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 55 then
                                                if state <= 54 then
                                                    if state == 54 then
                                                        r29 = 2
                                                        r21 = r8 < r29
                                                        state = r21 and 56 or 57
                                                    end
                                                else
                                                    if state == 55 then
                                                        r7, r16 = r10(r9, r7)
                                                        state = r7 and 58 or 59
                                                    end
                                                end
                                            else
                                                if state <= 56 then
                                                    if state == 56 then
                                                        r29 = 1
                                                        r21 = r8 + r29
                                                        r8 = r21
                                                        r28 = "ipairs"
                                                        r29 = _env[r28]
                                                        r17 = {
                                                            r12,
                                                            r8
                                                        }
                                                        r11 = {
                                                            r29(r17)
                                                        }
                                                        r13 = r11[2]
                                                        r18 = r11[3]
                                                        r28 = r11[1]
                                                        state = 60
                                                    end
                                                else
                                                    if state == 57 then
                                                        r12 = nil
                                                        r8 = nil
                                                        state = 51
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 61 then
                                            if state <= 59 then
                                                if state <= 58 then
                                                    if state == 58 then
                                                        r8 = allocUpvalue()
                                                        r12 = r7
                                                        upvalueValues[r8] = r12
                                                        r12 = r8
                                                        r8 = allocUpvalue()
                                                        upvalueValues[r8] = r16
                                                        r16 = r8
                                                        r8 = createClosure5(74, {
                                                            r12,
                                                            r16,
                                                            r15
                                                        })
                                                        r28 = upvalueValues[r12]
                                                        r13 = 2
                                                        r29 = r28 == r13
                                                        state = r29 and 61 or 62
                                                    end
                                                else
                                                    if state == 59 then
                                                        r12 = createClosure3(75, {})
                                                        r9 = "print"
                                                        r10 = _env[r9]
                                                        r29 = "no"
                                                        r28 = true
                                                        r8 = "yes"
                                                        r16 = r12(r8, r29, r28)
                                                        r17 = upvalueValues[r15]
                                                        r11 = 0
                                                        r18 = r17 > r11
                                                        r17 = "positive"
                                                        r28 = r18 and r17
                                                        r13 = state
                                                        r13 = "zero"
                                                        r8 = r28 or r13
                                                        r7 = "logic"
                                                        r9 = r10(r7, r16, r8)
                                                        ReturnVal = {}
                                                        r9 = "print"
                                                        r10 = _env[r9]
                                                        r16 = upvalueValues[r15]
                                                        r15 = releaseUpvalue(r15)
                                                        r7 = "sample60-end"
                                                        r9 = r10(r7, r16, r1, r5)
                                                        r19 = nil
                                                        r25 = nil
                                                        r29 = state
                                                        r30 = nil
                                                        r27 = nil
                                                        r23 = nil
                                                        r12 = nil
                                                        r2 = nil
                                                        r26 = nil
                                                        r1 = nil
                                                        r5 = nil
                                                        state = nil
                                                    end
                                                end
                                            else
                                                if state <= 60 then
                                                    if state == 60 then
                                                        r18, r17 = r28(r13, r18)
                                                        state = r18 and 63 or 64
                                                    end
                                                else
                                                    if state == 61 then
                                                        r28 = "print"
                                                        r29 = _env[r28]
                                                        r18 = {
                                                            r8()
                                                        }
                                                        r13 = "capture-a"
                                                        r28 = r29(r13, unpack(r18))
                                                        state = 65
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 63 then
                                                if state <= 62 then
                                                    if state == 62 then
                                                        r28 = "print"
                                                        r29 = _env[r28]
                                                        r18 = {
                                                            r8()
                                                        }
                                                        r13 = "capture-b"
                                                        r28 = r29(r13, unpack(r18))
                                                        state = 65
                                                    end
                                                else
                                                    if state == 63 then
                                                        r29 = r18
                                                        r14 = "print"
                                                        r11 = _env[r14]
                                                        r6 = "nested"
                                                        r14 = r11(r6, r12, r8, r29, r17)
                                                        r17 = nil
                                                        r29 = nil
                                                        state = 60
                                                    end
                                                end
                                            else
                                                if state <= 64 then
                                                    if state == 64 then
                                                        state = 54
                                                    end
                                                else
                                                    if state == 65 then
                                                        r16 = releaseUpvalue(r16)
                                                        r12 = releaseUpvalue(r12)
                                                        r8 = nil
                                                        state = 55
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            -- createClosure5 entry 8056603 -> 66, states 66-70
                            if state <= 68 then
                                if state <= 67 then
                                    if state <= 66 then
                                        if state == 66 then -- entry 8056603 -> 66
                                            r20 = args[1]
                                            ReturnVal = 0
                                            state = r20 < ReturnVal
                                            state = state and 67 or 68
                                        end
                                    else
                                        if state == 67 then
                                            state = "neg"
                                            ReturnVal = {
                                                state
                                            }
                                            state = nil
                                        end
                                    end
                                else
                                    if state == 68 then
                                        ReturnVal = 0
                                        state = r20 == ReturnVal
                                        state = state and 69 or 70
                                    end
                                end
                            else
                                if state <= 69 then
                                    if state == 69 then
                                        state = "zero"
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                else
                                    if state == 70 then
                                        state = "pos"
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                end
                            end
                        end
                    else
                        if state <= 71 then
                            -- createClosure3 entry 14367872 -> 71, states 71-71
                            if state == 71 then -- entry 14367872 -> 71
                                r15 = allocUpvalue()
                                state = createClosure3(80, {
                                    r15
                                })
                                r20 = args[1]
                                upvalueValues[r15] = r20
                                ReturnVal = {
                                    state
                                }
                                state = nil
                            end
                        else
                            -- createClosure3 entry 6143973 -> 72, states 72-72
                            if state == 72 then -- entry 6143973 -> 72
                                r15 = args[2]
                                r20 = args[1]
                                r26 = "value"
                                r25 = r20[r26]
                                ReturnVal = r25 + r15
                                state = "value"
                                r20[state] = ReturnVal
                                ReturnVal = "value"
                                state = r20[ReturnVal]
                                ReturnVal = {
                                    state
                                }
                                state = nil
                            end
                        end
                    end
                else
                    if state <= 74 then
                        if state <= 73 then
                            -- createClosure3 entry 9734147 -> 73, states 73-73
                            if state == 73 then -- entry 9734147 -> 73
                                r20 = args[1]
                                r15 = args[2]
                                r25 = "value"
                                ReturnVal = r20[r25]
                                state = ReturnVal * r15
                                ReturnVal = {
                                    state
                                }
                                state = nil
                            end
                        else
                            -- createClosure5 entry 4418654 -> 74, states 74-74
                            if state == 74 then -- entry 4418654 -> 74
                                r20 = upvalueValues[upvalues[1]]
                                r15 = upvalueValues[upvalues[2]]
                                ReturnVal = r20 + r15
                                r20 = upvalueValues[upvalues[3]]
                                state = ReturnVal + r20
                                ReturnVal = {
                                    state
                                }
                                state = nil
                            end
                        end
                    else
                        if state <= 79 then
                            -- createClosure3 entry 9039680 -> 75, states 75-79
                            if state <= 77 then
                                if state <= 76 then
                                    if state <= 75 then
                                        if state == 75 then -- entry 9039680 -> 75
                                            r15 = args[2]
                                            r25 = args[3]
                                            r2 = state
                                            state = r25 and 76 or 77
                                            r20 = args[1]
                                            r26 = r25
                                        end
                                    else
                                        if state == 76 then
                                            r26 = r20
                                            state = 77
                                        end
                                    end
                                else
                                    if state == 77 then
                                        state = r2
                                        state = r26 and 78 or 79
                                        ReturnVal = r26
                                    end
                                end
                            else
                                if state <= 78 then
                                    if state == 78 then
                                        ReturnVal = {
                                            ReturnVal
                                        }
                                        state = nil
                                    end
                                else
                                    if state == 79 then
                                        ReturnVal = r15
                                        state = 78
                                    end
                                end
                            end
                        else
                            -- createClosure3 entry 12147755 -> 80, states 80-80
                            if state == 80 then -- entry 12147755 -> 80
                                r20 = args[1]
                                ReturnVal = upvalueValues[upvalues[1]]
                                state = ReturnVal + r20
                                upvalueValues[upvalues[1]] = state
                                ReturnVal = upvalueValues[upvalues[1]]
                                ReturnVal = {
                                    ReturnVal
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
                upvalueRefCounts[upvalueId], captureIndex = upvalueRefCounts[upvalueId] - (1), (1) + captureIndex
                if upvalueRefCounts[upvalueId] == 0 then
                    upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
                end
                upvalueId = captures[captureIndex]
            end
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
        upvalueRefCounts = {}
        createClosure = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(...)
                return vm(entryId, {
                    ...
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
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)