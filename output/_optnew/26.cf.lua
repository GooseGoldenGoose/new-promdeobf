--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = "print"

local r_v2_1 = _env[r_v1_1]

local r_v3_1 = "start"

local r_v1_2 = r_v2_1(r_v3_1)

local r_v3_2 = 2

local r_v4_1 = r_v3_2

local r_v3_3 = 1

local r_v5_1 = r_v3_3

local r_v1_3 = 1

local r_v7_1 = args

for r_v8_4 = r_v1_3, r_v4_1, r_v5_1 do

    local r_v1_8 = "print"

    local r_v2_3 = _env[r_v1_8]

    local r_v9_1 = "before-loop"

    local r_v1_9 = r_v2_3(r_v9_1, r_v8_4)

end

local r_v3_5 = 3

local r_v4_2 = r_v3_5

local r_v3_6 = 1

local r_v5_2 = r_v3_6

local r_v1_10 = 1

for r_v8_8 = r_v1_10, r_v4_2, r_v5_2 do

    local r_v1_15 = "print"

    local r_v2_5 = _env[r_v1_15]

    local r_v9_2 = "outer"

    local r_v1_16 = r_v2_5(r_v9_2, r_v8_8)

    local r_v9_3 = 2

    local r_v10_1 = r_v9_3

    local r_v9_4 = 1

    local r_v11_1 = r_v9_4

    local r_v1_17 = 1

    for r_v13_4 = r_v1_17, r_v10_1, r_v11_1 do

        local r_v14_1 = r_v8_8 + r_v13_4

        local r_v15_1 = 2

        local r_v1_27 = r_v14_1 % r_v15_1

        local r_v14_2 = 0

        local r_v2_8 = r_v1_27 == r_v14_2

        if r_v2_8 then

            local r_v1_34 = "print"

            local r_v2_12 = _env[r_v1_34]

            local r_v14_3 = "inner-even"

            local r_v1_35 = r_v2_12(r_v14_3, r_v8_8, r_v13_4)

        else

            local r_v1_36 = "print"

            local r_v2_13 = _env[r_v1_36]

            local r_v14_4 = "inner-odd"

            local r_v1_37 = r_v2_13(r_v14_4, r_v8_8, r_v13_4)

        end

    end

    local r_v1_28 = "print"

    local r_v2_9 = _env[r_v1_28]

    local r_v9_6 = "outer-end"

    local r_v1_29 = r_v2_9(r_v9_6, r_v8_8)

end

local r_v3_8 = 1

local r_v4_3 = r_v3_8

local r_v3_9 = -1

local r_v5_3 = r_v3_9

local r_v1_18 = 3

for r_v8_12 = r_v1_18, r_v4_3, r_v5_3 do

    local r_v1_30 = "print"

    local r_v2_10 = _env[r_v1_30]

    local r_v9_7 = "after-loop"

    local r_v1_31 = r_v2_10(r_v9_7, r_v8_12)

end

local r_v1_32 = "print"

local r_v2_11 = _env[r_v1_32]

local r_v3_11 = "done"

local r_v1_33 = r_v2_11(r_v3_11)

return
