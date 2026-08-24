--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = args

while true do

    local r_v2_1 = "math"

    local r_v3_1 = _env[r_v2_1]

    local r_v2_2 = "random"

    local r_v4_1 = r_v3_1[r_v2_2]

    local r_v2_3 = 1

    local r_v5_1 = 2

    local r_v3_2 = r_v4_1(r_v2_3, r_v5_1)

    local r_v4_2 = 1

    local r_v6_1 = r_v3_2 == r_v4_2

    if not (r_v6_1) then
        break
    end

    local r_v4_3 = "print"

    local r_v6_2 = _env[r_v4_3]

    local r_v3_3 = 27

    local r_v4_4 = r_v6_2(r_v3_3)

end

return
