--headers

local _env = getfenv()
local args = { ... }

--body

local r_v2_1 = 3

local r_v2_2 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v6_4 = r_v2_1
    
    local r_v9_2 = args[1]
    
    local r_v2_5 = r_v9_2 + r_v6_4
    
    local r_v6_5 = r_v2_5
    
    local r_v3_2 = 5
    
    local r_v2_6 = r_v6_5 > r_v3_2
    
    if r_v2_6 then
    
        local r_v6_6 = r_v2_5
    
        local r_v3_3 = 1
    
        local r_v2_7 = r_v6_6 - r_v3_3
    
        r_v2_5 = r_v2_7
    
    else
    
        local r_v3_4 = r_v2_5
    
        local r_v7_2 = 2
    
        local r_v6_7 = r_v3_4 + r_v7_2
    
        r_v2_5 = r_v6_7
    
    end
    
    while true do
    
        local r_v7_3 = r_v2_5
    
        local r_v4_2 = 8
    
        local r_v3_5 = r_v7_3 < r_v4_2
    
        if not (r_v3_5) then
            break
        end
    
        local r_v7_4 = r_v2_5
    
        local r_v4_3 = 1
    
        local r_v3_6 = r_v7_4 + r_v4_3
    
        r_v2_5 = r_v3_6
    
    end
    
    local r_v7_5 = function(...)
        --headers
    
        local args = { ... }
    
        --body
    
        local r_v9_3 = args[1]
        
        local r_v1_4 = 2
        
        local r_v6_8 = r_v9_3 % r_v1_4
        
        local r_v1_5 = 0
        
        local r_v2_8 = r_v6_8 == r_v1_5
        
        if r_v2_8 then
        
            local r_v6_9 = r_v2_5
        
            local r_v2_9 = r_v6_9 + r_v9_3
        
            return r_v2_9
        
        end
        
        local r_v6_10 = r_v2_5
        
        local r_v2_10 = r_v6_10 - r_v9_3
        
        return r_v2_10
    end
    
    local r_v5_2 = 2
    
    local r_v4_4 = r_v7_5(r_v5_2)
    
    local r_v8_2 = 3
    
    local r_v5_3 = r_v7_5(r_v8_2)
    
    local r_v8_3 = r_v2_5
    
    return r_v8_3, r_v4_4, r_v5_3
end

local r_v3_1 = r_v2_2

local r_v4_1 = 2

local r_v5_1 = {
                                r_v3_1(r_v4_1)
                            }

local r_v2_3 = r_v5_1[1]

local r_v6_1 = r_v5_1[2]

local r_v7_1 = r_v5_1[3]

r_v5_1 = r_v6_1

r_v4_1 = r_v2_3

local r_v6_2 = "print"

local r_v2_4 = _env[r_v6_2]

local r_v8_1 = "theory"

local r_v6_3 = r_v2_4(r_v8_1, r_v4_1, r_v5_1, r_v7_1)

local r_v9_1 = args

r_v4_1 = nil

r_v5_1 = nil

r_v7_1 = nil

r_v3_1 = nil

return
