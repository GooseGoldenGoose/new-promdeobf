print("continue-start")
local total = 0
for i = 1, 5 do
    if i % 2 == 0 then
        continue
    end
    total = total + i
    print("continue-for", i, total)
end
local x = 0
while x < 5 do
    x = x + 1
    if x == 2 then
        continue
    end
    print("continue-while", x)
end
local r = 0
repeat
    r = r + 1
    if r == 2 then
        continue
    end
    print("continue-repeat", r)
until r >= 4
print("continue-end", total, x, r)
