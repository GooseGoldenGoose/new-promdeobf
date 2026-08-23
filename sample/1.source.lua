local base = 4

local function compute(n)
    local value = base + n

    if value > 6 then
        value = value * 2
    else
        value = value - 1
    end

    return value
end

print("baseline", compute(3), compute(1))
