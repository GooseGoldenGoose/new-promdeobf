local function f(n)
    for i = 1, 5 do
        if i == n then
            return "ret", i
        end
        if i == 2 then
            continue
        end
        if i == 4 then
            break
        end
        print("s44-body", n, i)
    end
    return "done", n
end
print("s44-a", f(3))
print("s44-b", f(9))
