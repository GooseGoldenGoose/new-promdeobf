local g = 213

if not (math.random(1, 2) == 1) then
    g = 1
    print("C")
elseif math.random(1, 2) == 1 then
    g = 2
    print("G")
else
    g = 3
    print("E")
end

print(g)

if not (math.random(1, 2) == 1) then
    print("W")
elseif math.random(1, 2) == 1 then
    print("L")
    return
else
    print("Z")
end

print("done", g)
