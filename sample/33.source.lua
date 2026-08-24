print("nested-control-start")
for i = 1, 3 do
    local j = 0
    while j < 4 do
        j = j + 1
        if j == 2 then
            continue
        end
        if i == 2 and j == 3 then
            break
        end
        print("nested-control", i, j)
    end
    if i == 2 then
        continue
    end
    repeat
        print("nested-repeat", i)
        break
    until false
end
print("nested-control-end")
