--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = true

local r_v2_1 = r_v1_1

local r_v3_1 = false

local r_v4_1 = "ok"

local r_v1_2 = {
                                    r_v3_1,
                                    r_v4_1
                                }

r_v4_1 = r_v1_2

local r_v1_3 = "ok"

local r_v5_1 = r_v1_3

local r_v6_1 = 2

local r_v7_1 = r_v6_1

local r_v6_2 = 1

local r_v8_1 = r_v6_2

local r_v3_2 = 1

local r_v10_1 = args

for r_v11_5 = r_v3_2, r_v7_1, r_v8_1 do

    local r_v3_7 = r_v2_1

    if r_v2_1 then

        local r_v12_1 = 1

        local r_v13_1 = r_v4_1[r_v12_1]

        local r_v12_2 = false

        local r_v14_1 = r_v13_1 == r_v12_2

        local r_v16_1 = r_v14_1

        if r_v14_1 then

            local r_v12_3 = 2

            local r_v13_2 = r_v4_1[r_v12_3]

            local r_v14_2 = r_v13_2 == r_v5_1

            r_v16_1 = r_v14_2

        end

        r_v3_7 = r_v16_1

    end

    local r_v16_2 = "print"

    local r_v1_6 = _env[r_v16_2]

    local r_v15_2 = "i"

    local r_v16_3 = r_v1_6(r_v15_2, r_v11_5)

    r_v2_1 = r_v3_7

end

local r_v6_5 = "print"

local r_v1_5 = _env[r_v6_5]

local r_v7_2 = "chain"

local r_v6_6 = r_v1_5(r_v7_2, r_v2_1)

r_v5_1 = nil

r_v4_1 = nil

r_v2_1 = nil

return
