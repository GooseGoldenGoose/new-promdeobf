print("s40-start")
for i = 1, 3 do
    do
        local x = i * 10
        if i == 2 then
            continue
        end
        print("s40-do", i, x)
    end
    print("s40-after", i)
end
print("s40-end")
