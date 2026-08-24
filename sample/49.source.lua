local valid = true
local arr = { false, "ok" }
local msg = "ok"

for i = 1, 2 do
    valid = valid and arr[1] == false and arr[2] == msg
    print("i", i)
end

print("chain", valid)
