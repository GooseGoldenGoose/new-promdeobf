--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = "print"

local r_v2_1 = _env[r_v1_1]

local r_v3_1 = "mixed-repeat-start"

local r_v1_2 = r_v2_1(r_v3_1)

local r_v2_2 = 0

local r_v3_2 = r_v2_2

local r_v4_1 = args

repeat

    local r_v1_4 = 1

    local r_v2_4 = r_v3_2 + r_v1_4

    r_v3_2 = r_v2_4

    local r_v5_1 = "print"

    local r_v1_5 = _env[r_v5_1]

    local r_v6_1 = "outer-repeat"

    local r_v5_2 = r_v1_5(r_v6_1, r_v3_2)

    local r_v5_3 = 2

    local r_v6_2 = r_v5_3

    local r_v5_4 = 1

    local r_v7_1 = r_v5_4

    local r_v1_6 = 1

    for r_v9_5 = r_v1_6, r_v6_2, r_v7_1 do

        local r_v10_1 = 1

        local r_v1_11 = r_v9_5 == r_v10_1

        if r_v1_11 then

            local r_v10_2 = "print"

            local r_v1_13 = _env[r_v10_2]

            local r_v11_1 = "for-in-repeat-a"

            local r_v10_3 = r_v1_13(r_v11_1, r_v3_2, r_v9_5)

        else

            local r_v10_4 = "print"

            local r_v1_14 = _env[r_v10_4]

            local r_v11_2 = "for-in-repeat-b"

            local r_v10_5 = r_v1_14(r_v11_2, r_v3_2, r_v9_5)

        end

    end

    local r_v1_12 = 0

    local r_v5_7 = r_v1_12

    while true do

        local r_v6_3 = 2

        local r_v1_15 = r_v5_7 < r_v6_3

        if not (r_v1_15) then
            break
        end

        local r_v6_4 = 1

        local r_v1_16 = r_v5_7 + r_v6_4

        r_v5_7 = r_v1_16

        local r_v7_2 = "print"

        local r_v6_5 = _env[r_v7_2]

        local r_v8_2 = "while-in-repeat"

        local r_v7_3 = r_v6_5(r_v8_2, r_v3_2, r_v5_7)

    end

    r_v5_7 = nil

    local r_v6_6 = 2

    local r_v5_8 = r_v3_2 >= r_v6_6

until r_v5_8

local r_v6_7 = 2

local r_v7_4 = r_v6_7

local r_v6_8 = 1

local r_v8_3 = r_v6_8

local r_v5_9 = 1

for r_v5_14 = r_v5_9, r_v7_4, r_v8_3 do

    local r_v10_10 = 0

    repeat

        local r_v12_2 = 1

        local r_v11_4 = r_v10_10 + r_v12_2

        r_v10_10 = r_v11_4

        local r_v13_1 = "print"

        local r_v12_3 = _env[r_v13_1]

        local r_v14_1 = "repeat-in-for"

        local r_v13_2 = r_v12_3(r_v14_1, r_v5_14, r_v10_10)

        local r_v13_3 = 2

        local r_v12_4 = r_v10_10 >= r_v13_3

    until r_v12_4

    r_v10_10 = nil

end

local r_v5_15 = 0

while true do

    local r_v7_5 = 2

    local r_v6_11 = r_v5_15 < r_v7_5

    if not (r_v6_11) then
        break
    end

    local r_v7_6 = 1

    local r_v6_12 = r_v5_15 + r_v7_6

    local r_v7_7 = 0

    r_v5_15 = r_v6_12

    repeat

        local r_v9_10 = 1

        local r_v8_5 = r_v7_7 + r_v9_10

        r_v7_7 = r_v8_5

        local r_v10_12 = 1

        local r_v9_11 = r_v7_7 == r_v10_12

        if r_v9_11 then

            local r_v10_14 = "print"

            local r_v9_12 = _env[r_v10_14]

            local r_v12_8 = "repeat-in-while-a"

            local r_v10_15 = r_v9_12(r_v12_8, r_v5_15, r_v7_7)

        else

            local r_v10_16 = "print"

            local r_v9_13 = _env[r_v10_16]

            local r_v12_9 = "repeat-in-while-b"

            local r_v10_17 = r_v9_13(r_v12_9, r_v5_15, r_v7_7)

        end

        local r_v10_21 = 2

        local r_v9_14 = r_v7_7 >= r_v10_21

    until r_v9_14

    r_v7_7 = nil

end

local r_v7_8 = 0

local r_v9_8 = "_REPEAT_CHECKS"

_env[r_v9_8] = r_v7_8

local r_v9_9 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v4_2 = args[1]
    
    local r_v3_3 = "_REPEAT_CHECKS"
    
    local r_v1_17 = _env[r_v3_3]
    
    local r_v3_4 = 1
    
    local r_v2_7 = r_v1_17 + r_v3_4
    
    local r_v1_18 = "_REPEAT_CHECKS"
    
    _env[r_v1_18] = r_v2_7
    
    local r_v5_16 = "_REPEAT_CHECKS"
    
    local r_v3_5 = _env[r_v5_16]
    
    local r_v1_19 = r_v3_5 >= r_v4_2
    
    return r_v1_19
end

repeat

    local r_v12_6 = "print"

    local r_v10_13 = _env[r_v12_6]

    local r_v15_1 = "_REPEAT_CHECKS"

    local r_v14_2 = _env[r_v15_1]

    local r_v13_4 = "side-effect-repeat"

    local r_v12_7 = r_v10_13(r_v13_4, r_v14_2)

    local r_v12_10 = 2

    local r_v10_18 = r_v9_9(r_v12_10)

until r_v10_18

local r_v12_11 = "print"

local r_v10_19 = _env[r_v12_11]

local r_v15_2 = "_REPEAT_CHECKS"

local r_v14_3 = _env[r_v15_2]

local r_v13_5 = "side-effect-checks"

local r_v12_12 = r_v10_19(r_v13_5, r_v14_3)

local r_v13_6 = "print"

local r_v12_13 = _env[r_v13_6]

local r_v10_20 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v4_3 = args[1]
    
    local r_v2_8 = 0
    
    local r_v3_6 = r_v2_8
    
    repeat
    
        local r_v1_20 = 1
    
        local r_v2_10 = r_v3_6 + r_v1_20
    
        r_v3_6 = r_v2_10
    
        local r_v5_17 = 2
    
        local r_v6_13 = r_v5_17
    
        local r_v5_18 = 1
    
        local r_v7_9 = r_v5_18
    
        local r_v1_21 = 1
    
        for r_v9_19 = r_v1_21, r_v6_13, r_v7_9 do
    
            local r_v11_5 = r_v3_6 + r_v9_19
    
            local r_v12_15 = 2
    
            local r_v10_22 = r_v11_5 % r_v12_15
    
            local r_v11_6 = 0
    
            local r_v1_26 = r_v10_22 == r_v11_6
    
            if r_v1_26 then
    
                local r_v10_23 = "print"
    
                local r_v1_27 = _env[r_v10_23]
    
                local r_v11_7 = "helper-even"
    
                local r_v10_24 = r_v1_27(r_v11_7, r_v3_6, r_v9_19)
    
            else
    
                local r_v10_25 = "print"
    
                local r_v1_28 = _env[r_v10_25]
    
                local r_v11_8 = "helper-odd"
    
                local r_v10_26 = r_v1_28(r_v11_8, r_v3_6, r_v9_19)
    
            end
    
        end
    
        local r_v1_29 = r_v3_6 >= r_v4_3
    
    until r_v1_29
    
    return r_v3_6
end

local r_v16_1 = 2

local r_v15_3 = {
                                                    r_v10_20(r_v16_1)
                                                }

local r_v14_4 = "helper-result"

local r_v13_7 = r_v12_13(r_v14_4, unpack(r_v15_3))

local r_v13_8 = "print"

local r_v12_14 = _env[r_v13_8]

local r_v14_5 = "mixed-repeat-end"

local r_v13_9 = r_v12_14(r_v14_5)

r_v5_15 = nil

r_v3_2 = nil

r_v9_9 = nil

r_v10_20 = nil

return
