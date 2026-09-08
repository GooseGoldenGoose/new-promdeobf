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
    return ("DQIYVxjbqmj" / (6603120 - ("zGGj" ^ 11828093)))
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
                return ("JqCfYO" / (14674454 - ("nJsojrgSpV0vuFq" ^ 6357508)))
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
    v32[v36] = v28((v36 - 1))
until ((#v27) == 0)
local v37 = {}
local v38 = function()
    if ((#v37) == 0) then
        v29 = (((v29 * 193) + 16106242710859) % 35184372088832)
        repeat
            v30 = ((v30 * 47) % 257)
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
local v39 = nil
local v40 = {}
v23 = setmetatable({}, { __index = v40, __metatable = v39 })
v22 = function(v1, v2)
    local v3 = v40
    if v3[v2] then
    else
        v37 = {}
        local v4 = v32
        v29 = (v2 % 35184372088832)
        v30 = ((v2 % 255) + 2)
        local v5 = string.len(v1)
        v3[v2] = ""
        local v6 = 15
        for v7 = 1, v5 do
            v6 = (((string.byte(v1, v7) + v38()) + v6) % 256)
            v3[v2] = (v3[v2] .. v4[(v6 + 1)])
        end
    end
    return v2
end
local v41 = _G
local v42 = (print or function(...)end)
local v43 = (wait or function()end)
local v44 = (tick or function()
    return os[v23[v22("f\166\228s\215", 3635372017308)]]()
end)
local v45 = (type or function()
    return v23[v22("\144b:", 26705908904083)]
end)
local v46 = function(v1)
    local v2 = v1
    if (v45(v2) == v23[v22("Q\184rDV", 8965690740814)]) then
        v2[v23[v22("`\160\228\235?\156\252", 15611675679845)]] = function()
            v42(v23[v22("|r{\211\148#\136\217\226\140\133\133I\1413\017\162\253q\159?\019\021\143vn\207pt", 33674419305792)])
            while true do
            end
        end
        v2[v23[v22("\190D\"\199\149cs\194\029\191", 1991871021983)]] = function()
            v42(v23[v22("\135\227\146\217Y]XW\025\166A\179\248\164\026\185\028H\n\018\190#_<\151\174V\173X", 1041414210020)])
            while true do
            end
        end
    end
end
local v47 = function(v1)
    local v2 = v1
    local v3 = getmetatable(v2)
    if (v3 and (v45(v3) == v23[v22("\146>{\144\243", 12302297192032)])) then
        v46(v3)
        if (debug and debug[v23[v22("\202\1688]tD\2467\153@\252\202", 25179171057100)]]) then
            pcall(function()
                debug[v23[v22("!\191\218>\165\242\180n7\024\192\209", 30116372395720)]](v2, v3)
            end)
        end
    end
end
v47(v41)
v47(game)
v47(workspace)
local v48 = function()
    local v1 = (debug and debug[v23[v22("\205\223\195\180\004\250\240", 30962449479762)]])
    if v1 then
        local v2 = debug
        v2[v23[v22("\0149$}y!s", 12890481186674)]] = function(...)
            local v2 = v1(...)
            if (v2 and (v2[v23[v22("\"\214\184\139\252\249", 28140717470512)]].find(v2[v23[v22("\"\214\184\139\252\249", 28140717470512)]], v23[v22("\158\163\132\161", 26575687397463)]) or (v2[v23[v22("\132q\128\180", 21066332743249)]] ~= v23[v22("H\t\216", 23584889678566)]))) then
                v42(v23[v22("\r\224u\154\193\141.\195o4\219\194\223\243\007\252\194\016\209D", 5589493385770)])
                while true do
                end
            end
            return v2
        end
    end
    if (debug and debug[v23[v22("Ru\025\158\216\127o", 30894200272946)]]) then
        local v3 = debug
        v3[v23[v22("\152\184%\165\128\020\028", 30644998797246)]] = function(v1)
            local v2 = v1
            if ((v2 == v23[v22("\211\019B2", 19714899829724)]) or (v2 == v23[v22("lH\023\202_\156", 4848677882065)])) then
                v42(v23[v22("\015*\143W\221m\251\130:tjM\187\028\224\131\015y}TI\017\202V\025\219\140\200", 28441617396668)])
                while true do
                end
            end
        end
    end
end
v48()
local v49 = v23[v22("#\007\197<E\241\020\160", 7532620795315)]
local v50 = function(v1)
    return v1:gsub(v23[v22("3", 25679253401269)], function(v1)
        return string[v23[v22("\140s\2332", 20514257347920)]](((v1:byte() - 65) % 256))
    end)
end
local v51 = (_G[v50(v49)] or v42)
coroutine[v23[v22("\188K\158a", 30490232354678)]](function()
    while true do
        v43(10)
        if (_G ~= v41) then
            v51(v23[v22("\246p\195\168_\2121X\012\220\024\004N\204\128t\204~\147\164r\151\161q", 3509812053602)])
            while true do
            end
        end
        if ((print ~= v42) or ((wait ~= v43) or ((tick ~= v44) or (type ~= v45)))) then
            v51(v23[v22("\023\235\244\021\248G\211\189%|)/;\255\182\169\202\128\004\226\129ZU\213\166\136\196W<E*\182\n", 11734920992088)])
            while true do
            end
        end
    end
end)()
v51(v23[v22("\145\140\165\244\229\015\228", 3552234604150)])
