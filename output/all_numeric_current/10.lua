return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, upvalueRefCounts, createClosure, upvalueValues, releaseUpvalue, allocUpvalue, createUpvalueProxy, currentUpvalueId, vm, releaseUpvalues)
        upvalueRefCounts = {}
        vm = function(state, args, upvalues, gcProxy)
            local RegisterOverflow = {}
            local r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53, r54, r55, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, r66, r67, r68, r69, r70, r71, r72, r73, r74, r75, r76, r77, r78, r79, r80, r81, r82, r83, r84, r85, r86, r87, r88, r89, r90, r91, r92, r93, r94, r95, r96, ReturnVal, r97, r98, r99
            while state do
                -- root entry 4222331 -> 1, states 1-1
                if state == 1 then -- entry 4222331 -> 1
                    state = 1
                    r83 = state
                    state = 2
                    r15 = state
                    state = 3
                    r55 = state
                    state = 4
                    r12 = state
                    state = 5
                    r64 = state
                    state = 6
                    r13 = state
                    state = 7
                    r75 = state
                    state = 8
                    r40 = state
                    state = 9
                    r44 = state
                    state = 10
                    r36 = state
                    state = 11
                    r18 = state
                    state = 12
                    r57 = state
                    state = 13
                    r21 = state
                    state = 14
                    r35 = state
                    state = 15
                    r37 = state
                    state = 16
                    r65 = state
                    state = 17
                    r49 = state
                    state = 18
                    r77 = state
                    state = 19
                    r69 = state
                    state = 20
                    r2 = state
                    state = 21
                    r67 = state
                    state = 22
                    r1 = state
                    state = 23
                    r94 = state
                    state = 24
                    r33 = state
                    state = 25
                    r17 = state
                    state = 26
                    r71 = state
                    state = 27
                    r47 = state
                    state = 28
                    r20 = state
                    state = 29
                    r25 = state
                    state = 30
                    r30 = state
                    state = 31
                    r51 = state
                    state = 32
                    r19 = state
                    state = 33
                    r90 = state
                    state = 34
                    r87 = state
                    state = 35
                    r29 = state
                    state = 36
                    r92 = state
                    state = 37
                    r97 = state
                    state = 38
                    r42 = state
                    state = 39
                    r52 = state
                    state = 40
                    r22 = state
                    state = 41
                    r32 = state
                    state = 42
                    r79 = state
                    state = 43
                    r61 = state
                    state = 44
                    r43 = state
                    state = 45
                    r68 = state
                    state = 46
                    r16 = state
                    state = 47
                    r38 = state
                    state = 48
                    r23 = state
                    state = 49
                    r76 = state
                    state = 50
                    r98 = state
                    state = 51
                    r41 = state
                    state = 52
                    r26 = state
                    state = 53
                    r73 = state
                    state = 54
                    r31 = state
                    state = 55
                    r58 = state
                    state = 56
                    r39 = state
                    state = 57
                    r24 = state
                    state = 58
                    r59 = state
                    state = 59
                    r66 = state
                    state = 60
                    r72 = state
                    state = 61
                    r78 = state
                    state = 62
                    r6 = state
                    state = 63
                    r3 = state
                    state = 64
                    r60 = state
                    state = 65
                    r99 = state
                    state = 66
                    r74 = state
                    state = 67
                    r86 = state
                    state = 68
                    r14 = state
                    state = 69
                    r63 = state
                    state = 70
                    r62 = state
                    state = 71
                    r8 = state
                    state = 72
                    r96 = state
                    state = 73
                    r28 = state
                    state = 74
                    r9 = state
                    state = 75
                    r93 = state
                    state = 76
                    r54 = state
                    state = 77
                    r7 = state
                    state = 78
                    r45 = state
                    state = 79
                    r46 = state
                    state = 80
                    r11 = state
                    state = 81
                    r5 = state
                    state = 82
                    r85 = state
                    state = 83
                    r56 = state
                    state = 84
                    r10 = state
                    state = 85
                    r88 = state
                    state = 86
                    r91 = state
                    state = 87
                    r81 = state
                    state = 88
                    r89 = state
                    state = 89
                    r80 = state
                    state = 90
                    r95 = state
                    state = 91
                    r82 = state
                    state = 92
                    r70 = state
                    state = 93
                    r48 = state
                    state = 94
                    r84 = state
                    state = 95
                    r4 = state
                    state = 96
                    r27 = state
                    state = 97
                    r53 = state
                    state = 98
                    r34 = state
                    state = 99
                    RegisterOverflow[1] = state
                    state = 100
                    RegisterOverflow[2] = state
                    state = 101
                    RegisterOverflow[3] = state
                    state = 102
                    RegisterOverflow[4] = state
                    state = 103
                    RegisterOverflow[5] = state
                    state = 104
                    RegisterOverflow[6] = state
                    state = 105
                    RegisterOverflow[7] = state
                    state = 106
                    RegisterOverflow[8] = state
                    state = 107
                    RegisterOverflow[9] = state
                    state = 108
                    RegisterOverflow[10] = state
                    state = 109
                    RegisterOverflow[11] = state
                    state = 110
                    RegisterOverflow[12] = state
                    ReturnVal = 1000
                    state = r83 + ReturnVal
                    RegisterOverflow[13] = 1000
                    ReturnVal = r34 + RegisterOverflow[13]
                    RegisterOverflow[14] = 1000
                    RegisterOverflow[13] = RegisterOverflow[1] + RegisterOverflow[14]
                    RegisterOverflow[15] = 1000
                    RegisterOverflow[14] = RegisterOverflow[2] + RegisterOverflow[15]
                    r34 = ReturnVal
                    ReturnVal = {}
                    RegisterOverflow[16] = 1000
                    RegisterOverflow[15] = RegisterOverflow[3] + RegisterOverflow[16]
                    RegisterOverflow[17] = 1000
                    RegisterOverflow[16] = RegisterOverflow[12] + RegisterOverflow[17]
                    RegisterOverflow[2] = RegisterOverflow[14]
                    r83 = state
                    RegisterOverflow[1] = RegisterOverflow[13]
                    RegisterOverflow[12] = RegisterOverflow[16]
                    RegisterOverflow[3] = RegisterOverflow[15]
                    RegisterOverflow[18] = "print"
                    RegisterOverflow[17] = _env[RegisterOverflow[18]]
                    RegisterOverflow[19] = "overflow-test"
                    RegisterOverflow[18] = RegisterOverflow[17](RegisterOverflow[19], r83, r34, RegisterOverflow[1], RegisterOverflow[2], RegisterOverflow[3], RegisterOverflow[12])
                    r53 = nil
                    r90 = nil
                    r74 = nil
                    r30 = nil
                    r93 = nil
                    r50 = args
                    r12 = nil
                    r21 = nil
                    r75 = nil
                    r57 = nil
                    r71 = nil
                    r51 = nil
                    r37 = nil
                    r79 = nil
                    r19 = nil
                    r13 = nil
                    r49 = nil
                    r40 = nil
                    r36 = nil
                    r35 = nil
                    r94 = nil
                    r55 = nil
                    r66 = nil
                    r64 = nil
                    r15 = nil
                    r72 = nil
                    r52 = nil
                    r61 = nil
                    r98 = nil
                    r65 = nil
                    r31 = nil
                    r77 = nil
                    r43 = nil
                    r33 = nil
                    r23 = nil
                    r60 = nil
                    r86 = nil
                    r78 = nil
                    r76 = nil
                    r3 = nil
                    r42 = nil
                    r22 = nil
                    r99 = nil
                    r63 = nil
                    r26 = nil
                    r67 = nil
                    r25 = nil
                    r59 = nil
                    r69 = nil
                    r1 = nil
                    r16 = nil
                    r45 = nil
                    r88 = nil
                    r44 = nil
                    r56 = nil
                    r9 = nil
                    r14 = nil
                    r17 = nil
                    r38 = nil
                    r73 = nil
                    r81 = nil
                    r2 = nil
                    r89 = nil
                    r5 = nil
                    r10 = nil
                    r68 = nil
                    r87 = nil
                    r29 = nil
                    r70 = nil
                    r6 = nil
                    r95 = nil
                    r32 = nil
                    r47 = nil
                    r18 = nil
                    r41 = nil
                    r54 = nil
                    r27 = nil
                    r20 = nil
                    r11 = nil
                    r96 = nil
                    r28 = nil
                    r85 = nil
                    r39 = nil
                    r84 = nil
                    RegisterOverflow[5] = nil
                    r46 = nil
                    r62 = nil
                    r97 = nil
                    RegisterOverflow[8] = nil
                    r4 = nil
                    RegisterOverflow[9] = nil
                    r7 = nil
                    RegisterOverflow[7] = nil
                    RegisterOverflow[6] = nil
                    RegisterOverflow[4] = nil
                    r80 = nil
                    r24 = nil
                    r91 = nil
                    r82 = nil
                    r58 = nil
                    r48 = nil
                    r8 = nil
                    r92 = nil
                    r34 = nil
                    RegisterOverflow[3] = nil
                    RegisterOverflow[10] = nil
                    RegisterOverflow[2] = nil
                    RegisterOverflow[12] = nil
                    RegisterOverflow[1] = nil
                    RegisterOverflow[11] = nil
                    r83 = nil
                    state = nil
                end
            end
            state = #gcProxy
            return unpack(ReturnVal)
        end
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return 1343931
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 1343931
                    end
                })
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
        upvalueValues = {}
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        currentUpvalueId = 0
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if 0 == upvalueRefCounts[upvalueId] then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
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
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)