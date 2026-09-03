return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, releaseUpvalue, allocUpvalue, releaseUpvalues, currentUpvalueId, upvalueValues, createClosure, upvalueRefCounts, createUpvalueProxy, vm)
        currentUpvalueId = 0
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if upvalueRefCounts[upvalueId] == 0 then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
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
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, ReturnVal, r9, r10, r11, r12
            while state do
                -- root entry 3979856 -> 1, states 1-15
                if state <= 8 then
                    if state <= 4 then
                        if state <= 2 then
                            if state <= 1 then
                                if state == 1 then -- entry 3979856 -> 1
                                    state = 1
                                    r11 = state
                                    state = 1
                                    r5 = state
                                    state = 1
                                    r10 = state
                                    ReturnVal = "print"
                                    state = _env[ReturnVal]
                                    ReturnVal = state(r11, r5, r10)
                                    r4 = state
                                    state = r11 and (2) or (3)
                                    r6 = args
                                    r7 = r11
                                end
                            else
                                if state == 2 then
                                    r7 = r5
                                    state = 3
                                end
                            end
                        else
                            if state <= 3 then
                                if state == 3 then
                                    state = r4
                                    state = r7 and (4) or (5)
                                    ReturnVal = r7
                                end
                            else
                                if state == 4 then
                                    r7 = ReturnVal
                                    ReturnVal = "print"
                                    state = _env[ReturnVal]
                                    r3 = state
                                    state = r7 and (6) or (7)
                                    r4 = r7
                                end
                            end
                        end
                    else
                        if state <= 6 then
                            if state <= 5 then
                                if state == 5 then
                                    r4 = state
                                    state = r10 and (8) or (9)
                                    r7 = r10
                                end
                            else
                                if state == 6 then
                                    r4 = r11
                                    state = 7
                                end
                            end
                        else
                            if state <= 7 then
                                if state == 7 then
                                    r10 = nil
                                    r5 = nil
                                    state = r3
                                    ReturnVal = state(r4)
                                    r7 = nil
                                    r11 = nil
                                    ReturnVal = {}
                                    state = nil
                                end
                            else
                                if state == 8 then
                                    state = r4
                                    ReturnVal = r7
                                    state = 4
                                end
                            end
                        end
                    end
                else
                    if state <= 12 then
                        if state <= 10 then
                            if state <= 9 then
                                if state == 9 then
                                    r9 = state
                                    state = r10 and (10) or (11)
                                    r3 = r10
                                end
                            else
                                if state == 10 then
                                    state = r9
                                    r7 = r3
                                    state = 8
                                end
                            end
                        else
                            if state <= 11 then
                                if state == 11 then
                                    r8 = state
                                    state = r10 and (12) or (13)
                                    r12 = r10
                                end
                            else
                                if state == 12 then
                                    state = r8
                                    r3 = r12
                                    state = 10
                                end
                            end
                        end
                    else
                        if state <= 14 then
                            if state <= 13 then
                                if state == 13 then
                                    r2 = state
                                    state = r11 and (14) or (15)
                                    r1 = r11
                                end
                            else
                                if state == 14 then
                                    r1 = r10
                                    state = 15
                                end
                            end
                        else
                            if state == 15 then
                                state = r2
                                r12 = r1
                                state = 12
                            end
                        end
                    end
                end
            end
            state = #gcProxy
            return unpack(ReturnVal)
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
            currentUpvalueId = currentUpvalueId + (1)
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
                    return 424889
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 424889
                    end
                })
            end
        end
        upvalueRefCounts = {}
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)