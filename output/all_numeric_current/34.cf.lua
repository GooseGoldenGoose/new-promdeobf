--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v8_2 = args[1]
    
    local r_v1_7 = 0
    
    local r_v2_2 = r_v1_7
    
    while true do
    
        local r_v1_8 = r_v2_2 < r_v8_2
    
        if not (r_v1_8) then
            break
        end
    
        local r_v5_7 = 1
    
        local r_v1_9 = r_v2_2 + r_v5_7
    
        r_v2_2 = r_v1_9
    
        local r_v3_2 = 3
    
        local r_v5_8 = r_v2_2 == r_v3_2
    
        if r_v5_8 then
    
            local r_v5_10 = "while"
    
            return r_v5_10, r_v2_2
    
        end
    
    end
    
    local r_v5_9 = "while-done"
    
    return r_v5_9, r_v2_2
end

local r_v2_1 = r_v1_1

local r_v1_2 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v8_3 = args[1]
    
    local r_v3_3 = 1
    
    local r_v4_2 = r_v3_3
    
    local r_v5_11 = 1
    
    local r_v2_3 = r_v8_3
    
    for r_v6_8 = r_v5_11, r_v2_3, r_v4_2 do
    
        local r_v5_16 = 2
    
        local r_v1_11 = r_v6_8 == r_v5_16
    
        if r_v1_11 then
    
            local r_v1_13 = "for"
    
            return r_v1_13, r_v6_8
    
        end
    
    end
    
    local r_v1_12 = "for-done"
    
    return r_v1_12, r_v8_3
end

local r_v3_1 = r_v1_2

local r_v1_3 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v8_4 = args[1]
    
    local r_v1_14 = 0
    
    local r_v2_4 = r_v1_14
    
    repeat
    
        local r_v5_18 = 1
    
        local r_v1_16 = r_v2_4 + r_v5_18
    
        r_v2_4 = r_v1_16
    
        local r_v5_19 = r_v2_4 == r_v8_4
    
        if r_v5_19 then
    
            local r_v5_20 = "repeat"
    
            return r_v5_20, r_v2_4
    
        end
    
        local r_v3_6 = 5
    
        local r_v5_21 = r_v2_4 >= r_v3_6
    
    until r_v5_21
    
    local r_v5_22 = "repeat-done"
    
    return r_v5_22, r_v2_4
end

local r_v4_1 = r_v1_3

local r_v5_1 = "print"

local r_v1_4 = _env[r_v5_1]

local r_v6_1 = 5

local r_v7_1 = {
                                r_v2_1(r_v6_1)
                            }

local r_v5_2 = r_v1_4(unpack(r_v7_1))

local r_v5_3 = "print"

local r_v1_5 = _env[r_v5_3]

local r_v6_2 = 5

local r_v7_2 = {
                                r_v3_1(r_v6_2)
                            }

local r_v5_4 = r_v1_5(unpack(r_v7_2))

local r_v5_5 = "print"

local r_v1_6 = _env[r_v5_5]

local r_v6_3 = 3

local r_v7_3 = {
                                r_v4_1(r_v6_3)
                            }

local r_v5_6 = r_v1_6(unpack(r_v7_3))

r_v2_1 = nil

local r_v8_1 = args

r_v3_1 = nil

r_v4_1 = nil

return
