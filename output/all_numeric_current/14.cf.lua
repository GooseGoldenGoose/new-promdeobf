--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = 1

local r_v2_1 = r_v1_1

local r_v3_1 = "print"

local r_v1_2 = _env[r_v3_1]

local r_v3_2 = r_v1_2(r_v2_1)

local r_v4_1 = "math"

local r_v5_1 = _env[r_v4_1]

local r_v4_2 = "random"

local r_v3_3 = r_v5_1[r_v4_2]

local r_v4_3 = 1

local r_v6_1 = 2

local r_v5_2 = r_v3_3(r_v4_3, r_v6_1)

local r_v3_4 = 1

local r_v1_3 = r_v5_2 == r_v3_4

local r_v7_1 = args

if r_v1_3 then

    local r_v1_4 = 2

    r_v2_1 = r_v1_4

end

local r_v6_2 = "math"

local r_v4_4 = _env[r_v6_2]

local r_v6_3 = "random"

local r_v5_3 = r_v4_4[r_v6_3]

local r_v8_1 = 3

local r_v6_4 = 2

local r_v4_5 = r_v5_3(r_v6_4, r_v8_1)

local r_v5_4 = 3

local r_v3_5 = r_v4_5 == r_v5_4

if r_v3_5 then

    local r_v5_5 = "print"

    local r_v3_6 = _env[r_v5_5]

    local r_v5_6 = r_v3_6(r_v2_1)

    return

end

local r_v3_7 = 3

r_v2_1 = r_v3_7

local r_v4_6 = "print"

local r_v5_7 = _env[r_v4_6]

local r_v4_7 = r_v5_7(r_v2_1)

r_v2_1 = nil

return
