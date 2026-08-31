--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = 3

local r_v2_1 = r_v1_1

local r_v3_1 = "print"

local r_v1_2 = _env[r_v3_1]

local r_v3_2 = r_v1_2(r_v2_1)

local r_v1_3 = 4

r_v2_1 = r_v1_3

local r_v4_1 = args

return r_v2_1
