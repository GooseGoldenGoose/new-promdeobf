return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, createUpvalueProxy, releaseUpvalue, releaseUpvalues, createClosure, upvalueRefCounts, upvalueValues, allocUpvalue, currentUpvalueId, vm)
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
                    return -2342742
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -2342742
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
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if 0 == upvalueRefCounts[upvalueId] then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        upvalueRefCounts = {}
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
        currentUpvalueId = 0
        vm = function(state, args, upvalues, gcProxy)
            local ReturnVal, r1, r2, r3, r4
            while state do
                -- root entry 9908920 -> 1, states 1-4
                if state <= 2 then
                    if state <= 1 then
                        if state == 1 then -- entry 9908920 -> 1
                            r3 = args
                            state = 2
                        end
                    else
                        if state == 2 then
                            r4 = "math"
                            r1 = _env[r4]
                            r4 = "random"
                            ReturnVal = r1[r4]
                            r4 = 1
                            r2 = 2
                            r1 = ReturnVal(r4, r2)
                            ReturnVal = 1
                            state = r1 == ReturnVal
                            state = state and 3 or 4
                        end
                    end
                else
                    if state <= 3 then
                        if state == 3 then
                            ReturnVal = "print"
                            state = _env[ReturnVal]
                            r1 = 27
                            ReturnVal = state(r1)
                            state = 2
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
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)