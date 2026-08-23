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
