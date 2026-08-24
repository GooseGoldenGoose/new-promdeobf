--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = "ipairs"

local r_v2_1 = _env[r_v1_1]

local r_v3_1 = 2

local r_v4_1 = 4

local r_v5_1 = 1

local r_v6_1 = 3

local r_v7_1 = {
                                    r_v5_1,
                                    r_v3_1,
                                    r_v6_1,
                                    r_v4_1
                                }

local r_v5_2 = {
                                    r_v2_1(r_v7_1)
                                }

local r_v1_2 = r_v5_2[1]

local r_v8_1 = r_v5_2[2]

local r_v9_1 = r_v5_2[3]

local r_v10_1 = args

local r_v7_2 = r_v1_2

for r_v5_3, r8 in r_v7_2, r_v8_1, r_v9_1 do

    local r_v6_2 = 2

    local r_v2_2 = r_v5_3 == r_v6_2

    if r_v2_2 then

        continue

    end

    local r_v6_3 = "print"

    local r_v2_4 = _env[r_v6_3]

    local r_v4_2 = "keep"

    local r_v6_4 = r_v2_4(r_v4_2, r_v5_3, r8)

end

local r_v8_2 = "print"

local r_v2_3 = _env[r_v8_2]

local r_v9_2 = "after-continue"

local r_v8_3 = r_v2_3(r_v9_2)

return
