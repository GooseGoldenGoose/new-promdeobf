local calls = 0

local function mark(value)
    calls = calls + 1
    return value
end

local valueOr = mark(false) or mark(true)
local valueAnd = mark(true) and mark(false)

if mark(false) or calls == 5 then
    print('if-or', valueOr, valueAnd, calls)
end

print('done', valueOr, valueAnd, calls)
