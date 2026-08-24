--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = "print"

local r_v2_1 = _env[r_v1_1]

local r_v3_1 = "branch-heavy-start"

local r_v1_2 = r_v2_1(r_v3_1)

local r_v2_2 = 0

local r_v3_2 = r_v2_2

local r_v4_1 = args

while true do

    local r_v1_3 = 4

    local r_v2_3 = r_v3_2 < r_v1_3

    if not (r_v2_3) then
        break
    end

    local r_v1_4 = 1

    local r_v2_4 = r_v3_2 + r_v1_4

    r_v3_2 = r_v2_4

    local r_v5_1 = 2

    local r_v6_1 = r_v3_2 % r_v5_1

    local r_v5_2 = 0

    local r_v1_5 = r_v6_1 == r_v5_2

    if r_v1_5 then

        local r_v6_6 = 2

        local r_v1_7 = r_v3_2 == r_v6_6

        if r_v1_7 then

            local r_v6_8 = "print"

            local r_v1_13 = _env[r_v6_8]

            local r_v5_4 = "while-a"

            local r_v6_9 = r_v1_13(r_v5_4, r_v3_2)

        else

            local r_v6_10 = "print"

            local r_v1_14 = _env[r_v6_10]

            local r_v5_5 = "while-b"

            local r_v6_11 = r_v1_14(r_v5_5, r_v3_2)

        end

    else

        local r_v6_7 = 1

        local r_v1_8 = r_v3_2 == r_v6_7

        if r_v1_8 then

            local r_v6_12 = "print"

            local r_v1_15 = _env[r_v6_12]

            local r_v5_6 = "while-c"

            local r_v6_13 = r_v1_15(r_v5_6, r_v3_2)

        else

            local r_v6_14 = "print"

            local r_v1_16 = _env[r_v6_14]

            local r_v5_7 = "while-d"

            local r_v6_15 = r_v1_16(r_v5_7, r_v3_2)

        end

    end

    local r_v6_17 = "print"

    local r_v1_23 = _env[r_v6_17]

    local r_v5_11 = "while-tail"

    local r_v6_18 = r_v1_23(r_v5_11, r_v3_2)

end

local r_v6_2 = 4

local r_v5_3 = r_v6_2

local r_v6_3 = 1

local r_v7_1 = r_v6_3

local r_v1_6 = 1

for r_v9_5 = r_v1_6, r_v5_3, r_v7_1 do

    local r_v10_1 = 2

    local r_v1_17 = r_v9_5 <= r_v10_1

    if r_v1_17 then

        local r_v10_2 = 1

        local r_v1_20 = r_v9_5 == r_v10_2

        if r_v1_20 then

            local r_v10_4 = "print"

            local r_v1_24 = _env[r_v10_4]

            local r_v11_1 = "for-a"

            local r_v10_5 = r_v1_24(r_v11_1, r_v9_5)

        else

            local r_v10_6 = "print"

            local r_v1_25 = _env[r_v10_6]

            local r_v11_2 = "for-b"

            local r_v10_7 = r_v1_25(r_v11_2, r_v9_5)

        end

    else

        local r_v10_3 = 3

        local r_v1_21 = r_v9_5 == r_v10_3

        if r_v1_21 then

            local r_v10_8 = "print"

            local r_v1_26 = _env[r_v10_8]

            local r_v11_3 = "for-c"

            local r_v10_9 = r_v1_26(r_v11_3, r_v9_5)

        else

            local r_v10_10 = "print"

            local r_v1_27 = _env[r_v10_10]

            local r_v11_4 = "for-d"

            local r_v10_11 = r_v1_27(r_v11_4, r_v9_5)

        end

    end

    local r_v10_12 = "print"

    local r_v1_28 = _env[r_v10_12]

    local r_v11_5 = "for-tail"

    local r_v10_13 = r_v1_28(r_v11_5, r_v9_5)

end

local r_v1_18 = 0

local r_v6_16 = r_v1_18

repeat

    local r_v5_9 = 1

    local r_v1_22 = r_v6_16 + r_v5_9

    r_v6_16 = r_v1_22

    local r_v7_2 = 1

    local r_v5_10 = r_v6_16 == r_v7_2

    if r_v5_10 then

        local r_v7_3 = "print"

        local r_v5_12 = _env[r_v7_3]

        local r_v8_2 = "repeat-a"

        local r_v7_4 = r_v5_12(r_v8_2, r_v6_16)

    else

        local r_v7_5 = 2

        local r_v5_13 = r_v6_16 == r_v7_5

        if r_v5_13 then

            local r_v7_8 = "print"

            local r_v5_15 = _env[r_v7_8]

            local r_v8_4 = "repeat-b"

            local r_v7_9 = r_v5_15(r_v8_4, r_v6_16)

        else

            local r_v7_10 = "print"

            local r_v5_16 = _env[r_v7_10]

            local r_v8_5 = "repeat-c"

            local r_v7_11 = r_v5_16(r_v8_5, r_v6_16)

        end

    end

    local r_v7_6 = "print"

    local r_v5_14 = _env[r_v7_6]

    local r_v8_3 = "repeat-tail"

    local r_v7_7 = r_v5_14(r_v8_3, r_v6_16)

    local r_v7_12 = 3

    local r_v5_17 = r_v6_16 >= r_v7_12

until r_v5_17

local r_v7_13 = "print"

local r_v5_18 = _env[r_v7_13]

local r_v8_6 = "branch-heavy-end"

local r_v7_14 = r_v5_18(r_v8_6)

r_v3_2 = nil

r_v6_16 = nil

return
