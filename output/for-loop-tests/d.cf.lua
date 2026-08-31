--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = 10

local r_v2_1 = r_v1_1

local r_v1_2 = 1

local r_v3_1 = r_v1_2

local r_v5_1 = 1

local r_v6_1 = args

for r_v7_4 = r_v5_1, r_v2_1, r_v3_1 do

    local r_v5_6 = "print"

    local r_v8_2 = _env[r_v5_6]

    local r_v9_1 = "a"

    local r_v5_7 = r_v8_2(r_v9_1, r_v7_4)

end

local r_v1_4 = 2

local r_v2_2 = r_v1_4

local r_v1_5 = 2

local r_v3_2 = r_v1_5

local r_v5_8 = 1

for r_v7_8 = r_v5_8, r_v2_2, r_v3_2 do

    local r_v5_13 = "print"

    local r_v8_4 = _env[r_v5_13]

    local r_v9_2 = "b"

    local r_v5_14 = r_v8_4(r_v9_2, r_v7_8)

end

local r_v1_7 = 1

local r_v2_3 = r_v1_7

local r_v1_8 = -1

local r_v3_3 = r_v1_8

local r_v5_15 = 3

for r_v7_12 = r_v5_15, r_v2_3, r_v3_3 do

    local r_v5_20 = "print"

    local r_v8_6 = _env[r_v5_20]

    local r_v9_3 = "c"

    local r_v5_21 = r_v8_6(r_v9_3, r_v7_12)

end

return
