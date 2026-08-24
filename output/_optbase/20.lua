return (function(...)
    
    return (function(_env, unpack, newproxy, setmetatable, getmetatable, select, InitialArgs, releaseUpvalues, upvalueRefCounts, createClosure5, releaseUpvalue, vm, createClosure0, currentUpvalueId, createUpvalueProxy, createClosure, createClosure3, createClosure1, upvalueValues, createClosure4, allocUpvalue, createClosure2)
        currentUpvalueId = 0
        createClosure1 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function(arg1)
                return vm(entryId, {
                    arg1
                }, captures, gcProxy)
            end
            return closure
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
        vm = function(state, args, upvalues, gcProxy)
            local r1, r2, r3, r4, r5, r6, r7, r8, ReturnVal, r9, r10
            while state do
                if state <= 30 then
                    if state <= 11 then
                        if state <= 7 then
                            if state <= 5 then
                                if state <= 4 then
                                    if state <= 1 then
                                        -- root entry 961164 -> 1, states 1-1
                                        if state == 1 then -- entry 961164 -> 1
                                            r2 = allocUpvalue()
                                            ReturnVal = "print"
                                            state = _env[ReturnVal]
                                            r10 = "testing language/library basics"
                                            ReturnVal = state(r10)
                                            ReturnVal = "getfenv"
                                            state = _env[ReturnVal]
                                            ReturnVal = state()
                                            r10 = ReturnVal
                                            state = createClosure(2, {})
                                            ReturnVal = "concat"
                                            _env[ReturnVal] = state
                                            ReturnVal = createClosure3(5, {})
                                            upvalueValues[r2] = ReturnVal
                                            r7 = "assert"
                                            ReturnVal = _env[r7]
                                            r6 = upvalueValues[r2]
                                            r9 = 1
                                            r8 = r6(r9)
                                            r6 = nil
                                            r3 = r8 == r6
                                            r7 = ReturnVal(r3)
                                            r7 = "assert"
                                            ReturnVal = _env[r7]
                                            r6 = upvalueValues[r2]
                                            r1 = 2
                                            r9 = 1
                                            r8 = r6(r9, r1)
                                            r6 = 2
                                            r3 = r8 == r6
                                            r7 = ReturnVal(r3)
                                            r7 = "assert"
                                            ReturnVal = _env[r7]
                                            r6 = upvalueValues[r2]
                                            r4 = 3
                                            r9 = 1
                                            r1 = 2
                                            r8 = r6(r9, r1, r4)
                                            r6 = 2
                                            r3 = r8 == r6
                                            r7 = ReturnVal(r3)
                                            r6 = createClosure4(6, {
                                                r2
                                            })
                                            r7 = "assert"
                                            ReturnVal = _env[r7]
                                            r8 = r6()
                                            r6 = 1
                                            r3 = r8 == r6
                                            r6 = createClosure3(7, {
                                                r2
                                            })
                                            r7 = ReturnVal(r3)
                                            r7 = "assert"
                                            ReturnVal = _env[r7]
                                            r8 = r6()
                                            r6 = 1
                                            r3 = r8 == r6
                                            r6 = createClosure2(8, {
                                                r2
                                            })
                                            r7 = ReturnVal(r3)
                                            r7 = "assert"
                                            ReturnVal = _env[r7]
                                            r8 = r6()
                                            r6 = 1
                                            r3 = r8 == r6
                                            r6 = createClosure0(9, {
                                                r2
                                            })
                                            r7 = ReturnVal(r3)
                                            r7 = "assert"
                                            ReturnVal = _env[r7]
                                            r8 = r6()
                                            r6 = 1
                                            r3 = r8 == r6
                                            r6 = createClosure5(10, {
                                                r2
                                            })
                                            r7 = ReturnVal(r3)
                                            r7 = "assert"
                                            ReturnVal = _env[r7]
                                            r8 = r6()
                                            r6 = 2
                                            r3 = r8 == r6
                                            r7 = ReturnVal(r3)
                                            r6 = createClosure0(11, {
                                                r2
                                            })
                                            r7 = "assert"
                                            ReturnVal = _env[r7]
                                            r8 = r6()
                                            r6 = 2
                                            r3 = r8 == r6
                                            r7 = ReturnVal(r3)
                                            r7 = "assert"
                                            ReturnVal = _env[r7]
                                            r6 = createClosure2(12, {})
                                            r8 = r6()
                                            r6 = 5
                                            r3 = r8 == r6
                                            r6 = createClosure4(13, {
                                                r2
                                            })
                                            r7 = ReturnVal(r3)
                                            r7 = "assert"
                                            ReturnVal = _env[r7]
                                            r8 = r6()
                                            r6 = 5
                                            r3 = r8 == r6
                                            r7 = ReturnVal(r3)
                                            r7 = "assert"
                                            ReturnVal = _env[r7]
                                            r6 = createClosure0(14, {})
                                            r8 = r6()
                                            r6 = 2
                                            r3 = r8 == r6
                                            r7 = ReturnVal(r3)
                                            r7 = "assert"
                                            ReturnVal = _env[r7]
                                            r6 = createClosure5(17, {})
                                            r8 = r6()
                                            r6 = nil
                                            r3 = r8 == r6
                                            r6 = createClosure4(20, {})
                                            r7 = ReturnVal(r3)
                                            r7 = "assert"
                                            ReturnVal = _env[r7]
                                            r8 = r6()
                                            r6 = 1
                                            r3 = r8 == r6
                                            r7 = ReturnVal(r3)
                                            r7 = "assert"
                                            ReturnVal = _env[r7]
                                            r6 = createClosure3(24, {})
                                            r8 = r6()
                                            r6 = 2
                                            r3 = r8 == r6
                                            r6 = createClosure4(28, {})
                                            r7 = ReturnVal(r3)
                                            r7 = "assert"
                                            ReturnVal = _env[r7]
                                            r8 = r6()
                                            r6 = 3
                                            r3 = r8 == r6
                                            r7 = ReturnVal(r3)
                                            r6 = createClosure4(29, {})
                                            r7 = "assert"
                                            ReturnVal = _env[r7]
                                            r8 = r6()
                                            r6 = -1
                                            r3 = r8 == r6
                                            r7 = ReturnVal(r3)
                                            r6 = createClosure0(30, {})
                                            r7 = "assert"
                                            ReturnVal = _env[r7]
                                            r8 = r6()
                                            r6 = 2
                                            r3 = r8 == r6
                                            r7 = ReturnVal(r3)
                                            r7 = "assert"
                                            ReturnVal = _env[r7]
                                            r2 = releaseUpvalue(r2)
                                            r6 = createClosure1(31, {})
                                            r8 = r6()
                                            r6 = 0.5
                                            r3 = r8 == r6
                                            r7 = ReturnVal(r3)
                                            r7 = "print"
                                            ReturnVal = _env[r7]
                                            r3 = "PASS"
                                            r7 = ReturnVal(r3)
                                            r5 = args
                                            r10 = nil
                                            ReturnVal = {}
                                            state = nil
                                        end
                                    else
                                        -- createClosure entry 5613579 -> 2, states 2-4
                                        if state <= 3 then
                                            if state <= 2 then
                                                if state == 2 then -- entry 5613579 -> 2
                                                    r10 = {
                                                        select(2, unpack(args))
                                                    }
                                                    r5 = args[1]
                                                    r2 = "select"
                                                    ReturnVal = _env[r2]
                                                    r7 = "#"
                                                    r2 = ReturnVal(r7, unpack(r10))
                                                    ReturnVal = 0
                                                    state = r2 == ReturnVal
                                                    state = state and 3 or 4
                                                end
                                            else
                                                if state == 3 then
                                                    ReturnVal = "tostring"
                                                    state = _env[ReturnVal]
                                                    ReturnVal = {
                                                        state(r5)
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
                                                r2 = ReturnVal(r5)
                                                r6 = "concat"
                                                r3 = _env[r6]
                                                r6 = r3(unpack(r10))
                                                r7 = ","
                                                ReturnVal = r7 .. r6
                                                state = r2 .. ReturnVal
                                                ReturnVal = {
                                                    state
                                                }
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    -- createClosure3 entry 12561932 -> 5, states 5-5
                                    if state == 5 then -- entry 12561932 -> 5
                                        r10 = args[2]
                                        r5 = args[1]
                                        ReturnVal = {
                                            r10
                                        }
                                        state = nil
                                    end
                                end
                            else
                                if state <= 6 then
                                    -- createClosure4 entry 8257778 -> 6, states 6-6
                                    if state == 6 then -- entry 8257778 -> 6
                                        r5 = allocUpvalue()
                                        state = 1
                                        upvalueValues[r5] = state
                                        state = createClosure5(32, {
                                            r5
                                        })
                                        upvalueValues[upvalues[1]] = state
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r10 = {
                                            ReturnVal()
                                        }
                                        ReturnVal = {
                                            unpack(r10)
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure3 entry 11387205 -> 7, states 7-7
                                    if state == 7 then -- entry 11387205 -> 7
                                        r5 = allocUpvalue()
                                        state = 1
                                        upvalueValues[r5] = state
                                        state = createClosure1(33, {
                                            r5
                                        })
                                        upvalueValues[upvalues[1]] = state
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r10 = ReturnVal()
                                        ReturnVal = {
                                            r10()
                                        }
                                        ReturnVal = {
                                            unpack(ReturnVal)
                                        }
                                        state = nil
                                    end
                                end
                            end
                        else
                            if state <= 9 then
                                if state <= 8 then
                                    -- createClosure2 entry 1821836 -> 8, states 8-8
                                    if state == 8 then -- entry 1821836 -> 8
                                        state = createClosure4(34, {})
                                        upvalueValues[upvalues[1]] = state
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r10 = 1
                                        r5 = ReturnVal(r10)
                                        ReturnVal = {
                                            r5()
                                        }
                                        ReturnVal = {
                                            unpack(ReturnVal)
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure0 entry 14964682 -> 9, states 9-9
                                    if state == 9 then -- entry 14964682 -> 9
                                        state = createClosure3(35, {})
                                        upvalueValues[upvalues[1]] = state
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r5 = ReturnVal()
                                        ReturnVal = {
                                            r5()
                                        }
                                        ReturnVal = {
                                            unpack(ReturnVal)
                                        }
                                        state = nil
                                    end
                                end
                            else
                                if state <= 10 then
                                    -- createClosure5 entry 12570033 -> 10, states 10-10
                                    if state == 10 then -- entry 12570033 -> 10
                                        state = createClosure2(36, {})
                                        upvalueValues[upvalues[1]] = state
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r5 = ReturnVal()
                                        ReturnVal = {
                                            r5()
                                        }
                                        ReturnVal = {
                                            unpack(ReturnVal)
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure0 entry 11045862 -> 11, states 11-11
                                    if state == 11 then -- entry 11045862 -> 11
                                        state = createClosure2(37, {})
                                        upvalueValues[upvalues[1]] = state
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r5 = {
                                            ReturnVal()
                                        }
                                        ReturnVal = {
                                            unpack(r5)
                                        }
                                        state = nil
                                    end
                                end
                            end
                        end
                    else
                        if state <= 23 then
                            if state <= 16 then
                                if state <= 13 then
                                    if state <= 12 then
                                        -- createClosure2 entry 9176550 -> 12, states 12-12
                                        if state == 12 then -- entry 9176550 -> 12
                                            ReturnVal = "f"
                                            r5 = 5
                                            state = {
                                                [ReturnVal] = r5
                                            }
                                            r5 = state
                                            state = createClosure2(38, {})
                                            ReturnVal = "get"
                                            r5[ReturnVal] = state
                                            ReturnVal = "get"
                                            ReturnVal = r5[ReturnVal]
                                            state = {
                                                ReturnVal(r5)
                                            }
                                            ReturnVal = {
                                                unpack(state)
                                            }
                                            state = nil
                                        end
                                    else
                                        -- createClosure4 entry 11247872 -> 13, states 13-13
                                        if state == 13 then -- entry 11247872 -> 13
                                            state = createClosure5(39, {})
                                            upvalueValues[upvalues[1]] = state
                                            ReturnVal = upvalueValues[upvalues[1]]
                                            r5 = ReturnVal()
                                            ReturnVal = {
                                                r5()
                                            }
                                            ReturnVal = {
                                                unpack(ReturnVal)
                                            }
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure0 entry 9297471 -> 14, states 14-16
                                    if state <= 15 then
                                        if state <= 14 then
                                            if state == 14 then -- entry 9297471 -> 14
                                                state = 1
                                                r5 = state
                                                state = r5 and 15 or 16
                                            end
                                        else
                                            if state == 15 then
                                                state = 2
                                                r5 = state
                                                state = 16
                                            end
                                        end
                                    else
                                        if state == 16 then
                                            ReturnVal = {
                                                r5
                                            }
                                            state = nil
                                        end
                                    end
                                end
                            else
                                if state <= 19 then
                                    -- createClosure5 entry 11745440 -> 17, states 17-19
                                    if state <= 18 then
                                        if state <= 17 then
                                            if state == 17 then -- entry 11745440 -> 17
                                                state = nil
                                                r5 = state
                                                state = r5 and 18 or 19
                                            end
                                        else
                                            if state == 18 then
                                                state = 2
                                                r5 = state
                                                state = 19
                                            end
                                        end
                                    else
                                        if state == 19 then
                                            ReturnVal = {
                                                r5
                                            }
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure4 entry 11977982 -> 20, states 20-23
                                    if state <= 21 then
                                        if state <= 20 then
                                            if state == 20 then -- entry 11977982 -> 20
                                                state = 0
                                                r5 = state
                                                state = r5 and 21 or 22
                                            end
                                        else
                                            if state == 21 then
                                                state = 1
                                                r5 = state
                                                state = 23
                                            end
                                        end
                                    else
                                        if state <= 22 then
                                            if state == 22 then
                                                ReturnVal = 2
                                                r5 = ReturnVal
                                                state = 23
                                            end
                                        else
                                            if state == 23 then
                                                ReturnVal = {
                                                    r5
                                                }
                                                state = nil
                                            end
                                        end
                                    end
                                end
                            end
                        else
                            if state <= 28 then
                                if state <= 27 then
                                    -- createClosure3 entry 10939078 -> 24, states 24-27
                                    if state <= 25 then
                                        if state <= 24 then
                                            if state == 24 then -- entry 10939078 -> 24
                                                state = nil
                                                r5 = state
                                                state = r5 and 25 or 26
                                            end
                                        else
                                            if state == 25 then
                                                state = 1
                                                r5 = state
                                                state = 27
                                            end
                                        end
                                    else
                                        if state <= 26 then
                                            if state == 26 then
                                                ReturnVal = 2
                                                r5 = ReturnVal
                                                state = 27
                                            end
                                        else
                                            if state == 27 then
                                                ReturnVal = {
                                                    r5
                                                }
                                                state = nil
                                            end
                                        end
                                    end
                                else
                                    -- createClosure4 entry 8517529 -> 28, states 28-28
                                    if state == 28 then -- entry 8517529 -> 28
                                        state = 1
                                        r5 = state
                                        ReturnVal = 2
                                        state = r5 + ReturnVal
                                        r5 = state
                                        ReturnVal = {
                                            r5
                                        }
                                        state = nil
                                    end
                                end
                            else
                                if state <= 29 then
                                    -- createClosure4 entry 445874 -> 29, states 29-29
                                    if state == 29 then -- entry 445874 -> 29
                                        state = 1
                                        r5 = state
                                        ReturnVal = 2
                                        state = r5 - ReturnVal
                                        r5 = state
                                        ReturnVal = {
                                            r5
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure0 entry 4050843 -> 30, states 30-30
                                    if state == 30 then -- entry 4050843 -> 30
                                        state = 1
                                        r5 = state
                                        ReturnVal = 2
                                        state = r5 * ReturnVal
                                        r5 = state
                                        ReturnVal = {
                                            r5
                                        }
                                        state = nil
                                    end
                                end
                            end
                        end
                    end
                else
                    if state <= 39 then
                        if state <= 35 then
                            if state <= 33 then
                                if state <= 32 then
                                    if state <= 31 then
                                        -- createClosure1 entry 1918424 -> 31, states 31-31
                                        if state == 31 then -- entry 1918424 -> 31
                                            state = 1
                                            r5 = state
                                            ReturnVal = 2
                                            state = r5 / ReturnVal
                                            r5 = state
                                            ReturnVal = {
                                                r5
                                            }
                                            state = nil
                                        end
                                    else
                                        -- createClosure5 entry 1156591 -> 32, states 32-32
                                        if state == 32 then -- entry 1156591 -> 32
                                            state = upvalueValues[upvalues[1]]
                                            ReturnVal = {
                                                state
                                            }
                                            state = nil
                                        end
                                    end
                                else
                                    -- createClosure1 entry 802594 -> 33, states 33-33
                                    if state == 33 then -- entry 802594 -> 33
                                        state = createClosure4(40, {
                                            upvalues[1]
                                        })
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                end
                            else
                                if state <= 34 then
                                    -- createClosure4 entry 9430556 -> 34, states 34-34
                                    if state == 34 then -- entry 9430556 -> 34
                                        r5 = allocUpvalue()
                                        upvalueValues[r5] = args[1]
                                        state = createClosure4(41, {
                                            r5
                                        })
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure3 entry 3676933 -> 35, states 35-35
                                    if state == 35 then -- entry 3676933 -> 35
                                        state = nil
                                        r5 = state
                                        state = 1
                                        r10 = allocUpvalue()
                                        upvalueValues[r10] = state
                                        state = createClosure0(42, {
                                            r10
                                        })
                                        r10 = releaseUpvalue(r10)
                                        r5 = state
                                        ReturnVal = 2
                                        r10 = ReturnVal
                                        ReturnVal = {
                                            r5
                                        }
                                        state = nil
                                    end
                                end
                            end
                        else
                            if state <= 37 then
                                if state <= 36 then
                                    -- createClosure2 entry 8879364 -> 36, states 36-36
                                    if state == 36 then -- entry 8879364 -> 36
                                        r5 = allocUpvalue()
                                        state = 1
                                        upvalueValues[r5] = state
                                        state = createClosure4(43, {
                                            r5
                                        })
                                        r10 = state
                                        state = 2
                                        upvalueValues[r5] = state
                                        ReturnVal = {
                                            r10
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure2 entry 16574874 -> 37, states 37-37
                                    if state == 37 then -- entry 16574874 -> 37
                                        r5 = allocUpvalue()
                                        state = 1
                                        upvalueValues[r5] = state
                                        state = createClosure2(44, {
                                            r5
                                        })
                                        ReturnVal = state()
                                        state = upvalueValues[r5]
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                end
                            else
                                if state <= 38 then
                                    -- createClosure2 entry 7126039 -> 38, states 38-38
                                    if state == 38 then -- entry 7126039 -> 38
                                        r5 = allocUpvalue()
                                        state = createClosure1(45, {
                                            r5
                                        })
                                        upvalueValues[r5] = args[1]
                                        ReturnVal = {
                                            state()
                                        }
                                        ReturnVal = {
                                            unpack(ReturnVal)
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure5 entry 5308 -> 39, states 39-39
                                    if state == 39 then -- entry 5308 -> 39
                                        ReturnVal = "f"
                                        r5 = 5
                                        state = {
                                            [ReturnVal] = r5
                                        }
                                        r5 = state
                                        state = createClosure1(46, {})
                                        ReturnVal = "get"
                                        r5[ReturnVal] = state
                                        ReturnVal = "get"
                                        ReturnVal = r5[ReturnVal]
                                        state = {
                                            ReturnVal(r5)
                                        }
                                        ReturnVal = {
                                            unpack(state)
                                        }
                                        state = nil
                                    end
                                end
                            end
                        end
                    else
                        if state <= 43 then
                            if state <= 41 then
                                if state <= 40 then
                                    -- createClosure4 entry 14557796 -> 40, states 40-40
                                    if state == 40 then -- entry 14557796 -> 40
                                        state = upvalueValues[upvalues[1]]
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure4 entry 11914599 -> 41, states 41-41
                                    if state == 41 then -- entry 11914599 -> 41
                                        state = upvalueValues[upvalues[1]]
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                end
                            else
                                if state <= 42 then
                                    -- createClosure0 entry 15820754 -> 42, states 42-42
                                    if state == 42 then -- entry 15820754 -> 42
                                        state = upvalueValues[upvalues[1]]
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure4 entry 9065177 -> 43, states 43-43
                                    if state == 43 then -- entry 9065177 -> 43
                                        state = upvalueValues[upvalues[1]]
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                end
                            end
                        else
                            if state <= 45 then
                                if state <= 44 then
                                    -- createClosure2 entry 15435267 -> 44, states 44-44
                                    if state == 44 then -- entry 15435267 -> 44
                                        state = 2
                                        upvalueValues[upvalues[1]] = state
                                        ReturnVal = {}
                                        state = nil
                                    end
                                else
                                    -- createClosure1 entry 8316264 -> 45, states 45-45
                                    if state == 45 then -- entry 8316264 -> 45
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r5 = "f"
                                        state = ReturnVal[r5]
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                end
                            else
                                if state <= 46 then
                                    -- createClosure1 entry 13039670 -> 46, states 46-46
                                    if state == 46 then -- entry 13039670 -> 46
                                        r5 = allocUpvalue()
                                        upvalueValues[r5] = args[1]
                                        state = createClosure4(47, {
                                            r5
                                        })
                                        ReturnVal = {
                                            state
                                        }
                                        state = nil
                                    end
                                else
                                    -- createClosure4 entry 7393309 -> 47, states 47-47
                                    if state == 47 then -- entry 7393309 -> 47
                                        ReturnVal = upvalueValues[upvalues[1]]
                                        r5 = "f"
                                        state = ReturnVal[r5]
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
            end
            state = #gcProxy
            return unpack(ReturnVal)
        end
        createClosure0 = function(entryId, captures)
            local gcProxy = createUpvalueProxy(captures)
            local closure = function()
                return vm(entryId, {}, captures, gcProxy)
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
        createUpvalueProxy = function(captures)
            for captureIndex = 1, #captures, 1 do
                upvalueRefCounts[captures[captureIndex]] = (1) + upvalueRefCounts[captures[captureIndex]]
            end
            if newproxy then
                local proxy = newproxy(true)
                local proxyMetatable = getmetatable(proxy)
                proxyMetatable["__index"], proxyMetatable["__gc"], proxyMetatable["__len"] = captures, releaseUpvalues, function()
                    return 2870044
                end
                return proxy
            else
                return setmetatable({}, {
                    ["__gc"] = releaseUpvalues,
                    ["__index"] = captures,
                    ["__len"] = function()
                        return 2870044
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
        allocUpvalue = function()
            currentUpvalueId = (1) + currentUpvalueId
            upvalueRefCounts[currentUpvalueId] = 1
            return currentUpvalueId
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
        upvalueRefCounts = {}
        releaseUpvalue = function(upvalueId)
            upvalueRefCounts[upvalueId] = upvalueRefCounts[upvalueId] - (1)
            if 0 == upvalueRefCounts[upvalueId] then
                upvalueRefCounts[upvalueId], upvalueValues[upvalueId] = nil, nil
            end
        end
        upvalueValues = {}
        return (createClosure(1, {}))(unpack(InitialArgs))
    end)(getfenv and getfenv() or _ENV, unpack or table["unpack"], newproxy, setmetatable, getmetatable, select, {
        ...
    })
end)(...)