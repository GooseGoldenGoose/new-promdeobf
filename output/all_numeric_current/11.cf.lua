--headers

local _env = getfenv()
local args = { ... }

--body

local r_v1_1 = 3123

local r_v2_1 = r_v1_1

local r_v3_1 = "_G"

local r_v4_1 = _env[r_v3_1]

local r_v3_2 = "wasd"

local r_v1_2 = r_v4_1[r_v3_2]

local r_v5_1 = args

if r_v1_2 then

    local r_v4_2 = "print"

    local r_v1_3 = _env[r_v4_2]

    local r_v4_3 = r_v1_3(r_v2_1)

    local r_v1_4 = 3

    r_v2_1 = r_v1_4

end

local r_v3_3 = "print"

local r_v4_4 = _env[r_v3_3]

local r_v3_4 = r_v4_4(r_v2_1)

r_v2_1 = nil

return
