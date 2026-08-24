for i, v in ipairs({1, 2, 3, 4}) do
    if i == 2 then
        continue
    end
    print("keep", i, v)
end
print("after-continue")