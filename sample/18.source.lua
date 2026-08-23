local a = 123

local b = function()
    a = a + 1
    return true
end

print(b())
print(a)
