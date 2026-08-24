--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = "print"

local r_v2_1 = _env[r_v1_1]

local r_v3_1 = "s43-start"

local r_v1_2 = r_v2_1(r_v3_1)

local r_v3_2 = 3

local r_v4_1 = r_v3_2

local r_v3_3 = 1

local r_v5_1 = r_v3_3

local r_v1_3 = 1

local r_v7_1 = args

for r_v8_5 = r_v1_3, r_v4_1, r_v5_1 do

    local r_v2_3 = 0

    local r_v9_1 = r_v2_3

    while true do

        local r_v2_5 = true

        if not (r_v2_5) then
            break
        end

        local r_v1_10 = 1

        local r_v2_6 = r_v9_1 + r_v1_10

        r_v9_1 = r_v2_6

        local r_v10_1 = 2

        local r_v1_11 = r_v9_1 == r_v10_1

        if r_v1_11 then

            break

        end

        local r_v10_3 = "print"

        local r_v1_13 = _env[r_v10_3]

        local r_v11_1 = "s43-inner"

        local r_v10_4 = r_v1_13(r_v11_1, r_v8_5, r_v9_1)

    end

    local r_v10_2 = 2

    local r_v1_12 = r_v8_5 == r_v10_2

    if r_v1_12 then

        r_v9_1 = nil

    else

        local r_v10_5 = "print"

        local r_v1_14 = _env[r_v10_5]

        local r_v11_2 = "s43-outer"

        local r_v10_6 = r_v1_14(r_v11_2, r_v8_5, r_v9_1)

        r_v9_1 = nil

    end

end

local r_v1_8 = "print"

local r_v2_4 = _env[r_v1_8]

local r_v3_6 = "s43-end"

local r_v1_9 = r_v2_4(r_v3_6)

return
