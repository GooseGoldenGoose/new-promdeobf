return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, upvalueRefCounts, createUpvalueProxy, releaseUpvalue, allocUpvalue, releaseUpvalues, currentUpvalueId, upvalueValues, createClosure, vm)
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
            local r1, r2, r3, r4, r5, ReturnVal, r6
            while state do
                -- root entry 8099129 -> 1, states 1-1
                if state == 1 then -- entry 8099129 -> 1
                    state = nil
                    r4 = state
                    ReturnVal = "print"
                    state = _env[ReturnVal]
                    r2 = "x0"
                    ReturnVal = state(r2, r4)
                    state = 5
                    r4 = state
                    r2 = "print"
                    ReturnVal = _env[r2]
                    r3 = "x1"
                    r2 = ReturnVal(r3, r4)
                    ReturnVal = nil
                    r2 = ReturnVal
                    r3 = "print"
                    ReturnVal = _env[r3]
                    r6 = "y0"
                    r3 = ReturnVal(r6, r2)
                    r6 = "print"
                    r3 = _env[r6]
                    ReturnVal = 6
                    r2 = ReturnVal
                    r1 = "y1"
                    r6 = r3(r1, r2)
                    r5 = args
                    r4 = nil
                    r2 = nil
                    ReturnVal = {}
                    state = nil
                end
            end
            state = #gcProxy
            return unpack(ReturnVal)
        end
        upvalueRefCounts = {}
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if upvalueRefCounts[upvalueId] == 0 then
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
        currentUpvalueId = 0
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return -3238794
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -3238794
                    end
                })
            end
        end
        allocUpvalue = function()
            currentUpvalueId = currentUpvalueId + (1)
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)