return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, currentUpvalueId, releaseUpvalue, upvalueValues, vm, createUpvalueProxy, allocUpvalue, upvalueRefCounts, createClosure, releaseUpvalues)
        upvalueRefCounts = {}
        currentUpvalueId = 0
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        vm = function(state, args, upvalues, gcProxy)
            local r1, ReturnVal, r2, r3, r4, r5, r6, r7, r8, r9, r10
            while state do
                -- root entry 2936776 -> 1, states 1-1
                if state == 1 then -- entry 2936776 -> 1
                    state = 10
                    r8 = state
                    ReturnVal = 1
                    state = r8 + ReturnVal
                    r8 = state
                    r9 = "print"
                    ReturnVal = _env[r9]
                    r6 = "keep1"
                    r9 = ReturnVal(r6, r8)
                    ReturnVal = nil
                    r8 = ReturnVal
                    r7 = "print"
                    r6 = _env[r7]
                    ReturnVal = {}
                    r9 = 12
                    r8 = r9
                    r10 = "keep2"
                    r7 = r6(r10, r8)
                    r6 = 20
                    r10 = 2
                    r7 = r6 + r10
                    r6 = r7
                    r3 = "print"
                    r10 = _env[r3]
                    r1 = "inner"
                    r3 = r10(r1, r6)
                    r6 = nil
                    r6 = 30
                    r3 = 3
                    r10 = r6 + r3
                    r6 = r10
                    r1 = "print"
                    r3 = _env[r1]
                    r4 = "after"
                    r1 = r3(r4, r6)
                    r1 = 4
                    r3 = r8 + r1
                    r8 = r3
                    r4 = "print"
                    r1 = _env[r4]
                    r2 = "keep3"
                    r4 = r1(r2, r8)
                    r5 = args
                    r6 = nil
                    r8 = nil
                    state = nil
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
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return 253695
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 253695
                    end
                })
            end
        end
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if upvalueRefCounts[upvalueId] == 0 then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        upvalueValues = {}
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)