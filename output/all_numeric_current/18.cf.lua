--headers

local _env = getfenv()
local args = { ... }

--body

local r_v2_1 = 123

local r_v2_2 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v4_5 = r_v2_1
    
    local r_v6_2 = 1
    
    local r_v2_5 = r_v4_5 + r_v6_2
    
    r_v2_1 = r_v2_5
    
    local r_v4_6 = true
    
    return r_v4_6
end

local r_v3_1 = r_v2_2

local r_v4_1 = "print"

local r_v2_3 = _env[r_v4_1]

local r_v5_1 = {
                            r_v3_1()
                        }

local r_v4_2 = r_v2_3(unpack(r_v5_1))

local r_v4_3 = "print"

local r_v2_4 = _env[r_v4_3]

local r_v5_2 = r_v2_1

local r_v4_4 = r_v2_4(r_v5_2)

local r_v6_1 = args

r_v3_1 = nil

return
