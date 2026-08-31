--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = 10

local r_v2_1 = r_v1_1

local r_v3_1 = 1

local r_v1_2 = r_v2_1 + r_v3_1

r_v2_1 = r_v1_2

local r_v4_1 = "print"

local r_v3_2 = _env[r_v4_1]

local r_v5_1 = "keep1"

local r_v4_2 = r_v3_2(r_v5_1, r_v2_1)

local r_v3_3 = nil

r_v2_1 = r_v3_3

local r_v6_1 = "print"

local r_v5_2 = _env[r_v6_1]

local r_v4_3 = 12

r_v2_1 = r_v4_3

local r_v7_1 = "keep2"

local r_v6_2 = r_v5_2(r_v7_1, r_v2_1)

local r_v5_3 = 20

local r_v7_2 = 2

local r_v6_3 = r_v5_3 + r_v7_2

r_v5_3 = r_v6_3

local r_v8_1 = "print"

local r_v7_3 = _env[r_v8_1]

local r_v9_1 = "inner"

local r_v8_2 = r_v7_3(r_v9_1, r_v5_3)

r_v5_3 = nil

local r_v5_4 = 30

local r_v8_3 = 3

local r_v7_4 = r_v5_4 + r_v8_3

r_v5_4 = r_v7_4

local r_v9_2 = "print"

local r_v8_4 = _env[r_v9_2]

local r_v10_1 = "after"

local r_v9_3 = r_v8_4(r_v10_1, r_v5_4)

local r_v9_4 = 4

local r_v8_5 = r_v2_1 + r_v9_4

r_v2_1 = r_v8_5

local r_v10_2 = "print"

local r_v9_5 = _env[r_v10_2]

local r_v11_1 = "keep3"

local r_v10_3 = r_v9_5(r_v11_1, r_v2_1)

local r_v12_1 = args

r_v5_4 = nil

r_v2_1 = nil

return
