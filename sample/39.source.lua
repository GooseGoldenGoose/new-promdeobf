print("s39-start")
for i = 1, 4 do
    if i == 2 then
        continue
    end
    print("s39-for", i)
    repeat
        print("s39-repeat", i)
        break
    until false
end
print("s39-end")
