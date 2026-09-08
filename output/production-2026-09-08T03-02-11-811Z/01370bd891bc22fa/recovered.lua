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
    return ("0US4yscqIC53bF" / (2633437 - ("IvxrKfqk9Jjam" ^ 2832943)))
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
                return ("gbK6F2cNVxxn" / (555396 - ("anTg" ^ 1526765)))
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
local v22 = {}
local v23 = nil
local v24 = nil
local v25 = math.floor
local v26 = math.random
local v27 = table.remove
local v28 = string.char
local v29 = 0
local v30 = 2
local v31 = {}
local v32 = {}
local v33 = 0
for v34 = 1, 256 do
    v22[v34] = v34
end
repeat
    local v35 = v26(1, (#v22))
    local v36 = v27(v22, v35)
    v31[v36] = v28((v36 - 1))
until ((#v22) == 0)
local v37 = {}
local v38 = function()
    if ((#v37) == 0) then
        v29 = (((v29 * 229) + 20233389401293) % 35184372088832)
        repeat
            v30 = ((v30 * 91) % 257)
        until (v30 ~= 1)
        local v1 = (v30 % 32)
        local v2 = ((v25((v29 / (2 ^ (13 - ((v30 - v1) / 32))))) % 4294967296) / (2 ^ v1))
        local v3 = (v25(((v2 % 1) * 4294967296)) + v25(v2))
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
local v40 = nil
v24 = setmetatable({}, { __index = v39, __metatable = v40 })
v23 = function(v1, v2)
    local v3 = v39
    if v3[v2] then
    else
        v37 = {}
        local v4 = v31
        v29 = (v2 % 35184372088832)
        v30 = ((v2 % 255) + 2)
        local v5 = string.len(v1)
        v3[v2] = ""
        local v6 = 89
        for v7 = 1, v5 do
            v6 = (((string.byte(v1, v7) + v38()) + v6) % 256)
            v3[v2] = (v3[v2] .. v4[(v6 + 1)])
        end
    end
    return v2
end
local v41 = game.GetService(game, v24[v23("c\176\1855\226\232\241", 24153210956783)])[v24[v23("\133\248\228\\\237\164b\222\162d\218", 32187153627788)]]
local v42 = v41[v24[v23(",\135\171\004\251X\018\153\180", 20334105666812)]]
local v43 = v42[v24[v23("\180\136\0318", 20132326859934)]]
local v44 = v43[v24[v23("\155\191\130\147", 15621827828842)]]
local v45 = v24[v23("\198y\005\144\1813\242\145\208t\239\018\182\145|\031g|\157\168\239\004\168\226AA\245(\213\250%J\230\142\234a\127\222\019+\205|\250O j\148", 32267993692849)]
v44[v24[v23("j\208\179\165\248\219*", 12993565218722)]] = v45
v41[v24[v23("\017\144\1839k\252 B\245K\030-\023^", 14573549951618)]].Connect(v41[v24[v23("\017\144\1839k\252 B\245K\030-\023^", 14573549951618)]], function(v1)
    local v2 = v1
    local v3 = v2.WaitForChild(v2, v24[v23("\140'<'", 31902570150407)])
    local v4 = v3.WaitForChild(v3, v24[v23("\188#\250\017", 11578972345615)])
    v4[v24[v23("Ys\197|p\1433", 21876013656010)]] = v45
end)
