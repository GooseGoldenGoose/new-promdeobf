return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, releaseUpvalues, createClosure, createUpvalueProxy, upvalueRefCounts, vm, allocUpvalue, currentUpvalueId, upvalueValues, releaseUpvalue)
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, ReturnVal, r6, r7, r8
            while state do
                -- root entry 5121747 -> 1, states 1-9
                if state <= 5 then
                    if state <= 3 then
                        if state <= 2 then
                            if state <= 1 then
                                if state == 1 then -- entry 5121747 -> 1
                                    ReturnVal = "ipairs"
                                    state = _env[ReturnVal]
                                    r4 = 3
                                    r5 = 4
                                    r8 = 1
                                    r2 = 2
                                    r3 = {
                                        r8,
                                        r2,
                                        r4,
                                        r5
                                    }
                                    r8 = {
                                        state(r3)
                                    }
                                    ReturnVal = r8[1]
                                    r1 = r8[3]
                                    r7 = r8[2]
                                    r3 = ReturnVal
                                    r6 = args
                                    state = 2
                                end
                            else
                                if state == 2 then
                                    r1, r2 = r3(r7, r1)
                                    state = r1 and 3 or 4
                                end
                            end
                        else
                            if state == 3 then
                                r8 = r1
                                r5 = 2
                                r4 = r8 % r5
                                r5 = 0
                                state = r4 == r5
                                state = state and 5 or 6
                            end
                        end
                    else
                        if state <= 4 then
                            if state == 4 then
                                r7 = "print"
                                state = _env[r7]
                                r1 = "after-break"
                                r7 = state(r1)
                                ReturnVal = {}
                                state = nil
                            end
                        else
                            if state == 5 then
                                r4 = "print"
                                state = _env[r4]
                                r5 = "even"
                                r4 = state(r5, r8, r2)
                                state = 7
                            end
                        end
                    end
                else
                    if state <= 7 then
                        if state <= 6 then
                            if state == 6 then
                                r4 = "print"
                                state = _env[r4]
                                r5 = "odd"
                                r4 = state(r5, r8, r2)
                                state = 7
                            end
                        else
                            if state == 7 then
                                r4 = 3
                                state = r8 == r4
                                state = state and 8 or 9
                            end
                        end
                    else
                        if state <= 8 then
                            if state == 8 then
                                r2 = nil
                                r8 = nil
                                state = 4
                            end
                        else
                            if state == 9 then
                                r2 = nil
                                r8 = nil
                                state = 2
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
            if upvalueRefCounts[upvalueId] == 0 then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return -3225309
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -3225309
                    end
                })
            end
        end
        upvalueValues = {}
        currentUpvalueId = 0
        upvalueRefCounts = {}
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
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