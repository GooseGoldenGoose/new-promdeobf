--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = "print"

local r_v2_1 = _env[r_v1_1]

local r_v3_1 = "capture-loop-start"

local r_v1_2 = r_v2_1(r_v3_1)

local r_v3_2 = 3

local r_v4_1 = r_v3_2

local r_v3_3 = 1

local r_v5_1 = r_v3_3

local r_v1_3 = 1

local r_v7_1 = args

for r_v8_5 = r_v1_3, r_v4_1, r_v5_1 do

    local r_v2_3 = function(...)
        --headers
    
        local args = { ... }
    
        --body
    
        local r_v2_8 = r_v8_5
        
        return r_v2_8
    end

    local r_v9_1 = r_v2_3

    local r_v1_8 = "print"

    local r_v2_4 = _env[r_v1_8]

    local r_v10_1 = {
                                                r_v9_1()
                                            }

    local r_v11_1 = "capture-for"

    local r_v1_9 = r_v2_4(r_v11_1, unpack(r_v10_1))

    r_v9_1 = nil

end

local r_v2_5 = 0

while true do

    local r_v1_10 = r_v2_5

    local r_v4_2 = 3

    local r_v2_6 = r_v1_10 < r_v4_2

    if not (r_v2_6) then
        break
    end

    local r_v1_11 = r_v2_5

    local r_v4_3 = 1

    local r_v2_7 = r_v1_11 + r_v4_3

    r_v2_5 = r_v2_7

    local r_v4_4 = r_v2_5

    local r_v5_2 = 10

    local r_v1_12 = r_v4_4 * r_v5_2

    local r_v1_13 = function(...)
        --headers
    
        local args = { ... }
    
        --body
    
        local r_v2_9 = r_v2_5
        
        local r_v1_18 = r_v1_12
        
        return r_v2_9, r_v1_18
    end

    local r_v5_3 = r_v1_13

    local r_v6_2 = "print"

    local r_v1_14 = _env[r_v6_2]

    local r_v9_2 = {
                                                    r_v5_3()
                                                }

    local r_v8_7 = "capture-while"

    local r_v6_3 = r_v1_14(r_v8_7, unpack(r_v9_2))

    r_v5_3 = nil

end

local r_v1_15 = 0

repeat

    local r_v5_5 = r_v1_15

    local r_v6_5 = 1

    local r_v1_17 = r_v5_5 + r_v6_5

    r_v1_15 = r_v1_17

    local r_v5_6 = function(...)
        --headers
    
        local args = { ... }
    
        --body
    
        local r_v2_10 = r_v1_15
        
        return r_v2_10
    end

    local r_v8_8 = "print"

    local r_v6_6 = _env[r_v8_8]

    local r_v11_2 = {
                                                r_v5_6()
                                            }

    local r_v9_3 = "capture-repeat"

    local r_v8_9 = r_v6_6(r_v9_3, unpack(r_v11_2))

    r_v5_6 = nil

    local r_v6_7 = r_v1_15

    local r_v8_10 = 2

    local r_v5_7 = r_v6_7 >= r_v8_10

until r_v5_7

local r_v6_8 = "print"

local r_v5_8 = _env[r_v6_8]

local r_v8_11 = "capture-loop-end"

local r_v6_9 = r_v5_8(r_v8_11)

return
