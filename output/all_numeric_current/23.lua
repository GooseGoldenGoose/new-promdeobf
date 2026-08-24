return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, createClosure2, releaseUpvalue, currentUpvalueId, releaseUpvalues, upvalueValues, createClosure1, vm, upvalueRefCounts, createClosure4, createUpvalueProxy, createClosure5, allocUpvalue, createClosure6, createClosure, createClosure3)
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
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return -2789372
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return -2789372
                    end
                })
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
        createClosure3 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1, arg2, arg3)
                return vm(entryId, {
                    arg1,
                    arg2,
                    arg3
                }, captures, gcProxy)
            end
            return closure
        end
        createClosure1 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1)
                return vm(entryId, {
                    arg1
                }, captures, gcProxy)
            end
            return closure
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
        allocUpvalue = function()
            currentUpvalueId = currentUpvalueId + (1)
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
        end
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, r9, ReturnVal, r10
            while state do
                if state <= 16 then
                    if state <= 9 then
                        if state <= 6 then
                            if state <= 4 then
                                if state <= 1 then
                                    -- root entry 9778580 -> 1, states 1-1
                                    if state == 1 then -- entry 9778580 -> 1
                                        ReturnVal = "print"
                                        state = _env[ReturnVal]
                                        r1 = "testing language/library basics"
                                        ReturnVal = state(r1)
                                        ReturnVal = "getfenv"
                                        state = _env[ReturnVal]
                                        ReturnVal = state()
                                        r1 = ReturnVal
                                        state = createClosure(2, {})
                                        r2 = allocUpvalue()
                                        ReturnVal = "concat"
                                        _env[ReturnVal] = state
                                        ReturnVal = createClosure6(5, {})
                                        upvalueValues[r2] = ReturnVal
                                        r8 = "assert"
                                        ReturnVal = _env[r8]
                                        r10 = upvalueValues[r2]
                                        r5 = 1
                                        r9 = r10(r5)
                                        r10 = nil
                                        r6 = r9 == r10
                                        r8 = ReturnVal(r6)
                                        r8 = "assert"
                                        ReturnVal = _env[r8]
                                        r10 = upvalueValues[r2]
                                        r4 = 2
                                        r5 = 1
                                        r9 = r10(r5, r4)
                                        r10 = 2
                                        r6 = r9 == r10
                                        r8 = ReturnVal(r6)
                                        r8 = "assert"
                                        ReturnVal = _env[r8]
                                        r10 = upvalueValues[r2]
                                        r7 = 3
                                        r4 = 2
                                        r5 = 1
                                        r9 = r10(r5, r4, r7)
                                        r10 = 2
                                        r6 = r9 == r10
                                        r8 = ReturnVal(r6)
                                        r10 = createClosure1(6, {
                                            r2
                                        })
                                        r8 = "assert"
                                        ReturnVal = _env[r8]
                                        r9 = r10()
                                        r10 = 1
                                        r6 = r9 == r10
                                        r8 = ReturnVal(r6)
                                        r10 = createClosure1(7, {
                                            r2
                                        })
                                        r8 = "assert"
                                        ReturnVal = _env[r8]
                                        r9 = r10()
                                        r10 = 1
                                        r6 = r9 == r10
                                        r8 = ReturnVal(r6)
                                        r8 = "assert"
                                        ReturnVal = _env[r8]
                                        r10 = createClosure4(8, {
                                            r2
                                        })
                                        r9 = r10()
                                        r10 = 1
                                        r6 = r9 == r10
                                        r8 = ReturnVal(r6)
                                        r8 = "assert"
                                        ReturnVal = _env[r8]
                                        r10 = createClosure3(9, {
                                            r2
                                        })
                                        r9 = r10()
                                        r10 = 1
                                        r6 = r9 == r10
                                        r8 = ReturnVal(r6)
                                        r8 = "print"
                                        ReturnVal = _env[r8]
                                        r6 = "o"
                                        r8 = ReturnVal(r6)
                                        r10 = createClosure3(10, {
                                            r2
                                        })
                                        r8 = "assert"
                                        ReturnVal = _env[r8]
                                        r9 = r10()
                                        r10 = 2
                                        r6 = r9 == r10
                                        r10 = createClosure2(11, {
                                            r2
                                        })
                                        r8 = ReturnVal(r6)
                                        r8 = "print"
                                        ReturnVal = _env[r8]
                                        r6 = "l"
                                        r8 = ReturnVal(r6)
                                        r8 = "assert"
                                        ReturnVal = _env[r8]
                                        r9 = r10()
                                        r10 = 2
                                        r6 = r9 == r10
                                        r8 = ReturnVal(r6)
                                        r8 = "print"
                                        ReturnVal = _env[r8]
                                        r6 = "d"
                                        r8 = ReturnVal(r6)
                                        r10 = createClosure2(12, {})
                                        r8 = "assert"
                                        ReturnVal = _env[r8]
                                        r9 = r10()
                                        r10 = 5
                                        r6 = r9 == r10
                                        r10 = createClosure2(13, {
                                            r2
                                        })
                                        r2 = releaseUpvalue(r2)
                                        r8 = ReturnVal(r6)
                                        r8 = "print"
                                        ReturnVal = _env[r8]
                                        r6 = "f"
                                        r8 = ReturnVal(r6)
                                        r8 = "assert"
                                        ReturnVal = _env[r8]
                                        r9 = r10()
                                        r10 = 5
                                        r6 = r9 == r10
                                        r8 = ReturnVal(r6)
                                        r3 = args
                                        r1 = nil
                                        ReturnVal = {}
                                        state = nil
                                    end
                                else
                                    -- createClosure entry 10740807 -> 2, states 2-4
                                    if state <= 3 then
                                        if state <= 2 then
                                            if state == 2 then -- entry 10740807 -> 2
                                                r1 = {
                                                    select(2, unpack(args))
                                                }
                                                r3 = args[1]
                                                r2 = "select"
                                                ReturnVal = _env[r2]
                                                r8 = "#"
                                                r2 = ReturnVal(r8, unpack(r1))
                                                ReturnVal = 0
                                                state = r2 == ReturnVal
                                                state = state and 3 or 4
                                            end
                                        else
                                            if state == 3 then
                                                ReturnVal = "tostring"
                                                state = _env[ReturnVal]
                                                ReturnVal = {
                                                    state(r3)
                                                }
                                                ReturnVal = {
                                                    unpack(ReturnVal)
                                                }
                                                state = nil
                                            end
                                        end
                                    else
                                        if state == 4 then
                                            r2 = "tostring"
                                            ReturnVal = _env[r2]
                                            r2 = ReturnVal(r3)
                                            r10 = "concat"
                                            r6 = _env[r10]
                                            r10 = r6(unpack(r1))
                                            r8 = ","
                                            ReturnVal = r8 .. r10
                                            state = r2 .. ReturnVal
                                            ReturnVal = {
                                                state
                                            }
                                            state = nil
                                        end
                                    end
                                end
                            else
                                if state <= 5 then
                                    -- createClosure6 entry 10998511 -> 5, states 5-5
                                    if state == 5 then -- entry 10998511 -> 5
                                        r1 = args[2]
                                        r3 = args[1]
                                        ReturnVal = {
                                            r1
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure1 entry 3857696 -> 6, states 6-6
                                    if state == 6 then -- entry 3857696 -> 6
                                        r3 = allocUpvalue()
                                        state = 1
                                        upvalueValues[r3] = state
                                        state = createClosure3(14, {
                                            r3
                                        })
                                        upvalueValues[upvalues[1]] = state
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r1 = {
                                            ReturnVal()
                                        }
                                        ReturnVal = {
                                            unpack(r1)
                                        }
                                        state = nil
                                    end
                                end
                            end
                        else
                            if state <= 8 then
                                if state <= 7 then
                                    -- createClosure1 entry 15380518 -> 7, states 7-7
                                    if state == 7 then -- entry 15380518 -> 7
                                        r3 = allocUpvalue()
                                        state = 1
                                        upvalueValues[r3] = state
                                        state = createClosure1(15, {
                                            r3
                                        })
                                        upvalueValues[upvalues[1]] = state
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r1 = ReturnVal()
                                        ReturnVal = {
                                            r1()
                                        }
                                        ReturnVal = {
                                            unpack(ReturnVal)
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure4 entry 5540621 -> 8, states 8-8
                                    if state == 8 then -- entry 5540621 -> 8
                                        state = createClosure6(16, {})
                                        upvalueValues[upvalues[1]] = state
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r1 = 1
                                        r3 = ReturnVal(r1)
                                        ReturnVal = {
                                            r3()
                                        }
                                        ReturnVal = {
                                            unpack(ReturnVal)
                                        }
                                        state = nil
                                    end
                                end
                            else
                                -- createClosure3 entry 2810134 -> 9, states 9-9
                                if state == 9 then -- entry 2810134 -> 9
                                    state = createClosure4(17, {})
                                    upvalueValues[upvalues[1]] = state
                                    ReturnVal = upvalueValues[upvalues[1]]
                                    r3 = ReturnVal()
                                    ReturnVal = {
                                        r3()
                                    }
                                    ReturnVal = {
                                        unpack(ReturnVal)
                                    }
                                    state = nil
                                end
                            end
                        end
                    else
                        if state <= 13 then
                            if state <= 11 then
                                if state <= 10 then
                                    -- createClosure3 entry 934360 -> 10, states 10-10
                                    if state == 10 then -- entry 934360 -> 10
                                        state = createClosure2(18, {})
                                        upvalueValues[upvalues[1]] = state
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r3 = ReturnVal()
                                        ReturnVal = {
                                            r3()
                                        }
                                        ReturnVal = {
                                            unpack(ReturnVal)
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure2 entry 2472985 -> 11, states 11-11
                                    if state == 11 then -- entry 2472985 -> 11
                                        state = createClosure1(19, {})
                                        upvalueValues[upvalues[1]] = state
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r3 = {
                                            ReturnVal()
                                        }
                                        ReturnVal = {
                                            unpack(r3)
                                        }
                                        state = nil
                                    end
                                end
                            else
                                if state <= 12 then
                                    -- createClosure2 entry 16138170 -> 12, states 12-12
                                    if state == 12 then -- entry 16138170 -> 12
                                        r3 = 5
                                        ReturnVal = "f"
                                        state = {
                                            [ReturnVal] = r3
                                        }
                                        r3 = state
                                        state = createClosure6(20, {})
                                        ReturnVal = "get"
                                        r3[ReturnVal] = state
                                        ReturnVal = "get"
                                        ReturnVal = r3[ReturnVal]
                                        state = {
                                            ReturnVal(r3)
                                        }
                                        ReturnVal = {
                                            unpack(state)
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure2 entry 4694466 -> 13, states 13-13
                                    if state == 13 then -- entry 4694466 -> 13
                                        state = createClosure2(21, {})
                                        upvalueValues[upvalues[1]] = state
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r3 = ReturnVal()
                                        ReturnVal = {
                                            r3()
                                        }
                                        ReturnVal = {
                                            unpack(ReturnVal)
                                        }
                                        state = nil
                                    end
                                end
                            end
                        else
                            if state <= 15 then
                                if state <= 14 then
                                    -- createClosure3 entry 1625654 -> 14, states 14-14
                                    if state == 14 then -- entry 1625654 -> 14
                                        state = upvalueValues[upvalues[1]]
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure1 entry 13053189 -> 15, states 15-15
                                    if state == 15 then -- entry 13053189 -> 15
                                        state = createClosure2(22, {
                                            upvalues[1]
                                        })
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                end
                            else
                                -- createClosure6 entry 9063562 -> 16, states 16-16
                                if state == 16 then -- entry 9063562 -> 16
                                    r3 = allocUpvalue()
                                    state = createClosure4(23, {
                                        r3
                                    })
                                    upvalueValues[r3] = args[1]
                                    ReturnVal = {
                                        state
                                    }
                                    state = nil
                                end
                            end
                        end
                    end
                else
                    if state <= 23 then
                        if state <= 20 then
                            if state <= 18 then
                                if state <= 17 then
                                    -- createClosure4 entry 6742620 -> 17, states 17-17
                                    if state == 17 then -- entry 6742620 -> 17
                                        state = nil
                                        r3 = state
                                        r1 = allocUpvalue()
                                        state = 1
                                        upvalueValues[r1] = state
                                        state = createClosure3(24, {
                                            r1
                                        })
                                        r1 = releaseUpvalue(r1)
                                        r3 = state
                                        ReturnVal = 2
                                        r1 = ReturnVal
                                        ReturnVal = {
                                            r3
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure2 entry 4132831 -> 18, states 18-18
                                    if state == 18 then -- entry 4132831 -> 18
                                        r3 = allocUpvalue()
                                        state = 1
                                        upvalueValues[r3] = state
                                        state = createClosure3(25, {
                                            r3
                                        })
                                        r1 = state
                                        state = 2
                                        upvalueValues[r3] = state
                                        ReturnVal = {
                                            r1
                                        }
                                        state = nil
                                    end
                                end
                            else
                                if state <= 19 then
                                    -- createClosure1 entry 16062002 -> 19, states 19-19
                                    if state == 19 then -- entry 16062002 -> 19
                                        state = 1
                                        r3 = allocUpvalue()
                                        upvalueValues[r3] = state
                                        state = createClosure1(26, {
                                            r3
                                        })
                                        ReturnVal = state()
                                        state = upvalueValues[r3]
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure6 entry 14192012 -> 20, states 20-20
                                    if state == 20 then -- entry 14192012 -> 20
                                        r3 = allocUpvalue()
                                        upvalueValues[r3] = args[1]
                                        state = createClosure5(27, {
                                            r3
                                        })
                                        ReturnVal = {
                                            state()
                                        }
                                        ReturnVal = {
                                            unpack(ReturnVal)
                                        }
                                        state = nil
                                    end
                                end
                            end
                        else
                            if state <= 22 then
                                if state <= 21 then
                                    -- createClosure2 entry 15830573 -> 21, states 21-21
                                    if state == 21 then -- entry 15830573 -> 21
                                        r3 = 5
                                        ReturnVal = "f"
                                        state = {
                                            [ReturnVal] = r3
                                        }
                                        r3 = state
                                        state = createClosure4(28, {})
                                        ReturnVal = "get"
                                        r3[ReturnVal] = state
                                        ReturnVal = "get"
                                        ReturnVal = r3[ReturnVal]
                                        state = {
                                            ReturnVal(r3)
                                        }
                                        ReturnVal = {
                                            unpack(state)
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure2 entry 14799313 -> 22, states 22-22
                                    if state == 22 then -- entry 14799313 -> 22
                                        state = upvalueValues[upvalues[1]]
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                end
                            else
                                -- createClosure4 entry 770559 -> 23, states 23-23
                                if state == 23 then -- entry 770559 -> 23
                                    state = upvalueValues[upvalues[1]]
                                    ReturnVal = {
                                        state
                                    }
                                    state = nil
                                end
                            end
                        end
                    else
                        if state <= 26 then
                            if state <= 25 then
                                if state <= 24 then
                                    -- createClosure3 entry 13470630 -> 24, states 24-24
                                    if state == 24 then -- entry 13470630 -> 24
                                        state = upvalueValues[upvalues[1]]
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure3 entry 1379026 -> 25, states 25-25
                                    if state == 25 then -- entry 1379026 -> 25
                                        state = upvalueValues[upvalues[1]]
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                end
                            else
                                -- createClosure1 entry 15208600 -> 26, states 26-26
                                if state == 26 then -- entry 15208600 -> 26
                                    state = 2
                                    upvalueValues[upvalues[1]] = state
                                    ReturnVal = {}
                                    state = nil
                                end
                            end
                        else
                            if state <= 28 then
                                if state <= 27 then
                                    -- createClosure5 entry 11829902 -> 27, states 27-27
                                    if state == 27 then -- entry 11829902 -> 27
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r3 = "f"
                                        state = ReturnVal[r3]
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure4 entry 6207511 -> 28, states 28-28
                                    if state == 28 then -- entry 6207511 -> 28
                                        r3 = allocUpvalue()
                                        state = createClosure1(29, {
                                            r3
                                        })
                                        upvalueValues[r3] = args[1]
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                end
                            else
                                -- createClosure1 entry 6227904 -> 29, states 29-29
                                if state == 29 then -- entry 6227904 -> 29
                                    ReturnVal = upvalueValues[upvalues[1]]
                                    r3 = "f"
                                    state = ReturnVal[r3]
                                    ReturnVal = {
                                        state
                                    }
                                    state = nil
                                end
                            end
                        end
                    end
                end
            end
            state = #gcProxy
            return unpack(ReturnVal)
        end
        createClosure2 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1, arg2)
                return vm(entryId, {
                    arg1,
                    arg2
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