return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, createClosure2, upvalueRefCounts, createClosure6, releaseUpvalues, createClosure, vm, createClosure5, currentUpvalueId, createClosure1, createClosure4, upvalueValues, createUpvalueProxy, releaseUpvalue, createClosure0, allocUpvalue, createClosure3)
        allocUpvalue = function()
            currentUpvalueId = currentUpvalueId + (1)
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
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
        createClosure0 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function()
                return vm(entryId, {}, captures, gcProxy)
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
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if upvalueRefCounts[upvalueId] == 0 then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
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
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return -706394
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -706394
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
        upvalueValues = {}
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, ReturnVal, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63
            while state do
                if state <= 56 then
                    if state <= 34 then
                        if state <= 32 then
                            if state <= 31 then
                                -- root entry 12444899 -> 1, states 1-31
                                if state <= 16 then
                                    if state <= 8 then
                                        if state <= 4 then
                                            if state <= 2 then
                                                if state <= 1 then
                                                    if state == 1 then -- entry 12444899 -> 1
                                                        r31 = allocUpvalue()
                                                        state = true
                                                        upvalueValues[r31] = state
                                                        r52 = "string"
                                                        ReturnVal = _env[r52]
                                                        r46 = allocUpvalue()
                                                        r52 = "gmatch"
                                                        state = ReturnVal[r52]
                                                        r52 = allocUpvalue()
                                                        upvalueValues[r52] = state
                                                        r55 = allocUpvalue()
                                                        state = createClosure4(32, {})
                                                        upvalueValues[r55] = state
                                                        r10 = createClosure0(33, {
                                                            r46
                                                        })
                                                        state = false
                                                        upvalueValues[r46] = state
                                                        r43 = "pcall"
                                                        r44 = _env[r43]
                                                        r43 = r44(r10)
                                                        state = r43 and (2) or (3)
                                                        r32 = args
                                                        ReturnVal = r43
                                                    end
                                                else
                                                    if state == 2 then
                                                        r44 = upvalueValues[r46]
                                                        ReturnVal = r44
                                                        state = 3
                                                    end
                                                end
                                            else
                                                if state <= 3 then
                                                    if state == 3 then
                                                        r44 = ReturnVal
                                                        r43 = "math"
                                                        ReturnVal = _env[r43]
                                                        r43 = "random"
                                                        state = ReturnVal[r43]
                                                        r43 = allocUpvalue()
                                                        upvalueValues[r43] = state
                                                        r10 = "table"
                                                        ReturnVal = _env[r10]
                                                        r10 = "concat"
                                                        state = ReturnVal[r10]
                                                        r10 = state
                                                        r30 = state
                                                        r23 = "table"
                                                        r25 = _env[r23]
                                                        state = r25 and (4) or (5)
                                                        r61 = r25
                                                    end
                                                else
                                                    if state == 4 then
                                                        r19 = "table"
                                                        r23 = _env[r19]
                                                        r19 = "unpack"
                                                        r25 = r23[r19]
                                                        r61 = r25
                                                        state = 5
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 6 then
                                                if state <= 5 then
                                                    if state == 5 then
                                                        state = r30
                                                        state = r61 and (6) or (7)
                                                        ReturnVal = r61
                                                    end
                                                else
                                                    if state == 6 then
                                                        r61 = allocUpvalue()
                                                        upvalueValues[r61] = ReturnVal
                                                        state = upvalueValues[r43]
                                                        r30 = 3
                                                        r25 = 65
                                                        ReturnVal = state(r30, r25)
                                                        r1 = createClosure2(34, {})
                                                        state = 0
                                                        r30 = allocUpvalue()
                                                        upvalueValues[r30] = ReturnVal
                                                        r25 = state
                                                        state = 0
                                                        r19 = "pcall"
                                                        ReturnVal = _env[r19]
                                                        r19 = {
                                                            ReturnVal(r1)
                                                        }
                                                        r23 = state
                                                        state = {
                                                            unpack(r19)
                                                        }
                                                        r19 = state
                                                        ReturnVal = 2
                                                        state = r19[ReturnVal]
                                                        r1 = state
                                                        ReturnVal = "tonumber"
                                                        state = _env[ReturnVal]
                                                        r15 = upvalueValues[r52]
                                                        r58 = "tostring"
                                                        r42 = _env[r58]
                                                        r58 = r42(r1)
                                                        r42 = ":(%d*):"
                                                        r26 = r15(r58, r42)
                                                        r15 = {
                                                            r26()
                                                        }
                                                        ReturnVal = state(unpack(r15))
                                                        r15 = allocUpvalue()
                                                        upvalueValues[r15] = ReturnVal
                                                        r26 = upvalueValues[r30]
                                                        r42 = r26
                                                        r26 = 1
                                                        r58 = r26
                                                        r26 = 0
                                                        r2 = r58 < r26
                                                        ReturnVal = 1
                                                        r26 = ReturnVal - r58
                                                        state = 8
                                                    end
                                                end
                                            else
                                                if state <= 7 then
                                                    if state == 7 then
                                                        r30 = "unpack"
                                                        r61 = _env[r30]
                                                        ReturnVal = r61
                                                        state = 6
                                                    end
                                                else
                                                    if state == 8 then
                                                        r9 = not r2
                                                        r26 = r26 + r58
                                                        ReturnVal = r26 <= r42
                                                        ReturnVal = r9 and ReturnVal
                                                        r9 = r26 >= r42
                                                        r9 = r2 and r9
                                                        ReturnVal = r9 or ReturnVal
                                                        r9 = (9)
                                                        state = ReturnVal and r9
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
                                                        r9 = allocUpvalue()
                                                        upvalueValues[r9] = r26
                                                        r6 = "math"
                                                        ReturnVal = _env[r6]
                                                        r6 = "random"
                                                        state = ReturnVal[r6]
                                                        r33 = 100
                                                        r6 = 1
                                                        ReturnVal = state(r6, r33)
                                                        r6 = allocUpvalue()
                                                        upvalueValues[r6] = ReturnVal
                                                        state = upvalueValues[r43]
                                                        r56 = 255
                                                        r33 = 0
                                                        ReturnVal = state(r33, r56)
                                                        r33 = allocUpvalue()
                                                        upvalueValues[r33] = ReturnVal
                                                        state = upvalueValues[r43]
                                                        r22 = upvalueValues[r6]
                                                        r56 = 1
                                                        ReturnVal = state(r56, r22)
                                                        r56 = allocUpvalue()
                                                        upvalueValues[r56] = ReturnVal
                                                        ReturnVal = upvalueValues[r43]
                                                        r27 = 2
                                                        r24 = 1
                                                        r22 = ReturnVal(r24, r27)
                                                        ReturnVal = 1
                                                        state = r22 == ReturnVal
                                                        r22 = allocUpvalue()
                                                        upvalueValues[r22] = state
                                                        r28 = "tostring"
                                                        r5 = _env[r28]
                                                        r17 = upvalueValues[r43]
                                                        r7 = 0
                                                        r63 = 10000
                                                        r48 = {
                                                            r17(r7, r63)
                                                        }
                                                        r28 = r5(unpack(r48))
                                                        r5 = ":"
                                                        r13 = r28 .. r5
                                                        state = "gsub"
                                                        state = r1[state]
                                                        r27 = ":"
                                                        r24 = r27 .. r13
                                                        ReturnVal = ":(%d*):"
                                                        state = state(r1, ReturnVal, r24)
                                                        r24 = allocUpvalue()
                                                        r13 = createClosure4(35, {
                                                            r43,
                                                            r9,
                                                            r30,
                                                            r52,
                                                            r31,
                                                            r15,
                                                            r22,
                                                            r24,
                                                            r6,
                                                            r56,
                                                            r33,
                                                            r61
                                                        })
                                                        upvalueValues[r24] = state
                                                        r27 = "pcall"
                                                        ReturnVal = _env[r27]
                                                        r27 = {
                                                            ReturnVal(r13)
                                                        }
                                                        state = {
                                                            unpack(r27)
                                                        }
                                                        r27 = state
                                                        state = upvalueValues[r22]
                                                        state = state and (11) or (12)
                                                    end
                                                else
                                                    if state == 10 then
                                                        r42 = upvalueValues[r31]
                                                        state = r42 and (13) or (14)
                                                        r26 = r42
                                                    end
                                                end
                                            else
                                                if state <= 11 then
                                                    if state == 11 then
                                                        r13 = upvalueValues[r31]
                                                        state = r13 and (15) or (16)
                                                        ReturnVal = r13
                                                    end
                                                else
                                                    if state == 12 then
                                                        r5 = upvalueValues[r31]
                                                        state = r5 and (17) or (18)
                                                        r13 = r5
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 14 then
                                                if state <= 13 then
                                                    if state == 13 then
                                                        r42 = r25 == r23
                                                        r26 = r42
                                                        state = 14
                                                    end
                                                else
                                                    if state == 14 then
                                                        upvalueValues[r31] = r26
                                                        state = upvalueValues[r31]
                                                        state = state and (19) or (20)
                                                    end
                                                end
                                            else
                                                if state <= 15 then
                                                    if state == 15 then
                                                        r5 = state
                                                        r48 = 1
                                                        r17 = r27[r48]
                                                        r48 = false
                                                        r28 = r17 == r48
                                                        state = r28 and (21) or (22)
                                                        r13 = r28
                                                    end
                                                else
                                                    if state == 16 then
                                                        upvalueValues[r31] = ReturnVal
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
                                                        r28 = 1
                                                        r5 = r27[r28]
                                                        r13 = r5
                                                        state = 18
                                                    end
                                                else
                                                    if state == 18 then
                                                        upvalueValues[r31] = r13
                                                        r48 = upvalueValues[r56]
                                                        r7 = 1
                                                        r17 = r48 + r7
                                                        r28 = r27[r17]
                                                        r5 = r25 + r28
                                                        r28 = 256
                                                        state = r5 % r28
                                                        r25 = state
                                                        r17 = upvalueValues[r33]
                                                        r28 = r23 + r17
                                                        r17 = 256
                                                        r5 = r28 % r17
                                                        r23 = r5
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
                                                        r48 = 2
                                                        r17 = r27[r48]
                                                        r48 = upvalueValues[r24]
                                                        r28 = r17 == r48
                                                        r13 = r28
                                                        state = 22
                                                    end
                                                else
                                                    if state == 22 then
                                                        state = r5
                                                        ReturnVal = r13
                                                        state = 16
                                                    end
                                                end
                                            else
                                                if state <= 23 then
                                                    if state == 23 then
                                                        r24 = releaseUpvalue(r24)
                                                        r56 = releaseUpvalue(r56)
                                                        r33 = releaseUpvalue(r33)
                                                        r9 = releaseUpvalue(r9)
                                                        r27 = nil
                                                        r22 = releaseUpvalue(r22)
                                                        r6 = releaseUpvalue(r6)
                                                        state = 8
                                                    end
                                                else
                                                    if state == 24 then
                                                        r52 = releaseUpvalue(r52)
                                                        r43 = releaseUpvalue(r43)
                                                        r55 = releaseUpvalue(r55)
                                                        r61 = releaseUpvalue(r61)
                                                        r30 = releaseUpvalue(r30)
                                                        r15 = releaseUpvalue(r15)
                                                        r46 = releaseUpvalue(r46)
                                                        r31 = releaseUpvalue(r31)
                                                        r23 = nil
                                                        r23 = allocUpvalue()
                                                        r55 = allocUpvalue()
                                                        r31 = nil
                                                        upvalueValues[r55] = r31
                                                        r25 = nil
                                                        r25 = {}
                                                        r31 = allocUpvalue()
                                                        r52 = nil
                                                        upvalueValues[r31] = r52
                                                        r44 = nil
                                                        r44 = "math"
                                                        r46 = _env[r44]
                                                        r44 = "floor"
                                                        r52 = r46[r44]
                                                        r46 = allocUpvalue()
                                                        upvalueValues[r46] = r52
                                                        r43 = "math"
                                                        r44 = _env[r43]
                                                        r43 = "random"
                                                        r52 = r44[r43]
                                                        r10 = nil
                                                        r10 = "table"
                                                        r43 = _env[r10]
                                                        r10 = "remove"
                                                        r44 = r43[r10]
                                                        r61 = "string"
                                                        r10 = _env[r61]
                                                        r61 = "char"
                                                        r43 = r10[r61]
                                                        r61 = allocUpvalue()
                                                        r10 = 0
                                                        upvalueValues[r61] = r10
                                                        r30 = allocUpvalue()
                                                        r15 = 256
                                                        r10 = 2
                                                        upvalueValues[r30] = r10
                                                        upvalueValues[r23] = r25
                                                        r2 = r15
                                                        r19 = nil
                                                        r19 = {}
                                                        r15 = 1
                                                        r9 = r15
                                                        r15 = 0
                                                        r6 = r9 < r15
                                                        r1 = nil
                                                        r1 = 1
                                                        r15 = r1 - r9
                                                        r10 = {}
                                                        r25 = 0
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
                                                        state = createClosure3(47, {
                                                            r55
                                                        })
                                                        r42 = {
                                                            state()
                                                        }
                                                        ReturnVal = {
                                                            unpack(r42)
                                                        }
                                                        state = nil
                                                    end
                                                else
                                                    if state == 26 then
                                                        r15 = r15 + r9
                                                        r33 = not r6
                                                        r1 = r15 <= r2
                                                        r1 = r33 and r1
                                                        r33 = r15 >= r2
                                                        r33 = r6 and r33
                                                        r1 = r33 or r1
                                                        r33 = (27)
                                                        state = r1 and r33
                                                        r1 = (28)
                                                        state = state or r1
                                                    end
                                                end
                                            else
                                                if state <= 27 then
                                                    if state == 27 then
                                                        r1 = r15
                                                        r33 = r1
                                                        r19[r1] = r33
                                                        r1 = nil
                                                        state = 26
                                                    end
                                                else
                                                    if state == 28 then
                                                        r15 = #r19
                                                        r2 = 0
                                                        r1 = r15 == r2
                                                        state = 29
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 30 then
                                                if state <= 29 then
                                                    if state == 29 then
                                                        r15 = 1
                                                        r2 = #r19
                                                        r1 = r52(r15, r2)
                                                        r15 = r44(r19, r1)
                                                        r33 = 1
                                                        r1 = nil
                                                        r2 = upvalueValues[r23]
                                                        r6 = r15 - r33
                                                        r9 = r43(r6)
                                                        r2[r15] = r9
                                                        r15 = nil
                                                        state = 30
                                                    end
                                                else
                                                    if state == 30 then
                                                        r15 = #r19
                                                        r2 = 0
                                                        r1 = r15 == r2
                                                        state = r1 and (31) or (29)
                                                    end
                                                end
                                            else
                                                if state == 31 then
                                                    r28 = nil
                                                    r19 = nil
                                                    r15 = allocUpvalue()
                                                    r33 = {}
                                                    r1 = {}
                                                    r10 = nil
                                                    r2 = createClosure0(51, {
                                                        r15,
                                                        r61,
                                                        r30,
                                                        r46
                                                    })
                                                    r10 = "\182\017\228\143q\014\253@\202\239\158\137"
                                                    r19 = "\245\249\211\251\229+\169"
                                                    upvalueValues[r15] = r1
                                                    r9 = allocUpvalue()
                                                    r1 = allocUpvalue()
                                                    upvalueValues[r1] = r2
                                                    r2 = {}
                                                    upvalueValues[r9] = r2
                                                    r6 = "setmetatable"
                                                    r2 = _env[r6]
                                                    r24 = upvalueValues[r9]
                                                    r22 = "__index"
                                                    r27 = "__metatable"
                                                    r56 = {
                                                        [r22] = r24,
                                                        [r27] = r28
                                                    }
                                                    r6 = r2(r33, r56)
                                                    r2 = createClosure6(57, {
                                                        r9,
                                                        r15,
                                                        r23,
                                                        r61,
                                                        r30,
                                                        r1
                                                    })
                                                    r15 = releaseUpvalue(r15)
                                                    r61 = releaseUpvalue(r61)
                                                    r61 = 19080282661556
                                                    r1 = releaseUpvalue(r1)
                                                    r30 = releaseUpvalue(r30)
                                                    upvalueValues[r31] = r6
                                                    r9 = releaseUpvalue(r9)
                                                    upvalueValues[r55] = r2
                                                    r23 = releaseUpvalue(r23)
                                                    r25 = nil
                                                    r46 = releaseUpvalue(r46)
                                                    r46 = upvalueValues[r31]
                                                    r63 = 6127646165797
                                                    r44 = nil
                                                    r44 = upvalueValues[r55]
                                                    r24 = "\231\237f"
                                                    r43 = nil
                                                    r43 = r44(r10, r61)
                                                    r44 = allocUpvalue()
                                                    r52 = nil
                                                    r52 = r46[r43]
                                                    r43 = allocUpvalue()
                                                    r46 = allocUpvalue()
                                                    r29 = 7769681497634
                                                    r61 = "Color3"
                                                    upvalueValues[r46] = r52
                                                    r52 = 7
                                                    upvalueValues[r44] = r52
                                                    r52 = 2
                                                    upvalueValues[r43] = r52
                                                    r10 = _env[r61]
                                                    r30 = upvalueValues[r31]
                                                    r25 = upvalueValues[r55]
                                                    r1 = 33310993235095
                                                    r23 = r25(r19, r1)
                                                    r61 = r30[r23]
                                                    r52 = r10[r61]
                                                    r30 = 25
                                                    r25 = 45
                                                    r61 = 15
                                                    r10 = r52(r61, r30, r25)
                                                    r30 = "Color3"
                                                    r61 = _env[r30]
                                                    r25 = upvalueValues[r31]
                                                    r23 = upvalueValues[r55]
                                                    r15 = 1986295022492
                                                    r1 = "/\156\232\233$x6"
                                                    r19 = r23(r1, r15)
                                                    r30 = r25[r19]
                                                    r23 = 255
                                                    r52 = r61[r30]
                                                    r30 = 0
                                                    r25 = 191
                                                    r61 = r52(r30, r25, r23)
                                                    r52 = allocUpvalue()
                                                    r25 = "Color3"
                                                    upvalueValues[r52] = r61
                                                    r30 = _env[r25]
                                                    r23 = upvalueValues[r31]
                                                    r19 = upvalueValues[r55]
                                                    r2 = 28300409615226
                                                    r15 = "-\243\024\19722\030"
                                                    r1 = r19(r15, r2)
                                                    r25 = r23[r1]
                                                    r61 = r30[r25]
                                                    r19 = 255
                                                    r25 = 255
                                                    r23 = 255
                                                    r30 = r61(r25, r23, r19)
                                                    r23 = "Color3"
                                                    r4 = 15372994911222
                                                    r25 = _env[r23]
                                                    r19 = upvalueValues[r31]
                                                    r1 = upvalueValues[r55]
                                                    r9 = 10663769297765
                                                    r2 = "+\015\020\011\251\241\178"
                                                    r15 = r1(r2, r9)
                                                    r23 = r19[r15]
                                                    r54 = 16190608039283
                                                    r33 = 28272934286189
                                                    r61 = r25[r23]
                                                    r17 = 33414380944583
                                                    r19 = 191
                                                    r23 = 0
                                                    r1 = 255
                                                    r25 = r61(r23, r19, r1)
                                                    r19 = "Color3"
                                                    r23 = _env[r19]
                                                    r1 = upvalueValues[r31]
                                                    r15 = upvalueValues[r55]
                                                    r9 = "?IP\250\145)\208"
                                                    r2 = r15(r9, r33)
                                                    r19 = r1[r2]
                                                    r61 = r23[r19]
                                                    r19 = 0
                                                    r15 = 255
                                                    r1 = 191
                                                    r23 = r61(r19, r1, r15)
                                                    r33 = "\221\145\r"
                                                    r1 = "UDim2"
                                                    r19 = _env[r1]
                                                    r15 = upvalueValues[r31]
                                                    r47 = 16234633796999
                                                    r2 = upvalueValues[r55]
                                                    r56 = 12172072703524
                                                    r9 = r2(r33, r56)
                                                    r33 = "\026(\163\176I\031\229$\023\254HF/\163\132\137\168\245\190/\007\023\2311\150\141\177*b9\1581\215\217\156\015\199\002\241\239\137\145H\025'\014bs\158\203\007\152n;\151\186\012\154&u\184\213Pi\239i\251\239\211\238t\127\244\219\243\\\175\163\023\234MH\217\007f\254\235W\003\241%QH\137\190\226\007\156u\145\250\158\157\185qf\001\245\004\249\243(jY\188h\209>\184\020SV\150\152\195\208[/\194H\197l\129\173'I.$\249)y\007\171\199V\168\129\149\253\172D\133\221\021\153R\231q@\130\029\nNh_u\001h\213'\185"
                                                    r1 = r15[r9]
                                                    r28 = 29333845423451
                                                    r61 = r19[r1]
                                                    r2 = 0
                                                    r15 = 400
                                                    r1 = 0
                                                    r9 = 250
                                                    r19 = r61(r1, r15, r2, r9)
                                                    r15 = upvalueValues[r31]
                                                    r61 = 16
                                                    r2 = upvalueValues[r55]
                                                    r56 = 14062102878612
                                                    r9 = r2(r33, r56)
                                                    r1 = r15[r9]
                                                    r15 = allocUpvalue()
                                                    upvalueValues[r15] = r1
                                                    r9 = "Instance"
                                                    r2 = _env[r9]
                                                    r33 = upvalueValues[r31]
                                                    r56 = upvalueValues[r55]
                                                    r27 = 13535124379806
                                                    r22 = r56(r24, r27)
                                                    r7 = 29518263711153
                                                    r9 = r33[r22]
                                                    r1 = r2[r9]
                                                    r33 = upvalueValues[r31]
                                                    r24 = "\191\194\181/\"\253\153~\196"
                                                    r56 = upvalueValues[r55]
                                                    r27 = 2395052655707
                                                    r22 = r56(r24, r27)
                                                    r48 = 3114161620394
                                                    r9 = r33[r22]
                                                    r33 = "Instance"
                                                    r2 = r1(r9)
                                                    r1 = allocUpvalue()
                                                    upvalueValues[r1] = r2
                                                    r9 = _env[r33]
                                                    r56 = upvalueValues[r31]
                                                    r22 = upvalueValues[r55]
                                                    r27 = "\180\215\129"
                                                    r24 = r22(r27, r28)
                                                    r33 = r56[r24]
                                                    r45 = 26411263422474
                                                    r2 = r9[r33]
                                                    r56 = upvalueValues[r31]
                                                    r22 = upvalueValues[r55]
                                                    r28 = 1067783864817
                                                    r27 = "q\135j_\160"
                                                    r24 = r22(r27, r28)
                                                    r33 = r56[r24]
                                                    r34 = 14980281916223
                                                    r9 = r2(r33)
                                                    r28 = "\202\144v"
                                                    r2 = allocUpvalue()
                                                    upvalueValues[r2] = r9
                                                    r56 = "Instance"
                                                    r33 = _env[r56]
                                                    r22 = upvalueValues[r31]
                                                    r24 = upvalueValues[r55]
                                                    r27 = r24(r28, r17)
                                                    r56 = r22[r27]
                                                    r9 = r33[r56]
                                                    r28 = "o\130\247E\238.\015\153"
                                                    r22 = upvalueValues[r31]
                                                    r17 = 16390275374544
                                                    r24 = upvalueValues[r55]
                                                    r27 = r24(r28, r17)
                                                    r56 = r22[r27]
                                                    r33 = r9(r56)
                                                    r22 = "Instance"
                                                    r56 = _env[r22]
                                                    r24 = upvalueValues[r31]
                                                    r27 = upvalueValues[r55]
                                                    r17 = "U\n,"
                                                    r28 = r27(r17, r48)
                                                    r48 = 1641147482876
                                                    r17 = "\135\144@(\190L\251\023"
                                                    r22 = r24[r28]
                                                    r9 = r56[r22]
                                                    r57 = 15136890280840
                                                    r24 = upvalueValues[r31]
                                                    r27 = upvalueValues[r55]
                                                    r28 = r27(r17, r48)
                                                    r22 = r24[r28]
                                                    r56 = r9(r22)
                                                    r9 = allocUpvalue()
                                                    r48 = "\141~\201"
                                                    r24 = "Instance"
                                                    upvalueValues[r9] = r56
                                                    r22 = _env[r24]
                                                    r27 = upvalueValues[r31]
                                                    r28 = upvalueValues[r55]
                                                    r17 = r28(r48, r7)
                                                    r7 = 5594708216365
                                                    r24 = r27[r17]
                                                    r56 = r22[r24]
                                                    r27 = upvalueValues[r31]
                                                    r48 = "\193\tb\016\137"
                                                    r28 = upvalueValues[r55]
                                                    r17 = r28(r48, r7)
                                                    r24 = r27[r17]
                                                    r7 = "S\217\238"
                                                    r22 = r56(r24)
                                                    r56 = allocUpvalue()
                                                    upvalueValues[r56] = r22
                                                    r27 = "Instance"
                                                    r24 = _env[r27]
                                                    r28 = upvalueValues[r31]
                                                    r17 = upvalueValues[r55]
                                                    r48 = r17(r7, r63)
                                                    r27 = r28[r48]
                                                    r22 = r24[r27]
                                                    r7 = "\011t4\234\217Y<("
                                                    r63 = 34462141497007
                                                    r28 = upvalueValues[r31]
                                                    r17 = upvalueValues[r55]
                                                    r48 = r17(r7, r63)
                                                    r27 = r28[r48]
                                                    r24 = r22(r27)
                                                    r28 = "Instance"
                                                    r63 = "\0048-"
                                                    r27 = _env[r28]
                                                    r17 = upvalueValues[r31]
                                                    r48 = upvalueValues[r55]
                                                    r7 = r48(r63, r4)
                                                    r28 = r17[r7]
                                                    r22 = r27[r28]
                                                    r17 = upvalueValues[r31]
                                                    r63 = "\188\025k\193x\1502\250"
                                                    r48 = upvalueValues[r55]
                                                    r4 = 34985805135779
                                                    r7 = r48(r63, r4)
                                                    r28 = r17[r7]
                                                    r27 = r22(r28)
                                                    r22 = allocUpvalue()
                                                    r17 = "Instance"
                                                    upvalueValues[r22] = r27
                                                    r28 = _env[r17]
                                                    r48 = upvalueValues[r31]
                                                    r7 = upvalueValues[r55]
                                                    r4 = "\211S\149"
                                                    r35 = 14008112142715
                                                    r63 = r7(r4, r35)
                                                    r17 = r48[r63]
                                                    r27 = r28[r17]
                                                    r4 = "\147V\008*\173"
                                                    r48 = upvalueValues[r31]
                                                    r7 = upvalueValues[r55]
                                                    r35 = 709495079242
                                                    r63 = r7(r4, r35)
                                                    r17 = r48[r63]
                                                    r28 = r27(r17)
                                                    r48 = "Instance"
                                                    r17 = _env[r48]
                                                    r7 = upvalueValues[r31]
                                                    r63 = upvalueValues[r55]
                                                    r35 = "4eY"
                                                    r4 = r63(r35, r57)
                                                    r48 = r7[r4]
                                                    r27 = r17[r48]
                                                    r7 = upvalueValues[r31]
                                                    r57 = 33756475227495
                                                    r63 = upvalueValues[r55]
                                                    r35 = "l\157\152\255\218\200{\206"
                                                    r4 = r63(r35, r57)
                                                    r48 = r7[r4]
                                                    r17 = r27(r48)
                                                    r57 = "\1878\254"
                                                    r7 = "Instance"
                                                    r48 = _env[r7]
                                                    r63 = upvalueValues[r31]
                                                    r4 = upvalueValues[r55]
                                                    r35 = r4(r57, r45)
                                                    r7 = r63[r35]
                                                    r27 = r48[r7]
                                                    r57 = "\203\237\169c\156.\240\157"
                                                    r63 = upvalueValues[r31]
                                                    r4 = upvalueValues[r55]
                                                    r45 = 16428592717282
                                                    r35 = r4(r57, r45)
                                                    r7 = r63[r35]
                                                    r45 = "\006Lk"
                                                    r48 = r27(r7)
                                                    r63 = "Instance"
                                                    r7 = _env[r63]
                                                    r4 = upvalueValues[r31]
                                                    r35 = upvalueValues[r55]
                                                    r57 = r35(r45, r54)
                                                    r63 = r4[r57]
                                                    r27 = r7[r63]
                                                    r4 = upvalueValues[r31]
                                                    r35 = upvalueValues[r55]
                                                    r54 = 28566512579574
                                                    r45 = "'\192!\002\189\t\248\003\252"
                                                    r57 = r35(r45, r54)
                                                    r63 = r4[r57]
                                                    r7 = r27(r63)
                                                    r4 = "Instance"
                                                    r63 = _env[r4]
                                                    r35 = upvalueValues[r31]
                                                    r57 = upvalueValues[r55]
                                                    r54 = "\236\023\144"
                                                    r51 = 31778018703821
                                                    r45 = r57(r54, r51)
                                                    r4 = r35[r45]
                                                    r27 = r63[r4]
                                                    r35 = upvalueValues[r31]
                                                    r54 = "\144\132\140[\t.\248nS"
                                                    r57 = upvalueValues[r55]
                                                    r51 = 86518612008
                                                    r45 = r57(r54, r51)
                                                    r3 = 26693133709453
                                                    r4 = r35[r45]
                                                    r53 = 13569917032622
                                                    r63 = r27(r4)
                                                    r60 = 28386928227234
                                                    r35 = "Instance"
                                                    r4 = _env[r35]
                                                    r57 = upvalueValues[r31]
                                                    r45 = upvalueValues[r55]
                                                    r51 = "\023i\213"
                                                    r54 = r45(r51, r3)
                                                    r3 = 33764313726314
                                                    r35 = r57[r54]
                                                    r27 = r4[r35]
                                                    r57 = upvalueValues[r31]
                                                    r45 = upvalueValues[r55]
                                                    r51 = "\215,\1789\025|oy\007"
                                                    r54 = r45(r51, r3)
                                                    r35 = r57[r54]
                                                    r3 = "Z\2175"
                                                    r57 = "Instance"
                                                    r4 = r27(r35)
                                                    r35 = _env[r57]
                                                    r45 = upvalueValues[r31]
                                                    r54 = upvalueValues[r55]
                                                    r51 = r54(r3, r60)
                                                    r60 = 2172530918387
                                                    r3 = "SAJ-\149\143\135\156\141"
                                                    r57 = r45[r51]
                                                    r27 = r35[r57]
                                                    r45 = upvalueValues[r31]
                                                    r54 = upvalueValues[r55]
                                                    r51 = r54(r3, r60)
                                                    r57 = r45[r51]
                                                    r45 = "Instance"
                                                    r35 = r27(r57)
                                                    r27 = allocUpvalue()
                                                    upvalueValues[r27] = r35
                                                    r60 = "\252\1551"
                                                    r57 = _env[r45]
                                                    r54 = upvalueValues[r31]
                                                    r51 = upvalueValues[r55]
                                                    r11 = 26852875907288
                                                    r3 = r51(r60, r11)
                                                    r37 = 20386043503892
                                                    r45 = r54[r3]
                                                    r35 = r57[r45]
                                                    r54 = upvalueValues[r31]
                                                    r51 = upvalueValues[r55]
                                                    r60 = "\148\174i>m"
                                                    r11 = 5374628841926
                                                    r3 = r51(r60, r11)
                                                    r45 = r54[r3]
                                                    r54 = "Instance"
                                                    r57 = r35(r45)
                                                    r45 = _env[r54]
                                                    r51 = upvalueValues[r31]
                                                    r3 = upvalueValues[r55]
                                                    r11 = "\232\226\134"
                                                    r60 = r3(r11, r47)
                                                    r54 = r51[r60]
                                                    r35 = r45[r54]
                                                    r47 = 5203628198263
                                                    r51 = upvalueValues[r31]
                                                    r3 = upvalueValues[r55]
                                                    r11 = "Y\152mJ\030qO\168"
                                                    r60 = r3(r11, r47)
                                                    r54 = r51[r60]
                                                    r45 = r35(r54)
                                                    r51 = "Instance"
                                                    r54 = _env[r51]
                                                    r3 = upvalueValues[r31]
                                                    r47 = "\158\024y"
                                                    r60 = upvalueValues[r55]
                                                    r11 = r60(r47, r29)
                                                    r47 = "\137\n\" Fu\183B"
                                                    r51 = r3[r11]
                                                    r29 = 10384107115235
                                                    r35 = r54[r51]
                                                    r3 = upvalueValues[r31]
                                                    r60 = upvalueValues[r55]
                                                    r11 = r60(r47, r29)
                                                    r51 = r3[r11]
                                                    r54 = r35(r51)
                                                    r3 = "Instance"
                                                    r51 = _env[r3]
                                                    r60 = upvalueValues[r31]
                                                    r11 = upvalueValues[r55]
                                                    r29 = "\023\162|"
                                                    r16 = 6271412063080
                                                    r47 = r11(r29, r16)
                                                    r3 = r60[r47]
                                                    r35 = r51[r3]
                                                    r29 = "\183\243\209\219z"
                                                    r60 = upvalueValues[r31]
                                                    r11 = upvalueValues[r55]
                                                    r16 = 5999690353385
                                                    r47 = r11(r29, r16)
                                                    r3 = r60[r47]
                                                    r51 = r35(r3)
                                                    r35 = allocUpvalue()
                                                    upvalueValues[r35] = r51
                                                    r60 = "Instance"
                                                    r3 = _env[r60]
                                                    r11 = upvalueValues[r31]
                                                    r47 = upvalueValues[r55]
                                                    r36 = 26774382489779
                                                    r16 = "\184?\218"
                                                    r29 = r47(r16, r36)
                                                    r60 = r11[r29]
                                                    r51 = r3[r60]
                                                    r11 = upvalueValues[r31]
                                                    r47 = upvalueValues[r55]
                                                    r36 = 9385573699858
                                                    r16 = "\237\027\217\143\173\142\189\243"
                                                    r29 = r47(r16, r36)
                                                    r60 = r11[r29]
                                                    r3 = r51(r60)
                                                    r11 = "Instance"
                                                    r60 = _env[r11]
                                                    r47 = upvalueValues[r31]
                                                    r29 = upvalueValues[r55]
                                                    r41 = 7640837836262
                                                    r36 = "\240\253\030"
                                                    r16 = r29(r36, r41)
                                                    r11 = r47[r16]
                                                    r51 = r60[r11]
                                                    r47 = upvalueValues[r31]
                                                    r29 = upvalueValues[r55]
                                                    r36 = "XV3e\145\246,\n"
                                                    r41 = 21108274095717
                                                    r16 = r29(r36, r41)
                                                    r11 = r47[r16]
                                                    r47 = "Instance"
                                                    r60 = r51(r11)
                                                    r11 = _env[r47]
                                                    r29 = upvalueValues[r31]
                                                    r16 = upvalueValues[r55]
                                                    r41 = "u\167\236"
                                                    r36 = r16(r41, r34)
                                                    r47 = r29[r36]
                                                    r34 = 13768484002059
                                                    r51 = r11[r47]
                                                    r29 = upvalueValues[r31]
                                                    r16 = upvalueValues[r55]
                                                    r41 = "2\216\248wi"
                                                    r36 = r16(r41, r34)
                                                    r47 = r29[r36]
                                                    r11 = r51(r47)
                                                    r34 = "\238\197^"
                                                    r51 = allocUpvalue()
                                                    upvalueValues[r51] = r11
                                                    r29 = "Instance"
                                                    r47 = _env[r29]
                                                    r16 = upvalueValues[r31]
                                                    r36 = upvalueValues[r55]
                                                    r41 = r36(r34, r37)
                                                    r29 = r16[r41]
                                                    r11 = r47[r29]
                                                    r16 = upvalueValues[r31]
                                                    r36 = upvalueValues[r55]
                                                    r34 = "|\128\144\2076\237>\130"
                                                    r37 = 30353276843830
                                                    r41 = r36(r34, r37)
                                                    r29 = r16[r41]
                                                    r37 = "\239d9"
                                                    r47 = r11(r29)
                                                    r16 = "Instance"
                                                    r29 = _env[r16]
                                                    r36 = upvalueValues[r31]
                                                    r41 = upvalueValues[r55]
                                                    r34 = r41(r37, r53)
                                                    r16 = r36[r34]
                                                    r11 = r29[r16]
                                                    r37 = "\011\253T:h4pQ"
                                                    r36 = upvalueValues[r31]
                                                    r53 = 34394155646608
                                                    r41 = upvalueValues[r55]
                                                    r34 = r41(r37, r53)
                                                    r16 = r36[r34]
                                                    r29 = r11(r16)
                                                    r36 = "Instance"
                                                    r16 = _env[r36]
                                                    r53 = "\195\183\217"
                                                    r41 = upvalueValues[r31]
                                                    r34 = upvalueValues[r55]
                                                    r18 = 31062771923072
                                                    r37 = r34(r53, r18)
                                                    r53 = "\215|\205\128\027w3\134["
                                                    r36 = r41[r37]
                                                    r11 = r16[r36]
                                                    r41 = upvalueValues[r31]
                                                    r34 = upvalueValues[r55]
                                                    r18 = 28706807313463
                                                    r37 = r34(r53, r18)
                                                    r36 = r41[r37]
                                                    r16 = r11(r36)
                                                    r11 = allocUpvalue()
                                                    upvalueValues[r11] = r16
                                                    r36 = allocUpvalue()
                                                    r16 = true
                                                    upvalueValues[r36] = r16
                                                    r41 = allocUpvalue()
                                                    r16 = false
                                                    upvalueValues[r41] = r16
                                                    r16 = upvalueValues[r1]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r40 = 32966258768887
                                                    r14 = "\249,\249\169"
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r53 = upvalueValues[r31]
                                                    r18 = upvalueValues[r55]
                                                    r8 = 22289663256715
                                                    r40 = "\183\025\129m\2076q\tU\003-\250\209E\211"
                                                    r14 = r18(r40, r8)
                                                    r37 = r53[r14]
                                                    r16[r34] = r37
                                                    r16 = upvalueValues[r1]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r40 = 9951027941913
                                                    r14 = "\190c\219T\172@"
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r14 = "game"
                                                    r18 = _env[r14]
                                                    r40 = upvalueValues[r31]
                                                    r8 = upvalueValues[r55]
                                                    r39 = "W\130RK\221\2493"
                                                    r62 = 13972494719338
                                                    r20 = r8(r39, r62)
                                                    r14 = r40[r20]
                                                    r53 = r18[r14]
                                                    r14 = upvalueValues[r31]
                                                    r40 = upvalueValues[r55]
                                                    r20 = "}\146\213\146\255 \251g\154t\020"
                                                    r39 = 15671803731073
                                                    r8 = r40(r20, r39)
                                                    r18 = r14[r8]
                                                    r37 = r53[r18]
                                                    r14 = upvalueValues[r31]
                                                    r53 = "WaitForChild"
                                                    r40 = upvalueValues[r55]
                                                    r20 = "\218_\134\008\226>Y\194\140"
                                                    r39 = 6544674540519
                                                    r8 = r40(r20, r39)
                                                    r18 = r14[r8]
                                                    r53 = r37[r53]
                                                    r53 = r53(r37, r18)
                                                    r16[r34] = r53
                                                    r16 = upvalueValues[r1]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r40 = 14059013331346
                                                    r14 = "\207\209k\156`\230\016:`~o\028"
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r37 = false
                                                    r16[r34] = r37
                                                    r16 = upvalueValues[r56]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r14 = "\174.(\230"
                                                    r40 = 7180565335311
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r53 = upvalueValues[r31]
                                                    r18 = upvalueValues[r55]
                                                    r8 = 5124616161618
                                                    r40 = "\171\135W\020ze\157\146\229#C\182@1"
                                                    r14 = r18(r40, r8)
                                                    r37 = r53[r14]
                                                    r16[r34] = r37
                                                    r16 = upvalueValues[r56]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r40 = 7261569453365
                                                    r14 = "H\016\254\0083x"
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r37 = upvalueValues[r1]
                                                    r16[r34] = r37
                                                    r16 = upvalueValues[r56]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r40 = 9353096253699
                                                    r14 = "\192%M\148\183\245\230dP\132I\254\141\0111\251"
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r37 = r10
                                                    r16[r34] = r37
                                                    r16 = upvalueValues[r56]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r40 = 31977492068906
                                                    r14 = "\165*)\003W\012Y1-\219V[\245\252\147"
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r37 = 0
                                                    r16[r34] = r37
                                                    r16 = upvalueValues[r56]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r14 = "\188V\181@\022f\016N"
                                                    r40 = 12636198295292
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r18 = "UDim2"
                                                    r53 = _env[r18]
                                                    r14 = upvalueValues[r31]
                                                    r40 = upvalueValues[r55]
                                                    r39 = 25587730050699
                                                    r20 = "\247\0276"
                                                    r8 = r40(r20, r39)
                                                    r18 = r14[r8]
                                                    r37 = r53[r18]
                                                    r14 = -205
                                                    r8 = -130
                                                    r40 = 0.5
                                                    r18 = 0.5
                                                    r53 = r37(r18, r14, r40, r8)
                                                    r16[r34] = r53
                                                    r16 = upvalueValues[r56]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r14 = "\151$\006\197"
                                                    r40 = 1996748161953
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r18 = "UDim2"
                                                    r53 = _env[r18]
                                                    r14 = upvalueValues[r31]
                                                    r40 = upvalueValues[r55]
                                                    r20 = "\023\143\020"
                                                    r39 = 20405879809310
                                                    r8 = r40(r20, r39)
                                                    r18 = r14[r8]
                                                    r37 = r53[r18]
                                                    r8 = 260
                                                    r14 = 410
                                                    r18 = 0
                                                    r40 = 0
                                                    r53 = r37(r18, r14, r40, r8)
                                                    r16[r34] = r53
                                                    r16 = upvalueValues[r56]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r14 = "\146\128R\218+W\188-=\178\225\215F\232\127\128\025\172OC\178r"
                                                    r40 = 787465077102
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r37 = 0.3
                                                    r16[r34] = r37
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r14 = 8268160241418
                                                    r18 = "|r\203b\225Y+R\161~(\029"
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r53 = "UDim"
                                                    r37 = _env[r53]
                                                    r18 = upvalueValues[r31]
                                                    r14 = upvalueValues[r55]
                                                    r20 = 26405570162696
                                                    r8 = "\188\154\005"
                                                    r40 = r14(r8, r20)
                                                    r53 = r18[r40]
                                                    r34 = r37[r53]
                                                    r53 = 0
                                                    r14 = 5
                                                    r18 = r61 + r14
                                                    r37 = r34(r53, r18)
                                                    r24[r16] = r37
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r14 = 27561847566882
                                                    r18 = "\165\138!uL\156"
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r34 = upvalueValues[r56]
                                                    r24[r16] = r34
                                                    r16 = upvalueValues[r22]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r14 = "\230\211\224R\235"
                                                    r40 = 17653733941276
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r37 = r23
                                                    r16[r34] = r37
                                                    r16 = upvalueValues[r22]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r14 = "\002\202\139G\199\164\006\213\018"
                                                    r40 = 34046407998958
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r37 = 3
                                                    r16[r34] = r37
                                                    r16 = upvalueValues[r22]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r40 = 13485749573767
                                                    r14 = "~\028)\024{,z\027\000'\208\234"
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r37 = 0.5
                                                    r16[r34] = r37
                                                    r16 = upvalueValues[r22]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r40 = 32634015857500
                                                    r14 = "H\231\248\222Q\213"
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r37 = upvalueValues[r56]
                                                    r16[r34] = r37
                                                    r16 = upvalueValues[r2]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r14 = "\003J\224\152"
                                                    r40 = 12630519895801
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r53 = upvalueValues[r31]
                                                    r18 = upvalueValues[r55]
                                                    r8 = 33871793077660
                                                    r40 = "i.\030rA\141\206\184\143"
                                                    r14 = r18(r40, r8)
                                                    r37 = r53[r14]
                                                    r16[r34] = r37
                                                    r16 = upvalueValues[r2]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r40 = 27802920596114
                                                    r14 = "/\165\192\182\194d"
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r37 = upvalueValues[r1]
                                                    r16[r34] = r37
                                                    r16 = upvalueValues[r2]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r14 = "\244\152\161\133\028>\030\150\132\156\236UO0\223\252"
                                                    r40 = 26200436928424
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r37 = r10
                                                    r16[r34] = r37
                                                    r16 = upvalueValues[r2]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r40 = 33081576619052
                                                    r14 = "\237?Btc\225\170\147\180\238\254|{\244?"
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r37 = 0
                                                    r16[r34] = r37
                                                    r16 = upvalueValues[r2]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r14 = "G=\215\239\247\028\001&"
                                                    r40 = 23681320430355
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r18 = "UDim2"
                                                    r53 = _env[r18]
                                                    r14 = upvalueValues[r31]
                                                    r40 = upvalueValues[r55]
                                                    r39 = 19722872136672
                                                    r20 = "\156\132\197"
                                                    r8 = r40(r20, r39)
                                                    r18 = r14[r8]
                                                    r37 = r53[r18]
                                                    r8 = -125
                                                    r14 = -200
                                                    r40 = 0.5
                                                    r18 = 0.5
                                                    r53 = r37(r18, r14, r40, r8)
                                                    r16[r34] = r53
                                                    r16 = upvalueValues[r2]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r14 = "\025\015\023\142"
                                                    r40 = 30863463299107
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r37 = r19
                                                    r16[r34] = r37
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r14 = 10786611581854
                                                    r18 = "\184s\227\138\026\191\208,\223Y\172\236"
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r53 = "UDim"
                                                    r37 = _env[r53]
                                                    r18 = upvalueValues[r31]
                                                    r14 = upvalueValues[r55]
                                                    r20 = 29673900078585
                                                    r8 = "Jyo"
                                                    r40 = r14(r8, r20)
                                                    r53 = r18[r40]
                                                    r34 = r37[r53]
                                                    r53 = 0
                                                    r37 = r34(r53, r61)
                                                    r33[r16] = r37
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r14 = 9651585913230
                                                    r18 = "\025\000\n@p\182"
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r34 = upvalueValues[r2]
                                                    r33[r16] = r34
                                                    r16 = upvalueValues[r9]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r14 = "2\251F\021\171"
                                                    r40 = 26458415312928
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r37 = upvalueValues[r52]
                                                    r16[r34] = r37
                                                    r16 = upvalueValues[r9]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r40 = 1034202513889
                                                    r14 = "\188\011\203\128b\168\012\018\202"
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r37 = 2
                                                    r16[r34] = r37
                                                    r16 = upvalueValues[r9]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r40 = 23710599244577
                                                    r14 = "\022\154M\233\237Y"
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r37 = upvalueValues[r2]
                                                    r16[r34] = r37
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r14 = 33638980648240
                                                    r18 = "A?\021T"
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r40 = 6158818675507
                                                    r14 = "T,\142\146,A\218\253\006"
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r28[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r14 = 30972168697942
                                                    r18 = "\008*\012\248\144\165"
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r34 = upvalueValues[r2]
                                                    r28[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r14 = 7807704813107
                                                    r18 = "\157\152E\180\195\209\209\173\018\190L_B\r\186e"
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r53 = "Color3"
                                                    r37 = _env[r53]
                                                    r18 = upvalueValues[r31]
                                                    r14 = upvalueValues[r55]
                                                    r20 = 2951938655582
                                                    r8 = "\235\190\025\191\"\177\154"
                                                    r40 = r14(r8, r20)
                                                    r53 = r18[r40]
                                                    r34 = r37[r53]
                                                    r53 = 25
                                                    r14 = 55
                                                    r18 = 35
                                                    r37 = r34(r53, r18, r14)
                                                    r28[r16] = r37
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r18 = "\005C\238\019\179$\225T\207\174\147\022\151\027\129"
                                                    r14 = 8423994904402
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r34 = 0
                                                    r28[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r14 = 33395434863806
                                                    r18 = "\206\006\\e\011\210\209\n"
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r53 = "UDim2"
                                                    r37 = _env[r53]
                                                    r18 = upvalueValues[r31]
                                                    r14 = upvalueValues[r55]
                                                    r8 = "\165\1644"
                                                    r20 = 4948686817536
                                                    r40 = r14(r8, r20)
                                                    r53 = r18[r40]
                                                    r34 = r37[r53]
                                                    r53 = 0.05
                                                    r14 = 0.08
                                                    r40 = 0
                                                    r18 = 0
                                                    r37 = r34(r53, r18, r14, r40)
                                                    r28[r16] = r37
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r18 = "\161|\128-"
                                                    r14 = 28829874713712
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r53 = "UDim2"
                                                    r37 = _env[r53]
                                                    r18 = upvalueValues[r31]
                                                    r14 = upvalueValues[r55]
                                                    r20 = 34182899940909
                                                    r8 = "T\148\140"
                                                    r40 = r14(r8, r20)
                                                    r53 = r18[r40]
                                                    r34 = r37[r53]
                                                    r53 = 0
                                                    r40 = 60
                                                    r18 = 60
                                                    r14 = 0
                                                    r37 = r34(r53, r18, r14, r40)
                                                    r28[r16] = r37
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r18 = "~\234\002\026X%\206\221V-\180\221"
                                                    r14 = 13216847058954
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r53 = "UDim"
                                                    r37 = _env[r53]
                                                    r18 = upvalueValues[r31]
                                                    r14 = upvalueValues[r55]
                                                    r20 = 20051072771193
                                                    r8 = "za\243"
                                                    r40 = r14(r8, r20)
                                                    r53 = r18[r40]
                                                    r34 = r37[r53]
                                                    r53 = 0
                                                    r18 = 12
                                                    r37 = r34(r53, r18)
                                                    r17[r16] = r37
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r14 = 26560375418960
                                                    r18 = "X\150\179\133\235@"
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r34 = r28
                                                    r17[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r18 = "%\1282d4"
                                                    r14 = 30870581000231
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r34 = upvalueValues[r52]
                                                    r48[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r18 = "\150\1375\158\149\178\186\215&"
                                                    r14 = 18913108664935
                                                    r53 = r37(r18, r14)
                                                    r19 = nil
                                                    r16 = r34[r53]
                                                    r34 = 1
                                                    r48[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r14 = 4861752887511
                                                    r18 = "\202,\144\18379"
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r34 = r28
                                                    r48[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r14 = 28320224768899
                                                    r18 = "\252\000g/"
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r40 = 31543628560736
                                                    r14 = "\140\180Lx"
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r7[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r14 = 3549173859956
                                                    r18 = "\"\144\143\233\150W"
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r34 = r28
                                                    r7[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r18 = "\211\216\200S\223\130\233\255\237X\1610\191R\1536H\213\240A\191\015"
                                                    r14 = 20938773259798
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r34 = 1
                                                    r7[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r18 = "\253,\211\185"
                                                    r14 = 22559693383945
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r53 = "UDim2"
                                                    r37 = _env[r53]
                                                    r18 = upvalueValues[r31]
                                                    r14 = upvalueValues[r55]
                                                    r20 = 1446378373793
                                                    r8 = "]=\163"
                                                    r40 = r14(r8, r20)
                                                    r53 = r18[r40]
                                                    r34 = r37[r53]
                                                    r53 = 1
                                                    r40 = 0
                                                    r14 = 1
                                                    r18 = 0
                                                    r37 = r34(r53, r18, r14, r40)
                                                    r7[r16] = r37
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r18 = "\178l\012\228"
                                                    r14 = 9435721584937
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r18 = "Enum"
                                                    r53 = _env[r18]
                                                    r14 = upvalueValues[r31]
                                                    r40 = upvalueValues[r55]
                                                    r39 = 7098193415401
                                                    r20 = "\152\143\222&"
                                                    r8 = r40(r20, r39)
                                                    r18 = r14[r8]
                                                    r37 = r53[r18]
                                                    r18 = upvalueValues[r31]
                                                    r14 = upvalueValues[r55]
                                                    r8 = "\142\177\223\170\251X\213\132\253Y"
                                                    r20 = 32309841672901
                                                    r40 = r14(r8, r20)
                                                    r53 = r18[r40]
                                                    r34 = r37[r53]
                                                    r7[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r18 = "\252TI\137"
                                                    r14 = 20222333166792
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r40 = 1587721405155
                                                    r14 = "\004\167"
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r7[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r18 = "\1523<\238^?\157\232p\240"
                                                    r14 = 6777055480915
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r34 = upvalueValues[r52]
                                                    r7[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r18 = "\221\2506\156y\236\195(\174T"
                                                    r14 = 11496376374505
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r34 = true
                                                    r7[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r18 = "\206\\\021\194\197\149\228\014$\\D\192\017\240\1649\148^\242j;/"
                                                    r14 = 2621923919044
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r34 = 0.5
                                                    r7[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r18 = "\024\1939\237F\197-\0126\205\213\014\157\241\252\145"
                                                    r14 = 30487654725492
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r34 = r23
                                                    r7[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r18 = "qvZn"
                                                    r14 = 9950984933913
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r40 = 8780742610936
                                                    r14 = "\197,!&H"
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r63[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r18 = "\204\130\001]\170v"
                                                    r14 = 26275451334603
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r34 = upvalueValues[r2]
                                                    r63[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r18 = "\029\184\031\182\221O\140\000\020:\225<\003\227\148*dF\022\163M\218"
                                                    r14 = 17758689747021
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r34 = 1
                                                    r63[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r14 = 11732681266519
                                                    r18 = "\236g0\183\190&F\228"
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r53 = "UDim2"
                                                    r37 = _env[r53]
                                                    r18 = upvalueValues[r31]
                                                    r14 = upvalueValues[r55]
                                                    r20 = 34699446239006
                                                    r8 = "z,S"
                                                    r40 = r14(r8, r20)
                                                    r53 = r18[r40]
                                                    r34 = r37[r53]
                                                    r53 = 0.22
                                                    r14 = 0.08
                                                    r40 = 0
                                                    r18 = 0
                                                    r37 = r34(r53, r18, r14, r40)
                                                    r63[r16] = r37
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r18 = "\136\003\178Z"
                                                    r14 = 15969752505612
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r53 = "UDim2"
                                                    r37 = _env[r53]
                                                    r18 = upvalueValues[r31]
                                                    r14 = upvalueValues[r55]
                                                    r20 = 16681368084055
                                                    r8 = "\240N\016"
                                                    r40 = r14(r8, r20)
                                                    r53 = r18[r40]
                                                    r34 = r37[r53]
                                                    r53 = 0.73
                                                    r14 = 0.25
                                                    r18 = 0
                                                    r40 = 0
                                                    r37 = r34(r53, r18, r14, r40)
                                                    r63[r16] = r37
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r18 = "\152\138\154\213"
                                                    r14 = 28344948847503
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r18 = "Enum"
                                                    r53 = _env[r18]
                                                    r14 = upvalueValues[r31]
                                                    r40 = upvalueValues[r55]
                                                    r39 = 14968280357690
                                                    r20 = "\1331\t\018"
                                                    r8 = r40(r20, r39)
                                                    r18 = r14[r8]
                                                    r37 = r53[r18]
                                                    r18 = upvalueValues[r31]
                                                    r14 = upvalueValues[r55]
                                                    r8 = "\160nB\199F:g\189|n"
                                                    r20 = 29898215159394
                                                    r40 = r14(r8, r20)
                                                    r53 = r18[r40]
                                                    r34 = r37[r53]
                                                    r63[r16] = r34
                                                    r38 = 17028525661945
                                                    r20 = "\025\165\157Oo\218\159\144\171\1734\026\172\020"
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r18 = "\237\"\006\189"
                                                    r14 = 13211649513480
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r14 = "G\197\181J?\242\185\186\031\197"
                                                    r62 = 9326162186486
                                                    r40 = 6344283671434
                                                    r37 = upvalueValues[r31]
                                                    r10 = nil
                                                    r53 = upvalueValues[r55]
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r63[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r14 = 25584424054409
                                                    r18 = "9[`LH^+\130\152w"
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r34 = upvalueValues[r52]
                                                    r63[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r14 = 32124758178415
                                                    r18 = "\251\155\005d\128\238\203\022g!"
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r34 = true
                                                    r63[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r18 = "&\236\209\006Z\031\195n\141y\185\025\012\211"
                                                    r14 = 11206036558946
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r18 = "Enum"
                                                    r53 = _env[r18]
                                                    r14 = upvalueValues[r31]
                                                    r40 = upvalueValues[r55]
                                                    r39 = 18720276718093
                                                    r8 = r40(r20, r39)
                                                    r18 = r14[r8]
                                                    r37 = r53[r18]
                                                    r18 = upvalueValues[r31]
                                                    r14 = upvalueValues[r55]
                                                    r20 = 28484014633935
                                                    r8 = "\163[\244\248"
                                                    r40 = r14(r8, r20)
                                                    r53 = r18[r40]
                                                    r34 = r37[r53]
                                                    r63[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r18 = "6\210qpD\201\200\001\192T\221Q\ni\174\012\017\224!\221\1513"
                                                    r14 = 14755210418902
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r34 = 0.7
                                                    r63[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r14 = 4474677889059
                                                    r18 = "T\235\136\203\157-\001\209\234\003\183\003\227g\161-"
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r34 = r23
                                                    r63[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r18 = "C\208FO"
                                                    r14 = 15859335912665
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r40 = 16201588792696
                                                    r14 = "\167\157!\169oj\005W"
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r4[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r14 = 13910399473997
                                                    r18 = "\231\187=\175\145\028"
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r34 = upvalueValues[r2]
                                                    r4[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r14 = 22957529328066
                                                    r18 = "\1770\127\003\2006\196M\003\015]\173y\158\000\189\204\001\127\004\201K"
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r34 = 1
                                                    r4[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r18 = "2\153\217\236F\207\185\166"
                                                    r14 = 13327058376765
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r53 = "UDim2"
                                                    r37 = _env[r53]
                                                    r18 = upvalueValues[r31]
                                                    r14 = upvalueValues[r55]
                                                    r8 = "\151y\012"
                                                    r20 = 34132732657174
                                                    r40 = r14(r8, r20)
                                                    r53 = r18[r40]
                                                    r34 = r37[r53]
                                                    r53 = 0.05
                                                    r40 = 0
                                                    r14 = 0.38
                                                    r18 = 0
                                                    r37 = r34(r53, r18, r14, r40)
                                                    r4[r16] = r37
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r14 = 24545250733221
                                                    r18 = "\142\192\019\160"
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r53 = "UDim2"
                                                    r37 = _env[r53]
                                                    r18 = upvalueValues[r31]
                                                    r14 = upvalueValues[r55]
                                                    r8 = "\007\020\208"
                                                    r20 = 20104113857681
                                                    r40 = r14(r8, r20)
                                                    r53 = r18[r40]
                                                    r34 = r37[r53]
                                                    r53 = 0.9
                                                    r40 = 0
                                                    r14 = 0.12
                                                    r18 = 0
                                                    r37 = r34(r53, r18, r14, r40)
                                                    r4[r16] = r37
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r14 = 10444736926463
                                                    r18 = "3'\014\139"
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r18 = "Enum"
                                                    r53 = _env[r18]
                                                    r14 = upvalueValues[r31]
                                                    r40 = upvalueValues[r55]
                                                    r20 = "\173#PN"
                                                    r39 = 27167174668650
                                                    r8 = r40(r20, r39)
                                                    r18 = r14[r8]
                                                    r37 = r53[r18]
                                                    r18 = upvalueValues[r31]
                                                    r14 = upvalueValues[r55]
                                                    r20 = 15407396494342
                                                    r8 = "\216\021c\138\231\180"
                                                    r40 = r14(r8, r20)
                                                    r53 = r18[r40]
                                                    r34 = r37[r53]
                                                    r4[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r14 = 20395721860377
                                                    r18 = "^\205\174\166"
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r40 = 763545174371
                                                    r14 = "\168W\1383\150\158\255\140W\212\238\142\018\142c\031\255n"
                                                    r18 = r53(r14, r40)
                                                    ReturnVal = {}
                                                    r34 = r37[r18]
                                                    r4[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r18 = "\172\230\138/\011\154(\167\002\241"
                                                    r14 = 6498475723730
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r53 = "Color3"
                                                    r37 = _env[r53]
                                                    r18 = upvalueValues[r31]
                                                    r14 = upvalueValues[r55]
                                                    r20 = 2970039502183
                                                    r8 = "q~eP\201\143\023"
                                                    r40 = r14(r8, r20)
                                                    r53 = r18[r40]
                                                    r34 = r37[r53]
                                                    r53 = 180
                                                    r18 = 180
                                                    r14 = 180
                                                    r37 = r34(r53, r18, r14)
                                                    r4[r16] = r37
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r18 = "g_\223\220vN\255\255\"\022"
                                                    r14 = 12496226440891
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r34 = true
                                                    r4[r16] = r34
                                                    r16 = upvalueValues[r27]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r40 = 6013549857520
                                                    r14 = "{.+,"
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r53 = upvalueValues[r31]
                                                    r18 = upvalueValues[r55]
                                                    r8 = 18939792024179
                                                    r40 = ".\025z\006\149\138\220\202\204\021\t"
                                                    r14 = r18(r40, r8)
                                                    r37 = r53[r14]
                                                    r16[r34] = r37
                                                    r16 = upvalueValues[r27]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r40 = 29177594524946
                                                    r14 = "\223\226\011\157\145{"
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r37 = upvalueValues[r2]
                                                    r16[r34] = r37
                                                    r16 = upvalueValues[r27]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r40 = 34358498705023
                                                    r14 = "hk\140\162\001[Q%K\207\225\205\230f\241++\201\1778#k"
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r37 = 1
                                                    r16[r34] = r37
                                                    r16 = upvalueValues[r27]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r14 = "`r\217\255l\022k\171"
                                                    r40 = 33908072381869
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r18 = "UDim2"
                                                    r53 = _env[r18]
                                                    r14 = upvalueValues[r31]
                                                    r40 = upvalueValues[r55]
                                                    r20 = "!\157-"
                                                    r39 = 23891437579125
                                                    r8 = r40(r20, r39)
                                                    r18 = r14[r8]
                                                    r37 = r53[r18]
                                                    r14 = 0
                                                    r40 = 0.55
                                                    r18 = 0.05
                                                    r8 = 0
                                                    r53 = r37(r18, r14, r40, r8)
                                                    r20 = "\200\221\190"
                                                    r48 = nil
                                                    r16[r34] = r53
                                                    r16 = upvalueValues[r27]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r40 = 12385776113287
                                                    r14 = "9#\155\004"
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r18 = "UDim2"
                                                    r53 = _env[r18]
                                                    r14 = upvalueValues[r31]
                                                    r40 = upvalueValues[r55]
                                                    r39 = 5067983948087
                                                    r8 = r40(r20, r39)
                                                    r18 = r14[r8]
                                                    r37 = r53[r18]
                                                    r40 = 0.1
                                                    r8 = 0
                                                    r14 = 0
                                                    r18 = 0.7
                                                    r53 = r37(r18, r14, r40, r8)
                                                    r16[r34] = r53
                                                    r16 = upvalueValues[r27]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r40 = 14291489544702
                                                    r14 = "\186\rHA"
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r14 = "Enum"
                                                    r18 = _env[r14]
                                                    r40 = upvalueValues[r31]
                                                    r8 = upvalueValues[r55]
                                                    r39 = "\144\026\241\160"
                                                    r20 = r8(r39, r62)
                                                    r14 = r40[r20]
                                                    r53 = r18[r14]
                                                    r14 = upvalueValues[r31]
                                                    r40 = upvalueValues[r55]
                                                    r39 = 16274020507034
                                                    r20 = "\173\137B\2297\141"
                                                    r8 = r40(r20, r39)
                                                    r18 = r14[r8]
                                                    r37 = r53[r18]
                                                    r16[r34] = r37
                                                    r16 = upvalueValues[r27]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r14 = "|\191\228\251"
                                                    r40 = 33011766262796
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r37 = upvalueValues[r46]
                                                    r16[r34] = r37
                                                    r16 = upvalueValues[r27]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r40 = 2625804715206
                                                    r14 = "q\243\205\133zC\243$\147#"
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r37 = r30
                                                    r16[r34] = r37
                                                    r16 = upvalueValues[r27]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r40 = 31029230925937
                                                    r14 = "~Yt\003\172by\r\140D"
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r37 = true
                                                    r16[r34] = r37
                                                    r16 = upvalueValues[r27]
                                                    r62 = 18485140627871
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r40 = 2302072046639
                                                    r14 = "\150\171\166\008j\134(\147O\234x\159\249\139"
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r14 = "Enum"
                                                    r39 = "7\192\213\187\204\158\201m\031Q]\140\186s"
                                                    r30 = nil
                                                    r18 = _env[r14]
                                                    r40 = upvalueValues[r31]
                                                    r8 = upvalueValues[r55]
                                                    r20 = r8(r39, r62)
                                                    r14 = r40[r20]
                                                    r53 = r18[r14]
                                                    r14 = upvalueValues[r31]
                                                    r40 = upvalueValues[r55]
                                                    r20 = "\192 \223\243"
                                                    r39 = 12046447613417
                                                    r8 = r40(r20, r39)
                                                    r18 = r14[r8]
                                                    r37 = r53[r18]
                                                    r16[r34] = r37
                                                    r16 = upvalueValues[r51]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r14 = "E>\192T"
                                                    r40 = 16212471537021
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r53 = upvalueValues[r31]
                                                    r18 = upvalueValues[r55]
                                                    r8 = 6258297850722
                                                    r40 = "\231\179\199n\183\211$(\143"
                                                    r14 = r18(r40, r8)
                                                    r37 = r53[r14]
                                                    r16[r34] = r37
                                                    r16 = upvalueValues[r51]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r40 = 25373505990183
                                                    r14 = "\014a\253c\003\166"
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r37 = upvalueValues[r2]
                                                    r16[r34] = r37
                                                    r16 = upvalueValues[r51]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r40 = 15160832088979
                                                    r14 = "d\156EK,\141\191G\167E\029g4\n\025\196"
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r18 = "Color3"
                                                    r53 = _env[r18]
                                                    r14 = upvalueValues[r31]
                                                    r40 = upvalueValues[r55]
                                                    r39 = 30803548600328
                                                    r20 = "\196@\249\130\227\220\r"
                                                    r8 = r40(r20, r39)
                                                    r18 = r14[r8]
                                                    r37 = r53[r18]
                                                    r40 = 0
                                                    r14 = 165
                                                    r18 = 255
                                                    r53 = r37(r18, r14, r40)
                                                    r16[r34] = r53
                                                    r16 = upvalueValues[r51]
                                                    r20 = "\227\165\154"
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r40 = 10293247759033
                                                    r14 = "#Q\199\247\184\190L\182B\234\001\142\184Z\226"
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r61 = nil
                                                    r37 = 0
                                                    r16[r34] = r37
                                                    r16 = upvalueValues[r51]
                                                    r14 = "\227\174O\232r\216\129'"
                                                    r40 = 25605569015443
                                                    r37 = upvalueValues[r31]
                                                    r63 = nil
                                                    r53 = upvalueValues[r55]
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r18 = "UDim2"
                                                    r53 = _env[r18]
                                                    r14 = upvalueValues[r31]
                                                    r40 = upvalueValues[r55]
                                                    r39 = 22786351163762
                                                    r8 = r40(r20, r39)
                                                    r18 = r14[r8]
                                                    r37 = r53[r18]
                                                    r8 = 0
                                                    r40 = 0.57
                                                    r18 = 0.85
                                                    r14 = 0
                                                    r53 = r37(r18, r14, r40, r8)
                                                    r16[r34] = r53
                                                    r16 = upvalueValues[r51]
                                                    r39 = 10816918786989
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r14 = "\024\"\189\t"
                                                    r40 = 25700644253375
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r18 = "UDim2"
                                                    r53 = _env[r18]
                                                    r50 = 2224837723148
                                                    r14 = upvalueValues[r31]
                                                    r20 = "W\244\224"
                                                    r17 = nil
                                                    r40 = upvalueValues[r55]
                                                    r8 = r40(r20, r39)
                                                    r18 = r14[r8]
                                                    r37 = r53[r18]
                                                    r14 = 8
                                                    r8 = 8
                                                    r18 = 0
                                                    r40 = 0
                                                    r53 = r37(r18, r14, r40, r8)
                                                    r16[r34] = r53
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r14 = 23549896338134
                                                    r18 = "h\"\015\229s\2348\012\222\n~\005"
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r53 = "UDim"
                                                    r37 = _env[r53]
                                                    r18 = upvalueValues[r31]
                                                    r14 = upvalueValues[r55]
                                                    r20 = 32199119977105
                                                    r8 = ">e\221"
                                                    r40 = r14(r8, r20)
                                                    r53 = r18[r40]
                                                    r34 = r37[r53]
                                                    r53 = 0
                                                    r18 = 4
                                                    r37 = r34(r53, r18)
                                                    r47[r16] = r37
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r14 = 13786958289172
                                                    r18 = "\017\006r\207\220c"
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r34 = upvalueValues[r51]
                                                    r47[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r14 = 861750673809
                                                    r18 = "\022\242\189\145\157"
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r53 = "Color3"
                                                    r37 = _env[r53]
                                                    r18 = upvalueValues[r31]
                                                    r14 = upvalueValues[r55]
                                                    r20 = 3028297729410
                                                    r8 = "[]\027\232\219\211J"
                                                    r40 = r14(r8, r20)
                                                    r53 = r18[r40]
                                                    r34 = r37[r53]
                                                    r53 = 255
                                                    r14 = 0
                                                    r18 = 165
                                                    r37 = r34(r53, r18, r14)
                                                    r29[r16] = r37
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r18 = "\240.3\015 2f\167\138"
                                                    r14 = 32726750313351
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r34 = 1
                                                    r29[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r14 = 30039345198756
                                                    r18 = "+\161g\152\185\217M\204\148{\129\201"
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r34 = 0.3
                                                    r29[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r18 = "\229\"\187\1407\025"
                                                    r14 = 2202424329217
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r34 = upvalueValues[r51]
                                                    r29[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r14 = 31450450590005
                                                    r18 = "se$\016"
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r40 = 18746410689049
                                                    r14 = "&n\195^8\233\240%\031G\159\181^"
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r57[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r18 = "#\003A\129\217M"
                                                    r14 = 14588200442505
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r34 = upvalueValues[r2]
                                                    r57[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r14 = 1334062432877
                                                    r18 = "\155\204\1492\012F\214\242\198h1\190Cd$\011"
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r53 = "Color3"
                                                    r37 = _env[r53]
                                                    r18 = upvalueValues[r31]
                                                    r14 = upvalueValues[r55]
                                                    r8 = "\235\143I\234\001O\245"
                                                    r20 = 33037900233752
                                                    r40 = r14(r8, r20)
                                                    r53 = r18[r40]
                                                    r34 = r37[r53]
                                                    r53 = 35
                                                    r18 = 45
                                                    r14 = 65
                                                    r37 = r34(r53, r18, r14)
                                                    r57[r16] = r37
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r18 = "\r\131\184}\143W\180\192\131\243\174\025\245\212\215"
                                                    r14 = 23914362628991
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r34 = 0
                                                    r57[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r14 = 17608082939911
                                                    r18 = ")+\017\214Z\221J\178"
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r53 = "UDim2"
                                                    r37 = _env[r53]
                                                    r18 = upvalueValues[r31]
                                                    r14 = upvalueValues[r55]
                                                    r20 = 30865294391332
                                                    r8 = "[s\244"
                                                    r40 = r14(r8, r20)
                                                    r53 = r18[r40]
                                                    r34 = r37[r53]
                                                    r53 = 0.05
                                                    r18 = 0
                                                    r40 = 0
                                                    r14 = 0.72
                                                    r37 = r34(r53, r18, r14, r40)
                                                    r57[r16] = r37
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r14 = 26540167344198
                                                    r18 = "\140\196%\027"
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r53 = "UDim2"
                                                    r37 = _env[r53]
                                                    r18 = upvalueValues[r31]
                                                    r14 = upvalueValues[r55]
                                                    r8 = "|\017\230"
                                                    r20 = 13452941760632
                                                    r40 = r14(r8, r20)
                                                    r53 = r18[r40]
                                                    r34 = r37[r53]
                                                    r53 = 0.9
                                                    r14 = 0.08
                                                    r40 = 0
                                                    r18 = 0
                                                    r37 = r34(r53, r18, r14, r40)
                                                    r57[r16] = r37
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r18 = "\164sg\160M\030\000\182\232HX\194"
                                                    r14 = 33167366454356
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r53 = "UDim"
                                                    r37 = _env[r53]
                                                    r18 = upvalueValues[r31]
                                                    r14 = upvalueValues[r55]
                                                    r8 = "\203\244@"
                                                    r20 = 9840935866854
                                                    r40 = r14(r8, r20)
                                                    r53 = r18[r40]
                                                    r34 = r37[r53]
                                                    r53 = 0
                                                    r18 = 8
                                                    r37 = r34(r53, r18)
                                                    r45[r16] = r37
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r14 = 25499389390434
                                                    r18 = ">_Z_\143\158"
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r34 = r57
                                                    r45[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r14 = 14195465886162
                                                    r18 = "\207\1598\001\130"
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r34 = upvalueValues[r52]
                                                    r54[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r14 = 16099233717576
                                                    r18 = ",pn\128\181A\175\249\239"
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r34 = 1
                                                    r54[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r18 = "p\250cL:r1\004\031\150vF"
                                                    r14 = 15688523275401
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r34 = 0.6
                                                    r54[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r18 = "\186\tMk``"
                                                    r14 = 29356297975142
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r34 = r57
                                                    r40 = 11718410212688
                                                    r20 = "X7\166"
                                                    r59 = 15162979015572
                                                    r12 = "\176/\192z\019\239\142y\017\159\250\140\192Fy"
                                                    r62 = 23258435185230
                                                    r8 = 25981771034434
                                                    r4 = nil
                                                    r54[r16] = r34
                                                    r16 = upvalueValues[r35]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r14 = "\160\175\210\225"
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r53 = upvalueValues[r31]
                                                    r18 = upvalueValues[r55]
                                                    r40 = "\158-\019\171\220\160Z\012\223r\030"
                                                    r14 = r18(r40, r8)
                                                    r37 = r53[r14]
                                                    r16[r34] = r37
                                                    r16 = upvalueValues[r35]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r40 = 19777494885369
                                                    r14 = "}\202\146\213\197K"
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r37 = r57
                                                    r16[r34] = r37
                                                    r16 = upvalueValues[r35]
                                                    r14 = "\021\237)gu\163\204\227\1981`\r\186\019\246`"
                                                    r40 = 34504761376451
                                                    r39 = 22870285609369
                                                    r57 = nil
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r37 = r25
                                                    r16[r34] = r37
                                                    r16 = upvalueValues[r35]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r40 = 16498043182594
                                                    r14 = "\223\237\192:\207\0147\167Jm\150\173!\247\177"
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r37 = 0
                                                    r16[r34] = r37
                                                    r16 = upvalueValues[r35]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r40 = 30594413672358
                                                    r14 = "\146\019\143\205\159\206b\212"
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r18 = "UDim2"
                                                    r53 = _env[r18]
                                                    r14 = upvalueValues[r31]
                                                    r40 = upvalueValues[r55]
                                                    r8 = r40(r20, r39)
                                                    r18 = r14[r8]
                                                    r37 = r53[r18]
                                                    r40 = 0
                                                    r14 = 0
                                                    r18 = 0
                                                    r8 = 0
                                                    r53 = r37(r18, r14, r40, r8)
                                                    r16[r34] = r53
                                                    r20 = "2\217\031"
                                                    r40 = 13512791054484
                                                    r54 = nil
                                                    r16 = upvalueValues[r35]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r14 = ".\213\238\218"
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r18 = "UDim2"
                                                    r53 = _env[r18]
                                                    r14 = upvalueValues[r31]
                                                    r40 = upvalueValues[r55]
                                                    r39 = 9196999872698
                                                    r8 = r40(r20, r39)
                                                    r18 = r14[r8]
                                                    r37 = r53[r18]
                                                    r39 = 30867870496805
                                                    r18 = 0
                                                    r25 = nil
                                                    r40 = 1
                                                    r8 = 0
                                                    r14 = 0
                                                    r53 = r37(r18, r14, r40, r8)
                                                    r16[r34] = r53
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r14 = 23732036283179
                                                    r18 = "\027\164\226?b\190\245\208v\029oy"
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r53 = "UDim"
                                                    r37 = _env[r53]
                                                    r18 = upvalueValues[r31]
                                                    r14 = upvalueValues[r55]
                                                    r8 = "/a\174"
                                                    r20 = 16541088783894
                                                    r40 = r14(r8, r20)
                                                    r53 = r18[r40]
                                                    r34 = r37[r53]
                                                    r53 = 0
                                                    r18 = 8
                                                    r37 = r34(r53, r18)
                                                    r3[r16] = r37
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r14 = 6739378080834
                                                    r18 = "\225\250*b\133\241"
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r34 = upvalueValues[r35]
                                                    r3[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r14 = 18587009393103
                                                    r18 = "\157T\163\246u"
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r34 = r23
                                                    r60[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r18 = "\131A\006\152\168-go\150"
                                                    r14 = 18743513113112
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r34 = 1
                                                    r60[r16] = r34
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r18 = "\198\200\031\160\167\237\196\185\018\031\227\248"
                                                    r14 = 3005456582007
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r34 = 0.3
                                                    r60[r16] = r34
                                                    r18 = "\026\247\229\228?u"
                                                    r40 = 33331713555617
                                                    r14 = 2149047976936
                                                    r49 = 2864963765558
                                                    r34 = upvalueValues[r31]
                                                    r37 = upvalueValues[r55]
                                                    r28 = nil
                                                    r53 = r37(r18, r14)
                                                    r16 = r34[r53]
                                                    r34 = upvalueValues[r35]
                                                    r60[r16] = r34
                                                    r16 = upvalueValues[r11]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r14 = "\169S\199a"
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r53 = upvalueValues[r31]
                                                    r18 = upvalueValues[r55]
                                                    r8 = 4339519014884
                                                    r40 = "\\\154\227\174\214\026m\196t\139"
                                                    r14 = r18(r40, r8)
                                                    r37 = r53[r14]
                                                    r16[r34] = r37
                                                    r16 = upvalueValues[r11]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r14 = "\210%>\202(g"
                                                    r40 = 2576105473
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r37 = upvalueValues[r2]
                                                    r16[r34] = r37
                                                    r16 = upvalueValues[r11]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r14 = "=\008\189?!\191/\023Y\r\140\132G\205\148\136\195\020x\193\226\192"
                                                    r40 = 22061704079393
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r37 = 1
                                                    r16[r34] = r37
                                                    r16 = upvalueValues[r11]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r40 = 21947601971180
                                                    r14 = ".\144\195\240\251\t\212\180"
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r18 = "UDim2"
                                                    r53 = _env[r18]
                                                    r14 = upvalueValues[r31]
                                                    r40 = upvalueValues[r55]
                                                    r20 = "\ruW"
                                                    r8 = r40(r20, r39)
                                                    r18 = r14[r8]
                                                    r37 = r53[r18]
                                                    r14 = 0
                                                    r40 = 0.85
                                                    r18 = 0.05
                                                    r8 = 0
                                                    r53 = r37(r18, r14, r40, r8)
                                                    r16[r34] = r53
                                                    r16 = upvalueValues[r11]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r40 = 13417499318376
                                                    r14 = "\242\160yD"
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r18 = "UDim2"
                                                    r53 = _env[r18]
                                                    r14 = upvalueValues[r31]
                                                    r40 = upvalueValues[r55]
                                                    r20 = "\214\138\245"
                                                    r39 = 216171626596
                                                    r8 = r40(r20, r39)
                                                    r18 = r14[r8]
                                                    r37 = r53[r18]
                                                    r18 = 0.9
                                                    r8 = 0
                                                    r40 = 0.08
                                                    r14 = 0
                                                    r53 = r37(r18, r14, r40, r8)
                                                    r16[r34] = r53
                                                    r16 = upvalueValues[r11]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r14 = "\196\166<\236"
                                                    r40 = 28850864845946
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r14 = "Enum"
                                                    r39 = "2H\031\187"
                                                    r3 = nil
                                                    r18 = _env[r14]
                                                    r40 = upvalueValues[r31]
                                                    r8 = upvalueValues[r55]
                                                    r20 = r8(r39, r62)
                                                    r14 = r40[r20]
                                                    r53 = r18[r14]
                                                    r14 = upvalueValues[r31]
                                                    r40 = upvalueValues[r55]
                                                    r39 = 25715561017030
                                                    r20 = "\190\1335a\198]\236\002\026\239\159\028"
                                                    r8 = r40(r20, r39)
                                                    r18 = r14[r8]
                                                    r37 = r53[r18]
                                                    r16[r34] = r37
                                                    r16 = upvalueValues[r11]
                                                    r8 = 4173296813975
                                                    r62 = "S\162#"
                                                    r40 = 7861958626893
                                                    r37 = upvalueValues[r31]
                                                    r47 = nil
                                                    r53 = upvalueValues[r55]
                                                    r14 = "\189\228\004\155"
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r53 = upvalueValues[r31]
                                                    r18 = upvalueValues[r55]
                                                    r40 = "\228\241"
                                                    r14 = r18(r40, r8)
                                                    r37 = r53[r14]
                                                    r16[r34] = r37
                                                    r16 = upvalueValues[r11]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r40 = 6219712203600
                                                    r14 = "\006\001\151\0195f}\1418."
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r37 = upvalueValues[r52]
                                                    r16[r34] = r37
                                                    r16 = upvalueValues[r11]
                                                    r37 = upvalueValues[r31]
                                                    r53 = upvalueValues[r55]
                                                    r14 = "\1520P\171!\133\129\151,:"
                                                    r40 = 2033884496819
                                                    r18 = r53(r14, r40)
                                                    r34 = r37[r18]
                                                    r37 = true
                                                    r53 = "spawn"
                                                    r18 = createClosure4(64, {
                                                        r41,
                                                        r1,
                                                        r31,
                                                        r55,
                                                        r22,
                                                        r9
                                                    })
                                                    r16[r34] = r37
                                                    r16 = allocUpvalue()
                                                    r34 = createClosure4(76, {
                                                        r41,
                                                        r36,
                                                        r1,
                                                        r31,
                                                        r55
                                                    })
                                                    upvalueValues[r16] = r34
                                                    r34 = createClosure2(81, {
                                                        r44,
                                                        r36,
                                                        r41,
                                                        r31,
                                                        r55,
                                                        r35,
                                                        r11,
                                                        r27,
                                                        r46,
                                                        r51,
                                                        r52,
                                                        r9,
                                                        r43,
                                                        r15,
                                                        r2,
                                                        r56,
                                                        r16
                                                    })
                                                    r37 = _env[r53]
                                                    r53 = r37(r18)
                                                    r37 = upvalueValues[r2]
                                                    r18 = upvalueValues[r31]
                                                    r14 = upvalueValues[r55]
                                                    r20 = 30295237736219
                                                    r8 = "\226\000\249\n.e\129\141"
                                                    r40 = r14(r8, r20)
                                                    r53 = r18[r40]
                                                    r40 = "UDim2"
                                                    r14 = _env[r40]
                                                    r8 = upvalueValues[r31]
                                                    r20 = upvalueValues[r55]
                                                    r39 = r20(r62, r38)
                                                    r40 = r8[r39]
                                                    r8 = -200
                                                    r18 = r14[r40]
                                                    r52 = releaseUpvalue(r52)
                                                    r20 = 1.5
                                                    r39 = 0
                                                    r40 = 0.5
                                                    r14 = r18(r40, r8, r20, r39)
                                                    r37[r53] = r14
                                                    r37 = upvalueValues[r56]
                                                    r18 = upvalueValues[r31]
                                                    r14 = upvalueValues[r55]
                                                    r20 = 10783331455901
                                                    r8 = "+\229\000V\007>\007\014"
                                                    r40 = r14(r8, r20)
                                                    r53 = r18[r40]
                                                    r40 = "UDim2"
                                                    r14 = _env[r40]
                                                    r8 = upvalueValues[r31]
                                                    r20 = upvalueValues[r55]
                                                    r62 = "Ti'"
                                                    r38 = 7295173119301
                                                    r39 = r20(r62, r38)
                                                    r40 = r8[r39]
                                                    r18 = r14[r40]
                                                    r8 = -205
                                                    r20 = 1.5
                                                    r40 = 0.5
                                                    r39 = 0
                                                    r14 = r18(r40, r8, r20, r39)
                                                    r37[r53] = r14
                                                    r37 = upvalueValues[r2]
                                                    r18 = upvalueValues[r2]
                                                    r40 = upvalueValues[r31]
                                                    r8 = upvalueValues[r55]
                                                    r62 = 29181374297364
                                                    r39 = "^\217?f:%U\022e\193\179\142\004"
                                                    r20 = r8(r39, r62)
                                                    r14 = r40[r20]
                                                    r53 = r18[r14]
                                                    r8 = "UDim2"
                                                    r38 = "\181\206\147"
                                                    r21 = 30347139807027
                                                    r29 = nil
                                                    r40 = _env[r8]
                                                    r20 = upvalueValues[r31]
                                                    r44 = releaseUpvalue(r44)
                                                    r39 = upvalueValues[r55]
                                                    r62 = r39(r38, r49)
                                                    r27 = releaseUpvalue(r27)
                                                    r8 = r20[r62]
                                                    r62 = -125
                                                    r14 = r40[r8]
                                                    r20 = -200
                                                    r39 = 0.5
                                                    r8 = 0.5
                                                    r40 = r14(r8, r20, r39, r62)
                                                    r39 = "Enum"
                                                    r20 = _env[r39]
                                                    r62 = upvalueValues[r31]
                                                    r38 = upvalueValues[r55]
                                                    r49 = r38(r12, r59)
                                                    r39 = r62[r49]
                                                    r8 = r20[r39]
                                                    r39 = upvalueValues[r31]
                                                    r62 = upvalueValues[r55]
                                                    r49 = "\179I\143"
                                                    r12 = 19567350162327
                                                    r38 = r62(r49, r12)
                                                    r20 = r39[r38]
                                                    r14 = r8[r20]
                                                    r62 = "Enum"
                                                    r39 = _env[r62]
                                                    r38 = upvalueValues[r31]
                                                    r49 = upvalueValues[r55]
                                                    r59 = "\169\005\178\166\222Z?\016\195\201\\"
                                                    r12 = r49(r59, r21)
                                                    r62 = r38[r12]
                                                    r20 = r39[r62]
                                                    r59 = 16697277652575
                                                    r12 = "\161\197\168~"
                                                    r62 = upvalueValues[r31]
                                                    r45 = nil
                                                    r38 = upvalueValues[r55]
                                                    r49 = r38(r12, r59)
                                                    r39 = r62[r49]
                                                    r8 = r20[r39]
                                                    r9 = releaseUpvalue(r9)
                                                    r46 = releaseUpvalue(r46)
                                                    r51 = releaseUpvalue(r51)
                                                    r39 = true
                                                    r20 = 0.8
                                                    r18 = r53(r37, r40, r14, r8, r20, r39)
                                                    r53 = upvalueValues[r56]
                                                    r49 = "\134>\017"
                                                    r38 = 33211761228905
                                                    r62 = "d$w\228\201\153\030<\133\174\003\141Z"
                                                    r24 = nil
                                                    r14 = upvalueValues[r56]
                                                    r8 = upvalueValues[r31]
                                                    r20 = upvalueValues[r55]
                                                    r39 = r20(r62, r38)
                                                    r40 = r8[r39]
                                                    r18 = r14[r40]
                                                    r20 = "UDim2"
                                                    r8 = _env[r20]
                                                    r39 = upvalueValues[r31]
                                                    r62 = upvalueValues[r55]
                                                    r12 = 13176132655095
                                                    r38 = r62(r49, r12)
                                                    r20 = r39[r38]
                                                    r40 = r8[r20]
                                                    r39 = -205
                                                    r38 = -130
                                                    r20 = 0.5
                                                    r62 = 0.5
                                                    r8 = r40(r20, r39, r62, r38)
                                                    r62 = "Enum"
                                                    r39 = _env[r62]
                                                    r38 = upvalueValues[r31]
                                                    r1 = releaseUpvalue(r1)
                                                    r49 = upvalueValues[r55]
                                                    r21 = 26093534916470
                                                    r59 = "\243\197\140\224\165JPz7\178(\214\250/b"
                                                    r12 = r49(r59, r21)
                                                    r62 = r38[r12]
                                                    r20 = r39[r62]
                                                    r21 = "\252\232\141zU\014.\030\\\251\134"
                                                    r12 = "=\217\249"
                                                    r62 = upvalueValues[r31]
                                                    r38 = upvalueValues[r55]
                                                    r60 = nil
                                                    r59 = 15845096987858
                                                    r49 = r38(r12, r59)
                                                    r36 = releaseUpvalue(r36)
                                                    r39 = r62[r49]
                                                    r56 = releaseUpvalue(r56)
                                                    r40 = r20[r39]
                                                    r38 = "Enum"
                                                    r62 = _env[r38]
                                                    r49 = upvalueValues[r31]
                                                    r12 = upvalueValues[r55]
                                                    r41 = releaseUpvalue(r41)
                                                    r15 = releaseUpvalue(r15)
                                                    r7 = nil
                                                    r59 = r12(r21, r50)
                                                    r38 = r49[r59]
                                                    r39 = r62[r38]
                                                    r11 = releaseUpvalue(r11)
                                                    r38 = upvalueValues[r31]
                                                    r49 = upvalueValues[r55]
                                                    r59 = "i\004?g"
                                                    r21 = 2339304588353
                                                    r12 = r49(r59, r21)
                                                    r62 = r38[r12]
                                                    r20 = r39[r62]
                                                    r39 = 0.8
                                                    r62 = true
                                                    r14 = r18(r53, r8, r40, r20, r39, r62)
                                                    r43 = releaseUpvalue(r43)
                                                    r14 = "wait"
                                                    r18 = _env[r14]
                                                    r40 = 0.8
                                                    r14 = r18(r40)
                                                    r62 = "\201:\232\164i~\129\222\231\251\019t\172\1698n\007J\138\203\002\014\008\223\231L\133dD_\134\242\129A8\024RR\217t6F(p\231\023.\026v\203\211&\148\226\161o\216\240\020G\0043pm\142\204\024\008TU\183}E\229\205\012"
                                                    r33 = nil
                                                    r2 = releaseUpvalue(r2)
                                                    r18 = r34()
                                                    r14 = "print"
                                                    r38 = 14370139789859
                                                    r53 = nil
                                                    r18 = _env[r14]
                                                    r8 = upvalueValues[r31]
                                                    r16 = releaseUpvalue(r16)
                                                    r23 = nil
                                                    r20 = upvalueValues[r55]
                                                    r37 = nil
                                                    r39 = r20(r62, r38)
                                                    r40 = r8[r39]
                                                    r34 = nil
                                                    r55 = releaseUpvalue(r55)
                                                    r31 = releaseUpvalue(r31)
                                                    r35 = releaseUpvalue(r35)
                                                    r22 = releaseUpvalue(r22)
                                                    r14 = r18(r40)
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure4 entry 10798855 -> 32, states 32-32
                                if state == 32 then -- entry 10798855 -> 32
                                    ReturnVal = "error"
                                    state = _env[ReturnVal]
                                    r32 = "Tamper Detected!"
                                    ReturnVal = state(r32)
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        else
                            if state <= 33 then
                                -- createClosure0 entry 10584052 -> 33, states 33-33
                                if state == 33 then -- entry 10584052 -> 33
                                    state = true
                                    upvalueValues[upvalues[1]] = state
                                    ReturnVal = {}
                                    state = nil
                                end
                            else
                                -- createClosure2 entry 7852265 -> 34, states 34-34
                                if state == 34 then -- entry 7852265 -> 34
                                    r52 = 3689564
                                    r31 = "GWjmFYmCwa53G"
                                    r32 = r31 ^ r52
                                    ReturnVal = 189044
                                    state = ReturnVal - r32
                                    r32 = state
                                    ReturnVal = "TlY"
                                    state = ReturnVal / r32
                                    ReturnVal = {
                                        state
                                    }
                                    state = nil
                                end
                            end
                        end
                    else
                        if state <= 50 then
                            if state <= 46 then
                                -- createClosure4 entry 1141916 -> 35, states 35-46
                                if state <= 40 then
                                    if state <= 37 then
                                        if state <= 36 then
                                            if state <= 35 then
                                                if state == 35 then -- entry 1141916 -> 35
                                                    r31 = upvalueValues[upvalues[1]]
                                                    r46 = 2
                                                    r55 = 1
                                                    r52 = r31(r55, r46)
                                                    r31 = 1
                                                    r32 = r52 == r31
                                                    state = r32 and (36) or (37)
                                                    ReturnVal = r32
                                                end
                                            else
                                                if state == 36 then
                                                    state = ReturnVal and (38) or (39)
                                                end
                                            end
                                        else
                                            if state == 37 then
                                                r31 = upvalueValues[upvalues[2]]
                                                r52 = upvalueValues[upvalues[3]]
                                                r32 = r31 == r52
                                                ReturnVal = r32
                                                state = 36
                                            end
                                        end
                                    else
                                        if state <= 39 then
                                            if state <= 38 then
                                                if state == 38 then
                                                    r61 = createClosure1(82, {})
                                                    ReturnVal = "tonumber"
                                                    state = _env[ReturnVal]
                                                    r32 = upvalueValues[upvalues[4]]
                                                    r55 = "tostring"
                                                    r52 = _env[r55]
                                                    r10 = "pcall"
                                                    r43 = _env[r10]
                                                    r10 = {
                                                        r43(r61)
                                                    }
                                                    r44 = {
                                                        unpack(r10)
                                                    }
                                                    r43 = 2
                                                    r46 = r44[r43]
                                                    r55 = r52(r46)
                                                    r52 = ":(%d*):"
                                                    r31 = r32(r55, r52)
                                                    r32 = {
                                                        r31()
                                                    }
                                                    ReturnVal = state(unpack(r32))
                                                    r32 = ReturnVal
                                                    r31 = upvalueValues[upvalues[5]]
                                                    state = r31 and (40) or (41)
                                                    ReturnVal = r31
                                                end
                                            else
                                                if state == 39 then
                                                    state = upvalueValues[upvalues[7]]
                                                    state = state and (42) or (43)
                                                end
                                            end
                                        else
                                            if state == 40 then
                                                r52 = upvalueValues[upvalues[6]]
                                                r31 = r52 == r32
                                                ReturnVal = r31
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
                                                    r32 = nil
                                                    state = 39
                                                end
                                            else
                                                if state == 42 then
                                                    r32 = "error"
                                                    state = _env[r32]
                                                    r31 = upvalueValues[upvalues[8]]
                                                    r52 = 0
                                                    r32 = state(r31, r52)
                                                    state = 43
                                                end
                                            end
                                        else
                                            if state == 43 then
                                                state = {}
                                                r32 = state
                                                r52 = upvalueValues[upvalues[9]]
                                                r55 = r52
                                                r52 = 1
                                                r46 = r52
                                                r52 = 0
                                                r44 = r46 < r52
                                                r31 = 1
                                                r52 = r31 - r46
                                                state = 44
                                            end
                                        end
                                    else
                                        if state <= 45 then
                                            if state <= 44 then
                                                if state == 44 then
                                                    r43 = not r44
                                                    r52 = r52 + r46
                                                    r31 = r52 <= r55
                                                    r31 = r43 and r31
                                                    r43 = r52 >= r55
                                                    r43 = r44 and r43
                                                    r31 = r43 or r31
                                                    r43 = (45)
                                                    state = r31 and r43
                                                    r31 = (46)
                                                    state = state or r31
                                                end
                                            else
                                                if state == 45 then
                                                    r31 = r52
                                                    state = upvalueValues[upvalues[1]]
                                                    r61 = 255
                                                    r10 = 0
                                                    r43 = state(r10, r61)
                                                    r32[r31] = r43
                                                    r31 = nil
                                                    state = 44
                                                end
                                            end
                                        else
                                            if state == 46 then
                                                state = upvalueValues[upvalues[10]]
                                                r31 = upvalueValues[upvalues[11]]
                                                r32[state] = r31
                                                state = upvalueValues[upvalues[12]]
                                                r31 = {
                                                    state(r32)
                                                }
                                                ReturnVal = {
                                                    unpack(r31)
                                                }
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure3 entry 9774730 -> 47, states 47-50
                                if state <= 48 then
                                    if state <= 47 then
                                        if state == 47 then -- entry 9774730 -> 47
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
                                            r32 = "l1"
                                            ReturnVal = _env[r32]
                                            r32 = "l1"
                                            _env[r32] = state
                                            r32 = "l2"
                                            _env[r32] = ReturnVal
                                            r32 = upvalueValues[upvalues[1]]
                                            r31 = r32()
                                            state = 48
                                        end
                                    else
                                        if state == 50 then
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                end
                            end
                        else
                            -- createClosure0 entry 8704962 -> 51, states 51-56
                            if state <= 53 then
                                if state <= 52 then
                                    if state <= 51 then
                                        if state == 51 then -- entry 8704962 -> 51
                                            r32 = upvalueValues[upvalues[1]]
                                            ReturnVal = #r32
                                            r32 = 0
                                            state = ReturnVal == r32
                                            state = state and (52) or (53)
                                        end
                                    else
                                        if state == 52 then
                                            r31 = upvalueValues[upvalues[2]]
                                            r52 = 9
                                            r32 = r31 * r52
                                            r31 = 2155249140715
                                            ReturnVal = r32 + r31
                                            r32 = 35184372088832
                                            state = ReturnVal % r32
                                            upvalueValues[upvalues[2]] = state
                                            r32 = upvalueValues[upvalues[3]]
                                            r31 = 1
                                            ReturnVal = r32 ~= r31
                                            state = 54
                                        end
                                    end
                                else
                                    if state == 53 then
                                        r52 = "table"
                                        r31 = _env[r52]
                                        r52 = "remove"
                                        r32 = r31[r52]
                                        r52 = upvalueValues[upvalues[1]]
                                        r31 = {
                                            r32(r52)
                                        }
                                        ReturnVal = {
                                            unpack(r31)
                                        }
                                        state = nil
                                    end
                                end
                            else
                                if state <= 55 then
                                    if state <= 54 then
                                        if state == 54 then
                                            r31 = upvalueValues[upvalues[3]]
                                            r52 = 254
                                            r32 = r31 * r52
                                            r31 = 257
                                            ReturnVal = r32 % r31
                                            upvalueValues[upvalues[3]] = ReturnVal
                                            state = 55
                                        end
                                    else
                                        if state == 55 then
                                            r31 = upvalueValues[upvalues[3]]
                                            r52 = 1
                                            r32 = r31 ~= r52
                                            state = r32 and (56) or (54)
                                        end
                                    end
                                else
                                    if state == 56 then
                                        r52 = 32
                                        r61 = 2
                                        r31 = upvalueValues[upvalues[3]]
                                        r32 = r31 % r52
                                        r55 = upvalueValues[upvalues[4]]
                                        r43 = upvalueValues[upvalues[2]]
                                        r1 = upvalueValues[upvalues[3]]
                                        r19 = r1 - r32
                                        r1 = 32
                                        r23 = r19 / r1
                                        r25 = 13
                                        r30 = r25 - r23
                                        r10 = r61 ^ r30
                                        r44 = r43 / r10
                                        r46 = r55(r44)
                                        r55 = 4294967296
                                        r52 = r46 % r55
                                        r46 = 2
                                        r55 = r46 ^ r32
                                        r31 = r52 / r55
                                        r10 = 1
                                        r32 = nil
                                        r55 = upvalueValues[upvalues[4]]
                                        r43 = r31 % r10
                                        r10 = 4294967296
                                        r44 = r43 * r10
                                        r46 = r55(r44)
                                        r61 = 256
                                        r55 = upvalueValues[upvalues[4]]
                                        r44 = r55(r31)
                                        r52 = r46 + r44
                                        r46 = 65536
                                        r43 = 65536
                                        r55 = r52 % r46
                                        r44 = r52 - r55
                                        r46 = r44 / r43
                                        r43 = 256
                                        r44 = r55 % r43
                                        r10 = r55 - r44
                                        r25 = 256
                                        r31 = nil
                                        r43 = r10 / r61
                                        r61 = 256
                                        r10 = r46 % r61
                                        r30 = r46 - r10
                                        r61 = r30 / r25
                                        r46 = nil
                                        r30 = {
                                            r44,
                                            r43,
                                            r10,
                                            r61
                                        }
                                        r61 = nil
                                        r55 = nil
                                        upvalueValues[upvalues[1]] = r30
                                        r10 = nil
                                        r43 = nil
                                        r52 = nil
                                        r44 = nil
                                        state = 53
                                    end
                                end
                            end
                        end
                    end
                else
                    if state <= 81 then
                        if state <= 75 then
                            if state <= 63 then
                                -- createClosure6 entry 11902950 -> 57, states 57-63
                                if state <= 60 then
                                    if state <= 58 then
                                        if state <= 57 then
                                            if state == 57 then -- entry 11902950 -> 57
                                                r31 = args[2]
                                                state = upvalueValues[upvalues[1]]
                                                r52 = state
                                                r32 = args[1]
                                                state = r52[r31]
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
                                                r55 = ReturnVal
                                                r46 = 35184372088832
                                                ReturnVal = r31 % r46
                                                upvalueValues[upvalues[4]] = ReturnVal
                                                r43 = 255
                                                r44 = r31 % r43
                                                r43 = 2
                                                r46 = r44 + r43
                                                upvalueValues[upvalues[5]] = r46
                                                r10 = "string"
                                                r43 = _env[r10]
                                                r10 = "len"
                                                r44 = r43[r10]
                                                r43 = r44(r32)
                                                r30 = 1
                                                r25 = r30
                                                r44 = ""
                                                r52[r31] = r44
                                                r30 = 0
                                                r23 = r25 < r30
                                                r10 = 1
                                                r30 = r10 - r25
                                                r61 = r43
                                                r44 = 111
                                                state = 61
                                            end
                                        else
                                            if state == 60 then
                                                ReturnVal = {
                                                    r31
                                                }
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    if state <= 62 then
                                        if state <= 61 then
                                            if state == 61 then
                                                r30 = r30 + r25
                                                r10 = r30 <= r61
                                                r19 = not r23
                                                r10 = r19 and r10
                                                r19 = r30 >= r61
                                                r19 = r23 and r19
                                                r10 = r19 or r10
                                                r19 = (62)
                                                state = r10 and r19
                                                r10 = (63)
                                                state = state or r10
                                            end
                                        else
                                            if state == 62 then
                                                r10 = r30
                                                r58 = "string"
                                                r42 = _env[r58]
                                                r58 = "byte"
                                                r26 = r42[r58]
                                                r42 = r26(r32, r10)
                                                r26 = upvalueValues[upvalues[6]]
                                                r58 = r26()
                                                r15 = r42 + r58
                                                r1 = r15 + r44
                                                r15 = 256
                                                r19 = r1 % r15
                                                r44 = r19
                                                r58 = 1
                                                r10 = nil
                                                r15 = r52[r31]
                                                r42 = r44 + r58
                                                r26 = r55[r42]
                                                r1 = r15 .. r26
                                                r52[r31] = r1
                                                state = 61
                                            end
                                        end
                                    else
                                        if state == 63 then
                                            r43 = nil
                                            r44 = nil
                                            r55 = nil
                                            state = 60
                                        end
                                    end
                                end
                            else
                                -- createClosure4 entry 16004029 -> 64, states 64-75
                                if state <= 69 then
                                    if state <= 66 then
                                        if state <= 65 then
                                            if state <= 64 then
                                                if state == 64 then -- entry 16004029 -> 64
                                                    state = 65
                                                end
                                            else
                                                if state == 65 then
                                                    r31 = upvalueValues[upvalues[1]]
                                                    r32 = not r31
                                                    state = r32 and (66) or (67)
                                                    ReturnVal = r32
                                                end
                                            end
                                        else
                                            if state == 66 then
                                                r31 = state
                                                r52 = upvalueValues[upvalues[2]]
                                                state = r52 and (68) or (69)
                                                r32 = r52
                                            end
                                        end
                                    else
                                        if state <= 68 then
                                            if state <= 67 then
                                                if state == 67 then
                                                    state = ReturnVal and (70) or (71)
                                                end
                                            else
                                                if state == 68 then
                                                    r55 = upvalueValues[upvalues[2]]
                                                    r44 = upvalueValues[upvalues[3]]
                                                    r43 = upvalueValues[upvalues[4]]
                                                    r30 = 4486045616168
                                                    r61 = "\141\241;\016\025Y"
                                                    r10 = r43(r61, r30)
                                                    r46 = r44[r10]
                                                    r52 = r55[r46]
                                                    r32 = r52
                                                    state = 69
                                                end
                                            end
                                        else
                                            if state == 69 then
                                                state = r31
                                                ReturnVal = r32
                                                state = 67
                                            end
                                        end
                                    end
                                else
                                    if state <= 72 then
                                        if state <= 71 then
                                            if state <= 70 then
                                                if state == 70 then
                                                    r55 = "math"
                                                    r52 = _env[r55]
                                                    r46 = upvalueValues[upvalues[3]]
                                                    r44 = upvalueValues[upvalues[4]]
                                                    r61 = 18113506353394
                                                    r10 = "\205\141w"
                                                    r43 = r44(r10, r61)
                                                    r55 = r46[r43]
                                                    r31 = r52[r55]
                                                    r44 = "tick"
                                                    r46 = _env[r44]
                                                    r44 = r46()
                                                    r46 = 2
                                                    r55 = r44 * r46
                                                    r52 = r31(r55)
                                                    r31 = 0.2
                                                    r32 = r52 * r31
                                                    ReturnVal = 0.3
                                                    state = ReturnVal + r32
                                                    r32 = state
                                                    state = upvalueValues[upvalues[5]]
                                                    state = state and (72) or (73)
                                                end
                                            else
                                                if state == 71 then
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state == 72 then
                                                state = upvalueValues[upvalues[5]]
                                                r31 = upvalueValues[upvalues[3]]
                                                r52 = upvalueValues[upvalues[4]]
                                                r46 = "\158\028\148>G-\186\017H\240\237\136"
                                                r44 = 26937381105919
                                                r55 = r52(r46, r44)
                                                ReturnVal = r31[r55]
                                                r31 = r32
                                                state[ReturnVal] = r31
                                                state = 73
                                            end
                                        end
                                    else
                                        if state <= 74 then
                                            if state <= 73 then
                                                if state == 73 then
                                                    state = upvalueValues[upvalues[6]]
                                                    state = state and (74) or (75)
                                                end
                                            else
                                                if state == 74 then
                                                    state = upvalueValues[upvalues[6]]
                                                    r31 = upvalueValues[upvalues[3]]
                                                    r52 = upvalueValues[upvalues[4]]
                                                    r46 = "\239\168*Q\149\240\217\172\001\209>I"
                                                    r44 = 5464929028592
                                                    r55 = r52(r46, r44)
                                                    ReturnVal = r31[r55]
                                                    r52 = 0.5
                                                    r31 = r32 * r52
                                                    state[ReturnVal] = r31
                                                    state = 75
                                                end
                                            end
                                        else
                                            if state == 75 then
                                                r32 = nil
                                                ReturnVal = "wait"
                                                state = _env[ReturnVal]
                                                r31 = 0.1
                                                ReturnVal = state(r31)
                                                state = 65
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            if state <= 80 then
                                -- createClosure4 entry 9719259 -> 76, states 76-80
                                if state <= 78 then
                                    if state <= 77 then
                                        if state <= 76 then
                                            if state == 76 then -- entry 9719259 -> 76
                                                state = true
                                                upvalueValues[upvalues[1]] = state
                                                r31 = state
                                                ReturnVal = false
                                                upvalueValues[upvalues[2]] = ReturnVal
                                                r52 = upvalueValues[upvalues[3]]
                                                state = r52 and (77) or (78)
                                                r32 = r52
                                            end
                                        else
                                            if state == 77 then
                                                r55 = upvalueValues[upvalues[3]]
                                                r44 = upvalueValues[upvalues[4]]
                                                r43 = upvalueValues[upvalues[5]]
                                                r61 = "\224\1947j\129a"
                                                r30 = 15891707026664
                                                r10 = r43(r61, r30)
                                                r46 = r44[r10]
                                                r52 = r55[r46]
                                                r32 = r52
                                                state = 78
                                            end
                                        end
                                    else
                                        if state == 78 then
                                            state = r31
                                            state = r32 and (79) or (80)
                                        end
                                    end
                                else
                                    if state <= 79 then
                                        if state == 79 then
                                            r32 = upvalueValues[upvalues[3]]
                                            r31 = "Destroy"
                                            r31 = r32[r31]
                                            r31 = r31(r32)
                                            r31 = "print"
                                            r32 = _env[r31]
                                            r55 = upvalueValues[upvalues[4]]
                                            r46 = upvalueValues[upvalues[5]]
                                            r10 = 32201483238034
                                            r43 = "\205\007\157\002F\031\199\016\024\174\207\1889\182\1282q\166I[&S \239\161\2096.yZ^\240P3A\030\173'\015\030=s\174\012R\0206c]\134\193\2063\229\190WqE4\2505\157\187W6\226<\132\158\015A\167H\008"
                                            r44 = r46(r43, r10)
                                            r52 = r55[r44]
                                            r31 = r32(r52)
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
                                -- createClosure2 entry 9431143 -> 81, states 81-81
                                if state == 81 then -- entry 9431143 -> 81
                                    r31 = allocUpvalue()
                                    ReturnVal = "tick"
                                    state = _env[ReturnVal]
                                    r32 = allocUpvalue()
                                    ReturnVal = state()
                                    upvalueValues[r32] = ReturnVal
                                    state = upvalueValues[upvalues[1]]
                                    upvalueValues[r31] = state
                                    r52 = createClosure5(83, {
                                        upvalues[2],
                                        upvalues[3],
                                        r32,
                                        r31,
                                        upvalues[4],
                                        upvalues[5],
                                        upvalues[6],
                                        upvalues[7],
                                        upvalues[8],
                                        upvalues[9],
                                        upvalues[10],
                                        upvalues[11],
                                        upvalues[12],
                                        upvalues[13],
                                        upvalues[14],
                                        upvalues[15],
                                        upvalues[16],
                                        upvalues[17]
                                    })
                                    r31 = releaseUpvalue(r31)
                                    ReturnVal = "spawn"
                                    state = _env[ReturnVal]
                                    r32 = releaseUpvalue(r32)
                                    ReturnVal = state(r52)
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        end
                    else
                        if state <= 101 then
                            if state <= 82 then
                                -- createClosure1 entry 10551950 -> 82, states 82-82
                                if state == 82 then -- entry 10551950 -> 82
                                    r31 = "00IZ"
                                    r52 = 7306933
                                    r32 = r31 ^ r52
                                    ReturnVal = 692016
                                    state = ReturnVal - r32
                                    r32 = state
                                    ReturnVal = "B1jNF6h5x3"
                                    state = ReturnVal / r32
                                    ReturnVal = {
                                        state
                                    }
                                    state = nil
                                end
                            else
                                -- createClosure5 entry 6254891 -> 83, states 83-101
                                if state <= 92 then
                                    if state <= 87 then
                                        if state <= 85 then
                                            if state <= 84 then
                                                if state <= 83 then
                                                    if state == 83 then -- entry 6254891 -> 83
                                                        state = 84
                                                    end
                                                else
                                                    if state == 84 then
                                                        r32 = upvalueValues[upvalues[1]]
                                                        state = r32 and (85) or (86)
                                                        ReturnVal = r32
                                                    end
                                                end
                                            else
                                                if state == 85 then
                                                    r31 = state
                                                    r55 = upvalueValues[upvalues[2]]
                                                    r52 = not r55
                                                    state = r52 and (87) or (88)
                                                    r32 = r52
                                                end
                                            end
                                        else
                                            if state <= 86 then
                                                if state == 86 then
                                                    state = ReturnVal and (89) or (90)
                                                end
                                            else
                                                if state == 87 then
                                                    r44 = "tick"
                                                    r46 = _env[r44]
                                                    r44 = r46()
                                                    r46 = upvalueValues[upvalues[3]]
                                                    r55 = r44 - r46
                                                    r46 = upvalueValues[upvalues[4]]
                                                    r52 = r55 < r46
                                                    r32 = r52
                                                    state = 88
                                                end
                                            end
                                        end
                                    else
                                        if state <= 90 then
                                            if state <= 89 then
                                                if state <= 88 then
                                                    if state == 88 then
                                                        state = r31
                                                        ReturnVal = r32
                                                        state = 86
                                                    end
                                                else
                                                    if state == 89 then
                                                        r31 = "tick"
                                                        r32 = _env[r31]
                                                        r31 = r32()
                                                        r32 = upvalueValues[upvalues[3]]
                                                        ReturnVal = r31 - r32
                                                        r32 = upvalueValues[upvalues[4]]
                                                        state = ReturnVal / r32
                                                        r32 = state
                                                        r31 = "math"
                                                        ReturnVal = _env[r31]
                                                        r52 = upvalueValues[upvalues[5]]
                                                        r55 = upvalueValues[upvalues[6]]
                                                        r43 = 21811379398572
                                                        r44 = "\180\014\207\155\250"
                                                        r46 = r55(r44, r43)
                                                        r31 = r52[r46]
                                                        state = ReturnVal[r31]
                                                        r52 = 100
                                                        r31 = r32 * r52
                                                        ReturnVal = state(r31)
                                                        r31 = ReturnVal
                                                        state = upvalueValues[upvalues[7]]
                                                        r52 = upvalueValues[upvalues[5]]
                                                        r55 = upvalueValues[upvalues[6]]
                                                        r44 = "G7\212\186"
                                                        r43 = 15212096314283
                                                        r46 = r55(r44, r43)
                                                        ReturnVal = r52[r46]
                                                        r46 = "UDim2"
                                                        r55 = _env[r46]
                                                        r44 = upvalueValues[upvalues[5]]
                                                        r43 = upvalueValues[upvalues[6]]
                                                        r61 = "C\213C"
                                                        r30 = 13515154331797
                                                        r10 = r43(r61, r30)
                                                        r46 = r44[r10]
                                                        r52 = r55[r46]
                                                        r43 = 0
                                                        r44 = 1
                                                        r46 = 0
                                                        r55 = r52(r32, r46, r44, r43)
                                                        state[ReturnVal] = r55
                                                        state = upvalueValues[upvalues[8]]
                                                        r52 = upvalueValues[upvalues[5]]
                                                        r55 = upvalueValues[upvalues[6]]
                                                        r44 = "\031\026\172\245"
                                                        r43 = 17221420965715
                                                        r46 = r55(r44, r43)
                                                        ReturnVal = r52[r46]
                                                        r46 = upvalueValues[upvalues[5]]
                                                        r44 = upvalueValues[upvalues[6]]
                                                        r61 = 2898009818437
                                                        r10 = "\128"
                                                        r43 = r44(r10, r61)
                                                        r55 = r46[r43]
                                                        r52 = r31 .. r55
                                                        state[ReturnVal] = r52
                                                        r55 = "math"
                                                        r52 = _env[r55]
                                                        r46 = upvalueValues[upvalues[5]]
                                                        r44 = upvalueValues[upvalues[6]]
                                                        r61 = 27027945386281
                                                        r10 = "\212\1574\rh"
                                                        r43 = r44(r10, r61)
                                                        r55 = r46[r43]
                                                        ReturnVal = r52[r55]
                                                        r43 = "tick"
                                                        r44 = _env[r43]
                                                        r43 = r44()
                                                        r44 = upvalueValues[upvalues[3]]
                                                        r46 = r43 - r44
                                                        r44 = 3
                                                        r55 = r46 * r44
                                                        r52 = ReturnVal(r55)
                                                        ReturnVal = 4
                                                        state = r52 % ReturnVal
                                                        r52 = state
                                                        state = upvalueValues[upvalues[9]]
                                                        r55 = upvalueValues[upvalues[5]]
                                                        r46 = upvalueValues[upvalues[6]]
                                                        r10 = 26418420838414
                                                        r43 = "cj\208\173"
                                                        r44 = r46(r43, r10)
                                                        ReturnVal = r55[r44]
                                                        r46 = upvalueValues[upvalues[10]]
                                                        r10 = "string"
                                                        r43 = _env[r10]
                                                        r61 = upvalueValues[upvalues[5]]
                                                        r30 = upvalueValues[upvalues[6]]
                                                        r23 = "\019\135<"
                                                        r19 = 26630046118000
                                                        r25 = r30(r23, r19)
                                                        r10 = r61[r25]
                                                        r44 = r43[r10]
                                                        r61 = upvalueValues[upvalues[5]]
                                                        r30 = upvalueValues[upvalues[6]]
                                                        r19 = 8384662081344
                                                        r23 = "k"
                                                        r25 = r30(r23, r19)
                                                        r10 = r61[r25]
                                                        r43 = r44(r10, r52)
                                                        r55 = r46 .. r43
                                                        state[ReturnVal] = r55
                                                        r43 = "math"
                                                        r44 = _env[r43]
                                                        r10 = upvalueValues[upvalues[5]]
                                                        r61 = upvalueValues[upvalues[6]]
                                                        r23 = 33157798935632
                                                        r25 = "n\208-"
                                                        r30 = r61(r25, r23)
                                                        r43 = r10[r30]
                                                        r46 = r44[r43]
                                                        r30 = "tick"
                                                        r61 = _env[r30]
                                                        r30 = r61()
                                                        r61 = upvalueValues[upvalues[3]]
                                                        r10 = r30 - r61
                                                        r61 = 10
                                                        r43 = r10 * r61
                                                        r44 = r46(r43)
                                                        r46 = 2
                                                        r55 = r44 * r46
                                                        ReturnVal = 8
                                                        state = ReturnVal + r55
                                                        r55 = state
                                                        state = upvalueValues[upvalues[11]]
                                                        r46 = upvalueValues[upvalues[5]]
                                                        r44 = upvalueValues[upvalues[6]]
                                                        r10 = "\201\210A\193"
                                                        r61 = 10032683405887
                                                        r43 = r44(r10, r61)
                                                        ReturnVal = r46[r43]
                                                        r43 = "UDim2"
                                                        r44 = _env[r43]
                                                        r10 = upvalueValues[upvalues[5]]
                                                        r61 = upvalueValues[upvalues[6]]
                                                        r23 = 27128175194456
                                                        r25 = "\191\245\243"
                                                        r30 = r61(r25, r23)
                                                        r43 = r10[r30]
                                                        r46 = r44[r43]
                                                        r10 = 0
                                                        r43 = 0
                                                        r44 = r46(r43, r55, r10, r55)
                                                        state[ReturnVal] = r44
                                                        ReturnVal = 0.3
                                                        state = r32 < ReturnVal
                                                        state = state and (91) or (92)
                                                    end
                                                end
                                            else
                                                if state == 90 then
                                                    r31 = upvalueValues[upvalues[2]]
                                                    r32 = not r31
                                                    state = r32 and (93) or (94)
                                                    ReturnVal = r32
                                                end
                                            end
                                        else
                                            if state <= 91 then
                                                if state == 91 then
                                                    state = upvalueValues[upvalues[11]]
                                                    r46 = upvalueValues[upvalues[5]]
                                                    r44 = upvalueValues[upvalues[6]]
                                                    r10 = "\176\193\179$\142\207\029\152 ~\172\1753M\234("
                                                    r61 = 978883412423
                                                    r43 = r44(r10, r61)
                                                    ReturnVal = r46[r43]
                                                    r43 = "Color3"
                                                    r44 = _env[r43]
                                                    r10 = upvalueValues[upvalues[5]]
                                                    r61 = upvalueValues[upvalues[6]]
                                                    r23 = 12181731382824
                                                    r25 = "B\130d6\139\236g"
                                                    r30 = r61(r25, r23)
                                                    r43 = r10[r30]
                                                    r46 = r44[r43]
                                                    r10 = 165
                                                    r61 = 0
                                                    r43 = 255
                                                    r44 = r46(r43, r10, r61)
                                                    state[ReturnVal] = r44
                                                    state = 95
                                                end
                                            else
                                                if state == 92 then
                                                    ReturnVal = 0.7
                                                    state = r32 < ReturnVal
                                                    state = state and (96) or (97)
                                                end
                                            end
                                        end
                                    end
                                else
                                    if state <= 97 then
                                        if state <= 95 then
                                            if state <= 94 then
                                                if state <= 93 then
                                                    if state == 93 then
                                                        r32 = upvalueValues[upvalues[1]]
                                                        ReturnVal = r32
                                                        state = 94
                                                    end
                                                else
                                                    if state == 94 then
                                                        state = ReturnVal and (98) or (99)
                                                    end
                                                end
                                            else
                                                if state == 95 then
                                                    ReturnVal = "wait"
                                                    r52 = nil
                                                    r32 = nil
                                                    r55 = nil
                                                    state = _env[ReturnVal]
                                                    r46 = 0.05
                                                    ReturnVal = state(r46)
                                                    r31 = nil
                                                    state = 84
                                                end
                                            end
                                        else
                                            if state <= 96 then
                                                if state == 96 then
                                                    state = upvalueValues[upvalues[11]]
                                                    r46 = upvalueValues[upvalues[5]]
                                                    r44 = upvalueValues[upvalues[6]]
                                                    r10 = "\201\137an\241\130\015\158\174?\191\133\184\138\197\135"
                                                    r61 = 25275516661241
                                                    r43 = r44(r10, r61)
                                                    ReturnVal = r46[r43]
                                                    r43 = "Color3"
                                                    r44 = _env[r43]
                                                    r10 = upvalueValues[upvalues[5]]
                                                    r61 = upvalueValues[upvalues[6]]
                                                    r23 = 5318402427308
                                                    r25 = "g\016\148\005\151K\212"
                                                    r30 = r61(r25, r23)
                                                    r43 = r10[r30]
                                                    r46 = r44[r43]
                                                    r61 = 0
                                                    r10 = 255
                                                    r43 = 255
                                                    r44 = r46(r43, r10, r61)
                                                    state[ReturnVal] = r44
                                                    state = 95
                                                end
                                            else
                                                if state == 97 then
                                                    state = upvalueValues[upvalues[11]]
                                                    r46 = upvalueValues[upvalues[5]]
                                                    r44 = upvalueValues[upvalues[6]]
                                                    r61 = 12184307488297
                                                    r10 = "\178\179\148Y\128!\200\167\217\222t\023)R \234"
                                                    r43 = r44(r10, r61)
                                                    ReturnVal = r46[r43]
                                                    r43 = "Color3"
                                                    r44 = _env[r43]
                                                    r10 = upvalueValues[upvalues[5]]
                                                    r61 = upvalueValues[upvalues[6]]
                                                    r25 = "f\159\004\"Je\168"
                                                    r23 = 12152848635419
                                                    r30 = r61(r25, r23)
                                                    r43 = r10[r30]
                                                    r46 = r44[r43]
                                                    r10 = 255
                                                    r43 = 0
                                                    r61 = 0
                                                    r44 = r46(r43, r10, r61)
                                                    state[ReturnVal] = r44
                                                    state = 95
                                                end
                                            end
                                        end
                                    else
                                        if state <= 99 then
                                            if state <= 98 then
                                                if state == 98 then
                                                    state = upvalueValues[upvalues[7]]
                                                    r32 = upvalueValues[upvalues[5]]
                                                    r31 = upvalueValues[upvalues[6]]
                                                    r55 = "\247\174\205J"
                                                    r46 = 27266004398488
                                                    r52 = r31(r55, r46)
                                                    ReturnVal = r32[r52]
                                                    r52 = "UDim2"
                                                    r31 = _env[r52]
                                                    r55 = upvalueValues[upvalues[5]]
                                                    r46 = upvalueValues[upvalues[6]]
                                                    r10 = 7867805879887
                                                    r43 = "\179\178I"
                                                    r44 = r46(r43, r10)
                                                    r52 = r55[r44]
                                                    r32 = r31[r52]
                                                    r46 = 1
                                                    r52 = 1
                                                    r44 = 0
                                                    r55 = 0
                                                    r31 = r32(r52, r55, r46, r44)
                                                    state[ReturnVal] = r31
                                                    state = upvalueValues[upvalues[8]]
                                                    r32 = upvalueValues[upvalues[5]]
                                                    r31 = upvalueValues[upvalues[6]]
                                                    r46 = 25570347970179
                                                    r55 = "0t\004\147"
                                                    r52 = r31(r55, r46)
                                                    ReturnVal = r32[r52]
                                                    r31 = upvalueValues[upvalues[5]]
                                                    r52 = upvalueValues[upvalues[6]]
                                                    r44 = 27482176041469
                                                    r46 = "eg\163\180"
                                                    r55 = r52(r46, r44)
                                                    r32 = r31[r55]
                                                    state[ReturnVal] = r32
                                                    state = upvalueValues[upvalues[9]]
                                                    r32 = upvalueValues[upvalues[5]]
                                                    r31 = upvalueValues[upvalues[6]]
                                                    r46 = 1534298637002
                                                    r55 = "L\230s`"
                                                    r52 = r31(r55, r46)
                                                    ReturnVal = r32[r52]
                                                    r31 = upvalueValues[upvalues[5]]
                                                    r52 = upvalueValues[upvalues[6]]
                                                    r44 = 13644411050193
                                                    r46 = "\166\242\169\142\228=\2471\018"
                                                    r55 = r52(r46, r44)
                                                    r32 = r31[r55]
                                                    state[ReturnVal] = r32
                                                    state = upvalueValues[upvalues[9]]
                                                    r32 = upvalueValues[upvalues[5]]
                                                    r31 = upvalueValues[upvalues[6]]
                                                    r55 = "\143\139\006\169u\025\152[\236\192"
                                                    r46 = 18013364953284
                                                    r52 = r31(r55, r46)
                                                    ReturnVal = r32[r52]
                                                    r32 = upvalueValues[upvalues[12]]
                                                    state[ReturnVal] = r32
                                                    state = upvalueValues[upvalues[11]]
                                                    r32 = upvalueValues[upvalues[5]]
                                                    r31 = upvalueValues[upvalues[6]]
                                                    r55 = "\229\030\127-=\194\238\182\215\219}\025j\182\168\188"
                                                    r46 = 9396257263895
                                                    r52 = r31(r55, r46)
                                                    ReturnVal = r32[r52]
                                                    r52 = "Color3"
                                                    r31 = _env[r52]
                                                    r55 = upvalueValues[upvalues[5]]
                                                    r46 = upvalueValues[upvalues[6]]
                                                    r43 = "\017\233\239\194\209T\184"
                                                    r10 = 17817707864169
                                                    r44 = r46(r43, r10)
                                                    r52 = r55[r44]
                                                    r32 = r31[r52]
                                                    r52 = 0
                                                    r55 = 255
                                                    r46 = 0
                                                    r31 = r32(r52, r55, r46)
                                                    state[ReturnVal] = r31
                                                    state = upvalueValues[upvalues[13]]
                                                    r32 = upvalueValues[upvalues[5]]
                                                    r31 = upvalueValues[upvalues[6]]
                                                    r46 = 24233077156884
                                                    r55 = "\142\163%\193="
                                                    r52 = r31(r55, r46)
                                                    ReturnVal = r32[r52]
                                                    r52 = "Color3"
                                                    r31 = _env[r52]
                                                    r55 = upvalueValues[upvalues[5]]
                                                    r46 = upvalueValues[upvalues[6]]
                                                    r10 = 11430141777098
                                                    r43 = "\210E\005\211\252_\164"
                                                    r44 = r46(r43, r10)
                                                    r52 = r55[r44]
                                                    r32 = r31[r52]
                                                    r46 = 0
                                                    r55 = 255
                                                    r52 = 0
                                                    r31 = r32(r52, r55, r46)
                                                    state[ReturnVal] = r31
                                                    ReturnVal = "wait"
                                                    state = _env[ReturnVal]
                                                    r32 = upvalueValues[upvalues[14]]
                                                    ReturnVal = state(r32)
                                                    ReturnVal = "pcall"
                                                    state = _env[ReturnVal]
                                                    r31 = createClosure4(102, {
                                                        upvalues[15]
                                                    })
                                                    r52 = {
                                                        state(r31)
                                                    }
                                                    ReturnVal = r52[1]
                                                    r31 = ReturnVal
                                                    state = not r31
                                                    state = state and (100) or (101)
                                                    r32 = r52[2]
                                                end
                                            else
                                                if state == 99 then
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state <= 100 then
                                                if state == 100 then
                                                    ReturnVal = "warn"
                                                    state = _env[ReturnVal]
                                                    r46 = upvalueValues[upvalues[5]]
                                                    r44 = upvalueValues[upvalues[6]]
                                                    r61 = 33709414907217
                                                    r10 = "\135\021o\162\145Lx\"8\233\194\227\rJ\145\250\tr{\020\173C\161\005\158F@I"
                                                    r43 = r44(r10, r61)
                                                    r55 = r46[r43]
                                                    r44 = "tostring"
                                                    r46 = _env[r44]
                                                    r44 = r46(r32)
                                                    r52 = r55 .. r44
                                                    ReturnVal = state(r52)
                                                    state = 101
                                                end
                                            else
                                                if state == 101 then
                                                    state = upvalueValues[upvalues[16]]
                                                    r46 = "UDim2"
                                                    r55 = _env[r46]
                                                    r44 = upvalueValues[upvalues[5]]
                                                    r43 = upvalueValues[upvalues[6]]
                                                    r30 = 21250188306087
                                                    r61 = "\128[\210"
                                                    r10 = r43(r61, r30)
                                                    r46 = r44[r10]
                                                    r52 = r55[r46]
                                                    r43 = -1
                                                    r44 = -200
                                                    r10 = 0
                                                    r46 = 0.5
                                                    r55 = r52(r46, r44, r43, r10)
                                                    r43 = "Enum"
                                                    r44 = _env[r43]
                                                    r10 = upvalueValues[upvalues[5]]
                                                    r61 = upvalueValues[upvalues[6]]
                                                    r23 = 33241521175671
                                                    r25 = "\136\232A\239~e\244\249\215\179\\\170q.\002"
                                                    r30 = r61(r25, r23)
                                                    ReturnVal = "TweenPosition"
                                                    ReturnVal = state[ReturnVal]
                                                    r43 = r10[r30]
                                                    r46 = r44[r43]
                                                    r43 = upvalueValues[upvalues[5]]
                                                    r10 = upvalueValues[upvalues[6]]
                                                    r25 = 13737139116284
                                                    r30 = "\201\\"
                                                    r61 = r10(r30, r25)
                                                    r44 = r43[r61]
                                                    r52 = r46[r44]
                                                    r10 = "Enum"
                                                    r43 = _env[r10]
                                                    r61 = upvalueValues[upvalues[5]]
                                                    r30 = upvalueValues[upvalues[6]]
                                                    r19 = 34765342637884
                                                    r23 = "\024\221B\255\020\130H4x\197\208"
                                                    r25 = r30(r23, r19)
                                                    r10 = r61[r25]
                                                    r44 = r43[r10]
                                                    r10 = upvalueValues[upvalues[5]]
                                                    r61 = upvalueValues[upvalues[6]]
                                                    r25 = "\227\197\026\197"
                                                    r23 = 15278570036170
                                                    r30 = r61(r25, r23)
                                                    r43 = r10[r30]
                                                    r46 = r44[r43]
                                                    r43 = true
                                                    r44 = 0.5
                                                    ReturnVal = ReturnVal(state, r55, r52, r46, r44, r43)
                                                    r19 = 8080822947506
                                                    state = upvalueValues[upvalues[17]]
                                                    ReturnVal = "TweenPosition"
                                                    r46 = "UDim2"
                                                    r55 = _env[r46]
                                                    r44 = upvalueValues[upvalues[5]]
                                                    r43 = upvalueValues[upvalues[6]]
                                                    r61 = "\163\210~"
                                                    r30 = 16635148934722
                                                    r10 = r43(r61, r30)
                                                    r46 = r44[r10]
                                                    r23 = 26608915918950
                                                    r43 = -1
                                                    r31 = nil
                                                    r52 = r55[r46]
                                                    r44 = -205
                                                    r10 = 0
                                                    r46 = 0.5
                                                    r55 = r52(r46, r44, r43, r10)
                                                    r43 = "Enum"
                                                    r44 = _env[r43]
                                                    r10 = upvalueValues[upvalues[5]]
                                                    r61 = upvalueValues[upvalues[6]]
                                                    r25 = "\170+\t\138\243~\002\003\181\240\250\168\246\200\002"
                                                    r30 = r61(r25, r23)
                                                    r43 = r10[r30]
                                                    r46 = r44[r43]
                                                    r43 = upvalueValues[upvalues[5]]
                                                    r10 = upvalueValues[upvalues[6]]
                                                    r25 = 6512618785752
                                                    r30 = "\180g"
                                                    r61 = r10(r30, r25)
                                                    r44 = r43[r61]
                                                    r52 = r46[r44]
                                                    r10 = "Enum"
                                                    r43 = _env[r10]
                                                    r61 = upvalueValues[upvalues[5]]
                                                    r30 = upvalueValues[upvalues[6]]
                                                    r23 = "\255LX\214\185#%\173\236DJ"
                                                    r25 = r30(r23, r19)
                                                    r10 = r61[r25]
                                                    r25 = "\211\168b\213"
                                                    r32 = nil
                                                    r44 = r43[r10]
                                                    r10 = upvalueValues[upvalues[5]]
                                                    r61 = upvalueValues[upvalues[6]]
                                                    ReturnVal = state[ReturnVal]
                                                    r23 = 34993578000295
                                                    r30 = r61(r25, r23)
                                                    r43 = r10[r30]
                                                    r46 = r44[r43]
                                                    r44 = 0.5
                                                    r43 = true
                                                    ReturnVal = ReturnVal(state, r55, r52, r46, r44, r43)
                                                    ReturnVal = "wait"
                                                    state = _env[ReturnVal]
                                                    r52 = 0.6
                                                    ReturnVal = state(r52)
                                                    state = upvalueValues[upvalues[18]]
                                                    ReturnVal = state()
                                                    state = 99
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            -- createClosure4 entry 14410175 -> 102, states 102-102
                            if state == 102 then -- entry 14410175 -> 102
                                ReturnVal = "loadstring"
                                state = _env[ReturnVal]
                                r32 = upvalueValues[upvalues[1]]
                                ReturnVal = state(r32)
                                state = ReturnVal()
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
        currentUpvalueId = 0
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
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)