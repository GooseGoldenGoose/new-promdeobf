--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v4_3 = "print"
    
    local r_v1_11 = _env[r_v4_3]
    
    local r_v5_2 = "g"
    
    local r_v4_4 = r_v1_11(r_v5_2)
    
    return
end

local r_v2_1 = r_v1_1

local r_v1_2 = {}

local r_v3_1 = r_v1_2

local r_v1_3 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v5_3 = args[1]
    
    local r_v4_5 = "print"
    
    local r_v1_12 = _env[r_v4_5]
    
    local r_v2_3 = "hee"
    
    local r_v4_6 = r_v1_12(r_v2_3, r_v5_3)
    
    r_v5_3 = nil
    
    return
end

local r_v4_1 = "hee"

r_v3_1[r_v4_1] = r_v1_3

local r_v4_2 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v5_4 = args[1]
    
    local r_v4_7 = "print"
    
    local r_v1_13 = _env[r_v4_7]
    
    local r_v2_4 = "yai"
    
    local r_v4_8 = r_v1_13(r_v2_4, r_v5_4)
    
    r_v5_4 = nil
    
    return
end

local r_v1_4 = "yai"

r_v3_1[r_v1_4] = r_v4_2

local r_v1_5 = "yai"

local r_v1_6 = r_v3_1[r_v1_5]

local r_v1_7 = r_v1_6(r_v3_1)

local r_v1_8 = "hee"

local r_v1_9 = r_v3_1[r_v1_8]

local r_v1_10 = r_v1_9(r_v3_1)

local r_v5_1 = args

local r_v2_2 = nil

r_v3_1 = nil

return
