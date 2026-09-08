return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, createClosure1, vm, releaseUpvalue, allocUpvalue, currentUpvalueId, upvalueValues, upvalueRefCounts, createClosure5, createUpvalueProxy, createClosure6, createClosure4, createClosure2, createClosure0, releaseUpvalues, createClosure, createClosure3)
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
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, ReturnVal, r25, r26, r27, r28, r29, r30, r31, r32, r33
            while state do
                if state <= 95 then
                    if state <= 63 then
                        if state <= 34 then
                            if state <= 32 then
                                if state <= 31 then
                                    -- root entry 4147945 -> 1, states 1-31
                                    if state <= 16 then
                                        if state <= 8 then
                                            if state <= 4 then
                                                if state <= 2 then
                                                    if state <= 1 then
                                                        if state == 1 then -- entry 4147945 -> 1
                                                            r17 = allocUpvalue()
                                                            r2 = allocUpvalue()
                                                            state = true
                                                            upvalueValues[r2] = state
                                                            r33 = "string"
                                                            ReturnVal = _env[r33]
                                                            r27 = allocUpvalue()
                                                            r33 = "gmatch"
                                                            state = ReturnVal[r33]
                                                            r33 = allocUpvalue()
                                                            upvalueValues[r33] = state
                                                            state = createClosure3(32, {})
                                                            upvalueValues[r17] = state
                                                            state = false
                                                            upvalueValues[r27] = state
                                                            r24 = createClosure4(33, {
                                                                r27
                                                            })
                                                            r22 = "pcall"
                                                            r10 = _env[r22]
                                                            r22 = r10(r24)
                                                            state = r22 and (2) or (3)
                                                            ReturnVal = r22
                                                            r9 = args
                                                        end
                                                    else
                                                        if state == 2 then
                                                            r10 = upvalueValues[r27]
                                                            ReturnVal = r10
                                                            state = 3
                                                        end
                                                    end
                                                else
                                                    if state <= 3 then
                                                        if state == 3 then
                                                            r10 = ReturnVal
                                                            r22 = "math"
                                                            ReturnVal = _env[r22]
                                                            r22 = "random"
                                                            state = ReturnVal[r22]
                                                            r22 = allocUpvalue()
                                                            upvalueValues[r22] = state
                                                            r24 = "table"
                                                            ReturnVal = _env[r24]
                                                            r24 = "concat"
                                                            state = ReturnVal[r24]
                                                            r19 = state
                                                            r24 = state
                                                            r1 = "table"
                                                            r11 = _env[r1]
                                                            state = r11 and (4) or (5)
                                                            r20 = r11
                                                        end
                                                    else
                                                        if state == 4 then
                                                            r18 = "table"
                                                            r1 = _env[r18]
                                                            r18 = "unpack"
                                                            r11 = r1[r18]
                                                            r20 = r11
                                                            state = 5
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 6 then
                                                    if state <= 5 then
                                                        if state == 5 then
                                                            state = r19
                                                            state = r20 and (6) or (7)
                                                            ReturnVal = r20
                                                        end
                                                    else
                                                        if state == 6 then
                                                            r20 = allocUpvalue()
                                                            upvalueValues[r20] = ReturnVal
                                                            state = upvalueValues[r22]
                                                            r19 = 3
                                                            r11 = 65
                                                            ReturnVal = state(r19, r11)
                                                            r19 = allocUpvalue()
                                                            state = 0
                                                            r3 = createClosure5(34, {})
                                                            upvalueValues[r19] = ReturnVal
                                                            r11 = state
                                                            r18 = "pcall"
                                                            ReturnVal = _env[r18]
                                                            state = 0
                                                            r18 = {
                                                                ReturnVal(r3)
                                                            }
                                                            r1 = state
                                                            state = {
                                                                unpack(r18)
                                                            }
                                                            r18 = state
                                                            ReturnVal = 2
                                                            state = r18[ReturnVal]
                                                            r3 = state
                                                            ReturnVal = "tonumber"
                                                            state = _env[ReturnVal]
                                                            r12 = upvalueValues[r33]
                                                            r14 = "tostring"
                                                            r4 = _env[r14]
                                                            r14 = r4(r3)
                                                            r4 = ":(%d*):"
                                                            r28 = r12(r14, r4)
                                                            r12 = {
                                                                r28()
                                                            }
                                                            ReturnVal = state(unpack(r12))
                                                            r12 = allocUpvalue()
                                                            upvalueValues[r12] = ReturnVal
                                                            r28 = upvalueValues[r19]
                                                            r4 = r28
                                                            r28 = 1
                                                            r14 = r28
                                                            r28 = 0
                                                            r31 = r14 < r28
                                                            ReturnVal = 1
                                                            r28 = ReturnVal - r14
                                                            state = 8
                                                        end
                                                    end
                                                else
                                                    if state <= 7 then
                                                        if state == 7 then
                                                            r19 = "unpack"
                                                            r20 = _env[r19]
                                                            ReturnVal = r20
                                                            state = 6
                                                        end
                                                    else
                                                        if state == 8 then
                                                            r28 = r28 + r14
                                                            ReturnVal = r28 <= r4
                                                            r25 = not r31
                                                            ReturnVal = r25 and ReturnVal
                                                            r25 = r28 >= r4
                                                            r25 = r31 and r25
                                                            ReturnVal = r25 or ReturnVal
                                                            r25 = (9)
                                                            state = ReturnVal and r25
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
                                                            r25 = allocUpvalue()
                                                            upvalueValues[r25] = r28
                                                            r26 = "math"
                                                            ReturnVal = _env[r26]
                                                            r26 = "random"
                                                            state = ReturnVal[r26]
                                                            r13 = 100
                                                            r26 = 1
                                                            ReturnVal = state(r26, r13)
                                                            r26 = allocUpvalue()
                                                            upvalueValues[r26] = ReturnVal
                                                            state = upvalueValues[r22]
                                                            r30 = 255
                                                            r13 = 0
                                                            ReturnVal = state(r13, r30)
                                                            r13 = allocUpvalue()
                                                            upvalueValues[r13] = ReturnVal
                                                            state = upvalueValues[r22]
                                                            r32 = upvalueValues[r26]
                                                            r30 = 1
                                                            ReturnVal = state(r30, r32)
                                                            r30 = allocUpvalue()
                                                            upvalueValues[r30] = ReturnVal
                                                            ReturnVal = upvalueValues[r22]
                                                            r29 = 1
                                                            r15 = 2
                                                            r32 = ReturnVal(r29, r15)
                                                            ReturnVal = 1
                                                            state = r32 == ReturnVal
                                                            r32 = allocUpvalue()
                                                            upvalueValues[r32] = state
                                                            r23 = "tostring"
                                                            r5 = _env[r23]
                                                            r6 = upvalueValues[r22]
                                                            state = "gsub"
                                                            state = r3[state]
                                                            r7 = 10000
                                                            r21 = 0
                                                            r16 = {
                                                                r6(r21, r7)
                                                            }
                                                            r23 = r5(unpack(r16))
                                                            r5 = ":"
                                                            r8 = r23 .. r5
                                                            r15 = ":"
                                                            r29 = r15 .. r8
                                                            ReturnVal = ":(%d*):"
                                                            state = state(r3, ReturnVal, r29)
                                                            r29 = allocUpvalue()
                                                            upvalueValues[r29] = state
                                                            r15 = "pcall"
                                                            ReturnVal = _env[r15]
                                                            r8 = createClosure4(35, {
                                                                r22,
                                                                r25,
                                                                r19,
                                                                r33,
                                                                r2,
                                                                r12,
                                                                r32,
                                                                r29,
                                                                r26,
                                                                r30,
                                                                r13,
                                                                r20
                                                            })
                                                            r15 = {
                                                                ReturnVal(r8)
                                                            }
                                                            state = {
                                                                unpack(r15)
                                                            }
                                                            r15 = state
                                                            state = upvalueValues[r32]
                                                            state = state and (11) or (12)
                                                        end
                                                    else
                                                        if state == 10 then
                                                            r4 = upvalueValues[r2]
                                                            state = r4 and (13) or (14)
                                                            r28 = r4
                                                        end
                                                    end
                                                else
                                                    if state <= 11 then
                                                        if state == 11 then
                                                            r8 = upvalueValues[r2]
                                                            state = r8 and (15) or (16)
                                                            ReturnVal = r8
                                                        end
                                                    else
                                                        if state == 12 then
                                                            r5 = upvalueValues[r2]
                                                            state = r5 and (17) or (18)
                                                            r8 = r5
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 14 then
                                                    if state <= 13 then
                                                        if state == 13 then
                                                            r4 = r11 == r1
                                                            r28 = r4
                                                            state = 14
                                                        end
                                                    else
                                                        if state == 14 then
                                                            upvalueValues[r2] = r28
                                                            state = upvalueValues[r2]
                                                            state = state and (19) or (20)
                                                        end
                                                    end
                                                else
                                                    if state <= 15 then
                                                        if state == 15 then
                                                            r5 = state
                                                            r16 = 1
                                                            r6 = r15[r16]
                                                            r16 = false
                                                            r23 = r6 == r16
                                                            state = r23 and (21) or (22)
                                                            r8 = r23
                                                        end
                                                    else
                                                        if state == 16 then
                                                            upvalueValues[r2] = ReturnVal
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
                                                            r23 = 1
                                                            r5 = r15[r23]
                                                            r8 = r5
                                                            state = 18
                                                        end
                                                    else
                                                        if state == 18 then
                                                            upvalueValues[r2] = r8
                                                            r16 = upvalueValues[r30]
                                                            r21 = 1
                                                            r6 = r16 + r21
                                                            r23 = r15[r6]
                                                            r5 = r11 + r23
                                                            r23 = 256
                                                            state = r5 % r23
                                                            r11 = state
                                                            r6 = upvalueValues[r13]
                                                            r23 = r1 + r6
                                                            r6 = 256
                                                            r5 = r23 % r6
                                                            r1 = r5
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
                                                            r16 = 2
                                                            r6 = r15[r16]
                                                            r16 = upvalueValues[r29]
                                                            r23 = r6 == r16
                                                            r8 = r23
                                                            state = 22
                                                        end
                                                    else
                                                        if state == 22 then
                                                            state = r5
                                                            ReturnVal = r8
                                                            state = 16
                                                        end
                                                    end
                                                else
                                                    if state <= 23 then
                                                        if state == 23 then
                                                            r32 = releaseUpvalue(r32)
                                                            r26 = releaseUpvalue(r26)
                                                            r30 = releaseUpvalue(r30)
                                                            r25 = releaseUpvalue(r25)
                                                            r13 = releaseUpvalue(r13)
                                                            r29 = releaseUpvalue(r29)
                                                            r15 = nil
                                                            state = 8
                                                        end
                                                    else
                                                        if state == 24 then
                                                            r27 = releaseUpvalue(r27)
                                                            r33 = releaseUpvalue(r33)
                                                            r19 = releaseUpvalue(r19)
                                                            r22 = releaseUpvalue(r22)
                                                            r20 = releaseUpvalue(r20)
                                                            r17 = releaseUpvalue(r17)
                                                            r12 = releaseUpvalue(r12)
                                                            r17 = allocUpvalue()
                                                            r2 = releaseUpvalue(r2)
                                                            r2 = nil
                                                            upvalueValues[r17] = r2
                                                            r19 = allocUpvalue()
                                                            r2 = allocUpvalue()
                                                            r33 = nil
                                                            upvalueValues[r2] = r33
                                                            r10 = nil
                                                            r10 = "math"
                                                            r27 = _env[r10]
                                                            r10 = "floor"
                                                            r33 = r27[r10]
                                                            r27 = allocUpvalue()
                                                            upvalueValues[r27] = r33
                                                            r22 = "math"
                                                            r10 = _env[r22]
                                                            r22 = "random"
                                                            r33 = r10[r22]
                                                            r18 = nil
                                                            r18 = {}
                                                            r1 = nil
                                                            r1 = allocUpvalue()
                                                            r24 = nil
                                                            r24 = "table"
                                                            r22 = _env[r24]
                                                            r24 = "remove"
                                                            r10 = r22[r24]
                                                            r20 = "string"
                                                            r24 = _env[r20]
                                                            r20 = "char"
                                                            r22 = r24[r20]
                                                            r20 = allocUpvalue()
                                                            r11 = nil
                                                            r11 = {}
                                                            r12 = 256
                                                            r24 = 0
                                                            upvalueValues[r20] = r24
                                                            r24 = 2
                                                            upvalueValues[r19] = r24
                                                            r31 = r12
                                                            r24 = {}
                                                            r12 = 1
                                                            upvalueValues[r1] = r11
                                                            r25 = r12
                                                            r12 = 0
                                                            r26 = r25 < r12
                                                            r3 = nil
                                                            r3 = 1
                                                            r12 = r3 - r25
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
                                                            state = createClosure0(47, {
                                                                r17
                                                            })
                                                            r4 = {
                                                                state()
                                                            }
                                                            ReturnVal = {
                                                                unpack(r4)
                                                            }
                                                            state = nil
                                                        end
                                                    else
                                                        if state == 26 then
                                                            r13 = not r26
                                                            r12 = r12 + r25
                                                            r3 = r12 <= r31
                                                            r3 = r13 and r3
                                                            r13 = r12 >= r31
                                                            r13 = r26 and r13
                                                            r3 = r13 or r3
                                                            r13 = (27)
                                                            state = r3 and r13
                                                            r3 = (28)
                                                            state = state or r3
                                                        end
                                                    end
                                                else
                                                    if state <= 27 then
                                                        if state == 27 then
                                                            r3 = r12
                                                            r13 = r3
                                                            r18[r3] = r13
                                                            r3 = nil
                                                            state = 26
                                                        end
                                                    else
                                                        if state == 28 then
                                                            r12 = #r18
                                                            r31 = 0
                                                            r3 = r12 == r31
                                                            state = 29
                                                        end
                                                    end
                                                end
                                            else
                                                if state <= 30 then
                                                    if state <= 29 then
                                                        if state == 29 then
                                                            r12 = 1
                                                            r31 = #r18
                                                            r3 = r33(r12, r31)
                                                            r12 = r10(r18, r3)
                                                            r13 = 1
                                                            r31 = upvalueValues[r1]
                                                            r3 = nil
                                                            r26 = r12 - r13
                                                            r25 = r22(r26)
                                                            r31[r12] = r25
                                                            r12 = nil
                                                            state = 30
                                                        end
                                                    else
                                                        if state == 30 then
                                                            r12 = #r18
                                                            r31 = 0
                                                            r3 = r12 == r31
                                                            state = r3 and (31) or (29)
                                                        end
                                                    end
                                                else
                                                    if state == 31 then
                                                        r3 = {}
                                                        r12 = allocUpvalue()
                                                        upvalueValues[r12] = r3
                                                        r3 = allocUpvalue()
                                                        r13 = {}
                                                        r25 = allocUpvalue()
                                                        r31 = createClosure2(51, {
                                                            r12,
                                                            r20,
                                                            r19,
                                                            r27
                                                        })
                                                        upvalueValues[r3] = r31
                                                        r27 = releaseUpvalue(r27)
                                                        r31 = {}
                                                        upvalueValues[r25] = r31
                                                        r26 = "setmetatable"
                                                        r31 = _env[r26]
                                                        r29 = upvalueValues[r25]
                                                        r15 = "__metatable"
                                                        r32 = "__index"
                                                        r23 = nil
                                                        r30 = {
                                                            [r32] = r29,
                                                            [r15] = r23
                                                        }
                                                        r26 = r31(r13, r30)
                                                        r31 = createClosure4(57, {
                                                            r25,
                                                            r12,
                                                            r1,
                                                            r20,
                                                            r19,
                                                            r3
                                                        })
                                                        r20 = releaseUpvalue(r20)
                                                        r3 = releaseUpvalue(r3)
                                                        upvalueValues[r17] = r26
                                                        r25 = releaseUpvalue(r25)
                                                        r19 = releaseUpvalue(r19)
                                                        r12 = releaseUpvalue(r12)
                                                        upvalueValues[r2] = r31
                                                        r13 = 5923556739782
                                                        r22 = nil
                                                        r22 = "game"
                                                        r10 = nil
                                                        r10 = _env[r22]
                                                        r24 = nil
                                                        r24 = upvalueValues[r17]
                                                        r20 = upvalueValues[r2]
                                                        r1 = releaseUpvalue(r1)
                                                        r11 = nil
                                                        r11 = "\004a>\237)\248\211"
                                                        r1 = 23987894217634
                                                        r19 = r20(r11, r1)
                                                        r22 = r24[r19]
                                                        r27 = r10[r22]
                                                        r22 = upvalueValues[r17]
                                                        r19 = "\157D3\183\000\022\195|\225\240\186"
                                                        r24 = upvalueValues[r2]
                                                        r11 = 10805228491687
                                                        r20 = r24(r19, r11)
                                                        r10 = r22[r20]
                                                        r33 = nil
                                                        r33 = r27[r10]
                                                        r27 = allocUpvalue()
                                                        upvalueValues[r27] = r33
                                                        r10 = "game"
                                                        r33 = _env[r10]
                                                        r24 = upvalueValues[r17]
                                                        r20 = upvalueValues[r2]
                                                        r1 = 11445108397265
                                                        r11 = "}\018\231|\204\208\210\238\152C\253["
                                                        r19 = r20(r11, r1)
                                                        r22 = r24[r19]
                                                        r10 = "GetService"
                                                        r10 = r33[r10]
                                                        r10 = r10(r33, r22)
                                                        r22 = allocUpvalue()
                                                        r33 = allocUpvalue()
                                                        upvalueValues[r33] = r10
                                                        r10 = false
                                                        upvalueValues[r22] = r10
                                                        r24 = allocUpvalue()
                                                        r10 = nil
                                                        upvalueValues[r24] = r10
                                                        ReturnVal = {}
                                                        r20 = upvalueValues[r17]
                                                        r19 = upvalueValues[r2]
                                                        r18 = nil
                                                        r18 = 7269032316216
                                                        r1 = "]\163\142p\245\219\216\148\170-\193\192^\248\nZJz023\011p7X"
                                                        r11 = r19(r1, r18)
                                                        r10 = r20[r11]
                                                        r20 = allocUpvalue()
                                                        upvalueValues[r20] = r10
                                                        r10 = allocUpvalue()
                                                        r19 = createClosure1(64, {
                                                            r27,
                                                            r17,
                                                            r2,
                                                            r20,
                                                            r22,
                                                            r33,
                                                            r24
                                                        })
                                                        upvalueValues[r10] = r19
                                                        r1 = "spawn"
                                                        r11 = _env[r1]
                                                        r19 = createClosure4(71, {
                                                            r27,
                                                            r17,
                                                            r2,
                                                            r20,
                                                            r10
                                                        })
                                                        r1 = r11(r19)
                                                        r20 = releaseUpvalue(r20)
                                                        r1 = upvalueValues[r27]
                                                        r25 = "\188\189{\249\217IA\165\2258\222\222\019R"
                                                        r19 = nil
                                                        r27 = releaseUpvalue(r27)
                                                        r10 = releaseUpvalue(r10)
                                                        r3 = upvalueValues[r17]
                                                        r12 = upvalueValues[r2]
                                                        r31 = r12(r25, r13)
                                                        r18 = r3[r31]
                                                        r11 = r1[r18]
                                                        r22 = releaseUpvalue(r22)
                                                        r18 = createClosure2(77, {})
                                                        r17 = releaseUpvalue(r17)
                                                        r1 = "Connect"
                                                        r1 = r11[r1]
                                                        r33 = releaseUpvalue(r33)
                                                        r1 = r1(r11, r18)
                                                        r2 = releaseUpvalue(r2)
                                                        r24 = releaseUpvalue(r24)
                                                        state = nil
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure3 entry 12194046 -> 32, states 32-32
                                    if state == 32 then -- entry 12194046 -> 32
                                        ReturnVal = "error"
                                        state = _env[ReturnVal]
                                        r9 = "Tamper Detected!"
                                        ReturnVal = state(r9)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            else
                                if state <= 33 then
                                    -- createClosure4 entry 7257165 -> 33, states 33-33
                                    if state == 33 then -- entry 7257165 -> 33
                                        state = true
                                        upvalueValues[upvalues[1]] = state
                                        ReturnVal = {}
                                        state = nil
                                    end
                                else
                                    -- createClosure5 entry 13233045 -> 34, states 34-34
                                    if state == 34 then -- entry 13233045 -> 34
                                        r33 = 4093279
                                        r2 = "4kfm7zbeA"
                                        r9 = r2 ^ r33
                                        ReturnVal = 1476029
                                        state = ReturnVal - r9
                                        r9 = state
                                        ReturnVal = "lnski7Go4KNbwKh"
                                        state = ReturnVal / r9
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
                                    -- createClosure4 entry 16754928 -> 35, states 35-46
                                    if state <= 40 then
                                        if state <= 37 then
                                            if state <= 36 then
                                                if state <= 35 then
                                                    if state == 35 then -- entry 16754928 -> 35
                                                        r2 = upvalueValues[upvalues[1]]
                                                        r27 = 2
                                                        r17 = 1
                                                        r33 = r2(r17, r27)
                                                        r2 = 1
                                                        r9 = r33 == r2
                                                        state = r9 and (36) or (37)
                                                        ReturnVal = r9
                                                    end
                                                else
                                                    if state == 36 then
                                                        state = ReturnVal and (38) or (39)
                                                    end
                                                end
                                            else
                                                if state == 37 then
                                                    r2 = upvalueValues[upvalues[2]]
                                                    r33 = upvalueValues[upvalues[3]]
                                                    r9 = r2 == r33
                                                    ReturnVal = r9
                                                    state = 36
                                                end
                                            end
                                        else
                                            if state <= 39 then
                                                if state <= 38 then
                                                    if state == 38 then
                                                        r20 = createClosure0(78, {})
                                                        ReturnVal = "tonumber"
                                                        state = _env[ReturnVal]
                                                        r9 = upvalueValues[upvalues[4]]
                                                        r17 = "tostring"
                                                        r33 = _env[r17]
                                                        r24 = "pcall"
                                                        r22 = _env[r24]
                                                        r24 = {
                                                            r22(r20)
                                                        }
                                                        r10 = {
                                                            unpack(r24)
                                                        }
                                                        r22 = 2
                                                        r27 = r10[r22]
                                                        r17 = r33(r27)
                                                        r33 = ":(%d*):"
                                                        r2 = r9(r17, r33)
                                                        r9 = {
                                                            r2()
                                                        }
                                                        ReturnVal = state(unpack(r9))
                                                        r9 = ReturnVal
                                                        r2 = upvalueValues[upvalues[5]]
                                                        state = r2 and (40) or (41)
                                                        ReturnVal = r2
                                                    end
                                                else
                                                    if state == 39 then
                                                        state = upvalueValues[upvalues[7]]
                                                        state = state and (42) or (43)
                                                    end
                                                end
                                            else
                                                if state == 40 then
                                                    r33 = upvalueValues[upvalues[6]]
                                                    r2 = r33 == r9
                                                    ReturnVal = r2
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
                                                        r9 = nil
                                                        state = 39
                                                    end
                                                else
                                                    if state == 42 then
                                                        r9 = "error"
                                                        state = _env[r9]
                                                        r2 = upvalueValues[upvalues[8]]
                                                        r33 = 0
                                                        r9 = state(r2, r33)
                                                        state = 43
                                                    end
                                                end
                                            else
                                                if state == 43 then
                                                    state = {}
                                                    r9 = state
                                                    r33 = upvalueValues[upvalues[9]]
                                                    r17 = r33
                                                    r33 = 1
                                                    r27 = r33
                                                    r33 = 0
                                                    r10 = r27 < r33
                                                    r2 = 1
                                                    r33 = r2 - r27
                                                    state = 44
                                                end
                                            end
                                        else
                                            if state <= 45 then
                                                if state <= 44 then
                                                    if state == 44 then
                                                        r22 = not r10
                                                        r33 = r33 + r27
                                                        r2 = r33 <= r17
                                                        r2 = r22 and r2
                                                        r22 = r33 >= r17
                                                        r22 = r10 and r22
                                                        r2 = r22 or r2
                                                        r22 = (45)
                                                        state = r2 and r22
                                                        r2 = (46)
                                                        state = state or r2
                                                    end
                                                else
                                                    if state == 45 then
                                                        r2 = r33
                                                        state = upvalueValues[upvalues[1]]
                                                        r24 = 0
                                                        r20 = 255
                                                        r22 = state(r24, r20)
                                                        r9[r2] = r22
                                                        r2 = nil
                                                        state = 44
                                                    end
                                                end
                                            else
                                                if state == 46 then
                                                    state = upvalueValues[upvalues[10]]
                                                    r2 = upvalueValues[upvalues[11]]
                                                    r9[state] = r2
                                                    state = upvalueValues[upvalues[12]]
                                                    r2 = {
                                                        state(r9)
                                                    }
                                                    ReturnVal = {
                                                        unpack(r2)
                                                    }
                                                    state = nil
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure0 entry 5529204 -> 47, states 47-50
                                    if state <= 48 then
                                        if state <= 47 then
                                            if state == 47 then -- entry 5529204 -> 47
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
                                                r9 = "l1"
                                                ReturnVal = _env[r9]
                                                r9 = "l1"
                                                _env[r9] = state
                                                r9 = "l2"
                                                _env[r9] = ReturnVal
                                                r9 = upvalueValues[upvalues[1]]
                                                r2 = r9()
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
                                if state <= 56 then
                                    -- createClosure2 entry 9501384 -> 51, states 51-56
                                    if state <= 53 then
                                        if state <= 52 then
                                            if state <= 51 then
                                                if state == 51 then -- entry 9501384 -> 51
                                                    r9 = upvalueValues[upvalues[1]]
                                                    ReturnVal = #r9
                                                    r9 = 0
                                                    state = ReturnVal == r9
                                                    state = state and (52) or (53)
                                                end
                                            else
                                                if state == 52 then
                                                    r2 = upvalueValues[upvalues[2]]
                                                    r33 = 237
                                                    r9 = r2 * r33
                                                    r2 = 1396569457291
                                                    ReturnVal = r9 + r2
                                                    r9 = 35184372088832
                                                    state = ReturnVal % r9
                                                    upvalueValues[upvalues[2]] = state
                                                    r9 = upvalueValues[upvalues[3]]
                                                    r2 = 1
                                                    ReturnVal = r9 ~= r2
                                                    state = 54
                                                end
                                            end
                                        else
                                            if state == 53 then
                                                r33 = "table"
                                                r2 = _env[r33]
                                                r33 = "remove"
                                                r9 = r2[r33]
                                                r33 = upvalueValues[upvalues[1]]
                                                r2 = {
                                                    r9(r33)
                                                }
                                                ReturnVal = {
                                                    unpack(r2)
                                                }
                                                state = nil
                                            end
                                        end
                                    else
                                        if state <= 55 then
                                            if state <= 54 then
                                                if state == 54 then
                                                    r2 = upvalueValues[upvalues[3]]
                                                    r33 = 102
                                                    r9 = r2 * r33
                                                    r2 = 257
                                                    ReturnVal = r9 % r2
                                                    upvalueValues[upvalues[3]] = ReturnVal
                                                    state = 55
                                                end
                                            else
                                                if state == 55 then
                                                    r2 = upvalueValues[upvalues[3]]
                                                    r33 = 1
                                                    r9 = r2 ~= r33
                                                    state = r9 and (56) or (54)
                                                end
                                            end
                                        else
                                            if state == 56 then
                                                r33 = 32
                                                r2 = upvalueValues[upvalues[3]]
                                                r9 = r2 % r33
                                                r17 = upvalueValues[upvalues[4]]
                                                r20 = 2
                                                r22 = upvalueValues[upvalues[2]]
                                                r3 = upvalueValues[upvalues[3]]
                                                r18 = r3 - r9
                                                r3 = 32
                                                r1 = r18 / r3
                                                r11 = 13
                                                r19 = r11 - r1
                                                r24 = r20 ^ r19
                                                r10 = r22 / r24
                                                r27 = r17(r10)
                                                r17 = 4294967296
                                                r24 = 1
                                                r33 = r27 % r17
                                                r27 = 2
                                                r20 = 256
                                                r17 = r27 ^ r9
                                                r2 = r33 / r17
                                                r17 = upvalueValues[upvalues[4]]
                                                r22 = r2 % r24
                                                r24 = 4294967296
                                                r10 = r22 * r24
                                                r27 = r17(r10)
                                                r17 = upvalueValues[upvalues[4]]
                                                r10 = r17(r2)
                                                r33 = r27 + r10
                                                r27 = 65536
                                                r22 = 65536
                                                r9 = nil
                                                r17 = r33 % r27
                                                r10 = r33 - r17
                                                r27 = r10 / r22
                                                r22 = 256
                                                r10 = r17 % r22
                                                r24 = r17 - r10
                                                r22 = r24 / r20
                                                r20 = 256
                                                r24 = r27 % r20
                                                r11 = 256
                                                r2 = nil
                                                r19 = r27 - r24
                                                r20 = r19 / r11
                                                r17 = nil
                                                r19 = {
                                                    r10,
                                                    r22,
                                                    r24,
                                                    r20
                                                }
                                                r24 = nil
                                                r27 = nil
                                                upvalueValues[upvalues[1]] = r19
                                                r20 = nil
                                                r10 = nil
                                                r33 = nil
                                                r22 = nil
                                                state = 53
                                            end
                                        end
                                    end
                                else
                                    -- createClosure4 entry 955450 -> 57, states 57-63
                                    if state <= 60 then
                                        if state <= 58 then
                                            if state <= 57 then
                                                if state == 57 then -- entry 955450 -> 57
                                                    state = upvalueValues[upvalues[1]]
                                                    r33 = state
                                                    r9 = args[1]
                                                    r2 = args[2]
                                                    state = r33[r2]
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
                                                    r17 = ReturnVal
                                                    r27 = 35184372088832
                                                    ReturnVal = r2 % r27
                                                    upvalueValues[upvalues[4]] = ReturnVal
                                                    r22 = 255
                                                    r10 = r2 % r22
                                                    r22 = 2
                                                    r27 = r10 + r22
                                                    upvalueValues[upvalues[5]] = r27
                                                    r24 = "string"
                                                    r22 = _env[r24]
                                                    r24 = "len"
                                                    r10 = r22[r24]
                                                    r22 = r10(r9)
                                                    r10 = ""
                                                    r33[r2] = r10
                                                    r19 = 1
                                                    r11 = r19
                                                    r19 = 0
                                                    r1 = r11 < r19
                                                    r24 = 1
                                                    r19 = r24 - r11
                                                    r20 = r22
                                                    r10 = 101
                                                    state = 61
                                                end
                                            else
                                                if state == 60 then
                                                    ReturnVal = {
                                                        r2
                                                    }
                                                    state = nil
                                                end
                                            end
                                        end
                                    else
                                        if state <= 62 then
                                            if state <= 61 then
                                                if state == 61 then
                                                    r18 = not r1
                                                    r19 = r19 + r11
                                                    r24 = r19 <= r20
                                                    r24 = r18 and r24
                                                    r18 = r19 >= r20
                                                    r18 = r1 and r18
                                                    r24 = r18 or r24
                                                    r18 = (62)
                                                    state = r24 and r18
                                                    r24 = (63)
                                                    state = state or r24
                                                end
                                            else
                                                if state == 62 then
                                                    r14 = "string"
                                                    r4 = _env[r14]
                                                    r24 = r19
                                                    r14 = "byte"
                                                    r28 = r4[r14]
                                                    r4 = r28(r9, r24)
                                                    r28 = upvalueValues[upvalues[6]]
                                                    r14 = r28()
                                                    r12 = r4 + r14
                                                    r3 = r12 + r10
                                                    r12 = 256
                                                    r18 = r3 % r12
                                                    r10 = r18
                                                    r12 = r33[r2]
                                                    r14 = 1
                                                    r4 = r10 + r14
                                                    r28 = r17[r4]
                                                    r3 = r12 .. r28
                                                    r24 = nil
                                                    r33[r2] = r3
                                                    state = 61
                                                end
                                            end
                                        else
                                            if state == 63 then
                                                r10 = nil
                                                r22 = nil
                                                r17 = nil
                                                state = 60
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    else
                        if state <= 78 then
                            if state <= 76 then
                                if state <= 70 then
                                    -- createClosure1 entry 5192053 -> 64, states 64-70
                                    if state <= 67 then
                                        if state <= 65 then
                                            if state <= 64 then
                                                if state == 64 then -- entry 5192053 -> 64
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    r2 = upvalueValues[upvalues[2]]
                                                    r33 = upvalueValues[upvalues[3]]
                                                    r27 = "_U\229\180bN\188\236\129"
                                                    r10 = 24202375818246
                                                    r17 = r33(r27, r10)
                                                    r9 = r2[r17]
                                                    state = ReturnVal[r9]
                                                    ReturnVal = "FindFirstChild"
                                                    ReturnVal = state[ReturnVal]
                                                    r9 = upvalueValues[upvalues[4]]
                                                    ReturnVal = ReturnVal(state, r9)
                                                    r9 = ReturnVal
                                                    state = r9 and (65) or (66)
                                                end
                                            else
                                                if state == 65 then
                                                    state = "Destroy"
                                                    state = r9[state]
                                                    state = state(r9)
                                                    state = 66
                                                end
                                            end
                                        else
                                            if state <= 66 then
                                                if state == 66 then
                                                    r2 = "Instance"
                                                    ReturnVal = _env[r2]
                                                    r33 = upvalueValues[upvalues[2]]
                                                    r17 = upvalueValues[upvalues[3]]
                                                    r10 = "y\019\245"
                                                    r22 = 29257542055224
                                                    r27 = r17(r10, r22)
                                                    r2 = r33[r27]
                                                    state = ReturnVal[r2]
                                                    r33 = upvalueValues[upvalues[2]]
                                                    r17 = upvalueValues[upvalues[3]]
                                                    r22 = 24664379911389
                                                    r10 = "\023\155\017-\016\228\204\198="
                                                    r27 = r17(r10, r22)
                                                    r2 = r33[r27]
                                                    ReturnVal = state(r2)
                                                    r2 = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r33 = upvalueValues[upvalues[3]]
                                                    r10 = 31537495423325
                                                    r27 = "rH5\170"
                                                    r17 = r33(r27, r10)
                                                    state = ReturnVal[r17]
                                                    ReturnVal = upvalueValues[upvalues[4]]
                                                    r2[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r33 = upvalueValues[upvalues[3]]
                                                    r10 = 30833343772693
                                                    r27 = "[\179\202\168n\2289\139Ig\188\029A\128"
                                                    r17 = r33(r27, r10)
                                                    state = ReturnVal[r17]
                                                    ReturnVal = true
                                                    r2[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r33 = upvalueValues[upvalues[3]]
                                                    r10 = 15242145061817
                                                    r27 = "\241\014\026\028\173@(\234\136!\253\""
                                                    r17 = r33(r27, r10)
                                                    state = ReturnVal[r17]
                                                    ReturnVal = false
                                                    r2[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r33 = upvalueValues[upvalues[3]]
                                                    r27 = "\012\003s\0077o"
                                                    r10 = 5335619340724
                                                    r17 = r33(r27, r10)
                                                    state = ReturnVal[r17]
                                                    ReturnVal = upvalueValues[upvalues[1]]
                                                    r27 = upvalueValues[upvalues[2]]
                                                    r10 = upvalueValues[upvalues[3]]
                                                    r24 = "\217bP\164\133\202}@\161"
                                                    r20 = 28354875749267
                                                    r22 = r10(r24, r20)
                                                    r33 = "WaitForChild"
                                                    r33 = ReturnVal[r33]
                                                    r17 = r27[r22]
                                                    r33 = r33(ReturnVal, r17)
                                                    r2[state] = r33
                                                    r33 = "Instance"
                                                    ReturnVal = _env[r33]
                                                    r17 = upvalueValues[upvalues[2]]
                                                    r27 = upvalueValues[upvalues[3]]
                                                    r24 = 26565147373650
                                                    r22 = "{\000,"
                                                    r10 = r27(r22, r24)
                                                    r33 = r17[r10]
                                                    state = ReturnVal[r33]
                                                    r17 = upvalueValues[upvalues[2]]
                                                    r27 = upvalueValues[upvalues[3]]
                                                    r24 = 17773392846932
                                                    r22 = "\204\025\251\016\165"
                                                    r10 = r27(r22, r24)
                                                    r33 = r17[r10]
                                                    ReturnVal = state(r33, r2)
                                                    r33 = allocUpvalue()
                                                    upvalueValues[r33] = ReturnVal
                                                    state = upvalueValues[r33]
                                                    r17 = upvalueValues[upvalues[2]]
                                                    r27 = upvalueValues[upvalues[3]]
                                                    r22 = "\250\222\129\031"
                                                    r24 = 19017051644567
                                                    r10 = r27(r22, r24)
                                                    ReturnVal = r17[r10]
                                                    r10 = "UDim2"
                                                    r27 = _env[r10]
                                                    r22 = upvalueValues[upvalues[2]]
                                                    r24 = upvalueValues[upvalues[3]]
                                                    r19 = "\005c\229"
                                                    r11 = 1770996695864
                                                    r20 = r24(r19, r11)
                                                    r10 = r22[r20]
                                                    r17 = r27[r10]
                                                    r22 = 210
                                                    r24 = 0
                                                    r20 = 174
                                                    r10 = 0
                                                    r27 = r17(r10, r22, r24, r20)
                                                    state[ReturnVal] = r27
                                                    state = upvalueValues[r33]
                                                    r17 = upvalueValues[upvalues[2]]
                                                    r27 = upvalueValues[upvalues[3]]
                                                    r22 = "\0220\202\222rH\r\206"
                                                    r24 = 4626056775786
                                                    r10 = r27(r22, r24)
                                                    ReturnVal = r17[r10]
                                                    r10 = "UDim2"
                                                    r27 = _env[r10]
                                                    r22 = upvalueValues[upvalues[2]]
                                                    r24 = upvalueValues[upvalues[3]]
                                                    r11 = 31032229591154
                                                    r19 = "\219\236p"
                                                    r20 = r24(r19, r11)
                                                    r10 = r22[r20]
                                                    r17 = r27[r10]
                                                    r22 = -105
                                                    r20 = -87
                                                    r10 = 0.5
                                                    r24 = 0.7
                                                    r27 = r17(r10, r22, r24, r20)
                                                    state[ReturnVal] = r27
                                                    state = upvalueValues[r33]
                                                    r17 = upvalueValues[upvalues[2]]
                                                    r27 = upvalueValues[upvalues[3]]
                                                    r22 = "\002\219r\158+.\176L\210\214\149j\017\207+\235"
                                                    r24 = 17671374512164
                                                    r10 = r27(r22, r24)
                                                    ReturnVal = r17[r10]
                                                    r10 = "Color3"
                                                    r27 = _env[r10]
                                                    r22 = upvalueValues[upvalues[2]]
                                                    r24 = upvalueValues[upvalues[3]]
                                                    r11 = 7045863886032
                                                    r19 = "\241\246\235\006\202vo"
                                                    r20 = r24(r19, r11)
                                                    r10 = r22[r20]
                                                    r17 = r27[r10]
                                                    r10 = 18
                                                    r24 = 28
                                                    r22 = 22
                                                    r27 = r17(r10, r22, r24)
                                                    state[ReturnVal] = r27
                                                    state = upvalueValues[r33]
                                                    r17 = upvalueValues[upvalues[2]]
                                                    r27 = upvalueValues[upvalues[3]]
                                                    r22 = "F\215Q\244\177\213\170\1867\194\n0b\213\246\196VcB\231\169\160"
                                                    r24 = 2427601257578
                                                    r10 = r27(r22, r24)
                                                    ReturnVal = r17[r10]
                                                    r17 = 0.07
                                                    state[ReturnVal] = r17
                                                    state = upvalueValues[r33]
                                                    r17 = upvalueValues[upvalues[2]]
                                                    r27 = upvalueValues[upvalues[3]]
                                                    r22 = "U\160\172.\165Gz\216z)>\157P3\133"
                                                    r24 = 20789337564624
                                                    r10 = r27(r22, r24)
                                                    ReturnVal = r17[r10]
                                                    r17 = 0
                                                    state[ReturnVal] = r17
                                                    state = upvalueValues[r33]
                                                    r17 = upvalueValues[upvalues[2]]
                                                    r27 = upvalueValues[upvalues[3]]
                                                    r22 = "OX\197\028{\018"
                                                    r24 = 7447576546700
                                                    r10 = r27(r22, r24)
                                                    ReturnVal = r17[r10]
                                                    r17 = true
                                                    state[ReturnVal] = r17
                                                    r17 = "Instance"
                                                    ReturnVal = _env[r17]
                                                    r27 = upvalueValues[upvalues[2]]
                                                    r10 = upvalueValues[upvalues[3]]
                                                    r20 = 11163306366030
                                                    r24 = "8\007Q"
                                                    r22 = r10(r24, r20)
                                                    r17 = r27[r22]
                                                    state = ReturnVal[r17]
                                                    r27 = upvalueValues[upvalues[2]]
                                                    r10 = upvalueValues[upvalues[3]]
                                                    r24 = "X\200U\228\148\238\215D"
                                                    r20 = 3898120111895
                                                    r22 = r10(r24, r20)
                                                    r17 = r27[r22]
                                                    r27 = upvalueValues[r33]
                                                    ReturnVal = state(r17, r27)
                                                    r17 = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r27 = upvalueValues[upvalues[3]]
                                                    r24 = 19601321927591
                                                    r22 = "+\140S\243a\127\248Wn"
                                                    r10 = r27(r22, r24)
                                                    state = ReturnVal[r10]
                                                    ReturnVal = 2
                                                    r17[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r27 = upvalueValues[upvalues[3]]
                                                    r24 = 9426762289445
                                                    r22 = "~\144\015\240\211"
                                                    r10 = r27(r22, r24)
                                                    state = ReturnVal[r10]
                                                    r10 = "Color3"
                                                    r27 = _env[r10]
                                                    r22 = upvalueValues[upvalues[2]]
                                                    r24 = upvalueValues[upvalues[3]]
                                                    r19 = "\n\174{vJ\237\235"
                                                    r11 = 1431422943898
                                                    r20 = r24(r19, r11)
                                                    r10 = r22[r20]
                                                    ReturnVal = r27[r10]
                                                    r22 = 255
                                                    r24 = 90
                                                    r10 = 10
                                                    r27 = ReturnVal(r10, r22, r24)
                                                    r17[state] = r27
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r27 = upvalueValues[upvalues[3]]
                                                    r22 = "\133\024\019\223!\132\t\001\186\243\008\247"
                                                    r24 = 7767717334561
                                                    r10 = r27(r22, r24)
                                                    state = ReturnVal[r10]
                                                    ReturnVal = 0.2
                                                    r17[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r27 = upvalueValues[upvalues[3]]
                                                    r22 = "\234\227\194\191\004\243xR3HK\169\145x\015"
                                                    r24 = 10823331763120
                                                    r10 = r27(r22, r24)
                                                    state = ReturnVal[r10]
                                                    r22 = "Enum"
                                                    r10 = _env[r22]
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r1 = 15335056727012
                                                    r11 = "\151\221\005\179O\253,\221t\133,X:\015\007"
                                                    r19 = r20(r11, r1)
                                                    r22 = r24[r19]
                                                    r27 = r10[r22]
                                                    r22 = upvalueValues[upvalues[2]]
                                                    r24 = upvalueValues[upvalues[3]]
                                                    r19 = "uf=\140\214k"
                                                    r11 = 31755611552195
                                                    r20 = r24(r19, r11)
                                                    r10 = r22[r20]
                                                    ReturnVal = r27[r10]
                                                    r17[state] = ReturnVal
                                                    r27 = "Instance"
                                                    ReturnVal = _env[r27]
                                                    r10 = upvalueValues[upvalues[2]]
                                                    r22 = upvalueValues[upvalues[3]]
                                                    r19 = 21628560254807
                                                    r20 = "\215z\152"
                                                    r24 = r22(r20, r19)
                                                    r27 = r10[r24]
                                                    state = ReturnVal[r27]
                                                    r10 = upvalueValues[upvalues[2]]
                                                    r22 = upvalueValues[upvalues[3]]
                                                    r20 = "\002\194\024O\234\007*\134"
                                                    r19 = 26780165124278
                                                    r24 = r22(r20, r19)
                                                    r27 = r10[r24]
                                                    r10 = upvalueValues[r33]
                                                    ReturnVal = state(r27, r10)
                                                    r27 = upvalueValues[upvalues[2]]
                                                    r10 = upvalueValues[upvalues[3]]
                                                    r24 = "\136\025\1357\219\192\204\215C\252\238\158"
                                                    r20 = 3840271763196
                                                    r22 = r10(r24, r20)
                                                    state = r27[r22]
                                                    r22 = "UDim"
                                                    r10 = _env[r22]
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r11 = "^/#"
                                                    r1 = 10646563984221
                                                    r19 = r20(r11, r1)
                                                    r22 = r24[r19]
                                                    r27 = r10[r22]
                                                    r22 = 0
                                                    r24 = 14
                                                    r10 = r27(r22, r24)
                                                    ReturnVal[state] = r10
                                                    r27 = "Instance"
                                                    ReturnVal = _env[r27]
                                                    r10 = upvalueValues[upvalues[2]]
                                                    r22 = upvalueValues[upvalues[3]]
                                                    r19 = 20853335074286
                                                    r20 = "Sva"
                                                    r24 = r22(r20, r19)
                                                    r27 = r10[r24]
                                                    state = ReturnVal[r27]
                                                    r10 = upvalueValues[upvalues[2]]
                                                    r22 = upvalueValues[upvalues[3]]
                                                    r20 = "m\031#N\134\011w\225c/"
                                                    r19 = 28504651674585
                                                    r24 = r22(r20, r19)
                                                    r27 = r10[r24]
                                                    r10 = upvalueValues[r33]
                                                    ReturnVal = state(r27, r10)
                                                    r27 = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r10 = upvalueValues[upvalues[3]]
                                                    r24 = "\160\197\208-"
                                                    r20 = 6999687302331
                                                    r22 = r10(r24, r20)
                                                    state = ReturnVal[r22]
                                                    r22 = "UDim2"
                                                    r10 = _env[r22]
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r11 = "\178d\011"
                                                    r1 = 16502306741764
                                                    r19 = r20(r11, r1)
                                                    r22 = r24[r19]
                                                    ReturnVal = r10[r22]
                                                    r20 = 1
                                                    r24 = 18
                                                    r22 = 1
                                                    r19 = 18
                                                    r10 = ReturnVal(r22, r24, r20, r19)
                                                    r27[state] = r10
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r10 = upvalueValues[upvalues[3]]
                                                    r20 = 8562424647571
                                                    r24 = "\022\131 n\253\232\011S"
                                                    r22 = r10(r24, r20)
                                                    state = ReturnVal[r22]
                                                    r22 = "UDim2"
                                                    r10 = _env[r22]
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r11 = "\227\241\205"
                                                    r1 = 12335306643056
                                                    r19 = r20(r11, r1)
                                                    r22 = r24[r19]
                                                    r24 = -9
                                                    r19 = -9
                                                    ReturnVal = r10[r22]
                                                    r20 = 0
                                                    r22 = 0
                                                    r10 = ReturnVal(r22, r24, r20, r19)
                                                    r27[state] = r10
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r10 = upvalueValues[upvalues[3]]
                                                    r24 = "\234k;\022d\143\128{\003\217\137T\001\138\000OE\244\146\140Y\146"
                                                    r20 = 9672810385816
                                                    r22 = r10(r24, r20)
                                                    state = ReturnVal[r22]
                                                    ReturnVal = 1
                                                    r27[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r10 = upvalueValues[upvalues[3]]
                                                    r24 = "\178.d\152\234"
                                                    r20 = 35127572021221
                                                    r22 = r10(r24, r20)
                                                    state = ReturnVal[r22]
                                                    r10 = upvalueValues[upvalues[2]]
                                                    r22 = upvalueValues[upvalues[3]]
                                                    r19 = 30108699506372
                                                    r20 = "r\250\172\145Z3-\019\240\028o&\237r\164\005=\252W\215Y\146\001"
                                                    r24 = r22(r20, r19)
                                                    ReturnVal = r10[r24]
                                                    r27[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r10 = upvalueValues[upvalues[3]]
                                                    r24 = "\229\012\194F\024\015\128\030\018RP"
                                                    r20 = 28689862046767
                                                    r22 = r10(r24, r20)
                                                    state = ReturnVal[r22]
                                                    r22 = upvalueValues[upvalues[2]]
                                                    r24 = upvalueValues[upvalues[3]]
                                                    r11 = 1714196611870
                                                    r19 = "\206 \237h\133"
                                                    r20 = r24(r19, r11)
                                                    r10 = r22[r20]
                                                    ReturnVal = r17[r10]
                                                    r27[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r10 = upvalueValues[upvalues[3]]
                                                    r20 = 34734756282158
                                                    r24 = "\164\202\251\"y\245\021\151\025\021$y\021\155\239\000\001"
                                                    r22 = r10(r24, r20)
                                                    state = ReturnVal[r22]
                                                    ReturnVal = 0.88
                                                    r27[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r10 = upvalueValues[upvalues[3]]
                                                    r20 = 24537719532706
                                                    r24 = "p\158\1591\239\242"
                                                    r22 = r10(r24, r20)
                                                    state = ReturnVal[r22]
                                                    ReturnVal = 0
                                                    r27[state] = ReturnVal
                                                    r10 = "Instance"
                                                    ReturnVal = _env[r10]
                                                    r22 = upvalueValues[upvalues[2]]
                                                    r24 = upvalueValues[upvalues[3]]
                                                    r11 = 19385571140419
                                                    r19 = "\162L\172"
                                                    r20 = r24(r19, r11)
                                                    r10 = r22[r20]
                                                    state = ReturnVal[r10]
                                                    r22 = upvalueValues[upvalues[2]]
                                                    r24 = upvalueValues[upvalues[3]]
                                                    r19 = "QB\250\186u\130\179j\202F"
                                                    r11 = 6596248062975
                                                    r20 = r24(r19, r11)
                                                    r10 = r22[r20]
                                                    r22 = upvalueValues[r33]
                                                    ReturnVal = state(r10, r22)
                                                    r10 = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r22 = upvalueValues[upvalues[3]]
                                                    r20 = "X{\198\240"
                                                    r19 = 26965320790284
                                                    r24 = r22(r20, r19)
                                                    state = ReturnVal[r24]
                                                    r24 = "UDim2"
                                                    r22 = _env[r24]
                                                    r20 = upvalueValues[upvalues[2]]
                                                    r19 = upvalueValues[upvalues[3]]
                                                    r18 = 4990536599827
                                                    r1 = "\150\001\131"
                                                    r11 = r19(r1, r18)
                                                    r24 = r20[r11]
                                                    ReturnVal = r22[r24]
                                                    r24 = 0
                                                    r19 = 0
                                                    r11 = 46
                                                    r20 = 46
                                                    r22 = ReturnVal(r24, r20, r19, r11)
                                                    r10[state] = r22
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r22 = upvalueValues[upvalues[3]]
                                                    r20 = "3\207\218\176\206\192\020\220"
                                                    r19 = 14043824609675
                                                    r24 = r22(r20, r19)
                                                    state = ReturnVal[r24]
                                                    r24 = "UDim2"
                                                    r22 = _env[r24]
                                                    r20 = upvalueValues[upvalues[2]]
                                                    r19 = upvalueValues[upvalues[3]]
                                                    r1 = "N\0049"
                                                    r18 = 2944255051099
                                                    r11 = r19(r1, r18)
                                                    r24 = r20[r11]
                                                    ReturnVal = r22[r24]
                                                    r20 = -23
                                                    r19 = 0
                                                    r11 = 7
                                                    r24 = 0.5
                                                    r22 = ReturnVal(r24, r20, r19, r11)
                                                    r10[state] = r22
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r22 = upvalueValues[upvalues[3]]
                                                    r19 = 8888656711723
                                                    r20 = "Q\162\202 \242\008\131\204\184\196\\\012\001\1324\191\132)$\027\171\254"
                                                    r24 = r22(r20, r19)
                                                    state = ReturnVal[r24]
                                                    ReturnVal = 1
                                                    r10[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r22 = upvalueValues[upvalues[3]]
                                                    r19 = 33645146537267
                                                    r20 = "(\218\250I\008"
                                                    r24 = r22(r20, r19)
                                                    state = ReturnVal[r24]
                                                    r22 = upvalueValues[upvalues[2]]
                                                    r24 = upvalueValues[upvalues[3]]
                                                    r19 = "X\250\242Y\195\215\232\000\2144Vf\136\180Uz!a]\171\030\153\209ew\142\144\1333\150.\144)V<\214\174\165:^\tzG8\200L4m\020\191\236"
                                                    r11 = 12371017356928
                                                    r20 = r24(r19, r11)
                                                    ReturnVal = r22[r20]
                                                    r10[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r22 = upvalueValues[upvalues[3]]
                                                    r19 = 10320079655621
                                                    r20 = "\223l\\G\188\196\153Y\220"
                                                    r24 = r22(r20, r19)
                                                    state = ReturnVal[r24]
                                                    r20 = "Enum"
                                                    r24 = _env[r20]
                                                    r19 = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r3 = 6228491766612
                                                    r18 = "\250cj<Q-38\175"
                                                    r1 = r11(r18, r3)
                                                    r20 = r19[r1]
                                                    r22 = r24[r20]
                                                    r20 = upvalueValues[upvalues[2]]
                                                    r19 = upvalueValues[upvalues[3]]
                                                    r1 = "WMi"
                                                    r18 = 23194349120048
                                                    r11 = r19(r1, r18)
                                                    r24 = r20[r11]
                                                    ReturnVal = r22[r24]
                                                    r10[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r22 = upvalueValues[upvalues[3]]
                                                    r20 = "\254V\135\027\218Y"
                                                    r19 = 25655136382634
                                                    r24 = r22(r20, r19)
                                                    state = ReturnVal[r24]
                                                    ReturnVal = 3
                                                    r10[state] = ReturnVal
                                                    r22 = "Instance"
                                                    ReturnVal = _env[r22]
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r11 = "M\151\179"
                                                    r1 = 2799731213591
                                                    r19 = r20(r11, r1)
                                                    r22 = r24[r19]
                                                    state = ReturnVal[r22]
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r1 = 9638537269640
                                                    r11 = "\014\0208\006\170\198hi;"
                                                    r19 = r20(r11, r1)
                                                    r22 = r24[r19]
                                                    r24 = upvalueValues[r33]
                                                    ReturnVal = state(r22, r24)
                                                    r22 = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r24 = upvalueValues[upvalues[3]]
                                                    r19 = "V\027\172\171"
                                                    r11 = 17250929401697
                                                    r20 = r24(r19, r11)
                                                    state = ReturnVal[r20]
                                                    r20 = "UDim2"
                                                    r24 = _env[r20]
                                                    r19 = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r3 = 6640002976787
                                                    r18 = "\135\008\178"
                                                    r1 = r11(r18, r3)
                                                    r20 = r19[r1]
                                                    r19 = -18
                                                    ReturnVal = r24[r20]
                                                    r1 = 20
                                                    r11 = 0
                                                    r20 = 1
                                                    r24 = ReturnVal(r20, r19, r11, r1)
                                                    r22[state] = r24
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r24 = upvalueValues[upvalues[3]]
                                                    r11 = 20285101253861
                                                    r19 = "@H\143\222\025\202\2292"
                                                    r20 = r24(r19, r11)
                                                    state = ReturnVal[r20]
                                                    r20 = "UDim2"
                                                    r24 = _env[r20]
                                                    r19 = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r18 = "o\r\157"
                                                    r3 = 2919892387151
                                                    r1 = r11(r18, r3)
                                                    r20 = r19[r1]
                                                    ReturnVal = r24[r20]
                                                    r11 = 0
                                                    r20 = 0
                                                    r19 = 9
                                                    r1 = 58
                                                    r24 = ReturnVal(r20, r19, r11, r1)
                                                    r22[state] = r24
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r24 = upvalueValues[upvalues[3]]
                                                    r19 = "\129\128w\176=\177s\198\223\157Ri)\148\200\250s\218S\248?:"
                                                    r11 = 35144654667757
                                                    r20 = r24(r19, r11)
                                                    state = ReturnVal[r20]
                                                    ReturnVal = 1
                                                    r22[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r24 = upvalueValues[upvalues[3]]
                                                    r11 = 27284788572577
                                                    r19 = "\178\241>\189"
                                                    r20 = r24(r19, r11)
                                                    state = ReturnVal[r20]
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r1 = 19422199128916
                                                    r11 = "r>\146QQ\157\174\248\199\026U;\218\238f\181\241J\156\190"
                                                    r19 = r20(r11, r1)
                                                    ReturnVal = r24[r19]
                                                    r22[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r24 = upvalueValues[upvalues[3]]
                                                    r11 = 8522707210112
                                                    r19 = "\182j\024\183"
                                                    r20 = r24(r19, r11)
                                                    state = ReturnVal[r20]
                                                    r19 = "Enum"
                                                    r20 = _env[r19]
                                                    r11 = upvalueValues[upvalues[2]]
                                                    r1 = upvalueValues[upvalues[3]]
                                                    r12 = 4435723110417
                                                    r3 = "\248\153;\005"
                                                    r18 = r1(r3, r12)
                                                    r19 = r11[r18]
                                                    r24 = r20[r19]
                                                    r19 = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r18 = "W\005\255!>\239\244\1784\252\137"
                                                    r3 = 29095009531116
                                                    r1 = r11(r18, r3)
                                                    r20 = r19[r1]
                                                    ReturnVal = r24[r20]
                                                    r22[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r24 = upvalueValues[upvalues[3]]
                                                    r11 = 8465907126118
                                                    r19 = "\216\145\208\213\135\011\217\220"
                                                    r20 = r24(r19, r11)
                                                    state = ReturnVal[r20]
                                                    ReturnVal = 15
                                                    r22[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r24 = upvalueValues[upvalues[3]]
                                                    r19 = "\227@('3\219LIf\030"
                                                    r11 = 34544422616790
                                                    r20 = r24(r19, r11)
                                                    state = ReturnVal[r20]
                                                    r20 = "Color3"
                                                    r24 = _env[r20]
                                                    r19 = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r18 = "\167\242\246\252P\141\179"
                                                    r3 = 22600499472668
                                                    r1 = r11(r18, r3)
                                                    r20 = r19[r1]
                                                    ReturnVal = r24[r20]
                                                    r11 = 90
                                                    r19 = 255
                                                    r20 = 10
                                                    r24 = ReturnVal(r20, r19, r11)
                                                    r22[state] = r24
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r24 = upvalueValues[upvalues[3]]
                                                    r11 = 10180103754372
                                                    r19 = "\168?\133\156Z\000\1774\217\163k\193\020\218X\031\163\163\249\153\184\241"
                                                    r20 = r24(r19, r11)
                                                    state = ReturnVal[r20]
                                                    ReturnVal = 0.7
                                                    r22[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r24 = upvalueValues[upvalues[3]]
                                                    r19 = "M\228~=\212\216"
                                                    r11 = 34094806793732
                                                    r20 = r24(r19, r11)
                                                    state = ReturnVal[r20]
                                                    ReturnVal = 3
                                                    r22[state] = ReturnVal
                                                    r24 = "Instance"
                                                    ReturnVal = _env[r24]
                                                    r20 = upvalueValues[upvalues[2]]
                                                    r19 = upvalueValues[upvalues[3]]
                                                    r1 = "r\017\206"
                                                    r18 = 11953846900158
                                                    r11 = r19(r1, r18)
                                                    r24 = r20[r11]
                                                    state = ReturnVal[r24]
                                                    r20 = upvalueValues[upvalues[2]]
                                                    r19 = upvalueValues[upvalues[3]]
                                                    r18 = 29565674894791
                                                    r1 = "\142\204\000\147\146.\141\254\025"
                                                    r11 = r19(r1, r18)
                                                    r24 = r20[r11]
                                                    r20 = upvalueValues[r33]
                                                    ReturnVal = state(r24, r20)
                                                    r24 = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r1 = 5506682751492
                                                    r11 = "\230\157\187\210"
                                                    r19 = r20(r11, r1)
                                                    state = ReturnVal[r19]
                                                    r19 = "UDim2"
                                                    r20 = _env[r19]
                                                    r11 = upvalueValues[upvalues[2]]
                                                    r1 = upvalueValues[upvalues[3]]
                                                    r12 = 3734795585227
                                                    r3 = "\012\022\137"
                                                    r18 = r1(r3, r12)
                                                    r19 = r11[r18]
                                                    r11 = -18
                                                    ReturnVal = r20[r19]
                                                    r1 = 0
                                                    r19 = 1
                                                    r18 = 16
                                                    r20 = ReturnVal(r19, r11, r1, r18)
                                                    r24[state] = r20
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r1 = 34556211494619
                                                    r11 = "z\024\1579nw\n\016"
                                                    r19 = r20(r11, r1)
                                                    state = ReturnVal[r19]
                                                    r19 = "UDim2"
                                                    r20 = _env[r19]
                                                    r11 = upvalueValues[upvalues[2]]
                                                    r1 = upvalueValues[upvalues[3]]
                                                    r3 = "\024t\241"
                                                    r12 = 19550507377551
                                                    r18 = r1(r3, r12)
                                                    r19 = r11[r18]
                                                    ReturnVal = r20[r19]
                                                    r11 = 9
                                                    r19 = 0
                                                    r18 = 78
                                                    r1 = 0
                                                    r20 = ReturnVal(r19, r11, r1, r18)
                                                    r24[state] = r20
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r11 = "\221/\018Y\162I^&8\150\206\169\162\005\163\020!\148{\247\n\005"
                                                    r1 = 6679050652710
                                                    r19 = r20(r11, r1)
                                                    state = ReturnVal[r19]
                                                    ReturnVal = 1
                                                    r24[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r11 = "\000\252E\184"
                                                    r1 = 8260496117510
                                                    r19 = r20(r11, r1)
                                                    state = ReturnVal[r19]
                                                    r11 = "Enum"
                                                    r19 = _env[r11]
                                                    r1 = upvalueValues[upvalues[2]]
                                                    r18 = upvalueValues[upvalues[3]]
                                                    r28 = 18011281809603
                                                    r12 = "\"z\201\145"
                                                    r3 = r18(r12, r28)
                                                    r11 = r1[r3]
                                                    r20 = r19[r11]
                                                    r11 = upvalueValues[upvalues[2]]
                                                    r1 = upvalueValues[upvalues[3]]
                                                    r12 = 19050068009638
                                                    r3 = "*t\227+d\154\246\145\015\192\130\017T\157"
                                                    r18 = r1(r3, r12)
                                                    r19 = r11[r18]
                                                    ReturnVal = r20[r19]
                                                    r24[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r1 = 18580575773132
                                                    r11 = "\219\186\234)H&)m"
                                                    r19 = r20(r11, r1)
                                                    state = ReturnVal[r19]
                                                    ReturnVal = 12
                                                    r24[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r11 = "\210s\171Y\011B^~J\250"
                                                    r1 = 24239773592599
                                                    r19 = r20(r11, r1)
                                                    state = ReturnVal[r19]
                                                    r19 = "Color3"
                                                    r20 = _env[r19]
                                                    r11 = upvalueValues[upvalues[2]]
                                                    r1 = upvalueValues[upvalues[3]]
                                                    r12 = 7060045024471
                                                    r3 = "\156|t5\147\016\020"
                                                    r18 = r1(r3, r12)
                                                    r19 = r11[r18]
                                                    ReturnVal = r20[r19]
                                                    r1 = 200
                                                    r19 = 200
                                                    r11 = 255
                                                    r20 = ReturnVal(r19, r11, r1)
                                                    r24[state] = r20
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r1 = 9051340066934
                                                    r11 = "\158\026*\191"
                                                    r19 = r20(r11, r1)
                                                    state = ReturnVal[r19]
                                                    r20 = upvalueValues[upvalues[2]]
                                                    r19 = upvalueValues[upvalues[3]]
                                                    r18 = 27039504806191
                                                    r1 = "&\193f\167\004ZF\214J\182\195\214FR\198\251\199;\239\153\2105\181{"
                                                    r11 = r19(r1, r18)
                                                    ReturnVal = r20[r11]
                                                    r24[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r1 = 16698582294111
                                                    r11 = "\202\016\217G\019\t\227(\008\222\r\234t\028\179\233@=X\026w\136"
                                                    r19 = r20(r11, r1)
                                                    state = ReturnVal[r19]
                                                    ReturnVal = 0.92
                                                    r24[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r1 = 26302269468631
                                                    r11 = "\172\199:Es-"
                                                    r19 = r20(r11, r1)
                                                    state = ReturnVal[r19]
                                                    ReturnVal = 3
                                                    r24[state] = ReturnVal
                                                    r20 = "Instance"
                                                    ReturnVal = _env[r20]
                                                    r19 = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r3 = 33679507799363
                                                    r18 = "\222T\239"
                                                    r1 = r11(r18, r3)
                                                    r20 = r19[r1]
                                                    state = ReturnVal[r20]
                                                    r19 = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r3 = 1799311459141
                                                    r18 = "\179 \204\206\023/\030\230\027"
                                                    r1 = r11(r18, r3)
                                                    r20 = r19[r1]
                                                    r19 = upvalueValues[r33]
                                                    ReturnVal = state(r20, r19)
                                                    r20 = allocUpvalue()
                                                    upvalueValues[r20] = ReturnVal
                                                    state = upvalueValues[r20]
                                                    r19 = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r3 = 29222161855783
                                                    r18 = "\173B\229\148"
                                                    r1 = r11(r18, r3)
                                                    ReturnVal = r19[r1]
                                                    r1 = "UDim2"
                                                    r11 = _env[r1]
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r3 = upvalueValues[upvalues[3]]
                                                    r4 = 33639790361904
                                                    r28 = "\014\222\253"
                                                    r12 = r3(r28, r4)
                                                    r1 = r18[r12]
                                                    r18 = -18
                                                    r19 = r11[r1]
                                                    r3 = 0
                                                    r12 = 16
                                                    r1 = 1
                                                    r11 = r19(r1, r18, r3, r12)
                                                    state[ReturnVal] = r11
                                                    state = upvalueValues[r20]
                                                    r19 = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r18 = "\190\174\016\247\162\155,u"
                                                    r3 = 29084100031719
                                                    r1 = r11(r18, r3)
                                                    ReturnVal = r19[r1]
                                                    r1 = "UDim2"
                                                    r11 = _env[r1]
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r3 = upvalueValues[upvalues[3]]
                                                    r4 = 13459988895867
                                                    r28 = "X\172:"
                                                    r12 = r3(r28, r4)
                                                    r1 = r18[r12]
                                                    r19 = r11[r1]
                                                    r18 = 9
                                                    r12 = 98
                                                    r3 = 0
                                                    r1 = 0
                                                    r11 = r19(r1, r18, r3, r12)
                                                    state[ReturnVal] = r11
                                                    state = upvalueValues[r20]
                                                    r19 = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r3 = 6978125466801
                                                    r18 = "!\159N\246\255[\030<\014\003N\249\187UryY\128\242\177\\\021"
                                                    r1 = r11(r18, r3)
                                                    ReturnVal = r19[r1]
                                                    r19 = 1
                                                    state[ReturnVal] = r19
                                                    state = upvalueValues[r20]
                                                    r19 = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r3 = 33519823142136
                                                    r18 = "C{\196\159"
                                                    r1 = r11(r18, r3)
                                                    ReturnVal = r19[r1]
                                                    r18 = "Enum"
                                                    r1 = _env[r18]
                                                    r3 = upvalueValues[upvalues[2]]
                                                    r12 = upvalueValues[upvalues[3]]
                                                    r14 = 7370626321768
                                                    r4 = "\n\164\162\202"
                                                    r28 = r12(r4, r14)
                                                    r18 = r3[r28]
                                                    r11 = r1[r18]
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r3 = upvalueValues[upvalues[3]]
                                                    r28 = "\215\152\022\231\247\027/\244\221\244q\21684"
                                                    r4 = 15444032592919
                                                    r12 = r3(r28, r4)
                                                    r1 = r18[r12]
                                                    r19 = r11[r1]
                                                    state[ReturnVal] = r19
                                                    state = upvalueValues[r20]
                                                    r19 = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r3 = 32879873670094
                                                    r18 = "\205\212\n\212f\151\153\251"
                                                    r1 = r11(r18, r3)
                                                    ReturnVal = r19[r1]
                                                    r19 = 12
                                                    state[ReturnVal] = r19
                                                    state = upvalueValues[r20]
                                                    r19 = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r18 = "\248\246\154\168T\223Nii\236"
                                                    r3 = 29971125794436
                                                    r1 = r11(r18, r3)
                                                    ReturnVal = r19[r1]
                                                    r1 = "Color3"
                                                    r11 = _env[r1]
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r3 = upvalueValues[upvalues[3]]
                                                    r28 = "?\132\012=\180\162w"
                                                    r4 = 25624136347292
                                                    r12 = r3(r28, r4)
                                                    r1 = r18[r12]
                                                    r19 = r11[r1]
                                                    r3 = 190
                                                    r18 = 255
                                                    r1 = 165
                                                    r11 = r19(r1, r18, r3)
                                                    state[ReturnVal] = r11
                                                    state = upvalueValues[r20]
                                                    r19 = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r18 = "8\222\225\230"
                                                    r3 = 31790308358611
                                                    r1 = r11(r18, r3)
                                                    ReturnVal = r19[r1]
                                                    r18 = state
                                                    r11 = state
                                                    r3 = upvalueValues[upvalues[5]]
                                                    state = r3 and (67) or (68)
                                                    r1 = r3
                                                end
                                            else
                                                if state == 67 then
                                                    r12 = upvalueValues[upvalues[2]]
                                                    r28 = upvalueValues[upvalues[3]]
                                                    r14 = "\025\219\131\171<\227\179\176+<\027'S\128\210"
                                                    r31 = 6740600589378
                                                    r4 = r28(r14, r31)
                                                    r3 = r12[r4]
                                                    r1 = r3
                                                    state = 68
                                                end
                                            end
                                        end
                                    else
                                        if state <= 69 then
                                            if state <= 68 then
                                                if state == 68 then
                                                    state = r18
                                                    state = r1 and (69) or (70)
                                                    r19 = r1
                                                end
                                            else
                                                if state == 69 then
                                                    state = r11
                                                    state[ReturnVal] = r19
                                                    state = upvalueValues[r20]
                                                    r19 = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r18 = "Z\218\202\186tX8F\027\021\136\219/\247\236\187\155k3&n\247"
                                                    r3 = 2112619021271
                                                    r1 = r11(r18, r3)
                                                    ReturnVal = r19[r1]
                                                    r19 = 0.92
                                                    state[ReturnVal] = r19
                                                    state = upvalueValues[r20]
                                                    r19 = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r18 = "\0216VS\233>"
                                                    r3 = 10475396174605
                                                    r1 = r11(r18, r3)
                                                    ReturnVal = r19[r1]
                                                    r19 = 3
                                                    state[ReturnVal] = r19
                                                    r19 = "Instance"
                                                    ReturnVal = _env[r19]
                                                    r11 = upvalueValues[upvalues[2]]
                                                    r1 = upvalueValues[upvalues[3]]
                                                    r12 = 19377278542655
                                                    r3 = "\252&\001"
                                                    r18 = r1(r3, r12)
                                                    r19 = r11[r18]
                                                    state = ReturnVal[r19]
                                                    r11 = upvalueValues[upvalues[2]]
                                                    r1 = upvalueValues[upvalues[3]]
                                                    r12 = 21663126398823
                                                    r3 = "W\172\210\021\242mwx\167\164"
                                                    r18 = r1(r3, r12)
                                                    r19 = r11[r18]
                                                    r11 = upvalueValues[r33]
                                                    ReturnVal = state(r19, r11)
                                                    r19 = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r3 = 17154446827316
                                                    r18 = "\152\235\236A"
                                                    r1 = r11(r18, r3)
                                                    state = ReturnVal[r1]
                                                    r1 = "UDim2"
                                                    r11 = _env[r1]
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r3 = upvalueValues[upvalues[3]]
                                                    r28 = "\189C\192"
                                                    r4 = 27637774660165
                                                    r12 = r3(r28, r4)
                                                    r1 = r18[r12]
                                                    ReturnVal = r11[r1]
                                                    r18 = 0
                                                    r3 = 0
                                                    r1 = 0.42
                                                    r12 = 34
                                                    r11 = ReturnVal(r1, r18, r3, r12)
                                                    r19[state] = r11
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r18 = "7\219\160\012\008\020\007\222"
                                                    r3 = 4490036103210
                                                    r1 = r11(r18, r3)
                                                    state = ReturnVal[r1]
                                                    r1 = "UDim2"
                                                    r11 = _env[r1]
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r3 = upvalueValues[upvalues[3]]
                                                    r4 = 1020142731739
                                                    r28 = "\250\173\177"
                                                    r12 = r3(r28, r4)
                                                    r1 = r18[r12]
                                                    ReturnVal = r11[r1]
                                                    r18 = 0
                                                    r12 = 124
                                                    r1 = 0.06
                                                    r3 = 0
                                                    r11 = ReturnVal(r1, r18, r3, r12)
                                                    r19[state] = r11
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r3 = 11033978328082
                                                    r18 = "\199\195}\144"
                                                    r1 = r11(r18, r3)
                                                    state = ReturnVal[r1]
                                                    r11 = upvalueValues[upvalues[2]]
                                                    r1 = upvalueValues[upvalues[3]]
                                                    r12 = 28729809695810
                                                    r3 = "\019\169\021\226\166>"
                                                    r18 = r1(r3, r12)
                                                    ReturnVal = r11[r18]
                                                    r19[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r3 = 8080187756210
                                                    r18 = "$@6A"
                                                    r1 = r11(r18, r3)
                                                    state = ReturnVal[r1]
                                                    r18 = "Enum"
                                                    r1 = _env[r18]
                                                    r3 = upvalueValues[upvalues[2]]
                                                    r12 = upvalueValues[upvalues[3]]
                                                    r14 = 20085318395016
                                                    r4 = "<p\206\192"
                                                    r28 = r12(r4, r14)
                                                    r18 = r3[r28]
                                                    r11 = r1[r18]
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r3 = upvalueValues[upvalues[3]]
                                                    r4 = 20584942413169
                                                    r28 = "*\019\135\008\016\029\178Ujo"
                                                    r12 = r3(r28, r4)
                                                    r1 = r18[r12]
                                                    ReturnVal = r11[r1]
                                                    r19[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r3 = 24778770066706
                                                    r18 = "7\1324\026\239\204\138P"
                                                    r1 = r11(r18, r3)
                                                    state = ReturnVal[r1]
                                                    ReturnVal = 15
                                                    r19[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r3 = 11203215774816
                                                    r18 = "n\015\227\0067\218\143\199\162\161"
                                                    r1 = r11(r18, r3)
                                                    state = ReturnVal[r1]
                                                    r1 = "Color3"
                                                    r11 = _env[r1]
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r3 = upvalueValues[upvalues[3]]
                                                    r4 = 19080078107316
                                                    r28 = " +\001\170\219\006\028"
                                                    r12 = r3(r28, r4)
                                                    r1 = r18[r12]
                                                    ReturnVal = r11[r1]
                                                    r1 = 255
                                                    r18 = 255
                                                    r3 = 255
                                                    r11 = ReturnVal(r1, r18, r3)
                                                    r19[state] = r11
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r18 = "\205e\128d@T\n\199\239\224\002\158)V\161\145"
                                                    r3 = 26578081525848
                                                    r1 = r11(r18, r3)
                                                    state = ReturnVal[r1]
                                                    r1 = "Color3"
                                                    r11 = _env[r1]
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r3 = upvalueValues[upvalues[3]]
                                                    r28 = "E\221\172\212?\195}"
                                                    r4 = 5241005525384
                                                    r12 = r3(r28, r4)
                                                    r1 = r18[r12]
                                                    ReturnVal = r11[r1]
                                                    r1 = 25
                                                    r3 = 110
                                                    r18 = 200
                                                    r11 = ReturnVal(r1, r18, r3)
                                                    r19[state] = r11
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r18 = "W\176\189\208o\198hcb\142`=\025`%"
                                                    r3 = 17535496364005
                                                    r1 = r11(r18, r3)
                                                    state = ReturnVal[r1]
                                                    ReturnVal = 0
                                                    r19[state] = ReturnVal
                                                    r11 = "Instance"
                                                    ReturnVal = _env[r11]
                                                    r1 = upvalueValues[upvalues[2]]
                                                    r18 = upvalueValues[upvalues[3]]
                                                    r28 = 20477809452351
                                                    r12 = "\196R\003"
                                                    r3 = r18(r12, r28)
                                                    r11 = r1[r3]
                                                    state = ReturnVal[r11]
                                                    r1 = upvalueValues[upvalues[2]]
                                                    r18 = upvalueValues[upvalues[3]]
                                                    r12 = "\154\140\242g\199\194F\020"
                                                    r28 = 18700994421252
                                                    r3 = r18(r12, r28)
                                                    r11 = r1[r3]
                                                    ReturnVal = state(r11, r19)
                                                    r11 = upvalueValues[upvalues[2]]
                                                    r1 = upvalueValues[upvalues[3]]
                                                    r3 = "C/\132ZL'49\1512\156\240"
                                                    r12 = 24513621830807
                                                    r18 = r1(r3, r12)
                                                    state = r11[r18]
                                                    r18 = "UDim"
                                                    r1 = _env[r18]
                                                    r3 = upvalueValues[upvalues[2]]
                                                    r12 = upvalueValues[upvalues[3]]
                                                    r14 = 18813260489272
                                                    r4 = "\158-Q"
                                                    r28 = r12(r4, r14)
                                                    r18 = r3[r28]
                                                    r11 = r1[r18]
                                                    r18 = 0
                                                    r3 = 10
                                                    r1 = r11(r18, r3)
                                                    ReturnVal[state] = r1
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r18 = "`\021\030\152~="
                                                    r3 = 26071620743020
                                                    r1 = r11(r18, r3)
                                                    state = ReturnVal[r1]
                                                    ReturnVal = 3
                                                    r19[state] = ReturnVal
                                                    r11 = "Instance"
                                                    ReturnVal = _env[r11]
                                                    r1 = upvalueValues[upvalues[2]]
                                                    r18 = upvalueValues[upvalues[3]]
                                                    r28 = 4773282318510
                                                    r12 = "\210\248\188"
                                                    r3 = r18(r12, r28)
                                                    r11 = r1[r3]
                                                    state = ReturnVal[r11]
                                                    r1 = upvalueValues[upvalues[2]]
                                                    r18 = upvalueValues[upvalues[3]]
                                                    r12 = "\\\188\213\t\1690\127\021\155\151"
                                                    r28 = 16508762054151
                                                    r3 = r18(r12, r28)
                                                    r11 = r1[r3]
                                                    r1 = upvalueValues[r33]
                                                    ReturnVal = state(r11, r1)
                                                    r11 = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r1 = upvalueValues[upvalues[3]]
                                                    r12 = 20858374432240
                                                    r3 = "\173c\176\159"
                                                    r18 = r1(r3, r12)
                                                    state = ReturnVal[r18]
                                                    r18 = "UDim2"
                                                    r1 = _env[r18]
                                                    r3 = upvalueValues[upvalues[2]]
                                                    r12 = upvalueValues[upvalues[3]]
                                                    r4 = "\209~\245"
                                                    r14 = 30397418682186
                                                    r28 = r12(r4, r14)
                                                    r18 = r3[r28]
                                                    ReturnVal = r1[r18]
                                                    r18 = 0.42
                                                    r3 = 0
                                                    r12 = 0
                                                    r28 = 34
                                                    r1 = ReturnVal(r18, r3, r12, r28)
                                                    r11[state] = r1
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r1 = upvalueValues[upvalues[3]]
                                                    r3 = "\205\179\164`\008Aj\207"
                                                    r12 = 13114698323931
                                                    r18 = r1(r3, r12)
                                                    state = ReturnVal[r18]
                                                    r18 = "UDim2"
                                                    r1 = _env[r18]
                                                    r3 = upvalueValues[upvalues[2]]
                                                    r12 = upvalueValues[upvalues[3]]
                                                    r14 = 27598975021619
                                                    r4 = "\208\024/"
                                                    r28 = r12(r4, r14)
                                                    r18 = r3[r28]
                                                    ReturnVal = r1[r18]
                                                    r3 = 0
                                                    r18 = 0.52
                                                    r28 = 124
                                                    r12 = 0
                                                    r1 = ReturnVal(r18, r3, r12, r28)
                                                    r11[state] = r1
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r1 = upvalueValues[upvalues[3]]
                                                    r3 = "L=\2242"
                                                    r12 = 15218485713838
                                                    r18 = r1(r3, r12)
                                                    state = ReturnVal[r18]
                                                    r1 = upvalueValues[upvalues[2]]
                                                    r18 = upvalueValues[upvalues[3]]
                                                    r12 = "\132\240\206\193\t\2289"
                                                    r28 = 15227317345202
                                                    r3 = r18(r12, r28)
                                                    ReturnVal = r1[r3]
                                                    r11[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r1 = upvalueValues[upvalues[3]]
                                                    r12 = 2889999107393
                                                    r3 = "\137\2441C"
                                                    r18 = r1(r3, r12)
                                                    state = ReturnVal[r18]
                                                    r3 = "Enum"
                                                    r18 = _env[r3]
                                                    r12 = upvalueValues[upvalues[2]]
                                                    r28 = upvalueValues[upvalues[3]]
                                                    r31 = 34595764256493
                                                    r14 = "\175\134\162\005"
                                                    r4 = r28(r14, r31)
                                                    r3 = r12[r4]
                                                    r1 = r18[r3]
                                                    r3 = upvalueValues[upvalues[2]]
                                                    r12 = upvalueValues[upvalues[3]]
                                                    r14 = 1706071638810
                                                    r4 = "I0\132\031\228\183\180Y\144\136"
                                                    r28 = r12(r4, r14)
                                                    r18 = r3[r28]
                                                    ReturnVal = r1[r18]
                                                    r11[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r1 = upvalueValues[upvalues[3]]
                                                    r3 = "ySZ\012\228\130`\164"
                                                    r12 = 20044445934709
                                                    r18 = r1(r3, r12)
                                                    state = ReturnVal[r18]
                                                    ReturnVal = 15
                                                    r11[state] = ReturnVal
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r1 = upvalueValues[upvalues[3]]
                                                    r12 = 27049166811443
                                                    r3 = "zE\235\022\197a\153\171\242\130"
                                                    r18 = r1(r3, r12)
                                                    state = ReturnVal[r18]
                                                    r18 = "Color3"
                                                    r1 = _env[r18]
                                                    r3 = upvalueValues[upvalues[2]]
                                                    r12 = upvalueValues[upvalues[3]]
                                                    r4 = "D.,tf\236x"
                                                    r14 = 6196107742021
                                                    r28 = r12(r4, r14)
                                                    r18 = r3[r28]
                                                    ReturnVal = r1[r18]
                                                    r12 = 255
                                                    r18 = 255
                                                    r3 = 255
                                                    r1 = ReturnVal(r18, r3, r12)
                                                    r11[state] = r1
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r1 = upvalueValues[upvalues[3]]
                                                    r3 = "\227n\0314|\011\185\176\255\194(FTG\166\163"
                                                    r12 = 21064588682832
                                                    r18 = r1(r3, r12)
                                                    state = ReturnVal[r18]
                                                    r18 = "Color3"
                                                    r1 = _env[r18]
                                                    r3 = upvalueValues[upvalues[2]]
                                                    r12 = upvalueValues[upvalues[3]]
                                                    r14 = 2898773050693
                                                    r4 = "=\008\186\192\227\0185"
                                                    r28 = r12(r4, r14)
                                                    r18 = r3[r28]
                                                    ReturnVal = r1[r18]
                                                    r18 = 230
                                                    r12 = 65
                                                    r3 = 60
                                                    r1 = ReturnVal(r18, r3, r12)
                                                    r11[state] = r1
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r1 = upvalueValues[upvalues[3]]
                                                    r12 = 34925917454215
                                                    r3 = "\160\133\145\172\181>\148\181|Re\185\251\006\141"
                                                    r18 = r1(r3, r12)
                                                    state = ReturnVal[r18]
                                                    ReturnVal = 0
                                                    r11[state] = ReturnVal
                                                    r1 = "Instance"
                                                    ReturnVal = _env[r1]
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r3 = upvalueValues[upvalues[3]]
                                                    r4 = 29144776439043
                                                    r28 = "\190\192\138"
                                                    r12 = r3(r28, r4)
                                                    r1 = r18[r12]
                                                    state = ReturnVal[r1]
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r3 = upvalueValues[upvalues[3]]
                                                    r28 = "\141\025\001\239\171\226\249\155"
                                                    r4 = 22984091445710
                                                    r12 = r3(r28, r4)
                                                    r1 = r18[r12]
                                                    ReturnVal = state(r1, r11)
                                                    r1 = upvalueValues[upvalues[2]]
                                                    r18 = upvalueValues[upvalues[3]]
                                                    r28 = 20326487762169
                                                    r12 = "\021\217\196(td\128l]80N"
                                                    r3 = r18(r12, r28)
                                                    state = r1[r3]
                                                    r3 = "UDim"
                                                    r18 = _env[r3]
                                                    r12 = upvalueValues[upvalues[2]]
                                                    r28 = upvalueValues[upvalues[3]]
                                                    r31 = 18739174400534
                                                    r14 = "\184\231\243"
                                                    r4 = r28(r14, r31)
                                                    r3 = r12[r4]
                                                    r1 = r18[r3]
                                                    r3 = 0
                                                    r12 = 10
                                                    r18 = r1(r3, r12)
                                                    ReturnVal[state] = r18
                                                    ReturnVal = upvalueValues[upvalues[2]]
                                                    r1 = upvalueValues[upvalues[3]]
                                                    r3 = "1[\203\179\023 "
                                                    r12 = 34187307220527
                                                    r18 = r1(r3, r12)
                                                    state = ReturnVal[r18]
                                                    ReturnVal = 3
                                                    r11[state] = ReturnVal
                                                    r1 = "Instance"
                                                    ReturnVal = _env[r1]
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r3 = upvalueValues[upvalues[3]]
                                                    r4 = 4222193764270
                                                    r28 = "\"IX"
                                                    r12 = r3(r28, r4)
                                                    r1 = r18[r12]
                                                    state = ReturnVal[r1]
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r3 = upvalueValues[upvalues[3]]
                                                    r28 = "\166hX\022\178\"x`\231"
                                                    r4 = 10132883821166
                                                    r12 = r3(r28, r4)
                                                    r1 = r18[r12]
                                                    ReturnVal = state(r1, r2)
                                                    r1 = allocUpvalue()
                                                    upvalueValues[r1] = ReturnVal
                                                    state = upvalueValues[r1]
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r3 = upvalueValues[upvalues[3]]
                                                    r28 = "?\n\rj"
                                                    r4 = 4243940657080
                                                    r12 = r3(r28, r4)
                                                    ReturnVal = r18[r12]
                                                    r12 = "UDim2"
                                                    r3 = _env[r12]
                                                    r28 = upvalueValues[upvalues[2]]
                                                    r4 = upvalueValues[upvalues[3]]
                                                    r25 = 21757690128275
                                                    r31 = "\215\163\183"
                                                    r14 = r4(r31, r25)
                                                    r12 = r28[r14]
                                                    r18 = r3[r12]
                                                    r4 = 0
                                                    r14 = 20
                                                    r28 = 120
                                                    r12 = 0
                                                    r3 = r18(r12, r28, r4, r14)
                                                    state[ReturnVal] = r3
                                                    state = upvalueValues[r1]
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r3 = upvalueValues[upvalues[3]]
                                                    r4 = 30610693273518
                                                    r28 = "7Pc\019\165\002\195|"
                                                    r12 = r3(r28, r4)
                                                    ReturnVal = r18[r12]
                                                    r12 = "UDim2"
                                                    r3 = _env[r12]
                                                    r28 = upvalueValues[upvalues[2]]
                                                    r4 = upvalueValues[upvalues[3]]
                                                    r31 = "d\233\153"
                                                    r25 = 22944935078332
                                                    r14 = r4(r31, r25)
                                                    r12 = r28[r14]
                                                    r14 = -36
                                                    r18 = r3[r12]
                                                    r28 = -130
                                                    r4 = 1
                                                    r12 = 1
                                                    r3 = r18(r12, r28, r4, r14)
                                                    state[ReturnVal] = r3
                                                    state = upvalueValues[r1]
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r3 = upvalueValues[upvalues[3]]
                                                    r4 = 11086939853866
                                                    r28 = "\240\207\241\141g\164\247\197\002\145\23293m\227\202\192\031S4\239'"
                                                    r12 = r3(r28, r4)
                                                    ReturnVal = r18[r12]
                                                    r18 = 0.3
                                                    state[ReturnVal] = r18
                                                    state = upvalueValues[r1]
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r3 = upvalueValues[upvalues[3]]
                                                    r4 = 14239581673958
                                                    r28 = "\182\187\247\025\176\155\139\191(s\217\003\011\029\006\t"
                                                    r12 = r3(r28, r4)
                                                    ReturnVal = r18[r12]
                                                    r12 = "Color3"
                                                    r3 = _env[r12]
                                                    r28 = upvalueValues[upvalues[2]]
                                                    r4 = upvalueValues[upvalues[3]]
                                                    r25 = 13832183732521
                                                    r31 = "\194x\202\1390\181x"
                                                    r14 = r4(r31, r25)
                                                    r12 = r28[r14]
                                                    r18 = r3[r12]
                                                    r28 = 22
                                                    r12 = 18
                                                    r4 = 28
                                                    r3 = r18(r12, r28, r4)
                                                    state[ReturnVal] = r3
                                                    state = upvalueValues[r1]
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r3 = upvalueValues[upvalues[3]]
                                                    r28 = "0\243\158\253\224\196\225\213\238\159"
                                                    r4 = 15860222172377
                                                    r12 = r3(r28, r4)
                                                    ReturnVal = r18[r12]
                                                    r12 = "Color3"
                                                    r3 = _env[r12]
                                                    r28 = upvalueValues[upvalues[2]]
                                                    r4 = upvalueValues[upvalues[3]]
                                                    r25 = 30748343728110
                                                    r31 = "W\181\011\182R\2480"
                                                    r14 = r4(r31, r25)
                                                    r12 = r28[r14]
                                                    r18 = r3[r12]
                                                    r28 = 255
                                                    r4 = 90
                                                    r12 = 10
                                                    r3 = r18(r12, r28, r4)
                                                    state[ReturnVal] = r3
                                                    state = upvalueValues[r1]
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r3 = upvalueValues[upvalues[3]]
                                                    r28 = "\228\179+\241"
                                                    r4 = 34690558164762
                                                    r12 = r3(r28, r4)
                                                    ReturnVal = r18[r12]
                                                    r28 = "Enum"
                                                    r12 = _env[r28]
                                                    r4 = upvalueValues[upvalues[2]]
                                                    r14 = upvalueValues[upvalues[3]]
                                                    r26 = 11073268749348
                                                    r25 = "^t\020\218"
                                                    r31 = r14(r25, r26)
                                                    r28 = r4[r31]
                                                    r3 = r12[r28]
                                                    r28 = upvalueValues[upvalues[2]]
                                                    r4 = upvalueValues[upvalues[3]]
                                                    r25 = 8678669946825
                                                    r31 = "\133\169/Si\245\131\221m\020\146"
                                                    r14 = r4(r31, r25)
                                                    r12 = r28[r14]
                                                    r18 = r3[r12]
                                                    state[ReturnVal] = r18
                                                    state = upvalueValues[r1]
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r3 = upvalueValues[upvalues[3]]
                                                    r4 = 27105161097549
                                                    r28 = "\254,i^k\147\253\150"
                                                    r12 = r3(r28, r4)
                                                    ReturnVal = r18[r12]
                                                    r18 = 13
                                                    state[ReturnVal] = r18
                                                    state = upvalueValues[r1]
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r3 = upvalueValues[upvalues[3]]
                                                    r28 = "\002\\\186\236p\028\017\199\222\158\201\206i\229\165\132#\157\174\159\152\252"
                                                    r4 = 26291754479571
                                                    r12 = r3(r28, r4)
                                                    ReturnVal = r18[r12]
                                                    r18 = 0.3
                                                    state[ReturnVal] = r18
                                                    state = upvalueValues[r1]
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r3 = upvalueValues[upvalues[3]]
                                                    r28 = "*\219+6\195<\242\231\251\200\161S\148\t"
                                                    r4 = 23905987292028
                                                    r12 = r3(r28, r4)
                                                    ReturnVal = r18[r12]
                                                    r28 = "Enum"
                                                    r12 = _env[r28]
                                                    r4 = upvalueValues[upvalues[2]]
                                                    r14 = upvalueValues[upvalues[3]]
                                                    r25 = "\250\008\028\t@R\254\022\223\128\002\192|\128"
                                                    r26 = 29995160204943
                                                    r31 = r14(r25, r26)
                                                    r28 = r4[r31]
                                                    r3 = r12[r28]
                                                    r28 = upvalueValues[upvalues[2]]
                                                    r4 = upvalueValues[upvalues[3]]
                                                    r31 = "\215 \218w\014"
                                                    r25 = 25703146630848
                                                    r14 = r4(r31, r25)
                                                    r12 = r28[r14]
                                                    r18 = r3[r12]
                                                    state[ReturnVal] = r18
                                                    state = upvalueValues[r1]
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r3 = upvalueValues[upvalues[3]]
                                                    r4 = 25612058930838
                                                    r28 = "`?hk"
                                                    r12 = r3(r28, r4)
                                                    ReturnVal = r18[r12]
                                                    r3 = upvalueValues[upvalues[2]]
                                                    r12 = upvalueValues[upvalues[3]]
                                                    r14 = 14855234034437
                                                    r4 = "mhk\220!#\155E~"
                                                    r28 = r12(r4, r14)
                                                    r18 = r3[r28]
                                                    state[ReturnVal] = r18
                                                    r18 = "Instance"
                                                    ReturnVal = _env[r18]
                                                    r3 = upvalueValues[upvalues[2]]
                                                    r12 = upvalueValues[upvalues[3]]
                                                    r4 = "\148\207\252"
                                                    r14 = 17567941353460
                                                    r28 = r12(r4, r14)
                                                    r18 = r3[r28]
                                                    state = ReturnVal[r18]
                                                    r3 = upvalueValues[upvalues[2]]
                                                    r12 = upvalueValues[upvalues[3]]
                                                    r14 = 31808166689243
                                                    r4 = "\222\237\1909>\026\155\211"
                                                    r28 = r12(r4, r14)
                                                    r18 = r3[r28]
                                                    r3 = upvalueValues[r1]
                                                    ReturnVal = state(r18, r3)
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r3 = upvalueValues[upvalues[3]]
                                                    r28 = "8}\017\255/J&\194\158\224\185P"
                                                    r4 = 735450612054
                                                    r12 = r3(r28, r4)
                                                    state = r18[r12]
                                                    r12 = "UDim"
                                                    r3 = _env[r12]
                                                    r28 = upvalueValues[upvalues[2]]
                                                    r4 = upvalueValues[upvalues[3]]
                                                    r31 = "\022w\153"
                                                    r25 = 20466714404154
                                                    r14 = r4(r31, r25)
                                                    r12 = r28[r14]
                                                    r18 = r3[r12]
                                                    r28 = 8
                                                    r12 = 0
                                                    r3 = r18(r12, r28)
                                                    ReturnVal[state] = r3
                                                    state = upvalueValues[r1]
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r3 = upvalueValues[upvalues[3]]
                                                    r4 = 31549712038243
                                                    r28 = "\192\216Y\028\187\166"
                                                    r12 = r3(r28, r4)
                                                    ReturnVal = r18[r12]
                                                    r18 = 4
                                                    state[ReturnVal] = r18
                                                    r18 = allocUpvalue()
                                                    r12 = allocUpvalue()
                                                    r3 = allocUpvalue()
                                                    state = nil
                                                    upvalueValues[r18] = state
                                                    state = nil
                                                    upvalueValues[r3] = state
                                                    state = nil
                                                    upvalueValues[r12] = state
                                                    ReturnVal = upvalueValues[r33]
                                                    r4 = upvalueValues[upvalues[2]]
                                                    r14 = upvalueValues[upvalues[3]]
                                                    r26 = 29880227067482
                                                    r25 = ")V[\026\140\154g&T\132"
                                                    r31 = r14(r25, r26)
                                                    r28 = r4[r31]
                                                    state = ReturnVal[r28]
                                                    r28 = createClosure1(79, {
                                                        upvalues[2],
                                                        upvalues[3],
                                                        r18,
                                                        r3,
                                                        r33,
                                                        r12
                                                    })
                                                    ReturnVal = "Connect"
                                                    ReturnVal = state[ReturnVal]
                                                    ReturnVal = ReturnVal(state, r28)
                                                    ReturnVal = upvalueValues[r33]
                                                    r4 = upvalueValues[upvalues[2]]
                                                    r14 = upvalueValues[upvalues[3]]
                                                    r25 = "@\129x\151\147\192\196\r\241z@'"
                                                    r26 = 13106056239062
                                                    r31 = r14(r25, r26)
                                                    r28 = r4[r31]
                                                    state = ReturnVal[r28]
                                                    r28 = createClosure6(84, {
                                                        r18,
                                                        upvalues[2],
                                                        upvalues[3],
                                                        r3,
                                                        r33,
                                                        r12
                                                    })
                                                    ReturnVal = "Connect"
                                                    ReturnVal = state[ReturnVal]
                                                    ReturnVal = ReturnVal(state, r28)
                                                    state = upvalueValues[r33]
                                                    r28 = upvalueValues[upvalues[2]]
                                                    r4 = upvalueValues[upvalues[3]]
                                                    r31 = "\208 \030\197\n^\138"
                                                    r25 = 26306721869786
                                                    r14 = r4(r31, r25)
                                                    ReturnVal = r28[r14]
                                                    r28 = true
                                                    state[ReturnVal] = r28
                                                    state = upvalueValues[r33]
                                                    r28 = upvalueValues[upvalues[2]]
                                                    r4 = upvalueValues[upvalues[3]]
                                                    r31 = "\209l\228P)\014\221P"
                                                    r25 = 23065388394996
                                                    r14 = r4(r31, r25)
                                                    ReturnVal = r28[r14]
                                                    r14 = "UDim2"
                                                    r4 = _env[r14]
                                                    r31 = upvalueValues[upvalues[2]]
                                                    r25 = upvalueValues[upvalues[3]]
                                                    r13 = "\213h\176"
                                                    r30 = 10335641359052
                                                    r26 = r25(r13, r30)
                                                    r14 = r31[r26]
                                                    r28 = r4[r14]
                                                    r31 = -105
                                                    r14 = 0.5
                                                    r26 = 200
                                                    r25 = 1
                                                    r4 = r28(r14, r31, r25, r26)
                                                    state[ReturnVal] = r4
                                                    state = upvalueValues[upvalues[6]]
                                                    r28 = upvalueValues[r33]
                                                    r31 = "TweenInfo"
                                                    r14 = _env[r31]
                                                    r25 = upvalueValues[upvalues[2]]
                                                    r26 = upvalueValues[upvalues[3]]
                                                    r32 = 12036371224036
                                                    r30 = "\212C\254"
                                                    r13 = r26(r30, r32)
                                                    r31 = r25[r13]
                                                    r4 = r14[r31]
                                                    r30 = "Enum"
                                                    r13 = _env[r30]
                                                    r32 = upvalueValues[upvalues[2]]
                                                    r29 = upvalueValues[upvalues[3]]
                                                    r8 = "\n%\024\237u\188\219\n\186\169\030"
                                                    r5 = 11448929490131
                                                    r15 = r29(r8, r5)
                                                    r30 = r32[r15]
                                                    r26 = r13[r30]
                                                    r30 = upvalueValues[upvalues[2]]
                                                    r32 = upvalueValues[upvalues[3]]
                                                    r8 = 21848950892478
                                                    r15 = "\203>\220\029"
                                                    r29 = r32(r15, r8)
                                                    r13 = r30[r29]
                                                    r25 = r26[r13]
                                                    r32 = "Enum"
                                                    r30 = _env[r32]
                                                    r29 = upvalueValues[upvalues[2]]
                                                    r15 = upvalueValues[upvalues[3]]
                                                    r23 = 19523710706563
                                                    r5 = "\183WL\024I\222\237\186\240\209^\210\023\177\137"
                                                    r8 = r15(r5, r23)
                                                    r32 = r29[r8]
                                                    r13 = r30[r32]
                                                    r32 = upvalueValues[upvalues[2]]
                                                    r29 = upvalueValues[upvalues[3]]
                                                    r5 = 30443163875168
                                                    r8 = "\161\186\155"
                                                    r15 = r29(r8, r5)
                                                    r30 = r32[r15]
                                                    r26 = r13[r30]
                                                    r31 = 0.7
                                                    r14 = r4(r31, r25, r26)
                                                    r25 = upvalueValues[upvalues[2]]
                                                    r26 = upvalueValues[upvalues[3]]
                                                    r32 = 21122823399020
                                                    r30 = "\145E\184//gE\211"
                                                    r13 = r26(r30, r32)
                                                    r31 = r25[r13]
                                                    ReturnVal = "Create"
                                                    ReturnVal = state[ReturnVal]
                                                    r13 = "UDim2"
                                                    r26 = _env[r13]
                                                    r30 = upvalueValues[upvalues[2]]
                                                    r32 = upvalueValues[upvalues[3]]
                                                    r8 = 2913617937740
                                                    r15 = "\182]\216"
                                                    r29 = r32(r15, r8)
                                                    r13 = r30[r29]
                                                    r25 = r26[r13]
                                                    r30 = -105
                                                    r29 = -87
                                                    r13 = 0.5
                                                    r32 = 0.7
                                                    r26 = r25(r13, r30, r32, r29)
                                                    r4 = {
                                                        [r31] = r26
                                                    }
                                                    ReturnVal = ReturnVal(state, r28, r14, r4)
                                                    state = "Play"
                                                    state = ReturnVal[state]
                                                    state = state(ReturnVal)
                                                    state = createClosure5(91, {
                                                        upvalues[2],
                                                        upvalues[3],
                                                        upvalues[6]
                                                    })
                                                    r28 = state
                                                    r14 = "Color3"
                                                    r4 = _env[r14]
                                                    r31 = upvalueValues[upvalues[2]]
                                                    r25 = upvalueValues[upvalues[3]]
                                                    r30 = 5867481139884
                                                    r13 = "y\005\167\136j\255\128"
                                                    r26 = r25(r13, r30)
                                                    r14 = r31[r26]
                                                    ReturnVal = r4[r14]
                                                    r25 = 110
                                                    r31 = 200
                                                    r14 = 25
                                                    r4 = {
                                                        ReturnVal(r14, r31, r25)
                                                    }
                                                    state = r28(r19, unpack(r4))
                                                    r14 = "Color3"
                                                    r4 = _env[r14]
                                                    r31 = upvalueValues[upvalues[2]]
                                                    r25 = upvalueValues[upvalues[3]]
                                                    r30 = 32037569313350
                                                    r13 = "\151\025?%\018\213\198"
                                                    r26 = r25(r13, r30)
                                                    r14 = r31[r26]
                                                    ReturnVal = r4[r14]
                                                    r25 = 65
                                                    r14 = 230
                                                    r31 = 60
                                                    r4 = {
                                                        ReturnVal(r14, r31, r25)
                                                    }
                                                    r31 = allocUpvalue()
                                                    r14 = allocUpvalue()
                                                    state = r28(r11, unpack(r4))
                                                    ReturnVal = "spawn"
                                                    state = _env[ReturnVal]
                                                    r4 = createClosure2(92, {
                                                        r1,
                                                        upvalues[2],
                                                        upvalues[3]
                                                    })
                                                    r25 = allocUpvalue()
                                                    ReturnVal = state(r4)
                                                    r4 = allocUpvalue()
                                                    state = createClosure5(96, {
                                                        upvalues[2],
                                                        upvalues[3]
                                                    })
                                                    upvalueValues[r4] = state
                                                    state = createClosure0(100, {
                                                        upvalues[1],
                                                        upvalues[2],
                                                        upvalues[3]
                                                    })
                                                    upvalueValues[r14] = state
                                                    state = createClosure5(113, {
                                                        upvalues[2],
                                                        upvalues[3]
                                                    })
                                                    upvalueValues[r31] = state
                                                    state = createClosure4(129, {
                                                        upvalues[5],
                                                        r20,
                                                        upvalues[2],
                                                        upvalues[3],
                                                        upvalues[6],
                                                        r4,
                                                        r14,
                                                        upvalues[1],
                                                        r31,
                                                        upvalues[7]
                                                    })
                                                    upvalueValues[r25] = state
                                                    r26 = allocUpvalue()
                                                    state = createClosure5(132, {
                                                        upvalues[5],
                                                        r20,
                                                        upvalues[2],
                                                        upvalues[3],
                                                        upvalues[6],
                                                        upvalues[7]
                                                    })
                                                    upvalueValues[r26] = state
                                                    r13 = upvalueValues[upvalues[2]]
                                                    r30 = upvalueValues[upvalues[3]]
                                                    r15 = 11671428764986
                                                    r29 = ".\132v4\242\219i\137\160\206iN)j\181=\003"
                                                    r32 = r30(r29, r15)
                                                    ReturnVal = r13[r32]
                                                    r13 = createClosure4(135, {
                                                        upvalues[5],
                                                        r25
                                                    })
                                                    state = r19[ReturnVal]
                                                    ReturnVal = "Connect"
                                                    ReturnVal = state[ReturnVal]
                                                    ReturnVal = ReturnVal(state, r13)
                                                    r13 = upvalueValues[upvalues[2]]
                                                    r30 = upvalueValues[upvalues[3]]
                                                    r15 = 30978605643865
                                                    r29 = "\158W\145}@\218\201\170b\208\174\n\176l\005\227\145"
                                                    r32 = r30(r29, r15)
                                                    ReturnVal = r13[r32]
                                                    state = r11[ReturnVal]
                                                    ReturnVal = "Connect"
                                                    ReturnVal = state[ReturnVal]
                                                    r13 = createClosure1(138, {
                                                        upvalues[5],
                                                        r26
                                                    })
                                                    ReturnVal = ReturnVal(state, r13)
                                                    ReturnVal = {
                                                        r2
                                                    }
                                                    state = nil
                                                end
                                            end
                                        else
                                            if state == 70 then
                                                r18 = upvalueValues[upvalues[2]]
                                                r3 = upvalueValues[upvalues[3]]
                                                r4 = 20005439136867
                                                r28 = "Jz\191\194\199\173\242p8A\235\205\192X\226c"
                                                r12 = r3(r28, r4)
                                                r1 = r18[r12]
                                                r19 = r1
                                                state = 69
                                            end
                                        end
                                    end
                                else
                                    -- createClosure4 entry 3421943 -> 71, states 71-76
                                    if state <= 73 then
                                        if state <= 72 then
                                            if state <= 71 then
                                                if state == 71 then -- entry 3421943 -> 71
                                                    state = 72
                                                end
                                            else
                                                if state == 72 then
                                                    state = true
                                                    state = state and (73) or (74)
                                                end
                                            end
                                        else
                                            if state == 73 then
                                                r2 = upvalueValues[upvalues[1]]
                                                r17 = upvalueValues[upvalues[2]]
                                                r27 = upvalueValues[upvalues[3]]
                                                r22 = "$o\190\153_6\006S\023"
                                                r24 = 30529002862472
                                                r10 = r27(r22, r24)
                                                r33 = r17[r10]
                                                r9 = r2[r33]
                                                r33 = upvalueValues[upvalues[4]]
                                                r2 = "FindFirstChild"
                                                r2 = r9[r2]
                                                r2 = r2(r9, r33)
                                                state = r2 and (75) or (76)
                                                ReturnVal = r2
                                            end
                                        end
                                    else
                                        if state <= 75 then
                                            if state <= 74 then
                                                if state == 74 then
                                                    ReturnVal = {}
                                                    state = nil
                                                end
                                            else
                                                if state == 75 then
                                                    r9 = allocUpvalue()
                                                    upvalueValues[r9] = ReturnVal
                                                    ReturnVal = upvalueValues[r9]
                                                    r33 = upvalueValues[upvalues[2]]
                                                    r17 = upvalueValues[upvalues[3]]
                                                    r10 = "\1291\240X\228\0172U\234F\244\196$\007\203"
                                                    r22 = 7861189004876
                                                    r27 = r17(r10, r22)
                                                    r2 = r33[r27]
                                                    state = ReturnVal[r2]
                                                    r2 = createClosure4(141, {
                                                        r9,
                                                        upvalues[5]
                                                    })
                                                    ReturnVal = "Connect"
                                                    ReturnVal = state[ReturnVal]
                                                    ReturnVal = ReturnVal(state, r2)
                                                    r9 = releaseUpvalue(r9)
                                                    ReturnVal = "wait"
                                                    state = _env[ReturnVal]
                                                    r2 = 1
                                                    ReturnVal = state(r2)
                                                    state = 72
                                                end
                                            end
                                        else
                                            if state == 76 then
                                                r9 = upvalueValues[upvalues[5]]
                                                r2 = r9()
                                                ReturnVal = r2
                                                state = 75
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 77 then
                                    -- createClosure2 entry 11693274 -> 77, states 77-77
                                    if state == 77 then -- entry 11693274 -> 77
                                        ReturnVal = "wait"
                                        state = _env[ReturnVal]
                                        r9 = 0.1
                                        ReturnVal = state(r9)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                else
                                    -- createClosure0 entry 9299125 -> 78, states 78-78
                                    if state == 78 then -- entry 9299125 -> 78
                                        r33 = 13587328
                                        r2 = "zcbdDSDO60SUhP"
                                        r9 = r2 ^ r33
                                        ReturnVal = 4216266
                                        state = ReturnVal - r9
                                        r9 = state
                                        ReturnVal = "CyCLX5DWLqR"
                                        state = ReturnVal / r9
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                end
                            end
                        else
                            if state <= 90 then
                                if state <= 83 then
                                    -- createClosure1 entry 14051064 -> 79, states 79-83
                                    if state <= 81 then
                                        if state <= 80 then
                                            if state <= 79 then
                                                if state == 79 then -- entry 14051064 -> 79
                                                    r9 = allocUpvalue()
                                                    upvalueValues[r9] = args[1]
                                                    r17 = upvalueValues[r9]
                                                    r10 = upvalueValues[upvalues[1]]
                                                    r22 = upvalueValues[upvalues[2]]
                                                    r19 = 8266433744649
                                                    r20 = "#{\175\150\020\192\185\026\008\021\185\166\004"
                                                    r24 = r22(r20, r19)
                                                    r27 = r10[r24]
                                                    r33 = r17[r27]
                                                    r22 = "Enum"
                                                    r10 = _env[r22]
                                                    r24 = upvalueValues[upvalues[1]]
                                                    r20 = upvalueValues[upvalues[2]]
                                                    r1 = 16691827695196
                                                    r11 = "\030\197\023\228S\017G\205\215Z\134J\147"
                                                    r19 = r20(r11, r1)
                                                    r22 = r24[r19]
                                                    r27 = r10[r22]
                                                    r22 = upvalueValues[upvalues[1]]
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r11 = 13435029362800
                                                    r19 = "\162\237\127\242\134\r\205q\210\199\255\165"
                                                    r20 = r24(r19, r11)
                                                    r10 = r22[r20]
                                                    r17 = r27[r10]
                                                    r2 = r33 == r17
                                                    state = r2 and (80) or (81)
                                                    ReturnVal = r2
                                                end
                                            else
                                                if state == 80 then
                                                    state = ReturnVal and (82) or (83)
                                                end
                                            end
                                        else
                                            if state == 81 then
                                                r17 = upvalueValues[r9]
                                                r10 = upvalueValues[upvalues[1]]
                                                r22 = upvalueValues[upvalues[2]]
                                                r20 = "\238+\155I\247A3kWk\152\142\029"
                                                r19 = 7269368876345
                                                r24 = r22(r20, r19)
                                                r27 = r10[r24]
                                                r33 = r17[r27]
                                                r22 = "Enum"
                                                r10 = _env[r22]
                                                r24 = upvalueValues[upvalues[1]]
                                                r20 = upvalueValues[upvalues[2]]
                                                r11 = "\008\1989C\229\004\172\1375\155\134\134\212"
                                                r1 = 20914021459466
                                                r19 = r20(r11, r1)
                                                r22 = r24[r19]
                                                r27 = r10[r22]
                                                r22 = upvalueValues[upvalues[1]]
                                                r24 = upvalueValues[upvalues[2]]
                                                r19 = "\179p\142;`"
                                                r11 = 23567913200350
                                                r20 = r24(r19, r11)
                                                r10 = r22[r20]
                                                r17 = r27[r10]
                                                r2 = r33 == r17
                                                ReturnVal = r2
                                                state = 80
                                            end
                                        end
                                    else
                                        if state <= 82 then
                                            if state == 82 then
                                                state = true
                                                upvalueValues[upvalues[3]] = state
                                                r2 = upvalueValues[r9]
                                                r17 = upvalueValues[upvalues[1]]
                                                r27 = upvalueValues[upvalues[2]]
                                                r22 = "\011*\1559V\218\158p"
                                                r24 = 11513309533425
                                                r10 = r27(r22, r24)
                                                r33 = r17[r10]
                                                ReturnVal = r2[r33]
                                                upvalueValues[upvalues[4]] = ReturnVal
                                                r33 = upvalueValues[upvalues[5]]
                                                r27 = upvalueValues[upvalues[1]]
                                                r10 = upvalueValues[upvalues[2]]
                                                r24 = "\139\165AQJz\146\251"
                                                r20 = 7487339482526
                                                r22 = r10(r24, r20)
                                                r17 = r27[r22]
                                                r2 = r33[r17]
                                                upvalueValues[upvalues[6]] = r2
                                                r17 = upvalueValues[r9]
                                                r10 = upvalueValues[upvalues[1]]
                                                r22 = upvalueValues[upvalues[2]]
                                                r20 = "\2156\141@\226:\189"
                                                r19 = 18994234368652
                                                r24 = r22(r20, r19)
                                                r27 = r10[r24]
                                                r33 = r17[r27]
                                                r17 = "Connect"
                                                r17 = r33[r17]
                                                r27 = createClosure1(144, {
                                                    r9,
                                                    upvalues[1],
                                                    upvalues[2],
                                                    upvalues[3]
                                                })
                                                r17 = r17(r33, r27)
                                                state = 83
                                            end
                                        else
                                            if state == 83 then
                                                ReturnVal = {}
                                                r9 = releaseUpvalue(r9)
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    -- createClosure6 entry 456879 -> 84, states 84-90
                                    if state <= 87 then
                                        if state <= 85 then
                                            if state <= 84 then
                                                if state == 84 then -- entry 456879 -> 84
                                                    r2 = upvalueValues[upvalues[1]]
                                                    r9 = args[1]
                                                    state = r2 and (85) or (86)
                                                    ReturnVal = r2
                                                end
                                            else
                                                if state == 85 then
                                                    r33 = state
                                                    r22 = upvalueValues[upvalues[2]]
                                                    r24 = upvalueValues[upvalues[3]]
                                                    r19 = "NvN\142\136B'\187\128\190\243\186,"
                                                    r11 = 34434501508770
                                                    r20 = r24(r19, r11)
                                                    r10 = r22[r20]
                                                    r27 = r9[r10]
                                                    r20 = "Enum"
                                                    r24 = _env[r20]
                                                    r19 = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r18 = ",\190\161\023\162\004\000\209\020\251t\170\160"
                                                    r3 = 28797787681890
                                                    r1 = r11(r18, r3)
                                                    r20 = r19[r1]
                                                    r22 = r24[r20]
                                                    r20 = upvalueValues[upvalues[2]]
                                                    r19 = upvalueValues[upvalues[3]]
                                                    r18 = 12612242314993
                                                    r1 = "\235\169\216\239\173\177e\133\030n\225W\027"
                                                    r11 = r19(r1, r18)
                                                    r24 = r20[r11]
                                                    r10 = r22[r24]
                                                    r17 = r27 == r10
                                                    state = r17 and (87) or (88)
                                                    r2 = r17
                                                end
                                            end
                                        else
                                            if state <= 86 then
                                                if state == 86 then
                                                    state = ReturnVal and (89) or (90)
                                                end
                                            else
                                                if state == 87 then
                                                    state = r33
                                                    ReturnVal = r2
                                                    state = 86
                                                end
                                            end
                                        end
                                    else
                                        if state <= 89 then
                                            if state <= 88 then
                                                if state == 88 then
                                                    r22 = upvalueValues[upvalues[2]]
                                                    r24 = upvalueValues[upvalues[3]]
                                                    r11 = 10323398169287
                                                    r19 = "sVTB\157F\179\208\1555\002o\025"
                                                    r20 = r24(r19, r11)
                                                    r10 = r22[r20]
                                                    r27 = r9[r10]
                                                    r20 = "Enum"
                                                    r24 = _env[r20]
                                                    r19 = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r18 = "c\1711#\011ouO\005\236\241X$"
                                                    r3 = 2292085523499
                                                    r1 = r11(r18, r3)
                                                    r20 = r19[r1]
                                                    r22 = r24[r20]
                                                    r20 = upvalueValues[upvalues[2]]
                                                    r19 = upvalueValues[upvalues[3]]
                                                    r18 = 4533031307326
                                                    r1 = "~\237(\000\128"
                                                    r11 = r19(r1, r18)
                                                    r24 = r20[r11]
                                                    r10 = r22[r24]
                                                    r17 = r27 == r10
                                                    r2 = r17
                                                    state = 87
                                                end
                                            else
                                                if state == 89 then
                                                    r33 = upvalueValues[upvalues[2]]
                                                    r17 = upvalueValues[upvalues[3]]
                                                    r10 = "\208\1977\016\179W\242\027"
                                                    r22 = 1430780543642
                                                    r27 = r17(r10, r22)
                                                    r2 = r33[r27]
                                                    ReturnVal = r9[r2]
                                                    r2 = upvalueValues[upvalues[4]]
                                                    state = ReturnVal - r2
                                                    r2 = state
                                                    state = upvalueValues[upvalues[5]]
                                                    r33 = upvalueValues[upvalues[2]]
                                                    r17 = upvalueValues[upvalues[3]]
                                                    r10 = "3\129\004\160Z\190\241\151"
                                                    r22 = 26198072831911
                                                    r27 = r17(r10, r22)
                                                    ReturnVal = r33[r27]
                                                    r27 = "UDim2"
                                                    r17 = _env[r27]
                                                    r10 = upvalueValues[upvalues[2]]
                                                    r22 = upvalueValues[upvalues[3]]
                                                    r19 = 34528191512270
                                                    r20 = "9P>"
                                                    r24 = r22(r20, r19)
                                                    r27 = r10[r24]
                                                    r33 = r17[r27]
                                                    r22 = upvalueValues[upvalues[6]]
                                                    r20 = upvalueValues[upvalues[2]]
                                                    r19 = upvalueValues[upvalues[3]]
                                                    r18 = 27133927174491
                                                    r1 = "4"
                                                    r11 = r19(r1, r18)
                                                    r24 = r20[r11]
                                                    r10 = r22[r24]
                                                    r24 = upvalueValues[upvalues[2]]
                                                    r20 = upvalueValues[upvalues[3]]
                                                    r1 = 16625759657533
                                                    r11 = ">_\2518\017"
                                                    r19 = r20(r11, r1)
                                                    r22 = r24[r19]
                                                    r27 = r10[r22]
                                                    r20 = upvalueValues[upvalues[6]]
                                                    r11 = upvalueValues[upvalues[2]]
                                                    r1 = upvalueValues[upvalues[3]]
                                                    r12 = 14199053441491
                                                    r3 = "8"
                                                    r18 = r1(r3, r12)
                                                    r19 = r11[r18]
                                                    r24 = r20[r19]
                                                    r19 = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r3 = 9517496422735
                                                    r18 = "OW\186\231\255O"
                                                    r1 = r11(r18, r3)
                                                    r20 = r19[r1]
                                                    r22 = r24[r20]
                                                    r19 = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r3 = 13249554241561
                                                    r18 = "<"
                                                    r1 = r11(r18, r3)
                                                    r20 = r19[r1]
                                                    r24 = r2[r20]
                                                    r10 = r22 + r24
                                                    r20 = upvalueValues[upvalues[6]]
                                                    r11 = upvalueValues[upvalues[2]]
                                                    r1 = upvalueValues[upvalues[3]]
                                                    r12 = 14934504069930
                                                    r3 = "\204"
                                                    r18 = r1(r3, r12)
                                                    r19 = r11[r18]
                                                    r24 = r20[r19]
                                                    r19 = upvalueValues[upvalues[2]]
                                                    r11 = upvalueValues[upvalues[3]]
                                                    r3 = 29984210826890
                                                    r18 = "\246h\243\019\008"
                                                    r1 = r11(r18, r3)
                                                    r20 = r19[r1]
                                                    r22 = r24[r20]
                                                    r11 = upvalueValues[upvalues[6]]
                                                    r18 = upvalueValues[upvalues[2]]
                                                    r3 = upvalueValues[upvalues[3]]
                                                    r4 = 9614894174589
                                                    r28 = "\r"
                                                    r12 = r3(r28, r4)
                                                    r1 = r18[r12]
                                                    r19 = r11[r1]
                                                    r1 = upvalueValues[upvalues[2]]
                                                    r18 = upvalueValues[upvalues[3]]
                                                    r28 = 9630359032196
                                                    r12 = "\213C\129\234\225\""
                                                    r3 = r18(r12, r28)
                                                    r11 = r1[r3]
                                                    r20 = r19[r11]
                                                    r1 = upvalueValues[upvalues[2]]
                                                    r18 = upvalueValues[upvalues[3]]
                                                    r12 = "\185"
                                                    r28 = 3066272482707
                                                    r3 = r18(r12, r28)
                                                    r11 = r1[r3]
                                                    r19 = r2[r11]
                                                    r24 = r20 + r19
                                                    r17 = r33(r27, r10, r22, r24)
                                                    r2 = nil
                                                    state[ReturnVal] = r17
                                                    state = 90
                                                end
                                            end
                                        else
                                            if state == 90 then
                                                r9 = nil
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 91 then
                                    -- createClosure5 entry 14234299 -> 91, states 91-91
                                    if state == 91 then -- entry 14234299 -> 91
                                        r9 = allocUpvalue()
                                        upvalueValues[r9] = args[1]
                                        r2 = allocUpvalue()
                                        r33 = createClosure0(147, {
                                            r9,
                                            upvalues[1],
                                            upvalues[2],
                                            upvalues[3],
                                            r2
                                        })
                                        r9 = releaseUpvalue(r9)
                                        upvalueValues[r2] = args[2]
                                        r2 = releaseUpvalue(r2)
                                        ReturnVal = "spawn"
                                        state = _env[ReturnVal]
                                        ReturnVal = state(r33)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                else
                                    -- createClosure2 entry 4008918 -> 92, states 92-95
                                    if state <= 93 then
                                        if state <= 92 then
                                            if state == 92 then -- entry 4008918 -> 92
                                                state = 0
                                                r9 = state
                                                state = 93
                                            end
                                        else
                                            if state == 93 then
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                r33 = upvalueValues[upvalues[2]]
                                                r17 = upvalueValues[upvalues[3]]
                                                r22 = 29732654020117
                                                r10 = "\182\204\229ba\165"
                                                r27 = r17(r10, r22)
                                                r2 = r33[r27]
                                                state = ReturnVal[r2]
                                                state = state and (94) or (95)
                                            end
                                        end
                                    else
                                        if state <= 94 then
                                            if state == 94 then
                                                r33 = "math"
                                                ReturnVal = 0.05
                                                state = r9 + ReturnVal
                                                r2 = _env[r33]
                                                r17 = upvalueValues[upvalues[2]]
                                                r27 = upvalueValues[upvalues[3]]
                                                r22 = "\003r\174\2549"
                                                r24 = 15384977579004
                                                r10 = r27(r22, r24)
                                                r33 = r17[r10]
                                                ReturnVal = r2[r33]
                                                r9 = state
                                                r17 = 10
                                                r24 = "math"
                                                r22 = _env[r24]
                                                r20 = upvalueValues[upvalues[2]]
                                                r19 = upvalueValues[upvalues[3]]
                                                r18 = 10102751466080
                                                r1 = "\226\218\180"
                                                r11 = r19(r1, r18)
                                                r24 = r20[r11]
                                                r10 = r22[r24]
                                                r19 = "math"
                                                r20 = _env[r19]
                                                r11 = upvalueValues[upvalues[2]]
                                                r1 = upvalueValues[upvalues[3]]
                                                r12 = 9482785984831
                                                r3 = "x\219q"
                                                r18 = r1(r3, r12)
                                                r19 = r11[r18]
                                                r24 = r20[r19]
                                                r20 = {
                                                    r24(r9)
                                                }
                                                r22 = r10(unpack(r20))
                                                r10 = 45
                                                r27 = r22 * r10
                                                r33 = r17 + r27
                                                r2 = ReturnVal(r33)
                                                r17 = "math"
                                                r33 = _env[r17]
                                                r27 = upvalueValues[upvalues[2]]
                                                r10 = upvalueValues[upvalues[3]]
                                                r24 = "T\243\128gb"
                                                r20 = 10184816300678
                                                r22 = r10(r24, r20)
                                                r17 = r27[r22]
                                                ReturnVal = r33[r17]
                                                r20 = "math"
                                                r24 = _env[r20]
                                                r19 = upvalueValues[upvalues[2]]
                                                r11 = upvalueValues[upvalues[3]]
                                                r3 = 19717645640669
                                                r18 = "\232\020?"
                                                r1 = r11(r18, r3)
                                                r20 = r19[r1]
                                                r22 = r24[r20]
                                                r11 = "math"
                                                r19 = _env[r11]
                                                r1 = upvalueValues[upvalues[2]]
                                                r18 = upvalueValues[upvalues[3]]
                                                r28 = 19113145017028
                                                r12 = "O\024\226"
                                                r3 = r18(r12, r28)
                                                r11 = r1[r3]
                                                r20 = r19[r11]
                                                r1 = 2
                                                r11 = r9 + r1
                                                r19 = {
                                                    r20(r11)
                                                }
                                                r24 = r22(unpack(r19))
                                                r22 = 30
                                                r10 = r24 * r22
                                                r27 = 220
                                                r17 = r27 + r10
                                                r33 = ReturnVal(r17)
                                                r27 = "math"
                                                r17 = _env[r27]
                                                r10 = upvalueValues[upvalues[2]]
                                                r22 = upvalueValues[upvalues[3]]
                                                r20 = "\229r\166\158\159"
                                                r19 = 13251088783386
                                                r24 = r22(r20, r19)
                                                r27 = r10[r24]
                                                ReturnVal = r17[r27]
                                                r19 = "math"
                                                r20 = _env[r19]
                                                r11 = upvalueValues[upvalues[2]]
                                                r1 = upvalueValues[upvalues[3]]
                                                r3 = "R\021\196"
                                                r12 = 10839995421623
                                                r18 = r1(r3, r12)
                                                r19 = r11[r18]
                                                r24 = r20[r19]
                                                r1 = "math"
                                                r11 = _env[r1]
                                                r18 = upvalueValues[upvalues[2]]
                                                r3 = upvalueValues[upvalues[3]]
                                                r4 = 6994161323192
                                                r28 = "\219\131\206"
                                                r12 = r3(r28, r4)
                                                r1 = r18[r12]
                                                r19 = r11[r1]
                                                r18 = 4
                                                r1 = r9 + r18
                                                r11 = {
                                                    r19(r1)
                                                }
                                                r20 = r24(unpack(r11))
                                                r24 = 80
                                                r22 = r20 * r24
                                                r10 = 90
                                                r27 = r10 + r22
                                                r17 = ReturnVal(r27)
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                r10 = upvalueValues[upvalues[2]]
                                                r22 = upvalueValues[upvalues[3]]
                                                r19 = 23586730142439
                                                r20 = "3(~\224\210\172|\248\138j"
                                                r24 = r22(r20, r19)
                                                r27 = r10[r24]
                                                r24 = "Color3"
                                                r22 = _env[r24]
                                                r20 = upvalueValues[upvalues[2]]
                                                r19 = upvalueValues[upvalues[3]]
                                                r1 = "y3&64\140\179"
                                                r18 = 22876366645660
                                                r11 = r19(r1, r18)
                                                r24 = r20[r11]
                                                r10 = r22[r24]
                                                r22 = r10(r2, r33, r17)
                                                ReturnVal[r27] = r22
                                                r11 = 10251308929701
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                r10 = upvalueValues[upvalues[2]]
                                                r22 = upvalueValues[upvalues[3]]
                                                r19 = 18443090813324
                                                r20 = "\171\198_L"
                                                r24 = r22(r20, r19)
                                                r27 = r10[r24]
                                                r19 = "\026\153\155P\136:\128gS"
                                                r22 = upvalueValues[upvalues[2]]
                                                r17 = nil
                                                r24 = upvalueValues[upvalues[3]]
                                                r20 = r24(r19, r11)
                                                r10 = r22[r20]
                                                ReturnVal[r27] = r10
                                                r2 = nil
                                                r33 = nil
                                                r27 = "wait"
                                                ReturnVal = _env[r27]
                                                r10 = 0.06
                                                r27 = ReturnVal(r10)
                                                state = 93
                                            end
                                        else
                                            if state == 95 then
                                                r9 = nil
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                else
                    if state <= 143 then
                        if state <= 131 then
                            if state <= 112 then
                                if state <= 99 then
                                    -- createClosure5 entry 11803822 -> 96, states 96-99
                                    if state <= 97 then
                                        if state <= 96 then
                                            if state == 96 then -- entry 11803822 -> 96
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                r9 = upvalueValues[upvalues[2]]
                                                r17 = 7215705263392
                                                r33 = "\151\147\147\164\251\tv\216\174\185\169\210In.\247\006\250\2504\234"
                                                r2 = r9(r33, r17)
                                                state = ReturnVal[r2]
                                                r9 = state
                                                r2 = 20
                                                r33 = r2
                                                r2 = 1
                                                r17 = r2
                                                r2 = 0
                                                r27 = r17 < r2
                                                ReturnVal = 1
                                                r2 = ReturnVal - r17
                                                state = 97
                                            end
                                        else
                                            if state == 97 then
                                                r10 = not r27
                                                r2 = r2 + r17
                                                ReturnVal = r2 <= r33
                                                ReturnVal = r10 and ReturnVal
                                                r10 = r2 >= r33
                                                r10 = r27 and r10
                                                ReturnVal = r10 or ReturnVal
                                                r10 = (98)
                                                state = ReturnVal and r10
                                                ReturnVal = (99)
                                                state = state or ReturnVal
                                            end
                                        end
                                    else
                                        if state <= 98 then
                                            if state == 98 then
                                                state = r9 .. r9
                                                r9 = state
                                                r10 = r2
                                                r10 = nil
                                                state = 97
                                            end
                                        else
                                            if state == 99 then
                                                ReturnVal = {
                                                    r9
                                                }
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    -- createClosure0 entry 3974902 -> 100, states 100-112
                                    if state <= 106 then
                                        if state <= 103 then
                                            if state <= 101 then
                                                if state <= 100 then
                                                    if state == 100 then -- entry 3974902 -> 100
                                                        ReturnVal = "pairs"
                                                        state = _env[ReturnVal]
                                                        r27 = upvalueValues[upvalues[1]]
                                                        r22 = upvalueValues[upvalues[2]]
                                                        r24 = upvalueValues[upvalues[3]]
                                                        r11 = 13701882583276
                                                        r19 = "&\218\141\1556\179\127\019"
                                                        r20 = r24(r19, r11)
                                                        r10 = r22[r20]
                                                        r17 = r27[r10]
                                                        r10 = upvalueValues[upvalues[1]]
                                                        r24 = upvalueValues[upvalues[2]]
                                                        r20 = upvalueValues[upvalues[3]]
                                                        r11 = "\237s~c\167\187\251K\250"
                                                        r1 = 31374132345105
                                                        r19 = r20(r11, r1)
                                                        r22 = r24[r19]
                                                        r27 = r10[r22]
                                                        r33 = {
                                                            r17,
                                                            r27
                                                        }
                                                        r17 = {
                                                            state(r33)
                                                        }
                                                        ReturnVal = r17[1]
                                                        r9 = r17[2]
                                                        r2 = r17[3]
                                                        state = {}
                                                        r17 = state
                                                        r33 = ReturnVal
                                                        state = 101
                                                    end
                                                else
                                                    if state == 101 then
                                                        state = true
                                                        state = state and (102) or (103)
                                                    end
                                                end
                                            else
                                                if state <= 102 then
                                                    if state == 102 then
                                                        r10 = {
                                                            r33(r9, r2)
                                                        }
                                                        state = nil
                                                        r27 = state
                                                        state = r10[1]
                                                        ReturnVal = r10[2]
                                                        r2 = state
                                                        r22 = nil
                                                        r10 = r2 == r22
                                                        state = r10 and (104) or (105)
                                                        r27 = ReturnVal
                                                    end
                                                else
                                                    if state == 103 then
                                                        ReturnVal = {
                                                            r17
                                                        }
                                                        state = nil
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 105 then
                                                if state <= 104 then
                                                    if state == 104 then
                                                        r10 = nil
                                                        r24 = nil
                                                        r22 = nil
                                                        r27 = nil
                                                        state = 103
                                                    end
                                                else
                                                    if state == 105 then
                                                        r19 = "pairs"
                                                        r20 = _env[r19]
                                                        r3 = "GetChildren"
                                                        r3 = r27[r3]
                                                        r18 = {
                                                            r3(r27)
                                                        }
                                                        r3 = {
                                                            r20(unpack(r18))
                                                        }
                                                        r19 = r3[1]
                                                        r11 = r3[2]
                                                        r1 = r3[3]
                                                        r10 = r19
                                                        r22 = r11
                                                        r24 = r1
                                                        state = 106
                                                    end
                                                end
                                            else
                                                if state == 106 then
                                                    r20 = true
                                                    state = r20 and (107) or (108)
                                                end
                                            end
                                        end
                                    else
                                        if state <= 109 then
                                            if state <= 108 then
                                                if state <= 107 then
                                                    if state == 107 then
                                                        r1 = {
                                                            r10(r22, r24)
                                                        }
                                                        r19 = r1[1]
                                                        r11 = r1[2]
                                                        r24 = r19
                                                        r18 = nil
                                                        r1 = r24 == r18
                                                        state = r1 and (109) or (110)
                                                        r20 = nil
                                                        r20 = r11
                                                    end
                                                else
                                                    if state == 108 then
                                                        r24 = nil
                                                        r22 = nil
                                                        r10 = nil
                                                        r27 = nil
                                                        state = 101
                                                    end
                                                end
                                            else
                                                if state == 109 then
                                                    r20 = nil
                                                    state = 108
                                                end
                                            end
                                        else
                                            if state <= 111 then
                                                if state <= 110 then
                                                    if state == 110 then
                                                        r3 = upvalueValues[upvalues[2]]
                                                        r12 = upvalueValues[upvalues[3]]
                                                        r1 = "IsA"
                                                        r1 = r20[r1]
                                                        r14 = 10129323201132
                                                        r4 = "\173\132.\166"
                                                        r28 = r12(r4, r14)
                                                        r18 = r3[r28]
                                                        r1 = r1(r20, r18)
                                                        state = r1 and (111) or (112)
                                                    end
                                                else
                                                    if state == 111 then
                                                        r3 = "table"
                                                        r18 = _env[r3]
                                                        r12 = upvalueValues[upvalues[2]]
                                                        r28 = upvalueValues[upvalues[3]]
                                                        r31 = 7010118307008
                                                        r14 = "\206\2221\177\209("
                                                        r4 = r28(r14, r31)
                                                        r3 = r12[r4]
                                                        r1 = r18[r3]
                                                        r18 = r1(r17, r20)
                                                        state = 112
                                                    end
                                                end
                                            else
                                                if state == 112 then
                                                    r20 = nil
                                                    state = 106
                                                end
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 128 then
                                    -- createClosure5 entry 7414690 -> 113, states 113-128
                                    if state <= 120 then
                                        if state <= 116 then
                                            if state <= 114 then
                                                if state <= 113 then
                                                    if state == 113 then -- entry 7414690 -> 113
                                                        r9 = allocUpvalue()
                                                        upvalueValues[r9] = args[1]
                                                        r2 = allocUpvalue()
                                                        upvalueValues[r2] = args[2]
                                                        ReturnVal = "pairs"
                                                        state = _env[ReturnVal]
                                                        r27 = upvalueValues[r9]
                                                        r22 = "GetDescendants"
                                                        r22 = r27[r22]
                                                        r10 = {
                                                            r22(r27)
                                                        }
                                                        r27 = {
                                                            state(unpack(r10))
                                                        }
                                                        r33 = r27[2]
                                                        ReturnVal = r27[1]
                                                        r17 = r27[3]
                                                        r27 = ReturnVal
                                                        state = 114
                                                    end
                                                else
                                                    if state == 114 then
                                                        state = true
                                                        state = state and (115) or (116)
                                                    end
                                                end
                                            else
                                                if state <= 115 then
                                                    if state == 115 then
                                                        r10 = allocUpvalue()
                                                        state = nil
                                                        upvalueValues[r10] = state
                                                        r22 = {
                                                            r27(r33, r17)
                                                        }
                                                        state = r22[1]
                                                        ReturnVal = r22[2]
                                                        upvalueValues[r10] = ReturnVal
                                                        r17 = state
                                                        r24 = nil
                                                        r22 = r17 == r24
                                                        state = r22 and (117) or (118)
                                                    end
                                                else
                                                    if state == 116 then
                                                        r22 = "pcall"
                                                        r2 = releaseUpvalue(r2)
                                                        r33 = nil
                                                        r24 = createClosure0(151, {
                                                            r9,
                                                            upvalues[1],
                                                            upvalues[2]
                                                        })
                                                        r10 = _env[r22]
                                                        r17 = nil
                                                        r22 = r10(r24)
                                                        r24 = createClosure0(154, {
                                                            r9,
                                                            upvalues[1],
                                                            upvalues[2]
                                                        })
                                                        r22 = "pcall"
                                                        r10 = _env[r22]
                                                        r27 = nil
                                                        r9 = releaseUpvalue(r9)
                                                        ReturnVal = {}
                                                        r22 = r10(r24)
                                                        state = nil
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 118 then
                                                if state <= 117 then
                                                    if state == 117 then
                                                        r10 = releaseUpvalue(r10)
                                                        state = 116
                                                    end
                                                else
                                                    if state == 118 then
                                                        r22 = upvalueValues[r10]
                                                        r19 = upvalueValues[upvalues[1]]
                                                        r11 = upvalueValues[upvalues[2]]
                                                        r3 = 30418639894356
                                                        r18 = "\244YK\1290\022\197\1581h "
                                                        r1 = r11(r18, r3)
                                                        r24 = "IsA"
                                                        r24 = r22[r24]
                                                        r20 = r19[r1]
                                                        r24 = r24(r22, r20)
                                                        state = r24 and (119) or (120)
                                                    end
                                                end
                                            else
                                                if state <= 119 then
                                                    if state == 119 then
                                                        r24 = 8
                                                        r20 = r24
                                                        r24 = 1
                                                        r19 = r24
                                                        r24 = 0
                                                        r11 = r19 < r24
                                                        r22 = 1
                                                        r24 = r22 - r19
                                                        state = 121
                                                    end
                                                else
                                                    if state == 120 then
                                                        r22 = upvalueValues[r10]
                                                        r19 = upvalueValues[upvalues[1]]
                                                        r24 = "IsA"
                                                        r24 = r22[r24]
                                                        r11 = upvalueValues[upvalues[2]]
                                                        r18 = "\169\022\187I-\008\171\177\186\173BcOg"
                                                        r3 = 24780216085779
                                                        r1 = r11(r18, r3)
                                                        r20 = r19[r1]
                                                        r24 = r24(r22, r20)
                                                        state = r24 and (122) or (123)
                                                    end
                                                end
                                            end
                                        end
                                    else
                                        if state <= 124 then
                                            if state <= 122 then
                                                if state <= 121 then
                                                    if state == 121 then
                                                        r1 = not r11
                                                        r24 = r24 + r19
                                                        r22 = r24 <= r20
                                                        r22 = r1 and r22
                                                        r1 = r24 >= r20
                                                        r1 = r11 and r1
                                                        r22 = r1 or r22
                                                        r1 = (124)
                                                        state = r22 and r1
                                                        r22 = (125)
                                                        state = state or r22
                                                    end
                                                else
                                                    if state == 122 then
                                                        r24 = 4
                                                        r20 = r24
                                                        r24 = 1
                                                        r19 = r24
                                                        r24 = 0
                                                        r11 = r19 < r24
                                                        r22 = 1
                                                        r24 = r22 - r19
                                                        state = 126
                                                    end
                                                end
                                            else
                                                if state <= 123 then
                                                    if state == 123 then
                                                        r10 = releaseUpvalue(r10)
                                                        state = 114
                                                    end
                                                else
                                                    if state == 124 then
                                                        r22 = r24
                                                        r3 = createClosure2(157, {
                                                            r10,
                                                            r2,
                                                            upvalues[1],
                                                            upvalues[2]
                                                        })
                                                        r18 = "pcall"
                                                        r1 = _env[r18]
                                                        r22 = nil
                                                        r18 = r1(r3)
                                                        state = 121
                                                    end
                                                end
                                            end
                                        else
                                            if state <= 126 then
                                                if state <= 125 then
                                                    if state == 125 then
                                                        state = 123
                                                    end
                                                else
                                                    if state == 126 then
                                                        r24 = r24 + r19
                                                        r1 = not r11
                                                        r22 = r24 <= r20
                                                        r22 = r1 and r22
                                                        r1 = r24 >= r20
                                                        r1 = r11 and r1
                                                        r22 = r1 or r22
                                                        r1 = (127)
                                                        state = r22 and r1
                                                        r22 = (128)
                                                        state = state or r22
                                                    end
                                                end
                                            else
                                                if state <= 127 then
                                                    if state == 127 then
                                                        r22 = r24
                                                        r3 = createClosure5(158, {
                                                            r10,
                                                            r2,
                                                            upvalues[1],
                                                            upvalues[2]
                                                        })
                                                        r18 = "pcall"
                                                        r1 = _env[r18]
                                                        r18 = r1(r3)
                                                        r22 = nil
                                                        state = 126
                                                    end
                                                else
                                                    if state == 128 then
                                                        state = 123
                                                    end
                                                end
                                            end
                                        end
                                    end
                                else
                                    -- createClosure4 entry 9149979 -> 129, states 129-131
                                    if state <= 130 then
                                        if state <= 129 then
                                            if state == 129 then -- entry 9149979 -> 129
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                state = not ReturnVal
                                                state = state and (130) or (131)
                                            end
                                        else
                                            if state == 130 then
                                                state = true
                                                upvalueValues[upvalues[1]] = state
                                                ReturnVal = upvalueValues[upvalues[2]]
                                                r2 = upvalueValues[upvalues[3]]
                                                r33 = upvalueValues[upvalues[4]]
                                                r10 = 3430027298365
                                                r27 = "O$\"i"
                                                r17 = r33(r27, r10)
                                                r9 = r2[r17]
                                                r33 = upvalueValues[upvalues[3]]
                                                r17 = upvalueValues[upvalues[4]]
                                                r10 = "\135n\148\202\196\007\225z\246\"\236\169l\238+"
                                                r22 = 9381251207440
                                                r27 = r17(r10, r22)
                                                r2 = r33[r27]
                                                ReturnVal[r9] = r2
                                                ReturnVal = upvalueValues[upvalues[5]]
                                                r2 = upvalueValues[upvalues[2]]
                                                r27 = "TweenInfo"
                                                r17 = _env[r27]
                                                r10 = upvalueValues[upvalues[3]]
                                                r22 = upvalueValues[upvalues[4]]
                                                r20 = "f\001\242"
                                                r19 = 30594885400486
                                                r24 = r22(r20, r19)
                                                r27 = r10[r24]
                                                r33 = r17[r27]
                                                r27 = 0.25
                                                r17 = r33(r27)
                                                r10 = upvalueValues[upvalues[3]]
                                                r22 = upvalueValues[upvalues[4]]
                                                r20 = "\011:+\156\206^sb\007\183"
                                                r19 = 33162681318482
                                                r24 = r22(r20, r19)
                                                r27 = r10[r24]
                                                r24 = "Color3"
                                                r22 = _env[r24]
                                                r20 = upvalueValues[upvalues[3]]
                                                r19 = upvalueValues[upvalues[4]]
                                                r1 = "\025K\008pJ\155A"
                                                r18 = 24766228786444
                                                r11 = r19(r1, r18)
                                                r9 = "Create"
                                                r9 = ReturnVal[r9]
                                                r24 = r20[r11]
                                                r10 = r22[r24]
                                                r20 = 255
                                                r24 = 10
                                                r19 = 90
                                                r22 = r10(r24, r20, r19)
                                                r33 = {
                                                    [r27] = r22
                                                }
                                                r9 = r9(ReturnVal, r2, r17, r33)
                                                ReturnVal = "Play"
                                                ReturnVal = r9[ReturnVal]
                                                ReturnVal = ReturnVal(r9)
                                                r2 = allocUpvalue()
                                                ReturnVal = upvalueValues[upvalues[6]]
                                                r9 = ReturnVal()
                                                upvalueValues[r2] = r9
                                                r33 = "game"
                                                r9 = _env[r33]
                                                r27 = upvalueValues[upvalues[3]]
                                                r10 = upvalueValues[upvalues[4]]
                                                r24 = "\005#_h]I2\212s\132"
                                                r20 = 5513264761351
                                                r22 = r10(r24, r20)
                                                r17 = r27[r22]
                                                r33 = "GetService"
                                                r33 = r9[r33]
                                                r33 = r33(r9, r17)
                                                r17 = upvalueValues[upvalues[3]]
                                                r27 = upvalueValues[upvalues[4]]
                                                r22 = "\027`\004L\015\236\164\143\226\163\135\181\249"
                                                r24 = 7461095214482
                                                r10 = r27(r22, r24)
                                                r9 = r17[r10]
                                                ReturnVal = r33[r9]
                                                r33 = createClosure5(159, {
                                                    upvalues[1],
                                                    upvalues[7],
                                                    upvalues[3],
                                                    upvalues[4],
                                                    upvalues[8],
                                                    upvalues[9],
                                                    r2
                                                })
                                                r9 = "Connect"
                                                r9 = ReturnVal[r9]
                                                r9 = r9(ReturnVal, r33)
                                                r2 = releaseUpvalue(r2)
                                                upvalueValues[upvalues[10]] = r9
                                                state = 131
                                            end
                                        end
                                    else
                                        if state == 131 then
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                end
                            end
                        else
                            if state <= 137 then
                                if state <= 134 then
                                    -- createClosure5 entry 14478994 -> 132, states 132-134
                                    if state <= 133 then
                                        if state <= 132 then
                                            if state == 132 then -- entry 14478994 -> 132
                                                state = false
                                                upvalueValues[upvalues[1]] = state
                                                ReturnVal = upvalueValues[upvalues[2]]
                                                r2 = upvalueValues[upvalues[3]]
                                                r33 = upvalueValues[upvalues[4]]
                                                r10 = 886533718428
                                                r27 = "\015\248\025\022"
                                                r17 = r33(r27, r10)
                                                r9 = r2[r17]
                                                r33 = upvalueValues[upvalues[3]]
                                                r17 = upvalueValues[upvalues[4]]
                                                r22 = 33568401554703
                                                r10 = "\203W\221q\003Z\006 \170\2017\250\194g\023@"
                                                r27 = r17(r10, r22)
                                                r2 = r33[r27]
                                                ReturnVal[r9] = r2
                                                ReturnVal = upvalueValues[upvalues[5]]
                                                r2 = upvalueValues[upvalues[2]]
                                                r27 = "TweenInfo"
                                                r17 = _env[r27]
                                                r10 = upvalueValues[upvalues[3]]
                                                r22 = upvalueValues[upvalues[4]]
                                                r19 = 1420119818901
                                                r20 = "&\134b"
                                                r24 = r22(r20, r19)
                                                r27 = r10[r24]
                                                r33 = r17[r27]
                                                r27 = 0.25
                                                r17 = r33(r27)
                                                r10 = upvalueValues[upvalues[3]]
                                                r22 = upvalueValues[upvalues[4]]
                                                r19 = 23762900380473
                                                r20 = "\145\145\029\246~s\170\139}\155"
                                                r24 = r22(r20, r19)
                                                r27 = r10[r24]
                                                r24 = "Color3"
                                                r22 = _env[r24]
                                                r20 = upvalueValues[upvalues[3]]
                                                r19 = upvalueValues[upvalues[4]]
                                                r18 = 16827120279195
                                                r1 = " \165\231<\132\008\159"
                                                r11 = r19(r1, r18)
                                                r24 = r20[r11]
                                                r10 = r22[r24]
                                                r9 = "Create"
                                                r9 = ReturnVal[r9]
                                                r24 = 165
                                                r20 = 255
                                                r19 = 190
                                                r22 = r10(r24, r20, r19)
                                                r33 = {
                                                    [r27] = r22
                                                }
                                                r9 = r9(ReturnVal, r2, r17, r33)
                                                ReturnVal = "Play"
                                                ReturnVal = r9[ReturnVal]
                                                ReturnVal = ReturnVal(r9)
                                                ReturnVal = upvalueValues[upvalues[6]]
                                                state = ReturnVal and (133) or (134)
                                            end
                                        else
                                            if state == 133 then
                                                ReturnVal = upvalueValues[upvalues[6]]
                                                r9 = "Disconnect"
                                                r9 = ReturnVal[r9]
                                                r9 = r9(ReturnVal)
                                                ReturnVal = nil
                                                upvalueValues[upvalues[6]] = ReturnVal
                                                state = 134
                                            end
                                        end
                                    else
                                        if state == 134 then
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure4 entry 13146364 -> 135, states 135-137
                                    if state <= 136 then
                                        if state <= 135 then
                                            if state == 135 then -- entry 13146364 -> 135
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                state = not ReturnVal
                                                state = state and (136) or (137)
                                            end
                                        else
                                            if state == 136 then
                                                state = upvalueValues[upvalues[2]]
                                                ReturnVal = state()
                                                state = 137
                                            end
                                        end
                                    else
                                        if state == 137 then
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                end
                            else
                                if state <= 140 then
                                    -- createClosure1 entry 15250658 -> 138, states 138-140
                                    if state <= 139 then
                                        if state <= 138 then
                                            if state == 138 then -- entry 15250658 -> 138
                                                state = upvalueValues[upvalues[1]]
                                                state = state and (139) or (140)
                                            end
                                        else
                                            if state == 139 then
                                                state = upvalueValues[upvalues[2]]
                                                ReturnVal = state()
                                                state = 140
                                            end
                                        end
                                    else
                                        if state == 140 then
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure4 entry 9757289 -> 141, states 141-143
                                    if state <= 142 then
                                        if state <= 141 then
                                            if state == 141 then -- entry 9757289 -> 141
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                r9 = "IsDescendantOf"
                                                r9 = ReturnVal[r9]
                                                r33 = "game"
                                                r2 = _env[r33]
                                                r9 = r9(ReturnVal, r2)
                                                state = not r9
                                                state = state and (142) or (143)
                                            end
                                        else
                                            if state == 142 then
                                                ReturnVal = "wait"
                                                state = _env[ReturnVal]
                                                r9 = 0.1
                                                ReturnVal = state(r9)
                                                state = upvalueValues[upvalues[2]]
                                                ReturnVal = state()
                                                state = 143
                                            end
                                        end
                                    else
                                        if state == 143 then
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                end
                            end
                        end
                    else
                        if state <= 156 then
                            if state <= 150 then
                                if state <= 146 then
                                    -- createClosure1 entry 3128112 -> 144, states 144-146
                                    if state <= 145 then
                                        if state <= 144 then
                                            if state == 144 then -- entry 3128112 -> 144
                                                r9 = upvalueValues[upvalues[1]]
                                                r33 = upvalueValues[upvalues[2]]
                                                r17 = upvalueValues[upvalues[3]]
                                                r22 = 34458244611757
                                                r10 = "Kg\233\140\229\0141\240\213\253\242\143d\148"
                                                r27 = r17(r10, r22)
                                                r2 = r33[r27]
                                                ReturnVal = r9[r2]
                                                r17 = "Enum"
                                                r33 = _env[r17]
                                                r27 = upvalueValues[upvalues[2]]
                                                r10 = upvalueValues[upvalues[3]]
                                                r20 = 18574279336393
                                                r24 = "]\179\028w\216:dwh\"R\253\231("
                                                r22 = r10(r24, r20)
                                                r17 = r27[r22]
                                                r2 = r33[r17]
                                                r17 = upvalueValues[upvalues[2]]
                                                r27 = upvalueValues[upvalues[3]]
                                                r22 = "\188\218\194"
                                                r24 = 33233816042611
                                                r10 = r27(r22, r24)
                                                r33 = r17[r10]
                                                r9 = r2[r33]
                                                state = ReturnVal == r9
                                                state = state and (145) or (146)
                                            end
                                        else
                                            if state == 145 then
                                                state = false
                                                upvalueValues[upvalues[4]] = state
                                                state = 146
                                            end
                                        end
                                    else
                                        if state == 146 then
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure0 entry 14261996 -> 147, states 147-150
                                    if state <= 148 then
                                        if state <= 147 then
                                            if state == 147 then -- entry 14261996 -> 147
                                                state = 148
                                            end
                                        else
                                            if state == 148 then
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                r2 = upvalueValues[upvalues[2]]
                                                r33 = upvalueValues[upvalues[3]]
                                                r10 = 28492607812563
                                                r27 = "q5RX\236\026"
                                                r17 = r33(r27, r10)
                                                r9 = r2[r17]
                                                state = ReturnVal[r9]
                                                state = state and (149) or (150)
                                            end
                                        end
                                    else
                                        if state <= 149 then
                                            if state == 149 then
                                                r27 = "\\\012&\200\203\007"
                                                state = upvalueValues[upvalues[4]]
                                                r10 = 34228879654467
                                                r2 = upvalueValues[upvalues[2]]
                                                r33 = upvalueValues[upvalues[3]]
                                                r9 = state
                                                r17 = r33(r27, r10)
                                                ReturnVal = r2[r17]
                                                state = r9[ReturnVal]
                                                r2 = state
                                                r17 = "TweenInfo"
                                                state = upvalueValues[upvalues[1]]
                                                ReturnVal = _env[r17]
                                                r33 = state
                                                r27 = upvalueValues[upvalues[2]]
                                                r10 = upvalueValues[upvalues[3]]
                                                r20 = 2163747357679
                                                r24 = "\150\130\196"
                                                r22 = r10(r24, r20)
                                                r17 = r27[r22]
                                                state = ReturnVal[r17]
                                                r24 = "Enum"
                                                r22 = _env[r24]
                                                r20 = upvalueValues[upvalues[2]]
                                                r17 = 0.65
                                                r19 = upvalueValues[upvalues[3]]
                                                r18 = 22106023389237
                                                r1 = "\141\215{\127\174\242\148\195\244eU"
                                                r11 = r19(r1, r18)
                                                r24 = r20[r11]
                                                r10 = r22[r24]
                                                r24 = upvalueValues[upvalues[2]]
                                                r20 = upvalueValues[upvalues[3]]
                                                r1 = 11656749864244
                                                r11 = "db\163h"
                                                r19 = r20(r11, r1)
                                                r22 = r24[r19]
                                                r27 = r10[r22]
                                                ReturnVal = state(r17, r27)
                                                r27 = upvalueValues[upvalues[2]]
                                                r10 = upvalueValues[upvalues[3]]
                                                r17 = ReturnVal
                                                r24 = "\216\215\"hMoV\145\192\008H\217\128\238\231\004"
                                                r20 = 12487145526966
                                                r22 = r10(r24, r20)
                                                ReturnVal = r27[r22]
                                                r27 = upvalueValues[upvalues[5]]
                                                r20 = "Color3"
                                                r24 = _env[r20]
                                                r19 = upvalueValues[upvalues[2]]
                                                r10 = "lerp"
                                                r11 = upvalueValues[upvalues[3]]
                                                r18 = "\218\157\000\157tAA"
                                                r3 = 24398108929121
                                                r1 = r11(r18, r3)
                                                r20 = r19[r1]
                                                r22 = r24[r20]
                                                r11 = 255
                                                r19 = 255
                                                r20 = 255
                                                r24 = r22(r20, r19, r11)
                                                r10 = r27[r10]
                                                r22 = 0.12
                                                r10 = r10(r27, r24, r22)
                                                state = {
                                                    [ReturnVal] = r10
                                                }
                                                r27 = state
                                                state = r2(r9, r33, r17, r27)
                                                ReturnVal = "Play"
                                                ReturnVal = state[ReturnVal]
                                                ReturnVal = ReturnVal(state)
                                                r14 = "\167n\194\012\205h\1764Hv\250"
                                                r12 = 13917926070609
                                                r31 = 15411809655816
                                                r10 = 0.65
                                                ReturnVal = "wait"
                                                state = _env[ReturnVal]
                                                ReturnVal = state(r10)
                                                r10 = upvalueValues[upvalues[2]]
                                                r22 = upvalueValues[upvalues[3]]
                                                r20 = ")\017\022\217{\239\1777\204\253\"x\008\221\132\239"
                                                r19 = 16189781171570
                                                r24 = r22(r20, r19)
                                                r3 = "\244\223\006"
                                                r27 = nil
                                                ReturnVal = r10[r24]
                                                r10 = upvalueValues[upvalues[5]]
                                                state = {
                                                    [ReturnVal] = r10
                                                }
                                                r10 = state
                                                state = upvalueValues[upvalues[4]]
                                                r19 = "TweenInfo"
                                                r22 = upvalueValues[upvalues[1]]
                                                r2 = nil
                                                r20 = _env[r19]
                                                r11 = upvalueValues[upvalues[2]]
                                                r1 = upvalueValues[upvalues[3]]
                                                r18 = r1(r3, r12)
                                                r33 = nil
                                                r19 = r11[r18]
                                                r24 = r20[r19]
                                                r19 = 0.65
                                                r3 = "Enum"
                                                r18 = _env[r3]
                                                r12 = upvalueValues[upvalues[2]]
                                                ReturnVal = "Create"
                                                r28 = upvalueValues[upvalues[3]]
                                                r9 = nil
                                                ReturnVal = state[ReturnVal]
                                                r4 = r28(r14, r31)
                                                r3 = r12[r4]
                                                r1 = r18[r3]
                                                r3 = upvalueValues[upvalues[2]]
                                                r12 = upvalueValues[upvalues[3]]
                                                r4 = "\148\180\\\216"
                                                r14 = 15533600578625
                                                r28 = r12(r4, r14)
                                                r18 = r3[r28]
                                                r11 = r1[r18]
                                                r20 = r24(r19, r11)
                                                ReturnVal = ReturnVal(state, r22, r20, r10)
                                                state = "Play"
                                                r17 = nil
                                                state = ReturnVal[state]
                                                state = state(ReturnVal)
                                                r22 = 0.65
                                                ReturnVal = "wait"
                                                state = _env[ReturnVal]
                                                r10 = nil
                                                ReturnVal = state(r22)
                                                state = 148
                                            end
                                        else
                                            if state == 150 then
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            else
                                if state <= 153 then
                                    -- createClosure0 entry 13323076 -> 151, states 151-153
                                    if state <= 152 then
                                        if state <= 151 then
                                            if state == 151 then -- entry 13323076 -> 151
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                r2 = upvalueValues[upvalues[2]]
                                                r33 = upvalueValues[upvalues[3]]
                                                r10 = 3513770051172
                                                r27 = "\140\236\012\1417E\163g"
                                                r17 = r33(r27, r10)
                                                r9 = r2[r17]
                                                state = ReturnVal[r9]
                                                state = state and (152) or (153)
                                            end
                                        else
                                            if state == 152 then
                                                state = upvalueValues[upvalues[1]]
                                                ReturnVal = "Activate"
                                                ReturnVal = state[ReturnVal]
                                                ReturnVal = ReturnVal(state)
                                                state = 153
                                            end
                                        end
                                    else
                                        if state == 153 then
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure0 entry 264851 -> 154, states 154-156
                                    if state <= 155 then
                                        if state <= 154 then
                                            if state == 154 then -- entry 264851 -> 154
                                                ReturnVal = upvalueValues[upvalues[1]]
                                                r2 = upvalueValues[upvalues[2]]
                                                r33 = upvalueValues[upvalues[3]]
                                                r10 = 33741688175968
                                                r27 = "4\137\211\196\198\171\221N \n\171\184\141n"
                                                r17 = r33(r27, r10)
                                                r9 = r2[r17]
                                                state = ReturnVal[r9]
                                                state = state and (155) or (156)
                                            end
                                        else
                                            if state == 155 then
                                                state = upvalueValues[upvalues[1]]
                                                ReturnVal = "ActivateClient"
                                                ReturnVal = state[ReturnVal]
                                                ReturnVal = ReturnVal(state)
                                                state = 156
                                            end
                                        end
                                    else
                                        if state == 156 then
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    end
                                end
                            end
                        else
                            if state <= 158 then
                                if state <= 157 then
                                    -- createClosure2 entry 12540323 -> 157, states 157-157
                                    if state == 157 then -- entry 12540323 -> 157
                                        state = upvalueValues[upvalues[1]]
                                        ReturnVal = "FireServer"
                                        ReturnVal = state[ReturnVal]
                                        r9 = upvalueValues[upvalues[2]]
                                        ReturnVal = ReturnVal(state, r9)
                                        state = upvalueValues[upvalues[1]]
                                        r2 = upvalueValues[upvalues[3]]
                                        r33 = upvalueValues[upvalues[4]]
                                        r27 = "r;p\177\248"
                                        r10 = 12293070558812
                                        r17 = r33(r27, r10)
                                        r9 = r2[r17]
                                        ReturnVal = "FireServer"
                                        ReturnVal = state[ReturnVal]
                                        r2 = upvalueValues[upvalues[2]]
                                        ReturnVal = ReturnVal(state, r9, r2)
                                        state = upvalueValues[upvalues[1]]
                                        r2 = upvalueValues[upvalues[2]]
                                        ReturnVal = "FireServer"
                                        ReturnVal = state[ReturnVal]
                                        r27 = "math"
                                        r17 = _env[r27]
                                        r10 = upvalueValues[upvalues[3]]
                                        r22 = upvalueValues[upvalues[4]]
                                        r20 = "\236=\026\172"
                                        r19 = 29116141696246
                                        r24 = r22(r20, r19)
                                        r27 = r10[r24]
                                        r33 = r17[r27]
                                        r17 = true
                                        r9 = {
                                            r2,
                                            r33,
                                            r17
                                        }
                                        ReturnVal = ReturnVal(state, r9)
                                        state = upvalueValues[upvalues[1]]
                                        r2 = upvalueValues[upvalues[3]]
                                        r33 = upvalueValues[upvalues[4]]
                                        r27 = "X\021\237\187[\192\005\198"
                                        r10 = 6891017653384
                                        r17 = r33(r27, r10)
                                        r9 = r2[r17]
                                        r2 = upvalueValues[upvalues[2]]
                                        ReturnVal = "FireServer"
                                        ReturnVal = state[ReturnVal]
                                        ReturnVal = ReturnVal(state, r9, r2)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                else
                                    -- createClosure5 entry 12522988 -> 158, states 158-158
                                    if state == 158 then -- entry 12522988 -> 158
                                        state = upvalueValues[upvalues[1]]
                                        r9 = upvalueValues[upvalues[2]]
                                        ReturnVal = "InvokeServer"
                                        ReturnVal = state[ReturnVal]
                                        ReturnVal = ReturnVal(state, r9)
                                        state = upvalueValues[upvalues[1]]
                                        r2 = upvalueValues[upvalues[3]]
                                        r33 = upvalueValues[upvalues[4]]
                                        r27 = "/\174n\244V"
                                        r10 = 18329878520151
                                        r17 = r33(r27, r10)
                                        r9 = r2[r17]
                                        ReturnVal = "InvokeServer"
                                        ReturnVal = state[ReturnVal]
                                        r2 = upvalueValues[upvalues[2]]
                                        ReturnVal = ReturnVal(state, r9, r2)
                                        state = upvalueValues[upvalues[1]]
                                        r2 = upvalueValues[upvalues[2]]
                                        r27 = "math"
                                        r17 = _env[r27]
                                        r10 = upvalueValues[upvalues[3]]
                                        r22 = upvalueValues[upvalues[4]]
                                        r20 = "\192\232\248\019~\221"
                                        r19 = 23080798824955
                                        r24 = r22(r20, r19)
                                        r27 = r10[r24]
                                        r33 = r17[r27]
                                        ReturnVal = "InvokeServer"
                                        ReturnVal = state[ReturnVal]
                                        r10 = 999999
                                        r27 = 1
                                        r17 = {
                                            r33(r27, r10)
                                        }
                                        r9 = {
                                            r2,
                                            unpack(r17)
                                        }
                                        ReturnVal = ReturnVal(state, r9)
                                        ReturnVal = {}
                                        state = nil
                                    end
                                end
                            else
                                -- createClosure5 entry 4040030 -> 159, states 159-168
                                if state <= 163 then
                                    if state <= 161 then
                                        if state <= 160 then
                                            if state <= 159 then
                                                if state == 159 then -- entry 4040030 -> 159
                                                    state = upvalueValues[upvalues[1]]
                                                    state = state and (160) or (161)
                                                end
                                            else
                                                if state == 160 then
                                                    ReturnVal = "pairs"
                                                    state = _env[ReturnVal]
                                                    r33 = upvalueValues[upvalues[2]]
                                                    r17 = {
                                                        r33()
                                                    }
                                                    r33 = {
                                                        state(unpack(r17))
                                                    }
                                                    r9 = r33[2]
                                                    r2 = r33[3]
                                                    ReturnVal = r33[1]
                                                    r33 = ReturnVal
                                                    state = 162
                                                end
                                            end
                                        else
                                            if state == 161 then
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    else
                                        if state <= 162 then
                                            if state == 162 then
                                                state = true
                                                state = state and (163) or (164)
                                            end
                                        else
                                            if state == 163 then
                                                r27 = {
                                                    r33(r9, r2)
                                                }
                                                state = nil
                                                r17 = state
                                                state = r27[1]
                                                r2 = state
                                                ReturnVal = r27[2]
                                                r10 = nil
                                                r27 = r2 == r10
                                                state = r27 and (165) or (166)
                                                r17 = ReturnVal
                                            end
                                        end
                                    end
                                else
                                    if state <= 166 then
                                        if state <= 165 then
                                            if state <= 164 then
                                                if state == 164 then
                                                    r9 = nil
                                                    r33 = nil
                                                    r2 = nil
                                                    state = 161
                                                end
                                            else
                                                if state == 165 then
                                                    r17 = nil
                                                    state = 164
                                                end
                                            end
                                        else
                                            if state == 166 then
                                                r24 = upvalueValues[upvalues[3]]
                                                r20 = upvalueValues[upvalues[4]]
                                                r1 = 34951045087123
                                                r11 = "\012rh&6\007"
                                                r19 = r20(r11, r1)
                                                r22 = r24[r19]
                                                r10 = r17[r22]
                                                r24 = upvalueValues[upvalues[5]]
                                                r19 = upvalueValues[upvalues[3]]
                                                r11 = upvalueValues[upvalues[4]]
                                                r18 = "\186\030J\030P}HL\017"
                                                r3 = 25230910402021
                                                r1 = r11(r18, r3)
                                                r20 = r19[r1]
                                                r22 = r24[r20]
                                                r27 = r10 ~= r22
                                                state = r27 and (167) or (168)
                                            end
                                        end
                                    else
                                        if state <= 167 then
                                            if state == 167 then
                                                r10 = upvalueValues[upvalues[3]]
                                                r22 = upvalueValues[upvalues[4]]
                                                r19 = 26574240231510
                                                r20 = "\022\198\005\217\232\173"
                                                r24 = r22(r20, r19)
                                                r27 = r10[r24]
                                                r22 = upvalueValues[upvalues[5]]
                                                r20 = upvalueValues[upvalues[3]]
                                                r19 = upvalueValues[upvalues[4]]
                                                r1 = "bLB\209&\195\134\249\185"
                                                r18 = 13017761781677
                                                r11 = r19(r1, r18)
                                                r24 = r20[r11]
                                                r10 = r22[r24]
                                                r17[r27] = r10
                                                state = 168
                                            end
                                        else
                                            if state == 168 then
                                                r27 = upvalueValues[upvalues[6]]
                                                r22 = upvalueValues[upvalues[7]]
                                                r10 = r27(r17, r22)
                                                r17 = nil
                                                state = 162
                                            end
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
            currentUpvalueId = currentUpvalueId + (1)
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
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
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return -662439
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -662439
                    end
                })
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
        createClosure1 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1)
                return vm(entryId, {
                    arg1
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
        currentUpvalueId = 0
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)