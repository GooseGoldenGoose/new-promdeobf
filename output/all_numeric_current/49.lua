return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, releaseUpvalue, upvalueValues, releaseUpvalues, upvalueRefCounts, allocUpvalue, vm, currentUpvalueId, createClosure, createUpvalueProxy)
        upvalueValues = {}
        upvalueRefCounts = {}
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if 0 == upvalueRefCounts[upvalueId] then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        currentUpvalueId = 0
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, r9, ReturnVal, r10, r11, r12, r13, r14
            while state do
                -- root entry 7284605 -> 1, states 1-8
                if state <= 4 then
                    if state <= 2 then
                        if state <= 1 then
                            if state == 1 then -- entry 7284605 -> 1
                                state = true
                                r3 = state
                                ReturnVal = false
                                r14 = "ok"
                                state = {
                                    ReturnVal,
                                    r14
                                }
                                r14 = state
                                state = "ok"
                                r10 = state
                                r2 = 2
                                r9 = r2
                                r2 = 1
                                r5 = r2
                                r2 = 0
                                r7 = r5 < r2
                                ReturnVal = 1
                                r2 = ReturnVal - r5
                                r12 = args
                                state = 2
                            end
                        else
                            if state == 2 then
                                r6 = not r7
                                r2 = r2 + r5
                                ReturnVal = r2 <= r9
                                ReturnVal = r6 and ReturnVal
                                r6 = r2 >= r9
                                r6 = r7 and r6
                                ReturnVal = r6 or ReturnVal
                                r6 = 3
                                state = ReturnVal and r6
                                ReturnVal = 4
                                state = state or ReturnVal
                            end
                        end
                    else
                        if state <= 3 then
                            if state == 3 then
                                state = r3 and 5 or 6
                                ReturnVal = r3
                                r6 = r2
                            end
                        else
                            if state == 4 then
                                ReturnVal = {}
                                r2 = "print"
                                state = _env[r2]
                                r9 = "chain"
                                r2 = state(r9, r3)
                                r10 = nil
                                r14 = nil
                                r3 = nil
                                state = nil
                            end
                        end
                    end
                else
                    if state <= 6 then
                        if state <= 5 then
                            if state == 5 then
                                r4 = 1
                                r8 = r14[r4]
                                r4 = false
                                r11 = r8 == r4
                                r13 = state
                                state = r11 and 7 or 8
                                r1 = r11
                            end
                        else
                            if state == 6 then
                                r1 = "print"
                                state = _env[r1]
                                r13 = "i"
                                r1 = state(r13, r6)
                                r3 = ReturnVal
                                r6 = nil
                                state = 2
                            end
                        end
                    else
                        if state <= 7 then
                            if state == 7 then
                                r4 = 2
                                r8 = r14[r4]
                                r11 = r8 == r10
                                r1 = r11
                                state = 8
                            end
                        else
                            if state == 8 then
                                state = r13
                                ReturnVal = r1
                                state = 6
                            end
                        end
                    end
                end
            end
            state = #gcProxy
            return unpack(ReturnVal)
        end
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = upvalueRefCounts[captures[captureIndex]] + (1)
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return -1533436
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -1533436
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
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)