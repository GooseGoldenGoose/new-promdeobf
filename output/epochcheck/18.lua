return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, createClosure5, currentUpvalueId, upvalueValues, releaseUpvalue, releaseUpvalues, allocUpvalue, createClosure, upvalueRefCounts, vm, createUpvalueProxy)
        upvalueRefCounts = {}
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = upvalueRefCounts[captures[captureIndex]] + (1)
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return 3737295
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 3737295
                    end
                })
            end
        end
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
        upvalueValues = {}
        vm = function(state, args, upvalues, gcProxy)
            local ReturnVal, r1, r2, r3, r4
            while state do
                if state <= 1 then
                    -- root entry 10319247 -> 1, states 1-1
                    if state == 1 then -- entry 10319247 -> 1
                        r1 = allocUpvalue()
                        state = 123
                        upvalueValues[r1] = state
                        state = createClosure5(2, {
                            r1
                        })
                        r2 = state
                        ReturnVal = "print"
                        state = _env[ReturnVal]
                        r3 = {
                            r2()
                        }
                        ReturnVal = state(unpack(r3))
                        ReturnVal = "print"
                        state = _env[ReturnVal]
                        r3 = upvalueValues[r1]
                        ReturnVal = state(r3)
                        r1 = releaseUpvalue(r1)
                        r4 = args
                        r2 = nil
                        ReturnVal = {}
                        state = nil
                    end
                else
                    -- createClosure5 entry 7837307 -> 2, states 2-2
                    if state == 2 then -- entry 7837307 -> 2
                        ReturnVal = upvalueValues[upvalues[1]]
                        r4 = 1
                        state = ReturnVal + r4
                        upvalueValues[upvalues[1]] = state
                        ReturnVal = true
                        ReturnVal = {
                            ReturnVal
                        }
                        state = nil
                    end
                end
            end
            state = #gcProxy
            return unpack(ReturnVal)
        end
        createClosure5 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1, arg2, arg3, arg4, arg5)
                return vm(entryId, {
                    arg1,
                    arg2,
                    arg3,
                    arg4,
                    arg5
                }, captures, gcProxy)
            end
            return closure
        end
        currentUpvalueId = 0
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
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
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)