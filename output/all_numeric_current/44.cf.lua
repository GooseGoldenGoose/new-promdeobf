--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v7_2 = args[1]
    
    local r_v2_2 = 5
    
    local r_v6_3 = r_v2_2
    
    local r_v2_3 = 1
    
    local r_v5_3 = r_v2_3
    
    local r_v3_5 = 1
    
    for r_v8_5 = r_v3_5, r_v6_3, r_v5_3 do
    
        local r_v1_5 = r_v8_5 == r_v7_2
    
        if r_v1_5 then
    
            local r_v1_7 = "ret"
    
            return r_v1_7, r_v8_5
    
        else
    
            local r_v3_10 = 2
    
            local r_v1_8 = r_v8_5 == r_v3_10
    
            if r_v1_8 then
    
                continue
    
            end
    
            local r_v3_11 = 4
    
            local r_v1_9 = r_v8_5 == r_v3_11
    
            if r_v1_9 then
    
                break
    
            end
    
            local r_v3_12 = "print"
    
            local r_v1_10 = _env[r_v3_12]
    
            local r_v9_1 = "s44-body"
    
            local r_v3_13 = r_v1_10(r_v9_1, r_v7_2, r_v8_5)
    
        end
    
    end
    
    local r_v1_6 = "done"
    
    return r_v1_6, r_v7_2
end

local r_v2_1 = r_v1_1

local r_v3_1 = "print"

local r_v1_2 = _env[r_v3_1]

local r_v4_1 = 3

local r_v5_1 = {
                            r_v2_1(r_v4_1)
                        }

local r_v6_1 = "s44-a"

local r_v3_2 = r_v1_2(r_v6_1, unpack(r_v5_1))

local r_v3_3 = "print"

local r_v1_3 = _env[r_v3_3]

local r_v4_2 = 9

local r_v5_2 = {
                            r_v2_1(r_v4_2)
                        }

local r_v6_2 = "s44-b"

local r_v3_4 = r_v1_3(r_v6_2, unpack(r_v5_2))

local r_v7_1 = args

r_v2_1 = nil

return
