--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = "math"

local r_v2_1 = _env[r_v1_1]

local r_v1_2 = "floor"

local r_v3_1 = r_v2_1[r_v1_2]

local r_v4_1 = "math"

local r_v2_2 = _env[r_v4_1]

local r_v4_2 = "random"

local r_v3_2 = r_v2_2[r_v4_2]

r_v4_2 = r_v3_2

local r_v7_1 = "table"

local r_v2_3 = _env[r_v7_1]

local r_v7_2 = "remove"

local r_v3_3 = r_v2_3[r_v7_2]

r_v7_2 = r_v3_3

local r_v9_1 = "string"

local r_v2_4 = _env[r_v9_1]

local r_v9_2 = "char"

local r_v3_4 = r_v2_4[r_v9_2]

r_v9_2 = r_v3_4

local r_v10_1 = 256

local r_v3_5 = 0

local r_v3_6 = 2

local r_v3_7 = {}

local r_v11_1 = r_v3_7

local r_v3_8 = {}

local r_v12_1 = r_v10_1

local r_v10_2 = 1

local r_v13_1 = r_v10_2

local r_v3_9 = 0

local r_v2_5 = 1

local r_v15_1 = r_v3_9

local r_v3_10 = {}

local r_v16_1 = r_v3_10

local r_v17_1 = args

for r_v18_5 = r_v2_5, r_v12_1, r_v13_1 do

    local r_v3_12 = r_v18_5

    r_v16_1[r_v18_5] = r_v3_12

end

repeat

    local r_v10_6 = #r_v16_1

    local r_v2_11 = 1

    local r_v3_14 = r_v4_2(r_v2_11, r_v10_6)

    r_v10_6 = r_v3_14

    local r_v3_15 = r_v7_2(r_v16_1, r_v10_6)

    r_v12_1 = r_v3_15

    local r_v3_16 = r_v3_8

    local r_v14_2 = 1

    local r_v13_2 = r_v12_1 - r_v14_2

    local r_v2_12 = r_v9_2(r_v13_2)

    r_v3_16[r_v12_1] = r_v2_12

    r_v10_6 = nil

    r_v12_1 = nil

    local r_v2_13 = #r_v16_1

    local r_v10_7 = 0

    local r_v3_17 = r_v2_13 == r_v10_7

until r_v3_17

local r_v3_18 = {}

local r_v3_19 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v17_2 = r_v3_18
    
    local r_v2_16 = #r_v17_2
    
    local r_v17_3 = 0
    
    local r_v3_24 = r_v2_16 == r_v17_3
    
    if r_v3_24 then
    
        local r_v1_5 = r_v3_5
    
        local r_v4_3 = 12345
    
        local r_v17_4 = r_v1_5 * r_v4_3
    
        local r_v1_6 = 6789
    
        local r_v2_17 = r_v17_4 + r_v1_6
    
        local r_v17_5 = 35184372088832
    
        local r_v3_25 = r_v2_17 % r_v17_5
    
        r_v3_5 = r_v3_25
    
        repeat
    
            local r_v1_10 = r_v3_6
    
            local r_v4_7 = 17
    
            local r_v17_8 = r_v1_10 * r_v4_7
    
            local r_v1_11 = 257
    
            local r_v2_19 = r_v17_8 % r_v1_11
    
            r_v3_6 = r_v2_19
    
            local r_v1_12 = r_v3_6
    
            local r_v4_8 = 1
    
            local r_v17_9 = r_v1_12 ~= r_v4_8
    
        until r_v17_9
    
        local r_v1_13 = r_v3_6
    
        local r_v4_9 = 32
    
        local r_v17_10 = r_v1_13 % r_v4_9
    
        local r_v7_3 = r_v3_1
    
        local r_v8_3 = r_v3_5
    
        local r_v13_5 = r_v3_6
    
        local r_v12_4 = r_v13_5 - r_v17_10
    
        local r_v13_6 = 32
    
        local r_v10_10 = r_v12_4 / r_v13_6
    
        local r_v16_2 = 13
    
        local r_v15_3 = r_v16_2 - r_v10_10
    
        local r_v5_3 = 2
    
        local r_v11_3 = r_v5_3 ^ r_v15_3
    
        local r_v6_3 = r_v8_3 / r_v11_3
    
        local r_v9_3 = r_v7_3(r_v6_3)
    
        local r_v7_4 = 4294967296
    
        local r_v4_10 = r_v9_3 % r_v7_4
    
        local r_v9_4 = 2
    
        local r_v7_5 = r_v9_4 ^ r_v17_10
    
        local r_v1_14 = r_v4_10 / r_v7_5
    
        local r_v7_6 = r_v3_1
    
        local r_v11_4 = 1
    
        local r_v8_4 = r_v1_14 % r_v11_4
    
        local r_v11_5 = 4294967296
    
        local r_v6_4 = r_v8_4 * r_v11_5
    
        local r_v9_5 = r_v7_6(r_v6_4)
    
        local r_v7_7 = r_v3_1
    
        local r_v6_5 = r_v7_7(r_v1_14)
    
        local r_v4_11 = r_v9_5 + r_v6_5
    
        local r_v9_6 = 65536
    
        local r_v7_8 = r_v4_11 % r_v9_6
    
        local r_v6_6 = r_v4_11 - r_v7_8
    
        local r_v8_5 = 65536
    
        local r_v9_7 = r_v6_6 / r_v8_5
    
        local r_v8_6 = 256
    
        local r_v6_7 = r_v7_8 % r_v8_6
    
        local r_v11_6 = r_v7_8 - r_v6_7
    
        local r_v5_4 = 256
    
        local r_v8_7 = r_v11_6 / r_v5_4
    
        local r_v5_5 = 256
    
        local r_v11_7 = r_v9_7 % r_v5_5
    
        local r_v15_4 = r_v9_7 - r_v11_7
    
        local r_v16_3 = 256
    
        local r_v5_6 = r_v15_4 / r_v16_3
    
        local r_v15_5 = {
                                                r_v6_7,
                                                r_v8_7,
                                                r_v11_7,
                                                r_v5_6
                                            }
    
        r_v3_18 = r_v15_5
    
        r_v11_7 = nil
    
        r_v5_6 = nil
    
        r_v6_7 = nil
    
        r_v7_8 = nil
    
        r_v1_14 = nil
    
        r_v4_11 = nil
    
        r_v17_10 = nil
    
        r_v9_7 = nil
    
        r_v8_7 = nil
    
    end
    
    local r_v4_4 = "table"
    
    local r_v1_8 = _env[r_v4_4]
    
    local r_v4_5 = "remove"
    
    local r_v17_7 = r_v1_8[r_v4_5]
    
    local r_v4_6 = r_v3_18
    
    local r_v1_9 = {
                                            r_v17_7(r_v4_6)
                                        }
    
    return unpack(r_v1_9)
end

local r_v3_20 = {}

local r_v14_3 = {}

local r_v2_14 = "setmetatable"

local r_v3_21 = _env[r_v2_14]

local r_v19_1 = r_v3_20

local r_v20_1 = "__index"

local r_v21_1 = "__metatable"

local r_v22_1 = nil

local r_v18_6 = {
                                        [r_v20_1] = r_v19_1,
                                        [r_v21_1] = r_v22_1
                                    }

local r_v2_15 = r_v3_21(r_v14_3, r_v18_6)

local r_v3_22 = "STRINGS"

_env[r_v3_22] = r_v2_15

local r_v3_23 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v1_15 = args[2]
    
    local r_v17_11 = args[1]
    
    local r_v3_26 = r_v3_20
    
    local r_v4_12 = r_v3_26
    
    local r_v3_27 = r_v4_12[r_v1_15]
    
    if not (r_v3_27) then
    
        local r_v3_28 = {}
    
        r_v3_18 = r_v3_28
    
        local r_v2_20 = r_v3_8
    
        local r_v7_9 = r_v2_20
    
        local r_v9_8 = 35184372088832
    
        local r_v2_21 = r_v1_15 % r_v9_8
    
        r_v3_5 = r_v2_21
    
        local r_v8_8 = 255
    
        local r_v6_8 = r_v1_15 % r_v8_8
    
        local r_v8_9 = 2
    
        local r_v9_9 = r_v6_8 + r_v8_9
    
        r_v3_6 = r_v9_9
    
        local r_v11_8 = "string"
    
        local r_v8_10 = _env[r_v11_8]
    
        local r_v15_6 = 1
    
        local r_v11_9 = "len"
    
        local r_v6_9 = r_v8_10[r_v11_9]
    
        local r_v8_11 = r_v6_9(r_v17_11)
    
        local r_v16_4 = r_v15_6
    
        local r_v6_10 = ""
    
        r_v4_12[r_v1_15] = r_v6_10
    
        local r_v11_10 = 1
    
        local r_v5_7 = r_v8_11
    
        local r_v6_11 = 91
    
        for r_v11_15 = r_v11_10, r_v5_7, r_v16_4 do
    
            local r_v19_2 = "string"
    
            local r_v20_2 = _env[r_v19_2]
    
            local r_v19_3 = "byte"
    
            local r_v18_7 = r_v20_2[r_v19_3]
    
            local r_v20_3 = r_v18_7(r_v17_11, r_v11_15)
    
            local r_v18_8 = r_v3_19
    
            local r_v19_4 = r_v18_8()
    
            local r_v14_5 = r_v20_3 + r_v19_4
    
            local r_v13_7 = r_v14_5 + r_v6_11
    
            local r_v14_6 = 256
    
            local r_v12_9 = r_v13_7 % r_v14_6
    
            r_v6_11 = r_v12_9
    
            local r_v14_7 = r_v4_12[r_v1_15]
    
            local r_v19_5 = 1
    
            local r_v20_4 = r_v6_11 + r_v19_5
    
            local r_v18_9 = r_v7_9[r_v20_4]
    
            local r_v13_8 = r_v14_7 .. r_v18_9
    
            r_v4_12[r_v1_15] = r_v13_8
    
        end
    
        r_v8_11 = nil
    
        r_v6_11 = nil
    
        r_v7_9 = nil
    
    end
    
    return r_v1_15
end

local r_v14_4 = "DECRYPT"

_env[r_v14_4] = r_v3_23

r_v7_2 = nil

local r_v11_2 = nil

r_v4_2 = nil

r_v9_2 = nil

r_v16_1 = nil

local r_v15_2 = nil

return
