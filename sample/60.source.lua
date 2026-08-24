print("sample60-start")

-- empty / blank blocks
do
end

if false then
end

while false do
end

for i = 1, 0 do
end

for k, v in pairs({}) do
end

repeat
until true

-- locals, tables, member/index access
local total = 0
local data = { 10, 20, 30, 40 }
local dict = { a = 1, b = 2, c = 3 }
local obj = { value = 3 }
obj.extra = "field"
obj["indexed"] = 7

-- named functions + if / elseif / else + return
local function classify(x)
    if x < 0 then
        return "neg"
    elseif x == 0 then
        return "zero"
    else
        return "pos"
    end
end

-- closure + mutable captured upvalue
local function makeCounter(start)
    local value = start
    return function(step)
        value = value + step
        return value
    end
end

local counter = makeCounter(5)
print("class", classify(-1), classify(0), classify(1))
print("closure", counter(2), counter(3))

-- method definition / namecall
function obj:add(x)
    self.value = self.value + x
    return self.value
end

function obj:mul(x)
    return self.value * x
end

print("namecall", obj:add(2), obj:mul(3), obj.extra, obj.indexed)

-- numeric for + nested if/elseif/else + continue + break
for i = 1, 6 do
    if i == 2 then
        continue
    elseif i == 5 then
        break
    else
        total = total + i
    end

    if i % 2 == 0 then
        print("num-even", i, total)
    else
        print("num-odd", i, total)
    end
end

-- generic for: pairs + branch, deterministic final output
local pairSum = 0
for k, v in pairs(dict) do
    pairSum = pairSum + v
    if k == "b" then
        pairSum = pairSum + 10
    else
        pairSum = pairSum + 0
    end
end
print("pairs-sum", pairSum)

-- generic for: direct iterator triple
for i, v in next, data do
    if i == 2 then
        continue
    end
    print("next", i, v)
    if i == 3 then
        break
    end
end

-- while + nested block + continue/break
local w = 0
while w < 6 do
    w = w + 1
    do
        local inner = w * 10
        if w == 2 then
            continue
        elseif w == 5 then
            print("while-break", inner)
            break
        else
            print("while", w, inner)
        end
    end
end

-- repeat until
local r = 0
repeat
    r = r + 1
    print("repeat", r)
until r >= 3

-- nested loops
for outer = 1, 2 do
    local n = 0
    while n < 2 do
        n = n + 1
        for i, v in ipairs({ outer, n }) do
            print("nested", outer, n, i, v)
        end
    end
end

-- closure created inside generic-for, captures loop variables
for i, v in ipairs({ 2, 4, 6 }) do
    local function captured()
        return i + v + total
    end
    if i == 2 then
        print("capture-a", captured())
    else
        print("capture-b", captured())
    end
end

-- anonymous function + logical expressions
local choose = function(a, b, flag)
    return flag and a or b
end
print("logic", choose("yes", "no", true), (total > 0 and "positive" or "zero"))

print("sample60-end", total, w, r)
