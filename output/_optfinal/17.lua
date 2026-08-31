return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, releaseUpvalue, createClosure, allocUpvalue, currentUpvalueId, releaseUpvalues, createClosure4, vm, upvalueValues, upvalueRefCounts, createUpvalueProxy)
        createClosure4 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1, arg2, arg3, arg4)
                return vm(entryId, {
                    arg1,
                    arg2,
                    arg3,
                    arg4
                }, captures, gcProxy)
            end
            return closure
        end
        vm = function(state, args, upvalues, gcProxy)
            local ReturnVal, r1, r2, r3, r4, r5
            while state do
                if state <= 1 then
                    -- root entry 3307686 -> 1, states 1-1
                    if state == 1 then -- entry 3307686 -> 1
                        ReturnVal = "print"
                        state = _env[ReturnVal]
                        r2 = "1"
                        ReturnVal = state(r2)
                        state = createClosure4(2, {})
                        r2 = state
                        ReturnVal = "print"
                        state = _env[ReturnVal]
                        r1 = 2
                        ReturnVal = state(r1)
                        ReturnVal = "print"
                        state = _env[ReturnVal]
                        r3 = 1
                        r5 = 2
                        r1 = {
                            r2(r3, r5)
                        }
                        ReturnVal = state(unpack(r1))
                        r4 = args
                        r2 = nil
                        ReturnVal = {}
                        state = nil
                    end
                else
                    -- createClosure4 entry 9459450 -> 2, states 2-2
                    if state == 2 then -- entry 9459450 -> 2
                        r4 = args[1]
                        r2 = args[2]
                        ReturnVal = "print"
                        state = _env[ReturnVal]
                        r1 = "A"
                        ReturnVal = state(r1)
                        state = r4 + r2
                        ReturnVal = {
                            state
                        }
                        state = nil
                    end
                end
            end
            state = #gcProxy
            return unpack(ReturnVal)
        end
        upvalueRefCounts = {}
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return 99794
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 99794
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
        upvalueValues = {}
        currentUpvalueId = 0
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if 0 == upvalueRefCounts[upvalueId] then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)