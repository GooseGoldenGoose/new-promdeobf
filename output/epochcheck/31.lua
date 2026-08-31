return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, releaseUpvalues, releaseUpvalue, vm, createUpvalueProxy, allocUpvalue, currentUpvalueId, createClosure, upvalueRefCounts, upvalueValues)
        currentUpvalueId = 0
        upvalueRefCounts = {}
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return 1998689
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 1998689
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
            currentUpvalueId = currentUpvalueId + (1)
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        vm = function(state, args, upvalues, gcProxy)
            local r1, ReturnVal, r2, r3, r4, r5, r6, r7, r8, r9
            while state do
                -- root entry 12770468 -> 1, states 1-16
                if state <= 8 then
                    if state <= 4 then
                        if state <= 2 then
                            if state <= 1 then
                                if state == 1 then -- entry 12770468 -> 1
                                    ReturnVal = "print"
                                    state = _env[ReturnVal]
                                    r4 = "break-start"
                                    ReturnVal = state(r4)
                                    state = 0
                                    r4 = state
                                    r5 = args
                                    state = 2
                                end
                            else
                                if state == 2 then
                                    ReturnVal = 5
                                    state = r4 < ReturnVal
                                    state = state and 3 or 4
                                end
                            end
                        else
                            if state <= 3 then
                                if state == 3 then
                                    ReturnVal = 1
                                    state = r4 + ReturnVal
                                    r4 = state
                                    r3 = "print"
                                    ReturnVal = _env[r3]
                                    r9 = "break-while"
                                    r3 = ReturnVal(r9, r4)
                                    r3 = 3
                                    ReturnVal = r4 == r3
                                    state = ReturnVal and 5 or 6
                                end
                            else
                                if state == 4 then
                                    r3 = 5
                                    r9 = r3
                                    r3 = 1
                                    r8 = r3
                                    r3 = 0
                                    r2 = r8 < r3
                                    ReturnVal = 1
                                    r3 = ReturnVal - r8
                                    state = 7
                                end
                            end
                        end
                    else
                        if state <= 6 then
                            if state <= 5 then
                                if state == 5 then
                                    state = 4
                                end
                            else
                                if state == 6 then
                                    state = 2
                                end
                            end
                        else
                            if state <= 7 then
                                if state == 7 then
                                    r3 = r3 + r8
                                    r1 = not r2
                                    ReturnVal = r3 <= r9
                                    ReturnVal = r1 and ReturnVal
                                    r1 = r3 >= r9
                                    r1 = r2 and r1
                                    ReturnVal = r1 or ReturnVal
                                    r1 = 8
                                    state = ReturnVal and r1
                                    ReturnVal = 9
                                    state = state or ReturnVal
                                end
                            else
                                if state == 8 then
                                    r1 = r3
                                    r7 = "print"
                                    ReturnVal = _env[r7]
                                    r6 = "break-for"
                                    r7 = ReturnVal(r6, r1)
                                    r7 = 2
                                    ReturnVal = r1 == r7
                                    state = ReturnVal and 10 or 11
                                end
                            end
                        end
                    end
                else
                    if state <= 12 then
                        if state <= 10 then
                            if state <= 9 then
                                if state == 9 then
                                    ReturnVal = 0
                                    r3 = ReturnVal
                                    r9 = 5
                                    ReturnVal = r3 >= r9
                                    state = 12
                                end
                            else
                                if state == 10 then
                                    r1 = nil
                                    state = 9
                                end
                            end
                        else
                            if state <= 11 then
                                if state == 11 then
                                    r1 = nil
                                    state = 7
                                end
                            else
                                if state == 12 then
                                    r9 = 1
                                    ReturnVal = r3 + r9
                                    r3 = ReturnVal
                                    r8 = "print"
                                    r9 = _env[r8]
                                    r2 = "break-repeat"
                                    r8 = r9(r2, r3)
                                    r8 = 2
                                    r9 = r3 == r8
                                    state = r9 and 13 or 14
                                end
                            end
                        end
                    else
                        if state <= 14 then
                            if state <= 13 then
                                if state == 13 then
                                    state = 15
                                end
                            else
                                if state == 14 then
                                    state = 16
                                end
                            end
                        else
                            if state <= 15 then
                                if state == 15 then
                                    ReturnVal = {}
                                    r8 = "print"
                                    r9 = _env[r8]
                                    r2 = "break-end"
                                    r8 = r9(r2, r4, r3)
                                    r3 = nil
                                    r4 = nil
                                    state = nil
                                end
                            else
                                if state == 16 then
                                    r8 = 5
                                    r9 = r3 >= r8
                                    state = r9 and 15 or 12
                                end
                            end
                        end
                    end
                end
            end
            state = #gcProxy
            return unpack(ReturnVal)
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
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if 0 == upvalueRefCounts[upvalueId] then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)