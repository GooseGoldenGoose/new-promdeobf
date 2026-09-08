return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, releaseUpvalue, createUpvalueProxy, upvalueValues, createClosure4, allocUpvalue, createClosure2, createClosure1, createClosure3, currentUpvalueId, upvalueRefCounts, vm, releaseUpvalues, createClosure0, createClosure, createClosure5)
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
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return -3126535
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -3126535
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
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, ReturnVal, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33
            while state do
                if state <= 51 then
                    if state <= 38 then
                        if state <= 37 then
                            if state <= 36 then
                                -- root entry 4249993 -> 1, states 1-36
                                if state <= 18 then
                                    if state <= 9 then
                                        if state <= 5 then
                                            if state <= 3 then
                                                if state <= 2 then
                                                    if state <= 1 then
                                                        if state == 1 then -- entry 4249993 -> 1
                                                            r28 = allocUpvalue()
                                                            state = true
                                                            upvalueValues[r28] = state
                                                            r21 = "string"
                                                            ReturnVal = _env[r21]
                                                            r21 = "gmatch"
                                                            state = ReturnVal[r21]
                                                            r21 = allocUpvalue()
                                                            upvalueValues[r21] = state
                                                            r23 = allocUpvalue()
                                                            state = createClosure5(37, {})
                                                            r1 = allocUpvalue()
                                                            upvalueValues[r1] = state
                                                            state = false
                                                            upvalueValues[r23] = state
                                                            r22 = "pcall"
                                                            r31 = _env[r22]
                                                            r19 = createClosure4(38, {
                                                                r23
                                                            })
                                                            r22 = r31(r19)
                                                            state = r22 and (2) or (3)
                                                            r26 = args
                                                            ReturnVal = r22
                                                        end
                                                    else
                                                        if state == 2 then
                                                            r31 = upvalueValues[r23]
                                                            ReturnVal = r31
                                                            state = 3
                                                        end
                                                    end
                                                else
                                                    if state == 3 then
                                                        r31 = ReturnVal
                                                        r22 = "math"
                                                        ReturnVal = _env[r22]
                                                        r22 = "random"
                                                        state = ReturnVal[r22]
                                                        r22 = allocUpvalue()
                                                        upvalueValues[r22] = state
                                                        r19 = "table"
                                                        ReturnVal = _env[r19]
                                                        r19 = "concat"
                                                        state = ReturnVal[r19]
                                                        r19 = state
                                                        r13 = state
                                                        r20 = "table"
                                                        r9 = _env[r20]
                                                        state = r9 and (4) or (5)
                                                        r2 = r9
                                                    end
                                                end
                                            else
                                                if state <= 4 then
                                                    if state == 4 then
                                                        r7 = "table"
                                                        r20 = _env[r7]
                                                        r7 = "unpack"
                                                        r9 = r20[r7]
                                                        r2 = r9
                                                        state = 5
                                                    end
                                                else
                                                    if state == 5 then
                                                        state = r13
                                                        state = r2 and (6) or (7)
                                                        ReturnVal = r2
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 7 then
                                                if state <= 6 then
                                                    if state == 6 then
                                                        r2 = allocUpvalue()
                                                        r8 = createClosure1(39, {})
                                                        upvalueValues[r2] = ReturnVal
                                                        state = upvalueValues[r22]
                                                        r13 = 3
                                                        r9 = 65
                                                        ReturnVal = state(r13, r9)
                                                        r13 = allocUpvalue()
                                                        upvalueValues[r13] = ReturnVal
                                                        state = 0
                                                        r9 = state
                                                        r7 = "pcall"
                                                        ReturnVal = _env[r7]
                                                        state = 0
                                                        r7 = {
                                                            ReturnVal(r8)
                                                        }
                                                        r20 = state
                                                        state = {
                                                            unpack(r7)
                                                        }
                                                        r7 = state
                                                        ReturnVal = 2
                                                        state = r7[ReturnVal]
                                                        r8 = state
                                                        ReturnVal = "tonumber"
                                                        state = _env[ReturnVal]
                                                        r25 = upvalueValues[r21]
                                                        r14 = "tostring"
                                                        r5 = _env[r14]
                                                        r14 = r5(r8)
                                                        r5 = ":(%d*):"
                                                        r12 = r25(r14, r5)
                                                        r25 = {
                                                            r12()
                                                        }
                                                        ReturnVal = state(unpack(r25))
                                                        r25 = allocUpvalue()
                                                        upvalueValues[r25] = ReturnVal
                                                        r12 = upvalueValues[r13]
                                                        r5 = r12
                                                        r12 = 1
                                                        r14 = r12
                                                        r12 = 0
                                                        r11 = r14 < r12
                                                        ReturnVal = 1
                                                        r12 = ReturnVal - r14
                                                        state = 8
                                                    end
                                                else
                                                    if state == 7 then
                                                        r13 = "unpack"
                                                        r2 = _env[r13]
                                                        ReturnVal = r2
                                                        state = 6
                                                    end
                                                end
                                            else
                                                if state <= 8 then
                                                    if state == 8 then
                                                        r12 = r12 + r14
                                                        ReturnVal = r12 <= r5
                                                        r17 = not r11
                                                        ReturnVal = r17 and ReturnVal
                                                        r17 = r12 >= r5
                                                        r17 = r11 and r17
                                                        ReturnVal = r17 or ReturnVal
                                                        r17 = (9)
                                                        state = ReturnVal and r17
                                                        ReturnVal = (10)
                                                        state = state or ReturnVal
                                                    end
                                                else
                                                    if state == 9 then
                                                        r17 = allocUpvalue()
                                                        upvalueValues[r17] = r12
                                                        r3 = "math"
                                                        ReturnVal = _env[r3]
                                                        r3 = "random"
                                                        state = ReturnVal[r3]
                                                        r10 = 100
                                                        r3 = 1
                                                        ReturnVal = state(r3, r10)
                                                        r3 = allocUpvalue()
                                                        upvalueValues[r3] = ReturnVal
                                                        state = upvalueValues[r22]
                                                        r16 = 255
                                                        r10 = 0
                                                        ReturnVal = state(r10, r16)
                                                        r10 = allocUpvalue()
                                                        upvalueValues[r10] = ReturnVal
                                                        state = upvalueValues[r22]
                                                        r27 = upvalueValues[r3]
                                                        r16 = 1
                                                        ReturnVal = state(r16, r27)
                                                        r16 = allocUpvalue()
                                                        upvalueValues[r16] = ReturnVal
                                                        ReturnVal = upvalueValues[r22]
                                                        r15 = 2
                                                        r32 = 1
                                                        r27 = ReturnVal(r32, r15)
                                                        ReturnVal = 1
                                                        state = r27 == ReturnVal
                                                        r27 = allocUpvalue()
                                                        upvalueValues[r27] = state
                                                        r24 = "tostring"
                                                        r4 = _env[r24]
                                                        r29 = upvalueValues[r22]
                                                        r33 = 10000
                                                        r6 = 0
                                                        r30 = {
                                                            r29(r6, r33)
                                                        }
                                                        r24 = r4(unpack(r30))
                                                        state = "gsub"
                                                        state = r8[state]
                                                        r4 = ":"
                                                        r18 = r24 .. r4
                                                        r15 = ":"
                                                        r32 = r15 .. r18
                                                        ReturnVal = ":(%d*):"
                                                        state = state(r8, ReturnVal, r32)
                                                        r32 = allocUpvalue()
                                                        r18 = createClosure4(40, {
                                                            r22,
                                                            r17,
                                                            r13,
                                                            r21,
                                                            r28,
                                                            r25,
                                                            r27,
                                                            r32,
                                                            r3,
                                                            r16,
                                                            r10,
                                                            r2
                                                        })
                                                        upvalueValues[r32] = state
                                                        r15 = "pcall"
                                                        ReturnVal = _env[r15]
                                                        r15 = {
                                                            ReturnVal(r18)
                                                        }
                                                        state = {
                                                            unpack(r15)
                                                        }
                                                        r15 = state
                                                        state = upvalueValues[r27]
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
                                                            r5 = upvalueValues[r28]
                                                            state = r5 and (13) or (14)
                                                            r12 = r5
                                                        end
                                                    else
                                                        if state == 11 then
                                                            r18 = upvalueValues[r28]
                                                            state = r18 and (15) or (16)
                                                            ReturnVal = r18
                                                        end
                                                    end
                                                else
                                                    if state == 12 then
                                                        r4 = upvalueValues[r28]
                                                        state = r4 and (17) or (18)
                                                        r18 = r4
                                                    end
                                                end
                                            else
                                                if state <= 13 then
                                                    if state == 13 then
                                                        r5 = r9 == r20
                                                        r12 = r5
                                                        state = 14
                                                    end
                                                else
                                                    if state == 14 then
                                                        upvalueValues[r28] = r12
                                                        state = upvalueValues[r28]
                                                        state = state and (19) or (20)
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 16 then
                                                if state <= 15 then
                                                    if state == 15 then
                                                        r30 = 1
                                                        r29 = r15[r30]
                                                        r30 = false
                                                        r24 = r29 == r30
                                                        r4 = state
                                                        state = r24 and (21) or (22)
                                                        r18 = r24
                                                    end
                                                else
                                                    if state == 16 then
                                                        upvalueValues[r28] = ReturnVal
                                                        state = 23
                                                    end
                                                end
                                            else
                                                if state <= 17 then
                                                    if state == 17 then
                                                        r24 = 1
                                                        r4 = r15[r24]
                                                        r18 = r4
                                                        state = 18
                                                    end
                                                else
                                                    if state == 18 then
                                                        upvalueValues[r28] = r18
                                                        r30 = upvalueValues[r16]
                                                        r6 = 1
                                                        r29 = r30 + r6
                                                        r24 = r15[r29]
                                                        r4 = r9 + r24
                                                        r24 = 256
                                                        state = r4 % r24
                                                        r9 = state
                                                        r29 = upvalueValues[r10]
                                                        r24 = r20 + r29
                                                        r29 = 256
                                                        r4 = r24 % r29
                                                        r20 = r4
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
                                                        r30 = 2
                                                        r29 = r15[r30]
                                                        r30 = upvalueValues[r32]
                                                        r24 = r29 == r30
                                                        r18 = r24
                                                        state = 22
                                                    end
                                                end
                                            else
                                                if state <= 22 then
                                                    if state == 22 then
                                                        state = r4
                                                        ReturnVal = r18
                                                        state = 16
                                                    end
                                                else
                                                    if state == 23 then
                                                        r3 = releaseUpvalue(r3)
                                                        r32 = releaseUpvalue(r32)
                                                        r17 = releaseUpvalue(r17)
                                                        r27 = releaseUpvalue(r27)
                                                        r16 = releaseUpvalue(r16)
                                                        r15 = nil
                                                        r10 = releaseUpvalue(r10)
                                                        state = 8
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 25 then
                                                if state <= 24 then
                                                    if state == 24 then
                                                        r13 = releaseUpvalue(r13)
                                                        r19 = nil
                                                        r9 = nil
                                                        r31 = nil
                                                        r23 = releaseUpvalue(r23)
                                                        r22 = releaseUpvalue(r22)
                                                        r21 = releaseUpvalue(r21)
                                                        r1 = releaseUpvalue(r1)
                                                        r25 = releaseUpvalue(r25)
                                                        r20 = nil
                                                        r8 = nil
                                                        r28 = releaseUpvalue(r28)
                                                        r2 = releaseUpvalue(r2)
                                                        r7 = nil
                                                        r21 = nil
                                                        r28 = nil
                                                        r7 = {}
                                                        r31 = "math"
                                                        r23 = _env[r31]
                                                        r31 = "floor"
                                                        r1 = r23[r31]
                                                        r20 = allocUpvalue()
                                                        r23 = allocUpvalue()
                                                        upvalueValues[r23] = r1
                                                        r22 = "math"
                                                        r31 = _env[r22]
                                                        r22 = "random"
                                                        r1 = r31[r22]
                                                        r19 = "table"
                                                        r22 = _env[r19]
                                                        r19 = "remove"
                                                        r31 = r22[r19]
                                                        r13 = allocUpvalue()
                                                        r9 = {}
                                                        r2 = "string"
                                                        r19 = _env[r2]
                                                        r2 = "char"
                                                        r22 = r19[r2]
                                                        r2 = allocUpvalue()
                                                        r19 = 0
                                                        upvalueValues[r2] = r19
                                                        r19 = 2
                                                        upvalueValues[r13] = r19
                                                        r25 = 256
                                                        r19 = {}
                                                        upvalueValues[r20] = r9
                                                        r11 = r25
                                                        r25 = 1
                                                        r17 = r25
                                                        r25 = 0
                                                        r3 = r17 < r25
                                                        r8 = 1
                                                        r25 = r8 - r17
                                                        r9 = 0
                                                        state = 26
                                                    end
                                                else
                                                    if state == 25 then
                                                        state = createClosure4(52, {
                                                            r1
                                                        })
                                                        r5 = {
                                                            state()
                                                        }
                                                        ReturnVal = {
                                                            unpack(r5)
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            else
                                                if state <= 26 then
                                                    if state == 26 then
                                                        r25 = r25 + r17
                                                        r8 = r25 <= r11
                                                        r10 = not r3
                                                        r8 = r10 and r8
                                                        r10 = r25 >= r11
                                                        r10 = r3 and r10
                                                        r8 = r10 or r8
                                                        r10 = (27)
                                                        state = r8 and r10
                                                        r8 = (28)
                                                        state = state or r8
                                                    end
                                                else
                                                    if state == 27 then
                                                        r8 = r25
                                                        r10 = r8
                                                        r7[r8] = r10
                                                        r8 = nil
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
                                                            r25 = #r7
                                                            r11 = 0
                                                            r8 = r25 == r11
                                                            state = 29
                                                        end
                                                    else
                                                        if state == 29 then
                                                            r25 = 1
                                                            r11 = #r7
                                                            r8 = r1(r25, r11)
                                                            r25 = r31(r7, r8)
                                                            r11 = upvalueValues[r20]
                                                            r10 = 1
                                                            r3 = r25 - r10
                                                            r17 = r22(r3)
                                                            r8 = nil
                                                            r11[r25] = r17
                                                            r25 = nil
                                                            state = 30
                                                        end
                                                    end
                                                else
                                                    if state == 30 then
                                                        r25 = #r7
                                                        r11 = 0
                                                        r8 = r25 == r11
                                                        state = r8 and (31) or (29)
                                                    end
                                                end
                                            else
                                                if state <= 31 then
                                                    if state == 31 then
                                                        r24 = nil
                                                        r25 = allocUpvalue()
                                                        r8 = {}
                                                        r11 = createClosure0(56, {
                                                            r25,
                                                            r2,
                                                            r13,
                                                            r23
                                                        })
                                                        upvalueValues[r25] = r8
                                                        r8 = allocUpvalue()
                                                        r17 = allocUpvalue()
                                                        upvalueValues[r8] = r11
                                                        r11 = {}
                                                        r10 = {}
                                                        upvalueValues[r17] = r11
                                                        r1 = nil
                                                        r27 = "__index"
                                                        r23 = releaseUpvalue(r23)
                                                        r19 = nil
                                                        r19 = 1582621901536
                                                        r31 = nil
                                                        r3 = "setmetatable"
                                                        r11 = _env[r3]
                                                        r15 = "__metatable"
                                                        r22 = nil
                                                        r22 = "\223"
                                                        r9 = nil
                                                        r7 = nil
                                                        r32 = upvalueValues[r17]
                                                        r16 = {
                                                            [r27] = r32,
                                                            [r15] = r24
                                                        }
                                                        r3 = r11(r10, r16)
                                                        r11 = createClosure3(62, {
                                                            r17,
                                                            r25,
                                                            r20,
                                                            r2,
                                                            r13,
                                                            r8
                                                        })
                                                        r28 = r11
                                                        r2 = releaseUpvalue(r2)
                                                        r13 = releaseUpvalue(r13)
                                                        r31 = r28(r22, r19)
                                                        r25 = releaseUpvalue(r25)
                                                        r21 = r3
                                                        r23 = r21[r31]
                                                        r17 = releaseUpvalue(r17)
                                                        r8 = releaseUpvalue(r8)
                                                        r20 = releaseUpvalue(r20)
                                                        r2 = "\174"
                                                        r13 = 32752733567891
                                                        r19 = r28(r2, r13)
                                                        r22 = r21[r19]
                                                        r31 = 1
                                                        r19 = 2
                                                        r1 = {
                                                            [r23] = r31,
                                                            [r22] = r19
                                                        }
                                                        r31 = "next"
                                                        r23 = _env[r31]
                                                        r19 = {
                                                            r23(r1)
                                                        }
                                                        r22 = r19[2]
                                                        r31 = r19[1]
                                                        r19 = "pairs"
                                                        r23 = _env[r19]
                                                        r9 = {
                                                            r23(r1)
                                                        }
                                                        r19 = r9[1]
                                                        r13 = r9[3]
                                                        r2 = r9[2]
                                                        state = 32
                                                    end
                                                else
                                                    if state == 32 then
                                                        r13 = r19(r2, r13)
                                                        state = r13 and (33) or (34)
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 34 then
                                                if state <= 33 then
                                                    if state == 33 then
                                                        r23 = r13
                                                        r9 = r23 ~= r31
                                                        state = r9 and (35) or (36)
                                                    end
                                                else
                                                    if state == 34 then
                                                        r1 = nil
                                                        r22 = nil
                                                        r31 = nil
                                                        r28 = nil
                                                        r21 = nil
                                                        ReturnVal = {}
                                                        state = nil
                                                    end
                                                end
                                            else
                                                if state <= 35 then
                                                    if state == 35 then
                                                        r20 = "error"
                                                        r9 = _env[r20]
                                                        r11 = 23702248762141
                                                        r25 = "\021\029\170\203\157\021\030ljV\207\024\":\004\176\141\228]\246Q\218\182"
                                                        r8 = r28(r25, r11)
                                                        r7 = r21[r8]
                                                        r20 = r9(r7)
                                                        state = 36
                                                    end
                                                else
                                                    if state == 36 then
                                                        r23 = nil
                                                        state = 34
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure5 entry 14566418 -> 37, states 37-37
                                if state == 37 then -- entry 14566418 -> 37
                                    ReturnVal = "error"
                                    state = _env[ReturnVal]
                                    r26 = "Tamper Detected!"
                                    ReturnVal = state(r26)
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        else
                            -- createClosure4 entry 7203153 -> 38, states 38-38
                            if state == 38 then -- entry 7203153 -> 38
                                state = true
                                upvalueValues[upvalues[1]] = state
                                ReturnVal = {}
                                state = nil
                            end
                        end
                    else
                        if state <= 39 then
                            -- createClosure1 entry 10720599 -> 39, states 39-39
                            if state == 39 then -- entry 10720599 -> 39
                                r28 = "PY7twad"
                                r21 = 3977098
                                r26 = r28 ^ r21
                                ReturnVal = 5577099
                                state = ReturnVal - r26
                                r26 = state
                                ReturnVal = "MKczz4R1yA"
                                state = ReturnVal / r26
                                ReturnVal = {
                                    state
                                }
                                state = nil
                            end
                        else
                            -- createClosure4 entry 14143142 -> 40, states 40-51
                            if state <= 45 then
                                if state <= 42 then
                                    if state <= 41 then
                                        if state <= 40 then
                                            if state == 40 then -- entry 14143142 -> 40
                                                r28 = upvalueValues[upvalues[1]]
                                                r23 = 2
                                                r1 = 1
                                                r21 = r28(r1, r23)
                                                r28 = 1
                                                r26 = r21 == r28
                                                state = r26 and (41) or (42)
                                                ReturnVal = r26
                                            end
                                        else
                                            if state == 41 then
                                                state = ReturnVal and (43) or (44)
                                            end
                                        end
                                    else
                                        if state == 42 then
                                            r28 = upvalueValues[upvalues[2]]
                                            r21 = upvalueValues[upvalues[3]]
                                            r26 = r28 == r21
                                            ReturnVal = r26
                                            state = 41
                                        end
                                    end
                                else
                                    if state <= 44 then
                                        if state <= 43 then
                                            if state == 43 then
                                                r2 = createClosure2(69, {})
                                                ReturnVal = "tonumber"
                                                state = _env[ReturnVal]
                                                r26 = upvalueValues[upvalues[4]]
                                                r1 = "tostring"
                                                r21 = _env[r1]
                                                r19 = "pcall"
                                                r22 = _env[r19]
                                                r19 = {
                                                    r22(r2)
                                                }
                                                r31 = {
                                                    unpack(r19)
                                                }
                                                r22 = 2
                                                r23 = r31[r22]
                                                r1 = r21(r23)
                                                r21 = ":(%d*):"
                                                r28 = r26(r1, r21)
                                                r26 = {
                                                    r28()
                                                }
                                                ReturnVal = state(unpack(r26))
                                                r26 = ReturnVal
                                                r28 = upvalueValues[upvalues[5]]
                                                state = r28 and (45) or (46)
                                                ReturnVal = r28
                                            end
                                        else
                                            if state == 44 then
                                                state = upvalueValues[upvalues[7]]
                                                state = state and (47) or (48)
                                            end
                                        end
                                    else
                                        if state == 45 then
                                            r21 = upvalueValues[upvalues[6]]
                                            r28 = r21 == r26
                                            ReturnVal = r28
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
                                                r26 = nil
                                                state = 44
                                            end
                                        else
                                            if state == 47 then
                                                r26 = "error"
                                                state = _env[r26]
                                                r28 = upvalueValues[upvalues[8]]
                                                r21 = 0
                                                r26 = state(r28, r21)
                                                state = 48
                                            end
                                        end
                                    else
                                        if state == 48 then
                                            state = {}
                                            r26 = state
                                            r21 = upvalueValues[upvalues[9]]
                                            r1 = r21
                                            r21 = 1
                                            r23 = r21
                                            r21 = 0
                                            r31 = r23 < r21
                                            r28 = 1
                                            r21 = r28 - r23
                                            state = 49
                                        end
                                    end
                                else
                                    if state <= 50 then
                                        if state <= 49 then
                                            if state == 49 then
                                                r22 = not r31
                                                r21 = r21 + r23
                                                r28 = r21 <= r1
                                                r28 = r22 and r28
                                                r22 = r21 >= r1
                                                r22 = r31 and r22
                                                r28 = r22 or r28
                                                r22 = (50)
                                                state = r28 and r22
                                                r28 = (51)
                                                state = state or r28
                                            end
                                        else
                                            if state == 50 then
                                                r28 = r21
                                                state = upvalueValues[upvalues[1]]
                                                r2 = 255
                                                r19 = 0
                                                r22 = state(r19, r2)
                                                r26[r28] = r22
                                                r28 = nil
                                                state = 49
                                            end
                                        end
                                    else
                                        if state == 51 then
                                            state = upvalueValues[upvalues[10]]
                                            r28 = upvalueValues[upvalues[11]]
                                            r26[state] = r28
                                            state = upvalueValues[upvalues[12]]
                                            r28 = {
                                                state(r26)
                                            }
                                            ReturnVal = {
                                                unpack(r28)
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
                            -- createClosure4 entry 1493659 -> 52, states 52-55
                            if state <= 53 then
                                if state <= 52 then
                                    if state == 52 then -- entry 1493659 -> 52
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
                                        r26 = "l1"
                                        ReturnVal = _env[r26]
                                        r26 = "l1"
                                        _env[r26] = state
                                        r26 = "l2"
                                        _env[r26] = ReturnVal
                                        r26 = upvalueValues[upvalues[1]]
                                        r28 = r26()
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
                            -- createClosure0 entry 2914624 -> 56, states 56-61
                            if state <= 58 then
                                if state <= 57 then
                                    if state <= 56 then
                                        if state == 56 then -- entry 2914624 -> 56
                                            r26 = upvalueValues[upvalues[1]]
                                            ReturnVal = #r26
                                            r26 = 0
                                            state = ReturnVal == r26
                                            state = state and (57) or (58)
                                        end
                                    else
                                        if state == 57 then
                                            r28 = upvalueValues[upvalues[2]]
                                            r21 = 113
                                            r26 = r28 * r21
                                            r28 = 3105170441637
                                            ReturnVal = r26 + r28
                                            r26 = 35184372088832
                                            state = ReturnVal % r26
                                            upvalueValues[upvalues[2]] = state
                                            r26 = upvalueValues[upvalues[3]]
                                            r28 = 1
                                            ReturnVal = r26 ~= r28
                                            state = 59
                                        end
                                    end
                                else
                                    if state == 58 then
                                        r21 = "table"
                                        r28 = _env[r21]
                                        r21 = "remove"
                                        r26 = r28[r21]
                                        r21 = upvalueValues[upvalues[1]]
                                        r28 = {
                                            r26(r21)
                                        }
                                        ReturnVal = {
                                            unpack(r28)
                                        }
                                        state = nil
                                    end
                                end
                            else
                                if state <= 60 then
                                    if state <= 59 then
                                        if state == 59 then
                                            r28 = upvalueValues[upvalues[3]]
                                            r21 = 237
                                            r26 = r28 * r21
                                            r28 = 257
                                            ReturnVal = r26 % r28
                                            upvalueValues[upvalues[3]] = ReturnVal
                                            state = 60
                                        end
                                    else
                                        if state == 60 then
                                            r28 = upvalueValues[upvalues[3]]
                                            r21 = 1
                                            r26 = r28 ~= r21
                                            state = r26 and (61) or (59)
                                        end
                                    end
                                else
                                    if state == 61 then
                                        r21 = 32
                                        r28 = upvalueValues[upvalues[3]]
                                        r26 = r28 % r21
                                        r1 = upvalueValues[upvalues[4]]
                                        r22 = upvalueValues[upvalues[2]]
                                        r2 = 2
                                        r8 = upvalueValues[upvalues[3]]
                                        r7 = r8 - r26
                                        r8 = 32
                                        r20 = r7 / r8
                                        r9 = 13
                                        r13 = r9 - r20
                                        r19 = r2 ^ r13
                                        r31 = r22 / r19
                                        r23 = r1(r31)
                                        r1 = 4294967296
                                        r19 = 1
                                        r21 = r23 % r1
                                        r23 = 2
                                        r1 = r23 ^ r26
                                        r28 = r21 / r1
                                        r1 = upvalueValues[upvalues[4]]
                                        r22 = r28 % r19
                                        r19 = 4294967296
                                        r31 = r22 * r19
                                        r23 = r1(r31)
                                        r1 = upvalueValues[upvalues[4]]
                                        r31 = r1(r28)
                                        r21 = r23 + r31
                                        r22 = 65536
                                        r23 = 65536
                                        r1 = r21 % r23
                                        r9 = 256
                                        r28 = nil
                                        r2 = 256
                                        r31 = r21 - r1
                                        r23 = r31 / r22
                                        r22 = 256
                                        r31 = r1 % r22
                                        r21 = nil
                                        r19 = r1 - r31
                                        r22 = r19 / r2
                                        r2 = 256
                                        r19 = r23 % r2
                                        r1 = nil
                                        r13 = r23 - r19
                                        r2 = r13 / r9
                                        r13 = {
                                            r31,
                                            r22,
                                            r19,
                                            r2
                                        }
                                        r23 = nil
                                        r19 = nil
                                        r22 = nil
                                        r26 = nil
                                        r2 = nil
                                        upvalueValues[upvalues[1]] = r13
                                        r31 = nil
                                        state = 58
                                    end
                                end
                            end
                        end
                    else
                        if state <= 68 then
                            -- createClosure3 entry 12458729 -> 62, states 62-68
                            if state <= 65 then
                                if state <= 63 then
                                    if state <= 62 then
                                        if state == 62 then -- entry 12458729 -> 62
                                            state = upvalueValues[upvalues[1]]
                                            r21 = state
                                            r28 = args[2]
                                            r26 = args[1]
                                            state = r21[r28]
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
                                            r1 = ReturnVal
                                            r23 = 35184372088832
                                            ReturnVal = r28 % r23
                                            upvalueValues[upvalues[4]] = ReturnVal
                                            r22 = 255
                                            r31 = r28 % r22
                                            r22 = 2
                                            r23 = r31 + r22
                                            upvalueValues[upvalues[5]] = r23
                                            r19 = "string"
                                            r22 = _env[r19]
                                            r19 = "len"
                                            r31 = r22[r19]
                                            r22 = r31(r26)
                                            r31 = ""
                                            r21[r28] = r31
                                            r13 = 1
                                            r9 = r13
                                            r13 = 0
                                            r20 = r9 < r13
                                            r19 = 1
                                            r13 = r19 - r9
                                            r2 = r22
                                            r31 = 255
                                            state = 66
                                        end
                                    else
                                        if state == 65 then
                                            ReturnVal = {
                                                r28
                                            }
                                            state = nil
                                        end
                                    end
                                end
                            else
                                if state <= 67 then
                                    if state <= 66 then
                                        if state == 66 then
                                            r7 = not r20
                                            r13 = r13 + r9
                                            r19 = r13 <= r2
                                            r19 = r7 and r19
                                            r7 = r13 >= r2
                                            r7 = r20 and r7
                                            r19 = r7 or r19
                                            r7 = (67)
                                            state = r19 and r7
                                            r19 = (68)
                                            state = state or r19
                                        end
                                    else
                                        if state == 67 then
                                            r14 = "string"
                                            r5 = _env[r14]
                                            r19 = r13
                                            r14 = "byte"
                                            r12 = r5[r14]
                                            r5 = r12(r26, r19)
                                            r12 = upvalueValues[upvalues[6]]
                                            r14 = r12()
                                            r25 = r5 + r14
                                            r8 = r25 + r31
                                            r25 = 256
                                            r7 = r8 % r25
                                            r31 = r7
                                            r25 = r21[r28]
                                            r14 = 1
                                            r5 = r31 + r14
                                            r12 = r1[r5]
                                            r8 = r25 .. r12
                                            r19 = nil
                                            r21[r28] = r8
                                            state = 66
                                        end
                                    end
                                else
                                    if state == 68 then
                                        r22 = nil
                                        r1 = nil
                                        r31 = nil
                                        state = 65
                                    end
                                end
                            end
                        else
                            -- createClosure2 entry 10495451 -> 69, states 69-69
                            if state == 69 then -- entry 10495451 -> 69
                                r28 = "eg1ekCKsuiCS"
                                r21 = 965764
                                r26 = r28 ^ r21
                                ReturnVal = 2313906
                                state = ReturnVal - r26
                                r26 = state
                                ReturnVal = "Ffe3B3Pps3eHZ"
                                state = ReturnVal / r26
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
        upvalueRefCounts = {}
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if upvalueRefCounts[upvalueId] == 0 then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        allocUpvalue = function()
            currentUpvalueId = currentUpvalueId + (1)
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        createClosure0 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function()
                return vm(entryId, {}, captures, gcProxy)
            end
            return closure
        end
        currentUpvalueId = 0
        upvalueValues = {}
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)