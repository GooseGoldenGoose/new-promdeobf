--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = "ipairs"

local r_v2_1 = _env[r_v1_1]

local r_v3_1 = 3

local r_v4_1 = 4

local r_v5_1 = 1

local r_v6_1 = 2

local r_v7_1 = {
                                        r_v5_1,
                                        r_v6_1,
                                        r_v3_1,
                                        r_v4_1
                                    }

local r_v5_2 = {
                                        r_v2_1(r_v7_1)
                                    }

local r_v1_2 = r_v5_2[1]

local r_v8_1 = r_v5_2[3]

local r_v9_1 = r_v5_2[2]

local r_v7_2 = r_v1_2

local r_v10_1 = args

for r_v5_3, r2 in r_v7_2, r_v9_1, r_v8_1 do

    local r_v4_2 = 2

    local r_v3_2 = r_v5_3 % r_v4_2

    local r_v4_3 = 0

    local r_v2_2 = r_v3_2 == r_v4_3

    if r_v2_2 then

        local r_v3_3 = "print"

        local r_v2_4 = _env[r_v3_3]

        local r_v4_4 = "even"

        local r_v3_4 = r_v2_4(r_v4_4, r_v5_3, r2)

    else

        local r_v3_5 = "print"

        local r_v2_5 = _env[r_v3_5]

        local r_v4_5 = "odd"

        local r_v3_6 = r_v2_5(r_v4_5, r_v5_3, r2)

    end

    local r_v3_7 = 3

    local r_v2_6 = r_v5_3 == r_v3_7

    if r_v2_6 then

        break

    end

end

local r_v9_2 = "print"

local r_v2_3 = _env[r_v9_2]

local r_v8_2 = "after-break"

local r_v9_3 = r_v2_3(r_v8_2)

return
