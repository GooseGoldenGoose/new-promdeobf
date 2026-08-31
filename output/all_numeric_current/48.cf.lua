--headers

local _env = getfenv()
local args = { ... }

--body

local r_v2_1 = 0

local r_v2_2 = function(...)
    --headers

    local args = { ... }

    --body

    local r_v6_8 = r_v2_1
    
    local r_v7_2 = args[1]
    
    local r_v1_3 = 1
    
    local r_v2_5 = r_v6_8 + r_v1_3
    
    r_v2_1 = r_v2_5
    
    return r_v7_2
end

local r_v3_1 = r_v2_2

local r_v4_1 = false

local r_v5_1 = r_v3_1(r_v4_1)

local r_v6_1 = r_v5_1

local r_v7_1 = args

if not (r_v5_1) then

    local r_v4_3 = true

    r_v5_1 = r_v3_1(r_v4_3)

    r_v6_1 = r_v5_1

end

r_v5_1 = r_v6_1

local r_v8_1 = true

local r_v4_2 = r_v3_1(r_v8_1)

local r_v6_2 = r_v4_2

if r_v4_2 then

    local r_v8_2 = false

    r_v4_2 = r_v3_1(r_v8_2)

    r_v6_2 = r_v4_2

end

local r_v9_1 = false

local r_v8_3 = r_v3_1(r_v9_1)

r_v4_2 = r_v6_2

local r_v6_3 = r_v8_3

if not (r_v8_3) then

    local r_v9_2 = r_v2_1

    local r_v10_1 = 5

    local r_v8_4 = r_v9_2 == r_v10_1

    r_v6_3 = r_v8_4

end

if r_v6_3 then

    local r_v6_4 = "print"

    local r_v2_3 = _env[r_v6_4]

    local r_v9_3 = r_v2_1

    local r_v8_5 = "if-or"

    local r_v6_5 = r_v2_3(r_v8_5, r_v5_1, r_v4_2, r_v9_3)

end

local r_v6_6 = "print"

local r_v2_4 = _env[r_v6_6]

local r_v9_4 = r_v2_1

local r_v8_6 = "done"

local r_v6_7 = r_v2_4(r_v8_6, r_v5_1, r_v4_2, r_v9_4)

r_v3_1 = nil

r_v4_2 = nil

r_v5_1 = nil

return
