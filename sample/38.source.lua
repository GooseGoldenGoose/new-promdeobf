print("branch-heavy-start")
local x = 0
while x < 4 do
    x = x + 1
    if x % 2 == 0 then
        if x == 2 then
            print("while-a", x)
        else
            print("while-b", x)
        end
    else
        if x == 1 then
            print("while-c", x)
        else
            print("while-d", x)
        end
    end
    print("while-tail", x)
end
for i = 1, 4 do
    if i <= 2 then
        if i == 1 then
            print("for-a", i)
        else
            print("for-b", i)
        end
    else
        if i == 3 then
            print("for-c", i)
        else
            print("for-d", i)
        end
    end
    print("for-tail", i)
end
local r = 0
repeat
    r = r + 1
    if r == 1 then
        print("repeat-a", r)
    elseif r == 2 then
        print("repeat-b", r)
    else
        print("repeat-c", r)
    end
    print("repeat-tail", r)
until r >= 3
print("branch-heavy-end")
