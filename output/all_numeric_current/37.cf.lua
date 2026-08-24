--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = "print"

local r_v2_1 = _env[r_v1_1]

local r_v3_1 = "mutate-for-start"

local r_v1_2 = r_v2_1(r_v3_1)

local r_v3_2 = 3

local r_v4_1 = r_v3_2

local r_v3_3 = 1

local r_v5_1 = r_v3_3

local r_v1_3 = 1

local r_v7_1 = args

for r_v8_5 = r_v1_3, r_v4_1, r_v5_1 do

    local r_v1_8 = "print"

    local r_v2_3 = _env[r_v1_8]

    local r_v9_1 = "mutate-before"

    local r_v1_9 = r_v2_3(r_v9_1, r_v8_5)

    local r_v1_10 = 10

    local r_v2_4 = r_v8_5 + r_v1_10

    r_v8_5 = r_v2_4

    local r_v9_2 = "print"

    local r_v1_11 = _env[r_v9_2]

    local r_v10_1 = "mutate-after"

    local r_v9_3 = r_v1_11(r_v10_1, r_v8_5)

end

local r_v1_12 = "print"

local r_v2_5 = _env[r_v1_12]

local r_v3_6 = "mutate-for-end"

local r_v1_13 = r_v2_5(r_v3_6)

return
