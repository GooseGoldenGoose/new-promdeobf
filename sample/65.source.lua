local a = function()
    return 1
end

local b = function()
    return 2
end

while a() and b() do
    if math.random(1, 2) == 1 then
        break
    end
end
