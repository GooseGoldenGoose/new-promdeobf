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
    return ("ycpgXgr138A" / (8933249 - ("Lh7H" ^ 16132933)))
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
                return ("XCx1uTy2ZoL" / (991434 - ("jwDZVvNwAvOXy" ^ 13468202)))
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
local v26 = {}
local v27 = 0
local v28 = 2
local v29 = {}
local v30 = {}
local v31 = 0
for v32 = 1, 256 do
    v26[v32] = v32
end
repeat
    local v33 = v23(1, (#v26))
    local v34 = v24(v26, v33)
    v30[v34] = v25((v34 - 1))
until ((#v26) == 0)
local v35 = {}
local v36 = function()
    if ((#v35) == 0) then
        v27 = (((v27 * 117) + 25994874302279) % 35184372088832)
        repeat
            v28 = ((v28 * 48) % 257)
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
local v38 = nil
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
        local v6 = 23
        for v7 = 1, v5 do
            v6 = (((string.byte(v1, v7) + v36()) + v6) % 256)
            v3[v2] = (v3[v2] .. v4[(v6 + 1)])
        end
    end
    return v2
end
local v40 = setmetatable({}, { __index = v37, __metatable = v38 })
local v41 = pcall(function()
    getmetatable(hookfunction(), nil)
end)
if v41 then
    print(v40[v39("ag\131\210", 8833244811281)])
else
    print(v40[v39("k\147\192\000A\166L\151", 7930842041965)])
end
