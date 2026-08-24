--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = "pairs"

local r_v2_1 = _env[r_v1_1]

local r_v3_1 = 1

local r_v4_1 = 2

local r_v5_1 = 3

local r_v6_1 = {
                                r_v3_1,
                                r_v4_1,
                                r_v5_1
                            }

local r_v3_2 = {
                                r_v2_1(r_v6_1)
                            }

local r_v7_1 = r_v3_2[3]

local r_v1_2 = r_v3_2[1]

local r_v8_1 = r_v3_2[2]

local r_v9_1 = args

local r_v6_2 = r_v1_2

for r_v3_3, r4 in r_v6_2, r_v8_1, r_v7_1 do

    local r_v5_2 = "print"

    local r_v2_2 = _env[r_v5_2]

    local r_v5_3 = r_v2_2(r_v3_3, r4)

end

return
