--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = 1

local r_v1_2 = 10

local r_v3_1 = r_v1_2

local r_v1_3 = 2

local r_v4_1 = r_v1_3

local r_v5_1 = "print"

local r_v1_4 = _env[r_v5_1]

local r_v6_1 = "block"

local r_v5_2 = r_v1_4(r_v6_1, r_v3_1, r_v4_1)

local r_v1_5 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v9_2 = args[1]
    
    local r_v5_7 = r_v1_1
    
    local r_v1_9 = r_v5_7 + r_v9_2
    
    r_v1_1 = r_v1_9
    
    local r_v5_8 = r_v1_1
    
    return r_v5_8
end

r_v3_1 = nil

local r_v3_2 = r_v1_5

local r_v1_6 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v1_10 = r_v1_1
    
    return r_v1_10
end

r_v4_1 = nil

local r_v4_2 = r_v1_6

local r_v5_3 = "print"

local r_v1_7 = _env[r_v5_3]

local r_v7_1 = {
                                r_v4_2()
                            }

local r_v6_2 = "before"

local r_v5_4 = r_v1_7(r_v6_2, unpack(r_v7_1))

local r_v5_5 = "print"

local r_v1_8 = _env[r_v5_5]

local r_v8_1 = 2

local r_v7_2 = r_v3_2(r_v8_1)

local r_v8_2 = {
                                r_v4_2()
                            }

local r_v6_3 = "after"

local r_v5_6 = r_v1_8(r_v6_3, r_v7_2, unpack(r_v8_2))

r_v4_2 = nil

local r_v9_1 = args

r_v3_2 = nil

return
