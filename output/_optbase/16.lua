return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, releaseUpvalues, vm, currentUpvalueId, allocUpvalue, upvalueRefCounts, upvalueValues, createClosure, createUpvalueProxy, releaseUpvalue)
        upvalueValues = {}
        currentUpvalueId = 0
        releaseUpvalues = function(captures)
            local captureIndex, upvalueId = 1, captures[1]
            while upvalueId do
                upvalueRefCounts[upvalueId], captureIndex = upvalueRefCounts[upvalueId] - (1), (1) + captureIndex
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
                    return 1356734
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 1356734
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
        upvalueRefCounts = {}
        vm = function(state, args, upvalues, gcProxy)
            local ReturnVal, r1, r2, r3, r4, r5, r6, r7, r8, r9
            while state do
                -- root entry 2442636 -> 1, states 1-11
                if state <= 6 then
                    if state <= 3 then
                        if state <= 2 then
                            if state <= 1 then
                                if state == 1 then -- entry 2442636 -> 1
                                    state = 213
                                    r7 = state
                                    r3 = "math"
                                    r2 = _env[r3]
                                    r3 = "random"
                                    r6 = r2[r3]
                                    r4 = 2
                                    r3 = 1
                                    r2 = r6(r3, r4)
                                    r6 = 1
                                    ReturnVal = r2 == r6
                                    state = not ReturnVal
                                    state = state and 2 or 3
                                    r8 = args
                                end
                            else
                                if state == 2 then
                                    state = 1
                                    r7 = state
                                    r6 = "print"
                                    ReturnVal = _env[r6]
                                    r2 = "C"
                                    r6 = ReturnVal(r2)
                                    state = 4
                                end
                            end
                        else
                            if state == 3 then
                                r3 = "math"
                                r2 = _env[r3]
                                r3 = "random"
                                r6 = r2[r3]
                                r4 = 2
                                r3 = 1
                                r2 = r6(r3, r4)
                                r6 = 1
                                ReturnVal = r2 == r6
                                state = ReturnVal and 5 or 6
                            end
                        end
                    else
                        if state <= 5 then
                            if state <= 4 then
                                if state == 4 then
                                    r3 = "print"
                                    r2 = _env[r3]
                                    r3 = r2(r7)
                                    r5 = "math"
                                    r1 = _env[r5]
                                    r5 = "random"
                                    r4 = r1[r5]
                                    r9 = 2
                                    r5 = 1
                                    r1 = r4(r5, r9)
                                    r4 = 1
                                    r3 = r1 == r4
                                    r2 = not r3
                                    state = r2 and 7 or 8
                                end
                            else
                                if state == 5 then
                                    ReturnVal = 2
                                    r2 = "print"
                                    r6 = _env[r2]
                                    r3 = "G"
                                    r2 = r6(r3)
                                    r7 = ReturnVal
                                    state = 4
                                end
                            end
                        else
                            if state == 6 then
                                r6 = 3
                                r3 = "print"
                                r2 = _env[r3]
                                r4 = "E"
                                r3 = r2(r4)
                                r7 = r6
                                state = 4
                            end
                        end
                    end
                else
                    if state <= 9 then
                        if state <= 8 then
                            if state <= 7 then
                                if state == 7 then
                                    r3 = "print"
                                    r2 = _env[r3]
                                    r4 = "W"
                                    r3 = r2(r4)
                                    state = 9
                                end
                            else
                                if state == 8 then
                                    r1 = "math"
                                    r4 = _env[r1]
                                    r1 = "random"
                                    r3 = r4[r1]
                                    r5 = 2
                                    r1 = 1
                                    r4 = r3(r1, r5)
                                    r3 = 1
                                    r2 = r4 == r3
                                    state = r2 and 10 or 11
                                end
                            end
                        else
                            if state == 9 then
                                r3 = "print"
                                r2 = _env[r3]
                                ReturnVal = {}
                                r4 = "done"
                                r3 = r2(r4, r7)
                                r7 = nil
                                state = nil
                            end
                        end
                    else
                        if state <= 10 then
                            if state == 10 then
                                r3 = "print"
                                r2 = _env[r3]
                                ReturnVal = {}
                                r4 = "L"
                                r3 = r2(r4)
                                state = nil
                            end
                        else
                            if state == 11 then
                                r3 = "print"
                                r2 = _env[r3]
                                r4 = "Z"
                                r3 = r2(r4)
                                state = 9
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
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)