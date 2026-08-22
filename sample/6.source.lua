local seed = 3

local function outer(n)
    local value = n + seed

    if value > 5 then
        value = value - 1
    else
        value = value + 2
    end

    while value < 8 do
        value = value + 1
    end

    local function inner(delta)
        if delta % 2 == 0 then
            return value + delta
        end

        return value - delta
    end

    local evenResult = inner(2)
    local oddResult = inner(3)
    return value, evenResult, oddResult
end

local value, evenResult, oddResult = outer(2)
print("theory", value, evenResult, oddResult)
