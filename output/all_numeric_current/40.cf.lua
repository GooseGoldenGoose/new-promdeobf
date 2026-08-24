--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = "print"

local r_v2_1 = _env[r_v1_1]

local r_v3_1 = "s40-start"

local r_v1_2 = r_v2_1(r_v3_1)

local r_v3_2 = 3

local r_v4_1 = r_v3_2

local r_v3_3 = 1

local r_v5_1 = r_v3_3

local r_v1_3 = 1

local r_v7_1 = args

for r_v8_5 = r_v1_3, r_v4_1, r_v5_1 do

    local r_v1_8 = 10

    local r_v2_3 = r_v8_5 * r_v1_8

    local r_v9_1 = r_v2_3

    local r_v1_9 = 2

    local r_v2_4 = r_v8_5 == r_v1_9

    if r_v2_4 then

        r_v9_1 = nil

    else

        local r_v1_12 = "print"

        local r_v2_6 = _env[r_v1_12]

        local r_v10_1 = "s40-do"

        local r_v1_13 = r_v2_6(r_v10_1, r_v8_5, r_v9_1)

        local r_v1_14 = "print"

        local r_v2_7 = _env[r_v1_14]

        r_v9_1 = nil

        local r_v9_2 = "s40-after"

        local r_v1_15 = r_v2_7(r_v9_2, r_v8_5)

    end

end

local r_v1_10 = "print"

local r_v2_5 = _env[r_v1_10]

local r_v3_6 = "s40-end"

local r_v1_11 = r_v2_5(r_v3_6)

return
