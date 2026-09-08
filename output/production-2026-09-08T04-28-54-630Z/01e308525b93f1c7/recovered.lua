local v1 = true
local v2 = string.gmatch
local v3 = function()
    error("Tamper Detected!")
end
local v4 = false
local v5 = (pcall(function()
    v4 = true
end) and v4)
local v6 = math.random
local v7 = table.concat
local v8 = ((table and table.unpack) or unpack)
local v9 = v6(3, 65)
local v10 = 0
local v11 = 0
local v12 = { pcall(function()
    return ("EeZ9F6oTgFI" / (10680634 - ("aTNkiaPp" ^ 8841854)))
end) }
local v13 = v12[2]
local v14 = tonumber(v2(tostring(v13), ":(%d*):")())
for v15 = 1, v9 do
    local v16 = math.random(1, 100)
    local v17 = v6(0, 255)
    local v18 = v6(1, v16)
    local v19 = (v6(1, 2) == 1)
    local v20 = v13.gsub(v13, ":(%d*):", (":" .. (tostring(v6(0, 10000)) .. ":")))
    local v21 = { pcall(function()
        if ((v6(1, 2) == 1) or (v15 == v9)) then
            local v3 = tonumber(v2(tostring(({ pcall(function()
                return ("mQA0PiG" / (8633796 - ("xd9si8NSi" ^ 5142743)))
            end) })[2]), ":(%d*):")())
            v1 = (v1 and (v14 == v3))
        end
        if v19 then
            error(v20, 0)
        end
        local t1 = {}
        for v4 = 1, v16 do
            t1[v4] = v6(0, 255)
        end
        t1[v18] = v17
        return v8(t1)
    end) }
    if v19 then
        v1 = (v1 and ((v21[1] == false) and (v21[2] == v20)))
    else
        v1 = (v1 and v21[1])
        v10 = ((v10 + v21[(v18 + 1)]) % 256)
        v11 = ((v11 + v17) % 256)
    end
end
v1 = (v1 and (v10 == v11))
if v1 then
else
    repeat
        return (function()
            while true do
                l1, l2 = l2, l1
                v3()
            end
        end)()
    until true
end
local v22 = nil
local v23 = nil
local v24 = math.floor
local v25 = math.random
local v26 = table.remove
local v27 = {}
local v28 = string.char
local v29 = 0
local v30 = 2
local v31 = {}
local v32 = {}
local v33 = 0
for v34 = 1, 256 do
    v27[v34] = v34
end
repeat
    local v35 = v25(1, (#v27))
    local v36 = v26(v27, v35)
    v31[v36] = v28((v36 - 1))
until ((#v27) == 0)
local v37 = {}
local v38 = function()
    if ((#v37) == 0) then
        v29 = (((v29 * 13) + 32561706236729) % 35184372088832)
        repeat
            v30 = ((v30 * 154) % 257)
        until (v30 ~= 1)
        local v1 = (v30 % 32)
        local v2 = ((v24((v29 / (2 ^ (13 - ((v30 - v1) / 32))))) % 4294967296) / (2 ^ v1))
        local v3 = (v24(((v2 % 1) * 4294967296)) + v24(v2))
        local v4 = (v3 % 65536)
        local v5 = ((v3 - v4) / 65536)
        local v6 = (v4 % 256)
        local v7 = ((v4 - v6) / 256)
        local v8 = (v5 % 256)
        local v9 = ((v5 - v8) / 256)
        v37 = { v6, v7, v8, v9 }
    end
    return table.remove(v37)
end
local v39 = {}
v23 = setmetatable({}, { __index = v39, __metatable = nil })
v22 = function(v1, v2)
    local v3 = v39
    if v3[v2] then
    else
        v37 = {}
        local v4 = v31
        v29 = (v2 % 35184372088832)
        v30 = ((v2 % 255) + 2)
        local v5 = string.len(v1)
        v3[v2] = ""
        local v6 = 199
        for v7 = 1, v5 do
            v6 = (((string.byte(v1, v7) + v38()) + v6) % 256)
            v3[v2] = (v3[v2] .. v4[(v6 + 1)])
        end
    end
    return v2
end
local v40, v41 = pcall(function()
    return (not (not (package and (package[v23[v22("j)\196\197", 24008414620587)]] and ((#package[v23[v22("\196\229\205\148", 14758587308760)]]) > 0)))))
end)
local v42 = true
if (v40 and v41) then
    error(v23[v22("}\234\243Yj\244\017yc\030\226\246\029\014t\029\220\157\162E\137$@\237\240\185-\000\188\218\231", 30310341850914)], 0)
else
    print(v23[v22("\130\014\004", 32319985793738)])
end
local v43 = v41
