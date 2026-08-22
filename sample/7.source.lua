local b = 3
local a = 1
print(a)

do
    local b = 2
    print(b)
end

print(b)

local function w()
    print(a)
    return 1
end
w()
