return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, vm, allocUpvalue, releaseUpvalues, releaseUpvalue, currentUpvalueId, createUpvalueProxy, createClosure, upvalueRefCounts, upvalueValues)
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if 0 == upvalueRefCounts[upvalueId] then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
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
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        upvalueValues = {}
        upvalueRefCounts = {}
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
        currentUpvalueId = 0
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return -3848608
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -3848608
                    end
                })
            end
        end
        vm = function(state, args, upvalues, gcProxy)
            local r1, ReturnVal, r2
            while state do
                -- root entry 15111455 -> 1, states 1-1
                if state == 1 then -- entry 15111455 -> 1
                    state = 3
                    r2 = state
                    ReturnVal = "print"
                    state = _env[ReturnVal]
                    ReturnVal = state(r2)
                    state = 4
                    r2 = state
                    r1 = args
                    ReturnVal = {
                        r2
                    }
                    state = nil
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