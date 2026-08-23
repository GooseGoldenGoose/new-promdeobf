local a = 1
print(a)
if math.random(1, 2) == 1 then
    a = 2
end

if math.random(2, 3) == 3 then
    print(a)
    return
end

a = 3
print(a)
