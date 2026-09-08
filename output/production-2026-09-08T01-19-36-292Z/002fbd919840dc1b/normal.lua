return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, createClosure, releaseUpvalues, createClosure1, createClosure5, createClosure0, createClosure3, createClosure4, allocUpvalue, currentUpvalueId, upvalueValues, createUpvalueProxy, releaseUpvalue, vm, upvalueRefCounts)
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
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
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, ReturnVal, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, r32, r33, r34, r35, r36, r37, r38, r39, r40, r41, r42, r43, r44, r45, r46, r47, r48, r49, r50, r51, r52, r53
            while state do
                if state <= 59 then
                    if state <= 46 then
                        if state <= 45 then
                            if state <= 44 then
                                -- root entry 6676071 -> 1, states 1-44
                                if state <= 22 then
                                    if state <= 11 then
                                        if state <= 6 then
                                            if state <= 3 then
                                                if state <= 2 then
                                                    if state <= 1 then
                                                        if state == 1 then -- entry 6676071 -> 1
                                                            r9 = allocUpvalue()
                                                            r31 = allocUpvalue()
                                                            state = true
                                                            upvalueValues[r9] = state
                                                            r30 = "string"
                                                            ReturnVal = _env[r30]
                                                            r39 = allocUpvalue()
                                                            r30 = "gmatch"
                                                            state = ReturnVal[r30]
                                                            r30 = allocUpvalue()
                                                            upvalueValues[r30] = state
                                                            r13 = createClosure3(45, {
                                                                r39
                                                            })
                                                            state = createClosure1(46, {})
                                                            upvalueValues[r31] = state
                                                            state = false
                                                            upvalueValues[r39] = state
                                                            r19 = "pcall"
                                                            r15 = _env[r19]
                                                            r19 = r15(r13)
                                                            state = r19 and (2) or (3)
                                                            r21 = args
                                                            ReturnVal = r19
                                                        end
                                                    else
                                                        if state == 2 then
                                                            r15 = upvalueValues[r39]
                                                            ReturnVal = r15
                                                            state = 3
                                                        end
                                                    end
                                                else
                                                    if state == 3 then
                                                        r15 = ReturnVal
                                                        r19 = "math"
                                                        ReturnVal = _env[r19]
                                                        r19 = "random"
                                                        state = ReturnVal[r19]
                                                        r19 = allocUpvalue()
                                                        upvalueValues[r19] = state
                                                        r13 = "table"
                                                        ReturnVal = _env[r13]
                                                        r13 = "concat"
                                                        state = ReturnVal[r13]
                                                        r26 = state
                                                        r13 = state
                                                        r32 = "table"
                                                        r37 = _env[r32]
                                                        state = r37 and (4) or (5)
                                                        r29 = r37
                                                    end
                                                end
                                            else
                                                if state <= 5 then
                                                    if state <= 4 then
                                                        if state == 4 then
                                                            r36 = "table"
                                                            r32 = _env[r36]
                                                            r36 = "unpack"
                                                            r37 = r32[r36]
                                                            r29 = r37
                                                            state = 5
                                                        end
                                                    else
                                                        if state == 5 then
                                                            state = r26
                                                            state = r29 and (6) or (7)
                                                            ReturnVal = r29
                                                        end
                                                    end
                                                else
                                                    if state == 6 then
                                                        r29 = allocUpvalue()
                                                        upvalueValues[r29] = ReturnVal
                                                        state = upvalueValues[r19]
                                                        r48 = createClosure4(47, {})
                                                        r37 = 65
                                                        r26 = 3
                                                        ReturnVal = state(r26, r37)
                                                        r26 = allocUpvalue()
                                                        upvalueValues[r26] = ReturnVal
                                                        state = 0
                                                        r37 = state
                                                        r36 = "pcall"
                                                        ReturnVal = _env[r36]
                                                        state = 0
                                                        r36 = {
                                                            ReturnVal(r48)
                                                        }
                                                        r32 = state
                                                        state = {
                                                            unpack(r36)
                                                        }
                                                        r36 = state
                                                        ReturnVal = 2
                                                        state = r36[ReturnVal]
                                                        r48 = state
                                                        ReturnVal = "tonumber"
                                                        state = _env[ReturnVal]
                                                        r4 = upvalueValues[r30]
                                                        r33 = "tostring"
                                                        r2 = _env[r33]
                                                        r33 = r2(r48)
                                                        r2 = ":(%d*):"
                                                        r8 = r4(r33, r2)
                                                        r4 = {
                                                            r8()
                                                        }
                                                        ReturnVal = state(unpack(r4))
                                                        r4 = allocUpvalue()
                                                        upvalueValues[r4] = ReturnVal
                                                        r8 = upvalueValues[r26]
                                                        r2 = r8
                                                        r8 = 1
                                                        r33 = r8
                                                        r8 = 0
                                                        r47 = r33 < r8
                                                        ReturnVal = 1
                                                        r8 = ReturnVal - r33
                                                        state = 8
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 9 then
                                                if state <= 8 then
                                                    if state <= 7 then
                                                        if state == 7 then
                                                            r26 = "unpack"
                                                            r29 = _env[r26]
                                                            ReturnVal = r29
                                                            state = 6
                                                        end
                                                    else
                                                        if state == 8 then
                                                            r8 = r8 + r33
                                                            r20 = not r47
                                                            ReturnVal = r8 <= r2
                                                            ReturnVal = r20 and ReturnVal
                                                            r20 = r8 >= r2
                                                            r20 = r47 and r20
                                                            ReturnVal = r20 or ReturnVal
                                                            r20 = (9)
                                                            state = ReturnVal and r20
                                                            ReturnVal = (10)
                                                            state = state or ReturnVal
                                                        end
                                                    end
                                                else
                                                    if state == 9 then
                                                        r20 = allocUpvalue()
                                                        upvalueValues[r20] = r8
                                                        r49 = "math"
                                                        ReturnVal = _env[r49]
                                                        r49 = "random"
                                                        state = ReturnVal[r49]
                                                        r11 = 100
                                                        r49 = 1
                                                        ReturnVal = state(r49, r11)
                                                        r49 = allocUpvalue()
                                                        upvalueValues[r49] = ReturnVal
                                                        state = upvalueValues[r19]
                                                        r45 = 255
                                                        r11 = 0
                                                        ReturnVal = state(r11, r45)
                                                        r11 = allocUpvalue()
                                                        upvalueValues[r11] = ReturnVal
                                                        state = upvalueValues[r19]
                                                        r3 = upvalueValues[r49]
                                                        r45 = 1
                                                        ReturnVal = state(r45, r3)
                                                        r45 = allocUpvalue()
                                                        upvalueValues[r45] = ReturnVal
                                                        ReturnVal = upvalueValues[r19]
                                                        r52 = 1
                                                        r35 = 2
                                                        r3 = ReturnVal(r52, r35)
                                                        ReturnVal = 1
                                                        state = r3 == ReturnVal
                                                        r3 = allocUpvalue()
                                                        upvalueValues[r3] = state
                                                        r27 = "tostring"
                                                        r50 = _env[r27]
                                                        r41 = upvalueValues[r19]
                                                        r28 = 10000
                                                        r10 = 0
                                                        r23 = {
                                                            r41(r10, r28)
                                                        }
                                                        r27 = r50(unpack(r23))
                                                        state = "gsub"
                                                        state = r48[state]
                                                        r50 = ":"
                                                        r18 = r27 .. r50
                                                        r35 = ":"
                                                        r52 = r35 .. r18
                                                        ReturnVal = ":(%d*):"
                                                        state = state(r48, ReturnVal, r52)
                                                        r52 = allocUpvalue()
                                                        upvalueValues[r52] = state
                                                        r35 = "pcall"
                                                        ReturnVal = _env[r35]
                                                        r18 = createClosure0(48, {
                                                            r19,
                                                            r20,
                                                            r26,
                                                            r30,
                                                            r9,
                                                            r4,
                                                            r3,
                                                            r52,
                                                            r49,
                                                            r45,
                                                            r11,
                                                            r29
                                                        })
                                                        r35 = {
                                                            ReturnVal(r18)
                                                        }
                                                        state = {
                                                            unpack(r35)
                                                        }
                                                        r35 = state
                                                        state = upvalueValues[r3]
                                                        state = state and (11) or (12)
                                                    end
                                                end
                                            else
                                                if state <= 10 then
                                                    if state == 10 then
                                                        r2 = upvalueValues[r9]
                                                        state = r2 and (13) or (14)
                                                        r8 = r2
                                                    end
                                                else
                                                    if state == 11 then
                                                        r18 = upvalueValues[r9]
                                                        state = r18 and (15) or (16)
                                                        ReturnVal = r18
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 17 then
                                            if state <= 14 then
                                                if state <= 13 then
                                                    if state <= 12 then
                                                        if state == 12 then
                                                            r50 = upvalueValues[r9]
                                                            state = r50 and (17) or (18)
                                                            r18 = r50
                                                        end
                                                    else
                                                        if state == 13 then
                                                            r2 = r37 == r32
                                                            r8 = r2
                                                            state = 14
                                                        end
                                                    end
                                                else
                                                    if state == 14 then
                                                        upvalueValues[r9] = r8
                                                        state = upvalueValues[r9]
                                                        state = state and (19) or (20)
                                                    end
                                                end
                                            else
                                                if state <= 16 then
                                                    if state <= 15 then
                                                        if state == 15 then
                                                            r50 = state
                                                            r23 = 1
                                                            r41 = r35[r23]
                                                            r23 = false
                                                            r27 = r41 == r23
                                                            state = r27 and (21) or (22)
                                                            r18 = r27
                                                        end
                                                    else
                                                        if state == 16 then
                                                            upvalueValues[r9] = ReturnVal
                                                            state = 23
                                                        end
                                                    end
                                                else
                                                    if state == 17 then
                                                        r27 = 1
                                                        r50 = r35[r27]
                                                        r18 = r50
                                                        state = 18
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 20 then
                                                if state <= 19 then
                                                    if state <= 18 then
                                                        if state == 18 then
                                                            upvalueValues[r9] = r18
                                                            r23 = upvalueValues[r45]
                                                            r10 = 1
                                                            r41 = r23 + r10
                                                            r27 = r35[r41]
                                                            r50 = r37 + r27
                                                            r27 = 256
                                                            state = r50 % r27
                                                            r37 = state
                                                            r41 = upvalueValues[r11]
                                                            r27 = r32 + r41
                                                            r41 = 256
                                                            r50 = r27 % r41
                                                            r32 = r50
                                                            state = 23
                                                        end
                                                    else
                                                        if state == 19 then
                                                            state = 24
                                                        end
                                                    end
                                                else
                                                    if state == 20 then
                                                        state = true
                                                        state = 25
                                                    end
                                                end
                                            else
                                                if state <= 21 then
                                                    if state == 21 then
                                                        r23 = 2
                                                        r41 = r35[r23]
                                                        r23 = upvalueValues[r52]
                                                        r27 = r41 == r23
                                                        r18 = r27
                                                        state = 22
                                                    end
                                                else
                                                    if state == 22 then
                                                        state = r50
                                                        ReturnVal = r18
                                                        state = 16
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    if state <= 33 then
                                        if state <= 28 then
                                            if state <= 25 then
                                                if state <= 24 then
                                                    if state <= 23 then
                                                        if state == 23 then
                                                            r20 = releaseUpvalue(r20)
                                                            r3 = releaseUpvalue(r3)
                                                            r52 = releaseUpvalue(r52)
                                                            r49 = releaseUpvalue(r49)
                                                            r35 = nil
                                                            r11 = releaseUpvalue(r11)
                                                            r45 = releaseUpvalue(r45)
                                                            state = 8
                                                        end
                                                    else
                                                        if state == 24 then
                                                            r26 = releaseUpvalue(r26)
                                                            r30 = releaseUpvalue(r30)
                                                            r39 = releaseUpvalue(r39)
                                                            r15 = nil
                                                            r13 = nil
                                                            r13 = "table"
                                                            r19 = releaseUpvalue(r19)
                                                            r48 = nil
                                                            r48 = 1
                                                            r30 = nil
                                                            r9 = releaseUpvalue(r9)
                                                            r9 = nil
                                                            r31 = releaseUpvalue(r31)
                                                            r29 = releaseUpvalue(r29)
                                                            r15 = "math"
                                                            r39 = _env[r15]
                                                            r26 = allocUpvalue()
                                                            r15 = "floor"
                                                            r31 = r39[r15]
                                                            r4 = releaseUpvalue(r4)
                                                            r37 = nil
                                                            r37 = {}
                                                            r39 = allocUpvalue()
                                                            upvalueValues[r39] = r31
                                                            r19 = "math"
                                                            r15 = _env[r19]
                                                            r19 = "random"
                                                            r31 = r15[r19]
                                                            r19 = _env[r13]
                                                            r13 = "remove"
                                                            r15 = r19[r13]
                                                            r32 = nil
                                                            r32 = allocUpvalue()
                                                            r36 = nil
                                                            r36 = {}
                                                            r29 = "string"
                                                            r13 = _env[r29]
                                                            r29 = "char"
                                                            r19 = r13[r29]
                                                            r29 = allocUpvalue()
                                                            r13 = 0
                                                            upvalueValues[r29] = r13
                                                            r13 = 2
                                                            upvalueValues[r26] = r13
                                                            upvalueValues[r32] = r37
                                                            r13 = {}
                                                            r4 = 256
                                                            r47 = r4
                                                            r4 = 1
                                                            r20 = r4
                                                            r4 = 0
                                                            r49 = r20 < r4
                                                            r4 = r48 - r20
                                                            r37 = 0
                                                            state = 26
                                                        end
                                                    end
                                                else
                                                    if state == 25 then
                                                        state = createClosure1(60, {
                                                            r31
                                                        })
                                                        r2 = {
                                                            state()
                                                        }
                                                        ReturnVal = {
                                                            unpack(r2)
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            else
                                                if state <= 27 then
                                                    if state <= 26 then
                                                        if state == 26 then
                                                            r4 = r4 + r20
                                                            r11 = not r49
                                                            r48 = r4 <= r47
                                                            r48 = r11 and r48
                                                            r11 = r4 >= r47
                                                            r11 = r49 and r11
                                                            r48 = r11 or r48
                                                            r11 = (27)
                                                            state = r48 and r11
                                                            r48 = (28)
                                                            state = state or r48
                                                        end
                                                    else
                                                        if state == 27 then
                                                            r48 = r4
                                                            r11 = r48
                                                            r36[r48] = r11
                                                            r48 = nil
                                                            state = 26
                                                        end
                                                    end
                                                else
                                                    if state == 28 then
                                                        r4 = #r36
                                                        r47 = 0
                                                        r48 = r4 == r47
                                                        state = 29
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 31 then
                                                if state <= 30 then
                                                    if state <= 29 then
                                                        if state == 29 then
                                                            r47 = #r36
                                                            r4 = 1
                                                            r48 = r31(r4, r47)
                                                            r4 = r15(r36, r48)
                                                            r47 = upvalueValues[r32]
                                                            r11 = 1
                                                            r49 = r4 - r11
                                                            r48 = nil
                                                            r20 = r19(r49)
                                                            r47[r4] = r20
                                                            r4 = nil
                                                            state = 30
                                                        end
                                                    else
                                                        if state == 30 then
                                                            r4 = #r36
                                                            r47 = 0
                                                            r48 = r4 == r47
                                                            state = r48 and (31) or (29)
                                                        end
                                                    end
                                                else
                                                    if state == 31 then
                                                        r4 = allocUpvalue()
                                                        r20 = allocUpvalue()
                                                        r11 = {}
                                                        r48 = {}
                                                        upvalueValues[r4] = r48
                                                        r47 = createClosure5(64, {
                                                            r4,
                                                            r29,
                                                            r26,
                                                            r39
                                                        })
                                                        r48 = allocUpvalue()
                                                        upvalueValues[r48] = r47
                                                        r47 = {}
                                                        upvalueValues[r20] = r47
                                                        r49 = "setmetatable"
                                                        r47 = _env[r49]
                                                        r52 = upvalueValues[r20]
                                                        r27 = nil
                                                        r35 = "__metatable"
                                                        r3 = "__index"
                                                        r45 = {
                                                            [r3] = r52,
                                                            [r35] = r27
                                                        }
                                                        r49 = r47(r11, r45)
                                                        r47 = createClosure3(70, {
                                                            r20,
                                                            r4,
                                                            r32,
                                                            r29,
                                                            r26,
                                                            r48
                                                        })
                                                        r20 = releaseUpvalue(r20)
                                                        r39 = releaseUpvalue(r39)
                                                        r29 = releaseUpvalue(r29)
                                                        r48 = releaseUpvalue(r48)
                                                        r30 = r49
                                                        r9 = r47
                                                        r26 = releaseUpvalue(r26)
                                                        r32 = releaseUpvalue(r32)
                                                        r19 = nil
                                                        r19 = 8010853338770
                                                        r15 = nil
                                                        r15 = "KV\029Wb\192+\130\222\011/\025\184\229\127\187H\213\157\225\140\1524\195\191\180\022\246P\001g\140\031\187\217\194!\017\210p\244R\141\222:Z\253\1432\191T\016\150>=\251\215\245\207\147\204\163\156I(\003L\027\205H\224\236;\146\210\141\016d$EUj\017\216\203\238\144\142E\014\191\241\183_x\251\181\193\\\148\002a\188\137G\179?\139v-\019\016<h\016uN\149\021\011\171"
                                                        r39 = r9(r15, r19)
                                                        r31 = nil
                                                        r31 = r30[r39]
                                                        r15 = "game"
                                                        r39 = _env[r15]
                                                        r15 = "GetService"
                                                        r15 = r39[r15]
                                                        r4 = releaseUpvalue(r4)
                                                        r29 = "D`\195s\252^\213`1\003\145"
                                                        r26 = 22223273928812
                                                        r13 = nil
                                                        r13 = r9(r29, r26)
                                                        r19 = r30[r13]
                                                        r15 = r15(r39, r19)
                                                        r13 = "game"
                                                        r19 = _env[r13]
                                                        r37 = nil
                                                        r37 = "\251\183\012+\160\209;"
                                                        r32 = 12776444598077
                                                        r26 = r9(r37, r32)
                                                        r13 = "GetService"
                                                        r13 = r19[r13]
                                                        r29 = r30[r26]
                                                        r13 = r13(r19, r29)
                                                        r37 = 5295390968225
                                                        r26 = "\239\001f7\023g:\137=\129|"
                                                        r29 = r9(r26, r37)
                                                        r19 = r30[r29]
                                                        r39 = r13[r19]
                                                        r26 = "\248\024\238\016"
                                                        r37 = 14817625709299
                                                        r29 = r9(r26, r37)
                                                        r13 = r30[r29]
                                                        r19 = r39[r13]
                                                        r32 = 20798306117076
                                                        r37 = "\187\145\012\143kZ\186\235CC\246"
                                                        r26 = r9(r37, r32)
                                                        r29 = r30[r26]
                                                        r13 = r39[r29]
                                                        r36 = nil
                                                        r36 = 4446139582486
                                                        r32 = "\202\235/\192d\166"
                                                        r37 = r9(r32, r36)
                                                        r26 = r30[r37]
                                                        r29 = r39[r26]
                                                        r32 = "game"
                                                        r37 = _env[r32]
                                                        r4 = 26936872956159
                                                        r48 = "\135\163\155$\174"
                                                        r36 = r9(r48, r4)
                                                        r32 = r30[r36]
                                                        r26 = r37[r32]
                                                        r32 = "game"
                                                        r37 = _env[r32]
                                                        r47 = 32091215493727
                                                        r4 = "\018l\1657\160\189\239HL\r\184>a\183\023\143/\222"
                                                        r48 = r9(r4, r47)
                                                        r36 = r30[r48]
                                                        r32 = "GetService"
                                                        r32 = r37[r32]
                                                        r32 = r32(r37, r36)
                                                        r4 = "game"
                                                        r48 = _env[r4]
                                                        r11 = 13070097913798
                                                        r20 = "\006\137qO6(\165"
                                                        r47 = r9(r20, r11)
                                                        r4 = r30[r47]
                                                        r36 = r48[r4]
                                                        r37 = "GetProductInfo"
                                                        r37 = r32[r37]
                                                        r37 = r37(r32, r36)
                                                        r47 = 26705289293971
                                                        r4 = "\136\030\251\194"
                                                        r48 = r9(r4, r47)
                                                        r36 = r30[r48]
                                                        r32 = r37[r36]
                                                        r47 = "\198\182\209Q\029\018\019i\180\026\149&5J6w\205\000\019\197Bx\161H\190\220~R;"
                                                        r20 = 32355432643290
                                                        r4 = r9(r47, r20)
                                                        r48 = r30[r4]
                                                        r45 = 31178986092726
                                                        r11 = "\170#x\208\025\239\023$"
                                                        r20 = r9(r11, r45)
                                                        r47 = r30[r20]
                                                        r4 = r29 .. r47
                                                        r36 = r48 .. r4
                                                        r47 = "game"
                                                        r4 = _env[r47]
                                                        r3 = 25278275874299
                                                        r45 = "\030\236\131\020\016\234\225"
                                                        r11 = r9(r45, r3)
                                                        r47 = "GetService"
                                                        r47 = r4[r47]
                                                        r20 = r30[r11]
                                                        r47 = r47(r4, r20)
                                                        r4 = "GetPlayers"
                                                        r4 = r47[r4]
                                                        r4 = r4(r47)
                                                        r48 = #r4
                                                        r11 = "\1933Qt\223\149g9@Y<?\175*\169`\182\173v\217p5\n\178\206\169\029\251\243.\028:\197&\022\237\198\147\148UW\209M=53\208\026\203\131\154\238U\028\131\240\162m\158"
                                                        r45 = 7180900060431
                                                        r20 = r9(r11, r45)
                                                        r47 = r30[r20]
                                                        r3 = "game"
                                                        r45 = _env[r3]
                                                        r27 = 5448224754153
                                                        r35 = "\219\187\144z'N\227"
                                                        r52 = r9(r35, r27)
                                                        r3 = r30[r52]
                                                        r11 = r45[r3]
                                                        r35 = "g\199D"
                                                        r27 = 17503457255382
                                                        r52 = r9(r35, r27)
                                                        r3 = r30[r52]
                                                        r41 = "MU"
                                                        r23 = 21898495764437
                                                        r27 = r9(r41, r23)
                                                        r35 = r30[r27]
                                                        r52 = r26 .. r35
                                                        r45 = r3 .. r52
                                                        r20 = r11 .. r45
                                                        r4 = r47 .. r20
                                                        r3 = 21934719789030
                                                        r45 = "\n\179\198\176\236\1280b"
                                                        r11 = r9(r45, r3)
                                                        r20 = r30[r11]
                                                        r52 = 3588480697991
                                                        r3 = "%\216\007\128\181\004\019\134\225\186.\205m"
                                                        r45 = r9(r3, r52)
                                                        r11 = r30[r45]
                                                        r35 = 24637579799760
                                                        r52 = "\135\189,\253jIrU+\242"
                                                        r3 = r9(r52, r35)
                                                        r45 = r30[r3]
                                                        r27 = 27896691143358
                                                        r35 = "\234\242w\003\171xq\016\134\147\215ea\018#\250\rw0\234\249\190;p\243\007&\167\215gB\154Y\146 \128VL\136\243M\217T\130\203\226\018\0172\236\251\239\134\240\143\028\166l@\196SS`M\166\129J\238\030\229T\220g\228\023\201\132\159k\129\200"
                                                        r52 = r9(r35, r27)
                                                        r3 = r30[r52]
                                                        r41 = 30565256165273
                                                        r27 = "T\007`\007\203\237"
                                                        r35 = r9(r27, r41)
                                                        r52 = r30[r35]
                                                        r28 = 29616368317919
                                                        r10 = "\192\024LAx"
                                                        r23 = r9(r10, r28)
                                                        r41 = r30[r23]
                                                        r7 = "}fJ9z\028\017\214\014\127\131l\1953"
                                                        r43 = 16079045107007
                                                        r28 = r9(r7, r43)
                                                        r10 = r30[r28]
                                                        r23 = r19 .. r10
                                                        r7 = "\012\237o\158\254"
                                                        r43 = 15264602250180
                                                        r28 = r9(r7, r43)
                                                        r10 = r30[r28]
                                                        r7 = "tonumber"
                                                        r28 = _env[r7]
                                                        r43 = 65535
                                                        r7 = r28(r43)
                                                        r44 = 3308612994564
                                                        r16 = "O/7\154{\249"
                                                        r43 = r9(r16, r44)
                                                        r28 = r30[r43]
                                                        r51 = 27911748891333
                                                        r1 = "RG\178\190"
                                                        r17 = r9(r1, r51)
                                                        r44 = r30[r17]
                                                        r12 = 14376218270246
                                                        r51 = "!\214nvF\234\229S"
                                                        r1 = r9(r51, r12)
                                                        r17 = r30[r1]
                                                        r42 = 9777222390216
                                                        r12 = "\232_\157;\204"
                                                        r51 = r9(r12, r42)
                                                        r1 = r30[r51]
                                                        r46 = "\239\226\227"
                                                        r38 = 13313055971383
                                                        r6 = r9(r46, r38)
                                                        r42 = r30[r6]
                                                        r24 = 22387071609016
                                                        r34 = "\249I"
                                                        r14 = r9(r34, r24)
                                                        r38 = r30[r14]
                                                        r22 = 32000496319029
                                                        r25 = "\140\005"
                                                        r24 = r9(r25, r22)
                                                        r34 = r30[r24]
                                                        r14 = r36 .. r34
                                                        r46 = r38 .. r14
                                                        r6 = r13 .. r46
                                                        r12 = r42 .. r6
                                                        r51 = r19 .. r12
                                                        r16 = {
                                                            [r44] = r17,
                                                            [r1] = r51
                                                        }
                                                        r12 = 26089500569460
                                                        r51 = "\245ia\146"
                                                        r1 = r9(r51, r12)
                                                        r17 = r30[r1]
                                                        r42 = 27682462593626
                                                        r12 = "uF\206\012"
                                                        r51 = r9(r12, r42)
                                                        r1 = r30[r51]
                                                        r6 = 11633749923113
                                                        r42 = "/Y\137\247\148"
                                                        r12 = r9(r42, r6)
                                                        r51 = r30[r12]
                                                        r38 = 11703434581321
                                                        r46 = "M\186"
                                                        r6 = r9(r46, r38)
                                                        r42 = r30[r6]
                                                        r14 = "W\204"
                                                        r34 = 32128602176113
                                                        r38 = r9(r14, r34)
                                                        r46 = r30[r38]
                                                        r6 = r32 .. r46
                                                        r12 = r42 .. r6
                                                        r46 = "\159;|Xkb"
                                                        r38 = 3386250790440
                                                        r6 = r9(r46, r38)
                                                        r42 = r30[r6]
                                                        r6 = false
                                                        r44 = {
                                                            [r17] = r1,
                                                            [r51] = r12,
                                                            [r42] = r6
                                                        }
                                                        r42 = 8610277969833
                                                        r12 = "\130\252\028b"
                                                        r51 = r9(r12, r42)
                                                        r1 = r30[r51]
                                                        r42 = "\239\021\028\223`\226\233@\186}\202\247"
                                                        r6 = 10014327984695
                                                        r12 = r9(r42, r6)
                                                        r51 = r30[r12]
                                                        r46 = 30091540084412
                                                        r6 = "\1380\242\025U"
                                                        r42 = r9(r6, r46)
                                                        r12 = r30[r42]
                                                        r14 = 5781338507908
                                                        r38 = "\241\008+E\004m4?1Q@\024\205\1912\255\171\242"
                                                        r46 = r9(r38, r14)
                                                        r6 = r30[r46]
                                                        r42 = r48 .. r6
                                                        r14 = 6008941972206
                                                        r38 = "\181-)\158\137\253"
                                                        r46 = r9(r38, r14)
                                                        r6 = r30[r46]
                                                        r46 = true
                                                        r17 = {
                                                            [r1] = r51,
                                                            [r12] = r42,
                                                            [r6] = r46
                                                        }
                                                        r6 = 20185443853495
                                                        r42 = "}\184\253\188"
                                                        r12 = r9(r42, r6)
                                                        r51 = r30[r12]
                                                        r46 = 12962238568340
                                                        r6 = "\166+\163\021VD"
                                                        r42 = r9(r6, r46)
                                                        r12 = r30[r42]
                                                        r38 = 11457166742743
                                                        r46 = "/p\164\2138"
                                                        r6 = r9(r46, r38)
                                                        r42 = r30[r6]
                                                        r34 = 2504529003662
                                                        r14 = "\220f\194"
                                                        r38 = r9(r14, r34)
                                                        r46 = r30[r38]
                                                        r25 = 34860734332777
                                                        r24 = "\177|$"
                                                        r34 = r9(r24, r25)
                                                        r14 = r30[r34]
                                                        r38 = r26 .. r14
                                                        r6 = r46 .. r38
                                                        r34 = 33391886531773
                                                        r14 = "<\024\192\031\185L"
                                                        r38 = r9(r14, r34)
                                                        r46 = r30[r38]
                                                        r38 = false
                                                        r1 = {
                                                            [r51] = r12,
                                                            [r42] = r6,
                                                            [r46] = r38
                                                        }
                                                        r46 = 6093009701653
                                                        r6 = "\234\149\151\193"
                                                        r42 = r9(r6, r46)
                                                        r12 = r30[r42]
                                                        r38 = 24313942027322
                                                        r46 = "\219\196<C\150\195\200r7\0112"
                                                        r6 = r9(r46, r38)
                                                        r42 = r30[r6]
                                                        r14 = 26104205586299
                                                        r38 = "\245\209I\130&"
                                                        r46 = r9(r38, r14)
                                                        r6 = r30[r46]
                                                        r34 = "\015e\02873GU"
                                                        r24 = 1473893778094
                                                        r14 = r9(r34, r24)
                                                        r38 = r30[r14]
                                                        r22 = 18745938240025
                                                        r25 = "\208g\247;"
                                                        r24 = r9(r25, r22)
                                                        r34 = r30[r24]
                                                        r14 = r4 .. r34
                                                        r46 = r38 .. r14
                                                        r51 = {
                                                            [r12] = r42,
                                                            [r6] = r46
                                                        }
                                                        r38 = 6998878588091
                                                        r46 = "4\177\147\232"
                                                        r6 = r9(r46, r38)
                                                        r42 = r30[r6]
                                                        r14 = 16738496028274
                                                        r38 = "\r'm\151|\247JF\233\163\195"
                                                        r46 = r9(r38, r14)
                                                        r6 = r30[r46]
                                                        r34 = 22054551250973
                                                        r14 = "f\128\015\194'"
                                                        r38 = r9(r14, r34)
                                                        r46 = r30[r38]
                                                        r24 = "\137\131h"
                                                        r25 = 34910627495808
                                                        r34 = r9(r24, r25)
                                                        r14 = r30[r34]
                                                        r22 = "os"
                                                        r25 = _env[r22]
                                                        r5 = 31114714314904
                                                        r53 = "\181\213\189\236"
                                                        r40 = r9(r53, r5)
                                                        r22 = r30[r40]
                                                        r24 = r25[r22]
                                                        r53 = "=\242\152\028\201]\004F=\189\2094\241\246\249\160\143"
                                                        r5 = 31831773641190
                                                        r40 = r9(r53, r5)
                                                        r22 = r30[r40]
                                                        r25 = r24(r22)
                                                        r40 = "x\027\245"
                                                        r53 = 13039311361975
                                                        r22 = r9(r40, r53)
                                                        r24 = r30[r22]
                                                        r34 = r25 .. r24
                                                        r38 = r14 .. r34
                                                        r25 = 18317413818705
                                                        r24 = "\158\tL\164\016P"
                                                        r34 = r9(r24, r25)
                                                        r14 = r30[r34]
                                                        r34 = false
                                                        r12 = {
                                                            [r42] = r6,
                                                            [r46] = r38,
                                                            [r14] = r34
                                                        }
                                                        r43 = {
                                                            r16,
                                                            r44,
                                                            r17,
                                                            r1,
                                                            r51,
                                                            r12
                                                        }
                                                        r27 = {
                                                            [r41] = r23,
                                                            [r10] = r7,
                                                            [r28] = r43
                                                        }
                                                        r35 = {
                                                            r27
                                                        }
                                                        r10 = 28647897871388
                                                        r23 = "\164\008{q,{\193\165\225\218"
                                                        r41 = r9(r23, r10)
                                                        r27 = r30[r41]
                                                        r43 = 3944439842604
                                                        r7 = "\179xC\185"
                                                        r28 = r9(r7, r43)
                                                        r10 = r30[r28]
                                                        r44 = 10815504307116
                                                        r16 = "\2094\244\180\2450\143}\213\240"
                                                        r43 = r9(r16, r44)
                                                        r7 = r30[r43]
                                                        r51 = 5097275689285
                                                        r1 = "\188(\248\241"
                                                        r17 = r9(r1, r51)
                                                        r44 = r30[r17]
                                                        r42 = 15647874423926
                                                        r12 = "\031\202V\015("
                                                        r51 = r9(r12, r42)
                                                        r1 = r30[r51]
                                                        r6 = "\253\188\006|>"
                                                        r46 = 7759734378013
                                                        r42 = r9(r6, r46)
                                                        r12 = r30[r42]
                                                        r38 = 8483526479726
                                                        r46 = "\025{\0213\176m\228}\240U\209\169\028\140\220\229"
                                                        r6 = r9(r46, r38)
                                                        r42 = r30[r6]
                                                        r14 = 24258152410144
                                                        r38 = "\130\176\148"
                                                        r46 = r9(r38, r14)
                                                        r6 = r30[r46]
                                                        r34 = 17774062379092
                                                        r14 = "\027\205\232uK$\180\142\014CpG`I\134\135\162{yJ\145 \025\rv\2479f\tx'\198\154`\252\198B\171"
                                                        r38 = r9(r14, r34)
                                                        r46 = r30[r38]
                                                        r17 = 2
                                                        r51 = 5
                                                        r16 = {
                                                            [r44] = r17,
                                                            [r1] = r51,
                                                            [r12] = r42,
                                                            [r6] = r46
                                                        }
                                                        r43 = {
                                                            r16
                                                        }
                                                        r28 = 1
                                                        r23 = {
                                                            [r10] = r28,
                                                            [r7] = r43
                                                        }
                                                        r41 = {
                                                            r23
                                                        }
                                                        r47 = {
                                                            [r20] = r11,
                                                            [r45] = r3,
                                                            [r52] = r35,
                                                            [r27] = r41
                                                        }
                                                        r3 = "\167=(\182'\031<\250E`\212|"
                                                        r52 = 3390694458922
                                                        r45 = r9(r3, r52)
                                                        r11 = r30[r45]
                                                        r52 = "\160\006\143\001=,\145\155C\203\208\147\011\159\255\157"
                                                        r35 = 30039490918052
                                                        r3 = r9(r52, r35)
                                                        r45 = r30[r3]
                                                        r20 = {
                                                            [r11] = r45
                                                        }
                                                        r11 = "JSONEncode"
                                                        r11 = r15[r11]
                                                        r11 = r11(r15, r47)
                                                        r3 = state
                                                        r35 = "http_request"
                                                        r52 = _env[r35]
                                                        state = r52 and (32) or (33)
                                                        r45 = r52
                                                    end
                                                end
                                            else
                                                if state <= 32 then
                                                    if state == 32 then
                                                        state = r3
                                                        state = r45 and (34) or (35)
                                                    end
                                                else
                                                    if state == 33 then
                                                        r35 = state
                                                        r41 = "request"
                                                        r27 = _env[r41]
                                                        state = r27 and (36) or (37)
                                                        r52 = r27
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 39 then
                                            if state <= 36 then
                                                if state <= 35 then
                                                    if state <= 34 then
                                                        if state == 34 then
                                                            r41 = "\151\021\n"
                                                            r23 = 7817357397560
                                                            r27 = r9(r41, r23)
                                                            r35 = r30[r27]
                                                            r10 = 55798988825
                                                            r23 = "\239\141\146\164\028\164"
                                                            r41 = r9(r23, r10)
                                                            r27 = r30[r41]
                                                            r28 = 26080667332464
                                                            r10 = "\150\157\212/"
                                                            r23 = r9(r10, r28)
                                                            r41 = r30[r23]
                                                            r7 = 7493719625121
                                                            r28 = "^\196*\208'2\007"
                                                            r10 = r9(r28, r7)
                                                            r23 = r30[r10]
                                                            r7 = "n]\244]"
                                                            r43 = 33447685536983
                                                            r28 = r9(r7, r43)
                                                            r10 = r30[r28]
                                                            r52 = {
                                                                [r35] = r31,
                                                                [r27] = r41,
                                                                [r23] = r20,
                                                                [r10] = r11
                                                            }
                                                            r3 = r45(r52)
                                                            state = 38
                                                        end
                                                    else
                                                        if state == 35 then
                                                            r52 = "warn"
                                                            r3 = _env[r52]
                                                            r23 = 32173677050502
                                                            r41 = "\t\214o6\220\250\006\1571\146|3\220\165D\254\167\145e\130\207\237\249\180\143'\199\183_\235\165\015\228\251\140^\245\229a"
                                                            r27 = r9(r41, r23)
                                                            r35 = r30[r27]
                                                            r52 = r3(r35)
                                                            state = 38
                                                        end
                                                    end
                                                else
                                                    if state == 36 then
                                                        state = r35
                                                        r45 = r52
                                                        state = 32
                                                    end
                                                end
                                            else
                                                if state <= 38 then
                                                    if state <= 37 then
                                                        if state == 37 then
                                                            r7 = "syn"
                                                            r28 = _env[r7]
                                                            r10 = state
                                                            r41 = state
                                                            state = r28 and (39) or (40)
                                                            r23 = r28
                                                        end
                                                    else
                                                        if state == 38 then
                                                            r9 = nil
                                                            r4 = nil
                                                            r45 = nil
                                                            r30 = nil
                                                            r37 = nil
                                                            r31 = nil
                                                            r29 = nil
                                                            r20 = nil
                                                            r26 = nil
                                                            r36 = nil
                                                            r32 = nil
                                                            r47 = nil
                                                            r19 = nil
                                                            r11 = nil
                                                            r39 = nil
                                                            r15 = nil
                                                            r13 = nil
                                                            r48 = nil
                                                            ReturnVal = {}
                                                            state = nil
                                                        end
                                                    end
                                                else
                                                    if state == 39 then
                                                        r43 = "syn"
                                                        r7 = _env[r43]
                                                        r44 = "c\211+\224x\255\155"
                                                        r17 = 23783004351298
                                                        r16 = r9(r44, r17)
                                                        r43 = r30[r16]
                                                        r28 = r7[r43]
                                                        r23 = r28
                                                        state = 40
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 42 then
                                                if state <= 41 then
                                                    if state <= 40 then
                                                        if state == 40 then
                                                            state = r10
                                                            state = r23 and (41) or (42)
                                                            r27 = r23
                                                        end
                                                    else
                                                        if state == 41 then
                                                            state = r41
                                                            r52 = r27
                                                            state = 36
                                                        end
                                                    end
                                                else
                                                    if state == 42 then
                                                        r7 = "fluxus"
                                                        r28 = _env[r7]
                                                        r10 = state
                                                        state = r28 and (43) or (44)
                                                        r23 = r28
                                                    end
                                                end
                                            else
                                                if state <= 43 then
                                                    if state == 43 then
                                                        r43 = "fluxus"
                                                        r7 = _env[r43]
                                                        r44 = "Z\245\011\245e\241."
                                                        r17 = 23576138328802
                                                        r16 = r9(r44, r17)
                                                        r43 = r30[r16]
                                                        r28 = r7[r43]
                                                        r23 = r28
                                                        state = 44
                                                    end
                                                else
                                                    if state == 44 then
                                                        state = r10
                                                        r27 = r23
                                                        state = 41
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                -- createClosure3 entry 4946036 -> 45, states 45-45
                                if state == 45 then -- entry 4946036 -> 45
                                    state = true
                                    upvalueValues[upvalues[1]] = state
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        else
                            -- createClosure1 entry 10767988 -> 46, states 46-46
                            if state == 46 then -- entry 10767988 -> 46
                                ReturnVal = "error"
                                state = _env[ReturnVal]
                                r21 = "Tamper Detected!"
                                ReturnVal = state(r21)
                                ReturnVal = {}
                                state = nil
                            end
                        end
                    else
                        if state <= 47 then
                            -- createClosure4 entry 11739306 -> 47, states 47-47
                            if state == 47 then -- entry 11739306 -> 47
                                r9 = "W4Qr3z9hMVvo6Nv"
                                r30 = 2828187
                                r21 = r9 ^ r30
                                ReturnVal = 11619339
                                state = ReturnVal - r21
                                r21 = state
                                ReturnVal = "2jcI6PIHV"
                                state = ReturnVal / r21
                                ReturnVal = {
                                    state
                                }
                                state = nil
                            end
                        else
                            -- createClosure0 entry 8568441 -> 48, states 48-59
                            if state <= 53 then
                                if state <= 50 then
                                    if state <= 49 then
                                        if state <= 48 then
                                            if state == 48 then -- entry 8568441 -> 48
                                                r9 = upvalueValues[upvalues[1]]
                                                r31 = 1
                                                r39 = 2
                                                r30 = r9(r31, r39)
                                                r9 = 1
                                                r21 = r30 == r9
                                                state = r21 and (49) or (50)
                                                ReturnVal = r21
                                            end
                                        else
                                            if state == 49 then
                                                state = ReturnVal and (51) or (52)
                                            end
                                        end
                                    else
                                        if state == 50 then
                                            r9 = upvalueValues[upvalues[2]]
                                            r30 = upvalueValues[upvalues[3]]
                                            r21 = r9 == r30
                                            ReturnVal = r21
                                            state = 49
                                        end
                                    end
                                else
                                    if state <= 52 then
                                        if state <= 51 then
                                            if state == 51 then
                                                r29 = createClosure1(77, {})
                                                ReturnVal = "tonumber"
                                                state = _env[ReturnVal]
                                                r21 = upvalueValues[upvalues[4]]
                                                r31 = "tostring"
                                                r30 = _env[r31]
                                                r13 = "pcall"
                                                r19 = _env[r13]
                                                r13 = {
                                                    r19(r29)
                                                }
                                                r15 = {
                                                    unpack(r13)
                                                }
                                                r19 = 2
                                                r39 = r15[r19]
                                                r31 = r30(r39)
                                                r30 = ":(%d*):"
                                                r9 = r21(r31, r30)
                                                r21 = {
                                                    r9()
                                                }
                                                ReturnVal = state(unpack(r21))
                                                r21 = ReturnVal
                                                r9 = upvalueValues[upvalues[5]]
                                                state = r9 and (53) or (54)
                                                ReturnVal = r9
                                            end
                                        else
                                            if state == 52 then
                                                state = upvalueValues[upvalues[7]]
                                                state = state and (55) or (56)
                                            end
                                        end
                                    else
                                        if state == 53 then
                                            r30 = upvalueValues[upvalues[6]]
                                            r9 = r30 == r21
                                            ReturnVal = r9
                                            state = 54
                                        end
                                    end
                                end
                            else
                                if state <= 56 then
                                    if state <= 55 then
                                        if state <= 54 then
                                            if state == 54 then
                                                r21 = nil
                                                upvalueValues[upvalues[5]] = ReturnVal
                                                state = 52
                                            end
                                        else
                                            if state == 55 then
                                                r21 = "error"
                                                state = _env[r21]
                                                r9 = upvalueValues[upvalues[8]]
                                                r30 = 0
                                                r21 = state(r9, r30)
                                                state = 56
                                            end
                                        end
                                    else
                                        if state == 56 then
                                            r30 = upvalueValues[upvalues[9]]
                                            r31 = r30
                                            state = {}
                                            r21 = state
                                            r30 = 1
                                            r39 = r30
                                            r30 = 0
                                            r15 = r39 < r30
                                            r9 = 1
                                            r30 = r9 - r39
                                            state = 57
                                        end
                                    end
                                else
                                    if state <= 58 then
                                        if state <= 57 then
                                            if state == 57 then
                                                r19 = not r15
                                                r30 = r30 + r39
                                                r9 = r30 <= r31
                                                r9 = r19 and r9
                                                r19 = r30 >= r31
                                                r19 = r15 and r19
                                                r9 = r19 or r9
                                                r19 = (58)
                                                state = r9 and r19
                                                r9 = (59)
                                                state = state or r9
                                            end
                                        else
                                            if state == 58 then
                                                r9 = r30
                                                state = upvalueValues[upvalues[1]]
                                                r29 = 255
                                                r13 = 0
                                                r19 = state(r13, r29)
                                                r21[r9] = r19
                                                r9 = nil
                                                state = 57
                                            end
                                        end
                                    else
                                        if state == 59 then
                                            state = upvalueValues[upvalues[10]]
                                            r9 = upvalueValues[upvalues[11]]
                                            r21[state] = r9
                                            state = upvalueValues[upvalues[12]]
                                            r9 = {
                                                state(r21)
                                            }
                                            ReturnVal = {
                                                unpack(r9)
                                            }
                                            state = nil
                                        end
                                    end
                                end
                            end
                        end
                    end
                else
                    if state <= 69 then
                        if state <= 63 then
                            -- createClosure1 entry 151965 -> 60, states 60-63
                            if state <= 61 then
                                if state <= 60 then
                                    if state == 60 then -- entry 151965 -> 60
                                        state = 61
                                    end
                                else
                                    if state == 61 then
                                        state = true
                                        state = state and (62) or (63)
                                    end
                                end
                            else
                                if state <= 62 then
                                    if state == 62 then
                                        ReturnVal = "l2"
                                        state = _env[ReturnVal]
                                        r21 = "l1"
                                        ReturnVal = _env[r21]
                                        r21 = "l1"
                                        _env[r21] = state
                                        r21 = "l2"
                                        _env[r21] = ReturnVal
                                        r21 = upvalueValues[upvalues[1]]
                                        r9 = r21()
                                        state = 61
                                    end
                                else
                                    if state == 63 then
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            end
                        else
                            -- createClosure5 entry 4024502 -> 64, states 64-69
                            if state <= 66 then
                                if state <= 65 then
                                    if state <= 64 then
                                        if state == 64 then -- entry 4024502 -> 64
                                            r21 = upvalueValues[upvalues[1]]
                                            ReturnVal = #r21
                                            r21 = 0
                                            state = ReturnVal == r21
                                            state = state and (65) or (66)
                                        end
                                    else
                                        if state == 65 then
                                            r9 = upvalueValues[upvalues[2]]
                                            r30 = 85
                                            r21 = r9 * r30
                                            r9 = 6468609395651
                                            ReturnVal = r21 + r9
                                            r21 = 35184372088832
                                            state = ReturnVal % r21
                                            upvalueValues[upvalues[2]] = state
                                            r21 = upvalueValues[upvalues[3]]
                                            r9 = 1
                                            ReturnVal = r21 ~= r9
                                            state = 67
                                        end
                                    end
                                else
                                    if state == 66 then
                                        r30 = "table"
                                        r9 = _env[r30]
                                        r30 = "remove"
                                        r21 = r9[r30]
                                        r30 = upvalueValues[upvalues[1]]
                                        r9 = {
                                            r21(r30)
                                        }
                                        ReturnVal = {
                                            unpack(r9)
                                        }
                                        state = nil
                                    end
                                end
                            else
                                if state <= 68 then
                                    if state <= 67 then
                                        if state == 67 then
                                            r9 = upvalueValues[upvalues[3]]
                                            r30 = 206
                                            r21 = r9 * r30
                                            r9 = 257
                                            ReturnVal = r21 % r9
                                            upvalueValues[upvalues[3]] = ReturnVal
                                            state = 68
                                        end
                                    else
                                        if state == 68 then
                                            r9 = upvalueValues[upvalues[3]]
                                            r30 = 1
                                            r21 = r9 ~= r30
                                            state = r21 and (69) or (67)
                                        end
                                    end
                                else
                                    if state == 69 then
                                        r30 = 32
                                        r9 = upvalueValues[upvalues[3]]
                                        r21 = r9 % r30
                                        r29 = 2
                                        r31 = upvalueValues[upvalues[4]]
                                        r19 = upvalueValues[upvalues[2]]
                                        r48 = upvalueValues[upvalues[3]]
                                        r36 = r48 - r21
                                        r48 = 32
                                        r32 = r36 / r48
                                        r37 = 13
                                        r26 = r37 - r32
                                        r13 = r29 ^ r26
                                        r15 = r19 / r13
                                        r39 = r31(r15)
                                        r31 = 4294967296
                                        r30 = r39 % r31
                                        r39 = 2
                                        r31 = r39 ^ r21
                                        r9 = r30 / r31
                                        r31 = upvalueValues[upvalues[4]]
                                        r13 = 1
                                        r19 = r9 % r13
                                        r13 = 4294967296
                                        r15 = r19 * r13
                                        r19 = 65536
                                        r39 = r31(r15)
                                        r31 = upvalueValues[upvalues[4]]
                                        r15 = r31(r9)
                                        r30 = r39 + r15
                                        r39 = 65536
                                        r31 = r30 % r39
                                        r37 = 256
                                        r9 = nil
                                        r15 = r30 - r31
                                        r39 = r15 / r19
                                        r19 = 256
                                        r29 = 256
                                        r15 = r31 % r19
                                        r13 = r31 - r15
                                        r19 = r13 / r29
                                        r31 = nil
                                        r21 = nil
                                        r30 = nil
                                        r29 = 256
                                        r13 = r39 % r29
                                        r26 = r39 - r13
                                        r29 = r26 / r37
                                        r26 = {
                                            r15,
                                            r19,
                                            r13,
                                            r29
                                        }
                                        r29 = nil
                                        r19 = nil
                                        r15 = nil
                                        r13 = nil
                                        r39 = nil
                                        upvalueValues[upvalues[1]] = r26
                                        state = 66
                                    end
                                end
                            end
                        end
                    else
                        if state <= 76 then
                            -- createClosure3 entry 2399885 -> 70, states 70-76
                            if state <= 73 then
                                if state <= 71 then
                                    if state <= 70 then
                                        if state == 70 then -- entry 2399885 -> 70
                                            state = upvalueValues[upvalues[1]]
                                            r30 = state
                                            r21 = args[1]
                                            r9 = args[2]
                                            state = r30[r9]
                                            state = state and (71) or (72)
                                        end
                                    else
                                        if state == 71 then
                                            state = 73
                                        end
                                    end
                                else
                                    if state <= 72 then
                                        if state == 72 then
                                            state = {}
                                            upvalueValues[upvalues[2]] = state
                                            ReturnVal = upvalueValues[upvalues[3]]
                                            r31 = ReturnVal
                                            r39 = 35184372088832
                                            ReturnVal = r9 % r39
                                            upvalueValues[upvalues[4]] = ReturnVal
                                            r19 = 255
                                            r15 = r9 % r19
                                            r19 = 2
                                            r39 = r15 + r19
                                            upvalueValues[upvalues[5]] = r39
                                            r13 = "string"
                                            r19 = _env[r13]
                                            r13 = "len"
                                            r15 = r19[r13]
                                            r19 = r15(r21)
                                            r15 = ""
                                            r30[r9] = r15
                                            r26 = 1
                                            r37 = r26
                                            r26 = 0
                                            r32 = r37 < r26
                                            r13 = 1
                                            r26 = r13 - r37
                                            r29 = r19
                                            r15 = 149
                                            state = 74
                                        end
                                    else
                                        if state == 73 then
                                            ReturnVal = {
                                                r9
                                            }
                                            state = nil
                                        end
                                    end
                                end
                            else
                                if state <= 75 then
                                    if state <= 74 then
                                        if state == 74 then
                                            r36 = not r32
                                            r26 = r26 + r37
                                            r13 = r26 <= r29
                                            r13 = r36 and r13
                                            r36 = r26 >= r29
                                            r36 = r32 and r36
                                            r13 = r36 or r13
                                            r36 = (75)
                                            state = r13 and r36
                                            r13 = (76)
                                            state = state or r13
                                        end
                                    else
                                        if state == 75 then
                                            r13 = r26
                                            r33 = "string"
                                            r2 = _env[r33]
                                            r33 = "byte"
                                            r8 = r2[r33]
                                            r2 = r8(r21, r13)
                                            r8 = upvalueValues[upvalues[6]]
                                            r33 = r8()
                                            r4 = r2 + r33
                                            r48 = r4 + r15
                                            r4 = 256
                                            r36 = r48 % r4
                                            r15 = r36
                                            r4 = r30[r9]
                                            r33 = 1
                                            r2 = r15 + r33
                                            r8 = r31[r2]
                                            r13 = nil
                                            r48 = r4 .. r8
                                            r30[r9] = r48
                                            state = 74
                                        end
                                    end
                                else
                                    if state == 76 then
                                        r31 = nil
                                        r15 = nil
                                        r19 = nil
                                        state = 73
                                    end
                                end
                            end
                        else
                            -- createClosure1 entry 15730111 -> 77, states 77-77
                            if state == 77 then -- entry 15730111 -> 77
                                r30 = 3697000
                                r9 = "KsIoy9d8la"
                                r21 = r9 ^ r30
                                ReturnVal = 8359969
                                state = ReturnVal - r21
                                r21 = state
                                ReturnVal = "7Ak"
                                state = ReturnVal / r21
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
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = upvalueRefCounts[captures[captureIndex]] + (1)
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return 3124327
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 3124327
                    end
                })
            end
        end
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if 0 == upvalueRefCounts[upvalueId] then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
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
        currentUpvalueId = 0
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
        createClosure0 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function()
                return vm(entryId, {}, captures, gcProxy)
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
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)