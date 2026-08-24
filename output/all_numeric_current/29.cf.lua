--headers

local _env = getfenv()
local args = { ... }

--body

local r_v6_1 = args

repeat

    local r_v3_3 = "print"

    local r_v5_2 = _env[r_v3_3]

    local r_v2_3 = 12

    local r_v3_4 = r_v5_2(r_v2_3)

    local r_v1_4 = "math"

    local r_v2_4 = _env[r_v1_4]

    local r_v1_5 = "random"

    local r_v3_5 = r_v2_4[r_v1_5]

    local r_v4_2 = 2

    local r_v1_6 = 1

    local r_v2_5 = r_v3_5(r_v1_6, r_v4_2)

    local r_v3_6 = 1

    local r_v5_3 = r_v2_5 == r_v3_6

until r_v5_3

return
