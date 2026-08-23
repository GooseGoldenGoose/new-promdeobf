print("start")

local outer = 1
while outer <= 2 do
    print("while", outer)

    do
        local marker = outer * 10
        if outer % 2 == 0 then
            print("while-even", marker)
        else
            print("while-odd", marker)
        end
    end

    for i = 1, 2 do
        print("for-in-while", outer, i)
        if i == 1 then
            do
                local value = outer + i
                print("for-a", value)
            end
        else
            do
                local value = outer * i
                print("for-b", value)
            end
        end
    end

    outer = outer + 1
end

for j = 1, 2 do
    print("outer-for", j)
    local k = 1
    while k <= 2 do
        print("while-in-for", j, k)
        if (j + k) % 2 == 0 then
            print("nested-even", j, k)
        else
            print("nested-odd", j, k)
        end
        k = k + 1
    end
end

local function helper(n)
    local x = 1
    while x <= 2 do
        for y = 1, 2 do
            if y == 1 then
                print("helper-a", n, x, y)
            else
                print("helper-b", n, x, y)
            end
        end
        x = x + 1
    end
    return n + 10
end

print("helper", helper(5))
print("done")
