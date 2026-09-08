return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, releaseUpvalues, upvalueValues, createClosure0, releaseUpvalue, createClosure1, createClosure, currentUpvalueId, vm, allocUpvalue, createClosure4, createUpvalueProxy, createClosure5, upvalueRefCounts, createClosure2)
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
                    return 2808966
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 2808966
                    end
                })
            end
        end
        currentUpvalueId = 0
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, ReturnVal, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33
            while state do
                if state <= 46 then
                    if state <= 33 then
                        if state <= 32 then
                            if state <= 31 then
                                -- root entry 7400647 -> 1, states 1-31
                                if state <= 16 then
                                    if state <= 8 then
                                        if state <= 4 then
                                            if state <= 2 then
                                                if state <= 1 then
                                                    if state == 1 then -- entry 7400647 -> 1
                                                        r31 = allocUpvalue()
                                                        r15 = allocUpvalue()
                                                        state = true
                                                        upvalueValues[r15] = state
                                                        r7 = "string"
                                                        ReturnVal = _env[r7]
                                                        r30 = allocUpvalue()
                                                        r7 = "gmatch"
                                                        state = ReturnVal[r7]
                                                        r7 = allocUpvalue()
                                                        upvalueValues[r7] = state
                                                        state = createClosure1(32, {})
                                                        upvalueValues[r31] = state
                                                        state = false
                                                        upvalueValues[r30] = state
                                                        r10 = createClosure5(33, {
                                                            r30
                                                        })
                                                        r19 = "pcall"
                                                        r4 = _env[r19]
                                                        r19 = r4(r10)
                                                        state = r19 and (2) or (3)
                                                        r14 = args
                                                        ReturnVal = r19
                                                    end
                                                else
                                                    if state == 2 then
                                                        r4 = upvalueValues[r30]
                                                        ReturnVal = r4
                                                        state = 3
                                                    end
                                                end
                                            else
                                                if state <= 3 then
                                                    if state == 3 then
                                                        r4 = ReturnVal
                                                        r19 = "math"
                                                        ReturnVal = _env[r19]
                                                        r19 = "random"
                                                        state = ReturnVal[r19]
                                                        r19 = allocUpvalue()
                                                        upvalueValues[r19] = state
                                                        r10 = "table"
                                                        ReturnVal = _env[r10]
                                                        r10 = "concat"
                                                        state = ReturnVal[r10]
                                                        r26 = state
                                                        r10 = state
                                                        r32 = "table"
                                                        r11 = _env[r32]
                                                        state = r11 and (4) or (5)
                                                        r3 = r11
                                                    end
                                                else
                                                    if state == 4 then
                                                        r9 = "table"
                                                        r32 = _env[r9]
                                                        r9 = "unpack"
                                                        r11 = r32[r9]
                                                        r3 = r11
                                                        state = 5
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 6 then
                                                if state <= 5 then
                                                    if state == 5 then
                                                        state = r26
                                                        state = r3 and (6) or (7)
                                                        ReturnVal = r3
                                                    end
                                                else
                                                    if state == 6 then
                                                        r21 = createClosure5(34, {})
                                                        r3 = allocUpvalue()
                                                        upvalueValues[r3] = ReturnVal
                                                        state = upvalueValues[r19]
                                                        r11 = 65
                                                        r26 = 3
                                                        ReturnVal = state(r26, r11)
                                                        r26 = allocUpvalue()
                                                        state = 0
                                                        upvalueValues[r26] = ReturnVal
                                                        r9 = "pcall"
                                                        ReturnVal = _env[r9]
                                                        r9 = {
                                                            ReturnVal(r21)
                                                        }
                                                        r11 = state
                                                        state = 0
                                                        r32 = state
                                                        state = {
                                                            unpack(r9)
                                                        }
                                                        r9 = state
                                                        ReturnVal = 2
                                                        state = r9[ReturnVal]
                                                        r21 = state
                                                        ReturnVal = "tonumber"
                                                        state = _env[ReturnVal]
                                                        r28 = upvalueValues[r7]
                                                        r23 = "tostring"
                                                        r18 = _env[r23]
                                                        r23 = r18(r21)
                                                        r18 = ":(%d*):"
                                                        r16 = r28(r23, r18)
                                                        r28 = {
                                                            r16()
                                                        }
                                                        ReturnVal = state(unpack(r28))
                                                        r28 = allocUpvalue()
                                                        upvalueValues[r28] = ReturnVal
                                                        r16 = upvalueValues[r26]
                                                        r18 = r16
                                                        r16 = 1
                                                        r23 = r16
                                                        r16 = 0
                                                        r29 = r23 < r16
                                                        ReturnVal = 1
                                                        r16 = ReturnVal - r23
                                                        state = 8
                                                    end
                                                end
                                            else
                                                if state <= 7 then
                                                    if state == 7 then
                                                        r26 = "unpack"
                                                        r3 = _env[r26]
                                                        ReturnVal = r3
                                                        state = 6
                                                    end
                                                else
                                                    if state == 8 then
                                                        r16 = r16 + r23
                                                        r5 = not r29
                                                        ReturnVal = r16 <= r18
                                                        ReturnVal = r5 and ReturnVal
                                                        r5 = r16 >= r18
                                                        r5 = r29 and r5
                                                        ReturnVal = r5 or ReturnVal
                                                        r5 = (9)
                                                        state = ReturnVal and r5
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
                                                        r5 = allocUpvalue()
                                                        upvalueValues[r5] = r16
                                                        r33 = "math"
                                                        ReturnVal = _env[r33]
                                                        r33 = "random"
                                                        state = ReturnVal[r33]
                                                        r8 = 100
                                                        r33 = 1
                                                        ReturnVal = state(r33, r8)
                                                        r33 = allocUpvalue()
                                                        upvalueValues[r33] = ReturnVal
                                                        state = upvalueValues[r19]
                                                        r27 = 255
                                                        r8 = 0
                                                        ReturnVal = state(r8, r27)
                                                        r8 = allocUpvalue()
                                                        upvalueValues[r8] = ReturnVal
                                                        state = upvalueValues[r19]
                                                        r24 = upvalueValues[r33]
                                                        r27 = 1
                                                        ReturnVal = state(r27, r24)
                                                        r27 = allocUpvalue()
                                                        upvalueValues[r27] = ReturnVal
                                                        ReturnVal = upvalueValues[r19]
                                                        r1 = 1
                                                        r2 = 2
                                                        r24 = ReturnVal(r1, r2)
                                                        ReturnVal = 1
                                                        state = r24 == ReturnVal
                                                        r24 = allocUpvalue()
                                                        upvalueValues[r24] = state
                                                        r6 = "tostring"
                                                        r17 = _env[r6]
                                                        r22 = upvalueValues[r19]
                                                        r13 = 10000
                                                        r25 = 0
                                                        r20 = {
                                                            r22(r25, r13)
                                                        }
                                                        r6 = r17(unpack(r20))
                                                        state = "gsub"
                                                        state = r21[state]
                                                        r17 = ":"
                                                        r12 = r6 .. r17
                                                        r2 = ":"
                                                        r1 = r2 .. r12
                                                        ReturnVal = ":(%d*):"
                                                        state = state(r21, ReturnVal, r1)
                                                        r1 = allocUpvalue()
                                                        upvalueValues[r1] = state
                                                        r12 = createClosure4(35, {
                                                            r19,
                                                            r5,
                                                            r26,
                                                            r7,
                                                            r15,
                                                            r28,
                                                            r24,
                                                            r1,
                                                            r33,
                                                            r27,
                                                            r8,
                                                            r3
                                                        })
                                                        r2 = "pcall"
                                                        ReturnVal = _env[r2]
                                                        r2 = {
                                                            ReturnVal(r12)
                                                        }
                                                        state = {
                                                            unpack(r2)
                                                        }
                                                        r2 = state
                                                        state = upvalueValues[r24]
                                                        state = state and (11) or (12)
                                                    end
                                                else
                                                    if state == 10 then
                                                        r18 = upvalueValues[r15]
                                                        state = r18 and (13) or (14)
                                                        r16 = r18
                                                    end
                                                end
                                            else
                                                if state <= 11 then
                                                    if state == 11 then
                                                        r12 = upvalueValues[r15]
                                                        state = r12 and (15) or (16)
                                                        ReturnVal = r12
                                                    end
                                                else
                                                    if state == 12 then
                                                        r17 = upvalueValues[r15]
                                                        state = r17 and (17) or (18)
                                                        r12 = r17
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 14 then
                                                if state <= 13 then
                                                    if state == 13 then
                                                        r18 = r11 == r32
                                                        r16 = r18
                                                        state = 14
                                                    end
                                                else
                                                    if state == 14 then
                                                        upvalueValues[r15] = r16
                                                        state = upvalueValues[r15]
                                                        state = state and (19) or (20)
                                                    end
                                                end
                                            else
                                                if state <= 15 then
                                                    if state == 15 then
                                                        r20 = 1
                                                        r22 = r2[r20]
                                                        r20 = false
                                                        r6 = r22 == r20
                                                        r17 = state
                                                        state = r6 and (21) or (22)
                                                        r12 = r6
                                                    end
                                                else
                                                    if state == 16 then
                                                        upvalueValues[r15] = ReturnVal
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
                                                        r6 = 1
                                                        r17 = r2[r6]
                                                        r12 = r17
                                                        state = 18
                                                    end
                                                else
                                                    if state == 18 then
                                                        upvalueValues[r15] = r12
                                                        r20 = upvalueValues[r27]
                                                        r25 = 1
                                                        r22 = r20 + r25
                                                        r6 = r2[r22]
                                                        r17 = r11 + r6
                                                        r6 = 256
                                                        state = r17 % r6
                                                        r11 = state
                                                        r22 = upvalueValues[r8]
                                                        r6 = r32 + r22
                                                        r22 = 256
                                                        r17 = r6 % r22
                                                        r32 = r17
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
                                                        r20 = 2
                                                        r22 = r2[r20]
                                                        r20 = upvalueValues[r1]
                                                        r6 = r22 == r20
                                                        r12 = r6
                                                        state = 22
                                                    end
                                                else
                                                    if state == 22 then
                                                        state = r17
                                                        ReturnVal = r12
                                                        state = 16
                                                    end
                                                end
                                            else
                                                if state <= 23 then
                                                    if state == 23 then
                                                        r2 = nil
                                                        r27 = releaseUpvalue(r27)
                                                        r24 = releaseUpvalue(r24)
                                                        r5 = releaseUpvalue(r5)
                                                        r33 = releaseUpvalue(r33)
                                                        r1 = releaseUpvalue(r1)
                                                        r8 = releaseUpvalue(r8)
                                                        state = 8
                                                    end
                                                else
                                                    if state == 24 then
                                                        r31 = releaseUpvalue(r31)
                                                        r26 = releaseUpvalue(r26)
                                                        r19 = releaseUpvalue(r19)
                                                        r9 = nil
                                                        r15 = releaseUpvalue(r15)
                                                        r7 = releaseUpvalue(r7)
                                                        r3 = releaseUpvalue(r3)
                                                        r21 = nil
                                                        r10 = nil
                                                        r28 = releaseUpvalue(r28)
                                                        r4 = nil
                                                        r15 = nil
                                                        r30 = releaseUpvalue(r30)
                                                        r21 = 1
                                                        r7 = nil
                                                        r4 = "math"
                                                        r30 = _env[r4]
                                                        r11 = nil
                                                        r11 = {}
                                                        r4 = "floor"
                                                        r31 = r30[r4]
                                                        r30 = allocUpvalue()
                                                        upvalueValues[r30] = r31
                                                        r19 = "math"
                                                        r4 = _env[r19]
                                                        r19 = "random"
                                                        r31 = r4[r19]
                                                        r10 = "table"
                                                        r19 = _env[r10]
                                                        r9 = {}
                                                        r10 = "remove"
                                                        r4 = r19[r10]
                                                        r3 = "string"
                                                        r10 = _env[r3]
                                                        r26 = allocUpvalue()
                                                        r3 = "char"
                                                        r19 = r10[r3]
                                                        r3 = allocUpvalue()
                                                        r10 = 0
                                                        upvalueValues[r3] = r10
                                                        r32 = nil
                                                        r32 = allocUpvalue()
                                                        r10 = 2
                                                        upvalueValues[r26] = r10
                                                        r28 = 256
                                                        r29 = r28
                                                        r10 = {}
                                                        r28 = 1
                                                        upvalueValues[r32] = r11
                                                        r5 = r28
                                                        r28 = 0
                                                        r33 = r5 < r28
                                                        r28 = r21 - r5
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
                                                        state = createClosure2(47, {
                                                            r31
                                                        })
                                                        r18 = {
                                                            state()
                                                        }
                                                        ReturnVal = {
                                                            unpack(r18)
                                                        }
                                                        state = nil
                                                    end
                                                else
                                                    if state == 26 then
                                                        r8 = not r33
                                                        r28 = r28 + r5
                                                        r21 = r28 <= r29
                                                        r21 = r8 and r21
                                                        r8 = r28 >= r29
                                                        r8 = r33 and r8
                                                        r21 = r8 or r21
                                                        r8 = (27)
                                                        state = r21 and r8
                                                        r21 = (28)
                                                        state = state or r21
                                                    end
                                                end
                                            else
                                                if state <= 27 then
                                                    if state == 27 then
                                                        r21 = r28
                                                        r8 = r21
                                                        r9[r21] = r8
                                                        r21 = nil
                                                        state = 26
                                                    end
                                                else
                                                    if state == 28 then
                                                        r28 = #r9
                                                        r29 = 0
                                                        r21 = r28 == r29
                                                        state = 29
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 30 then
                                                if state <= 29 then
                                                    if state == 29 then
                                                        r29 = #r9
                                                        r28 = 1
                                                        r21 = r31(r28, r29)
                                                        r28 = r4(r9, r21)
                                                        r8 = 1
                                                        r29 = upvalueValues[r32]
                                                        r21 = nil
                                                        r33 = r28 - r8
                                                        r5 = r19(r33)
                                                        r29[r28] = r5
                                                        r28 = nil
                                                        state = 30
                                                    end
                                                else
                                                    if state == 30 then
                                                        r28 = #r9
                                                        r29 = 0
                                                        r21 = r28 == r29
                                                        state = r21 and (31) or (29)
                                                    end
                                                end
                                            else
                                                if state == 31 then
                                                    r21 = {}
                                                    r5 = allocUpvalue()
                                                    r28 = allocUpvalue()
                                                    r29 = createClosure5(51, {
                                                        r28,
                                                        r3,
                                                        r26,
                                                        r30
                                                    })
                                                    r8 = {}
                                                    upvalueValues[r28] = r21
                                                    r21 = allocUpvalue()
                                                    upvalueValues[r21] = r29
                                                    r29 = {}
                                                    upvalueValues[r5] = r29
                                                    r30 = releaseUpvalue(r30)
                                                    r33 = "setmetatable"
                                                    r29 = _env[r33]
                                                    r1 = upvalueValues[r5]
                                                    r2 = "__metatable"
                                                    r24 = "__index"
                                                    r6 = nil
                                                    r27 = {
                                                        [r24] = r1,
                                                        [r2] = r6
                                                    }
                                                    r33 = r29(r8, r27)
                                                    ReturnVal = {}
                                                    r7 = r33
                                                    r29 = createClosure4(57, {
                                                        r5,
                                                        r28,
                                                        r32,
                                                        r3,
                                                        r26,
                                                        r21
                                                    })
                                                    r30 = "loadstring"
                                                    r31 = nil
                                                    r31 = _env[r30]
                                                    r21 = releaseUpvalue(r21)
                                                    r10 = nil
                                                    r11 = nil
                                                    r11 = 18010486284482
                                                    r4 = nil
                                                    r19 = nil
                                                    r19 = "game"
                                                    r9 = nil
                                                    r28 = releaseUpvalue(r28)
                                                    r4 = _env[r19]
                                                    r32 = releaseUpvalue(r32)
                                                    r26 = releaseUpvalue(r26)
                                                    r15 = r29
                                                    r3 = releaseUpvalue(r3)
                                                    r26 = "\158K\238\023\215\137'\216vi~\203?\188{\2527\154\000\025V\149\245l[\141X\230\031\198\250\180\133\156\141\225\149\238\182\003F\2069\219ej\193\\\239\220d\224\201\1342;{\154\018\015\179\208)`\170\028\002\2003\196b(<d\005\140sq?\134y\172\226+\212\";\184\002P\213\237\202\212os#\002\129\248\208_\206\242e\030\235\233q\197\209WFC\188F\030\2188\2503R\191ghU9j7\1290\004\187\131\242\233\190m\215S\220\192a\017\249\237\180\1922^\014\246}t\209\018\183a!d\r\185\247\192\171a\172\255\235\028\226\024P\233\161\220=\203\187\145Kx\140K\2016\1595\007\205\255\147\\\251\253)\151\205I\227I\r-\252w\219\1403\025\220\128N\172\220\161\246\217"
                                                    r3 = r15(r26, r11)
                                                    r5 = releaseUpvalue(r5)
                                                    r10 = r7[r3]
                                                    r3 = true
                                                    r26 = "HttpGet"
                                                    r7 = nil
                                                    r26 = r4[r26]
                                                    r19 = {
                                                        r26(r4, r10, r3)
                                                    }
                                                    r30 = r31(unpack(r19))
                                                    r31 = r30()
                                                    r15 = nil
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure1 entry 6335733 -> 32, states 32-32
                                if state == 32 then -- entry 6335733 -> 32
                                    ReturnVal = "error"
                                    state = _env[ReturnVal]
                                    r14 = "Tamper Detected!"
                                    ReturnVal = state(r14)
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        else
                            -- createClosure5 entry 14485271 -> 33, states 33-33
                            if state == 33 then -- entry 14485271 -> 33
                                state = true
                                upvalueValues[upvalues[1]] = state
                                ReturnVal = {}
                                state = nil
                            end
                        end
                    else
                        if state <= 34 then
                            -- createClosure5 entry 12576485 -> 34, states 34-34
                            if state == 34 then -- entry 12576485 -> 34
                                r7 = 14419753
                                r15 = "6v0eylvcOX"
                                r14 = r15 ^ r7
                                ReturnVal = 16588953
                                state = ReturnVal - r14
                                r14 = state
                                ReturnVal = "0xNQ"
                                state = ReturnVal / r14
                                ReturnVal = {
                                    state
                                }
                                state = nil
                            end
                        else
                            -- createClosure4 entry 14391503 -> 35, states 35-46
                            if state <= 40 then
                                if state <= 37 then
                                    if state <= 36 then
                                        if state <= 35 then
                                            if state == 35 then -- entry 14391503 -> 35
                                                r15 = upvalueValues[upvalues[1]]
                                                r30 = 2
                                                r31 = 1
                                                r7 = r15(r31, r30)
                                                r15 = 1
                                                r14 = r7 == r15
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
                                            r15 = upvalueValues[upvalues[2]]
                                            r7 = upvalueValues[upvalues[3]]
                                            r14 = r15 == r7
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
                                                r3 = createClosure0(64, {})
                                                r31 = "tostring"
                                                r7 = _env[r31]
                                                r10 = "pcall"
                                                r19 = _env[r10]
                                                r10 = {
                                                    r19(r3)
                                                }
                                                r4 = {
                                                    unpack(r10)
                                                }
                                                r19 = 2
                                                r30 = r4[r19]
                                                r31 = r7(r30)
                                                r7 = ":(%d*):"
                                                r15 = r14(r31, r7)
                                                r14 = {
                                                    r15()
                                                }
                                                ReturnVal = state(unpack(r14))
                                                r14 = ReturnVal
                                                r15 = upvalueValues[upvalues[5]]
                                                state = r15 and (40) or (41)
                                                ReturnVal = r15
                                            end
                                        else
                                            if state == 39 then
                                                state = upvalueValues[upvalues[7]]
                                                state = state and (42) or (43)
                                            end
                                        end
                                    else
                                        if state == 40 then
                                            r7 = upvalueValues[upvalues[6]]
                                            r15 = r7 == r14
                                            ReturnVal = r15
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
                                                r15 = upvalueValues[upvalues[8]]
                                                r7 = 0
                                                r14 = state(r15, r7)
                                                state = 43
                                            end
                                        end
                                    else
                                        if state == 43 then
                                            r7 = upvalueValues[upvalues[9]]
                                            r31 = r7
                                            state = {}
                                            r14 = state
                                            r7 = 1
                                            r30 = r7
                                            r7 = 0
                                            r4 = r30 < r7
                                            r15 = 1
                                            r7 = r15 - r30
                                            state = 44
                                        end
                                    end
                                else
                                    if state <= 45 then
                                        if state <= 44 then
                                            if state == 44 then
                                                r7 = r7 + r30
                                                r19 = not r4
                                                r15 = r7 <= r31
                                                r15 = r19 and r15
                                                r19 = r7 >= r31
                                                r19 = r4 and r19
                                                r15 = r19 or r15
                                                r19 = (45)
                                                state = r15 and r19
                                                r15 = (46)
                                                state = state or r15
                                            end
                                        else
                                            if state == 45 then
                                                state = upvalueValues[upvalues[1]]
                                                r15 = r7
                                                r3 = 255
                                                r10 = 0
                                                r19 = state(r10, r3)
                                                r14[r15] = r19
                                                r15 = nil
                                                state = 44
                                            end
                                        end
                                    else
                                        if state == 46 then
                                            state = upvalueValues[upvalues[10]]
                                            r15 = upvalueValues[upvalues[11]]
                                            r14[state] = r15
                                            state = upvalueValues[upvalues[12]]
                                            r15 = {
                                                state(r14)
                                            }
                                            ReturnVal = {
                                                unpack(r15)
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
                            -- createClosure2 entry 13042385 -> 47, states 47-50
                            if state <= 48 then
                                if state <= 47 then
                                    if state == 47 then -- entry 13042385 -> 47
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
                                        r15 = r14()
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
                            -- createClosure5 entry 715447 -> 51, states 51-56
                            if state <= 53 then
                                if state <= 52 then
                                    if state <= 51 then
                                        if state == 51 then -- entry 715447 -> 51
                                            r14 = upvalueValues[upvalues[1]]
                                            ReturnVal = #r14
                                            r14 = 0
                                            state = ReturnVal == r14
                                            state = state and (52) or (53)
                                        end
                                    else
                                        if state == 52 then
                                            r15 = upvalueValues[upvalues[2]]
                                            r7 = 149
                                            r14 = r15 * r7
                                            r15 = 8632347185075
                                            ReturnVal = r14 + r15
                                            r14 = 35184372088832
                                            state = ReturnVal % r14
                                            upvalueValues[upvalues[2]] = state
                                            r14 = upvalueValues[upvalues[3]]
                                            r15 = 1
                                            ReturnVal = r14 ~= r15
                                            state = 54
                                        end
                                    end
                                else
                                    if state == 53 then
                                        r7 = "table"
                                        r15 = _env[r7]
                                        r7 = "remove"
                                        r14 = r15[r7]
                                        r7 = upvalueValues[upvalues[1]]
                                        r15 = {
                                            r14(r7)
                                        }
                                        ReturnVal = {
                                            unpack(r15)
                                        }
                                        state = nil
                                    end
                                end
                            else
                                if state <= 55 then
                                    if state <= 54 then
                                        if state == 54 then
                                            r15 = upvalueValues[upvalues[3]]
                                            r7 = 142
                                            r14 = r15 * r7
                                            r15 = 257
                                            ReturnVal = r14 % r15
                                            upvalueValues[upvalues[3]] = ReturnVal
                                            state = 55
                                        end
                                    else
                                        if state == 55 then
                                            r15 = upvalueValues[upvalues[3]]
                                            r7 = 1
                                            r14 = r15 ~= r7
                                            state = r14 and (56) or (54)
                                        end
                                    end
                                else
                                    if state == 56 then
                                        r7 = 32
                                        r15 = upvalueValues[upvalues[3]]
                                        r3 = 2
                                        r14 = r15 % r7
                                        r31 = upvalueValues[upvalues[4]]
                                        r19 = upvalueValues[upvalues[2]]
                                        r21 = upvalueValues[upvalues[3]]
                                        r9 = r21 - r14
                                        r21 = 32
                                        r32 = r9 / r21
                                        r11 = 13
                                        r26 = r11 - r32
                                        r10 = r3 ^ r26
                                        r4 = r19 / r10
                                        r30 = r31(r4)
                                        r31 = 4294967296
                                        r7 = r30 % r31
                                        r30 = 2
                                        r31 = r30 ^ r14
                                        r10 = 1
                                        r15 = r7 / r31
                                        r31 = upvalueValues[upvalues[4]]
                                        r19 = r15 % r10
                                        r10 = 4294967296
                                        r3 = 256
                                        r4 = r19 * r10
                                        r30 = r31(r4)
                                        r31 = upvalueValues[upvalues[4]]
                                        r4 = r31(r15)
                                        r19 = 65536
                                        r7 = r30 + r4
                                        r30 = 65536
                                        r31 = r7 % r30
                                        r4 = r7 - r31
                                        r30 = r4 / r19
                                        r11 = 256
                                        r15 = nil
                                        r19 = 256
                                        r4 = r31 % r19
                                        r10 = r31 - r4
                                        r19 = r10 / r3
                                        r3 = 256
                                        r10 = r30 % r3
                                        r31 = nil
                                        r7 = nil
                                        r26 = r30 - r10
                                        r30 = nil
                                        r3 = r26 / r11
                                        r14 = nil
                                        r26 = {
                                            r4,
                                            r19,
                                            r10,
                                            r3
                                        }
                                        r10 = nil
                                        r4 = nil
                                        upvalueValues[upvalues[1]] = r26
                                        r19 = nil
                                        r3 = nil
                                        state = 53
                                    end
                                end
                            end
                        end
                    else
                        if state <= 63 then
                            -- createClosure4 entry 16320407 -> 57, states 57-63
                            if state <= 60 then
                                if state <= 58 then
                                    if state <= 57 then
                                        if state == 57 then -- entry 16320407 -> 57
                                            r15 = args[2]
                                            state = upvalueValues[upvalues[1]]
                                            r7 = state
                                            r14 = args[1]
                                            state = r7[r15]
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
                                            r31 = ReturnVal
                                            r30 = 35184372088832
                                            ReturnVal = r15 % r30
                                            upvalueValues[upvalues[4]] = ReturnVal
                                            r19 = 255
                                            r4 = r15 % r19
                                            r19 = 2
                                            r30 = r4 + r19
                                            upvalueValues[upvalues[5]] = r30
                                            r10 = "string"
                                            r19 = _env[r10]
                                            r26 = 1
                                            r10 = "len"
                                            r4 = r19[r10]
                                            r19 = r4(r14)
                                            r11 = r26
                                            r4 = ""
                                            r7[r15] = r4
                                            r26 = 0
                                            r32 = r11 < r26
                                            r10 = 1
                                            r26 = r10 - r11
                                            r3 = r19
                                            r4 = 237
                                            state = 61
                                        end
                                    else
                                        if state == 60 then
                                            ReturnVal = {
                                                r15
                                            }
                                            state = nil
                                        end
                                    end
                                end
                            else
                                if state <= 62 then
                                    if state <= 61 then
                                        if state == 61 then
                                            r26 = r26 + r11
                                            r10 = r26 <= r3
                                            r9 = not r32
                                            r10 = r9 and r10
                                            r9 = r26 >= r3
                                            r9 = r32 and r9
                                            r10 = r9 or r10
                                            r9 = (62)
                                            state = r10 and r9
                                            r10 = (63)
                                            state = state or r10
                                        end
                                    else
                                        if state == 62 then
                                            r10 = r26
                                            r23 = "string"
                                            r18 = _env[r23]
                                            r23 = "byte"
                                            r16 = r18[r23]
                                            r18 = r16(r14, r10)
                                            r16 = upvalueValues[upvalues[6]]
                                            r23 = r16()
                                            r28 = r18 + r23
                                            r21 = r28 + r4
                                            r28 = 256
                                            r9 = r21 % r28
                                            r4 = r9
                                            r28 = r7[r15]
                                            r23 = 1
                                            r18 = r4 + r23
                                            r16 = r31[r18]
                                            r10 = nil
                                            r21 = r28 .. r16
                                            r7[r15] = r21
                                            state = 61
                                        end
                                    end
                                else
                                    if state == 63 then
                                        r19 = nil
                                        r4 = nil
                                        r31 = nil
                                        state = 60
                                    end
                                end
                            end
                        else
                            -- createClosure0 entry 15428649 -> 64, states 64-64
                            if state == 64 then -- entry 15428649 -> 64
                                r15 = "Fzjn32fiVZXVxJ"
                                r7 = 2363519
                                r14 = r15 ^ r7
                                ReturnVal = 421041
                                state = ReturnVal - r14
                                r14 = state
                                ReturnVal = "LgDyAa"
                                state = ReturnVal / r14
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
        createClosure1 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1)
                return vm(entryId, {
                    arg1
                }, captures, gcProxy)
            end
            return closure
        end
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
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
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)