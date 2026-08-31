--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = 3

local r_v2_1 = r_v1_1

local r_v1_2 = 1

local r_v4_1 = "print"

local r_v1_3 = _env[r_v4_1]

local r_v5_1 = r_v1_2

local r_v4_2 = r_v1_3(r_v5_1)

local r_v6_1 = "math"

local r_v5_2 = _env[r_v6_1]

local r_v6_2 = "random"

local r_v4_3 = r_v5_2[r_v6_2]

local r_v7_1 = 2

local r_v6_3 = 1

local r_v5_3 = r_v4_3(r_v6_3, r_v7_1)

local r_v4_4 = 1

local r_v1_4 = r_v5_3 == r_v4_4

local r_v8_1 = args

if r_v1_4 then

    local r_v1_5 = 2

    local r_v5_4 = r_v1_5

    local r_v4_5 = "print"

    local r_v1_6 = _env[r_v4_5]

    local r_v4_6 = r_v1_6(r_v5_4)

    local r_v1_7 = 123

    return r_v1_7

end

local r_v4_7 = "print"

local r_v1_8 = _env[r_v4_7]

local r_v4_8 = r_v1_8(r_v2_1)

local r_v1_9 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v4_9 = "print"
    
    local r_v1_11 = _env[r_v4_9]
    
    local r_v8_2 = r_v1_2
    
    local r_v4_10 = r_v1_11(r_v8_2)
    
    local r_v1_12 = 1
    
    return r_v1_12
end

local r_v5_5 = r_v1_9

local r_v1_10 = r_v5_5()

r_v2_1 = nil

r_v5_5 = nil

return
