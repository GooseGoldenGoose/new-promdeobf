return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, upvalueValues, allocUpvalue, createUpvalueProxy, upvalueRefCounts, releaseUpvalue, releaseUpvalues, vm, currentUpvalueId, createClosure)
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        currentUpvalueId = 0
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if 0 == upvalueRefCounts[upvalueId] then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, ReturnVal
            while state do
                -- root entry 7166338 -> 1, states 1-3
                if state <= 2 then
                    if state <= 1 then
                        if state == 1 then -- entry 7166338 -> 1
                            ReturnVal = "warn"
                            state = _env[ReturnVal]
                            r1 = "gg"
                            ReturnVal = state(r1)
                            r2 = "math"
                            r1 = _env[r2]
                            r2 = "random"
                            ReturnVal = r1[r2]
                            r3 = 2
                            r2 = 1
                            r1 = ReturnVal(r2, r3)
                            ReturnVal = 1
                            state = r1 == ReturnVal
                            state = state and 2 or 3
                            r4 = args
                        end
                    else
                        if state == 2 then
                            ReturnVal = "print"
                            state = _env[ReturnVal]
                            r1 = "ranf"
                            ReturnVal = state(r1)
                            state = 3
                        end
                    end
                else
                    if state == 3 then
                        ReturnVal = {}
                        state = nil
                    end
                end
            end
            state = #gcProxy
            return unpack(ReturnVal)
        end
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
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = upvalueRefCounts[captures[captureIndex]] + (1)
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return -3421254
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -3421254
                    end
                })
            end
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
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)