--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = "print"

local r_v2_1 = _env[r_v1_1]

local r_v3_1 = "nested-control-start"

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

        local r_v1_10 = 4

        local r_v2_5 = r_v9_1 < r_v1_10

        if not (r_v2_5) then
            break
        end

        local r_v1_11 = 1

        local r_v2_6 = r_v9_1 + r_v1_11

        r_v9_1 = r_v2_6

        local r_v10_1 = 2

        local r_v1_12 = r_v9_1 == r_v10_1

        if r_v1_12 then

            continue

        end

        local r_v11_1 = 2

        local r_v12_1 = r_v8_5 == r_v11_1

        local r_v1_14 = r_v12_1

        if r_v12_1 then

            local r_v11_2 = 3

            local r_v12_2 = r_v9_1 == r_v11_2

            r_v1_14 = r_v12_2

        end

        if r_v1_14 then

            break

        end

        local r_v10_6 = "print"

        local r_v1_17 = _env[r_v10_6]

        local r_v12_4 = "nested-control"

        local r_v10_7 = r_v1_17(r_v12_4, r_v8_5, r_v9_1)

    end

    local r_v10_2 = 2

    local r_v1_13 = r_v8_5 == r_v10_2

    if r_v1_13 then

        r_v9_1 = nil

    else

        local r_v1_15 = false

        local r_v10_4 = "print"

        local r_v1_16 = _env[r_v10_4]

        local r_v12_3 = "nested-repeat"

        local r_v10_5 = r_v1_16(r_v12_3, r_v8_5)

        r_v9_1 = nil

    end

end

local r_v1_8 = "print"

local r_v2_4 = _env[r_v1_8]

local r_v3_6 = "nested-control-end"

local r_v1_9 = r_v2_4(r_v3_6)

return
