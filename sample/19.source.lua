local a = 10

local outer = function()
    local inner = function()
        a = a + 2
        return a
    end

    return inner()
end

print(outer())
print(outer())
print(a)
