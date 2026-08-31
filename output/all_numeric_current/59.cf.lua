--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = "ipairs"

local r_v2_1 = _env[r_v1_1]

local r_v3_1 = 4

local r_v4_1 = 6

local r_v5_1 = 2

local r_v6_1 = {
                                        r_v5_1,
                                        r_v3_1,
                                        r_v4_1
                                    }

local r_v5_2 = {
                                        r_v2_1(r_v6_1)
                                    }

local r_v7_1 = r_v5_2[3]

local r_v1_2 = r_v5_2[1]

local r_v8_1 = r_v5_2[2]

local r_v6_2 = r_v1_2

local r_v9_1 = args

for r_v5_3, r_v2_3 in r_v6_2, r_v8_1, r_v7_1 do

    local r_v2_4 = function(...)
        --headers
    
        local args = { ... }
    
        --body
    
        local r_v1_3 = r_v5_3
        
        local r_v9_2 = r_v2_3
        
        local r_v2_8 = r_v1_3 + r_v9_2
        
        return r_v2_8
    end

    local r_v10_1 = r_v5_3

    local r_v4_2 = r_v2_4

    local r_v11_1 = 2

    local r_v2_5 = r_v10_1 == r_v11_1

    if r_v2_5 then

        local r_v10_2 = "print"

        local r_v2_6 = _env[r_v10_2]

        local r_v12_1 = {
                                                r_v4_2()
                                            }

        local r_v11_2 = "cap-a"

        local r_v10_3 = r_v2_6(r_v11_2, unpack(r_v12_1))

    else

        local r_v10_4 = "print"

        local r_v2_7 = _env[r_v10_4]

        local r_v12_2 = {
                                                r_v4_2()
                                            }

        local r_v11_3 = "cap-b"

        local r_v10_5 = r_v2_7(r_v11_3, unpack(r_v12_2))

    end

    r_v4_2 = nil

end

return
