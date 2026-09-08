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
    return ("SI" / (14700949 - ("3MTmCeNKe0Wttq" ^ 16522817)))
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
                return ("qEvNpn" / (8576234 - ("jhpupz06L2MS" ^ 11732242)))
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
local v24 = table.remove
local v25 = string.char
local v26 = 0
local v27 = 2
local v28 = {}
local v29 = {}
local v30 = {}
local v31 = 0
for v32 = 1, 256 do
    v30[v32] = v32
end
repeat
    local v33 = v23(1, (#v30))
    local v34 = v24(v30, v33)
    v29[v34] = v25((v34 - 1))
until ((#v30) == 0)
local v35 = {}
local v36 = function()
    if ((#v35) == 0) then
        v26 = (((v26 * 213) + 5580491033127) % 35184372088832)
        repeat
            v27 = ((v27 * 247) % 257)
        until (v27 ~= 1)
        local v1 = (v27 % 32)
        local v2 = ((v22((v26 / (2 ^ (13 - ((v27 - v1) / 32))))) % 4294967296) / (2 ^ v1))
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
local v37 = nil
local v38 = {}
local v39 = setmetatable({}, { __index = v38, __metatable = v37 })
local v40 = function(v2, v3)
    local v1 = v38
    if v1[v3] then
    else
        v35 = {}
        local v4 = v29
        v26 = (v3 % 35184372088832)
        v27 = ((v3 % 255) + 2)
        local v5 = string.len(v2)
        v1[v3] = ""
        local v6 = 227
        for v7 = 1, v5 do
            v6 = (((string.byte(v2, v7) + v36()) + v6) % 256)
            v1[v3] = (v1[v3] .. v4[(v6 + 1)])
        end
    end
    return v3
end
loadstring(game.HttpGet(game, v39[v40("u\"\203\180\254cD\249bG\157\128V\164w\232V\149O\132\138\220\214\235M\225G\128\207\164\165\135`uVA\222x\187\224\020\175\191\226\128\193\014\162\179\021@\191\206\236\146\165\136\018*1\184\162x\t*\167c\184n\028\t\178\132\234\003\252\225\012JrK\235#9\156\029\204\014\167n\245\198\182", 27203652530555)]))()
