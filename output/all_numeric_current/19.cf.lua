--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = 10

local r_v1_2 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v1_6 = function(...)
        --headers
    
        local args = { ... }
    
        --body
    
        local r_v4_7 = r_v1_1
        
        local r_v6_3 = 2
        
        local r_v1_8 = r_v4_7 + r_v6_3
        
        r_v1_1 = r_v1_8
        
        local r_v4_8 = r_v1_1
        
        return r_v4_8
    end
    
    local r_v6_2 = r_v1_6
    
    local r_v1_7 = {
                                    r_v6_2()
                                }
    
    return unpack(r_v1_7)
end

local r_v3_1 = r_v1_2

local r_v4_1 = "print"

local r_v1_3 = _env[r_v4_1]

local r_v5_1 = {
                                r_v3_1()
                            }

local r_v4_2 = r_v1_3(unpack(r_v5_1))

local r_v4_3 = "print"

local r_v1_4 = _env[r_v4_3]

local r_v5_2 = {
                                r_v3_1()
                            }

local r_v4_4 = r_v1_4(unpack(r_v5_2))

local r_v4_5 = "print"

local r_v1_5 = _env[r_v4_5]

local r_v5_3 = r_v1_1

local r_v4_6 = r_v1_5(r_v5_3)

local r_v6_1 = args

r_v3_1 = nil

return
