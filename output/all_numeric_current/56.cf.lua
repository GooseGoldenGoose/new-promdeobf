--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = 8

local r_v2_1 = 9

local r_v3_1 = 7

local r_v4_1 = {
                                r_v3_1,
                                r_v1_1,
                                r_v2_1
                            }

r_v1_1 = r_v4_1

local r_v3_2 = "pairs"

local r_v4_2 = _env[r_v3_2]

local r_v5_1 = {
                                r_v4_2(r_v1_1)
                            }

local r_v2_2 = r_v5_1[2]

local r_v6_1 = r_v5_1[3]

local r_v3_3 = r_v5_1[1]

local r_v7_1 = args

local r_v5_2 = r_v3_3

for r_v9_1, r5 in r_v5_2, r_v2_2, r_v6_1 do

    local r_v8_1 = "print"

    local r_v4_3 = _env[r_v8_1]

    local r_v10_1 = "pairs"

    local r_v8_2 = r_v4_3(r_v10_1, r_v9_1, r5)

end

r_v1_1 = nil

return
