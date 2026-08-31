--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = "print"

local r_v2_1 = _env[r_v1_1]

local r_v3_1 = "before"

local r_v1_2 = r_v2_1(r_v3_1)

local r_v2_2 = 5

local r_v3_2 = r_v2_2

local r_v1_3 = "print"

local r_v2_3 = _env[r_v1_3]

local r_v4_1 = "outer-do"

local r_v1_4 = r_v2_3(r_v4_1, r_v3_2)

r_v3_2 = nil

local r_v3_3 = 5

local r_v4_2 = r_v3_3

local r_v3_4 = 1

local r_v5_1 = r_v3_4

local r_v1_5 = 1

local r_v7_1 = args

for r_v8_4 = r_v1_5, r_v4_2, r_v5_1 do

    local r_v1_10 = "print"

    local r_v2_5 = _env[r_v1_10]

    local r_v9_1 = "loop"

    local r_v1_11 = r_v2_5(r_v9_1, r_v8_4)

    local r_v1_12 = 2

    local r_v2_6 = r_v8_4 * r_v1_12

    local r_v9_2 = r_v2_6

    local r_v1_13 = "print"

    local r_v2_7 = _env[r_v1_13]

    local r_v10_1 = "inner-do"

    local r_v1_14 = r_v2_7(r_v10_1, r_v9_2)

    r_v9_2 = nil

    local r_v9_3 = 2

    local r_v1_15 = r_v8_4 % r_v9_3

    local r_v9_4 = 0

    local r_v2_8 = r_v1_15 == r_v9_4

    if r_v2_8 then

        local r_v1_18 = "print"

        local r_v2_10 = _env[r_v1_18]

        local r_v9_5 = "even"

        local r_v1_19 = r_v2_10(r_v9_5, r_v8_4)

    else

        local r_v1_20 = "print"

        local r_v2_11 = _env[r_v1_20]

        local r_v9_6 = "odd"

        local r_v1_21 = r_v2_11(r_v9_6, r_v8_4)

    end

    local r_v1_22 = "print"

    local r_v2_12 = _env[r_v1_22]

    local r_v9_7 = "after-if"

    local r_v1_23 = r_v2_12(r_v9_7, r_v8_4)

end

local r_v1_16 = "print"

local r_v2_9 = _env[r_v1_16]

local r_v3_6 = "after"

local r_v1_17 = r_v2_9(r_v3_6)

return
