return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, createUpvalueProxy, vm, releaseUpvalue, releaseUpvalues, upvalueValues, allocUpvalue, currentUpvalueId, createClosure, upvalueRefCounts)
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, ReturnVal, r4
            while state do
                -- root entry 1839677 -> 1, states 1-4
                if state <= 2 then
                    if state <= 1 then
                        if state == 1 then -- entry 1839677 -> 1
                            r4 = "math"
                            r3 = _env[r4]
                            r4 = "random"
                            ReturnVal = r3[r4]
                            r2 = 2
                            r4 = 1
                            r3 = ReturnVal(r4, r2)
                            ReturnVal = 1
                            state = r3 == ReturnVal
                            r1 = args
                            state = 2
                        end
                    else
                        if state == 2 then
                            ReturnVal = "print"
                            state = _env[ReturnVal]
                            r3 = 12
                            ReturnVal = state(r3)
                            state = 3
                        end
                    end
                else
                    if state <= 3 then
                        if state == 3 then
                            r4 = "math"
                            r3 = _env[r4]
                            r4 = "random"
                            ReturnVal = r3[r4]
                            r2 = 2
                            r4 = 1
                            r3 = ReturnVal(r4, r2)
                            ReturnVal = 1
                            state = r3 == ReturnVal
                            state = state and 4 or 2
                        end
                    else
                        if state == 4 then
                            ReturnVal = {}
                            state = nil
                        end
                    end
                end
            end
            state = #gcProxy
            return unpack(ReturnVal)
        end
        upvalueRefCounts = {}
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
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
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = upvalueRefCounts[captures[captureIndex]] + (1)
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return 843799
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 843799
                    end
                })
            end
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
        upvalueValues = {}
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