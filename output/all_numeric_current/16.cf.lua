--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = 213

local r_v2_1 = r_v1_1

local r_v3_1 = "math"

local r_v4_1 = _env[r_v3_1]

local r_v3_2 = "random"

local r_v5_1 = r_v4_1[r_v3_2]

local r_v6_1 = 2

local r_v3_3 = 1

local r_v4_2 = r_v5_1(r_v3_3, r_v6_1)

local r_v5_2 = 1

local r_v7_1 = r_v4_2 == r_v5_2

local r_v1_2 = not r_v7_1

local r_v8_1 = args

if r_v1_2 then

    local r_v1_3 = 1

    r_v2_1 = r_v1_3

    local r_v5_3 = "print"

    local r_v7_2 = _env[r_v5_3]

    local r_v4_3 = "C"

    local r_v5_4 = r_v7_2(r_v4_3)

else

    local r_v3_4 = "math"

    local r_v4_4 = _env[r_v3_4]

    local r_v3_5 = "random"

    local r_v5_5 = r_v4_4[r_v3_5]

    local r_v6_2 = 2

    local r_v3_6 = 1

    local r_v4_5 = r_v5_5(r_v3_6, r_v6_2)

    local r_v5_6 = 1

    local r_v7_3 = r_v4_5 == r_v5_6

    if r_v7_3 then

        local r_v7_4 = 2

        local r_v4_8 = "print"

        local r_v5_7 = _env[r_v4_8]

        local r_v3_10 = "G"

        local r_v4_9 = r_v5_7(r_v3_10)

        r_v2_1 = r_v7_4

    else

        local r_v5_8 = 3

        local r_v3_11 = "print"

        local r_v4_10 = _env[r_v3_11]

        local r_v6_5 = "E"

        local r_v3_12 = r_v4_10(r_v6_5)

        r_v2_1 = r_v5_8

    end

end

local r_v3_7 = "print"

local r_v4_6 = _env[r_v3_7]

local r_v3_8 = r_v4_6(r_v2_1)

local r_v9_1 = "math"

local r_v10_1 = _env[r_v9_1]

local r_v9_2 = "random"

local r_v6_3 = r_v10_1[r_v9_2]

local r_v11_1 = 2

local r_v9_3 = 1

local r_v10_2 = r_v6_3(r_v9_3, r_v11_1)

local r_v6_4 = 1

local r_v3_9 = r_v10_2 == r_v6_4

local r_v4_7 = not r_v3_9

if r_v4_7 then

    local r_v3_13 = "print"

    local r_v4_11 = _env[r_v3_13]

    local r_v6_6 = "W"

    local r_v3_14 = r_v4_11(r_v6_6)

else

    local r_v10_3 = "math"

    local r_v6_7 = _env[r_v10_3]

    local r_v10_4 = "random"

    local r_v3_15 = r_v6_7[r_v10_4]

    local r_v9_4 = 2

    local r_v10_5 = 1

    local r_v6_8 = r_v3_15(r_v10_5, r_v9_4)

    local r_v3_16 = 1

    local r_v4_12 = r_v6_8 == r_v3_16

    if r_v4_12 then

        local r_v3_19 = "print"

        local r_v4_14 = _env[r_v3_19]

        local r_v6_10 = "L"

        local r_v3_20 = r_v4_14(r_v6_10)

        return

    else

        local r_v3_21 = "print"

        local r_v4_15 = _env[r_v3_21]

        local r_v6_11 = "Z"

        local r_v3_22 = r_v4_15(r_v6_11)

    end

end

local r_v3_17 = "print"

local r_v4_13 = _env[r_v3_17]

local r_v6_9 = "done"

local r_v3_18 = r_v4_13(r_v6_9, r_v2_1)

r_v2_1 = nil

return
