--headers

local _env = getfenv()
local args = { ... }

--body

local r_v2_1 = 4

local r_v2_2 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v4_3 = r_v2_1
    
    local r_v9_2 = args[1]
    
    local r_v2_4 = r_v4_3 + r_v9_2
    
    local r_v1_3 = r_v2_4
    
    local r_v4_4 = 6
    
    local r_v2_5 = r_v1_3 > r_v4_4
    
    if r_v2_5 then
    
        local r_v4_5 = 2
    
        local r_v2_6 = r_v1_3 * r_v4_5
    
        r_v1_3 = r_v2_6
    
    else
    
        local r_v3_2 = 1
    
        local r_v4_6 = r_v1_3 - r_v3_2
    
        r_v1_3 = r_v4_6
    
    end
    
    return r_v1_3
end

local r_v3_1 = r_v2_2

local r_v4_1 = "print"

local r_v2_3 = _env[r_v4_1]

local r_v5_1 = 3

local r_v6_1 = r_v3_1(r_v5_1)

local r_v7_1 = 1

local r_v5_2 = {
                            r_v3_1(r_v7_1)
                        }

local r_v8_1 = "baseline"

local r_v4_2 = r_v2_3(r_v8_1, r_v6_1, unpack(r_v5_2))

local r_v9_1 = args

r_v3_1 = nil

return
