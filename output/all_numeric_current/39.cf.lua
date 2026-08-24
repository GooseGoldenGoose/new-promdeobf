--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = "print"

local r_v2_1 = _env[r_v1_1]

local r_v3_1 = "s39-start"

local r_v1_2 = r_v2_1(r_v3_1)

local r_v3_2 = 4

local r_v4_1 = r_v3_2

local r_v3_3 = 1

local r_v5_1 = r_v3_3

local r_v1_3 = 1

local r_v7_1 = args

for r_v8_5 = r_v1_3, r_v4_1, r_v5_1 do

    local r_v1_8 = 2

    local r_v2_3 = r_v8_5 == r_v1_8

    if r_v2_3 then

        continue

    end

    local r_v1_11 = "print"

    local r_v2_5 = _env[r_v1_11]

    local r_v9_1 = "s39-for"

    local r_v1_12 = r_v2_5(r_v9_1, r_v8_5)

    local r_v2_6 = false

    local r_v1_13 = "print"

    local r_v2_7 = _env[r_v1_13]

    local r_v9_2 = "s39-repeat"

    local r_v1_14 = r_v2_7(r_v9_2, r_v8_5)

end

local r_v1_9 = "print"

local r_v2_4 = _env[r_v1_9]

local r_v3_6 = "s39-end"

local r_v1_10 = r_v2_4(r_v3_6)

return
