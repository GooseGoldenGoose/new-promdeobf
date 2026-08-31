--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = "print"

local r_v2_1 = _env[r_v1_1]

local r_v3_1 = "testing language/library basics"

local r_v1_2 = r_v2_1(r_v3_1)

local r_v1_3 = "getfenv"

local r_v2_2 = _env[r_v1_3]

local r_v1_4 = r_v2_2()

local r_v3_2 = r_v1_4

local r_v2_3 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v3_4 = {
                                                        select(2, unpack(args))
                                                    }
    
    local r_v12_2 = args[1]
    
    local r_v4_3 = "select"
    
    local r_v1_22 = _env[r_v4_3]
    
    local r_v5_31 = "#"
    
    local r_v4_4 = r_v1_22(r_v5_31, unpack(r_v3_4))
    
    local r_v1_23 = 0
    
    local r_v2_4 = r_v4_4 == r_v1_23
    
    if r_v2_4 then
    
        local r_v1_24 = "tostring"
    
        local r_v2_5 = _env[r_v1_24]
    
        local r_v1_25 = {
                                                            r_v2_5(r_v12_2)
                                                        }
    
        return unpack(r_v1_25)
    
    end
    
    local r_v4_5 = "tostring"
    
    local r_v1_26 = _env[r_v4_5]
    
    local r_v4_6 = r_v1_26(r_v12_2)
    
    local r_v6_23 = "concat"
    
    local r_v9_16 = _env[r_v6_23]
    
    local r_v6_24 = r_v9_16(unpack(r_v3_4))
    
    local r_v5_32 = ","
    
    local r_v1_27 = r_v5_32 .. r_v6_24
    
    local r_v2_6 = r_v4_6 .. r_v1_27
    
    return r_v2_6
end

local r_v1_5 = "concat"

_env[r_v1_5] = r_v2_3

local r_v1_6 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v3_5 = args[2]
    
    local r_v12_3 = args[1]
    
    return r_v3_5
end

local r_v5_1 = "assert"

local r_v1_7 = _env[r_v5_1]

local r_v6_1 = r_v1_6

local r_v7_1 = 1

local r_v8_1 = r_v6_1(r_v7_1)

local r_v6_2 = nil

local r_v9_1 = r_v8_1 == r_v6_2

local r_v5_2 = r_v1_7(r_v9_1)

local r_v5_3 = "assert"

local r_v1_8 = _env[r_v5_3]

local r_v6_3 = r_v1_6

local r_v10_1 = 2

local r_v7_2 = 1

local r_v8_2 = r_v6_3(r_v7_2, r_v10_1)

local r_v6_4 = 2

local r_v9_2 = r_v8_2 == r_v6_4

local r_v5_4 = r_v1_8(r_v9_2)

local r_v5_5 = "assert"

local r_v1_9 = _env[r_v5_5]

local r_v6_5 = r_v1_6

local r_v11_1 = 3

local r_v10_2 = 2

local r_v7_3 = 1

local r_v8_3 = r_v6_5(r_v7_3, r_v10_2, r_v11_1)

local r_v6_6 = 2

local r_v9_3 = r_v8_3 == r_v6_6

local r_v5_6 = r_v1_9(r_v9_3)

local r_v6_7 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v2_7 = 1
    
    local r_v2_8 = function(...)
        --headers
    
        local args = { ... }
    
        --body
    
        local r_v2_19 = r_v2_7
        
        return r_v2_19
    end
    
    r_v1_6 = r_v2_8
    
    local r_v1_28 = r_v1_6
    
    local r_v3_6 = {
                                                r_v1_28()
                                            }
    
    return unpack(r_v3_6)
end

local r_v5_7 = "assert"

local r_v1_10 = _env[r_v5_7]

local r_v8_4 = r_v6_7()

local r_v6_8 = 1

local r_v9_4 = r_v8_4 == r_v6_8

local r_v5_8 = r_v1_10(r_v9_4)

local r_v6_9 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v2_9 = 1
    
    local r_v2_10 = function(...)
        --headers
    
        local args = { ... }
    
        --body
    
        local r_v2_20 = function(...)
            --headers
        
            local args = { ... }
        
            --body
        
            local r_v2_35 = r_v2_9
            
            return r_v2_35
        end
        
        return r_v2_20
    end
    
    r_v1_6 = r_v2_10
    
    local r_v1_29 = r_v1_6
    
    local r_v3_7 = r_v1_29()
    
    local r_v1_30 = {
                                                r_v3_7()
                                            }
    
    return unpack(r_v1_30)
end

local r_v5_9 = "assert"

local r_v1_11 = _env[r_v5_9]

local r_v8_5 = r_v6_9()

local r_v6_10 = 1

local r_v9_5 = r_v8_5 == r_v6_10

local r_v5_10 = r_v1_11(r_v9_5)

local r_v5_11 = "assert"

local r_v1_12 = _env[r_v5_11]

local r_v6_11 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v2_11 = function(...)
        --headers
    
        local args = { ... }
    
        --body
    
        local r_v12_13
        
        local r_v2_21 = function(...)
            --headers
        
            local args = { ... }
        
            --body
        
            local r_v2_36 = r_v12_13
            
            return r_v2_36
        end
        
        r_v12_13 = args[1]
        
        return r_v2_21
    end
    
    r_v1_6 = r_v2_11
    
    local r_v1_31 = r_v1_6
    
    local r_v3_8 = 1
    
    local r_v12_6 = r_v1_31(r_v3_8)
    
    local r_v1_32 = {
                                                r_v12_6()
                                            }
    
    return unpack(r_v1_32)
end

local r_v8_6 = r_v6_11()

local r_v6_12 = 1

local r_v9_6 = r_v8_6 == r_v6_12

local r_v5_12 = r_v1_12(r_v9_6)

local r_v5_13 = "assert"

local r_v1_13 = _env[r_v5_13]

local r_v6_13 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v2_12 = function(...)
        --headers
    
        local args = { ... }
    
        --body
    
        local r_v2_22 = nil
        
        local r_v12_14 = r_v2_22
        
        local r_v2_23 = 1
        
        local r_v2_24 = function(...)
            --headers
        
            local args = { ... }
        
            --body
        
            local r_v2_37 = r_v2_23
            
            return r_v2_37
        end
        
        r_v12_14 = r_v2_24
        
        local r_v1_44 = 2
        
        local r_v3_11 = r_v1_44
        
        return r_v12_14
    end
    
    r_v1_6 = r_v2_12
    
    local r_v1_33 = r_v1_6
    
    local r_v12_7 = r_v1_33()
    
    local r_v1_34 = {
                                            r_v12_7()
                                        }
    
    return unpack(r_v1_34)
end

local r_v8_7 = r_v6_13()

local r_v6_14 = 1

local r_v9_7 = r_v8_7 == r_v6_14

local r_v5_14 = r_v1_13(r_v9_7)

local r_v5_15 = "print"

local r_v1_14 = _env[r_v5_15]

local r_v9_8 = "o"

local r_v5_16 = r_v1_14(r_v9_8)

local r_v6_15 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v2_13 = function(...)
        --headers
    
        local args = { ... }
    
        --body
    
        local r_v2_25 = 1
        
        local r_v2_26 = function(...)
            --headers
        
            local args = { ... }
        
            --body
        
            local r_v2_38 = r_v2_25
            
            return r_v2_38
        end
        
        local r_v3_12 = r_v2_26
        
        local r_v2_27 = 2
        
        r_v2_25 = r_v2_27
        
        return r_v3_12
    end
    
    r_v1_6 = r_v2_13
    
    local r_v1_35 = r_v1_6
    
    local r_v12_8 = r_v1_35()
    
    local r_v1_36 = {
                                                r_v12_8()
                                            }
    
    return unpack(r_v1_36)
end

local r_v5_17 = "assert"

local r_v1_15 = _env[r_v5_17]

local r_v8_8 = r_v6_15()

local r_v6_16 = 2

local r_v9_9 = r_v8_8 == r_v6_16

local r_v6_17 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v2_14 = function(...)
        --headers
    
        local args = { ... }
    
        --body
    
        local r_v2_28 = 1
        
        local r_v2_29 = function(...)
            --headers
        
            local args = { ... }
        
            --body
        
            local r_v2_39 = 2
            
            r_v2_28 = r_v2_39
            
            return
        end
        
        local r_v1_45 = r_v2_29()
        
        local r_v2_30 = r_v2_28
        
        return r_v2_30
    end
    
    r_v1_6 = r_v2_14
    
    local r_v1_37 = r_v1_6
    
    local r_v12_9 = {
                                                r_v1_37()
                                            }
    
    return unpack(r_v12_9)
end

local r_v5_18 = r_v1_15(r_v9_9)

local r_v5_19 = "print"

local r_v1_16 = _env[r_v5_19]

local r_v9_10 = "l"

local r_v5_20 = r_v1_16(r_v9_10)

local r_v5_21 = "assert"

local r_v1_17 = _env[r_v5_21]

local r_v8_9 = r_v6_17()

local r_v6_18 = 2

local r_v9_11 = r_v8_9 == r_v6_18

local r_v5_22 = r_v1_17(r_v9_11)

local r_v5_23 = "print"

local r_v1_18 = _env[r_v5_23]

local r_v9_12 = "d"

local r_v5_24 = r_v1_18(r_v9_12)

local r_v6_19 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v12_10 = 5
    
    local r_v1_38 = "f"
    
    local r_v2_15 = {
                                                [r_v1_38] = r_v12_10
                                            }
    
    local r_v12_11 = r_v2_15
    
    local r_v2_16 = function(...)
        --headers
    
        local args = { ... }
    
        --body
    
        local r_v12_17 = args[1]
        
        local r_v2_31 = function(...)
            --headers
        
            local args = { ... }
        
            --body
        
            local r_v1_51 = r_v12_17
            
            local r_v12_20 = "f"
            
            local r_v2_40 = r_v1_51[r_v12_20]
            
            return r_v2_40
        end
        
        local r_v1_46 = {
                                                    r_v2_31()
                                                }
        
        return unpack(r_v1_46)
    end
    
    local r_v1_39 = "get"
    
    r_v12_11[r_v1_39] = r_v2_16
    
    local r_v1_40 = "get"
    
    local r_v1_41 = r_v12_11[r_v1_40]
    
    local r_v2_17 = {
                                                r_v1_41(r_v12_11)
                                            }
    
    return unpack(r_v2_17)
end

local r_v5_25 = "assert"

local r_v1_19 = _env[r_v5_25]

local r_v8_10 = r_v6_19()

local r_v6_20 = 5

local r_v9_13 = r_v8_10 == r_v6_20

local r_v6_21 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v2_18 = function(...)
        --headers
    
        local args = { ... }
    
        --body
    
        local r_v12_18 = 5
        
        local r_v1_47 = "f"
        
        local r_v2_32 = {
                                                    [r_v1_47] = r_v12_18
                                                }
        
        local r_v12_19 = r_v2_32
        
        local r_v2_33 = function(...)
            --headers
        
            local args = { ... }
        
            --body
        
            local r_v12_21
            
            local r_v2_41 = function(...)
                --headers
            
                local args = { ... }
            
                --body
            
                local r_v1_52 = r_v12_21
                
                local r_v12_22 = "f"
                
                local r_v2_42 = r_v1_52[r_v12_22]
                
                return r_v2_42
            end
            
            r_v12_21 = args[1]
            
            return r_v2_41
        end
        
        local r_v1_48 = "get"
        
        r_v12_19[r_v1_48] = r_v2_33
        
        local r_v1_49 = "get"
        
        local r_v1_50 = r_v12_19[r_v1_49]
        
        local r_v2_34 = {
                                                    r_v1_50(r_v12_19)
                                                }
        
        return unpack(r_v2_34)
    end
    
    r_v1_6 = r_v2_18
    
    local r_v1_42 = r_v1_6
    
    local r_v12_12 = r_v1_42()
    
    local r_v1_43 = {
                                                r_v12_12()
                                            }
    
    return unpack(r_v1_43)
end

local r_v5_26 = r_v1_19(r_v9_13)

local r_v5_27 = "print"

local r_v1_20 = _env[r_v5_27]

local r_v9_14 = "f"

local r_v5_28 = r_v1_20(r_v9_14)

local r_v5_29 = "assert"

local r_v1_21 = _env[r_v5_29]

local r_v8_11 = r_v6_21()

local r_v6_22 = 5

local r_v9_15 = r_v8_11 == r_v6_22

local r_v5_30 = r_v1_21(r_v9_15)

local r_v12_1 = args

local r_v3_3 = nil

return
