print("break-start")
local x = 0
while x < 5 do
    x = x + 1
    print("break-while", x)
    if x == 3 then
        break
    end
end
for i = 1, 5 do
    print("break-for", i)
    if i == 2 then
        break
    end
end
local r = 0
repeat
    r = r + 1
    print("break-repeat", r)
    if r == 2 then
        break
    end
until r >= 5
print("break-end", x, r)
