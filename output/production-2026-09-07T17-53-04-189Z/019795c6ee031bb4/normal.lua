return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, releaseUpvalues, createClosure3, createClosure, createClosure4, createClosure5, currentUpvalueId, allocUpvalue, createUpvalueProxy, upvalueValues, releaseUpvalue, vm, upvalueRefCounts, createClosure2, createClosure0, createClosure1)
        createClosure1 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1)
                return vm(entryId, {
                    arg1
                }, captures, gcProxy)
            end
            return closure
        end
        upvalueRefCounts = {}
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
        allocUpvalue = function()
            currentUpvalueId = currentUpvalueId + (1)
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
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
        upvalueValues = {}
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
                if upvalueRefCounts[upvalueId] == 0 then
                    upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
                end
                upvalueId = captures[captureIndex]
            end
        end
        currentUpvalueId = 0
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = upvalueRefCounts[captures[captureIndex]] + (1)
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return 3420272
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 3420272
                    end
                })
            end
        end
        createClosure0 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function()
                return vm(entryId, {}, captures, gcProxy)
            end
            return closure
        end
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if 0 == upvalueRefCounts[upvalueId] then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
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
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, ReturnVal, r31, r32, r33
            while state do
                if state <= 46 then
                    if state <= 33 then
                        if state <= 32 then
                            if state <= 31 then
                                -- root entry 11853742 -> 1, states 1-31
                                if state <= 16 then
                                    if state <= 8 then
                                        if state <= 4 then
                                            if state <= 2 then
                                                if state <= 1 then
                                                    if state == 1 then -- entry 11853742 -> 1
                                                        r11 = allocUpvalue()
                                                        state = true
                                                        upvalueValues[r11] = state
                                                        r19 = "string"
                                                        ReturnVal = _env[r19]
                                                        r19 = "gmatch"
                                                        state = ReturnVal[r19]
                                                        r23 = allocUpvalue()
                                                        r19 = allocUpvalue()
                                                        upvalueValues[r19] = state
                                                        state = createClosure3(32, {})
                                                        upvalueValues[r23] = state
                                                        r13 = allocUpvalue()
                                                        r5 = createClosure4(33, {
                                                            r13
                                                        })
                                                        state = false
                                                        upvalueValues[r13] = state
                                                        r30 = "pcall"
                                                        r17 = _env[r30]
                                                        r30 = r17(r5)
                                                        state = r30 and (2) or (3)
                                                        r31 = args
                                                        ReturnVal = r30
                                                    end
                                                else
                                                    if state == 2 then
                                                        r17 = upvalueValues[r13]
                                                        ReturnVal = r17
                                                        state = 3
                                                    end
                                                end
                                            else
                                                if state <= 3 then
                                                    if state == 3 then
                                                        r17 = ReturnVal
                                                        r30 = "math"
                                                        ReturnVal = _env[r30]
                                                        r30 = "random"
                                                        state = ReturnVal[r30]
                                                        r30 = allocUpvalue()
                                                        upvalueValues[r30] = state
                                                        r5 = "table"
                                                        ReturnVal = _env[r5]
                                                        r5 = "concat"
                                                        state = ReturnVal[r5]
                                                        r4 = state
                                                        r5 = state
                                                        r15 = "table"
                                                        r6 = _env[r15]
                                                        state = r6 and (4) or (5)
                                                        r27 = r6
                                                    end
                                                else
                                                    if state == 4 then
                                                        r28 = "table"
                                                        r15 = _env[r28]
                                                        r28 = "unpack"
                                                        r6 = r15[r28]
                                                        r27 = r6
                                                        state = 5
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 6 then
                                                if state <= 5 then
                                                    if state == 5 then
                                                        state = r4
                                                        state = r27 and (6) or (7)
                                                        ReturnVal = r27
                                                    end
                                                else
                                                    if state == 6 then
                                                        r27 = allocUpvalue()
                                                        upvalueValues[r27] = ReturnVal
                                                        state = upvalueValues[r30]
                                                        r4 = 3
                                                        r6 = 65
                                                        ReturnVal = state(r4, r6)
                                                        r4 = allocUpvalue()
                                                        r1 = createClosure1(34, {})
                                                        state = 0
                                                        upvalueValues[r4] = ReturnVal
                                                        r6 = state
                                                        state = 0
                                                        r28 = "pcall"
                                                        ReturnVal = _env[r28]
                                                        r28 = {
                                                            ReturnVal(r1)
                                                        }
                                                        r15 = state
                                                        state = {
                                                            unpack(r28)
                                                        }
                                                        r28 = state
                                                        ReturnVal = 2
                                                        state = r28[ReturnVal]
                                                        r1 = state
                                                        ReturnVal = "tonumber"
                                                        state = _env[ReturnVal]
                                                        r25 = upvalueValues[r19]
                                                        r14 = "tostring"
                                                        r22 = _env[r14]
                                                        r14 = r22(r1)
                                                        r22 = ":(%d*):"
                                                        r24 = r25(r14, r22)
                                                        r25 = {
                                                            r24()
                                                        }
                                                        ReturnVal = state(unpack(r25))
                                                        r25 = allocUpvalue()
                                                        upvalueValues[r25] = ReturnVal
                                                        r24 = upvalueValues[r4]
                                                        r22 = r24
                                                        r24 = 1
                                                        r14 = r24
                                                        r24 = 0
                                                        r20 = r14 < r24
                                                        ReturnVal = 1
                                                        r24 = ReturnVal - r14
                                                        state = 8
                                                    end
                                                end
                                            else
                                                if state <= 7 then
                                                    if state == 7 then
                                                        r4 = "unpack"
                                                        r27 = _env[r4]
                                                        ReturnVal = r27
                                                        state = 6
                                                    end
                                                else
                                                    if state == 8 then
                                                        r2 = not r20
                                                        r24 = r24 + r14
                                                        ReturnVal = r24 <= r22
                                                        ReturnVal = r2 and ReturnVal
                                                        r2 = r24 >= r22
                                                        r2 = r20 and r2
                                                        ReturnVal = r2 or ReturnVal
                                                        r2 = (9)
                                                        state = ReturnVal and r2
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
                                                        r2 = allocUpvalue()
                                                        upvalueValues[r2] = r24
                                                        r21 = "math"
                                                        ReturnVal = _env[r21]
                                                        r21 = "random"
                                                        state = ReturnVal[r21]
                                                        r12 = 100
                                                        r21 = 1
                                                        ReturnVal = state(r21, r12)
                                                        r21 = allocUpvalue()
                                                        upvalueValues[r21] = ReturnVal
                                                        state = upvalueValues[r30]
                                                        r32 = 255
                                                        r12 = 0
                                                        ReturnVal = state(r12, r32)
                                                        r12 = allocUpvalue()
                                                        upvalueValues[r12] = ReturnVal
                                                        state = upvalueValues[r30]
                                                        r29 = upvalueValues[r21]
                                                        r32 = 1
                                                        ReturnVal = state(r32, r29)
                                                        r32 = allocUpvalue()
                                                        upvalueValues[r32] = ReturnVal
                                                        ReturnVal = upvalueValues[r30]
                                                        r7 = 2
                                                        r16 = 1
                                                        r29 = ReturnVal(r16, r7)
                                                        ReturnVal = 1
                                                        state = r29 == ReturnVal
                                                        r29 = allocUpvalue()
                                                        upvalueValues[r29] = state
                                                        r26 = "tostring"
                                                        r18 = _env[r26]
                                                        r8 = upvalueValues[r30]
                                                        r10 = 0
                                                        r3 = 10000
                                                        r33 = {
                                                            r8(r10, r3)
                                                        }
                                                        r26 = r18(unpack(r33))
                                                        state = "gsub"
                                                        state = r1[state]
                                                        r18 = ":"
                                                        r9 = r26 .. r18
                                                        r7 = ":"
                                                        r16 = r7 .. r9
                                                        ReturnVal = ":(%d*):"
                                                        state = state(r1, ReturnVal, r16)
                                                        r16 = allocUpvalue()
                                                        r9 = createClosure5(35, {
                                                            r30,
                                                            r2,
                                                            r4,
                                                            r19,
                                                            r11,
                                                            r25,
                                                            r29,
                                                            r16,
                                                            r21,
                                                            r32,
                                                            r12,
                                                            r27
                                                        })
                                                        upvalueValues[r16] = state
                                                        r7 = "pcall"
                                                        ReturnVal = _env[r7]
                                                        r7 = {
                                                            ReturnVal(r9)
                                                        }
                                                        state = {
                                                            unpack(r7)
                                                        }
                                                        r7 = state
                                                        state = upvalueValues[r29]
                                                        state = state and (11) or (12)
                                                    end
                                                else
                                                    if state == 10 then
                                                        r22 = upvalueValues[r11]
                                                        state = r22 and (13) or (14)
                                                        r24 = r22
                                                    end
                                                end
                                            else
                                                if state <= 11 then
                                                    if state == 11 then
                                                        r9 = upvalueValues[r11]
                                                        state = r9 and (15) or (16)
                                                        ReturnVal = r9
                                                    end
                                                else
                                                    if state == 12 then
                                                        r18 = upvalueValues[r11]
                                                        state = r18 and (17) or (18)
                                                        r9 = r18
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 14 then
                                                if state <= 13 then
                                                    if state == 13 then
                                                        r22 = r6 == r15
                                                        r24 = r22
                                                        state = 14
                                                    end
                                                else
                                                    if state == 14 then
                                                        upvalueValues[r11] = r24
                                                        state = upvalueValues[r11]
                                                        state = state and (19) or (20)
                                                    end
                                                end
                                            else
                                                if state <= 15 then
                                                    if state == 15 then
                                                        r18 = state
                                                        r33 = 1
                                                        r8 = r7[r33]
                                                        r33 = false
                                                        r26 = r8 == r33
                                                        state = r26 and (21) or (22)
                                                        r9 = r26
                                                    end
                                                else
                                                    if state == 16 then
                                                        upvalueValues[r11] = ReturnVal
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
                                                        r26 = 1
                                                        r18 = r7[r26]
                                                        r9 = r18
                                                        state = 18
                                                    end
                                                else
                                                    if state == 18 then
                                                        upvalueValues[r11] = r9
                                                        r33 = upvalueValues[r32]
                                                        r10 = 1
                                                        r8 = r33 + r10
                                                        r26 = r7[r8]
                                                        r18 = r6 + r26
                                                        r26 = 256
                                                        state = r18 % r26
                                                        r6 = state
                                                        r8 = upvalueValues[r12]
                                                        r26 = r15 + r8
                                                        r8 = 256
                                                        r18 = r26 % r8
                                                        r15 = r18
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
                                                        r33 = 2
                                                        r8 = r7[r33]
                                                        r33 = upvalueValues[r16]
                                                        r26 = r8 == r33
                                                        r9 = r26
                                                        state = 22
                                                    end
                                                else
                                                    if state == 22 then
                                                        state = r18
                                                        ReturnVal = r9
                                                        state = 16
                                                    end
                                                end
                                            else
                                                if state <= 23 then
                                                    if state == 23 then
                                                        r7 = nil
                                                        r32 = releaseUpvalue(r32)
                                                        r21 = releaseUpvalue(r21)
                                                        r16 = releaseUpvalue(r16)
                                                        r2 = releaseUpvalue(r2)
                                                        r12 = releaseUpvalue(r12)
                                                        r29 = releaseUpvalue(r29)
                                                        state = 8
                                                    end
                                                else
                                                    if state == 24 then
                                                        r23 = releaseUpvalue(r23)
                                                        r4 = releaseUpvalue(r4)
                                                        r28 = nil
                                                        r28 = {}
                                                        r23 = allocUpvalue()
                                                        r11 = releaseUpvalue(r11)
                                                        r27 = releaseUpvalue(r27)
                                                        r13 = releaseUpvalue(r13)
                                                        r25 = releaseUpvalue(r25)
                                                        r19 = releaseUpvalue(r19)
                                                        r11 = nil
                                                        upvalueValues[r23] = r11
                                                        r30 = releaseUpvalue(r30)
                                                        r11 = allocUpvalue()
                                                        r19 = nil
                                                        upvalueValues[r11] = r19
                                                        r17 = nil
                                                        r17 = "math"
                                                        r13 = _env[r17]
                                                        r15 = nil
                                                        r15 = allocUpvalue()
                                                        r17 = "floor"
                                                        r19 = r13[r17]
                                                        r13 = allocUpvalue()
                                                        r25 = 256
                                                        upvalueValues[r13] = r19
                                                        r30 = "math"
                                                        r17 = _env[r30]
                                                        r30 = "random"
                                                        r19 = r17[r30]
                                                        r6 = nil
                                                        r6 = {}
                                                        r5 = nil
                                                        r5 = "table"
                                                        r30 = _env[r5]
                                                        r5 = "remove"
                                                        r17 = r30[r5]
                                                        r27 = "string"
                                                        r5 = _env[r27]
                                                        r27 = "char"
                                                        r30 = r5[r27]
                                                        r27 = allocUpvalue()
                                                        r4 = allocUpvalue()
                                                        r5 = 0
                                                        upvalueValues[r27] = r5
                                                        r5 = 2
                                                        upvalueValues[r4] = r5
                                                        r5 = {}
                                                        upvalueValues[r15] = r6
                                                        r20 = r25
                                                        r25 = 1
                                                        r2 = r25
                                                        r25 = 0
                                                        r21 = r2 < r25
                                                        r1 = nil
                                                        r1 = 1
                                                        r25 = r1 - r2
                                                        r6 = 0
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
                                                        state = createClosure0(47, {
                                                            r23
                                                        })
                                                        r22 = {
                                                            state()
                                                        }
                                                        ReturnVal = {
                                                            unpack(r22)
                                                        }
                                                        state = nil
                                                    end
                                                else
                                                    if state == 26 then
                                                        r25 = r25 + r2
                                                        r12 = not r21
                                                        r1 = r25 <= r20
                                                        r1 = r12 and r1
                                                        r12 = r25 >= r20
                                                        r12 = r21 and r12
                                                        r1 = r12 or r1
                                                        r12 = (27)
                                                        state = r1 and r12
                                                        r1 = (28)
                                                        state = state or r1
                                                    end
                                                end
                                            else
                                                if state <= 27 then
                                                    if state == 27 then
                                                        r1 = r25
                                                        r12 = r1
                                                        r28[r1] = r12
                                                        r1 = nil
                                                        state = 26
                                                    end
                                                else
                                                    if state == 28 then
                                                        r25 = #r28
                                                        r20 = 0
                                                        r1 = r25 == r20
                                                        state = 29
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 30 then
                                                if state <= 29 then
                                                    if state == 29 then
                                                        r25 = 1
                                                        r20 = #r28
                                                        r1 = r19(r25, r20)
                                                        r25 = r17(r28, r1)
                                                        r20 = upvalueValues[r15]
                                                        r12 = 1
                                                        r21 = r25 - r12
                                                        r1 = nil
                                                        r2 = r30(r21)
                                                        r20[r25] = r2
                                                        r25 = nil
                                                        state = 30
                                                    end
                                                else
                                                    if state == 30 then
                                                        r25 = #r28
                                                        r20 = 0
                                                        r1 = r25 == r20
                                                        state = r1 and (31) or (29)
                                                    end
                                                end
                                            else
                                                if state == 31 then
                                                    r25 = allocUpvalue()
                                                    r1 = {}
                                                    upvalueValues[r25] = r1
                                                    r2 = allocUpvalue()
                                                    r20 = createClosure3(51, {
                                                        r25,
                                                        r27,
                                                        r4,
                                                        r13
                                                    })
                                                    r1 = allocUpvalue()
                                                    upvalueValues[r1] = r20
                                                    r20 = {}
                                                    r12 = {}
                                                    upvalueValues[r2] = r20
                                                    r21 = "setmetatable"
                                                    r20 = _env[r21]
                                                    r19 = nil
                                                    r16 = upvalueValues[r2]
                                                    r7 = "__metatable"
                                                    r29 = "__index"
                                                    r26 = nil
                                                    r32 = {
                                                        [r29] = r16,
                                                        [r7] = r26
                                                    }
                                                    r21 = r20(r12, r32)
                                                    r20 = createClosure3(57, {
                                                        r2,
                                                        r25,
                                                        r15,
                                                        r27,
                                                        r4,
                                                        r1
                                                    })
                                                    r25 = releaseUpvalue(r25)
                                                    r13 = releaseUpvalue(r13)
                                                    upvalueValues[r11] = r21
                                                    r4 = releaseUpvalue(r4)
                                                    r13 = "loadstring"
                                                    r2 = releaseUpvalue(r2)
                                                    r15 = releaseUpvalue(r15)
                                                    r27 = releaseUpvalue(r27)
                                                    upvalueValues[r23] = r20
                                                    r19 = _env[r13]
                                                    r1 = releaseUpvalue(r1)
                                                    r30 = nil
                                                    r30 = "game"
                                                    r17 = nil
                                                    r17 = _env[r30]
                                                    r27 = upvalueValues[r11]
                                                    r4 = upvalueValues[r23]
                                                    r28 = nil
                                                    r28 = 29228521370922
                                                    r15 = "}d\230w:\006\203\003-xE\178:\246\205 \217\250\004\172\131\138\n\177\187\154\2334\204\031\231V\253\1552\216\018*\189| \023])~\004\019\180\225?\232\"\026!T\236\008Ux\027E\157\180\152|\189\004\t\008\228zN\2401"
                                                    r6 = nil
                                                    r6 = r4(r15, r28)
                                                    r5 = nil
                                                    r5 = r27[r6]
                                                    r27 = "HttpGet"
                                                    r27 = r17[r27]
                                                    r30 = {
                                                        r27(r17, r5)
                                                    }
                                                    r13 = r19(unpack(r30))
                                                    r19 = r13()
                                                    r30 = upvalueValues[r11]
                                                    r5 = upvalueValues[r23]
                                                    r6 = 22725825407318
                                                    r4 = "\192\224\132Gx\172\178t>O\245\182Uo"
                                                    r27 = r5(r4, r6)
                                                    r17 = r30[r27]
                                                    r13 = "Window"
                                                    r13 = r19[r13]
                                                    r13 = r13(r19, r17)
                                                    r5 = upvalueValues[r11]
                                                    r27 = upvalueValues[r23]
                                                    r15 = 33624952864041
                                                    r6 = "\184\187\178 \204\225c\161\172.\n{\128\220\250\204\168wZ\000=C["
                                                    r4 = r27(r6, r15)
                                                    r30 = r5[r4]
                                                    r4 = "Color3"
                                                    r27 = _env[r4]
                                                    r6 = upvalueValues[r11]
                                                    r15 = upvalueValues[r23]
                                                    r17 = "Label"
                                                    r17 = r13[r17]
                                                    r25 = 29649568085486
                                                    r1 = "J-\238^\170\217\250"
                                                    r28 = r15(r1, r25)
                                                    r4 = r6[r28]
                                                    r5 = r27[r4]
                                                    r15 = 166
                                                    r4 = 127
                                                    r6 = 143
                                                    r27 = {
                                                        r5(r4, r6, r15)
                                                    }
                                                    r17 = r17(r13, r30, unpack(r27))
                                                    r5 = upvalueValues[r11]
                                                    r27 = upvalueValues[r23]
                                                    r6 = "\234\200\200\187\146\157\n~\1759lZ\146\177\173\167\208\241\237=v."
                                                    r15 = 27078758330689
                                                    r4 = r27(r6, r15)
                                                    r30 = r5[r4]
                                                    r4 = "Color3"
                                                    r27 = _env[r4]
                                                    r6 = upvalueValues[r11]
                                                    r15 = upvalueValues[r23]
                                                    ReturnVal = {}
                                                    r25 = 32552502328118
                                                    r1 = "\217\022\020\201\233\011\231"
                                                    r28 = r15(r1, r25)
                                                    r4 = r6[r28]
                                                    r5 = r27[r4]
                                                    r15 = 166
                                                    r6 = 143
                                                    r4 = 127
                                                    r27 = {
                                                        r5(r4, r6, r15)
                                                    }
                                                    r17 = "Label"
                                                    r17 = r13[r17]
                                                    r15 = 13879398570303
                                                    r6 = "Z\027Y\238R\t\190m"
                                                    r19 = nil
                                                    r17 = r17(r13, r30, unpack(r27))
                                                    r5 = upvalueValues[r11]
                                                    r27 = upvalueValues[r23]
                                                    r4 = r27(r6, r15)
                                                    r17 = "Button"
                                                    r17 = r13[r17]
                                                    r30 = r5[r4]
                                                    r5 = createClosure2(64, {
                                                        r11,
                                                        r23
                                                    })
                                                    r11 = releaseUpvalue(r11)
                                                    r23 = releaseUpvalue(r23)
                                                    r17 = r17(r13, r30, r5)
                                                    r13 = nil
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure3 entry 12063262 -> 32, states 32-32
                                if state == 32 then -- entry 12063262 -> 32
                                    ReturnVal = "error"
                                    state = _env[ReturnVal]
                                    r31 = "Tamper Detected!"
                                    ReturnVal = state(r31)
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        else
                            -- createClosure4 entry 10437594 -> 33, states 33-33
                            if state == 33 then -- entry 10437594 -> 33
                                state = true
                                upvalueValues[upvalues[1]] = state
                                ReturnVal = {}
                                state = nil
                            end
                        end
                    else
                        if state <= 34 then
                            -- createClosure1 entry 3999513 -> 34, states 34-34
                            if state == 34 then -- entry 3999513 -> 34
                                r19 = 10732130
                                r11 = "KKoy"
                                r31 = r11 ^ r19
                                ReturnVal = 15685950
                                state = ReturnVal - r31
                                r31 = state
                                ReturnVal = "3Ox"
                                state = ReturnVal / r31
                                ReturnVal = {
                                    state
                                }
                                state = nil
                            end
                        else
                            -- createClosure5 entry 15487267 -> 35, states 35-46
                            if state <= 40 then
                                if state <= 37 then
                                    if state <= 36 then
                                        if state <= 35 then
                                            if state == 35 then -- entry 15487267 -> 35
                                                r11 = upvalueValues[upvalues[1]]
                                                r23 = 1
                                                r13 = 2
                                                r19 = r11(r23, r13)
                                                r11 = 1
                                                r31 = r19 == r11
                                                state = r31 and (36) or (37)
                                                ReturnVal = r31
                                            end
                                        else
                                            if state == 36 then
                                                state = ReturnVal and (38) or (39)
                                            end
                                        end
                                    else
                                        if state == 37 then
                                            r11 = upvalueValues[upvalues[2]]
                                            r19 = upvalueValues[upvalues[3]]
                                            r31 = r11 == r19
                                            ReturnVal = r31
                                            state = 36
                                        end
                                    end
                                else
                                    if state <= 39 then
                                        if state <= 38 then
                                            if state == 38 then
                                                r27 = createClosure4(68, {})
                                                ReturnVal = "tonumber"
                                                state = _env[ReturnVal]
                                                r31 = upvalueValues[upvalues[4]]
                                                r23 = "tostring"
                                                r19 = _env[r23]
                                                r5 = "pcall"
                                                r30 = _env[r5]
                                                r5 = {
                                                    r30(r27)
                                                }
                                                r17 = {
                                                    unpack(r5)
                                                }
                                                r30 = 2
                                                r13 = r17[r30]
                                                r23 = r19(r13)
                                                r19 = ":(%d*):"
                                                r11 = r31(r23, r19)
                                                r31 = {
                                                    r11()
                                                }
                                                ReturnVal = state(unpack(r31))
                                                r31 = ReturnVal
                                                r11 = upvalueValues[upvalues[5]]
                                                state = r11 and (40) or (41)
                                                ReturnVal = r11
                                            end
                                        else
                                            if state == 39 then
                                                state = upvalueValues[upvalues[7]]
                                                state = state and (42) or (43)
                                            end
                                        end
                                    else
                                        if state == 40 then
                                            r19 = upvalueValues[upvalues[6]]
                                            r11 = r19 == r31
                                            ReturnVal = r11
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
                                                r31 = nil
                                                state = 39
                                            end
                                        else
                                            if state == 42 then
                                                r31 = "error"
                                                state = _env[r31]
                                                r11 = upvalueValues[upvalues[8]]
                                                r19 = 0
                                                r31 = state(r11, r19)
                                                state = 43
                                            end
                                        end
                                    else
                                        if state == 43 then
                                            state = {}
                                            r31 = state
                                            r19 = upvalueValues[upvalues[9]]
                                            r23 = r19
                                            r19 = 1
                                            r13 = r19
                                            r19 = 0
                                            r17 = r13 < r19
                                            r11 = 1
                                            r19 = r11 - r13
                                            state = 44
                                        end
                                    end
                                else
                                    if state <= 45 then
                                        if state <= 44 then
                                            if state == 44 then
                                                r19 = r19 + r13
                                                r11 = r19 <= r23
                                                r30 = not r17
                                                r11 = r30 and r11
                                                r30 = r19 >= r23
                                                r30 = r17 and r30
                                                r11 = r30 or r11
                                                r30 = (45)
                                                state = r11 and r30
                                                r11 = (46)
                                                state = state or r11
                                            end
                                        else
                                            if state == 45 then
                                                r11 = r19
                                                state = upvalueValues[upvalues[1]]
                                                r27 = 255
                                                r5 = 0
                                                r30 = state(r5, r27)
                                                r31[r11] = r30
                                                r11 = nil
                                                state = 44
                                            end
                                        end
                                    else
                                        if state == 46 then
                                            state = upvalueValues[upvalues[10]]
                                            r11 = upvalueValues[upvalues[11]]
                                            r31[state] = r11
                                            state = upvalueValues[upvalues[12]]
                                            r11 = {
                                                state(r31)
                                            }
                                            ReturnVal = {
                                                unpack(r11)
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
                                -- createClosure0 entry 14200670 -> 47, states 47-50
                                if state <= 48 then
                                    if state <= 47 then
                                        if state == 47 then -- entry 14200670 -> 47
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
                                            r31 = "l1"
                                            ReturnVal = _env[r31]
                                            r31 = "l1"
                                            _env[r31] = state
                                            r31 = "l2"
                                            _env[r31] = ReturnVal
                                            r31 = upvalueValues[upvalues[1]]
                                            r11 = r31()
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
                                -- createClosure3 entry 15878765 -> 51, states 51-56
                                if state <= 53 then
                                    if state <= 52 then
                                        if state <= 51 then
                                            if state == 51 then -- entry 15878765 -> 51
                                                r31 = upvalueValues[upvalues[1]]
                                                ReturnVal = #r31
                                                r31 = 0
                                                state = ReturnVal == r31
                                                state = state and (52) or (53)
                                            end
                                        else
                                            if state == 52 then
                                                r11 = upvalueValues[upvalues[2]]
                                                r19 = 117
                                                r31 = r11 * r19
                                                r11 = 4325503829981
                                                ReturnVal = r31 + r11
                                                r31 = 35184372088832
                                                state = ReturnVal % r31
                                                upvalueValues[upvalues[2]] = state
                                                r31 = upvalueValues[upvalues[3]]
                                                r11 = 1
                                                ReturnVal = r31 ~= r11
                                                state = 54
                                            end
                                        end
                                    else
                                        if state == 53 then
                                            r19 = "table"
                                            r11 = _env[r19]
                                            r19 = "remove"
                                            r31 = r11[r19]
                                            r19 = upvalueValues[upvalues[1]]
                                            r11 = {
                                                r31(r19)
                                            }
                                            ReturnVal = {
                                                unpack(r11)
                                            }
                                            state = nil
                                        end
                                    end
                                else
                                    if state <= 55 then
                                        if state <= 54 then
                                            if state == 54 then
                                                r11 = upvalueValues[upvalues[3]]
                                                r19 = 87
                                                r31 = r11 * r19
                                                r11 = 257
                                                ReturnVal = r31 % r11
                                                upvalueValues[upvalues[3]] = ReturnVal
                                                state = 55
                                            end
                                        else
                                            if state == 55 then
                                                r11 = upvalueValues[upvalues[3]]
                                                r19 = 1
                                                r31 = r11 ~= r19
                                                state = r31 and (56) or (54)
                                            end
                                        end
                                    else
                                        if state == 56 then
                                            r19 = 32
                                            r11 = upvalueValues[upvalues[3]]
                                            r31 = r11 % r19
                                            r23 = upvalueValues[upvalues[4]]
                                            r27 = 2
                                            r30 = upvalueValues[upvalues[2]]
                                            r1 = upvalueValues[upvalues[3]]
                                            r28 = r1 - r31
                                            r1 = 32
                                            r15 = r28 / r1
                                            r6 = 13
                                            r4 = r6 - r15
                                            r5 = r27 ^ r4
                                            r17 = r30 / r5
                                            r13 = r23(r17)
                                            r23 = 4294967296
                                            r19 = r13 % r23
                                            r13 = 2
                                            r5 = 1
                                            r23 = r13 ^ r31
                                            r11 = r19 / r23
                                            r6 = 256
                                            r23 = upvalueValues[upvalues[4]]
                                            r31 = nil
                                            r30 = r11 % r5
                                            r5 = 4294967296
                                            r27 = 256
                                            r17 = r30 * r5
                                            r13 = r23(r17)
                                            r23 = upvalueValues[upvalues[4]]
                                            r30 = 65536
                                            r17 = r23(r11)
                                            r19 = r13 + r17
                                            r13 = 65536
                                            r23 = r19 % r13
                                            r17 = r19 - r23
                                            r13 = r17 / r30
                                            r19 = nil
                                            r30 = 256
                                            r17 = r23 % r30
                                            r5 = r23 - r17
                                            r30 = r5 / r27
                                            r27 = 256
                                            r5 = r13 % r27
                                            r4 = r13 - r5
                                            r27 = r4 / r6
                                            r13 = nil
                                            r23 = nil
                                            r11 = nil
                                            r4 = {
                                                r17,
                                                r30,
                                                r5,
                                                r27
                                            }
                                            r5 = nil
                                            r30 = nil
                                            r27 = nil
                                            upvalueValues[upvalues[1]] = r4
                                            r17 = nil
                                            state = 53
                                        end
                                    end
                                end
                            end
                        else
                            -- createClosure3 entry 6361513 -> 57, states 57-63
                            if state <= 60 then
                                if state <= 58 then
                                    if state <= 57 then
                                        if state == 57 then -- entry 6361513 -> 57
                                            state = upvalueValues[upvalues[1]]
                                            r19 = state
                                            r31 = args[1]
                                            r11 = args[2]
                                            state = r19[r11]
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
                                            r23 = ReturnVal
                                            r13 = 35184372088832
                                            ReturnVal = r11 % r13
                                            upvalueValues[upvalues[4]] = ReturnVal
                                            r30 = 255
                                            r17 = r11 % r30
                                            r30 = 2
                                            r13 = r17 + r30
                                            upvalueValues[upvalues[5]] = r13
                                            r5 = "string"
                                            r30 = _env[r5]
                                            r5 = "len"
                                            r17 = r30[r5]
                                            r30 = r17(r31)
                                            r4 = 1
                                            r6 = r4
                                            r17 = ""
                                            r19[r11] = r17
                                            r4 = 0
                                            r15 = r6 < r4
                                            r5 = 1
                                            r4 = r5 - r6
                                            r27 = r30
                                            r17 = 150
                                            state = 61
                                        end
                                    else
                                        if state == 60 then
                                            ReturnVal = {
                                                r11
                                            }
                                            state = nil
                                        end
                                    end
                                end
                            else
                                if state <= 62 then
                                    if state <= 61 then
                                        if state == 61 then
                                            r4 = r4 + r6
                                            r28 = not r15
                                            r5 = r4 <= r27
                                            r5 = r28 and r5
                                            r28 = r4 >= r27
                                            r28 = r15 and r28
                                            r5 = r28 or r5
                                            r28 = (62)
                                            state = r5 and r28
                                            r5 = (63)
                                            state = state or r5
                                        end
                                    else
                                        if state == 62 then
                                            r14 = "string"
                                            r22 = _env[r14]
                                            r14 = "byte"
                                            r24 = r22[r14]
                                            r5 = r4
                                            r22 = r24(r31, r5)
                                            r24 = upvalueValues[upvalues[6]]
                                            r14 = r24()
                                            r25 = r22 + r14
                                            r1 = r25 + r17
                                            r25 = 256
                                            r28 = r1 % r25
                                            r17 = r28
                                            r25 = r19[r11]
                                            r14 = 1
                                            r22 = r17 + r14
                                            r24 = r23[r22]
                                            r1 = r25 .. r24
                                            r5 = nil
                                            r19[r11] = r1
                                            state = 61
                                        end
                                    end
                                else
                                    if state == 63 then
                                        r30 = nil
                                        r23 = nil
                                        r17 = nil
                                        state = 60
                                    end
                                end
                            end
                        end
                    else
                        if state <= 67 then
                            -- createClosure2 entry 10338445 -> 64, states 64-67
                            if state <= 65 then
                                if state <= 64 then
                                    if state == 64 then -- entry 10338445 -> 64
                                        ReturnVal = "game"
                                        state = _env[ReturnVal]
                                        r11 = upvalueValues[upvalues[1]]
                                        r19 = upvalueValues[upvalues[2]]
                                        r17 = 32901073435608
                                        r13 = "y.C\2205\238\218"
                                        r23 = r19(r13, r17)
                                        r31 = r11[r23]
                                        ReturnVal = "GetService"
                                        ReturnVal = state[ReturnVal]
                                        ReturnVal = ReturnVal(state, r31)
                                        r31 = ReturnVal
                                        r11 = upvalueValues[upvalues[1]]
                                        r19 = upvalueValues[upvalues[2]]
                                        r13 = "\182B\251i6\r[\017\141\149\141"
                                        r17 = 33938836749756
                                        r23 = r19(r13, r17)
                                        ReturnVal = r11[r23]
                                        state = r31[ReturnVal]
                                        r11 = state
                                        r19 = upvalueValues[upvalues[1]]
                                        r23 = upvalueValues[upvalues[2]]
                                        r30 = 27621008536126
                                        r17 = "\145\006\206\210\2449\183\016\183"
                                        r13 = r23(r17, r30)
                                        ReturnVal = r19[r13]
                                        state = r11[ReturnVal]
                                        r23 = upvalueValues[upvalues[1]]
                                        r13 = upvalueValues[upvalues[2]]
                                        r5 = 32486657948439
                                        r30 = "{\162\131\163\193y}\244r\156\205:\135\219K\145"
                                        r17 = r13(r30, r5)
                                        r19 = r23[r17]
                                        ReturnVal = "WaitForChild"
                                        ReturnVal = state[ReturnVal]
                                        ReturnVal = ReturnVal(state, r19)
                                        r19 = ReturnVal
                                        r13 = "Vector3"
                                        r23 = _env[r13]
                                        r17 = upvalueValues[upvalues[1]]
                                        r30 = upvalueValues[upvalues[2]]
                                        r4 = 8082209935027
                                        r27 = "\218\023\184"
                                        r5 = r30(r27, r4)
                                        r13 = r17[r5]
                                        ReturnVal = r23[r13]
                                        r30 = 183.430000000000007
                                        r17 = 6
                                        r13 = 149.699999999999989
                                        r23 = ReturnVal(r13, r17, r30)
                                        r17 = "Vector3"
                                        r13 = _env[r17]
                                        r30 = upvalueValues[upvalues[1]]
                                        r5 = upvalueValues[upvalues[2]]
                                        r6 = 8206623362797
                                        r4 = "\158\141\143"
                                        r27 = r5(r4, r6)
                                        r17 = r30[r27]
                                        ReturnVal = r13[r17]
                                        r5 = 167.629999999999995
                                        r17 = 186.860000000000014
                                        r30 = 7.99
                                        r13 = ReturnVal(r17, r30, r5)
                                        r30 = "Vector3"
                                        r17 = _env[r30]
                                        r5 = upvalueValues[upvalues[1]]
                                        r27 = upvalueValues[upvalues[2]]
                                        r15 = 13401068492896
                                        r6 = "8+S"
                                        r4 = r27(r6, r15)
                                        r30 = r5[r4]
                                        ReturnVal = r17[r30]
                                        r5 = 13
                                        r30 = 194.360000000000014
                                        r27 = 167.060000000000002
                                        r17 = ReturnVal(r30, r5, r27)
                                        r5 = "Vector3"
                                        r30 = _env[r5]
                                        r27 = upvalueValues[upvalues[1]]
                                        r4 = upvalueValues[upvalues[2]]
                                        r28 = 11560250283271
                                        r15 = "\144\217X"
                                        r6 = r4(r15, r28)
                                        r5 = r27[r6]
                                        ReturnVal = r30[r5]
                                        r4 = 166.819999999999993
                                        r27 = 5.99
                                        r5 = 195.090000000000003
                                        r30 = ReturnVal(r5, r27, r4)
                                        r27 = "Vector3"
                                        r5 = _env[r27]
                                        r4 = upvalueValues[upvalues[1]]
                                        r6 = upvalueValues[upvalues[2]]
                                        r1 = 10858937668544
                                        r28 = "\128?["
                                        r15 = r6(r28, r1)
                                        r27 = r4[r15]
                                        ReturnVal = r5[r27]
                                        r27 = 288.019999999999982
                                        r6 = 170.919999999999987
                                        r4 = 40.109999999999999
                                        r5 = ReturnVal(r27, r4, r6)
                                        r4 = "Vector3"
                                        r27 = _env[r4]
                                        r6 = upvalueValues[upvalues[1]]
                                        r15 = upvalueValues[upvalues[2]]
                                        r25 = 8859960430621
                                        r1 = "\129\1541"
                                        r28 = r15(r1, r25)
                                        r4 = r6[r28]
                                        ReturnVal = r27[r4]
                                        r6 = 70.840000000000003
                                        r15 = 201.900000000000006
                                        r4 = 404.29000000000002
                                        r27 = ReturnVal(r4, r6, r15)
                                        r6 = "Vector3"
                                        r4 = _env[r6]
                                        r15 = upvalueValues[upvalues[1]]
                                        r28 = upvalueValues[upvalues[2]]
                                        r24 = 32539426667312
                                        r25 = "\155#g"
                                        r1 = r28(r25, r24)
                                        r6 = r15[r1]
                                        ReturnVal = r4[r6]
                                        r6 = 552.590000000000032
                                        r15 = 51.119999999999997
                                        r28 = 242.689999999999998
                                        r4 = ReturnVal(r6, r15, r28)
                                        r15 = "Vector3"
                                        r6 = _env[r15]
                                        r28 = upvalueValues[upvalues[1]]
                                        r1 = upvalueValues[upvalues[2]]
                                        r24 = "\202\247\150"
                                        r22 = 32777332685727
                                        r25 = r1(r24, r22)
                                        r15 = r28[r25]
                                        ReturnVal = r6[r15]
                                        r28 = 13.67
                                        r1 = 165.909999999999997
                                        r15 = 670.700000000000045
                                        r6 = ReturnVal(r15, r28, r1)
                                        r28 = "Vector3"
                                        r15 = _env[r28]
                                        r1 = upvalueValues[upvalues[1]]
                                        r25 = upvalueValues[upvalues[2]]
                                        r14 = 33169463835733
                                        r22 = "#\234\213"
                                        r24 = r25(r22, r14)
                                        r28 = r1[r24]
                                        ReturnVal = r15[r28]
                                        r1 = 38.950000000000003
                                        r28 = 823.080000000000041
                                        r25 = 239.280000000000001
                                        r15 = ReturnVal(r28, r1, r25)
                                        r1 = "Vector3"
                                        r28 = _env[r1]
                                        r25 = upvalueValues[upvalues[1]]
                                        r24 = upvalueValues[upvalues[2]]
                                        r20 = 22494911047915
                                        r14 = "\178\134U"
                                        r22 = r24(r14, r20)
                                        r1 = r25[r22]
                                        ReturnVal = r28[r1]
                                        r25 = 73.260000000000005
                                        r1 = 929.200000000000045
                                        r24 = 225.280000000000001
                                        r28 = ReturnVal(r1, r25, r24)
                                        r25 = "Vector3"
                                        r1 = _env[r25]
                                        r24 = upvalueValues[upvalues[1]]
                                        r22 = upvalueValues[upvalues[2]]
                                        r2 = 797442130291
                                        r20 = "\175tM"
                                        r14 = r22(r20, r2)
                                        r25 = r24[r14]
                                        ReturnVal = r1[r25]
                                        r22 = 206.409999999999997
                                        r25 = 1091.940000000000055
                                        r24 = 30.649999999999999
                                        r1 = ReturnVal(r25, r24, r22)
                                        r24 = "Vector3"
                                        r25 = _env[r24]
                                        r22 = upvalueValues[upvalues[1]]
                                        r14 = upvalueValues[upvalues[2]]
                                        r21 = 12154013586971
                                        r2 = "'\183\206"
                                        r20 = r14(r2, r21)
                                        r24 = r22[r20]
                                        ReturnVal = r25[r24]
                                        r14 = 179.830000000000013
                                        r24 = 1303.519999999999982
                                        r22 = 28.27
                                        r25 = ReturnVal(r24, r22, r14)
                                        r22 = "Vector3"
                                        r24 = _env[r22]
                                        r14 = upvalueValues[upvalues[1]]
                                        r20 = upvalueValues[upvalues[2]]
                                        r12 = 7215555153184
                                        r21 = "\249F\207"
                                        r2 = r20(r21, r12)
                                        r22 = r14[r2]
                                        ReturnVal = r24[r22]
                                        r14 = 57.689999999999998
                                        r20 = 198.139999999999986
                                        r22 = 1457.599999999999909
                                        r24 = ReturnVal(r22, r14, r20)
                                        r14 = "Vector3"
                                        r22 = _env[r14]
                                        r20 = upvalueValues[upvalues[1]]
                                        r2 = upvalueValues[upvalues[2]]
                                        r32 = 6789380525145
                                        r12 = "z\215\236"
                                        r21 = r2(r12, r32)
                                        r14 = r20[r21]
                                        ReturnVal = r22[r14]
                                        r2 = 169.900000000000006
                                        r20 = 45.159999999999997
                                        r14 = 1663.3900000000001
                                        r22 = ReturnVal(r14, r20, r2)
                                        r20 = "Vector3"
                                        r14 = _env[r20]
                                        r2 = upvalueValues[upvalues[1]]
                                        r21 = upvalueValues[upvalues[2]]
                                        r29 = 23126877956625
                                        r32 = "}\233\017"
                                        r12 = r21(r32, r29)
                                        r20 = r2[r12]
                                        ReturnVal = r14[r20]
                                        r21 = 170.150000000000006
                                        r2 = 45.299999999999997
                                        r20 = 1823.079999999999927
                                        r14 = ReturnVal(r20, r2, r21)
                                        r2 = "Vector3"
                                        r20 = _env[r2]
                                        r21 = upvalueValues[upvalues[1]]
                                        r12 = upvalueValues[upvalues[2]]
                                        r16 = 5844490668705
                                        r29 = "\163X\169"
                                        r32 = r12(r29, r16)
                                        r2 = r21[r32]
                                        ReturnVal = r20[r2]
                                        r21 = 41.390000000000001
                                        r12 = 193.090000000000003
                                        r2 = 1986.309999999999945
                                        r20 = ReturnVal(r2, r21, r12)
                                        r21 = "Vector3"
                                        r2 = _env[r21]
                                        r12 = upvalueValues[upvalues[1]]
                                        r32 = upvalueValues[upvalues[2]]
                                        r7 = 23258242722382
                                        r16 = "\139\139;"
                                        r29 = r32(r16, r7)
                                        r21 = r12[r29]
                                        ReturnVal = r2[r21]
                                        r32 = 200.47999999999999
                                        r12 = 42.030000000000001
                                        r21 = 2039.809999999999945
                                        r2 = {
                                            ReturnVal(r21, r12, r32)
                                        }
                                        state = {
                                            r23,
                                            r13,
                                            r17,
                                            r30,
                                            r5,
                                            r27,
                                            r4,
                                            r6,
                                            r15,
                                            r28,
                                            r1,
                                            r25,
                                            r24,
                                            r22,
                                            r14,
                                            r20,
                                            unpack(r2)
                                        }
                                        r23 = state
                                        ReturnVal = "ipairs"
                                        state = _env[ReturnVal]
                                        r30 = {
                                            state(r23)
                                        }
                                        r17 = r30[3]
                                        r13 = r30[2]
                                        ReturnVal = r30[1]
                                        r30 = ReturnVal
                                        state = 65
                                    end
                                else
                                    if state == 65 then
                                        r17, r27 = r30(r13, r17)
                                        state = r17 and (66) or (67)
                                    end
                                end
                            else
                                if state <= 66 then
                                    if state == 66 then
                                        r6 = "task"
                                        r4 = _env[r6]
                                        r5 = r17
                                        r15 = upvalueValues[upvalues[1]]
                                        r28 = upvalueValues[upvalues[2]]
                                        r24 = 987929215436
                                        r25 = "\164\006\005\163"
                                        r1 = r28(r25, r24)
                                        r6 = r15[r1]
                                        state = r4[r6]
                                        r6 = 0.4
                                        r4 = state(r6)
                                        r1 = 10169994515071
                                        r28 = "&\193\157\000\155\238"
                                        r4 = upvalueValues[upvalues[1]]
                                        r5 = nil
                                        r6 = upvalueValues[upvalues[2]]
                                        r15 = r6(r28, r1)
                                        state = r4[r15]
                                        r15 = "CFrame"
                                        r6 = _env[r15]
                                        r28 = upvalueValues[upvalues[1]]
                                        r1 = upvalueValues[upvalues[2]]
                                        r24 = "\127M9"
                                        r22 = 8748213014505
                                        r25 = r1(r24, r22)
                                        r15 = r28[r25]
                                        r4 = r6[r15]
                                        r6 = r4(r27)
                                        r27 = nil
                                        r19[state] = r6
                                        state = 65
                                    end
                                else
                                    if state == 67 then
                                        r19 = nil
                                        r23 = nil
                                        r31 = nil
                                        r11 = nil
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            end
                        else
                            -- createClosure4 entry 9170859 -> 68, states 68-68
                            if state == 68 then -- entry 9170859 -> 68
                                r11 = "GQdPcofbTQPoAga"
                                r19 = 14710180
                                r31 = r11 ^ r19
                                ReturnVal = 1916854
                                state = ReturnVal - r31
                                r31 = state
                                ReturnVal = "wNJZUNMp"
                                state = ReturnVal / r31
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
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)