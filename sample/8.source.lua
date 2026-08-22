local keep = 10
keep = keep + 1
print("keep1", keep)

keep = nil
keep = 12
print("keep2", keep)

do
    local inner = 20
    inner = inner + 2
    print("inner", inner)
end

local after = 30
after = after + 3
print("after", after)

keep = keep + 4
print("keep3", keep)
