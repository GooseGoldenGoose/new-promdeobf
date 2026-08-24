local function whileReturn(n)
    local x = 0
    while x < n do
        x = x + 1
        if x == 3 then
            return "while", x
        end
    end
    return "while-done", x
end
local function forReturn(n)
    for i = 1, n do
        if i == 2 then
            return "for", i
        end
    end
    return "for-done", n
end
local function repeatReturn(n)
    local x = 0
    repeat
        x = x + 1
        if x == n then
            return "repeat", x
        end
    until x >= 5
    return "repeat-done", x
end
print(whileReturn(5))
print(forReturn(5))
print(repeatReturn(3))
