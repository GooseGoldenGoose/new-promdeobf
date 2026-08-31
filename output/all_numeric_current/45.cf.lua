--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = 2

local r_v2_1 = r_v1_1

local r_v1_2 = 1

local r_v3_1 = r_v1_2

local r_v5_1 = 1

local r_v6_1 = args

for r_v7_5 = r_v5_1, r_v2_1, r_v3_1 do

    local r_v8_2 = function(...)
        --headers
    
        local args = { ... }
    
        --body
    
        local r_v8_4 = r_v7_5
        
        return r_v8_4
    end

    local r_v9_1 = r_v8_2

    local r_v5_6 = "print"

    local r_v8_3 = _env[r_v5_6]

    local r_v10_1 = {
                                        r_v9_1()
                                    }

    local r_v5_7 = r_v8_3(unpack(r_v10_1))

    r_v9_1 = nil

end

return
