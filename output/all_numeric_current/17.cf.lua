--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = "print"

local r_v2_1 = _env[r_v1_1]

local r_v3_1 = "1"

local r_v1_2 = r_v2_1(r_v3_1)

local r_v2_2 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v7_2 = args[1]
    
    local r_v3_3 = args[2]
    
    local r_v1_7 = "print"
    
    local r_v2_5 = _env[r_v1_7]
    
    local r_v4_3 = "A"
    
    local r_v1_8 = r_v2_5(r_v4_3)
    
    local r_v2_6 = r_v7_2 + r_v3_3
    
    return r_v2_6
end

local r_v3_2 = r_v2_2

local r_v1_3 = "print"

local r_v2_3 = _env[r_v1_3]

local r_v4_1 = 2

local r_v1_4 = r_v2_3(r_v4_1)

local r_v1_5 = "print"

local r_v2_4 = _env[r_v1_5]

local r_v5_1 = 1

local r_v6_1 = 2

local r_v4_2 = {
                            r_v3_2(r_v5_1, r_v6_1)
                        }

local r_v1_6 = r_v2_4(unpack(r_v4_2))

local r_v7_1 = args

r_v3_2 = nil

return
