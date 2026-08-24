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
    foo = function()
        return a
    end
    return foo()
end)() == 1)
assert((function()
    local a = 1
    foo = function()
        return function()
            return a
        end
    end
    return foo()()
end)() == 1)
assert((function()
    foo = function(a)
        return function()
            return a
        end
    end
    return foo(1)()
end)() == 1)
assert((function()
    foo = function()
        local f
        do
            local a = 1
            f = function()
                return a
            end
        end
        local b = 2
        return f
    end
    return foo()()
end)() == 1)
print('o')
assert((function()
    foo = function()
        local a = 1
        local function f()
            return a
        end
        a = 2
        return f
    end
    return foo()()
end)() == 2)
print('l')
assert((function()
    foo = function()
        local a = 1
        ;(function()
            a = 2
        end)()
        return a
    end
    return foo()
end)() == 2)
print('d')
assert((function()
    local t = {
        f = 5
    }
    function t:get()
        return (function()
            return self.f
        end)()
    end
    return t:get()
end)() == 5)
print('f')
assert((function()
    foo = function()
        local t = {
            f = 5
        }
        function t:get()
            return function()
                return self.f
            end
        end
        return t:get()
    end
    return foo()()
end)() == 5)
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
print("PASS")
