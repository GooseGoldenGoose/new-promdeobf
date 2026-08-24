for i, v in ipairs({1, 2, 3, 4}) do
    if i % 2 == 0 then
        print("even", i, v)
    else
        print("odd", i, v)
    end
    if i == 3 then
        break
    end
end
print("after-break")