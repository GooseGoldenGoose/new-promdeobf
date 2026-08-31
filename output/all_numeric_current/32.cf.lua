--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = "print"

local r_v2_1 = _env[r_v1_1]

local r_v3_1 = "continue-start"

local r_v1_2 = r_v2_1(r_v3_1)

local r_v2_2 = 0

local r_v3_2 = r_v2_2

local r_v4_1 = 5

local r_v5_1 = r_v4_1

local r_v4_2 = 1

local r_v6_1 = r_v4_2

local r_v1_3 = 1

local r_v8_1 = args

for r_v9_5 = r_v1_3, r_v5_1, r_v6_1 do

    local r_v10_1 = 2

    local r_v1_8 = r_v9_5 % r_v10_1

    local r_v10_2 = 0

    local r_v2_4 = r_v1_8 == r_v10_2

    if r_v2_4 then

        continue

    end

    local r_v2_6 = r_v3_2 + r_v9_5

    r_v3_2 = r_v2_6

    local r_v10_3 = "print"

    local r_v1_9 = _env[r_v10_3]

    local r_v11_1 = "continue-for"

    local r_v10_4 = r_v1_9(r_v11_1, r_v9_5, r_v3_2)

end

local r_v2_5 = 0

local r_v4_5 = r_v2_5

while true do

    local r_v1_10 = 5

    local r_v2_7 = r_v4_5 < r_v1_10

    if not (r_v2_7) then
        break
    end

    local r_v1_11 = 1

    local r_v2_8 = r_v4_5 + r_v1_11

    r_v4_5 = r_v2_8

    local r_v5_2 = 2

    local r_v1_12 = r_v4_5 == r_v5_2

    if r_v1_12 then

        continue

    end

    local r_v5_3 = "print"

    local r_v1_15 = _env[r_v5_3]

    local r_v6_3 = "continue-while"

    local r_v5_4 = r_v1_15(r_v6_3, r_v4_5)

end

local r_v1_13 = 0

r_v5_1 = r_v1_13

repeat

    local r_v6_4 = 1

    local r_v1_16 = r_v5_1 + r_v6_4

    r_v5_1 = r_v1_16

    local r_v7_2 = 2

    local r_v6_5 = r_v5_1 == r_v7_2

    if not (r_v6_5) then

        local r_v7_3 = "print"

        local r_v6_6 = _env[r_v7_3]

        local r_v9_6 = "continue-repeat"

        local r_v7_4 = r_v6_6(r_v9_6, r_v5_1)

    end

    local r_v7_5 = 4

    local r_v6_7 = r_v5_1 >= r_v7_5

until r_v6_7

local r_v7_6 = "print"

local r_v6_8 = _env[r_v7_6]

local r_v9_7 = "continue-end"

local r_v7_7 = r_v6_8(r_v9_7, r_v3_2, r_v4_5, r_v5_1)

r_v3_2 = nil

r_v4_5 = nil

r_v5_1 = nil

return
