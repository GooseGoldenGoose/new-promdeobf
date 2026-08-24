local function customthing()
    local data = {4, 5, 6}
    local function iter(t, k)
        local n = (k or 0) + 1
        local v = t[n]
        if v ~= nil then
            return n, v
        end
    end
    return iter, data, nil
end

for i, v in customthing() do
    print("custom", i, v)
end