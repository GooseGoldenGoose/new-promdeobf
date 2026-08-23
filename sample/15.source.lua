local g = 213

if not (math.random(1, 2) == 1) then
    g = 1
    print("C")
elseif math.random(1, 2) == 1 then
    g = 2
    print("G")
end

print(g)

if not (math.random(1, 2) == 1) then
    print("W")
elseif math.random(1, 2) == 1 then
    print("L")
    return
end
