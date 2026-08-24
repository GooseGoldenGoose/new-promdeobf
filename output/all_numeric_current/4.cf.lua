--headers

local _env = getfenv()
local args = { ... }

--body

local r_v2_1 = 0

local r_v2_2 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v10_2 = args[1]
    
    local r_v6_9 = 3
    
    local r_v2_9 = r_v10_2 > r_v6_9
    
    if r_v2_9 then
    
        local r_v6_10 = r_v2_1
    
        local r_v2_10 = r_v6_10 + r_v10_2
    
        r_v2_1 = r_v2_10
    
    else
    
        local r_v1_3 = r_v2_1
    
        local r_v3_2 = 1
    
        local r_v6_11 = r_v1_3 + r_v3_2
    
        r_v2_1 = r_v6_11
    
    end
    
    local r_v1_4 = r_v2_1
    
    return r_v1_4
end

local r_v3_1 = r_v2_2

local r_v2_3 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v10_3 = args[1]
    
    local r_v2_11 = 0
    
    local r_v3_3 = r_v2_11
    
    local r_v1_5 = args[2]
    
    while true do
    
        local r_v2_12 = r_v3_3 < r_v10_3
    
        if not (r_v2_12) then
            break
        end
    
        local r_v4_2 = 2
    
        local r_v6_12 = r_v3_3 % r_v4_2
    
        local r_v4_3 = 0
    
        local r_v2_13 = r_v6_12 == r_v4_3
    
        if r_v2_13 then
    
            local r_v6_13 = r_v2_1
    
            local r_v4_4 = 2
    
            local r_v2_14 = r_v6_13 + r_v4_4
    
            r_v2_1 = r_v2_14
    
        else
    
            local r_v4_5 = r_v2_1
    
            local r_v5_3 = 1
    
            local r_v6_14 = r_v4_5 + r_v5_3
    
            r_v2_1 = r_v6_14
    
        end
    
        local r_v5_4 = 1
    
        local r_v4_6 = r_v3_3 + r_v5_4
    
        r_v3_3 = r_v4_6
    
    end
    
    local r_v5_2 = r_v2_1
    
    return r_v5_2
end

local r_v4_1 = r_v2_3

local r_v2_4 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v3_4 = args[3]
    
    local r_v4_7 = args[4]
    
    local r_v10_4 = args[1]
    
    local r_v5_5 = args[5]
    
    local r_v1_6 = args[2]
    
    repeat
    
        local r_v6_16 = r_v2_1
    
        local r_v8_5 = 1
    
        local r_v2_16 = r_v6_16 - r_v8_5
    
        r_v2_1 = r_v2_16
    
        local r_v8_6 = r_v2_1
    
        local r_v6_17 = r_v8_6 <= r_v10_4
    
    until r_v6_17
    
    local r_v6_18 = r_v2_1
    
    return r_v6_18
end

local r_v5_1 = r_v2_4

local r_v6_1 = "print"

local r_v2_5 = _env[r_v6_1]

local r_v7_1 = r_v2_1

local r_v8_1 = "start"

local r_v6_2 = r_v2_5(r_v8_1, r_v7_1)

local r_v6_3 = "print"

local r_v2_6 = _env[r_v6_3]

local r_v9_1 = 5

local r_v7_2 = {
                                r_v3_1(r_v9_1)
                            }

local r_v8_2 = "choose"

local r_v6_4 = r_v2_6(r_v8_2, unpack(r_v7_2))

local r_v6_5 = "print"

local r_v2_7 = _env[r_v6_5]

local r_v9_2 = 3

local r_v7_3 = {
                                r_v4_1(r_v9_2)
                            }

local r_v8_3 = "spin"

local r_v6_6 = r_v2_7(r_v8_3, unpack(r_v7_3))

local r_v6_7 = "print"

local r_v2_8 = _env[r_v6_7]

local r_v9_3 = 2

local r_v7_4 = {
                                r_v5_1(r_v9_3)
                            }

local r_v8_4 = "trim"

local r_v6_8 = r_v2_8(r_v8_4, unpack(r_v7_4))

local r_v10_1 = args

r_v3_1 = nil

r_v4_1 = nil

r_v5_1 = nil

return
