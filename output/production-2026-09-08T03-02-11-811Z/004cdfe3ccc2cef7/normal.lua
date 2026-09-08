return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, createClosure5, createClosure6, releaseUpvalues, createClosure, createClosure4, vm, createClosure7, allocUpvalue, createClosure1, upvalueValues, createClosure2, createClosure10, currentUpvalueId, releaseUpvalue, createClosure3, upvalueRefCounts, createUpvalueProxy, createClosure0)
        upvalueValues = {}
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
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = upvalueRefCounts[captures[captureIndex]] + (1)
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return 3940027
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 3940027
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
        createClosure10 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
                return vm(entryId, {
                    arg1,
                    arg2,
                    arg3,
                    arg4,
                    arg5,
                    arg6,
                    arg7,
                    arg8,
                    arg9,
                    arg10
                }, captures, gcProxy)
            end
            return closure
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
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if upvalueRefCounts[upvalueId] == 0 then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
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
        vm = function(state, args, upvalues, gcProxy)
            
            local r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, ReturnVal, r81, r82, r83, r84, r85, r86, r87, r88, r89, r90, r91, r92, r93, r94, r95, r96, r97, r98, r99
            while state do
                if state <= 276 then
                    if state <= 136 then
                        if state <= 79 then
                            if state <= 59 then
                                if state <= 42 then
                                    if state <= 41 then
                                        if state <= 40 then
                                            -- root entry 7741796 -> 1, states 1-40
                                            if state <= 20 then
                                                if state <= 10 then
                                                    if state <= 5 then
                                                        if state <= 3 then
                                                            if state <= 2 then
                                                                if state <= 1 then
                                                                    if state == 1 then -- entry 7741796 -> 1
                                                                        r61 = allocUpvalue()
                                                                        r12 = allocUpvalue()
                                                                        state = true
                                                                        upvalueValues[r61] = state
                                                                        r34 = "string"
                                                                        ReturnVal = _env[r34]
                                                                        r34 = "gmatch"
                                                                        state = ReturnVal[r34]
                                                                        r65 = allocUpvalue()
                                                                        r34 = allocUpvalue()
                                                                        upvalueValues[r34] = state
                                                                        state = createClosure0(41, {})
                                                                        upvalueValues[r12] = state
                                                                        state = false
                                                                        upvalueValues[r65] = state
                                                                        r56 = createClosure0(42, {
                                                                            r65
                                                                        })
                                                                        r16 = "pcall"
                                                                        r92 = _env[r16]
                                                                        r16 = r92(r56)
                                                                        state = r16 and (2) or (3)
                                                                        r37 = args
                                                                        ReturnVal = r16
                                                                    end
                                                                else
                                                                    if state == 2 then
                                                                        r92 = upvalueValues[r65]
                                                                        ReturnVal = r92
                                                                        state = 3
                                                                    end
                                                                end
                                                            else
                                                                if state == 3 then
                                                                    r92 = ReturnVal
                                                                    r16 = "math"
                                                                    ReturnVal = _env[r16]
                                                                    r16 = "random"
                                                                    state = ReturnVal[r16]
                                                                    r16 = allocUpvalue()
                                                                    upvalueValues[r16] = state
                                                                    r56 = "table"
                                                                    ReturnVal = _env[r56]
                                                                    r56 = "concat"
                                                                    state = ReturnVal[r56]
                                                                    r56 = state
                                                                    r74 = state
                                                                    r41 = "table"
                                                                    r27 = _env[r41]
                                                                    state = r27 and (4) or (5)
                                                                    r62 = r27
                                                                end
                                                            end
                                                        else
                                                            if state <= 4 then
                                                                if state == 4 then
                                                                    r66 = "table"
                                                                    r41 = _env[r66]
                                                                    r66 = "unpack"
                                                                    r27 = r41[r66]
                                                                    r62 = r27
                                                                    state = 5
                                                                end
                                                            else
                                                                if state == 5 then
                                                                    state = r74
                                                                    state = r62 and (6) or (7)
                                                                    ReturnVal = r62
                                                                end
                                                            end
                                                        end
                                                    else
                                                        if state <= 8 then
                                                            if state <= 7 then
                                                                if state <= 6 then
                                                                    if state == 6 then
                                                                        r62 = allocUpvalue()
                                                                        upvalueValues[r62] = ReturnVal
                                                                        r68 = createClosure2(43, {})
                                                                        state = upvalueValues[r16]
                                                                        r27 = 65
                                                                        r74 = 3
                                                                        ReturnVal = state(r74, r27)
                                                                        r74 = allocUpvalue()
                                                                        upvalueValues[r74] = ReturnVal
                                                                        state = 0
                                                                        r27 = state
                                                                        state = 0
                                                                        r66 = "pcall"
                                                                        ReturnVal = _env[r66]
                                                                        r66 = {
                                                                            ReturnVal(r68)
                                                                        }
                                                                        r41 = state
                                                                        state = {
                                                                            unpack(r66)
                                                                        }
                                                                        r66 = state
                                                                        ReturnVal = 2
                                                                        state = r66[ReturnVal]
                                                                        r68 = state
                                                                        ReturnVal = "tonumber"
                                                                        state = _env[ReturnVal]
                                                                        r4 = upvalueValues[r34]
                                                                        r90 = "tostring"
                                                                        r39 = _env[r90]
                                                                        r90 = r39(r68)
                                                                        r39 = ":(%d*):"
                                                                        r6 = r4(r90, r39)
                                                                        r4 = {
                                                                            r6()
                                                                        }
                                                                        ReturnVal = state(unpack(r4))
                                                                        r4 = allocUpvalue()
                                                                        upvalueValues[r4] = ReturnVal
                                                                        r6 = upvalueValues[r74]
                                                                        r39 = r6
                                                                        r6 = 1
                                                                        r90 = r6
                                                                        r6 = 0
                                                                        r13 = r90 < r6
                                                                        ReturnVal = 1
                                                                        r6 = ReturnVal - r90
                                                                        state = 8
                                                                    end
                                                                else
                                                                    if state == 7 then
                                                                        r74 = "unpack"
                                                                        r62 = _env[r74]
                                                                        ReturnVal = r62
                                                                        state = 6
                                                                    end
                                                                end
                                                            else
                                                                if state == 8 then
                                                                    r54 = not r13
                                                                    r6 = r6 + r90
                                                                    ReturnVal = r6 <= r39
                                                                    ReturnVal = r54 and ReturnVal
                                                                    r54 = r6 >= r39
                                                                    r54 = r13 and r54
                                                                    ReturnVal = r54 or ReturnVal
                                                                    r54 = (9)
                                                                    state = ReturnVal and r54
                                                                    ReturnVal = (10)
                                                                    state = state or ReturnVal
                                                                end
                                                            end
                                                        else
                                                            if state <= 9 then
                                                                if state == 9 then
                                                                    r54 = allocUpvalue()
                                                                    upvalueValues[r54] = r6
                                                                    r14 = "math"
                                                                    ReturnVal = _env[r14]
                                                                    r14 = "random"
                                                                    state = ReturnVal[r14]
                                                                    r67 = 100
                                                                    r14 = 1
                                                                    ReturnVal = state(r14, r67)
                                                                    r14 = allocUpvalue()
                                                                    upvalueValues[r14] = ReturnVal
                                                                    state = upvalueValues[r16]
                                                                    r84 = 255
                                                                    r67 = 0
                                                                    ReturnVal = state(r67, r84)
                                                                    r67 = allocUpvalue()
                                                                    upvalueValues[r67] = ReturnVal
                                                                    state = upvalueValues[r16]
                                                                    r91 = upvalueValues[r14]
                                                                    r84 = 1
                                                                    ReturnVal = state(r84, r91)
                                                                    r84 = allocUpvalue()
                                                                    upvalueValues[r84] = ReturnVal
                                                                    ReturnVal = upvalueValues[r16]
                                                                    r15 = 1
                                                                    r24 = 2
                                                                    r91 = ReturnVal(r15, r24)
                                                                    ReturnVal = 1
                                                                    state = r91 == ReturnVal
                                                                    r91 = allocUpvalue()
                                                                    upvalueValues[r91] = state
                                                                    r32 = "tostring"
                                                                    r38 = _env[r32]
                                                                    r73 = upvalueValues[r16]
                                                                    r19 = 0
                                                                    r70 = 10000
                                                                    r1 = {
                                                                        r73(r19, r70)
                                                                    }
                                                                    r32 = r38(unpack(r1))
                                                                    state = "gsub"
                                                                    state = r68[state]
                                                                    r38 = ":"
                                                                    r36 = r32 .. r38
                                                                    r24 = ":"
                                                                    r15 = r24 .. r36
                                                                    ReturnVal = ":(%d*):"
                                                                    state = state(r68, ReturnVal, r15)
                                                                    r15 = allocUpvalue()
                                                                    r36 = createClosure2(44, {
                                                                        r16,
                                                                        r54,
                                                                        r74,
                                                                        r34,
                                                                        r61,
                                                                        r4,
                                                                        r91,
                                                                        r15,
                                                                        r14,
                                                                        r84,
                                                                        r67,
                                                                        r62
                                                                    })
                                                                    upvalueValues[r15] = state
                                                                    r24 = "pcall"
                                                                    ReturnVal = _env[r24]
                                                                    r24 = {
                                                                        ReturnVal(r36)
                                                                    }
                                                                    state = {
                                                                        unpack(r24)
                                                                    }
                                                                    r24 = state
                                                                    state = upvalueValues[r91]
                                                                    state = state and (11) or (12)
                                                                end
                                                            else
                                                                if state == 10 then
                                                                    r39 = upvalueValues[r61]
                                                                    state = r39 and (13) or (14)
                                                                    r6 = r39
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
                                                                        r36 = upvalueValues[r61]
                                                                        state = r36 and (15) or (16)
                                                                        ReturnVal = r36
                                                                    end
                                                                else
                                                                    if state == 12 then
                                                                        r38 = upvalueValues[r61]
                                                                        state = r38 and (17) or (18)
                                                                        r36 = r38
                                                                    end
                                                                end
                                                            else
                                                                if state == 13 then
                                                                    r39 = r27 == r41
                                                                    r6 = r39
                                                                    state = 14
                                                                end
                                                            end
                                                        else
                                                            if state <= 14 then
                                                                if state == 14 then
                                                                    upvalueValues[r61] = r6
                                                                    state = upvalueValues[r61]
                                                                    state = state and (19) or (20)
                                                                end
                                                            else
                                                                if state == 15 then
                                                                    r38 = state
                                                                    r1 = 1
                                                                    r73 = r24[r1]
                                                                    r1 = false
                                                                    r32 = r73 == r1
                                                                    state = r32 and (21) or (22)
                                                                    r36 = r32
                                                                end
                                                            end
                                                        end
                                                    else
                                                        if state <= 18 then
                                                            if state <= 17 then
                                                                if state <= 16 then
                                                                    if state == 16 then
                                                                        upvalueValues[r61] = ReturnVal
                                                                        state = 23
                                                                    end
                                                                else
                                                                    if state == 17 then
                                                                        r32 = 1
                                                                        r38 = r24[r32]
                                                                        r36 = r38
                                                                        state = 18
                                                                    end
                                                                end
                                                            else
                                                                if state == 18 then
                                                                    upvalueValues[r61] = r36
                                                                    r1 = upvalueValues[r84]
                                                                    r19 = 1
                                                                    r73 = r1 + r19
                                                                    r32 = r24[r73]
                                                                    r38 = r27 + r32
                                                                    r32 = 256
                                                                    state = r38 % r32
                                                                    r27 = state
                                                                    r73 = upvalueValues[r67]
                                                                    r32 = r41 + r73
                                                                    r73 = 256
                                                                    r38 = r32 % r73
                                                                    r41 = r38
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
                                                    end
                                                end
                                            else
                                                if state <= 30 then
                                                    if state <= 25 then
                                                        if state <= 23 then
                                                            if state <= 22 then
                                                                if state <= 21 then
                                                                    if state == 21 then
                                                                        r1 = 2
                                                                        r73 = r24[r1]
                                                                        r1 = upvalueValues[r15]
                                                                        r32 = r73 == r1
                                                                        r36 = r32
                                                                        state = 22
                                                                    end
                                                                else
                                                                    if state == 22 then
                                                                        state = r38
                                                                        ReturnVal = r36
                                                                        state = 16
                                                                    end
                                                                end
                                                            else
                                                                if state == 23 then
                                                                    r15 = releaseUpvalue(r15)
                                                                    r54 = releaseUpvalue(r54)
                                                                    r84 = releaseUpvalue(r84)
                                                                    r91 = releaseUpvalue(r91)
                                                                    r24 = nil
                                                                    r67 = releaseUpvalue(r67)
                                                                    r14 = releaseUpvalue(r14)
                                                                    state = 8
                                                                end
                                                            end
                                                        else
                                                            if state <= 24 then
                                                                if state == 24 then
                                                                    r4 = releaseUpvalue(r4)
                                                                    r61 = releaseUpvalue(r61)
                                                                    r16 = releaseUpvalue(r16)
                                                                    r65 = releaseUpvalue(r65)
                                                                    r74 = releaseUpvalue(r74)
                                                                    r34 = releaseUpvalue(r34)
                                                                    r41 = nil
                                                                    r41 = allocUpvalue()
                                                                    r12 = releaseUpvalue(r12)
                                                                    r62 = releaseUpvalue(r62)
                                                                    r12 = allocUpvalue()
                                                                    r61 = nil
                                                                    upvalueValues[r12] = r61
                                                                    r61 = allocUpvalue()
                                                                    r34 = nil
                                                                    upvalueValues[r61] = r34
                                                                    r92 = nil
                                                                    r92 = "math"
                                                                    r65 = _env[r92]
                                                                    r92 = "floor"
                                                                    r34 = r65[r92]
                                                                    r65 = allocUpvalue()
                                                                    upvalueValues[r65] = r34
                                                                    r16 = "math"
                                                                    r92 = _env[r16]
                                                                    r16 = "random"
                                                                    r34 = r92[r16]
                                                                    r56 = nil
                                                                    r56 = "table"
                                                                    r16 = _env[r56]
                                                                    r56 = "remove"
                                                                    r92 = r16[r56]
                                                                    r62 = "string"
                                                                    r56 = _env[r62]
                                                                    r66 = nil
                                                                    r66 = {}
                                                                    r62 = "char"
                                                                    r16 = r56[r62]
                                                                    r62 = allocUpvalue()
                                                                    r74 = allocUpvalue()
                                                                    r4 = 256
                                                                    r27 = nil
                                                                    r27 = {}
                                                                    r56 = 0
                                                                    upvalueValues[r62] = r56
                                                                    r56 = 2
                                                                    upvalueValues[r74] = r56
                                                                    r56 = {}
                                                                    upvalueValues[r41] = r27
                                                                    r13 = r4
                                                                    r4 = 1
                                                                    r54 = r4
                                                                    r4 = 0
                                                                    r14 = r54 < r4
                                                                    r68 = nil
                                                                    r68 = 1
                                                                    r4 = r68 - r54
                                                                    r27 = 0
                                                                    state = 26
                                                                end
                                                            else
                                                                if state == 25 then
                                                                    state = createClosure5(56, {
                                                                        r12
                                                                    })
                                                                    r39 = {
                                                                        state()
                                                                    }
                                                                    ReturnVal = {
                                                                        unpack(r39)
                                                                    }
                                                                    state = nil
                                                                end
                                                            end
                                                        end
                                                    else
                                                        if state <= 28 then
                                                            if state <= 27 then
                                                                if state <= 26 then
                                                                    if state == 26 then
                                                                        r67 = not r14
                                                                        r4 = r4 + r54
                                                                        r68 = r4 <= r13
                                                                        r68 = r67 and r68
                                                                        r67 = r4 >= r13
                                                                        r67 = r14 and r67
                                                                        r68 = r67 or r68
                                                                        r67 = (27)
                                                                        state = r68 and r67
                                                                        r68 = (28)
                                                                        state = state or r68
                                                                    end
                                                                else
                                                                    if state == 27 then
                                                                        r68 = r4
                                                                        r67 = r68
                                                                        r66[r68] = r67
                                                                        r68 = nil
                                                                        state = 26
                                                                    end
                                                                end
                                                            else
                                                                if state == 28 then
                                                                    r4 = #r66
                                                                    r13 = 0
                                                                    r68 = r4 == r13
                                                                    state = 29
                                                                end
                                                            end
                                                        else
                                                            if state <= 29 then
                                                                if state == 29 then
                                                                    r4 = 1
                                                                    r13 = #r66
                                                                    r68 = r34(r4, r13)
                                                                    r4 = r92(r66, r68)
                                                                    r13 = upvalueValues[r41]
                                                                    r67 = 1
                                                                    r14 = r4 - r67
                                                                    r54 = r16(r14)
                                                                    r68 = nil
                                                                    r13[r4] = r54
                                                                    r4 = nil
                                                                    state = 30
                                                                end
                                                            else
                                                                if state == 30 then
                                                                    r4 = #r66
                                                                    r13 = 0
                                                                    r68 = r4 == r13
                                                                    state = r68 and (31) or (29)
                                                                end
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 35 then
                                                        if state <= 33 then
                                                            if state <= 32 then
                                                                if state <= 31 then
                                                                    if state == 31 then
                                                                        r4 = allocUpvalue()
                                                                        r68 = {}
                                                                        upvalueValues[r4] = r68
                                                                        r68 = allocUpvalue()
                                                                        r13 = createClosure4(60, {
                                                                            r4,
                                                                            r62,
                                                                            r74,
                                                                            r65
                                                                        })
                                                                        upvalueValues[r68] = r13
                                                                        r13 = {}
                                                                        r54 = allocUpvalue()
                                                                        r67 = {}
                                                                        r65 = releaseUpvalue(r65)
                                                                        upvalueValues[r54] = r13
                                                                        r14 = "setmetatable"
                                                                        r13 = _env[r14]
                                                                        r15 = upvalueValues[r54]
                                                                        r32 = nil
                                                                        r24 = "__metatable"
                                                                        r91 = "__index"
                                                                        r84 = {
                                                                            [r91] = r15,
                                                                            [r24] = r32
                                                                        }
                                                                        r14 = r13(r67, r84)
                                                                        r13 = createClosure5(66, {
                                                                            r54,
                                                                            r4,
                                                                            r41,
                                                                            r62,
                                                                            r74,
                                                                            r68
                                                                        })
                                                                        r54 = releaseUpvalue(r54)
                                                                        upvalueValues[r12] = r14
                                                                        r74 = releaseUpvalue(r74)
                                                                        upvalueValues[r61] = r13
                                                                        r62 = releaseUpvalue(r62)
                                                                        r68 = releaseUpvalue(r68)
                                                                        r65 = "game"
                                                                        r34 = nil
                                                                        r34 = _env[r65]
                                                                        r41 = releaseUpvalue(r41)
                                                                        r16 = nil
                                                                        r16 = upvalueValues[r12]
                                                                        r56 = nil
                                                                        r56 = upvalueValues[r61]
                                                                        r4 = releaseUpvalue(r4)
                                                                        r27 = nil
                                                                        r27 = 20415380268322
                                                                        r74 = "\249=!\008\142\141'"
                                                                        r62 = r56(r74, r27)
                                                                        r92 = nil
                                                                        r92 = r16[r62]
                                                                        r65 = "GetService"
                                                                        r65 = r34[r65]
                                                                        r65 = r65(r34, r92)
                                                                        r34 = allocUpvalue()
                                                                        upvalueValues[r34] = r65
                                                                        r92 = "game"
                                                                        r65 = _env[r92]
                                                                        r56 = upvalueValues[r12]
                                                                        r92 = "GetService"
                                                                        r92 = r65[r92]
                                                                        r62 = upvalueValues[r61]
                                                                        r41 = 18194891366680
                                                                        r27 = "Wf\184q\174\1717\251\232t"
                                                                        r74 = r62(r27, r41)
                                                                        r16 = r56[r74]
                                                                        r92 = r92(r65, r16)
                                                                        r65 = allocUpvalue()
                                                                        upvalueValues[r65] = r92
                                                                        r16 = "game"
                                                                        r92 = _env[r16]
                                                                        r62 = upvalueValues[r12]
                                                                        r74 = upvalueValues[r61]
                                                                        r66 = nil
                                                                        r66 = 12141130176021
                                                                        r41 = "\193\212H>\247\180\"\193\224"
                                                                        r27 = r74(r41, r66)
                                                                        r56 = r62[r27]
                                                                        r16 = "GetService"
                                                                        r16 = r92[r16]
                                                                        r16 = r16(r92, r56)
                                                                        r92 = allocUpvalue()
                                                                        upvalueValues[r92] = r16
                                                                        r56 = "game"
                                                                        r16 = _env[r56]
                                                                        r74 = upvalueValues[r12]
                                                                        r27 = upvalueValues[r61]
                                                                        r68 = 24723266546936
                                                                        r66 = "'J\"\175\014\204\203;_\172V\146e)W>"
                                                                        r41 = r27(r66, r68)
                                                                        r56 = "GetService"
                                                                        r56 = r16[r56]
                                                                        r62 = r74[r41]
                                                                        r56 = r56(r16, r62)
                                                                        r16 = allocUpvalue()
                                                                        upvalueValues[r16] = r56
                                                                        r62 = upvalueValues[r34]
                                                                        r27 = upvalueValues[r12]
                                                                        r41 = upvalueValues[r61]
                                                                        r4 = 3934436722472
                                                                        r68 = "Y\219'B\203\007\234\218,\169\235"
                                                                        r66 = r41(r68, r4)
                                                                        r74 = r27[r66]
                                                                        r56 = r62[r74]
                                                                        r27 = upvalueValues[r12]
                                                                        r41 = upvalueValues[r61]
                                                                        r4 = 18847237530184
                                                                        r68 = "\008\203\201 \223z\237\222\193"
                                                                        r66 = r41(r68, r4)
                                                                        r74 = r27[r66]
                                                                        r62 = "WaitForChild"
                                                                        r62 = r56[r62]
                                                                        r62 = r62(r56, r74)
                                                                        r41 = upvalueValues[r12]
                                                                        r66 = upvalueValues[r61]
                                                                        r74 = "FindFirstChild"
                                                                        r74 = r62[r74]
                                                                        r13 = 5071413152057
                                                                        r4 = "?\212d\176\152Q/\154"
                                                                        r68 = r66(r4, r13)
                                                                        r27 = r41[r68]
                                                                        r74 = r74(r62, r27)
                                                                        state = r74 and (32) or (33)
                                                                    end
                                                                else
                                                                    if state == 32 then
                                                                        r27 = "Destroy"
                                                                        r27 = r74[r27]
                                                                        r27 = r27(r74)
                                                                        state = 33
                                                                    end
                                                                end
                                                            else
                                                                if state == 33 then
                                                                    r66 = "Instance"
                                                                    r41 = _env[r66]
                                                                    r68 = upvalueValues[r12]
                                                                    r4 = upvalueValues[r61]
                                                                    r54 = "\220\162h"
                                                                    r67 = 25919037058853
                                                                    r13 = r4(r54, r67)
                                                                    r66 = r68[r13]
                                                                    r27 = r41[r66]
                                                                    r68 = upvalueValues[r12]
                                                                    r4 = upvalueValues[r61]
                                                                    r54 = "\022C\232H\183\193\176\029\230"
                                                                    r67 = 14159723993537
                                                                    r13 = r4(r54, r67)
                                                                    r66 = r68[r13]
                                                                    r41 = r27(r66)
                                                                    r66 = upvalueValues[r12]
                                                                    r68 = upvalueValues[r61]
                                                                    r13 = "\206\237e:"
                                                                    r54 = 28324971017093
                                                                    r4 = r68(r13, r54)
                                                                    r27 = r66[r4]
                                                                    r68 = upvalueValues[r12]
                                                                    r4 = upvalueValues[r61]
                                                                    r67 = 14091407808929
                                                                    r54 = "\197\191\251\157\001\173\020\234"
                                                                    r13 = r4(r54, r67)
                                                                    r66 = r68[r13]
                                                                    r41[r27] = r66
                                                                    r66 = upvalueValues[r12]
                                                                    r68 = upvalueValues[r61]
                                                                    r54 = 33590666099993
                                                                    r13 = "\189\227\164\030c\141\230\176\002.\211Q"
                                                                    r4 = r68(r13, r54)
                                                                    r27 = r66[r4]
                                                                    r66 = false
                                                                    r41[r27] = r66
                                                                    r66 = upvalueValues[r12]
                                                                    r68 = upvalueValues[r61]
                                                                    r54 = 4890747406565
                                                                    r13 = "\217\tX\012U\223"
                                                                    r4 = r68(r13, r54)
                                                                    r27 = r66[r4]
                                                                    r66 = r62
                                                                    r41[r27] = r66
                                                                    r68 = "Instance"
                                                                    r66 = _env[r68]
                                                                    r4 = upvalueValues[r12]
                                                                    r13 = upvalueValues[r61]
                                                                    r84 = 5333642545587
                                                                    r67 = "/\220\154"
                                                                    r54 = r13(r67, r84)
                                                                    r68 = r4[r54]
                                                                    r27 = r66[r68]
                                                                    r4 = upvalueValues[r12]
                                                                    r13 = upvalueValues[r61]
                                                                    r84 = 10066974102095
                                                                    r67 = "s\159]\0034\153W\017\143va"
                                                                    r54 = r13(r67, r84)
                                                                    r68 = r4[r54]
                                                                    r66 = r27(r68)
                                                                    r27 = allocUpvalue()
                                                                    upvalueValues[r27] = r66
                                                                    r66 = upvalueValues[r27]
                                                                    r4 = upvalueValues[r12]
                                                                    r13 = upvalueValues[r61]
                                                                    r67 = "-j\008\225"
                                                                    r84 = 33998712061399
                                                                    r54 = r13(r67, r84)
                                                                    r68 = r4[r54]
                                                                    r13 = upvalueValues[r12]
                                                                    r54 = upvalueValues[r61]
                                                                    r91 = 29875520255575
                                                                    r84 = "<\239\015\152\014\015\146$"
                                                                    r67 = r54(r84, r91)
                                                                    r4 = r13[r67]
                                                                    r66[r68] = r4
                                                                    r66 = upvalueValues[r27]
                                                                    r4 = upvalueValues[r12]
                                                                    r13 = upvalueValues[r61]
                                                                    r84 = 10106134188642
                                                                    r67 = "\133\227\210i"
                                                                    r54 = r13(r67, r84)
                                                                    r68 = r4[r54]
                                                                    r54 = "UDim2"
                                                                    r13 = _env[r54]
                                                                    r67 = upvalueValues[r12]
                                                                    r84 = upvalueValues[r61]
                                                                    r15 = "\185\150("
                                                                    r24 = 28273831654254
                                                                    r91 = r84(r15, r24)
                                                                    r54 = r67[r91]
                                                                    r4 = r13[r54]
                                                                    r84 = 0
                                                                    r54 = 0
                                                                    r67 = 70
                                                                    r91 = 70
                                                                    r13 = r4(r54, r67, r84, r91)
                                                                    r66[r68] = r13
                                                                    r66 = upvalueValues[r27]
                                                                    r4 = upvalueValues[r12]
                                                                    r13 = upvalueValues[r61]
                                                                    r84 = 22324381755547
                                                                    r67 = "d%]t\146@\202\203"
                                                                    r54 = r13(r67, r84)
                                                                    r68 = r4[r54]
                                                                    r5 = allocUpvalue()
                                                                    r54 = "UDim2"
                                                                    r13 = _env[r54]
                                                                    r67 = upvalueValues[r12]
                                                                    r84 = upvalueValues[r61]
                                                                    r24 = 30432012367707
                                                                    r15 = "\2320\197"
                                                                    r91 = r84(r15, r24)
                                                                    r54 = r67[r91]
                                                                    r4 = r13[r54]
                                                                    r84 = 0
                                                                    r54 = 0
                                                                    r67 = 20
                                                                    r91 = 20
                                                                    r13 = r4(r54, r67, r84, r91)
                                                                    r66[r68] = r13
                                                                    r66 = upvalueValues[r27]
                                                                    r4 = upvalueValues[r12]
                                                                    r13 = upvalueValues[r61]
                                                                    r84 = 24142798875626
                                                                    r67 = "4\006\237\241'\241\182]T_h\229MD\139\233"
                                                                    r54 = r13(r67, r84)
                                                                    r68 = r4[r54]
                                                                    r54 = "Color3"
                                                                    r13 = _env[r54]
                                                                    r67 = upvalueValues[r12]
                                                                    r84 = upvalueValues[r61]
                                                                    r15 = "\005\141\243\209\012\127j"
                                                                    r24 = 3793135978214
                                                                    r91 = r84(r15, r24)
                                                                    r54 = r67[r91]
                                                                    r4 = r13[r54]
                                                                    r67 = upvalueValues[r12]
                                                                    r84 = upvalueValues[r61]
                                                                    r24 = 28076216447762
                                                                    r15 = "\235(\210y\028\025\239"
                                                                    r91 = r84(r15, r24)
                                                                    r54 = r67[r91]
                                                                    r13 = r4(r54)
                                                                    r66[r68] = r13
                                                                    r66 = upvalueValues[r27]
                                                                    r4 = upvalueValues[r12]
                                                                    r13 = upvalueValues[r61]
                                                                    r84 = 26911276331251
                                                                    r67 = "Hn\1475\217_\1531\220\184\0012M<\232"
                                                                    r54 = r13(r67, r84)
                                                                    r68 = r4[r54]
                                                                    r4 = 0
                                                                    r66[r68] = r4
                                                                    r66 = upvalueValues[r27]
                                                                    r4 = upvalueValues[r12]
                                                                    r13 = upvalueValues[r61]
                                                                    r67 = "\165\238\029mZ"
                                                                    r84 = 23061957585395
                                                                    r54 = r13(r67, r84)
                                                                    r68 = r4[r54]
                                                                    r13 = upvalueValues[r12]
                                                                    r54 = upvalueValues[r61]
                                                                    r91 = 9958705238557
                                                                    r84 = "\008\185\162\"\140\158cz\227\173':\nl\r\021\170\154\157\002\236\211\251 \014\162\127p"
                                                                    r67 = r54(r84, r91)
                                                                    r4 = r13[r67]
                                                                    r66[r68] = r4
                                                                    r66 = upvalueValues[r27]
                                                                    r4 = upvalueValues[r12]
                                                                    r13 = upvalueValues[r61]
                                                                    r67 = "dV\008\t\021\152"
                                                                    r84 = 6271536581480
                                                                    r54 = r13(r67, r84)
                                                                    r68 = r4[r54]
                                                                    r4 = r41
                                                                    r66[r68] = r4
                                                                    r66 = upvalueValues[r27]
                                                                    r4 = upvalueValues[r12]
                                                                    r13 = upvalueValues[r61]
                                                                    r84 = 13786985945364
                                                                    r67 = "\176\134\235\252\165P"
                                                                    r54 = r13(r67, r84)
                                                                    r68 = r4[r54]
                                                                    r4 = 10
                                                                    r66[r68] = r4
                                                                    r4 = "Instance"
                                                                    r68 = _env[r4]
                                                                    r13 = upvalueValues[r12]
                                                                    r54 = upvalueValues[r61]
                                                                    r91 = 11835672745351
                                                                    r84 = "\133\012\021"
                                                                    r67 = r54(r84, r91)
                                                                    r4 = r13[r67]
                                                                    r66 = r68[r4]
                                                                    r13 = upvalueValues[r12]
                                                                    r54 = upvalueValues[r61]
                                                                    r91 = 33265251662978
                                                                    r84 = "K\2474\203*3a\164"
                                                                    r67 = r54(r84, r91)
                                                                    r4 = r13[r67]
                                                                    r13 = upvalueValues[r27]
                                                                    r68 = r66(r4, r13)
                                                                    r4 = upvalueValues[r12]
                                                                    r13 = upvalueValues[r61]
                                                                    r67 = "\018\138\179\221EK\255p\030J\248\198"
                                                                    r84 = 34202366213686
                                                                    r54 = r13(r67, r84)
                                                                    r66 = r4[r54]
                                                                    r54 = "UDim"
                                                                    r13 = _env[r54]
                                                                    r67 = upvalueValues[r12]
                                                                    r84 = upvalueValues[r61]
                                                                    r24 = 30030564128416
                                                                    r15 = "\239\149\226"
                                                                    r91 = r84(r15, r24)
                                                                    r54 = r67[r91]
                                                                    r4 = r13[r54]
                                                                    r67 = 10
                                                                    r54 = 0
                                                                    r13 = r4(r54, r67)
                                                                    r68[r66] = r13
                                                                    r4 = "Instance"
                                                                    r68 = _env[r4]
                                                                    r13 = upvalueValues[r12]
                                                                    r54 = upvalueValues[r61]
                                                                    r91 = 10222009733783
                                                                    r84 = "(\031V"
                                                                    r67 = r54(r84, r91)
                                                                    r4 = r13[r67]
                                                                    r66 = r68[r4]
                                                                    r13 = upvalueValues[r12]
                                                                    r54 = upvalueValues[r61]
                                                                    r84 = "\232`s\025\005"
                                                                    r91 = 23741260655407
                                                                    r67 = r54(r84, r91)
                                                                    r4 = r13[r67]
                                                                    r68 = r66(r4)
                                                                    r66 = allocUpvalue()
                                                                    upvalueValues[r66] = r68
                                                                    r68 = upvalueValues[r66]
                                                                    r13 = upvalueValues[r12]
                                                                    r54 = upvalueValues[r61]
                                                                    r91 = 33965000850888
                                                                    r84 = "1\017Q\176"
                                                                    r67 = r54(r84, r91)
                                                                    r4 = r13[r67]
                                                                    r54 = upvalueValues[r12]
                                                                    r67 = upvalueValues[r61]
                                                                    r15 = 29069247263968
                                                                    r91 = "\161\130\198\144\206\243\254\0072|"
                                                                    r84 = r67(r91, r15)
                                                                    r13 = r54[r84]
                                                                    r68[r4] = r13
                                                                    r68 = upvalueValues[r66]
                                                                    r13 = upvalueValues[r12]
                                                                    r54 = upvalueValues[r61]
                                                                    r84 = "Oy\181\152"
                                                                    r91 = 28812673807464
                                                                    r67 = r54(r84, r91)
                                                                    r4 = r13[r67]
                                                                    r67 = "UDim2"
                                                                    r54 = _env[r67]
                                                                    r84 = upvalueValues[r12]
                                                                    r91 = upvalueValues[r61]
                                                                    r32 = 24699665804525
                                                                    r24 = "{4z"
                                                                    r15 = r91(r24, r32)
                                                                    r67 = r84[r15]
                                                                    r10 = allocUpvalue()
                                                                    r13 = r54[r67]
                                                                    r91 = 0
                                                                    r15 = 245
                                                                    r67 = 0
                                                                    r84 = 205
                                                                    r54 = r13(r67, r84, r91, r15)
                                                                    r68[r4] = r54
                                                                    r68 = upvalueValues[r66]
                                                                    r13 = upvalueValues[r12]
                                                                    r54 = upvalueValues[r61]
                                                                    r91 = 8044599168674
                                                                    r84 = "\170\246\"\243Y\"\172D"
                                                                    r67 = r54(r84, r91)
                                                                    r4 = r13[r67]
                                                                    r67 = "UDim2"
                                                                    r54 = _env[r67]
                                                                    r84 = upvalueValues[r12]
                                                                    r91 = upvalueValues[r61]
                                                                    r32 = 21953272719342
                                                                    r24 = "ASM"
                                                                    r15 = r91(r24, r32)
                                                                    r67 = r84[r15]
                                                                    r13 = r54[r67]
                                                                    r15 = -105
                                                                    r84 = -102
                                                                    r91 = 0.5
                                                                    r67 = 0.5
                                                                    r54 = r13(r67, r84, r91, r15)
                                                                    r68[r4] = r54
                                                                    r68 = upvalueValues[r66]
                                                                    r13 = upvalueValues[r12]
                                                                    r54 = upvalueValues[r61]
                                                                    r84 = "9u\252\020\189?\177K\159\248\197\180\146\026\161\242"
                                                                    r91 = 3606701508239
                                                                    r67 = r54(r84, r91)
                                                                    r4 = r13[r67]
                                                                    r67 = "Color3"
                                                                    r54 = _env[r67]
                                                                    r84 = upvalueValues[r12]
                                                                    r91 = upvalueValues[r61]
                                                                    r32 = 6450893163451
                                                                    r24 = "\225\008\030K\135\183:"
                                                                    r15 = r91(r24, r32)
                                                                    r67 = r84[r15]
                                                                    r13 = r54[r67]
                                                                    r84 = upvalueValues[r12]
                                                                    r91 = upvalueValues[r61]
                                                                    r24 = "\"\192\026\028\128\136\221"
                                                                    r32 = 26844020125908
                                                                    r15 = r91(r24, r32)
                                                                    r67 = r84[r15]
                                                                    r54 = r13(r67)
                                                                    r68[r4] = r54
                                                                    r68 = upvalueValues[r66]
                                                                    r13 = upvalueValues[r12]
                                                                    r54 = upvalueValues[r61]
                                                                    r91 = 8940344053827
                                                                    r84 = "\227\212B\130\147C"
                                                                    r67 = r54(r84, r91)
                                                                    r4 = r13[r67]
                                                                    r13 = r41
                                                                    r68[r4] = r13
                                                                    r68 = upvalueValues[r66]
                                                                    r13 = upvalueValues[r12]
                                                                    r54 = upvalueValues[r61]
                                                                    r84 = "\011\155\018y\187\129\133\014\205\015G\239\206\175\236\211"
                                                                    r91 = 16517867265547
                                                                    r67 = r54(r84, r91)
                                                                    r4 = r13[r67]
                                                                    r13 = true
                                                                    r68[r4] = r13
                                                                    r68 = upvalueValues[r66]
                                                                    r13 = upvalueValues[r12]
                                                                    r54 = upvalueValues[r61]
                                                                    r91 = 25658360082092
                                                                    r84 = "\142\220\023\198m\192}"
                                                                    r67 = r54(r84, r91)
                                                                    r4 = r13[r67]
                                                                    r13 = false
                                                                    r68[r4] = r13
                                                                    r13 = "Instance"
                                                                    r4 = _env[r13]
                                                                    r54 = upvalueValues[r12]
                                                                    r67 = upvalueValues[r61]
                                                                    r15 = 3631492204187
                                                                    r91 = "\163\205\215"
                                                                    r84 = r67(r91, r15)
                                                                    r13 = r54[r84]
                                                                    r68 = r4[r13]
                                                                    r54 = upvalueValues[r12]
                                                                    r67 = upvalueValues[r61]
                                                                    r91 = "\210\148\195g\217\190\004\174"
                                                                    r15 = 26624001470573
                                                                    r84 = r67(r91, r15)
                                                                    r13 = r54[r84]
                                                                    r54 = upvalueValues[r66]
                                                                    r4 = r68(r13, r54)
                                                                    r13 = upvalueValues[r12]
                                                                    r54 = upvalueValues[r61]
                                                                    r84 = "j\211\003\218<\231\149S\222Eb\251"
                                                                    r91 = 18747819647514
                                                                    r67 = r54(r84, r91)
                                                                    r68 = r13[r67]
                                                                    r67 = "UDim"
                                                                    r54 = _env[r67]
                                                                    r84 = upvalueValues[r12]
                                                                    r91 = upvalueValues[r61]
                                                                    r32 = 25955873976118
                                                                    r24 = "0uz"
                                                                    r15 = r91(r24, r32)
                                                                    r67 = r84[r15]
                                                                    r13 = r54[r67]
                                                                    r84 = 10
                                                                    r67 = 0
                                                                    r54 = r13(r67, r84)
                                                                    r4[r68] = r54
                                                                    r13 = "Instance"
                                                                    r4 = _env[r13]
                                                                    r54 = upvalueValues[r12]
                                                                    r67 = upvalueValues[r61]
                                                                    r91 = "\2220\254"
                                                                    r15 = 21871641733064
                                                                    r84 = r67(r91, r15)
                                                                    r13 = r54[r84]
                                                                    r68 = r4[r13]
                                                                    r54 = upvalueValues[r12]
                                                                    r67 = upvalueValues[r61]
                                                                    r91 = "\234\250\219F#"
                                                                    r15 = 7706246417924
                                                                    r84 = r67(r91, r15)
                                                                    r13 = r54[r84]
                                                                    r4 = r68(r13)
                                                                    r13 = upvalueValues[r12]
                                                                    r54 = upvalueValues[r61]
                                                                    r91 = 29749009954332
                                                                    r84 = "\149\200\251'"
                                                                    r67 = r54(r84, r91)
                                                                    r68 = r13[r67]
                                                                    r54 = upvalueValues[r12]
                                                                    r67 = upvalueValues[r61]
                                                                    r15 = 14763486075610
                                                                    r91 = "\129\212f\001"
                                                                    r84 = r67(r91, r15)
                                                                    r13 = r54[r84]
                                                                    r4[r68] = r13
                                                                    r13 = upvalueValues[r12]
                                                                    r54 = upvalueValues[r61]
                                                                    r84 = "\246\020//"
                                                                    r91 = 34617522749176
                                                                    r67 = r54(r84, r91)
                                                                    r68 = r13[r67]
                                                                    r67 = "UDim2"
                                                                    r54 = _env[r67]
                                                                    r84 = upvalueValues[r12]
                                                                    r91 = upvalueValues[r61]
                                                                    r32 = 17626595434512
                                                                    r24 = "\217\251\157"
                                                                    r15 = r91(r24, r32)
                                                                    r67 = r84[r15]
                                                                    r13 = r54[r67]
                                                                    r91 = 0
                                                                    r15 = 35
                                                                    r84 = 0
                                                                    r67 = 1
                                                                    r54 = r13(r67, r84, r91, r15)
                                                                    r4[r68] = r54
                                                                    r13 = upvalueValues[r12]
                                                                    r54 = upvalueValues[r61]
                                                                    r91 = 24722191314168
                                                                    r84 = "\132\1344\195\150\149\169\017\140\025w \156PC\206"
                                                                    r67 = r54(r84, r91)
                                                                    r68 = r13[r67]
                                                                    r67 = "Color3"
                                                                    r54 = _env[r67]
                                                                    r84 = upvalueValues[r12]
                                                                    r91 = upvalueValues[r61]
                                                                    r24 = "\228:y\130\225\219v"
                                                                    r32 = 5704687225440
                                                                    r15 = r91(r24, r32)
                                                                    r67 = r84[r15]
                                                                    r13 = r54[r67]
                                                                    r84 = upvalueValues[r12]
                                                                    r91 = upvalueValues[r61]
                                                                    r24 = "2\242\207\2248\202\024"
                                                                    r32 = 31413581379876
                                                                    r15 = r91(r24, r32)
                                                                    r67 = r84[r15]
                                                                    r54 = r13(r67)
                                                                    r4[r68] = r54
                                                                    r13 = upvalueValues[r12]
                                                                    r54 = upvalueValues[r61]
                                                                    r84 = "_\000S\206<\253"
                                                                    r91 = 1373491970687
                                                                    r67 = r54(r84, r91)
                                                                    r68 = r13[r67]
                                                                    r13 = upvalueValues[r66]
                                                                    r4[r68] = r13
                                                                    r54 = "Instance"
                                                                    r13 = _env[r54]
                                                                    r67 = upvalueValues[r12]
                                                                    r84 = upvalueValues[r61]
                                                                    r15 = "\148\192{"
                                                                    r24 = 3785566783202
                                                                    r91 = r84(r15, r24)
                                                                    r54 = r67[r91]
                                                                    r68 = r13[r54]
                                                                    r67 = upvalueValues[r12]
                                                                    r84 = upvalueValues[r61]
                                                                    r15 = "\030Q\027\219\169\213hI"
                                                                    r24 = 30431575488346
                                                                    r91 = r84(r15, r24)
                                                                    r54 = r67[r91]
                                                                    r13 = r68(r54, r4)
                                                                    r54 = upvalueValues[r12]
                                                                    r67 = upvalueValues[r61]
                                                                    r91 = "D\196!1|\158\179\222:\229\128\134"
                                                                    r15 = 31404056099103
                                                                    r84 = r67(r91, r15)
                                                                    r68 = r54[r84]
                                                                    r84 = "UDim"
                                                                    r67 = _env[r84]
                                                                    r91 = upvalueValues[r12]
                                                                    r15 = upvalueValues[r61]
                                                                    r73 = 14007576516986
                                                                    r32 = "`@7"
                                                                    r24 = r15(r32, r73)
                                                                    r84 = r91[r24]
                                                                    r54 = r67[r84]
                                                                    r91 = 10
                                                                    r84 = 0
                                                                    r67 = r54(r84, r91)
                                                                    r13[r68] = r67
                                                                    r54 = "Instance"
                                                                    r13 = _env[r54]
                                                                    r67 = upvalueValues[r12]
                                                                    r84 = upvalueValues[r61]
                                                                    r15 = "&\227\188"
                                                                    r24 = 18988464038538
                                                                    r91 = r84(r15, r24)
                                                                    r54 = r67[r91]
                                                                    r68 = r13[r54]
                                                                    r67 = upvalueValues[r12]
                                                                    r84 = upvalueValues[r61]
                                                                    r15 = "\240Rg\012U"
                                                                    r24 = 30184684844775
                                                                    r91 = r84(r15, r24)
                                                                    r54 = r67[r91]
                                                                    r13 = r68(r54)
                                                                    r54 = upvalueValues[r12]
                                                                    r67 = upvalueValues[r61]
                                                                    r15 = 7892451692123
                                                                    r91 = "\234\023\191^"
                                                                    r84 = r67(r91, r15)
                                                                    r68 = r54[r84]
                                                                    r84 = "UDim2"
                                                                    r67 = _env[r84]
                                                                    r91 = upvalueValues[r12]
                                                                    r15 = upvalueValues[r61]
                                                                    r32 = "\205\212h"
                                                                    r73 = 12616765757171
                                                                    r24 = r15(r32, r73)
                                                                    r84 = r91[r24]
                                                                    r54 = r67[r84]
                                                                    r91 = 0
                                                                    r84 = 1
                                                                    r15 = 0
                                                                    r24 = 25
                                                                    r67 = r54(r84, r91, r15, r24)
                                                                    r13[r68] = r67
                                                                    r54 = upvalueValues[r12]
                                                                    r67 = upvalueValues[r61]
                                                                    r15 = 19699978544085
                                                                    r91 = "\143\197/\011\194A\222\171"
                                                                    r84 = r67(r91, r15)
                                                                    r68 = r54[r84]
                                                                    r84 = "UDim2"
                                                                    r67 = _env[r84]
                                                                    r91 = upvalueValues[r12]
                                                                    r15 = upvalueValues[r61]
                                                                    r32 = "x^)"
                                                                    r73 = 15937050860797
                                                                    r24 = r15(r32, r73)
                                                                    r84 = r91[r24]
                                                                    r54 = r67[r84]
                                                                    r91 = 0
                                                                    r15 = 0
                                                                    r24 = 10
                                                                    r84 = 0
                                                                    r67 = r54(r84, r91, r15, r24)
                                                                    r13[r68] = r67
                                                                    r54 = upvalueValues[r12]
                                                                    r67 = upvalueValues[r61]
                                                                    r91 = "\245\224t\244\199\252\164\186\208\234\172\174\165\219G\237"
                                                                    r15 = 34570038476513
                                                                    r84 = r67(r91, r15)
                                                                    r68 = r54[r84]
                                                                    r84 = "Color3"
                                                                    r67 = _env[r84]
                                                                    r91 = upvalueValues[r12]
                                                                    r15 = upvalueValues[r61]
                                                                    r73 = 23306680052325
                                                                    r32 = "\217q\222b\170\2332"
                                                                    r24 = r15(r32, r73)
                                                                    r84 = r91[r24]
                                                                    r54 = r67[r84]
                                                                    r91 = upvalueValues[r12]
                                                                    r15 = upvalueValues[r61]
                                                                    r73 = 22387944024249
                                                                    r32 = "\014\215\134\215\025&\189"
                                                                    r24 = r15(r32, r73)
                                                                    r84 = r91[r24]
                                                                    r67 = r54(r84)
                                                                    r13[r68] = r67
                                                                    r54 = upvalueValues[r12]
                                                                    r67 = upvalueValues[r61]
                                                                    r15 = 26229686513590
                                                                    r91 = "-25\233\204S\225\165-OZ\212\129\004\182"
                                                                    r84 = r67(r91, r15)
                                                                    r68 = r54[r84]
                                                                    r54 = 0
                                                                    r13[r68] = r54
                                                                    r54 = upvalueValues[r12]
                                                                    r67 = upvalueValues[r61]
                                                                    r15 = 32247024122536
                                                                    r91 = "\138\197P\252\162_"
                                                                    r84 = r67(r91, r15)
                                                                    r68 = r54[r84]
                                                                    r54 = r4
                                                                    r13[r68] = r54
                                                                    r67 = "Instance"
                                                                    r54 = _env[r67]
                                                                    r84 = upvalueValues[r12]
                                                                    r91 = upvalueValues[r61]
                                                                    r24 = "\224+\202"
                                                                    r32 = 3721439184580
                                                                    r15 = r91(r24, r32)
                                                                    r67 = r84[r15]
                                                                    r68 = r54[r67]
                                                                    r84 = upvalueValues[r12]
                                                                    r91 = upvalueValues[r61]
                                                                    r24 = "\169\164\142\152\187\150ud\211"
                                                                    r32 = 16703674490466
                                                                    r15 = r91(r24, r32)
                                                                    r67 = r84[r15]
                                                                    r54 = r68(r67)
                                                                    r67 = upvalueValues[r12]
                                                                    r84 = upvalueValues[r61]
                                                                    r15 = "T\242\022O\182\175"
                                                                    r24 = 694144221507
                                                                    r91 = r84(r15, r24)
                                                                    r68 = r67[r91]
                                                                    r67 = r4
                                                                    r54[r68] = r67
                                                                    r67 = upvalueValues[r12]
                                                                    r84 = upvalueValues[r61]
                                                                    r15 = "\222<\168B"
                                                                    r24 = 30345440655154
                                                                    r91 = r84(r15, r24)
                                                                    r68 = r67[r91]
                                                                    r91 = "UDim2"
                                                                    r84 = _env[r91]
                                                                    r15 = upvalueValues[r12]
                                                                    r24 = upvalueValues[r61]
                                                                    r1 = 267122032764
                                                                    r73 = "\143\\_"
                                                                    r32 = r24(r73, r1)
                                                                    r91 = r15[r32]
                                                                    r15 = -5
                                                                    r67 = r84[r91]
                                                                    r91 = 0.7
                                                                    r24 = 1
                                                                    r32 = 0
                                                                    r84 = r67(r91, r15, r24, r32)
                                                                    r54[r68] = r84
                                                                    r67 = upvalueValues[r12]
                                                                    r84 = upvalueValues[r61]
                                                                    r24 = 26650018197625
                                                                    r15 = "\251\198\029h\151\255\023\130"
                                                                    r91 = r84(r15, r24)
                                                                    r68 = r67[r91]
                                                                    r91 = "UDim2"
                                                                    r84 = _env[r91]
                                                                    r15 = upvalueValues[r12]
                                                                    r24 = upvalueValues[r61]
                                                                    r73 = "\1833\156"
                                                                    r1 = 17032710283003
                                                                    r32 = r24(r73, r1)
                                                                    r91 = r15[r32]
                                                                    r67 = r84[r91]
                                                                    r91 = 0
                                                                    r24 = 0
                                                                    r15 = 30
                                                                    r32 = 0
                                                                    r84 = r67(r91, r15, r24, r32)
                                                                    r54[r68] = r84
                                                                    r67 = upvalueValues[r12]
                                                                    r84 = upvalueValues[r61]
                                                                    r24 = 7973368467072
                                                                    r15 = "\219o\138S\209\029\003C\242A\204=@\201\003\154\028\028X(\172Y"
                                                                    r91 = r84(r15, r24)
                                                                    r68 = r67[r91]
                                                                    r67 = 1
                                                                    r54[r68] = r67
                                                                    r67 = upvalueValues[r12]
                                                                    r84 = upvalueValues[r61]
                                                                    r24 = 21214656046742
                                                                    r15 = "\249m\192\012"
                                                                    r91 = r84(r15, r24)
                                                                    r68 = r67[r91]
                                                                    r84 = upvalueValues[r12]
                                                                    r91 = upvalueValues[r61]
                                                                    r24 = "\002\186CX\185\n\2497`i\021"
                                                                    r32 = 31796196374998
                                                                    r15 = r91(r24, r32)
                                                                    r67 = r84[r15]
                                                                    r54[r68] = r67
                                                                    r67 = upvalueValues[r12]
                                                                    r84 = upvalueValues[r61]
                                                                    r15 = "\160q\218e\0082\211*\157\019"
                                                                    r24 = 7406519111032
                                                                    r91 = r84(r15, r24)
                                                                    r68 = r67[r91]
                                                                    r91 = "Color3"
                                                                    r84 = _env[r91]
                                                                    r15 = upvalueValues[r12]
                                                                    r24 = upvalueValues[r61]
                                                                    r1 = 3656879376038
                                                                    r73 = "\141\227\003#n\146u"
                                                                    r32 = r24(r73, r1)
                                                                    r91 = r15[r32]
                                                                    r67 = r84[r91]
                                                                    r15 = upvalueValues[r12]
                                                                    r24 = upvalueValues[r61]
                                                                    r1 = 21334015583950
                                                                    r73 = "~\217<\170In?"
                                                                    r32 = r24(r73, r1)
                                                                    r91 = r15[r32]
                                                                    r84 = r67(r91)
                                                                    r54[r68] = r84
                                                                    r67 = upvalueValues[r12]
                                                                    r84 = upvalueValues[r61]
                                                                    r15 = "/%\209*g(<\031"
                                                                    r24 = 13111206352857
                                                                    r91 = r84(r15, r24)
                                                                    r68 = r67[r91]
                                                                    r67 = 15
                                                                    r54[r68] = r67
                                                                    r67 = upvalueValues[r12]
                                                                    r84 = upvalueValues[r61]
                                                                    r24 = 35070460755914
                                                                    r15 = "\020\136e\149"
                                                                    r91 = r84(r15, r24)
                                                                    r68 = r67[r91]
                                                                    r15 = "Enum"
                                                                    r91 = _env[r15]
                                                                    r24 = upvalueValues[r12]
                                                                    r32 = upvalueValues[r61]
                                                                    r19 = 22707507554638
                                                                    r1 = "i\250\130\249"
                                                                    r73 = r32(r1, r19)
                                                                    r15 = r24[r73]
                                                                    r84 = r91[r15]
                                                                    r15 = upvalueValues[r12]
                                                                    r24 = upvalueValues[r61]
                                                                    r1 = 16896773136060
                                                                    r73 = "\023\185\191\231\130\201\223*\221\008"
                                                                    r32 = r24(r73, r1)
                                                                    r91 = r15[r32]
                                                                    r67 = r84[r91]
                                                                    r54[r68] = r67
                                                                    r67 = upvalueValues[r12]
                                                                    r84 = upvalueValues[r61]
                                                                    r15 = "/\004\004`\025\251\247\177\02032\196y\021"
                                                                    r24 = 30317664139045
                                                                    r91 = r84(r15, r24)
                                                                    r68 = r67[r91]
                                                                    r15 = "Enum"
                                                                    r91 = _env[r15]
                                                                    r24 = upvalueValues[r12]
                                                                    r32 = upvalueValues[r61]
                                                                    r1 = "n\025\233\201#\159\171n\1457\016<;\199"
                                                                    r19 = 18927191548525
                                                                    r73 = r32(r1, r19)
                                                                    r15 = r24[r73]
                                                                    r84 = r91[r15]
                                                                    r15 = upvalueValues[r12]
                                                                    r24 = upvalueValues[r61]
                                                                    r1 = 30904349669430
                                                                    r73 = "a\177\132\222"
                                                                    r32 = r24(r73, r1)
                                                                    r91 = r15[r32]
                                                                    r67 = r84[r91]
                                                                    r54[r68] = r67
                                                                    r84 = "Instance"
                                                                    r67 = _env[r84]
                                                                    r91 = upvalueValues[r12]
                                                                    r15 = upvalueValues[r61]
                                                                    r73 = 14121756088751
                                                                    r32 = "\158b\193"
                                                                    r24 = r15(r32, r73)
                                                                    r84 = r91[r24]
                                                                    r68 = r67[r84]
                                                                    r91 = upvalueValues[r12]
                                                                    r15 = upvalueValues[r61]
                                                                    r32 = "\161\170\185+\t\240\139\127\230l\217"
                                                                    r73 = 13927504288085
                                                                    r24 = r15(r32, r73)
                                                                    r84 = r91[r24]
                                                                    r67 = r68(r84)
                                                                    r84 = upvalueValues[r12]
                                                                    r91 = upvalueValues[r61]
                                                                    r32 = 3612429256338
                                                                    r24 = "\150c5\2305\171"
                                                                    r15 = r91(r24, r32)
                                                                    r68 = r84[r15]
                                                                    r84 = r4
                                                                    r67[r68] = r84
                                                                    r84 = upvalueValues[r12]
                                                                    r91 = upvalueValues[r61]
                                                                    r32 = 26738521845923
                                                                    r24 = "\155\223\165\157"
                                                                    r15 = r91(r24, r32)
                                                                    r68 = r84[r15]
                                                                    r15 = "UDim2"
                                                                    r91 = _env[r15]
                                                                    r24 = upvalueValues[r12]
                                                                    r32 = upvalueValues[r61]
                                                                    r19 = 33627482832171
                                                                    r1 = "\156(\164"
                                                                    r73 = r32(r1, r19)
                                                                    r15 = r24[r73]
                                                                    r84 = r91[r15]
                                                                    r32 = 0
                                                                    r73 = 23
                                                                    r15 = 0
                                                                    r24 = 23
                                                                    r91 = r84(r15, r24, r32, r73)
                                                                    r67[r68] = r91
                                                                    r84 = upvalueValues[r12]
                                                                    r91 = upvalueValues[r61]
                                                                    r24 = "\150\1464-\186\163&*"
                                                                    r32 = 19549480117135
                                                                    r15 = r91(r24, r32)
                                                                    r68 = r84[r15]
                                                                    r15 = "UDim2"
                                                                    r91 = _env[r15]
                                                                    r24 = upvalueValues[r12]
                                                                    r32 = upvalueValues[r61]
                                                                    r19 = 26124188217221
                                                                    r1 = "\170\254\157"
                                                                    r73 = r32(r1, r19)
                                                                    r15 = r24[r73]
                                                                    r24 = -28
                                                                    r84 = r91[r15]
                                                                    r73 = -11
                                                                    r32 = 0.5
                                                                    r15 = 1
                                                                    r91 = r84(r15, r24, r32, r73)
                                                                    r67[r68] = r91
                                                                    r84 = upvalueValues[r12]
                                                                    r91 = upvalueValues[r61]
                                                                    r32 = 21749790795664
                                                                    r24 = "\223\174\235j\005\012kP*\169\176\245&\004{\139v_\241fe\139"
                                                                    r15 = r91(r24, r32)
                                                                    r68 = r84[r15]
                                                                    r84 = 1
                                                                    r67[r68] = r84
                                                                    r84 = upvalueValues[r12]
                                                                    r91 = upvalueValues[r61]
                                                                    r24 = "b\011a\187\215"
                                                                    r32 = 6753052036168
                                                                    r15 = r91(r24, r32)
                                                                    r68 = r84[r15]
                                                                    r91 = upvalueValues[r12]
                                                                    r15 = upvalueValues[r61]
                                                                    r73 = 17169502625595
                                                                    r32 = ".\135\235\031\170\184\158\166\131\0168\239\205+\023\007\175\206\239\242g\180\127JfP\243"
                                                                    r24 = r15(r32, r73)
                                                                    r84 = r91[r24]
                                                                    r67[r68] = r84
                                                                    r91 = "Instance"
                                                                    r84 = _env[r91]
                                                                    r15 = upvalueValues[r12]
                                                                    r24 = upvalueValues[r61]
                                                                    r1 = 18812442812984
                                                                    r73 = "\197\002D"
                                                                    r32 = r24(r73, r1)
                                                                    r91 = r15[r32]
                                                                    r68 = r84[r91]
                                                                    r15 = upvalueValues[r12]
                                                                    r24 = upvalueValues[r61]
                                                                    r1 = 10474491220749
                                                                    r73 = "3\"\236\0035/\208\224\174\188\180i\253\145"
                                                                    r32 = r24(r73, r1)
                                                                    r91 = r15[r32]
                                                                    r84 = r68(r91)
                                                                    r68 = allocUpvalue()
                                                                    upvalueValues[r68] = r84
                                                                    r84 = upvalueValues[r68]
                                                                    r15 = upvalueValues[r12]
                                                                    r24 = upvalueValues[r61]
                                                                    r1 = 33873177132445
                                                                    r73 = "m\149s\177\178\169"
                                                                    r32 = r24(r73, r1)
                                                                    r91 = r15[r32]
                                                                    r15 = upvalueValues[r66]
                                                                    r84[r91] = r15
                                                                    r84 = upvalueValues[r68]
                                                                    r15 = upvalueValues[r12]
                                                                    r24 = upvalueValues[r61]
                                                                    r73 = "\201K\t["
                                                                    r1 = 19506587034491
                                                                    r32 = r24(r73, r1)
                                                                    r91 = r15[r32]
                                                                    r32 = "UDim2"
                                                                    r24 = _env[r32]
                                                                    r73 = upvalueValues[r12]
                                                                    r1 = upvalueValues[r61]
                                                                    r8 = 5635559787072
                                                                    r70 = "\247\201\022"
                                                                    r19 = r1(r70, r8)
                                                                    r32 = r73[r19]
                                                                    r15 = r24[r32]
                                                                    r73 = -10
                                                                    r98 = upvalueValues[r12]
                                                                    r46 = upvalueValues[r61]
                                                                    r94 = " &\0158"
                                                                    r76 = 34140299165209
                                                                    r42 = r46(r94, r76)
                                                                    r2 = r98[r42]
                                                                    r59 = r4[r2]
                                                                    r98 = upvalueValues[r12]
                                                                    r46 = upvalueValues[r61]
                                                                    r94 = "3"
                                                                    r76 = 10972233143285
                                                                    r42 = r46(r94, r76)
                                                                    r2 = r98[r42]
                                                                    r9 = r59[r2]
                                                                    r2 = upvalueValues[r12]
                                                                    r98 = upvalueValues[r61]
                                                                    r94 = 22668270070075
                                                                    r42 = "9\193*&\155\152"
                                                                    r46 = r98(r42, r94)
                                                                    r59 = r2[r46]
                                                                    r8 = r9[r59]
                                                                    r70 = -r8
                                                                    r8 = 10
                                                                    r19 = r70 - r8
                                                                    r1 = 1
                                                                    r32 = 1
                                                                    r24 = r15(r32, r73, r1, r19)
                                                                    r84[r91] = r24
                                                                    r84 = upvalueValues[r68]
                                                                    r15 = upvalueValues[r12]
                                                                    r24 = upvalueValues[r61]
                                                                    r1 = 6929295527066
                                                                    r73 = "0A\255T\224.\168\194"
                                                                    r32 = r24(r73, r1)
                                                                    r91 = r15[r32]
                                                                    r32 = "UDim2"
                                                                    r24 = _env[r32]
                                                                    r73 = upvalueValues[r12]
                                                                    r1 = upvalueValues[r61]
                                                                    r8 = 32186889190028
                                                                    r70 = ";\169\177"
                                                                    r19 = r1(r70, r8)
                                                                    r32 = r73[r19]
                                                                    r15 = r24[r32]
                                                                    r2 = upvalueValues[r12]
                                                                    r98 = upvalueValues[r61]
                                                                    r42 = "\218\238\134U"
                                                                    r94 = 19280094339857
                                                                    r46 = r98(r42, r94)
                                                                    r59 = r2[r46]
                                                                    r9 = r4[r59]
                                                                    r2 = upvalueValues[r12]
                                                                    r98 = upvalueValues[r61]
                                                                    r42 = "\159"
                                                                    r94 = 14335814654483
                                                                    r46 = r98(r42, r94)
                                                                    r59 = r2[r46]
                                                                    r8 = r9[r59]
                                                                    r59 = upvalueValues[r12]
                                                                    r2 = upvalueValues[r61]
                                                                    r42 = 659396477235
                                                                    r46 = "+\236\165\223K\011"
                                                                    r98 = r2(r46, r42)
                                                                    r9 = r59[r98]
                                                                    r70 = r8[r9]
                                                                    r8 = 5
                                                                    r19 = r70 + r8
                                                                    r1 = 0
                                                                    r73 = 5
                                                                    r32 = 0
                                                                    r24 = r15(r32, r73, r1, r19)
                                                                    r42 = allocUpvalue()
                                                                    r84[r91] = r24
                                                                    r84 = upvalueValues[r68]
                                                                    r15 = upvalueValues[r12]
                                                                    r24 = upvalueValues[r61]
                                                                    r1 = 5429737834976
                                                                    r73 = "\208'\244\005$Z\2372\160@"
                                                                    r32 = r24(r73, r1)
                                                                    r91 = r15[r32]
                                                                    r32 = "UDim2"
                                                                    r24 = _env[r32]
                                                                    r73 = upvalueValues[r12]
                                                                    r1 = upvalueValues[r61]
                                                                    r8 = 27447021007341
                                                                    r70 = "\131ES"
                                                                    r19 = r1(r70, r8)
                                                                    r32 = r73[r19]
                                                                    r15 = r24[r32]
                                                                    r1 = 0
                                                                    r32 = 0
                                                                    r19 = 0
                                                                    r73 = 0
                                                                    r24 = r15(r32, r73, r1, r19)
                                                                    r84[r91] = r24
                                                                    r84 = upvalueValues[r68]
                                                                    r15 = upvalueValues[r12]
                                                                    r24 = upvalueValues[r61]
                                                                    r73 = "z*\194\004Y\r\172\016\164\005\161x\202-\135t\157\014"
                                                                    r1 = 545485127934
                                                                    r32 = r24(r73, r1)
                                                                    r91 = r15[r32]
                                                                    r15 = 0
                                                                    r84[r91] = r15
                                                                    r84 = upvalueValues[r68]
                                                                    r15 = upvalueValues[r12]
                                                                    r24 = upvalueValues[r61]
                                                                    r73 = "\190\183\129\148j\164gf\155\253P,s=P1-\001Y\251K\135"
                                                                    r1 = 28137245389614
                                                                    r32 = r24(r73, r1)
                                                                    r91 = r15[r32]
                                                                    r15 = 1
                                                                    r84[r91] = r15
                                                                    r15 = "Instance"
                                                                    r91 = _env[r15]
                                                                    r24 = upvalueValues[r12]
                                                                    r32 = upvalueValues[r61]
                                                                    r19 = 9159422038185
                                                                    r1 = "\150\139\191"
                                                                    r73 = r32(r1, r19)
                                                                    r15 = r24[r73]
                                                                    r84 = r91[r15]
                                                                    r24 = upvalueValues[r12]
                                                                    r32 = upvalueValues[r61]
                                                                    r1 = "8S\159\151$\129\178\223\236L\157%"
                                                                    r19 = 30863149283363
                                                                    r73 = r32(r1, r19)
                                                                    r15 = r24[r73]
                                                                    r91 = r84(r15)
                                                                    r84 = allocUpvalue()
                                                                    upvalueValues[r84] = r91
                                                                    r91 = upvalueValues[r84]
                                                                    r24 = upvalueValues[r12]
                                                                    r32 = upvalueValues[r61]
                                                                    r1 = "\155\154\157\237\186F"
                                                                    r19 = 11880064849308
                                                                    r73 = r32(r1, r19)
                                                                    r15 = r24[r73]
                                                                    r24 = upvalueValues[r68]
                                                                    r91[r15] = r24
                                                                    r91 = upvalueValues[r84]
                                                                    r24 = upvalueValues[r12]
                                                                    r32 = upvalueValues[r61]
                                                                    r1 = "\023y\183\186\249\128\008"
                                                                    r19 = 4879399602400
                                                                    r73 = r32(r1, r19)
                                                                    r15 = r24[r73]
                                                                    r73 = "UDim"
                                                                    r32 = _env[r73]
                                                                    r1 = upvalueValues[r12]
                                                                    r19 = upvalueValues[r61]
                                                                    r8 = "E]\006"
                                                                    r9 = 9800533266899
                                                                    r70 = r19(r8, r9)
                                                                    r73 = r1[r70]
                                                                    r24 = r32[r73]
                                                                    r53 = allocUpvalue()
                                                                    r73 = 0
                                                                    r1 = 10
                                                                    r32 = r24(r73, r1)
                                                                    r91[r15] = r32
                                                                    r91 = upvalueValues[r84]
                                                                    r24 = upvalueValues[r12]
                                                                    r32 = upvalueValues[r61]
                                                                    r19 = 25807569137393
                                                                    r1 = "\143\212\251A\241\251\226t0"
                                                                    r73 = r32(r1, r19)
                                                                    r15 = r24[r73]
                                                                    r1 = "Enum"
                                                                    r73 = _env[r1]
                                                                    r19 = upvalueValues[r12]
                                                                    r70 = upvalueValues[r61]
                                                                    r9 = "\202\2320\\6Em\161\253"
                                                                    r59 = 8491828858738
                                                                    r8 = r70(r9, r59)
                                                                    r1 = r19[r8]
                                                                    r32 = r73[r1]
                                                                    r1 = upvalueValues[r12]
                                                                    r19 = upvalueValues[r61]
                                                                    r8 = "g\177I;SZ\223\217\207s\233"
                                                                    r9 = 1354683007606
                                                                    r70 = r19(r8, r9)
                                                                    r73 = r1[r70]
                                                                    r24 = r32[r73]
                                                                    r91[r15] = r24
                                                                    r91 = upvalueValues[r84]
                                                                    r24 = upvalueValues[r84]
                                                                    r73 = upvalueValues[r12]
                                                                    r1 = upvalueValues[r61]
                                                                    r8 = 24250679880732
                                                                    r70 = "h\249\188T\167iT\172)a\148$\165oG\000\029\232l\2325\132\227\164"
                                                                    r19 = r1(r70, r8)
                                                                    r32 = r73[r19]
                                                                    r15 = r24[r32]
                                                                    r73 = upvalueValues[r12]
                                                                    r1 = upvalueValues[r61]
                                                                    r8 = 28041308975873
                                                                    r70 = "\127t\180[\030\197\133\219\162\023\235\166\163ST\225Hi+"
                                                                    r19 = r1(r70, r8)
                                                                    r32 = r73[r19]
                                                                    r24 = r15(r91, r32)
                                                                    r32 = createClosure1(73, {
                                                                        r68,
                                                                        r12,
                                                                        r61,
                                                                        r84
                                                                    })
                                                                    r15 = "Connect"
                                                                    r15 = r24[r15]
                                                                    r15 = r15(r24, r32)
                                                                    r15 = createClosure7(74, {
                                                                        r12,
                                                                        r61
                                                                    })
                                                                    r32 = upvalueValues[r92]
                                                                    r1 = upvalueValues[r12]
                                                                    r19 = upvalueValues[r61]
                                                                    r9 = 7854335397449
                                                                    r8 = "\214\186\222;\231\137\203@m\200wE\001"
                                                                    r70 = r19(r8, r9)
                                                                    r73 = r1[r70]
                                                                    r24 = r32[r73]
                                                                    r32 = allocUpvalue()
                                                                    r1 = allocUpvalue()
                                                                    upvalueValues[r32] = r24
                                                                    r24 = allocUpvalue()
                                                                    upvalueValues[r24] = r56
                                                                    r73 = 110
                                                                    upvalueValues[r1] = r73
                                                                    r70 = "Color3"
                                                                    r19 = _env[r70]
                                                                    r8 = upvalueValues[r12]
                                                                    r9 = upvalueValues[r61]
                                                                    r46 = allocUpvalue()
                                                                    r2 = "\027\205w\000i\027\031"
                                                                    r98 = 9285428564195
                                                                    r59 = r9(r2, r98)
                                                                    r70 = r8[r59]
                                                                    r73 = r19[r70]
                                                                    r59 = allocUpvalue()
                                                                    r9 = 255
                                                                    r8 = 255
                                                                    r70 = 255
                                                                    r19 = r73(r70, r8, r9)
                                                                    r73 = allocUpvalue()
                                                                    r8 = allocUpvalue()
                                                                    upvalueValues[r73] = r19
                                                                    r9 = allocUpvalue()
                                                                    r70 = allocUpvalue()
                                                                    r19 = 2
                                                                    upvalueValues[r70] = r19
                                                                    r2 = allocUpvalue()
                                                                    r19 = false
                                                                    upvalueValues[r8] = r19
                                                                    r98 = allocUpvalue()
                                                                    r19 = false
                                                                    upvalueValues[r9] = r19
                                                                    r19 = nil
                                                                    upvalueValues[r59] = r19
                                                                    r19 = {}
                                                                    r94 = allocUpvalue()
                                                                    upvalueValues[r2] = r19
                                                                    r19 = nil
                                                                    upvalueValues[r98] = r19
                                                                    r19 = nil
                                                                    upvalueValues[r46] = r19
                                                                    r76 = createClosure0(77, {
                                                                        r98,
                                                                        r12,
                                                                        r61,
                                                                        r70,
                                                                        r1,
                                                                        r73,
                                                                        r8,
                                                                        r65,
                                                                        r32,
                                                                        r94
                                                                    })
                                                                    r19 = nil
                                                                    upvalueValues[r42] = r19
                                                                    r99 = createClosure1(80, {
                                                                        r12,
                                                                        r61,
                                                                        r2
                                                                    })
                                                                    r19 = nil
                                                                    upvalueValues[r94] = r19
                                                                    r19 = allocUpvalue()
                                                                    r23 = createClosure0(83, {
                                                                        r98,
                                                                        r12,
                                                                        r61,
                                                                        r94
                                                                    })
                                                                    upvalueValues[r19] = r76
                                                                    r76 = allocUpvalue()
                                                                    upvalueValues[r76] = r23
                                                                    r23 = allocUpvalue()
                                                                    upvalueValues[r23] = r99
                                                                    r35 = "ipairs"
                                                                    r99 = _env[r35]
                                                                    r58 = upvalueValues[r34]
                                                                    r50 = "GetPlayers"
                                                                    r50 = r58[r50]
                                                                    r81 = {
                                                                        r50(r58)
                                                                    }
                                                                    r58 = {
                                                                        r99(unpack(r81))
                                                                    }
                                                                    r99 = upvalueValues[r32]
                                                                    r11 = r58[3]
                                                                    r35 = r58[1]
                                                                    r86 = r58[2]
                                                                    r81 = allocUpvalue()
                                                                    r58 = allocUpvalue()
                                                                    upvalueValues[r58] = r99
                                                                    r99 = upvalueValues[r2]
                                                                    upvalueValues[r81] = r99
                                                                    r99 = upvalueValues[r68]
                                                                    r50 = upvalueValues[r1]
                                                                    upvalueValues[r53] = r50
                                                                    r50 = nil
                                                                    upvalueValues[r5] = r50
                                                                    r50 = nil
                                                                    upvalueValues[r10] = r50
                                                                    state = 34
                                                                end
                                                            end
                                                        else
                                                            if state <= 34 then
                                                                if state == 34 then
                                                                    r50 = true
                                                                    state = r50 and (35) or (36)
                                                                end
                                                            else
                                                                if state == 35 then
                                                                    r31 = {
                                                                        r35(r86, r11)
                                                                    }
                                                                    r29 = r31[2]
                                                                    r50 = r31[1]
                                                                    r26 = nil
                                                                    r31 = r50 == r26
                                                                    state = r31 and (37) or (38)
                                                                end
                                                            end
                                                        end
                                                    else
                                                        if state <= 38 then
                                                            if state <= 37 then
                                                                if state <= 36 then
                                                                    if state == 36 then
                                                                        r95 = "3^\166z\006\227m<\215.\196"
                                                                        r29 = upvalueValues[r34]
                                                                        r28 = upvalueValues[r12]
                                                                        r71 = upvalueValues[r61]
                                                                        r55 = "\247\004<\002\168\195\164\025\158n\199"
                                                                        r63 = 14605865360017
                                                                        r20 = r71(r55, r63)
                                                                        r26 = r28[r20]
                                                                        r50 = r29[r26]
                                                                        r26 = createClosure3(88, {
                                                                            r24,
                                                                            r23
                                                                        })
                                                                        r29 = "Connect"
                                                                        r29 = r50[r29]
                                                                        r29 = r29(r50, r26)
                                                                        r29 = upvalueValues[r34]
                                                                        r28 = upvalueValues[r12]
                                                                        r71 = upvalueValues[r61]
                                                                        r63 = 7873261112914
                                                                        r55 = "\239\016SZ\008|\026\143\145Y\159\019\128\169"
                                                                        r20 = r71(r55, r63)
                                                                        r26 = r28[r20]
                                                                        r50 = r29[r26]
                                                                        r26 = createClosure5(91, {
                                                                            r81
                                                                        })
                                                                        r29 = "Connect"
                                                                        r29 = r50[r29]
                                                                        r29 = r29(r50, r26)
                                                                        r26 = createClosure4(92, {
                                                                            r58,
                                                                            r12,
                                                                            r61
                                                                        })
                                                                        r29 = createClosure2(93, {
                                                                            r58,
                                                                            r12,
                                                                            r61,
                                                                            r24,
                                                                            r92
                                                                        })
                                                                        r50 = allocUpvalue()
                                                                        upvalueValues[r50] = r29
                                                                        r29 = allocUpvalue()
                                                                        upvalueValues[r29] = r26
                                                                        r26 = allocUpvalue()
                                                                        r71 = createClosure5(98, {
                                                                            r12,
                                                                            r61,
                                                                            r58,
                                                                            r34,
                                                                            r24,
                                                                            r81,
                                                                            r50,
                                                                            r29,
                                                                            r26
                                                                        })
                                                                        r28 = createClosure2(124, {
                                                                            r58,
                                                                            r12,
                                                                            r61,
                                                                            r53
                                                                        })
                                                                        upvalueValues[r26] = r28
                                                                        r28 = allocUpvalue()
                                                                        upvalueValues[r28] = r71
                                                                        r20 = upvalueValues[r58]
                                                                        r63 = upvalueValues[r12]
                                                                        r80 = upvalueValues[r61]
                                                                        r57 = "\194\254l\250\254\223\170Q\252\162"
                                                                        r44 = 818196398461
                                                                        r51 = r80(r57, r44)
                                                                        r55 = r63[r51]
                                                                        r71 = r20[r55]
                                                                        r20 = allocUpvalue()
                                                                        upvalueValues[r20] = r71
                                                                        r55 = upvalueValues[r58]
                                                                        r80 = upvalueValues[r12]
                                                                        r51 = upvalueValues[r61]
                                                                        r47 = 33818939391364
                                                                        r44 = "\216 \238\153Q}=aS\244\195]\020"
                                                                        r57 = r51(r44, r47)
                                                                        r63 = r80[r57]
                                                                        r71 = r55[r63]
                                                                        r55 = allocUpvalue()
                                                                        upvalueValues[r55] = r71
                                                                        r71 = allocUpvalue()
                                                                        r63 = createClosure4(127, {
                                                                            r58,
                                                                            r12,
                                                                            r61,
                                                                            r20,
                                                                            r55,
                                                                            r9,
                                                                            r28,
                                                                            r59
                                                                        })
                                                                        upvalueValues[r71] = r63
                                                                        r57 = createClosure0(128, {
                                                                            r46,
                                                                            r42,
                                                                            r10,
                                                                            r5
                                                                        })
                                                                        r63 = allocUpvalue()
                                                                        r80 = createClosure2(137, {
                                                                            r58,
                                                                            r12,
                                                                            r61,
                                                                            r20,
                                                                            r24,
                                                                            r9,
                                                                            r59
                                                                        })
                                                                        upvalueValues[r63] = r80
                                                                        r80 = allocUpvalue()
                                                                        r51 = createClosure4(144, {
                                                                            r46,
                                                                            r42,
                                                                            r16,
                                                                            r12,
                                                                            r61,
                                                                            r71,
                                                                            r63,
                                                                            r24,
                                                                            r10,
                                                                            r5
                                                                        })
                                                                        upvalueValues[r80] = r51
                                                                        r51 = allocUpvalue()
                                                                        upvalueValues[r51] = r57
                                                                        r44 = upvalueValues[r65]
                                                                        r7 = upvalueValues[r12]
                                                                        r20 = releaseUpvalue(r20)
                                                                        r83 = upvalueValues[r61]
                                                                        r93 = 18848894607945
                                                                        r25 = "\131\001\248>mE\027\232p\254\145K="
                                                                        r40 = r83(r25, r93)
                                                                        r47 = r7[r40]
                                                                        r57 = r44[r47]
                                                                        r44 = "Connect"
                                                                        r44 = r57[r44]
                                                                        r88 = "\161+x\146\184\195{\"$\253@\224\r\198"
                                                                        r97 = 26468444958757
                                                                        r69 = " \215\239\160\026\178"
                                                                        r60 = 14114557843884
                                                                        o4 = "\242\246\242"
                                                                        r74 = nil
                                                                        r47 = createClosure4(149, {
                                                                            r9,
                                                                            r59,
                                                                            r12,
                                                                            r61,
                                                                            r81,
                                                                            r26,
                                                                            r28,
                                                                            r58
                                                                        })
                                                                        r44 = r44(r57, r47)
                                                                        upvalueValues[r94] = r44
                                                                        r47 = createClosure4(170, {
                                                                            r19,
                                                                            r80,
                                                                            r12,
                                                                            r61
                                                                        })
                                                                        r57 = allocUpvalue()
                                                                        upvalueValues[r57] = r47
                                                                        r7 = createClosure2(171, {
                                                                            r63,
                                                                            r76,
                                                                            r51,
                                                                            r12,
                                                                            r61
                                                                        })
                                                                        r47 = allocUpvalue()
                                                                        upvalueValues[r47] = r7
                                                                        r40 = upvalueValues[r12]
                                                                        r25 = upvalueValues[r61]
                                                                        r93 = r25(r69, r60)
                                                                        r25 = allocUpvalue()
                                                                        r63 = releaseUpvalue(r63)
                                                                        r83 = r40[r93]
                                                                        r40 = createClosure2(172, {
                                                                            r57,
                                                                            r47
                                                                        })
                                                                        r7 = r15(r99, r83, r40)
                                                                        r40 = allocUpvalue()
                                                                        r83 = allocUpvalue()
                                                                        r7 = 250
                                                                        upvalueValues[r83] = r7
                                                                        r22 = createClosure10(176, {
                                                                            r12,
                                                                            r61
                                                                        })
                                                                        r18 = createClosure4(190, {
                                                                            r40,
                                                                            r12,
                                                                            r61
                                                                        })
                                                                        r7 = {}
                                                                        r93 = allocUpvalue()
                                                                        upvalueValues[r40] = r7
                                                                        r60 = createClosure3(206, {
                                                                            r58,
                                                                            r12,
                                                                            r61
                                                                        })
                                                                        r7 = nil
                                                                        upvalueValues[r25] = r7
                                                                        r69 = createClosure5(207, {
                                                                            r12,
                                                                            r61
                                                                        })
                                                                        r7 = nil
                                                                        upvalueValues[r93] = r7
                                                                        r7 = allocUpvalue()
                                                                        upvalueValues[r7] = r69
                                                                        r69 = allocUpvalue()
                                                                        upvalueValues[r69] = r60
                                                                        r60 = allocUpvalue()
                                                                        r92 = releaseUpvalue(r92)
                                                                        r79 = createClosure3(211, {
                                                                            r25,
                                                                            r93,
                                                                            r40,
                                                                            r12,
                                                                            r61
                                                                        })
                                                                        r96 = createClosure1(231, {
                                                                            r12,
                                                                            r61,
                                                                            r69
                                                                        })
                                                                        upvalueValues[r60] = r96
                                                                        r96 = allocUpvalue()
                                                                        upvalueValues[r96] = r22
                                                                        r22 = allocUpvalue()
                                                                        r30 = createClosure0(246, {
                                                                            r25,
                                                                            r65,
                                                                            r12,
                                                                            r61,
                                                                            r58,
                                                                            r34,
                                                                            r24,
                                                                            r83,
                                                                            r60,
                                                                            r40,
                                                                            r7,
                                                                            r96,
                                                                            r93,
                                                                            r22
                                                                        })
                                                                        upvalueValues[r22] = r18
                                                                        r18 = allocUpvalue()
                                                                        upvalueValues[r18] = r30
                                                                        r30 = allocUpvalue()
                                                                        upvalueValues[r30] = r79
                                                                        r93 = releaseUpvalue(r93)
                                                                        r43 = upvalueValues[r12]
                                                                        r87 = upvalueValues[r61]
                                                                        r52 = r87(r95, r97)
                                                                        r75 = r43[r52]
                                                                        r71 = releaseUpvalue(r71)
                                                                        r43 = createClosure3(251, {
                                                                            r18,
                                                                            r12,
                                                                            r61,
                                                                            r30
                                                                        })
                                                                        r79 = r15(r99, r75, r43)
                                                                        r33 = "#\004#l\137\202\206"
                                                                        o5 = 15397703539714
                                                                        r89 = 33857149173141
                                                                        o8 = "\004@+\250T\0008,bz"
                                                                        o2 = 31388460579096
                                                                        r48 = 2879138448700
                                                                        r87 = "Color3"
                                                                        r75 = allocUpvalue()
                                                                        r79 = 250
                                                                        r35 = nil
                                                                        upvalueValues[r75] = r79
                                                                        r43 = _env[r87]
                                                                        r80 = releaseUpvalue(r80)
                                                                        r52 = upvalueValues[r12]
                                                                        r95 = upvalueValues[r61]
                                                                        r97 = r95(r33, r48)
                                                                        r87 = r52[r97]
                                                                        r79 = r43[r87]
                                                                        r10 = releaseUpvalue(r10)
                                                                        r95 = 255
                                                                        r87 = 255
                                                                        r52 = 255
                                                                        r43 = r79(r87, r52, r95)
                                                                        r79 = allocUpvalue()
                                                                        upvalueValues[r79] = r43
                                                                        o10 = 25014193892736
                                                                        o1 = "\212F\204+\007\183\\8\144\222/aZ\189"
                                                                        r87 = allocUpvalue()
                                                                        r43 = 2
                                                                        upvalueValues[r87] = r43
                                                                        r52 = allocUpvalue()
                                                                        r43 = {}
                                                                        r95 = allocUpvalue()
                                                                        upvalueValues[r52] = r43
                                                                        r54 = nil
                                                                        r64 = createClosure5(255, {
                                                                            r95,
                                                                            r52,
                                                                            r12,
                                                                            r61
                                                                        })
                                                                        r43 = nil
                                                                        upvalueValues[r95] = r43
                                                                        r97 = createClosure4(265, {
                                                                            r12,
                                                                            r61,
                                                                            r79,
                                                                            r87
                                                                        })
                                                                        r33 = createClosure2(266, {
                                                                            r52,
                                                                            r12,
                                                                            r61
                                                                        })
                                                                        r43 = allocUpvalue()
                                                                        r48 = createClosure1(269, {
                                                                            r95,
                                                                            r65,
                                                                            r12,
                                                                            r61,
                                                                            r24,
                                                                            r58,
                                                                            r34,
                                                                            r75,
                                                                            r52,
                                                                            r43
                                                                        })
                                                                        upvalueValues[r43] = r97
                                                                        r97 = allocUpvalue()
                                                                        r98 = releaseUpvalue(r98)
                                                                        r96 = releaseUpvalue(r96)
                                                                        upvalueValues[r97] = r33
                                                                        r33 = allocUpvalue()
                                                                        upvalueValues[r33] = r48
                                                                        r48 = allocUpvalue()
                                                                        r28 = releaseUpvalue(r28)
                                                                        upvalueValues[r48] = r64
                                                                        r72 = upvalueValues[r34]
                                                                        r85 = upvalueValues[r12]
                                                                        r45 = upvalueValues[r61]
                                                                        r82 = r45(r88, r89)
                                                                        r21 = r85[r82]
                                                                        r64 = r72[r21]
                                                                        r81 = releaseUpvalue(r81)
                                                                        r21 = createClosure3(272, {
                                                                            r97
                                                                        })
                                                                        r72 = "Connect"
                                                                        r72 = r64[r72]
                                                                        r72 = r72(r64, r21)
                                                                        r21 = upvalueValues[r12]
                                                                        r85 = upvalueValues[r61]
                                                                        r82 = "\251\196\159\232\215\153\027\002"
                                                                        r88 = 34848635305827
                                                                        r45 = r85(r82, r88)
                                                                        r72 = r21[r45]
                                                                        r21 = createClosure1(273, {
                                                                            r33,
                                                                            r12,
                                                                            r61,
                                                                            r48
                                                                        })
                                                                        r85 = allocUpvalue()
                                                                        r64 = r15(r99, r72, r21)
                                                                        r64 = 250
                                                                        r72 = allocUpvalue()
                                                                        r56 = nil
                                                                        r45 = createClosure3(277, {
                                                                            r12,
                                                                            r61
                                                                        })
                                                                        upvalueValues[r72] = r64
                                                                        r64 = {}
                                                                        r21 = allocUpvalue()
                                                                        upvalueValues[r21] = r64
                                                                        r89 = createClosure2(278, {
                                                                            r85,
                                                                            r21,
                                                                            r12,
                                                                            r61
                                                                        })
                                                                        r82 = createClosure6(288, {
                                                                            r21,
                                                                            r12,
                                                                            r61
                                                                        })
                                                                        r64 = nil
                                                                        upvalueValues[r85] = r64
                                                                        r64 = allocUpvalue()
                                                                        upvalueValues[r64] = r45
                                                                        r45 = allocUpvalue()
                                                                        upvalueValues[r45] = r82
                                                                        r88 = createClosure0(299, {
                                                                            r85,
                                                                            r65,
                                                                            r12,
                                                                            r61,
                                                                            r58,
                                                                            r34,
                                                                            r24,
                                                                            r72,
                                                                            r21,
                                                                            r64,
                                                                            r60
                                                                        })
                                                                        r82 = allocUpvalue()
                                                                        upvalueValues[r82] = r88
                                                                        r88 = allocUpvalue()
                                                                        upvalueValues[r88] = r89
                                                                        r17 = upvalueValues[r34]
                                                                        r1 = releaseUpvalue(r1)
                                                                        r3 = upvalueValues[r12]
                                                                        r78 = upvalueValues[r61]
                                                                        r49 = r78(o1, o2)
                                                                        r77 = r3[r49]
                                                                        r89 = r17[r77]
                                                                        r17 = "Connect"
                                                                        r17 = r89[r17]
                                                                        r77 = createClosure4(302, {
                                                                            r45
                                                                        })
                                                                        r17 = r17(r89, r77)
                                                                        r77 = upvalueValues[r12]
                                                                        r3 = upvalueValues[r61]
                                                                        r49 = "\176\21703\194\147d\030\219\180"
                                                                        o1 = 9654008844687
                                                                        r78 = r3(r49, o1)
                                                                        r17 = r77[r78]
                                                                        r77 = createClosure6(303, {
                                                                            r82,
                                                                            r12,
                                                                            r61,
                                                                            r88
                                                                        })
                                                                        r34 = releaseUpvalue(r34)
                                                                        r89 = r15(r99, r17, r77)
                                                                        r9 = releaseUpvalue(r9)
                                                                        r77 = "Instance"
                                                                        r17 = _env[r77]
                                                                        r3 = upvalueValues[r12]
                                                                        r78 = upvalueValues[r61]
                                                                        o2 = 19045091254948
                                                                        o1 = "\179p\202"
                                                                        r49 = r78(o1, o2)
                                                                        r77 = r3[r49]
                                                                        r89 = r17[r77]
                                                                        r3 = upvalueValues[r12]
                                                                        r78 = upvalueValues[r61]
                                                                        o1 = "\151\r\156\002\198\017\127;M\213"
                                                                        o2 = 24815366745379
                                                                        r49 = r78(o1, o2)
                                                                        r77 = r3[r49]
                                                                        r17 = r89(r77)
                                                                        r89 = allocUpvalue()
                                                                        upvalueValues[r89] = r17
                                                                        r17 = upvalueValues[r89]
                                                                        r53 = releaseUpvalue(r53)
                                                                        r3 = upvalueValues[r12]
                                                                        r78 = upvalueValues[r61]
                                                                        o1 = "?_\138\240"
                                                                        o2 = 10384212775651
                                                                        r49 = r78(o1, o2)
                                                                        r77 = r3[r49]
                                                                        r49 = "UDim2"
                                                                        r78 = _env[r49]
                                                                        o1 = upvalueValues[r12]
                                                                        o2 = upvalueValues[r61]
                                                                        o3 = o2(o4, o5)
                                                                        r49 = o1[o3]
                                                                        r3 = r78[r49]
                                                                        o1 = 180
                                                                        o3 = 35
                                                                        r49 = 0
                                                                        o2 = 0
                                                                        r78 = r3(r49, o1, o2, o3)
                                                                        r17[r77] = r78
                                                                        r17 = upvalueValues[r89]
                                                                        r3 = upvalueValues[r12]
                                                                        r75 = releaseUpvalue(r75)
                                                                        r78 = upvalueValues[r61]
                                                                        o2 = 5951932418771
                                                                        o1 = "\152\237\157Q\163E\220\190"
                                                                        r49 = r78(o1, o2)
                                                                        r77 = r3[r49]
                                                                        o9 = 20432505365802
                                                                        o6 = 20900959643140
                                                                        r49 = "UDim2"
                                                                        r78 = _env[r49]
                                                                        o1 = upvalueValues[r12]
                                                                        o2 = upvalueValues[r61]
                                                                        o5 = 5606325193266
                                                                        o4 = "Z\187\204"
                                                                        o3 = o2(o4, o5)
                                                                        r49 = o1[o3]
                                                                        o1 = -190
                                                                        o3 = -45
                                                                        r3 = r78[r49]
                                                                        o2 = 1
                                                                        r49 = 1
                                                                        r78 = r3(r49, o1, o2, o3)
                                                                        o5 = 9300841550059
                                                                        r41 = nil
                                                                        r17[r77] = r78
                                                                        r17 = upvalueValues[r89]
                                                                        r3 = upvalueValues[r12]
                                                                        r30 = releaseUpvalue(r30)
                                                                        o1 = "\163\253;\231\210\206\215Ui\200\245'=\218\027\222"
                                                                        o2 = 1459520176807
                                                                        r78 = upvalueValues[r61]
                                                                        r91 = nil
                                                                        r73 = releaseUpvalue(r73)
                                                                        r49 = r78(o1, o2)
                                                                        r77 = r3[r49]
                                                                        r49 = "Color3"
                                                                        r78 = _env[r49]
                                                                        o1 = upvalueValues[r12]
                                                                        o2 = upvalueValues[r61]
                                                                        o4 = "\140?\015\193F\1514"
                                                                        o3 = o2(o4, o5)
                                                                        r49 = o1[o3]
                                                                        r3 = r78[r49]
                                                                        o1 = 31
                                                                        o2 = 31
                                                                        r49 = 31
                                                                        r78 = r3(r49, o1, o2)
                                                                        r17[r77] = r78
                                                                        r17 = upvalueValues[r89]
                                                                        o4 = "a\228B"
                                                                        o3 = 5383337232842
                                                                        r11 = nil
                                                                        r3 = upvalueValues[r12]
                                                                        r78 = upvalueValues[r61]
                                                                        o1 = "\221\235\150\016\208\146.O\212di\148\154\024\247"
                                                                        o2 = 14373461547557
                                                                        r49 = r78(o1, o2)
                                                                        r77 = r3[r49]
                                                                        r3 = 0
                                                                        r17[r77] = r3
                                                                        r17 = upvalueValues[r89]
                                                                        r3 = upvalueValues[r12]
                                                                        r78 = upvalueValues[r61]
                                                                        o1 = "\141\193x\212"
                                                                        o2 = 13789667055893
                                                                        r49 = r78(o1, o2)
                                                                        r77 = r3[r49]
                                                                        r78 = upvalueValues[r12]
                                                                        r49 = upvalueValues[r61]
                                                                        o2 = ""
                                                                        o1 = r49(o2, o3)
                                                                        r94 = releaseUpvalue(r94)
                                                                        r3 = r78[o1]
                                                                        r17[r77] = r3
                                                                        r17 = upvalueValues[r89]
                                                                        r3 = upvalueValues[r12]
                                                                        r78 = upvalueValues[r61]
                                                                        o1 = "q\197\196S\220d"
                                                                        o2 = 29278881953090
                                                                        r49 = r78(o1, o2)
                                                                        r77 = r3[r49]
                                                                        r3 = upvalueValues[r66]
                                                                        r17[r77] = r3
                                                                        r3 = "Instance"
                                                                        r77 = _env[r3]
                                                                        r78 = upvalueValues[r12]
                                                                        r49 = upvalueValues[r61]
                                                                        o2 = "\219#\172"
                                                                        o3 = 33434502823121
                                                                        o1 = r49(o2, o3)
                                                                        r3 = r78[o1]
                                                                        r17 = r77[r3]
                                                                        r78 = upvalueValues[r12]
                                                                        r49 = upvalueValues[r61]
                                                                        o3 = 12106444330501
                                                                        o2 = "\0238][DU\1744"
                                                                        o1 = r49(o2, o3)
                                                                        r3 = r78[o1]
                                                                        r78 = upvalueValues[r89]
                                                                        r77 = r17(r3, r78)
                                                                        r8 = releaseUpvalue(r8)
                                                                        r3 = upvalueValues[r12]
                                                                        r58 = releaseUpvalue(r58)
                                                                        r52 = releaseUpvalue(r52)
                                                                        r78 = upvalueValues[r61]
                                                                        o2 = 3377554048548
                                                                        o1 = "o\248\230\217R\204\253\129]\131\199\238"
                                                                        r49 = r78(o1, o2)
                                                                        r17 = r3[r49]
                                                                        r49 = "UDim"
                                                                        r78 = _env[r49]
                                                                        o1 = upvalueValues[r12]
                                                                        o2 = upvalueValues[r61]
                                                                        o5 = 14757652912856
                                                                        o3 = o2(o4, o5)
                                                                        r49 = o1[o3]
                                                                        r3 = r78[r49]
                                                                        r79 = releaseUpvalue(r79)
                                                                        r76 = releaseUpvalue(r76)
                                                                        r49 = 0
                                                                        o1 = 6
                                                                        r78 = r3(r49, o1)
                                                                        r77[r17] = r78
                                                                        r3 = "Instance"
                                                                        r77 = _env[r3]
                                                                        r7 = releaseUpvalue(r7)
                                                                        r78 = upvalueValues[r12]
                                                                        r25 = releaseUpvalue(r25)
                                                                        r49 = upvalueValues[r61]
                                                                        o2 = "\235\213\218"
                                                                        o3 = 15678298217604
                                                                        o1 = r49(o2, o3)
                                                                        r23 = releaseUpvalue(r23)
                                                                        r3 = r78[o1]
                                                                        r22 = releaseUpvalue(r22)
                                                                        r17 = r77[r3]
                                                                        r78 = upvalueValues[r12]
                                                                        r49 = upvalueValues[r61]
                                                                        o2 = "Ce;\201a\154V\206\241\016"
                                                                        o3 = 11481673372898
                                                                        o1 = r49(o2, o3)
                                                                        r3 = r78[o1]
                                                                        r77 = r17(r3)
                                                                        r3 = upvalueValues[r12]
                                                                        r78 = upvalueValues[r61]
                                                                        o1 = "\220\027,."
                                                                        o2 = 4964428613895
                                                                        r49 = r78(o1, o2)
                                                                        r17 = r3[r49]
                                                                        r49 = "UDim2"
                                                                        r78 = _env[r49]
                                                                        o1 = upvalueValues[r12]
                                                                        r50 = releaseUpvalue(r50)
                                                                        o4 = "\193\138P"
                                                                        o5 = 8671655219142
                                                                        o7 = 25784728268518
                                                                        r99 = nil
                                                                        o2 = upvalueValues[r61]
                                                                        o3 = o2(o4, o5)
                                                                        r49 = o1[o3]
                                                                        r3 = r78[r49]
                                                                        r51 = releaseUpvalue(r51)
                                                                        r60 = releaseUpvalue(r60)
                                                                        o2 = 0
                                                                        o1 = 20
                                                                        o3 = 20
                                                                        r49 = 0
                                                                        r78 = r3(r49, o1, o2, o3)
                                                                        r77[r17] = r78
                                                                        r3 = upvalueValues[r12]
                                                                        r78 = upvalueValues[r61]
                                                                        r42 = releaseUpvalue(r42)
                                                                        o1 = "N\208\228\159\252\208\192\247"
                                                                        o2 = 33650768772405
                                                                        r49 = r78(o1, o2)
                                                                        r17 = r3[r49]
                                                                        r49 = "UDim2"
                                                                        r78 = _env[r49]
                                                                        r5 = releaseUpvalue(r5)
                                                                        r48 = releaseUpvalue(r48)
                                                                        r84 = releaseUpvalue(r84)
                                                                        o1 = upvalueValues[r12]
                                                                        o2 = upvalueValues[r61]
                                                                        o5 = 28574471615482
                                                                        o4 = "CB\160"
                                                                        o3 = o2(o4, o5)
                                                                        r49 = o1[o3]
                                                                        r3 = r78[r49]
                                                                        o3 = -12
                                                                        o2 = 0.5
                                                                        r49 = 0
                                                                        o1 = 5
                                                                        r78 = r3(r49, o1, o2, o3)
                                                                        r77[r17] = r78
                                                                        r29 = releaseUpvalue(r29)
                                                                        r3 = upvalueValues[r12]
                                                                        r78 = upvalueValues[r61]
                                                                        o2 = 28830274040945
                                                                        o1 = "\1353\212y\"\221\1344\148\2369\217\2024\1562@\197\018\128\141\156"
                                                                        r49 = r78(o1, o2)
                                                                        r17 = r3[r49]
                                                                        r3 = 1
                                                                        r77[r17] = r3
                                                                        r3 = upvalueValues[r12]
                                                                        r78 = upvalueValues[r61]
                                                                        o1 = "\246m\184VA"
                                                                        o2 = 15155012541329
                                                                        r49 = r78(o1, o2)
                                                                        r17 = r3[r49]
                                                                        r78 = upvalueValues[r12]
                                                                        r49 = upvalueValues[r61]
                                                                        o3 = 3227084342750
                                                                        o2 = "w\145\005\236;\127\211\158Ga\014[J\026\023\202`O\181\132l3\003\021aH%"
                                                                        o1 = r49(o2, o3)
                                                                        r3 = r78[o1]
                                                                        r77[r17] = r3
                                                                        r3 = upvalueValues[r12]
                                                                        r46 = releaseUpvalue(r46)
                                                                        r78 = upvalueValues[r61]
                                                                        o2 = 8009060241041
                                                                        o1 = "\133\018\029\145\0224"
                                                                        r49 = r78(o1, o2)
                                                                        r17 = r3[r49]
                                                                        r3 = upvalueValues[r89]
                                                                        r47 = releaseUpvalue(r47)
                                                                        r72 = releaseUpvalue(r72)
                                                                        r77[r17] = r3
                                                                        r78 = "Instance"
                                                                        r3 = _env[r78]
                                                                        r49 = upvalueValues[r12]
                                                                        o1 = upvalueValues[r61]
                                                                        o4 = 24957655526757
                                                                        o3 = "\031\215\255"
                                                                        o2 = o1(o3, o4)
                                                                        r78 = r49[o2]
                                                                        r17 = r3[r78]
                                                                        r64 = releaseUpvalue(r64)
                                                                        r49 = upvalueValues[r12]
                                                                        r45 = releaseUpvalue(r45)
                                                                        o1 = upvalueValues[r61]
                                                                        o4 = 34615544921847
                                                                        o3 = "zL\135\174Q\012\193\145\012"
                                                                        o2 = o1(o3, o4)
                                                                        r78 = r49[o2]
                                                                        r3 = r17(r78)
                                                                        r87 = releaseUpvalue(r87)
                                                                        r78 = upvalueValues[r12]
                                                                        r49 = upvalueValues[r61]
                                                                        o2 = "\128\217\254\244"
                                                                        o3 = 17663069085729
                                                                        o1 = r49(o2, o3)
                                                                        r17 = r78[o1]
                                                                        o1 = "UDim2"
                                                                        r49 = _env[o1]
                                                                        r88 = releaseUpvalue(r88)
                                                                        r19 = releaseUpvalue(r19)
                                                                        o2 = upvalueValues[r12]
                                                                        o3 = upvalueValues[r61]
                                                                        o5 = "\020\031%"
                                                                        o4 = o3(o5, o6)
                                                                        o1 = o2[o4]
                                                                        o2 = -35
                                                                        r78 = r49[o1]
                                                                        o3 = 1
                                                                        o4 = 0
                                                                        o1 = 1
                                                                        r49 = r78(o1, o2, o3, o4)
                                                                        r3[r17] = r49
                                                                        r78 = upvalueValues[r12]
                                                                        r49 = upvalueValues[r61]
                                                                        o2 = "\13296E\015L\131:"
                                                                        o3 = 32202020092563
                                                                        o1 = r49(o2, o3)
                                                                        r17 = r78[o1]
                                                                        o1 = "UDim2"
                                                                        r49 = _env[o1]
                                                                        o2 = upvalueValues[r12]
                                                                        o3 = upvalueValues[r61]
                                                                        r85 = releaseUpvalue(r85)
                                                                        o6 = 1523788235461
                                                                        o5 = "\019Qz"
                                                                        o4 = o3(o5, o6)
                                                                        o1 = o2[o4]
                                                                        r68 = releaseUpvalue(r68)
                                                                        r78 = r49[o1]
                                                                        o2 = 45
                                                                        o4 = 0
                                                                        o3 = 0
                                                                        o1 = 0
                                                                        r49 = r78(o1, o2, o3, o4)
                                                                        r3[r17] = r49
                                                                        o4 = 16921491775175
                                                                        o5 = "G\019\130\n#\016h"
                                                                        o2 = "\160\160m\145\13643`L\242\145\188Q\158MR\016\006\129\218K\162"
                                                                        r77 = nil
                                                                        r78 = upvalueValues[r12]
                                                                        r49 = upvalueValues[r61]
                                                                        o3 = 10531954283304
                                                                        o1 = r49(o2, o3)
                                                                        r17 = r78[o1]
                                                                        o6 = 13008185972649
                                                                        r78 = 1
                                                                        o3 = 7401860762998
                                                                        r86 = nil
                                                                        r3[r17] = r78
                                                                        r78 = upvalueValues[r12]
                                                                        r49 = upvalueValues[r61]
                                                                        o2 = "I\028\207\154"
                                                                        o1 = r49(o2, o3)
                                                                        r17 = r78[o1]
                                                                        r49 = upvalueValues[r12]
                                                                        o1 = upvalueValues[r61]
                                                                        o3 = "\222\189\213\164\253\022\r\143&l+\203"
                                                                        o2 = o1(o3, o4)
                                                                        r78 = r49[o2]
                                                                        r3[r17] = r78
                                                                        o2 = "IB5\206\251'~(r{"
                                                                        r13 = nil
                                                                        r78 = upvalueValues[r12]
                                                                        r49 = upvalueValues[r61]
                                                                        o3 = 16483886718459
                                                                        o1 = r49(o2, o3)
                                                                        r17 = r78[o1]
                                                                        o1 = "Color3"
                                                                        r49 = _env[o1]
                                                                        o2 = upvalueValues[r12]
                                                                        o3 = upvalueValues[r61]
                                                                        o4 = o3(o5, o6)
                                                                        o1 = o2[o4]
                                                                        r78 = r49[o1]
                                                                        o3 = 255
                                                                        o2 = 255
                                                                        o1 = 255
                                                                        r49 = r78(o1, o2, o3)
                                                                        r3[r17] = r49
                                                                        r78 = upvalueValues[r12]
                                                                        r49 = upvalueValues[r61]
                                                                        o3 = 18381011951983
                                                                        o2 = "\027\219\192\196"
                                                                        o1 = r49(o2, o3)
                                                                        r17 = r78[o1]
                                                                        o2 = "Enum"
                                                                        o1 = _env[o2]
                                                                        o3 = upvalueValues[r12]
                                                                        o4 = upvalueValues[r61]
                                                                        o6 = "\134\154\250'"
                                                                        o5 = o4(o6, o7)
                                                                        o2 = o3[o5]
                                                                        r82 = releaseUpvalue(r82)
                                                                        ReturnVal = {}
                                                                        r49 = o1[o2]
                                                                        r95 = releaseUpvalue(r95)
                                                                        r55 = releaseUpvalue(r55)
                                                                        r83 = releaseUpvalue(r83)
                                                                        r21 = releaseUpvalue(r21)
                                                                        o2 = upvalueValues[r12]
                                                                        o3 = upvalueValues[r61]
                                                                        o6 = 27381647520206
                                                                        o5 = "\018\004\205~\166\004\156\158,A\"x\129\204"
                                                                        o4 = o3(o5, o6)
                                                                        o1 = o2[o4]
                                                                        r78 = r49[o1]
                                                                        r3[r17] = r78
                                                                        r78 = upvalueValues[r12]
                                                                        r49 = upvalueValues[r61]
                                                                        o3 = 32170679024260
                                                                        o2 = "\007a\015\222\000\019\127\t"
                                                                        o1 = r49(o2, o3)
                                                                        r17 = r78[o1]
                                                                        r78 = 20
                                                                        r3[r17] = r78
                                                                        r78 = upvalueValues[r12]
                                                                        r2 = releaseUpvalue(r2)
                                                                        r49 = upvalueValues[r61]
                                                                        o3 = 31168065501361
                                                                        o2 = "\011\226@\212\253&\203k{\022f\177\202\166"
                                                                        o1 = r49(o2, o3)
                                                                        r17 = r78[o1]
                                                                        o2 = "Enum"
                                                                        o1 = _env[o2]
                                                                        o3 = upvalueValues[r12]
                                                                        o4 = upvalueValues[r61]
                                                                        o7 = 21476157368080
                                                                        o6 = "l\195l\157\200\017B\189G\147C\250\030\214"
                                                                        o5 = o4(o6, o7)
                                                                        o2 = o3[o5]
                                                                        r49 = o1[o2]
                                                                        o2 = upvalueValues[r12]
                                                                        o3 = upvalueValues[r61]
                                                                        o6 = 30420809742165
                                                                        o5 = "\185\191[y"
                                                                        o4 = o3(o5, o6)
                                                                        o1 = o2[o4]
                                                                        r78 = r49[o1]
                                                                        r3[r17] = r78
                                                                        r40 = releaseUpvalue(r40)
                                                                        r78 = upvalueValues[r12]
                                                                        r49 = upvalueValues[r61]
                                                                        o3 = 8090137743031
                                                                        o2 = "\198\206\236\196\134\132"
                                                                        o1 = r49(o2, o3)
                                                                        r17 = r78[o1]
                                                                        r78 = upvalueValues[r89]
                                                                        r3[r17] = r78
                                                                        r26 = releaseUpvalue(r26)
                                                                        r17 = upvalueValues[r89]
                                                                        r49 = upvalueValues[r12]
                                                                        o1 = upvalueValues[r61]
                                                                        o4 = 24853711416629
                                                                        o3 = "w\220{\205m\129\139"
                                                                        o2 = o1(o3, o4)
                                                                        r78 = r49[o2]
                                                                        r49 = false
                                                                        r17[r78] = r49
                                                                        r78 = upvalueValues[r89]
                                                                        o1 = upvalueValues[r12]
                                                                        o2 = upvalueValues[r61]
                                                                        o4 = "-\191\235pb\139:e51\146\152\006;\000\1638"
                                                                        o5 = 9994090549805
                                                                        o3 = o2(o4, o5)
                                                                        r49 = o1[o3]
                                                                        r17 = r78[r49]
                                                                        r49 = createClosure1(307, {
                                                                            r12,
                                                                            r61
                                                                        })
                                                                        r78 = "Connect"
                                                                        r78 = r17[r78]
                                                                        r78 = r78(r17, r49)
                                                                        o4 = "K\173@x\229O5\154\143\025\179\186\019E\246E\128"
                                                                        r62 = nil
                                                                        r78 = upvalueValues[r27]
                                                                        o1 = upvalueValues[r12]
                                                                        r70 = releaseUpvalue(r70)
                                                                        o2 = upvalueValues[r61]
                                                                        o5 = 34095053372932
                                                                        o3 = o2(o4, o5)
                                                                        r49 = o1[o3]
                                                                        r17 = r78[r49]
                                                                        r49 = createClosure1(311, {
                                                                            r66,
                                                                            r12,
                                                                            r61,
                                                                            r27,
                                                                            r89
                                                                        })
                                                                        r78 = "Connect"
                                                                        r78 = r17[r78]
                                                                        r33 = releaseUpvalue(r33)
                                                                        r78 = r78(r17, r49)
                                                                        r49 = upvalueValues[r12]
                                                                        o1 = upvalueValues[r61]
                                                                        o3 = "\146\195\020\180\186\220_\128I\235r\209S\130\149f-"
                                                                        o4 = 25446664990281
                                                                        o2 = o1(o3, o4)
                                                                        r78 = r49[o2]
                                                                        r57 = releaseUpvalue(r57)
                                                                        r49 = createClosure1(312, {
                                                                            r66,
                                                                            r12,
                                                                            r61,
                                                                            r27,
                                                                            r89
                                                                        })
                                                                        o1 = allocUpvalue()
                                                                        r17 = r67[r78]
                                                                        r43 = releaseUpvalue(r43)
                                                                        r78 = "Connect"
                                                                        r78 = r17[r78]
                                                                        r3 = nil
                                                                        r67 = nil
                                                                        r59 = releaseUpvalue(r59)
                                                                        r78 = r78(r17, r49)
                                                                        r78 = allocUpvalue()
                                                                        r49 = allocUpvalue()
                                                                        r65 = releaseUpvalue(r65)
                                                                        r17 = nil
                                                                        upvalueValues[r78] = r17
                                                                        r97 = releaseUpvalue(r97)
                                                                        r17 = nil
                                                                        upvalueValues[r49] = r17
                                                                        o2 = allocUpvalue()
                                                                        o3 = createClosure4(313, {
                                                                            r12,
                                                                            r61,
                                                                            o1,
                                                                            r66,
                                                                            o2
                                                                        })
                                                                        r17 = nil
                                                                        upvalueValues[o1] = r17
                                                                        r17 = nil
                                                                        upvalueValues[o2] = r17
                                                                        r17 = allocUpvalue()
                                                                        upvalueValues[r17] = o3
                                                                        o5 = upvalueValues[r12]
                                                                        o6 = upvalueValues[r61]
                                                                        o7 = o6(o8, o9)
                                                                        r18 = releaseUpvalue(r18)
                                                                        o4 = o5[o7]
                                                                        o5 = createClosure6(314, {
                                                                            r12,
                                                                            r61,
                                                                            r78,
                                                                            o1,
                                                                            r66,
                                                                            o2
                                                                        })
                                                                        r32 = releaseUpvalue(r32)
                                                                        r66 = releaseUpvalue(r66)
                                                                        r15 = nil
                                                                        o3 = r4[o4]
                                                                        o4 = "Connect"
                                                                        o4 = o3[o4]
                                                                        o4 = o4(o3, o5)
                                                                        o5 = upvalueValues[r12]
                                                                        o6 = upvalueValues[r61]
                                                                        o1 = releaseUpvalue(o1)
                                                                        r89 = releaseUpvalue(r89)
                                                                        o9 = 4178156816281
                                                                        o8 = "\219\141\195\248r( \245^8\rx"
                                                                        o7 = o6(o8, o9)
                                                                        o4 = o5[o7]
                                                                        o5 = createClosure4(319, {
                                                                            r12,
                                                                            r61,
                                                                            r49
                                                                        })
                                                                        o3 = r4[o4]
                                                                        o4 = "Connect"
                                                                        o4 = o3[o4]
                                                                        o4 = o4(o3, o5)
                                                                        o4 = upvalueValues[r16]
                                                                        o6 = upvalueValues[r12]
                                                                        o7 = upvalueValues[r61]
                                                                        r4 = nil
                                                                        o2 = releaseUpvalue(o2)
                                                                        o9 = "\t\1771\025R\247\0087*\014\169\157"
                                                                        o8 = o7(o9, o10)
                                                                        r69 = releaseUpvalue(r69)
                                                                        o5 = o6[o8]
                                                                        o3 = o4[o5]
                                                                        r16 = releaseUpvalue(r16)
                                                                        r27 = releaseUpvalue(r27)
                                                                        r24 = releaseUpvalue(r24)
                                                                        o5 = createClosure6(324, {
                                                                            r49,
                                                                            r78,
                                                                            r17
                                                                        })
                                                                        r12 = releaseUpvalue(r12)
                                                                        r17 = releaseUpvalue(r17)
                                                                        r61 = releaseUpvalue(r61)
                                                                        r49 = releaseUpvalue(r49)
                                                                        r78 = releaseUpvalue(r78)
                                                                        o4 = "Connect"
                                                                        o4 = o3[o4]
                                                                        o4 = o4(o3, o5)
                                                                        state = nil
                                                                    end
                                                                else
                                                                    if state == 37 then
                                                                        r29 = nil
                                                                        r50 = nil
                                                                        state = 36
                                                                    end
                                                                end
                                                            else
                                                                if state == 38 then
                                                                    r31 = r50
                                                                    r28 = upvalueValues[r24]
                                                                    r26 = r29 ~= r28
                                                                    state = r26 and (39) or (40)
                                                                    r11 = r31
                                                                end
                                                            end
                                                        else
                                                            if state <= 39 then
                                                                if state == 39 then
                                                                    r26 = upvalueValues[r23]
                                                                    r28 = r26(r29)
                                                                    state = 40
                                                                end
                                                            else
                                                                if state == 40 then
                                                                    r29 = nil
                                                                    r50 = nil
                                                                    state = 34
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            -- createClosure0 entry 9079595 -> 41, states 41-41
                                            if state == 41 then -- entry 9079595 -> 41
                                                ReturnVal = "error"
                                                state = _env[ReturnVal]
                                                r37 = "Tamper Detected!"
                                                ReturnVal = state(r37)
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    else
                                        -- createClosure0 entry 13937260 -> 42, states 42-42
                                        if state == 42 then -- entry 13937260 -> 42
                                            state = true
                                            upvalueValues[upvalues[1]] = state
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                else
                                    if state <= 55 then
                                        if state <= 43 then
                                            -- createClosure2 entry 4077037 -> 43, states 43-43
                                            if state == 43 then -- entry 4077037 -> 43
                                                r34 = 4223753
                                                r61 = "7Peo3beEn9Ex5Kq"
                                                r37 = r61 ^ r34
                                                ReturnVal = 2451731
                                                state = ReturnVal - r37
                                                r37 = state
                                                ReturnVal = "HZaV6"
                                                state = ReturnVal / r37
                                                ReturnVal = {
                                                    state
                                                }
                                                state = nil
                                            end
                                        else
                                            -- createClosure2 entry 15116944 -> 44, states 44-55
                                            if state <= 49 then
                                                if state <= 46 then
                                                    if state <= 45 then
                                                        if state <= 44 then
                                                            if state == 44 then -- entry 15116944 -> 44
                                                                r61 = upvalueValues[upvalues[1]]
                                                                r65 = 2
                                                                r12 = 1
                                                                r34 = r61(r12, r65)
                                                                r61 = 1
                                                                r37 = r34 == r61
                                                                state = r37 and (45) or (46)
                                                                ReturnVal = r37
                                                            end
                                                        else
                                                            if state == 45 then
                                                                state = ReturnVal and (47) or (48)
                                                            end
                                                        end
                                                    else
                                                        if state == 46 then
                                                            r61 = upvalueValues[upvalues[2]]
                                                            r34 = upvalueValues[upvalues[3]]
                                                            r37 = r61 == r34
                                                            ReturnVal = r37
                                                            state = 45
                                                        end
                                                    end
                                                else
                                                    if state <= 48 then
                                                        if state <= 47 then
                                                            if state == 47 then
                                                                r62 = createClosure1(329, {})
                                                                ReturnVal = "tonumber"
                                                                state = _env[ReturnVal]
                                                                r37 = upvalueValues[upvalues[4]]
                                                                r12 = "tostring"
                                                                r34 = _env[r12]
                                                                r56 = "pcall"
                                                                r16 = _env[r56]
                                                                r56 = {
                                                                    r16(r62)
                                                                }
                                                                r92 = {
                                                                    unpack(r56)
                                                                }
                                                                r16 = 2
                                                                r65 = r92[r16]
                                                                r12 = r34(r65)
                                                                r34 = ":(%d*):"
                                                                r61 = r37(r12, r34)
                                                                r37 = {
                                                                    r61()
                                                                }
                                                                ReturnVal = state(unpack(r37))
                                                                r37 = ReturnVal
                                                                r61 = upvalueValues[upvalues[5]]
                                                                state = r61 and (49) or (50)
                                                                ReturnVal = r61
                                                            end
                                                        else
                                                            if state == 48 then
                                                                state = upvalueValues[upvalues[7]]
                                                                state = state and (51) or (52)
                                                            end
                                                        end
                                                    else
                                                        if state == 49 then
                                                            r34 = upvalueValues[upvalues[6]]
                                                            r61 = r34 == r37
                                                            ReturnVal = r61
                                                            state = 50
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 52 then
                                                    if state <= 51 then
                                                        if state <= 50 then
                                                            if state == 50 then
                                                                r37 = nil
                                                                upvalueValues[upvalues[5]] = ReturnVal
                                                                state = 48
                                                            end
                                                        else
                                                            if state == 51 then
                                                                r37 = "error"
                                                                state = _env[r37]
                                                                r61 = upvalueValues[upvalues[8]]
                                                                r34 = 0
                                                                r37 = state(r61, r34)
                                                                state = 52
                                                            end
                                                        end
                                                    else
                                                        if state == 52 then
                                                            state = {}
                                                            r37 = state
                                                            r34 = upvalueValues[upvalues[9]]
                                                            r12 = r34
                                                            r34 = 1
                                                            r65 = r34
                                                            r34 = 0
                                                            r92 = r65 < r34
                                                            r61 = 1
                                                            r34 = r61 - r65
                                                            state = 53
                                                        end
                                                    end
                                                else
                                                    if state <= 54 then
                                                        if state <= 53 then
                                                            if state == 53 then
                                                                r34 = r34 + r65
                                                                r16 = not r92
                                                                r61 = r34 <= r12
                                                                r61 = r16 and r61
                                                                r16 = r34 >= r12
                                                                r16 = r92 and r16
                                                                r61 = r16 or r61
                                                                r16 = (54)
                                                                state = r61 and r16
                                                                r61 = (55)
                                                                state = state or r61
                                                            end
                                                        else
                                                            if state == 54 then
                                                                r61 = r34
                                                                state = upvalueValues[upvalues[1]]
                                                                r56 = 0
                                                                r62 = 255
                                                                r16 = state(r56, r62)
                                                                r37[r61] = r16
                                                                r61 = nil
                                                                state = 53
                                                            end
                                                        end
                                                    else
                                                        if state == 55 then
                                                            state = upvalueValues[upvalues[10]]
                                                            r61 = upvalueValues[upvalues[11]]
                                                            r37[state] = r61
                                                            state = upvalueValues[upvalues[12]]
                                                            r61 = {
                                                                state(r37)
                                                            }
                                                            ReturnVal = {
                                                                unpack(r61)
                                                            }
                                                            state = nil
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        -- createClosure5 entry 9396428 -> 56, states 56-59
                                        if state <= 57 then
                                            if state <= 56 then
                                                if state == 56 then -- entry 9396428 -> 56
                                                    state = 57
                                                end
                                            else
                                                if state == 57 then
                                                    state = true
                                                    state = state and (58) or (59)
                                                end
                                            end
                                        else
                                            if state <= 58 then
                                                if state == 58 then
                                                    ReturnVal = "l2"
                                                    state = _env[ReturnVal]
                                                    r37 = "l1"
                                                    ReturnVal = _env[r37]
                                                    r37 = "l1"
                                                    _env[r37] = state
                                                    r37 = "l2"
                                                    _env[r37] = ReturnVal
                                                    r37 = upvalueValues[upvalues[1]]
                                                    r61 = r37()
                                                    state = 57
                                                end
                                            else
                                                if state == 59 then
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 73 then
                                    if state <= 72 then
                                        if state <= 65 then
                                            -- createClosure4 entry 6862511 -> 60, states 60-65
                                            if state <= 62 then
                                                if state <= 61 then
                                                    if state <= 60 then
                                                        if state == 60 then -- entry 6862511 -> 60
                                                            r37 = upvalueValues[upvalues[1]]
                                                            ReturnVal = #r37
                                                            r37 = 0
                                                            state = ReturnVal == r37
                                                            state = state and (61) or (62)
                                                        end
                                                    else
                                                        if state == 61 then
                                                            r61 = upvalueValues[upvalues[2]]
                                                            r34 = 105
                                                            r37 = r61 * r34
                                                            r61 = 1876967506793
                                                            ReturnVal = r37 + r61
                                                            r37 = 35184372088832
                                                            state = ReturnVal % r37
                                                            upvalueValues[upvalues[2]] = state
                                                            r37 = upvalueValues[upvalues[3]]
                                                            r61 = 1
                                                            ReturnVal = r37 ~= r61
                                                            state = 63
                                                        end
                                                    end
                                                else
                                                    if state == 62 then
                                                        r34 = "table"
                                                        r61 = _env[r34]
                                                        r34 = "remove"
                                                        r37 = r61[r34]
                                                        r34 = upvalueValues[upvalues[1]]
                                                        r61 = {
                                                            r37(r34)
                                                        }
                                                        ReturnVal = {
                                                            unpack(r61)
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            else
                                                if state <= 64 then
                                                    if state <= 63 then
                                                        if state == 63 then
                                                            r61 = upvalueValues[upvalues[3]]
                                                            r34 = 210
                                                            r37 = r61 * r34
                                                            r61 = 257
                                                            ReturnVal = r37 % r61
                                                            upvalueValues[upvalues[3]] = ReturnVal
                                                            state = 64
                                                        end
                                                    else
                                                        if state == 64 then
                                                            r61 = upvalueValues[upvalues[3]]
                                                            r34 = 1
                                                            r37 = r61 ~= r34
                                                            state = r37 and (65) or (63)
                                                        end
                                                    end
                                                else
                                                    if state == 65 then
                                                        r34 = 32
                                                        r61 = upvalueValues[upvalues[3]]
                                                        r37 = r61 % r34
                                                        r62 = 2
                                                        r12 = upvalueValues[upvalues[4]]
                                                        r16 = upvalueValues[upvalues[2]]
                                                        r68 = upvalueValues[upvalues[3]]
                                                        r66 = r68 - r37
                                                        r68 = 32
                                                        r41 = r66 / r68
                                                        r27 = 13
                                                        r74 = r27 - r41
                                                        r56 = r62 ^ r74
                                                        r92 = r16 / r56
                                                        r65 = r12(r92)
                                                        r12 = 4294967296
                                                        r34 = r65 % r12
                                                        r65 = 2
                                                        r12 = r65 ^ r37
                                                        r61 = r34 / r12
                                                        r12 = upvalueValues[upvalues[4]]
                                                        r56 = 1
                                                        r16 = r61 % r56
                                                        r56 = 4294967296
                                                        r92 = r16 * r56
                                                        r65 = r12(r92)
                                                        r12 = upvalueValues[upvalues[4]]
                                                        r92 = r12(r61)
                                                        r34 = r65 + r92
                                                        r65 = 65536
                                                        r16 = 65536
                                                        r12 = r34 % r65
                                                        r92 = r34 - r12
                                                        r65 = r92 / r16
                                                        r16 = 256
                                                        r62 = 256
                                                        r92 = r12 % r16
                                                        r56 = r12 - r92
                                                        r16 = r56 / r62
                                                        r27 = 256
                                                        r34 = nil
                                                        r61 = nil
                                                        r12 = nil
                                                        r37 = nil
                                                        r62 = 256
                                                        r56 = r65 % r62
                                                        r74 = r65 - r56
                                                        r65 = nil
                                                        r62 = r74 / r27
                                                        r74 = {
                                                            r92,
                                                            r16,
                                                            r56,
                                                            r62
                                                        }
                                                        upvalueValues[upvalues[1]] = r74
                                                        r92 = nil
                                                        r62 = nil
                                                        r16 = nil
                                                        r56 = nil
                                                        state = 62
                                                    end
                                                end
                                            end
                                        else
                                            -- createClosure5 entry 1997593 -> 66, states 66-72
                                            if state <= 69 then
                                                if state <= 67 then
                                                    if state <= 66 then
                                                        if state == 66 then -- entry 1997593 -> 66
                                                            r37 = args[1]
                                                            state = upvalueValues[upvalues[1]]
                                                            r34 = state
                                                            r61 = args[2]
                                                            state = r34[r61]
                                                            state = state and (67) or (68)
                                                        end
                                                    else
                                                        if state == 67 then
                                                            state = 69
                                                        end
                                                    end
                                                else
                                                    if state <= 68 then
                                                        if state == 68 then
                                                            state = {}
                                                            upvalueValues[upvalues[2]] = state
                                                            ReturnVal = upvalueValues[upvalues[3]]
                                                            r12 = ReturnVal
                                                            r65 = 35184372088832
                                                            ReturnVal = r61 % r65
                                                            upvalueValues[upvalues[4]] = ReturnVal
                                                            r16 = 255
                                                            r92 = r61 % r16
                                                            r16 = 2
                                                            r65 = r92 + r16
                                                            upvalueValues[upvalues[5]] = r65
                                                            r56 = "string"
                                                            r16 = _env[r56]
                                                            r56 = "len"
                                                            r92 = r16[r56]
                                                            r16 = r92(r37)
                                                            r92 = ""
                                                            r34[r61] = r92
                                                            r74 = 1
                                                            r27 = r74
                                                            r74 = 0
                                                            r41 = r27 < r74
                                                            r56 = 1
                                                            r74 = r56 - r27
                                                            r62 = r16
                                                            r92 = 196
                                                            state = 70
                                                        end
                                                    else
                                                        if state == 69 then
                                                            ReturnVal = {
                                                                r61
                                                            }
                                                            state = nil
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 71 then
                                                    if state <= 70 then
                                                        if state == 70 then
                                                            r74 = r74 + r27
                                                            r56 = r74 <= r62
                                                            r66 = not r41
                                                            r56 = r66 and r56
                                                            r66 = r74 >= r62
                                                            r66 = r41 and r66
                                                            r56 = r66 or r56
                                                            r66 = (71)
                                                            state = r56 and r66
                                                            r56 = (72)
                                                            state = state or r56
                                                        end
                                                    else
                                                        if state == 71 then
                                                            r56 = r74
                                                            r90 = "string"
                                                            r39 = _env[r90]
                                                            r90 = "byte"
                                                            r6 = r39[r90]
                                                            r39 = r6(r37, r56)
                                                            r6 = upvalueValues[upvalues[6]]
                                                            r90 = r6()
                                                            r4 = r39 + r90
                                                            r68 = r4 + r92
                                                            r4 = 256
                                                            r66 = r68 % r4
                                                            r92 = r66
                                                            r4 = r34[r61]
                                                            r90 = 1
                                                            r56 = nil
                                                            r39 = r92 + r90
                                                            r6 = r12[r39]
                                                            r68 = r4 .. r6
                                                            r34[r61] = r68
                                                            state = 70
                                                        end
                                                    end
                                                else
                                                    if state == 72 then
                                                        r92 = nil
                                                        r12 = nil
                                                        r16 = nil
                                                        state = 69
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        -- createClosure1 entry 11270211 -> 73, states 73-73
                                        if state == 73 then -- entry 11270211 -> 73
                                            state = upvalueValues[upvalues[1]]
                                            r37 = upvalueValues[upvalues[2]]
                                            r61 = upvalueValues[upvalues[3]]
                                            r12 = "\2056\210\170\012\144\238\213(\012"
                                            r65 = 27478871224827
                                            r34 = r61(r12, r65)
                                            ReturnVal = r37[r34]
                                            r34 = "UDim2"
                                            r61 = _env[r34]
                                            r12 = upvalueValues[upvalues[2]]
                                            r65 = upvalueValues[upvalues[3]]
                                            r56 = 10816098571180
                                            r16 = "l\t~"
                                            r92 = r65(r16, r56)
                                            r34 = r12[r92]
                                            r37 = r61[r34]
                                            r62 = upvalueValues[upvalues[4]]
                                            r27 = upvalueValues[upvalues[2]]
                                            r41 = upvalueValues[upvalues[3]]
                                            r68 = "\164\208A\011\130\186\178\2139\248\128\1638c\250\200o[\211"
                                            r4 = 34794361012042
                                            r66 = r41(r68, r4)
                                            r74 = r27[r66]
                                            r56 = r62[r74]
                                            r74 = upvalueValues[upvalues[2]]
                                            r27 = upvalueValues[upvalues[3]]
                                            r68 = 9464001761591
                                            r66 = "\""
                                            r41 = r27(r66, r68)
                                            r62 = r74[r41]
                                            r16 = r56[r62]
                                            r56 = 10
                                            r92 = r16 + r56
                                            r65 = 0
                                            r12 = 0
                                            r34 = 0
                                            r61 = r37(r34, r12, r65, r92)
                                            state[ReturnVal] = r61
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                else
                                    if state <= 76 then
                                        -- createClosure7 entry 1246859 -> 74, states 74-76
                                        if state <= 75 then
                                            if state <= 74 then
                                                if state == 74 then -- entry 1246859 -> 74
                                                    r61 = args[2]
                                                    r37 = args[1]
                                                    r34 = allocUpvalue()
                                                    upvalueValues[r34] = args[3]
                                                    r12 = "Instance"
                                                    ReturnVal = _env[r12]
                                                    r65 = upvalueValues[upvalues[1]]
                                                    r92 = upvalueValues[upvalues[2]]
                                                    r56 = "\131e\222"
                                                    r62 = 29628541384164
                                                    r16 = r92(r56, r62)
                                                    r12 = r65[r16]
                                                    state = ReturnVal[r12]
                                                    r65 = upvalueValues[upvalues[1]]
                                                    r92 = upvalueValues[upvalues[2]]
                                                    r56 = "99\248\140\205"
                                                    r62 = 10084480143959
                                                    r16 = r92(r56, r62)
                                                    r12 = r65[r16]
                                                    ReturnVal = state(r12)
                                                    r12 = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    r65 = upvalueValues[upvalues[2]]
                                                    r56 = 8152806788820
                                                    r16 = "\026\022\185\165"
                                                    r92 = r65(r16, r56)
                                                    state = ReturnVal[r92]
                                                    r92 = "UDim2"
                                                    r65 = _env[r92]
                                                    r16 = upvalueValues[upvalues[1]]
                                                    r56 = upvalueValues[upvalues[2]]
                                                    r27 = 13950756313440
                                                    r74 = ",1\249"
                                                    r62 = r56(r74, r27)
                                                    r92 = r16[r62]
                                                    ReturnVal = r65[r92]
                                                    r16 = -10
                                                    r56 = 0
                                                    r92 = 1
                                                    r62 = 30
                                                    r65 = ReturnVal(r92, r16, r56, r62)
                                                    r12[state] = r65
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    r65 = upvalueValues[upvalues[2]]
                                                    r16 = "\003G\129\236W\226\199\n\170\137+/\2320\230\141E\232\193\221\152\210"
                                                    r56 = 15720039931032
                                                    r92 = r65(r16, r56)
                                                    state = ReturnVal[r92]
                                                    ReturnVal = 1
                                                    r12[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    r65 = upvalueValues[upvalues[2]]
                                                    r56 = 7108733848814
                                                    r16 = "i\131`R\138?"
                                                    r92 = r65(r16, r56)
                                                    state = ReturnVal[r92]
                                                    ReturnVal = r37
                                                    r12[state] = ReturnVal
                                                    r65 = "Instance"
                                                    ReturnVal = _env[r65]
                                                    r92 = upvalueValues[upvalues[1]]
                                                    r16 = upvalueValues[upvalues[2]]
                                                    r74 = 24922989456725
                                                    r62 = "{O6"
                                                    r56 = r16(r62, r74)
                                                    r65 = r92[r56]
                                                    state = ReturnVal[r65]
                                                    r92 = upvalueValues[upvalues[1]]
                                                    r16 = upvalueValues[upvalues[2]]
                                                    r62 = "\143\019\025\220t"
                                                    r74 = 3203937895891
                                                    r56 = r16(r62, r74)
                                                    r65 = r92[r56]
                                                    ReturnVal = state(r65)
                                                    r65 = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    r92 = upvalueValues[upvalues[2]]
                                                    r56 = "\000VU\135"
                                                    r62 = 14038029392264
                                                    r16 = r92(r56, r62)
                                                    state = ReturnVal[r16]
                                                    r16 = "UDim2"
                                                    r92 = _env[r16]
                                                    r56 = upvalueValues[upvalues[1]]
                                                    r62 = upvalueValues[upvalues[2]]
                                                    r41 = 21925506557921
                                                    r27 = ".}\248"
                                                    r74 = r62(r27, r41)
                                                    r16 = r56[r74]
                                                    ReturnVal = r92[r16]
                                                    r56 = 30
                                                    r74 = 30
                                                    r62 = 0
                                                    r16 = 0
                                                    r92 = ReturnVal(r16, r56, r62, r74)
                                                    r65[state] = r92
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    r92 = upvalueValues[upvalues[2]]
                                                    r56 = "\n\242\197\229^\n\188\140\018(^?[\238\014}"
                                                    r62 = 22484032252133
                                                    r16 = r92(r56, r62)
                                                    state = ReturnVal[r16]
                                                    r16 = "Color3"
                                                    r92 = _env[r16]
                                                    r56 = upvalueValues[upvalues[1]]
                                                    r62 = upvalueValues[upvalues[2]]
                                                    r41 = 28373844046748
                                                    r27 = "\244\"\172?\186\176\248"
                                                    r74 = r62(r27, r41)
                                                    r16 = r56[r74]
                                                    ReturnVal = r92[r16]
                                                    r62 = 31
                                                    r16 = 31
                                                    r56 = 31
                                                    r92 = ReturnVal(r16, r56, r62)
                                                    r65[state] = r92
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    r92 = upvalueValues[upvalues[2]]
                                                    r62 = 22584903035156
                                                    r56 = "\016C\016\250\154\129bs1\1984\190\134|\146"
                                                    r16 = r92(r56, r62)
                                                    state = ReturnVal[r16]
                                                    ReturnVal = 0
                                                    r65[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    r92 = upvalueValues[upvalues[2]]
                                                    r62 = 27913770087110
                                                    r56 = "1\133\246\221s\174"
                                                    r16 = r92(r56, r62)
                                                    state = ReturnVal[r16]
                                                    ReturnVal = r12
                                                    r65[state] = ReturnVal
                                                    r92 = "Instance"
                                                    ReturnVal = _env[r92]
                                                    r16 = upvalueValues[upvalues[1]]
                                                    r56 = upvalueValues[upvalues[2]]
                                                    r27 = 20636492948873
                                                    r74 = "\252jW"
                                                    r62 = r56(r74, r27)
                                                    r92 = r16[r62]
                                                    state = ReturnVal[r92]
                                                    r16 = upvalueValues[upvalues[1]]
                                                    r56 = upvalueValues[upvalues[2]]
                                                    r74 = "\251O&\234L\229\007\141"
                                                    r27 = 23130388163090
                                                    r62 = r56(r74, r27)
                                                    r92 = r16[r62]
                                                    ReturnVal = state(r92, r65)
                                                    r92 = upvalueValues[upvalues[1]]
                                                    r16 = upvalueValues[upvalues[2]]
                                                    r74 = 20866643371508
                                                    r62 = "\246\223\247\160M\247\146\136\237\189\197\021"
                                                    r56 = r16(r62, r74)
                                                    state = r92[r56]
                                                    r56 = "UDim"
                                                    r16 = _env[r56]
                                                    r62 = upvalueValues[upvalues[1]]
                                                    r74 = upvalueValues[upvalues[2]]
                                                    r66 = 29795914987058
                                                    r41 = "4\002\023"
                                                    r27 = r74(r41, r66)
                                                    r56 = r62[r27]
                                                    r92 = r16[r56]
                                                    r62 = 6
                                                    r56 = 0
                                                    r16 = r92(r56, r62)
                                                    ReturnVal[state] = r16
                                                    r92 = "Instance"
                                                    ReturnVal = _env[r92]
                                                    r16 = upvalueValues[upvalues[1]]
                                                    r56 = upvalueValues[upvalues[2]]
                                                    r74 = "\204+\179"
                                                    r27 = 18809165341238
                                                    r62 = r56(r74, r27)
                                                    r92 = r16[r62]
                                                    state = ReturnVal[r92]
                                                    r16 = upvalueValues[upvalues[1]]
                                                    r56 = upvalueValues[upvalues[2]]
                                                    r74 = "\155:PU\193\225\245\201\228\153"
                                                    r27 = 32746708220816
                                                    r62 = r56(r74, r27)
                                                    r92 = r16[r62]
                                                    ReturnVal = state(r92)
                                                    r92 = allocUpvalue()
                                                    upvalueValues[r92] = ReturnVal
                                                    state = upvalueValues[r92]
                                                    r16 = upvalueValues[upvalues[1]]
                                                    r56 = upvalueValues[upvalues[2]]
                                                    r27 = 34675314605842
                                                    r74 = "~\151r)"
                                                    r62 = r56(r74, r27)
                                                    ReturnVal = r16[r62]
                                                    r62 = "UDim2"
                                                    r56 = _env[r62]
                                                    r74 = upvalueValues[upvalues[1]]
                                                    r27 = upvalueValues[upvalues[2]]
                                                    r68 = 28609698608138
                                                    r66 = "H\204\160"
                                                    r41 = r27(r66, r68)
                                                    r62 = r74[r41]
                                                    r16 = r56[r62]
                                                    r41 = 22
                                                    r74 = 22
                                                    r27 = 0
                                                    r62 = 0
                                                    r56 = r16(r62, r74, r27, r41)
                                                    state[ReturnVal] = r56
                                                    state = upvalueValues[r92]
                                                    r16 = upvalueValues[upvalues[1]]
                                                    r56 = upvalueValues[upvalues[2]]
                                                    r27 = 23369905269378
                                                    r74 = "*:\152\157\214\2111s"
                                                    r62 = r56(r74, r27)
                                                    ReturnVal = r16[r62]
                                                    r62 = "UDim2"
                                                    r56 = _env[r62]
                                                    r74 = upvalueValues[upvalues[1]]
                                                    r27 = upvalueValues[upvalues[2]]
                                                    r66 = "\201\197\007"
                                                    r68 = 7982771359365
                                                    r41 = r27(r66, r68)
                                                    r62 = r74[r41]
                                                    r16 = r56[r62]
                                                    r27 = 0.5
                                                    r62 = 0.5
                                                    r74 = 0
                                                    r41 = 0
                                                    r56 = r16(r62, r74, r27, r41)
                                                    state[ReturnVal] = r56
                                                    state = upvalueValues[r92]
                                                    r16 = upvalueValues[upvalues[1]]
                                                    r56 = upvalueValues[upvalues[2]]
                                                    r27 = 29964381615745
                                                    r74 = "O\191\004O\166\216\131\134A\157\216"
                                                    r62 = r56(r74, r27)
                                                    ReturnVal = r16[r62]
                                                    r62 = "Vector2"
                                                    r56 = _env[r62]
                                                    r74 = upvalueValues[upvalues[1]]
                                                    r27 = upvalueValues[upvalues[2]]
                                                    r68 = 12436213044895
                                                    r66 = "\023\247\168"
                                                    r41 = r27(r66, r68)
                                                    r62 = r74[r41]
                                                    r16 = r56[r62]
                                                    r62 = 0.5
                                                    r74 = 0.5
                                                    r56 = r16(r62, r74)
                                                    state[ReturnVal] = r56
                                                    state = upvalueValues[r92]
                                                    r16 = upvalueValues[upvalues[1]]
                                                    r56 = upvalueValues[upvalues[2]]
                                                    r27 = 839708246407
                                                    r74 = "@\199G\154\139UZ\t\196\194B\234\243Ys\175o\205\240\152\184\178"
                                                    r62 = r56(r74, r27)
                                                    ReturnVal = r16[r62]
                                                    r16 = 1
                                                    state[ReturnVal] = r16
                                                    state = upvalueValues[r92]
                                                    r16 = upvalueValues[upvalues[1]]
                                                    r56 = upvalueValues[upvalues[2]]
                                                    r27 = 22258880751741
                                                    r74 = "\171\173\029\217/"
                                                    r62 = r56(r74, r27)
                                                    ReturnVal = r16[r62]
                                                    r56 = upvalueValues[upvalues[1]]
                                                    r62 = upvalueValues[upvalues[2]]
                                                    r41 = 23252311616075
                                                    r27 = "\141\162\249>9\173\158\r\134cr\201\213o\155\007\247\027?\193\152\1587\211D\241<"
                                                    r74 = r62(r27, r41)
                                                    r16 = r56[r74]
                                                    state[ReturnVal] = r16
                                                    state = upvalueValues[r92]
                                                    r16 = upvalueValues[upvalues[1]]
                                                    r56 = upvalueValues[upvalues[2]]
                                                    r74 = "\223\127/t\179Rh"
                                                    r27 = 449697153233
                                                    r62 = r56(r74, r27)
                                                    ReturnVal = r16[r62]
                                                    r16 = false
                                                    state[ReturnVal] = r16
                                                    state = upvalueValues[r92]
                                                    r16 = upvalueValues[upvalues[1]]
                                                    r56 = upvalueValues[upvalues[2]]
                                                    r74 = "\164\228Y_\179\017"
                                                    r27 = 31722882513332
                                                    r62 = r56(r74, r27)
                                                    ReturnVal = r16[r62]
                                                    r16 = r65
                                                    state[ReturnVal] = r16
                                                    r16 = "Instance"
                                                    ReturnVal = _env[r16]
                                                    r56 = upvalueValues[upvalues[1]]
                                                    r62 = upvalueValues[upvalues[2]]
                                                    r41 = 17696480895024
                                                    r27 = "\224H\017"
                                                    r74 = r62(r27, r41)
                                                    r16 = r56[r74]
                                                    state = ReturnVal[r16]
                                                    r56 = upvalueValues[upvalues[1]]
                                                    r62 = upvalueValues[upvalues[2]]
                                                    r27 = "\014Y\193\003\231\169\222\234\189m"
                                                    r41 = 10534177297193
                                                    r74 = r62(r27, r41)
                                                    r16 = r56[r74]
                                                    ReturnVal = state(r16)
                                                    r16 = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    r56 = upvalueValues[upvalues[2]]
                                                    r74 = "%g\173\208"
                                                    r27 = 4691317196936
                                                    r62 = r56(r74, r27)
                                                    state = ReturnVal[r62]
                                                    r62 = "UDim2"
                                                    r56 = _env[r62]
                                                    r74 = upvalueValues[upvalues[1]]
                                                    r27 = upvalueValues[upvalues[2]]
                                                    r66 = "\208\253\221"
                                                    r68 = 31647237208464
                                                    r41 = r27(r66, r68)
                                                    r62 = r74[r41]
                                                    ReturnVal = r56[r62]
                                                    r74 = 0
                                                    r27 = 1
                                                    r41 = 0
                                                    r62 = 1
                                                    r56 = ReturnVal(r62, r74, r27, r41)
                                                    r16[state] = r56
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    r56 = upvalueValues[upvalues[2]]
                                                    r74 = "\023\129\180\147x\143\213\001\253\197\228\219\205\250W\224\154\242%\231\149\241"
                                                    r27 = 26254217228225
                                                    r62 = r56(r74, r27)
                                                    state = ReturnVal[r62]
                                                    ReturnVal = 1
                                                    r16[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    r56 = upvalueValues[upvalues[2]]
                                                    r74 = "Z,\215s"
                                                    r27 = 11800051045750
                                                    r62 = r56(r74, r27)
                                                    state = ReturnVal[r62]
                                                    r56 = upvalueValues[upvalues[1]]
                                                    r62 = upvalueValues[upvalues[2]]
                                                    r41 = 21385854576358
                                                    r27 = ""
                                                    r74 = r62(r27, r41)
                                                    ReturnVal = r56[r74]
                                                    r16[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    r56 = upvalueValues[upvalues[2]]
                                                    r27 = 29458155140501
                                                    r74 = "\003\027\150-v\247"
                                                    r62 = r56(r74, r27)
                                                    state = ReturnVal[r62]
                                                    ReturnVal = r65
                                                    r16[state] = ReturnVal
                                                    r56 = "Instance"
                                                    ReturnVal = _env[r56]
                                                    r62 = upvalueValues[upvalues[1]]
                                                    r74 = upvalueValues[upvalues[2]]
                                                    r41 = "%\235\193"
                                                    r66 = 25838080438015
                                                    r27 = r74(r41, r66)
                                                    r56 = r62[r27]
                                                    state = ReturnVal[r56]
                                                    r62 = upvalueValues[upvalues[1]]
                                                    r74 = upvalueValues[upvalues[2]]
                                                    r41 = "C\212\240\130d\186&ei"
                                                    r66 = 8126989029064
                                                    r27 = r74(r41, r66)
                                                    r56 = r62[r27]
                                                    ReturnVal = state(r56)
                                                    r56 = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    r62 = upvalueValues[upvalues[2]]
                                                    r27 = "\203\246\162^"
                                                    r41 = 16757815287419
                                                    r74 = r62(r27, r41)
                                                    state = ReturnVal[r74]
                                                    r74 = "UDim2"
                                                    r62 = _env[r74]
                                                    r27 = upvalueValues[upvalues[1]]
                                                    r41 = upvalueValues[upvalues[2]]
                                                    r4 = 19027552379548
                                                    r68 = "\188U\181"
                                                    r66 = r41(r68, r4)
                                                    r74 = r27[r66]
                                                    ReturnVal = r62[r74]
                                                    r27 = -40
                                                    r74 = 1
                                                    r41 = 1
                                                    r66 = 0
                                                    r62 = ReturnVal(r74, r27, r41, r66)
                                                    r56[state] = r62
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    r62 = upvalueValues[upvalues[2]]
                                                    r41 = 30711892064221
                                                    r27 = "a\249\176F\138\214\251\005"
                                                    r74 = r62(r27, r41)
                                                    state = ReturnVal[r74]
                                                    r74 = "UDim2"
                                                    r62 = _env[r74]
                                                    r27 = upvalueValues[upvalues[1]]
                                                    r41 = upvalueValues[upvalues[2]]
                                                    r68 = "l\020\253"
                                                    r4 = 9487213269313
                                                    r66 = r41(r68, r4)
                                                    r74 = r27[r66]
                                                    ReturnVal = r62[r74]
                                                    r41 = 0
                                                    r27 = 40
                                                    r74 = 0
                                                    r66 = 0
                                                    r62 = ReturnVal(r74, r27, r41, r66)
                                                    r56[state] = r62
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    r62 = upvalueValues[upvalues[2]]
                                                    r27 = "z\161\2482E\014\217=\166d\171\198\231\023\n\144W\1951H\165\000"
                                                    r41 = 4479673223206
                                                    r74 = r62(r27, r41)
                                                    state = ReturnVal[r74]
                                                    ReturnVal = 1
                                                    r56[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    r62 = upvalueValues[upvalues[2]]
                                                    r41 = 18657908122096
                                                    r27 = "\161\179\132\015"
                                                    r74 = r62(r27, r41)
                                                    state = ReturnVal[r74]
                                                    r62 = state
                                                    state = r61 and (75) or (76)
                                                    ReturnVal = r61
                                                end
                                            else
                                                if state == 75 then
                                                    state = r62
                                                    r56[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    r62 = upvalueValues[upvalues[2]]
                                                    r41 = 34275588226648
                                                    r27 = "\249\179\217\"E\129\175\192&\189"
                                                    r74 = r62(r27, r41)
                                                    state = ReturnVal[r74]
                                                    r74 = "Color3"
                                                    r62 = _env[r74]
                                                    r27 = upvalueValues[upvalues[1]]
                                                    r41 = upvalueValues[upvalues[2]]
                                                    r68 = "\2163' \203E\237"
                                                    r4 = 2282701374502
                                                    r66 = r41(r68, r4)
                                                    r74 = r27[r66]
                                                    ReturnVal = r62[r74]
                                                    r27 = 255
                                                    r74 = 255
                                                    r41 = 255
                                                    r62 = ReturnVal(r74, r27, r41)
                                                    r56[state] = r62
                                                    r6 = 33766530727275
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    r62 = upvalueValues[upvalues[2]]
                                                    r27 = "\144!\tj"
                                                    r41 = 27916192772807
                                                    r74 = r62(r27, r41)
                                                    state = ReturnVal[r74]
                                                    r4 = "\229\175|\030"
                                                    r27 = "Enum"
                                                    r74 = _env[r27]
                                                    r41 = upvalueValues[upvalues[1]]
                                                    r66 = upvalueValues[upvalues[2]]
                                                    r37 = nil
                                                    r68 = r66(r4, r6)
                                                    r27 = r41[r68]
                                                    r62 = r74[r27]
                                                    r27 = upvalueValues[upvalues[1]]
                                                    r41 = upvalueValues[upvalues[2]]
                                                    r4 = 30892399982641
                                                    r68 = "\206'w\168ll\219\252a\207"
                                                    r66 = r41(r68, r4)
                                                    r74 = r27[r66]
                                                    ReturnVal = r62[r74]
                                                    r56[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    r62 = upvalueValues[upvalues[2]]
                                                    r41 = 16101725936969
                                                    r27 = "'WM\157\198\173Tu"
                                                    r74 = r62(r27, r41)
                                                    state = ReturnVal[r74]
                                                    ReturnVal = 20
                                                    r56[state] = ReturnVal
                                                    r6 = 25672409509554
                                                    r4 = "\146\190\169M4\161\132\203g\153\204Qx\005"
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    r62 = upvalueValues[upvalues[2]]
                                                    r41 = 6564929981425
                                                    r27 = "\252\168\227\254ox\198.\169D\024.V\206"
                                                    r74 = r62(r27, r41)
                                                    state = ReturnVal[r74]
                                                    r65 = nil
                                                    r27 = "Enum"
                                                    r74 = _env[r27]
                                                    r41 = upvalueValues[upvalues[1]]
                                                    r66 = upvalueValues[upvalues[2]]
                                                    r68 = r66(r4, r6)
                                                    r27 = r41[r68]
                                                    r62 = r74[r27]
                                                    r27 = upvalueValues[upvalues[1]]
                                                    r41 = upvalueValues[upvalues[2]]
                                                    r68 = "\165\152\t\031"
                                                    r4 = 28537938981865
                                                    r66 = r41(r68, r4)
                                                    r74 = r27[r66]
                                                    ReturnVal = r62[r74]
                                                    r56[state] = ReturnVal
                                                    r68 = 12746918156079
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    r62 = upvalueValues[upvalues[2]]
                                                    r41 = 7404638227832
                                                    r27 = "?\212\253\1871X"
                                                    r74 = r62(r27, r41)
                                                    r62 = allocUpvalue()
                                                    state = ReturnVal[r74]
                                                    r66 = "\011 \007L\012\184\229\149\170BK\240L\003u\155\185"
                                                    r61 = nil
                                                    ReturnVal = r12
                                                    r56[state] = ReturnVal
                                                    state = false
                                                    upvalueValues[r62] = state
                                                    r74 = upvalueValues[upvalues[1]]
                                                    r56 = nil
                                                    r27 = upvalueValues[upvalues[2]]
                                                    r41 = r27(r66, r68)
                                                    r12 = nil
                                                    ReturnVal = r74[r41]
                                                    state = r16[ReturnVal]
                                                    r74 = createClosure3(330, {
                                                        r62,
                                                        r92,
                                                        upvalues[1],
                                                        upvalues[2],
                                                        r34
                                                    })
                                                    r92 = releaseUpvalue(r92)
                                                    ReturnVal = "Connect"
                                                    ReturnVal = state[ReturnVal]
                                                    ReturnVal = ReturnVal(state, r74)
                                                    r62 = releaseUpvalue(r62)
                                                    r34 = releaseUpvalue(r34)
                                                    r16 = nil
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state == 76 then
                                                r27 = upvalueValues[upvalues[1]]
                                                r41 = upvalueValues[upvalues[2]]
                                                r4 = 30353856640822
                                                r68 = "\238\199\234\223\021\230"
                                                r66 = r41(r68, r4)
                                                r74 = r27[r66]
                                                ReturnVal = r74
                                                state = 75
                                            end
                                        end
                                    else
                                        -- createClosure0 entry 11599526 -> 77, states 77-79
                                        if state <= 78 then
                                            if state <= 77 then
                                                if state == 77 then -- entry 11599526 -> 77
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    state = not ReturnVal
                                                    state = state and (78) or (79)
                                                end
                                            else
                                                if state == 78 then
                                                    r37 = "Drawing"
                                                    ReturnVal = _env[r37]
                                                    r61 = upvalueValues[upvalues[2]]
                                                    r34 = upvalueValues[upvalues[3]]
                                                    r65 = "b\1737"
                                                    r92 = 34302359387749
                                                    r12 = r34(r65, r92)
                                                    r37 = r61[r12]
                                                    state = ReturnVal[r37]
                                                    r61 = upvalueValues[upvalues[2]]
                                                    r34 = upvalueValues[upvalues[3]]
                                                    r65 = "^X\025\178Ne"
                                                    r92 = 18388512694642
                                                    r12 = r34(r65, r92)
                                                    r37 = r61[r12]
                                                    ReturnVal = state(r37)
                                                    upvalueValues[upvalues[1]] = ReturnVal
                                                    state = upvalueValues[upvalues[1]]
                                                    r61 = upvalueValues[upvalues[2]]
                                                    r34 = upvalueValues[upvalues[3]]
                                                    r92 = 13976745761132
                                                    r65 = "\004\153\138wI?j\135\197"
                                                    r12 = r34(r65, r92)
                                                    r37 = r61[r12]
                                                    r61 = upvalueValues[upvalues[4]]
                                                    state[r37] = r61
                                                    state = upvalueValues[upvalues[1]]
                                                    r61 = upvalueValues[upvalues[2]]
                                                    r34 = upvalueValues[upvalues[3]]
                                                    r65 = "<\250\t\132j$~\245"
                                                    r92 = 30765224490998
                                                    r12 = r34(r65, r92)
                                                    r37 = r61[r12]
                                                    r61 = 110
                                                    state[r37] = r61
                                                    state = upvalueValues[upvalues[1]]
                                                    r61 = upvalueValues[upvalues[2]]
                                                    r34 = upvalueValues[upvalues[3]]
                                                    r92 = 9458357834036
                                                    r65 = "\221(\235\179\220\225"
                                                    r12 = r34(r65, r92)
                                                    r37 = r61[r12]
                                                    r61 = upvalueValues[upvalues[5]]
                                                    state[r37] = r61
                                                    state = upvalueValues[upvalues[1]]
                                                    r61 = upvalueValues[upvalues[2]]
                                                    r34 = upvalueValues[upvalues[3]]
                                                    r92 = 25776796806883
                                                    r65 = "\133\173/\200\146"
                                                    r12 = r34(r65, r92)
                                                    r37 = r61[r12]
                                                    r61 = upvalueValues[upvalues[6]]
                                                    state[r37] = r61
                                                    state = upvalueValues[upvalues[1]]
                                                    r61 = upvalueValues[upvalues[2]]
                                                    r34 = upvalueValues[upvalues[3]]
                                                    r65 = "\143\142W-\148\214"
                                                    r92 = 16966706962140
                                                    r12 = r34(r65, r92)
                                                    r37 = r61[r12]
                                                    r61 = upvalueValues[upvalues[7]]
                                                    state[r37] = r61
                                                    state = upvalueValues[upvalues[1]]
                                                    r61 = upvalueValues[upvalues[2]]
                                                    r34 = upvalueValues[upvalues[3]]
                                                    r65 = "\167FX\152\020\019\025"
                                                    r92 = 3732140869321
                                                    r12 = r34(r65, r92)
                                                    r37 = r61[r12]
                                                    r61 = true
                                                    state[r37] = r61
                                                    r37 = upvalueValues[upvalues[8]]
                                                    r34 = upvalueValues[upvalues[2]]
                                                    r12 = upvalueValues[upvalues[3]]
                                                    r16 = 16430505156067
                                                    r92 = "b\193\163\026\176\233pa\017\195\161\r\240"
                                                    r65 = r12(r92, r16)
                                                    r61 = r34[r65]
                                                    state = r37[r61]
                                                    r61 = createClosure5(333, {
                                                        upvalues[1],
                                                        upvalues[9],
                                                        upvalues[2],
                                                        upvalues[3]
                                                    })
                                                    r37 = "Connect"
                                                    r37 = state[r37]
                                                    r37 = r37(state, r61)
                                                    upvalueValues[upvalues[10]] = r37
                                                    state = 79
                                                end
                                            end
                                        else
                                            if state == 79 then
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            if state <= 92 then
                                if state <= 90 then
                                    if state <= 87 then
                                        if state <= 82 then
                                            -- createClosure1 entry 13228579 -> 80, states 80-82
                                            if state <= 81 then
                                                if state <= 80 then
                                                    if state == 80 then -- entry 13228579 -> 80
                                                        r61 = allocUpvalue()
                                                        r37 = allocUpvalue()
                                                        state = createClosure1(336, {
                                                            r37,
                                                            upvalues[1],
                                                            upvalues[2],
                                                            upvalues[3]
                                                        })
                                                        upvalueValues[r37] = args[1]
                                                        upvalueValues[r61] = state
                                                        ReturnVal = upvalueValues[r37]
                                                        r12 = upvalueValues[upvalues[1]]
                                                        r65 = upvalueValues[upvalues[2]]
                                                        r16 = "\\&f\182\023{\204\008\174j\248\170\025`"
                                                        r56 = 27333767442872
                                                        r92 = r65(r16, r56)
                                                        r34 = r12[r92]
                                                        state = ReturnVal[r34]
                                                        r34 = createClosure5(354, {
                                                            r37,
                                                            upvalues[1],
                                                            upvalues[2],
                                                            r61
                                                        })
                                                        ReturnVal = "Connect"
                                                        ReturnVal = state[ReturnVal]
                                                        ReturnVal = ReturnVal(state, r34)
                                                        ReturnVal = upvalueValues[r37]
                                                        r12 = upvalueValues[upvalues[1]]
                                                        r65 = upvalueValues[upvalues[2]]
                                                        r56 = 24250637036572
                                                        r16 = "\214\012\031\012\203%\188p\234"
                                                        r92 = r65(r16, r56)
                                                        r34 = r12[r92]
                                                        state = ReturnVal[r34]
                                                        state = state and (81) or (82)
                                                    end
                                                else
                                                    if state == 81 then
                                                        state = upvalueValues[r61]
                                                        ReturnVal = state()
                                                        state = 82
                                                    end
                                                end
                                            else
                                                if state == 82 then
                                                    r61 = releaseUpvalue(r61)
                                                    ReturnVal = {}
                                                    r37 = releaseUpvalue(r37)
                                                    state = nil
                                                end
                                            end
                                        else
                                            -- createClosure0 entry 15620707 -> 83, states 83-87
                                            if state <= 85 then
                                                if state <= 84 then
                                                    if state <= 83 then
                                                        if state == 83 then -- entry 15620707 -> 83
                                                            state = upvalueValues[upvalues[1]]
                                                            state = state and (84) or (85)
                                                        end
                                                    else
                                                        if state == 84 then
                                                            state = upvalueValues[upvalues[1]]
                                                            r37 = upvalueValues[upvalues[2]]
                                                            r61 = upvalueValues[upvalues[3]]
                                                            r65 = 4753358669989
                                                            r12 = "\130\154\239\176\172<\014"
                                                            r34 = r61(r12, r65)
                                                            ReturnVal = r37[r34]
                                                            r37 = false
                                                            state[ReturnVal] = r37
                                                            state = upvalueValues[upvalues[1]]
                                                            ReturnVal = "Remove"
                                                            ReturnVal = state[ReturnVal]
                                                            ReturnVal = ReturnVal(state)
                                                            state = nil
                                                            upvalueValues[upvalues[1]] = state
                                                            state = 85
                                                        end
                                                    end
                                                else
                                                    if state == 85 then
                                                        ReturnVal = upvalueValues[upvalues[4]]
                                                        state = ReturnVal and (86) or (87)
                                                    end
                                                end
                                            else
                                                if state <= 86 then
                                                    if state == 86 then
                                                        ReturnVal = upvalueValues[upvalues[4]]
                                                        r37 = "Disconnect"
                                                        r37 = ReturnVal[r37]
                                                        r37 = r37(ReturnVal)
                                                        ReturnVal = nil
                                                        r37 = "RenderStepedConn"
                                                        _env[r37] = ReturnVal
                                                        r37 = nil
                                                        upvalueValues[upvalues[4]] = r37
                                                        state = 87
                                                    end
                                                else
                                                    if state == 87 then
                                                        ReturnVal = {}
                                                        state = nil
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        -- createClosure3 entry 558157 -> 88, states 88-90
                                        if state <= 89 then
                                            if state <= 88 then
                                                if state == 88 then -- entry 558157 -> 88
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    r37 = args[1]
                                                    state = r37 ~= ReturnVal
                                                    state = state and (89) or (90)
                                                end
                                            else
                                                if state == 89 then
                                                    state = upvalueValues[upvalues[2]]
                                                    ReturnVal = state(r37)
                                                    state = 90
                                                end
                                            end
                                        else
                                            if state == 90 then
                                                r37 = nil
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    if state <= 91 then
                                        -- createClosure5 entry 4974612 -> 91, states 91-91
                                        if state == 91 then -- entry 4974612 -> 91
                                            r37 = args[1]
                                            state = upvalueValues[upvalues[1]]
                                            ReturnVal = nil
                                            state[r37] = ReturnVal
                                            r37 = nil
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    else
                                        -- createClosure4 entry 3290077 -> 92, states 92-92
                                        if state == 92 then -- entry 3290077 -> 92
                                            r37 = args[1]
                                            r61 = upvalueValues[upvalues[1]]
                                            r12 = upvalueValues[upvalues[2]]
                                            r65 = upvalueValues[upvalues[3]]
                                            r16 = "\144\180G\213\019\220"
                                            r56 = 30951360329804
                                            r92 = r65(r16, r56)
                                            r34 = r12[r92]
                                            ReturnVal = r61[r34]
                                            r34 = upvalueValues[upvalues[2]]
                                            r12 = upvalueValues[upvalues[3]]
                                            r16 = 743657701722
                                            r92 = "\251\173C\2154B'\252"
                                            r65 = r12(r92, r16)
                                            r61 = r34[r65]
                                            state = ReturnVal[r61]
                                            r61 = state
                                            r12 = upvalueValues[upvalues[1]]
                                            r92 = upvalueValues[upvalues[2]]
                                            r16 = upvalueValues[upvalues[3]]
                                            r62 = "\149d\139\176\228="
                                            r74 = 5448212990441
                                            r56 = r16(r62, r74)
                                            r65 = r92[r56]
                                            r34 = r12[r65]
                                            r65 = upvalueValues[upvalues[2]]
                                            r92 = upvalueValues[upvalues[3]]
                                            r62 = 35046112313279
                                            r56 = "\130\155\241\206\186;9\001\221\180"
                                            r16 = r92(r56, r62)
                                            r12 = r65[r16]
                                            ReturnVal = r34[r12]
                                            r65 = r37 - r61
                                            r16 = upvalueValues[upvalues[2]]
                                            r56 = upvalueValues[upvalues[3]]
                                            r27 = 25890311679768
                                            r74 = "\008S\174G"
                                            r62 = r56(r74, r27)
                                            r92 = r16[r62]
                                            r34 = "Dot"
                                            r34 = ReturnVal[r34]
                                            r12 = r65[r92]
                                            r34 = r34(ReturnVal, r12)
                                            ReturnVal = 0.3
                                            state = r34 > ReturnVal
                                            ReturnVal = {
                                                state
                                            }
                                            state = nil
                                        end
                                    end
                                end
                            else
                                if state <= 126 then
                                    if state <= 123 then
                                        if state <= 97 then
                                            -- createClosure2 entry 9649893 -> 93, states 93-97
                                            if state <= 95 then
                                                if state <= 94 then
                                                    if state <= 93 then
                                                        if state == 93 then -- entry 9649893 -> 93
                                                            r37 = args[1]
                                                            state = not r37
                                                            state = state and (94) or (95)
                                                        end
                                                    else
                                                        if state == 94 then
                                                            state = false
                                                            ReturnVal = {
                                                                state
                                                            }
                                                            state = nil
                                                        end
                                                    end
                                                else
                                                    if state == 95 then
                                                        r61 = upvalueValues[upvalues[1]]
                                                        r12 = upvalueValues[upvalues[2]]
                                                        r65 = upvalueValues[upvalues[3]]
                                                        r16 = "S\223\025\180\199d"
                                                        r56 = 7454777625999
                                                        r92 = r65(r16, r56)
                                                        r34 = r12[r92]
                                                        ReturnVal = r61[r34]
                                                        r34 = upvalueValues[upvalues[2]]
                                                        r12 = upvalueValues[upvalues[3]]
                                                        r16 = 28582611121149
                                                        r92 = "c~\218\226\250\232\199,"
                                                        r65 = r12(r92, r16)
                                                        r61 = r34[r65]
                                                        state = ReturnVal[r61]
                                                        r61 = state
                                                        r12 = upvalueValues[upvalues[2]]
                                                        r65 = upvalueValues[upvalues[3]]
                                                        r56 = 3454113515080
                                                        r16 = "\133q\015\189/\236\139\194"
                                                        r92 = r65(r16, r56)
                                                        r34 = r12[r92]
                                                        ReturnVal = r37[r34]
                                                        state = ReturnVal - r61
                                                        r34 = state
                                                        r12 = "RaycastParams"
                                                        ReturnVal = _env[r12]
                                                        r65 = upvalueValues[upvalues[2]]
                                                        r92 = upvalueValues[upvalues[3]]
                                                        r62 = 16913135460035
                                                        r56 = "\198\245\005"
                                                        r16 = r92(r56, r62)
                                                        r12 = r65[r16]
                                                        state = ReturnVal[r12]
                                                        ReturnVal = state()
                                                        r12 = ReturnVal
                                                        ReturnVal = upvalueValues[upvalues[2]]
                                                        r65 = upvalueValues[upvalues[3]]
                                                        r16 = "\005\255\204\182\016\168\182\020h\244"
                                                        r56 = 19175035839201
                                                        r92 = r65(r16, r56)
                                                        state = ReturnVal[r92]
                                                        r16 = "Enum"
                                                        r92 = _env[r16]
                                                        r56 = upvalueValues[upvalues[2]]
                                                        r62 = upvalueValues[upvalues[3]]
                                                        r41 = 20420820477221
                                                        r27 = "\143e\149V\254\tm\165y\179`\210/\154\191\179\220"
                                                        r74 = r62(r27, r41)
                                                        r16 = r56[r74]
                                                        r65 = r92[r16]
                                                        r16 = upvalueValues[upvalues[2]]
                                                        r56 = upvalueValues[upvalues[3]]
                                                        r74 = "\234\225\182P.\0020\160l"
                                                        r27 = 20645276329357
                                                        r62 = r56(r74, r27)
                                                        r92 = r16[r62]
                                                        ReturnVal = r65[r92]
                                                        r12[state] = ReturnVal
                                                        ReturnVal = upvalueValues[upvalues[2]]
                                                        r65 = upvalueValues[upvalues[3]]
                                                        r56 = 421168890052
                                                        r16 = "\205r\208\185\000\237\031\166\223C(OPT(\159$\254\215\226\171A\216\232\015\187"
                                                        r92 = r65(r16, r56)
                                                        state = ReturnVal[r92]
                                                        r92 = upvalueValues[upvalues[4]]
                                                        r56 = upvalueValues[upvalues[2]]
                                                        r62 = upvalueValues[upvalues[3]]
                                                        r41 = 10330144379594
                                                        r27 = "2\157\253\221\216\218@\200S"
                                                        r74 = r62(r27, r41)
                                                        r16 = r56[r74]
                                                        r65 = r92[r16]
                                                        ReturnVal = {
                                                            r65
                                                        }
                                                        r12[state] = ReturnVal
                                                        state = upvalueValues[upvalues[5]]
                                                        ReturnVal = "Raycast"
                                                        ReturnVal = state[ReturnVal]
                                                        ReturnVal = ReturnVal(state, r61, r34, r12)
                                                        r65 = ReturnVal
                                                        r56 = not r65
                                                        r62 = true
                                                        r92 = r56 and r62
                                                        r16 = state
                                                        state = r92 and (96) or (97)
                                                        ReturnVal = r92
                                                    end
                                                end
                                            else
                                                if state <= 96 then
                                                    if state == 96 then
                                                        ReturnVal = {
                                                            ReturnVal
                                                        }
                                                        state = nil
                                                    end
                                                else
                                                    if state == 97 then
                                                        r56 = upvalueValues[upvalues[2]]
                                                        r62 = upvalueValues[upvalues[3]]
                                                        r41 = 5950860380883
                                                        r27 = "\166Vf\194;pL\221"
                                                        r74 = r62(r27, r41)
                                                        r16 = r56[r74]
                                                        r92 = r65[r16]
                                                        r74 = upvalueValues[upvalues[2]]
                                                        r27 = upvalueValues[upvalues[3]]
                                                        r68 = 694854320451
                                                        r66 = "|\204\222\173\146\n"
                                                        r41 = r27(r66, r68)
                                                        r16 = "IsDescendantOf"
                                                        r16 = r92[r16]
                                                        r62 = r74[r41]
                                                        r56 = r37[r62]
                                                        r16 = r16(r92, r56)
                                                        ReturnVal = r16
                                                        state = 96
                                                    end
                                                end
                                            end
                                        else
                                            -- createClosure5 entry 4739527 -> 98, states 98-123
                                            if state <= 110 then
                                                if state <= 104 then
                                                    if state <= 101 then
                                                        if state <= 99 then
                                                            if state <= 98 then
                                                                if state == 98 then -- entry 4739527 -> 98
                                                                    r37 = "math"
                                                                    ReturnVal = _env[r37]
                                                                    r61 = upvalueValues[upvalues[1]]
                                                                    r34 = upvalueValues[upvalues[2]]
                                                                    r92 = 1923114140543
                                                                    r65 = "5\213<9"
                                                                    r12 = r34(r65, r92)
                                                                    r37 = r61[r12]
                                                                    state = ReturnVal[r37]
                                                                    r37 = state
                                                                    r61 = upvalueValues[upvalues[3]]
                                                                    r12 = upvalueValues[upvalues[1]]
                                                                    r65 = upvalueValues[upvalues[2]]
                                                                    r56 = 6218630269775
                                                                    r16 = "$\199\163'\160\179"
                                                                    r92 = r65(r16, r56)
                                                                    r34 = r12[r92]
                                                                    ReturnVal = r61[r34]
                                                                    r34 = upvalueValues[upvalues[1]]
                                                                    r12 = upvalueValues[upvalues[2]]
                                                                    r16 = 8284911865617
                                                                    r92 = "\137`\008\157i\150q\133"
                                                                    r65 = r12(r92, r16)
                                                                    r61 = r34[r65]
                                                                    state = ReturnVal[r61]
                                                                    r61 = state
                                                                    state = upvalueValues[upvalues[4]]
                                                                    r34 = state
                                                                    r16 = "GetPlayers"
                                                                    r16 = r34[r16]
                                                                    ReturnVal = "ipairs"
                                                                    state = _env[ReturnVal]
                                                                    r92 = {
                                                                        r16(r34)
                                                                    }
                                                                    r16 = {
                                                                        state(unpack(r92))
                                                                    }
                                                                    ReturnVal = r16[1]
                                                                    r65 = r16[3]
                                                                    r12 = r16[2]
                                                                    state = nil
                                                                    r16 = state
                                                                    r92 = ReturnVal
                                                                    state = 99
                                                                end
                                                            else
                                                                if state == 99 then
                                                                    state = true
                                                                    state = state and (100) or (101)
                                                                end
                                                            end
                                                        else
                                                            if state <= 100 then
                                                                if state == 100 then
                                                                    r62 = {
                                                                        r92(r12, r65)
                                                                    }
                                                                    ReturnVal = r62[2]
                                                                    state = nil
                                                                    r56 = state
                                                                    state = r62[1]
                                                                    r65 = state
                                                                    r74 = nil
                                                                    r62 = r65 == r74
                                                                    state = r62 and (102) or (103)
                                                                    r56 = ReturnVal
                                                                end
                                                            else
                                                                if state == 101 then
                                                                    ReturnVal = {
                                                                        r16
                                                                    }
                                                                    state = nil
                                                                end
                                                            end
                                                        end
                                                    else
                                                        if state <= 103 then
                                                            if state <= 102 then
                                                                if state == 102 then
                                                                    r56 = nil
                                                                    state = 101
                                                                end
                                                            else
                                                                if state == 103 then
                                                                    r74 = upvalueValues[upvalues[5]]
                                                                    r62 = r56 ~= r74
                                                                    state = r62 and (104) or (105)
                                                                end
                                                            end
                                                        else
                                                            if state == 104 then
                                                                r74 = upvalueValues[upvalues[6]]
                                                                r62 = r74[r56]
                                                                r27 = state
                                                                r68 = upvalueValues[upvalues[1]]
                                                                r4 = upvalueValues[upvalues[2]]
                                                                r39 = "\150\191]\22237\143\187K"
                                                                r90 = 26173751177116
                                                                r6 = r4(r39, r90)
                                                                r66 = r68[r6]
                                                                r41 = r56[r66]
                                                                state = r41 and (106) or (107)
                                                                r74 = r41
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 107 then
                                                        if state <= 106 then
                                                            if state <= 105 then
                                                                if state == 105 then
                                                                    r56 = nil
                                                                    state = 99
                                                                end
                                                            else
                                                                if state == 106 then
                                                                    r66 = state
                                                                    state = r62 and (108) or (109)
                                                                    r41 = r62
                                                                end
                                                            end
                                                        else
                                                            if state == 107 then
                                                                state = r27
                                                                state = r74 and (110) or (111)
                                                            end
                                                        end
                                                    else
                                                        if state <= 109 then
                                                            if state <= 108 then
                                                                if state == 108 then
                                                                    r39 = upvalueValues[upvalues[1]]
                                                                    r68 = "IsDescendantOf"
                                                                    r68 = r62[r68]
                                                                    r90 = upvalueValues[upvalues[2]]
                                                                    r54 = "3?\2185~6\222\139\127"
                                                                    r14 = 20824495629793
                                                                    r13 = r90(r54, r14)
                                                                    r6 = r39[r13]
                                                                    r4 = r56[r6]
                                                                    r68 = r68(r62, r4)
                                                                    r41 = r68
                                                                    state = 109
                                                                end
                                                            else
                                                                if state == 109 then
                                                                    state = r66
                                                                    r74 = r41
                                                                    state = 107
                                                                end
                                                            end
                                                        else
                                                            if state == 110 then
                                                                r41 = upvalueValues[upvalues[1]]
                                                                r66 = upvalueValues[upvalues[2]]
                                                                r4 = "\244\196\182\004\151t]H\173"
                                                                r6 = 16158172978532
                                                                r68 = r66(r4, r6)
                                                                r27 = r41[r68]
                                                                r74 = r56[r27]
                                                                r66 = upvalueValues[upvalues[1]]
                                                                r68 = upvalueValues[upvalues[2]]
                                                                r27 = "FindFirstChildOfClass"
                                                                r27 = r74[r27]
                                                                r39 = 33628528803115
                                                                r6 = "<\239~\142\193J\247C"
                                                                r4 = r68(r6, r39)
                                                                r41 = r66[r4]
                                                                r27 = r27(r74, r41)
                                                                r41 = state
                                                                state = r27 and (112) or (113)
                                                                r74 = r27
                                                            end
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 117 then
                                                    if state <= 114 then
                                                        if state <= 112 then
                                                            if state <= 111 then
                                                                if state == 111 then
                                                                    r62 = nil
                                                                    state = 105
                                                                end
                                                            else
                                                                if state == 112 then
                                                                    r90 = upvalueValues[upvalues[1]]
                                                                    r13 = upvalueValues[upvalues[2]]
                                                                    r14 = "\007`\197D)\019"
                                                                    r67 = 14222734662110
                                                                    r54 = r13(r14, r67)
                                                                    r39 = r90[r54]
                                                                    r6 = r27[r39]
                                                                    r39 = 0
                                                                    r4 = r6 > r39
                                                                    r68 = state
                                                                    state = r4 and (114) or (115)
                                                                    r66 = r4
                                                                end
                                                            end
                                                        else
                                                            if state <= 113 then
                                                                if state == 113 then
                                                                    state = r41
                                                                    state = r74 and (116) or (117)
                                                                end
                                                            else
                                                                if state == 114 then
                                                                    r39 = upvalueValues[upvalues[7]]
                                                                    r90 = r39(r62)
                                                                    r6 = state
                                                                    state = r90 and (118) or (119)
                                                                    r4 = r90
                                                                end
                                                            end
                                                        end
                                                    else
                                                        if state <= 116 then
                                                            if state <= 115 then
                                                                if state == 115 then
                                                                    state = r68
                                                                    r74 = r66
                                                                    state = 113
                                                                end
                                                            else
                                                                if state == 116 then
                                                                    r4 = upvalueValues[upvalues[1]]
                                                                    r6 = upvalueValues[upvalues[2]]
                                                                    r13 = 33397770501312
                                                                    r90 = ".\240\221 \219\158Nf"
                                                                    r39 = r6(r90, r13)
                                                                    r68 = r4[r39]
                                                                    r66 = r62[r68]
                                                                    r41 = r66 - r61
                                                                    r68 = upvalueValues[upvalues[1]]
                                                                    r4 = upvalueValues[upvalues[2]]
                                                                    r90 = 4848734882001
                                                                    r39 = "\021\237$\020G\245|\131&"
                                                                    r6 = r4(r39, r90)
                                                                    r66 = r68[r6]
                                                                    r74 = r41[r66]
                                                                    r41 = r74 < r37
                                                                    state = r41 and (120) or (121)
                                                                end
                                                            end
                                                        else
                                                            if state == 117 then
                                                                r27 = nil
                                                                state = 111
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 120 then
                                                        if state <= 119 then
                                                            if state <= 118 then
                                                                if state == 118 then
                                                                    r13 = upvalueValues[upvalues[8]]
                                                                    r84 = upvalueValues[upvalues[1]]
                                                                    r91 = upvalueValues[upvalues[2]]
                                                                    r36 = 19612286493612
                                                                    r24 = "[\149\137\143\001(Ar"
                                                                    r15 = r91(r24, r36)
                                                                    r67 = r84[r15]
                                                                    r14 = r62[r67]
                                                                    r54 = r13(r14)
                                                                    r90 = state
                                                                    state = r54 and (122) or (123)
                                                                    r39 = r54
                                                                end
                                                            else
                                                                if state == 119 then
                                                                    state = r6
                                                                    r66 = r4
                                                                    state = 115
                                                                end
                                                            end
                                                        else
                                                            if state == 120 then
                                                                r66 = r74
                                                                r41 = r56
                                                                r37 = r66
                                                                r16 = r41
                                                                state = 121
                                                            end
                                                        end
                                                    else
                                                        if state <= 122 then
                                                            if state <= 121 then
                                                                if state == 121 then
                                                                    r74 = nil
                                                                    state = 117
                                                                end
                                                            else
                                                                if state == 122 then
                                                                    r13 = upvalueValues[upvalues[9]]
                                                                    r84 = upvalueValues[upvalues[1]]
                                                                    r91 = upvalueValues[upvalues[2]]
                                                                    r24 = "\252\247\168\006\198\170\252D"
                                                                    r36 = 15357292174319
                                                                    r15 = r91(r24, r36)
                                                                    r67 = r84[r15]
                                                                    r14 = r62[r67]
                                                                    r54 = r13(r14)
                                                                    r39 = r54
                                                                    state = 123
                                                                end
                                                            end
                                                        else
                                                            if state == 123 then
                                                                state = r90
                                                                r4 = r39
                                                                state = 119
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        -- createClosure2 entry 12744678 -> 124, states 124-126
                                        if state <= 125 then
                                            if state <= 124 then
                                                if state == 124 then -- entry 12744678 -> 124
                                                    r37 = args[1]
                                                    state = upvalueValues[upvalues[1]]
                                                    r34 = "WorldToViewportPoint"
                                                    r34 = state[r34]
                                                    r34 = {
                                                        r34(state, r37)
                                                    }
                                                    ReturnVal = r34[1]
                                                    r61 = r34[2]
                                                    state = not r61
                                                    state = state and (125) or (126)
                                                    r34 = ReturnVal
                                                end
                                            else
                                                if state == 125 then
                                                    state = false
                                                    ReturnVal = {
                                                        state
                                                    }
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state == 126 then
                                                r12 = "Vector2"
                                                ReturnVal = _env[r12]
                                                r65 = upvalueValues[upvalues[2]]
                                                r92 = upvalueValues[upvalues[3]]
                                                r62 = 9292787781863
                                                r56 = "\211\211\152"
                                                r16 = r92(r56, r62)
                                                r12 = r65[r16]
                                                state = ReturnVal[r12]
                                                r16 = upvalueValues[upvalues[1]]
                                                r62 = upvalueValues[upvalues[2]]
                                                r74 = upvalueValues[upvalues[3]]
                                                r66 = 6239193566041
                                                r41 = "S\146\137\230\193\215 N\142\210\200W"
                                                r27 = r74(r41, r66)
                                                r56 = r62[r27]
                                                r92 = r16[r56]
                                                r56 = upvalueValues[upvalues[2]]
                                                r62 = upvalueValues[upvalues[3]]
                                                r41 = 8584414203805
                                                r27 = "\245"
                                                r74 = r62(r27, r41)
                                                r16 = r56[r74]
                                                r65 = r92[r16]
                                                r92 = 2
                                                r12 = r65 / r92
                                                r56 = upvalueValues[upvalues[1]]
                                                r74 = upvalueValues[upvalues[2]]
                                                r27 = upvalueValues[upvalues[3]]
                                                r68 = 11719521195345
                                                r66 = "\2433\139\185g\229\024\250\143d\019\228"
                                                r41 = r27(r66, r68)
                                                r62 = r74[r41]
                                                r16 = r56[r62]
                                                r62 = upvalueValues[upvalues[2]]
                                                r74 = upvalueValues[upvalues[3]]
                                                r66 = 8324674817828
                                                r41 = "H"
                                                r27 = r74(r41, r66)
                                                r56 = r62[r27]
                                                r92 = r16[r56]
                                                r16 = 2
                                                r65 = r92 / r16
                                                ReturnVal = state(r12, r65)
                                                r12 = ReturnVal
                                                r56 = "Vector2"
                                                r16 = _env[r56]
                                                r62 = upvalueValues[upvalues[2]]
                                                r74 = upvalueValues[upvalues[3]]
                                                r66 = 7380242681196
                                                r41 = "\245\243\144"
                                                r27 = r74(r41, r66)
                                                r56 = r62[r27]
                                                r92 = r16[r56]
                                                r74 = upvalueValues[upvalues[2]]
                                                r27 = upvalueValues[upvalues[3]]
                                                r68 = 20711184606636
                                                r66 = "\005"
                                                r41 = r27(r66, r68)
                                                r62 = r74[r41]
                                                r56 = r34[r62]
                                                r27 = upvalueValues[upvalues[2]]
                                                r41 = upvalueValues[upvalues[3]]
                                                r4 = 898193457570
                                                r68 = "="
                                                r66 = r41(r68, r4)
                                                r74 = r27[r66]
                                                r62 = r34[r74]
                                                r16 = r92(r56, r62)
                                                r65 = r16 - r12
                                                r16 = upvalueValues[upvalues[2]]
                                                r56 = upvalueValues[upvalues[3]]
                                                r74 = "b/cd\187\000\127\190\183"
                                                r27 = 34714010124068
                                                r62 = r56(r74, r27)
                                                r92 = r16[r62]
                                                ReturnVal = r65[r92]
                                                r65 = upvalueValues[upvalues[4]]
                                                state = ReturnVal <= r65
                                                ReturnVal = {
                                                    state
                                                }
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    if state <= 127 then
                                        -- createClosure4 entry 10578062 -> 127, states 127-127
                                        if state == 127 then -- entry 10578062 -> 127
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r61 = upvalueValues[upvalues[2]]
                                            r34 = upvalueValues[upvalues[3]]
                                            r65 = "5\204=`\195\018\004sO\200"
                                            r92 = 15178879261596
                                            r12 = r34(r65, r92)
                                            r37 = r61[r12]
                                            state = ReturnVal[r37]
                                            upvalueValues[upvalues[4]] = state
                                            r37 = upvalueValues[upvalues[1]]
                                            r34 = upvalueValues[upvalues[2]]
                                            r12 = upvalueValues[upvalues[3]]
                                            r16 = 6769056795728
                                            r92 = "\249\164L\184\165(5&P\228\230Nk"
                                            r65 = r12(r92, r16)
                                            r61 = r34[r65]
                                            ReturnVal = r37[r61]
                                            upvalueValues[upvalues[5]] = ReturnVal
                                            r37 = upvalueValues[upvalues[1]]
                                            r34 = upvalueValues[upvalues[2]]
                                            ReturnVal = {}
                                            r12 = upvalueValues[upvalues[3]]
                                            r92 = "J\183^`\006f-+\162}"
                                            r16 = 34513793711815
                                            r65 = r12(r92, r16)
                                            r61 = r34[r65]
                                            r92 = "Enum"
                                            r65 = _env[r92]
                                            r16 = upvalueValues[upvalues[2]]
                                            r56 = upvalueValues[upvalues[3]]
                                            r74 = "\199\254l+\251\238\186@\232\005"
                                            r27 = 10945867486185
                                            r62 = r56(r74, r27)
                                            r92 = r16[r62]
                                            r12 = r65[r92]
                                            r92 = upvalueValues[upvalues[2]]
                                            r16 = upvalueValues[upvalues[3]]
                                            r62 = "j\021\203X\213\003\241p\179L"
                                            r74 = 7512714497450
                                            r56 = r16(r62, r74)
                                            r65 = r92[r56]
                                            r34 = r12[r65]
                                            r37[r61] = r34
                                            r37 = true
                                            upvalueValues[upvalues[6]] = r37
                                            r61 = upvalueValues[upvalues[7]]
                                            r34 = r61()
                                            upvalueValues[upvalues[8]] = r34
                                            state = nil
                                        end
                                    else
                                        -- createClosure0 entry 15705625 -> 128, states 128-136
                                        if state <= 132 then
                                            if state <= 130 then
                                                if state <= 129 then
                                                    if state <= 128 then
                                                        if state == 128 then -- entry 15705625 -> 128
                                                            state = upvalueValues[upvalues[1]]
                                                            state = state and (129) or (130)
                                                        end
                                                    else
                                                        if state == 129 then
                                                            state = upvalueValues[upvalues[1]]
                                                            ReturnVal = "Disconnect"
                                                            ReturnVal = state[ReturnVal]
                                                            ReturnVal = ReturnVal(state)
                                                            state = nil
                                                            upvalueValues[upvalues[1]] = state
                                                            state = 130
                                                        end
                                                    end
                                                else
                                                    if state == 130 then
                                                        ReturnVal = upvalueValues[upvalues[2]]
                                                        state = ReturnVal and (131) or (132)
                                                    end
                                                end
                                            else
                                                if state <= 131 then
                                                    if state == 131 then
                                                        ReturnVal = upvalueValues[upvalues[2]]
                                                        r37 = "Disconnect"
                                                        r37 = ReturnVal[r37]
                                                        r37 = r37(ReturnVal)
                                                        ReturnVal = nil
                                                        upvalueValues[upvalues[2]] = ReturnVal
                                                        state = 132
                                                    end
                                                else
                                                    if state == 132 then
                                                        r37 = upvalueValues[upvalues[3]]
                                                        state = r37 and (133) or (134)
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 134 then
                                                if state <= 133 then
                                                    if state == 133 then
                                                        r37 = upvalueValues[upvalues[3]]
                                                        r61 = "Disconnect"
                                                        r61 = r37[r61]
                                                        r61 = r61(r37)
                                                        r37 = nil
                                                        upvalueValues[upvalues[3]] = r37
                                                        state = 134
                                                    end
                                                else
                                                    if state == 134 then
                                                        r61 = upvalueValues[upvalues[4]]
                                                        state = r61 and (135) or (136)
                                                    end
                                                end
                                            else
                                                if state <= 135 then
                                                    if state == 135 then
                                                        r61 = upvalueValues[upvalues[4]]
                                                        r34 = "Disconnect"
                                                        r34 = r61[r34]
                                                        r34 = r34(r61)
                                                        r61 = nil
                                                        upvalueValues[upvalues[4]] = r61
                                                        state = 136
                                                    end
                                                else
                                                    if state == 136 then
                                                        ReturnVal = {}
                                                        state = nil
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    else
                        if state <= 210 then
                            if state <= 171 then
                                if state <= 169 then
                                    if state <= 148 then
                                        if state <= 143 then
                                            -- createClosure2 entry 11302910 -> 137, states 137-143
                                            if state <= 140 then
                                                if state <= 138 then
                                                    if state <= 137 then
                                                        if state == 137 then -- entry 11302910 -> 137
                                                            state = upvalueValues[upvalues[1]]
                                                            r37 = upvalueValues[upvalues[2]]
                                                            r61 = upvalueValues[upvalues[3]]
                                                            r65 = 4777634613424
                                                            r12 = "H\229\205\170zW>\\\236\242"
                                                            r34 = r61(r12, r65)
                                                            ReturnVal = r37[r34]
                                                            r61 = state
                                                            r34 = upvalueValues[upvalues[4]]
                                                            state = r34 and (138) or (139)
                                                            r37 = r34
                                                        end
                                                    else
                                                        if state == 138 then
                                                            state = r61
                                                            state[ReturnVal] = r37
                                                            r61 = upvalueValues[upvalues[5]]
                                                            r12 = upvalueValues[upvalues[2]]
                                                            r65 = upvalueValues[upvalues[3]]
                                                            r16 = "\143\239\190\250\171\181{\142\171"
                                                            r56 = 14070422395288
                                                            r92 = r65(r16, r56)
                                                            r34 = r12[r92]
                                                            r37 = r61[r34]
                                                            state = r37 and (140) or (141)
                                                            ReturnVal = r37
                                                        end
                                                    end
                                                else
                                                    if state <= 139 then
                                                        if state == 139 then
                                                            r92 = "Enum"
                                                            r65 = _env[r92]
                                                            r16 = upvalueValues[upvalues[2]]
                                                            r56 = upvalueValues[upvalues[3]]
                                                            r27 = 10807607710632
                                                            r74 = "Y\133%!\216\146i\006N@"
                                                            r62 = r56(r74, r27)
                                                            r92 = r16[r62]
                                                            r12 = r65[r92]
                                                            r92 = upvalueValues[upvalues[2]]
                                                            r16 = upvalueValues[upvalues[3]]
                                                            r74 = 33403026177218
                                                            r62 = "\031\240\253ce\215"
                                                            r56 = r16(r62, r74)
                                                            r65 = r92[r56]
                                                            r34 = r12[r65]
                                                            r37 = r34
                                                            state = 138
                                                        end
                                                    else
                                                        if state == 140 then
                                                            r61 = upvalueValues[upvalues[5]]
                                                            r12 = upvalueValues[upvalues[2]]
                                                            r65 = upvalueValues[upvalues[3]]
                                                            r56 = 17046801276674
                                                            r16 = "|NF\021l\241\021\204a"
                                                            r92 = r65(r16, r56)
                                                            r34 = r12[r92]
                                                            r37 = r61[r34]
                                                            r12 = upvalueValues[upvalues[2]]
                                                            r65 = upvalueValues[upvalues[3]]
                                                            r56 = 6803068292191
                                                            r16 = "\024L\159p\223\235Jr"
                                                            r92 = r65(r16, r56)
                                                            r34 = r12[r92]
                                                            r61 = "FindFirstChild"
                                                            r61 = r37[r61]
                                                            r61 = r61(r37, r34)
                                                            ReturnVal = r61
                                                            state = 141
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 142 then
                                                    if state <= 141 then
                                                        if state == 141 then
                                                            state = ReturnVal and (142) or (143)
                                                        end
                                                    else
                                                        if state == 142 then
                                                            state = upvalueValues[upvalues[1]]
                                                            r37 = upvalueValues[upvalues[2]]
                                                            r61 = upvalueValues[upvalues[3]]
                                                            r65 = 25789943607017
                                                            r12 = "\191\141\172\027x\148\004,\195\242'\014 "
                                                            r34 = r61(r12, r65)
                                                            ReturnVal = r37[r34]
                                                            r61 = upvalueValues[upvalues[5]]
                                                            r12 = upvalueValues[upvalues[2]]
                                                            r65 = upvalueValues[upvalues[3]]
                                                            r16 = "vu\200\178\189p\130\251\021"
                                                            r56 = 25371476094502
                                                            r92 = r65(r16, r56)
                                                            r34 = r12[r92]
                                                            r37 = r61[r34]
                                                            r61 = "FindFirstChild"
                                                            r61 = r37[r61]
                                                            r12 = upvalueValues[upvalues[2]]
                                                            r65 = upvalueValues[upvalues[3]]
                                                            r56 = 14183310973388
                                                            r16 = "\214(\224\148\1491_I"
                                                            r92 = r65(r16, r56)
                                                            r34 = r12[r92]
                                                            r61 = r61(r37, r34)
                                                            state[ReturnVal] = r61
                                                            state = 143
                                                        end
                                                    end
                                                else
                                                    if state == 143 then
                                                        state = false
                                                        upvalueValues[upvalues[6]] = state
                                                        ReturnVal = nil
                                                        upvalueValues[upvalues[7]] = ReturnVal
                                                        ReturnVal = {}
                                                        state = nil
                                                    end
                                                end
                                            end
                                        else
                                            -- createClosure4 entry 6450517 -> 144, states 144-148
                                            if state <= 146 then
                                                if state <= 145 then
                                                    if state <= 144 then
                                                        if state == 144 then -- entry 6450517 -> 144
                                                            state = upvalueValues[upvalues[1]]
                                                            state = state and (145) or (146)
                                                        end
                                                    else
                                                        if state == 145 then
                                                            state = upvalueValues[upvalues[1]]
                                                            ReturnVal = "Disconnect"
                                                            ReturnVal = state[ReturnVal]
                                                            ReturnVal = ReturnVal(state)
                                                            state = 146
                                                        end
                                                    end
                                                else
                                                    if state == 146 then
                                                        state = upvalueValues[upvalues[2]]
                                                        state = state and (147) or (148)
                                                    end
                                                end
                                            else
                                                if state <= 147 then
                                                    if state == 147 then
                                                        state = upvalueValues[upvalues[2]]
                                                        ReturnVal = "Disconnect"
                                                        ReturnVal = state[ReturnVal]
                                                        ReturnVal = ReturnVal(state)
                                                        state = 148
                                                    end
                                                else
                                                    if state == 148 then
                                                        ReturnVal = upvalueValues[upvalues[3]]
                                                        r61 = upvalueValues[upvalues[4]]
                                                        r34 = upvalueValues[upvalues[5]]
                                                        r65 = "\182<*\152\183\218\177F\226\211"
                                                        r92 = 11316756108437
                                                        r12 = r34(r65, r92)
                                                        r37 = r61[r12]
                                                        state = ReturnVal[r37]
                                                        r37 = createClosure7(358, {
                                                            upvalues[4],
                                                            upvalues[5],
                                                            upvalues[6]
                                                        })
                                                        ReturnVal = "Connect"
                                                        ReturnVal = state[ReturnVal]
                                                        ReturnVal = ReturnVal(state, r37)
                                                        upvalueValues[upvalues[1]] = ReturnVal
                                                        r37 = upvalueValues[upvalues[3]]
                                                        r34 = upvalueValues[upvalues[4]]
                                                        r12 = upvalueValues[upvalues[5]]
                                                        r16 = 32488299838232
                                                        r92 = "\153\190V\004\144X?\160x\129"
                                                        r65 = r12(r92, r16)
                                                        r61 = r34[r65]
                                                        state = r37[r61]
                                                        r61 = createClosure4(363, {
                                                            upvalues[4],
                                                            upvalues[5],
                                                            upvalues[7]
                                                        })
                                                        r37 = "Connect"
                                                        r37 = state[r37]
                                                        r37 = r37(state, r61)
                                                        upvalueValues[upvalues[2]] = r37
                                                        r34 = "task"
                                                        r61 = _env[r34]
                                                        r12 = upvalueValues[upvalues[4]]
                                                        r65 = upvalueValues[upvalues[5]]
                                                        r16 = "4\194t6\236"
                                                        r56 = 2971661747559
                                                        r92 = r65(r16, r56)
                                                        r34 = r12[r92]
                                                        state = r61[r34]
                                                        ReturnVal = {}
                                                        r34 = createClosure1(366, {
                                                            upvalues[8],
                                                            upvalues[4],
                                                            upvalues[5],
                                                            upvalues[9],
                                                            upvalues[10],
                                                            upvalues[6],
                                                            upvalues[7]
                                                        })
                                                        r61 = state(r34)
                                                        state = nil
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        -- createClosure4 entry 996635 -> 149, states 149-169
                                        if state <= 159 then
                                            if state <= 154 then
                                                if state <= 151 then
                                                    if state <= 150 then
                                                        if state <= 149 then
                                                            if state == 149 then -- entry 996635 -> 149
                                                                state = upvalueValues[upvalues[1]]
                                                                state = state and (150) or (151)
                                                            end
                                                        else
                                                            if state == 150 then
                                                                r12 = upvalueValues[upvalues[2]]
                                                                r34 = state
                                                                state = r12 and (152) or (153)
                                                                r61 = r12
                                                            end
                                                        end
                                                    else
                                                        if state == 151 then
                                                            ReturnVal = {}
                                                            state = nil
                                                        end
                                                    end
                                                else
                                                    if state <= 153 then
                                                        if state <= 152 then
                                                            if state == 152 then
                                                                r65 = state
                                                                r16 = upvalueValues[upvalues[2]]
                                                                r62 = upvalueValues[upvalues[3]]
                                                                r74 = upvalueValues[upvalues[4]]
                                                                r41 = "\189\244\231M},uX@"
                                                                r66 = 29199123707164
                                                                r27 = r74(r41, r66)
                                                                r56 = r62[r27]
                                                                r92 = r16[r56]
                                                                state = r92 and (154) or (155)
                                                                r12 = r92
                                                            end
                                                        else
                                                            if state == 153 then
                                                                r37 = not r61
                                                                state = r34
                                                                state = r37 and (156) or (157)
                                                                ReturnVal = r37
                                                            end
                                                        end
                                                    else
                                                        if state == 154 then
                                                            r16 = upvalueValues[upvalues[5]]
                                                            r56 = upvalueValues[upvalues[2]]
                                                            r92 = r16[r56]
                                                            r12 = r92
                                                            state = 155
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 157 then
                                                    if state <= 156 then
                                                        if state <= 155 then
                                                            if state == 155 then
                                                                state = r65
                                                                r61 = r12
                                                                state = 153
                                                            end
                                                        else
                                                            if state == 156 then
                                                                state = ReturnVal and (158) or (159)
                                                            end
                                                        end
                                                    else
                                                        if state == 157 then
                                                            r61 = state
                                                            r12 = state
                                                            r16 = upvalueValues[upvalues[5]]
                                                            r56 = upvalueValues[upvalues[2]]
                                                            r92 = r16[r56]
                                                            r62 = upvalueValues[upvalues[2]]
                                                            r27 = upvalueValues[upvalues[3]]
                                                            r41 = upvalueValues[upvalues[4]]
                                                            r68 = "\137\215\248\2487\255\220sf"
                                                            r4 = 7427190279554
                                                            r66 = r41(r68, r4)
                                                            r74 = r27[r66]
                                                            r56 = r62[r74]
                                                            r16 = "IsDescendantOf"
                                                            r16 = r92[r16]
                                                            r16 = r16(r92, r56)
                                                            r65 = not r16
                                                            state = r65 and (160) or (161)
                                                            r34 = r65
                                                        end
                                                    end
                                                else
                                                    if state <= 158 then
                                                        if state == 158 then
                                                            state = upvalueValues[upvalues[7]]
                                                            ReturnVal = state()
                                                            upvalueValues[upvalues[2]] = ReturnVal
                                                            state = 159
                                                        end
                                                    else
                                                        if state == 159 then
                                                            r61 = upvalueValues[upvalues[2]]
                                                            state = r61 and (162) or (163)
                                                            r37 = r61
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 164 then
                                                if state <= 162 then
                                                    if state <= 161 then
                                                        if state <= 160 then
                                                            if state == 160 then
                                                                state = r12
                                                                state = r34 and (164) or (165)
                                                                r37 = r34
                                                            end
                                                        else
                                                            if state == 161 then
                                                                r92 = state
                                                                r56 = upvalueValues[upvalues[2]]
                                                                r74 = upvalueValues[upvalues[3]]
                                                                r27 = upvalueValues[upvalues[4]]
                                                                r66 = "\185E\213lu\253\247\136\238"
                                                                r68 = 25617951403673
                                                                r41 = r27(r66, r68)
                                                                r62 = r74[r41]
                                                                r16 = r56[r62]
                                                                r74 = upvalueValues[upvalues[3]]
                                                                r27 = upvalueValues[upvalues[4]]
                                                                r56 = "FindFirstChildOfClass"
                                                                r56 = r16[r56]
                                                                r68 = 28528545330148
                                                                r66 = "B\2445\226\155\198\169\003"
                                                                r41 = r27(r66, r68)
                                                                r62 = r74[r41]
                                                                r56 = r56(r16, r62)
                                                                state = r56 and (166) or (167)
                                                                r65 = r56
                                                            end
                                                        end
                                                    else
                                                        if state == 162 then
                                                            r34 = upvalueValues[upvalues[5]]
                                                            r12 = upvalueValues[upvalues[2]]
                                                            r61 = r34[r12]
                                                            r37 = r61
                                                            state = 163
                                                        end
                                                    end
                                                else
                                                    if state <= 163 then
                                                        if state == 163 then
                                                            state = r37 and (168) or (169)
                                                        end
                                                    else
                                                        if state == 164 then
                                                            state = r61
                                                            ReturnVal = r37
                                                            state = 156
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 167 then
                                                    if state <= 166 then
                                                        if state <= 165 then
                                                            if state == 165 then
                                                                r12 = upvalueValues[upvalues[6]]
                                                                r56 = upvalueValues[upvalues[5]]
                                                                r62 = upvalueValues[upvalues[2]]
                                                                r16 = r56[r62]
                                                                r62 = upvalueValues[upvalues[3]]
                                                                r74 = upvalueValues[upvalues[4]]
                                                                r41 = "q<\002-\027*\168\174"
                                                                r66 = 29180665492756
                                                                r27 = r74(r41, r66)
                                                                r56 = r62[r27]
                                                                r92 = r16[r56]
                                                                r65 = r12(r92)
                                                                r34 = not r65
                                                                r37 = r34
                                                                state = 164
                                                            end
                                                        else
                                                            if state == 166 then
                                                                r74 = upvalueValues[upvalues[2]]
                                                                r41 = upvalueValues[upvalues[3]]
                                                                r66 = upvalueValues[upvalues[4]]
                                                                r6 = 18373057782123
                                                                r4 = "4-k\193\186:\026\213\151"
                                                                r68 = r66(r4, r6)
                                                                r27 = r41[r68]
                                                                r62 = r74[r27]
                                                                r41 = upvalueValues[upvalues[3]]
                                                                r66 = upvalueValues[upvalues[4]]
                                                                r6 = 33130665901123
                                                                r4 = "\129\132\159#l\219\000\197"
                                                                r68 = r66(r4, r6)
                                                                r74 = "FindFirstChildOfClass"
                                                                r74 = r62[r74]
                                                                r27 = r41[r68]
                                                                r74 = r74(r62, r27)
                                                                r27 = upvalueValues[upvalues[3]]
                                                                r41 = upvalueValues[upvalues[4]]
                                                                r4 = 33306179943573
                                                                r68 = "\190\245\131\170\150@"
                                                                r66 = r41(r68, r4)
                                                                r62 = r27[r66]
                                                                r56 = r74[r62]
                                                                r62 = 0
                                                                r16 = r56 <= r62
                                                                r65 = r16
                                                                state = 167
                                                            end
                                                        end
                                                    else
                                                        if state == 167 then
                                                            state = r92
                                                            r34 = r65
                                                            state = 160
                                                        end
                                                    end
                                                else
                                                    if state <= 168 then
                                                        if state == 168 then
                                                            r37 = upvalueValues[upvalues[5]]
                                                            r61 = upvalueValues[upvalues[2]]
                                                            state = r37[r61]
                                                            r37 = state
                                                            state = upvalueValues[upvalues[8]]
                                                            r34 = upvalueValues[upvalues[3]]
                                                            r12 = upvalueValues[upvalues[4]]
                                                            r92 = "\230\172\245e[d"
                                                            r16 = 31349319989510
                                                            r65 = r12(r92, r16)
                                                            r61 = r34[r65]
                                                            r65 = "CFrame"
                                                            r12 = _env[r65]
                                                            r92 = upvalueValues[upvalues[3]]
                                                            r16 = upvalueValues[upvalues[4]]
                                                            r74 = 12192230233645
                                                            r62 = "\221t\131"
                                                            r56 = r16(r62, r74)
                                                            r65 = r92[r56]
                                                            r34 = r12[r65]
                                                            r16 = upvalueValues[upvalues[8]]
                                                            r62 = upvalueValues[upvalues[3]]
                                                            r74 = upvalueValues[upvalues[4]]
                                                            r41 = "m\134%\015.\247"
                                                            r66 = 11043094664214
                                                            r27 = r74(r41, r66)
                                                            r56 = r62[r27]
                                                            r92 = r16[r56]
                                                            r56 = upvalueValues[upvalues[3]]
                                                            r62 = upvalueValues[upvalues[4]]
                                                            r41 = 2968016176486
                                                            r27 = "(\135\237\239\235\183\218h"
                                                            r74 = r62(r27, r41)
                                                            r16 = r56[r74]
                                                            r65 = r92[r16]
                                                            r56 = upvalueValues[upvalues[3]]
                                                            r62 = upvalueValues[upvalues[4]]
                                                            r41 = 2797801735446
                                                            r27 = "\207B\024E\031\234\246\226"
                                                            r74 = r62(r27, r41)
                                                            r16 = r56[r74]
                                                            r92 = r37[r16]
                                                            r37 = nil
                                                            r12 = r34(r65, r92)
                                                            state[r61] = r12
                                                            state = 169
                                                        end
                                                    else
                                                        if state == 169 then
                                                            state = 151
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    if state <= 170 then
                                        -- createClosure4 entry 8248157 -> 170, states 170-170
                                        if state == 170 then -- entry 8248157 -> 170
                                            state = upvalueValues[upvalues[1]]
                                            ReturnVal = state()
                                            state = upvalueValues[upvalues[2]]
                                            ReturnVal = state()
                                            ReturnVal = "print"
                                            state = _env[ReturnVal]
                                            r61 = upvalueValues[upvalues[3]]
                                            r34 = upvalueValues[upvalues[4]]
                                            r65 = "\030B\144\151\161\243}^\156\tx\221\190~"
                                            r92 = 1230198669884
                                            r12 = r34(r65, r92)
                                            r37 = r61[r12]
                                            ReturnVal = state(r37)
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    else
                                        -- createClosure2 entry 1467244 -> 171, states 171-171
                                        if state == 171 then -- entry 1467244 -> 171
                                            state = upvalueValues[upvalues[1]]
                                            ReturnVal = state()
                                            state = upvalueValues[upvalues[2]]
                                            ReturnVal = state()
                                            state = upvalueValues[upvalues[3]]
                                            ReturnVal = state()
                                            ReturnVal = "print"
                                            state = _env[ReturnVal]
                                            r61 = upvalueValues[upvalues[4]]
                                            r34 = upvalueValues[upvalues[5]]
                                            r65 = "\138\193D\149\002l\201A\204f\247'\216H\005\\j"
                                            r92 = 17151327149874
                                            r12 = r34(r65, r92)
                                            r37 = r61[r12]
                                            ReturnVal = state(r37)
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                end
                            else
                                if state <= 205 then
                                    if state <= 189 then
                                        if state <= 175 then
                                            -- createClosure2 entry 707895 -> 172, states 172-175
                                            if state <= 173 then
                                                if state <= 172 then
                                                    if state == 172 then -- entry 707895 -> 172
                                                        r37 = args[1]
                                                        state = r37 and (173) or (174)
                                                    end
                                                else
                                                    if state == 173 then
                                                        state = upvalueValues[upvalues[1]]
                                                        ReturnVal = state()
                                                        state = 175
                                                    end
                                                end
                                            else
                                                if state <= 174 then
                                                    if state == 174 then
                                                        state = upvalueValues[upvalues[2]]
                                                        ReturnVal = state()
                                                        state = 175
                                                    end
                                                else
                                                    if state == 175 then
                                                        r37 = nil
                                                        ReturnVal = {}
                                                        state = nil
                                                    end
                                                end
                                            end
                                        else
                                            -- createClosure10 entry 1124609 -> 176, states 176-189
                                            if state <= 182 then
                                                if state <= 179 then
                                                    if state <= 177 then
                                                        if state <= 176 then
                                                            if state == 176 then -- entry 1124609 -> 176
                                                                r65 = args[5]
                                                                r61 = args[2]
                                                                state = 7
                                                                r92 = state
                                                                r12 = args[4]
                                                                r34 = args[3]
                                                                state = r61 and (177) or (178)
                                                                r37 = args[1]
                                                                ReturnVal = r61
                                                            end
                                                        else
                                                            if state == 177 then
                                                                r56 = state
                                                                state = r34 and (179) or (180)
                                                                r16 = r34
                                                            end
                                                        end
                                                    else
                                                        if state <= 178 then
                                                            if state == 178 then
                                                                state = ReturnVal and (181) or (182)
                                                            end
                                                        else
                                                            if state == 179 then
                                                                r74 = state
                                                                state = r12 and (183) or (184)
                                                                r62 = r12
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 181 then
                                                        if state <= 180 then
                                                            if state == 180 then
                                                                state = r56
                                                                ReturnVal = r16
                                                                state = 178
                                                            end
                                                        else
                                                            if state == 181 then
                                                                r16 = r61 + r92
                                                                ReturnVal = {
                                                                    r61,
                                                                    r34,
                                                                    r16,
                                                                    r34
                                                                }
                                                                r56 = r34 + r92
                                                                r16 = {
                                                                    r61,
                                                                    r34,
                                                                    r61,
                                                                    r56
                                                                }
                                                                r62 = r12 - r92
                                                                r56 = {
                                                                    r12,
                                                                    r34,
                                                                    r62,
                                                                    r34
                                                                }
                                                                r74 = r34 + r92
                                                                r62 = {
                                                                    r12,
                                                                    r34,
                                                                    r12,
                                                                    r74
                                                                }
                                                                r27 = r61 + r92
                                                                r41 = r65 - r92
                                                                r74 = {
                                                                    r61,
                                                                    r65,
                                                                    r27,
                                                                    r65
                                                                }
                                                                r27 = {
                                                                    r61,
                                                                    r65,
                                                                    r61,
                                                                    r41
                                                                }
                                                                r66 = r12 - r92
                                                                r68 = r65 - r92
                                                                r41 = {
                                                                    r12,
                                                                    r65,
                                                                    r66,
                                                                    r65
                                                                }
                                                                r66 = {
                                                                    r12,
                                                                    r65,
                                                                    r12,
                                                                    r68
                                                                }
                                                                state = {
                                                                    ReturnVal,
                                                                    r16,
                                                                    r56,
                                                                    r62,
                                                                    r74,
                                                                    r27,
                                                                    r41,
                                                                    r66
                                                                }
                                                                r16 = state
                                                                r56 = 8
                                                                r62 = r56
                                                                r56 = 1
                                                                r74 = r56
                                                                r56 = 0
                                                                r27 = r74 < r56
                                                                ReturnVal = 1
                                                                r56 = ReturnVal - r74
                                                                state = 185
                                                            end
                                                        end
                                                    else
                                                        if state == 182 then
                                                            r92 = nil
                                                            r61 = nil
                                                            r34 = nil
                                                            r65 = nil
                                                            r12 = nil
                                                            r37 = nil
                                                            ReturnVal = {}
                                                            state = nil
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 186 then
                                                    if state <= 184 then
                                                        if state <= 183 then
                                                            if state == 183 then
                                                                r62 = r65
                                                                state = 184
                                                            end
                                                        else
                                                            if state == 184 then
                                                                state = r74
                                                                r16 = r62
                                                                state = 180
                                                            end
                                                        end
                                                    else
                                                        if state <= 185 then
                                                            if state == 185 then
                                                                r41 = not r27
                                                                r56 = r56 + r74
                                                                ReturnVal = r56 <= r62
                                                                ReturnVal = r41 and ReturnVal
                                                                r41 = r56 >= r62
                                                                r41 = r27 and r41
                                                                ReturnVal = r41 or ReturnVal
                                                                r41 = (186)
                                                                state = ReturnVal and r41
                                                                ReturnVal = (187)
                                                                state = state or ReturnVal
                                                            end
                                                        else
                                                            if state == 186 then
                                                                r41 = r56
                                                                state = r37[r41]
                                                                r66 = state
                                                                state = r66 and (188) or (189)
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 188 then
                                                        if state <= 187 then
                                                            if state == 187 then
                                                                r16 = nil
                                                                state = 182
                                                            end
                                                        else
                                                            if state == 188 then
                                                                ReturnVal = upvalueValues[upvalues[1]]
                                                                r68 = upvalueValues[upvalues[2]]
                                                                r39 = 20393554240792
                                                                r6 = ",\251\159a"
                                                                r4 = r68(r6, r39)
                                                                state = ReturnVal[r4]
                                                                r4 = "Vector2"
                                                                r68 = _env[r4]
                                                                r6 = upvalueValues[upvalues[1]]
                                                                r39 = upvalueValues[upvalues[2]]
                                                                r13 = "\141~\152"
                                                                r54 = 21568935618363
                                                                r90 = r39(r13, r54)
                                                                r4 = r6[r90]
                                                                ReturnVal = r68[r4]
                                                                r6 = r16[r41]
                                                                r39 = 1
                                                                r4 = r6[r39]
                                                                r39 = r16[r41]
                                                                r90 = 2
                                                                r6 = r39[r90]
                                                                r68 = ReturnVal(r4, r6)
                                                                r66[state] = r68
                                                                ReturnVal = upvalueValues[upvalues[1]]
                                                                r68 = upvalueValues[upvalues[2]]
                                                                r39 = 20325640611064
                                                                r6 = "i\174"
                                                                r4 = r68(r6, r39)
                                                                state = ReturnVal[r4]
                                                                r4 = "Vector2"
                                                                r68 = _env[r4]
                                                                r6 = upvalueValues[upvalues[1]]
                                                                r39 = upvalueValues[upvalues[2]]
                                                                r54 = 11595065595159
                                                                r13 = "J\2419"
                                                                r90 = r39(r13, r54)
                                                                r4 = r6[r90]
                                                                ReturnVal = r68[r4]
                                                                r6 = r16[r41]
                                                                r39 = 3
                                                                r4 = r6[r39]
                                                                r39 = r16[r41]
                                                                r90 = 4
                                                                r6 = r39[r90]
                                                                r68 = ReturnVal(r4, r6)
                                                                r66[state] = r68
                                                                ReturnVal = upvalueValues[upvalues[1]]
                                                                r68 = upvalueValues[upvalues[2]]
                                                                r39 = 9222677942470
                                                                r6 = "\239h\227h\208\201\237"
                                                                r4 = r68(r6, r39)
                                                                state = ReturnVal[r4]
                                                                ReturnVal = true
                                                                r66[state] = ReturnVal
                                                                state = 189
                                                            end
                                                        end
                                                    else
                                                        if state == 189 then
                                                            r41 = nil
                                                            r66 = nil
                                                            state = 185
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        -- createClosure4 entry 6107789 -> 190, states 190-205
                                        if state <= 197 then
                                            if state <= 193 then
                                                if state <= 191 then
                                                    if state <= 190 then
                                                        if state == 190 then -- entry 6107789 -> 190
                                                            r37 = args[1]
                                                            ReturnVal = upvalueValues[upvalues[1]]
                                                            state = ReturnVal[r37]
                                                            r61 = state
                                                            state = r61 and (191) or (192)
                                                        end
                                                    else
                                                        if state == 191 then
                                                            ReturnVal = "pairs"
                                                            state = _env[ReturnVal]
                                                            r65 = {
                                                                state(r61)
                                                            }
                                                            r12 = r65[3]
                                                            r34 = r65[2]
                                                            ReturnVal = r65[1]
                                                            r65 = ReturnVal
                                                            state = 193
                                                        end
                                                    end
                                                else
                                                    if state <= 192 then
                                                        if state == 192 then
                                                            r61 = nil
                                                            r37 = nil
                                                            ReturnVal = {}
                                                            state = nil
                                                        end
                                                    else
                                                        if state == 193 then
                                                            state = true
                                                            state = state and (194) or (195)
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 195 then
                                                    if state <= 194 then
                                                        if state == 194 then
                                                            r92 = allocUpvalue()
                                                            state = nil
                                                            upvalueValues[r92] = state
                                                            r16 = {
                                                                r65(r34, r12)
                                                            }
                                                            state = r16[1]
                                                            ReturnVal = r16[2]
                                                            upvalueValues[r92] = ReturnVal
                                                            r12 = state
                                                            r56 = nil
                                                            r16 = r12 == r56
                                                            state = r16 and (196) or (197)
                                                        end
                                                    else
                                                        if state == 195 then
                                                            r12 = nil
                                                            r92 = upvalueValues[upvalues[1]]
                                                            r34 = nil
                                                            r16 = nil
                                                            r65 = nil
                                                            r92[r37] = r16
                                                            state = 192
                                                        end
                                                    end
                                                else
                                                    if state <= 196 then
                                                        if state == 196 then
                                                            r92 = releaseUpvalue(r92)
                                                            state = 195
                                                        end
                                                    else
                                                        if state == 197 then
                                                            r56 = state
                                                            r62 = upvalueValues[r92]
                                                            state = r62 and (198) or (199)
                                                            r16 = r62
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 201 then
                                                if state <= 199 then
                                                    if state <= 198 then
                                                        if state == 198 then
                                                            r74 = upvalueValues[r92]
                                                            r41 = upvalueValues[upvalues[2]]
                                                            r66 = upvalueValues[upvalues[3]]
                                                            r4 = "\214O\171\146L'!"
                                                            r6 = 11238830412913
                                                            r68 = r66(r4, r6)
                                                            r27 = r41[r68]
                                                            r62 = r74[r27]
                                                            r16 = r62
                                                            state = 199
                                                        end
                                                    else
                                                        if state == 199 then
                                                            state = r56
                                                            state = r16 and (200) or (201)
                                                        end
                                                    end
                                                else
                                                    if state <= 200 then
                                                        if state == 200 then
                                                            r16 = upvalueValues[r92]
                                                            r62 = upvalueValues[upvalues[2]]
                                                            r74 = upvalueValues[upvalues[3]]
                                                            r41 = "\194m\231\143ar\250"
                                                            r66 = 742870745433
                                                            r27 = r74(r41, r66)
                                                            r56 = r62[r27]
                                                            r62 = false
                                                            r16[r56] = r62
                                                            state = 201
                                                        end
                                                    else
                                                        if state == 201 then
                                                            r62 = upvalueValues[r92]
                                                            r56 = state
                                                            state = r62 and (202) or (203)
                                                            r16 = r62
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 203 then
                                                    if state <= 202 then
                                                        if state == 202 then
                                                            r74 = upvalueValues[r92]
                                                            r41 = upvalueValues[upvalues[2]]
                                                            r66 = upvalueValues[upvalues[3]]
                                                            r6 = 30182600210150
                                                            r4 = "\192\251E|p\249"
                                                            r68 = r66(r4, r6)
                                                            r27 = r41[r68]
                                                            r62 = r74[r27]
                                                            r16 = r62
                                                            state = 203
                                                        end
                                                    else
                                                        if state == 203 then
                                                            state = r56
                                                            state = r16 and (204) or (205)
                                                        end
                                                    end
                                                else
                                                    if state <= 204 then
                                                        if state == 204 then
                                                            r62 = createClosure4(375, {
                                                                r92
                                                            })
                                                            r56 = "pcall"
                                                            r16 = _env[r56]
                                                            r56 = r16(r62)
                                                            state = 205
                                                        end
                                                    else
                                                        if state == 205 then
                                                            r92 = releaseUpvalue(r92)
                                                            state = 193
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    if state <= 206 then
                                        -- createClosure3 entry 7753022 -> 206, states 206-206
                                        if state == 206 then -- entry 7753022 -> 206
                                            r37 = args[1]
                                            state = upvalueValues[upvalues[1]]
                                            r34 = "WorldToViewportPoint"
                                            r34 = state[r34]
                                            r34 = {
                                                r34(state, r37)
                                            }
                                            ReturnVal = r34[1]
                                            r61 = r34[2]
                                            r34 = ReturnVal
                                            r12 = "Vector2"
                                            ReturnVal = _env[r12]
                                            r65 = upvalueValues[upvalues[2]]
                                            r92 = upvalueValues[upvalues[3]]
                                            r62 = 7747847228951
                                            r56 = "\149Cm"
                                            r16 = r92(r56, r62)
                                            r12 = r65[r16]
                                            state = ReturnVal[r12]
                                            r92 = upvalueValues[upvalues[2]]
                                            r16 = upvalueValues[upvalues[3]]
                                            r74 = 20649426658703
                                            r62 = "\236"
                                            r56 = r16(r62, r74)
                                            r65 = r92[r56]
                                            r12 = r34[r65]
                                            r16 = upvalueValues[upvalues[2]]
                                            r56 = upvalueValues[upvalues[3]]
                                            r27 = 34257083448912
                                            r74 = "\189"
                                            r62 = r56(r74, r27)
                                            r92 = r16[r62]
                                            r65 = r34[r92]
                                            ReturnVal = state(r12, r65)
                                            ReturnVal = {
                                                ReturnVal,
                                                r61
                                            }
                                            state = nil
                                        end
                                    else
                                        -- createClosure5 entry 16420610 -> 207, states 207-210
                                        if state <= 208 then
                                            if state <= 207 then
                                                if state == 207 then -- entry 16420610 -> 207
                                                    r61 = 8
                                                    r34 = r61
                                                    state = {}
                                                    r37 = state
                                                    r61 = 1
                                                    r12 = r61
                                                    r61 = 0
                                                    r65 = r12 < r61
                                                    ReturnVal = 1
                                                    r61 = ReturnVal - r12
                                                    state = 208
                                                end
                                            else
                                                if state == 208 then
                                                    r92 = not r65
                                                    r61 = r61 + r12
                                                    ReturnVal = r61 <= r34
                                                    ReturnVal = r92 and ReturnVal
                                                    r92 = r61 >= r34
                                                    r92 = r65 and r92
                                                    ReturnVal = r92 or ReturnVal
                                                    r92 = (209)
                                                    state = ReturnVal and r92
                                                    ReturnVal = (210)
                                                    state = state or ReturnVal
                                                end
                                            end
                                        else
                                            if state <= 209 then
                                                if state == 209 then
                                                    r16 = "Drawing"
                                                    r92 = r61
                                                    ReturnVal = _env[r16]
                                                    r56 = upvalueValues[upvalues[1]]
                                                    r62 = upvalueValues[upvalues[2]]
                                                    r27 = "\025\216\161"
                                                    r41 = 27499868238341
                                                    r74 = r62(r27, r41)
                                                    r16 = r56[r74]
                                                    state = ReturnVal[r16]
                                                    r56 = upvalueValues[upvalues[1]]
                                                    r62 = upvalueValues[upvalues[2]]
                                                    r41 = 30864276142116
                                                    r27 = "d\131Cr"
                                                    r74 = r62(r27, r41)
                                                    r16 = r56[r74]
                                                    ReturnVal = state(r16)
                                                    r16 = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    r56 = upvalueValues[upvalues[2]]
                                                    r27 = 27354428092865
                                                    r74 = "\195\178\030yu"
                                                    r62 = r56(r74, r27)
                                                    state = ReturnVal[r62]
                                                    r62 = "Color3"
                                                    r56 = _env[r62]
                                                    r74 = upvalueValues[upvalues[1]]
                                                    r27 = upvalueValues[upvalues[2]]
                                                    r66 = "\026\192c\2548\026k"
                                                    r68 = 24803795971358
                                                    r41 = r27(r66, r68)
                                                    r62 = r74[r41]
                                                    ReturnVal = r56[r62]
                                                    r27 = 255
                                                    r62 = 255
                                                    r74 = 255
                                                    r56 = ReturnVal(r62, r74, r27)
                                                    r16[state] = r56
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    r56 = upvalueValues[upvalues[2]]
                                                    r74 = "\160}\223\226 Q\214\019\151"
                                                    r27 = 17677764911143
                                                    r62 = r56(r74, r27)
                                                    state = ReturnVal[r62]
                                                    ReturnVal = 1.5
                                                    r16[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    r56 = upvalueValues[upvalues[2]]
                                                    r27 = 31583677413747
                                                    r74 = "\015\234\006\128\145!u"
                                                    r62 = r56(r74, r27)
                                                    state = ReturnVal[r62]
                                                    ReturnVal = false
                                                    r16[state] = ReturnVal
                                                    state = r16
                                                    r16 = nil
                                                    r37[r92] = state
                                                    r92 = nil
                                                    state = 208
                                                end
                                            else
                                                if state == 210 then
                                                    ReturnVal = {
                                                        r37
                                                    }
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            if state <= 264 then
                                if state <= 250 then
                                    if state <= 245 then
                                        if state <= 230 then
                                            -- createClosure3 entry 3290209 -> 211, states 211-230
                                            if state <= 220 then
                                                if state <= 215 then
                                                    if state <= 213 then
                                                        if state <= 212 then
                                                            if state <= 211 then
                                                                if state == 211 then -- entry 3290209 -> 211
                                                                    state = upvalueValues[upvalues[1]]
                                                                    state = state and (212) or (213)
                                                                end
                                                            else
                                                                if state == 212 then
                                                                    state = upvalueValues[upvalues[1]]
                                                                    ReturnVal = "Disconnect"
                                                                    ReturnVal = state[ReturnVal]
                                                                    ReturnVal = ReturnVal(state)
                                                                    state = nil
                                                                    upvalueValues[upvalues[1]] = state
                                                                    state = 213
                                                                end
                                                            end
                                                        else
                                                            if state == 213 then
                                                                ReturnVal = upvalueValues[upvalues[2]]
                                                                state = ReturnVal and (214) or (215)
                                                            end
                                                        end
                                                    else
                                                        if state <= 214 then
                                                            if state == 214 then
                                                                ReturnVal = upvalueValues[upvalues[2]]
                                                                r37 = "Disconnect"
                                                                r37 = ReturnVal[r37]
                                                                r37 = r37(ReturnVal)
                                                                ReturnVal = nil
                                                                upvalueValues[upvalues[2]] = ReturnVal
                                                                state = 215
                                                            end
                                                        else
                                                            if state == 215 then
                                                                r61 = "pairs"
                                                                r37 = _env[r61]
                                                                r65 = upvalueValues[upvalues[3]]
                                                                r92 = {
                                                                    r37(r65)
                                                                }
                                                                r34 = r92[2]
                                                                r61 = r92[1]
                                                                r12 = r92[3]
                                                                state = 216
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 218 then
                                                        if state <= 217 then
                                                            if state <= 216 then
                                                                if state == 216 then
                                                                    r37 = true
                                                                    state = r37 and (217) or (218)
                                                                end
                                                            else
                                                                if state == 217 then
                                                                    r92 = {
                                                                        r61(r34, r12)
                                                                    }
                                                                    r37 = r92[1]
                                                                    r65 = r92[2]
                                                                    r16 = nil
                                                                    r92 = r37 == r16
                                                                    state = r92 and (219) or (220)
                                                                end
                                                            end
                                                        else
                                                            if state == 218 then
                                                                r12 = nil
                                                                r34 = nil
                                                                r61 = nil
                                                                ReturnVal = {}
                                                                state = nil
                                                            end
                                                        end
                                                    else
                                                        if state <= 219 then
                                                            if state == 219 then
                                                                r37 = nil
                                                                r65 = nil
                                                                state = 218
                                                            end
                                                        else
                                                            if state == 220 then
                                                                state = r65 and (221) or (222)
                                                            end
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 225 then
                                                    if state <= 223 then
                                                        if state <= 222 then
                                                            if state <= 221 then
                                                                if state == 221 then
                                                                    r16 = "pairs"
                                                                    r92 = _env[r16]
                                                                    r74 = {
                                                                        r92(r65)
                                                                    }
                                                                    r92 = r37
                                                                    r56 = r74[2]
                                                                    r16 = r74[1]
                                                                    r62 = r74[3]
                                                                    r12 = r92
                                                                    state = 223
                                                                end
                                                            else
                                                                if state == 222 then
                                                                    r16 = r37
                                                                    r12 = r16
                                                                    state = 224
                                                                end
                                                            end
                                                        else
                                                            if state == 223 then
                                                                r74 = true
                                                                state = r74 and (225) or (226)
                                                            end
                                                        end
                                                    else
                                                        if state <= 224 then
                                                            if state == 224 then
                                                                r56 = upvalueValues[upvalues[3]]
                                                                r62 = nil
                                                                r65 = nil
                                                                r56[r37] = r62
                                                                r37 = nil
                                                                state = 216
                                                            end
                                                        else
                                                            if state == 225 then
                                                                r27 = allocUpvalue()
                                                                r74 = nil
                                                                upvalueValues[r27] = r74
                                                                r66 = {
                                                                    r16(r56, r62)
                                                                }
                                                                r74 = r66[1]
                                                                r41 = r66[2]
                                                                upvalueValues[r27] = r41
                                                                r62 = r74
                                                                r68 = nil
                                                                r66 = r62 == r68
                                                                state = r66 and (227) or (228)
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 228 then
                                                        if state <= 227 then
                                                            if state <= 226 then
                                                                if state == 226 then
                                                                    r56 = nil
                                                                    r62 = nil
                                                                    r16 = nil
                                                                    state = 224
                                                                end
                                                            else
                                                                if state == 227 then
                                                                    r27 = releaseUpvalue(r27)
                                                                    state = 226
                                                                end
                                                            end
                                                        else
                                                            if state == 228 then
                                                                r66 = upvalueValues[r27]
                                                                state = r66 and (229) or (230)
                                                            end
                                                        end
                                                    else
                                                        if state <= 229 then
                                                            if state == 229 then
                                                                r4 = createClosure3(376, {
                                                                    r27,
                                                                    upvalues[4],
                                                                    upvalues[5]
                                                                })
                                                                r68 = "pcall"
                                                                r66 = _env[r68]
                                                                r68 = r66(r4)
                                                                r4 = createClosure3(377, {
                                                                    r27
                                                                })
                                                                r68 = "pcall"
                                                                r66 = _env[r68]
                                                                r68 = r66(r4)
                                                                state = 230
                                                            end
                                                        else
                                                            if state == 230 then
                                                                r27 = releaseUpvalue(r27)
                                                                state = 223
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            -- createClosure1 entry 5993548 -> 231, states 231-245
                                            if state <= 238 then
                                                if state <= 234 then
                                                    if state <= 232 then
                                                        if state <= 231 then
                                                            if state == 231 then -- entry 5993548 -> 231
                                                                r37 = args[1]
                                                                r65 = "GetChildren"
                                                                r65 = r37[r65]
                                                                ReturnVal = "ipairs"
                                                                state = _env[ReturnVal]
                                                                r12 = {
                                                                    r65(r37)
                                                                }
                                                                r65 = {
                                                                    state(unpack(r12))
                                                                }
                                                                ReturnVal = r65[1]
                                                                r34 = r65[3]
                                                                r61 = r65[2]
                                                                state = {}
                                                                r65 = state
                                                                r12 = ReturnVal
                                                                state = 232
                                                            end
                                                        else
                                                            if state == 232 then
                                                                state = true
                                                                state = state and (233) or (234)
                                                            end
                                                        end
                                                    else
                                                        if state <= 233 then
                                                            if state == 233 then
                                                                r16 = {
                                                                    r12(r61, r34)
                                                                }
                                                                ReturnVal = r16[2]
                                                                state = nil
                                                                r92 = state
                                                                state = r16[1]
                                                                r34 = state
                                                                r56 = nil
                                                                r16 = r34 == r56
                                                                state = r16 and (235) or (236)
                                                                r92 = ReturnVal
                                                            end
                                                        else
                                                            if state == 234 then
                                                                ReturnVal = {
                                                                    r65
                                                                }
                                                                state = nil
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 236 then
                                                        if state <= 235 then
                                                            if state == 235 then
                                                                r92 = nil
                                                                state = 234
                                                            end
                                                        else
                                                            if state == 236 then
                                                                r62 = upvalueValues[upvalues[1]]
                                                                r74 = upvalueValues[upvalues[2]]
                                                                r16 = "IsA"
                                                                r16 = r92[r16]
                                                                r41 = "\221,\216\"Z6A\213"
                                                                r66 = 4914633165040
                                                                r27 = r74(r41, r66)
                                                                r56 = r62[r27]
                                                                r16 = r16(r92, r56)
                                                                state = r16 and (237) or (238)
                                                            end
                                                        end
                                                    else
                                                        if state <= 237 then
                                                            if state == 237 then
                                                                r74 = upvalueValues[upvalues[1]]
                                                                r27 = upvalueValues[upvalues[2]]
                                                                r68 = 8049002794660
                                                                r66 = "\014\232\179n"
                                                                r41 = r27(r66, r68)
                                                                r62 = r74[r41]
                                                                r56 = r92[r62]
                                                                r62 = 2
                                                                r16 = r56 / r62
                                                                r27 = "Vector3"
                                                                r74 = _env[r27]
                                                                r41 = upvalueValues[upvalues[1]]
                                                                r66 = upvalueValues[upvalues[2]]
                                                                r4 = "\142\213\143"
                                                                r6 = 17103409536796
                                                                r68 = r66(r4, r6)
                                                                r27 = r41[r68]
                                                                r62 = r74[r27]
                                                                r66 = upvalueValues[upvalues[1]]
                                                                r68 = upvalueValues[upvalues[2]]
                                                                r6 = "\184"
                                                                r39 = 294817480841
                                                                r4 = r68(r6, r39)
                                                                r41 = r66[r4]
                                                                r27 = r16[r41]
                                                                r68 = upvalueValues[upvalues[1]]
                                                                r4 = upvalueValues[upvalues[2]]
                                                                r90 = 297313829002
                                                                r39 = "\212"
                                                                r6 = r4(r39, r90)
                                                                r66 = r68[r6]
                                                                r41 = r16[r66]
                                                                r4 = upvalueValues[upvalues[1]]
                                                                r6 = upvalueValues[upvalues[2]]
                                                                r13 = 767932039525
                                                                r90 = "\r"
                                                                r39 = r6(r90, r13)
                                                                r68 = r4[r39]
                                                                r66 = r16[r68]
                                                                r74 = r62(r27, r41, r66)
                                                                r41 = "Vector3"
                                                                r27 = _env[r41]
                                                                r66 = upvalueValues[upvalues[1]]
                                                                r68 = upvalueValues[upvalues[2]]
                                                                r6 = "\194\212\208"
                                                                r39 = 29493941204390
                                                                r4 = r68(r6, r39)
                                                                r41 = r66[r4]
                                                                r62 = r27[r41]
                                                                r68 = upvalueValues[upvalues[1]]
                                                                r4 = upvalueValues[upvalues[2]]
                                                                r90 = 7724504108557
                                                                r39 = "\024"
                                                                r6 = r4(r39, r90)
                                                                r66 = r68[r6]
                                                                r41 = r16[r66]
                                                                r4 = upvalueValues[upvalues[1]]
                                                                r6 = upvalueValues[upvalues[2]]
                                                                r13 = 26385883443198
                                                                r90 = "8"
                                                                r39 = r6(r90, r13)
                                                                r68 = r4[r39]
                                                                r66 = r16[r68]
                                                                r39 = upvalueValues[upvalues[1]]
                                                                r90 = upvalueValues[upvalues[2]]
                                                                r54 = "\206"
                                                                r14 = 22838114429322
                                                                r13 = r90(r54, r14)
                                                                r6 = r39[r13]
                                                                r4 = r16[r6]
                                                                r68 = -r4
                                                                r27 = r62(r41, r66, r68)
                                                                r66 = "Vector3"
                                                                r41 = _env[r66]
                                                                r68 = upvalueValues[upvalues[1]]
                                                                r4 = upvalueValues[upvalues[2]]
                                                                r39 = "\142VK"
                                                                r90 = 26097561890680
                                                                r6 = r4(r39, r90)
                                                                r66 = r68[r6]
                                                                r62 = r41[r66]
                                                                r4 = upvalueValues[upvalues[1]]
                                                                r6 = upvalueValues[upvalues[2]]
                                                                r13 = 24332177255490
                                                                r90 = "\136"
                                                                r39 = r6(r90, r13)
                                                                r68 = r4[r39]
                                                                r66 = r16[r68]
                                                                r39 = upvalueValues[upvalues[1]]
                                                                r90 = upvalueValues[upvalues[2]]
                                                                r54 = "\241"
                                                                r14 = 20959922267680
                                                                r13 = r90(r54, r14)
                                                                r6 = r39[r13]
                                                                r4 = r16[r6]
                                                                r68 = -r4
                                                                r39 = upvalueValues[upvalues[1]]
                                                                r90 = upvalueValues[upvalues[2]]
                                                                r14 = 20093855278220
                                                                r54 = "\172"
                                                                r13 = r90(r54, r14)
                                                                r6 = r39[r13]
                                                                r4 = r16[r6]
                                                                r41 = r62(r66, r68, r4)
                                                                r68 = "Vector3"
                                                                r66 = _env[r68]
                                                                r4 = upvalueValues[upvalues[1]]
                                                                r6 = upvalueValues[upvalues[2]]
                                                                r13 = 20497125139784
                                                                r90 = "\249b\195"
                                                                r39 = r6(r90, r13)
                                                                r68 = r4[r39]
                                                                r62 = r66[r68]
                                                                r6 = upvalueValues[upvalues[1]]
                                                                r39 = upvalueValues[upvalues[2]]
                                                                r54 = 33152152501325
                                                                r13 = "\023"
                                                                r90 = r39(r13, r54)
                                                                r4 = r6[r90]
                                                                r68 = r16[r4]
                                                                r90 = upvalueValues[upvalues[1]]
                                                                r13 = upvalueValues[upvalues[2]]
                                                                r67 = 31136949958819
                                                                r14 = "\156"
                                                                r54 = r13(r14, r67)
                                                                r39 = r90[r54]
                                                                r6 = r16[r39]
                                                                r4 = -r6
                                                                r13 = upvalueValues[upvalues[1]]
                                                                r54 = upvalueValues[upvalues[2]]
                                                                r84 = 23465141316270
                                                                r67 = "("
                                                                r14 = r54(r67, r84)
                                                                r90 = r13[r14]
                                                                r39 = r16[r90]
                                                                r6 = -r39
                                                                r66 = r62(r68, r4, r6)
                                                                r4 = "Vector3"
                                                                r68 = _env[r4]
                                                                r6 = upvalueValues[upvalues[1]]
                                                                r39 = upvalueValues[upvalues[2]]
                                                                r13 = "\183u\188"
                                                                r54 = 765582147940
                                                                r90 = r39(r13, r54)
                                                                r4 = r6[r90]
                                                                r62 = r68[r4]
                                                                r90 = upvalueValues[upvalues[1]]
                                                                r13 = upvalueValues[upvalues[2]]
                                                                r67 = 32367148628704
                                                                r14 = "\187"
                                                                r54 = r13(r14, r67)
                                                                r39 = r90[r54]
                                                                r6 = r16[r39]
                                                                r4 = -r6
                                                                r90 = upvalueValues[upvalues[1]]
                                                                r13 = upvalueValues[upvalues[2]]
                                                                r67 = 5432096360929
                                                                r14 = "\018"
                                                                r54 = r13(r14, r67)
                                                                r39 = r90[r54]
                                                                r6 = r16[r39]
                                                                r13 = upvalueValues[upvalues[1]]
                                                                r54 = upvalueValues[upvalues[2]]
                                                                r84 = 14880139991825
                                                                r67 = "\018"
                                                                r14 = r54(r67, r84)
                                                                r90 = r13[r14]
                                                                r39 = r16[r90]
                                                                r68 = r62(r4, r6, r39)
                                                                r6 = "Vector3"
                                                                r4 = _env[r6]
                                                                r39 = upvalueValues[upvalues[1]]
                                                                r90 = upvalueValues[upvalues[2]]
                                                                r54 = "\001\129?"
                                                                r14 = 24682644761829
                                                                r13 = r90(r54, r14)
                                                                r6 = r39[r13]
                                                                r62 = r4[r6]
                                                                r13 = upvalueValues[upvalues[1]]
                                                                r54 = upvalueValues[upvalues[2]]
                                                                r84 = 1112000397829
                                                                r67 = "\161"
                                                                r14 = r54(r67, r84)
                                                                r90 = r13[r14]
                                                                r39 = r16[r90]
                                                                r6 = -r39
                                                                r13 = upvalueValues[upvalues[1]]
                                                                r54 = upvalueValues[upvalues[2]]
                                                                r84 = 7050195995859
                                                                r67 = "4"
                                                                r14 = r54(r67, r84)
                                                                r90 = r13[r14]
                                                                r39 = r16[r90]
                                                                r14 = upvalueValues[upvalues[1]]
                                                                r67 = upvalueValues[upvalues[2]]
                                                                r91 = "\020"
                                                                r15 = 14302068627971
                                                                r84 = r67(r91, r15)
                                                                r54 = r14[r84]
                                                                r13 = r16[r54]
                                                                r90 = -r13
                                                                r4 = r62(r6, r39, r90)
                                                                r39 = "Vector3"
                                                                r6 = _env[r39]
                                                                r90 = upvalueValues[upvalues[1]]
                                                                r13 = upvalueValues[upvalues[2]]
                                                                r14 = "\129\233\238"
                                                                r67 = 18789765308973
                                                                r54 = r13(r14, r67)
                                                                r39 = r90[r54]
                                                                r62 = r6[r39]
                                                                r54 = upvalueValues[upvalues[1]]
                                                                r14 = upvalueValues[upvalues[2]]
                                                                r91 = 3449501304390
                                                                r84 = "\219"
                                                                r67 = r14(r84, r91)
                                                                r13 = r54[r67]
                                                                r90 = r16[r13]
                                                                r39 = -r90
                                                                r14 = upvalueValues[upvalues[1]]
                                                                r67 = upvalueValues[upvalues[2]]
                                                                r15 = 22049915856923
                                                                r91 = "_"
                                                                r84 = r67(r91, r15)
                                                                r54 = r14[r84]
                                                                r13 = r16[r54]
                                                                r90 = -r13
                                                                r14 = upvalueValues[upvalues[1]]
                                                                r67 = upvalueValues[upvalues[2]]
                                                                r15 = 4254819862461
                                                                r91 = "1"
                                                                r84 = r67(r91, r15)
                                                                r54 = r14[r84]
                                                                r13 = r16[r54]
                                                                r6 = r62(r39, r90, r13)
                                                                r90 = "Vector3"
                                                                r39 = _env[r90]
                                                                r13 = upvalueValues[upvalues[1]]
                                                                r54 = upvalueValues[upvalues[2]]
                                                                r84 = 2522212648086
                                                                r67 = "\158\143 "
                                                                r14 = r54(r67, r84)
                                                                r90 = r13[r14]
                                                                r62 = r39[r90]
                                                                r14 = upvalueValues[upvalues[1]]
                                                                r67 = upvalueValues[upvalues[2]]
                                                                r91 = "\246"
                                                                r15 = 26964549021964
                                                                r84 = r67(r91, r15)
                                                                r54 = r14[r84]
                                                                r13 = r16[r54]
                                                                r90 = -r13
                                                                r67 = upvalueValues[upvalues[1]]
                                                                r84 = upvalueValues[upvalues[2]]
                                                                r24 = 12303822673505
                                                                r15 = "\230"
                                                                r91 = r84(r15, r24)
                                                                r14 = r67[r91]
                                                                r54 = r16[r14]
                                                                r13 = -r54
                                                                r84 = upvalueValues[upvalues[1]]
                                                                r91 = upvalueValues[upvalues[2]]
                                                                r36 = 19625622201266
                                                                r24 = "\157"
                                                                r15 = r91(r24, r36)
                                                                r67 = r84[r15]
                                                                r14 = r16[r67]
                                                                r54 = -r14
                                                                r39 = {
                                                                    r62(r90, r13, r54)
                                                                }
                                                                r56 = {
                                                                    r74,
                                                                    r27,
                                                                    r41,
                                                                    r66,
                                                                    r68,
                                                                    r4,
                                                                    r6,
                                                                    unpack(r39)
                                                                }
                                                                r74 = "ipairs"
                                                                r62 = _env[r74]
                                                                r66 = {
                                                                    r62(r56)
                                                                }
                                                                r74 = r66[1]
                                                                r41 = r66[3]
                                                                r27 = r66[2]
                                                                state = 239
                                                            end
                                                        else
                                                            if state == 238 then
                                                                r92 = nil
                                                                state = 232
                                                            end
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 242 then
                                                    if state <= 240 then
                                                        if state <= 239 then
                                                            if state == 239 then
                                                                r62 = true
                                                                state = r62 and (240) or (241)
                                                            end
                                                        else
                                                            if state == 240 then
                                                                r4 = {
                                                                    r74(r27, r41)
                                                                }
                                                                r66 = r4[1]
                                                                r41 = r66
                                                                r68 = r4[2]
                                                                r6 = nil
                                                                r4 = r41 == r6
                                                                state = r4 and (242) or (243)
                                                                r62 = nil
                                                                r62 = r68
                                                            end
                                                        end
                                                    else
                                                        if state <= 241 then
                                                            if state == 241 then
                                                                r41 = nil
                                                                r27 = nil
                                                                r56 = nil
                                                                r74 = nil
                                                                r16 = nil
                                                                state = 238
                                                            end
                                                        else
                                                            if state == 242 then
                                                                r6 = nil
                                                                r62 = nil
                                                                r4 = nil
                                                                state = 241
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 244 then
                                                        if state <= 243 then
                                                            if state == 243 then
                                                                r39 = upvalueValues[upvalues[3]]
                                                                r67 = upvalueValues[upvalues[1]]
                                                                r84 = upvalueValues[upvalues[2]]
                                                                r15 = "\r\172!c\215>"
                                                                r24 = 27259366519189
                                                                r91 = r84(r15, r24)
                                                                r14 = r67[r91]
                                                                r54 = r92[r14]
                                                                r67 = "PointToWorldSpace"
                                                                r67 = r54[r67]
                                                                r14 = {
                                                                    r67(r54, r62)
                                                                }
                                                                r54 = {
                                                                    r39(unpack(r14))
                                                                }
                                                                r90 = r54[1]
                                                                r13 = r54[2]
                                                                r6 = r13
                                                                state = r6 and (244) or (245)
                                                                r4 = r90
                                                            end
                                                        else
                                                            if state == 244 then
                                                                r13 = "table"
                                                                r90 = _env[r13]
                                                                r54 = upvalueValues[upvalues[1]]
                                                                r14 = upvalueValues[upvalues[2]]
                                                                r91 = 12601136502507
                                                                r84 = "\028'\030\1920^"
                                                                r67 = r14(r84, r91)
                                                                r13 = r54[r67]
                                                                r39 = r90[r13]
                                                                r90 = r39(r65, r4)
                                                                state = 245
                                                            end
                                                        end
                                                    else
                                                        if state == 245 then
                                                            r62 = nil
                                                            r6 = nil
                                                            r4 = nil
                                                            state = 239
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        -- createClosure0 entry 86166 -> 246, states 246-250
                                        if state <= 248 then
                                            if state <= 247 then
                                                if state <= 246 then
                                                    if state == 246 then -- entry 86166 -> 246
                                                        ReturnVal = upvalueValues[upvalues[1]]
                                                        state = not ReturnVal
                                                        state = state and (247) or (248)
                                                    end
                                                else
                                                    if state == 247 then
                                                        ReturnVal = upvalueValues[upvalues[2]]
                                                        r61 = upvalueValues[upvalues[3]]
                                                        r34 = upvalueValues[upvalues[4]]
                                                        r92 = 31332685691134
                                                        r65 = "M\004\249\246Y\030.\158\169!\193\133\135"
                                                        r12 = r34(r65, r92)
                                                        r37 = r61[r12]
                                                        state = ReturnVal[r37]
                                                        r37 = createClosure2(378, {
                                                            upvalues[5],
                                                            upvalues[3],
                                                            upvalues[4],
                                                            upvalues[6],
                                                            upvalues[7],
                                                            upvalues[8],
                                                            upvalues[9],
                                                            upvalues[10],
                                                            upvalues[11],
                                                            upvalues[12]
                                                        })
                                                        ReturnVal = "Connect"
                                                        ReturnVal = state[ReturnVal]
                                                        ReturnVal = ReturnVal(state, r37)
                                                        upvalueValues[upvalues[1]] = ReturnVal
                                                        r37 = upvalueValues[upvalues[13]]
                                                        state = not r37
                                                        state = state and (249) or (250)
                                                    end
                                                end
                                            else
                                                if state == 248 then
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state <= 249 then
                                                if state == 249 then
                                                    r37 = upvalueValues[upvalues[6]]
                                                    r34 = upvalueValues[upvalues[3]]
                                                    r12 = upvalueValues[upvalues[4]]
                                                    r16 = 34173468556841
                                                    r92 = "\167\214\236\191\"\168\006\178\134\019\193\242\140\195"
                                                    r65 = r12(r92, r16)
                                                    r61 = r34[r65]
                                                    state = r37[r61]
                                                    r61 = createClosure5(413, {
                                                        upvalues[14]
                                                    })
                                                    r37 = "Connect"
                                                    r37 = state[r37]
                                                    r37 = r37(state, r61)
                                                    upvalueValues[upvalues[13]] = r37
                                                    state = 250
                                                end
                                            else
                                                if state == 250 then
                                                    state = 248
                                                end
                                            end
                                        end
                                    end
                                else
                                    if state <= 254 then
                                        -- createClosure3 entry 3896494 -> 251, states 251-254
                                        if state <= 252 then
                                            if state <= 251 then
                                                if state == 251 then -- entry 3896494 -> 251
                                                    r37 = args[1]
                                                    state = r37 and (252) or (253)
                                                end
                                            else
                                                if state == 252 then
                                                    state = upvalueValues[upvalues[1]]
                                                    ReturnVal = state()
                                                    ReturnVal = "print"
                                                    state = _env[ReturnVal]
                                                    r34 = upvalueValues[upvalues[2]]
                                                    r12 = upvalueValues[upvalues[3]]
                                                    r92 = "\028XD\241c\215\000\213T4@K\148x\152\184z 9"
                                                    r16 = 20558032069989
                                                    r65 = r12(r92, r16)
                                                    r61 = r34[r65]
                                                    ReturnVal = state(r61)
                                                    state = 254
                                                end
                                            end
                                        else
                                            if state <= 253 then
                                                if state == 253 then
                                                    state = upvalueValues[upvalues[4]]
                                                    ReturnVal = state()
                                                    ReturnVal = "print"
                                                    state = _env[ReturnVal]
                                                    r34 = upvalueValues[upvalues[2]]
                                                    r12 = upvalueValues[upvalues[3]]
                                                    r92 = "C5F\218\145\153\014R6\228P\226p\178-\235\177\023\232\164\202\213"
                                                    r16 = 13971302635881
                                                    r65 = r12(r92, r16)
                                                    r61 = r34[r65]
                                                    ReturnVal = state(r61)
                                                    state = 254
                                                end
                                            else
                                                if state == 254 then
                                                    r37 = nil
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        end
                                    else
                                        -- createClosure5 entry 11422048 -> 255, states 255-264
                                        if state <= 259 then
                                            if state <= 257 then
                                                if state <= 256 then
                                                    if state <= 255 then
                                                        if state == 255 then -- entry 11422048 -> 255
                                                            state = upvalueValues[upvalues[1]]
                                                            state = state and (256) or (257)
                                                        end
                                                    else
                                                        if state == 256 then
                                                            state = upvalueValues[upvalues[1]]
                                                            ReturnVal = "Disconnect"
                                                            ReturnVal = state[ReturnVal]
                                                            ReturnVal = ReturnVal(state)
                                                            state = nil
                                                            upvalueValues[upvalues[1]] = state
                                                            state = 257
                                                        end
                                                    end
                                                else
                                                    if state == 257 then
                                                        r37 = "pairs"
                                                        ReturnVal = _env[r37]
                                                        r12 = upvalueValues[upvalues[2]]
                                                        r65 = {
                                                            ReturnVal(r12)
                                                        }
                                                        r61 = r65[2]
                                                        r34 = r65[3]
                                                        r37 = r65[1]
                                                        state = 258
                                                    end
                                                end
                                            else
                                                if state <= 258 then
                                                    if state == 258 then
                                                        ReturnVal = true
                                                        state = ReturnVal and (259) or (260)
                                                    end
                                                else
                                                    if state == 259 then
                                                        r12 = allocUpvalue()
                                                        ReturnVal = nil
                                                        upvalueValues[r12] = ReturnVal
                                                        r92 = {
                                                            r37(r61, r34)
                                                        }
                                                        ReturnVal = r92[1]
                                                        r65 = r92[2]
                                                        upvalueValues[r12] = r65
                                                        r34 = ReturnVal
                                                        r16 = nil
                                                        r92 = r34 == r16
                                                        state = r92 and (261) or (262)
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 262 then
                                                if state <= 261 then
                                                    if state <= 260 then
                                                        if state == 260 then
                                                            r37 = nil
                                                            r34 = nil
                                                            r61 = nil
                                                            ReturnVal = {}
                                                            state = nil
                                                        end
                                                    else
                                                        if state == 261 then
                                                            r12 = releaseUpvalue(r12)
                                                            state = 260
                                                        end
                                                    end
                                                else
                                                    if state == 262 then
                                                        r92 = upvalueValues[r12]
                                                        state = r92 and (263) or (264)
                                                    end
                                                end
                                            else
                                                if state <= 263 then
                                                    if state == 263 then
                                                        r56 = createClosure0(414, {
                                                            r12,
                                                            upvalues[3],
                                                            upvalues[4]
                                                        })
                                                        r16 = "pcall"
                                                        r92 = _env[r16]
                                                        r16 = r92(r56)
                                                        r56 = createClosure0(415, {
                                                            r12
                                                        })
                                                        r16 = "pcall"
                                                        r92 = _env[r16]
                                                        r16 = r92(r56)
                                                        state = 264
                                                    end
                                                else
                                                    if state == 264 then
                                                        r92 = upvalueValues[upvalues[2]]
                                                        r12 = releaseUpvalue(r12)
                                                        r16 = nil
                                                        r92[r34] = r16
                                                        state = 258
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 271 then
                                    if state <= 268 then
                                        if state <= 265 then
                                            -- createClosure4 entry 15196311 -> 265, states 265-265
                                            if state == 265 then -- entry 15196311 -> 265
                                                r37 = "Drawing"
                                                ReturnVal = _env[r37]
                                                r61 = upvalueValues[upvalues[1]]
                                                r34 = upvalueValues[upvalues[2]]
                                                r92 = 29780710012459
                                                r65 = "\255\n\174"
                                                r12 = r34(r65, r92)
                                                r37 = r61[r12]
                                                state = ReturnVal[r37]
                                                r61 = upvalueValues[upvalues[1]]
                                                r34 = upvalueValues[upvalues[2]]
                                                r92 = 25210133048795
                                                r65 = "9N\220\222"
                                                r12 = r34(r65, r92)
                                                r37 = r61[r12]
                                                ReturnVal = state(r37)
                                                r37 = ReturnVal
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                r61 = upvalueValues[upvalues[2]]
                                                r12 = "p2\194j8"
                                                r65 = 3622009194134
                                                r34 = r61(r12, r65)
                                                state = ReturnVal[r34]
                                                ReturnVal = upvalueValues[upvalues[3]]
                                                r37[state] = ReturnVal
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                r61 = upvalueValues[upvalues[2]]
                                                r12 = "\237\166\210\0024\171m2\026"
                                                r65 = 24778938117394
                                                r34 = r61(r12, r65)
                                                state = ReturnVal[r34]
                                                ReturnVal = upvalueValues[upvalues[4]]
                                                r37[state] = ReturnVal
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                r61 = upvalueValues[upvalues[2]]
                                                r12 = "o<0\214\188CJb\222?\137\220"
                                                r65 = 21358446634713
                                                r34 = r61(r12, r65)
                                                state = ReturnVal[r34]
                                                ReturnVal = 1
                                                r37[state] = ReturnVal
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                r61 = upvalueValues[upvalues[2]]
                                                r65 = 24862005079353
                                                r12 = "\145\132#<\016\149\167"
                                                r34 = r61(r12, r65)
                                                state = ReturnVal[r34]
                                                ReturnVal = false
                                                r37[state] = ReturnVal
                                                ReturnVal = {
                                                    r37
                                                }
                                                state = nil
                                            end
                                        else
                                            -- createClosure2 entry 12693531 -> 266, states 266-268
                                            if state <= 267 then
                                                if state <= 266 then
                                                    if state == 266 then -- entry 12693531 -> 266
                                                        ReturnVal = upvalueValues[upvalues[1]]
                                                        r37 = args[1]
                                                        r61 = allocUpvalue()
                                                        state = ReturnVal[r37]
                                                        upvalueValues[r61] = state
                                                        state = upvalueValues[r61]
                                                        state = state and (267) or (268)
                                                    end
                                                else
                                                    if state == 267 then
                                                        r34 = createClosure1(416, {
                                                            r61,
                                                            upvalues[2],
                                                            upvalues[3]
                                                        })
                                                        ReturnVal = "pcall"
                                                        state = _env[ReturnVal]
                                                        ReturnVal = state(r34)
                                                        ReturnVal = "pcall"
                                                        state = _env[ReturnVal]
                                                        r34 = createClosure4(417, {
                                                            r61
                                                        })
                                                        ReturnVal = state(r34)
                                                        state = upvalueValues[upvalues[1]]
                                                        ReturnVal = nil
                                                        state[r37] = ReturnVal
                                                        state = 268
                                                    end
                                                end
                                            else
                                                if state == 268 then
                                                    r37 = nil
                                                    ReturnVal = {}
                                                    r61 = releaseUpvalue(r61)
                                                    state = nil
                                                end
                                            end
                                        end
                                    else
                                        -- createClosure1 entry 12799715 -> 269, states 269-271
                                        if state <= 270 then
                                            if state <= 269 then
                                                if state == 269 then -- entry 12799715 -> 269
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    state = not ReturnVal
                                                    state = state and (270) or (271)
                                                end
                                            else
                                                if state == 270 then
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r61 = upvalueValues[upvalues[3]]
                                                    r34 = upvalueValues[upvalues[4]]
                                                    r92 = 13459338090619
                                                    r65 = "p\2119p\183l\168\024\219\228eQ\156"
                                                    r12 = r34(r65, r92)
                                                    r37 = r61[r12]
                                                    state = ReturnVal[r37]
                                                    r37 = createClosure2(418, {
                                                        upvalues[5],
                                                        upvalues[3],
                                                        upvalues[4],
                                                        upvalues[6],
                                                        upvalues[7],
                                                        upvalues[8],
                                                        upvalues[9],
                                                        upvalues[10]
                                                    })
                                                    ReturnVal = "Connect"
                                                    ReturnVal = state[ReturnVal]
                                                    ReturnVal = ReturnVal(state, r37)
                                                    upvalueValues[upvalues[1]] = ReturnVal
                                                    state = 271
                                                end
                                            end
                                        else
                                            if state == 271 then
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    if state <= 272 then
                                        -- createClosure3 entry 6748536 -> 272, states 272-272
                                        if state == 272 then -- entry 6748536 -> 272
                                            r37 = args[1]
                                            state = upvalueValues[upvalues[1]]
                                            ReturnVal = state(r37)
                                            r37 = nil
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    else
                                        -- createClosure1 entry 10493013 -> 273, states 273-276
                                        if state <= 274 then
                                            if state <= 273 then
                                                if state == 273 then -- entry 10493013 -> 273
                                                    r37 = args[1]
                                                    state = r37 and (274) or (275)
                                                end
                                            else
                                                if state == 274 then
                                                    state = upvalueValues[upvalues[1]]
                                                    ReturnVal = state()
                                                    ReturnVal = "print"
                                                    state = _env[ReturnVal]
                                                    r34 = upvalueValues[upvalues[2]]
                                                    r12 = upvalueValues[upvalues[3]]
                                                    r92 = "\227\1571\204\"\159lW.z\246\001\190\184\200Y"
                                                    r16 = 18139962220799
                                                    r65 = r12(r92, r16)
                                                    r61 = r34[r65]
                                                    ReturnVal = state(r61)
                                                    state = 276
                                                end
                                            end
                                        else
                                            if state <= 275 then
                                                if state == 275 then
                                                    state = upvalueValues[upvalues[4]]
                                                    ReturnVal = state()
                                                    ReturnVal = "print"
                                                    state = _env[ReturnVal]
                                                    r34 = upvalueValues[upvalues[2]]
                                                    r12 = upvalueValues[upvalues[3]]
                                                    r16 = 12132115158545
                                                    r92 = "@\233\024\215}lq\128<\tF\1611\162\028\140\224x\233"
                                                    r65 = r12(r92, r16)
                                                    r61 = r34[r65]
                                                    ReturnVal = state(r61)
                                                    state = 276
                                                end
                                            else
                                                if state == 276 then
                                                    r37 = nil
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                else
                    if state <= 365 then
                        if state <= 313 then
                            if state <= 302 then
                                if state <= 298 then
                                    if state <= 287 then
                                        if state <= 277 then
                                            -- createClosure3 entry 13600250 -> 277, states 277-277
                                            if state == 277 then -- entry 13600250 -> 277
                                                r37 = "Drawing"
                                                ReturnVal = _env[r37]
                                                r61 = upvalueValues[upvalues[1]]
                                                r34 = upvalueValues[upvalues[2]]
                                                r65 = "\008\018\250"
                                                r92 = 34047033376238
                                                r12 = r34(r65, r92)
                                                r37 = r61[r12]
                                                state = ReturnVal[r37]
                                                r61 = upvalueValues[upvalues[1]]
                                                r34 = upvalueValues[upvalues[2]]
                                                r65 = "\200\131\008\225\161u"
                                                r92 = 29616499504607
                                                r12 = r34(r65, r92)
                                                r37 = r61[r12]
                                                ReturnVal = state(r37)
                                                r37 = ReturnVal
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                r61 = upvalueValues[upvalues[2]]
                                                r65 = 14875121212174
                                                r12 = "h3\031A\148A\196F;"
                                                r34 = r61(r12, r65)
                                                state = ReturnVal[r34]
                                                ReturnVal = 0
                                                r37[state] = ReturnVal
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                r61 = upvalueValues[upvalues[2]]
                                                r12 = "\214g\132k\135\020"
                                                r65 = 13013920815020
                                                r34 = r61(r12, r65)
                                                state = ReturnVal[r34]
                                                ReturnVal = true
                                                r37[state] = ReturnVal
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                r61 = upvalueValues[upvalues[2]]
                                                r65 = 14520395356777
                                                r12 = "\250h\130&\220"
                                                r34 = r61(r12, r65)
                                                state = ReturnVal[r34]
                                                r34 = "Color3"
                                                r61 = _env[r34]
                                                r12 = upvalueValues[upvalues[1]]
                                                r65 = upvalueValues[upvalues[2]]
                                                r16 = "x\194\136h\235\247\236"
                                                r56 = 31584440007027
                                                r92 = r65(r16, r56)
                                                r34 = r12[r92]
                                                ReturnVal = r61[r34]
                                                r65 = 70
                                                r12 = 70
                                                r34 = 70
                                                r61 = ReturnVal(r34, r12, r65)
                                                r37[state] = r61
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                r61 = upvalueValues[upvalues[2]]
                                                r12 = "*\209\255\179%+m"
                                                r65 = 8045670108834
                                                r34 = r61(r12, r65)
                                                state = ReturnVal[r34]
                                                ReturnVal = false
                                                r37[state] = ReturnVal
                                                r61 = "Drawing"
                                                ReturnVal = _env[r61]
                                                r34 = upvalueValues[upvalues[1]]
                                                r12 = upvalueValues[upvalues[2]]
                                                r16 = 15086217845617
                                                r92 = "D\166\005"
                                                r65 = r12(r92, r16)
                                                r61 = r34[r65]
                                                state = ReturnVal[r61]
                                                r34 = upvalueValues[upvalues[1]]
                                                r12 = upvalueValues[upvalues[2]]
                                                r92 = "~\220\129y\233\193"
                                                r16 = 6193395960644
                                                r65 = r12(r92, r16)
                                                r61 = r34[r65]
                                                ReturnVal = state(r61)
                                                r61 = ReturnVal
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                r34 = upvalueValues[upvalues[2]]
                                                r92 = 2747674477823
                                                r65 = "\192\253\189z]9k\008\""
                                                r12 = r34(r65, r92)
                                                state = ReturnVal[r12]
                                                ReturnVal = 0
                                                r61[state] = ReturnVal
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                r34 = upvalueValues[upvalues[2]]
                                                r65 = "\162^M\196\027\240"
                                                r92 = 34763468308284
                                                r12 = r34(r65, r92)
                                                state = ReturnVal[r12]
                                                ReturnVal = true
                                                r61[state] = ReturnVal
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                r34 = upvalueValues[upvalues[2]]
                                                r65 = "\203\227\132\236Y"
                                                r92 = 31120649123995
                                                r12 = r34(r65, r92)
                                                state = ReturnVal[r12]
                                                r12 = "Color3"
                                                r34 = _env[r12]
                                                r65 = upvalueValues[upvalues[1]]
                                                r92 = upvalueValues[upvalues[2]]
                                                r56 = "\171^t\219?\199\164"
                                                r62 = 1374753784448
                                                r16 = r92(r56, r62)
                                                r12 = r65[r16]
                                                ReturnVal = r34[r12]
                                                r12 = 0
                                                r65 = 255
                                                r92 = 0
                                                r34 = ReturnVal(r12, r65, r92)
                                                r61[state] = r34
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                r34 = upvalueValues[upvalues[2]]
                                                r65 = "\247\146f\027\025U\189"
                                                r92 = 5705615182432
                                                r12 = r34(r65, r92)
                                                state = ReturnVal[r12]
                                                ReturnVal = false
                                                r61[state] = ReturnVal
                                                r34 = upvalueValues[upvalues[1]]
                                                r12 = upvalueValues[upvalues[2]]
                                                r16 = 27777632236166
                                                r92 = "\002@"
                                                r65 = r12(r92, r16)
                                                ReturnVal = r34[r65]
                                                r12 = upvalueValues[upvalues[1]]
                                                r65 = upvalueValues[upvalues[2]]
                                                r56 = 16230730718598
                                                r16 = "\223\174\217"
                                                r92 = r65(r16, r56)
                                                r34 = r12[r92]
                                                state = {
                                                    [ReturnVal] = r37,
                                                    [r34] = r61
                                                }
                                                ReturnVal = {
                                                    state
                                                }
                                                state = nil
                                            end
                                        else
                                            -- createClosure2 entry 2887692 -> 278, states 278-287
                                            if state <= 282 then
                                                if state <= 280 then
                                                    if state <= 279 then
                                                        if state <= 278 then
                                                            if state == 278 then -- entry 2887692 -> 278
                                                                state = upvalueValues[upvalues[1]]
                                                                state = state and (279) or (280)
                                                            end
                                                        else
                                                            if state == 279 then
                                                                state = upvalueValues[upvalues[1]]
                                                                ReturnVal = "Disconnect"
                                                                ReturnVal = state[ReturnVal]
                                                                ReturnVal = ReturnVal(state)
                                                                state = nil
                                                                upvalueValues[upvalues[1]] = state
                                                                state = 280
                                                            end
                                                        end
                                                    else
                                                        if state == 280 then
                                                            r37 = "pairs"
                                                            ReturnVal = _env[r37]
                                                            r12 = upvalueValues[upvalues[2]]
                                                            r65 = {
                                                                ReturnVal(r12)
                                                            }
                                                            r34 = r65[3]
                                                            r37 = r65[1]
                                                            r61 = r65[2]
                                                            state = 281
                                                        end
                                                    end
                                                else
                                                    if state <= 281 then
                                                        if state == 281 then
                                                            ReturnVal = true
                                                            state = ReturnVal and (282) or (283)
                                                        end
                                                    else
                                                        if state == 282 then
                                                            r12 = allocUpvalue()
                                                            ReturnVal = nil
                                                            upvalueValues[r12] = ReturnVal
                                                            r92 = {
                                                                r37(r61, r34)
                                                            }
                                                            ReturnVal = r92[1]
                                                            r65 = r92[2]
                                                            upvalueValues[r12] = r65
                                                            r34 = ReturnVal
                                                            r16 = nil
                                                            r92 = r34 == r16
                                                            state = r92 and (284) or (285)
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 285 then
                                                    if state <= 284 then
                                                        if state <= 283 then
                                                            if state == 283 then
                                                                r61 = nil
                                                                r34 = nil
                                                                r37 = nil
                                                                ReturnVal = {}
                                                                state = nil
                                                            end
                                                        else
                                                            if state == 284 then
                                                                r12 = releaseUpvalue(r12)
                                                                state = 283
                                                            end
                                                        end
                                                    else
                                                        if state == 285 then
                                                            r92 = upvalueValues[r12]
                                                            state = r92 and (286) or (287)
                                                        end
                                                    end
                                                else
                                                    if state <= 286 then
                                                        if state == 286 then
                                                            r56 = createClosure4(461, {
                                                                r12,
                                                                upvalues[3],
                                                                upvalues[4]
                                                            })
                                                            r16 = "pcall"
                                                            r92 = _env[r16]
                                                            r16 = r92(r56)
                                                            r16 = "pcall"
                                                            r92 = _env[r16]
                                                            r56 = createClosure4(462, {
                                                                r12,
                                                                upvalues[3],
                                                                upvalues[4]
                                                            })
                                                            r16 = r92(r56)
                                                            r16 = "pcall"
                                                            r92 = _env[r16]
                                                            r56 = createClosure1(463, {
                                                                r12,
                                                                upvalues[3],
                                                                upvalues[4]
                                                            })
                                                            r16 = r92(r56)
                                                            r56 = createClosure4(466, {
                                                                r12,
                                                                upvalues[3],
                                                                upvalues[4]
                                                            })
                                                            r16 = "pcall"
                                                            r92 = _env[r16]
                                                            r16 = r92(r56)
                                                            state = 287
                                                        end
                                                    else
                                                        if state == 287 then
                                                            r92 = upvalueValues[upvalues[2]]
                                                            r16 = nil
                                                            r92[r34] = r16
                                                            r12 = releaseUpvalue(r12)
                                                            state = 281
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        -- createClosure6 entry 5115929 -> 288, states 288-298
                                        if state <= 293 then
                                            if state <= 290 then
                                                if state <= 289 then
                                                    if state <= 288 then
                                                        if state == 288 then -- entry 5115929 -> 288
                                                            r61 = allocUpvalue()
                                                            ReturnVal = upvalueValues[upvalues[1]]
                                                            r37 = args[1]
                                                            state = ReturnVal[r37]
                                                            upvalueValues[r61] = state
                                                            state = upvalueValues[r61]
                                                            state = state and (289) or (290)
                                                        end
                                                    else
                                                        if state == 289 then
                                                            r12 = upvalueValues[r61]
                                                            r92 = upvalueValues[upvalues[2]]
                                                            r16 = upvalueValues[upvalues[3]]
                                                            r62 = "\156\012"
                                                            r74 = 17907024879762
                                                            r56 = r16(r62, r74)
                                                            r65 = r92[r56]
                                                            r34 = r12[r65]
                                                            state = r34 and (291) or (292)
                                                            ReturnVal = r34
                                                        end
                                                    end
                                                else
                                                    if state == 290 then
                                                        r61 = releaseUpvalue(r61)
                                                        r37 = nil
                                                        ReturnVal = {}
                                                        state = nil
                                                    end
                                                end
                                            else
                                                if state <= 292 then
                                                    if state <= 291 then
                                                        if state == 291 then
                                                            r65 = upvalueValues[r61]
                                                            r16 = upvalueValues[upvalues[2]]
                                                            r56 = upvalueValues[upvalues[3]]
                                                            r74 = "\1832"
                                                            r27 = 23423711816347
                                                            r62 = r56(r74, r27)
                                                            r92 = r16[r62]
                                                            r12 = r65[r92]
                                                            r92 = upvalueValues[upvalues[2]]
                                                            r16 = upvalueValues[upvalues[3]]
                                                            r74 = 24732369677564
                                                            r62 = "\235\164\141p\r\021"
                                                            r56 = r16(r62, r74)
                                                            r65 = r92[r56]
                                                            r34 = r12[r65]
                                                            ReturnVal = r34
                                                            state = 292
                                                        end
                                                    else
                                                        if state == 292 then
                                                            state = ReturnVal and (293) or (294)
                                                        end
                                                    end
                                                else
                                                    if state == 293 then
                                                        ReturnVal = "pcall"
                                                        state = _env[ReturnVal]
                                                        r34 = createClosure0(469, {
                                                            r61,
                                                            upvalues[2],
                                                            upvalues[3]
                                                        })
                                                        ReturnVal = state(r34)
                                                        state = 294
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 296 then
                                                if state <= 295 then
                                                    if state <= 294 then
                                                        if state == 294 then
                                                            r12 = upvalueValues[r61]
                                                            r92 = upvalueValues[upvalues[2]]
                                                            r16 = upvalueValues[upvalues[3]]
                                                            r62 = "\204\158\176"
                                                            r74 = 4443451361301
                                                            r56 = r16(r62, r74)
                                                            r65 = r92[r56]
                                                            r34 = r12[r65]
                                                            state = r34 and (295) or (296)
                                                            ReturnVal = r34
                                                        end
                                                    else
                                                        if state == 295 then
                                                            r65 = upvalueValues[r61]
                                                            r16 = upvalueValues[upvalues[2]]
                                                            r56 = upvalueValues[upvalues[3]]
                                                            r74 = "o~\030"
                                                            r27 = 12020939150813
                                                            r62 = r56(r74, r27)
                                                            r92 = r16[r62]
                                                            r12 = r65[r92]
                                                            r92 = upvalueValues[upvalues[2]]
                                                            r16 = upvalueValues[upvalues[3]]
                                                            r62 = ",\020{P^Y"
                                                            r74 = 27757128462973
                                                            r56 = r16(r62, r74)
                                                            r65 = r92[r56]
                                                            r34 = r12[r65]
                                                            ReturnVal = r34
                                                            state = 296
                                                        end
                                                    end
                                                else
                                                    if state == 296 then
                                                        state = ReturnVal and (297) or (298)
                                                    end
                                                end
                                            else
                                                if state <= 297 then
                                                    if state == 297 then
                                                        r34 = createClosure3(470, {
                                                            r61,
                                                            upvalues[2],
                                                            upvalues[3]
                                                        })
                                                        ReturnVal = "pcall"
                                                        state = _env[ReturnVal]
                                                        ReturnVal = state(r34)
                                                        state = 298
                                                    end
                                                else
                                                    if state == 298 then
                                                        state = upvalueValues[upvalues[1]]
                                                        ReturnVal = nil
                                                        state[r37] = ReturnVal
                                                        state = 290
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    if state <= 301 then
                                        -- createClosure0 entry 13010184 -> 299, states 299-301
                                        if state <= 300 then
                                            if state <= 299 then
                                                if state == 299 then -- entry 13010184 -> 299
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    state = not ReturnVal
                                                    state = state and (300) or (301)
                                                end
                                            else
                                                if state == 300 then
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r61 = upvalueValues[upvalues[3]]
                                                    r34 = upvalueValues[upvalues[4]]
                                                    r65 = "n\149\r\130O|\140m\020\230\021\011\130"
                                                    r92 = 24519641689241
                                                    r12 = r34(r65, r92)
                                                    r37 = r61[r12]
                                                    state = ReturnVal[r37]
                                                    r37 = createClosure2(471, {
                                                        upvalues[5],
                                                        upvalues[3],
                                                        upvalues[4],
                                                        upvalues[6],
                                                        upvalues[7],
                                                        upvalues[8],
                                                        upvalues[9],
                                                        upvalues[10],
                                                        upvalues[11]
                                                    })
                                                    ReturnVal = "Connect"
                                                    ReturnVal = state[ReturnVal]
                                                    ReturnVal = ReturnVal(state, r37)
                                                    upvalueValues[upvalues[1]] = ReturnVal
                                                    state = 301
                                                end
                                            end
                                        else
                                            if state == 301 then
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    else
                                        -- createClosure4 entry 239012 -> 302, states 302-302
                                        if state == 302 then -- entry 239012 -> 302
                                            state = upvalueValues[upvalues[1]]
                                            r37 = args[1]
                                            ReturnVal = state(r37)
                                            r37 = nil
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                end
                            else
                                if state <= 311 then
                                    if state <= 310 then
                                        if state <= 306 then
                                            -- createClosure6 entry 15497022 -> 303, states 303-306
                                            if state <= 304 then
                                                if state <= 303 then
                                                    if state == 303 then -- entry 15497022 -> 303
                                                        r37 = args[1]
                                                        state = r37 and (304) or (305)
                                                    end
                                                else
                                                    if state == 304 then
                                                        state = upvalueValues[upvalues[1]]
                                                        ReturnVal = state()
                                                        ReturnVal = "print"
                                                        state = _env[ReturnVal]
                                                        r34 = upvalueValues[upvalues[2]]
                                                        r12 = upvalueValues[upvalues[3]]
                                                        r92 = "\1915\198\007=%C\153q\024\136\015)\159A\218\228\179"
                                                        r16 = 31127676221598
                                                        r65 = r12(r92, r16)
                                                        r61 = r34[r65]
                                                        ReturnVal = state(r61)
                                                        state = 306
                                                    end
                                                end
                                            else
                                                if state <= 305 then
                                                    if state == 305 then
                                                        state = upvalueValues[upvalues[4]]
                                                        ReturnVal = state()
                                                        ReturnVal = "print"
                                                        state = _env[ReturnVal]
                                                        r34 = upvalueValues[upvalues[2]]
                                                        r12 = upvalueValues[upvalues[3]]
                                                        r92 = "\252\211\196\196UK\161\167\156\223\213\229F\231{\156\012\220\021\"\245"
                                                        r16 = 32770847259548
                                                        r65 = r12(r92, r16)
                                                        r61 = r34[r65]
                                                        ReturnVal = state(r61)
                                                        state = 306
                                                    end
                                                else
                                                    if state == 306 then
                                                        r37 = nil
                                                        ReturnVal = {}
                                                        state = nil
                                                    end
                                                end
                                            end
                                        else
                                            -- createClosure1 entry 14990912 -> 307, states 307-310
                                            if state <= 308 then
                                                if state <= 307 then
                                                    if state == 307 then -- entry 14990912 -> 307
                                                        ReturnVal = upvalueValues[upvalues[1]]
                                                        r37 = upvalueValues[upvalues[2]]
                                                        r12 = 23768435960636
                                                        r34 = "\132\017\008\211\181b0\243\250q\028\197\149\135\161\223Js\020\191\246\209\193\002\160\202\174Oa"
                                                        r61 = r37(r34, r12)
                                                        state = ReturnVal[r61]
                                                        r37 = state
                                                        ReturnVal = "setclipboard"
                                                        state = _env[ReturnVal]
                                                        state = state and (308) or (309)
                                                    end
                                                else
                                                    if state == 308 then
                                                        ReturnVal = "setclipboard"
                                                        state = _env[ReturnVal]
                                                        ReturnVal = state(r37)
                                                        ReturnVal = "game"
                                                        state = _env[ReturnVal]
                                                        r34 = upvalueValues[upvalues[1]]
                                                        r12 = upvalueValues[upvalues[2]]
                                                        r16 = 1151012700695
                                                        r92 = "b \243\016Msh\n@\028"
                                                        r65 = r12(r92, r16)
                                                        ReturnVal = "GetService"
                                                        ReturnVal = state[ReturnVal]
                                                        r61 = r34[r65]
                                                        ReturnVal = ReturnVal(state, r61)
                                                        r34 = upvalueValues[upvalues[1]]
                                                        r12 = upvalueValues[upvalues[2]]
                                                        r92 = "\131F\246\171\025\243\172\012GwY+\1622\170\193"
                                                        r16 = 14958519180085
                                                        r65 = r12(r92, r16)
                                                        r61 = r34[r65]
                                                        r65 = upvalueValues[upvalues[1]]
                                                        r92 = upvalueValues[upvalues[2]]
                                                        r56 = "\153\194\148\179>"
                                                        r62 = 32440091179778
                                                        r16 = r92(r56, r62)
                                                        r12 = r65[r16]
                                                        r92 = upvalueValues[upvalues[1]]
                                                        r16 = upvalueValues[upvalues[2]]
                                                        r62 = ",\199\160\001\1689\152"
                                                        r74 = 34801781473101
                                                        r56 = r16(r62, r74)
                                                        r65 = r92[r56]
                                                        r16 = upvalueValues[upvalues[1]]
                                                        r56 = upvalueValues[upvalues[2]]
                                                        r27 = 8348618690351
                                                        r74 = "u\n\0280"
                                                        r62 = r56(r74, r27)
                                                        r92 = r16[r62]
                                                        r56 = upvalueValues[upvalues[1]]
                                                        r62 = upvalueValues[upvalues[2]]
                                                        r41 = 26085993131891
                                                        r27 = "\025\1712p\242S\028\207\202N\214e78R\024\163\001\156\022\012\223s\022\170x\031\210\026Ci\172o\030\158b"
                                                        r74 = r62(r27, r41)
                                                        r16 = r56[r74]
                                                        r62 = upvalueValues[upvalues[1]]
                                                        r74 = upvalueValues[upvalues[2]]
                                                        r66 = 14772421925598
                                                        r41 = "\168\161\"\174\1963F\177"
                                                        r27 = r74(r41, r66)
                                                        r56 = r62[r27]
                                                        state = "SetCore"
                                                        state = ReturnVal[state]
                                                        r62 = 4
                                                        r34 = {
                                                            [r12] = r65,
                                                            [r92] = r16,
                                                            [r56] = r62
                                                        }
                                                        state = state(ReturnVal, r61, r34)
                                                        state = 310
                                                    end
                                                end
                                            else
                                                if state <= 309 then
                                                    if state == 309 then
                                                        ReturnVal = "print"
                                                        state = _env[ReturnVal]
                                                        r12 = upvalueValues[upvalues[1]]
                                                        r65 = upvalueValues[upvalues[2]]
                                                        r56 = 11575703033102
                                                        r16 = "o\207\184\127t\002"
                                                        r92 = r65(r16, r56)
                                                        r34 = r12[r92]
                                                        r61 = r34 .. r37
                                                        ReturnVal = state(r61)
                                                        state = 310
                                                    end
                                                else
                                                    if state == 310 then
                                                        r37 = nil
                                                        ReturnVal = {}
                                                        state = nil
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        -- createClosure1 entry 14551376 -> 311, states 311-311
                                        if state == 311 then -- entry 14551376 -> 311
                                            state = upvalueValues[upvalues[1]]
                                            r37 = upvalueValues[upvalues[2]]
                                            r61 = upvalueValues[upvalues[3]]
                                            r65 = 4545705347140
                                            r12 = "\191l\156x]\217D"
                                            r34 = r61(r12, r65)
                                            ReturnVal = r37[r34]
                                            r37 = true
                                            state[ReturnVal] = r37
                                            state = upvalueValues[upvalues[4]]
                                            r37 = upvalueValues[upvalues[2]]
                                            r61 = upvalueValues[upvalues[3]]
                                            r12 = "@\015\146\019\020\135\166"
                                            r65 = 11006875849733
                                            r34 = r61(r12, r65)
                                            ReturnVal = r37[r34]
                                            r37 = false
                                            state[ReturnVal] = r37
                                            state = upvalueValues[upvalues[5]]
                                            r37 = upvalueValues[upvalues[2]]
                                            r61 = upvalueValues[upvalues[3]]
                                            r65 = 16573750369829
                                            r12 = "\143{DC*gv"
                                            r34 = r61(r12, r65)
                                            ReturnVal = r37[r34]
                                            r37 = true
                                            state[ReturnVal] = r37
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                else
                                    if state <= 312 then
                                        -- createClosure1 entry 6776392 -> 312, states 312-312
                                        if state == 312 then -- entry 6776392 -> 312
                                            state = upvalueValues[upvalues[1]]
                                            r37 = upvalueValues[upvalues[2]]
                                            r61 = upvalueValues[upvalues[3]]
                                            r12 = "\197\023\216\153\211\181!"
                                            r65 = 8024523837080
                                            r34 = r61(r12, r65)
                                            ReturnVal = r37[r34]
                                            r37 = false
                                            state[ReturnVal] = r37
                                            state = upvalueValues[upvalues[4]]
                                            r37 = upvalueValues[upvalues[2]]
                                            r61 = upvalueValues[upvalues[3]]
                                            r65 = 18097538605291
                                            r12 = "b\150,E.5\007"
                                            r34 = r61(r12, r65)
                                            ReturnVal = r37[r34]
                                            r37 = true
                                            state[ReturnVal] = r37
                                            state = upvalueValues[upvalues[5]]
                                            r37 = upvalueValues[upvalues[2]]
                                            r61 = upvalueValues[upvalues[3]]
                                            r65 = 794247168369
                                            r12 = "F\216U\218x\183\221"
                                            r34 = r61(r12, r65)
                                            ReturnVal = r37[r34]
                                            r37 = false
                                            state[ReturnVal] = r37
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    else
                                        -- createClosure4 entry 9393086 -> 313, states 313-313
                                        if state == 313 then -- entry 9393086 -> 313
                                            r37 = args[1]
                                            r34 = upvalueValues[upvalues[1]]
                                            r12 = upvalueValues[upvalues[2]]
                                            r16 = 15426384616463
                                            r92 = "\\\195\222\170\222\171O\019"
                                            r65 = r12(r92, r16)
                                            r61 = r34[r65]
                                            ReturnVal = r37[r61]
                                            r61 = upvalueValues[upvalues[3]]
                                            state = ReturnVal - r61
                                            r61 = state
                                            r6 = "\187"
                                            state = upvalueValues[upvalues[4]]
                                            r34 = upvalueValues[upvalues[1]]
                                            r12 = upvalueValues[upvalues[2]]
                                            r16 = 35019030396851
                                            r92 = "\162@\251\211\226\251\027+"
                                            r65 = r12(r92, r16)
                                            ReturnVal = r34[r65]
                                            r65 = "UDim2"
                                            r12 = _env[r65]
                                            r92 = upvalueValues[upvalues[1]]
                                            r16 = upvalueValues[upvalues[2]]
                                            r74 = 17278133886829
                                            r62 = "\164Q\159"
                                            r56 = r16(r62, r74)
                                            r65 = r92[r56]
                                            r34 = r12[r65]
                                            r16 = upvalueValues[upvalues[5]]
                                            r62 = upvalueValues[upvalues[1]]
                                            r74 = upvalueValues[upvalues[2]]
                                            r66 = 28434570589112
                                            r41 = "\247"
                                            r27 = r74(r41, r66)
                                            r56 = r62[r27]
                                            r92 = r16[r56]
                                            r56 = upvalueValues[upvalues[1]]
                                            r62 = upvalueValues[upvalues[2]]
                                            r41 = 18215670243618
                                            r27 = "pT\232\190\179"
                                            r74 = r62(r27, r41)
                                            r16 = r56[r74]
                                            r65 = r92[r16]
                                            r62 = upvalueValues[upvalues[5]]
                                            r27 = upvalueValues[upvalues[1]]
                                            r41 = upvalueValues[upvalues[2]]
                                            r68 = "\""
                                            r4 = 7878490066516
                                            r66 = r41(r68, r4)
                                            r74 = r27[r66]
                                            r56 = r62[r74]
                                            r37 = nil
                                            r74 = upvalueValues[upvalues[1]]
                                            r27 = upvalueValues[upvalues[2]]
                                            r68 = 20631846004103
                                            r66 = "\023p\004\207\189\191"
                                            r41 = r27(r66, r68)
                                            r62 = r74[r41]
                                            r16 = r56[r62]
                                            r74 = upvalueValues[upvalues[1]]
                                            r27 = upvalueValues[upvalues[2]]
                                            r68 = 15201977162662
                                            r66 = "\237"
                                            r41 = r27(r66, r68)
                                            r62 = r74[r41]
                                            r56 = r61[r62]
                                            r92 = r16 + r56
                                            r62 = upvalueValues[upvalues[5]]
                                            r27 = upvalueValues[upvalues[1]]
                                            r41 = upvalueValues[upvalues[2]]
                                            r4 = 3862183462662
                                            r68 = "\176"
                                            r66 = r41(r68, r4)
                                            r74 = r27[r66]
                                            r56 = r62[r74]
                                            r74 = upvalueValues[upvalues[1]]
                                            r27 = upvalueValues[upvalues[2]]
                                            r68 = 6923631266968
                                            r66 = "lcbz\236"
                                            r41 = r27(r66, r68)
                                            r62 = r74[r41]
                                            r16 = r56[r62]
                                            r27 = upvalueValues[upvalues[5]]
                                            r66 = upvalueValues[upvalues[1]]
                                            r68 = upvalueValues[upvalues[2]]
                                            r39 = 10438414799612
                                            r4 = r68(r6, r39)
                                            r41 = r66[r4]
                                            r74 = r27[r41]
                                            r41 = upvalueValues[upvalues[1]]
                                            r66 = upvalueValues[upvalues[2]]
                                            r6 = 11952321205693
                                            r4 = "#\017\029M\201L"
                                            r68 = r66(r4, r6)
                                            r27 = r41[r68]
                                            r62 = r74[r27]
                                            r41 = upvalueValues[upvalues[1]]
                                            r66 = upvalueValues[upvalues[2]]
                                            r6 = 31777342699981
                                            r4 = "\020"
                                            r68 = r66(r4, r6)
                                            r27 = r41[r68]
                                            r74 = r61[r27]
                                            r61 = nil
                                            r56 = r62 + r74
                                            r12 = r34(r65, r92, r16, r56)
                                            state[ReturnVal] = r12
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                end
                            end
                        else
                            if state <= 332 then
                                if state <= 328 then
                                    if state <= 323 then
                                        if state <= 318 then
                                            -- createClosure6 entry 15990816 -> 314, states 314-318
                                            if state <= 316 then
                                                if state <= 315 then
                                                    if state <= 314 then
                                                        if state == 314 then -- entry 15990816 -> 314
                                                            r37 = allocUpvalue()
                                                            upvalueValues[r37] = args[1]
                                                            r12 = upvalueValues[r37]
                                                            r92 = upvalueValues[upvalues[1]]
                                                            r16 = upvalueValues[upvalues[2]]
                                                            r62 = "\253\203\150\199sS\235/\232\177\024l\147"
                                                            r74 = 536385061113
                                                            r56 = r16(r62, r74)
                                                            r65 = r92[r56]
                                                            r34 = r12[r65]
                                                            r16 = "Enum"
                                                            r92 = _env[r16]
                                                            r56 = upvalueValues[upvalues[1]]
                                                            r62 = upvalueValues[upvalues[2]]
                                                            r41 = 32928355400677
                                                            r27 = "\191\233\226\"i(\231\1868R\015\206\232"
                                                            r74 = r62(r27, r41)
                                                            r16 = r56[r74]
                                                            r65 = r92[r16]
                                                            r16 = upvalueValues[upvalues[1]]
                                                            r56 = upvalueValues[upvalues[2]]
                                                            r27 = 206652440672
                                                            r74 = "\0311\239A\173\237\008\252\144\031= "
                                                            r62 = r56(r74, r27)
                                                            r92 = r16[r62]
                                                            r12 = r65[r92]
                                                            r61 = r34 == r12
                                                            state = r61 and (315) or (316)
                                                            ReturnVal = r61
                                                        end
                                                    else
                                                        if state == 315 then
                                                            state = ReturnVal and (317) or (318)
                                                        end
                                                    end
                                                else
                                                    if state == 316 then
                                                        r12 = upvalueValues[r37]
                                                        r92 = upvalueValues[upvalues[1]]
                                                        r16 = upvalueValues[upvalues[2]]
                                                        r62 = "\008\175\132\000\236\165\019D\152\130\227p\221"
                                                        r74 = 32976476257275
                                                        r56 = r16(r62, r74)
                                                        r65 = r92[r56]
                                                        r34 = r12[r65]
                                                        r16 = "Enum"
                                                        r92 = _env[r16]
                                                        r56 = upvalueValues[upvalues[1]]
                                                        r62 = upvalueValues[upvalues[2]]
                                                        r27 = "\214xj\193ej\217#\209\144\253\149\229"
                                                        r41 = 32545764768563
                                                        r74 = r62(r27, r41)
                                                        r16 = r56[r74]
                                                        r65 = r92[r16]
                                                        r16 = upvalueValues[upvalues[1]]
                                                        r56 = upvalueValues[upvalues[2]]
                                                        r27 = 8555271131023
                                                        r74 = "+S>A\005"
                                                        r62 = r56(r74, r27)
                                                        r92 = r16[r62]
                                                        r12 = r65[r92]
                                                        r61 = r34 == r12
                                                        ReturnVal = r61
                                                        state = 315
                                                    end
                                                end
                                            else
                                                if state <= 317 then
                                                    if state == 317 then
                                                        state = true
                                                        upvalueValues[upvalues[3]] = state
                                                        r61 = upvalueValues[r37]
                                                        r12 = upvalueValues[upvalues[1]]
                                                        r65 = upvalueValues[upvalues[2]]
                                                        r56 = 23878097283951
                                                        r16 = "='\204L\132\175kp"
                                                        r92 = r65(r16, r56)
                                                        r34 = r12[r92]
                                                        ReturnVal = r61[r34]
                                                        upvalueValues[upvalues[4]] = ReturnVal
                                                        r34 = upvalueValues[upvalues[5]]
                                                        r65 = upvalueValues[upvalues[1]]
                                                        r92 = upvalueValues[upvalues[2]]
                                                        r56 = "6;\2005q\167\227\151"
                                                        r62 = 12133814588946
                                                        r16 = r92(r56, r62)
                                                        r12 = r65[r16]
                                                        r61 = r34[r12]
                                                        upvalueValues[upvalues[6]] = r61
                                                        r12 = upvalueValues[r37]
                                                        r92 = upvalueValues[upvalues[1]]
                                                        r16 = upvalueValues[upvalues[2]]
                                                        r74 = 20130974164126
                                                        r62 = "7S\217p>w\222"
                                                        r56 = r16(r62, r74)
                                                        r65 = r92[r56]
                                                        r34 = r12[r65]
                                                        r12 = "Connect"
                                                        r12 = r34[r12]
                                                        r65 = createClosure4(508, {
                                                            r37,
                                                            upvalues[1],
                                                            upvalues[2],
                                                            upvalues[3]
                                                        })
                                                        r12 = r12(r34, r65)
                                                        state = 318
                                                    end
                                                else
                                                    if state == 318 then
                                                        ReturnVal = {}
                                                        r37 = releaseUpvalue(r37)
                                                        state = nil
                                                    end
                                                end
                                            end
                                        else
                                            -- createClosure4 entry 12113663 -> 319, states 319-323
                                            if state <= 321 then
                                                if state <= 320 then
                                                    if state <= 319 then
                                                        if state == 319 then -- entry 12113663 -> 319
                                                            r65 = upvalueValues[upvalues[1]]
                                                            r37 = args[1]
                                                            r92 = upvalueValues[upvalues[2]]
                                                            r56 = "\161}\236\232\166\193\138\244\020\133\163\029\n"
                                                            r62 = 6941812821152
                                                            r16 = r92(r56, r62)
                                                            r12 = r65[r16]
                                                            r34 = r37[r12]
                                                            r16 = "Enum"
                                                            r92 = _env[r16]
                                                            r56 = upvalueValues[upvalues[1]]
                                                            r62 = upvalueValues[upvalues[2]]
                                                            r41 = 3978001762108
                                                            r27 = "2Eq\156\154&f\250\173\017J8\017"
                                                            r74 = r62(r27, r41)
                                                            r16 = r56[r74]
                                                            r65 = r92[r16]
                                                            r16 = upvalueValues[upvalues[1]]
                                                            r56 = upvalueValues[upvalues[2]]
                                                            r74 = "\0156\201\012\156\019\130\129\165}\175\192\r"
                                                            r27 = 22275695437956
                                                            r62 = r56(r74, r27)
                                                            r92 = r16[r62]
                                                            r12 = r65[r92]
                                                            r61 = r34 == r12
                                                            state = r61 and (320) or (321)
                                                            ReturnVal = r61
                                                        end
                                                    else
                                                        if state == 320 then
                                                            state = ReturnVal and (322) or (323)
                                                        end
                                                    end
                                                else
                                                    if state == 321 then
                                                        r65 = upvalueValues[upvalues[1]]
                                                        r92 = upvalueValues[upvalues[2]]
                                                        r62 = 7736060005906
                                                        r56 = "\192\219\220\202\2223s\018\156/\216\160F"
                                                        r16 = r92(r56, r62)
                                                        r12 = r65[r16]
                                                        r34 = r37[r12]
                                                        r16 = "Enum"
                                                        r92 = _env[r16]
                                                        r56 = upvalueValues[upvalues[1]]
                                                        r62 = upvalueValues[upvalues[2]]
                                                        r27 = "2\015A\252\162\162\018\171_Z\228\129\155"
                                                        r41 = 19404386378571
                                                        r74 = r62(r27, r41)
                                                        r16 = r56[r74]
                                                        r65 = r92[r16]
                                                        r16 = upvalueValues[upvalues[1]]
                                                        r56 = upvalueValues[upvalues[2]]
                                                        r74 = "j!\247\129\205"
                                                        r27 = 22110353729591
                                                        r62 = r56(r74, r27)
                                                        r92 = r16[r62]
                                                        r12 = r65[r92]
                                                        r61 = r34 == r12
                                                        ReturnVal = r61
                                                        state = 320
                                                    end
                                                end
                                            else
                                                if state <= 322 then
                                                    if state == 322 then
                                                        state = r37
                                                        upvalueValues[upvalues[3]] = state
                                                        state = 323
                                                    end
                                                else
                                                    if state == 323 then
                                                        r37 = nil
                                                        ReturnVal = {}
                                                        state = nil
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        -- createClosure6 entry 2080155 -> 324, states 324-328
                                        if state <= 326 then
                                            if state <= 325 then
                                                if state <= 324 then
                                                    if state == 324 then -- entry 2080155 -> 324
                                                        r34 = upvalueValues[upvalues[1]]
                                                        r37 = args[1]
                                                        r61 = r37 == r34
                                                        state = r61 and (325) or (326)
                                                        ReturnVal = r61
                                                    end
                                                else
                                                    if state == 325 then
                                                        r61 = upvalueValues[upvalues[2]]
                                                        ReturnVal = r61
                                                        state = 326
                                                    end
                                                end
                                            else
                                                if state == 326 then
                                                    state = ReturnVal and (327) or (328)
                                                end
                                            end
                                        else
                                            if state <= 327 then
                                                if state == 327 then
                                                    state = upvalueValues[upvalues[3]]
                                                    ReturnVal = state(r37)
                                                    state = 328
                                                end
                                            else
                                                if state == 328 then
                                                    r37 = nil
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                else
                                    if state <= 329 then
                                        -- createClosure1 entry 10347148 -> 329, states 329-329
                                        if state == 329 then -- entry 10347148 -> 329
                                            r61 = "oMe1ssV"
                                            r34 = 2215787
                                            r37 = r61 ^ r34
                                            ReturnVal = 4611103
                                            state = ReturnVal - r37
                                            r37 = state
                                            ReturnVal = "MkFfzuDlO8fj"
                                            state = ReturnVal / r37
                                            ReturnVal = {
                                                state
                                            }
                                            state = nil
                                        end
                                    else
                                        -- createClosure3 entry 7848953 -> 330, states 330-332
                                        if state <= 331 then
                                            if state <= 330 then
                                                if state == 330 then -- entry 7848953 -> 330
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    state = not ReturnVal
                                                    upvalueValues[upvalues[1]] = state
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r61 = upvalueValues[upvalues[3]]
                                                    r34 = upvalueValues[upvalues[4]]
                                                    r65 = "AQ\197\208\1273\179"
                                                    r92 = 16605878492724
                                                    r12 = r34(r65, r92)
                                                    r37 = r61[r12]
                                                    r61 = upvalueValues[upvalues[1]]
                                                    ReturnVal[r37] = r61
                                                    ReturnVal = upvalueValues[upvalues[5]]
                                                    state = ReturnVal and (331) or (332)
                                                end
                                            else
                                                if state == 331 then
                                                    ReturnVal = upvalueValues[upvalues[5]]
                                                    r61 = upvalueValues[upvalues[1]]
                                                    r37 = ReturnVal(r61)
                                                    state = 332
                                                end
                                            end
                                        else
                                            if state == 332 then
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 357 then
                                    if state <= 353 then
                                        if state <= 335 then
                                            -- createClosure5 entry 8883252 -> 333, states 333-335
                                            if state <= 334 then
                                                if state <= 333 then
                                                    if state == 333 then -- entry 8883252 -> 333
                                                        state = upvalueValues[upvalues[1]]
                                                        state = state and (334) or (335)
                                                    end
                                                else
                                                    if state == 334 then
                                                        ReturnVal = upvalueValues[upvalues[2]]
                                                        r61 = upvalueValues[upvalues[3]]
                                                        r34 = upvalueValues[upvalues[4]]
                                                        r65 = "\151x;\210\252\017\030\212\024\175\2423"
                                                        r92 = 25093695991205
                                                        r12 = r34(r65, r92)
                                                        r37 = r61[r12]
                                                        state = ReturnVal[r37]
                                                        r37 = state
                                                        state = upvalueValues[upvalues[1]]
                                                        r61 = upvalueValues[upvalues[3]]
                                                        r34 = upvalueValues[upvalues[4]]
                                                        r65 = "\210\194\2109\"P\134\217"
                                                        r92 = 20489956156741
                                                        r12 = r34(r65, r92)
                                                        ReturnVal = r61[r12]
                                                        r12 = "Vector2"
                                                        r34 = _env[r12]
                                                        r65 = upvalueValues[upvalues[3]]
                                                        r92 = upvalueValues[upvalues[4]]
                                                        r56 = "\2369+"
                                                        r62 = 273685430399
                                                        r16 = r92(r56, r62)
                                                        r12 = r65[r16]
                                                        r61 = r34[r12]
                                                        r16 = upvalueValues[upvalues[3]]
                                                        r56 = upvalueValues[upvalues[4]]
                                                        r74 = "["
                                                        r27 = 20621215950210
                                                        r62 = r56(r74, r27)
                                                        r92 = r16[r62]
                                                        r65 = r37[r92]
                                                        r92 = 2
                                                        r12 = r65 / r92
                                                        r56 = upvalueValues[upvalues[3]]
                                                        r62 = upvalueValues[upvalues[4]]
                                                        r41 = 29977169426055
                                                        r27 = "\136"
                                                        r74 = r62(r27, r41)
                                                        r16 = r56[r74]
                                                        r92 = r37[r16]
                                                        r16 = 2
                                                        r65 = r92 / r16
                                                        r34 = r61(r12, r65)
                                                        r37 = nil
                                                        state[ReturnVal] = r34
                                                        state = 335
                                                    end
                                                end
                                            else
                                                if state == 335 then
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        else
                                            -- createClosure1 entry 11351481 -> 336, states 336-353
                                            if state <= 344 then
                                                if state <= 340 then
                                                    if state <= 338 then
                                                        if state <= 337 then
                                                            if state <= 336 then
                                                                if state == 336 then -- entry 11351481 -> 336
                                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                                    r61 = upvalueValues[upvalues[2]]
                                                                    r34 = upvalueValues[upvalues[3]]
                                                                    r65 = "\2503\130\201\015\204\248\189A"
                                                                    r92 = 4094751983474
                                                                    r12 = r34(r65, r92)
                                                                    r37 = r61[r12]
                                                                    state = ReturnVal[r37]
                                                                    r37 = state
                                                                    state = r37 and (337) or (338)
                                                                end
                                                            else
                                                                if state == 337 then
                                                                    r12 = upvalueValues[upvalues[2]]
                                                                    r65 = upvalueValues[upvalues[3]]
                                                                    r61 = "FindFirstChild"
                                                                    r61 = r37[r61]
                                                                    r16 = " \198k\251"
                                                                    r56 = 25146653961661
                                                                    r92 = r65(r16, r56)
                                                                    r34 = r12[r92]
                                                                    r61 = r61(r37, r34)
                                                                    state = r61 and (339) or (340)
                                                                    ReturnVal = r61
                                                                end
                                                            end
                                                        else
                                                            if state == 338 then
                                                                r37 = nil
                                                                ReturnVal = {}
                                                                state = nil
                                                            end
                                                        end
                                                    else
                                                        if state <= 339 then
                                                            if state == 339 then
                                                                r61 = ReturnVal
                                                                state = not r61
                                                                state = state and (341) or (342)
                                                            end
                                                        else
                                                            if state == 340 then
                                                                r34 = state
                                                                r92 = upvalueValues[upvalues[2]]
                                                                r16 = upvalueValues[upvalues[3]]
                                                                r62 = "`\155\153S\146K"
                                                                r74 = 3844574791422
                                                                r56 = r16(r62, r74)
                                                                r65 = r92[r56]
                                                                r12 = "FindFirstChild"
                                                                r12 = r37[r12]
                                                                r12 = r12(r37, r65)
                                                                state = r12 and (343) or (344)
                                                                r61 = r12
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 342 then
                                                        if state <= 341 then
                                                            if state == 341 then
                                                                r12 = "math"
                                                                r34 = _env[r12]
                                                                r65 = upvalueValues[upvalues[2]]
                                                                r92 = upvalueValues[upvalues[3]]
                                                                r62 = 17878474629253
                                                                r56 = "\166\169\139\188"
                                                                r16 = r92(r56, r62)
                                                                r12 = r65[r16]
                                                                ReturnVal = r34[r12]
                                                                state = -ReturnVal
                                                                r34 = state
                                                                r16 = "GetChildren"
                                                                r16 = r37[r16]
                                                                ReturnVal = "ipairs"
                                                                state = _env[ReturnVal]
                                                                r92 = {
                                                                    r16(r37)
                                                                }
                                                                r16 = {
                                                                    state(unpack(r92))
                                                                }
                                                                ReturnVal = r16[1]
                                                                r65 = r16[3]
                                                                r12 = r16[2]
                                                                r92 = ReturnVal
                                                                state = 345
                                                            end
                                                        else
                                                            if state == 342 then
                                                                r34 = upvalueValues[upvalues[4]]
                                                                r65 = r61
                                                                r12 = upvalueValues[upvalues[1]]
                                                                r61 = nil
                                                                r34[r12] = r65
                                                                state = 338
                                                            end
                                                        end
                                                    else
                                                        if state <= 343 then
                                                            if state == 343 then
                                                                state = r34
                                                                ReturnVal = r61
                                                                state = 339
                                                            end
                                                        else
                                                            if state == 344 then
                                                                r92 = upvalueValues[upvalues[2]]
                                                                r16 = upvalueValues[upvalues[3]]
                                                                r74 = 6377453357977
                                                                r62 = "'>R\003\201\024\218"
                                                                r56 = r16(r62, r74)
                                                                r65 = r92[r56]
                                                                r12 = "FindFirstChild"
                                                                r12 = r37[r12]
                                                                r12 = r12(r37, r65)
                                                                r61 = r12
                                                                state = 343
                                                            end
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 349 then
                                                    if state <= 347 then
                                                        if state <= 346 then
                                                            if state <= 345 then
                                                                if state == 345 then
                                                                    state = true
                                                                    state = state and (346) or (347)
                                                                end
                                                            else
                                                                if state == 346 then
                                                                    r56 = {
                                                                        r92(r12, r65)
                                                                    }
                                                                    state = nil
                                                                    r16 = state
                                                                    state = r56[1]
                                                                    ReturnVal = r56[2]
                                                                    r65 = state
                                                                    r62 = nil
                                                                    r56 = r65 == r62
                                                                    state = r56 and (348) or (349)
                                                                    r16 = ReturnVal
                                                                end
                                                            end
                                                        else
                                                            if state == 347 then
                                                                r12 = nil
                                                                r34 = nil
                                                                r92 = nil
                                                                r65 = nil
                                                                state = 342
                                                            end
                                                        end
                                                    else
                                                        if state <= 348 then
                                                            if state == 348 then
                                                                r16 = nil
                                                                state = 347
                                                            end
                                                        else
                                                            if state == 349 then
                                                                r62 = state
                                                                r41 = upvalueValues[upvalues[2]]
                                                                r66 = upvalueValues[upvalues[3]]
                                                                r4 = "\244\241\150L\215\2301\155"
                                                                r6 = 2426733413482
                                                                r68 = r66(r4, r6)
                                                                r27 = r41[r68]
                                                                r74 = "IsA"
                                                                r74 = r16[r74]
                                                                r74 = r74(r16, r27)
                                                                state = r74 and (350) or (351)
                                                                r56 = r74
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 351 then
                                                        if state <= 350 then
                                                            if state == 350 then
                                                                r68 = upvalueValues[upvalues[2]]
                                                                r4 = upvalueValues[upvalues[3]]
                                                                r39 = "B\252\202\129\019\198\229\229"
                                                                r90 = 2085481235403
                                                                r6 = r4(r39, r90)
                                                                r66 = r68[r6]
                                                                r41 = r16[r66]
                                                                r68 = upvalueValues[upvalues[2]]
                                                                r4 = upvalueValues[upvalues[3]]
                                                                r39 = ":"
                                                                r90 = 33980200566223
                                                                r6 = r4(r39, r90)
                                                                r66 = r68[r6]
                                                                r27 = r41[r66]
                                                                r74 = r34 < r27
                                                                r56 = r74
                                                                state = 351
                                                            end
                                                        else
                                                            if state == 351 then
                                                                state = r62
                                                                state = r56 and (352) or (353)
                                                            end
                                                        end
                                                    else
                                                        if state <= 352 then
                                                            if state == 352 then
                                                                r27 = upvalueValues[upvalues[2]]
                                                                r41 = upvalueValues[upvalues[3]]
                                                                r68 = "\148\189\2186g\204G\238"
                                                                r4 = 8991663394907
                                                                r66 = r41(r68, r4)
                                                                r74 = r27[r66]
                                                                r62 = r16[r74]
                                                                r27 = upvalueValues[upvalues[2]]
                                                                r41 = upvalueValues[upvalues[3]]
                                                                r68 = "\156"
                                                                r4 = 27757890744957
                                                                r66 = r41(r68, r4)
                                                                r74 = r27[r66]
                                                                r56 = r62[r74]
                                                                r62 = r16
                                                                r34 = r56
                                                                r61 = r62
                                                                state = 353
                                                            end
                                                        else
                                                            if state == 353 then
                                                                r16 = nil
                                                                state = 345
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        -- createClosure5 entry 9073479 -> 354, states 354-357
                                        if state <= 355 then
                                            if state <= 354 then
                                                if state == 354 then -- entry 9073479 -> 354
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    r61 = upvalueValues[upvalues[2]]
                                                    r34 = upvalueValues[upvalues[3]]
                                                    r65 = "b'\020\159\154\143_o\220"
                                                    r92 = 5320436795821
                                                    r12 = r34(r65, r92)
                                                    r37 = r61[r12]
                                                    state = ReturnVal[r37]
                                                    state = 355
                                                end
                                            else
                                                if state == 355 then
                                                    r37 = "task"
                                                    ReturnVal = _env[r37]
                                                    r61 = upvalueValues[upvalues[2]]
                                                    r34 = upvalueValues[upvalues[3]]
                                                    r65 = "\144lH\019"
                                                    r92 = 16396301639123
                                                    r12 = r34(r65, r92)
                                                    r37 = r61[r12]
                                                    state = ReturnVal[r37]
                                                    ReturnVal = state()
                                                    state = 356
                                                end
                                            end
                                        else
                                            if state <= 356 then
                                                if state == 356 then
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    r61 = upvalueValues[upvalues[2]]
                                                    r34 = upvalueValues[upvalues[3]]
                                                    r92 = 5320436795821
                                                    r65 = "b'\020\159\154\143_o\220"
                                                    r12 = r34(r65, r92)
                                                    r37 = r61[r12]
                                                    state = ReturnVal[r37]
                                                    state = state and (357) or (355)
                                                end
                                            else
                                                if state == 357 then
                                                    r37 = "task"
                                                    ReturnVal = _env[r37]
                                                    r61 = upvalueValues[upvalues[2]]
                                                    r34 = upvalueValues[upvalues[3]]
                                                    r92 = 8755273830380
                                                    r65 = "\026\198T\026"
                                                    r12 = r34(r65, r92)
                                                    r37 = r61[r12]
                                                    state = ReturnVal[r37]
                                                    r37 = 0.1
                                                    ReturnVal = state(r37)
                                                    state = upvalueValues[upvalues[4]]
                                                    ReturnVal = state()
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                else
                                    if state <= 362 then
                                        -- createClosure7 entry 4624487 -> 358, states 358-362
                                        if state <= 360 then
                                            if state <= 359 then
                                                if state <= 358 then
                                                    if state == 358 then -- entry 4624487 -> 358
                                                        r37 = args[1]
                                                        r61 = args[2]
                                                        state = not r61
                                                        state = state and (359) or (360)
                                                    end
                                                else
                                                    if state == 359 then
                                                        r12 = upvalueValues[upvalues[1]]
                                                        r65 = upvalueValues[upvalues[2]]
                                                        r56 = 26269669568456
                                                        r16 = "\213\\CC\149\004=Q\244\176\007?\160"
                                                        r92 = r65(r16, r56)
                                                        r34 = r12[r92]
                                                        ReturnVal = r37[r34]
                                                        r92 = "Enum"
                                                        r65 = _env[r92]
                                                        r16 = upvalueValues[upvalues[1]]
                                                        r56 = upvalueValues[upvalues[2]]
                                                        r27 = 13712948992241
                                                        r74 = "\221S\000\nH%@\171\199\162\018P\168"
                                                        r62 = r56(r74, r27)
                                                        r92 = r16[r62]
                                                        r12 = r65[r92]
                                                        r92 = upvalueValues[upvalues[1]]
                                                        r16 = upvalueValues[upvalues[2]]
                                                        r74 = 13239870248981
                                                        r62 = "Y\017`\157\011\185s\196'r\026\225"
                                                        r56 = r16(r62, r74)
                                                        r65 = r92[r56]
                                                        r34 = r12[r65]
                                                        state = ReturnVal == r34
                                                        state = state and (361) or (362)
                                                    end
                                                end
                                            else
                                                if state == 360 then
                                                    r61 = nil
                                                    r37 = nil
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state <= 361 then
                                                if state == 361 then
                                                    state = upvalueValues[upvalues[3]]
                                                    ReturnVal = state()
                                                    state = 362
                                                end
                                            else
                                                if state == 362 then
                                                    state = 360
                                                end
                                            end
                                        end
                                    else
                                        -- createClosure4 entry 9036870 -> 363, states 363-365
                                        if state <= 364 then
                                            if state <= 363 then
                                                if state == 363 then -- entry 9036870 -> 363
                                                    r34 = upvalueValues[upvalues[1]]
                                                    r37 = args[1]
                                                    r12 = upvalueValues[upvalues[2]]
                                                    r16 = 21997860857859
                                                    r92 = "V>\139\130\140\175\029\169\242\176\127%\191"
                                                    r65 = r12(r92, r16)
                                                    r61 = r34[r65]
                                                    ReturnVal = r37[r61]
                                                    r65 = "Enum"
                                                    r12 = _env[r65]
                                                    r92 = upvalueValues[upvalues[1]]
                                                    r16 = upvalueValues[upvalues[2]]
                                                    r74 = 4229249320881
                                                    r62 = "_\179\028B\165\243\210\205\219\181\24868"
                                                    r56 = r16(r62, r74)
                                                    r65 = r92[r56]
                                                    r34 = r12[r65]
                                                    r65 = upvalueValues[upvalues[1]]
                                                    r92 = upvalueValues[upvalues[2]]
                                                    r62 = 18128423362809
                                                    r56 = "|\217})\252\150|g\188&\134\160"
                                                    r16 = r92(r56, r62)
                                                    r12 = r65[r16]
                                                    r61 = r34[r12]
                                                    state = ReturnVal == r61
                                                    state = state and (364) or (365)
                                                end
                                            else
                                                if state == 364 then
                                                    state = upvalueValues[upvalues[3]]
                                                    ReturnVal = state()
                                                    state = 365
                                                end
                                            end
                                        else
                                            if state == 365 then
                                                r37 = nil
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    else
                        if state <= 417 then
                            if state <= 412 then
                                if state <= 376 then
                                    if state <= 375 then
                                        if state <= 374 then
                                            -- createClosure1 entry 14171451 -> 366, states 366-374
                                            if state <= 370 then
                                                if state <= 368 then
                                                    if state <= 367 then
                                                        if state <= 366 then
                                                            if state == 366 then -- entry 14171451 -> 366
                                                                r61 = createClosure0(511, {
                                                                    upvalues[1],
                                                                    upvalues[2],
                                                                    upvalues[3]
                                                                })
                                                                ReturnVal = "pcall"
                                                                state = _env[ReturnVal]
                                                                r34 = {
                                                                    state(r61)
                                                                }
                                                                ReturnVal = r34[1]
                                                                r61 = ReturnVal
                                                                state = r61 and (367) or (368)
                                                                r37 = r34[2]
                                                                ReturnVal = r61
                                                            end
                                                        else
                                                            if state == 367 then
                                                                ReturnVal = r37
                                                                state = 368
                                                            end
                                                        end
                                                    else
                                                        if state == 368 then
                                                            state = ReturnVal and (369) or (370)
                                                        end
                                                    end
                                                else
                                                    if state <= 369 then
                                                        if state == 369 then
                                                            state = upvalueValues[upvalues[4]]
                                                            state = state and (371) or (372)
                                                        end
                                                    else
                                                        if state == 370 then
                                                            r61 = nil
                                                            r37 = nil
                                                            ReturnVal = {}
                                                            state = nil
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 372 then
                                                    if state <= 371 then
                                                        if state == 371 then
                                                            state = upvalueValues[upvalues[4]]
                                                            ReturnVal = "Disconnect"
                                                            ReturnVal = state[ReturnVal]
                                                            ReturnVal = ReturnVal(state)
                                                            state = 372
                                                        end
                                                    else
                                                        if state == 372 then
                                                            state = upvalueValues[upvalues[5]]
                                                            state = state and (373) or (374)
                                                        end
                                                    end
                                                else
                                                    if state <= 373 then
                                                        if state == 373 then
                                                            state = upvalueValues[upvalues[5]]
                                                            ReturnVal = "Disconnect"
                                                            ReturnVal = state[ReturnVal]
                                                            ReturnVal = ReturnVal(state)
                                                            state = 374
                                                        end
                                                    else
                                                        if state == 374 then
                                                            r34 = upvalueValues[upvalues[2]]
                                                            r12 = upvalueValues[upvalues[3]]
                                                            r92 = "\002\194\149\246`\004*#\245\159\156\159X\174\\\018"
                                                            r16 = 30564556421016
                                                            r65 = r12(r92, r16)
                                                            ReturnVal = r34[r65]
                                                            state = r37[ReturnVal]
                                                            r34 = upvalueValues[upvalues[6]]
                                                            ReturnVal = "Connect"
                                                            ReturnVal = state[ReturnVal]
                                                            ReturnVal = ReturnVal(state, r34)
                                                            upvalueValues[upvalues[4]] = ReturnVal
                                                            r12 = upvalueValues[upvalues[2]]
                                                            r65 = upvalueValues[upvalues[3]]
                                                            r56 = 27432683123174
                                                            r16 = "\182\148\183\1530b\183\229'W\191\247XJ"
                                                            r92 = r65(r16, r56)
                                                            r34 = r12[r92]
                                                            state = r37[r34]
                                                            r12 = upvalueValues[upvalues[7]]
                                                            r34 = "Connect"
                                                            r34 = state[r34]
                                                            r34 = r34(state, r12)
                                                            upvalueValues[upvalues[5]] = r34
                                                            state = 370
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            -- createClosure4 entry 632082 -> 375, states 375-375
                                            if state == 375 then -- entry 632082 -> 375
                                                state = upvalueValues[upvalues[1]]
                                                ReturnVal = "Remove"
                                                ReturnVal = state[ReturnVal]
                                                ReturnVal = ReturnVal(state)
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    else
                                        -- createClosure3 entry 15078988 -> 376, states 376-376
                                        if state == 376 then -- entry 15078988 -> 376
                                            state = upvalueValues[upvalues[1]]
                                            r37 = upvalueValues[upvalues[2]]
                                            r61 = upvalueValues[upvalues[3]]
                                            r65 = 28830034113649
                                            r12 = "tw\172\196~\211\165"
                                            r34 = r61(r12, r65)
                                            ReturnVal = r37[r34]
                                            r37 = false
                                            state[ReturnVal] = r37
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                else
                                    if state <= 377 then
                                        -- createClosure3 entry 8796411 -> 377, states 377-377
                                        if state == 377 then -- entry 8796411 -> 377
                                            state = upvalueValues[upvalues[1]]
                                            ReturnVal = "Remove"
                                            ReturnVal = state[ReturnVal]
                                            ReturnVal = ReturnVal(state)
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    else
                                        -- createClosure2 entry 1658518 -> 378, states 378-412
                                        if state <= 395 then
                                            if state <= 386 then
                                                if state <= 382 then
                                                    if state <= 380 then
                                                        if state <= 379 then
                                                            if state <= 378 then
                                                                if state == 378 then -- entry 1658518 -> 378
                                                                    r37 = upvalueValues[upvalues[1]]
                                                                    r34 = upvalueValues[upvalues[2]]
                                                                    r12 = upvalueValues[upvalues[3]]
                                                                    r92 = "\1644[\238.\025"
                                                                    r16 = 21239995885218
                                                                    r65 = r12(r92, r16)
                                                                    r61 = r34[r65]
                                                                    ReturnVal = r37[r61]
                                                                    r61 = upvalueValues[upvalues[2]]
                                                                    r34 = upvalueValues[upvalues[3]]
                                                                    r65 = "'>\0077\n\146d\008"
                                                                    r92 = 28150380606260
                                                                    r12 = r34(r65, r92)
                                                                    r37 = r61[r12]
                                                                    state = ReturnVal[r37]
                                                                    r37 = state
                                                                    state = upvalueValues[upvalues[4]]
                                                                    r61 = state
                                                                    r92 = "GetPlayers"
                                                                    r92 = r61[r92]
                                                                    ReturnVal = "ipairs"
                                                                    state = _env[ReturnVal]
                                                                    r65 = {
                                                                        r92(r61)
                                                                    }
                                                                    r92 = {
                                                                        state(unpack(r65))
                                                                    }
                                                                    ReturnVal = r92[1]
                                                                    r34 = r92[2]
                                                                    r12 = r92[3]
                                                                    r65 = ReturnVal
                                                                    state = 379
                                                                end
                                                            else
                                                                if state == 379 then
                                                                    state = true
                                                                    state = state and (380) or (381)
                                                                end
                                                            end
                                                        else
                                                            if state == 380 then
                                                                state = 382
                                                            end
                                                        end
                                                    else
                                                        if state <= 381 then
                                                            if state == 381 then
                                                                r37 = nil
                                                                r12 = nil
                                                                r65 = nil
                                                                r61 = nil
                                                                r34 = nil
                                                                ReturnVal = {}
                                                                state = nil
                                                            end
                                                        else
                                                            if state == 382 then
                                                                state = true
                                                                state = state and (383) or (384)
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 384 then
                                                        if state <= 383 then
                                                            if state == 383 then
                                                                state = nil
                                                                r92 = state
                                                                r16 = {
                                                                    r65(r34, r12)
                                                                }
                                                                state = r16[1]
                                                                ReturnVal = r16[2]
                                                                r12 = state
                                                                r56 = nil
                                                                r16 = r12 == r56
                                                                state = r16 and (385) or (386)
                                                                r92 = ReturnVal
                                                            end
                                                        else
                                                            if state == 384 then
                                                                r16 = upvalueValues[upvalues[8]]
                                                                r62 = "v157"
                                                                r56 = _env[r62]
                                                                r92 = r16[r56]
                                                                state = r92 and (387) or (388)
                                                            end
                                                        end
                                                    else
                                                        if state <= 385 then
                                                            if state == 385 then
                                                                ReturnVal = {}
                                                                state = nil
                                                            end
                                                        else
                                                            if state == 386 then
                                                                r74 = upvalueValues[upvalues[5]]
                                                                r62 = r92 == r74
                                                                r56 = state
                                                                state = r62 and (389) or (390)
                                                                r16 = r62
                                                            end
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 391 then
                                                    if state <= 389 then
                                                        if state <= 388 then
                                                            if state <= 387 then
                                                                if state == 387 then
                                                                    r16 = "pairs"
                                                                    r92 = _env[r16]
                                                                    r27 = upvalueValues[upvalues[8]]
                                                                    r66 = "v157"
                                                                    r41 = _env[r66]
                                                                    r74 = r27[r41]
                                                                    r27 = {
                                                                        r92(r74)
                                                                    }
                                                                    r16 = r27[1]
                                                                    r62 = r27[3]
                                                                    r56 = r27[2]
                                                                    state = 391
                                                                end
                                                            else
                                                                if state == 388 then
                                                                    state = 379
                                                                end
                                                            end
                                                        else
                                                            if state == 389 then
                                                                state = r56
                                                                state = r16 and (392) or (393)
                                                            end
                                                        end
                                                    else
                                                        if state <= 390 then
                                                            if state == 390 then
                                                                r41 = upvalueValues[upvalues[2]]
                                                                r66 = upvalueValues[upvalues[3]]
                                                                r4 = "\145\211\135\023P>\017\140i"
                                                                r6 = 27285263544737
                                                                r68 = r66(r4, r6)
                                                                r27 = r41[r68]
                                                                r74 = r92[r27]
                                                                r62 = not r74
                                                                r16 = r62
                                                                state = 389
                                                            end
                                                        else
                                                            if state == 391 then
                                                                r92 = true
                                                                state = r92 and (394) or (395)
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 393 then
                                                        if state <= 392 then
                                                            if state == 392 then
                                                                r16 = nil
                                                                r74 = nil
                                                                r4 = nil
                                                                r27 = nil
                                                                r6 = nil
                                                                r68 = nil
                                                                r41 = nil
                                                                r66 = nil
                                                                r62 = nil
                                                                r56 = nil
                                                                r92 = nil
                                                                state = 384
                                                            end
                                                        else
                                                            if state == 393 then
                                                                r13 = upvalueValues[upvalues[2]]
                                                                r54 = upvalueValues[upvalues[3]]
                                                                r67 = "1VR\151\197\136Z]!"
                                                                r84 = 9520765096273
                                                                r14 = r54(r67, r84)
                                                                r90 = r13[r14]
                                                                r39 = r92[r90]
                                                                r16 = r39
                                                                r13 = upvalueValues[upvalues[2]]
                                                                r54 = upvalueValues[upvalues[3]]
                                                                r67 = "\"2\208\218\231\197\000\188\225/^\159\234\003\136\001"
                                                                r84 = 28915962754201
                                                                r14 = r54(r67, r84)
                                                                r90 = r13[r14]
                                                                r39 = "FindFirstChild"
                                                                r39 = r16[r39]
                                                                r39 = r39(r16, r90)
                                                                r56 = r39
                                                                r13 = not r56
                                                                r90 = state
                                                                state = r13 and (396) or (397)
                                                                r39 = r13
                                                            end
                                                        end
                                                    else
                                                        if state <= 394 then
                                                            if state == 394 then
                                                                r41 = {
                                                                    r16(r56, r62)
                                                                }
                                                                r74 = r41[1]
                                                                r62 = r74
                                                                r27 = r41[2]
                                                                r66 = nil
                                                                r41 = r62 == r66
                                                                state = r41 and (398) or (399)
                                                                r92 = nil
                                                                r92 = r27
                                                            end
                                                        else
                                                            if state == 395 then
                                                                r16 = nil
                                                                r62 = nil
                                                                r56 = nil
                                                                state = 388
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 404 then
                                                if state <= 400 then
                                                    if state <= 398 then
                                                        if state <= 397 then
                                                            if state <= 396 then
                                                                if state == 396 then
                                                                    state = r90
                                                                    state = r39 and (400) or (401)
                                                                end
                                                            else
                                                                if state == 397 then
                                                                    r91 = upvalueValues[upvalues[2]]
                                                                    r15 = upvalueValues[upvalues[3]]
                                                                    r38 = 24468040068225
                                                                    r36 = "\tL\128\162z*$H"
                                                                    r24 = r15(r36, r38)
                                                                    r84 = r91[r24]
                                                                    r67 = r56[r84]
                                                                    r14 = r37 - r67
                                                                    r84 = upvalueValues[upvalues[2]]
                                                                    r91 = upvalueValues[upvalues[3]]
                                                                    r36 = 14952861457202
                                                                    r24 = "\131\169\181H48\t?C"
                                                                    r15 = r91(r24, r36)
                                                                    r67 = r84[r15]
                                                                    r54 = r14[r67]
                                                                    r14 = upvalueValues[upvalues[6]]
                                                                    r13 = r54 > r14
                                                                    r39 = r13
                                                                    state = 396
                                                                end
                                                            end
                                                        else
                                                            if state == 398 then
                                                                r92 = nil
                                                                state = 395
                                                            end
                                                        end
                                                    else
                                                        if state <= 399 then
                                                            if state == 399 then
                                                                state = r92 and (402) or (403)
                                                            end
                                                        else
                                                            if state == 400 then
                                                                state = 401
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 402 then
                                                        if state <= 401 then
                                                            if state == 401 then
                                                                r39 = upvalueValues[upvalues[7]]
                                                                r90 = r39(r16)
                                                                r62 = r90
                                                                r90 = #r62
                                                                r13 = 1
                                                                r39 = r90 < r13
                                                                state = r39 and (404) or (405)
                                                            end
                                                        else
                                                            if state == 402 then
                                                                r66 = upvalueValues[upvalues[2]]
                                                                r68 = upvalueValues[upvalues[3]]
                                                                r39 = 6074890717964
                                                                r6 = "V\182\151\233 a\001"
                                                                r4 = r68(r6, r39)
                                                                r41 = r66[r4]
                                                                r66 = false
                                                                r92[r41] = r66
                                                                state = 403
                                                            end
                                                        end
                                                    else
                                                        if state <= 403 then
                                                            if state == 403 then
                                                                r92 = nil
                                                                state = 391
                                                            end
                                                        else
                                                            if state == 404 then
                                                                state = 405
                                                            end
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 408 then
                                                    if state <= 406 then
                                                        if state <= 405 then
                                                            if state == 405 then
                                                                r13 = "math"
                                                                r90 = _env[r13]
                                                                r54 = upvalueValues[upvalues[2]]
                                                                r14 = upvalueValues[upvalues[3]]
                                                                r91 = 8611730657194
                                                                r84 = "\190\218qa"
                                                                r67 = r14(r84, r91)
                                                                r13 = r54[r67]
                                                                r39 = r90[r13]
                                                                r74 = r39
                                                                r13 = "math"
                                                                r90 = _env[r13]
                                                                r54 = upvalueValues[upvalues[2]]
                                                                r14 = upvalueValues[upvalues[3]]
                                                                r91 = 13966312724839
                                                                r84 = "+\205\191G"
                                                                r67 = r14(r84, r91)
                                                                r13 = r54[r67]
                                                                r39 = r90[r13]
                                                                r27 = r39
                                                                r54 = "math"
                                                                r13 = _env[r54]
                                                                r14 = upvalueValues[upvalues[2]]
                                                                r67 = upvalueValues[upvalues[3]]
                                                                r15 = 16064861855032
                                                                r91 = "<L\165\255"
                                                                r84 = r67(r91, r15)
                                                                r54 = r14[r84]
                                                                r90 = r13[r54]
                                                                r39 = -r90
                                                                r41 = r39
                                                                r54 = "math"
                                                                r13 = _env[r54]
                                                                r14 = upvalueValues[upvalues[2]]
                                                                r67 = upvalueValues[upvalues[3]]
                                                                r15 = 15661926653053
                                                                r91 = "\026\017\152o"
                                                                r84 = r67(r91, r15)
                                                                r54 = r14[r84]
                                                                r90 = r13[r54]
                                                                r39 = -r90
                                                                r66 = r39
                                                                r90 = "ipairs"
                                                                r39 = _env[r90]
                                                                r14 = {
                                                                    r39(r62)
                                                                }
                                                                r90 = r14[1]
                                                                r13 = r14[2]
                                                                r54 = r14[3]
                                                                r6 = r54
                                                                r68 = r90
                                                                r4 = r13
                                                                state = 406
                                                            end
                                                        else
                                                            if state == 406 then
                                                                r39 = true
                                                                state = r39 and (407) or (408)
                                                            end
                                                        end
                                                    else
                                                        if state <= 407 then
                                                            if state == 407 then
                                                                r54 = {
                                                                    r68(r4, r6)
                                                                }
                                                                r90 = r54[1]
                                                                r6 = r90
                                                                r13 = r54[2]
                                                                r14 = nil
                                                                r54 = r6 == r14
                                                                state = r54 and (409) or (410)
                                                                r39 = nil
                                                                r39 = r13
                                                            end
                                                        else
                                                            if state == 408 then
                                                                r15 = upvalueValues[upvalues[8]]
                                                                r54 = r15[r92]
                                                                r39 = not r54
                                                                state = r39 and (411) or (412)
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 410 then
                                                        if state <= 409 then
                                                            if state == 409 then
                                                                r39 = nil
                                                                state = 408
                                                            end
                                                        else
                                                            if state == 410 then
                                                                r67 = "math"
                                                                r14 = _env[r67]
                                                                r84 = upvalueValues[upvalues[2]]
                                                                r91 = upvalueValues[upvalues[3]]
                                                                r36 = 28268381352811
                                                                r24 = "\133\235\160"
                                                                r15 = r91(r24, r36)
                                                                r67 = r84[r15]
                                                                r54 = r14[r67]
                                                                r91 = upvalueValues[upvalues[2]]
                                                                r15 = upvalueValues[upvalues[3]]
                                                                r38 = 34854627180390
                                                                r36 = "\212"
                                                                r24 = r15(r36, r38)
                                                                r84 = r91[r24]
                                                                r67 = r39[r84]
                                                                r14 = r54(r74, r67)
                                                                r74 = r14
                                                                r84 = "math"
                                                                r67 = _env[r84]
                                                                r91 = upvalueValues[upvalues[2]]
                                                                r15 = upvalueValues[upvalues[3]]
                                                                r36 = "\025\2015"
                                                                r38 = 19111427957443
                                                                r24 = r15(r36, r38)
                                                                r84 = r91[r24]
                                                                r54 = r67[r84]
                                                                r15 = upvalueValues[upvalues[2]]
                                                                r24 = upvalueValues[upvalues[3]]
                                                                r32 = 15133925120903
                                                                r38 = "\213"
                                                                r36 = r24(r38, r32)
                                                                r91 = r15[r36]
                                                                r84 = r39[r91]
                                                                r67 = r54(r27, r84)
                                                                r27 = r67
                                                                r91 = "math"
                                                                r84 = _env[r91]
                                                                r15 = upvalueValues[upvalues[2]]
                                                                r24 = upvalueValues[upvalues[3]]
                                                                r38 = "\149\154\174"
                                                                r32 = 3925074937635
                                                                r36 = r24(r38, r32)
                                                                r91 = r15[r36]
                                                                r54 = r84[r91]
                                                                r24 = upvalueValues[upvalues[2]]
                                                                r36 = upvalueValues[upvalues[3]]
                                                                r73 = 21633640621913
                                                                r32 = "\233"
                                                                r38 = r36(r32, r73)
                                                                r15 = r24[r38]
                                                                r91 = r39[r15]
                                                                r84 = r54(r41, r91)
                                                                r41 = r84
                                                                r15 = "math"
                                                                r91 = _env[r15]
                                                                r24 = upvalueValues[upvalues[2]]
                                                                r36 = upvalueValues[upvalues[3]]
                                                                r32 = "\018\006\205"
                                                                r73 = 6914102037651
                                                                r38 = r36(r32, r73)
                                                                r15 = r24[r38]
                                                                r54 = r91[r15]
                                                                r36 = upvalueValues[upvalues[2]]
                                                                r38 = upvalueValues[upvalues[3]]
                                                                r1 = 16228897611141
                                                                r73 = "\027"
                                                                r32 = r38(r73, r1)
                                                                r24 = r36[r32]
                                                                r15 = r39[r24]
                                                                r91 = r54(r66, r15)
                                                                r66 = r91
                                                                r39 = nil
                                                                state = 406
                                                            end
                                                        end
                                                    else
                                                        if state <= 411 then
                                                            if state == 411 then
                                                                r39 = upvalueValues[upvalues[8]]
                                                                r54 = upvalueValues[upvalues[9]]
                                                                r15 = r54()
                                                                r39[r92] = r15
                                                                state = 412
                                                            end
                                                        else
                                                            if state == 412 then
                                                                r39 = upvalueValues[upvalues[10]]
                                                                r56 = nil
                                                                r24 = upvalueValues[upvalues[8]]
                                                                r6 = nil
                                                                r15 = r24[r92]
                                                                r92 = nil
                                                                r54 = r39(r15, r74, r27, r41, r66)
                                                                r27 = nil
                                                                r4 = nil
                                                                r16 = nil
                                                                r66 = nil
                                                                r62 = nil
                                                                r68 = nil
                                                                r41 = nil
                                                                r74 = nil
                                                                state = 382
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 415 then
                                    if state <= 414 then
                                        if state <= 413 then
                                            -- createClosure5 entry 7561669 -> 413, states 413-413
                                            if state == 413 then -- entry 7561669 -> 413
                                                state = upvalueValues[upvalues[1]]
                                                r37 = args[1]
                                                ReturnVal = state(r37)
                                                r37 = nil
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        else
                                            -- createClosure0 entry 7955822 -> 414, states 414-414
                                            if state == 414 then -- entry 7955822 -> 414
                                                state = upvalueValues[upvalues[1]]
                                                r37 = upvalueValues[upvalues[2]]
                                                r61 = upvalueValues[upvalues[3]]
                                                r12 = "}\140\211\240\249\161\237"
                                                r65 = 395015585975
                                                r34 = r61(r12, r65)
                                                ReturnVal = r37[r34]
                                                r37 = false
                                                state[ReturnVal] = r37
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    else
                                        -- createClosure0 entry 16349618 -> 415, states 415-415
                                        if state == 415 then -- entry 16349618 -> 415
                                            state = upvalueValues[upvalues[1]]
                                            ReturnVal = "Remove"
                                            ReturnVal = state[ReturnVal]
                                            ReturnVal = ReturnVal(state)
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                else
                                    if state <= 416 then
                                        -- createClosure1 entry 9006784 -> 416, states 416-416
                                        if state == 416 then -- entry 9006784 -> 416
                                            state = upvalueValues[upvalues[1]]
                                            r37 = upvalueValues[upvalues[2]]
                                            r61 = upvalueValues[upvalues[3]]
                                            r12 = "R\n\152.\r4e"
                                            r65 = 17744946634823
                                            r34 = r61(r12, r65)
                                            ReturnVal = r37[r34]
                                            r37 = false
                                            state[ReturnVal] = r37
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    else
                                        -- createClosure4 entry 8666019 -> 417, states 417-417
                                        if state == 417 then -- entry 8666019 -> 417
                                            state = upvalueValues[upvalues[1]]
                                            ReturnVal = "Remove"
                                            ReturnVal = state[ReturnVal]
                                            ReturnVal = ReturnVal(state)
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                end
                            end
                        else
                            if state <= 468 then
                                if state <= 462 then
                                    if state <= 461 then
                                        if state <= 460 then
                                            -- createClosure2 entry 12926065 -> 418, states 418-460
                                            if state <= 439 then
                                                if state <= 428 then
                                                    if state <= 423 then
                                                        if state <= 420 then
                                                            if state <= 419 then
                                                                if state <= 418 then
                                                                    if state == 418 then -- entry 12926065 -> 418
                                                                        ReturnVal = upvalueValues[upvalues[1]]
                                                                        r61 = upvalueValues[upvalues[2]]
                                                                        r34 = upvalueValues[upvalues[3]]
                                                                        r65 = "r\219\244\000E\132\004\r\213"
                                                                        r92 = 34382770175626
                                                                        r12 = r34(r65, r92)
                                                                        r37 = r61[r12]
                                                                        state = ReturnVal[r37]
                                                                        r37 = state
                                                                        state = r37 and (419) or (420)
                                                                    end
                                                                else
                                                                    if state == 419 then
                                                                        r61 = upvalueValues[upvalues[2]]
                                                                        r34 = upvalueValues[upvalues[3]]
                                                                        r65 = "\215x\146;+\135\173t\173\219\172j\141\219\216\138"
                                                                        r92 = 11476537283808
                                                                        r12 = r34(r65, r92)
                                                                        state = "FindFirstChild"
                                                                        state = r37[state]
                                                                        ReturnVal = r61[r12]
                                                                        state = state(r37, ReturnVal)
                                                                        r37 = state
                                                                        state = 420
                                                                    end
                                                                end
                                                            else
                                                                if state == 420 then
                                                                    state = r37 and (421) or (422)
                                                                end
                                                            end
                                                        else
                                                            if state <= 422 then
                                                                if state <= 421 then
                                                                    if state == 421 then
                                                                        ReturnVal = upvalueValues[upvalues[4]]
                                                                        r92 = upvalueValues[upvalues[2]]
                                                                        r16 = upvalueValues[upvalues[3]]
                                                                        r62 = "l%\134\220\234\215 \004"
                                                                        r74 = 2743006053629
                                                                        r56 = r16(r62, r74)
                                                                        r65 = r92[r56]
                                                                        r12 = r37[r65]
                                                                        r65 = "WorldToViewportPoint"
                                                                        r65 = ReturnVal[r65]
                                                                        r65 = {
                                                                            r65(ReturnVal, r12)
                                                                        }
                                                                        r61 = r65[1]
                                                                        r34 = r65[2]
                                                                        r65 = "Vector2"
                                                                        r12 = _env[r65]
                                                                        r92 = upvalueValues[upvalues[2]]
                                                                        r16 = upvalueValues[upvalues[3]]
                                                                        r62 = "\141\222T"
                                                                        r74 = 14151259527613
                                                                        r56 = r16(r62, r74)
                                                                        r65 = r92[r56]
                                                                        ReturnVal = r12[r65]
                                                                        r16 = upvalueValues[upvalues[2]]
                                                                        r56 = upvalueValues[upvalues[3]]
                                                                        r27 = 20088267941002
                                                                        r74 = "\147"
                                                                        r62 = r56(r74, r27)
                                                                        r92 = r16[r62]
                                                                        r65 = r61[r92]
                                                                        r56 = upvalueValues[upvalues[2]]
                                                                        r62 = upvalueValues[upvalues[3]]
                                                                        r41 = 16709318794852
                                                                        r27 = "\230"
                                                                        r74 = r62(r27, r41)
                                                                        r16 = r56[r74]
                                                                        r92 = r61[r16]
                                                                        r12 = ReturnVal(r65, r92)
                                                                        ReturnVal = upvalueValues[upvalues[5]]
                                                                        r65 = ReturnVal
                                                                        r92 = "ipairs"
                                                                        ReturnVal = _env[r92]
                                                                        r74 = "GetPlayers"
                                                                        r74 = r65[r74]
                                                                        r62 = {
                                                                            r74(r65)
                                                                        }
                                                                        r74 = {
                                                                            ReturnVal(unpack(r62))
                                                                        }
                                                                        r56 = r74[3]
                                                                        r16 = r74[2]
                                                                        r92 = r74[1]
                                                                        state = 423
                                                                    end
                                                                else
                                                                    if state == 422 then
                                                                        r34 = "pairs"
                                                                        r61 = _env[r34]
                                                                        r92 = upvalueValues[upvalues[7]]
                                                                        r16 = {
                                                                            r61(r92)
                                                                        }
                                                                        r34 = r16[1]
                                                                        r65 = r16[3]
                                                                        r12 = r16[2]
                                                                        state = 424
                                                                    end
                                                                end
                                                            else
                                                                if state == 423 then
                                                                    ReturnVal = true
                                                                    state = ReturnVal and (425) or (426)
                                                                end
                                                            end
                                                        end
                                                    else
                                                        if state <= 426 then
                                                            if state <= 425 then
                                                                if state <= 424 then
                                                                    if state == 424 then
                                                                        r61 = true
                                                                        state = r61 and (427) or (428)
                                                                    end
                                                                else
                                                                    if state == 425 then
                                                                        r27 = {
                                                                            r92(r16, r56)
                                                                        }
                                                                        r74 = r27[2]
                                                                        ReturnVal = nil
                                                                        r62 = ReturnVal
                                                                        ReturnVal = r27[1]
                                                                        r56 = ReturnVal
                                                                        r41 = nil
                                                                        r27 = r56 == r41
                                                                        state = r27 and (429) or (430)
                                                                        r62 = r74
                                                                    end
                                                                end
                                                            else
                                                                if state == 426 then
                                                                    r65 = nil
                                                                    r12 = nil
                                                                    r92 = nil
                                                                    r16 = nil
                                                                    r56 = nil
                                                                    r34 = nil
                                                                    r61 = nil
                                                                    state = 431
                                                                end
                                                            end
                                                        else
                                                            if state <= 427 then
                                                                if state == 427 then
                                                                    r56 = {
                                                                        r34(r12, r65)
                                                                    }
                                                                    r92 = r56[1]
                                                                    r16 = r56[2]
                                                                    r65 = r92
                                                                    r62 = nil
                                                                    r56 = r65 == r62
                                                                    state = r56 and (432) or (433)
                                                                    r61 = nil
                                                                    r61 = r16
                                                                end
                                                            else
                                                                if state == 428 then
                                                                    r34 = nil
                                                                    r12 = nil
                                                                    r65 = nil
                                                                    state = 431
                                                                end
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 434 then
                                                        if state <= 431 then
                                                            if state <= 430 then
                                                                if state <= 429 then
                                                                    if state == 429 then
                                                                        r62 = nil
                                                                        state = 426
                                                                    end
                                                                else
                                                                    if state == 430 then
                                                                        r68 = upvalueValues[upvalues[1]]
                                                                        r66 = r62 ~= r68
                                                                        r41 = state
                                                                        state = r66 and (434) or (435)
                                                                        r27 = r66
                                                                    end
                                                                end
                                                            else
                                                                if state == 431 then
                                                                    r37 = nil
                                                                    ReturnVal = {}
                                                                    state = nil
                                                                end
                                                            end
                                                        else
                                                            if state <= 433 then
                                                                if state <= 432 then
                                                                    if state == 432 then
                                                                        r61 = nil
                                                                        state = 428
                                                                    end
                                                                else
                                                                    if state == 433 then
                                                                        state = r61 and (436) or (437)
                                                                    end
                                                                end
                                                            else
                                                                if state == 434 then
                                                                    r4 = upvalueValues[upvalues[2]]
                                                                    r6 = upvalueValues[upvalues[3]]
                                                                    r13 = 30216121399030
                                                                    r90 = "\239\222\240\254\021\159Z\0254"
                                                                    r39 = r6(r90, r13)
                                                                    r68 = r4[r39]
                                                                    r66 = r62[r68]
                                                                    r27 = r66
                                                                    state = 435
                                                                end
                                                            end
                                                        end
                                                    else
                                                        if state <= 437 then
                                                            if state <= 436 then
                                                                if state <= 435 then
                                                                    if state == 435 then
                                                                        state = r41
                                                                        state = r27 and (438) or (439)
                                                                    end
                                                                else
                                                                    if state == 436 then
                                                                        r62 = upvalueValues[upvalues[2]]
                                                                        r27 = upvalueValues[upvalues[3]]
                                                                        r68 = 9986630210090
                                                                        r66 = "-\204\212\1450\012\015"
                                                                        r41 = r27(r66, r68)
                                                                        r56 = r62[r41]
                                                                        r62 = false
                                                                        r61[r56] = r62
                                                                        state = 437
                                                                    end
                                                                end
                                                            else
                                                                if state == 437 then
                                                                    r61 = nil
                                                                    state = 424
                                                                end
                                                            end
                                                        else
                                                            if state <= 438 then
                                                                if state == 438 then
                                                                    r66 = upvalueValues[upvalues[2]]
                                                                    r68 = upvalueValues[upvalues[3]]
                                                                    r6 = "e.\029@\r\255O\137\186"
                                                                    r39 = 565822488839
                                                                    r4 = r68(r6, r39)
                                                                    r41 = r66[r4]
                                                                    r27 = r62[r41]
                                                                    r68 = upvalueValues[upvalues[2]]
                                                                    r4 = upvalueValues[upvalues[3]]
                                                                    r90 = 9793328042448
                                                                    r39 = "3=U\221\026\232\000\217\178\244N]9(\128\012"
                                                                    r6 = r4(r39, r90)
                                                                    r66 = r68[r6]
                                                                    r41 = "FindFirstChild"
                                                                    r41 = r27[r41]
                                                                    r41 = r41(r27, r66)
                                                                    r68 = upvalueValues[upvalues[2]]
                                                                    r4 = upvalueValues[upvalues[3]]
                                                                    r90 = 29886376474204
                                                                    r39 = "F\201\253\213\224\231\197\177\206"
                                                                    r6 = r4(r39, r90)
                                                                    r66 = r68[r6]
                                                                    r27 = r62[r66]
                                                                    r4 = upvalueValues[upvalues[2]]
                                                                    r6 = upvalueValues[upvalues[3]]
                                                                    r13 = 19677250462666
                                                                    r90 = "\1335\143p\237\018QA"
                                                                    r39 = r6(r90, r13)
                                                                    r66 = "FindFirstChildOfClass"
                                                                    r66 = r27[r66]
                                                                    r68 = r4[r39]
                                                                    r66 = r66(r27, r68)
                                                                    r68 = state
                                                                    state = r41 and (440) or (441)
                                                                    r27 = r41
                                                                end
                                                            else
                                                                if state == 439 then
                                                                    r62 = nil
                                                                    state = 423
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 450 then
                                                    if state <= 445 then
                                                        if state <= 442 then
                                                            if state <= 441 then
                                                                if state <= 440 then
                                                                    if state == 440 then
                                                                        r6 = state
                                                                        state = r66 and (442) or (443)
                                                                        r4 = r66
                                                                    end
                                                                else
                                                                    if state == 441 then
                                                                        state = r68
                                                                        state = r27 and (444) or (445)
                                                                    end
                                                                end
                                                            else
                                                                if state == 442 then
                                                                    r54 = upvalueValues[upvalues[2]]
                                                                    r14 = upvalueValues[upvalues[3]]
                                                                    r84 = "\149(\163)\252\208"
                                                                    r91 = 24927253163351
                                                                    r67 = r14(r84, r91)
                                                                    r13 = r54[r67]
                                                                    r90 = r66[r13]
                                                                    r13 = 0
                                                                    r39 = r90 > r13
                                                                    r4 = r39
                                                                    state = 443
                                                                end
                                                            end
                                                        else
                                                            if state <= 444 then
                                                                if state <= 443 then
                                                                    if state == 443 then
                                                                        state = r6
                                                                        r27 = r4
                                                                        state = 441
                                                                    end
                                                                else
                                                                    if state == 444 then
                                                                        r39 = upvalueValues[upvalues[2]]
                                                                        r90 = upvalueValues[upvalues[3]]
                                                                        r14 = 33811451411840
                                                                        r54 = "[Ff}Pl\2000"
                                                                        r13 = r90(r54, r14)
                                                                        r6 = r39[r13]
                                                                        r4 = r37[r6]
                                                                        r90 = upvalueValues[upvalues[2]]
                                                                        r13 = upvalueValues[upvalues[3]]
                                                                        r67 = 6126518979364
                                                                        r14 = "\002Z\169L\152,Da"
                                                                        r54 = r13(r14, r67)
                                                                        r39 = r90[r54]
                                                                        r6 = r41[r39]
                                                                        r68 = r4 - r6
                                                                        r6 = upvalueValues[upvalues[2]]
                                                                        r39 = upvalueValues[upvalues[3]]
                                                                        r13 = "\179\220\000\254#\134\204xI"
                                                                        r54 = 31841355217387
                                                                        r90 = r39(r13, r54)
                                                                        r4 = r6[r90]
                                                                        r27 = r68[r4]
                                                                        r68 = upvalueValues[upvalues[4]]
                                                                        r13 = upvalueValues[upvalues[2]]
                                                                        r54 = upvalueValues[upvalues[3]]
                                                                        r84 = 14855976934149
                                                                        r67 = "\255\021\231\163\026Th\188"
                                                                        r14 = r54(r67, r84)
                                                                        r90 = r13[r14]
                                                                        r39 = r41[r90]
                                                                        r90 = "WorldToViewportPoint"
                                                                        r90 = r68[r90]
                                                                        r90 = {
                                                                            r90(r68, r39)
                                                                        }
                                                                        r6 = r90[2]
                                                                        r4 = r90[1]
                                                                        r13 = upvalueValues[upvalues[6]]
                                                                        r90 = r27 > r13
                                                                        r39 = state
                                                                        state = r90 and (446) or (447)
                                                                        r68 = r90
                                                                    end
                                                                end
                                                            else
                                                                if state == 445 then
                                                                    r68 = upvalueValues[upvalues[7]]
                                                                    r27 = r68[r62]
                                                                    state = r27 and (448) or (449)
                                                                end
                                                            end
                                                        end
                                                    else
                                                        if state <= 448 then
                                                            if state <= 447 then
                                                                if state <= 446 then
                                                                    if state == 446 then
                                                                        state = r39
                                                                        state = r68 and (450) or (451)
                                                                    end
                                                                else
                                                                    if state == 447 then
                                                                        r54 = not r34
                                                                        r13 = state
                                                                        state = r54 and (452) or (453)
                                                                        r90 = r54
                                                                    end
                                                                end
                                                            else
                                                                if state == 448 then
                                                                    r68 = upvalueValues[upvalues[7]]
                                                                    r27 = r68[r62]
                                                                    r4 = upvalueValues[upvalues[2]]
                                                                    r6 = upvalueValues[upvalues[3]]
                                                                    r90 = "\251\012\011`\132F\252"
                                                                    r13 = 12498702522044
                                                                    r39 = r6(r90, r13)
                                                                    r68 = r4[r39]
                                                                    r4 = false
                                                                    r27[r68] = r4
                                                                    state = 449
                                                                end
                                                            end
                                                        else
                                                            if state <= 449 then
                                                                if state == 449 then
                                                                    r41 = nil
                                                                    r66 = nil
                                                                    state = 439
                                                                end
                                                            else
                                                                if state == 450 then
                                                                    r39 = upvalueValues[upvalues[7]]
                                                                    r68 = r39[r62]
                                                                    state = r68 and (454) or (455)
                                                                end
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 455 then
                                                        if state <= 453 then
                                                            if state <= 452 then
                                                                if state <= 451 then
                                                                    if state == 451 then
                                                                        r90 = upvalueValues[upvalues[7]]
                                                                        r39 = r90[r62]
                                                                        r68 = not r39
                                                                        state = r68 and (456) or (457)
                                                                    end
                                                                else
                                                                    if state == 452 then
                                                                        state = r13
                                                                        r68 = r90
                                                                        state = 446
                                                                    end
                                                                end
                                                            else
                                                                if state == 453 then
                                                                    r14 = state
                                                                    r67 = not r6
                                                                    state = r67 and (458) or (459)
                                                                    r54 = r67
                                                                end
                                                            end
                                                        else
                                                            if state <= 454 then
                                                                if state == 454 then
                                                                    r39 = upvalueValues[upvalues[7]]
                                                                    r68 = r39[r62]
                                                                    r90 = upvalueValues[upvalues[2]]
                                                                    r13 = upvalueValues[upvalues[3]]
                                                                    r14 = "\161n\218\252\203+\n"
                                                                    r67 = 30830451669012
                                                                    r54 = r13(r14, r67)
                                                                    r39 = r90[r54]
                                                                    r90 = false
                                                                    r68[r39] = r90
                                                                    state = 455
                                                                end
                                                            else
                                                                if state == 455 then
                                                                    state = 460
                                                                end
                                                            end
                                                        end
                                                    else
                                                        if state <= 458 then
                                                            if state <= 457 then
                                                                if state <= 456 then
                                                                    if state == 456 then
                                                                        r68 = upvalueValues[upvalues[7]]
                                                                        r39 = upvalueValues[upvalues[8]]
                                                                        r90 = r39()
                                                                        r68[r62] = r90
                                                                        state = 457
                                                                    end
                                                                else
                                                                    if state == 457 then
                                                                        r39 = upvalueValues[upvalues[7]]
                                                                        r68 = r39[r62]
                                                                        r90 = upvalueValues[upvalues[2]]
                                                                        r13 = upvalueValues[upvalues[3]]
                                                                        r67 = 8501638942582
                                                                        r14 = ")r\002\148"
                                                                        r54 = r13(r14, r67)
                                                                        r39 = r90[r54]
                                                                        r90 = r12
                                                                        r68[r39] = r90
                                                                        r90 = upvalueValues[upvalues[2]]
                                                                        r13 = upvalueValues[upvalues[3]]
                                                                        r67 = 3485482550871
                                                                        r14 = "u\138"
                                                                        r54 = r13(r14, r67)
                                                                        r39 = r90[r54]
                                                                        r54 = "Vector2"
                                                                        r13 = _env[r54]
                                                                        r14 = upvalueValues[upvalues[2]]
                                                                        r67 = upvalueValues[upvalues[3]]
                                                                        r91 = "B^="
                                                                        r15 = 16204111650169
                                                                        r84 = r67(r91, r15)
                                                                        r54 = r14[r84]
                                                                        r90 = r13[r54]
                                                                        r67 = upvalueValues[upvalues[2]]
                                                                        r84 = upvalueValues[upvalues[3]]
                                                                        r24 = 22472941578464
                                                                        r15 = "V"
                                                                        r91 = r84(r15, r24)
                                                                        r14 = r67[r91]
                                                                        r54 = r4[r14]
                                                                        r84 = upvalueValues[upvalues[2]]
                                                                        r91 = upvalueValues[upvalues[3]]
                                                                        r36 = 6364621015955
                                                                        r24 = "\240"
                                                                        r15 = r91(r24, r36)
                                                                        r67 = r84[r15]
                                                                        r14 = r4[r67]
                                                                        r13 = r90(r54, r14)
                                                                        r68[r39] = r13
                                                                        r90 = upvalueValues[upvalues[2]]
                                                                        r13 = upvalueValues[upvalues[3]]
                                                                        r14 = ")a\207\r\028\0145"
                                                                        r67 = 10800449557413
                                                                        r54 = r13(r14, r67)
                                                                        r39 = r90[r54]
                                                                        r90 = true
                                                                        r68[r39] = r90
                                                                        r68 = nil
                                                                        state = 460
                                                                    end
                                                                end
                                                            else
                                                                if state == 458 then
                                                                    state = r14
                                                                    r90 = r54
                                                                    state = 452
                                                                end
                                                            end
                                                        else
                                                            if state <= 459 then
                                                                if state == 459 then
                                                                    r15 = upvalueValues[upvalues[2]]
                                                                    r24 = upvalueValues[upvalues[3]]
                                                                    r32 = 12201409697329
                                                                    r38 = "\165"
                                                                    r36 = r24(r38, r32)
                                                                    r91 = r15[r36]
                                                                    r84 = r4[r91]
                                                                    r91 = 0
                                                                    r67 = r84 <= r91
                                                                    r54 = r67
                                                                    state = 458
                                                                end
                                                            else
                                                                if state == 460 then
                                                                    r6 = nil
                                                                    r4 = nil
                                                                    r27 = nil
                                                                    state = 449
                                                                end
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            -- createClosure4 entry 10080583 -> 461, states 461-461
                                            if state == 461 then -- entry 10080583 -> 461
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                r61 = upvalueValues[upvalues[2]]
                                                r34 = upvalueValues[upvalues[3]]
                                                r92 = 8104119324349
                                                r65 = "\141]"
                                                r12 = r34(r65, r92)
                                                r37 = r61[r12]
                                                state = ReturnVal[r37]
                                                r37 = upvalueValues[upvalues[2]]
                                                r61 = upvalueValues[upvalues[3]]
                                                r12 = "X\182\019\214\1509\194"
                                                r65 = 25391147806255
                                                r34 = r61(r12, r65)
                                                ReturnVal = r37[r34]
                                                r37 = false
                                                state[ReturnVal] = r37
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    else
                                        -- createClosure4 entry 788374 -> 462, states 462-462
                                        if state == 462 then -- entry 788374 -> 462
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r61 = upvalueValues[upvalues[2]]
                                            r34 = upvalueValues[upvalues[3]]
                                            r65 = "\237\158\161"
                                            r92 = 28177729106753
                                            r12 = r34(r65, r92)
                                            r37 = r61[r12]
                                            state = ReturnVal[r37]
                                            r37 = upvalueValues[upvalues[2]]
                                            r61 = upvalueValues[upvalues[3]]
                                            r65 = 22169095399507
                                            r12 = "\217\018X\137\242\1343"
                                            r34 = r61(r12, r65)
                                            ReturnVal = r37[r34]
                                            r37 = false
                                            state[ReturnVal] = r37
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                else
                                    if state <= 465 then
                                        -- createClosure1 entry 14946661 -> 463, states 463-465
                                        if state <= 464 then
                                            if state <= 463 then
                                                if state == 463 then -- entry 14946661 -> 463
                                                    r37 = upvalueValues[upvalues[1]]
                                                    r34 = upvalueValues[upvalues[2]]
                                                    r12 = upvalueValues[upvalues[3]]
                                                    r92 = "\000|"
                                                    r16 = 23610042985202
                                                    r65 = r12(r92, r16)
                                                    r61 = r34[r65]
                                                    ReturnVal = r37[r61]
                                                    r61 = upvalueValues[upvalues[2]]
                                                    r34 = upvalueValues[upvalues[3]]
                                                    r92 = 20158618821803
                                                    r65 = "?*\235l\129{"
                                                    r12 = r34(r65, r92)
                                                    r37 = r61[r12]
                                                    state = ReturnVal[r37]
                                                    state = state and (464) or (465)
                                                end
                                            else
                                                if state == 464 then
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    r61 = upvalueValues[upvalues[2]]
                                                    r34 = upvalueValues[upvalues[3]]
                                                    r92 = 16688615874139
                                                    r65 = "\023`"
                                                    r12 = r34(r65, r92)
                                                    r37 = r61[r12]
                                                    state = ReturnVal[r37]
                                                    ReturnVal = "Remove"
                                                    ReturnVal = state[ReturnVal]
                                                    ReturnVal = ReturnVal(state)
                                                    state = 465
                                                end
                                            end
                                        else
                                            if state == 465 then
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    else
                                        -- createClosure4 entry 12441612 -> 466, states 466-468
                                        if state <= 467 then
                                            if state <= 466 then
                                                if state == 466 then -- entry 12441612 -> 466
                                                    r37 = upvalueValues[upvalues[1]]
                                                    r34 = upvalueValues[upvalues[2]]
                                                    r12 = upvalueValues[upvalues[3]]
                                                    r16 = 9836984832484
                                                    r92 = "8$\237"
                                                    r65 = r12(r92, r16)
                                                    r61 = r34[r65]
                                                    ReturnVal = r37[r61]
                                                    r61 = upvalueValues[upvalues[2]]
                                                    r34 = upvalueValues[upvalues[3]]
                                                    r92 = 14363158305312
                                                    r65 = "}\174Y\172YW"
                                                    r12 = r34(r65, r92)
                                                    r37 = r61[r12]
                                                    state = ReturnVal[r37]
                                                    state = state and (467) or (468)
                                                end
                                            else
                                                if state == 467 then
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    r61 = upvalueValues[upvalues[2]]
                                                    r34 = upvalueValues[upvalues[3]]
                                                    r92 = 9802642969044
                                                    r65 = "\rV="
                                                    r12 = r34(r65, r92)
                                                    r37 = r61[r12]
                                                    state = ReturnVal[r37]
                                                    ReturnVal = "Remove"
                                                    ReturnVal = state[ReturnVal]
                                                    ReturnVal = ReturnVal(state)
                                                    state = 468
                                                end
                                            end
                                        else
                                            if state == 468 then
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 507 then
                                    if state <= 470 then
                                        if state <= 469 then
                                            -- createClosure0 entry 4169434 -> 469, states 469-469
                                            if state == 469 then -- entry 4169434 -> 469
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                r61 = upvalueValues[upvalues[2]]
                                                r34 = upvalueValues[upvalues[3]]
                                                r65 = "O\151"
                                                r92 = 21392507447017
                                                r12 = r34(r65, r92)
                                                r37 = r61[r12]
                                                state = ReturnVal[r37]
                                                ReturnVal = "Remove"
                                                ReturnVal = state[ReturnVal]
                                                ReturnVal = ReturnVal(state)
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        else
                                            -- createClosure3 entry 2150708 -> 470, states 470-470
                                            if state == 470 then -- entry 2150708 -> 470
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                r61 = upvalueValues[upvalues[2]]
                                                r34 = upvalueValues[upvalues[3]]
                                                r65 = "\138Q\207"
                                                r92 = 15243900918714
                                                r12 = r34(r65, r92)
                                                r37 = r61[r12]
                                                state = ReturnVal[r37]
                                                ReturnVal = "Remove"
                                                ReturnVal = state[ReturnVal]
                                                ReturnVal = ReturnVal(state)
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    else
                                        -- createClosure2 entry 11651778 -> 471, states 471-507
                                        if state <= 489 then
                                            if state <= 480 then
                                                if state <= 475 then
                                                    if state <= 473 then
                                                        if state <= 472 then
                                                            if state <= 471 then
                                                                if state == 471 then -- entry 11651778 -> 471
                                                                    r37 = upvalueValues[upvalues[1]]
                                                                    r34 = upvalueValues[upvalues[2]]
                                                                    r12 = upvalueValues[upvalues[3]]
                                                                    r16 = 2559386567847
                                                                    r92 = "$[\177Z\234d"
                                                                    r65 = r12(r92, r16)
                                                                    r61 = r34[r65]
                                                                    ReturnVal = r37[r61]
                                                                    r61 = upvalueValues[upvalues[2]]
                                                                    r34 = upvalueValues[upvalues[3]]
                                                                    r65 = "\211T\196Q\019=<;"
                                                                    r92 = 15638916504690
                                                                    r12 = r34(r65, r92)
                                                                    r37 = r61[r12]
                                                                    state = ReturnVal[r37]
                                                                    r37 = state
                                                                    state = upvalueValues[upvalues[4]]
                                                                    r61 = state
                                                                    r92 = "GetPlayers"
                                                                    r92 = r61[r92]
                                                                    ReturnVal = "ipairs"
                                                                    state = _env[ReturnVal]
                                                                    r65 = {
                                                                        r92(r61)
                                                                    }
                                                                    r92 = {
                                                                        state(unpack(r65))
                                                                    }
                                                                    ReturnVal = r92[1]
                                                                    r65 = ReturnVal
                                                                    r34 = r92[2]
                                                                    r12 = r92[3]
                                                                    state = 472
                                                                end
                                                            else
                                                                if state == 472 then
                                                                    state = true
                                                                    state = state and (473) or (474)
                                                                end
                                                            end
                                                        else
                                                            if state == 473 then
                                                                state = 475
                                                            end
                                                        end
                                                    else
                                                        if state <= 474 then
                                                            if state == 474 then
                                                                r65 = nil
                                                                r37 = nil
                                                                r61 = nil
                                                                r12 = nil
                                                                r34 = nil
                                                                ReturnVal = {}
                                                                state = nil
                                                            end
                                                        else
                                                            if state == 475 then
                                                                state = true
                                                                state = state and (476) or (477)
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 478 then
                                                        if state <= 477 then
                                                            if state <= 476 then
                                                                if state == 476 then
                                                                    r16 = {
                                                                        r65(r34, r12)
                                                                    }
                                                                    ReturnVal = r16[2]
                                                                    state = nil
                                                                    r92 = state
                                                                    state = r16[1]
                                                                    r12 = state
                                                                    r56 = nil
                                                                    r16 = r12 == r56
                                                                    state = r16 and (478) or (479)
                                                                    r92 = ReturnVal
                                                                end
                                                            else
                                                                if state == 477 then
                                                                    r16 = upvalueValues[upvalues[7]]
                                                                    r62 = "v237"
                                                                    r56 = _env[r62]
                                                                    r92 = r16[r56]
                                                                    state = r92 and (480) or (481)
                                                                end
                                                            end
                                                        else
                                                            if state == 478 then
                                                                ReturnVal = {}
                                                                state = nil
                                                            end
                                                        end
                                                    else
                                                        if state <= 479 then
                                                            if state == 479 then
                                                                r56 = state
                                                                r74 = upvalueValues[upvalues[5]]
                                                                r62 = r92 == r74
                                                                state = r62 and (482) or (483)
                                                                r16 = r62
                                                            end
                                                        else
                                                            if state == 480 then
                                                                r56 = upvalueValues[upvalues[7]]
                                                                r74 = "v237"
                                                                r62 = _env[r74]
                                                                r16 = r56[r62]
                                                                r62 = upvalueValues[upvalues[2]]
                                                                r74 = upvalueValues[upvalues[3]]
                                                                r66 = 6723107097658
                                                                r41 = "E\019"
                                                                r27 = r74(r41, r66)
                                                                r56 = r62[r27]
                                                                r92 = r16[r56]
                                                                r56 = upvalueValues[upvalues[2]]
                                                                r62 = upvalueValues[upvalues[3]]
                                                                r41 = 9283044184290
                                                                r27 = "\167w\240(\008t\240"
                                                                r74 = r62(r27, r41)
                                                                r16 = r56[r74]
                                                                r56 = false
                                                                r92[r16] = r56
                                                                r56 = upvalueValues[upvalues[7]]
                                                                r74 = "v237"
                                                                r62 = _env[r74]
                                                                r16 = r56[r62]
                                                                r62 = upvalueValues[upvalues[2]]
                                                                r74 = upvalueValues[upvalues[3]]
                                                                r66 = 16507522194950
                                                                r41 = "\138\142\017"
                                                                r27 = r74(r41, r66)
                                                                r56 = r62[r27]
                                                                r92 = r16[r56]
                                                                r56 = upvalueValues[upvalues[2]]
                                                                r62 = upvalueValues[upvalues[3]]
                                                                r41 = 3571853870719
                                                                r27 = "\141\167\147\186\240X\178"
                                                                r74 = r62(r27, r41)
                                                                r16 = r56[r74]
                                                                r56 = false
                                                                r92[r16] = r56
                                                                state = 481
                                                            end
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 485 then
                                                    if state <= 483 then
                                                        if state <= 482 then
                                                            if state <= 481 then
                                                                if state == 481 then
                                                                    state = 472
                                                                end
                                                            else
                                                                if state == 482 then
                                                                    state = r56
                                                                    state = r16 and (484) or (485)
                                                                end
                                                            end
                                                        else
                                                            if state == 483 then
                                                                r41 = upvalueValues[upvalues[2]]
                                                                r66 = upvalueValues[upvalues[3]]
                                                                r6 = 23192418757167
                                                                r4 = "^\031\186\253\183\204\024\nQ"
                                                                r68 = r66(r4, r6)
                                                                r27 = r41[r68]
                                                                r74 = r92[r27]
                                                                r62 = not r74
                                                                r16 = r62
                                                                state = 482
                                                            end
                                                        end
                                                    else
                                                        if state <= 484 then
                                                            if state == 484 then
                                                                r14 = nil
                                                                r67 = nil
                                                                r68 = nil
                                                                r56 = nil
                                                                r74 = nil
                                                                r4 = nil
                                                                r39 = nil
                                                                r16 = nil
                                                                r54 = nil
                                                                r66 = nil
                                                                r90 = nil
                                                                r92 = nil
                                                                r6 = nil
                                                                r27 = nil
                                                                r13 = nil
                                                                r62 = nil
                                                                r41 = nil
                                                                state = 477
                                                            end
                                                        else
                                                            if state == 485 then
                                                                r15 = upvalueValues[upvalues[2]]
                                                                r24 = upvalueValues[upvalues[3]]
                                                                r38 = "t\203I 8c^y6"
                                                                r32 = 2223649768459
                                                                r36 = r24(r38, r32)
                                                                r91 = r15[r36]
                                                                r84 = r92[r91]
                                                                r16 = r84
                                                                r15 = upvalueValues[upvalues[2]]
                                                                r24 = upvalueValues[upvalues[3]]
                                                                r32 = 33778878725489
                                                                r38 = "\139\243\222\014\205\134\018D"
                                                                r36 = r24(r38, r32)
                                                                r91 = r15[r36]
                                                                r84 = "FindFirstChildOfClass"
                                                                r84 = r16[r84]
                                                                r84 = r84(r16, r91)
                                                                r56 = r84
                                                                r15 = upvalueValues[upvalues[2]]
                                                                r24 = upvalueValues[upvalues[3]]
                                                                r38 = "\200\254\207\015\221M8\196\153?R\224\227\239\207\198"
                                                                r32 = 140161810497
                                                                r36 = r24(r38, r32)
                                                                r91 = r15[r36]
                                                                r15 = not r56
                                                                r84 = "FindFirstChild"
                                                                r84 = r16[r84]
                                                                r84 = r84(r16, r91)
                                                                r62 = r84
                                                                r91 = state
                                                                state = r15 and (486) or (487)
                                                                r84 = r15
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 487 then
                                                        if state <= 486 then
                                                            if state == 486 then
                                                                state = r91
                                                                state = r84 and (488) or (489)
                                                            end
                                                        else
                                                            if state == 487 then
                                                                r24 = state
                                                                r36 = not r62
                                                                state = r36 and (490) or (491)
                                                                r15 = r36
                                                            end
                                                        end
                                                    else
                                                        if state <= 488 then
                                                            if state == 488 then
                                                                state = 489
                                                            end
                                                        else
                                                            if state == 489 then
                                                                r15 = upvalueValues[upvalues[7]]
                                                                r91 = r15[r92]
                                                                r84 = not r91
                                                                state = r84 and (492) or (493)
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 498 then
                                                if state <= 494 then
                                                    if state <= 492 then
                                                        if state <= 491 then
                                                            if state <= 490 then
                                                                if state == 490 then
                                                                    state = r24
                                                                    r84 = r15
                                                                    state = 486
                                                                end
                                                            else
                                                                if state == 491 then
                                                                    r19 = upvalueValues[upvalues[2]]
                                                                    r70 = upvalueValues[upvalues[3]]
                                                                    r59 = 1086311055865
                                                                    r9 = "hZ0_\2003<7"
                                                                    r8 = r70(r9, r59)
                                                                    r1 = r19[r8]
                                                                    r73 = r62[r1]
                                                                    r32 = r37 - r73
                                                                    r1 = upvalueValues[upvalues[2]]
                                                                    r19 = upvalueValues[upvalues[3]]
                                                                    r8 = "\254\215\026\2328\213\026^\186"
                                                                    r9 = 28211006141264
                                                                    r70 = r19(r8, r9)
                                                                    r73 = r1[r70]
                                                                    r38 = r32[r73]
                                                                    r32 = upvalueValues[upvalues[6]]
                                                                    r36 = r38 > r32
                                                                    r15 = r36
                                                                    state = 490
                                                                end
                                                            end
                                                        else
                                                            if state == 492 then
                                                                r84 = upvalueValues[upvalues[7]]
                                                                r91 = upvalueValues[upvalues[8]]
                                                                r15 = r91()
                                                                r84[r92] = r15
                                                                state = 493
                                                            end
                                                        end
                                                    else
                                                        if state <= 493 then
                                                            if state == 493 then
                                                                r91 = upvalueValues[upvalues[7]]
                                                                r84 = r91[r92]
                                                                r74 = r84
                                                                r84 = upvalueValues[upvalues[9]]
                                                                r91 = r84(r16)
                                                                r27 = r91
                                                                r91 = #r27
                                                                r15 = 0
                                                                r84 = r91 <= r15
                                                                state = r84 and (494) or (495)
                                                            end
                                                        else
                                                            if state == 494 then
                                                                r15 = upvalueValues[upvalues[2]]
                                                                r24 = upvalueValues[upvalues[3]]
                                                                r38 = "\203g"
                                                                r32 = 15015283022672
                                                                r36 = r24(r38, r32)
                                                                r91 = r15[r36]
                                                                r84 = r74[r91]
                                                                r15 = upvalueValues[upvalues[2]]
                                                                r24 = upvalueValues[upvalues[3]]
                                                                r38 = "\031X\130\186a\176\248"
                                                                r32 = 14100231870885
                                                                r36 = r24(r38, r32)
                                                                r91 = r15[r36]
                                                                r15 = false
                                                                r84[r91] = r15
                                                                r15 = upvalueValues[upvalues[2]]
                                                                r24 = upvalueValues[upvalues[3]]
                                                                r38 = "\023\011\030"
                                                                r32 = 7547029392826
                                                                r36 = r24(r38, r32)
                                                                r91 = r15[r36]
                                                                r84 = r74[r91]
                                                                r15 = upvalueValues[upvalues[2]]
                                                                r24 = upvalueValues[upvalues[3]]
                                                                r38 = "\228\155\016$\209\206\243"
                                                                r32 = 11415350940867
                                                                r36 = r24(r38, r32)
                                                                r91 = r15[r36]
                                                                r15 = false
                                                                r84[r91] = r15
                                                                state = 495
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 496 then
                                                        if state <= 495 then
                                                            if state == 495 then
                                                                r15 = "math"
                                                                r91 = _env[r15]
                                                                r24 = upvalueValues[upvalues[2]]
                                                                r36 = upvalueValues[upvalues[3]]
                                                                r73 = 22145901979720
                                                                r32 = "\011\201\174i"
                                                                r38 = r36(r32, r73)
                                                                r15 = r24[r38]
                                                                r84 = r91[r15]
                                                                r41 = r84
                                                                r15 = "math"
                                                                r91 = _env[r15]
                                                                r24 = upvalueValues[upvalues[2]]
                                                                r36 = upvalueValues[upvalues[3]]
                                                                r32 = "1P\021f"
                                                                r73 = 22633247238443
                                                                r38 = r36(r32, r73)
                                                                r15 = r24[r38]
                                                                r84 = r91[r15]
                                                                r66 = r84
                                                                r24 = "math"
                                                                r15 = _env[r24]
                                                                r36 = upvalueValues[upvalues[2]]
                                                                r38 = upvalueValues[upvalues[3]]
                                                                r1 = 17608746901511
                                                                r73 = "\149\214\184\175"
                                                                r32 = r38(r73, r1)
                                                                r24 = r36[r32]
                                                                r91 = r15[r24]
                                                                r84 = -r91
                                                                r68 = r84
                                                                r24 = "math"
                                                                r15 = _env[r24]
                                                                r36 = upvalueValues[upvalues[2]]
                                                                r38 = upvalueValues[upvalues[3]]
                                                                r1 = 24893576457543
                                                                r73 = "\220\182\135 "
                                                                r32 = r38(r73, r1)
                                                                r24 = r36[r32]
                                                                r91 = r15[r24]
                                                                r84 = -r91
                                                                r4 = r84
                                                                r91 = "ipairs"
                                                                r84 = _env[r91]
                                                                r36 = {
                                                                    r84(r27)
                                                                }
                                                                r91 = r36[1]
                                                                r15 = r36[2]
                                                                r24 = r36[3]
                                                                r6 = r91
                                                                r90 = r24
                                                                r39 = r15
                                                                state = 496
                                                            end
                                                        else
                                                            if state == 496 then
                                                                r84 = true
                                                                state = r84 and (497) or (498)
                                                            end
                                                        end
                                                    else
                                                        if state <= 497 then
                                                            if state == 497 then
                                                                r24 = {
                                                                    r6(r39, r90)
                                                                }
                                                                r91 = r24[1]
                                                                r15 = r24[2]
                                                                r90 = r91
                                                                r36 = nil
                                                                r24 = r90 == r36
                                                                state = r24 and (499) or (500)
                                                                r84 = nil
                                                                r84 = r15
                                                            end
                                                        else
                                                            if state == 498 then
                                                                r24 = r68 - r41
                                                                r1 = 0.08
                                                                r84 = r24 * r1
                                                                r13 = r84
                                                                r84 = r4 - r66
                                                                r54 = r84
                                                                r1 = "math"
                                                                r24 = _env[r1]
                                                                r19 = upvalueValues[upvalues[2]]
                                                                r70 = upvalueValues[upvalues[3]]
                                                                r59 = 32047058549323
                                                                r9 = "?6\135\209C"
                                                                r8 = r70(r9, r59)
                                                                r1 = r19[r8]
                                                                r84 = r24[r1]
                                                                r8 = upvalueValues[upvalues[2]]
                                                                r9 = upvalueValues[upvalues[3]]
                                                                r98 = 32033118878276
                                                                r2 = "qz\230y0E"
                                                                r59 = r9(r2, r98)
                                                                r70 = r8[r59]
                                                                r19 = r56[r70]
                                                                r8 = state
                                                                r42 = upvalueValues[upvalues[2]]
                                                                r94 = upvalueValues[upvalues[3]]
                                                                r23 = "\144\191\137\175\147\028\236\182\022"
                                                                r99 = 34005447245275
                                                                r76 = r94(r23, r99)
                                                                r46 = r42[r76]
                                                                r98 = r56[r46]
                                                                r46 = 0
                                                                r2 = r98 > r46
                                                                r59 = state
                                                                state = r2 and (501) or (502)
                                                                r9 = r2
                                                            end
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 503 then
                                                    if state <= 501 then
                                                        if state <= 500 then
                                                            if state <= 499 then
                                                                if state == 499 then
                                                                    r84 = nil
                                                                    state = 498
                                                                end
                                                            else
                                                                if state == 500 then
                                                                    r38 = "math"
                                                                    r36 = _env[r38]
                                                                    r32 = upvalueValues[upvalues[2]]
                                                                    r73 = upvalueValues[upvalues[3]]
                                                                    r70 = 22212343457895
                                                                    r19 = "\167\167\239"
                                                                    r1 = r73(r19, r70)
                                                                    r38 = r32[r1]
                                                                    r24 = r36[r38]
                                                                    r73 = upvalueValues[upvalues[2]]
                                                                    r1 = upvalueValues[upvalues[3]]
                                                                    r8 = 13545023920291
                                                                    r70 = "\199"
                                                                    r19 = r1(r70, r8)
                                                                    r32 = r73[r19]
                                                                    r38 = r84[r32]
                                                                    r36 = r24(r41, r38)
                                                                    r41 = r36
                                                                    r32 = "math"
                                                                    r38 = _env[r32]
                                                                    r73 = upvalueValues[upvalues[2]]
                                                                    r1 = upvalueValues[upvalues[3]]
                                                                    r8 = 26268330241992
                                                                    r70 = "\137\176'"
                                                                    r19 = r1(r70, r8)
                                                                    r32 = r73[r19]
                                                                    r24 = r38[r32]
                                                                    r1 = upvalueValues[upvalues[2]]
                                                                    r19 = upvalueValues[upvalues[3]]
                                                                    r9 = 27917958640328
                                                                    r8 = "\188"
                                                                    r70 = r19(r8, r9)
                                                                    r73 = r1[r70]
                                                                    r32 = r84[r73]
                                                                    r38 = r24(r66, r32)
                                                                    r66 = r38
                                                                    r73 = "math"
                                                                    r32 = _env[r73]
                                                                    r1 = upvalueValues[upvalues[2]]
                                                                    r19 = upvalueValues[upvalues[3]]
                                                                    r9 = 6138284067626
                                                                    r8 = "Z?\222"
                                                                    r70 = r19(r8, r9)
                                                                    r73 = r1[r70]
                                                                    r24 = r32[r73]
                                                                    r19 = upvalueValues[upvalues[2]]
                                                                    r70 = upvalueValues[upvalues[3]]
                                                                    r59 = 7314688871758
                                                                    r9 = "\179"
                                                                    r8 = r70(r9, r59)
                                                                    r1 = r19[r8]
                                                                    r73 = r84[r1]
                                                                    r32 = r24(r68, r73)
                                                                    r68 = r32
                                                                    r1 = "math"
                                                                    r73 = _env[r1]
                                                                    r19 = upvalueValues[upvalues[2]]
                                                                    r70 = upvalueValues[upvalues[3]]
                                                                    r59 = 10640611431258
                                                                    r9 = "%\001c"
                                                                    r8 = r70(r9, r59)
                                                                    r1 = r19[r8]
                                                                    r24 = r73[r1]
                                                                    r70 = upvalueValues[upvalues[2]]
                                                                    r8 = upvalueValues[upvalues[3]]
                                                                    r2 = 29561995883973
                                                                    r59 = "\017"
                                                                    r9 = r8(r59, r2)
                                                                    r19 = r70[r9]
                                                                    r1 = r84[r19]
                                                                    r84 = nil
                                                                    r73 = r24(r4, r1)
                                                                    r4 = r73
                                                                    state = 496
                                                                end
                                                            end
                                                        else
                                                            if state == 501 then
                                                                r46 = upvalueValues[upvalues[2]]
                                                                r42 = upvalueValues[upvalues[3]]
                                                                r76 = "\015\246\231ts{\225^I"
                                                                r23 = 8883625594920
                                                                r94 = r42(r76, r23)
                                                                r98 = r46[r94]
                                                                r2 = r56[r98]
                                                                r9 = r2
                                                                state = 502
                                                            end
                                                        end
                                                    else
                                                        if state <= 502 then
                                                            if state == 502 then
                                                                state = r59
                                                                r59 = 100
                                                                r70 = r9 or r59
                                                                r1 = r19 / r70
                                                                r19 = 0
                                                                r70 = 1
                                                                r24 = r84(r1, r19, r70)
                                                                r14 = r24
                                                                r84 = r54 * r14
                                                                r67 = r84
                                                                r1 = upvalueValues[upvalues[2]]
                                                                r19 = upvalueValues[upvalues[3]]
                                                                r8 = "\184\149"
                                                                r9 = 24605875236034
                                                                r70 = r19(r8, r9)
                                                                r24 = r1[r70]
                                                                r84 = r74[r24]
                                                                r1 = upvalueValues[upvalues[2]]
                                                                r19 = upvalueValues[upvalues[3]]
                                                                r8 = " \209<\171"
                                                                r9 = 14064976058773
                                                                r70 = r19(r8, r9)
                                                                r24 = r1[r70]
                                                                r70 = "Vector2"
                                                                r19 = _env[r70]
                                                                r8 = upvalueValues[upvalues[2]]
                                                                r9 = upvalueValues[upvalues[3]]
                                                                r98 = 33403267284162
                                                                r2 = "\2059\155"
                                                                r59 = r9(r2, r98)
                                                                r70 = r8[r59]
                                                                r1 = r19[r70]
                                                                r19 = r1(r13, r54)
                                                                r84[r24] = r19
                                                                r1 = upvalueValues[upvalues[2]]
                                                                r19 = upvalueValues[upvalues[3]]
                                                                r8 = "\190\011"
                                                                r9 = 27165261803881
                                                                r70 = r19(r8, r9)
                                                                r24 = r1[r70]
                                                                r84 = r74[r24]
                                                                r1 = upvalueValues[upvalues[2]]
                                                                r19 = upvalueValues[upvalues[3]]
                                                                r8 = "\204GW\226\206\156h\211"
                                                                r9 = 29703892579847
                                                                r70 = r19(r8, r9)
                                                                r24 = r1[r70]
                                                                r70 = "Vector2"
                                                                r19 = _env[r70]
                                                                r8 = upvalueValues[upvalues[2]]
                                                                r9 = upvalueValues[upvalues[3]]
                                                                r98 = 21411313936114
                                                                r2 = "\1568,"
                                                                r59 = r9(r2, r98)
                                                                r70 = r8[r59]
                                                                r1 = r19[r70]
                                                                r8 = r41 - r13
                                                                r9 = 5
                                                                r70 = r8 - r9
                                                                r19 = r1(r70, r66)
                                                                r84[r24] = r19
                                                                r1 = upvalueValues[upvalues[2]]
                                                                r19 = upvalueValues[upvalues[3]]
                                                                r8 = "qH"
                                                                r9 = 29388911588725
                                                                r70 = r19(r8, r9)
                                                                r24 = r1[r70]
                                                                r84 = r74[r24]
                                                                r1 = upvalueValues[upvalues[2]]
                                                                r19 = upvalueValues[upvalues[3]]
                                                                r8 = "\210\215\196Fv\208S"
                                                                r9 = 28298399200121
                                                                r70 = r19(r8, r9)
                                                                r24 = r1[r70]
                                                                r1 = true
                                                                r84[r24] = r1
                                                                r1 = upvalueValues[upvalues[2]]
                                                                r19 = upvalueValues[upvalues[3]]
                                                                r9 = 21551475746611
                                                                r8 = "\t\016\245"
                                                                r70 = r19(r8, r9)
                                                                r24 = r1[r70]
                                                                r84 = r74[r24]
                                                                r1 = upvalueValues[upvalues[2]]
                                                                r19 = upvalueValues[upvalues[3]]
                                                                r9 = 30475222644591
                                                                r8 = "\144\172\248,"
                                                                r70 = r19(r8, r9)
                                                                r24 = r1[r70]
                                                                r70 = "Vector2"
                                                                r19 = _env[r70]
                                                                r8 = upvalueValues[upvalues[2]]
                                                                r9 = upvalueValues[upvalues[3]]
                                                                r98 = 21325033236170
                                                                r2 = "\142\129\251"
                                                                r59 = r9(r2, r98)
                                                                r70 = r8[r59]
                                                                r1 = r19[r70]
                                                                r19 = r1(r13, r67)
                                                                r84[r24] = r19
                                                                r1 = upvalueValues[upvalues[2]]
                                                                r19 = upvalueValues[upvalues[3]]
                                                                r8 = "f\011\227"
                                                                r9 = 1382386680451
                                                                r70 = r19(r8, r9)
                                                                r24 = r1[r70]
                                                                r84 = r74[r24]
                                                                r1 = upvalueValues[upvalues[2]]
                                                                r19 = upvalueValues[upvalues[3]]
                                                                r8 = "\173>\193\138\233X\238o"
                                                                r9 = 9391082410261
                                                                r70 = r19(r8, r9)
                                                                r24 = r1[r70]
                                                                r70 = "Vector2"
                                                                r19 = _env[r70]
                                                                r8 = upvalueValues[upvalues[2]]
                                                                r9 = upvalueValues[upvalues[3]]
                                                                r98 = 28872062628996
                                                                r2 = "\196[6"
                                                                r59 = r9(r2, r98)
                                                                r70 = r8[r59]
                                                                r1 = r19[r70]
                                                                r8 = r41 - r13
                                                                r9 = 5
                                                                r70 = r8 - r9
                                                                r8 = r4 - r67
                                                                r19 = r1(r70, r8)
                                                                r84[r24] = r19
                                                                r1 = upvalueValues[upvalues[2]]
                                                                r19 = upvalueValues[upvalues[3]]
                                                                r8 = "g\162\130"
                                                                r9 = 12797737621319
                                                                r70 = r19(r8, r9)
                                                                r24 = r1[r70]
                                                                r84 = r74[r24]
                                                                r1 = upvalueValues[upvalues[2]]
                                                                r19 = upvalueValues[upvalues[3]]
                                                                r8 = "\136J\249\028\212dg"
                                                                r9 = 31536984389981
                                                                r70 = r19(r8, r9)
                                                                r24 = r1[r70]
                                                                r1 = true
                                                                r84[r24] = r1
                                                                r24 = 0.65
                                                                r84 = r14 > r24
                                                                state = r84 and (503) or (504)
                                                            end
                                                        else
                                                            if state == 503 then
                                                                r1 = upvalueValues[upvalues[2]]
                                                                r19 = upvalueValues[upvalues[3]]
                                                                r8 = "\248\171\207"
                                                                r9 = 16320937778608
                                                                r70 = r19(r8, r9)
                                                                r24 = r1[r70]
                                                                r84 = r74[r24]
                                                                r1 = upvalueValues[upvalues[2]]
                                                                r19 = upvalueValues[upvalues[3]]
                                                                r8 = "\212\227f\140A"
                                                                r9 = 30406484522831
                                                                r70 = r19(r8, r9)
                                                                r24 = r1[r70]
                                                                r70 = "Color3"
                                                                r19 = _env[r70]
                                                                r8 = upvalueValues[upvalues[2]]
                                                                r9 = upvalueValues[upvalues[3]]
                                                                r98 = 21246188742309
                                                                r2 = "52`\176\184\1566"
                                                                r59 = r9(r2, r98)
                                                                r70 = r8[r59]
                                                                r1 = r19[r70]
                                                                r8 = 255
                                                                r9 = 0
                                                                r70 = 0
                                                                r19 = r1(r70, r8, r9)
                                                                r84[r24] = r19
                                                                state = 505
                                                            end
                                                        end
                                                    end
                                                else
                                                    if state <= 505 then
                                                        if state <= 504 then
                                                            if state == 504 then
                                                                r24 = 0.35
                                                                r84 = r14 > r24
                                                                state = r84 and (506) or (507)
                                                            end
                                                        else
                                                            if state == 505 then
                                                                r74 = nil
                                                                r62 = nil
                                                                r4 = nil
                                                                r92 = nil
                                                                r66 = nil
                                                                r39 = nil
                                                                r6 = nil
                                                                r68 = nil
                                                                r13 = nil
                                                                r41 = nil
                                                                r16 = nil
                                                                r90 = nil
                                                                r56 = nil
                                                                r27 = nil
                                                                r67 = nil
                                                                r54 = nil
                                                                r14 = nil
                                                                state = 475
                                                            end
                                                        end
                                                    else
                                                        if state <= 506 then
                                                            if state == 506 then
                                                                r1 = upvalueValues[upvalues[2]]
                                                                r19 = upvalueValues[upvalues[3]]
                                                                r8 = "\134\239\129"
                                                                r9 = 3348909131287
                                                                r70 = r19(r8, r9)
                                                                r24 = r1[r70]
                                                                r84 = r74[r24]
                                                                r1 = upvalueValues[upvalues[2]]
                                                                r19 = upvalueValues[upvalues[3]]
                                                                r9 = 8767136337906
                                                                r8 = "\196\185\129\189\186"
                                                                r70 = r19(r8, r9)
                                                                r24 = r1[r70]
                                                                r70 = "Color3"
                                                                r19 = _env[r70]
                                                                r8 = upvalueValues[upvalues[2]]
                                                                r9 = upvalueValues[upvalues[3]]
                                                                r98 = 12330146879085
                                                                r2 = "=s\212\144\236k\015"
                                                                r59 = r9(r2, r98)
                                                                r70 = r8[r59]
                                                                r1 = r19[r70]
                                                                r8 = 190
                                                                r9 = 0
                                                                r70 = 255
                                                                r19 = r1(r70, r8, r9)
                                                                r84[r24] = r19
                                                                state = 505
                                                            end
                                                        else
                                                            if state == 507 then
                                                                r1 = upvalueValues[upvalues[2]]
                                                                r19 = upvalueValues[upvalues[3]]
                                                                r8 = "MAI"
                                                                r9 = 31266867771615
                                                                r70 = r19(r8, r9)
                                                                r24 = r1[r70]
                                                                r84 = r74[r24]
                                                                r1 = upvalueValues[upvalues[2]]
                                                                r19 = upvalueValues[upvalues[3]]
                                                                r9 = 14905420405532
                                                                r8 = "\243\234\187\223\n"
                                                                r70 = r19(r8, r9)
                                                                r24 = r1[r70]
                                                                r70 = "Color3"
                                                                r19 = _env[r70]
                                                                r8 = upvalueValues[upvalues[2]]
                                                                r9 = upvalueValues[upvalues[3]]
                                                                r98 = 19644835750843
                                                                r2 = "\197\193\135\164\233\n\238"
                                                                r59 = r9(r2, r98)
                                                                r70 = r8[r59]
                                                                r1 = r19[r70]
                                                                r8 = 0
                                                                r9 = 0
                                                                r70 = 255
                                                                r19 = r1(r70, r8, r9)
                                                                r84[r24] = r19
                                                                state = 505
                                                            end
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    if state <= 510 then
                                        -- createClosure4 entry 15133232 -> 508, states 508-510
                                        if state <= 509 then
                                            if state <= 508 then
                                                if state == 508 then -- entry 15133232 -> 508
                                                    r37 = upvalueValues[upvalues[1]]
                                                    r34 = upvalueValues[upvalues[2]]
                                                    r12 = upvalueValues[upvalues[3]]
                                                    r16 = 22788778551667
                                                    r92 = "\181%\214\254\2554G\004j\178\139- \030"
                                                    r65 = r12(r92, r16)
                                                    r61 = r34[r65]
                                                    ReturnVal = r37[r61]
                                                    r12 = "Enum"
                                                    r34 = _env[r12]
                                                    r65 = upvalueValues[upvalues[2]]
                                                    r92 = upvalueValues[upvalues[3]]
                                                    r56 = "\2145\217Q\177\250!A\184\170\027\159\189\187"
                                                    r62 = 16679519936087
                                                    r16 = r92(r56, r62)
                                                    r12 = r65[r16]
                                                    r61 = r34[r12]
                                                    r12 = upvalueValues[upvalues[2]]
                                                    r65 = upvalueValues[upvalues[3]]
                                                    r56 = 31137850013859
                                                    r16 = "*\170\176"
                                                    r92 = r65(r16, r56)
                                                    r34 = r12[r92]
                                                    r37 = r61[r34]
                                                    state = ReturnVal == r37
                                                    state = state and (509) or (510)
                                                end
                                            else
                                                if state == 509 then
                                                    state = false
                                                    upvalueValues[upvalues[4]] = state
                                                    state = 510
                                                end
                                            end
                                        else
                                            if state == 510 then
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    else
                                        -- createClosure0 entry 15160976 -> 511, states 511-511
                                        if state == 511 then -- entry 15160976 -> 511
                                            state = upvalueValues[upvalues[1]]
                                            r61 = upvalueValues[upvalues[2]]
                                            r34 = upvalueValues[upvalues[3]]
                                            ReturnVal = "WaitForChild"
                                            ReturnVal = state[ReturnVal]
                                            r92 = 2673406018780
                                            r65 = "L\134K(\001\000\186\194\165"
                                            r12 = r34(r65, r92)
                                            r37 = r61[r12]
                                            ReturnVal = ReturnVal(state, r37)
                                            r61 = upvalueValues[upvalues[2]]
                                            r34 = upvalueValues[upvalues[3]]
                                            r92 = 32351158024920
                                            r65 = "\165\170\203\218\2261r\029@\177"
                                            r12 = r34(r65, r92)
                                            r37 = r61[r12]
                                            state = "WaitForChild"
                                            state = ReturnVal[state]
                                            state = state(ReturnVal, r37)
                                            ReturnVal = "WaitForChild"
                                            ReturnVal = state[ReturnVal]
                                            r61 = upvalueValues[upvalues[2]]
                                            r34 = upvalueValues[upvalues[3]]
                                            r65 = "\243\161\0152\029\229'J\168}"
                                            r92 = 22583948241172
                                            r12 = r34(r65, r92)
                                            r37 = r61[r12]
                                            ReturnVal = ReturnVal(state, r37)
                                            r61 = upvalueValues[upvalues[2]]
                                            r34 = upvalueValues[upvalues[3]]
                                            r65 = ",,-H\004\197n\003#,"
                                            r92 = 18030698193100
                                            r12 = r34(r65, r92)
                                            r37 = r61[r12]
                                            r61 = "WaitForChild"
                                            r61 = ReturnVal[r61]
                                            state = {
                                                r61(ReturnVal, r37)
                                            }
                                            ReturnVal = {
                                                unpack(state)
                                            }
                                            state = nil
                                        end
                                    end
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