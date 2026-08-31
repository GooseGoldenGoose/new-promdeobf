return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, allocUpvalue, releaseUpvalues, upvalueRefCounts, vm, currentUpvalueId, createUpvalueProxy, createClosure, upvalueValues, releaseUpvalue)
        upvalueValues = {}
        upvalueRefCounts = {}
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        currentUpvalueId = 0
        vm = function(state, args, upvalues, gcProxy)
            local r1, ReturnVal, r2, r3, r4, r5, r6, r7, r8
            while state do
                -- root entry 2055284 -> 1, states 1-9
                if state <= 5 then
                    if state <= 3 then
                        if state <= 2 then
                            if state <= 1 then
                                if state == 1 then -- entry 2055284 -> 1
                                    state = 213
                                    r6 = state
                                    r2 = "math"
                                    r8 = _env[r2]
                                    r2 = "random"
                                    r4 = r8[r2]
                                    r1 = 2
                                    r2 = 1
                                    r8 = r4(r2, r1)
                                    r4 = 1
                                    ReturnVal = r8 == r4
                                    state = not ReturnVal
                                    state = state and 2 or 3
                                    r7 = args
                                end
                            else
                                if state == 2 then
                                    state = 1
                                    r6 = state
                                    r4 = "print"
                                    ReturnVal = _env[r4]
                                    r8 = "C"
                                    r4 = ReturnVal(r8)
                                    state = 4
                                end
                            end
                        else
                            if state == 3 then
                                r2 = "math"
                                r8 = _env[r2]
                                r2 = "random"
                                r4 = r8[r2]
                                r1 = 2
                                r2 = 1
                                r8 = r4(r2, r1)
                                r4 = 1
                                ReturnVal = r8 == r4
                                state = ReturnVal and 5 or 4
                            end
                        end
                    else
                        if state <= 4 then
                            if state == 4 then
                                r8 = "print"
                                r4 = _env[r8]
                                r8 = r4(r6)
                                r3 = "math"
                                r1 = _env[r3]
                                r3 = "random"
                                r2 = r1[r3]
                                r5 = 2
                                r3 = 1
                                r1 = r2(r3, r5)
                                r2 = 1
                                r8 = r1 == r2
                                r4 = not r8
                                state = r4 and 6 or 7
                            end
                        else
                            if state == 5 then
                                ReturnVal = 2
                                r8 = "print"
                                r4 = _env[r8]
                                r2 = "G"
                                r8 = r4(r2)
                                r6 = ReturnVal
                                state = 4
                            end
                        end
                    end
                else
                    if state <= 7 then
                        if state <= 6 then
                            if state == 6 then
                                r8 = "print"
                                r4 = _env[r8]
                                r2 = "W"
                                r8 = r4(r2)
                                state = 8
                            end
                        else
                            if state == 7 then
                                r1 = "math"
                                r2 = _env[r1]
                                r1 = "random"
                                r8 = r2[r1]
                                r3 = 2
                                r1 = 1
                                r2 = r8(r1, r3)
                                r8 = 1
                                r4 = r2 == r8
                                state = r4 and 9 or 8
                            end
                        end
                    else
                        if state <= 8 then
                            if state == 8 then
                                r6 = nil
                                ReturnVal = {}
                                state = nil
                            end
                        else
                            if state == 9 then
                                r8 = "print"
                                r4 = _env[r8]
                                r2 = "L"
                                r8 = r4(r2)
                                ReturnVal = {}
                                state = nil
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
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return -1927550
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -1927550
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