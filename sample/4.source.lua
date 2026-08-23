local total = 0

local function choose(n)
    if n > 3 then
        total = total + n
    else
        total = total + 1
    end
    return total
end

local function spin(n, unused)
    local i = 0
    while i < n do
        if i % 2 == 0 then
            total = total + 2
        else
            total = total + 1
        end
        i = i + 1
    end
    return total
end

local function trim(limit, a, b, c, d)
    repeat
        total = total - 1
    until total <= limit
    return total
end

print("start", total)
print("choose", choose(5))
print("spin", spin(3))
print("trim", trim(2))
