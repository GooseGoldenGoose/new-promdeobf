print("s41-start")
local i = 0
while i < 5 do
    i = i + 1
    if i % 2 == 0 then
        continue
    end
    print("s41-odd", i)
end
print("s41-end", i)
