--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = "print"

local r_v2_1 = _env[r_v1_1]

local r_v3_1 = "s41-start"

local r_v1_2 = r_v2_1(r_v3_1)

local r_v2_2 = 0

local r_v3_2 = r_v2_2

local r_v4_1 = args

while true do

    local r_v1_3 = 5

    local r_v2_3 = r_v3_2 < r_v1_3

    if not (r_v2_3) then
        break
    end

    local r_v1_4 = 1

    local r_v2_4 = r_v3_2 + r_v1_4

    r_v3_2 = r_v2_4

    local r_v5_1 = 2

    local r_v6_1 = r_v3_2 % r_v5_1

    local r_v5_2 = 0

    local r_v1_5 = r_v6_1 == r_v5_2

    if r_v1_5 then

        continue

    end

    local r_v6_4 = "print"

    local r_v1_7 = _env[r_v6_4]

    local r_v5_4 = "s41-odd"

    local r_v6_5 = r_v1_7(r_v5_4, r_v3_2)

end

local r_v6_2 = "print"

local r_v1_6 = _env[r_v6_2]

local r_v5_3 = "s41-end"

local r_v6_3 = r_v1_6(r_v5_3, r_v3_2)

r_v3_2 = nil

return
