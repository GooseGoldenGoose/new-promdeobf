print("capture-loop-start")
for i = 1, 3 do
    local function readI()
        return i
    end
    print("capture-for", readI())
end
local x = 0
while x < 3 do
    x = x + 1
    local y = x * 10
    local function readBoth()
        return x, y
    end
    print("capture-while", readBoth())
end
local r = 0
repeat
    r = r + 1
    local function readR()
        return r
    end
    print("capture-repeat", readR())
until r >= 2
print("capture-loop-end")
