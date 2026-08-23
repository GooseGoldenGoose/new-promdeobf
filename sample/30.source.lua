print("mixed-repeat-start")

local outer = 0
repeat
    outer = outer + 1
    print("outer-repeat", outer)

    for i = 1, 2 do
        if i == 1 then
            print("for-in-repeat-a", outer, i)
        else
            print("for-in-repeat-b", outer, i)
        end
    end

    do
        local w = 0
        while w < 2 do
            w = w + 1
            print("while-in-repeat", outer, w)
        end
    end
until outer >= 2

for k = 1, 2 do
    local inner = 0
    repeat
        inner = inner + 1
        do
            print("repeat-in-for", k, inner)
        end
    until inner >= 2
end

local q = 0
while q < 2 do
    q = q + 1
    local inner = 0
    repeat
        inner = inner + 1
        if inner == 1 then
            print("repeat-in-while-a", q, inner)
        else
            print("repeat-in-while-b", q, inner)
        end
    until inner >= 2
end

_REPEAT_CHECKS = 0
local function repeatDone(limit)
    _REPEAT_CHECKS = _REPEAT_CHECKS + 1
    return _REPEAT_CHECKS >= limit
end

repeat
    print("side-effect-repeat", _REPEAT_CHECKS)
until repeatDone(2)
print("side-effect-checks", _REPEAT_CHECKS)

local function helper(n)
    local c = 0
    repeat
        c = c + 1
        for j = 1, 2 do
            if (c + j) % 2 == 0 then
                print("helper-even", c, j)
            else
                print("helper-odd", c, j)
            end
        end
    until c >= n
    return c
end

print("helper-result", helper(2))
print("mixed-repeat-end")
