--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = "print"

local r_v2_1 = _env[r_v1_1]

local r_v3_1 = "break-start"

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

    local r_v5_1 = "print"

    local r_v1_5 = _env[r_v5_1]

    local r_v6_1 = "break-while"

    local r_v5_2 = r_v1_5(r_v6_1, r_v3_2)

    local r_v5_3 = 3

    local r_v1_6 = r_v3_2 == r_v5_3

    if r_v1_6 then

        break

    end

end

local r_v5_4 = 5

local r_v6_2 = r_v5_4

local r_v5_5 = 1

local r_v7_1 = r_v5_5

local r_v1_7 = 1

for r_v9_5 = r_v1_7, r_v6_2, r_v7_1 do

    local r_v10_1 = "print"

    local r_v1_12 = _env[r_v10_1]

    local r_v11_1 = "break-for"

    local r_v10_2 = r_v1_12(r_v11_1, r_v9_5)

    local r_v10_3 = 2

    local r_v1_13 = r_v9_5 == r_v10_3

    if r_v1_13 then

        break

    end

end

local r_v1_14 = 0

local r_v5_8 = r_v1_14

repeat

    local r_v6_4 = 1

    local r_v1_16 = r_v5_8 + r_v6_4

    r_v5_8 = r_v1_16

    local r_v7_2 = "print"

    local r_v6_5 = _env[r_v7_2]

    local r_v8_2 = "break-repeat"

    local r_v7_3 = r_v6_5(r_v8_2, r_v5_8)

    local r_v7_4 = 2

    local r_v6_6 = r_v5_8 == r_v7_4

    if r_v6_6 then

        break

    end

    local r_v7_7 = 5

    local r_v6_8 = r_v5_8 >= r_v7_7

until r_v6_8

local r_v7_5 = "print"

local r_v6_7 = _env[r_v7_5]

local r_v8_3 = "break-end"

local r_v7_6 = r_v6_7(r_v8_3, r_v3_2, r_v5_8)

r_v5_8 = nil

r_v3_2 = nil

return
