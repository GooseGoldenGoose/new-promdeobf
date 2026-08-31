--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v5_2 = args[1]
    
    local r_v3_3 = "print"
    
    local r_v1_5 = _env[r_v3_3]
    
    local r_v3_4 = r_v1_5(r_v5_2)
    
    return r_v5_2
end

local r_v2_1 = r_v1_1

local r_v3_1 = "table"

local r_v1_2 = r_v2_1(r_v3_1)

local r_v4_1 = r_v1_2

local r_v3_2 = "after"

local r_v1_3 = r_v2_1(r_v3_2)

local r_v1_4 = {
                            r_v4_1
                        }

local r_v5_1 = args

return r_v1_4
