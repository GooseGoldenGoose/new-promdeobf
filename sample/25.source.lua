print("before")

do
    local x = 5
    print("outer-do", x)
end

for i = 1, 5, 1 do
    print("loop", i)

    do
        local doubled = i * 2
        print("inner-do", doubled)
    end

    if i % 2 == 0 then
        print("even", i)
    else
        print("odd", i)
    end

    print("after-if", i)
end

print("after")
