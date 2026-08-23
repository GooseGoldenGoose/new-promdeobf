local x = 1

do
    local x = 10
    local y = 2
    print("block", x, y)
end

local function inc(delta)
    x = x + delta
    return x
end

local function get()
    return x
end

print("before", get())
print("after", inc(2), get())
