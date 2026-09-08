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
    return ("V1wY3j" / (9287250 - ("B6E6kA3OW" ^ 9166592)))
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
                return ("3OUDzKa" / (7550264 - ("Cv" ^ 4718871)))
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
    v32[v36] = v28((v36 - 1))
until ((#v24) == 0)
local v37 = {}
local v38 = function()
    if ((#v37) == 0) then
        v29 = (((v29 * 105) + 21433972483835) % 35184372088832)
        repeat
            v30 = ((v30 * 218) % 257)
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
v22 = setmetatable({}, { __index = v39, __metatable = nil })
v23 = function(v1, v3)
    local v2 = v39
    if v2[v3] then
    else
        v37 = {}
        local v4 = v32
        v29 = (v3 % 35184372088832)
        v30 = ((v3 % 255) + 2)
        local v5 = string.len(v1)
        v2[v3] = ""
        local v6 = 213
        for v7 = 1, v5 do
            v6 = (((string.byte(v1, v7) + v38()) + v6) % 256)
            v2[v3] = (v2[v3] .. v4[(v6 + 1)])
        end
    end
    return v3
end
local v40 = game.GetService(game, ("HttpService"))
local v41 = game[("Players")][("LocalPlayer")]
local v42 = function()
    return ((syn and syn[("request")]) or (http_request or (request or ((http and http[("request")]) or nil))))
end
local v43 = function(v1)
    local v2 = v1
    local v3 = v42()
    if (not v3) then
        return nil, ("HTTP not supported")
    end
    local v4, v5 = pcall(function()
        return v3({ [("Url")] = v2, [("Method")] = ("GET") })
    end)
    if (v4 and (v5 and v5[("Body")])) then
        return v5[("Body")]
    end
    return nil, ("HTTP request failed")
end
local v44 = Instance[("new")](("ScreenGui"), v41.WaitForChild(v41, ("PlayerGui")))
v44[("Name")] = ("KSys")
local v45 = Instance[("new")](("Frame"), v44)
v45[("Size")] = UDim2[("new")](0, 380, 0, 450)
v45[("Position")] = UDim2[("new")](0.5, (-190), 0.5, (-225))
v45[("BackgroundColor3")] = Color3[("fromRGB")](255, 255, 255)
v45[("BorderSizePixel")] = 0
v45[("Active")] = true
v45[("Draggable")] = true
local v46 = Instance[("new")](("UICorner"), v45)
v46[("CornerRadius")] = UDim[("new")](0, 20)
local v47 = Instance[("new")](("UIStroke"), v45)
v47[("Thickness")] = 6
v47[("ApplyStrokeMode")] = Enum[("ApplyStrokeMode")][("Border")]
v47[("Color")] = Color3[("fromRGB")](85, 170, 255)
v47[("Transparency")] = 0
local v48 = { Color3[("fromRGB")](85, 170, 255), Color3[("fromRGB")](52, 152, 219), Color3[("fromRGB")](100, 149, 237), Color3[("fromRGB")](173, 216, 230), Color3[("fromRGB")](0, 191, 255), Color3[("fromRGB")](135, 206, 250) }
task[("spawn")](function()
    local v1 = 1
    while v45[("Parent")] do
        local v2 = ((v1 % (#v48)) + 1)
        local v3 = v48[v1]
        local v4 = v48[v2]
        for v5 = 0, 1, 0.02 do
            v47[("Color")] = Color3[("new")]((v3[("R")] + ((v4[("R")] - v3[("R")]) * v5)), (v3[("G")] + ((v4[("G")] - v3[("G")]) * v5)), (v3[("B")] + ((v4[("B")] - v3[("B")]) * v5)))
            task[("wait")](0.03)
        end
        v1 = v2
    end
end)
local v49 = Instance[("new")](("TextLabel"), v45)
v49[("Size")] = UDim2[("new")](1, 0, 0.12, 0)
v49[("Position")] = UDim2[("new")](0, 0, 0, 0)
v49[("Text")] = ("Key System")
v49[("BackgroundTransparency")] = 1
v49[("TextColor3")] = Color3[("fromRGB")](40, 40, 40)
v49[("Font")] = Enum[("Font")][("SourceSansBold")]
v49[("TextScaled")] = true
local v50 = Instance[("new")](("TextBox"), v45)
v50[("PlaceholderText")] = ("Enter Key Here!")
v50[("Size")] = UDim2[("new")](0.9, 0, 0.1, 0)
v50[("Position")] = UDim2[("new")](0.05, 0, 0.14, 0)
v50[("BackgroundColor3")] = Color3[("fromRGB")](240, 240, 240)
v50[("TextColor3")] = Color3[("fromRGB")](40, 40, 40)
v50[("Font")] = Enum[("Font")][("SourceSans")]
v50[("TextScaled")] = true
local v51 = Instance[("new")](("UICorner"), v50)
v51[("CornerRadius")] = UDim[("new")](0, 12)
local v52 = Instance[("new")](("TextLabel"), v45)
v52[("Size")] = UDim2[("new")](0.9, 0, 0.06, 0)
v52[("Position")] = UDim2[("new")](0.05, 0, 0.26, 0)
v52[("BackgroundTransparency")] = 1
v52[("Text")] = ("")
v52[("TextColor3")] = Color3[("fromRGB")](40, 40, 40)
v52[("Font")] = Enum[("Font")][("SourceSansBold")]
v52[("TextScaled")] = true
local v53 = function(v1, v2)
    v52[("Text")] = v1
    v52[("TextColor3")] = v2
end
local v54 = function(v1, v2)
    local v3 = Instance[("new")](("TextButton"), v45)
    v3[("Text")] = v1
    v3[("Size")] = UDim2[("new")](0.9, 0, 0.08, 0)
    v3[("Position")] = UDim2[("new")](0.05, 0, v2, 0)
    v3[("BackgroundColor3")] = Color3[("fromRGB")](230, 230, 230)
    v3[("TextColor3")] = Color3[("fromRGB")](40, 40, 40)
    v3[("Font")] = Enum[("Font")][("SourceSansBold")]
    v3[("TextScaled")] = true
    local v4 = Instance[("new")](("UICorner"), v3)
    v4[("CornerRadius")] = UDim[("new")](0, 12)
    return v3
end
local v55 = v54(("Check Key"), 0.35)
local v56 = v54(("Free With Ads"), 0.45)
local v57 = v54(("Work Ink Premium"), 0.55)
local v58 = v54(("Subscribe"), 0.65)
local v59 = v54(("Discord"), 0.75)
local v60 = Instance[("new")](("Frame"), v45)
v60[("Size")] = UDim2[("new")](0.9, 0, 0.1, 0)
v60[("Position")] = UDim2[("new")](0.05, 0, 0.87, 0)
v60[("BackgroundColor3")] = Color3[("fromRGB")](245, 245, 245)
local v61 = Instance[("new")](("UICorner"), v60)
v61[("CornerRadius")] = UDim[("new")](0, 12)
local v62 = Instance[("new")](("TextLabel"), v60)
v62[("Size")] = UDim2[("new")](1, (-10), 1, (-10))
v62[("Position")] = UDim2[("new")](0, 5, 0, 5)
v62[("BackgroundTransparency")] = 1
v62[("Text")] = ("")
v62[("TextColor3")] = Color3[("fromRGB")](40, 40, 40)
v62[("Font")] = Enum[("Font")][("SourceSansBold")]
v62[("TextScaled")] = true
v62[("TextWrapped")] = true
local v63 = function(v1, v2)
    v62[("Text")] = v1
    v62[("TextColor3")] = v2
end
local v64 = function()
    local v1, v2 = v43(("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua"))
    if v1 then
        local v3 = loadstring(v1)
        if v3 then
            task[("delay")](0.5, v3)
        end
    else
        v53(("⚠️ Script load fail"), Color3[("fromRGB")](200, 100, 100))
    end
end
v55[("MouseButton1Click")].Connect(v55[("MouseButton1Click")], function()
    local v1 = v50[("Text")].match(v50[("Text")], ("^%s*(.-)%s*$"))
    if (v1 == ("")) then
        return v53(("❌ Enter a key first!"), Color3[("fromRGB")](231, 76, 60))
    end
    v53(("🔍 Checking..."), Color3[("fromRGB")](52, 152, 219))
    local v2, v3 = v43((("https://work.ink/_api/v2/token/isValid/") .. v1))
    if (not v2) then
        return v53((("⚠️ ") .. (v3 or ("Error"))), Color3[("fromRGB")](200, 100, 100))
    end
    local v4, v5 = pcall(function()
        return v40:JSONDecode(v2)
    end)
    if (v4 and (v5 and v5[("valid")])) then
        v53(("✅ Key Valid!"), Color3[("fromRGB")](46, 204, 113))
        task[("delay")](1, function()
            v44:Destroy()
            v64()
        end)
    else
        v53(("❌ Invalid Key"), Color3[("fromRGB")](231, 76, 60))
    end
end)
v56[("MouseButton1Click")].Connect(v56[("MouseButton1Click")], function()
    setclipboard(("https://work.ink/21e5/5b8xlsw3"))
    v63(("📋 Free link copied!"), Color3[("fromRGB")](102, 204, 102))
end)
v57[("MouseButton1Click")].Connect(v57[("MouseButton1Click")], function()
    setclipboard(("https://work.ink/21e5/addmclee"))
    v63(("⚠️ You need to own Work Ink Premium to use this ⚠️"), Color3[("fromRGB")](255, 128, 128))
end)
v58[("MouseButton1Click")].Connect(v58[("MouseButton1Click")], function()
    setclipboard(("https://www.youtube.com/@CrepScripts"))
    v63(("📋 YouTube link copied!"), Color3[("fromRGB")](241, 196, 15))
end)
v59[("MouseButton1Click")].Connect(v59[("MouseButton1Click")], function()
    setclipboard(("https://discord.gg/Nga4tbbtY2"))
    v63(("📋 Discord link copied!"), Color3[("fromRGB")](155, 89, 182))
end)
