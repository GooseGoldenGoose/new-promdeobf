--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = true

local r_v2_1 = "valid"

_env[r_v2_1] = r_v1_1

local r_v4_1 = args

repeat

    local r_v3_2 = "valid"

    local r_v2_3 = _env[r_v3_2]

until r_v2_3

local r_v3_3 = "print"

local r_v2_4 = _env[r_v3_3]

local r_v5_1 = "valid"

local r_v6_1 = _env[r_v5_1]

local r_v7_1 = "empty-repeat"

local r_v3_4 = r_v2_4(r_v7_1, r_v6_1)

return
