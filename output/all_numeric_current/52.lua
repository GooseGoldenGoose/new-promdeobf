return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, releaseUpvalues, currentUpvalueId, upvalueValues, allocUpvalue, releaseUpvalue, createUpvalueProxy, createClosure3, upvalueRefCounts, createClosure, vm)
        upvalueValues = {}
        upvalueRefCounts = {}
        createClosure = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(...)
                return vm(entryId, {
                    ...
                }, captures, gcProxy)
            end
            return closure
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
            local r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, ReturnVal, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20
            while state do
                if state <= 13 then
                    if state <= 7 then
                        -- root entry 15381731 -> 1, states 1-7
                        if state <= 4 then
                            if state <= 2 then
                                if state <= 1 then
                                    if state == 1 then -- entry 15381731 -> 1
                                        r9 = "math"
                                        ReturnVal = _env[r9]
                                        r9 = "floor"
                                        state = ReturnVal[r9]
                                        r9 = allocUpvalue()
                                        upvalueValues[r9] = state
                                        r15 = "math"
                                        ReturnVal = _env[r15]
                                        r15 = "random"
                                        state = ReturnVal[r15]
                                        r15 = state
                                        r8 = allocUpvalue()
                                        r6 = allocUpvalue()
                                        r12 = "table"
                                        ReturnVal = _env[r12]
                                        r12 = "remove"
                                        state = ReturnVal[r12]
                                        r12 = state
                                        r4 = allocUpvalue()
                                        r18 = "string"
                                        ReturnVal = _env[r18]
                                        r18 = "char"
                                        state = ReturnVal[r18]
                                        r18 = state
                                        r13 = 256
                                        state = 0
                                        upvalueValues[r6] = state
                                        state = 2
                                        upvalueValues[r4] = state
                                        state = {}
                                        r5 = state
                                        state = {}
                                        upvalueValues[r8] = state
                                        r1 = r13
                                        r13 = 1
                                        r10 = r13
                                        state = 0
                                        r13 = 0
                                        r2 = r10 < r13
                                        ReturnVal = 1
                                        r13 = ReturnVal - r10
                                        r7 = state
                                        state = {}
                                        r16 = state
                                        r20 = args
                                        state = 2
                                    end
                                else
                                    if state == 2 then
                                        r3 = not r2
                                        r13 = r13 + r10
                                        ReturnVal = r13 <= r1
                                        ReturnVal = r3 and ReturnVal
                                        r3 = r13 >= r1
                                        r3 = r2 and r3
                                        ReturnVal = r3 or ReturnVal
                                        r3 = 3
                                        state = ReturnVal and r3
                                        ReturnVal = 4
                                        state = state or ReturnVal
                                    end
                                end
                            else
                                if state <= 3 then
                                    if state == 3 then
                                        r3 = r13
                                        state = r3
                                        r16[r3] = state
                                        r3 = nil
                                        state = 2
                                    end
                                else
                                    if state == 4 then
                                        ReturnVal = #r16
                                        r13 = 0
                                        state = ReturnVal == r13
                                        state = 5
                                    end
                                end
                            end
                        else
                            if state <= 6 then
                                if state <= 5 then
                                    if state == 5 then
                                        r13 = #r16
                                        ReturnVal = 1
                                        state = r15(ReturnVal, r13)
                                        r13 = state
                                        state = r12(r16, r13)
                                        r1 = state
                                        state = upvalueValues[r8]
                                        r2 = 1
                                        r10 = r1 - r2
                                        ReturnVal = r18(r10)
                                        state[r1] = ReturnVal
                                        r13 = nil
                                        r1 = nil
                                        state = 6
                                    end
                                else
                                    if state == 6 then
                                        ReturnVal = #r16
                                        r13 = 0
                                        state = ReturnVal == r13
                                        state = state and 7 or 5
                                    end
                                end
                            else
                                if state == 7 then
                                    r10 = allocUpvalue()
                                    state = {}
                                    r13 = allocUpvalue()
                                    upvalueValues[r13] = state
                                    r1 = allocUpvalue()
                                    state = createClosure3(8, {
                                        r13,
                                        r6,
                                        r4,
                                        r9
                                    })
                                    upvalueValues[r1] = state
                                    state = {}
                                    upvalueValues[r10] = state
                                    r2 = {}
                                    ReturnVal = "setmetatable"
                                    state = _env[ReturnVal]
                                    r19 = upvalueValues[r10]
                                    r11 = "__index"
                                    r17 = "__metatable"
                                    r14 = nil
                                    r3 = {
                                        [r11] = r19,
                                        [r17] = r14
                                    }
                                    ReturnVal = state(r2, r3)
                                    r9 = releaseUpvalue(r9)
                                    state = "STRINGS"
                                    _env[state] = ReturnVal
                                    ReturnVal = {}
                                    state = createClosure3(14, {
                                        r10,
                                        r13,
                                        r8,
                                        r6,
                                        r4,
                                        r1
                                    })
                                    r13 = releaseUpvalue(r13)
                                    r10 = releaseUpvalue(r10)
                                    r8 = releaseUpvalue(r8)
                                    r6 = releaseUpvalue(r6)
                                    r4 = releaseUpvalue(r4)
                                    r2 = "DECRYPT"
                                    _env[r2] = state
                                    r1 = releaseUpvalue(r1)
                                    r12 = nil
                                    r5 = nil
                                    r15 = nil
                                    r18 = nil
                                    r16 = nil
                                    r7 = nil
                                    state = nil
                                end
                            end
                        end
                    else
                        -- createClosure3 entry 615614 -> 8, states 8-13
                        if state <= 10 then
                            if state <= 9 then
                                if state <= 8 then
                                    if state == 8 then -- entry 615614 -> 8
                                        r20 = upvalueValues[upvalues[1]]
                                        ReturnVal = #r20
                                        r20 = 0
                                        state = ReturnVal == r20
                                        state = state and 9 or 10
                                    end
                                else
                                    if state == 9 then
                                        r9 = upvalueValues[upvalues[2]]
                                        r15 = 12345
                                        r20 = r9 * r15
                                        r9 = 6789
                                        ReturnVal = r20 + r9
                                        r20 = 35184372088832
                                        state = ReturnVal % r20
                                        upvalueValues[upvalues[2]] = state
                                        r20 = upvalueValues[upvalues[3]]
                                        r9 = 1
                                        ReturnVal = r20 ~= r9
                                        state = 11
                                    end
                                end
                            else
                                if state == 10 then
                                    r15 = "table"
                                    r9 = _env[r15]
                                    r15 = "remove"
                                    r20 = r9[r15]
                                    r15 = upvalueValues[upvalues[1]]
                                    r9 = {
                                        r20(r15)
                                    }
                                    ReturnVal = {
                                        unpack(r9)
                                    }
                                    state = nil
                                end
                            end
                        else
                            if state <= 12 then
                                if state <= 11 then
                                    if state == 11 then
                                        r9 = upvalueValues[upvalues[3]]
                                        r15 = 17
                                        r20 = r9 * r15
                                        r9 = 257
                                        ReturnVal = r20 % r9
                                        upvalueValues[upvalues[3]] = ReturnVal
                                        state = 12
                                    end
                                else
                                    if state == 12 then
                                        r9 = upvalueValues[upvalues[3]]
                                        r15 = 1
                                        r20 = r9 ~= r15
                                        state = r20 and 13 or 11
                                    end
                                end
                            else
                                if state == 13 then
                                    r9 = upvalueValues[upvalues[3]]
                                    r15 = 32
                                    r20 = r9 % r15
                                    r12 = upvalueValues[upvalues[4]]
                                    r4 = upvalueValues[upvalues[2]]
                                    r10 = upvalueValues[upvalues[3]]
                                    r1 = r10 - r20
                                    r10 = 32
                                    r13 = r1 / r10
                                    r16 = 13
                                    r7 = r16 - r13
                                    r8 = 2
                                    r5 = r8 ^ r7
                                    r6 = r4 / r5
                                    r18 = r12(r6)
                                    r12 = 4294967296
                                    r15 = r18 % r12
                                    r18 = 2
                                    r12 = r18 ^ r20
                                    r9 = r15 / r12
                                    r12 = upvalueValues[upvalues[4]]
                                    r5 = 1
                                    r4 = r9 % r5
                                    r5 = 4294967296
                                    r6 = r4 * r5
                                    r18 = r12(r6)
                                    r12 = upvalueValues[upvalues[4]]
                                    r6 = r12(r9)
                                    r15 = r18 + r6
                                    r18 = 65536
                                    r12 = r15 % r18
                                    r6 = r15 - r12
                                    r4 = 65536
                                    r18 = r6 / r4
                                    r4 = 256
                                    r6 = r12 % r4
                                    r5 = r12 - r6
                                    r8 = 256
                                    r4 = r5 / r8
                                    r8 = 256
                                    r5 = r18 % r8
                                    r7 = r18 - r5
                                    r16 = 256
                                    r8 = r7 / r16
                                    r7 = {
                                        r6,
                                        r4,
                                        r5,
                                        r8
                                    }
                                    upvalueValues[upvalues[1]] = r7
                                    r5 = nil
                                    r8 = nil
                                    r6 = nil
                                    r12 = nil
                                    r9 = nil
                                    r15 = nil
                                    r20 = nil
                                    r18 = nil
                                    r4 = nil
                                    state = 10
                                end
                            end
                        end
                    end
                else
                    -- createClosure3 entry 6903190 -> 14, states 14-20
                    if state <= 17 then
                        if state <= 15 then
                            if state <= 14 then
                                if state == 14 then -- entry 6903190 -> 14
                                    r9 = args[2]
                                    r20 = args[1]
                                    state = upvalueValues[upvalues[1]]
                                    r15 = state
                                    state = r15[r9]
                                    state = state and 15 or 16
                                end
                            else
                                if state == 15 then
                                    state = 17
                                end
                            end
                        else
                            if state <= 16 then
                                if state == 16 then
                                    state = {}
                                    upvalueValues[upvalues[2]] = state
                                    ReturnVal = upvalueValues[upvalues[3]]
                                    r12 = ReturnVal
                                    r18 = 35184372088832
                                    ReturnVal = r9 % r18
                                    upvalueValues[upvalues[4]] = ReturnVal
                                    r4 = 255
                                    r6 = r9 % r4
                                    r4 = 2
                                    r18 = r6 + r4
                                    upvalueValues[upvalues[5]] = r18
                                    r5 = "string"
                                    r4 = _env[r5]
                                    r7 = 1
                                    r5 = "len"
                                    r6 = r4[r5]
                                    r4 = r6(r20)
                                    r16 = r7
                                    r6 = ""
                                    r15[r9] = r6
                                    r7 = 0
                                    r13 = r16 < r7
                                    r5 = 1
                                    r7 = r5 - r16
                                    r8 = r4
                                    r6 = 91
                                    state = 18
                                end
                            else
                                if state == 17 then
                                    ReturnVal = {
                                        r9
                                    }
                                    state = nil
                                end
                            end
                        end
                    else
                        if state <= 19 then
                            if state <= 18 then
                                if state == 18 then
                                    r7 = r7 + r16
                                    r5 = r7 <= r8
                                    r1 = not r13
                                    r5 = r1 and r5
                                    r1 = r7 >= r8
                                    r1 = r13 and r1
                                    r5 = r1 or r5
                                    r1 = 19
                                    state = r5 and r1
                                    r5 = 20
                                    state = state or r5
                                end
                            else
                                if state == 19 then
                                    r5 = r7
                                    r19 = "string"
                                    r11 = _env[r19]
                                    r19 = "byte"
                                    r3 = r11[r19]
                                    r11 = r3(r20, r5)
                                    r3 = upvalueValues[upvalues[6]]
                                    r19 = r3()
                                    r2 = r11 + r19
                                    r10 = r2 + r6
                                    r2 = 256
                                    r1 = r10 % r2
                                    r6 = r1
                                    r2 = r15[r9]
                                    r19 = 1
                                    r11 = r6 + r19
                                    r3 = r12[r11]
                                    r10 = r2 .. r3
                                    r15[r9] = r10
                                    r5 = nil
                                    state = 18
                                end
                            end
                        else
                            if state == 20 then
                                r4 = nil
                                r6 = nil
                                r12 = nil
                                state = 17
                            end
                        end
                    end
                end
            end
            state = #gcProxy
            return unpack(ReturnVal)
        end
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = upvalueRefCounts[captures[captureIndex]] + (1)
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return -1342234
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -1342234
                    end
                })
            end
        end
        currentUpvalueId = 0
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if upvalueRefCounts[upvalueId] == 0 then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)