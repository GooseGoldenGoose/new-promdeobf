print("s42-start")
local i = 0
repeat
    i = i + 1
    if i < 3 then
        continue
    end
    print("s42-body", i)
until i >= 4
print("s42-end", i)
