local b = 3
local a = 1
print(a)

if math.random(1,2) == 1 then
    local b = 2
    print(b)
    return 123;
end

print(b)

local function w()
    print(a)
    return 1
end
w()
