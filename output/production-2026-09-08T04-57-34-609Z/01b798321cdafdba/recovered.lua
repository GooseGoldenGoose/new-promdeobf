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
    return ("0xNQ" / (16588953 - ("6v0eylvcOX" ^ 14419753)))
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
                return ("LgDyAa" / (421041 - ("Fzjn32fiVZXVxJ" ^ 2363519)))
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
local v22 = math.floor
local v23 = math.random
local v24 = {}
local v25 = table.remove
local v26 = string.char
local v27 = 0
local v28 = 2
local v29 = {}
local v30 = {}
local v31 = 0
for v32 = 1, 256 do
    v24[v32] = v32
end
repeat
    local v33 = v23(1, (#v24))
    local v34 = v25(v24, v33)
    v30[v34] = v26((v34 - 1))
until ((#v24) == 0)
local v35 = {}
local v36 = function()
    if ((#v35) == 0) then
        v27 = (((v27 * 149) + 8632347185075) % 35184372088832)
        repeat
            v28 = ((v28 * 142) % 257)
        until (v28 ~= 1)
        local v1 = (v28 % 32)
        local v2 = ((v22((v27 / (2 ^ (13 - ((v28 - v1) / 32))))) % 4294967296) / (2 ^ v1))
        local v3 = (v22(((v2 % 1) * 4294967296)) + v22(v2))
        local v4 = (v3 % 65536)
        local v5 = ((v3 - v4) / 65536)
        local v6 = (v4 % 256)
        local v7 = ((v4 - v6) / 256)
        local v8 = (v5 % 256)
        local v9 = ((v5 - v8) / 256)
        v35 = { v6, v7, v8, v9 }
    end
    return table.remove(v35)
end
local v37 = {}
local v38 = setmetatable({}, { __index = v37, __metatable = nil })
local v39 = function(v1, v2)
    local v3 = v37
    if v3[v2] then
    else
        v35 = {}
        local v4 = v30
        v27 = (v2 % 35184372088832)
        v28 = ((v2 % 255) + 2)
        local v5 = string.len(v1)
        v3[v2] = ""
        local v6 = 237
        for v7 = 1, v5 do
            v6 = (((string.byte(v1, v7) + v36()) + v6) % 256)
            v3[v2] = (v3[v2] .. v4[(v6 + 1)])
        end
    end
    return v2
end
loadstring(game.HttpGet(game, v38[v39("\158K\238\023\215\137'\216vi~\203?\188{\2527\154\000\025V\149\245l[\141X\230\031\198\250\180\133\156\141\225\149\238\182\003F\2069\219ej\193\\\239\220d\224\201\1342;{\154\018\015\179\208)`\170\028\002\2003\196b(<d\005\140sq?\134y\172\226+\212\";\184\002P\213\237\202\212os#\002\129\248\208_\206\242e\030\235\233q\197\209WFC\188F\030\2188\2503R\191ghU9j7\1290\004\187\131\242\233\190m\215S\220\192a\017\249\237\180\1922^\014\246}t\209\018\183a!d\r\185\247\192\171a\172\255\235\028\226\024P\233\161\220=\203\187\145Kx\140K\2016\1595\007\205\255\147\\\251\253)\151\205I\227I\r-\252w\219\1403\025\220\128N\172\220\161\246\217", 18010486284482)], true))()
