--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = "_G"

local r_v2_1 = _env[r_v1_1]

local r_v1_2 = "scw"

local r_v3_1 = 0

r_v2_1[r_v1_2] = r_v3_1

local r_v2_2 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v1_21 = "_G"
    
    local r_v2_15 = _env[r_v1_21]
    
    local r_v7_11 = "_G"
    
    local r_v5_13 = _env[r_v7_11]
    
    local r_v7_12 = "scw"
    
    local r_v3_12 = r_v5_13[r_v7_12]
    
    local r_v5_14 = 1
    
    local r_v4_2 = r_v3_12 + r_v5_14
    
    local r_v1_22 = "scw"
    
    r_v2_15[r_v1_22] = r_v4_2
    
    local r_v1_23 = "print"
    
    local r_v2_16 = _env[r_v1_23]
    
    local r_v7_13 = "_G"
    
    local r_v5_15 = _env[r_v7_13]
    
    local r_v7_14 = "scw"
    
    local r_v3_13 = r_v5_15[r_v7_14]
    
    local r_v4_3 = "A"
    
    local r_v1_24 = r_v2_16(r_v4_3, r_v3_13)
    
    local r_v3_14 = "_G"
    
    local r_v4_4 = _env[r_v3_14]
    
    local r_v3_15 = "scw"
    
    local r_v1_25 = r_v4_4[r_v3_15]
    
    local r_v4_5 = 4
    
    local r_v2_17 = r_v1_25 < r_v4_5
    
    return r_v2_17
end

local r_v1_3 = "scA"

_env[r_v1_3] = r_v2_2

local r_v2_3 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v1_26 = "print"
    
    local r_v2_18 = _env[r_v1_26]
    
    local r_v7_15 = "_G"
    
    local r_v5_16 = _env[r_v7_15]
    
    local r_v7_16 = "scw"
    
    local r_v3_16 = r_v5_16[r_v7_16]
    
    local r_v4_6 = "B"
    
    local r_v1_27 = r_v2_18(r_v4_6, r_v3_16)
    
    local r_v5_17 = "_G"
    
    local r_v3_17 = _env[r_v5_17]
    
    local r_v5_18 = "scw"
    
    local r_v4_7 = r_v3_17[r_v5_18]
    
    local r_v3_18 = 2
    
    local r_v1_28 = r_v4_7 % r_v3_18
    
    local r_v4_8 = 0
    
    local r_v2_19 = r_v1_28 == r_v4_8
    
    return r_v2_19
end

local r_v1_4 = "scB"

_env[r_v1_4] = r_v2_3

local r_v2_4 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v1_29 = "print"
    
    local r_v2_20 = _env[r_v1_29]
    
    local r_v7_17 = "_G"
    
    local r_v5_19 = _env[r_v7_17]
    
    local r_v7_18 = "scw"
    
    local r_v3_19 = r_v5_19[r_v7_18]
    
    local r_v4_9 = "C"
    
    local r_v1_30 = r_v2_20(r_v4_9, r_v3_19)
    
    local r_v2_21 = true
    
    return r_v2_21
end

local r_v1_5 = "scC"

_env[r_v1_5] = r_v2_4

local r_v4_1 = args

while true do

    local r_v5_1 = "scA"

    local r_v3_2 = _env[r_v5_1]

    local r_v5_2 = r_v3_2()

    local r_v1_6 = r_v5_2

    if r_v5_2 then

        local r_v6_1 = "scB"

        local r_v7_1 = _env[r_v6_1]

        local r_v6_2 = r_v7_1()

        local r_v3_3 = r_v6_2

        if not (r_v6_2) then

            local r_v6_3 = "scC"

            local r_v7_2 = _env[r_v6_3]

            local r_v6_4 = r_v7_2()

            r_v3_3 = r_v6_4

        end

        r_v1_6 = r_v3_3

    end

    if not (r_v1_6) then
        break
    end

    local r_v1_7 = "print"

    local r_v2_6 = _env[r_v1_7]

    local r_v6_5 = "_G"

    local r_v7_3 = _env[r_v6_5]

    local r_v6_6 = "scw"

    local r_v5_4 = r_v7_3[r_v6_6]

    local r_v3_4 = "short-while-body"

    local r_v1_8 = r_v2_6(r_v3_4, r_v5_4)

end

local r_v1_9 = "_G"

local r_v2_7 = _env[r_v1_9]

local r_v3_5 = 0

local r_v1_10 = "scr"

r_v2_7[r_v1_10] = r_v3_5

local r_v2_8 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v1_31 = "_G"
    
    local r_v2_22 = _env[r_v1_31]
    
    local r_v7_19 = "_G"
    
    local r_v5_20 = _env[r_v7_19]
    
    local r_v7_20 = "scr"
    
    local r_v3_20 = r_v5_20[r_v7_20]
    
    local r_v5_21 = 1
    
    local r_v4_10 = r_v3_20 + r_v5_21
    
    local r_v1_32 = "scr"
    
    r_v2_22[r_v1_32] = r_v4_10
    
    local r_v1_33 = "print"
    
    local r_v2_23 = _env[r_v1_33]
    
    local r_v7_21 = "_G"
    
    local r_v5_22 = _env[r_v7_21]
    
    local r_v7_22 = "scr"
    
    local r_v3_21 = r_v5_22[r_v7_22]
    
    local r_v4_11 = "RA"
    
    local r_v1_34 = r_v2_23(r_v4_11, r_v3_21)
    
    local r_v3_22 = "_G"
    
    local r_v4_12 = _env[r_v3_22]
    
    local r_v3_23 = "scr"
    
    local r_v1_35 = r_v4_12[r_v3_23]
    
    local r_v4_13 = 3
    
    local r_v2_24 = r_v1_35 >= r_v4_13
    
    return r_v2_24
end

local r_v1_11 = "srA"

_env[r_v1_11] = r_v2_8

local r_v2_9 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v1_36 = "print"
    
    local r_v2_25 = _env[r_v1_36]
    
    local r_v7_23 = "_G"
    
    local r_v5_23 = _env[r_v7_23]
    
    local r_v7_24 = "scr"
    
    local r_v3_24 = r_v5_23[r_v7_24]
    
    local r_v4_14 = "RB"
    
    local r_v1_37 = r_v2_25(r_v4_14, r_v3_24)
    
    local r_v5_24 = "_G"
    
    local r_v3_25 = _env[r_v5_24]
    
    local r_v5_25 = "scr"
    
    local r_v4_15 = r_v3_25[r_v5_25]
    
    local r_v3_26 = 2
    
    local r_v1_38 = r_v4_15 % r_v3_26
    
    local r_v4_16 = 1
    
    local r_v2_26 = r_v1_38 == r_v4_16
    
    return r_v2_26
end

local r_v1_12 = "srB"

_env[r_v1_12] = r_v2_9

local r_v2_10 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v1_39 = "print"
    
    local r_v2_27 = _env[r_v1_39]
    
    local r_v7_25 = "_G"
    
    local r_v5_26 = _env[r_v7_25]
    
    local r_v7_26 = "scr"
    
    local r_v3_27 = r_v5_26[r_v7_26]
    
    local r_v4_17 = "RC"
    
    local r_v1_40 = r_v2_27(r_v4_17, r_v3_27)
    
    local r_v2_28 = false
    
    return r_v2_28
end

local r_v1_13 = "srC"

_env[r_v1_13] = r_v2_10

local r_v5_5 = r_v2_10

local r_v6_7 = "srA"

local r_v7_4 = _env[r_v6_7]

local r_v6_8 = r_v7_4()

local r_v3_6 = r_v6_8

if r_v6_8 then

    local r_v6_9 = "srB"

    local r_v7_5 = _env[r_v6_9]

    local r_v6_10 = r_v7_5()

    r_v3_6 = r_v6_10

end

local r_v2_11 = r_v5_5

local r_v1_14 = r_v3_6

if not (r_v3_6) then

    local r_v5_6 = "srC"

    local r_v3_7 = _env[r_v5_6]

    local r_v5_7 = r_v3_7()

    local r_v1_15 = r_v5_7

end

repeat

    local r_v1_16 = "print"

    local r_v2_12 = _env[r_v1_16]

    local r_v6_11 = "_G"

    local r_v7_6 = _env[r_v6_11]

    local r_v6_12 = "scr"

    local r_v5_8 = r_v7_6[r_v6_12]

    local r_v3_8 = "short-repeat-body"

    local r_v1_17 = r_v2_12(r_v3_8, r_v5_8)

    local r_v6_13 = "srA"

    local r_v7_7 = _env[r_v6_13]

    local r_v6_14 = r_v7_7()

    local r_v3_9 = r_v6_14

    if r_v6_14 then

        local r_v6_15 = "srB"

        local r_v7_8 = _env[r_v6_15]

        local r_v6_16 = r_v7_8()

        r_v3_9 = r_v6_16

    end

    local r_v1_18 = r_v3_9

    if not (r_v3_9) then

        local r_v5_10 = "srC"

        local r_v3_10 = _env[r_v5_10]

        local r_v5_11 = r_v3_10()

        r_v1_18 = r_v5_11

    end

until r_v1_18

local r_v1_19 = "print"

local r_v2_14 = _env[r_v1_19]

local r_v6_17 = "_G"

local r_v7_9 = _env[r_v6_17]

local r_v6_18 = "scw"

local r_v5_12 = r_v7_9[r_v6_18]

local r_v8_1 = "_G"

local r_v6_19 = _env[r_v8_1]

local r_v8_2 = "scr"

local r_v7_10 = r_v6_19[r_v8_2]

local r_v3_11 = "short-end"

local r_v1_20 = r_v2_14(r_v3_11, r_v5_12, r_v7_10)

return
