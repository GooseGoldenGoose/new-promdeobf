--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v6_2 = 5
    
    local r_v2_2 = 6
    
    local r_v5_2 = 4
    
    local r_v1_3 = {
                                    r_v5_2,
                                    r_v6_2,
                                    r_v2_2
                                }
    
    r_v6_2 = r_v1_3
    
    local r_v1_4 = function(...)
        --headers
    
        local args = { ... }
    
        --body
    
        local r_v2_4 = args[2]
        
        local r_v6_3 = args[1]
        
        local r_v3_3 = 0
        
        local r_v5_3 = r_v2_4 or r_v3_3
        
        local r_v4_3 = 1
        
        local r_v1_6 = r_v5_3 + r_v4_3
        
        r_v4_3 = r_v1_6
        
        local r_v5_4 = r_v6_3[r_v4_3]
        
        r_v3_3 = r_v5_4
        
        local r_v7_2 = nil
        
        local r_v5_5 = r_v3_3 ~= r_v7_2
        
        if r_v5_5 then
        
            return r_v4_3, r_v3_3
        
        end
        
        r_v3_3 = nil
        
        r_v4_3 = nil
        
        r_v2_4 = nil
        
        r_v6_3 = nil
        
        return
    end
    
    local r_v2_3 = r_v1_4
    
    local r_v1_5 = nil
    
    return r_v2_3, r_v6_2, r_v1_5
end

local r_v2_1 = r_v1_1

local r_v3_1 = {
                                        r_v2_1()
                                    }

local r_v4_1 = r_v3_1[3]

local r_v1_2 = r_v3_1[1]

local r_v5_1 = r_v3_1[2]

local r_v3_2 = r_v1_2

local r_v6_1 = args

local r_v7_1 = r_v5_1

for r_v8_1, r10 in r_v3_2, r_v7_1, r_v4_1 do

    local r_v9_1 = "print"

    local r_v10_1 = _env[r_v9_1]

    local r_v11_1 = "custom"

    local r_v9_2 = r_v10_1(r_v11_1, r_v8_1, r10)

end

r_v2_1 = nil

return
