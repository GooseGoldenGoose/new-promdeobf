for i, v in ipairs({2, 4, 6}) do
    local function add()
        return i + v
    end
    if i == 2 then
        print("cap-a", add())
    else
        print("cap-b", add())
    end
end