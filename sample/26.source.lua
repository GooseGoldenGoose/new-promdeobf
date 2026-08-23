print("start")

for a = 1, 2, 1 do
    print("before-loop", a)
end

for i = 1, 3, 1 do
    print("outer", i)

    for j = 1, 2, 1 do
        if (i + j) % 2 == 0 then
            print("inner-even", i, j)
        else
            print("inner-odd", i, j)
        end
    end

    print("outer-end", i)
end

for k = 3, 1, -1 do
    print("after-loop", k)
end

print("done")
