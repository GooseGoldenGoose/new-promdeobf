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
    
    local r_v11_2 = args[1]
    
    local r_v4_2 = "select"
    
    local r_v1_20 = _env[r_v4_2]
    
    local r_v5_24 = "#"
    
    local r_v4_3 = r_v1_20(r_v5_24, unpack(r_v3_4))
    
    local r_v1_21 = 0
    
    local r_v2_4 = r_v4_3 == r_v1_21
    
    if r_v2_4 then
    
        local r_v1_22 = "tostring"
    
        local r_v2_5 = _env[r_v1_22]
    
        local r_v1_23 = {
                                                        r_v2_5(r_v11_2)
                                                    }
    
        return unpack(r_v1_23)
    
    end
    
    local r_v4_4 = "tostring"
    
    local r_v1_24 = _env[r_v4_4]
    
    local r_v4_5 = r_v1_24(r_v11_2)
    
    local r_v7_22 = "concat"
    
    local r_v8_15 = _env[r_v7_22]
    
    local r_v7_23 = r_v8_15(unpack(r_v3_4))
    
    local r_v5_25 = ","
    
    local r_v1_25 = r_v5_25 .. r_v7_23
    
    local r_v2_6 = r_v4_5 .. r_v1_25
    
    return r_v2_6
end

local r_v1_5 = "concat"

_env[r_v1_5] = r_v2_3

local r_v1_6 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v11_3 = args[1]
    
    local r_v3_5 = args[2]
    
    return r_v3_5
end

local r_v4_1 = r_v1_6

local r_v5_1 = "assert"

local r_v1_7 = _env[r_v5_1]

local r_v6_1 = 1

local r_v7_1 = r_v4_1(r_v6_1)

local r_v6_2 = nil

local r_v8_1 = r_v7_1 == r_v6_2

local r_v5_2 = r_v1_7(r_v8_1)

local r_v5_3 = "assert"

local r_v1_8 = _env[r_v5_3]

local r_v9_1 = 2

local r_v6_3 = 1

local r_v7_2 = r_v4_1(r_v6_3, r_v9_1)

local r_v6_4 = 2

local r_v8_2 = r_v7_2 == r_v6_4

local r_v5_4 = r_v1_8(r_v8_2)

local r_v5_5 = "assert"

local r_v1_9 = _env[r_v5_5]

local r_v9_2 = 2

local r_v10_1 = 3

local r_v6_5 = 1

local r_v7_3 = r_v4_1(r_v6_5, r_v9_2, r_v10_1)

local r_v6_6 = 2

local r_v8_3 = r_v7_3 == r_v6_6

local r_v5_6 = r_v1_9(r_v8_3)

local r_v7_4 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v2_7 = 1
    
    local r_v11_4 = r_v2_7
    
    if r_v11_4 then
    
        local r_v2_8 = 2
    
        r_v11_4 = r_v2_8
    
    end
    
    return r_v11_4
end

local r_v5_7 = "assert"

local r_v1_10 = _env[r_v5_7]

local r_v6_7 = r_v7_4()

local r_v7_5 = 2

local r_v8_4 = r_v6_7 == r_v7_5

local r_v5_8 = r_v1_10(r_v8_4)

local r_v7_6 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v2_9 = nil
    
    local r_v11_5 = r_v2_9
    
    if r_v11_5 then
    
        local r_v2_10 = 2
    
        r_v11_5 = r_v2_10
    
    end
    
    return r_v11_5
end

local r_v5_9 = "assert"

local r_v1_11 = _env[r_v5_9]

local r_v6_8 = r_v7_6()

local r_v7_7 = nil

local r_v8_5 = r_v6_8 == r_v7_7

local r_v5_10 = r_v1_11(r_v8_5)

local r_v7_8 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v2_11 = 0
    
    local r_v11_6 = r_v2_11
    
    if r_v11_6 then
    
        local r_v2_12 = 1
    
        r_v11_6 = r_v2_12
    
    else
    
        local r_v1_26 = 2
    
        r_v11_6 = r_v1_26
    
    end
    
    return r_v11_6
end

local r_v5_11 = "assert"

local r_v1_12 = _env[r_v5_11]

local r_v6_9 = r_v7_8()

local r_v7_9 = 1

local r_v8_6 = r_v6_9 == r_v7_9

local r_v5_12 = r_v1_12(r_v8_6)

local r_v7_10 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v2_13 = nil
    
    local r_v11_7 = r_v2_13
    
    if r_v11_7 then
    
        local r_v2_14 = 1
    
        r_v11_7 = r_v2_14
    
    else
    
        local r_v1_27 = 2
    
        r_v11_7 = r_v1_27
    
    end
    
    return r_v11_7
end

local r_v5_13 = "assert"

local r_v1_13 = _env[r_v5_13]

local r_v6_10 = r_v7_10()

local r_v7_11 = 2

local r_v8_7 = r_v6_10 == r_v7_11

local r_v7_12 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v2_15 = 1
    
    local r_v11_8 = r_v2_15
    
    local r_v1_28 = 2
    
    local r_v2_16 = r_v11_8 + r_v1_28
    
    r_v11_8 = r_v2_16
    
    return r_v11_8
end

local r_v5_14 = r_v1_13(r_v8_7)

local r_v5_15 = "assert"

local r_v1_14 = _env[r_v5_15]

local r_v6_11 = r_v7_12()

local r_v7_13 = 3

local r_v8_8 = r_v6_11 == r_v7_13

local r_v5_16 = r_v1_14(r_v8_8)

local r_v5_17 = "assert"

local r_v1_15 = _env[r_v5_17]

local r_v7_14 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v2_17 = 1
    
    local r_v11_9 = r_v2_17
    
    local r_v1_29 = 2
    
    local r_v2_18 = r_v11_9 - r_v1_29
    
    r_v11_9 = r_v2_18
    
    return r_v11_9
end

local r_v6_12 = r_v7_14()

local r_v7_15 = -1

local r_v8_9 = r_v6_12 == r_v7_15

local r_v5_18 = r_v1_15(r_v8_9)

local r_v7_16 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v2_19 = 1
    
    local r_v11_10 = r_v2_19
    
    local r_v1_30 = 2
    
    local r_v2_20 = r_v11_10 * r_v1_30
    
    r_v11_10 = r_v2_20
    
    return r_v11_10
end

local r_v5_19 = "assert"

local r_v1_16 = _env[r_v5_19]

local r_v6_13 = r_v7_16()

local r_v7_17 = 2

local r_v8_10 = r_v6_13 == r_v7_17

local r_v5_20 = r_v1_16(r_v8_10)

local r_v5_21 = "assert"

local r_v1_17 = _env[r_v5_21]

local r_v7_18 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v2_21 = 1
    
    local r_v11_11 = r_v2_21
    
    local r_v1_31 = 2
    
    local r_v2_22 = r_v11_11 / r_v1_31
    
    r_v11_11 = r_v2_22
    
    return r_v11_11
end

local r_v6_14 = r_v7_18()

local r_v7_19 = 0.5

local r_v8_11 = r_v6_14 == r_v7_19

local r_v10_2 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v1_32 = "print"
    
    local r_v2_23 = _env[r_v1_32]
    
    local r_v11_12 = "G"
    
    local r_v1_33 = r_v2_23(r_v11_12)
    
    return
end

local r_v5_22 = r_v1_17(r_v8_11)

local r_v9_3 = "tad"

local r_v7_20 = "kuy"

local r_v5_23 = "hee"

local r_v6_15 = 2

local r_v8_12 = 1

local r_v1_18 = {
                                        [r_v5_23] = r_v8_12,
                                        [r_v7_20] = r_v6_15,
                                        [r_v9_3] = r_v10_2
                                    }

r_v5_23 = r_v1_18

local r_v8_13 = "print"

local r_v1_19 = _env[r_v8_13]

local r_v7_21 = "PASS"

local r_v8_14 = r_v1_19(r_v7_21, r_v5_23)

local r_v11_1 = args

local r_v3_3 = nil

r_v4_1 = nil

r_v5_23 = nil

return
