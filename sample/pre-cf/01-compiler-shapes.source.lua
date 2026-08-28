-- PRE-CF compiler-shape probe 01
local function pair()
    return 1, 2
end

local function effect(tag, value)
    print(tag)
    return value
end

local a = 1
local b = a
local c = a + b
local field = math.random
local call = effect("call", c)
local x, y = pair()

if effect("if", x > 0) then
    print(call)
end

while effect("while", false) do
    break
end

repeat
    y -= 1
until effect("repeat", y <= 0)

for i = effect("start", 1), effect("limit", 2), effect("step", 1) do
    print(i)
end

for k, v in pairs({x, y}) do
    print(k, v)
end

return x, y