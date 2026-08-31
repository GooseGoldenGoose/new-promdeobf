return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, releaseUpvalue, releaseUpvalues, currentUpvalueId, createUpvalueProxy, upvalueValues, upvalueRefCounts, createClosure, allocUpvalue, vm)
        currentUpvalueId = 0
        upvalueValues = {}
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, ReturnVal, r3, r4, r5
            while state do
                -- root entry 9789898 -> 1, states 1-4
                if state <= 2 then
                    if state <= 1 then
                        if state == 1 then -- entry 9789898 -> 1
                            state = true
                            ReturnVal = "valid"
                            _env[ReturnVal] = state
                            r2 = "valid"
                            ReturnVal = _env[r2]
                            r4 = args
                            state = 2
                        end
                    else
                        if state == 2 then
                            state = 3
                        end
                    end
                else
                    if state <= 3 then
                        if state == 3 then
                            r2 = "valid"
                            ReturnVal = _env[r2]
                            state = ReturnVal and 4 or 2
                        end
                    else
                        if state == 4 then
                            r2 = "print"
                            ReturnVal = _env[r2]
                            r3 = "valid"
                            r1 = _env[r3]
                            r5 = "empty-repeat"
                            r2 = ReturnVal(r5, r1)
                            ReturnVal = {}
                            state = nil
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
        upvalueRefCounts = {}
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if 0 == upvalueRefCounts[upvalueId] then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
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
                    return 3940922
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 3940922
                    end
                })
            end
        end
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)