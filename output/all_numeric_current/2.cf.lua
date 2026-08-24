--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = "warn"

local r_v2_1 = _env[r_v1_1]

local r_v3_1 = "gg"

local r_v1_2 = r_v2_1(r_v3_1)

local r_v4_1 = "math"

local r_v3_2 = _env[r_v4_1]

local r_v4_2 = "random"

local r_v1_3 = r_v3_2[r_v4_2]

local r_v5_1 = 2

local r_v4_3 = 1

local r_v3_3 = r_v1_3(r_v4_3, r_v5_1)

local r_v1_4 = 1

local r_v2_2 = r_v3_3 == r_v1_4

local r_v6_1 = args

if r_v2_2 then

    local r_v1_5 = "print"

    local r_v2_3 = _env[r_v1_5]

    local r_v3_4 = "ranf"

    local r_v1_6 = r_v2_3(r_v3_4)

end

return
