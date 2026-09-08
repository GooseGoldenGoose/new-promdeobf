return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, vm, createClosure2, createClosure3, createClosure1, createUpvalueProxy, releaseUpvalues, createClosure4, upvalueRefCounts, releaseUpvalue, createClosure, createClosure6, createClosure0, allocUpvalue, upvalueValues, createClosure7, currentUpvalueId, createClosure5)
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
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = upvalueRefCounts[captures[captureIndex]] + (1)
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return -2332653
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -2332653
                    end
                })
            end
        end
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, ReturnVal, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46
            while state do
                if state <= 117 then
                    if state <= 58 then
                        if state <= 36 then
                            if state <= 34 then
                                if state <= 33 then
                                    -- root entry 11514984 -> 1, states 1-33
                                    if state <= 17 then
                                        if state <= 9 then
                                            if state <= 5 then
                                                if state <= 3 then
                                                    if state <= 2 then
                                                        if state <= 1 then
                                                            if state == 1 then -- entry 11514984 -> 1
                                                                r3 = allocUpvalue()
                                                                state = true
                                                                upvalueValues[r3] = state
                                                                r12 = allocUpvalue()
                                                                r20 = "string"
                                                                ReturnVal = _env[r20]
                                                                r20 = "gmatch"
                                                                state = ReturnVal[r20]
                                                                r20 = allocUpvalue()
                                                                upvalueValues[r20] = state
                                                                r39 = allocUpvalue()
                                                                state = createClosure1(34, {})
                                                                upvalueValues[r12] = state
                                                                state = false
                                                                upvalueValues[r39] = state
                                                                r17 = createClosure1(35, {
                                                                    r39
                                                                })
                                                                r9 = "pcall"
                                                                r25 = _env[r9]
                                                                r9 = r25(r17)
                                                                state = r9 and (2) or (3)
                                                                r15 = args
                                                                ReturnVal = r9
                                                            end
                                                        else
                                                            if state == 2 then
                                                                r25 = upvalueValues[r39]
                                                                ReturnVal = r25
                                                                state = 3
                                                            end
                                                        end
                                                    else
                                                        if state == 3 then
                                                            r25 = ReturnVal
                                                            r9 = "math"
                                                            ReturnVal = _env[r9]
                                                            r9 = "random"
                                                            state = ReturnVal[r9]
                                                            r9 = allocUpvalue()
                                                            upvalueValues[r9] = state
                                                            r17 = "table"
                                                            ReturnVal = _env[r17]
                                                            r17 = "concat"
                                                            state = ReturnVal[r17]
                                                            r17 = state
                                                            r2 = state
                                                            r37 = "table"
                                                            r43 = _env[r37]
                                                            state = r43 and (4) or (5)
                                                            r28 = r43
                                                        end
                                                    end
                                                else
                                                    if state <= 4 then
                                                        if state == 4 then
                                                            r1 = "table"
                                                            r37 = _env[r1]
                                                            r1 = "unpack"
                                                            r43 = r37[r1]
                                                            r28 = r43
                                                            state = 5
                                                        end
                                                    else
                                                        if state == 5 then
                                                            state = r2
                                                            state = r28 and (6) or (7)
                                                            ReturnVal = r28
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 7 then
                                                    if state <= 6 then
                                                        if state == 6 then
                                                            r28 = allocUpvalue()
                                                            upvalueValues[r28] = ReturnVal
                                                            state = upvalueValues[r9]
                                                            r5 = createClosure4(36, {})
                                                            r2 = 3
                                                            r43 = 65
                                                            ReturnVal = state(r2, r43)
                                                            r2 = allocUpvalue()
                                                            upvalueValues[r2] = ReturnVal
                                                            r1 = "pcall"
                                                            ReturnVal = _env[r1]
                                                            state = 0
                                                            r1 = {
                                                                ReturnVal(r5)
                                                            }
                                                            r43 = state
                                                            state = 0
                                                            r37 = state
                                                            state = {
                                                                unpack(r1)
                                                            }
                                                            r1 = state
                                                            ReturnVal = 2
                                                            state = r1[ReturnVal]
                                                            r5 = state
                                                            ReturnVal = "tonumber"
                                                            state = _env[ReturnVal]
                                                            r40 = upvalueValues[r20]
                                                            r26 = "tostring"
                                                            r22 = _env[r26]
                                                            r26 = r22(r5)
                                                            r22 = ":(%d*):"
                                                            r16 = r40(r26, r22)
                                                            r40 = {
                                                                r16()
                                                            }
                                                            ReturnVal = state(unpack(r40))
                                                            r40 = allocUpvalue()
                                                            upvalueValues[r40] = ReturnVal
                                                            r16 = upvalueValues[r2]
                                                            r22 = r16
                                                            r16 = 1
                                                            r26 = r16
                                                            r16 = 0
                                                            r19 = r26 < r16
                                                            ReturnVal = 1
                                                            r16 = ReturnVal - r26
                                                            state = 8
                                                        end
                                                    else
                                                        if state == 7 then
                                                            r2 = "unpack"
                                                            r28 = _env[r2]
                                                            ReturnVal = r28
                                                            state = 6
                                                        end
                                                    end
                                                else
                                                    if state <= 8 then
                                                        if state == 8 then
                                                            r42 = not r19
                                                            r16 = r16 + r26
                                                            ReturnVal = r16 <= r22
                                                            ReturnVal = r42 and ReturnVal
                                                            r42 = r16 >= r22
                                                            r42 = r19 and r42
                                                            ReturnVal = r42 or ReturnVal
                                                            r42 = (9)
                                                            state = ReturnVal and r42
                                                            ReturnVal = (10)
                                                            state = state or ReturnVal
                                                        end
                                                    else
                                                        if state == 9 then
                                                            r42 = allocUpvalue()
                                                            upvalueValues[r42] = r16
                                                            r32 = "math"
                                                            ReturnVal = _env[r32]
                                                            r32 = "random"
                                                            state = ReturnVal[r32]
                                                            r27 = 100
                                                            r32 = 1
                                                            ReturnVal = state(r32, r27)
                                                            r32 = allocUpvalue()
                                                            upvalueValues[r32] = ReturnVal
                                                            state = upvalueValues[r9]
                                                            r11 = 255
                                                            r27 = 0
                                                            ReturnVal = state(r27, r11)
                                                            r27 = allocUpvalue()
                                                            upvalueValues[r27] = ReturnVal
                                                            state = upvalueValues[r9]
                                                            r34 = upvalueValues[r32]
                                                            r11 = 1
                                                            ReturnVal = state(r11, r34)
                                                            r11 = allocUpvalue()
                                                            upvalueValues[r11] = ReturnVal
                                                            ReturnVal = upvalueValues[r9]
                                                            r23 = 1
                                                            r7 = 2
                                                            r34 = ReturnVal(r23, r7)
                                                            ReturnVal = 1
                                                            state = r34 == ReturnVal
                                                            r34 = allocUpvalue()
                                                            upvalueValues[r34] = state
                                                            r44 = "tostring"
                                                            r33 = _env[r44]
                                                            r13 = upvalueValues[r9]
                                                            r4 = 10000
                                                            r41 = 0
                                                            r24 = {
                                                                r13(r41, r4)
                                                            }
                                                            r44 = r33(unpack(r24))
                                                            r33 = ":"
                                                            r45 = r44 .. r33
                                                            state = "gsub"
                                                            state = r5[state]
                                                            r7 = ":"
                                                            r23 = r7 .. r45
                                                            ReturnVal = ":(%d*):"
                                                            state = state(r5, ReturnVal, r23)
                                                            r23 = allocUpvalue()
                                                            r45 = createClosure3(37, {
                                                                r9,
                                                                r42,
                                                                r2,
                                                                r20,
                                                                r3,
                                                                r40,
                                                                r34,
                                                                r23,
                                                                r32,
                                                                r11,
                                                                r27,
                                                                r28
                                                            })
                                                            upvalueValues[r23] = state
                                                            r7 = "pcall"
                                                            ReturnVal = _env[r7]
                                                            r7 = {
                                                                ReturnVal(r45)
                                                            }
                                                            state = {
                                                                unpack(r7)
                                                            }
                                                            r7 = state
                                                            state = upvalueValues[r34]
                                                            state = state and (11) or (12)
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 13 then
                                                if state <= 11 then
                                                    if state <= 10 then
                                                        if state == 10 then
                                                            r22 = upvalueValues[r3]
                                                            state = r22 and (13) or (14)
                                                            r16 = r22
                                                        end
                                                    else
                                                        if state == 11 then
                                                            r45 = upvalueValues[r3]
                                                            state = r45 and (15) or (16)
                                                            ReturnVal = r45
                                                        end
                                                    end
                                                else
                                                    if state <= 12 then
                                                        if state == 12 then
                                                            r33 = upvalueValues[r3]
                                                            state = r33 and (17) or (18)
                                                            r45 = r33
                                                        end
                                                    else
                                                        if state == 13 then
                                                            r22 = r43 == r37
                                                            r16 = r22
                                                            state = 14
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 15 then
                                                    if state <= 14 then
                                                        if state == 14 then
                                                            upvalueValues[r3] = r16
                                                            state = upvalueValues[r3]
                                                            state = state and (19) or (20)
                                                        end
                                                    else
                                                        if state == 15 then
                                                            r24 = 1
                                                            r13 = r7[r24]
                                                            r24 = false
                                                            r44 = r13 == r24
                                                            r33 = state
                                                            state = r44 and (21) or (22)
                                                            r45 = r44
                                                        end
                                                    end
                                                else
                                                    if state <= 16 then
                                                        if state == 16 then
                                                            upvalueValues[r3] = ReturnVal
                                                            state = 23
                                                        end
                                                    else
                                                        if state == 17 then
                                                            r44 = 1
                                                            r33 = r7[r44]
                                                            r45 = r33
                                                            state = 18
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
                                                            upvalueValues[r3] = r45
                                                            r24 = upvalueValues[r11]
                                                            r41 = 1
                                                            r13 = r24 + r41
                                                            r44 = r7[r13]
                                                            r33 = r43 + r44
                                                            r44 = 256
                                                            state = r33 % r44
                                                            r43 = state
                                                            r13 = upvalueValues[r27]
                                                            r44 = r37 + r13
                                                            r13 = 256
                                                            r33 = r44 % r13
                                                            r37 = r33
                                                            state = 23
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
                                                            r24 = 2
                                                            r13 = r7[r24]
                                                            r24 = upvalueValues[r23]
                                                            r44 = r13 == r24
                                                            r45 = r44
                                                            state = 22
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 23 then
                                                    if state <= 22 then
                                                        if state == 22 then
                                                            state = r33
                                                            ReturnVal = r45
                                                            state = 16
                                                        end
                                                    else
                                                        if state == 23 then
                                                            r32 = releaseUpvalue(r32)
                                                            r34 = releaseUpvalue(r34)
                                                            r23 = releaseUpvalue(r23)
                                                            r42 = releaseUpvalue(r42)
                                                            r27 = releaseUpvalue(r27)
                                                            r7 = nil
                                                            r11 = releaseUpvalue(r11)
                                                            state = 8
                                                        end
                                                    end
                                                else
                                                    if state <= 24 then
                                                        if state == 24 then
                                                            r28 = releaseUpvalue(r28)
                                                            r40 = releaseUpvalue(r40)
                                                            r39 = releaseUpvalue(r39)
                                                            r20 = releaseUpvalue(r20)
                                                            r2 = releaseUpvalue(r2)
                                                            r43 = nil
                                                            r43 = {}
                                                            r9 = releaseUpvalue(r9)
                                                            r12 = releaseUpvalue(r12)
                                                            r3 = releaseUpvalue(r3)
                                                            r12 = allocUpvalue()
                                                            r3 = nil
                                                            upvalueValues[r12] = r3
                                                            r3 = allocUpvalue()
                                                            r20 = nil
                                                            upvalueValues[r3] = r20
                                                            r25 = nil
                                                            r25 = "math"
                                                            r39 = _env[r25]
                                                            r25 = "floor"
                                                            r20 = r39[r25]
                                                            r39 = allocUpvalue()
                                                            upvalueValues[r39] = r20
                                                            r9 = "math"
                                                            r25 = _env[r9]
                                                            r2 = allocUpvalue()
                                                            r9 = "random"
                                                            r20 = r25[r9]
                                                            r17 = nil
                                                            r17 = "table"
                                                            r9 = _env[r17]
                                                            r17 = "remove"
                                                            r25 = r9[r17]
                                                            r28 = "string"
                                                            r17 = _env[r28]
                                                            r28 = "char"
                                                            r9 = r17[r28]
                                                            r28 = allocUpvalue()
                                                            r17 = 0
                                                            upvalueValues[r28] = r17
                                                            r40 = 256
                                                            r17 = 2
                                                            upvalueValues[r2] = r17
                                                            r17 = {}
                                                            r1 = nil
                                                            r1 = {}
                                                            r37 = nil
                                                            r37 = allocUpvalue()
                                                            upvalueValues[r37] = r43
                                                            r19 = r40
                                                            r40 = 1
                                                            r42 = r40
                                                            r40 = 0
                                                            r32 = r42 < r40
                                                            r5 = nil
                                                            r5 = 1
                                                            r40 = r5 - r42
                                                            r43 = 0
                                                            state = 26
                                                        end
                                                    else
                                                        if state == 25 then
                                                            state = createClosure5(49, {
                                                                r12
                                                            })
                                                            r22 = {
                                                                state()
                                                            }
                                                            ReturnVal = {
                                                                unpack(r22)
                                                            }
                                                            state = nil
                                                        end
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 29 then
                                                if state <= 27 then
                                                    if state <= 26 then
                                                        if state == 26 then
                                                            r27 = not r32
                                                            r40 = r40 + r42
                                                            r5 = r40 <= r19
                                                            r5 = r27 and r5
                                                            r27 = r40 >= r19
                                                            r27 = r32 and r27
                                                            r5 = r27 or r5
                                                            r27 = (27)
                                                            state = r5 and r27
                                                            r5 = (28)
                                                            state = state or r5
                                                        end
                                                    else
                                                        if state == 27 then
                                                            r5 = r40
                                                            r27 = r5
                                                            r1[r5] = r27
                                                            r5 = nil
                                                            state = 26
                                                        end
                                                    end
                                                else
                                                    if state <= 28 then
                                                        if state == 28 then
                                                            r40 = #r1
                                                            r19 = 0
                                                            r5 = r40 == r19
                                                            state = 29
                                                        end
                                                    else
                                                        if state == 29 then
                                                            r40 = 1
                                                            r19 = #r1
                                                            r5 = r20(r40, r19)
                                                            r40 = r25(r1, r5)
                                                            r19 = upvalueValues[r37]
                                                            r27 = 1
                                                            r32 = r40 - r27
                                                            r5 = nil
                                                            r42 = r9(r32)
                                                            r19[r40] = r42
                                                            r40 = nil
                                                            state = 30
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 31 then
                                                    if state <= 30 then
                                                        if state == 30 then
                                                            r40 = #r1
                                                            r19 = 0
                                                            r5 = r40 == r19
                                                            state = r5 and (31) or (29)
                                                        end
                                                    else
                                                        if state == 31 then
                                                            r40 = allocUpvalue()
                                                            r42 = allocUpvalue()
                                                            r19 = createClosure4(53, {
                                                                r40,
                                                                r28,
                                                                r2,
                                                                r39
                                                            })
                                                            r5 = {}
                                                            upvalueValues[r40] = r5
                                                            r27 = {}
                                                            r5 = allocUpvalue()
                                                            upvalueValues[r5] = r19
                                                            r19 = {}
                                                            upvalueValues[r42] = r19
                                                            r32 = "setmetatable"
                                                            r19 = _env[r32]
                                                            r39 = releaseUpvalue(r39)
                                                            r23 = upvalueValues[r42]
                                                            r44 = nil
                                                            r34 = "__index"
                                                            r7 = "__metatable"
                                                            r11 = {
                                                                [r34] = r23,
                                                                [r7] = r44
                                                            }
                                                            r32 = r19(r27, r11)
                                                            r19 = createClosure7(59, {
                                                                r42,
                                                                r40,
                                                                r37,
                                                                r28,
                                                                r2,
                                                                r5
                                                            })
                                                            r5 = releaseUpvalue(r5)
                                                            r2 = releaseUpvalue(r2)
                                                            r28 = releaseUpvalue(r28)
                                                            r42 = releaseUpvalue(r42)
                                                            r40 = releaseUpvalue(r40)
                                                            upvalueValues[r12] = r32
                                                            r37 = releaseUpvalue(r37)
                                                            upvalueValues[r3] = r19
                                                            r39 = "loadstring"
                                                            r20 = nil
                                                            r20 = _env[r39]
                                                            r9 = nil
                                                            r9 = "game"
                                                            r25 = nil
                                                            r25 = _env[r9]
                                                            r28 = upvalueValues[r12]
                                                            r2 = upvalueValues[r3]
                                                            r37 = "Q\132\189\027\137'WSZ\\ \217\135\012\166\162\213U)0\164a\153\011\155/\165\129\2199'\247\134\181I\0074\131<\191z=\173\179\165O\253\211\147\249\024\197y\191\011\017\233\227\0119Ea\000z\189\145J\023\242q\159\228vM\014\0209c|WQ\019\026\139"
                                                            r1 = nil
                                                            r1 = 2216619295752
                                                            r43 = nil
                                                            r43 = r2(r37, r1)
                                                            r17 = nil
                                                            r17 = r28[r43]
                                                            r28 = "HttpGet"
                                                            r28 = r25[r28]
                                                            r9 = {
                                                                r28(r25, r17)
                                                            }
                                                            r39 = r20(unpack(r9))
                                                            r20 = r39()
                                                            r39 = allocUpvalue()
                                                            upvalueValues[r39] = r20
                                                            r20 = upvalueValues[r39]
                                                            r9 = upvalueValues[r39]
                                                            r28 = upvalueValues[r12]
                                                            r2 = upvalueValues[r3]
                                                            r1 = 5163439655268
                                                            r37 = "\028\014#\007A\186\201\208l\004\150&"
                                                            r43 = r2(r37, r1)
                                                            r17 = r28[r43]
                                                            r25 = r9[r17]
                                                            r2 = upvalueValues[r12]
                                                            r43 = upvalueValues[r3]
                                                            r1 = "+\227\2557\218"
                                                            r5 = 10875450790856
                                                            r37 = r43(r1, r5)
                                                            r28 = r2[r37]
                                                            r43 = upvalueValues[r12]
                                                            r37 = upvalueValues[r3]
                                                            r40 = 894858690976
                                                            r5 = "P<\233\252^ep\147\165R\162!qu\176\162a "
                                                            r1 = r37(r5, r40)
                                                            r2 = r43[r1]
                                                            r37 = upvalueValues[r12]
                                                            r1 = upvalueValues[r3]
                                                            r19 = 27430990524901
                                                            r40 = "\142t\173\007\250r"
                                                            r5 = r1(r40, r19)
                                                            r43 = r37[r5]
                                                            r1 = upvalueValues[r12]
                                                            r5 = upvalueValues[r3]
                                                            r42 = 20796847891924
                                                            r19 = "\166%F\001\140E"
                                                            r40 = r5(r19, r42)
                                                            r37 = r1[r40]
                                                            r5 = upvalueValues[r12]
                                                            r40 = upvalueValues[r3]
                                                            r27 = 25581035040392
                                                            r42 = "\199-\005\1510\224\140L\216\206\249\152\235"
                                                            r19 = r40(r42, r27)
                                                            r1 = r5[r19]
                                                            r42 = "Enum"
                                                            r19 = _env[r42]
                                                            r27 = upvalueValues[r12]
                                                            r11 = upvalueValues[r3]
                                                            r7 = 32624951376728
                                                            r23 = "\1762K\151}\138\182"
                                                            r34 = r11(r23, r7)
                                                            r42 = r27[r34]
                                                            r40 = r19[r42]
                                                            r42 = upvalueValues[r12]
                                                            r27 = upvalueValues[r3]
                                                            r23 = 23843441748830
                                                            r34 = "#\233\233\158b\199\145\244D6\017\012"
                                                            r11 = r27(r34, r23)
                                                            r19 = r42[r11]
                                                            r5 = r40[r19]
                                                            r19 = upvalueValues[r12]
                                                            r42 = upvalueValues[r3]
                                                            r11 = "\236^\137\019\164f"
                                                            r34 = 27939030315730
                                                            r27 = r42(r11, r34)
                                                            r40 = r19[r27]
                                                            r27 = upvalueValues[r12]
                                                            r11 = upvalueValues[r3]
                                                            r7 = 18819809026619
                                                            r23 = "\223\205\223k2\233.\139"
                                                            r34 = r11(r23, r7)
                                                            r42 = r27[r34]
                                                            r34 = upvalueValues[r12]
                                                            r23 = upvalueValues[r3]
                                                            r13 = 31676886759838
                                                            r44 = "N\016\253}\011\246s\192]"
                                                            r7 = r23(r44, r13)
                                                            r11 = r34[r7]
                                                            r7 = upvalueValues[r12]
                                                            r44 = upvalueValues[r3]
                                                            r41 = 6984492305588
                                                            r24 = "\153>\142\148"
                                                            r13 = r44(r24, r41)
                                                            r23 = r7[r13]
                                                            r13 = "UDim2"
                                                            r44 = _env[r13]
                                                            r24 = upvalueValues[r12]
                                                            r41 = upvalueValues[r3]
                                                            r31 = 24559104617644
                                                            r35 = "\170\159\250\236<\232n\249+\222"
                                                            r4 = r41(r35, r31)
                                                            r13 = r24[r4]
                                                            r7 = r44[r13]
                                                            r24 = 500
                                                            r13 = 700
                                                            r44 = r7(r13, r24)
                                                            r19 = true
                                                            r27 = true
                                                            r34 = false
                                                            r17 = {
                                                                [r28] = r2,
                                                                [r43] = r37,
                                                                [r1] = r5,
                                                                [r40] = r19,
                                                                [r42] = r27,
                                                                [r11] = r34,
                                                                [r23] = r44
                                                            }
                                                            r9 = r25(r20, r17)
                                                            r17 = "game"
                                                            r25 = _env[r17]
                                                            r2 = upvalueValues[r12]
                                                            r43 = upvalueValues[r3]
                                                            r5 = 11411468866753
                                                            r1 = "\138D:\024\214\155\141\1533\225\216"
                                                            r37 = r43(r1, r5)
                                                            r28 = r2[r37]
                                                            r17 = "GetService"
                                                            r17 = r25[r17]
                                                            r17 = r17(r25, r28)
                                                            r25 = allocUpvalue()
                                                            upvalueValues[r25] = r17
                                                            r28 = upvalueValues[r12]
                                                            r2 = upvalueValues[r3]
                                                            r1 = 18946987500150
                                                            r37 = "\165\142\\\208\005Th\149\191w\207\011\149\228x\251\218Z\236\180\132\228\031\250\141`\167\244\180\216\207\173\028"
                                                            r43 = r2(r37, r1)
                                                            r17 = r28[r43]
                                                            r28 = allocUpvalue()
                                                            upvalueValues[r28] = r17
                                                            r2 = upvalueValues[r12]
                                                            r43 = upvalueValues[r3]
                                                            r5 = 33848279285137
                                                            r1 = "\167S\006{^\181\\\026z\233\185!\157\016'F:\238\237 \232\0040\167\233\194\000\180\217"
                                                            r37 = r43(r1, r5)
                                                            r17 = r2[r37]
                                                            r2 = allocUpvalue()
                                                            upvalueValues[r2] = r17
                                                            r43 = upvalueValues[r12]
                                                            r37 = upvalueValues[r3]
                                                            r40 = 33855629852053
                                                            r5 = "\031X}\248W\198\\\195\190\003\133g\027\230\251\225z~P\028\205/]\209\018\159\197\136\2368\231\220\026"
                                                            r1 = r37(r5, r40)
                                                            r17 = r43[r1]
                                                            r43 = allocUpvalue()
                                                            upvalueValues[r43] = r17
                                                            r37 = upvalueValues[r12]
                                                            r1 = upvalueValues[r3]
                                                            r19 = 18841219162693
                                                            r40 = "\212\027\196\201\145\194"
                                                            r5 = r1(r40, r19)
                                                            r17 = r37[r5]
                                                            r37 = allocUpvalue()
                                                            upvalueValues[r37] = r17
                                                            r1 = upvalueValues[r12]
                                                            r5 = upvalueValues[r3]
                                                            r42 = 30910578882617
                                                            r19 = "N\146y\180\143g\174h\239\007\249\152\148\211\159\127\142k\228a\159$o3\222MVh\224P\166\170\159\128/\t\015\149\139"
                                                            r40 = r5(r19, r42)
                                                            r17 = r1[r40]
                                                            r1 = allocUpvalue()
                                                            r40 = createClosure5(66, {})
                                                            upvalueValues[r1] = r17
                                                            r17 = allocUpvalue()
                                                            r5 = createClosure5(69, {
                                                                r12,
                                                                r3
                                                            })
                                                            upvalueValues[r17] = r5
                                                            r5 = allocUpvalue()
                                                            upvalueValues[r5] = r40
                                                            r19 = createClosure1(94, {
                                                                r12,
                                                                r3,
                                                                r17,
                                                                r1,
                                                                r25
                                                            })
                                                            r40 = allocUpvalue()
                                                            upvalueValues[r40] = r19
                                                            r27 = upvalueValues[r12]
                                                            r11 = upvalueValues[r3]
                                                            r23 = " \230\228UQ\248\157^\145\170"
                                                            r7 = 30579947911071
                                                            r34 = r11(r23, r7)
                                                            r42 = r27[r34]
                                                            r19 = "AddKeyTab"
                                                            r19 = r9[r19]
                                                            r19 = r19(r9, r42)
                                                            r11 = upvalueValues[r12]
                                                            r42 = "AddTab"
                                                            r42 = r9[r42]
                                                            r34 = upvalueValues[r3]
                                                            r44 = 7258699615540
                                                            r7 = "oGv\254"
                                                            r23 = r34(r7, r44)
                                                            r27 = r11[r23]
                                                            r34 = upvalueValues[r12]
                                                            r23 = upvalueValues[r3]
                                                            r13 = 34429578133152
                                                            r44 = "Y\159\235\146"
                                                            r7 = r23(r44, r13)
                                                            r11 = r34[r7]
                                                            r42 = r42(r9, r27, r11)
                                                            r34 = upvalueValues[r12]
                                                            r23 = upvalueValues[r3]
                                                            r44 = "\139o"
                                                            r13 = 20976610846247
                                                            r7 = r23(r44, r13)
                                                            r11 = r34[r7]
                                                            r23 = upvalueValues[r12]
                                                            r7 = upvalueValues[r3]
                                                            r24 = 4699278887052
                                                            r13 = "\179\168\n\132\201\006\230\193"
                                                            r44 = r7(r13, r24)
                                                            r27 = "AddTab"
                                                            r27 = r9[r27]
                                                            r34 = r23[r44]
                                                            r27 = r27(r9, r11, r34)
                                                            r7 = upvalueValues[r12]
                                                            r44 = upvalueValues[r3]
                                                            r41 = 23088647793151
                                                            r24 = "\225\127!\004"
                                                            r13 = r44(r24, r41)
                                                            r23 = r7[r13]
                                                            r44 = upvalueValues[r12]
                                                            r13 = upvalueValues[r3]
                                                            r4 = 13731269073146
                                                            r41 = "\177\159o\185b\1396[\024\n\187\015\217}\005O\183K:\181\211"
                                                            r24 = r13(r41, r4)
                                                            r7 = r44[r24]
                                                            r13 = upvalueValues[r12]
                                                            r24 = upvalueValues[r3]
                                                            r35 = 23519087930055
                                                            r4 = "\219\250_\169eE\255\023"
                                                            r41 = r24(r4, r35)
                                                            r44 = r13[r41]
                                                            r41 = upvalueValues[r12]
                                                            r4 = upvalueValues[r3]
                                                            r6 = 19581162447774
                                                            r31 = "\244\024\1883"
                                                            r35 = r4(r31, r6)
                                                            r24 = r41[r35]
                                                            r11 = "AddLabel"
                                                            r11 = r19[r11]
                                                            r13 = true
                                                            r41 = 32
                                                            r34 = {
                                                                [r23] = r7,
                                                                [r44] = r13,
                                                                [r24] = r41
                                                            }
                                                            r11 = r11(r19, r34)
                                                            r44 = createClosure6(107, {})
                                                            r24 = upvalueValues[r37]
                                                            r11 = createClosure4(112, {
                                                                r12,
                                                                r3,
                                                                r39,
                                                                r40,
                                                                r5,
                                                                r37,
                                                                r17,
                                                                r28
                                                            })
                                                            r13 = r44(r24)
                                                            r7 = state
                                                            state = r13 and (32) or (33)
                                                            r23 = r13
                                                        end
                                                    end
                                                else
                                                    if state <= 32 then
                                                        if state == 32 then
                                                            state = r7
                                                            r34 = "AddKeyBox"
                                                            r34 = r19[r34]
                                                            r34 = r34(r19, r23, r11)
                                                            r44 = upvalueValues[r12]
                                                            r13 = upvalueValues[r3]
                                                            r5 = releaseUpvalue(r5)
                                                            r41 = "-\246\150\214"
                                                            r4 = 29255155954998
                                                            r24 = r13(r41, r4)
                                                            r34 = "AddLabel"
                                                            r7 = r44[r24]
                                                            r13 = upvalueValues[r12]
                                                            r1 = releaseUpvalue(r1)
                                                            r24 = upvalueValues[r3]
                                                            r35 = 11037252801555
                                                            r4 = "N\221(h\134\234\195\248*m1\23075\238\244z\018\158Ige9\244\181)kf \0317Z\130\186\199U\141\018\028\242\146\223F\230\228c\199\255P\002\164Bg\191]BQ\213\185&\173\247\2102d\147 \251v|-O/\255RP\241\024"
                                                            r41 = r24(r4, r35)
                                                            r44 = r13[r41]
                                                            r24 = upvalueValues[r12]
                                                            r41 = upvalueValues[r3]
                                                            r31 = 1572972888796
                                                            r35 = "\155\018\193s\031\018~z"
                                                            r4 = r41(r35, r31)
                                                            r13 = r24[r4]
                                                            r34 = r19[r34]
                                                            r4 = upvalueValues[r12]
                                                            r35 = upvalueValues[r3]
                                                            r6 = "\244C\174\226"
                                                            r29 = 4804573497533
                                                            r31 = r35(r6, r29)
                                                            r41 = r4[r31]
                                                            r28 = releaseUpvalue(r28)
                                                            r24 = true
                                                            r4 = 16
                                                            r23 = {
                                                                [r7] = r44,
                                                                [r13] = r24,
                                                                [r41] = r4
                                                            }
                                                            r34 = r34(r19, r23)
                                                            r46 = 31914733484557
                                                            r38 = 18999356498575
                                                            r7 = upvalueValues[r12]
                                                            r44 = upvalueValues[r3]
                                                            r34 = "AddLeftGroupbox"
                                                            r24 = "\127JX\022%a\210Byd\163\163v\250"
                                                            r41 = 3588978411143
                                                            r13 = r44(r24, r41)
                                                            r23 = r7[r13]
                                                            r44 = upvalueValues[r12]
                                                            r34 = r42[r34]
                                                            r13 = upvalueValues[r3]
                                                            r4 = 12101319792131
                                                            r41 = "\152\133\186"
                                                            r24 = r13(r41, r4)
                                                            r7 = r44[r24]
                                                            r34 = r34(r42, r23, r7)
                                                            r13 = upvalueValues[r12]
                                                            r24 = upvalueValues[r3]
                                                            r35 = 8991309172826
                                                            r4 = "P\175\020\208"
                                                            r41 = r24(r4, r35)
                                                            r44 = r13[r41]
                                                            r24 = upvalueValues[r12]
                                                            r41 = upvalueValues[r3]
                                                            r23 = "AddLabel"
                                                            r23 = r34[r23]
                                                            r31 = 24435519581298
                                                            r35 = "\187\006\227\223\179\\R+w\025\246\165[`\150\"\177\235T\254\030v\137\228\131!\0207\007\153\197;\027\241iD\141\243`\162\237\137\245\014\230\157yI\229\179i\023\2090\168_\132Z\160P\156\186\254I\128\175\128\193\229\\\153=\2051u\235r\214\202\015\254\022u\021\166\160P\227\155\252\157\244_*\191_,\181\008*\165\023\2050\176\023\133\236Q\156\176\018\237\221\198\144\015\213\243\011'\011\250\0071\220H\209\179\225\1535?Y\137O\240,\022 \023\203\221\236\000\175\192\1449\254\239J\144Q\005\196Y\011l\2499\189\176Q\178 \135\007$3\160_\019WX\245\228\168\222\136\005ykGw{\240\025\177X\134\019$b\141\186R\012\179\175\193\160GoA\189.\194\030~\214\215"
                                                            r4 = r41(r35, r31)
                                                            r13 = r24[r4]
                                                            r41 = upvalueValues[r12]
                                                            r4 = upvalueValues[r3]
                                                            r6 = 4385417594874
                                                            r31 = "\234;\027\220\244Y\244\002"
                                                            r35 = r4(r31, r6)
                                                            r24 = r41[r35]
                                                            r41 = true
                                                            r7 = {
                                                                [r44] = r13,
                                                                [r24] = r41
                                                            }
                                                            r23 = r23(r34, r7)
                                                            r30 = "\019\150\218\175(\235O\241"
                                                            r18 = 30695836628949
                                                            r13 = upvalueValues[r12]
                                                            r24 = upvalueValues[r3]
                                                            r35 = 18839950713413
                                                            r4 = "\241\232a("
                                                            r41 = r24(r4, r35)
                                                            r44 = r13[r41]
                                                            r24 = upvalueValues[r12]
                                                            r41 = upvalueValues[r3]
                                                            r31 = 27192799015286
                                                            r35 = "\214\128=gCn\186B\000\163\016\254\134\012\028\177\228-\236D<#\170$8\174\138O\000\183:\142*3x\000dM\140\241h\0271y\235\161v%\213\131\210\205I1"
                                                            r4 = r41(r35, r31)
                                                            r13 = r24[r4]
                                                            r41 = upvalueValues[r12]
                                                            r4 = upvalueValues[r3]
                                                            r31 = "\012\221\007\163"
                                                            r6 = 34070506814969
                                                            r35 = r4(r31, r6)
                                                            r24 = r41[r35]
                                                            r20 = nil
                                                            r23 = "AddButton"
                                                            r41 = createClosure5(118, {
                                                                r43,
                                                                r39,
                                                                r12,
                                                                r3
                                                            })
                                                            r7 = {
                                                                [r44] = r13,
                                                                [r24] = r41
                                                            }
                                                            r23 = r34[r23]
                                                            r23 = r23(r34, r7)
                                                            r31 = 5926359403207
                                                            r44 = upvalueValues[r12]
                                                            r13 = upvalueValues[r3]
                                                            r4 = 5641157151298
                                                            r41 = "<\194\245\174"
                                                            r24 = r13(r41, r4)
                                                            r40 = releaseUpvalue(r40)
                                                            r7 = r44[r24]
                                                            r29 = 15258321361857
                                                            r8 = 32268809517746
                                                            r36 = 23411902212758
                                                            r13 = upvalueValues[r12]
                                                            r35 = 29466082620825
                                                            r4 = "X\1999]"
                                                            r34 = nil
                                                            r24 = upvalueValues[r3]
                                                            r23 = "AddRightGroupbox"
                                                            r23 = r42[r23]
                                                            r41 = r24(r4, r35)
                                                            r44 = r13[r41]
                                                            r23 = r23(r42, r7, r44)
                                                            r6 = 4886363195619
                                                            r42 = nil
                                                            r24 = upvalueValues[r12]
                                                            r41 = upvalueValues[r3]
                                                            r35 = "\198\nhc"
                                                            r4 = r41(r35, r31)
                                                            r13 = r24[r4]
                                                            r41 = upvalueValues[r12]
                                                            r4 = upvalueValues[r3]
                                                            r31 = "d}\243Q\198\128|c\026\2441\1481L\237T\249\143ov,+=\254\213\179zu\168'\235\130\150\176\176\131\027\158?\199\164_\230/\021\216\185#\163\215\235\221\184\025\146\244\165\239 \185rh"
                                                            r35 = r4(r31, r6)
                                                            r24 = r41[r35]
                                                            r4 = upvalueValues[r12]
                                                            r35 = upvalueValues[r3]
                                                            r37 = releaseUpvalue(r37)
                                                            ReturnVal = {}
                                                            r6 = "H\156:\254\144\1376*"
                                                            r31 = r35(r6, r29)
                                                            r41 = r4[r31]
                                                            r7 = "AddLabel"
                                                            r7 = r23[r7]
                                                            r43 = releaseUpvalue(r43)
                                                            r4 = true
                                                            r44 = {
                                                                [r13] = r24,
                                                                [r41] = r4
                                                            }
                                                            r7 = r7(r23, r44)
                                                            r10 = 7134580346106
                                                            r24 = upvalueValues[r12]
                                                            r41 = upvalueValues[r3]
                                                            r31 = 10625638306643
                                                            r35 = "\183\148\246\251"
                                                            r4 = r41(r35, r31)
                                                            r13 = r24[r4]
                                                            r41 = upvalueValues[r12]
                                                            r4 = upvalueValues[r3]
                                                            r6 = 27975010988770
                                                            r31 = "\131/\148\172zu\248\146\254|\149\214mwN\157V"
                                                            r35 = r4(r31, r6)
                                                            r24 = r41[r35]
                                                            r4 = upvalueValues[r12]
                                                            r7 = "AddButton"
                                                            r35 = upvalueValues[r3]
                                                            r29 = 28989590435003
                                                            r6 = "\156\252\241\166"
                                                            r31 = r35(r6, r29)
                                                            r41 = r4[r31]
                                                            r14 = 2659577513174
                                                            r19 = nil
                                                            r4 = createClosure3(121, {
                                                                r2,
                                                                r39,
                                                                r12,
                                                                r3
                                                            })
                                                            r44 = {
                                                                [r13] = r24,
                                                                [r41] = r4
                                                            }
                                                            r7 = r23[r7]
                                                            r7 = r7(r23, r44)
                                                            r13 = upvalueValues[r12]
                                                            r24 = upvalueValues[r3]
                                                            r35 = 12371801331329
                                                            r4 = "W\129\241\r"
                                                            r41 = r24(r4, r35)
                                                            r44 = r13[r41]
                                                            r24 = upvalueValues[r12]
                                                            r41 = upvalueValues[r3]
                                                            r7 = "AddLeftGroupbox"
                                                            r2 = releaseUpvalue(r2)
                                                            r7 = r27[r7]
                                                            r31 = 14520979724905
                                                            r35 = "\153\154\203\164\161\191\154\131"
                                                            r4 = r41(r35, r31)
                                                            r13 = r24[r4]
                                                            r7 = r7(r27, r44, r13)
                                                            r24 = upvalueValues[r12]
                                                            r41 = upvalueValues[r3]
                                                            r44 = "AddLabel"
                                                            r44 = r7[r44]
                                                            r25 = releaseUpvalue(r25)
                                                            r31 = 11854174573968
                                                            r35 = "\015\016\028\242\0028\191\182H"
                                                            r4 = r41(r35, r31)
                                                            r13 = r24[r4]
                                                            r44 = r44(r7, r13)
                                                            r21 = 18171833164045
                                                            r6 = 8180060540641
                                                            r29 = "\205\169\211vER\128"
                                                            r31 = "0z|7\227P%\223\187"
                                                            r11 = nil
                                                            r41 = upvalueValues[r12]
                                                            r4 = upvalueValues[r3]
                                                            r35 = r4(r31, r6)
                                                            r24 = r41[r35]
                                                            r35 = upvalueValues[r12]
                                                            r31 = upvalueValues[r3]
                                                            r6 = r31(r29, r38)
                                                            r4 = r35[r6]
                                                            r23 = nil
                                                            r31 = upvalueValues[r12]
                                                            r6 = upvalueValues[r3]
                                                            r38 = "u\157c"
                                                            r29 = r6(r38, r36)
                                                            r35 = r31[r29]
                                                            r6 = upvalueValues[r12]
                                                            r29 = upvalueValues[r3]
                                                            r36 = ",\191\n\176"
                                                            r38 = r29(r36, r14)
                                                            r17 = releaseUpvalue(r17)
                                                            r31 = r6[r38]
                                                            r29 = upvalueValues[r12]
                                                            r38 = upvalueValues[r3]
                                                            r14 = "#3\016\020\143\159&\1862"
                                                            r36 = r38(r14, r10)
                                                            r6 = r29[r36]
                                                            r38 = upvalueValues[r12]
                                                            r36 = upvalueValues[r3]
                                                            r10 = "\242J\210h"
                                                            r14 = r36(r10, r18)
                                                            r13 = "AddKeyPicker"
                                                            r13 = r44[r13]
                                                            r29 = r38[r14]
                                                            r36 = upvalueValues[r12]
                                                            r14 = upvalueValues[r3]
                                                            r18 = "\201\t\252\185\179\247"
                                                            r10 = r14(r18, r46)
                                                            r38 = r36[r10]
                                                            r14 = upvalueValues[r12]
                                                            r10 = upvalueValues[r3]
                                                            r46 = "\133\165\189\249N2%p\197z\198\020`i\217"
                                                            r18 = r10(r46, r21)
                                                            r36 = r14[r18]
                                                            r18 = upvalueValues[r12]
                                                            r46 = upvalueValues[r3]
                                                            r21 = r46(r30, r8)
                                                            r10 = r18[r21]
                                                            r18 = createClosure5(124, {
                                                                r39
                                                            })
                                                            r14 = false
                                                            r41 = {
                                                                [r4] = r35,
                                                                [r31] = r6,
                                                                [r29] = r38,
                                                                [r36] = r14,
                                                                [r10] = r18
                                                            }
                                                            r13 = r13(r44, r24, r41)
                                                            r41 = upvalueValues[r12]
                                                            r4 = upvalueValues[r3]
                                                            r6 = 1534934876874
                                                            r31 = "\144\"b'"
                                                            r35 = r4(r31, r6)
                                                            r29 = 21760811575189
                                                            r27 = nil
                                                            r24 = r41[r35]
                                                            r4 = upvalueValues[r12]
                                                            r35 = upvalueValues[r3]
                                                            r6 = "\r\157?$(\t\176\142F"
                                                            r31 = r35(r6, r29)
                                                            r44 = "AddButton"
                                                            r9 = nil
                                                            r41 = r4[r31]
                                                            r35 = upvalueValues[r12]
                                                            r31 = upvalueValues[r3]
                                                            r29 = "\001\129\145\149"
                                                            r38 = 9185757221045
                                                            r6 = r31(r29, r38)
                                                            r4 = r35[r6]
                                                            r3 = releaseUpvalue(r3)
                                                            r35 = createClosure1(125, {
                                                                r39
                                                            })
                                                            r44 = r7[r44]
                                                            r12 = releaseUpvalue(r12)
                                                            r13 = {
                                                                [r24] = r41,
                                                                [r4] = r35
                                                            }
                                                            r39 = releaseUpvalue(r39)
                                                            r44 = r44(r7, r13)
                                                            r7 = nil
                                                            state = nil
                                                        end
                                                    else
                                                        if state == 33 then
                                                            r13 = upvalueValues[r12]
                                                            r24 = upvalueValues[r3]
                                                            r4 = "\021\024{\195}+\234\027\245\222x\204"
                                                            r35 = 7283934416191
                                                            r41 = r24(r4, r35)
                                                            r44 = r13[r41]
                                                            r23 = r44
                                                            state = 32
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure1 entry 12912178 -> 34, states 34-34
                                    if state == 34 then -- entry 12912178 -> 34
                                        ReturnVal = "error"
                                        state = _env[ReturnVal]
                                        r15 = "Tamper Detected!"
                                        ReturnVal = state(r15)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            else
                                if state <= 35 then
                                    -- createClosure1 entry 2478234 -> 35, states 35-35
                                    if state == 35 then -- entry 2478234 -> 35
                                        state = true
                                        upvalueValues[upvalues[1]] = state
                                        ReturnVal = {}
                                        state = nil
                                    end
                                else
                                    -- createClosure4 entry 16027511 -> 36, states 36-36
                                    if state == 36 then -- entry 16027511 -> 36
                                        r20 = 6460146
                                        r3 = "MycBhs8"
                                        r15 = r3 ^ r20
                                        ReturnVal = 5250912
                                        state = ReturnVal - r15
                                        r15 = state
                                        ReturnVal = "jsWgU2PCng"
                                        state = ReturnVal / r15
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                end
                            end
                        else
                            if state <= 52 then
                                if state <= 48 then
                                    -- createClosure3 entry 15519229 -> 37, states 37-48
                                    if state <= 42 then
                                        if state <= 39 then
                                            if state <= 38 then
                                                if state <= 37 then
                                                    if state == 37 then -- entry 15519229 -> 37
                                                        r3 = upvalueValues[upvalues[1]]
                                                        r12 = 1
                                                        r39 = 2
                                                        r20 = r3(r12, r39)
                                                        r3 = 1
                                                        r15 = r20 == r3
                                                        state = r15 and (38) or (39)
                                                        ReturnVal = r15
                                                    end
                                                else
                                                    if state == 38 then
                                                        state = ReturnVal and (40) or (41)
                                                    end
                                                end
                                            else
                                                if state == 39 then
                                                    r3 = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r15 = r3 == r20
                                                    ReturnVal = r15
                                                    state = 38
                                                end
                                            end
                                        else
                                            if state <= 41 then
                                                if state <= 40 then
                                                    if state == 40 then
                                                        r28 = createClosure1(126, {})
                                                        ReturnVal = "tonumber"
                                                        state = _env[ReturnVal]
                                                        r15 = upvalueValues[upvalues[4]]
                                                        r12 = "tostring"
                                                        r20 = _env[r12]
                                                        r17 = "pcall"
                                                        r9 = _env[r17]
                                                        r17 = {
                                                            r9(r28)
                                                        }
                                                        r25 = {
                                                            unpack(r17)
                                                        }
                                                        r9 = 2
                                                        r39 = r25[r9]
                                                        r12 = r20(r39)
                                                        r20 = ":(%d*):"
                                                        r3 = r15(r12, r20)
                                                        r15 = {
                                                            r3()
                                                        }
                                                        ReturnVal = state(unpack(r15))
                                                        r15 = ReturnVal
                                                        r3 = upvalueValues[upvalues[5]]
                                                        state = r3 and (42) or (43)
                                                        ReturnVal = r3
                                                    end
                                                else
                                                    if state == 41 then
                                                        state = upvalueValues[upvalues[7]]
                                                        state = state and (44) or (45)
                                                    end
                                                end
                                            else
                                                if state == 42 then
                                                    r20 = upvalueValues[upvalues[6]]
                                                    r3 = r20 == r15
                                                    ReturnVal = r3
                                                    state = 43
                                                end
                                            end
                                        end
                                    else
                                        if state <= 45 then
                                            if state <= 44 then
                                                if state <= 43 then
                                                    if state == 43 then
                                                        r15 = nil
                                                        upvalueValues[upvalues[5]] = ReturnVal
                                                        state = 41
                                                    end
                                                else
                                                    if state == 44 then
                                                        r15 = "error"
                                                        state = _env[r15]
                                                        r3 = upvalueValues[upvalues[8]]
                                                        r20 = 0
                                                        r15 = state(r3, r20)
                                                        state = 45
                                                    end
                                                end
                                            else
                                                if state == 45 then
                                                    state = {}
                                                    r15 = state
                                                    r20 = upvalueValues[upvalues[9]]
                                                    r12 = r20
                                                    r20 = 1
                                                    r39 = r20
                                                    r20 = 0
                                                    r25 = r39 < r20
                                                    r3 = 1
                                                    r20 = r3 - r39
                                                    state = 46
                                                end
                                            end
                                        else
                                            if state <= 47 then
                                                if state <= 46 then
                                                    if state == 46 then
                                                        r9 = not r25
                                                        r20 = r20 + r39
                                                        r3 = r20 <= r12
                                                        r3 = r9 and r3
                                                        r9 = r20 >= r12
                                                        r9 = r25 and r9
                                                        r3 = r9 or r3
                                                        r9 = (47)
                                                        state = r3 and r9
                                                        r3 = (48)
                                                        state = state or r3
                                                    end
                                                else
                                                    if state == 47 then
                                                        state = upvalueValues[upvalues[1]]
                                                        r3 = r20
                                                        r17 = 0
                                                        r28 = 255
                                                        r9 = state(r17, r28)
                                                        r15[r3] = r9
                                                        r3 = nil
                                                        state = 46
                                                    end
                                                end
                                            else
                                                if state == 48 then
                                                    state = upvalueValues[upvalues[10]]
                                                    r3 = upvalueValues[upvalues[11]]
                                                    r15[state] = r3
                                                    state = upvalueValues[upvalues[12]]
                                                    r3 = {
                                                        state(r15)
                                                    }
                                                    ReturnVal = {
                                                        unpack(r3)
                                                    }
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure5 entry 6813505 -> 49, states 49-52
                                    if state <= 50 then
                                        if state <= 49 then
                                            if state == 49 then -- entry 6813505 -> 49
                                                state = 50
                                            end
                                        else
                                            if state == 50 then
                                                state = true
                                                state = state and (51) or (52)
                                            end
                                        end
                                    else
                                        if state <= 51 then
                                            if state == 51 then
                                                ReturnVal = "l2"
                                                state = _env[ReturnVal]
                                                r15 = "l1"
                                                ReturnVal = _env[r15]
                                                r15 = "l1"
                                                _env[r15] = state
                                                r15 = "l2"
                                                _env[r15] = ReturnVal
                                                r15 = upvalueValues[upvalues[1]]
                                                r3 = r15()
                                                state = 50
                                            end
                                        else
                                            if state == 52 then
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure4 entry 7247055 -> 53, states 53-58
                                if state <= 55 then
                                    if state <= 54 then
                                        if state <= 53 then
                                            if state == 53 then -- entry 7247055 -> 53
                                                r15 = upvalueValues[upvalues[1]]
                                                ReturnVal = #r15
                                                r15 = 0
                                                state = ReturnVal == r15
                                                state = state and (54) or (55)
                                            end
                                        else
                                            if state == 54 then
                                                r3 = upvalueValues[upvalues[2]]
                                                r20 = 205
                                                r15 = r3 * r20
                                                r3 = 5661905848909
                                                ReturnVal = r15 + r3
                                                r15 = 35184372088832
                                                state = ReturnVal % r15
                                                upvalueValues[upvalues[2]] = state
                                                r15 = upvalueValues[upvalues[3]]
                                                r3 = 1
                                                ReturnVal = r15 ~= r3
                                                state = 56
                                            end
                                        end
                                    else
                                        if state == 55 then
                                            r20 = "table"
                                            r3 = _env[r20]
                                            r20 = "remove"
                                            r15 = r3[r20]
                                            r20 = upvalueValues[upvalues[1]]
                                            r3 = {
                                                r15(r20)
                                            }
                                            ReturnVal = {
                                                unpack(r3)
                                            }
                                            state = nil
                                        end
                                    end
                                else
                                    if state <= 57 then
                                        if state <= 56 then
                                            if state == 56 then
                                                r3 = upvalueValues[upvalues[3]]
                                                r20 = 202
                                                r15 = r3 * r20
                                                r3 = 257
                                                ReturnVal = r15 % r3
                                                upvalueValues[upvalues[3]] = ReturnVal
                                                state = 57
                                            end
                                        else
                                            if state == 57 then
                                                r3 = upvalueValues[upvalues[3]]
                                                r20 = 1
                                                r15 = r3 ~= r20
                                                state = r15 and (58) or (56)
                                            end
                                        end
                                    else
                                        if state == 58 then
                                            r28 = 2
                                            r3 = upvalueValues[upvalues[3]]
                                            r20 = 32
                                            r15 = r3 % r20
                                            r12 = upvalueValues[upvalues[4]]
                                            r9 = upvalueValues[upvalues[2]]
                                            r5 = upvalueValues[upvalues[3]]
                                            r1 = r5 - r15
                                            r5 = 32
                                            r37 = r1 / r5
                                            r43 = 13
                                            r2 = r43 - r37
                                            r17 = r28 ^ r2
                                            r25 = r9 / r17
                                            r39 = r12(r25)
                                            r17 = 1
                                            r12 = 4294967296
                                            r20 = r39 % r12
                                            r39 = 2
                                            r12 = r39 ^ r15
                                            r3 = r20 / r12
                                            r12 = upvalueValues[upvalues[4]]
                                            r9 = r3 % r17
                                            r17 = 4294967296
                                            r25 = r9 * r17
                                            r39 = r12(r25)
                                            r9 = 65536
                                            r12 = upvalueValues[upvalues[4]]
                                            r25 = r12(r3)
                                            r20 = r39 + r25
                                            r28 = 256
                                            r39 = 65536
                                            r12 = r20 % r39
                                            r43 = 256
                                            r15 = nil
                                            r25 = r20 - r12
                                            r39 = r25 / r9
                                            r3 = nil
                                            r9 = 256
                                            r25 = r12 % r9
                                            r17 = r12 - r25
                                            r9 = r17 / r28
                                            r20 = nil
                                            r28 = 256
                                            r17 = r39 % r28
                                            r2 = r39 - r17
                                            r39 = nil
                                            r28 = r2 / r43
                                            r12 = nil
                                            r2 = {
                                                r25,
                                                r9,
                                                r17,
                                                r28
                                            }
                                            r25 = nil
                                            r17 = nil
                                            upvalueValues[upvalues[1]] = r2
                                            r9 = nil
                                            r28 = nil
                                            state = 55
                                        end
                                    end
                                end
                            end
                        end
                    else
                        if state <= 93 then
                            if state <= 68 then
                                if state <= 65 then
                                    -- createClosure7 entry 6462233 -> 59, states 59-65
                                    if state <= 62 then
                                        if state <= 60 then
                                            if state <= 59 then
                                                if state == 59 then -- entry 6462233 -> 59
                                                    state = upvalueValues[upvalues[1]]
                                                    r20 = state
                                                    r3 = args[2]
                                                    r15 = args[1]
                                                    state = r20[r3]
                                                    state = state and (60) or (61)
                                                end
                                            else
                                                if state == 60 then
                                                    state = 62
                                                end
                                            end
                                        else
                                            if state <= 61 then
                                                if state == 61 then
                                                    state = {}
                                                    upvalueValues[upvalues[2]] = state
                                                    ReturnVal = upvalueValues[upvalues[3]]
                                                    r12 = ReturnVal
                                                    r39 = 35184372088832
                                                    ReturnVal = r3 % r39
                                                    upvalueValues[upvalues[4]] = ReturnVal
                                                    r9 = 255
                                                    r25 = r3 % r9
                                                    r9 = 2
                                                    r39 = r25 + r9
                                                    upvalueValues[upvalues[5]] = r39
                                                    r17 = "string"
                                                    r9 = _env[r17]
                                                    r17 = "len"
                                                    r25 = r9[r17]
                                                    r9 = r25(r15)
                                                    r25 = ""
                                                    r20[r3] = r25
                                                    r2 = 1
                                                    r43 = r2
                                                    r2 = 0
                                                    r37 = r43 < r2
                                                    r17 = 1
                                                    r2 = r17 - r43
                                                    r28 = r9
                                                    r25 = 124
                                                    state = 63
                                                end
                                            else
                                                if state == 62 then
                                                    ReturnVal = {
                                                        r3
                                                    }
                                                    state = nil
                                                end
                                            end
                                        end
                                    else
                                        if state <= 64 then
                                            if state <= 63 then
                                                if state == 63 then
                                                    r2 = r2 + r43
                                                    r17 = r2 <= r28
                                                    r1 = not r37
                                                    r17 = r1 and r17
                                                    r1 = r2 >= r28
                                                    r1 = r37 and r1
                                                    r17 = r1 or r17
                                                    r1 = (64)
                                                    state = r17 and r1
                                                    r17 = (65)
                                                    state = state or r17
                                                end
                                            else
                                                if state == 64 then
                                                    r17 = r2
                                                    r26 = "string"
                                                    r22 = _env[r26]
                                                    r26 = "byte"
                                                    r16 = r22[r26]
                                                    r22 = r16(r15, r17)
                                                    r16 = upvalueValues[upvalues[6]]
                                                    r26 = r16()
                                                    r40 = r22 + r26
                                                    r5 = r40 + r25
                                                    r40 = 256
                                                    r1 = r5 % r40
                                                    r25 = r1
                                                    r40 = r20[r3]
                                                    r26 = 1
                                                    r22 = r25 + r26
                                                    r16 = r12[r22]
                                                    r17 = nil
                                                    r5 = r40 .. r16
                                                    r20[r3] = r5
                                                    state = 63
                                                end
                                            end
                                        else
                                            if state == 65 then
                                                r9 = nil
                                                r25 = nil
                                                r12 = nil
                                                state = 62
                                            end
                                        end
                                    end
                                else
                                    -- createClosure5 entry 8738269 -> 66, states 66-68
                                    if state <= 67 then
                                        if state <= 66 then
                                            if state == 66 then -- entry 8738269 -> 66
                                                r15 = allocUpvalue()
                                                r3 = allocUpvalue()
                                                upvalueValues[r15] = args[1]
                                                upvalueValues[r3] = args[2]
                                                ReturnVal = "writefile"
                                                state = _env[ReturnVal]
                                                state = state and (67) or (68)
                                            end
                                        else
                                            if state == 67 then
                                                ReturnVal = "pcall"
                                                state = _env[ReturnVal]
                                                r20 = createClosure3(127, {
                                                    r15,
                                                    r3
                                                })
                                                ReturnVal = state(r20)
                                                state = 68
                                            end
                                        end
                                    else
                                        if state == 68 then
                                            ReturnVal = {}
                                            r15 = releaseUpvalue(r15)
                                            r3 = releaseUpvalue(r3)
                                            state = nil
                                        end
                                    end
                                end
                            else
                                -- createClosure5 entry 8327170 -> 69, states 69-93
                                if state <= 81 then
                                    if state <= 75 then
                                        if state <= 72 then
                                            if state <= 70 then
                                                if state <= 69 then
                                                    if state == 69 then -- entry 8327170 -> 69
                                                        r20 = state
                                                        r15 = allocUpvalue()
                                                        upvalueValues[r15] = args[1]
                                                        r39 = "syn"
                                                        r12 = _env[r39]
                                                        state = r12 and (70) or (71)
                                                        r3 = r12
                                                    end
                                                else
                                                    if state == 70 then
                                                        r25 = "syn"
                                                        r39 = _env[r25]
                                                        r9 = upvalueValues[upvalues[1]]
                                                        r17 = upvalueValues[upvalues[2]]
                                                        r2 = "1\173\160?\007\194\014"
                                                        r43 = 34775638982465
                                                        r28 = r17(r2, r43)
                                                        r25 = r9[r28]
                                                        r12 = r39[r25]
                                                        r3 = r12
                                                        state = 71
                                                    end
                                                end
                                            else
                                                if state <= 71 then
                                                    if state == 71 then
                                                        state = r20
                                                        state = r3 and (72) or (73)
                                                        ReturnVal = r3
                                                    end
                                                else
                                                    if state == 72 then
                                                        r3 = allocUpvalue()
                                                        upvalueValues[r3] = ReturnVal
                                                        state = upvalueValues[r3]
                                                        state = state and (74) or (75)
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 74 then
                                                if state <= 73 then
                                                    if state == 73 then
                                                        r20 = state
                                                        r39 = "request"
                                                        r12 = _env[r39]
                                                        state = r12 and (76) or (77)
                                                        r3 = r12
                                                    end
                                                else
                                                    if state == 74 then
                                                        r12 = createClosure0(128, {
                                                            r3,
                                                            upvalues[1],
                                                            upvalues[2],
                                                            r15
                                                        })
                                                        ReturnVal = "pcall"
                                                        state = _env[ReturnVal]
                                                        r39 = {
                                                            state(r12)
                                                        }
                                                        ReturnVal = r39[1]
                                                        r12 = ReturnVal
                                                        state = r12 and (78) or (79)
                                                        ReturnVal = r12
                                                        r20 = r39[2]
                                                    end
                                                end
                                            else
                                                if state == 75 then
                                                    state = false
                                                    ReturnVal = {
                                                        state
                                                    }
                                                    state = nil
                                                end
                                            end
                                        end
                                    else
                                        if state <= 78 then
                                            if state <= 77 then
                                                if state <= 76 then
                                                    if state == 76 then
                                                        state = r20
                                                        ReturnVal = r3
                                                        state = 72
                                                    end
                                                else
                                                    if state == 77 then
                                                        r39 = state
                                                        r28 = "http"
                                                        r17 = _env[r28]
                                                        r9 = state
                                                        state = r17 and (80) or (81)
                                                        r25 = r17
                                                    end
                                                end
                                            else
                                                if state == 78 then
                                                    ReturnVal = r20
                                                    state = 79
                                                end
                                            end
                                        else
                                            if state <= 80 then
                                                if state <= 79 then
                                                    if state == 79 then
                                                        state = ReturnVal and (82) or (83)
                                                    end
                                                else
                                                    if state == 80 then
                                                        r2 = "http"
                                                        r28 = _env[r2]
                                                        r43 = upvalueValues[upvalues[1]]
                                                        r37 = upvalueValues[upvalues[2]]
                                                        r40 = 22902028954024
                                                        r5 = "R!\253\192\1328@"
                                                        r1 = r37(r5, r40)
                                                        r2 = r43[r1]
                                                        r17 = r28[r2]
                                                        r25 = r17
                                                        state = 81
                                                    end
                                                end
                                            else
                                                if state == 81 then
                                                    state = r9
                                                    state = r25 and (84) or (85)
                                                    r12 = r25
                                                end
                                            end
                                        end
                                    end
                                else
                                    if state <= 87 then
                                        if state <= 84 then
                                            if state <= 83 then
                                                if state <= 82 then
                                                    if state == 82 then
                                                        r39 = "type"
                                                        ReturnVal = _env[r39]
                                                        r39 = ReturnVal(r20)
                                                        r25 = upvalueValues[upvalues[1]]
                                                        r9 = upvalueValues[upvalues[2]]
                                                        r2 = 10528346903334
                                                        r28 = "|q\021'n"
                                                        r17 = r9(r28, r2)
                                                        ReturnVal = r25[r17]
                                                        state = r39 ~= ReturnVal
                                                        state = state and (86) or (87)
                                                    end
                                                else
                                                    if state == 83 then
                                                        state = false
                                                        ReturnVal = {
                                                            state
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            else
                                                if state == 84 then
                                                    state = r39
                                                    r3 = r12
                                                    state = 76
                                                end
                                            end
                                        else
                                            if state <= 86 then
                                                if state <= 85 then
                                                    if state == 85 then
                                                        r9 = "http_request"
                                                        r25 = _env[r9]
                                                        r12 = r25
                                                        state = 84
                                                    end
                                                else
                                                    if state == 86 then
                                                        r39 = "type"
                                                        ReturnVal = _env[r39]
                                                        r39 = ReturnVal(r20)
                                                        r25 = upvalueValues[upvalues[1]]
                                                        r9 = upvalueValues[upvalues[2]]
                                                        r2 = 4186735675293
                                                        r28 = "7\171\027T-\205"
                                                        r17 = r9(r28, r2)
                                                        ReturnVal = r25[r17]
                                                        state = r39 ~= ReturnVal
                                                        state = state and (88) or (89)
                                                    end
                                                end
                                            else
                                                if state == 87 then
                                                    state = true
                                                    r39 = state
                                                    r17 = upvalueValues[upvalues[1]]
                                                    r28 = upvalueValues[upvalues[2]]
                                                    r43 = "z\195:\214"
                                                    r37 = 20846541153771
                                                    r2 = r28(r43, r37)
                                                    r9 = r17[r2]
                                                    r25 = r20[r9]
                                                    state = r25 and (90) or (91)
                                                    ReturnVal = r25
                                                end
                                            end
                                        end
                                    else
                                        if state <= 90 then
                                            if state <= 89 then
                                                if state <= 88 then
                                                    if state == 88 then
                                                        state = false
                                                        ReturnVal = {
                                                            state
                                                        }
                                                        state = nil
                                                    end
                                                else
                                                    if state == 89 then
                                                        state = true
                                                        ReturnVal = {
                                                            state,
                                                            r20
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            else
                                                if state == 90 then
                                                    state = r39
                                                    ReturnVal = {
                                                        state,
                                                        ReturnVal
                                                    }
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state <= 92 then
                                                if state <= 91 then
                                                    if state == 91 then
                                                        r9 = state
                                                        r2 = upvalueValues[upvalues[1]]
                                                        r43 = upvalueValues[upvalues[2]]
                                                        r5 = 27468469907959
                                                        r1 = "\168\240\221\237"
                                                        r37 = r43(r1, r5)
                                                        r28 = r2[r37]
                                                        r17 = r20[r28]
                                                        state = r17 and (92) or (93)
                                                        r25 = r17
                                                    end
                                                else
                                                    if state == 92 then
                                                        state = r9
                                                        ReturnVal = r25
                                                        state = 90
                                                    end
                                                end
                                            else
                                                if state == 93 then
                                                    r2 = upvalueValues[upvalues[1]]
                                                    r43 = upvalueValues[upvalues[2]]
                                                    r5 = 9848641524202
                                                    r1 = "x\231x\135\213\221u("
                                                    r37 = r43(r1, r5)
                                                    r28 = r2[r37]
                                                    r17 = r20[r28]
                                                    r25 = r17
                                                    state = 92
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            if state <= 111 then
                                if state <= 106 then
                                    -- createClosure1 entry 12183549 -> 94, states 94-106
                                    if state <= 100 then
                                        if state <= 97 then
                                            if state <= 95 then
                                                if state <= 94 then
                                                    if state == 94 then -- entry 12183549 -> 94
                                                        r15 = args[1]
                                                        state = r15 and (95) or (96)
                                                        ReturnVal = r15
                                                    end
                                                else
                                                    if state == 95 then
                                                        r12 = upvalueValues[upvalues[1]]
                                                        r39 = upvalueValues[upvalues[2]]
                                                        r17 = 2757279433987
                                                        r9 = ""
                                                        r25 = r39(r9, r17)
                                                        r20 = r12[r25]
                                                        r3 = r15 ~= r20
                                                        ReturnVal = r3
                                                        state = 96
                                                    end
                                                end
                                            else
                                                if state <= 96 then
                                                    if state == 96 then
                                                        state = ReturnVal and (97) or (98)
                                                    end
                                                else
                                                    if state == 97 then
                                                        state = upvalueValues[upvalues[3]]
                                                        r12 = upvalueValues[upvalues[4]]
                                                        r25 = "tostring"
                                                        r39 = _env[r25]
                                                        r25 = r39(r15)
                                                        r20 = r12 .. r25
                                                        r12 = {
                                                            state(r20)
                                                        }
                                                        ReturnVal = r12[1]
                                                        r3 = r12[2]
                                                        r20 = ReturnVal
                                                        state = r20 and (99) or (100)
                                                        r12 = allocUpvalue()
                                                        upvalueValues[r12] = r3
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 99 then
                                                if state <= 98 then
                                                    if state == 98 then
                                                        state = false
                                                        ReturnVal = {
                                                            state
                                                        }
                                                        state = nil
                                                    end
                                                else
                                                    if state == 99 then
                                                        ReturnVal = "pcall"
                                                        state = _env[ReturnVal]
                                                        r39 = createClosure2(129, {
                                                            upvalues[5],
                                                            r12
                                                        })
                                                        r25 = {
                                                            state(r39)
                                                        }
                                                        ReturnVal = r25[1]
                                                        r39 = ReturnVal
                                                        state = r39 and (101) or (102)
                                                        r3 = r25[2]
                                                        ReturnVal = r39
                                                    end
                                                end
                                            else
                                                if state == 100 then
                                                    state = false
                                                    ReturnVal = {
                                                        state
                                                    }
                                                    state = nil
                                                end
                                            end
                                        end
                                    else
                                        if state <= 103 then
                                            if state <= 102 then
                                                if state <= 101 then
                                                    if state == 101 then
                                                        ReturnVal = r3
                                                        state = 102
                                                    end
                                                else
                                                    if state == 102 then
                                                        state = ReturnVal and (103) or (104)
                                                    end
                                                end
                                            else
                                                if state == 103 then
                                                    r28 = upvalueValues[upvalues[1]]
                                                    r2 = upvalueValues[upvalues[2]]
                                                    r37 = "\171&\221\238\228"
                                                    r1 = 29685089203711
                                                    r43 = r2(r37, r1)
                                                    r17 = r28[r43]
                                                    r9 = r3[r17]
                                                    r17 = true
                                                    r25 = r9 == r17
                                                    state = r25 and (105) or (106)
                                                    ReturnVal = r25
                                                end
                                            end
                                        else
                                            if state <= 105 then
                                                if state <= 104 then
                                                    if state == 104 then
                                                        state = false
                                                        ReturnVal = {
                                                            state
                                                        }
                                                        state = nil
                                                    end
                                                else
                                                    if state == 105 then
                                                        ReturnVal = {
                                                            ReturnVal
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            else
                                                if state == 106 then
                                                    r28 = upvalueValues[upvalues[1]]
                                                    r2 = upvalueValues[upvalues[2]]
                                                    r1 = 15012081179470
                                                    r37 = "\006\210\234\017o"
                                                    r43 = r2(r37, r1)
                                                    r17 = r28[r43]
                                                    r9 = r3[r17]
                                                    r28 = upvalueValues[upvalues[1]]
                                                    r2 = upvalueValues[upvalues[2]]
                                                    r37 = "G\134H\220"
                                                    r1 = 13632730241228
                                                    r43 = r2(r37, r1)
                                                    r17 = r28[r43]
                                                    r25 = r9 == r17
                                                    ReturnVal = r25
                                                    state = 105
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure6 entry 1328258 -> 107, states 107-111
                                    if state <= 109 then
                                        if state <= 108 then
                                            if state <= 107 then
                                                if state == 107 then -- entry 1328258 -> 107
                                                    r15 = allocUpvalue()
                                                    upvalueValues[r15] = args[1]
                                                    ReturnVal = "readfile"
                                                    state = _env[ReturnVal]
                                                    state = state and (108) or (109)
                                                end
                                            else
                                                if state == 108 then
                                                    ReturnVal = "pcall"
                                                    state = _env[ReturnVal]
                                                    r20 = createClosure0(130, {
                                                        r15
                                                    })
                                                    r12 = {
                                                        state(r20)
                                                    }
                                                    ReturnVal = r12[1]
                                                    r20 = ReturnVal
                                                    state = r20 and (110) or (111)
                                                    r3 = r12[2]
                                                end
                                            end
                                        else
                                            if state == 109 then
                                                r15 = releaseUpvalue(r15)
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    else
                                        if state <= 110 then
                                            if state == 110 then
                                                ReturnVal = {
                                                    r3
                                                }
                                                state = nil
                                            end
                                        else
                                            if state == 111 then
                                                r3 = nil
                                                r20 = nil
                                                state = 109
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure4 entry 5974464 -> 112, states 112-117
                                if state <= 114 then
                                    if state <= 113 then
                                        if state <= 112 then
                                            if state == 112 then -- entry 5974464 -> 112
                                                r15 = args[1]
                                                r3 = allocUpvalue()
                                                upvalueValues[r3] = args[2]
                                                r20 = upvalueValues[r3]
                                                state = r20 and (113) or (114)
                                                ReturnVal = r20
                                            end
                                        else
                                            if state == 113 then
                                                r12 = upvalueValues[r3]
                                                r25 = upvalueValues[upvalues[1]]
                                                r9 = upvalueValues[upvalues[2]]
                                                r2 = 20715761378734
                                                r28 = ""
                                                r17 = r9(r28, r2)
                                                r39 = r25[r17]
                                                r20 = r12 ~= r39
                                                ReturnVal = r20
                                                state = 114
                                            end
                                        end
                                    else
                                        if state == 114 then
                                            state = ReturnVal and (115) or (116)
                                        end
                                    end
                                else
                                    if state <= 116 then
                                        if state <= 115 then
                                            if state == 115 then
                                                state = upvalueValues[upvalues[3]]
                                                r12 = upvalueValues[upvalues[1]]
                                                r39 = upvalueValues[upvalues[2]]
                                                ReturnVal = "Notify"
                                                ReturnVal = state[ReturnVal]
                                                r9 = "$\156\234\005\232`\161\029vt\136\1474@\201"
                                                r17 = 12893820442484
                                                r25 = r39(r9, r17)
                                                r20 = r12[r25]
                                                r12 = 1
                                                ReturnVal = ReturnVal(state, r20, r12)
                                                r20 = "task"
                                                ReturnVal = _env[r20]
                                                r12 = upvalueValues[upvalues[1]]
                                                r39 = upvalueValues[upvalues[2]]
                                                r17 = 30992631314528
                                                r9 = "\189fN\199q"
                                                r25 = r39(r9, r17)
                                                r20 = r12[r25]
                                                state = ReturnVal[r20]
                                                r20 = createClosure2(131, {
                                                    upvalues[4],
                                                    r3,
                                                    upvalues[5],
                                                    upvalues[6],
                                                    upvalues[3],
                                                    upvalues[1],
                                                    upvalues[2],
                                                    upvalues[7],
                                                    upvalues[8]
                                                })
                                                ReturnVal = state(r20)
                                                state = 117
                                            end
                                        else
                                            if state == 116 then
                                                state = upvalueValues[upvalues[3]]
                                                r12 = upvalueValues[upvalues[1]]
                                                r39 = upvalueValues[upvalues[2]]
                                                r17 = 23319595952747
                                                r9 = "\1392Y\188\245>/\249\195{\142\215w\016K\138\238\024\028"
                                                r25 = r39(r9, r17)
                                                ReturnVal = "Notify"
                                                ReturnVal = state[ReturnVal]
                                                r20 = r12[r25]
                                                r12 = 5
                                                ReturnVal = ReturnVal(state, r20, r12)
                                                state = 117
                                            end
                                        end
                                    else
                                        if state == 117 then
                                            r3 = releaseUpvalue(r3)
                                            r15 = nil
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                end
                            end
                        end
                    end
                else
                    if state <= 128 then
                        if state <= 125 then
                            if state <= 123 then
                                if state <= 120 then
                                    -- createClosure5 entry 7201455 -> 118, states 118-120
                                    if state <= 119 then
                                        if state <= 118 then
                                            if state == 118 then -- entry 7201455 -> 118
                                                ReturnVal = "setclipboard"
                                                state = _env[ReturnVal]
                                                state = state and (119) or (120)
                                            end
                                        else
                                            if state == 119 then
                                                r15 = createClosure3(139, {
                                                    upvalues[1]
                                                })
                                                ReturnVal = "pcall"
                                                state = _env[ReturnVal]
                                                ReturnVal = state(r15)
                                                state = 120
                                            end
                                        end
                                    else
                                        if state == 120 then
                                            state = upvalueValues[upvalues[2]]
                                            ReturnVal = "Notify"
                                            ReturnVal = state[ReturnVal]
                                            r3 = upvalueValues[upvalues[3]]
                                            r20 = upvalueValues[upvalues[4]]
                                            r25 = 33852031892883
                                            r39 = "$)\129\211\252x-\006\1859e\\\247\131[\154\220\164\152\165\027\213Q\237\171\241\151\131]"
                                            r12 = r20(r39, r25)
                                            r15 = r3[r12]
                                            r3 = 5
                                            ReturnVal = ReturnVal(state, r15, r3)
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure3 entry 2839340 -> 121, states 121-123
                                    if state <= 122 then
                                        if state <= 121 then
                                            if state == 121 then -- entry 2839340 -> 121
                                                ReturnVal = "setclipboard"
                                                state = _env[ReturnVal]
                                                state = state and (122) or (123)
                                            end
                                        else
                                            if state == 122 then
                                                r15 = createClosure4(140, {
                                                    upvalues[1]
                                                })
                                                ReturnVal = "pcall"
                                                state = _env[ReturnVal]
                                                ReturnVal = state(r15)
                                                state = 123
                                            end
                                        end
                                    else
                                        if state == 123 then
                                            state = upvalueValues[upvalues[2]]
                                            r3 = upvalueValues[upvalues[3]]
                                            r20 = upvalueValues[upvalues[4]]
                                            r39 = "\148+<\244{\133{\192 \167\024\025\232\201+\160\133\029\241J"
                                            r25 = 34144726236699
                                            r12 = r20(r39, r25)
                                            ReturnVal = "Notify"
                                            ReturnVal = state[ReturnVal]
                                            r15 = r3[r12]
                                            r3 = 5
                                            ReturnVal = ReturnVal(state, r15, r3)
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                end
                            else
                                if state <= 124 then
                                    -- createClosure5 entry 9839665 -> 124, states 124-124
                                    if state == 124 then -- entry 9839665 -> 124
                                        state = upvalueValues[upvalues[1]]
                                        ReturnVal = "Unload"
                                        ReturnVal = state[ReturnVal]
                                        ReturnVal = ReturnVal(state)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                else
                                    -- createClosure1 entry 16772515 -> 125, states 125-125
                                    if state == 125 then -- entry 16772515 -> 125
                                        state = upvalueValues[upvalues[1]]
                                        ReturnVal = "Unload"
                                        ReturnVal = state[ReturnVal]
                                        ReturnVal = ReturnVal(state)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            end
                        else
                            if state <= 127 then
                                if state <= 126 then
                                    -- createClosure1 entry 16257087 -> 126, states 126-126
                                    if state == 126 then -- entry 16257087 -> 126
                                        r3 = "uXiwBZlyrH"
                                        r20 = 15508341
                                        r15 = r3 ^ r20
                                        ReturnVal = 14090531
                                        state = ReturnVal - r15
                                        r15 = state
                                        ReturnVal = "wLb"
                                        state = ReturnVal / r15
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure3 entry 238608 -> 127, states 127-127
                                    if state == 127 then -- entry 238608 -> 127
                                        ReturnVal = "writefile"
                                        state = _env[ReturnVal]
                                        r15 = upvalueValues[upvalues[1]]
                                        r3 = upvalueValues[upvalues[2]]
                                        ReturnVal = state(r15, r3)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            else
                                -- createClosure0 entry 8913221 -> 128, states 128-128
                                if state == 128 then -- entry 8913221 -> 128
                                    state = upvalueValues[upvalues[1]]
                                    r20 = upvalueValues[upvalues[2]]
                                    r12 = upvalueValues[upvalues[3]]
                                    r9 = 29473410577820
                                    r25 = "\029\193\132"
                                    r39 = r12(r25, r9)
                                    r3 = r20[r39]
                                    r20 = upvalueValues[upvalues[4]]
                                    r39 = upvalueValues[upvalues[2]]
                                    r25 = upvalueValues[upvalues[3]]
                                    r28 = 10733789631366
                                    r17 = "\022\165\167ds\204"
                                    r9 = r25(r17, r28)
                                    r12 = r39[r9]
                                    r25 = upvalueValues[upvalues[2]]
                                    r9 = upvalueValues[upvalues[3]]
                                    r28 = "\236R\243"
                                    r2 = 27736097714803
                                    r17 = r9(r28, r2)
                                    r39 = r25[r17]
                                    r15 = {
                                        [r3] = r20,
                                        [r12] = r39
                                    }
                                    ReturnVal = {
                                        state(r15)
                                    }
                                    ReturnVal = {
                                        unpack(ReturnVal)
                                    }
                                    state = nil
                                end
                            end
                        end
                    else
                        if state <= 138 then
                            if state <= 130 then
                                if state <= 129 then
                                    -- createClosure2 entry 16256580 -> 129, states 129-129
                                    if state == 129 then -- entry 16256580 -> 129
                                        state = upvalueValues[upvalues[1]]
                                        r3 = "JSONDecode"
                                        r3 = state[r3]
                                        r15 = upvalueValues[upvalues[2]]
                                        ReturnVal = {
                                            r3(state, r15)
                                        }
                                        ReturnVal = {
                                            unpack(ReturnVal)
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure0 entry 539918 -> 130, states 130-130
                                    if state == 130 then -- entry 539918 -> 130
                                        ReturnVal = "readfile"
                                        state = _env[ReturnVal]
                                        r15 = upvalueValues[upvalues[1]]
                                        ReturnVal = {
                                            state(r15)
                                        }
                                        ReturnVal = {
                                            unpack(ReturnVal)
                                        }
                                        state = nil
                                    end
                                end
                            else
                                -- createClosure2 entry 13116096 -> 131, states 131-138
                                if state <= 134 then
                                    if state <= 132 then
                                        if state <= 131 then
                                            if state == 131 then -- entry 13116096 -> 131
                                                state = upvalueValues[upvalues[1]]
                                                r15 = upvalueValues[upvalues[2]]
                                                ReturnVal = state(r15)
                                                state = ReturnVal and (132) or (133)
                                            end
                                        else
                                            if state == 132 then
                                                state = upvalueValues[upvalues[3]]
                                                r15 = upvalueValues[upvalues[4]]
                                                r3 = upvalueValues[upvalues[2]]
                                                ReturnVal = state(r15, r3)
                                                state = upvalueValues[upvalues[5]]
                                                r3 = upvalueValues[upvalues[6]]
                                                r20 = upvalueValues[upvalues[7]]
                                                r39 = "\220\004\211\157dw\159\159\014\233\143!\145\t[\246\138\222\141F\"k\011'q\252p6"
                                                r25 = 4478376773669
                                                r12 = r20(r39, r25)
                                                r15 = r3[r12]
                                                ReturnVal = "Notify"
                                                ReturnVal = state[ReturnVal]
                                                r3 = 3
                                                ReturnVal = ReturnVal(state, r15, r3)
                                                r15 = "task"
                                                ReturnVal = _env[r15]
                                                r3 = upvalueValues[upvalues[6]]
                                                r20 = upvalueValues[upvalues[7]]
                                                r39 = "\175\243\134\020"
                                                r25 = 11557727638789
                                                r12 = r20(r39, r25)
                                                r15 = r3[r12]
                                                state = ReturnVal[r15]
                                                r15 = 0.3
                                                ReturnVal = state(r15)
                                                state = upvalueValues[upvalues[8]]
                                                r3 = upvalueValues[upvalues[9]]
                                                r20 = {
                                                    state(r3)
                                                }
                                                ReturnVal = r20[1]
                                                r3 = ReturnVal
                                                state = r3 and (134) or (135)
                                                r15 = r20[2]
                                                r20 = allocUpvalue()
                                                upvalueValues[r20] = r15
                                                ReturnVal = r3
                                            end
                                        end
                                    else
                                        if state <= 133 then
                                            if state == 133 then
                                                state = upvalueValues[upvalues[5]]
                                                r3 = upvalueValues[upvalues[6]]
                                                r20 = upvalueValues[upvalues[7]]
                                                r39 = "\237&\136\180\152P\016+\167f\149"
                                                r25 = 29663889077749
                                                r12 = r20(r39, r25)
                                                r15 = r3[r12]
                                                ReturnVal = "Notify"
                                                ReturnVal = state[ReturnVal]
                                                r3 = 5
                                                ReturnVal = ReturnVal(state, r15, r3)
                                                state = 136
                                            end
                                        else
                                            if state == 134 then
                                                r15 = upvalueValues[r20]
                                                ReturnVal = r15
                                                state = 135
                                            end
                                        end
                                    end
                                else
                                    if state <= 136 then
                                        if state <= 135 then
                                            if state == 135 then
                                                state = ReturnVal and (137) or (138)
                                            end
                                        else
                                            if state == 136 then
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    else
                                        if state <= 137 then
                                            if state == 137 then
                                                r15 = createClosure0(141, {
                                                    r20
                                                })
                                                ReturnVal = "pcall"
                                                state = _env[ReturnVal]
                                                ReturnVal = state(r15)
                                                state = 138
                                            end
                                        else
                                            if state == 138 then
                                                r20 = releaseUpvalue(r20)
                                                r3 = nil
                                                state = 136
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            if state <= 140 then
                                if state <= 139 then
                                    -- createClosure3 entry 8060547 -> 139, states 139-139
                                    if state == 139 then -- entry 8060547 -> 139
                                        ReturnVal = "setclipboard"
                                        state = _env[ReturnVal]
                                        r15 = upvalueValues[upvalues[1]]
                                        ReturnVal = state(r15)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                else
                                    -- createClosure4 entry 15924486 -> 140, states 140-140
                                    if state == 140 then -- entry 15924486 -> 140
                                        ReturnVal = "setclipboard"
                                        state = _env[ReturnVal]
                                        r15 = upvalueValues[upvalues[1]]
                                        ReturnVal = state(r15)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            else
                                -- createClosure0 entry 3647259 -> 141, states 141-141
                                if state == 141 then -- entry 3647259 -> 141
                                    ReturnVal = "loadstring"
                                    state = _env[ReturnVal]
                                    r15 = upvalueValues[upvalues[1]]
                                    ReturnVal = state(r15)
                                    state = ReturnVal()
                                    ReturnVal = {}
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
        allocUpvalue = function()
            currentUpvalueId = currentUpvalueId + (1)
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        currentUpvalueId = 0
        createClosure0 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function()
                return vm(entryId, {}, captures, gcProxy)
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
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)