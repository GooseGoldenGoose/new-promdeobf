return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, createClosure6, createClosure, releaseUpvalues, releaseUpvalue, allocUpvalue, currentUpvalueId, upvalueRefCounts, createUpvalueProxy, vm, upvalueValues)
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return -4180087
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -4180087
                    end
                })
            end
        end
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
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
        upvalueRefCounts = {}
        createClosure6 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1, arg2, arg3, arg4, arg5, arg6)
                return vm(entryId, {
                    arg1,
                    arg2,
                    arg3,
                    arg4,
                    arg5,
                    arg6
                }, captures, gcProxy)
            end
            return closure
        end
        vm = function(state, args, upvalues, gcProxy)
            local ReturnVal, r1, r2, r3
            while state do
                if state <= 1 then
                    -- root entry 4532186 -> 1, states 1-1
                    if state == 1 then -- entry 4532186 -> 1
                        state = createClosure6(2, {})
                        r2 = state
                        ReturnVal = "table"
                        state = r2(ReturnVal)
                        r3 = state
                        ReturnVal = "after"
                        state = r2(ReturnVal)
                        state = {
                            r3
                        }
                        r1 = args
                        ReturnVal = {
                            state
                        }
                        state = nil
                    end
                else
                    -- createClosure6 entry 7702988 -> 2, states 2-2
                    if state == 2 then -- entry 7702988 -> 2
                        r1 = args[1]
                        ReturnVal = "print"
                        state = _env[ReturnVal]
                        ReturnVal = state(r1)
                        ReturnVal = {
                            r1
                        }
                        state = nil
                    end
                end
            end
            state = #gcProxy
            return unpack(ReturnVal)
        end
        currentUpvalueId = 0
        upvalueValues = {}
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)