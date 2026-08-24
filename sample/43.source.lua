print("s43-start")
for i = 1, 3 do
    local j = 0
    while true do
        j = j + 1
        if j == 2 then
            break
        end
        print("s43-inner", i, j)
    end
    if i == 2 then
        continue
    end
    print("s43-outer", i, j)
end
print("s43-end")
