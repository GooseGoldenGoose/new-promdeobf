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

        local r_v4_9 = "print"

        local r_v5_9 = _env[r_v4_9]

        local r_v3_9 = "G"

        local r_v4_10 = r_v5_9(r_v3_9)

        r_v2_1 = r_v7_4

    end

end

local r_v4_6 = "print"

local r_v5_7 = _env[r_v4_6]

local r_v4_7 = r_v5_7(r_v2_1)

local r_v9_1 = "math"

local r_v6_3 = _env[r_v9_1]

local r_v9_2 = "random"

local r_v3_7 = r_v6_3[r_v9_2]

local r_v10_1 = 2

local r_v9_3 = 1

local r_v6_4 = r_v3_7(r_v9_3, r_v10_1)

local r_v3_8 = 1

local r_v4_8 = r_v6_4 == r_v3_8

local r_v5_8 = not r_v4_8

if r_v5_8 then

    local r_v4_11 = "print"

    local r_v5_10 = _env[r_v4_11]

    local r_v3_10 = "W"

    local r_v4_12 = r_v5_10(r_v3_10)

else

    local r_v6_5 = "math"

    local r_v3_11 = _env[r_v6_5]

    local r_v6_6 = "random"

    local r_v4_13 = r_v3_11[r_v6_6]

    local r_v9_4 = 2

    local r_v6_7 = 1

    local r_v3_12 = r_v4_13(r_v6_7, r_v9_4)

    local r_v4_14 = 1

    local r_v5_11 = r_v3_12 == r_v4_14

    if r_v5_11 then

        local r_v4_15 = "print"

        local r_v5_12 = _env[r_v4_15]

        local r_v3_13 = "L"

        local r_v4_16 = r_v5_12(r_v3_13)

        return

    end

end

r_v2_1 = nil

return
