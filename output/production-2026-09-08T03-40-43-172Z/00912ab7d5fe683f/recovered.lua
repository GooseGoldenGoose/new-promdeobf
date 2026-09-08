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
    return ("L8TGZTQRy2qP0" / (2214229 - ("kc5goFjLVhQVfD9" ^ 26420)))
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
                return ("wCVUQUq10yLqH" / (16174278 - ("x3yRYcskSStNg" ^ 832074)))
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
local v23 = math.floor
local v24 = math.random
local v25 = table.remove
local v26 = string.char
local v27 = 0
local v28 = 2
local v29 = {}
local v30 = {}
local v31 = 0
for v32 = 1, 256 do
    v22[v32] = v32
end
repeat
    local v33 = v24(1, (#v22))
    local v34 = v25(v22, v33)
    v30[v34] = v26((v34 - 1))
until ((#v22) == 0)
local v35 = {}
local v36 = function()
    if ((#v35) == 0) then
        v27 = (((v27 * 253) + 25667546656431) % 35184372088832)
        repeat
            v28 = ((v28 * 40) % 257)
        until (v28 ~= 1)
        local v1 = (v28 % 32)
        local v2 = ((v23((v27 / (2 ^ (13 - ((v28 - v1) / 32))))) % 4294967296) / (2 ^ v1))
        local v3 = (v23(((v2 % 1) * 4294967296)) + v23(v2))
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
local v38 = nil
local v39 = setmetatable({}, { __index = v37, __metatable = v38 })
local v40 = function(v2, v3)
    local v1 = v37
    if v1[v3] then
    else
        v35 = {}
        local v4 = v30
        v27 = (v3 % 35184372088832)
        v28 = ((v3 % 255) + 2)
        local v5 = string.len(v2)
        v1[v3] = ""
        local v6 = 152
        for v7 = 1, v5 do
            v6 = (((string.byte(v2, v7) + v36()) + v6) % 256)
            v1[v3] = (v1[v3] .. v4[(v6 + 1)])
        end
    end
    return v3
end
PROTECT_ID = v39[v40("tv\173\008\174u\210\222~\134hx\025Gh#\224Mk", 15270644849606)]
loadstring(game.HttpGet(game, v39[v40("\250{\n\135\024o\196\151\008\1751\021\250\157\228Z\024c\145\246>L!;T\143\231\221\202\226A\188j2\166Vg\217M\243\149E\1813I\143\173\245\2011C\011{0:\182\2496{\2437\169\236i>8\028^jb/\016\182\158\163\165\t\019\003\185\1726\183}\20807\138lB", 19013016560277)]))()
