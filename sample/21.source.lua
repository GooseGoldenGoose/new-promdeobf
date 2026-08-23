print("testing language/library basics")

local _G = getfenv()

concat = function(head, ...)
    if select("#", ...) == 0 then
        return tostring(head)
    else
        return tostring(head) .. "," .. concat(...)
    end
end

local function foo(a, b)
    return b
end

assert(foo(1) == nil)
assert(foo(1, 2) == 2)
assert(foo(1, 2, 3) == 2)

assert((function()
    local a = 1
    if a then
        a = 2
    end
    return a
end)() == 2)

assert((function()
    local a
    if a then
        a = 2
    end
    return a
end)() == nil)

assert((function()
    local a = 0
    if a then
        a = 1
    else
        a = 2
    end
    return a
end)() == 1)

assert((function()
    local a
    if a then
        a = 1
    else
        a = 2
    end
    return a
end)() == 2)

assert((function()
    local a = 1
    a = a + 2
    return a
end)() == 3)

assert((function()
    local a = 1
    a = a - 2
    return a
end)() == -1)

assert((function()
    local a = 1
    a = a * 2
    return a
end)() == 2)

assert((function()
    local a = 1
    a = a / 2
    return a
end)() == 0.5)

local g = {
    hee = 1,
    kuy = 2,
    tad = function()
        print("G")
    end
}

print("PASS", g)
