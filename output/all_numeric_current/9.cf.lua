--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = nil

local r_v2_1 = r_v1_1

local r_v3_1 = "print"

local r_v1_2 = _env[r_v3_1]

local r_v4_1 = "x0"

local r_v3_2 = r_v1_2(r_v4_1, r_v2_1)

local r_v1_3 = 5

r_v2_1 = r_v1_3

local r_v4_2 = "print"

local r_v3_3 = _env[r_v4_2]

local r_v5_1 = "x1"

local r_v4_3 = r_v3_3(r_v5_1, r_v2_1)

local r_v3_4 = nil

local r_v4_4 = r_v3_4

local r_v5_2 = "print"

local r_v3_5 = _env[r_v5_2]

local r_v6_1 = "y0"

local r_v5_3 = r_v3_5(r_v6_1, r_v4_4)

local r_v6_2 = "print"

local r_v5_4 = _env[r_v6_2]

local r_v3_6 = 6

r_v4_4 = r_v3_6

local r_v7_1 = "y1"

local r_v6_3 = r_v5_4(r_v7_1, r_v4_4)

local r_v8_1 = args

r_v2_1 = nil

r_v4_4 = nil

return
