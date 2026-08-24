--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = "print"

local r_v2_1 = _env[r_v1_1]

local r_v3_1 = "start"

local r_v1_2 = r_v2_1(r_v3_1)

local r_v2_2 = 1

local r_v3_2 = r_v2_2

local r_v4_1 = args

while true do

    local r_v1_3 = 2

    local r_v2_3 = r_v3_2 <= r_v1_3

    if not (r_v2_3) then
        break
    end

    local r_v1_4 = "print"

    local r_v2_4 = _env[r_v1_4]

    local r_v5_1 = "while"

    local r_v1_5 = r_v2_4(r_v5_1, r_v3_2)

    local r_v1_6 = 10

    local r_v2_5 = r_v3_2 * r_v1_6

    local r_v5_2 = r_v2_5

    local r_v6_1 = 2

    local r_v1_7 = r_v3_2 % r_v6_1

    local r_v6_2 = 0

    local r_v2_6 = r_v1_7 == r_v6_2

    if r_v2_6 then

        local r_v1_9 = "print"

        local r_v2_7 = _env[r_v1_9]

        local r_v6_4 = "while-even"

        local r_v1_10 = r_v2_7(r_v6_4, r_v5_2)

    else

        local r_v1_11 = "print"

        local r_v2_8 = _env[r_v1_11]

        local r_v6_5 = "while-odd"

        local r_v1_12 = r_v2_8(r_v6_5, r_v5_2)

    end

    r_v5_2 = nil

    local r_v5_7 = 2

    local r_v6_6 = r_v5_7

    local r_v5_8 = 1

    local r_v7_2 = r_v5_8

    local r_v1_17 = 1

    for r_v9_11 = r_v1_17, r_v6_6, r_v7_2 do

        local r_v1_25 = "print"

        local r_v2_11 = _env[r_v1_25]

        local r_v10_5 = "for-in-while"

        local r_v1_26 = r_v2_11(r_v10_5, r_v3_2, r_v9_11)

        local r_v1_27 = 1

        local r_v2_12 = r_v9_11 == r_v1_27

        if r_v2_12 then

            local r_v2_14 = r_v3_2 + r_v9_11

            local r_v10_6 = r_v2_14

            local r_v1_31 = "print"

            local r_v2_15 = _env[r_v1_31]

            local r_v11_6 = "for-a"

            local r_v1_32 = r_v2_15(r_v11_6, r_v10_6)

            r_v10_6 = nil

        else

            local r_v2_16 = r_v3_2 * r_v9_11

            local r_v10_7 = r_v2_16

            local r_v1_33 = "print"

            local r_v2_17 = _env[r_v1_33]

            local r_v11_7 = "for-b"

            local r_v1_34 = r_v2_17(r_v11_7, r_v10_7)

            r_v10_7 = nil

        end

    end

    local r_v1_28 = 1

    local r_v2_13 = r_v3_2 + r_v1_28

    r_v3_2 = r_v2_13

end

local r_v5_3 = 2

local r_v6_3 = r_v5_3

local r_v5_4 = 1

local r_v7_1 = r_v5_4

local r_v1_8 = 1

for r_v9_5 = r_v1_8, r_v6_3, r_v7_1 do

    local r_v10_1 = "print"

    local r_v1_18 = _env[r_v10_1]

    local r_v11_1 = "outer-for"

    local r_v10_2 = r_v1_18(r_v11_1, r_v9_5)

    local r_v1_19 = 1

    local r_v10_3 = r_v1_19

    while true do

        local r_v11_2 = 2

        local r_v1_24 = r_v10_3 <= r_v11_2

        if not (r_v1_24) then
            break
        end

        local r_v11_3 = "print"

        local r_v1_29 = _env[r_v11_3]

        local r_v12_1 = "while-in-for"

        local r_v11_4 = r_v1_29(r_v12_1, r_v9_5, r_v10_3)

        local r_v12_2 = r_v9_5 + r_v10_3

        local r_v13_1 = 2

        local r_v11_5 = r_v12_2 % r_v13_1

        local r_v12_3 = 0

        local r_v1_30 = r_v11_5 == r_v12_3

        if r_v1_30 then

            local r_v11_8 = "print"

            local r_v1_35 = _env[r_v11_8]

            local r_v12_4 = "nested-even"

            local r_v11_9 = r_v1_35(r_v12_4, r_v9_5, r_v10_3)

        else

            local r_v11_10 = "print"

            local r_v1_36 = _env[r_v11_10]

            local r_v12_5 = "nested-odd"

            local r_v11_11 = r_v1_36(r_v12_5, r_v9_5, r_v10_3)

        end

        local r_v11_12 = 1

        local r_v1_37 = r_v10_3 + r_v11_12

        r_v10_3 = r_v1_37

    end

    r_v10_3 = nil

end

local r_v5_11 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v4_2 = args[1]
    
    local r_v2_18 = 1
    
    local r_v3_3 = r_v2_18
    
    while true do
    
        local r_v1_38 = 2
    
        local r_v2_19 = r_v3_3 <= r_v1_38
    
        if not (r_v2_19) then
            break
        end
    
        local r_v5_12 = 2
    
        local r_v6_9 = r_v5_12
    
        local r_v5_13 = 1
    
        local r_v7_7 = r_v5_13
    
        local r_v1_39 = 1
    
        for r_v9_16 = r_v1_39, r_v6_9, r_v7_7 do
    
            local r_v1_45 = 1
    
            local r_v2_21 = r_v9_16 == r_v1_45
    
            if r_v2_21 then
    
                local r_v1_47 = "print"
    
                local r_v2_23 = _env[r_v1_47]
    
                local r_v10_8 = "helper-a"
    
                local r_v1_48 = r_v2_23(r_v10_8, r_v4_2, r_v3_3, r_v9_16)
    
            else
    
                local r_v1_49 = "print"
    
                local r_v2_24 = _env[r_v1_49]
    
                local r_v10_9 = "helper-b"
    
                local r_v1_50 = r_v2_24(r_v10_9, r_v4_2, r_v3_3, r_v9_16)
    
            end
    
        end
    
        local r_v1_46 = 1
    
        local r_v2_22 = r_v3_3 + r_v1_46
    
        r_v3_3 = r_v2_22
    
    end
    
    local r_v5_16 = 10
    
    local r_v1_40 = r_v4_2 + r_v5_16
    
    return r_v1_40
end

local r_v7_3 = "print"

local r_v6_7 = _env[r_v7_3]

local r_v10_4 = 5

local r_v9_6 = {
                                            r_v5_11(r_v10_4)
                                        }

local r_v8_3 = "helper"

local r_v7_4 = r_v6_7(r_v8_3, unpack(r_v9_6))

local r_v7_5 = "print"

local r_v6_8 = _env[r_v7_5]

local r_v8_4 = "done"

local r_v7_6 = r_v6_8(r_v8_4)

r_v3_2 = nil

r_v5_11 = nil

return
