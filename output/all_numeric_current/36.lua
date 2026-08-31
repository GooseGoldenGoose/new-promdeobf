return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, createClosure5, createClosure, createClosure0, releaseUpvalue, currentUpvalueId, releaseUpvalues, createClosure2, createClosure3, upvalueRefCounts, allocUpvalue, upvalueValues, vm, createUpvalueProxy)
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
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if upvalueRefCounts[upvalueId] == 0 then
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
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = upvalueRefCounts[captures[captureIndex]] + (1)
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return 84540
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 84540
                    end
                })
            end
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
        upvalueValues = {}
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
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, ReturnVal, r5, r6
            while state do
                if state <= 22 then
                    if state <= 20 then
                        if state <= 19 then
                            -- root entry 6306426 -> 1, states 1-19
                            if state <= 10 then
                                if state <= 5 then
                                    if state <= 3 then
                                        if state <= 2 then
                                            if state <= 1 then
                                                if state == 1 then -- entry 6306426 -> 1
                                                    ReturnVal = "_G"
                                                    state = _env[ReturnVal]
                                                    ReturnVal = "scw"
                                                    r1 = 0
                                                    state[ReturnVal] = r1
                                                    state = createClosure2(20, {})
                                                    ReturnVal = "scA"
                                                    _env[ReturnVal] = state
                                                    state = createClosure5(21, {})
                                                    ReturnVal = "scB"
                                                    _env[ReturnVal] = state
                                                    state = createClosure2(22, {})
                                                    ReturnVal = "scC"
                                                    _env[ReturnVal] = state
                                                    r2 = args
                                                    state = 2
                                                end
                                            else
                                                if state == 2 then
                                                    r5 = "scA"
                                                    r1 = _env[r5]
                                                    r5 = r1()
                                                    state = r5 and 3 or 4
                                                    ReturnVal = r5
                                                end
                                            end
                                        else
                                            if state == 3 then
                                                r5 = state
                                                r4 = "scB"
                                                r3 = _env[r4]
                                                r4 = r3()
                                                state = r4 and 5 or 6
                                                r1 = r4
                                            end
                                        end
                                    else
                                        if state <= 4 then
                                            if state == 4 then
                                                state = ReturnVal and 7 or 8
                                            end
                                        else
                                            if state == 5 then
                                                state = r5
                                                ReturnVal = r1
                                                state = 4
                                            end
                                        end
                                    end
                                else
                                    if state <= 8 then
                                        if state <= 7 then
                                            if state <= 6 then
                                                if state == 6 then
                                                    r4 = "scC"
                                                    r3 = _env[r4]
                                                    r4 = r3()
                                                    r1 = r4
                                                    state = 5
                                                end
                                            else
                                                if state == 7 then
                                                    ReturnVal = "print"
                                                    state = _env[ReturnVal]
                                                    r4 = "_G"
                                                    r3 = _env[r4]
                                                    r4 = "scw"
                                                    r5 = r3[r4]
                                                    r1 = "short-while-body"
                                                    ReturnVal = state(r1, r5)
                                                    state = 2
                                                end
                                            end
                                        else
                                            if state == 8 then
                                                ReturnVal = "_G"
                                                state = _env[ReturnVal]
                                                r1 = 0
                                                ReturnVal = "scr"
                                                state[ReturnVal] = r1
                                                state = createClosure0(23, {})
                                                ReturnVal = "srA"
                                                _env[ReturnVal] = state
                                                state = createClosure3(24, {})
                                                ReturnVal = "srB"
                                                _env[ReturnVal] = state
                                                state = createClosure5(25, {})
                                                ReturnVal = "srC"
                                                _env[ReturnVal] = state
                                                r5 = state
                                                r4 = "srA"
                                                r3 = _env[r4]
                                                r4 = r3()
                                                state = r4 and 9 or 10
                                                r1 = r4
                                            end
                                        end
                                    else
                                        if state <= 9 then
                                            if state == 9 then
                                                r4 = "srB"
                                                r3 = _env[r4]
                                                r4 = r3()
                                                r1 = r4
                                                state = 10
                                            end
                                        else
                                            if state == 10 then
                                                state = r5
                                                state = r1 and 11 or 12
                                                ReturnVal = r1
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
                                                    state = 13
                                                end
                                            else
                                                if state == 12 then
                                                    r5 = "srC"
                                                    r1 = _env[r5]
                                                    r5 = r1()
                                                    ReturnVal = r5
                                                    state = 11
                                                end
                                            end
                                        else
                                            if state == 13 then
                                                ReturnVal = "print"
                                                state = _env[ReturnVal]
                                                r4 = "_G"
                                                r3 = _env[r4]
                                                r4 = "scr"
                                                r5 = r3[r4]
                                                r1 = "short-repeat-body"
                                                ReturnVal = state(r1, r5)
                                                state = 14
                                            end
                                        end
                                    else
                                        if state <= 14 then
                                            if state == 14 then
                                                r5 = state
                                                r4 = "srA"
                                                r3 = _env[r4]
                                                r4 = r3()
                                                state = r4 and 15 or 16
                                                r1 = r4
                                            end
                                        else
                                            if state == 15 then
                                                r4 = "srB"
                                                r3 = _env[r4]
                                                r4 = r3()
                                                r1 = r4
                                                state = 16
                                            end
                                        end
                                    end
                                else
                                    if state <= 17 then
                                        if state <= 16 then
                                            if state == 16 then
                                                state = r5
                                                state = r1 and 17 or 18
                                                ReturnVal = r1
                                            end
                                        else
                                            if state == 17 then
                                                state = ReturnVal and 19 or 13
                                            end
                                        end
                                    else
                                        if state <= 18 then
                                            if state == 18 then
                                                r5 = "srC"
                                                r1 = _env[r5]
                                                r5 = r1()
                                                ReturnVal = r5
                                                state = 17
                                            end
                                        else
                                            if state == 19 then
                                                ReturnVal = "print"
                                                state = _env[ReturnVal]
                                                r4 = "_G"
                                                r3 = _env[r4]
                                                r4 = "scw"
                                                r5 = r3[r4]
                                                r6 = "_G"
                                                r4 = _env[r6]
                                                r6 = "scr"
                                                r3 = r4[r6]
                                                r1 = "short-end"
                                                ReturnVal = state(r1, r5, r3)
                                                ReturnVal = {}
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            -- createClosure2 entry 9372094 -> 20, states 20-20
                            if state == 20 then -- entry 9372094 -> 20
                                ReturnVal = "_G"
                                state = _env[ReturnVal]
                                r3 = "_G"
                                r5 = _env[r3]
                                r3 = "scw"
                                r1 = r5[r3]
                                r5 = 1
                                r2 = r1 + r5
                                ReturnVal = "scw"
                                state[ReturnVal] = r2
                                ReturnVal = "print"
                                state = _env[ReturnVal]
                                r3 = "_G"
                                r5 = _env[r3]
                                r3 = "scw"
                                r1 = r5[r3]
                                r2 = "A"
                                ReturnVal = state(r2, r1)
                                r1 = "_G"
                                r2 = _env[r1]
                                r1 = "scw"
                                ReturnVal = r2[r1]
                                r2 = 4
                                state = ReturnVal < r2
                                ReturnVal = {
                                    state
                                }
                                state = nil
                            end
                        end
                    else
                        if state <= 21 then
                            -- createClosure5 entry 7886567 -> 21, states 21-21
                            if state == 21 then -- entry 7886567 -> 21
                                ReturnVal = "print"
                                state = _env[ReturnVal]
                                r3 = "_G"
                                r5 = _env[r3]
                                r3 = "scw"
                                r1 = r5[r3]
                                r2 = "B"
                                ReturnVal = state(r2, r1)
                                r5 = "_G"
                                r1 = _env[r5]
                                r5 = "scw"
                                r2 = r1[r5]
                                r1 = 2
                                ReturnVal = r2 % r1
                                r2 = 0
                                state = ReturnVal == r2
                                ReturnVal = {
                                    state
                                }
                                state = nil
                            end
                        else
                            -- createClosure2 entry 10150443 -> 22, states 22-22
                            if state == 22 then -- entry 10150443 -> 22
                                ReturnVal = "print"
                                state = _env[ReturnVal]
                                r3 = "_G"
                                r5 = _env[r3]
                                r3 = "scw"
                                r1 = r5[r3]
                                r2 = "C"
                                ReturnVal = state(r2, r1)
                                state = true
                                ReturnVal = {
                                    state
                                }
                                state = nil
                            end
                        end
                    end
                else
                    if state <= 24 then
                        if state <= 23 then
                            -- createClosure0 entry 13707145 -> 23, states 23-23
                            if state == 23 then -- entry 13707145 -> 23
                                ReturnVal = "_G"
                                state = _env[ReturnVal]
                                r3 = "_G"
                                r5 = _env[r3]
                                r3 = "scr"
                                r1 = r5[r3]
                                r5 = 1
                                r2 = r1 + r5
                                ReturnVal = "scr"
                                state[ReturnVal] = r2
                                ReturnVal = "print"
                                state = _env[ReturnVal]
                                r3 = "_G"
                                r5 = _env[r3]
                                r3 = "scr"
                                r1 = r5[r3]
                                r2 = "RA"
                                ReturnVal = state(r2, r1)
                                r1 = "_G"
                                r2 = _env[r1]
                                r1 = "scr"
                                ReturnVal = r2[r1]
                                r2 = 3
                                state = ReturnVal >= r2
                                ReturnVal = {
                                    state
                                }
                                state = nil
                            end
                        else
                            -- createClosure3 entry 5252433 -> 24, states 24-24
                            if state == 24 then -- entry 5252433 -> 24
                                ReturnVal = "print"
                                state = _env[ReturnVal]
                                r3 = "_G"
                                r5 = _env[r3]
                                r3 = "scr"
                                r1 = r5[r3]
                                r2 = "RB"
                                ReturnVal = state(r2, r1)
                                r5 = "_G"
                                r1 = _env[r5]
                                r5 = "scr"
                                r2 = r1[r5]
                                r1 = 2
                                ReturnVal = r2 % r1
                                r2 = 1
                                state = ReturnVal == r2
                                ReturnVal = {
                                    state
                                }
                                state = nil
                            end
                        end
                    else
                        -- createClosure5 entry 9158541 -> 25, states 25-25
                        if state == 25 then -- entry 9158541 -> 25
                            ReturnVal = "print"
                            state = _env[ReturnVal]
                            r3 = "_G"
                            r5 = _env[r3]
                            r3 = "scr"
                            r1 = r5[r3]
                            r2 = "RC"
                            ReturnVal = state(r2, r1)
                            state = false
                            ReturnVal = {
                                state
                            }
                            state = nil
                        end
                    end
                end
            end
            state = #gcProxy
            return unpack(ReturnVal)
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
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)