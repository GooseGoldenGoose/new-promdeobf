return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, createClosure2, createClosure5, currentUpvalueId, upvalueRefCounts, createClosure6, createClosure3, releaseUpvalue, createClosure4, vm, createClosure, allocUpvalue, releaseUpvalues, upvalueValues, createClosure1, createUpvalueProxy)
        upvalueRefCounts = {}
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = upvalueRefCounts[captures[captureIndex]] + (1)
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return -2267404
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -2267404
                    end
                })
            end
        end
        currentUpvalueId = 0
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
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
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
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if 0 == upvalueRefCounts[upvalueId] then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
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
        createClosure1 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1)
                return vm(entryId, {
                    arg1
                }, captures, gcProxy)
            end
            return closure
        end
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, ReturnVal, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33
            while state do
                if state <= 46 then
                    if state <= 33 then
                        if state <= 32 then
                            if state <= 31 then
                                -- root entry 7112618 -> 1, states 1-31
                                if state <= 16 then
                                    if state <= 8 then
                                        if state <= 4 then
                                            if state <= 2 then
                                                if state <= 1 then
                                                    if state == 1 then -- entry 7112618 -> 1
                                                        r10 = allocUpvalue()
                                                        state = true
                                                        upvalueValues[r10] = state
                                                        r17 = "string"
                                                        ReturnVal = _env[r17]
                                                        r5 = allocUpvalue()
                                                        r17 = "gmatch"
                                                        state = ReturnVal[r17]
                                                        r17 = allocUpvalue()
                                                        upvalueValues[r17] = state
                                                        r14 = allocUpvalue()
                                                        state = createClosure3(32, {})
                                                        upvalueValues[r5] = state
                                                        state = false
                                                        upvalueValues[r14] = state
                                                        r30 = "pcall"
                                                        r2 = _env[r30]
                                                        r8 = createClosure2(33, {
                                                            r14
                                                        })
                                                        r30 = r2(r8)
                                                        state = r30 and (2) or (3)
                                                        r28 = args
                                                        ReturnVal = r30
                                                    end
                                                else
                                                    if state == 2 then
                                                        r2 = upvalueValues[r14]
                                                        ReturnVal = r2
                                                        state = 3
                                                    end
                                                end
                                            else
                                                if state <= 3 then
                                                    if state == 3 then
                                                        r2 = ReturnVal
                                                        r30 = "math"
                                                        ReturnVal = _env[r30]
                                                        r30 = "random"
                                                        state = ReturnVal[r30]
                                                        r30 = allocUpvalue()
                                                        upvalueValues[r30] = state
                                                        r8 = "table"
                                                        ReturnVal = _env[r8]
                                                        r8 = "concat"
                                                        state = ReturnVal[r8]
                                                        r8 = state
                                                        r4 = state
                                                        r27 = "table"
                                                        r26 = _env[r27]
                                                        state = r26 and (4) or (5)
                                                        r20 = r26
                                                    end
                                                else
                                                    if state == 4 then
                                                        r13 = "table"
                                                        r27 = _env[r13]
                                                        r13 = "unpack"
                                                        r26 = r27[r13]
                                                        r20 = r26
                                                        state = 5
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 6 then
                                                if state <= 5 then
                                                    if state == 5 then
                                                        state = r4
                                                        state = r20 and (6) or (7)
                                                        ReturnVal = r20
                                                    end
                                                else
                                                    if state == 6 then
                                                        r20 = allocUpvalue()
                                                        upvalueValues[r20] = ReturnVal
                                                        state = upvalueValues[r30]
                                                        r26 = 65
                                                        r4 = 3
                                                        ReturnVal = state(r4, r26)
                                                        r4 = allocUpvalue()
                                                        upvalueValues[r4] = ReturnVal
                                                        state = 0
                                                        r26 = state
                                                        r6 = createClosure2(34, {})
                                                        r13 = "pcall"
                                                        ReturnVal = _env[r13]
                                                        r13 = {
                                                            ReturnVal(r6)
                                                        }
                                                        state = 0
                                                        r27 = state
                                                        state = {
                                                            unpack(r13)
                                                        }
                                                        r13 = state
                                                        ReturnVal = 2
                                                        state = r13[ReturnVal]
                                                        r6 = state
                                                        ReturnVal = "tonumber"
                                                        state = _env[ReturnVal]
                                                        r24 = upvalueValues[r17]
                                                        r22 = "tostring"
                                                        r7 = _env[r22]
                                                        r22 = r7(r6)
                                                        r7 = ":(%d*):"
                                                        r11 = r24(r22, r7)
                                                        r24 = {
                                                            r11()
                                                        }
                                                        ReturnVal = state(unpack(r24))
                                                        r24 = allocUpvalue()
                                                        upvalueValues[r24] = ReturnVal
                                                        r11 = upvalueValues[r4]
                                                        r7 = r11
                                                        r11 = 1
                                                        r22 = r11
                                                        r11 = 0
                                                        r21 = r22 < r11
                                                        ReturnVal = 1
                                                        r11 = ReturnVal - r22
                                                        state = 8
                                                    end
                                                end
                                            else
                                                if state <= 7 then
                                                    if state == 7 then
                                                        r4 = "unpack"
                                                        r20 = _env[r4]
                                                        ReturnVal = r20
                                                        state = 6
                                                    end
                                                else
                                                    if state == 8 then
                                                        r11 = r11 + r22
                                                        r23 = not r21
                                                        ReturnVal = r11 <= r7
                                                        ReturnVal = r23 and ReturnVal
                                                        r23 = r11 >= r7
                                                        r23 = r21 and r23
                                                        ReturnVal = r23 or ReturnVal
                                                        r23 = (9)
                                                        state = ReturnVal and r23
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
                                                        r23 = allocUpvalue()
                                                        upvalueValues[r23] = r11
                                                        r25 = "math"
                                                        ReturnVal = _env[r25]
                                                        r25 = "random"
                                                        state = ReturnVal[r25]
                                                        r29 = 100
                                                        r25 = 1
                                                        ReturnVal = state(r25, r29)
                                                        r25 = allocUpvalue()
                                                        upvalueValues[r25] = ReturnVal
                                                        state = upvalueValues[r30]
                                                        r12 = 255
                                                        r29 = 0
                                                        ReturnVal = state(r29, r12)
                                                        r29 = allocUpvalue()
                                                        upvalueValues[r29] = ReturnVal
                                                        state = upvalueValues[r30]
                                                        r18 = upvalueValues[r25]
                                                        r12 = 1
                                                        ReturnVal = state(r12, r18)
                                                        r12 = allocUpvalue()
                                                        upvalueValues[r12] = ReturnVal
                                                        ReturnVal = upvalueValues[r30]
                                                        r19 = 1
                                                        r15 = 2
                                                        r18 = ReturnVal(r19, r15)
                                                        ReturnVal = 1
                                                        state = r18 == ReturnVal
                                                        r18 = allocUpvalue()
                                                        upvalueValues[r18] = state
                                                        r33 = "tostring"
                                                        r16 = _env[r33]
                                                        r31 = upvalueValues[r30]
                                                        r3 = 0
                                                        r32 = 10000
                                                        r9 = {
                                                            r31(r3, r32)
                                                        }
                                                        r33 = r16(unpack(r9))
                                                        state = "gsub"
                                                        state = r6[state]
                                                        r16 = ":"
                                                        r1 = r33 .. r16
                                                        r15 = ":"
                                                        r19 = r15 .. r1
                                                        ReturnVal = ":(%d*):"
                                                        state = state(r6, ReturnVal, r19)
                                                        r19 = allocUpvalue()
                                                        upvalueValues[r19] = state
                                                        r1 = createClosure1(35, {
                                                            r30,
                                                            r23,
                                                            r4,
                                                            r17,
                                                            r10,
                                                            r24,
                                                            r18,
                                                            r19,
                                                            r25,
                                                            r12,
                                                            r29,
                                                            r20
                                                        })
                                                        r15 = "pcall"
                                                        ReturnVal = _env[r15]
                                                        r15 = {
                                                            ReturnVal(r1)
                                                        }
                                                        state = {
                                                            unpack(r15)
                                                        }
                                                        r15 = state
                                                        state = upvalueValues[r18]
                                                        state = state and (11) or (12)
                                                    end
                                                else
                                                    if state == 10 then
                                                        r7 = upvalueValues[r10]
                                                        state = r7 and (13) or (14)
                                                        r11 = r7
                                                    end
                                                end
                                            else
                                                if state <= 11 then
                                                    if state == 11 then
                                                        r1 = upvalueValues[r10]
                                                        state = r1 and (15) or (16)
                                                        ReturnVal = r1
                                                    end
                                                else
                                                    if state == 12 then
                                                        r16 = upvalueValues[r10]
                                                        state = r16 and (17) or (18)
                                                        r1 = r16
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 14 then
                                                if state <= 13 then
                                                    if state == 13 then
                                                        r7 = r26 == r27
                                                        r11 = r7
                                                        state = 14
                                                    end
                                                else
                                                    if state == 14 then
                                                        upvalueValues[r10] = r11
                                                        state = upvalueValues[r10]
                                                        state = state and (19) or (20)
                                                    end
                                                end
                                            else
                                                if state <= 15 then
                                                    if state == 15 then
                                                        r16 = state
                                                        r9 = 1
                                                        r31 = r15[r9]
                                                        r9 = false
                                                        r33 = r31 == r9
                                                        state = r33 and (21) or (22)
                                                        r1 = r33
                                                    end
                                                else
                                                    if state == 16 then
                                                        upvalueValues[r10] = ReturnVal
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
                                                        r16 = r15[r33]
                                                        r1 = r16
                                                        state = 18
                                                    end
                                                else
                                                    if state == 18 then
                                                        upvalueValues[r10] = r1
                                                        r9 = upvalueValues[r12]
                                                        r3 = 1
                                                        r31 = r9 + r3
                                                        r33 = r15[r31]
                                                        r16 = r26 + r33
                                                        r33 = 256
                                                        state = r16 % r33
                                                        r26 = state
                                                        r31 = upvalueValues[r29]
                                                        r33 = r27 + r31
                                                        r31 = 256
                                                        r16 = r33 % r31
                                                        r27 = r16
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
                                                        r9 = 2
                                                        r31 = r15[r9]
                                                        r9 = upvalueValues[r19]
                                                        r33 = r31 == r9
                                                        r1 = r33
                                                        state = 22
                                                    end
                                                else
                                                    if state == 22 then
                                                        state = r16
                                                        ReturnVal = r1
                                                        state = 16
                                                    end
                                                end
                                            else
                                                if state <= 23 then
                                                    if state == 23 then
                                                        r23 = releaseUpvalue(r23)
                                                        r12 = releaseUpvalue(r12)
                                                        r25 = releaseUpvalue(r25)
                                                        r18 = releaseUpvalue(r18)
                                                        r29 = releaseUpvalue(r29)
                                                        r15 = nil
                                                        r19 = releaseUpvalue(r19)
                                                        state = 8
                                                    end
                                                else
                                                    if state == 24 then
                                                        r17 = releaseUpvalue(r17)
                                                        r20 = releaseUpvalue(r20)
                                                        r5 = releaseUpvalue(r5)
                                                        r14 = releaseUpvalue(r14)
                                                        r5 = allocUpvalue()
                                                        r30 = releaseUpvalue(r30)
                                                        r24 = releaseUpvalue(r24)
                                                        r10 = releaseUpvalue(r10)
                                                        r13 = nil
                                                        r13 = {}
                                                        r4 = releaseUpvalue(r4)
                                                        r26 = nil
                                                        r26 = {}
                                                        r10 = nil
                                                        upvalueValues[r5] = r10
                                                        r10 = allocUpvalue()
                                                        r17 = nil
                                                        upvalueValues[r10] = r17
                                                        r2 = nil
                                                        r2 = "math"
                                                        r14 = _env[r2]
                                                        r2 = "floor"
                                                        r17 = r14[r2]
                                                        r14 = allocUpvalue()
                                                        upvalueValues[r14] = r17
                                                        r30 = "math"
                                                        r2 = _env[r30]
                                                        r30 = "random"
                                                        r17 = r2[r30]
                                                        r8 = nil
                                                        r8 = "table"
                                                        r30 = _env[r8]
                                                        r8 = "remove"
                                                        r2 = r30[r8]
                                                        r20 = "string"
                                                        r8 = _env[r20]
                                                        r20 = "char"
                                                        r30 = r8[r20]
                                                        r27 = nil
                                                        r27 = allocUpvalue()
                                                        r4 = allocUpvalue()
                                                        r20 = allocUpvalue()
                                                        r8 = 0
                                                        upvalueValues[r20] = r8
                                                        r8 = 2
                                                        upvalueValues[r4] = r8
                                                        upvalueValues[r27] = r26
                                                        r8 = {}
                                                        r24 = 256
                                                        r21 = r24
                                                        r24 = 1
                                                        r23 = r24
                                                        r24 = 0
                                                        r25 = r23 < r24
                                                        r6 = nil
                                                        r6 = 1
                                                        r24 = r6 - r23
                                                        r26 = 0
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
                                                            r5
                                                        })
                                                        r7 = {
                                                            state()
                                                        }
                                                        ReturnVal = {
                                                            unpack(r7)
                                                        }
                                                        state = nil
                                                    end
                                                else
                                                    if state == 26 then
                                                        r24 = r24 + r23
                                                        r6 = r24 <= r21
                                                        r29 = not r25
                                                        r6 = r29 and r6
                                                        r29 = r24 >= r21
                                                        r29 = r25 and r29
                                                        r6 = r29 or r6
                                                        r29 = (27)
                                                        state = r6 and r29
                                                        r6 = (28)
                                                        state = state or r6
                                                    end
                                                end
                                            else
                                                if state <= 27 then
                                                    if state == 27 then
                                                        r6 = r24
                                                        r29 = r6
                                                        r13[r6] = r29
                                                        r6 = nil
                                                        state = 26
                                                    end
                                                else
                                                    if state == 28 then
                                                        r24 = #r13
                                                        r21 = 0
                                                        r6 = r24 == r21
                                                        state = 29
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 30 then
                                                if state <= 29 then
                                                    if state == 29 then
                                                        r24 = 1
                                                        r21 = #r13
                                                        r6 = r17(r24, r21)
                                                        r24 = r2(r13, r6)
                                                        r29 = 1
                                                        r21 = upvalueValues[r27]
                                                        r6 = nil
                                                        r25 = r24 - r29
                                                        r23 = r30(r25)
                                                        r21[r24] = r23
                                                        r24 = nil
                                                        state = 30
                                                    end
                                                else
                                                    if state == 30 then
                                                        r24 = #r13
                                                        r21 = 0
                                                        r6 = r24 == r21
                                                        state = r6 and (31) or (29)
                                                    end
                                                end
                                            else
                                                if state == 31 then
                                                    r24 = allocUpvalue()
                                                    r23 = allocUpvalue()
                                                    r21 = createClosure4(51, {
                                                        r24,
                                                        r20,
                                                        r4,
                                                        r14
                                                    })
                                                    r14 = releaseUpvalue(r14)
                                                    r6 = {}
                                                    upvalueValues[r24] = r6
                                                    r6 = allocUpvalue()
                                                    upvalueValues[r6] = r21
                                                    r30 = nil
                                                    r2 = nil
                                                    r21 = {}
                                                    upvalueValues[r23] = r21
                                                    r29 = {}
                                                    r17 = nil
                                                    r25 = "setmetatable"
                                                    r21 = _env[r25]
                                                    r19 = upvalueValues[r23]
                                                    r33 = nil
                                                    r18 = "__index"
                                                    r15 = "__metatable"
                                                    r12 = {
                                                        [r18] = r19,
                                                        [r15] = r33
                                                    }
                                                    r25 = r21(r29, r12)
                                                    r21 = createClosure4(57, {
                                                        r23,
                                                        r24,
                                                        r27,
                                                        r20,
                                                        r4,
                                                        r6
                                                    })
                                                    r2 = "game"
                                                    upvalueValues[r10] = r25
                                                    r24 = releaseUpvalue(r24)
                                                    r23 = releaseUpvalue(r23)
                                                    r27 = releaseUpvalue(r27)
                                                    r20 = releaseUpvalue(r20)
                                                    r6 = releaseUpvalue(r6)
                                                    r4 = releaseUpvalue(r4)
                                                    upvalueValues[r5] = r21
                                                    r14 = _env[r2]
                                                    r8 = nil
                                                    r8 = upvalueValues[r10]
                                                    r20 = upvalueValues[r5]
                                                    r27 = 24153210956783
                                                    r26 = nil
                                                    r26 = "c\176\1855\226\232\241"
                                                    r4 = r20(r26, r27)
                                                    r30 = r8[r4]
                                                    r2 = "GetService"
                                                    r2 = r14[r2]
                                                    r2 = r2(r14, r30)
                                                    r30 = upvalueValues[r10]
                                                    r8 = upvalueValues[r5]
                                                    r26 = 32187153627788
                                                    r4 = "\133\248\228\\\237\164b\222\162d\218"
                                                    r20 = r8(r4, r26)
                                                    r14 = r30[r20]
                                                    r17 = r2[r14]
                                                    r30 = upvalueValues[r10]
                                                    r8 = upvalueValues[r5]
                                                    r4 = ",\135\171\004\251X\018\153\180"
                                                    r26 = 20334105666812
                                                    r20 = r8(r4, r26)
                                                    r2 = r30[r20]
                                                    r14 = r17[r2]
                                                    r8 = upvalueValues[r10]
                                                    r20 = upvalueValues[r5]
                                                    r27 = 20132326859934
                                                    r26 = "\180\136\0318"
                                                    r4 = r20(r26, r27)
                                                    r30 = r8[r4]
                                                    r2 = r14[r30]
                                                    r20 = upvalueValues[r10]
                                                    r4 = upvalueValues[r5]
                                                    r13 = nil
                                                    r13 = 15621827828842
                                                    r27 = "\155\191\130\147"
                                                    r26 = r4(r27, r13)
                                                    r8 = r20[r26]
                                                    r30 = r2[r8]
                                                    r24 = 14573549951618
                                                    r20 = upvalueValues[r10]
                                                    r4 = upvalueValues[r5]
                                                    r27 = "\198y\005\144\1813\242\145\208t\239\018\182\145|\031g|\157\168\239\004\168\226AA\245(\213\250%J\230\142\234a\127\222\019+\205|\250O j\148"
                                                    r13 = 32267993692849
                                                    r26 = r4(r27, r13)
                                                    r8 = r20[r26]
                                                    r20 = allocUpvalue()
                                                    upvalueValues[r20] = r8
                                                    r4 = upvalueValues[r10]
                                                    r26 = upvalueValues[r5]
                                                    r6 = 12993565218722
                                                    r13 = "j\208\179\165\248\219*"
                                                    r27 = r26(r13, r6)
                                                    r2 = nil
                                                    r8 = r4[r27]
                                                    r4 = upvalueValues[r20]
                                                    r30[r8] = r4
                                                    r30 = nil
                                                    r6 = "\017\144\1839k\252 B\245K\030-\023^"
                                                    r14 = nil
                                                    r26 = upvalueValues[r10]
                                                    r27 = upvalueValues[r5]
                                                    r13 = r27(r6, r24)
                                                    r4 = r26[r13]
                                                    r8 = r17[r4]
                                                    r26 = createClosure6(64, {
                                                        r10,
                                                        r5,
                                                        r20
                                                    })
                                                    ReturnVal = {}
                                                    r4 = "Connect"
                                                    r4 = r8[r4]
                                                    r10 = releaseUpvalue(r10)
                                                    r4 = r4(r8, r26)
                                                    r17 = nil
                                                    r20 = releaseUpvalue(r20)
                                                    r5 = releaseUpvalue(r5)
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure3 entry 9614103 -> 32, states 32-32
                                if state == 32 then -- entry 9614103 -> 32
                                    ReturnVal = "error"
                                    state = _env[ReturnVal]
                                    r28 = "Tamper Detected!"
                                    ReturnVal = state(r28)
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        else
                            -- createClosure2 entry 1781000 -> 33, states 33-33
                            if state == 33 then -- entry 1781000 -> 33
                                state = true
                                upvalueValues[upvalues[1]] = state
                                ReturnVal = {}
                                state = nil
                            end
                        end
                    else
                        if state <= 34 then
                            -- createClosure2 entry 1364039 -> 34, states 34-34
                            if state == 34 then -- entry 1364039 -> 34
                                r17 = 2832943
                                r10 = "IvxrKfqk9Jjam"
                                r28 = r10 ^ r17
                                ReturnVal = 2633437
                                state = ReturnVal - r28
                                r28 = state
                                ReturnVal = "0US4yscqIC53bF"
                                state = ReturnVal / r28
                                ReturnVal = {
                                    state
                                }
                                state = nil
                            end
                        else
                            -- createClosure1 entry 15748489 -> 35, states 35-46
                            if state <= 40 then
                                if state <= 37 then
                                    if state <= 36 then
                                        if state <= 35 then
                                            if state == 35 then -- entry 15748489 -> 35
                                                r10 = upvalueValues[upvalues[1]]
                                                r14 = 2
                                                r5 = 1
                                                r17 = r10(r5, r14)
                                                r10 = 1
                                                r28 = r17 == r10
                                                state = r28 and (36) or (37)
                                                ReturnVal = r28
                                            end
                                        else
                                            if state == 36 then
                                                state = ReturnVal and (38) or (39)
                                            end
                                        end
                                    else
                                        if state == 37 then
                                            r10 = upvalueValues[upvalues[2]]
                                            r17 = upvalueValues[upvalues[3]]
                                            r28 = r10 == r17
                                            ReturnVal = r28
                                            state = 36
                                        end
                                    end
                                else
                                    if state <= 39 then
                                        if state <= 38 then
                                            if state == 38 then
                                                r20 = createClosure2(65, {})
                                                ReturnVal = "tonumber"
                                                state = _env[ReturnVal]
                                                r28 = upvalueValues[upvalues[4]]
                                                r5 = "tostring"
                                                r17 = _env[r5]
                                                r8 = "pcall"
                                                r30 = _env[r8]
                                                r8 = {
                                                    r30(r20)
                                                }
                                                r2 = {
                                                    unpack(r8)
                                                }
                                                r30 = 2
                                                r14 = r2[r30]
                                                r5 = r17(r14)
                                                r17 = ":(%d*):"
                                                r10 = r28(r5, r17)
                                                r28 = {
                                                    r10()
                                                }
                                                ReturnVal = state(unpack(r28))
                                                r28 = ReturnVal
                                                r10 = upvalueValues[upvalues[5]]
                                                state = r10 and (40) or (41)
                                                ReturnVal = r10
                                            end
                                        else
                                            if state == 39 then
                                                state = upvalueValues[upvalues[7]]
                                                state = state and (42) or (43)
                                            end
                                        end
                                    else
                                        if state == 40 then
                                            r17 = upvalueValues[upvalues[6]]
                                            r10 = r17 == r28
                                            ReturnVal = r10
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
                                                r28 = nil
                                                state = 39
                                            end
                                        else
                                            if state == 42 then
                                                r28 = "error"
                                                state = _env[r28]
                                                r10 = upvalueValues[upvalues[8]]
                                                r17 = 0
                                                r28 = state(r10, r17)
                                                state = 43
                                            end
                                        end
                                    else
                                        if state == 43 then
                                            state = {}
                                            r28 = state
                                            r17 = upvalueValues[upvalues[9]]
                                            r5 = r17
                                            r17 = 1
                                            r14 = r17
                                            r17 = 0
                                            r2 = r14 < r17
                                            r10 = 1
                                            r17 = r10 - r14
                                            state = 44
                                        end
                                    end
                                else
                                    if state <= 45 then
                                        if state <= 44 then
                                            if state == 44 then
                                                r17 = r17 + r14
                                                r30 = not r2
                                                r10 = r17 <= r5
                                                r10 = r30 and r10
                                                r30 = r17 >= r5
                                                r30 = r2 and r30
                                                r10 = r30 or r10
                                                r30 = (45)
                                                state = r10 and r30
                                                r10 = (46)
                                                state = state or r10
                                            end
                                        else
                                            if state == 45 then
                                                state = upvalueValues[upvalues[1]]
                                                r10 = r17
                                                r8 = 0
                                                r20 = 255
                                                r30 = state(r8, r20)
                                                r28[r10] = r30
                                                r10 = nil
                                                state = 44
                                            end
                                        end
                                    else
                                        if state == 46 then
                                            state = upvalueValues[upvalues[10]]
                                            r10 = upvalueValues[upvalues[11]]
                                            r28[state] = r10
                                            state = upvalueValues[upvalues[12]]
                                            r10 = {
                                                state(r28)
                                            }
                                            ReturnVal = {
                                                unpack(r10)
                                            }
                                            state = nil
                                        end
                                    end
                                end
                            end
                        end
                    end
                else
                    if state <= 63 then
                        if state <= 56 then
                            if state <= 50 then
                                -- createClosure5 entry 8550832 -> 47, states 47-50
                                if state <= 48 then
                                    if state <= 47 then
                                        if state == 47 then -- entry 8550832 -> 47
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
                                            r28 = "l1"
                                            ReturnVal = _env[r28]
                                            r28 = "l1"
                                            _env[r28] = state
                                            r28 = "l2"
                                            _env[r28] = ReturnVal
                                            r28 = upvalueValues[upvalues[1]]
                                            r10 = r28()
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
                                -- createClosure4 entry 4180727 -> 51, states 51-56
                                if state <= 53 then
                                    if state <= 52 then
                                        if state <= 51 then
                                            if state == 51 then -- entry 4180727 -> 51
                                                r28 = upvalueValues[upvalues[1]]
                                                ReturnVal = #r28
                                                r28 = 0
                                                state = ReturnVal == r28
                                                state = state and (52) or (53)
                                            end
                                        else
                                            if state == 52 then
                                                r10 = upvalueValues[upvalues[2]]
                                                r17 = 229
                                                r28 = r10 * r17
                                                r10 = 20233389401293
                                                ReturnVal = r28 + r10
                                                r28 = 35184372088832
                                                state = ReturnVal % r28
                                                upvalueValues[upvalues[2]] = state
                                                r28 = upvalueValues[upvalues[3]]
                                                r10 = 1
                                                ReturnVal = r28 ~= r10
                                                state = 54
                                            end
                                        end
                                    else
                                        if state == 53 then
                                            r17 = "table"
                                            r10 = _env[r17]
                                            r17 = "remove"
                                            r28 = r10[r17]
                                            r17 = upvalueValues[upvalues[1]]
                                            r10 = {
                                                r28(r17)
                                            }
                                            ReturnVal = {
                                                unpack(r10)
                                            }
                                            state = nil
                                        end
                                    end
                                else
                                    if state <= 55 then
                                        if state <= 54 then
                                            if state == 54 then
                                                r10 = upvalueValues[upvalues[3]]
                                                r17 = 91
                                                r28 = r10 * r17
                                                r10 = 257
                                                ReturnVal = r28 % r10
                                                upvalueValues[upvalues[3]] = ReturnVal
                                                state = 55
                                            end
                                        else
                                            if state == 55 then
                                                r10 = upvalueValues[upvalues[3]]
                                                r17 = 1
                                                r28 = r10 ~= r17
                                                state = r28 and (56) or (54)
                                            end
                                        end
                                    else
                                        if state == 56 then
                                            r17 = 32
                                            r10 = upvalueValues[upvalues[3]]
                                            r28 = r10 % r17
                                            r5 = upvalueValues[upvalues[4]]
                                            r20 = 2
                                            r30 = upvalueValues[upvalues[2]]
                                            r6 = upvalueValues[upvalues[3]]
                                            r13 = r6 - r28
                                            r6 = 32
                                            r27 = r13 / r6
                                            r26 = 13
                                            r4 = r26 - r27
                                            r8 = r20 ^ r4
                                            r2 = r30 / r8
                                            r14 = r5(r2)
                                            r5 = 4294967296
                                            r17 = r14 % r5
                                            r14 = 2
                                            r5 = r14 ^ r28
                                            r10 = r17 / r5
                                            r8 = 1
                                            r5 = upvalueValues[upvalues[4]]
                                            r30 = r10 % r8
                                            r8 = 4294967296
                                            r2 = r30 * r8
                                            r14 = r5(r2)
                                            r5 = upvalueValues[upvalues[4]]
                                            r2 = r5(r10)
                                            r17 = r14 + r2
                                            r20 = 256
                                            r28 = nil
                                            r14 = 65536
                                            r5 = r17 % r14
                                            r2 = r17 - r5
                                            r30 = 65536
                                            r14 = r2 / r30
                                            r30 = 256
                                            r2 = r5 % r30
                                            r8 = r5 - r2
                                            r30 = r8 / r20
                                            r26 = 256
                                            r10 = nil
                                            r20 = 256
                                            r8 = r14 % r20
                                            r4 = r14 - r8
                                            r20 = r4 / r26
                                            r4 = {
                                                r2,
                                                r30,
                                                r8,
                                                r20
                                            }
                                            r8 = nil
                                            r14 = nil
                                            r2 = nil
                                            r17 = nil
                                            r30 = nil
                                            upvalueValues[upvalues[1]] = r4
                                            r5 = nil
                                            r20 = nil
                                            state = 53
                                        end
                                    end
                                end
                            end
                        else
                            -- createClosure4 entry 7411320 -> 57, states 57-63
                            if state <= 60 then
                                if state <= 58 then
                                    if state <= 57 then
                                        if state == 57 then -- entry 7411320 -> 57
                                            r10 = args[2]
                                            state = upvalueValues[upvalues[1]]
                                            r17 = state
                                            r28 = args[1]
                                            state = r17[r10]
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
                                            r5 = ReturnVal
                                            r14 = 35184372088832
                                            ReturnVal = r10 % r14
                                            upvalueValues[upvalues[4]] = ReturnVal
                                            r30 = 255
                                            r2 = r10 % r30
                                            r30 = 2
                                            r14 = r2 + r30
                                            upvalueValues[upvalues[5]] = r14
                                            r8 = "string"
                                            r30 = _env[r8]
                                            r8 = "len"
                                            r2 = r30[r8]
                                            r30 = r2(r28)
                                            r2 = ""
                                            r17[r10] = r2
                                            r4 = 1
                                            r26 = r4
                                            r4 = 0
                                            r27 = r26 < r4
                                            r8 = 1
                                            r4 = r8 - r26
                                            r20 = r30
                                            r2 = 89
                                            state = 61
                                        end
                                    else
                                        if state == 60 then
                                            ReturnVal = {
                                                r10
                                            }
                                            state = nil
                                        end
                                    end
                                end
                            else
                                if state <= 62 then
                                    if state <= 61 then
                                        if state == 61 then
                                            r4 = r4 + r26
                                            r13 = not r27
                                            r8 = r4 <= r20
                                            r8 = r13 and r8
                                            r13 = r4 >= r20
                                            r13 = r27 and r13
                                            r8 = r13 or r8
                                            r13 = (62)
                                            state = r8 and r13
                                            r8 = (63)
                                            state = state or r8
                                        end
                                    else
                                        if state == 62 then
                                            r22 = "string"
                                            r7 = _env[r22]
                                            r8 = r4
                                            r22 = "byte"
                                            r11 = r7[r22]
                                            r7 = r11(r28, r8)
                                            r8 = nil
                                            r11 = upvalueValues[upvalues[6]]
                                            r22 = r11()
                                            r24 = r7 + r22
                                            r6 = r24 + r2
                                            r24 = 256
                                            r13 = r6 % r24
                                            r2 = r13
                                            r24 = r17[r10]
                                            r22 = 1
                                            r7 = r2 + r22
                                            r11 = r5[r7]
                                            r6 = r24 .. r11
                                            r17[r10] = r6
                                            state = 61
                                        end
                                    end
                                else
                                    if state == 63 then
                                        r30 = nil
                                        r5 = nil
                                        r2 = nil
                                        state = 60
                                    end
                                end
                            end
                        end
                    else
                        if state <= 64 then
                            -- createClosure6 entry 7453417 -> 64, states 64-64
                            if state == 64 then -- entry 7453417 -> 64
                                r28 = args[1]
                                r10 = upvalueValues[upvalues[1]]
                                state = "WaitForChild"
                                state = r28[state]
                                r17 = upvalueValues[upvalues[2]]
                                r14 = "\140'<'"
                                r2 = 31902570150407
                                r5 = r17(r14, r2)
                                ReturnVal = r10[r5]
                                state = state(r28, ReturnVal)
                                r17 = upvalueValues[upvalues[1]]
                                r10 = state
                                r5 = upvalueValues[upvalues[2]]
                                r30 = 11578972345615
                                r2 = "\188#\250\017"
                                r14 = r5(r2, r30)
                                ReturnVal = r17[r14]
                                state = "WaitForChild"
                                state = r10[state]
                                state = state(r10, ReturnVal)
                                r2 = "Ys\197|p\1433"
                                ReturnVal = upvalueValues[upvalues[1]]
                                r28 = nil
                                r17 = state
                                r5 = upvalueValues[upvalues[2]]
                                r30 = 21876013656010
                                r14 = r5(r2, r30)
                                state = ReturnVal[r14]
                                ReturnVal = upvalueValues[upvalues[3]]
                                r10 = nil
                                r17[state] = ReturnVal
                                r17 = nil
                                ReturnVal = {}
                                state = nil
                            end
                        else
                            -- createClosure2 entry 3056599 -> 65, states 65-65
                            if state == 65 then -- entry 3056599 -> 65
                                r17 = 1526765
                                r10 = "anTg"
                                r28 = r10 ^ r17
                                ReturnVal = 555396
                                state = ReturnVal - r28
                                r28 = state
                                ReturnVal = "gbK6F2cNVxxn"
                                state = ReturnVal / r28
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
        upvalueValues = {}
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