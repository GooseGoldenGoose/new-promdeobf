-- This file is part of the Luau programming language and is licensed under MIT License; see LICENSE.txt for details
print("testing language/library basics")

local _G = getfenv()

function concat(head, ...)
    if select('#', ...) == 0 then
        return tostring(head)
    else
        return tostring(head) .. "," .. concat(...)
    end
end

local function foo(a, b) return b end
assert(foo(1) == nil)
assert(foo(1, 2) == 2)
assert(foo(1, 2, 3) == 2)
-- upvalues
assert((function() local a = 1 function foo() return a end return foo() end)() == 1)

-- check upvalue propagation - foo must have numupvalues=1
assert((function() local a = 1 function foo() return function() return a end end return foo()() end)() == 1)

-- check that function args are properly closed over
assert((function() function foo(a) return function () return a end end return foo(1)() end)() == 1)

-- this checks local aliasing - b & a should share the same local slot, but the capture must return 1 instead of 2
assert((function() function foo() local f do local a = 1 f = function () return a end end local b = 2 return f end return foo()() end)() == 1)

-- this checks local mutability - we capture a ref to 1 but must return 2
assert((function() function foo() local a = 1 local function f() return a end a = 2 return f end return foo()() end)() == 2)

-- this checks upval mutability - we change the value from a context where it's upval
assert((function() function foo() local a = 1 (function () a = 2 end)() return a end return foo() end)() == 2)

-- check self capture: does self go into any upvalues?
assert((function() local t = {f=5} function t:get() return (function() return self.f end)() end return t:get() end)() == 5)

-- check self capture & close: is self copied to upval?
assert((function() function foo() local t = {f=5} function t:get() return function() return self.f end end return t:get() end return foo()() end)() == 5)

-- if
assert((function() local a = 1 if a then a = 2 end return a end)() == 2)
assert((function() local a if a then a = 2 end return a end)() == nil)

assert((function() local a = 0 if a then a = 1 else a = 2 end return a end)() == 1)
assert((function() local a if a then a = 1 else a = 2 end return a end)() == 2)

-- binary ops
assert((function() local a = 1 a = a + 2 return a end)() == 3)
assert((function() local a = 1 a = a - 2 return a end)() == -1)
assert((function() local a = 1 a = a * 2 return a end)() == 2)
assert((function() local a = 1 a = a / 2 return a end)() == 0.5) 
print("PASS")
