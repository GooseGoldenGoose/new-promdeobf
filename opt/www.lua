local r_v1_1 = true
local r_v1_2 = string.gmatch
local r_v1_3 = function()
    error("Tamper Detected!")
end
local r_v1_4 = false
local r_v4_2 = (pcall(function()
    r_v1_4 = true
end)) and r_v1_4
local r_v1_5 = math.random
local r_v1_6 = table.concat
local r_v4_5 = (table and (table.unpack)) or unpack
local r_v16_1 = function()
    return ("gWxUQQVtU2UhX" / (4051390 - ("jZ85I" ^ 12759468)))
end
local r_v14_2 = r_v4_5
local r_v4_6 = r_v1_5(3, 65)
local r_v13_4 = 0
local r_v15_4 = {
    pcall(r_v16_1)
}
local r_v12_3 = 0
r_v15_4 = {
    unpack(r_v15_4)
}
r_v16_1 = r_v15_4[2]
local r_v1_13 = tonumber
local r_v18_2 = tostring(r_v16_1)
local r_v4_10 = r_v1_13((r_v1_2(r_v18_2, ":(%d*):"))())
local r_v19_3 = r_v4_6
for r_v22_5 = 1, r_v19_3 do
    local r_v4_17 = 65
    local r_v4_18 = r_v1_5(0, 255)
    local r_v4_19 = r_v1_5(1, r_v4_17)
    local r_v26_2 = r_v1_5(1, 2)
    local r_v1_18 = r_v26_2 == 1
    local r_v29_2 = tostring(r_v1_5(0, 10000))
    local r_v28_2 = ":" .. (r_v29_2 .. ":")
    local r_v1_21 = r_v16_1:gsub(":(%d*):", r_v28_2)
    local r_v27_4 = {
        pcall(function()
            if ((r_v1_5(1, 2) == 1) or (r_v22_5 == r_v4_6)) then
                local r_v1_51 = tonumber
                local r_v3_21 = tostring
                local r_v9_40 = {
                    pcall(function()
                        return ("ot" / (6542067 - ("7kFWt74za" ^ 2646467)))
                    end)
                }
                local __beta_unused_return_1, r_v6_26 = unpack(r_v9_40)
                local r_v10_8 = r_v1_51((r_v1_2((r_v3_21(r_v6_26)), ":(%d*):"))())
                r_v1_1 = r_v1_1 and (r_v4_10 == r_v10_8)
            end
            if r_v1_18 then
                error(r_v1_21, 0)
            end
            local r_v10_11 = {}
            local r_v5_8 = r_v4_17
            for r_v2_19 = 1, r_v5_8 do
                r_v10_11[r_v2_19] = r_v1_5(0, 255)
            end
            r_v10_11[r_v4_19] = r_v4_18
            return r_v14_2(r_v10_11)
        end)
    }
    r_v27_4 = {
        unpack(r_v27_4)
    }
    if r_v1_18 then
        local r_v35_3 = r_v1_1
        local r_v4_24 = r_v35_3
        if r_v35_3 then
            local r_v31_2 = r_v27_4[1]
            local r_v29_3 = r_v31_2 == false
            local r_v35_5 = r_v29_3
            if r_v29_3 then
                local r_v31_6 = r_v27_4[2]
                r_v35_5 = r_v31_6 == r_v1_21
            end
            r_v4_24 = r_v35_5
        end
        r_v1_1 = r_v4_24
    else
        r_v1_1 = r_v1_1 and (r_v27_4[1])
        local r_v29_5 = r_v27_4[r_v4_19 + 1]
        r_v13_4 = (r_v13_4 + r_v29_5) % 256
        r_v12_3 = (r_v12_3 + r_v4_18) % 256
    end
end
r_v1_1 = r_v1_1 and (r_v13_4 == r_v12_3)
if r_v1_1 then
    local r_v8_30
    local r_v13_5 = {}
    local r_v2_3 = nil
    local r_v15_5 = {}
    local r_v3_5 = nil
    local r_v3_6 = math.floor
    local r_v3_7 = math.random
    local r_v8_8 = table.remove
    local r_v7_10 = string.char
    local r_v9_9 = 0
    local r_v9_10 = 2
    for r_v16_7 = 1, 256 do
        r_v15_5[r_v16_7] = r_v16_7
    end
    repeat
        local r_v17_11 = r_v8_8(r_v15_5, (r_v3_7(1, #r_v15_5)))
        r_v13_5[r_v17_11] = r_v7_10(r_v17_11 - 1)
        local r_v17_12 = #r_v15_5
        local r_v21_6 = 0
    until r_v17_12 == r_v21_6
    local r_v16_11 = {}
    local r_v17_13
    local r_v21_7 = function()
        if ((#r_v17_13) == 0) then
            r_v9_9 = ((r_v9_9 * 45) + 21402374792941) % 35184372088832
            repeat
                r_v9_10 = (r_v9_10 * 164) % 257
                local r_v2_30 = r_v9_10
                local r_v3_34 = 1
            until r_v2_30 ~= r_v3_34
            local r_v10_24 = r_v9_10 % 32
            local r_v9_42 = 2 ^ (13 - ((r_v9_10 - r_v10_24) / 32))
            local r_v6_28 = r_v3_6(r_v9_9 / r_v9_42)
            local r_v3_36 = r_v6_28 % 4294967296
            local r_v5_11 = 2 ^ r_v10_24
            local r_v2_32 = r_v3_36 / r_v5_11
            local r_v6_30 = r_v3_6((r_v2_32 % 1) * 4294967296)
            local r_v8_38 = r_v3_6(r_v2_32)
            local r_v3_37 = r_v6_30 + r_v8_38
            local r_v5_14 = r_v3_37 % 65536
            local r_v6_32 = (r_v3_37 - r_v5_14) / 65536
            local r_v8_40 = r_v5_14 % 256
            local r_v7_39 = (r_v5_14 - r_v8_40) / 256
            local r_v9_46 = r_v6_32 % 256
            local r_v14_39 = (r_v6_32 - r_v9_46) / 256
            r_v17_13 = {
                r_v8_40,
                r_v7_39,
                r_v9_46,
                r_v14_39
            }
        end
        return table.remove(r_v17_13)
    end
    r_v17_13 = r_v16_11
    local r_v24_11 = {}
    local r_v21_8 = {}
    r_v2_3 = setmetatable(r_v24_11, {
        ["__index"] = r_v21_8,
        ["__metatable"] = nil
    })
    r_v3_5 = function(r_v10_25, r_v2_33)
        local r_v3_38 = r_v21_8
        if not (r_v3_38[r_v2_33]) then
            r_v17_13 = {}
            local r_v5_15 = r_v13_5
            r_v9_9 = r_v2_33 % 35184372088832
            r_v9_10 = (r_v2_33 % 255) + 2
            local r_v7_43 = string.len(r_v10_25)
            r_v3_38[r_v2_33] = ""
            local r_v14_40 = r_v7_43
            local r_v8_44 = 28
            for r_v9_54 = 1, r_v14_40 do
                local r_v19_8 = string.byte(r_v10_25, r_v9_54)
                local r_v18_6 = r_v21_7()
                r_v8_44 = ((r_v19_8 + r_v18_6) + r_v8_44) % 256
                local r_v17_57 = r_v3_38[r_v2_33]
                local r_v20_9 = r_v5_15[r_v8_44 + 1]
                r_v3_38[r_v2_33] = r_v17_57 .. r_v20_9
            end
        end
        return r_v2_33
    end
    if (not game:IsLoaded()) then
        game.Loaded:Wait()
    end
    local r_v8_15 = game.Players.LocalPlayer
    if r_v8_15 then
        local r_v11_11 = game.Players
        local r_v9_16 = r_v11_11.LocalPlayer.Character
        local r_v8_16 = r_v9_16
        if r_v9_16 then
            local r_v14_14 = game.Players.LocalPlayer
            r_v8_16 = r_v14_14.PlayerGui
        end
    end
    repeat
        local r_v6_12 = task
        r_v6_12.wait()
        local r_v8_19 = game.Players.LocalPlayer
        local r_v3_13 = r_v8_19
        if r_v8_19 then
            local r_v11_18 = game.Players
            local r_v9_21 = r_v11_18.LocalPlayer.Character
            local r_v8_20 = r_v9_21
            if r_v9_21 then
                local r_v14_20 = game.Players.LocalPlayer
                r_v8_20 = r_v14_20.PlayerGui
            end
            r_v3_13 = r_v8_20
        end
    until r_v3_13
    if (not game:IsLoaded()) then
        game.Loaded:Wait()
    end
    task.wait(3)
    local r_v3_17 = 0
    while true do
        r_v8_30 = state
        local r_v9_25 = game.GameId
        if not ((r_v9_25 == 0) and (r_v3_17 < (5))) then
            break
        end
        task.wait(1)
        r_v3_17 = r_v3_17 + 1
    end
    local r_v14_26 = game.GameId
    local r_v9_28 = r_v14_26 == 1720936166
    r_v8_30 = r_v9_28
    if not r_v9_28 then
        local r_v12_30 = table.find({
            14657361824,
            5552815761,
            11574204578,
            4996049426,
            7785334488
        }, game.PlaceId)
        local r_v11_29 = r_v12_30 ~= nil
        local r_v9_29 = r_v11_29
        if not r_v11_29 then
            local r_v13_40 = (game:GetService("ReplicatedStorage")):FindFirstChild("Remotes")
            r_v9_29 = r_v13_40 ~= nil
        end
        r_v8_30 = r_v9_29
    end
    if (not r_v8_30) then
        local r_v7_26 = warn
        local r_v15_29 = tostring(game.PlaceId)
        local r_v21_28 = tostring(game.GameId)
        local r_v12_33 = " GameId: " .. r_v21_28
        r_v7_26("[ StarX ] Game verification failed! PlaceId: " .. r_v15_29 .. r_v12_33)
        return
    end
    local r_v7_27 = (syn and (syn.queue_on_teleport)) or (queue_on_teleport or (fluxus and (fluxus.queue_on_teleport)))
    if r_v7_27 then
        r_v7_27("        repeat task.wait() until game:IsLoaded()\n        task.wait(3)\n    ")
    end
    local r_v14_32 = os
    local r_v14_33 = r_v14_32.clock()
    local r_v11_40 = game:GetService("Players")
    local r_v13_49 = game:GetService("TweenService")
    local r_v12_49 = game:GetService("UserInputService")
    local r_v15_42 = game:GetService("RunService")
    game:GetService("Stats")
    local r_v17_48 = game:GetService("CoreGui")
    game:GetService("MarketplaceService")
    local r_v22_33 = game:GetService("HttpService")
    local r_v22_34 = r_v11_40.LocalPlayer
    while true do
        if not (not r_v22_34) then
            break
        end
        task.wait(0.5)
        r_v22_34 = r_v11_40.LocalPlayer
    end
    local r_v27_14 = CFrame.new(6.86415958, 92.437477099999995, (-1880.070069999999987), 0.916565478, (-0.00000000573387), (-0.399884641), (-0.000000005454222), 1, (-0.000000026840294), 0.399884641, 0.000000026781947, 0.916565478)
    local r_v31_15 = CFrame.new(2660.448730000000069, (-116.003501999999997), (-1679.466670000000022), 0.766720712, 0.000000046498485, (-0.641980827), 0.000000032351721, 1, 0.000000111067529, 0.641980827, (-0.000000105926958), 0.766720712)
    local r_v32_10 = CFrame.new((-2178.775389999999788), (-103.242355000000003), (-1633.089109999999891), 0.100230105, 0.000000019906882, 0.994964302, 0.000000002750261, 1, (-0.000000020284688), (-0.994964302), 0.000000004769547, 0.100230105)
    local r_v37_10 = CFrame.new(1343.529299999999921, (-329.710082999999997), (-10.2807779), (-0.971747994), (-0.00000001523955), (-0.236020952), (-0.000000004354283), 1, (-0.000000046641134), 0.236020952, (-0.000000044295724), (-0.971747994))
    local r_v41_11 = CFrame.new((-340.536224000000004), 95.613746599999999, (-1957.512210000000096), 0.787827313, 0.000000014483218, 0.615896165, (-0.000000041654648), 1, 0.000000029767111, (-0.615896165), (-0.00000004910628), 0.787827313)
    local r_v43_12 = CFrame.new((-2255.052729999999883), 5365.382319999999709, 286.556151999999997, (-0.0217900071), 0.000000055998747, (-0.999762595), (-0.000000061244016), 1, 0.00000005734687, 0.999762595, 0.000000062479067, (-0.0217900071))
    local r_v44_12 = CFrame
    local r_v44_13 = r_v44_12.new((-2727.029050000000097), 5433.812990000000354, (-459.582610999999986), 0.000000000000051, 0.000000010407228, 1, (-0.000000019248961), 1, (-0.000000010407228), (-1), (-0.000000019248961), 0.000000000000051)
    local r_v47_13 = CFrame.new((-2322.937739999999849), 5367.467770000000201, (-450.329376000000025), (-0.981341422), (-0.00000001467512), 0.192273185, (-0.00000001483777), 1, 0.000000000593948, (-0.192273185), (-0.000000002270039), (-0.981341422))
    local r_v25_22 = {
        ["W1_Orb"] = r_v27_14,
        ["W1_Infinite"] = r_v31_15,
        ["W1_Story"] = r_v32_10,
        ["W1_Tower"] = r_v37_10,
        ["W1_Tournament"] = r_v41_11,
        ["W2_Adventure"] = r_v43_12,
        ["W2_Infinite"] = r_v44_13,
        ["W2_Story"] = r_v47_13
    }
    local r_v25_23 = {
        "\224\184\149\224\184\185\224\185\137 X (Standard)",
        "\224\184\149\224\184\185\224\185\137 Y (Standard)",
        "\224\184\149\224\184\185\224\185\137 Z (Standard)",
        "\224\184\149\224\184\185\224\185\137 Gold",
        "Stardust: \224\185\130\224\184\129\224\184\132\224\184\185",
        "Stardust: \224\184\129\224\184\180\224\184\165\224\184\129\224\184\178\224\185\128\224\184\161\224\184\138",
        "Stardust: \224\185\130\224\184\154\224\184\163\224\184\165\224\184\181\224\185\136/\224\184\132\224\184\185\224\184\165\224\185\128\224\184\165\224\184\173\224\184\163\224\185\140",
        "Stardust: \224\184\151\224\184\177\224\184\153\224\184\136\224\184\180\224\185\130\224\184\163\224\185\136",
        "Stardust: \224\184\165\224\184\185\224\184\159\224\184\181\224\185\136/\224\184\173\224\184\180\224\184\136\224\184\180\224\185\130\224\184\129\224\184\176",
        "Stardust: \224\184\170\224\184\184\224\184\132\224\184\184\224\184\153\224\184\176"
    }
    local r_v29_27 = function(r_v10_26, r_v2_34)
        local r_v3_39 = {}
        local r_v1_68 = r_v10_26 .. r_v2_34
        local r_v8_45 = "(.-)" .. r_v2_34
        local r_v7_46 = r_v1_68.gmatch
        local r_v7_47 = {
            r_v7_46(r_v1_68, r_v8_45)
        }
        local r_v4_41 = r_v7_47[1]
        local r_v5_16 = r_v7_47[2]
        local r_v6_35 = r_v7_47[3]
        local r_v8_46 = r_v4_41
        while true do
            r_v6_35 = r_v8_46(r_v5_16, r_v6_35)
            if not r_v6_35 then
                break
            end
            r_v7_47 = r_v6_35
            local r_v9_56 = table
            r_v9_56.insert(r_v3_39, r_v7_47)
            r_v7_47 = nil
        end
        return r_v3_39
    end
    local r_v31_23 = function(r_v10_27)
        local r_v1_70 = CFrame.new
        local r_v2_37 = unpack
        local r_v5_18 = r_v22_33
        local r_v8_48 = "[" .. (r_v10_27 .. "]")
        local r_v7_51 = r_v5_18.JSONDecode
        return r_v1_70(r_v2_37(r_v7_51(r_v5_18, r_v8_48)))
    end
    local r_v33_30 = function(r_v10_28)
        local r_v2_38 = {}
        local r_v1_72 = pairs
        for r_v8_49, r_v7_52 in r_v1_72(r_v10_28) do
            local r_v9_60 = table
            r_v9_60.insert(r_v2_38, r_v8_49)
        end
        return r_v2_38
    end
    local r_v31_24
    r_v31_24 = function(r_v10_29)
        local r_v2_39 = {}
        local r_v6_41, r_v3_44, r_v5_20 = pairs(r_v10_29)
        while true do
            r_v5_20, r_v7_54 = r_v6_41(r_v3_44, r_v5_20)
            if not r_v5_20 then
                break
            end
            if (type(r_v7_54) == "table") then
                r_v7_54 = r_v31_24(r_v7_54)
            end
            r_v2_39[r_v5_20] = r_v7_54
            r_v7_54 = nil
        end
        return r_v2_39
    end
    local r_v34_29 = function(r_v10_30)
        local r_v2_40 = 0
        local r_v6_43, r_v3_45, r_v5_21 = pairs(r_v10_30)
        while true do
            r_v5_21 = r_v6_43(r_v3_45, r_v5_21)
            if not r_v5_21 then
                break
            end
            r_v2_40 = r_v2_40 + 1
        end
        return r_v2_40
    end
    local r_v33_31 = {
        ["n"] = 0.000001,
        ["m"] = 0.001,
        ["k"] = 1000,
        ["M"] = 1000000,
        ["G"] = 1000000000
    }
    local r_v41_35 = function(r_v10_31, r_v2_41)
        local r_v4_50 = r_v10_31.R
        local r_v3_47 = r_v10_31.G
        local r_v5_24 = r_v10_31.B
        local r_v1_82 = {
            r_v4_50,
            r_v3_47,
            r_v5_24
        }
        local r_v4_51 = r_v2_41.R
        local r_v5_26 = r_v2_41.G
        local r_v14_54 = 18251206369586
        local r_v6_49 = r_v2_41.B
        local r_v3_48 = r_v1_82
        local r_v5_27 = {
            r_v4_51,
            r_v5_26,
            r_v6_49
        }
        local r_v6_50 = {}
        local r_v4_53, r_v8_59, r_v7_62 = ipairs(r_v5_27)
        local r_v9_72 = r_v4_53
        for r_v14_54, r_v11_56 in r_v9_72, r_v8_59, r_v7_62 do
            if (r_v3_48[r_v14_54] == r_v11_56) then
                table.insert(r_v6_50, true)
            else
                table.insert(r_v6_50, false)
            end
        end
        local r_v8_60 = table
        if r_v8_60.find(r_v6_50, false) then
            return false
        end
        return true
    end
    local r_v39_37 = function(r_v10_32)
        local r_v2_42 = r_v10_32:sub((-1))
        if r_v33_31[r_v2_42] then
            local r_v3_50 = tonumber(r_v10_32.sub(r_v10_32, 1, (-2)))
            local r_v4_57 = r_v33_31[r_v2_42]
            return (r_v3_50 * r_v4_57)
        end
        if tonumber(r_v10_32) then
            return tonumber(r_v10_32)
        end
        return 0
    end
    local r_v41_36 = "laos_v3"
    local r_v40_42 = nil
    local r_v40_43 = {}
    if (not isfolder("StarHub")) then
        makefolder("StarHub")
    end
    if (not isfolder("StarHub/ASTD")) then
        makefolder("StarHub/ASTD")
    end
    if (not isfolder("StarHub/ASTD/Settings")) then
        makefolder("StarHub/ASTD/Settings")
    end
    local r_v47_43 = r_v22_34.UserId
    local r_v40_50 = "StarHub/ASTD/Settings/" .. (r_v47_43 .. ".json")
    local r_v40_51 = "StarHub/ASTD/MapTracker.json"
    local r_v49_44 = r_v22_34.UserId
    local r_v40_52 = "StarHub/ASTD/Settings/" .. (r_v49_44 .. "_LifetimeStats.json")
    local r_v40_53 = {
        ["TotalGems"] = 0,
        ["TotalGold"] = 0,
        ["TotalStardust"] = 0,
        ["TotalRuns"] = 0,
        ["TotalPlayTime"] = 0
    }
    if isfile(r_v40_52) then
        pcall(function()
            r_v40_53 = r_v22_33:JSONDecode(readfile(r_v40_52))
        end)
    else
        local r_v38_44 = r_v22_33
        writefile(r_v40_52, r_v38_44.JSONEncode(r_v38_44, r_v40_53))
    end
    local r_v49_53 = function()
        local r_v2_45 = r_v22_33
        writefile(r_v40_52, r_v2_45.JSONEncode(r_v2_45, r_v40_53))
    end
    local r_v49_54 = {
        ["-1"] = "REGULAR",
        ["-1.7"] = "REGULAR (2)",
        ["-1.1"] = "Category x Girls",
        ["-1.3"] = "AIR",
        ["-1.8"] = "SOLO",
        ["-1.9"] = "RANDOM UNIT",
        ["-1.5"] = "Double Path",
        ["-97"] = "Gauntlet",
        ["-98"] = "Training",
        ["-99"] = "Farm"
    }
    local r_v49_55 = {
        ["-13"] = "String Raid",
        ["-1003"] = "Sijin Raid",
        ["-1004"] = "Spirit Raid",
        ["-1111"] = "Marine HQ",
        ["-1112"] = "Kai Planet",
        ["-1113"] = "Hell",
        ["-1114"] = "Machi Planet",
        ["-1117"] = "Candy Raid",
        ["-1118"] = "Demon Mark Raid",
        ["-1121"] = "Soul Raid",
        ["-1122"] = "Sun Raid",
        ["-1125"] = "Meteor Raid",
        ["-1127"] = "Berserker Raid",
        ["-1128"] = "Venom Raid",
        ["-1129"] = "Dueled Raid",
        ["-1132"] = "Hunt On Blacksmith",
        ["-1133"] = "Mythical Freedom",
        ["-1134"] = "Bizare Prison",
        ["-1136"] = "Six Eyes Raid",
        ["-1142"] = "TOP1",
        ["-1143"] = "TOP2",
        ["-1144"] = "TOP3",
        ["-1145"] = "TOP4",
        ["-1146"] = "TOP5",
        ["-1147"] = "TOP6",
        ["-1155"] = "Demon Raid M2",
        ["-1156"] = "Divine Raid",
        ["-1450"] = "Random Boss Rush",
        ["-1451"] = "Random Boss Rush 2",
        ["-1506"] = "Path Raid",
        ["-1550"] = "Enuma Raid",
        ["-1168"] = "Demon Memory Raid",
        ["-1167"] = "Ocean Memory Raid",
        ["-1166"] = "Earth Tournament Memory Raid",
        ["-1165"] = "Purple Planet Raid",
        ["-1164"] = "Darkness Raid",
        ["-1163"] = "Malevolent Raid",
        ["-1162"] = "Crystal Cavern Raid"
    }
    local r_v49_56 = {
        ["\224\185\128\224\184\130\224\184\181\224\184\162\224\184\167 (Green)"] = 5763719,
        ["\224\185\129\224\184\148\224\184\135 (Red)"] = 15548997,
        ["\224\184\153\224\185\137\224\184\179\224\185\128\224\184\135\224\184\180\224\184\153 (Blue)"] = 3447003,
        ["\224\184\161\224\185\136\224\184\167\224\184\135 (Purple)"] = 10181046,
        ["\224\184\151\224\184\173\224\184\135/\224\185\128\224\184\171\224\184\165\224\184\183\224\184\173\224\184\135 (Gold)"] = 16766720,
        ["\224\184\170\224\185\137\224\184\161 (Orange)"] = 15105570,
        ["\224\184\138\224\184\161\224\184\158\224\184\185 (Pink)"] = 15277667,
        ["\224\184\130\224\184\178\224\184\167 (White)"] = 16777215,
        ["\224\184\148\224\184\179 (Black)"] = 0
    }
    local r_v49_57 = {
        "\224\185\128\224\184\130\224\184\181\224\184\162\224\184\167 (Green)",
        "\224\185\129\224\184\148\224\184\135 (Red)",
        "\224\184\153\224\185\137\224\184\179\224\185\128\224\184\135\224\184\180\224\184\153 (Blue)",
        "\224\184\161\224\185\136\224\184\167\224\184\135 (Purple)",
        "\224\184\151\224\184\173\224\184\135/\224\185\128\224\184\171\224\184\165\224\184\183\224\184\173\224\184\135 (Gold)",
        "\224\184\170\224\185\137\224\184\161 (Orange)",
        "\224\184\138\224\184\161\224\184\158\224\184\185 (Pink)",
        "\224\184\130\224\184\178\224\184\167 (White)",
        "\224\184\148\224\184\179 (Black)"
    }
    local r_v51_45 = Color3.fromRGB(255, 60, 60)
    local r_v52_42 = Color3.fromRGB(60, 255, 60)
    local r_v57_35 = Color3.fromRGB(60, 60, 255)
    local r_v59_30 = Color3.fromRGB(180, 60, 255)
    local r_v61_26 = Color3.fromRGB(255, 255, 60)
    local r_v63_24 = Color3.fromRGB(255, 150, 60)
    local r_v65_23 = Color3.fromRGB(255, 100, 180)
    local r_v67_21 = Color3.fromRGB(60, 255, 255)
    local r_v69_18 = Color3.fromRGB(255, 255, 255)
    local r_v71_15 = Color3.fromRGB(30, 30, 30)
    local r_v49_58 = {
        ["\224\185\129\224\184\148\224\184\135 (Red)"] = r_v51_45,
        ["\224\185\128\224\184\130\224\184\181\224\184\162\224\184\167 (Green)"] = r_v52_42,
        ["\224\184\153\224\185\137\224\184\179\224\185\128\224\184\135\224\184\180\224\184\153 (Blue)"] = r_v57_35,
        ["\224\184\161\224\185\136\224\184\167\224\184\135 (Purple)"] = r_v59_30,
        ["\224\185\128\224\184\171\224\184\165\224\184\183\224\184\173\224\184\135 (Yellow)"] = r_v61_26,
        ["\224\184\170\224\185\137\224\184\161 (Orange)"] = r_v63_24,
        ["\224\184\138\224\184\161\224\184\158\224\184\185 (Pink)"] = r_v65_23,
        ["\224\184\159\224\185\137\224\184\178 (Cyan)"] = r_v67_21,
        ["\224\184\130\224\184\178\224\184\167 (White)"] = r_v69_18,
        ["\224\184\148\224\184\179 (Black)"] = r_v71_15
    }
    local r_v49_59 = {
        "\224\185\129\224\184\148\224\184\135 (Red)",
        "\224\185\128\224\184\130\224\184\181\224\184\162\224\184\167 (Green)",
        "\224\184\153\224\185\137\224\184\179\224\185\128\224\184\135\224\184\180\224\184\153 (Blue)",
        "\224\184\161\224\185\136\224\184\167\224\184\135 (Purple)",
        "\224\185\128\224\184\171\224\184\165\224\184\183\224\184\173\224\184\135 (Yellow)",
        "\224\184\170\224\185\137\224\184\161 (Orange)",
        "\224\184\138\224\184\161\224\184\158\224\184\185 (Pink)",
        "\224\184\159\224\185\137\224\184\178 (Cyan)",
        "\224\184\130\224\184\178\224\184\167 (White)",
        "\224\184\148\224\184\179 (Black)"
    }
    local r_v55_53 = Enum.Font.Gotham
    local r_v56_54 = Enum.Font.GothamBold
    local r_v58_52 = Enum.Font.SciFi
    local r_v60_48 = Enum.Font.Arcade
    local r_v62_45 = Enum.Font.Cartoon
    local r_v64_41 = Enum.Font.Code
    local r_v66_39 = Enum.Font.PatrickHand
    local r_v68_34 = Enum.Font.Jura
    local r_v70_30 = Enum.Font.Oswald
    local r_v49_60 = {
        ["Gotham (\224\184\148\224\184\177\224\185\137\224\184\135\224\185\128\224\184\148\224\184\180\224\184\161)"] = r_v55_53,
        ["Gotham Bold"] = r_v56_54,
        ["Sci-Fi (\224\184\173\224\184\153\224\184\178\224\184\132\224\184\149)"] = r_v58_52,
        ["Arcade (\224\185\128\224\184\129\224\184\161\224\184\149\224\184\185\224\185\137)"] = r_v60_48,
        ["Cartoon (\224\184\129\224\184\178\224\184\163\224\185\140\224\184\149\224\184\185\224\184\153)"] = r_v62_45,
        ["Code (\224\185\129\224\184\174\224\184\129\224\185\128\224\184\129\224\184\173\224\184\163\224\185\140)"] = r_v64_41,
        ["Patrick Hand (\224\184\165\224\184\178\224\184\162\224\184\161\224\184\183\224\184\173)"] = r_v66_39,
        ["Jura (\224\185\130\224\184\161\224\185\128\224\184\148\224\184\180\224\184\163\224\185\140\224\184\153)"] = r_v68_34,
        ["Oswald (\224\184\151\224\184\178\224\184\135\224\184\129\224\184\178\224\184\163)"] = r_v70_30
    }
    local r_v49_61 = {
        "Gotham (\224\184\148\224\184\177\224\185\137\224\184\135\224\185\128\224\184\148\224\184\180\224\184\161)",
        "Gotham Bold",
        "Sci-Fi (\224\184\173\224\184\153\224\184\178\224\184\132\224\184\149)",
        "Arcade (\224\185\128\224\184\129\224\184\161\224\184\149\224\184\185\224\185\137)",
        "Cartoon (\224\184\129\224\184\178\224\184\163\224\185\140\224\184\149\224\184\185\224\184\153)",
        "Code (\224\185\129\224\184\174\224\184\129\224\185\128\224\184\129\224\184\173\224\184\163\224\185\140)",
        "Patrick Hand (\224\184\165\224\184\178\224\184\162\224\184\161\224\184\183\224\184\173)",
        "Jura (\224\185\130\224\184\161\224\185\128\224\184\148\224\184\180\224\184\163\224\185\140\224\184\153)",
        "Oswald (\224\184\151\224\184\178\224\184\135\224\184\129\224\184\178\224\184\163)"
    }
    local r_v49_62 = {
        "W3Octo",
        "Speedwagon",
        "Bulma (Super Money Corp)",
        "Hoshino",
        "Daydayfarm"
    }
    local r_v56_60 = function(r_v10_35)
        local r_v2_46 = {}
        local r_v4_68, r_v3_53, r_v5_31 = pairs(r_v10_35)
        local r_v6_55 = r_v4_68
        for r_v8_63, r_v7_68 in r_v6_55, r_v3_53, r_v5_31 do
            local r_v9_74 = table
            r_v9_74.insert(r_v2_46, r_v7_68)
        end
        return r_v2_46
    end
    local r_v67_38 = {
        "attack",
        "range"
    }
    local r_v63_50 = {
        ["Mode"] = "Box",
        ["Checks"] = r_v67_38,
        ["Ability Type"] = "Normal",
        ["Time"] = 13
    }
    local r_v61_57 = {
        ["Brook6"] = r_v63_50
    }
    local o_v6_10 = {}
    local r_v56_61 = {
        ["version"] = r_v41_36,
        ["auto_buff"] = true,
        ["auto_buff_units"] = r_v61_57,
        ["auto_vote_extreme"] = false,
        ["auto_vote_normal"] = false,
        ["auto_2x"] = false,
        ["auto_3x"] = false,
        ["macro_profile"] = "Default Profile",
        ["macro_record"] = false,
        ["macro_playback"] = false,
        ["macro_record_time_offset"] = 0,
        ["macro_money_tracking"] = false,
        ["macro_playback_time_offset"] = 0,
        ["macro_magnitude"] = 1.5,
        ["macro_playback_search_attempts"] = 150,
        ["macro_playback_search_delay"] = 1,
        ["macro_summon"] = true,
        ["macro_sell"] = true,
        ["macro_upgrade"] = true,
        ["macro_ability"] = true,
        ["macro_auto_ability"] = true,
        ["macro_priority"] = true,
        ["macro_skipwave"] = true,
        ["macro_autoskipwave"] = true,
        ["macro_speedchange"] = true,
        ["macro_ability_blacklist"] = o_v6_10,
        ["macro_timer_version"] = "\224\185\128\224\184\167\224\184\165\224\184\178\224\184\149\224\184\178\224\184\161\224\185\128\224\184\167\224\184\159(\224\185\129\224\184\153\224\184\176\224\184\153\224\184\179)",
        ["action_queue_remote_fire_delay"] = 0.25,
        ["action_queue_remote_on_fail"] = true,
        ["action_queue_remote_on_fail_delay"] = 1,
        ["action_queue_remote_on_fail_delay_loop"] = 0.5,
        ["smart_auto_next"] = false,
        ["auto_replay"] = false,
        ["auto_next_story"] = false,
        ["auto_farm_enable"] = false,
        ["auto_farm_unit"] = "Speedwagon",
        ["auto_farm_upgrade_wave"] = 15,
        ["auto_upgrade"] = false,
        ["auto_upgrade_money"] = 100,
        ["auto_upgrade_wave_stop"] = 100,
        ["auto_upgrade_sell"] = false,
        ["auto_upgrade_wave"] = 0,
        ["auto_upgrade_wave_sell"] = 100,
        ["auto_sell_blacklist"] = "Speedwagon, Bulma (Super Money Corp), W3Octo, Hoshino, Daydayfarm",
        ["auto_join_game"] = false,
        ["auto_join_tower"] = false,
        ["auto_join_delay"] = 5,
        ["auto_join_mode"] = "Infinite",
        ["auto_join_story_level"] = 1,
        ["auto_join_infinite_level"] = "-1.7",
        ["auto_join_trial_level"] = 1,
        ["auto_join_raid_level"] = 1,
        ["auto_join_challenge_level"] = 1,
        ["auto_join_bout_level"] = 1,
        ["auto_join_adventure_level"] = "-1133",
        ["auto_join_w3_level"] = 1,
        ["auto_evolve_exp"] = false,
        ["auto_skip_gui"] = true,
        ["webhook_url"] = "",
        ["webhook_image_url"] = "",
        ["webhook_discord_id"] = "",
        ["webhook_user_name"] = true,
        ["webhook_color"] = "FF8700",
        ["webhook_ping_user"] = false,
        ["webhook_end_game"] = false,
        ["webhook_exp_evolve"] = false,
        ["webhook_win_color"] = "\224\185\128\224\184\130\224\184\181\224\184\162\224\184\167 (Green)",
        ["webhook_lose_color"] = "\224\185\129\224\184\148\224\184\135 (Red)",
        ["webhook_summon_url"] = "",
        ["anti_afk"] = true,
        ["disable_3d_rendering"] = false,
        ["auto_battle"] = false,
        ["auto_battle_gems"] = 20,
        ["fps_cap"] = 0,
        ["auto_hide_ui"] = false,
        ["auto_hide_delay"] = 15,
        ["anonymous_mode"] = true,
        ["anonymous_mode_name"] = "StarHuBUser",
        ["rainbow_anon_name"] = false,
        ["anon_use_gradient"] = true,
        ["anon_color1"] = "\224\185\129\224\184\148\224\184\135 (Red)",
        ["anon_color2"] = "\224\184\153\224\185\137\224\184\179\224\185\128\224\184\135\224\184\180\224\184\153 (Blue)",
        ["ui_width"] = 500,
        ["ui_height"] = 300,
        ["custom_bg_url"] = "",
        ["custom_logo_url"] = "",
        ["toggle_img_url"] = "",
        ["custom_hub_title"] = "LARB HUB",
        ["logo_size"] = 56,
        ["toggle_size"] = 50,
        ["bg_transparency"] = 45,
        ["ui_font"] = "Gotham Bold",
        ["theme_main_r"] = 20,
        ["theme_main_g"] = 20,
        ["theme_main_b"] = 22,
        ["theme_element_r"] = 30,
        ["theme_element_g"] = 30,
        ["theme_element_b"] = 35,
        ["theme_accent_r"] = 255,
        ["theme_accent_g"] = 60,
        ["theme_accent_b"] = 60,
        ["auto_change_macro_map"] = false,
        ["stop_max_runs_enable"] = false,
        ["stop_max_runs"] = 10,
        ["current_runs"] = 0,
        ["stop_item_drop_enable"] = false,
        ["stop_item_name"] = "",
        ["custom_spawn_enable"] = false,
        ["custom_spawn_cframe"] = "",
        ["auto_target_boss"] = false,
        ["auto_target_boss_unit"] = "",
        ["auto_target_boss_condition"] = "\224\185\128\224\184\161\224\184\183\224\185\136\224\184\173\224\184\154\224\184\173\224\184\170\224\185\128\224\184\129\224\184\180\224\184\148",
        ["air_unit_first"] = false,
        ["air_unit_name"] = "",
        ["auto_skill_boss"] = false,
        ["auto_skill_boss_count"] = 1,
        ["auto_skill_boss_unit"] = "",
        ["auto_skill_boss_mode"] = "Normal",
        ["auto_skill_boss_multi_index"] = 1,
        ["auto_skill_boss_trigger_condition"] = "\224\184\129\224\184\148\224\184\151\224\184\177\224\184\153\224\184\151\224\184\181 (\224\185\132\224\184\161\224\185\136\224\184\170\224\184\153\224\184\161\224\184\173\224\184\153\224\184\173\224\184\183\224\185\136\224\184\153)",
        ["auto_skill_boss_target_amount"] = "\224\184\129\224\184\148\224\184\151\224\184\184\224\184\129\224\184\149\224\184\177\224\184\167\224\184\151\224\184\181\224\185\136\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129",
        ["auto_specific_upgrade"] = false,
        ["specific_upgrade_unit"] = "",
        ["specific_upgrade_level"] = 1,
        ["webhook_kill_enable"] = false,
        ["webhook_kill_target"] = 5000,
        ["current_kills"] = 0,
        ["auto_summon_enable"] = false,
        ["auto_summon_banner"] = "\224\184\149\224\184\185\224\185\137 X (Standard)",
        ["auto_summon_amount"] = 1,
        ["auto_claim_tasks"] = false
    }
    if (not pcall(function()
        readfile(r_v40_50)
    end)) then
        local r_v60_64 = r_v22_33
        writefile(r_v40_50, r_v60_64.JSONEncode(r_v60_64, r_v56_61))
    end
    if (not pcall(function()
        r_v40_42 = r_v22_33:JSONDecode(readfile(r_v40_50))
    end)) then
        local r_v60_66 = r_v22_33
        writefile(r_v40_50, r_v60_66.JSONEncode(r_v60_66, r_v56_61))
        r_v40_42 = r_v56_61
    end
    local r_v60_68 = {}
    local r_v62_66 = {}
    local r_v64_55 = {}
    local r_v66_52 = {}
    local r_v58_70 = {
        ["Macro"] = r_v60_68,
        ["Units"] = r_v62_66,
        ["Map"] = r_v64_55,
        ["Settings"] = r_v66_52
    }
    local r_v62_68 = r_v31_24(r_v58_70)
    local r_v58_71 = {
        ["Default Profile"] = r_v62_68
    }
    local r_v62_70 = r_v22_34.UserId
    local r_v60_70 = "StarHub/ASTD/" .. r_v62_70
    if (not isfolder(r_v60_70)) then
        makefolder(r_v60_70)
    end
    if ((#listfiles(r_v60_70)) == 0) then
        local r_v63_65 = r_v60_70 .. "/Default Profile.json"
        local r_v64_63 = r_v22_33
        writefile(r_v63_65, r_v64_63.JSONEncode(r_v64_63, r_v58_71))
    end
    local r_v60_75 = pairs
    local r_v66_59 = {
        listfiles(r_v60_70)
    }
    for r_v60_76, r_v66_60 in r_v60_75(unpack(r_v66_59)) do
        pcall(function()
            local r_v10_38 = readfile
            local r_v3_55 = r_v66_60
            r_v10_38 = r_v22_33:JSONDecode(r_v10_38(r_v3_55))
            local r_v4_78, r_v2_51, r_v3_56 = pairs(r_v10_38)
            local r_v5_33 = r_v4_78
            for r_v6_56, r_v8_65 in r_v5_33, r_v2_51, r_v3_56 do
                if (r_v40_43[r_v6_56] ~= nil) then
                    delfile(r_v66_60)
                else
                    r_v40_43[r_v6_56] = r_v8_65
                end
            end
        end)
    end
    if (r_v34_29(r_v40_43) == 0) then
        local r_v63_69 = r_v60_70 .. "/Default Profile.json"
        local r_v64_66 = r_v22_33
        writefile(r_v63_69, r_v64_66.JSONEncode(r_v64_66, r_v58_71))
        r_v40_43["Default Profile"] = r_v31_24(r_v58_70)
    end
    local r_v60_81 = {}
    local r_v60_82 = pairs
    local r_v66_66 = r_v40_43
    for r_v60_82, r_v66_67 in r_v60_82(r_v66_66) do
        table.insert(r_v60_81, r_v60_82)
    end
    table.sort(r_v60_81)
    if (r_v40_43[r_v40_42.macro_profile] == nil) then
        r_v40_42.macro_profile = r_v60_81[#r_v60_81]
    end
    Save = function()
        local r_v2_52 = r_v22_33
        writefile(r_v40_50, r_v2_52.JSONEncode(r_v2_52, r_v40_42))
        local r_v5_35 = {
            pairs(r_v40_43)
        }
        local r_v2_53 = r_v5_35[3]
        local r_v10_40 = r_v5_35[2]
        local r_v3_59 = r_v5_35[1]
        for r_v5_35, r_v6_59 in r_v3_59, r_v10_40, r_v2_53 do
            local r_v8_66 = {}
            r_v8_66[r_v5_35] = r_v6_59
            local r_v11_59 = "/" .. (r_v5_35 .. ".json")
            local r_v9_79 = r_v60_70 .. r_v11_59
            local r_v14_59 = r_v22_33
            writefile(r_v9_79, r_v14_59.JSONEncode(r_v14_59, r_v8_66))
        end
    end
    local r_v60_87 = pairs
    for r_v60_87, r_v66_74 in r_v60_87(r_v56_61) do
        if (r_v40_42[r_v60_87] == nil) then
            r_v40_42[r_v60_87] = r_v66_74
        end
    end
    r_v40_42.version = r_v41_36
    Save()
    local r_v65_74 = Color3.fromRGB(r_v40_42.theme_main_r or 20, r_v40_42.theme_main_g or 20, r_v40_42.theme_main_b or 22)
    local r_v67_66 = Color3.fromRGB(15, 15, 17)
    local r_v69_62 = Color3.fromRGB(10, 10, 12)
    local r_v71_50 = Color3.fromRGB(r_v40_42.theme_element_r or 30, r_v40_42.theme_element_g or 30, r_v40_42.theme_element_b or 35)
    local r_v73_42 = Color3.fromRGB(r_v40_42.theme_accent_r or 255, r_v40_42.theme_accent_g or 60, r_v40_42.theme_accent_b or 60)
    local r_v75_34 = Color3.fromRGB(250, 250, 250)
    local r_v77_30 = Color3.fromRGB(180, 180, 180)
    local r_v79_25 = Color3.fromRGB(45, 45, 50)
    local r_v60_90 = {
        ["MainBg"] = r_v65_74,
        ["SidebarBg"] = r_v67_66,
        ["TopbarBg"] = r_v69_62,
        ["ElementBg"] = r_v71_50,
        ["Accent"] = r_v73_42,
        ["Text"] = r_v75_34,
        ["SubText"] = r_v77_30,
        ["Outline"] = r_v79_25
    }
    local r_v64_84 = Instance.new("ScreenGui")
    r_v64_84.Name = "StarHub_Notifications"
    r_v64_84.Parent = r_v17_48
    local r_v66_89 = Enum.ZIndexBehavior
    r_v64_84.ZIndexBehavior = r_v66_89.Sibling
    local r_v65_85 = Instance.new("Frame", r_v64_84)
    r_v65_85.Size = UDim2.new(0, 300, 1, (-20))
    r_v65_85.Position = UDim2.new(1, (-320), 0, 10)
    r_v65_85.BackgroundTransparency = 1
    local r_v66_97 = Instance.new("UIListLayout", r_v65_85)
    local r_v68_90 = Enum.SortOrder
    r_v66_97.SortOrder = r_v68_90.LayoutOrder
    local r_v68_92 = Enum.VerticalAlignment
    r_v66_97.VerticalAlignment = r_v68_92.Bottom
    local r_v68_95 = UDim.new(0, 10)
    local r_v67_92 = function(r_v10_41, r_v2_54, r_v3_60)
        r_v3_60 = r_v3_60 or 5
        task.spawn(function()
            local r_v1_899 = Instance.new
            local r_v10_387 = "Frame"
            r_v10_387 = r_v1_899(r_v10_387, r_v65_85)
            r_v10_387.Size = UDim2.new(1, 0, 0, 70)
            r_v10_387.BackgroundColor3 = r_v60_90.MainBg
            r_v10_387.BackgroundTransparency = 1
            local r_v4_892 = Instance.new("UICorner", r_v10_387)
            r_v4_892.CornerRadius = UDim.new(0, 8)
            local r_v1_905 = Instance.new
            local r_v2_640 = "UIStroke"
            r_v2_640 = r_v1_905(r_v2_640, r_v10_387)
            r_v2_640.Color = r_v60_90.Accent
            r_v2_640.Thickness = 1.5
            r_v2_640.Transparency = 1
            local r_v1_909 = Instance.new
            local r_v3_644 = "TextLabel"
            r_v3_644 = r_v1_909(r_v3_644, r_v10_387)
            r_v3_644.Size = UDim2.new(1, (-20), 0, 25)
            r_v3_644.Position = UDim2.new(0, 10, 0, 5)
            r_v3_644.BackgroundTransparency = 1
            r_v3_644.Text = r_v10_41
            r_v3_644.TextColor3 = r_v60_90.Accent
            local r_v5_777 = Enum.Font
            r_v3_644.Font = r_v5_777.GothamBold
            r_v3_644.TextSize = 14
            local r_v5_780 = Enum.TextXAlignment
            r_v3_644.TextXAlignment = r_v5_780.Left
            r_v3_644.TextTransparency = 1
            local r_v1_919 = Instance.new
            local r_v5_784 = "TextLabel"
            r_v5_784 = r_v1_919(r_v5_784, r_v10_387)
            r_v5_784.Size = UDim2.new(1, (-20), 0, 35)
            r_v5_784.Position = UDim2.new(0, 10, 0, 30)
            r_v5_784.BackgroundTransparency = 1
            r_v5_784.Text = r_v2_54
            r_v5_784.TextColor3 = r_v60_90.Text
            local r_v6_905 = Enum.Font
            r_v5_784.Font = r_v6_905.Gotham
            r_v5_784.TextSize = 12
            local r_v6_908 = Enum.TextXAlignment
            r_v5_784.TextXAlignment = r_v6_908.Left
            local r_v6_910 = Enum.TextYAlignment
            r_v5_784.TextYAlignment = r_v6_910.Top
            r_v5_784.TextWrapped = true
            r_v5_784.TextTransparency = 1
            local r_v8_958 = TweenInfo.new(0.3)
            ;(r_v13_49:Create(r_v10_387, r_v8_958, {
                ["BackgroundTransparency"] = 0.1
            })):Play()
            local r_v8_960 = TweenInfo.new(0.3)
            local r_v6_916 = {
                ["Transparency"] = 0
            }
            ;(r_v13_49:Create(r_v2_640, r_v8_960, r_v6_916)):Play()
            local r_v8_962 = TweenInfo.new(0.3)
            ;(r_v13_49:Create(r_v3_644, r_v8_962, {
                ["TextTransparency"] = 0
            })):Play()
            local r_v8_964 = TweenInfo.new(0.3)
            ;(r_v13_49:Create(r_v5_784, r_v8_964, {
                ["TextTransparency"] = 0
            })):Play()
            task.wait(r_v3_60)
            local r_v8_967 = TweenInfo.new(0.3)
            ;(r_v13_49:Create(r_v10_387, r_v8_967, {
                ["BackgroundTransparency"] = 1
            })):Play()
            local r_v8_969 = TweenInfo.new(0.3)
            ;(r_v13_49:Create(r_v2_640, r_v8_969, {
                ["Transparency"] = 1
            })):Play()
            local r_v8_970 = TweenInfo
            local r_v8_971 = r_v8_970.new(0.3)
            ;(r_v13_49:Create(r_v3_644, r_v8_971, {
                ["TextTransparency"] = 1
            })):Play()
            local r_v8_973 = TweenInfo.new(0.3)
            ;(r_v13_49:Create(r_v5_784, r_v8_973, {
                ["TextTransparency"] = 1
            })):Play()
            task.wait(0.3)
            r_v10_387:Destroy()
        end)
    end
    r_v66_97.Padding = r_v68_95
    pcall(function()
        if setfpscap then
            if (r_v40_42.fps_cap == 0) then
                setfpscap(9999)
            else
                setfpscap(r_v40_42.fps_cap)
            end
        end
    end)
    local r_v68_99 = getgenv()
    r_v68_99.IsAutoBuffClicking = false
    local r_v67_96 = r_v22_34
    local r_v69_99 = r_v67_96:WaitForChild("PlayerGui", 9000000000)
    local r_v70_90 = function()
        local r_v10_49 = {
            ["14657361824"] = (-2),
            ["5552815761"] = (-1),
            ["11574204578"] = 0,
            ["4996049426"] = 1,
            ["7785334488"] = 2
        }
        local r_v4_91 = tostring
        local r_v3_67 = game.PlaceId
        local r_v1_122 = r_v10_49[r_v4_91(r_v3_67)]
        return r_v1_122
    end
    local r_v69_100
    local r_v72_64 = function()
        local r_v4_95 = game:GetService("ReplicatedStorage")
        if r_v4_95.FindFirstChild(r_v4_95, "SpeedUP") then
            local r_v2_67 = game:GetService("ReplicatedStorage")
            local r_v1_127 = r_v2_67.SpeedUP.Value
            return r_v1_127
        end
        return 1
    end
    local r_v71_75 = function()
        local r_v3_73 = r_v69_100()
        local r_v10_55 = r_v3_73 ~= (-1)
        local r_v4_97 = r_v10_55
        if r_v10_55 then
            local r_v3_74 = r_v69_100()
            r_v4_97 = r_v3_74 ~= (-2)
        end
        if r_v4_97 then
            local r_v1_129 = game.ReplicatedStorage
            if r_v1_129.FindFirstChild(r_v1_129, "Lobby") then
                local r_v10_60 = game.ReplicatedStorage
                local r_v1_131 = r_v10_60.Lobby.Value
                return r_v1_131
            end
        end
        return nil
    end
    r_v69_100 = r_v70_90
    local r_v73_53 = function(r_v10_62, r_v2_78)
        local r_v3_81 = 0
        local r_v5_54 = 0.1
        while true do
            if r_v3_81 >= r_v10_62 then
                break
            end
            if (not r_v2_78) then
                break
            end
            local r_v8_86 = r_v72_64()
            local r_v4_103 = r_v5_54 * r_v8_86
            r_v3_81 = r_v3_81 + r_v4_103
            local r_v6_82 = task
            r_v6_82.wait(r_v5_54)
        end
        r_v10_62 = nil
        r_v2_78 = nil
    end
    local r_v74_49 = function()
        local r_v10_63 = {}
        local r_v1_138 = pairs
        local r_v8_92 = game:GetService("Workspace")
        local r_v5_55 = r_v8_92.Unit
        local r_v4_106, r_v2_79, r_v3_82 = r_v1_138(r_v5_55.GetChildren(r_v5_55))
        local r_v5_57 = r_v4_106
        for r_v6_87, r_v8_95 in r_v5_57, r_v2_79, r_v3_82 do
            local r_v14_71 = r_v8_95:FindFirstChild("Owner")
            local r_v9_91 = r_v14_71 ~= nil
            local r_v7_90 = r_v9_91
            if r_v9_91 then
                local r_v11_71 = tostring(r_v8_95.Owner.Value)
                local r_v14_73 = r_v67_96.Name
                r_v7_90 = r_v11_71 == r_v14_73
            end
            if r_v7_90 then
                local r_v7_91 = table
                r_v7_91.insert(r_v10_63, r_v8_95)
            end
        end
        return r_v10_63
    end
    local r_v74_50 = nil
    local r_v75_38 = nil
    local r_v76_34 = nil
    if (not r_v71_75()) then
        local r_v78_32 = r_v67_96.Backpack:WaitForChild("Framework", 15)
        if r_v78_32 then
            r_v74_50 = require(r_v78_32.WaitForChild(r_v78_32, "CachedStats", 5))
        else
            warn("[ StarX ] Failed to find Backpack.Framework!")
        end
        local r_v76_43 = (game:GetService("ReplicatedStorage")):WaitForChild("Framework", 15)
        if r_v76_43 then
            r_v75_38 = require(r_v76_43.WaitForChild(r_v76_43, "OrbsV2Client", 5))
            r_v76_34 = require(r_v76_43.WaitForChild(r_v76_43, "DataFolderClient", 5))
        else
            warn("[ StarX ] Failed to find ReplicatedStorage.Framework!")
        end
    end
    local r_v78_33 = function(r_v10_64)
        local r_v2_80 = r_v74_50 and (r_v74_50.getstat(r_v10_64))
        local r_v4_107 = r_v2_80 or ({})
        return r_v4_107
    end
    local r_v93_11 = function()
        local r_v1_141 = "N/A"
        pcall(function()
            local r_v6_935 = r_v69_99.TowerPassRewards.Main
            local r_v3_645 = r_v6_935.Page.Main
            local r_v4_973 = r_v3_645.Top.CurrentTierBox.Tier
            r_v1_141 = r_v4_973.Text
            local r_v10_391 = string.match(r_v1_141, "%d+")
            if r_v10_391 then
                r_v1_141 = r_v10_391
            end
        end)
        return r_v1_141
    end
    local r_v95_11 = function(r_v10_67)
        local r_v4_112, r_v2_84, r_v3_85 = pairs(r_v10_67)
        local r_v5_62 = r_v4_112
        for r_v6_91, r_v8_97 in r_v5_62, r_v2_84, r_v3_85 do
            local r_v9_98 = r_v8_97:FindFirstChild("Head")
            local r_v7_94 = r_v9_98
            if r_v9_98 then
                r_v9_98 = r_v8_97.Head
                r_v7_94 = r_v9_98:FindFirstChild("EffectBBGUI")
            end
            if r_v7_94 then
                local r_v14_83 = r_v7_94:FindFirstChild("Frame")
                r_v9_98 = r_v14_83
                if r_v14_83 then
                    r_v9_98 = r_v7_94.Frame:FindFirstChild("AttackImage")
                end
                local r_v11_82 = not r_v9_98
                local r_v14_85 = r_v11_82
                if not r_v11_82 then
                    local r_v13_91 = r_v9_98.Visible
                    r_v14_85 = not r_v13_91
                end
                if r_v14_85 then
                    return false
                else
                    r_v9_98 = nil
                    r_v7_94 = nil
                end
            else
                return false
            end
        end
        return true
    end
    local r_v90_10 = function()
        local r_v10_68 = r_v76_34 and (r_v76_34.Get("StardustStone"))
        return (r_v10_68 or 0)
    end
    local r_v87_11 = function()
        local r_v3_91 = (game:GetService("ReplicatedStorage")):FindFirstChild("WaveValue")
        local r_v10_69 = r_v3_91
        if r_v3_91 then
            local r_v5_69 = game.ReplicatedStorage.WaveValue
            r_v10_69 = r_v5_69.Value
        end
        return (r_v10_69 or 0)
    end
    local r_v98_10
    local r_v85_13 = function(r_v10_70)
        local r_v8_105 = r_v78_33(r_v10_70)
        local r_v5_70 = r_v8_105.Upgrade
        local r_v2_89 = r_v5_70
        if r_v5_70 then
            local r_v7_104 = r_v78_33(r_v10_70)
            local r_v6_101 = r_v7_104.Upgrade
            r_v2_89 = #r_v6_101
        end
        return (r_v2_89 or 1)
    end
    local r_v80_27 = function(r_v10_71)
        local r_v2_92 = (r_v69_99:FindFirstChild("HUD")) and ((r_v69_99.HUD:FindFirstChild("BottomFrame")) and (r_v69_99.HUD.BottomFrame:FindFirstChild("Unit")))
        if r_v2_92 then
            local r_v8_115 = r_v2_92.GetChildren
            local r_v4_118, r_v3_99, r_v5_75 = pairs(r_v8_115(r_v2_92))
            local r_v6_112 = r_v4_118
            for r_v8_117, r_v7_111 in r_v6_112, r_v3_99, r_v5_75 do
                if (r_v7_111.ClassName == "Frame") then
                    local r_v9_115 = "Unit"
                    r_v9_115 = r_v7_111:FindFirstChild(r_v9_115)
                    local r_v14_104 = r_v9_115
                    if r_v9_115 then
                        local r_v13_104 = r_v9_115.Value
                        r_v14_104 = r_v13_104 == r_v10_71
                    end
                    if r_v14_104 then
                        return r_v7_111
                    else
                        r_v9_115 = nil
                    end
                end
            end
        end
        return nil
    end
    local r_v89_11 = function()
        local r_v10_72 = r_v76_34 and (r_v76_34.Get("Gold"))
        return (r_v10_72 or 0)
    end
    local r_v88_10 = function()
        local r_v10_73 = r_v76_34 and (r_v76_34.Get("Gems"))
        return (r_v10_73 or 0)
    end
    local r_v84_15 = function(r_v10_74, r_v2_97)
        local r_v3_104 = r_v78_33(r_v10_74)
        local r_v4_122 = r_v3_104 and ((r_v3_104.Upgrade) and (r_v3_104.Upgrade[r_v2_97]))
        if r_v4_122 then
            local r_v4_123 = r_v3_104.Upgrade[r_v2_97]
            local r_v5_82 = "Cost"
            r_v5_82 = r_v4_123[r_v5_82]
            local r_v6_120 = r_v80_27(r_v10_74)
            if (r_v6_120 ~= nil) then
                local r_v8_127 = r_v2_3
                r_v8_127 = r_v6_120:FindFirstChild("ID")
                if ((r_v8_127 ~= nil) and r_v75_38) then
                    local r_v1_168 = r_v75_38.GetAssignedOrbForUnit
                    local r_v7_124 = r_v8_127.Value
                    r_v7_124 = r_v1_168(r_v7_124)
                    if (r_v7_124 ~= nil) then
                        local r_v9_128 = "getOrbStat"
                        r_v9_128 = r_v74_50[r_v9_128](r_v7_124)
                        local r_v14_117 = r_v9_128 ~= nil
                        local r_v4_134 = r_v14_117
                        if r_v14_117 then
                            local r_v11_114 = r_v9_128.InitialPercentageCost
                            r_v4_134 = r_v11_114 ~= nil
                        end
                        if r_v4_134 then
                            local r_v4_135 = r_v9_128.InitialPercentageCost
                            r_v5_82 = r_v5_82 * r_v4_135
                        end
                    end
                end
            end
            return r_v5_82
        end
        return 0
    end
    local r_v83_19 = function(r_v10_75)
        local r_v5_83 = r_v78_33(r_v10_75)
        local r_v2_98 = r_v5_83.Cost
        r_v2_98 = r_v2_98 or 0
        local r_v3_108 = 0
        local r_v5_84 = r_v80_27(r_v10_75)
        if (r_v5_84 == nil) then
            if r_v75_38 then
                local r_v6_125 = r_v75_38.GetAssignedOrbForUnit(r_v10_75)
                if (r_v6_125 ~= nil) then
                    local r_v8_134 = r_v74_50.getOrbStat(r_v6_125)
                    if (r_v8_134 ~= nil) then
                        if (r_v8_134.InitialCost ~= nil) then
                            r_v3_108 = r_v8_134.InitialCost
                        end
                        if (r_v8_134.InitialPercentageCost ~= nil) then
                            local r_v9_142 = r_v8_134.InitialPercentageCost
                            r_v2_98 = r_v2_98 * r_v9_142
                        end
                    end
                end
            end
            return (r_v2_98 - r_v3_108)
        end
        local r_v6_123 = (r_v5_84:FindFirstChild("ImageLabel")) and (r_v5_84.ImageLabel:FindFirstChild("TextLabel"))
        if (r_v6_123 ~= nil) then
            r_v2_98 = r_v39_37(r_v6_123.Text)
        end
        return r_v2_98
    end
    local r_v94_10 = function()
        if (not r_v71_75()) then
            local r_v2_99 = game.ReplicatedStorage
            local r_v10_80 = r_v2_99.Remotes.Server:InvokeServer("Mission")
            return (#r_v10_80)
        end
        return 204
    end
    local r_v91_11 = function()
        local r_v1_176 = 0
        pcall(function()
            local r_v2_650 = game:GetService("ReplicatedStorage")
            r_v1_176 = r_v2_650.Remotes.Server:InvokeServer("Data", "GauntletTokens")
        end)
        local r_v3_114 = tonumber(r_v1_176)
        return (r_v3_114 or 0)
    end
    local o_v1_10 = function(r_v10_82, r_v2_105, r_v3_115)
        local r_v1_178 = {
            ["Mode"] = r_v10_82,
            ["Detail"] = r_v2_105,
            ["MapType"] = r_v3_115
        }
        local r_v5_93
        local r_v6_134 = function()
            local r_v2_654 = r_v22_33
            writefile(r_v40_51, r_v2_654.JSONEncode(r_v2_654, r_v5_93))
        end
        r_v5_93 = r_v1_178
        pcall(r_v6_134)
        r_v3_115 = nil
        r_v2_105 = nil
        r_v10_82 = nil
    end
    local r_v86_10 = function()
        local r_v5_97 = r_v67_96:FindFirstChild("Money")
        local r_v10_83 = r_v5_97
        if r_v5_97 then
            local r_v5_98 = r_v67_96.Money
            r_v10_83 = r_v5_98.Value
        end
        return (r_v10_83 or 0)
    end
    local r_v99_11
    local r_v96_10 = function(r_v10_84)
        local r_v4_157, r_v2_108, r_v3_118 = pairs(r_v10_84)
        local r_v5_100 = r_v4_157
        for r_v6_138, r_v8_146 in r_v5_100, r_v2_108, r_v3_118 do
            local r_v9_153 = r_v8_146:FindFirstChild("Head")
            local r_v7_143 = r_v9_153
            if r_v9_153 then
                r_v9_153 = r_v8_146.Head
                r_v7_143 = r_v9_153:FindFirstChild("EffectBBGUI")
            end
            if r_v7_143 then
                local r_v14_147 = r_v7_143:FindFirstChild("Frame")
                r_v9_153 = r_v14_147
                if r_v14_147 then
                    r_v9_153 = r_v7_143.Frame:FindFirstChild("RangeImage")
                end
                local r_v11_138 = not r_v9_153
                local r_v14_149 = r_v11_138
                if not r_v11_138 then
                    local r_v13_130 = r_v9_153.Visible
                    r_v14_149 = not r_v13_130
                end
                if r_v14_149 then
                    return false
                else
                    r_v9_153 = nil
                    r_v7_143 = nil
                end
            else
                return false
            end
        end
        return true
    end
    local o_v2_11 = function()
        if isfile(r_v40_51) then
            local r_v2_109 = function()
                return r_v22_33:JSONDecode(readfile(r_v40_51))
            end
            local r_v3_119 = {
                pcall(r_v2_109)
            }
            local r_v10_86 = r_v3_119[2]
            r_v2_109 = r_v3_119[1]
            if r_v2_109 then
                return r_v10_86
            else
                -- empty block
            end
        end
        return nil
    end
    local r_v92_10 = function()
        local r_v10_87 = r_v76_34 and (r_v76_34.Get("Level"))
        return (r_v10_87 or 0)
    end
    local r_v97_11 = function(r_v10_88)
        local r_v2_116 = (r_v10_88:FindFirstChild("Head")) and (r_v10_88.Head:FindFirstChild("EffectBBGUI"))
        if r_v2_116 then
            local r_v3_129 = r_v2_116:FindFirstChild("Frame")
            local r_v4_164 = r_v3_129
            if r_v3_129 then
                r_v3_129 = r_v2_116.Frame
                r_v4_164 = r_v3_129:FindFirstChild("StunImage")
            end
            r_v3_129 = r_v4_164
            local r_v4_165 = r_v3_129 and (r_v3_129.Visible)
            if r_v4_165 then
                return true
            else
                -- empty block
            end
        end
        return false
    end
    local r_v100_10 = function()
        if (r_v87_11() > 0) then
            if (r_v40_42.macro_timer_version == "\224\184\149\224\184\178\224\184\161\224\185\128\224\184\167\224\184\165\224\184\178\224\185\128\224\184\139\224\184\180\224\184\159\224\185\128\224\184\167\224\184\173\224\184\163\224\185\140") then
                local r_v3_133 = getrenv()
                local r_v2_121 = r_v3_133.time()
                return (r_v2_121 + r_v99_11)
            else
                local r_v3_134 = r_v40_42.macro_timer_version
                local r_v2_122 = r_v3_134 == "\224\185\128\224\184\167\224\184\165\224\184\178\224\184\149\224\184\178\224\184\161\224\185\128\224\184\167\224\184\159(\224\185\129\224\184\153\224\184\176\224\184\153\224\184\179)"
                local r_v4_171 = r_v2_122
                if not r_v2_122 then
                    local r_v3_135 = r_v40_42.macro_timer_version
                    r_v4_171 = r_v3_135 == "\224\185\128\224\184\167\224\184\165\224\184\178+\224\184\163\224\184\173\224\185\128\224\184\167\224\184\159 (\224\185\129\224\184\161\224\185\136\224\184\153\224\184\162\224\184\179\224\184\170\224\184\185\224\184\135)"
                end
                if r_v4_171 then
                    local r_v5_120 = getrenv()
                    local r_v3_138 = r_v5_120.time()
                    return ((r_v3_138 - r_v98_10) + r_v99_11)
                end
            end
        end
        return 0
    end
    r_v98_10 = 30
    r_v99_11 = 0
    local r_v100_11 = function()
        task.spawn(function()
            if (r_v72_64() ~= nil) then
                r_v87_11()
            end
            repeat
                local r_v4_985 = task
                r_v4_985.wait()
                local r_v3_661 = r_v72_64()
                local r_v10_404 = r_v3_661 ~= nil
                local r_v4_987 = r_v10_404
                if r_v10_404 then
                    local r_v3_662 = r_v87_11()
                    r_v4_987 = r_v3_662 > 0
                end
            until r_v4_987
            local r_v10_407 = getrenv()
            r_v98_10 = r_v10_407.time()
            local r_v10_409 = os.clock()
            while true do
                -- optimized-out if statement
                local r_v2_669 = os
                local r_v3_666 = "clock"
                local r_v2_670 = r_v2_669[r_v3_666]()
                r_v3_666 = r_v2_670 - r_v10_409
                r_v10_409 = r_v2_670
                if (r_v87_11() > 0) then
                    local r_v7_981 = r_v72_64()
                    local r_v5_803 = r_v7_981 or 1
                    if (r_v5_803 > 1) then
                        local r_v7_985 = (r_v5_803 - 1) * r_v3_666
                        r_v99_11 = r_v99_11 + r_v7_985
                    end
                end
                task.wait(0.05)
            end
        end)
    end
    local o_v2_12 = false
    local o_v2_13 = nil
    local o_v2_14 = false
    local o_v2_15 = {
        ["Gems"] = 0,
        ["Gold"] = 0,
        ["Stardust"] = 0,
        ["Level"] = 0,
        ["GauntletTokens"] = 0
    }
    local o_v7_13 = getgenv()
    o_v7_13.MatchDrops = {}
    task.spawn(function()
        pcall(function()
            repeat
                task.wait(0.5)
                local r_v10_414 = r_v88_10()
                local r_v4_996 = nil
            until r_v10_414 ~= r_v4_996
            local r_v5_807 = r_v88_10()
            o_v2_15.Gems = r_v5_807 or 0
            local r_v6_962 = r_v89_11()
            o_v2_15.Gold = r_v6_962 or 0
            local r_v6_964 = r_v90_10()
            o_v2_15.Stardust = r_v6_964 or 0
            local r_v6_966 = r_v92_10()
            o_v2_15.Level = r_v6_966 or 0
            local r_v6_968 = r_v91_11()
            o_v2_15.GauntletTokens = r_v6_968 or 0
        end)
    end)
    local o_v7_16 = function(r_v10_94)
        if (r_v40_42.webhook_summon_url == "") then
            return
        end
        task.spawn(function()
            pcall(function()
                local r_v1_2344 = "https://tr.rbxcdn.com/38c6edcb50633730ff4cf39ac8859840/420/420/AvatarHeadshot/Png"
                pcall(function()
                    local r_v1_2793 = game
                    local r_v2_2025 = "https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds="
                    local r_v5_2371 = r_v22_34.UserId
                    local r_v3_2102 = r_v5_2371 .. "&size=420x420&format=Png&isCircular=false"
                    local r_v10_1247 = r_v2_2025 .. r_v3_2102
                    r_v10_1247 = r_v1_2793:HttpGet(r_v10_1247)
                    r_v2_2025 = r_v22_33:JSONDecode(r_v10_1247)
                    local r_v4_3189 = r_v2_2025
                    if r_v2_2025 then
                        local r_v6_2762 = r_v2_2025.data
                        local r_v3_2103 = r_v6_2762
                        if r_v6_2762 then
                            local r_v8_2910 = r_v2_2025.data
                            r_v3_2103 = r_v8_2910[1]
                        end
                        r_v4_3189 = r_v3_2103
                    end
                    if r_v4_3189 then
                        local r_v4_3190 = r_v2_2025.data[1]
                        r_v1_2344 = r_v4_3190.imageUrl
                    end
                end)
                local r_v2_1765 = "\226\156\168 STAR HUB | SUMMON RESULT \226\156\168"
                local r_v7_2251 = r_v22_34.Name
                local r_v5_1979 = "\224\184\156\224\184\185\224\185\137\224\185\128\224\184\165\224\185\136\224\184\153 **" .. (r_v7_2251 .. "** \224\184\170\224\184\184\224\185\136\224\184\161\224\185\132\224\184\148\224\185\137\224\184\149\224\184\177\224\184\167\224\184\165\224\184\176\224\184\132\224\184\163\224\185\131\224\184\171\224\184\161\224\185\136!")
                local r_v9_2134 = {
                    ["url"] = r_v1_2344
                }
                local r_v17_863 = "```fix\n" .. (r_v10_94 .. "\n```")
                local r_v13_1649 = {
                    ["name"] = "\240\159\142\129 **\224\185\132\224\184\148\224\185\137\224\184\163\224\184\177\224\184\154\224\184\149\224\184\177\224\184\167\224\184\165\224\184\176\224\184\132\224\184\163**",
                    ["value"] = r_v17_863,
                    ["inline"] = false
                }
                local r_v11_1768 = {
                    r_v13_1649
                }
                local r_v20_644 = r_v22_34.Name
                local r_v16_1022 = "Star Hub Summon Tracker \226\128\162 " .. r_v20_644
                local r_v12_1431 = {
                    ["text"] = r_v16_1022,
                    ["icon_url"] = r_v1_2344
                }
                local r_v17_869 = DateTime
                local r_v16_1027 = (r_v17_869.now()):ToIsoDate()
                r_v2_1765 = {
                    ["title"] = r_v2_1765,
                    ["description"] = r_v5_1979,
                    ["color"] = 16766720,
                    ["thumbnail"] = r_v9_2134,
                    ["fields"] = r_v11_1768,
                    ["footer"] = r_v12_1431,
                    ["timestamp"] = r_v16_1027
                }
                local r_v3_1784 = {
                    r_v2_1765
                }
                r_v3_1784 = {
                    ["embeds"] = r_v3_1784
                }
                local r_v5_1981 = request
                local r_v4_2769 = r_v5_1981
                if not r_v5_1981 then
                    local r_v8_2411 = http_request
                    r_v5_1981 = r_v8_2411
                    if not r_v8_2411 then
                        r_v5_1981 = (syn.request) or (fluxus.request)
                    end
                    r_v4_2769 = r_v5_1981
                end
                r_v5_1981 = r_v4_2769
                if r_v5_1981 then
                    local r_v8_2413 = r_v40_42.webhook_summon_url
                    local r_v11_1774 = {
                        ["Content-Type"] = "application/json"
                    }
                    local r_v15_1203 = r_v22_33:JSONEncode(r_v3_1784)
                    r_v5_1981({
                        ["Url"] = r_v8_2413,
                        ["Method"] = "POST",
                        ["Headers"] = r_v11_1774,
                        ["Body"] = r_v15_1203
                    })
                end
            end)
        end)
    end
    pcall(function()
        local r_v3_146 = game:GetService("ReplicatedStorage")
        r_v3_146.Remotes.Input.OnClientEvent:Connect(function(...)
            local r_v2_682 = {
                ...
            }
            if (type(r_v2_682[1]) == "string") then
                local r_v1_986 = string.find
                local r_v3_683 = r_v2_682[1]
                if r_v1_986(r_v3_683, "ShowEndMenu") then
                    local r_v6_974 = tostring(r_v2_682[2])
                    local r_v3_684 = r_v6_974 == "Fail"
                    local r_v4_1008 = r_v3_684
                    if not r_v3_684 then
                        local r_v6_977 = tostring(r_v2_682[2])
                        r_v4_1008 = r_v6_977 == "Defeat"
                    end
                    if r_v4_1008 then
                        o_v2_13 = "Defeat"
                    else
                        local r_v8_1018 = tostring(r_v2_682[2])
                        local r_v5_831 = r_v8_1018 == "Success"
                        local r_v4_1010 = r_v5_831
                        if not r_v5_831 then
                            local r_v9_897 = tostring(r_v2_682[2])
                            local r_v8_1020 = r_v9_897 == "Victory"
                            local r_v5_833 = r_v8_1020
                            if not r_v8_1020 then
                                local r_v9_901 = tostring(r_v2_682[2])
                                r_v5_833 = r_v9_901 == "Win"
                            end
                            r_v4_1010 = r_v5_833
                        end
                        if r_v4_1010 then
                            o_v2_13 = "Victory"
                        end
                    end
                else
                    local r_v3_685 = (string.find((string.lower(r_v2_682[1])), "max units")) or (string.find((string.lower(r_v2_682[1])), "limit"))
                    if r_v3_685 then
                        o_v2_12 = true
                    else
                        local r_v7_1003 = r_v2_682[1]
                        local r_v8_1019 = r_v7_1003 == "AddToInventory"
                        local r_v5_832 = r_v8_1019
                        if r_v8_1019 then
                            local r_v9_899 = type(r_v2_682[3])
                            r_v5_832 = r_v9_899 == "table"
                        end
                        if r_v5_832 then
                            local r_v5_835 = r_v2_682[3].Name
                            if r_v5_835 then
                                local r_v8_1028 = getgenv()
                                local r_v13_697 = getgenv()
                                r_v8_1028.MatchDrops = (r_v13_697.MatchDrops) or ({})
                                local r_v7_1018 = getgenv()
                                local r_v6_989 = r_v7_1018.MatchDrops
                                local r_v12_583 = getgenv()
                                local r_v14_810 = r_v12_583.MatchDrops[r_v5_835]
                                local r_v7_1019 = r_v14_810 or 0
                                r_v6_989[r_v5_835] = r_v7_1019 + 1
                            end
                        else
                            local r_v7_1012 = r_v2_682[1]
                            local r_v8_1026 = r_v7_1012 == "DisplayUnit"
                            local r_v5_836 = r_v8_1026
                            if r_v8_1026 then
                                local r_v9_908 = type(r_v2_682[2])
                                r_v5_836 = r_v9_908 == "table"
                            end
                            if r_v5_836 then
                                local r_v5_837 = r_v2_682[2][1]
                                if (type(r_v5_837) == "string") then
                                    local r_v8_1038 = getgenv()
                                    local r_v13_705 = getgenv()
                                    r_v8_1038.MatchDrops = (r_v13_705.MatchDrops) or ({})
                                    local r_v13_707 = type(r_v2_682[2][2])
                                    local r_v7_1024 = (r_v13_707 == "number") and (r_v2_682[2][2])
                                    local r_v6_994 = r_v7_1024 or 1
                                    local r_v9_918 = getgenv()
                                    local r_v8_1040 = r_v9_918.MatchDrops
                                    local r_v15_462 = getgenv()
                                    local r_v11_750 = r_v15_462.MatchDrops[r_v5_837]
                                    local r_v9_919 = r_v11_750 or 0
                                    r_v8_1040[r_v5_837] = r_v9_919 + r_v6_994
                                    local r_v8_1041 = (r_v71_75()) and (r_v40_42.auto_summon_enable)
                                    if r_v8_1041 then
                                        o_v7_16(r_v5_837)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end)
    end)
    if (not r_v71_75()) then
        local o_v9_21 = workspace:WaitForChild("Enemies")
        o_v9_21.ChildAdded:Connect(function(r_v10_99)
            task.wait(0.5)
            pcall(function()
                local r_v1_997 = string.lower
                local r_v10_425 = r_v10_99.Name
                r_v10_425 = r_v1_997(r_v10_425)
                local r_v2_687 = r_v10_425:match("air")
                local r_v4_1014 = r_v2_687
                if not r_v2_687 then
                    local r_v5_843 = r_v10_425:match("bird")
                    local r_v2_688 = r_v5_843
                    if not r_v5_843 then
                        local r_v8_1049 = r_v10_425:match("fly")
                        local r_v5_844 = r_v8_1049
                        if not r_v8_1049 then
                            local r_v11_756 = r_v10_99:GetAttribute("AirUnitBool")
                            local r_v9_926 = r_v11_756 == true
                            local r_v8_1050 = r_v9_926
                            if not r_v9_926 then
                                local r_v11_759 = r_v10_99:GetAttribute("TitleString")
                                r_v8_1050 = r_v11_759 == "Air"
                            end
                            r_v5_844 = r_v8_1050
                        end
                        r_v2_688 = r_v5_844
                    end
                    r_v4_1014 = r_v2_688
                end
                if r_v4_1014 then
                    o_v2_14 = true
                end
            end)
        end)
        local o_v9_26 = workspace:WaitForChild("Enemies")
        o_v9_26.ChildRemoved:Connect(function(r_v10_101)
            if r_v40_42.webhook_kill_enable then
                r_v40_42.current_kills = r_v40_42.current_kills + 1
                local r_v4_190 = r_v40_42.current_kills
                local r_v2_145 = r_v40_42.webhook_kill_target
                if (r_v4_190 >= r_v2_145) then
                    task.spawn(function()
                        r_v67_92("Kill Target Reached!", "\224\184\132\224\184\184\224\184\147\224\184\129\224\184\179\224\184\136\224\184\177\224\184\148\224\184\161\224\184\173\224\184\153\224\184\170\224\185\128\224\184\149\224\184\173\224\184\163\224\185\140\224\184\132\224\184\163\224\184\154 " .. r_v40_42.webhook_kill_target .. " \224\184\149\224\184\177\224\184\167\224\185\129\224\184\165\224\185\137\224\184\167", 5)
                    end)
                    r_v40_42.current_kills = 0
                end
            end
        end)
    end
    local o_v8_31 = function(r_v10_103)
        local r_v2_154 = math.floor(r_v10_103 / 3600)
        local r_v3_162 = math.floor((r_v10_103 % 3600) / 60)
        local r_v5_144 = math.floor(r_v10_103 % 60)
        if (r_v2_154 > 0) then
            return string.format("%02d \224\184\138\224\184\177\224\185\136\224\184\167\224\185\130\224\184\161\224\184\135 %02d \224\184\153\224\184\178\224\184\151\224\184\181 %02d \224\184\167\224\184\180\224\184\153\224\184\178\224\184\151\224\184\181", r_v2_154, r_v3_162, r_v5_144)
        end
        return string.format("%02d \224\184\153\224\184\178\224\184\151\224\184\181 %02d \224\184\167\224\184\180\224\184\153\224\184\178\224\184\151\224\184\181", r_v3_162, r_v5_144)
    end
    local o_v27_6 = function(r_v10_104)
        local r_v2_156 = r_v10_104.Name
        local r_v1_216 = r_v10_104.Index
        local r_v6_187 = r_v40_43[r_v40_42.macro_profile]
        local r_v5_148 = r_v6_187.Units[r_v2_156][r_v1_216]
        local r_v6_188 = r_v2_3
        r_v6_188 = r_v5_148.Rotation
        local r_v8_192 = r_v5_148.Position
        r_v8_192 = r_v31_23(r_v8_192)
        local r_v7_185 = nil
        local r_v1_221 = pairs
        local r_v11_154 = workspace.Unit
        local r_v4_211, r_v9_186, r_v14_174 = r_v1_221(r_v11_154.GetChildren(r_v11_154))
        local r_v11_156 = r_v4_211
        for r_v13_136, r_v12_121 in r_v11_156, r_v9_186, r_v14_174 do
            local r_v15_102 = "HumanoidRootPart"
            r_v15_102 = r_v12_121:FindFirstChild(r_v15_102)
            if (r_v15_102 ~= nil) then
                local r_v17_82 = r_v8_192.Position
                local r_v20_26 = r_v15_102.CFrame.Position
                local r_v16_98 = r_v17_82 - r_v20_26
                r_v16_98 = r_v16_98.magnitude
                local r_v17_84 = r_v40_42.macro_magnitude
                if (r_v16_98 <= r_v17_84) then
                    r_v7_185 = r_v12_121
                    r_v16_98 = nil
                    r_v15_102 = nil
                    break
                else
                    r_v16_98 = nil
                end
            end
        end
        return r_v7_185, r_v8_192, r_v6_188
    end
    local o_v8_32 = function(r_v10_105)
        if (r_v40_42.webhook_url == "") then
            return
        end
        local r_v1_230 = task.spawn
        local r_v2_161 = function()
            local r_v10_427 = function()
                local r_v1_2351 = string.char
                local r_v10_1088 = 96
                r_v10_1088 = r_v1_2351(r_v10_1088, 96, 96)
                local r_v2_1768 = {}
                local r_v1_2353 = "https://tr.rbxcdn.com/38c6edcb50633730ff4cf39ac8859840/420/420/AvatarHeadshot/Png"
                pcall(function()
                    local r_v1_2797 = game
                    local r_v2_2026 = "https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds="
                    local r_v5_2377 = r_v22_34.UserId
                    local r_v3_2107 = r_v5_2377 .. "&size=420x420&format=Png&isCircular=false"
                    local r_v10_1248 = r_v2_2026 .. r_v3_2107
                    r_v10_1248 = r_v1_2797:HttpGet(r_v10_1248)
                    r_v2_2026 = r_v22_33:JSONDecode(r_v10_1248)
                    local r_v4_3198 = r_v2_2026
                    if r_v2_2026 then
                        local r_v6_2769 = r_v2_2026.data
                        local r_v3_2108 = r_v6_2769
                        if r_v6_2769 then
                            local r_v8_2917 = r_v2_2026.data
                            r_v3_2108 = r_v8_2917[1]
                        end
                        r_v4_3198 = r_v3_2108
                    end
                    if r_v4_3198 then
                        local r_v4_3199 = r_v2_2026.data[1]
                        r_v1_2353 = r_v4_3199.imageUrl
                    end
                end)
                if (type(r_v10_105) == "table") then
                    local r_v5_1987 = r_v49_56[r_v40_42.webhook_win_color]
                    r_v5_1987 = r_v5_1987 or 5763719
                    local r_v6_2293 = state
                    local r_v8_2419 = r_v49_56[r_v40_42.webhook_lose_color]
                    r_v6_2293 = r_v8_2419 or 15548997
                    local r_v8_2420 = 16753920
                    local r_v4_2781 = ipairs
                    local r_v11_1781 = r_v10_105
                    for r_v11_1787, r_v13_1667 in r_v4_2781(r_v11_1781) do
                        local r_v12_1451 = string.lower(r_v13_1667.value)
                        local r_v4_2783 = (string.find(r_v12_1451, "victory")) or (string.find(r_v12_1451, "success"))
                        if r_v4_2783 then
                            r_v8_2420 = r_v5_1987
                        else
                            local r_v15_1212 = (string.find(r_v12_1451, "defeat")) or ((string.find(r_v12_1451, "lose")) or (string.find(r_v12_1451, "fail")))
                            if r_v15_1212 then
                                r_v8_2420 = r_v6_2293
                            end
                        end
                    end
                    local r_v7_2271 = {}
                    local r_v9_2145 = ipairs
                    local r_v12_1452 = game.Players
                    local r_v17_893 = r_v12_1452.GetPlayers
                    local r_v16_1046 = {
                        r_v17_893(r_v12_1452)
                    }
                    for r_v9_2146, r_v12_1454 in r_v9_2145(unpack(r_v16_1046)) do
                        table.insert(r_v7_2271, r_v12_1454.Name)
                    end
                    local r_v9_2148 = table.insert
                    local r_v24_241 = tostring(#r_v7_2271)
                    local r_v27_155 = tostring(game.Players.MaxPlayers)
                    local r_v31_213 = table.concat(r_v7_2271, ", ")
                    local r_v29_172 = "\n" .. r_v10_1088
                    local r_v28_256 = "\nList: " .. (r_v31_213 .. r_v29_172)
                    local r_v23_251 = "/" .. (r_v27_155 .. r_v28_256)
                    local r_v18_401 = "yaml\nPlayers: " .. (r_v24_241 .. r_v23_251)
                    local r_v19_537 = r_v10_1088 .. r_v18_401
                    r_v9_2148(r_v10_105, 2, {
                        ["name"] = "\240\159\145\165 **PLAYERS INFO**",
                        ["value"] = r_v19_537,
                        ["inline"] = false
                    })
                    local r_v20_686 = {
                        ["url"] = r_v1_2353
                    }
                    local r_v26_210 = r_v22_34.Name
                    local r_v24_247 = "Star Hub Premium Engine \226\128\162 " .. r_v26_210
                    local r_v22_346 = {
                        ["text"] = r_v24_247,
                        ["icon_url"] = r_v1_2353
                    }
                    local r_v25_214 = DateTime
                    local r_v24_252 = (r_v25_214.now()):ToIsoDate()
                    local r_v9_2149 = {
                        ["title"] = "\240\159\143\134 STAR HUB ULTIMATE | MATCH REPORT \240\159\143\134",
                        ["description"] = "\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\n**\224\184\170\224\184\163\224\184\184\224\184\155\224\184\156\224\184\165\224\184\129\224\184\178\224\184\163\224\185\128\224\184\165\224\185\136\224\184\153\224\184\148\224\185\136\224\184\178\224\184\153\224\184\165\224\185\136\224\184\178\224\184\170\224\184\184\224\184\148\224\184\130\224\184\173\224\184\135\224\184\132\224\184\184\224\184\147**",
                        ["color"] = r_v8_2420,
                        ["thumbnail"] = r_v20_686,
                        ["fields"] = r_v10_105,
                        ["footer"] = r_v22_346,
                        ["timestamp"] = r_v24_252
                    }
                    local r_v13_1676 = r_v40_42.webhook_image_url
                    r_v2_1768 = r_v9_2149
                    local r_v14_1970 = r_v13_1676
                    if r_v13_1676 then
                        local r_v12_1466 = r_v40_42.webhook_image_url
                        r_v14_1970 = r_v12_1466 ~= ""
                    end
                    if r_v14_1970 then
                        local r_v12_1473 = r_v40_42.webhook_image_url
                        r_v2_1768.image = {
                            ["url"] = r_v12_1473
                        }
                    end
                else
                    local r_v5_1988 = ((r_v10_105 == "EXP Evolve") and 3447003) or 65280
                    local r_v14_1960 = r_v92_10()
                    local r_v6_2295 = r_v14_1960 or 0
                    local r_v7_2270 = o_v2_15.Level
                    local r_v8_2423 = r_v6_2295 - r_v7_2270
                    local r_v22_321 = "' \224\185\128\224\184\170\224\184\163\224\185\135\224\184\136\224\184\170\224\184\180\224\185\137\224\184\153\224\185\129\224\184\165\224\185\137\224\184\167!\n" .. r_v10_1088
                    local r_v20_658 = "diff\n+ \224\184\163\224\184\176\224\184\154\224\184\154\224\184\151\224\184\179\224\184\135\224\184\178\224\184\153 '" .. (r_v10_105 .. r_v22_321)
                    local r_v12_1449 = "\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\226\148\129\n" .. (r_v10_1088 .. r_v20_658)
                    local r_v20_661 = {
                        ["url"] = r_v1_2353
                    }
                    local r_v35_120 = r_v22_34.Name
                    local r_v32_170 = tostring(r_v6_2295)
                    local r_v39_201 = ((r_v8_2423 > 0) and ("(+" .. (r_v8_2423 .. ")"))) or ("")
                    local r_v41_192 = "\n" .. r_v10_1088
                    local r_v34_188 = " " .. (r_v39_201 .. r_v41_192)
                    local r_v30_131 = "\n\224\185\128\224\184\165\224\185\128\224\184\167\224\184\165\224\184\155\224\184\177\224\184\136\224\184\136\224\184\184\224\184\154\224\184\177\224\184\153: " .. (r_v32_170 .. r_v34_188)
                    local r_v26_193 = "yaml\n\224\184\138\224\184\183\224\185\136\224\184\173\224\184\149\224\184\177\224\184\167\224\184\165\224\184\176\224\184\132\224\184\163: " .. (r_v35_120 .. r_v30_131)
                    local r_v25_197 = r_v10_1088 .. r_v26_193
                    local r_v21_369 = {
                        ["name"] = "\240\159\145\164 \224\184\130\224\185\137\224\184\173\224\184\161\224\184\185\224\184\165\224\184\156\224\184\185\224\185\137\224\185\128\224\184\165\224\185\136\224\184\153 (Player Profile)",
                        ["value"] = r_v25_197,
                        ["inline"] = false
                    }
                    local r_v18_391 = {
                        r_v21_369
                    }
                    local r_v26_198 = r_v22_34.Name
                    local r_v24_230 = "Star Hub Alerts \226\128\162 " .. r_v26_198
                    local r_v22_330 = {
                        ["text"] = r_v24_230,
                        ["icon_url"] = r_v1_2353
                    }
                    local r_v25_203 = DateTime
                    local r_v24_235 = (r_v25_203.now()):ToIsoDate()
                    r_v2_1768 = {
                        ["title"] = "\226\156\168 STAR HUB | PROGRESSION ALERT \226\156\168",
                        ["description"] = r_v12_1449,
                        ["color"] = r_v5_1988,
                        ["thumbnail"] = r_v20_661,
                        ["fields"] = r_v18_391,
                        ["footer"] = r_v22_330,
                        ["timestamp"] = r_v24_235
                    }
                end
                local r_v8_2425 = {
                    r_v2_1768
                }
                local r_v5_1989 = {
                    ["embeds"] = r_v8_2425
                }
                local r_v14_1966 = r_v40_42.webhook_ping_user
                local r_v6_2297 = r_v14_1966
                if r_v14_1966 then
                    local r_v11_1797 = r_v40_42.webhook_discord_id
                    r_v6_2297 = r_v11_1797 ~= ""
                end
                if r_v6_2297 then
                    local r_v13_1682 = r_v40_42.webhook_discord_id
                    local r_v11_1801 = r_v13_1682 .. ">"
                    r_v5_1989.content = "<@" .. r_v11_1801
                end
                local r_v14_1974 = request
                r_v6_2297 = r_v14_1974
                if not r_v14_1974 then
                    r_v6_2297 = http_request or ((syn.request) or (fluxus.request))
                end
                if r_v6_2297 then
                    local r_v13_1687 = r_v40_42.webhook_url
                    local r_v20_702 = {
                        ["Content-Type"] = "application/json"
                    }
                    local r_v21_407 = r_v22_33:JSONEncode(r_v5_1989)
                    r_v6_2297({
                        ["Url"] = r_v13_1687,
                        ["Method"] = "POST",
                        ["Headers"] = r_v20_702,
                        ["Body"] = r_v21_407
                    })
                end
            end
            pcall(r_v10_427)
        end
        r_v1_230(r_v2_161)
    end
    local o_v18_12 = function(r_v10_107)
        task.spawn(function()
            local r_v10_428 = "KilluaWishes"
            r_v10_428 = r_v69_99:WaitForChild(r_v10_428)
            local r_v1_1007 = r_v10_428:WaitForChild("TextBackground")
            local r_v2_693 = "OptionsContainer"
            r_v2_693 = r_v1_1007:WaitForChild(r_v2_693)
            local r_v8_1059 = r_v2_693.GetChildren
            local r_v1_1008 = pairs
            for r_v8_1061, r_v1_1009 in r_v1_1008(r_v8_1059(r_v2_693)) do
                local r_v11_762 = r_v1_1009.Name
                local r_v14_830 = r_v11_762 == "Option"
                local r_v9_931 = r_v14_830
                if r_v14_830 then
                    local r_v11_763 = r_v1_1009.Text
                    r_v9_931 = r_v11_763 == r_v10_107
                end
                if not r_v9_931 then
                    continue
                end
                local r_v9_933 = getgenv()
                r_v9_933.IsAutoBuffClicking = true
                pcall(function()
                    firesignal(r_v1_1009.MouseButton1Click)
                end)
                task.wait(0.2)
                local r_v9_939 = getgenv()
                r_v9_939.IsAutoBuffClicking = false
                r_v10_428:Destroy()
                break
            end
        end)
    end
    SendWebhook = o_v8_32
    Queue = {}
    local o_v10_22 = Queue
    o_v10_22.new = (function()
        local r_v1_232 = {
            ["first"] = 0,
            ["last"] = (-1)
        }
        return r_v1_232
    end)
    local o_v28_6 = function()
        local r_v10_111 = r_v100_10()
        local r_v4_219 = r_v40_42.macro_record_time_offset
        return (r_v10_111 + r_v4_219)
    end
    local o_v26_7 = function(r_v10_113)
        if (r_v40_43[r_v40_42.macro_profile].Units[r_v10_113.Name] == nil) then
            local r_v1_238 = r_v40_43[r_v40_42.macro_profile].Units
            r_v1_238[r_v10_113.Name] = {}
        end
        local r_v2_175 = nil
        local r_v1_240 = ipairs
        local r_v6_204 = r_v40_43[r_v40_42.macro_profile].Units[r_v10_113.Name]
        local r_v8_208 = {
            r_v1_240(r_v6_204)
        }
        local r_v3_181 = r_v8_208[2]
        local r_v5_164 = r_v8_208[3]
        local r_v6_205 = r_v8_208[1]
        for r_v8_208, r_v7_202 in r_v6_205, r_v3_181, r_v5_164 do
            local r_v9_197 = "HumanoidRootPart"
            r_v9_197 = r_v10_113:FindFirstChild(r_v9_197)
            if (r_v9_197 ~= nil) then
                local r_v12_127 = r_v31_23(r_v7_202.Position)
                local r_v11_163 = r_v12_127.Position
                local r_v13_146 = r_v9_197.CFrame.Position
                local r_v14_184 = r_v11_163 - r_v13_146
                r_v14_184 = r_v14_184.magnitude
                local r_v11_165 = r_v40_42.macro_magnitude
                if (r_v14_184 <= r_v11_165) then
                    r_v2_175 = r_v8_208
                    r_v9_197 = nil
                    r_v14_184 = nil
                    break
                else
                    r_v14_184 = nil
                end
            end
        end
        if (r_v2_175 == nil) then
            local r_v5_166 = table.insert
            local r_v8_211 = r_v40_43[r_v40_42.macro_profile].Units[r_v10_113.Name]
            local r_v13_156 = tostring(r_v10_113.HumanoidRootPart.CFrame)
            r_v5_166(r_v8_211, {
                ["Rotation"] = 0,
                ["Position"] = r_v13_156
            })
            local r_v6_208 = r_v40_43[r_v40_42.macro_profile].Units[r_v10_113.Name]
            r_v2_175 = #r_v6_208
        end
        return r_v2_175
    end
    local o_v10_24 = Queue
    o_v10_24.pushleft = (function(r_v10_112, r_v2_168)
        local r_v4_220 = r_v10_112.first
        local r_v3_175 = 1
        r_v3_175 = r_v4_220 - r_v3_175
        r_v10_112.first = r_v3_175
        r_v10_112[r_v3_175] = r_v2_168
        r_v2_168 = nil
        r_v10_112 = nil
    end)
    local o_v10_26 = Queue
    o_v10_26.pushright = (function(r_v10_114, r_v2_176)
        local r_v4_228 = r_v10_114.last
        local r_v3_185 = 1
        r_v3_185 = r_v4_228 + r_v3_185
        r_v10_114.last = r_v3_185
        r_v10_114[r_v3_185] = r_v2_176
        r_v2_176 = nil
        r_v10_114 = nil
    end)
    local o_v9_33 = function(r_v10_115)
        local r_v1_251 = r_v10_115.first
        local r_v4_232 = r_v10_115.last
        local r_v2_178 = r_v1_251
        if (r_v2_178 > r_v4_232) then
            error("list is empty")
        end
        local r_v3_189 = r_v10_115[r_v2_178]
        r_v10_115[r_v2_178] = nil
        r_v10_115.first = r_v2_178 + 1
        return r_v3_189
    end
    local o_v10_28 = Queue
    o_v10_28.popleft = o_v9_33
    local o_v17_12 = function(r_v10_117)
        task.spawn(function()
            local r_v10_429 = "MultipleAbilities"
            r_v10_429 = r_v69_99:WaitForChild(r_v10_429)
            local r_v1_1020 = pairs
            local r_v5_855 = r_v10_429:WaitForChild("Frame")
            local r_v4_1031, r_v2_695, r_v3_703 = r_v1_1020(r_v5_855.GetChildren(r_v5_855))
            local r_v5_857 = r_v4_1031
            for r_v6_1011, r_v1_1021 in r_v5_857, r_v2_695, r_v3_703 do
                if (r_v1_1021.Name == "ImageButton") then
                    local r_v7_1047 = r_v1_1021:WaitForChild("TextLabel")
                    if (r_v7_1047.Text == r_v10_117) then
                        local r_v9_946 = getgenv()
                        r_v9_946.IsAutoBuffClicking = true
                        firesignal(r_v1_1021.Activated)
                        pcall(function()
                            firesignal(r_v1_1021.MouseButton1Click)
                        end)
                        task.wait(0.2)
                        local r_v9_954 = getgenv()
                        r_v9_954.IsAutoBuffClicking = false
                        r_v7_1047 = nil
                        break
                    else
                        r_v7_1047 = nil
                    end
                end
            end
        end)
    end
    local o_v10_30 = Queue
    o_v10_30.length = (function(r_v10_116)
        local r_v2_179 = r_v10_116.last
        local r_v3_191 = r_v10_116.first
        return ((r_v2_179 - r_v3_191) + 1)
    end)
    local o_v10_31 = Queue
    local o_v10_32 = o_v10_31.new()
    local o_v9_36
    local o_v11_28 = function()
        while true do
            local r_v4_240 = task
            if not (r_v4_240.wait()) then
                break
            end
            if (Queue.length(o_v9_36) > 0) then
                local r_v1_261 = Queue.popleft
                local r_v10_125 = o_v9_36
                r_v10_125 = r_v1_261(r_v10_125)
                local r_v2_189 = r_v2_3
                r_v2_189 = r_v10_125.Method
                local r_v3_197 = r_v2_3
                local r_v1_263 = r_v10_125.Args
                local r_v5_184 = tostring(r_v2_189)
                r_v3_197 = r_v1_263
                if (r_v5_184 == "Input") then
                    local r_v6_227 = game:GetService("ReplicatedStorage")
                    r_v6_227.Remotes.Input:FireServer(unpack(r_v3_197))
                end
                if (tostring(r_v2_189) == "Server") then
                    local r_v6_235 = game:GetService("ReplicatedStorage")
                    r_v6_235.Remotes.Server:InvokeServer(unpack(r_v3_197))
                end
                task.wait(r_v40_42.action_queue_remote_fire_delay)
            end
        end
    end
    o_v9_36 = o_v10_32
    local o_v13_21 = function(r_v10_126, r_v2_190)
        local r_v1_269 = Queue.pushright
        local r_v5_199 = {
            ["Method"] = r_v10_126,
            ["Args"] = r_v2_190
        }
        r_v1_269(o_v9_36, r_v5_199)
        r_v10_126 = nil
        r_v2_190 = nil
    end
    local o_v12_22
    local o_v22_11 = function(r_v10_127)
        local r_v6_246 = game:GetService("ReplicatedStorage")
        local r_v2_191 = r_v6_246.Remotes.Input
        local r_v3_202 = {
            [1] = "Sell",
            [2] = r_v10_127
        }
        o_v12_22(r_v2_191, r_v3_202)
        r_v10_127 = nil
    end
    o_v12_22 = o_v13_21
    local o_v11_29 = function()
        local r_v2_192 = o_v11_28
        local r_v4_266, __beta_unused_return_1 = pcall(r_v2_192)
        r_v2_192 = r_v4_266
        while true do
            if not (not r_v2_192) then
                break
            end
            local r_v4_268, __beta_unused_return_1 = pcall(o_v11_28)
            local r_v5_205 = task
            r_v5_205.wait()
            r_v2_192 = r_v4_268
        end
    end
    local o_v14_19 = function(r_v10_131, r_v2_193, r_v3_205)
        local r_v6_252 = function()
            local r_v1_1032 = function(r_v10_1091)
                local r_v2_1772 = r_v10_1091:FindFirstChild("Owner")
                local r_v1_2373 = r_v10_1091:FindFirstChild("HumanoidRootPart")
                local r_v5_1994 = r_v2_1772 ~= nil
                local r_v3_1794 = r_v1_2373
                if (r_v5_1994 and (r_v3_1794 ~= (nil))) then
                    local r_v5_1996 = r_v2_193.Position
                    local r_v6_2306 = r_v3_1794.CFrame.Position
                    local r_v4_2792 = r_v5_1996 - r_v6_2306
                    local r_v5_1997 = "magnitude"
                    r_v5_1997 = r_v4_2792[r_v5_1997]
                    local r_v7_2281 = tostring(r_v2_1772.Value)
                    local r_v8_2439 = r_v67_96.Name
                    local r_v6_2308 = r_v7_2281 == r_v8_2439
                    local r_v4_2793 = r_v6_2308
                    if r_v6_2308 then
                        local r_v9_2158 = r_v10_1091.Name
                        local r_v7_2282 = r_v9_2158 == r_v3_205
                        local r_v6_2309 = r_v7_2282
                        if r_v7_2282 then
                            local r_v9_2159 = r_v40_42.macro_magnitude
                            r_v6_2309 = r_v5_1997 <= r_v9_2159
                        end
                        r_v4_2793 = r_v6_2309
                    end
                    if r_v4_2793 then
                        return true
                    else
                        -- empty block
                    end
                end
                return false
            end
            if (type(r_v2_193) == "string") then
                r_v2_193 = r_v31_23(r_v2_193)
            end
            if r_v40_42.macro_money_tracking then
                repeat
                    local r_v2_703 = task
                    r_v2_703.wait()
                    local r_v3_721 = r_v86_10()
                    local r_v5_866 = r_v83_19(r_v3_205)
                until r_v3_721 >= r_v5_866
            end
            local r_v1_1037 = false
            local r_v3_708 = workspace.Unit
            local r_v3_711 = r_v3_708.ChildAdded:Connect(function(r_v10_1092)
                if r_v1_1032(r_v10_1092) then
                    r_v1_1037 = true
                end
                r_v10_1092 = nil
            end)
            local r_v9_961 = game:GetService("ReplicatedStorage")
            local r_v6_1020 = r_v9_961.Remotes.Input
            local r_v11_781 = {
                ["Rotation"] = r_v10_131,
                ["cframe"] = r_v2_193,
                ["Unit"] = r_v3_205
            }
            o_v12_22(r_v6_1020, {
                [1] = "Summon",
                [2] = r_v11_781
            })
            if r_v40_42.action_queue_remote_on_fail then
                task.spawn(function()
                    task.wait(r_v40_42.action_queue_remote_on_fail_delay)
                    while true do
                        if not (not r_v1_1037) then
                            break
                        end
                        if (Queue.length(o_v9_36) == 0) then
                            local r_v1_2383 = pairs
                            local r_v3_1798 = workspace.Unit
                            local r_v4_2801, r_v10_1099, r_v2_1781 = r_v1_2383(r_v3_1798.GetChildren(r_v3_1798))
                            local r_v3_1800 = r_v4_2801
                            for r_v5_2005, r_v6_2319 in r_v3_1800, r_v10_1099, r_v2_1781 do
                                if not (r_v1_1032(r_v6_2319, r_v2_193)) then
                                    continue
                                end
                                r_v1_1037 = true
                                break
                            end
                            if (not r_v1_1037) then
                                local r_v8_2451 = game:GetService("ReplicatedStorage")
                                local r_v3_1804 = r_v8_2451.Remotes.Input
                                local r_v9_2168 = {
                                    ["Rotation"] = r_v10_131,
                                    ["cframe"] = r_v2_193,
                                    ["Unit"] = r_v3_205
                                }
                                o_v12_22(r_v3_1804, {
                                    [1] = "Summon",
                                    [2] = r_v9_2168
                                })
                            end
                        end
                        task.wait(r_v40_42.action_queue_remote_on_fail_delay_loop)
                    end
                    r_v3_711:Disconnect()
                end)
            else
                r_v3_711:Disconnect()
            end
        end
        local __beta_unused_return_1, __beta_unused_return_2 = pcall(r_v6_252)
    end
    local o_v21_10 = function(r_v10_133)
        local r_v6_258 = game:GetService("ReplicatedStorage")
        local r_v2_195 = r_v6_258.Remotes.Input
        local r_v3_208 = {
            [1] = "ChangePriority",
            [2] = r_v10_133
        }
        o_v12_22(r_v2_195, r_v3_208)
        r_v10_133 = nil
    end
    local o_v15_17 = function(r_v10_134, r_v2_196)
        local __beta_unused_return_3, __beta_unused_return_3 = pcall(function()
            local r_v4_1037 = r_v10_134:FindFirstChild("UpgradeTag")
            local r_v4_1038 = r_v85_13(r_v10_134.Name)
            local r_v1_1047 = function()
                local r_v2_1786 = r_v4_1037.Value
                local r_v10_1103 = r_v2_1786 >= r_v2_196
                local r_v4_2802 = r_v10_1103
                if not r_v10_1103 then
                    local r_v2_1787 = r_v4_1037.Value
                    r_v4_2802 = r_v2_1787 >= r_v4_1038
                end
                if r_v4_2802 then
                    return true
                end
                return false
            end
            local r_v5_870 = 0
            local r_v6_1029 = r_v4_1037.Value
            local r_v4_1039 = r_v6_1029 + 1
            local r_v8_1085 = r_v2_196
            for r_v14_870 = r_v4_1039, r_v8_1085 do
                local r_v11_785 = r_v84_15(r_v10_134.Name, r_v14_870)
                r_v5_870 = r_v5_870 + r_v11_785
            end
            repeat
                local r_v4_1046 = task
                r_v4_1046.wait()
                if r_v1_1047() then
                    return
                end
                local r_v6_1037 = r_v86_10()
            until r_v6_1037 >= r_v5_870
            local r_v1_1055 = false
            local r_v1_1059 = (r_v4_1037:GetPropertyChangedSignal("Value")):Connect(function()
                if r_v1_1047() then
                    r_v1_1055 = true
                end
            end)
            local r_v7_1064 = r_v4_1037.Value
            local r_v4_1053 = r_v7_1064 + 1
            local r_v9_974 = r_v2_196
            for r_v13_748 = r_v4_1053, r_v9_974 do
                local r_v15_491 = game:GetService("ReplicatedStorage")
                r_v15_491.Remotes.Server:InvokeServer("Upgrade", r_v10_134)
            end
            task.spawn(function()
                task.wait(1)
                while true do
                    if not (not r_v1_1055) then
                        break
                    end
                    if (Queue.length(o_v9_36) == 0) then
                        if r_v1_1047() then
                            break
                        else
                            if (not r_v1_1055) then
                                local r_v2_1796 = game:GetService("ReplicatedStorage")
                                r_v2_1796.Remotes.Server:InvokeServer("Upgrade", r_v10_134)
                            end
                        end
                    end
                    task.wait(1)
                end
                r_v1_1059:Disconnect()
            end)
        end)
    end
    local o_v16_14 = function(r_v10_136, r_v2_198)
        task.spawn(function()
            local __beta_unused_return_1, __beta_unused_return_2 = pcall(function()
                local r_v10_1117 = "SpecialMove"
                r_v10_1117 = r_v10_136:FindFirstChild(r_v10_1117)
                if (not r_v10_1117) then
                    return
                end
                local r_v2_1804 = (r_v10_1117:FindFirstChild("Special_Enabled2")) or (r_v10_1117:FindFirstChild(("Special_Enabled")))
                if (not r_v2_1804) then
                    return
                end
                local r_v6_2336 = r_v97_11(r_v10_136)
                if (not r_v6_2336) then
                    local r_v5_2023 = r_v2_1804.Value
                end
                repeat
                    local r_v4_2827 = task
                    r_v4_2827.wait()
                    local r_v6_2339 = r_v97_11(r_v10_136)
                    local r_v3_1823 = not r_v6_2339
                    local r_v4_2829 = r_v3_1823
                    if r_v3_1823 then
                        local r_v5_2026 = r_v2_1804.Value
                        r_v4_2829 = not r_v5_2026
                    end
                until r_v4_2829
                local r_v1_2402 = false
                local r_v1_2406 = (r_v2_1804:GetPropertyChangedSignal("Value")):Connect(function()
                    r_v1_2402 = true
                end)
                o_v12_22((game:GetService("ReplicatedStorage")).Remotes.Input, {
                    [1] = "UseSpecialMove",
                    [2] = r_v10_136,
                    [3] = r_v2_198
                })
                if r_v40_42.action_queue_remote_on_fail then
                    task.spawn(function()
                        task.wait(r_v40_42.action_queue_remote_on_fail_delay)
                        while true do
                            if not (not r_v1_2402) then
                                break
                            end
                            if (Queue.length(o_v9_36) == 0) then
                                if r_v2_1804.Value then
                                    break
                                else
                                    if (not r_v1_2402) then
                                        o_v12_22((game:GetService("ReplicatedStorage")).Remotes.Input, {
                                            [1] = "UseSpecialMove",
                                            [2] = r_v10_136,
                                            [3] = r_v2_198
                                        })
                                    end
                                end
                            end
                            task.wait(r_v40_42.action_queue_remote_on_fail_delay_loop)
                        end
                        r_v1_2406:Disconnect()
                    end)
                else
                    r_v1_2406:Disconnect()
                end
            end)
        end)
    end
    local o_v20_11 = function(r_v10_138, r_v2_200, r_v3_214)
        local r_v7_244 = game:GetService("ReplicatedStorage")
        local r_v5_217 = r_v7_244.Remotes.Input
        local r_v6_264 = {
            [1] = "AutoToggle",
            [2] = r_v10_138,
            [3] = r_v3_214
        }
        o_v12_22(r_v5_217, r_v6_264)
        o_v16_14(r_v10_138, r_v2_200)
        r_v2_200 = nil
        r_v10_138 = nil
        r_v3_214 = nil
    end
    local o_v24_9 = function(r_v10_139, r_v2_201)
        task.spawn(function()
            repeat
                local r_v4_1068 = task
                r_v4_1068.wait()
                local r_v10_440 = r_v87_11()
                local r_v4_1071 = r_v10_139
            until r_v10_440 >= r_v4_1071
            local r_v1_1070 = (r_v69_99:WaitForChild("HUD")):WaitForChild("Setting")
            local r_v1_1073 = (r_v1_1070:WaitForChild("Page")):WaitForChild("Main")
            local r_v1_1076 = (r_v1_1073:WaitForChild("Scroll")):WaitForChild("SettingV2")
            local r_v4_1086 = ((r_v1_1076:WaitForChild("AutoSkip")):WaitForChild("Options")):WaitForChild("Toggle")
            local r_v10_450 = "CategoryName"
            r_v10_450 = r_v4_1086:WaitForChild(r_v10_450)
            if (r_v10_450.Text ~= r_v2_201) then
                o_v12_22((game:GetService("ReplicatedStorage")).Remotes.Input, {
                    [1] = "AutoSkipWaves_CHANGE"
                })
            end
        end)
    end
    local o_v45_5 = function()
        local r_v1_282 = task.spawn
        local r_v10_143 = function()
            local r_v10_451 = function(r_v10_1118)
                local r_v2_1809 = 0
                local r_v4_2841, r_v3_1827, r_v5_2031 = pairs(r_v74_49())
                local r_v6_2349 = r_v4_2841
                for r_v8_2477, r_v7_2312 in r_v6_2349, r_v3_1827, r_v5_2031 do
                    if (r_v7_2312.Name == r_v10_1118) then
                        r_v2_1809 = r_v2_1809 + 1
                    end
                end
                return r_v2_1809
            end
            local r_v1_1086 = {}
            local r_v3_741 = function()
                if ((#r_v1_1086) == 0) then
                    local r_v10_1121 = "Placeable"
                    r_v10_1121 = workspace:FindFirstChild(r_v10_1121)
                    local r_v4_2847 = r_v10_1121 and (r_v10_1121:FindFirstChild(("Base")))
                    if r_v4_2847 then
                        local r_v1_2418 = pairs
                        local r_v7_2314 = r_v3_5
                        local r_v5_2034 = r_v10_1121.Base
                        local r_v4_2849, r_v2_1814, r_v3_1830 = r_v1_2418(r_v5_2034.GetChildren(r_v5_2034))
                        local r_v5_2036 = r_v4_2849
                        for r_v6_2356, r_v8_2484 in r_v5_2036, r_v2_1814, r_v3_1830 do
                            local r_v11_1834 = r_v8_2484.IsA
                            local r_v9_2190 = (r_v11_1834(r_v8_2484, "BasePart")) and r_v8_2484
                            r_v7_2314 = r_v9_2190
                            if not r_v9_2190 then
                                r_v7_2314 = r_v8_2484:FindFirstChildWhichIsA("BasePart")
                            end
                            if r_v7_2314 then
                                table.insert(r_v1_1086, r_v7_2314)
                            end
                            r_v7_2314 = nil
                        end
                    end
                    if ((#r_v1_1086) == 0) then
                        local r_v1_2420 = pairs
                        local r_v6_2354 = workspace
                        local r_v7_2316 = r_v6_2354.GetDescendants
                        local r_v8_2486 = {
                            r_v7_2316(r_v6_2354)
                        }
                        for r_v6_2357, r_v8_2487 in r_v1_2420(unpack(r_v8_2486)) do
                            local r_v13_1710 = r_v8_2487.Name
                            local r_v11_1836 = r_v13_1710 == "Base_Part"
                            local r_v9_2191 = r_v11_1836
                            if not r_v11_1836 then
                                local r_v12_1500 = string.lower(r_v8_2487.Name)
                                r_v9_2191 = r_v12_1500 == "base"
                            end
                            local r_v7_2317 = r_v9_2191 and (r_v8_2487:IsA(("BasePart")))
                            if r_v7_2317 then
                                table.insert(r_v1_1086, r_v8_2487)
                            end
                        end
                    end
                end
                return r_v1_1086
            end
            while true do
                local r_v1_1088 = task.wait
                if not (r_v1_1088(0.6)) then
                    break
                end
                local r_v6_1059 = r_v40_42.auto_farm_enable
                local r_v4_1091 = (not r_v6_1059) or (r_v71_75())
                if r_v4_1091 then
                    r_v1_1086 = {}
                else
                    local r_v5_893 = r_v40_42.auto_farm_unit
                    if ((r_v10_451(r_v5_893) < 1) and (not o_v2_12)) then
                        local r_v7_1082 = r_v86_10()
                        local r_v9_985 = r_v83_19(r_v5_893)
                        if (r_v7_1082 >= r_v9_985) then
                            local r_v8_1114 = r_v3_741()
                            local r_v7_1086 = Vector3.new(0, 0, 0)
                            if ((#r_v8_1114) > 0) then
                                local r_v9_992 = math.random
                                local r_v13_756 = #r_v8_1114
                                r_v9_992 = r_v8_1114[r_v9_992(1, r_v13_756)]
                                local r_v13_757 = math
                                local r_v13_758 = r_v13_757.random()
                                local r_v14_890 = r_v13_758 - 0.5
                                local r_v13_759 = r_v9_992.Size.X
                                local r_v11_806 = r_v13_759 * 0.65
                                local r_v4_1100 = r_v14_890 * r_v11_806
                                local r_v12_633 = math
                                local r_v12_634 = r_v12_633.random()
                                local r_v11_807 = r_v12_634 - 0.5
                                local r_v12_635 = r_v9_992.Size.Z
                                local r_v13_762 = r_v12_635 * 0.65
                                r_v14_890 = r_v4_1100
                                local r_v4_1101 = r_v11_807 * r_v13_762
                                local r_v12_636 = r_v9_992.CFrame
                                local r_v15_507 = CFrame.new
                                local r_v20_231 = r_v9_992.Size.Y
                                local r_v17_353 = r_v20_231 / 2
                                r_v11_807 = r_v4_1101
                                local r_v16_423 = r_v15_507(r_v14_890, r_v17_353, r_v11_807)
                                local r_v4_1102 = (r_v12_636 * r_v16_423).Position
                                local r_v12_638 = RaycastParams
                                local r_v12_639 = r_v12_638.new()
                                local r_v19_177 = workspace:FindFirstChild("Placeable")
                                r_v7_1086 = r_v4_1102
                                local r_v16_427 = r_v19_177 or workspace
                                r_v12_639.FilterDescendantsInstances = {
                                    r_v16_427
                                }
                                local r_v16_430 = Enum.RaycastFilterType
                                r_v12_639.FilterType = r_v16_430.Include
                                local r_v13_767 = workspace
                                local r_v20_242 = Vector3.new(0, 50, 0)
                                local r_v16_431 = r_v7_1086 + r_v20_242
                                local r_v20_243 = Vector3
                                local r_v20_244 = r_v20_243.new(0, (-100), 0)
                                local r_v15_519 = r_v13_767:Raycast(r_v16_431, r_v20_244, r_v12_639)
                                if r_v15_519 then
                                    r_v7_1086 = r_v15_519.Position
                                end
                            else
                                local r_v9_993 = (r_v22_34.Character) and (r_v22_34.Character:FindFirstChild("HumanoidRootPart"))
                                if r_v9_993 then
                                    local r_v15_523 = math
                                    local r_v15_524 = r_v15_523.random()
                                    local r_v14_892 = (r_v15_524 - 0.5) * 10
                                    local r_v16_438 = math
                                    local r_v16_439 = r_v16_438.random()
                                    local r_v11_812 = (r_v16_439 - 0.5) * 10
                                    local r_v15_528 = r_v9_993.Position
                                    local r_v17_373 = Vector3.new(r_v14_892, 0, r_v11_812)
                                    r_v7_1086 = r_v15_528 + r_v17_373
                                end
                            end
                            local r_v14_894 = CFrame.new(r_v7_1086)
                            local r_v9_995 = r_v22_34.Character
                            local r_v11_816 = r_v9_995 and (r_v9_995:FindFirstChild(("HumanoidRootPart")))
                            if r_v11_816 then
                                local r_v11_817 = r_v9_995.HumanoidRootPart
                                local r_v20_272 = CFrame.new(0, 3, 0)
                                r_v11_817.CFrame = r_v14_894 * r_v20_272
                                local r_v11_818 = r_v9_995.HumanoidRootPart
                                r_v11_818.Velocity = Vector3.new(0, 0, 0)
                                task.wait(0.3)
                            end
                            local r_v17_397 = game:GetService("ReplicatedStorage")
                            local r_v11_820 = r_v17_397.Remotes.Input
                            local r_v17_400 = {
                                ["Rotation"] = 0,
                                ["cframe"] = r_v14_894,
                                ["Unit"] = r_v5_893
                            }
                            r_v11_820:FireServer("Summon", r_v17_400)
                        end
                    end
                    local r_v9_986 = r_v87_11()
                    local r_v7_1084 = r_v40_42.auto_farm_upgrade_wave
                    if (r_v9_986 >= r_v7_1084) then
                        local r_v8_1115 = pairs
                        local r_v15_497 = {
                            r_v74_49()
                        }
                        for r_v8_1116, r_v11_809 in r_v8_1115(unpack(r_v15_497)) do
                            local r_v20_248 = r_v11_809.Name
                            local r_v17_366 = r_v20_248 == r_v5_893
                            local r_v15_522 = r_v17_366
                            if r_v17_366 then
                                local r_v19_199 = r_v11_809:FindFirstChild("UpgradeTag")
                                local r_v17_374 = r_v19_199
                                if r_v19_199 then
                                    local r_v18_158 = r_v11_809.UpgradeTag.Value
                                    local r_v22_165 = r_v85_13(r_v5_893)
                                    r_v17_374 = r_v18_158 < r_v22_165
                                end
                                r_v15_522 = r_v17_374
                            end
                            if r_v15_522 then
                                local r_v16_444 = r_v84_15(r_v5_893, r_v11_809.UpgradeTag.Value + 1)
                                if (r_v86_10() >= r_v16_444) then
                                    local r_v19_209 = game:GetService("ReplicatedStorage")
                                    r_v19_209.Remotes.Server:InvokeServer("Upgrade", r_v11_809)
                                    task.wait(0.2)
                                end
                            end
                        end
                    end
                end
            end
        end
        r_v1_282(r_v10_143)
    end
    local o_v19_11 = function(r_v10_144, r_v2_204, r_v3_219)
        o_v16_14(r_v10_144, r_v2_204)
        o_v17_12(r_v3_219)
        r_v2_204 = nil
        r_v10_144 = nil
        r_v3_219 = nil
    end
    local o_v23_9 = function(r_v10_145)
        task.spawn(function()
            repeat
                local r_v4_1104 = task
                r_v4_1104.wait()
                local r_v4_1106 = r_v69_99.HUD.NextWaveVote
                local r_v10_457 = "Visible"
            until r_v4_1106[r_v10_457]
            while true do
                local r_v3_749 = r_v87_11()
                local r_v10_458 = r_v3_749 == r_v10_145
                local r_v4_1107 = r_v10_458
                if r_v10_458 then
                    local r_v2_740 = r_v69_99.HUD.NextWaveVote
                    r_v4_1107 = r_v2_740.Visible
                end
                if not r_v4_1107 then
                    break
                end
                o_v12_22((game:GetService("ReplicatedStorage")).Remotes.Input, {
                    [1] = "VoteWaveConfirm"
                })
                task.wait(1)
            end
        end)
    end
    local o_v68_6
    local o_v24_10 = {}
    local o_v29_5
    local o_v30_6 = function(r_v10_147)
        if (r_v10_147.Wave == nil) then
            r_v10_147.Wave = r_v87_11()
        end
        if (r_v10_147.EnemyCount == nil) then
            local r_v1_289 = 0
            pcall(function()
                local r_v10_467 = workspace.Enemies:GetChildren()
                r_v1_289 = #r_v10_467
            end)
            r_v10_147.EnemyCount = r_v1_289
        end
        table.insert(r_v40_43[r_v40_42.macro_profile].Macro, r_v10_147)
        Save()
        if (o_v29_5 ~= nil) then
            o_v29_5 = o_v29_5 + 1
        else
            o_v29_5 = 1
        end
        r_v10_147 = nil
    end
    o_v29_5 = nil
    local o_v28_8
    local o_v31_5 = function(r_v10_148, r_v2_221)
        local r_v4_303 = r_v10_148:WaitForChild("UpgradeTag", 60)
        if (r_v4_303 ~= nil) then
            return (r_v4_303:GetPropertyChangedSignal("Value")):Connect(function()
                local r_v4_1112 = (r_v40_42.macro_record) and (r_v40_42.macro_upgrade)
                if r_v4_1112 then
                    local r_v5_915 = o_v28_6()
                    local r_v7_1106 = r_v10_148.Name
                    local r_v6_1083 = {
                        ["Name"] = r_v7_1106,
                        ["Index"] = r_v2_221
                    }
                    local r_v7_1108 = {
                        [1] = "Upgrade",
                        [2] = "Target"
                    }
                    local r_v13_777 = r_v4_303.Value
                    local r_v14_908 = {
                        ["Level"] = r_v13_777
                    }
                    o_v28_8({
                        ["Time"] = r_v5_915,
                        ["Target"] = r_v6_1083,
                        ["Remote"] = r_v7_1108,
                        ["Parameter"] = r_v14_908
                    })
                end
            end)
        end
        return nil
    end
    local o_v35_4 = function()
        local r_v4_311 = (game:GetService("ReplicatedStorage")):WaitForChild("SpeedUP")
        return r_v4_311.Changed:Connect(function(r_v10_471)
            local r_v4_1114 = (r_v40_42.macro_record) and (r_v40_42.macro_speedchange)
            if r_v4_1114 then
                local r_v6_1087 = o_v28_6()
                local r_v8_1144 = {
                    [1] = "SpeedChange"
                }
                local r_v9_1020 = {
                    ["Speed"] = r_v10_471
                }
                o_v28_8({
                    ["Time"] = r_v6_1087,
                    ["Remote"] = r_v8_1144,
                    ["Parameter"] = r_v9_1020
                })
            end
            r_v10_471 = nil
        end)
    end
    o_v28_8 = o_v30_6
    local o_v33_4 = function()
        local r_v1_305 = (r_v69_99:WaitForChild("HUD")):WaitForChild("Setting")
        local r_v1_308 = (r_v1_305:WaitForChild("Page")):WaitForChild("Main")
        local r_v1_311 = (r_v1_308:WaitForChild("Scroll")):WaitForChild("SettingV2")
        local r_v10_164 = ((r_v1_311:WaitForChild("AutoSkip")):WaitForChild("Options")):WaitForChild("Toggle")
        local r_v1_317 = r_v10_164:WaitForChild("CategoryName")
        local r_v3_244 = r_v10_164:WaitForChild("TextButton")
        if (r_v3_244 ~= nil) then
            return r_v3_244.MouseButton1Click:Connect(function()
                local r_v4_1116 = (r_v40_42.macro_record) and (r_v40_42.macro_autoskipwave)
                if r_v4_1116 then
                    local r_v5_924 = o_v28_6()
                    local r_v6_1092 = {
                        [1] = "AutoSkipWaves_CHANGE"
                    }
                    local r_v11_838 = r_v87_11()
                    local r_v13_785 = r_v1_317.Text
                    local r_v7_1121 = {
                        ["Wave"] = r_v11_838,
                        ["Status"] = r_v13_785
                    }
                    o_v28_8({
                        ["Time"] = r_v5_924,
                        ["Remote"] = r_v6_1092,
                        ["Parameter"] = r_v7_1121
                    })
                end
            end)
        end
        return nil
    end
    local o_v34_5 = function()
        local r_v1_324 = function(r_v10_475)
            if (r_v10_475.Name == "MultipleAbilities") then
                local r_v2_757 = r_v2_3
                r_v2_757 = r_v10_475:WaitForChild("Frame")
                repeat
                    local r_v4_1121 = task
                    r_v4_1121.wait()
                    local r_v3_788 = r_v2_757:GetChildren()
                    local r_v4_1123 = #r_v3_788
                    local r_v3_789 = 1
                until r_v4_1123 > r_v3_789
                local r_v8_1161 = r_v2_757.GetChildren
                local r_v4_1125, r_v3_790, r_v5_934 = pairs(r_v8_1161(r_v2_757))
                local r_v6_1103 = r_v4_1125
                for r_v8_1165, r_v1_1121 in r_v6_1103, r_v3_790, r_v5_934 do
                    if (r_v1_1121.Name == "ImageButton") then
                        r_v1_1121.MouseButton1Click:Connect(function()
                            local r_v10_1128 = getgenv()
                            if r_v10_1128.IsAutoBuffClicking then
                                return
                            end
                            local r_v10_1129 = "TextLabel"
                            r_v10_1129 = r_v1_1121:WaitForChild(r_v10_1129)
                            local r_v4_2859 = (r_v40_42.macro_record) and (r_v40_42.macro_ability)
                            if r_v4_2859 then
                                local r_v6_2371 = o_v28_6()
                                local r_v8_2501 = {
                                    [1] = "MultipleAbilities"
                                }
                                local r_v11_1850 = r_v10_1129.Text
                                local r_v9_2215 = {
                                    ["Ability Name"] = r_v11_1850
                                }
                                o_v28_8({
                                    ["Time"] = r_v6_2371,
                                    ["Remote"] = r_v8_2501,
                                    ["Parameter"] = r_v9_2215
                                })
                            end
                        end)
                    end
                end
            end
            if (r_v10_475.Name == "KilluaWishes") then
                local r_v2_762 = (r_v10_475:WaitForChild("TextBackground")):WaitForChild("OptionsContainer")
                local r_v1_1115 = pairs
                local r_v7_1130 = r_v2_762.GetChildren
                local r_v8_1159 = {
                    r_v7_1130(r_v2_762)
                }
                for r_v8_1163, r_v1_1118 in r_v1_1115(unpack(r_v8_1159)) do
                    if (r_v1_1118.Name == "Option") then
                        r_v1_1118.MouseButton1Click:Connect(function()
                            local r_v10_1123 = getgenv()
                            if r_v10_1123.IsAutoBuffClicking then
                                return
                            end
                            local r_v4_2852 = (r_v40_42.macro_record) and (r_v40_42.macro_ability)
                            if r_v4_2852 then
                                local r_v5_2042 = o_v28_6()
                                local r_v6_2365 = {
                                    [1] = "KilluaWishes"
                                }
                                local r_v14_2020 = r_v1_1118.Text
                                local r_v7_2326 = {
                                    ["Ability Name"] = r_v14_2020
                                }
                                o_v28_8({
                                    ["Time"] = r_v5_2042,
                                    ["Remote"] = r_v6_2365,
                                    ["Parameter"] = r_v7_2326
                                })
                            end
                        end)
                    end
                end
            end
            r_v10_475 = nil
        end
        local r_v5_249 = r_v69_99
        local r_v4_334, r_v2_238, r_v3_245 = pairs(r_v5_249.GetChildren(r_v5_249))
        local r_v5_251 = r_v4_334
        for r_v6_297, r_v8_285 in r_v5_251, r_v2_238, r_v3_245 do
            r_v1_324(r_v8_285)
        end
        return r_v69_99.ChildAdded:Connect(function(r_v10_476)
            r_v1_324(r_v10_476)
            r_v10_476 = nil
        end)
    end
    local o_v32_5 = function()
        local r_v10_167 = r_v69_99:WaitForChild("HUD", 15)
        if (r_v10_167 ~= nil) then
            local r_v2_244 = 15
            r_v2_244 = r_v10_167:WaitForChild("NextWaveVote", r_v2_244)
            if (r_v2_244 == nil) then
                return nil
            else
                local r_v3_251 = 15
                r_v3_251 = r_v2_244:WaitForChild("YesButton", r_v3_251)
                if (r_v3_251 ~= nil) then
                    return r_v3_251.MouseButton1Click:Connect(function()
                        local r_v4_1127 = (r_v40_42.macro_record) and (r_v40_42.macro_skipwave)
                        if r_v4_1127 then
                            local r_v5_938 = o_v28_6()
                            local r_v6_1108 = {
                                [1] = "VoteWaveConfirm"
                            }
                            local r_v11_848 = r_v87_11()
                            local r_v7_1144 = {
                                ["Wave"] = r_v11_848
                            }
                            o_v28_8({
                                ["Time"] = r_v5_938,
                                ["Remote"] = r_v6_1108,
                                ["Parameter"] = r_v7_1144
                            })
                        end
                    end)
                else
                    -- empty block
                end
            end
        end
        return nil
    end
    local o_v66_6
    local o_v36_5 = function(r_v10_168, r_v2_245)
        table.insert(o_v24_10, o_v31_5(r_v10_168, r_v2_245))
        r_v2_245 = nil
        r_v10_168 = nil
    end
    local o_v37_5 = getrawmetatable(game)
    local o_v36_7 = o_v37_5.__namecall
    setreadonly(o_v37_5, false)
    local o_v41_6 = function(r_v10_169, ...)
        local r_v4_348 = getnamecallmethod()
        local r_v1_343 = {
            ...
        }
        local r_v3_255 = r_v4_348
        if ((r_v3_255 == "FireServer") or (r_v3_255 == ("InvokeServer"))) then
            local r_v7_268 = tostring(r_v10_169)
            local r_v6_310 = r_v7_268 == "Input"
            local r_v4_350 = r_v6_310
            if r_v6_310 then
                local r_v7_270 = r_v1_343
                local r_v6_312 = r_v7_270
                if r_v7_270 then
                    local r_v14_229 = type(r_v1_343[1])
                    r_v6_312 = r_v14_229 == "string"
                end
                r_v4_350 = r_v6_312
            end
            if r_v4_350 then
                task.spawn(function()
                    local r_v10_480 = r_v1_343[1]
                    if (r_v10_480 == "StoryModeLevel") then
                        local r_v3_798 = tostring
                        local r_v6_1111 = (r_v1_343[2]) or ("")
                        o_v1_10("\224\185\128\224\184\153\224\184\183\224\185\137\224\184\173\224\185\128\224\184\163\224\184\183\224\185\136\224\184\173\224\184\135", (r_v3_798(r_v6_1111)), "Story")
                    else
                        if (r_v10_480 == "InfiniteModeLevel") then
                            local r_v3_802 = tostring
                            local r_v6_1115 = (r_v1_343[2]) or ("")
                            o_v1_10("\224\184\159\224\184\178\224\184\163\224\185\140\224\184\161", (r_v3_802(r_v6_1115)), "Infinite")
                        else
                            if (r_v10_480 == "AdventureModeLevel") then
                                local r_v3_806 = tostring
                                local r_v6_1119 = (r_v1_343[2]) or ("")
                                o_v1_10("\224\185\128\224\184\163\224\184\148", (r_v3_806(r_v6_1119)), "Adventure")
                            else
                                local r_v3_808 = string.find(r_v10_480, "Level")
                                local r_v4_1135 = r_v3_808
                                if r_v3_808 then
                                    local r_v5_955 = type(r_v1_343[2])
                                    r_v4_1135 = r_v5_955 == "number"
                                end
                                if r_v4_1135 then
                                    o_v1_10("\224\184\171\224\184\173\224\184\132\224\184\173\224\184\162", (tostring(r_v1_343[2])), "Tower")
                                end
                            end
                        end
                    end
                end)
            end
        end
        if r_v40_42.macro_record then
            if ((r_v1_343 ~= nil) and (((#r_v1_343) > 1) and ((r_v3_255 == ("FireServer")) or (r_v3_255 == ("InvokeServer"))))) then
                local r_v8_301 = r_v1_343[1]
                local r_v4_356 = (r_v8_301 == "ChangePriority") and (r_v40_42.macro_priority)
                if r_v4_356 then
                    task.spawn(function()
                        local r_v5_960 = o_v28_6()
                        local r_v7_1167 = r_v1_343[2].Name
                        local r_v11_856 = o_v26_7(r_v1_343[2])
                        local r_v6_1130 = {
                            ["Name"] = r_v7_1167,
                            ["Index"] = r_v11_856
                        }
                        local r_v7_1169 = {
                            [1] = "ChangePriority",
                            [2] = "Target"
                        }
                        o_v28_8({
                            ["Time"] = r_v5_960,
                            ["Target"] = r_v6_1130,
                            ["Remote"] = r_v7_1169
                        })
                    end)
                else
                    local r_v8_304 = r_v1_343[1]
                    local r_v4_359 = (r_v8_304 == "UseSpecialMove") and (r_v40_42.macro_ability)
                    if r_v4_359 then
                        task.spawn(function()
                            local r_v10_482 = r_v1_343[2]
                            local r_v2_776 = r_v1_343[3]
                            local r_v4_1140 = r_v2_776
                            if not r_v2_776 then
                                r_v2_776 = ""
                                r_v4_1140 = r_v2_776
                            end
                            r_v2_776 = r_v4_1140
                            local r_v4_1141 = r_v10_482
                            if r_v10_482 then
                                local r_v7_1172 = typeof(r_v10_482)
                                local r_v6_1132 = r_v7_1172 == "Instance"
                                local r_v3_820 = r_v6_1132
                                if r_v6_1132 then
                                    local r_v7_1174 = table.find(r_v40_42.macro_ability_blacklist, r_v10_482.Name)
                                    r_v3_820 = r_v7_1174 == nil
                                end
                                r_v4_1141 = r_v3_820
                            end
                            if r_v4_1141 then
                                local r_v3_821 = r_v40_42.auto_buff
                                local r_v4_1142 = r_v3_821
                                if r_v3_821 then
                                    local r_v5_965 = r_v40_42.auto_buff_units[r_v10_482.Name]
                                    r_v4_1142 = r_v5_965 ~= nil
                                end
                                if r_v4_1142 then
                                    return
                                else
                                    local r_v8_1205 = o_v28_6()
                                    local r_v14_965 = r_v10_482.Name
                                    local r_v12_689 = o_v26_7(r_v10_482)
                                    local r_v7_1180 = {
                                        ["Name"] = r_v14_965,
                                        ["Index"] = r_v12_689
                                    }
                                    local r_v14_967 = {
                                        [1] = "UseSpecialMove",
                                        [2] = "Target",
                                        [3] = r_v2_776
                                    }
                                    o_v28_8({
                                        ["Time"] = r_v8_1205,
                                        ["Target"] = r_v7_1180,
                                        ["Remote"] = r_v14_967
                                    })
                                end
                            end
                        end)
                    else
                        local r_v8_307 = r_v1_343[1]
                        local r_v4_362 = (r_v8_307 == "AutoToggle") and (r_v40_42.macro_auto_ability)
                        if r_v4_362 then
                            task.spawn(function()
                                local r_v1_1141 = r_v1_343[2]
                                local r_v2_777 = r_v1_343[3]
                                local r_v1_1143 = ""
                                pcall(function()
                                    local r_v10_1130 = "SpecialMove"
                                    r_v10_1130 = r_v1_1141:FindFirstChild(r_v10_1130)
                                    local r_v2_1828 = r_v2_3
                                    r_v2_1828 = r_v10_1130:FindFirstChild("Special_Enabled")
                                    if r_v2_1828 then
                                        local r_v4_2867 = r_v2_1828:FindFirstChild("Special_Enabled_String")
                                        r_v1_1143 = r_v4_2867.Value
                                    end
                                end)
                                local r_v5_969 = r_v1_1141
                                local r_v4_1149 = r_v5_969
                                if r_v5_969 then
                                    local r_v8_1208 = typeof(r_v1_1141)
                                    r_v4_1149 = r_v8_1208 == "Instance"
                                end
                                if r_v4_1149 then
                                    local r_v5_971 = r_v40_42.auto_buff
                                    local r_v4_1150 = r_v5_971
                                    if r_v5_971 then
                                        local r_v6_1144 = r_v40_42.auto_buff_units[r_v1_1141.Name]
                                        r_v4_1150 = r_v6_1144 ~= nil
                                    end
                                    if r_v4_1150 then
                                        return
                                    else
                                        local r_v7_1187 = o_v28_6()
                                        local r_v11_880 = r_v1_1141.Name
                                        local r_v15_584 = o_v26_7(r_v1_1141)
                                        local r_v9_1083 = {
                                            ["Name"] = r_v11_880,
                                            ["Index"] = r_v15_584
                                        }
                                        local r_v11_882 = {
                                            [1] = "AutoToggle",
                                            [2] = "Target",
                                            [3] = r_v2_777
                                        }
                                        local r_v12_703 = {
                                            ["Ability String"] = r_v1_1143
                                        }
                                        o_v28_8({
                                            ["Time"] = r_v7_1187,
                                            ["Target"] = r_v9_1083,
                                            ["Remote"] = r_v11_882,
                                            ["Parameter"] = r_v12_703
                                        })
                                    end
                                end
                            end)
                        end
                    end
                end
            end
        end
        return o_v36_7(r_v10_169, ...)
    end
    o_v37_5.__namecall = newcclosure(o_v41_6)
    setreadonly(o_v37_5, true)
    StartMacroRecord = function()
        if (r_v40_43[r_v40_42.macro_profile].Macro == nil) then
            local r_v1_354 = r_v40_43[r_v40_42.macro_profile]
            r_v1_354.Macro = {}
        end
        if (r_v40_43[r_v40_42.macro_profile].Settings == nil) then
            local r_v1_356 = r_v40_43[r_v40_42.macro_profile]
            r_v1_356.Settings = {}
        end
        if (r_v40_43[r_v40_42.macro_profile].Units == nil) then
            local r_v1_358 = r_v40_43[r_v40_42.macro_profile]
            r_v1_358.Units = {}
        end
        if r_v71_75() then
            return
        end
        local r_v4_378 = workspace:WaitForChild("Unit")
        local r_v1_361 = pairs
        local r_v5_276 = r_v74_49
        for r_v6_347, r_v8_320 in r_v1_361(r_v5_276()) do
            local r_v14_247 = {
                o_v26_7(r_v8_320)
            }
            o_v36_5(r_v8_320, unpack(r_v14_247))
        end
        task.spawn(function()
            local r_v1_1146 = table.insert
            local r_v2_779 = r_v4_378.ChildAdded
            r_v1_1146(o_v24_10, r_v2_779.Connect(r_v2_779, function(r_v10_1131)
                local r_v2_1829 = r_v2_3
                r_v2_1829 = r_v10_1131:WaitForChild("Owner")
                local r_v3_1851 = tostring(r_v2_1829.Value)
                local r_v4_2870 = r_v67_96.Name
                if (r_v3_1851 == r_v4_2870) then
                    local r_v3_1852 = o_v26_7(r_v10_1131)
                    local r_v4_2872 = (r_v40_42.macro_record) and (r_v40_42.macro_summon)
                    if r_v4_2872 then
                        local r_v7_2340 = o_v28_6()
                        local r_v11_1858 = r_v10_1131.Name
                        local r_v9_2224 = {
                            ["Name"] = r_v11_1858,
                            ["Index"] = r_v3_1852
                        }
                        local r_v11_1860 = {
                            [1] = "Summon",
                            [2] = "Target"
                        }
                        o_v28_8({
                            ["Time"] = r_v7_2340,
                            ["Target"] = r_v9_2224,
                            ["Remote"] = r_v11_1860
                        })
                    end
                    o_v36_5(r_v10_1131, r_v3_1852)
                end
                r_v10_1131 = nil
            end))
        end)
        task.spawn(function()
            local r_v1_1147 = table.insert
            local r_v2_781 = r_v4_378.ChildRemoved
            r_v1_1147(o_v24_10, r_v2_781.Connect(r_v2_781, function(r_v10_1132)
                local r_v4_2875 = (r_v40_42.macro_record) and (r_v40_42.macro_sell)
                if r_v4_2875 then
                    local r_v2_1832 = r_v2_3
                    r_v2_1832 = r_v10_1132:WaitForChild("Owner")
                    local r_v3_1857 = tostring(r_v2_1832.Value)
                    local r_v4_2878 = r_v67_96.Name
                    if (r_v3_1857 == r_v4_2878) then
                        local r_v3_1858 = o_v26_7(r_v10_1132)
                        local r_v7_2346 = o_v28_6()
                        local r_v11_1866 = r_v10_1132.Name
                        local r_v9_2231 = {
                            ["Name"] = r_v11_1866,
                            ["Index"] = r_v3_1858
                        }
                        local r_v11_1868 = {
                            [1] = "Sell",
                            [2] = "Target"
                        }
                        o_v28_8({
                            ["Time"] = r_v7_2346,
                            ["Target"] = r_v9_2231,
                            ["Remote"] = r_v11_1868
                        })
                        Save()
                    end
                end
                r_v10_1132 = nil
            end))
        end)
        task.spawn(function()
            table.insert(o_v24_10, o_v32_5())
        end)
        task.spawn(function()
            table.insert(o_v24_10, o_v34_5())
        end)
        task.spawn(function()
            table.insert(o_v24_10, o_v33_4())
        end)
        task.spawn(function()
            table.insert(o_v24_10, o_v35_4())
        end)
        r_v67_92("\224\185\128\224\184\163\224\184\180\224\185\136\224\184\161\224\184\154\224\184\177\224\184\153\224\184\151\224\184\182\224\184\129\224\184\161\224\184\178\224\185\130\224\184\132\224\184\163", "\224\184\163\224\184\176\224\184\154\224\184\154\224\184\129\224\184\179\224\184\165\224\184\177\224\184\135\224\184\136\224\184\148\224\184\136\224\184\179\224\184\129\224\184\178\224\184\163\224\184\129\224\184\163\224\184\176\224\184\151\224\184\179\224\184\130\224\184\173\224\184\135\224\184\132\224\184\184\224\184\147...", 6.5)
    end
    StopMacroRecord = function()
        local r_v1_370 = pairs
        for r_v5_288, r_v6_358 in r_v1_370(o_v24_10) do
            r_v6_358:Disconnect()
        end
        o_v24_10 = {}
        r_v67_92("\224\184\171\224\184\162\224\184\184\224\184\148\224\184\154\224\184\177\224\184\153\224\184\151\224\184\182\224\184\129\224\184\161\224\184\178\224\185\130\224\184\132\224\184\163", "\224\184\129\224\184\178\224\184\163\224\184\154\224\184\177\224\184\153\224\184\151\224\184\182\224\184\129\224\184\150\224\184\185\224\184\129\224\184\155\224\184\180\224\184\148\224\185\128\224\184\163\224\184\181\224\184\162\224\184\154\224\184\163\224\185\137\224\184\173\224\184\162\224\185\129\224\184\165\224\185\137\224\184\167...", 6.5)
    end
    StartMacroPlayback = function()
        if r_v71_75() then
            return
        end
        table.sort(r_v40_43[r_v40_42.macro_profile].Macro, function(r_v10_504, r_v2_790)
            local r_v4_1164 = r_v10_504.Time
            local r_v3_842 = r_v2_790.Time
            return (r_v4_1164 < r_v3_842)
        end)
        local r_v4_387, r_v10_193 = next(r_v40_43[r_v40_42.macro_profile].Macro, o_v29_5)
        o_v29_5 = r_v4_387
        _ = r_v10_193
        while true do
            if not o_v29_5 then
                break
            end
            local r_v3_297 = r_v40_43[r_v40_42.macro_profile]
            local r_v1_380 = r_v3_297.Macro[o_v29_5]
            if (r_v40_42.macro_timer_version == "\224\185\128\224\184\167\224\184\165\224\184\178+\224\184\163\224\184\173\224\185\128\224\184\167\224\184\159 (\224\185\129\224\184\161\224\185\136\224\184\153\224\184\162\224\184\179\224\184\170\224\184\185\224\184\135)") then
                local r_v6_371 = r_v1_380.Wave
                local r_v5_302 = r_v6_371 ~= nil
                local r_v3_300 = r_v5_302
                if r_v5_302 then
                    local r_v6_373 = r_v1_380.Wave
                    r_v3_300 = r_v6_373 > 0
                end
                if r_v3_300 then
                    local r_v8_348 = r_v87_11()
                    local r_v6_376 = r_v1_380.Wave
                    if r_v8_348 < r_v6_376 then
                        local r_v6_378 = r_v40_42.macro_playback
                    end
                    repeat
                        local r_v3_308 = task
                        r_v3_308.wait()
                        local r_v8_356 = r_v87_11()
                        local r_v6_383 = r_v1_380.Wave
                        local r_v5_314 = r_v8_356 >= r_v6_383
                        local r_v3_310 = r_v5_314
                        if not r_v5_314 then
                            local r_v6_385 = r_v40_42.macro_playback
                            r_v3_310 = not r_v6_385
                        end
                    until r_v3_310
                end
            end
            local r_v7_317 = r_v100_10()
            local r_v8_343 = r_v40_42.macro_playback_time_offset
            local r_v6_372 = r_v7_317 + r_v8_343
            local r_v8_344 = r_v1_380.Time
            if r_v6_372 < r_v8_344 then
                local r_v6_374 = r_v40_42.macro_playback
            end
            repeat
                local r_v3_304 = task
                r_v3_304.wait()
                local r_v7_324 = r_v100_10()
                local r_v8_352 = r_v40_42.macro_playback_time_offset
                local r_v6_379 = r_v7_324 + r_v8_352
                local r_v8_353 = r_v1_380.Time
                local r_v5_310 = r_v6_379 >= r_v8_353
                local r_v3_307 = r_v5_310
                if not r_v5_310 then
                    local r_v6_381 = r_v40_42.macro_playback
                    r_v3_307 = not r_v6_381
                end
            until r_v3_307
            local r_v3_311 = r_v40_42.macro_playback
            if (not r_v3_311) then
                r_v3_311 = nil
                break
            else
                local r_v3_312 = r_v1_380.Remote
                if (r_v1_380.Target == nil) then
                    if (r_v3_312[1] == "VoteWaveConfirm") then
                        o_v23_9(r_v1_380.Parameter.Wave)
                    else
                        if (r_v3_312[1] == "AutoSkipWaves_CHANGE") then
                            o_v24_9(r_v1_380.Parameter.Wave, r_v1_380.Parameter.Status)
                        else
                            if (r_v3_312[1] == "MultipleAbilities") then
                                o_v17_12(r_v1_380.Parameter["Ability Name"])
                            else
                                if (r_v3_312[1] == "KilluaWishes") then
                                    o_v18_12(r_v1_380.Parameter["Ability Name"])
                                else
                                    if (r_v3_312[1] == "SpeedChange") then
                                        local r_v8_381 = game:GetService("ReplicatedStorage")
                                        local r_v1_401 = r_v8_381.Remotes.Input
                                        local r_v7_357 = r_v1_380.Parameter.Speed
                                        local r_v14_302 = r_v72_64()
                                        r_v1_401:FireServer("SpeedChange", r_v7_357 > r_v14_302)
                                    end
                                end
                            end
                        end
                    end
                else
                    local r_v5_320, r_v6_391, r_v8_362 = o_v27_6(r_v1_380.Target)
                    local r_v8_363 = (r_v5_320 == nil) and (r_v6_391 and r_v8_362)
                    if r_v8_363 then
                        local r_v14_286 = r_v3_312[1]
                        local r_v9_323 = r_v14_286 == "Summon"
                        r_v8_363 = r_v9_323
                        if r_v9_323 then
                            r_v8_363 = r_v40_42.macro_summon
                        end
                        if r_v8_363 then
                            task.spawn(function()
                                o_v14_19(r_v8_362, r_v6_391, r_v1_380.Target.Name)
                            end)
                        else
                            r_v8_363 = 0
                            if r_v5_320 == nil then
                                local r_v12_193 = r_v40_42.macro_playback_search_attempts
                                local r_v13_225 = r_v8_363 >= r_v12_193
                                local r_v14_303 = r_v13_225
                                if not r_v13_225 then
                                    local r_v12_202 = r_v40_42.macro_playback
                                    r_v14_303 = not r_v12_202
                                end
                            end
                            repeat
                                task.wait(r_v40_42.macro_playback_search_delay)
                                local r_v9_343, r_v14_307, r_v11_268 = o_v27_6(r_v1_380.Target)
                                r_v5_320 = r_v9_343
                                r_v6_391 = r_v14_307
                                r_v8_362 = r_v11_268
                                r_v8_363 = r_v8_363 + 1
                                local r_v15_157 = r_v5_320 ~= nil
                                local r_v13_234 = r_v15_157
                                if not r_v15_157 then
                                    local r_v20_54 = r_v40_42.macro_playback_search_attempts
                                    local r_v17_117 = r_v8_363 >= r_v20_54
                                    local r_v15_160 = r_v17_117
                                    if not r_v17_117 then
                                        local r_v20_56 = r_v40_42.macro_playback
                                        r_v15_160 = not r_v20_56
                                    end
                                    r_v13_234 = r_v15_160
                                end
                            until r_v13_234
                            r_v8_363 = nil
                        end
                    end
                    if (r_v5_320 ~= nil) then
                        local r_v15_143 = r_v3_312[1]
                        local r_v8_373 = (r_v15_143 == "Upgrade") and (r_v40_42.macro_upgrade)
                        if r_v8_373 then
                            task.spawn(function()
                                o_v15_17(r_v5_320, r_v1_380.Parameter.Level)
                            end)
                        else
                            local r_v15_151 = r_v3_312[1]
                            local r_v12_197 = r_v15_151 == "UseSpecialMove"
                            local r_v8_386 = r_v12_197
                            if r_v12_197 then
                                local r_v16_138 = r_v40_42.macro_ability
                                local r_v12_203 = r_v16_138
                                if r_v16_138 then
                                    local r_v20_52 = table.find(r_v40_42.macro_ability_blacklist, r_v5_320.Name)
                                    r_v12_203 = r_v20_52 == nil
                                end
                                r_v8_386 = r_v12_203
                            end
                            if r_v8_386 then
                                o_v16_14(r_v5_320, r_v3_312[3])
                            else
                                local r_v15_159 = r_v3_312[1]
                                local r_v8_388 = (r_v15_159 == "AutoToggle") and (r_v40_42.macro_auto_ability)
                                if r_v8_388 then
                                    o_v20_11(r_v5_320, r_v1_380.Parameter["Ability String"], r_v3_312[3])
                                else
                                    local r_v15_163 = r_v3_312[1]
                                    local r_v8_390 = (r_v15_163 == "ChangePriority") and (r_v40_42.macro_priority)
                                    if r_v8_390 then
                                        o_v21_10(r_v5_320)
                                    else
                                        local r_v15_165 = r_v3_312[1]
                                        local r_v8_392 = (r_v15_165 == "Sell") and (r_v40_42.macro_sell)
                                        if r_v8_392 then
                                            o_v22_11(r_v5_320)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                local r_v6_400, r_v8_370 = next(r_v40_43[r_v40_42.macro_profile].Macro, o_v29_5)
                o_v29_5 = r_v6_400
                _ = r_v8_370
                local r_v7_344 = task
                r_v7_344.wait()
            end
        end
    end
    StopMacroPlayback = function()
        if r_v71_75() then
            return
        end
    end
    ManualMapUnitToMacro = function()
        if r_v71_75() then
            r_v67_92("Macro", "\224\184\149\224\185\137\224\184\173\224\184\135\224\184\173\224\184\162\224\184\185\224\185\136\224\185\131\224\184\153\224\184\148\224\185\136\224\184\178\224\184\153\224\184\150\224\184\182\224\184\135\224\184\136\224\184\176\224\185\129\224\184\173\224\184\148\224\184\149\224\184\177\224\184\167\224\184\165\224\184\176\224\184\132\224\184\163\224\185\128\224\184\130\224\185\137\224\184\178 Macro \224\185\132\224\184\148\224\185\137!", 3)
            return
        end
        if (r_v40_43[r_v40_42.macro_profile] == nil) then
            r_v40_43[r_v40_42.macro_profile] = r_v31_24(r_v58_70)
        end
        local r_v10_199 = r_v74_49()
        if ((#r_v10_199) == 0) then
            r_v67_92("Macro", "\224\185\132\224\184\161\224\185\136\224\184\158\224\184\154\224\184\149\224\184\177\224\184\167\224\184\165\224\184\176\224\184\132\224\184\163\224\184\130\224\184\173\224\184\135\224\184\132\224\184\184\224\184\147\224\185\131\224\184\153\224\184\148\224\185\136\224\184\178\224\184\153!", 3)
            return
        end
        local r_v2_291 = nil
        local r_v3_322 = math.huge
        local r_v5_346 = r_v22_34.Character
        local r_v4_397 = r_v5_346
        if r_v5_346 then
            r_v5_346 = r_v22_34.Character
            r_v4_397 = r_v5_346:FindFirstChild("HumanoidRootPart")
        end
        r_v5_346 = r_v4_397
        if r_v5_346 then
            local r_v4_399, r_v6_424, r_v8_404 = pairs(r_v10_199)
            local r_v7_368 = r_v4_399
            for r_v9_351, r_v14_312 in r_v7_368, r_v6_424, r_v8_404 do
                local r_v11_272 = "HumanoidRootPart"
                r_v11_272 = r_v14_312:FindFirstChild(r_v11_272)
                if r_v11_272 then
                    local r_v12_216 = r_v5_346.Position
                    local r_v15_174 = r_v11_272.Position
                    local r_v13_252 = r_v12_216 - r_v15_174
                    r_v13_252 = r_v13_252.Magnitude
                    if (r_v13_252 < r_v3_322) then
                        local r_v12_218 = r_v14_312
                        r_v3_322 = r_v13_252
                        r_v2_291 = r_v12_218
                    end
                end
            end
        else
            r_v2_291 = r_v10_199[#r_v10_199]
        end
        if r_v2_291 then
            local r_v7_369 = o_v26_7(r_v2_291)
            local r_v15_169 = o_v28_6()
            local r_v20_66 = r_v2_291.Name
            local r_v16_157 = {
                ["Name"] = r_v20_66,
                ["Index"] = r_v7_369
            }
            local r_v20_68 = {
                [1] = "Summon",
                [2] = "Target"
            }
            o_v28_8({
                ["Time"] = r_v15_169,
                ["Target"] = r_v16_157,
                ["Remote"] = r_v20_68
            })
            Save()
            r_v67_92("Macro Mapped", "\224\185\128\224\184\158\224\184\180\224\185\136\224\184\161\224\184\162\224\184\185\224\184\153\224\184\180\224\184\149: " .. r_v2_291.Name .. " \224\185\128\224\184\130\224\185\137\224\184\178\224\184\161\224\184\178\224\185\130\224\184\132\224\184\163\224\185\128\224\184\163\224\184\181\224\184\162\224\184\154\224\184\163\224\185\137\224\184\173\224\184\162\224\185\129\224\184\165\224\185\137\224\184\167!", 4)
        end
    end
    local o_v36_16 = false
    AutoVoteExtreme = function()
        if o_v36_16 then
            return
        end
        o_v36_16 = true
        task.spawn(function()
            while true do
                if not (r_v40_42.auto_vote_extreme) then
                    break
                end
                local r_v4_1168 = r_v69_99.HUD.ModeVoteFrame
                if r_v4_1168.Visible then
                    local r_v2_800 = game:GetService("ReplicatedStorage")
                    r_v2_800.Remotes.Input:FireServer("VoteGameMode", "Extreme")
                end
                task.wait(1)
            end
            o_v36_16 = false
        end)
    end
    local o_v36_18 = false
    AutoVoteNormal = function()
        if o_v36_18 then
            return
        end
        o_v36_18 = true
        task.spawn(function()
            while true do
                if not (r_v40_42.auto_vote_normal) then
                    break
                end
                local r_v4_1176 = r_v69_99.HUD.ModeVoteFrame
                if r_v4_1176.Visible then
                    local r_v2_812 = game:GetService("ReplicatedStorage")
                    r_v2_812.Remotes.Input:FireServer("VoteGameMode", "Normal")
                end
                task.wait(1)
            end
            o_v36_18 = false
        end)
    end
    local o_v36_20 = false
    AutoBattle = function()
        if o_v36_20 then
            return
        end
        o_v36_20 = true
        task.spawn(function()
            while true do
                if not (r_v40_42.auto_battle) then
                    break
                end
                pcall(function()
                    local r_v2_1836 = r_v69_99.HUD:FindFirstChild("FastForward")
                    local r_v4_2883 = r_v2_1836
                    if r_v2_1836 then
                        local r_v5_2071 = r_v69_99.HUD.FastForward:FindFirstChild("Autoplay")
                        local r_v10_1134 = r_v5_2071
                        if r_v5_2071 then
                            local r_v5_2072 = r_v69_99.HUD.FastForward.Autoplay
                            r_v10_1134 = r_v5_2072.Visible
                        end
                        r_v4_2883 = r_v10_1134
                    end
                    if r_v4_2883 then
                        local r_v5_2073 = r_v69_99.HUD.FastForward
                        local r_v2_1838 = r_v5_2073.Autoplay.BackgroundColor3
                        local r_v3_1864 = Color3.fromRGB
                        if (not r_v41_35(r_v2_1838, r_v3_1864(10, 230, 0))) then
                            local r_v3_1865 = r_v88_10()
                            local r_v2_1840 = r_v40_42.auto_battle_gems
                            local r_v10_1136 = r_v3_1865 >= r_v2_1840
                            local r_v4_2885 = r_v10_1136
                            if r_v10_1136 then
                                local r_v2_1841 = r_v69_99.HUD.ModeVoteFrame.Visible
                                r_v4_2885 = not r_v2_1841
                            end
                            if r_v4_2885 then
                                local r_v2_1845 = game:GetService("ReplicatedStorage")
                                r_v2_1845.Remotes.Input:FireServer("BuyAutoBattle")
                                task.wait(1.5)
                            else
                                local r_v10_1145 = r_v88_10()
                                local r_v4_2893 = r_v40_42.auto_battle_gems
                                if (r_v10_1145 < r_v4_2893) then
                                    r_v40_42.auto_battle = false
                                    r_v67_92("Auto Battle", "\224\185\128\224\184\158\224\184\138\224\184\163\224\185\132\224\184\161\224\185\136\224\184\158\224\184\173\224\184\149\224\184\178\224\184\161\224\184\151\224\184\181\224\185\136\224\184\149\224\184\177\224\185\137\224\184\135\224\184\132\224\185\136\224\184\178\224\185\132\224\184\167\224\185\137!", 5)
                                end
                            end
                        end
                    end
                end)
                task.wait(1)
            end
            o_v36_20 = false
        end)
    end
    local o_v36_22 = false
    AutoChangeSpeed = function()
        if o_v36_22 then
            return
        end
        o_v36_22 = true
        task.spawn(function()
            repeat
                task.wait(1)
                local r_v10_536 = r_v72_64()
                local r_v4_1193 = nil
            until r_v10_536 ~= r_v4_1193
            while true do
                local r_v4_1194 = (r_v40_42.auto_2x) or (r_v40_42.auto_3x)
                if not r_v4_1194 then
                    break
                end
                local r_v3_870 = r_v40_42.auto_3x
                local r_v10_539 = r_v3_870 and 3
                r_v10_539 = r_v10_539 or 2
                local r_v2_824 = r_v72_64()
                if (r_v2_824 < r_v10_539) then
                    local r_v6_1193 = game:GetService("ReplicatedStorage")
                    r_v6_1193.Remotes.Input:FireServer("SpeedChange", true)
                else
                    if (r_v2_824 > r_v10_539) then
                        local r_v6_1201 = game:GetService("ReplicatedStorage")
                        r_v6_1201.Remotes.Input:FireServer("SpeedChange", false)
                    end
                end
                task.wait(1)
            end
            o_v36_22 = false
        end)
    end
    SmartAutoNext = function()
        local r_v4_407 = r_v69_99.HUD:WaitForChild("MissionEnd")
        repeat
            local r_v4_409 = task
            r_v4_409.wait()
            local r_v4_411 = r_v4_407
            local r_v2_309 = "Visible"
        until r_v4_411[r_v2_309]
        local r_v1_445 = (r_v4_407:WaitForChild("BG")):WaitForChild("Actions")
        local r_v2_312 = "Replay"
        r_v2_312 = r_v1_445:WaitForChild(r_v2_312)
        local r_v1_449 = (r_v4_407:WaitForChild("BG")):WaitForChild("Actions")
        local r_v3_337 = "Next"
        local r_v4_423 = r_v1_449:WaitForChild(r_v3_337)
        local r_v5_362 = false
        r_v3_337 = r_v4_423
        while true do
            if not (r_v40_42.smart_auto_next) then
                break
            end
            if (not r_v5_362) then
                r_v5_362 = true
                local r_v4_425 = o_v2_13 or ("Victory")
                local r_v6_444
                local r_v7_387 = function()
                    local r_v1_1172 = string.lower
                    local r_v10_542 = r_v4_407.BG.Title.Text
                    r_v10_542 = r_v1_1172(r_v10_542)
                    local r_v4_1205 = (string.find(r_v10_542, "defeat")) or ((string.find(r_v10_542, "lose")) or (string.find(r_v10_542, "fail")))
                    if r_v4_1205 then
                        r_v6_444 = "Defeat"
                    end
                end
                r_v6_444 = r_v4_425
                pcall(r_v7_387)
                local r_v4_427 = (r_v6_444 == "Defeat") and (r_v2_312.Visible)
                if r_v4_427 then
                    firesignal(r_v2_312.Activated)
                else
                    local r_v4_429 = (r_v6_444 == "Victory") and (r_v3_337.Visible)
                    if r_v4_429 then
                        firesignal(r_v3_337.Activated)
                    else
                        if r_v2_312.Visible then
                            firesignal(r_v2_312.Activated)
                        end
                    end
                end
                task.wait(2)
                r_v5_362 = false
            end
            task.wait(1)
        end
    end
    AutoReplay = function()
        local r_v1_457 = r_v69_99.HUD
        local r_v10_213 = "MissionEnd"
        r_v10_213 = r_v1_457:WaitForChild(r_v10_213)
        repeat
            local r_v4_440 = task
            r_v4_440.wait()
            local r_v4_442 = "Visible"
        until r_v10_213[r_v4_442]
        local r_v4_446 = (r_v10_213:WaitForChild("BG")):WaitForChild("Actions")
        local r_v2_321 = "Replay"
        r_v2_321 = r_v4_446:WaitForChild(r_v2_321)
        while true do
            if not (r_v40_42.auto_replay) then
                break
            end
            local r_v4_448 = (r_v40_42.auto_next_story) or (r_v40_42.smart_auto_next)
            if r_v4_448 then
                break
            end
            if r_v2_321.Visible then
                firesignal(r_v2_321.Activated)
            end
            task.wait(1)
        end
    end
    AutoNextStory = function()
        local r_v1_471 = r_v69_99.HUD
        local r_v10_215 = "MissionEnd"
        r_v10_215 = r_v1_471:WaitForChild(r_v10_215)
        repeat
            local r_v4_459 = task
            r_v4_459.wait()
            local r_v4_461 = "Visible"
        until r_v10_215[r_v4_461]
        local r_v4_465 = (r_v10_215:WaitForChild("BG")):WaitForChild("Actions")
        local r_v2_330 = "Next"
        r_v2_330 = r_v4_465:WaitForChild(r_v2_330)
        while true do
            if not (r_v40_42.auto_next_story) then
                break
            end
            if r_v40_42.smart_auto_next then
                break
            end
            if r_v2_330.Visible then
                firesignal(r_v2_330.Activated)
            end
            task.wait(1)
        end
    end
    isSmartSkipLoop = false
    SmartSkipWaveLoop = function()
        local r_v4_473 = isSmartSkipLoop or (r_v71_75())
        if r_v4_473 then
            return
        end
        isSmartSkipLoop = true
        task.spawn(function()
            while true do
                if not (r_v40_42.smart_skip_enable) then
                    break
                end
                pcall(function()
                    local r_v1_2456 = r_v69_99.HUD
                    local r_v10_1150 = "NextWaveVote"
                    r_v10_1150 = r_v1_2456:FindFirstChild(r_v10_1150)
                    local r_v4_2900 = r_v10_1150 and (r_v10_1150.Visible)
                    if r_v4_2900 then
                        local r_v2_1856 = 0
                        local r_v1_2458 = workspace
                        if r_v1_2458.FindFirstChild(r_v1_2458, "Enemies") then
                            local r_v3_1884 = workspace.Enemies:GetChildren()
                            r_v2_1856 = #r_v3_1884
                        end
                        local r_v6_2419 = r_v40_42.smart_skip_enemy_count
                        local r_v3_1885 = r_v6_2419 or 5
                        if (r_v2_1856 <= r_v3_1885) then
                            task.wait(r_v40_42.smart_skip_delay or 0)
                            local r_v6_2425 = game:GetService("ReplicatedStorage")
                            r_v6_2425.Remotes.Input:FireServer("VoteWaveConfirm")
                            task.wait(2)
                        end
                    end
                end)
                task.wait(0.5)
            end
            isSmartSkipLoop = false
        end)
    end
    AutoUpgrade = function()
        while true do
            -- optimized-out if statement
            while true do
                local r_v3_370 = r_v86_10()
                local r_v2_337 = r_v40_42.auto_upgrade_money
                local r_v10_220 = r_v3_370 >= r_v2_337
                local r_v4_476 = r_v10_220
                if r_v10_220 then
                    local r_v6_475 = r_v87_11()
                    local r_v5_393 = r_v40_42.auto_upgrade_wave
                    local r_v3_371 = r_v6_475 >= r_v5_393
                    local r_v10_221 = r_v3_371
                    if r_v3_371 then
                        local r_v6_476 = r_v40_42.auto_upgrade
                        local r_v3_372 = r_v6_476
                        if r_v6_476 then
                            local r_v7_422 = r_v87_11()
                            local r_v8_476 = r_v40_42.auto_upgrade_wave_stop
                            r_v3_372 = r_v7_422 < r_v8_476
                        end
                        r_v10_221 = r_v3_372
                    end
                    r_v4_476 = r_v10_221
                end
                if not r_v4_476 then
                    break
                end
                local r_v4_478, r_v10_222, r_v2_339 = ipairs(r_v74_49())
                local r_v3_375 = r_v4_478
                for r_v5_399, r_v6_479 in r_v3_375, r_v10_222, r_v2_339 do
                    local r_v9_386 = r_v78_33(r_v6_479.Name)
                    local r_v8_479 = r_v9_386
                    if r_v9_386 then
                        local r_v14_339 = r_v6_479:FindFirstChild("UpgradeTag")
                        local r_v7_426 = r_v14_339
                        if r_v14_339 then
                            local r_v11_296 = r_v6_479.UpgradeTag.Value
                            local r_v12_235 = r_v85_13(r_v6_479.Name)
                            r_v7_426 = r_v11_296 < r_v12_235
                        end
                        r_v8_479 = r_v7_426
                    end
                    if r_v8_479 then
                        local r_v11_300 = game:GetService("ReplicatedStorage")
                        local r_v7_427 = r_v11_300.Remotes.Server
                        local r_v9_389 = {
                            "Upgrade",
                            r_v6_479
                        }
                        o_v12_22(r_v7_427, r_v9_389)
                        task.wait(0.1)
                    end
                end
                task.wait(1)
            end
            local r_v2_340 = r_v87_11()
            local r_v10_224 = r_v40_42.auto_upgrade_wave_stop
            if (r_v2_340 >= r_v10_224) then
                r_v40_42.auto_upgrade = false
                break
            else
                task.wait(1)
            end
        end
    end
    AutoSell = function()
        local r_v10_234 = function(r_v10_551)
            if (not r_v40_42.auto_sell_blacklist) then
                return false
            end
            local r_v2_841 = string.split(r_v40_42.auto_sell_blacklist, ",")
            local r_v1_1185 = pairs
            for r_v8_1294, r_v7_1240 in r_v1_1185(r_v2_841) do
                local r_v9_1130 = string.match(r_v7_1240, "^%s*(.-)%s*$")
                local r_v14_1013 = r_v9_1130 and ((r_v9_1130 ~= "") and (string.find((string.lower(r_v10_551)), (string.lower(r_v9_1130)), 1, true)))
                if r_v14_1013 then
                    return true
                else
                    r_v9_1130 = nil
                end
            end
            return false
        end
        local r_v2_359 = r_v87_11()
        local r_v4_498 = r_v40_42.auto_upgrade_wave_sell
        if (r_v2_359 >= r_v4_498) then
            while true do
                if not (r_v40_42.auto_upgrade_sell) then
                    break
                end
                local r_v2_361 = false
                local r_v1_517 = ipairs
                local r_v6_514 = workspace.Unit
                local r_v7_471 = r_v6_514.GetChildren
                for r_v8_520, r_v7_472 in r_v1_517(r_v7_471(r_v6_514)) do
                    local r_v14_366 = r_v7_472:FindFirstChild("Owner")
                    local r_v9_428 = r_v14_366
                    if r_v14_366 then
                        local r_v13_309 = tostring(r_v7_472.Owner.Value)
                        local r_v11_321 = r_v67_96.Name
                        r_v9_428 = r_v13_309 == r_v11_321
                    end
                    if r_v9_428 then
                        if (not r_v10_234(r_v7_472.Name)) then
                            local r_v12_276 = game:GetService("ReplicatedStorage")
                            local r_v14_370 = r_v12_276.Remotes.Input
                            local r_v11_325 = {
                                "Sell",
                                r_v7_472
                            }
                            o_v12_22(r_v14_370, r_v11_325)
                            local r_v9_432 = task.wait
                            r_v2_361 = true
                            r_v9_432(0.6)
                        end
                    end
                end
                if (not r_v2_361) then
                    r_v2_361 = nil
                    break
                else
                    task.wait(1)
                    r_v2_361 = nil
                end
            end
        end
    end
    local o_v43_15 = false
    AutoFarmSetup = o_v45_5
    local o_v43_16 = function()
        local r_v4_502 = o_v43_15 or (r_v71_75())
        if r_v4_502 then
            return
        end
        o_v43_15 = true
        local r_v4_503 = task.spawn
        local r_v2_365 = function()
            local r_v10_552 = false
            while true do
                local r_v2_842 = r_v40_42.air_unit_first
                local r_v4_1222 = r_v2_842
                if r_v2_842 then
                    local r_v6_1236 = r_v40_42.air_unit_name
                    local r_v5_1055 = r_v6_1236 ~= ""
                    local r_v2_843 = r_v5_1055
                    if r_v5_1055 then
                        local r_v6_1237 = r_v40_42.air_unit_name
                        r_v2_843 = r_v6_1237 ~= "\224\185\132\224\184\161\224\185\136\224\185\132\224\184\148\224\185\137\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129 (None)"
                    end
                    r_v4_1222 = r_v2_843
                end
                if not r_v4_1222 then
                    break
                end
                if ((not r_v10_552) and o_v2_14) then
                    local r_v2_847 = "air_unit_name"
                    r_v2_847 = r_v40_42[r_v2_847]
                    local r_v3_905 = r_v86_10()
                    local r_v5_1058 = r_v83_19(r_v2_847)
                    if (r_v3_905 >= r_v5_1058) then
                        local r_v3_908 = nil
                        local r_v5_1062 = "Placeable"
                        r_v5_1062 = workspace:FindFirstChild(r_v5_1062)
                        local r_v6_1241 = "Enemies"
                        r_v6_1241 = workspace:FindFirstChild(r_v6_1241)
                        local r_v4_1235 = r_v5_1062
                        if r_v5_1062 then
                            local r_v9_1140 = r_v5_1062.FindFirstChild
                            r_v4_1235 = (r_v9_1140(r_v5_1062, "Hill")) and r_v6_1241
                        end
                        if r_v4_1235 then
                            local r_v8_1306 = r_v2_3
                            local r_v13_850 = r_v6_1241.GetChildren
                            r_v8_1306 = r_v5_1062.Hill
                            local r_v7_1252 = nil
                            local r_v4_1238, r_v9_1143, r_v14_1023 = pairs(r_v13_850(r_v6_1241))
                            local r_v11_912 = r_v4_1238
                            for r_v13_863, r_v12_711 in r_v11_912, r_v9_1143, r_v14_1023 do
                                local r_v17_442 = r_v12_711:GetAttribute("AirUnitBool")
                                local r_v16_518 = r_v17_442 == true
                                local r_v15_596 = r_v16_518
                                if not r_v16_518 then
                                    local r_v17_450 = r_v12_711:GetAttribute("TitleString")
                                    r_v15_596 = r_v17_450 == "Air"
                                end
                                if not r_v15_596 then
                                    continue
                                end
                                r_v7_1252 = r_v12_711
                                break
                            end
                            if (not r_v7_1252) then
                                local r_v9_1150 = pairs
                                local r_v15_598 = r_v6_1241.GetChildren
                                local r_v12_732 = {
                                    r_v15_598(r_v6_1241)
                                }
                                for r_v9_1152, r_v12_733 in r_v9_1150(unpack(r_v12_732)) do
                                    local r_v15_601 = r_v12_733.FindFirstChild
                                    if not (r_v15_601(r_v12_733, "HumanoidRootPart")) then
                                        continue
                                    end
                                    r_v7_1252 = r_v12_733
                                    break
                                end
                            end
                            local r_v9_1151 = r_v7_1252 and (r_v7_1252:FindFirstChild(("HumanoidRootPart")))
                            if r_v9_1151 then
                                local r_v9_1153 = r_v7_1252.HumanoidRootPart.Position
                                local r_v14_1040 = math.huge
                                local r_v20_338 = r_v8_1306.GetChildren
                                local r_v20_339 = {
                                    pairs(r_v20_338(r_v8_1306))
                                }
                                local r_v13_873 = r_v20_339[1]
                                local r_v16_531 = r_v20_339[3]
                                local r_v12_738 = r_v20_339[2]
                                for r_v11_923, r_v17_460 in r_v13_873, r_v12_738, r_v16_531 do
                                    local r_v22_224 = r_v17_460.IsA
                                    local r_v18_195 = (r_v22_224(r_v17_460, "BasePart")) and r_v17_460
                                    r_v20_339 = r_v18_195
                                    if not r_v18_195 then
                                        r_v20_339 = r_v17_460:FindFirstChildWhichIsA("BasePart")
                                    end
                                    if r_v20_339 then
                                        local r_v21_235 = r_v20_339.Position
                                        local r_v19_289 = (r_v21_235 - r_v9_1153).Magnitude
                                        if (r_v19_289 < r_v14_1040) then
                                            r_v14_1040 = r_v19_289
                                            r_v3_908 = r_v20_339
                                        end
                                    end
                                    r_v20_339 = nil
                                end
                            else
                                local r_v9_1156 = r_v8_1306:GetChildren()
                                if ((#r_v9_1156) > 0) then
                                    local r_v11_922 = math.random
                                    local r_v16_533 = #r_v9_1156
                                    local r_v14_1042 = r_v9_1156[r_v11_922(1, r_v16_533)]
                                    local r_v17_463 = r_v14_1042.IsA
                                    r_v3_908 = ((r_v17_463(r_v14_1042, "BasePart")) and r_v14_1042) or (r_v14_1042:FindFirstChildWhichIsA(("BasePart")))
                                end
                            end
                        end
                        if r_v3_908 then
                            local r_v14_1024 = math
                            local r_v14_1025 = r_v14_1024.random()
                            local r_v7_1253 = r_v14_1025 - 0.5
                            local r_v14_1026 = r_v3_908.Size.X
                            local r_v9_1146 = r_v14_1026 * 0.6
                            local r_v8_1307 = r_v7_1253 * r_v9_1146
                            local r_v13_856 = math
                            local r_v13_857 = r_v13_856.random()
                            local r_v9_1147 = r_v13_857 - 0.5
                            local r_v13_858 = r_v3_908.Size.Z
                            local r_v14_1029 = r_v13_858 * 0.6
                            local r_v7_1254 = r_v9_1147 * r_v14_1029
                            local r_v13_859 = r_v3_908.CFrame
                            local r_v16_513 = CFrame.new(r_v8_1307, r_v3_908.Size.Y / 2, r_v7_1254)
                            local r_v9_1148 = (r_v13_859 * r_v16_513).Position
                            local r_v13_861 = RaycastParams
                            local r_v13_862 = r_v13_861.new()
                            local r_v16_517 = r_v5_1062
                            if not r_v5_1062 then
                                r_v16_517 = workspace
                            end
                            r_v13_862.FilterDescendantsInstances = {
                                r_v16_517
                            }
                            local r_v16_520 = Enum.RaycastFilterType
                            r_v13_862.FilterType = r_v16_520.Include
                            local r_v14_1034 = workspace
                            local r_v20_321 = Vector3.new(0, 50, 0)
                            local r_v16_521 = r_v9_1148 + r_v20_321
                            local r_v20_323 = Vector3.new(0, (-100), 0)
                            local r_v12_731 = r_v14_1034:Raycast(r_v16_521, r_v20_323, r_v13_862)
                            if r_v12_731 then
                                r_v9_1148 = r_v12_731.Position
                            end
                            local r_v17_453 = CFrame.new(r_v9_1148)
                            local r_v16_525 = r_v22_34.Character
                            local r_v20_331 = r_v16_525 and (r_v16_525:FindFirstChild(("HumanoidRootPart")))
                            if r_v20_331 then
                                local r_v20_340 = r_v16_525.HumanoidRootPart
                                local r_v24_163 = CFrame.new(0, 3, 0)
                                r_v20_340.CFrame = r_v17_453 * r_v24_163
                                local r_v20_341 = r_v16_525.HumanoidRootPart
                                r_v20_341.Velocity = Vector3.new(0, 0, 0)
                                task.wait(0.3)
                            end
                            local r_v23_158 = game:GetService("ReplicatedStorage")
                            local r_v20_343 = r_v23_158.Remotes.Input
                            local r_v23_161 = {
                                ["Rotation"] = 0,
                                ["cframe"] = r_v17_453,
                                ["Unit"] = r_v2_847
                            }
                            r_v20_343:FireServer("Summon", r_v23_161)
                            r_v10_552 = true
                        end
                    end
                end
                task.wait(1)
            end
            o_v43_15 = false
        end
        r_v4_503(r_v2_365)
    end
    isAutoGStopLoop = false
    AutoGauntletStop = function()
        if isAutoGStopLoop then
            return
        end
        isAutoGStopLoop = true
        task.spawn(function()
            while true do
                if not (r_v40_42.auto_stop_g_enable) then
                    break
                end
                local r_v10_554 = r_v91_11()
                local r_v3_910 = r_v40_42.auto_stop_g_target
                local r_v4_1241 = r_v3_910 or 155
                if (r_v10_554 >= r_v4_1241) then
                    r_v40_42.auto_join_game = false
                    r_v40_42.auto_replay = false
                    r_v40_42.smart_auto_next = false
                    Save()
                    local r_v7_1261 = tostring(r_v10_554)
                    local r_v6_1248 = r_v7_1261 .. ")"
                    r_v22_34:Kick("\nStar Hub Auto Stop: \n\224\184\159\224\184\178\224\184\163\224\185\140\224\184\161 Gauntlet Tokens \224\184\132\224\184\163\224\184\154\224\185\128\224\184\155\224\185\137\224\184\178\224\184\171\224\184\161\224\184\178\224\184\162\224\185\129\224\184\165\224\185\137\224\184\167 (" .. r_v6_1248)
                    r_v10_554 = nil
                    break
                else
                    task.wait(5)
                    r_v10_554 = nil
                end
            end
            isAutoGStopLoop = false
        end)
    end
    UseCleanseAbilityUnit = function(r_v10_241)
        task.spawn(function()
            pcall(function()
                local r_v10_1151 = "SpecialMove"
                r_v10_1151 = r_v10_241:FindFirstChild(r_v10_1151)
                if (not r_v10_1151) then
                    return
                end
                local r_v2_1860 = r_v10_1151:FindFirstChild("Special_Enabled2")
                local r_v4_2913 = r_v2_1860
                if not r_v2_1860 then
                    r_v2_1860 = r_v10_1151:FindFirstChild("Special_Enabled")
                    r_v4_2913 = r_v2_1860
                end
                r_v2_1860 = r_v4_2913
                if (not r_v2_1860) then
                    return
                end
                local r_v3_1897 = r_v3_5
                r_v3_1897 = ""
                if r_v10_1151.FindFirstChild(r_v10_1151, "Special_Enabled_String") then
                    local r_v4_2916 = r_v10_1151.Special_Enabled_String
                    r_v3_1897 = r_v4_2916.Value
                end
                local r_v7_2387 = r_v97_11(r_v10_241)
                local r_v6_2436 = not r_v7_2387
                local r_v4_2917 = r_v6_2436
                if r_v6_2436 then
                    local r_v8_2570 = r_v2_1860.Value
                    r_v4_2917 = not r_v8_2570
                end
                if r_v4_2917 then
                    local r_v5_2114 = r_v40_42
                    r_v5_2114 = r_v5_2114.macro_record
                    r_v40_42.macro_record = false
                    if (r_v40_42.auto_cleanse_skill_mode == "Multiple (\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129\224\184\138\224\185\136\224\184\173\224\184\135\224\184\170\224\184\129\224\184\180\224\184\165)") then
                        local r_v7_2396 = game:GetService("ReplicatedStorage")
                        r_v7_2396.Remotes.Input:FireServer("UseSpecialMove", r_v10_241, r_v3_1897)
                        task.spawn(function()
                            local r_v10_1259 = "MultipleAbilities"
                            r_v10_1259 = r_v69_99:FindFirstChild(r_v10_1259)
                            local r_v4_3216 = r_v10_1259 and (r_v10_1259:FindFirstChild(("Frame")))
                            if r_v4_3216 then
                                local r_v2_2041 = 0
                                local r_v1_2812 = ipairs
                                local r_v6_2786 = r_v10_1259.Frame
                                local r_v4_3218, r_v3_2123, r_v5_2396 = r_v1_2812(r_v6_2786.GetChildren(r_v6_2786))
                                local r_v6_2788 = r_v4_3218
                                for r_v8_2935, r_v1_2813 in r_v6_2788, r_v3_2123, r_v5_2396 do
                                    if (r_v1_2813.Name == "ImageButton") then
                                        r_v2_2041 = r_v2_2041 + 1
                                        local r_v13_2089 = r_v40_42.auto_cleanse_multi_index
                                        local r_v14_2412 = r_v13_2089 or 1
                                        if (r_v2_2041 == r_v14_2412) then
                                            local r_v14_2414 = getgenv()
                                            r_v14_2414.IsAutoBuffClicking = true
                                            pcall(function()
                                                firesignal(r_v1_2813.Activated)
                                            end)
                                            pcall(function()
                                                firesignal(r_v1_2813.MouseButton1Click)
                                            end)
                                            task.wait(0.2)
                                            local r_v14_2422 = getgenv()
                                            r_v14_2422.IsAutoBuffClicking = false
                                            break
                                        end
                                    end
                                end
                            end
                        end)
                    else
                        local r_v7_2404 = game:GetService("ReplicatedStorage")
                        r_v7_2404.Remotes.Input:FireServer("UseSpecialMove", r_v10_241, r_v3_1897)
                    end
                    r_v40_42.macro_record = r_v5_2114
                end
            end)
        end)
    end
    isAutoCleanseLoop = false
    AutoCleanseLoop = function()
        local r_v4_509 = isAutoCleanseLoop or (r_v71_75())
        if r_v4_509 then
            return
        end
        isAutoCleanseLoop = true
        local r_v4_511 = task.spawn
        local r_v2_376 = function()
            while true do
                if not (r_v40_42.auto_cleanse_enable) then
                    break
                end
                local r_v10_558 = function()
                    local r_v10_1152 = {}
                    local r_v2_1863 = {}
                    local r_v4_2925 = workspace
                    local r_v3_1899 = "Enemies"
                    r_v3_1899 = r_v4_2925[r_v3_1899]:GetChildren()
                    local r_v4_2930, r_v5_2116, r_v6_2453 = ipairs(r_v3_1899)
                    local r_v8_2591 = r_v4_2930
                    for r_v7_2410, r_v9_2285 in r_v8_2591, r_v5_2116, r_v6_2453 do
                        local r_v11_1902 = r_v2_3
                        local r_v14_2085 = "TitleString"
                        r_v14_2085 = r_v9_2285:GetAttribute(r_v14_2085)
                        local r_v13_1762 = r_v14_2085 == "Cloner"
                        r_v11_1902 = r_v13_1762
                        if not r_v13_1762 then
                            r_v11_1902 = r_v14_2085 == "Decelerate"
                        end
                        if r_v11_1902 then
                            local r_v12_1538 = r_v40_42.auto_cleanse_class
                            local r_v13_1765 = r_v12_1538 == "\224\184\151\224\184\177\224\185\137\224\184\135\224\184\171\224\184\161\224\184\148 (All)"
                            r_v11_1902 = r_v13_1765
                            if not r_v13_1765 then
                                local r_v12_1539 = r_v40_42.auto_cleanse_class
                                r_v11_1902 = r_v14_2085 == r_v12_1539
                            end
                            if r_v11_1902 then
                                local r_v13_1768 = r_v9_2285.PrimaryPart
                                r_v11_1902 = r_v13_1768
                                if not r_v13_1768 then
                                    r_v11_1902 = (r_v9_2285:FindFirstChild("Torso")) or (r_v9_2285:FindFirstChild(("HumanoidRootPart")))
                                end
                                if r_v11_1902 then
                                    local r_v13_1771 = table
                                    r_v13_1771.insert(r_v10_1152, r_v9_2285)
                                    local r_v13_1773 = table
                                    r_v13_1773.insert(r_v2_1863, r_v11_1902)
                                end
                                r_v11_1902 = nil
                            end
                        end
                    end
                    local r_v5_2117 = #r_v10_1152
                    local r_v7_2411 = r_v40_42.auto_cleanse_count
                    local r_v6_2454 = r_v7_2411 or 1
                    if (r_v5_2117 >= r_v6_2454) then
                        local r_v6_2455 = r_v74_49()
                        local r_v5_2119 = ipairs
                        for r_v5_2120, r_v14_2088 in r_v5_2119(r_v6_2455) do
                            local r_v12_1540 = state
                            local r_v16_1116 = r_v40_42.auto_cleanse_unit
                            local r_v15_1264 = r_v16_1116 ~= ""
                            local r_v11_1904 = true
                            local r_v13_1767 = r_v15_1264
                            if r_v15_1264 then
                                local r_v16_1118 = r_v40_42.auto_cleanse_unit
                                r_v13_1767 = r_v16_1118 ~= "\224\184\151\224\184\184\224\184\129\224\184\149\224\184\177\224\184\167 (All)"
                            end
                            if r_v13_1767 then
                                r_v12_1540 = state
                                local r_v16_1120 = r_v40_42.auto_cleanse_unit
                                local r_v15_1270 = r_v16_1120 == "\224\185\132\224\184\161\224\185\136\224\185\132\224\184\148\224\185\137\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129 (None)"
                                local r_v13_1770 = r_v15_1270
                                if not r_v15_1270 then
                                    local r_v16_1124 = string.find
                                    local r_v19_591 = string.lower(r_v14_2088.Name)
                                    local r_v20_744 = string.lower
                                    local r_v21_428 = r_v40_42.auto_cleanse_unit
                                    local r_v17_964 = r_v16_1124(r_v19_591, (r_v20_744(r_v21_428)), 1, true)
                                    r_v13_1770 = not r_v17_964
                                end
                                if r_v13_1770 then
                                    r_v11_1904 = false
                                end
                            end
                            if r_v11_1904 then
                                local r_v16_1125 = r_v14_2088.PrimaryPart
                                r_v12_1540 = r_v16_1125
                                if not r_v16_1125 then
                                    r_v12_1540 = (r_v14_2088:FindFirstChild("Torso")) or (r_v14_2088:FindFirstChild(("HumanoidRootPart")))
                                end
                                if r_v12_1540 then
                                    local r_v17_967 = r_v40_42.auto_cleanse_condition
                                    local r_v16_1127 = r_v17_967 == "\224\185\128\224\184\161\224\184\183\224\185\136\224\184\173\224\184\161\224\184\173\224\184\153\224\185\128\224\184\129\224\184\180\224\184\148"
                                    local r_v15_1278 = false
                                    if r_v16_1127 then
                                        r_v15_1278 = true
                                    else
                                        local r_v17_970 = r_v14_2088:GetAttribute("Range")
                                        if ((not r_v17_970) or (r_v17_970 == (0))) then
                                            local r_v19_603 = r_v78_33(r_v14_2088.Name)
                                            local r_v21_441 = r_v19_603 and (r_v19_603.Range)
                                            r_v17_970 = r_v21_441 or 60
                                        end
                                        local r_v21_443, r_v22_379, r_v23_282 = ipairs(r_v2_1863)
                                        local r_v19_604 = 0
                                        for r_v18_464, r_v24_271 in r_v21_443, r_v22_379, r_v23_282 do
                                            local r_v28_266 = r_v12_1540.Position
                                            local r_v27_165 = r_v24_271.Position
                                            if ((r_v28_266 - r_v27_165).Magnitude <= r_v17_970) then
                                                r_v19_604 = r_v19_604 + 1
                                            end
                                        end
                                        local r_v23_284 = r_v40_42.auto_cleanse_count
                                        local r_v21_444 = r_v23_284 or 1
                                        if (r_v19_604 >= r_v21_444) then
                                            r_v15_1278 = true
                                        end
                                    end
                                    if r_v15_1278 then
                                        UseCleanseAbilityUnit(r_v14_2088)
                                        task.wait(0.01)
                                    end
                                end
                                r_v12_1540 = nil
                            end
                        end
                    end
                end
                pcall(r_v10_558)
                task.wait(0.1)
            end
            isAutoCleanseLoop = false
        end
        r_v4_511(r_v2_376)
    end
    isWipeMapLoop = false
    WipeMapLoop = function()
        local r_v4_512 = isWipeMapLoop or (r_v71_75())
        if r_v4_512 then
            return
        end
        isWipeMapLoop = true
        task.spawn(function()
            while true do
                if not (r_v40_42.fps_wipe_map) then
                    break
                end
                pcall(function()
                    local r_v1_2486 = workspace
                    if r_v1_2486.FindFirstChild(r_v1_2486, "Others") then
                        workspace.Others:ClearAllChildren()
                    end
                    local r_v1_2488 = workspace
                    if r_v1_2488.FindFirstChild(r_v1_2488, "Map Borders") then
                        workspace.MapBorders:ClearAllChildren()
                    end
                    local r_v1_2490 = workspace
                    if r_v1_2490.FindFirstChild(r_v1_2490, "Don't Care") then
                        local r_v1_2491 = pairs
                        local r_v3_1905 = workspace["Don't Care"]
                        local r_v4_2952, r_v10_1160, r_v2_1869 = r_v1_2491(r_v3_1905.GetChildren(r_v3_1905))
                        local r_v3_1907 = r_v4_2952
                        for r_v5_2129, r_v6_2465 in r_v3_1907, r_v10_1160, r_v2_1869 do
                            local r_v11_1907 = r_v6_2465.GetChildren
                            local r_v1_2492 = pairs
                            local r_v14_2090 = {
                                r_v11_1907(r_v6_2465)
                            }
                            for r_v14_2091, r_v11_1909 in r_v1_2492(unpack(r_v14_2090)) do
                                if (r_v11_1909.Name ~= "Pathway") then
                                    r_v11_1909:Destroy()
                                end
                            end
                        end
                    end
                end)
                task.wait(5)
            end
            isWipeMapLoop = false
        end)
    end
    isStripEnemyLoop = false
    StripEnemyLoop = function()
        local r_v4_515 = isStripEnemyLoop or (r_v71_75())
        if r_v4_515 then
            return
        end
        isStripEnemyLoop = true
        task.spawn(function()
            local r_v1_1221 = {
                "Head",
                "HumanoidRootPart",
                "Torso",
                "HoverPart",
                "Humanoid"
            }
            while true do
                if not (r_v40_42.fps_strip_enemy) then
                    break
                end
                pcall(function()
                    local r_v1_2497 = pairs
                    local r_v3_1908 = workspace.Enemies
                    local r_v4_2954, r_v10_1161, r_v2_1870 = r_v1_2497(r_v3_1908.GetChildren(r_v3_1908))
                    local r_v3_1910 = r_v4_2954
                    for r_v5_2133, r_v6_2470 in r_v3_1910, r_v10_1161, r_v2_1870 do
                        local r_v1_2498 = pairs
                        local r_v11_1912 = r_v6_2470.GetChildren
                        local r_v14_2094 = {
                            r_v11_1912(r_v6_2470)
                        }
                        for r_v14_2095, r_v11_1914 in r_v1_2498(unpack(r_v14_2094)) do
                            local r_v13_1777 = (r_v11_1914:IsA("BasePart")) or ((r_v11_1914:IsA("MeshPart")) or ((r_v11_1914:IsA("Accessory")) or ((r_v11_1914:IsA("Shirt")) or ((r_v11_1914:IsA(("Pants"))) or (r_v11_1914:IsA(("CharacterMesh")))))))
                            if r_v13_1777 then
                                local r_v13_1778 = table.find
                                if (not r_v13_1778(r_v1_1221, r_v11_1914.Name)) then
                                    r_v11_1914:Destroy()
                                end
                            end
                        end
                    end
                end)
                task.wait(2)
            end
            isStripEnemyLoop = false
        end)
    end
    local o_v69_5 = function()
        local r_v4_518 = o_v68_6 or (r_v71_75())
        if r_v4_518 then
            return
        end
        o_v68_6 = true
        task.spawn(function()
            local r_v1_1226 = {
                "ParticleEmitter",
                "Beam",
                "Trail",
                "Fire",
                "Smoke",
                "Sparkles"
            }
            while true do
                if not (r_v40_42.hide_unit_effects) then
                    break
                end
                pcall(function()
                    local r_v1_2507 = workspace
                    if r_v1_2507.FindFirstChild(r_v1_2507, "Unit") then
                        local r_v1_2508 = pairs
                        local r_v3_1912 = workspace.Unit
                        local r_v4_2960, r_v10_1163, r_v2_1872 = r_v1_2508(r_v3_1912.GetChildren(r_v3_1912))
                        local r_v3_1914 = r_v4_2960
                        for r_v5_2138, r_v6_2476 in r_v3_1914, r_v10_1163, r_v2_1872 do
                            local r_v1_2509 = pairs
                            local r_v11_1917 = r_v6_2476.GetDescendants
                            local r_v14_2098 = {
                                r_v11_1917(r_v6_2476)
                            }
                            for r_v14_2099, r_v11_1919 in r_v1_2509(unpack(r_v14_2098)) do
                                if table.find(r_v1_1226, r_v11_1919.ClassName) then
                                    r_v11_1919.Enabled = false
                                else
                                    local r_v13_1783 = (r_v11_1919:IsA("PointLight")) or ((r_v11_1919:IsA(("SurfaceLight"))) or (r_v11_1919:IsA(("SpotLight"))))
                                    if r_v13_1783 then
                                        r_v11_1919.Enabled = false
                                    end
                                end
                            end
                        end
                    end
                end)
                task.wait(2)
            end
            o_v68_6 = false
        end)
    end
    isAutoKilluaLoop = false
    AutoKilluaLoop = function()
        local r_v4_520 = isAutoKilluaLoop or (r_v71_75())
        if r_v4_520 then
            return
        end
        isAutoKilluaLoop = true
        task.spawn(function()
            while true do
                if not (r_v40_42.auto_killua_enable) then
                    break
                end
                pcall(function()
                    local r_v10_1164 = "KilluaWishes"
                    r_v10_1164 = r_v69_99:FindFirstChild(r_v10_1164)
                    local r_v4_2964 = r_v10_1164 and (r_v10_1164.Visible)
                    if r_v4_2964 then
                        local r_v2_1877 = r_v10_1164:FindFirstChild("TextBackground")
                        local r_v4_2965 = r_v2_1877
                        if r_v2_1877 then
                            r_v2_1877 = r_v10_1164.TextBackground
                            r_v4_2965 = r_v2_1877:FindFirstChild("OptionsContainer")
                        end
                        r_v2_1877 = r_v4_2965
                        if r_v2_1877 then
                            local r_v3_1924 = r_v40_42.auto_killua_wish
                            local r_v4_2966 = r_v3_1924
                            if not r_v3_1924 then
                                r_v3_1924 = "Money"
                                r_v4_2966 = r_v3_1924
                            end
                            r_v3_1924 = r_v4_2966
                            local r_v1_2515 = nil
                            local r_v9_2302 = r_v2_1877.GetChildren
                            local r_v4_2968, r_v6_2484, r_v8_2619 = ipairs(r_v9_2302(r_v2_1877))
                            local r_v7_2428 = r_v4_2968
                            for r_v9_2306, r_v14_2105 in r_v7_2428, r_v6_2484, r_v8_2619 do
                                local r_v11_1923 = (r_v14_2105:IsA("TextButton")) and (string.find(r_v14_2105.Text, r_v3_1924))
                                if not r_v11_1923 then
                                    continue
                                end
                                r_v1_2515 = r_v14_2105
                                break
                            end
                            if r_v1_2515 then
                                local r_v6_2487 = r_v40_42.macro_record
                                r_v40_42.macro_record = false
                                local r_v7_2434 = getgenv()
                                r_v7_2434.IsAutoBuffClicking = true
                                pcall(function()
                                    firesignal(r_v1_2515.MouseButton1Click)
                                end)
                                pcall(function()
                                    firesignal(r_v1_2515.Activated)
                                end)
                                task.wait(0.2)
                                local r_v7_2442 = getgenv()
                                r_v7_2442.IsAutoBuffClicking = false
                                r_v40_42.macro_record = r_v6_2487
                                r_v67_92("Killua Wish", "\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129\224\184\158\224\184\163 " .. r_v3_1924 .. " \224\185\131\224\184\171\224\185\137\224\185\128\224\184\163\224\184\181\224\184\162\224\184\154\224\184\163\224\185\137\224\184\173\224\184\162\224\185\129\224\184\165\224\185\137\224\184\167!", 3)
                            end
                        end
                    end
                    local r_v2_1878 = ipairs
                    local r_v7_2422 = {
                        r_v74_49()
                    }
                    for r_v2_1879, r_v8_2617 in r_v2_1878(unpack(r_v7_2422)) do
                        local r_v11_1921 = r_v8_2617.Name
                        local r_v14_2103 = r_v11_1921 == "Killua6"
                        local r_v7_2426 = r_v14_2103
                        if r_v14_2103 then
                            local r_v13_1790 = r_v8_2617:FindFirstChild("Alluka")
                            local r_v14_2104 = r_v13_1790
                            if r_v13_1790 then
                                local r_v15_1295 = r_v97_11(r_v8_2617)
                                r_v14_2104 = not r_v15_1295
                            end
                            r_v7_2426 = r_v14_2104
                        end
                        if r_v7_2426 then
                            local r_v14_2106 = not r_v10_1164
                            local r_v7_2430 = r_v14_2106
                            if not r_v14_2106 then
                                local r_v11_1924 = r_v10_1164.Visible
                                r_v7_2430 = not r_v11_1924
                            end
                            if r_v7_2430 then
                                local r_v11_1937 = game:GetService("ReplicatedStorage")
                                r_v11_1937.Remotes.Input:FireServer("UseSpecialMove", r_v8_2617, "")
                                task.wait(0.5)
                            end
                        end
                    end
                end)
                task.wait(0.5)
            end
            isAutoKilluaLoop = false
        end)
    end
    AutoBuff = function()
        local r_v1_530 = pairs
        local r_v3_400 = r_v40_42.auto_buff_units
        for r_v5_442, r_v1_532 in r_v1_530(r_v3_400) do
            local r_v1_533 = task.spawn
            local r_v7_485 = function()
                while true do
                    if not (r_v40_42.auto_buff) then
                        break
                    end
                    local r_v10_581 = {}
                    local r_v4_1284, r_v2_884, r_v3_940 = pairs(r_v74_49())
                    local r_v5_1094 = r_v4_1284
                    for r_v6_1273, r_v8_1337 in r_v5_1094, r_v2_884, r_v3_940 do
                        local r_v14_1049 = r_v8_1337.Name
                        local r_v11_930 = r_v5_442
                        local r_v9_1168 = r_v14_1049 == r_v11_930
                        local r_v7_1274 = r_v9_1168
                        if r_v9_1168 then
                            local r_v11_934 = r_v8_1337:WaitForChild("SpecialMove")
                            local r_v14_1052 = r_v11_934.Value
                            r_v7_1274 = r_v14_1052 ~= ""
                        end
                        if r_v7_1274 then
                            local r_v7_1281 = table
                            r_v7_1281.insert(r_v10_581, r_v8_1337)
                        end
                    end
                    local r_v2_885 = r_v1_532
                    r_v2_885 = r_v2_885.Checks
                    local r_v3_942 = r_v1_532
                    r_v3_942 = r_v3_942["Ability Type"]
                    local r_v6_1276 = (r_v3_942 == "Multiple") and (r_v1_532["Ability Name"])
                    local r_v5_1097 = r_v6_1276 or nil
                    local r_v6_1277 = r_v1_532.Time
                    local r_v8_1343 = function(r_v10_1165, r_v2_1881, r_v3_1925, r_v5_2150, r_v6_2488)
                        local r_v4_2970, r_v8_2632, r_v7_2447 = pairs(r_v3_1925)
                        local r_v9_2331 = r_v4_2970
                        for r_v14_2123, r_v11_1942 in r_v9_2331, r_v8_2632, r_v7_2447 do
                            if (r_v11_1942 == "attack") then
                                repeat
                                    local r_v13_1818 = task
                                    r_v13_1818.wait()
                                    local r_v12_1595 = r_v95_11(r_v10_1165)
                                until not r_v12_1595
                            else
                                if (r_v11_1942 == "range") then
                                    repeat
                                        local r_v13_1822 = task
                                        r_v13_1822.wait()
                                        local r_v12_1598 = r_v96_10(r_v10_1165)
                                    until not r_v12_1598
                                end
                            end
                        end
                        if (r_v5_2150 == "Multiple") then
                            o_v19_11(r_v2_1881, "", r_v6_2488)
                        else
                            o_v16_14(r_v2_1881, "")
                        end
                        r_v3_1925 = nil
                        r_v2_1881 = nil
                        r_v5_2150 = nil
                        r_v10_1165 = nil
                        r_v6_2488 = nil
                    end
                    if (r_v1_532.Mode == "Box") then
                        local r_v13_889 = #r_v10_581
                        local r_v7_1283 = {}
                        if ((r_v13_889 > 4) and ((#r_v10_581) < 8)) then
                            repeat
                                task.wait(1)
                                table.remove(r_v10_581, #r_v10_581)
                                local r_v14_1083 = #r_v10_581
                                local r_v11_964 = 4
                            until r_v14_1083 == r_v11_964
                        end
                        if ((#r_v10_581) == 8) then
                            for r_v9_1205 = 1, 4 do
                                table.insert(r_v7_1283, r_v10_581[1])
                                table.remove(r_v10_581, 1)
                            end
                        end
                        if (((#r_v10_581) == 4) or ((#r_v7_1283) == 4)) then
                            for r_v9_1216 = 1, 4 do
                                local r_v20_361 = r_v40_42.auto_buff
                                local r_v17_491 = not r_v20_361
                                local r_v15_646 = r_v17_491
                                if not r_v17_491 then
                                    local r_v20_364 = r_v40_42.auto_buff_units[r_v5_442]
                                    r_v15_646 = r_v20_364 == nil
                                end
                                if r_v15_646 then
                                    break
                                end
                                if ((#r_v10_581) == 4) then
                                    r_v8_1343(r_v10_581, r_v10_581[r_v9_1216], r_v2_885, r_v3_942, r_v5_1097)
                                end
                                if ((#r_v7_1283) == 4) then
                                    r_v8_1343(r_v7_1283, r_v7_1283[r_v9_1216], r_v2_885, r_v3_942, r_v5_1097)
                                end
                                local r_v19_307 = r_v40_42.auto_buff
                                local r_v17_499 = r_v19_307
                                if r_v19_307 then
                                    local r_v18_219 = r_v40_42.auto_buff_units[r_v5_442]
                                    r_v17_499 = r_v18_219 ~= nil
                                end
                                r_v73_53(r_v6_1277, r_v17_499)
                            end
                        end
                    else
                        if (r_v1_532.Mode == "Pair") then
                            if ((#r_v10_581) >= 2) then
                                local r_v7_1287 = pairs
                                for r_v7_1287, r_v13_903 in r_v7_1287(r_v10_581) do
                                    if ((r_v7_1287 % 2) ~= 0) then
                                        r_v8_1343(r_v10_581, r_v10_581[r_v7_1287], r_v2_885, r_v3_942, r_v5_1097)
                                    end
                                end
                                local r_v13_908 = r_v40_42.auto_buff
                                local r_v14_1084 = r_v13_908
                                if r_v13_908 then
                                    local r_v12_782 = r_v40_42.auto_buff_units[r_v5_442]
                                    r_v14_1084 = r_v12_782 ~= nil
                                end
                                r_v73_53(r_v6_1277, r_v14_1084)
                                local r_v7_1296 = pairs
                                for r_v7_1296, r_v13_920 in r_v7_1296(r_v10_581) do
                                    if ((r_v7_1296 % 2) == 0) then
                                        r_v8_1343(r_v10_581, r_v10_581[r_v7_1296], r_v2_885, r_v3_942, r_v5_1097)
                                    end
                                end
                                local r_v13_921 = r_v40_42.auto_buff
                                local r_v14_1096 = r_v13_921
                                if r_v13_921 then
                                    local r_v12_788 = r_v40_42.auto_buff_units[r_v5_442]
                                    r_v14_1096 = r_v12_788 ~= nil
                                end
                                r_v73_53(r_v6_1277, r_v14_1096)
                            end
                        else
                            if (r_v1_532.Mode == "Spam") then
                                local r_v7_1288 = pairs
                                for r_v7_1288, r_v13_905 in r_v7_1288(r_v10_581) do
                                    r_v8_1343(r_v10_581, r_v10_581[r_v7_1288], r_v2_885, r_v3_942, r_v5_1097)
                                end
                                local r_v13_913 = r_v40_42.auto_buff
                                local r_v14_1088 = r_v13_913
                                if r_v13_913 then
                                    local r_v12_783 = r_v40_42.auto_buff_units[r_v5_442]
                                    r_v14_1088 = r_v12_783 ~= nil
                                end
                                r_v73_53(r_v6_1277, r_v14_1088)
                            else
                                if (r_v1_532.Mode == "Cycle") then
                                    local r_v14_1081 = r_v1_532["Cycle Units"]
                                    local r_v7_1291 = r_v14_1081 or 8
                                    if ((#r_v10_581) >= r_v7_1291) then
                                        local r_v9_1204 = pairs
                                        for r_v9_1204, r_v12_784 in r_v9_1204(r_v10_581) do
                                            local r_v17_490 = r_v40_42.auto_buff
                                            local r_v15_645 = r_v17_490
                                            if r_v17_490 then
                                                local r_v18_211 = r_v40_42.auto_buff_units[r_v5_442]
                                                r_v15_645 = (r_v18_211 ~= nil) and ((#r_v10_581) >= r_v7_1291)
                                            end
                                            if not r_v15_645 then
                                                break
                                            end
                                            r_v8_1343(r_v10_581, r_v10_581[r_v9_1204], r_v2_885, r_v3_942, r_v5_1097)
                                            local r_v19_305 = r_v40_42.auto_buff
                                            local r_v17_497 = r_v19_305
                                            if r_v19_305 then
                                                local r_v22_241 = r_v40_42.auto_buff_units[r_v5_442]
                                                r_v17_497 = (r_v22_241 ~= nil) and ((#r_v10_581) >= r_v7_1291)
                                            end
                                            r_v73_53(r_v6_1277, r_v17_497)
                                        end
                                    end
                                end
                            end
                        end
                    end
                    if (r_v1_532.Delay ~= nil) then
                        r_v73_53(r_v1_532.Delay, r_v40_42.auto_buff)
                    end
                    local r_v9_1202 = task
                    r_v9_1202.wait()
                end
            end
            r_v1_533(r_v7_485)
        end
    end
    local o_v50_9 = false
    AutoEvolveEXP = function()
        local r_v1_534 = function()
            local r_v10_582 = game.ReplicatedStorage
            return r_v10_582.Remotes.Server:InvokeServer("Data", "Units")
        end
        local r_v1_535 = function()
            local r_v10_585 = r_v1_534()
            local r_v5_1103 = 0
            local r_v6_1284 = 0
            local r_v9_1220, r_v8_1349, r_v7_1301 = pairs(r_v10_585)
            local r_v3_951 = 0
            local r_v2_891 = 0
            for r_v14_1097, r_v11_975 in r_v9_1220, r_v8_1349, r_v7_1301 do
                if (r_v11_975.Name == "EXP IV") then
                    r_v3_951 = r_v3_951 + 1
                else
                    if (r_v11_975.Name == "EXP III") then
                        r_v2_891 = r_v2_891 + 1
                    else
                        if (r_v11_975.Name == "EXP II") then
                            r_v6_1284 = r_v6_1284 + 1
                        else
                            if (r_v11_975.Name == "EXP I") then
                                r_v5_1103 = r_v5_1103 + 1
                            end
                        end
                    end
                end
            end
            return r_v5_1103, r_v6_1284, r_v2_891, r_v3_951
        end
        local r_v1_536 = function(r_v10_586)
            local r_v4_1292, r_v2_892, r_v3_952 = pairs(r_v1_534())
            local r_v5_1106 = r_v4_1292
            for r_v6_1286, r_v8_1350 in r_v5_1106, r_v2_892, r_v3_952 do
                if (r_v8_1350.Name == r_v10_586) then
                    local r_v1_1264 = r_v8_1350.ID
                    return r_v1_1264
                end
            end
            return nil
        end
        local r_v5_445 = function(r_v10_587)
            local r_v2_893 = r_v1_536(r_v10_587)
            if (r_v2_893 ~= nil) then
                local r_v5_1110 = game:GetService("ReplicatedStorage")
                r_v5_1110.Remotes.Input:FireServer("UpgradeUnit", r_v10_587, r_v2_893)
                task.wait(0.25)
            end
            return r_v1_535()
        end
        local r_v9_435 = {
            r_v1_535()
        }
        local r_v6_532 = r_v9_435[2]
        local r_v7_486 = r_v9_435[4]
        local r_v4_525 = r_v9_435[1]
        local r_v8_534 = r_v9_435[3]
        local r_v14_375 = r_v8_534 >= 3
        r_v9_435 = r_v4_525
        if (r_v14_375 or ((r_v6_532 >= 3) or (r_v9_435 >= (2)))) then
            o_v50_9 = true
            while true do
                if not ((r_v8_534 >= 3) or ((r_v6_532 >= 3) or (r_v9_435 >= (2)))) then
                    break
                end
                if (r_v8_534 >= 3) then
                    local r_v4_529, r_v14_379, r_v11_335, __beta_unused_return_1 = r_v5_445("EXP III")
                    r_v9_435 = r_v4_529
                    r_v6_532 = r_v14_379
                    r_v8_534 = r_v11_335
                end
                if (r_v6_532 >= 3) then
                    local r_v12_287, r_v15_234, r_v16_208, __beta_unused_return_1 = r_v5_445("EXP II")
                    r_v8_534 = r_v16_208
                    r_v6_532 = r_v15_234
                    r_v9_435 = r_v12_287
                end
                if ((r_v8_534 >= 3) or (r_v6_532 >= (3))) then
                    o_v50_9 = true
                else
                    if (r_v9_435 >= 2) then
                        local r_v19_88, r_v18_68, r_v21_91, __beta_unused_return_1 = r_v5_445("EXP I")
                        r_v8_534 = r_v21_91
                        r_v6_532 = r_v18_68
                        r_v9_435 = r_v19_88
                    else
                        break
                    end
                end
            end
            if r_v40_42.webhook_exp_evolve then
                SendWebhook("EXP Evolve")
            end
        end
        HideSummonGUI()
        o_v50_9 = false
    end
    AutoTower = function()
        local r_v1_544 = workspace.Queue.InteractionsV2
        local r_v10_268 = "Script633"
        r_v10_268 = r_v1_544:FindFirstChild(r_v10_268)
        ;(function(r_v10_588)
            if (r_v10_588 ~= nil) then
                firetouchinterest(r_v22_34.Character.HumanoidRootPart, r_v10_588, 0)
                local r_v4_1305 = task
                r_v4_1305.wait()
                firetouchinterest(r_v22_34.Character.HumanoidRootPart, r_v10_588, 1)
                task.wait(1)
            end
            r_v10_588 = nil
        end)(r_v10_268)
        local r_v5_449 = r_v69_99.HUD.TowerLevelSelector
        local r_v4_534 = r_v5_449.StoryModeChooser.StoryModeChooser
        if r_v4_534.Visible then
            local r_v4_538 = game:GetService("VirtualInputManager")
            pcall(function()
                local r_v2_901 = Enum.KeyCode.BackSlash
                local r_v5_1122 = game
                r_v4_538:SendKeyEvent(true, r_v2_901, false, r_v5_1122)
                task.wait(0.5)
                local r_v2_903 = Enum.KeyCode.Right
                local r_v5_1126 = game
                r_v4_538:SendKeyEvent(true, r_v2_903, false, r_v5_1126)
                task.wait(0.5)
                local r_v2_905 = Enum.KeyCode.Return
                local r_v5_1130 = game
                r_v4_538:SendKeyEvent(true, r_v2_905, false, r_v5_1130)
                task.wait(0.5)
                local r_v2_907 = Enum.KeyCode.BackSlash
                local r_v5_1134 = game
                r_v4_538:SendKeyEvent(true, r_v2_907, false, r_v5_1134)
            end)
            local r_v6_544 = game:GetService("ReplicatedStorage")
            local r_v1_550 = r_v6_544.Remotes.Input
            local r_v6_546 = r_v10_268.Name
            r_v1_550:FireServer(r_v6_546 .. "Start")
        end
    end
    local o_v50_12 = function()
        local r_v10_269 = function(r_v10_602)
            if (r_v10_602 ~= nil) then
                firetouchinterest(r_v67_96.Character.HumanoidRootPart, r_v10_602, 0)
                local r_v4_1332 = task
                r_v4_1332.wait()
                firetouchinterest(r_v67_96.Character.HumanoidRootPart, r_v10_602, 1)
                task.wait(1)
            end
            r_v10_602 = nil
        end
        local r_v2_404 = function(r_v10_603)
            task.wait(1)
            local r_v1_1288 = r_v67_96.Character.HumanoidRootPart
            local r_v3_987 = workspace.SpawnLocation
            r_v1_1288.CFrame = r_v3_987.CFrame
            task.wait(1)
            if (r_v10_603 ~= nil) then
                local r_v3_992 = game:GetService("ReplicatedStorage")
                local r_v1_1291 = r_v3_992.Remotes.Input
                local r_v3_994 = r_v10_603.Name
                r_v1_1291:FireServer(r_v3_994 .. "Start")
            end
            r_v10_603 = nil
        end
        if r_v40_42.auto_evolve_exp then
            if not (not o_v50_9) then
                local r_v5_461 = r_v40_42.auto_evolve_exp
            end
            repeat
                local r_v4_553 = task
                r_v4_553.wait()
                local r_v3_422 = not o_v50_9
                local r_v4_556 = r_v3_422
                if not r_v3_422 then
                    local r_v5_470 = r_v40_42.auto_evolve_exp
                    r_v4_556 = not r_v5_470
                end
            until r_v4_556
        end
        if (not r_v40_42.auto_join_game) then
            return
        end
        task.wait(r_v40_42.auto_join_delay)
        local r_v3_419 = nil
        if (r_v69_100() == 1) then
            local r_v5_466 = function(r_v10_604)
                while true do
                    -- optimized-out if statement
                    local r_v4_1350, r_v2_929, r_v3_995 = pairs(r_v10_604)
                    local r_v5_1154 = r_v4_1350
                    for r_v6_1337, r_v8_1391 in r_v5_1154, r_v2_929, r_v3_995 do
                        local r_v14_1124 = r_v8_1391.ClassName
                        local r_v9_1251 = r_v14_1124 == "Part"
                        local r_v7_1340 = r_v9_1251
                        if r_v9_1251 then
                            local r_v13_932 = r_v8_1391.SurfaceGui.Frame
                            local r_v14_1125 = r_v13_932.TextLabel.Text
                            r_v7_1340 = r_v14_1125 == "Empty"
                        end
                        if r_v7_1340 then
                            return r_v8_1391
                        end
                    end
                    local r_v2_930 = task
                    r_v2_930.wait()
                end
                r_v10_604 = nil
            end
            local r_v6_553 = function()
                local r_v10_605 = {}
                local r_v2_934 = {
                    "Script170",
                    "Script158",
                    "Script395",
                    "Script408",
                    "Script523",
                    "Script539",
                    "Script573",
                    "Script600",
                    "Script624",
                    "Script958"
                }
                local r_v1_1297 = pairs
                local r_v6_1345 = workspace.Queue.InteractionsV2
                local r_v4_1353, r_v3_1001, r_v5_1160 = r_v1_1297(r_v6_1345.GetChildren(r_v6_1345))
                local r_v6_1347 = r_v4_1353
                for r_v8_1401, r_v7_1352 in r_v6_1347, r_v3_1001, r_v5_1160 do
                    if table.find(r_v2_934, r_v7_1352.Name) then
                        local r_v9_1265 = table
                        r_v9_1265.insert(r_v10_605, r_v7_1352)
                    end
                end
                return r_v10_605
            end
            local r_v1_561 = function()
                local r_v10_606 = {}
                local r_v2_937 = {
                    "Script209",
                    "Script222",
                    "Script381",
                    "Script405",
                    "Script448",
                    "Script58",
                    "Script647",
                    "Script716"
                }
                local r_v1_1302 = pairs
                local r_v6_1353 = workspace.Queue.InteractionsV2
                local r_v4_1356, r_v3_1005, r_v5_1165 = r_v1_1302(r_v6_1353.GetChildren(r_v6_1353))
                local r_v6_1355 = r_v4_1356
                for r_v8_1411, r_v7_1363 in r_v6_1355, r_v3_1005, r_v5_1165 do
                    if table.find(r_v2_937, r_v7_1363.Name) then
                        local r_v9_1278 = table
                        r_v9_1278.insert(r_v10_606, r_v7_1363)
                    end
                end
                return r_v10_606
            end
            local r_v4_555 = r_v40_42.auto_join_mode
            local r_v8_555 = r_v1_561
            if (r_v4_555 == "Story") then
                if (r_v40_42.auto_join_story_level > 120) then
                    r_v10_269(get_world_teleporter())
                    return
                else
                    r_v3_419 = r_v5_466(r_v6_553())
                    r_v10_269(r_v3_419)
                    if r_v3_419 then
                        local r_v14_409 = game:GetService("ReplicatedStorage")
                        local r_v4_563 = r_v14_409.Remotes.Input
                        local r_v14_411 = r_v3_419.Name
                        local r_v9_469 = r_v14_411 .. "Level"
                        local r_v11_366 = tostring(r_v40_42.auto_join_story_level)
                        r_v4_563:FireServer(r_v9_469, r_v11_366, false)
                    end
                end
            else
                if (r_v40_42.auto_join_mode == "Infinite") then
                    local r_v14_400 = r_v49_54[r_v40_42.auto_join_infinite_level]
                    local r_v9_461 = r_v14_400 == "Gauntlet"
                    local r_v4_562 = r_v9_461
                    if not r_v9_461 then
                        local r_v14_414 = r_v49_54[r_v40_42.auto_join_infinite_level]
                        r_v4_562 = r_v14_414 == "Training"
                    end
                    if r_v4_562 then
                        r_v10_269(get_world_teleporter())
                        return
                    else
                        r_v3_419 = r_v5_466(r_v8_555())
                        r_v10_269(r_v3_419)
                        if r_v3_419 then
                            local r_v11_392 = game:GetService("ReplicatedStorage")
                            local r_v7_547 = r_v11_392.Remotes.Input
                            local r_v11_394 = r_v3_419.Name
                            local r_v14_439 = r_v11_394 .. "Level"
                            local r_v11_395 = r_v40_42.auto_join_infinite_level
                            r_v7_547:FireServer(r_v14_439, r_v11_395, false)
                        end
                    end
                else
                    if (r_v40_42.auto_join_mode == "Adventure") then
                        r_v10_269(get_world_teleporter())
                        return
                    else
                        if (r_v40_42.auto_join_mode == "Time Chamber") then
                            r_v10_269(workspace.Queue.Interactions.Script548)
                        else
                            if (r_v40_42.auto_join_mode == "Team Event") then
                                local r_v7_548 = pairs
                                local r_v13_374 = workspace.Queue
                                local r_v15_278 = r_v13_374.GetChildren
                                local r_v12_334 = {
                                    r_v15_278(r_v13_374)
                                }
                                for r_v7_562, r_v13_381 in r_v7_548(unpack(r_v12_334)) do
                                    local r_v17_202 = r_v13_381.Name
                                    local r_v16_251 = r_v17_202 == "Model"
                                    local r_v12_348 = r_v16_251
                                    if r_v16_251 then
                                        local r_v17_208 = r_v13_381:FindFirstChild("PortalPart")
                                        r_v12_348 = r_v17_208 ~= nil
                                    end
                                    if not r_v12_348 then
                                        continue
                                    end
                                    r_v10_269(r_v13_381.FindFirstChild(r_v13_381, "PortalPart"))
                                    break
                                end
                            else
                                if (r_v40_42.auto_join_mode == "Bakugan Event") then
                                    r_v10_269(workspace.Queue.BakuganEventArea.Script412)
                                end
                            end
                        end
                    end
                end
            end
            r_v2_404(r_v3_419)
        else
            if (r_v69_100() == 2) then
                local r_v5_469 = function(r_v10_607, r_v2_938)
                    while true do
                        -- optimized-out if statement
                        local r_v1_1306 = pairs
                        for r_v8_1413, r_v7_1364 in r_v1_1306(r_v10_607) do
                            local r_v13_953 = r_v2_938 == nil
                            local r_v14_1151 = r_v13_953
                            if not r_v13_953 then
                                local r_v12_822 = r_v7_1364.Name
                                r_v14_1151 = r_v12_822 == r_v2_938
                            end
                            local r_v9_1281 = r_v14_1151
                            if r_v14_1151 then
                                local r_v12_823 = r_v7_1364.ClassName
                                local r_v13_955 = r_v12_823 == "Part"
                                local r_v14_1153 = r_v13_955
                                if r_v13_955 then
                                    local r_v16_608 = r_v7_1364.SurfaceGui.Frame
                                    local r_v12_824 = r_v16_608.TextLabel.Text
                                    r_v14_1153 = r_v12_824 == "Empty"
                                end
                                r_v9_1281 = r_v14_1153
                            end
                            if r_v9_1281 then
                                return r_v7_1364
                            end
                        end
                        local r_v3_1007 = task
                        r_v3_1007.wait()
                    end
                    r_v2_938 = nil
                    r_v10_607 = nil
                end
                if (r_v40_42.auto_join_mode == "Story") then
                    if (r_v40_42.auto_join_story_level < 121) then
                        r_v10_269(get_world_teleporter())
                        return
                    else
                        repeat
                            local r_v8_564 = task
                            r_v8_564.wait()
                            local r_v9_501 = workspace.Joinables:GetChildren()
                            local r_v8_568 = #r_v9_501
                            local r_v7_551 = 0
                        until r_v8_568 > r_v7_551
                        r_v3_419 = r_v5_469((workspace.Joinables:GetChildren()), "StoryMode")
                        r_v10_269(r_v3_419)
                        if r_v3_419 then
                            local r_v14_460 = game:GetService("ReplicatedStorage")
                            local r_v8_574 = r_v14_460.Remotes.Input
                            local r_v11_417 = tostring(r_v40_42.auto_join_story_level)
                            r_v8_574:FireServer("StoryModeLevel", r_v11_417, true)
                        end
                    end
                else
                    if (r_v40_42.auto_join_mode == "Infinite") then
                        if (r_v49_54[r_v40_42.auto_join_infinite_level] == "Farm") then
                            r_v10_269(get_world_teleporter())
                            return
                        else
                            repeat
                                local r_v7_552 = task
                                r_v7_552.wait()
                                local r_v14_454 = workspace.Joinables:GetChildren()
                                local r_v7_560 = #r_v14_454
                                local r_v9_511 = 0
                            until r_v7_560 > r_v9_511
                            r_v3_419 = r_v5_469((workspace.Joinables:GetChildren()), "InfiniteMode")
                            r_v10_269(r_v3_419)
                            if r_v3_419 then
                                local r_v11_426 = game:GetService("ReplicatedStorage")
                                local r_v7_571 = r_v11_426.Remotes.Input
                                local r_v11_429 = r_v40_42.auto_join_infinite_level
                                r_v7_571:FireServer("InfiniteModeLevel", r_v11_429, false)
                            end
                        end
                    else
                        if (r_v40_42.auto_join_mode == "Adventure") then
                            repeat
                                local r_v9_504 = task
                                r_v9_504.wait()
                                local r_v11_411 = workspace.Joinables:GetChildren()
                                local r_v9_512 = #r_v11_411
                                local r_v14_456 = 0
                            until r_v9_512 > r_v14_456
                            r_v3_419 = r_v5_469((workspace.Joinables:GetChildren()), "AdventureMode")
                            r_v10_269(r_v3_419)
                            if r_v3_419 then
                                local r_v13_408 = game:GetService("ReplicatedStorage")
                                local r_v9_529 = r_v13_408.Remotes.Input
                                local r_v13_411 = r_v40_42.auto_join_adventure_level
                                r_v9_529:FireServer("AdventureModeLevel", r_v13_411, false)
                            end
                        else
                            r_v10_269(get_world_teleporter())
                            return
                        end
                    end
                end
                r_v2_404(r_v3_419)
            end
        end
    end
    local o_v67_5 = function()
        local r_v4_566 = o_v66_6 or (r_v71_75())
        if r_v4_566 then
            return
        end
        o_v66_6 = true
        task.spawn(function()
            while true do
                if not (r_v40_42.auto_specific_upgrade) then
                    break
                end
                pcall(function()
                    local r_v1_2533 = {}
                    local r_v2_1882 = r_v40_42.specific_upgrade_list
                    local r_v10_1166 = r_v1_2533
                    local r_v4_2971 = r_v2_1882
                    if not r_v2_1882 then
                        r_v2_1882 = ""
                        r_v4_2971 = r_v2_1882
                    end
                    r_v2_1882 = r_v4_2971
                    if (r_v2_1882 ~= "") then
                        local r_v4_2974, r_v3_1929, r_v5_2154 = ipairs(string.split(r_v2_1882, ","))
                        local r_v6_2494 = r_v4_2974
                        for r_v8_2643, r_v7_2458 in r_v6_2494, r_v3_1929, r_v5_2154 do
                            local r_v9_2339, r_v14_2133 = string.match(r_v7_2458, "^%s*(.-)%s*:%s*(%d+)%s*$")
                            if (r_v9_2339 and r_v14_2133) then
                                local r_v11_1952 = string
                                local r_v11_1953 = r_v11_1952.lower(r_v9_2339)
                                r_v10_1166[r_v11_1953] = tonumber(r_v14_2133)
                            end
                        end
                    end
                    local r_v1_2536 = pairs
                    local r_v7_2457 = {
                        r_v74_49()
                    }
                    for r_v8_2644, r_v7_2459 in r_v1_2536(unpack(r_v7_2457)) do
                        local r_v13_1830 = {
                            pairs(r_v10_1166)
                        }
                        local r_v14_2134 = r_v13_1830[2]
                        local r_v11_1951 = r_v13_1830[3]
                        local r_v9_2341 = r_v13_1830[1]
                        for r_v13_1830, r_v12_1603 in r_v9_2341, r_v14_2134, r_v11_1951 do
                            local r_v1_2541 = string.find
                            local r_v16_1173 = string.lower
                            if not (r_v1_2541((r_v16_1173(r_v7_2459.Name)), r_v13_1830, 1, true)) then
                                continue
                            end
                            local r_v15_1320 = "UpgradeTag"
                            r_v15_1320 = r_v7_2459:FindFirstChild(r_v15_1320)
                            local r_v16_1176 = r_v15_1320
                            if r_v15_1320 then
                                local r_v20_794 = r_v15_1320.Value
                                r_v16_1176 = r_v20_794 < r_v12_1603
                            end
                            if r_v16_1176 then
                                local r_v20_798 = game:GetService("ReplicatedStorage")
                                r_v20_798.Remotes.Server:InvokeServer("Upgrade", r_v7_2459)
                                task.wait(0.01)
                            end
                            break
                        end
                    end
                end)
                task.wait(0.2)
            end
            o_v66_6 = false
        end)
    end
    AutoJoinGame = o_v50_12
    AutoSkipGUI = function()
        local r_v4_570 = r_v69_99:WaitForChild("Summon")
        while true do
            if not (r_v40_42.auto_skip_gui) then
                break
            end
            pcall(function()
                local r_v10_615 = r_v4_570:FindFirstChild("Skip")
                if r_v10_615.Visible then
                    pcall(function()
                        local r_v4_2978 = game:GetService("VirtualUser")
                        local r_v10_1168 = Vector2.new
                        local r_v8_2649 = workspace.CurrentCamera
                        local r_v5_2158 = r_v8_2649.ViewportSize.X
                        local r_v3_1935 = r_v5_2158 / 2
                        local r_v7_2464 = workspace.CurrentCamera
                        local r_v6_2500 = r_v7_2464.ViewportSize.Y
                        local r_v5_2159 = r_v6_2500 / 2
                        r_v4_2978:ClickButton1(r_v10_1168(r_v3_1935, r_v5_2159))
                    end)
                end
            end)
            task.wait(0.1)
        end
    end
    local o_v52_10
    local o_v53_5 = function(r_v10_277)
        if o_v52_10 then
            o_v52_10:Disconnect()
            o_v52_10 = nil
        end
        local r_v5_477 = tostring(r_v22_34.UserId)
        local r_v4_579 = "p_" .. r_v5_477
        local r_v4_580 = function()
            local r_v10_617
            local r_v2_943 = function()
                table.insert(r_v10_617, r_v17_48.PlayerList.PlayerListMaster.OffsetFrame.PlayerScrollList.SizeOffsetFrame.ScrollingFrameContainer.ScrollingFrameClippingFrame.ScollingFrame.OffsetUndoFrame[r_v4_579].ChildrenFrame.NameFrame.BGFrame.OverlayFrame.PlayerName.PlayerName)
            end
            r_v10_617 = {}
            pcall(r_v2_943)
            pcall(function()
                local r_v1_2552 = table.insert
                local r_v8_2659 = workspace.Camera
                local r_v9_2358 = r_v67_96.Name
                r_v1_2552(r_v10_617, (r_v8_2659:FindFirstChild(r_v9_2358)).Head.NameLevelBBGUI.NameFrame.TextLabel)
            end)
            return r_v10_617
        end
        local r_v4_581 = r_v10_277
        if r_v10_277 then
            r_v4_581 = r_v40_42.anonymous_mode
        end
        if r_v4_581 then
            if r_v40_42.anon_use_gradient then
                o_v52_10 = r_v15_42.RenderStepped:Connect(function()
                    local r_v10_618 = r_v49_58[r_v40_42.anon_color1]
                    local r_v4_1372 = r_v10_618
                    if not r_v10_618 then
                        local r_v2_947 = Color3
                        r_v10_618 = r_v2_947.fromRGB
                        r_v4_1372 = r_v10_618(255, 60, 60)
                    end
                    local r_v2_946 = r_v49_58[r_v40_42.anon_color2]
                    r_v10_618 = r_v4_1372
                    local r_v4_1373 = r_v2_946
                    if not r_v2_946 then
                        local r_v3_1021 = Color3
                        r_v2_946 = r_v3_1021.fromRGB
                        r_v4_1373 = r_v2_946(60, 60, 255)
                    end
                    r_v2_946 = r_v4_1373
                    local r_v5_1178 = math.sin((tick()) * 2)
                    local r_v4_1374 = r_v5_1178 + 1
                    local r_v3_1020 = 2
                    r_v3_1020 = r_v4_1374 / r_v3_1020
                    local r_v1_1321 = ColorSequence.new
                    local r_v8_1428 = ColorSequenceKeypoint.new(0, r_v10_618)
                    local r_v7_1378 = ColorSequenceKeypoint.new(0.5, r_v2_946)
                    local r_v6_1373 = ColorSequenceKeypoint.new
                    local r_v9_1292 = {
                        r_v6_1373(1, r_v10_618)
                    }
                    local r_v5_1181 = {
                        r_v8_1428,
                        r_v7_1378,
                        unpack(r_v9_1292)
                    }
                    r_v5_1181 = r_v1_1321(r_v5_1181)
                    local r_v4_1378, r_v6_1374, r_v8_1429 = pairs(r_v4_580())
                    local r_v7_1381 = r_v4_1378
                    for r_v9_1295, r_v14_1164 in r_v7_1381, r_v6_1374, r_v8_1429 do
                        r_v14_1164.TextColor3 = Color3.new(1, 1, 1)
                        local r_v11_1022 = (r_v14_1164:FindFirstChild("RainbowGradient")) or (Instance.new("UIGradient", r_v14_1164))
                        r_v11_1022.Name = "RainbowGradient"
                        r_v11_1022.Color = r_v5_1181
                        r_v11_1022.Offset = Vector2.new(r_v3_1020 - 0.5, 0)
                    end
                end)
            else
                if r_v40_42.rainbow_anon_name then
                    o_v52_10 = r_v15_42.RenderStepped:Connect(function()
                        local r_v2_950 = tick()
                        local r_v4_1379 = r_v2_950 % 3
                        local r_v10_621 = 3
                        r_v10_621 = r_v4_1379 / r_v10_621
                        local r_v2_951 = {}
                        for r_v7_1387 = 0, 1, 0.2 do
                            local r_v1_1330 = table.insert
                            local r_v9_1299 = ColorSequenceKeypoint.new
                            local r_v11_1026 = Color3.fromHSV
                            local r_v12_845 = (r_v7_1387 + r_v10_621) % 1
                            local r_v13_977 = {
                                r_v11_1026(r_v12_845, 1, 1)
                            }
                            r_v1_1330(r_v2_951, r_v9_1299(r_v7_1387, unpack(r_v13_977)))
                        end
                        local r_v4_1387 = ColorSequence
                        local r_v3_1028 = "new"
                        r_v3_1028 = r_v4_1387[r_v3_1028](r_v2_951)
                        local r_v1_1332 = pairs
                        local r_v8_1434 = r_v4_580
                        for r_v7_1390, r_v9_1301 in r_v1_1332(r_v8_1434()) do
                            r_v9_1301.TextColor3 = Color3.new(1, 1, 1)
                            local r_v14_1170 = (r_v9_1301:FindFirstChild("RainbowGradient")) or (Instance.new("UIGradient", r_v9_1301))
                            r_v14_1170.Name = "RainbowGradient"
                            r_v14_1170.Color = r_v3_1028
                            r_v14_1170.Offset = Vector2.new(0, 0)
                        end
                    end)
                end
            end
        else
            local r_v4_583 = pairs
            local r_v11_437 = {
                r_v4_580()
            }
            for r_v14_488, r_v11_440 in r_v4_583(unpack(r_v11_437)) do
                local r_v13_416 = "RainbowGradient"
                r_v13_416 = r_v11_440:FindFirstChild(r_v13_416)
                if r_v13_416 then
                    r_v13_416:Destroy()
                end
                r_v11_440.TextColor3 = Color3.new(1, 1, 1)
            end
        end
        r_v10_277 = nil
    end
    o_v52_10 = nil
    local o_v54_6 = function()
        local r_v2_420 = tostring(r_v22_34.UserId)
        local r_v1_577 = "p_" .. r_v2_420
        pcall(function()
            local r_v15_725 = r_v17_48.PlayerList.PlayerListMaster
            local r_v13_991 = r_v15_725.OffsetFrame.PlayerScrollList
            local r_v14_1171 = r_v13_991.SizeOffsetFrame.ScrollingFrameContainer
            local r_v7_1392 = r_v14_1171.ScrollingFrameClippingFrame.ScollingFrame
            local r_v5_1188 = r_v7_1392.OffsetUndoFrame[r_v1_577].ChildrenFrame
            local r_v2_952 = r_v5_1188.NameFrame.BGFrame
            local r_v1_1337 = r_v2_952.OverlayFrame.PlayerName.PlayerName
            r_v1_1337.Text = r_v40_42.anonymous_mode_name
        end)
        pcall(function()
            local r_v4_1393 = workspace.Camera
            local r_v2_959 = r_v67_96.Name
            local r_v10_629 = r_v4_1393:WaitForChild(r_v2_959)
            local r_v4_1397 = r_v10_629.Head:WaitForChild("NameLevelBBGUI")
            local r_v4_1400 = (r_v4_1397:WaitForChild("NameFrame")):WaitForChild("TextLabel")
            r_v4_1400.Text = r_v40_42.anonymous_mode_name
        end)
        o_v53_5(true)
    end
    ToggleBlackScreen = function(r_v10_282)
        pcall(function()
            local r_v10_635 = not r_v10_282
            r_v15_42:Set3dRenderingEnabled(r_v10_635)
        end)
        if r_v10_282 then
            if (not r_v17_48:FindFirstChild("StarHub_BlackScreen")) then
                local r_v1_585 = Instance.new
                local r_v2_431 = "ScreenGui"
                r_v2_431 = r_v1_585(r_v2_431, r_v17_48)
                r_v2_431.Name = "StarHub_BlackScreen"
                r_v2_431.DisplayOrder = -1
                r_v2_431.IgnoreGuiInset = true
                local r_v1_589 = Instance.new
                local r_v3_445 = "Frame"
                r_v3_445 = r_v1_589(r_v3_445, r_v2_431)
                r_v3_445.Size = UDim2.new(1, 0, 1, 0)
                r_v3_445.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                local r_v1_592 = Instance.new
                local r_v5_504 = "TextLabel"
                r_v5_504 = r_v1_592(r_v5_504, r_v3_445)
                r_v5_504.Text = "STAR HUB - BLACK SCREEN MODE\n\224\184\129\224\184\179\224\184\165\224\184\177\224\184\135\224\184\151\224\184\179\224\184\135\224\184\178\224\184\153..."
                r_v5_504.TextColor3 = Color3.fromRGB(150, 150, 150)
                r_v5_504.Size = UDim2.new(1, 0, 1, 0)
                r_v5_504.BackgroundTransparency = 1
                local r_v6_611 = Enum.Font
                r_v5_504.Font = r_v6_611.GothamBold
                r_v5_504.TextSize = 20
            end
        else
            local r_v1_584 = r_v17_48
            if r_v1_584.FindFirstChild(r_v1_584, "StarHub_BlackScreen") then
                r_v17_48.StarHub_BlackScreen:Destroy()
            end
        end
    end
    local o_v57_5 = false
    local o_v54_8 = function()
        local r_v2_433 = r_v40_42.auto_change_macro_map
        local r_v4_638 = (not r_v2_433) or (r_v71_75())
        if r_v4_638 then
            return
        end
        local r_v10_286 = o_v2_11()
        if r_v10_286 then
            local r_v2_435 = r_v3_5
            r_v2_435 = ""
            if (r_v10_286.Mode == "\224\184\171\224\184\173\224\184\132\224\184\173\224\184\162") then
                local r_v5_512 = tostring(r_v10_286.Detail)
                r_v2_435 = "[\224\184\171\224\184\173\224\184\132\224\184\173\224\184\162] \224\184\138\224\184\177\224\185\137\224\184\153 " .. r_v5_512
            else
                if (r_v10_286.Mode == "\224\185\128\224\184\153\224\184\183\224\185\137\224\184\173\224\185\128\224\184\163\224\184\183\224\185\136\224\184\173\224\184\135") then
                    local r_v6_624 = tostring(r_v10_286.Detail)
                    r_v2_435 = "[\224\185\128\224\184\153\224\184\183\224\185\137\224\184\173\224\185\128\224\184\163\224\184\183\224\185\136\224\184\173\224\184\135] \224\185\128\224\184\165\224\185\128\224\184\167\224\184\165 " .. r_v6_624
                end
            end
            if r_v40_43[r_v2_435] then
                r_v40_42.macro_profile = r_v2_435
                Save()
            end
        end
    end
    local o_v55_7 = function()
        local r_v10_287 = r_v40_42.custom_spawn_enable
        local r_v4_645 = r_v10_287
        if r_v10_287 then
            local r_v5_522 = r_v40_42.custom_spawn_cframe
            local r_v3_459 = r_v5_522 ~= ""
            local r_v10_288 = r_v3_459
            if r_v3_459 then
                local r_v6_630 = r_v71_75()
                r_v10_288 = not r_v6_630
            end
            r_v4_645 = r_v10_288
        end
        if r_v4_645 then
            task.wait(4)
            pcall(function()
                local r_v1_1344 = r_v22_34.Character.HumanoidRootPart
                r_v1_1344.CFrame = r_v31_23(r_v40_42.custom_spawn_cframe)
            end)
        end
    end
    AutoWaveStopLoop = function()
        local r_v4_650 = o_v57_5 or (r_v71_75())
        if r_v4_650 then
            return
        end
        o_v57_5 = true
        task.spawn(function()
            while true do
                if not (r_v40_42.stop_at_wave_enable) then
                    break
                end
                local r_v10_641 = r_v87_11()
                local r_v3_1048 = r_v40_42.stop_at_wave_target
                local r_v4_1408 = r_v3_1048 or 50
                if (r_v10_641 >= r_v4_1408) then
                    r_v40_42.auto_join_game = false
                    r_v40_42.auto_replay = false
                    r_v40_42.smart_auto_next = false
                    Save()
                    local r_v8_1462 = tostring(r_v87_11())
                    local r_v5_1214 = r_v8_1462 .. ")"
                    r_v22_34:Kick("\nStar Hub Auto Stop: \n\224\184\150\224\184\182\224\184\135\224\185\128\224\184\167\224\184\159\224\185\128\224\184\155\224\185\137\224\184\178\224\184\171\224\184\161\224\184\178\224\184\162\224\185\129\224\184\165\224\185\137\224\184\167 (" .. r_v5_1214)
                    break
                else
                    task.wait(2)
                end
            end
            o_v57_5 = false
        end)
    end
    local o_v57_7 = false
    AutoFpsSaverLoop = function()
        if o_v57_7 then
            return
        end
        o_v57_7 = true
        task.spawn(function()
            local r_v10_652 = 0
            while true do
                if not (r_v40_42.smart_fps_saver_enable) then
                    break
                end
                local r_v2_984 = workspace:GetRealPhysicsFPS()
                local r_v5_1217 = r_v40_42.smart_fps_saver_threshold
                local r_v4_1421 = r_v5_1217 or 15
                if (r_v2_984 < r_v4_1421) then
                    r_v10_652 = r_v10_652 + 1
                else
                    r_v10_652 = 0
                end
                if (r_v10_652 >= 10) then
                    if (r_v40_42.smart_fps_saver_action == "\224\185\128\224\184\155\224\184\180\224\184\148\224\184\136\224\184\173\224\184\148\224\184\179 (Black Screen)") then
                        r_v40_42.disable_3d_rendering = true
                        ToggleBlackScreen(true)
                    else
                        if (r_v40_42.smart_fps_saver_action == "\224\184\165\224\184\154\224\184\149\224\184\177\224\184\167\224\184\161\224\184\173\224\184\153\224\184\170\224\185\128\224\184\149\224\184\173\224\184\163\224\185\140 (Strip Enemy)") then
                            r_v40_42.fps_strip_enemy = true
                            task.spawn(StripEnemyLoop)
                        end
                    end
                    r_v67_92("Auto FPS Saver", "FPS \224\184\149\224\185\136\224\184\179\224\185\128\224\184\129\224\184\180\224\184\153\224\185\132\224\184\155! \224\184\163\224\184\176\224\184\154\224\184\154\224\185\128\224\184\155\224\184\180\224\184\148\224\185\130\224\184\171\224\184\161\224\184\148\224\184\138\224\185\136\224\184\167\224\184\162\224\185\128\224\184\171\224\184\165\224\184\183\224\184\173\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180\224\185\129\224\184\165\224\185\137\224\184\167", 5)
                    r_v10_652 = 0
                end
                task.wait(1)
            end
            o_v57_7 = false
        end)
    end
    local o_v57_9 = "StarHub/ASTD/PartySync.json"
    local o_v62_6
    local o_v63_5 = function()
        local r_v4_653 = o_v62_6 or (r_v71_75())
        if r_v4_653 then
            return
        end
        o_v62_6 = true
        local r_v4_654 = task.spawn
        local r_v2_449 = function()
            local r_v1_1351 = {}
            while true do
                if not (r_v40_42.auto_target_boss) then
                    break
                end
                local r_v2_987 = function()
                    local r_v10_1175 = {}
                    local r_v1_2554 = pairs
                    local r_v6_2509 = workspace
                    local r_v7_2478 = r_v2_3
                    local r_v5_2166 = r_v6_2509.Enemies
                    local r_v4_2984, r_v2_1890, r_v3_1940 = r_v1_2554(r_v5_2166.GetChildren(r_v5_2166))
                    local r_v5_2168 = r_v4_2984
                    for r_v6_2511, r_v8_2668 in r_v5_2168, r_v2_1890, r_v3_1940 do
                        local r_v14_2158 = r_v8_2668:GetAttribute("TitleString")
                        local r_v9_2364 = r_v14_2158 == "Boss"
                        r_v7_2478 = r_v9_2364
                        if not r_v9_2364 then
                            local r_v14_2161 = r_v8_2668:GetAttribute("OriginalTitleString")
                            r_v7_2478 = r_v14_2161 == "Boss"
                        end
                        if r_v7_2478 then
                            if r_v8_2668.PrimaryPart then
                                local r_v7_2480 = table
                                r_v7_2480.insert(r_v10_1175, r_v8_2668)
                            end
                        end
                    end
                    if ((#r_v10_1175) > 0) then
                        local r_v1_2556 = pairs
                        local r_v8_2669 = {
                            r_v74_49()
                        }
                        for r_v6_2515, r_v1_2559 in r_v1_2556(unpack(r_v8_2669)) do
                            r_v7_2478 = true
                            local r_v11_1979 = r_v40_42.auto_target_boss_unit
                            local r_v14_2164 = r_v11_1979 ~= ""
                            local r_v9_2369 = r_v14_2164
                            if r_v14_2164 then
                                local r_v11_1980 = r_v40_42.auto_target_boss_unit
                                r_v9_2369 = r_v11_1980 ~= "\224\184\151\224\184\184\224\184\129\224\184\149\224\184\177\224\184\167 (All)"
                            end
                            if r_v9_2369 then
                                local r_v11_1981 = r_v40_42.auto_target_boss_unit
                                local r_v14_2166 = r_v11_1981 == "\224\185\132\224\184\161\224\185\136\224\185\132\224\184\148\224\185\137\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129 (None)"
                                r_v9_2369 = r_v14_2166
                                if not r_v14_2166 then
                                    local r_v11_1982 = string.find
                                    local r_v15_1345 = string.lower(r_v1_2559.Name)
                                    local r_v12_1634 = string.lower
                                    local r_v17_1039 = r_v40_42.auto_target_boss_unit
                                    local r_v13_1865 = r_v11_1982(r_v15_1345, r_v12_1634(r_v17_1039))
                                    r_v9_2369 = not r_v13_1865
                                end
                                if r_v9_2369 then
                                    r_v7_2478 = false
                                end
                            end
                            r_v9_2369 = r_v7_2478
                            if r_v7_2478 then
                                local r_v13_1866 = r_v1_2559
                                r_v9_2369 = r_v13_1866.PrimaryPart
                            end
                            if r_v9_2369 then
                                local r_v13_1869 = r_v1_2559:GetAttribute("Range")
                                r_v9_2369 = r_v13_1869
                                if not r_v13_1869 then
                                    local r_v16_1209 = r_v78_33(r_v1_2559.Name)
                                    local r_v12_1638 = r_v16_1209.Range
                                    r_v9_2369 = r_v12_1638 or 0
                                end
                                local r_v14_2170 = pairs
                                for r_v14_2171, r_v15_1352 in r_v14_2170(r_v10_1175) do
                                    local r_v20_824 = r_v40_42.auto_target_boss_condition
                                    local r_v17_1044 = r_v20_824 == "\224\185\128\224\184\161\224\184\183\224\185\136\224\184\173\224\184\154\224\184\173\224\184\170\224\185\128\224\184\130\224\185\137\224\184\178\224\184\163\224\184\176\224\184\162\224\184\176 (\224\185\128\224\184\130\224\185\137\224\184\178\224\184\167\224\184\135)"
                                    local r_v16_1210 = false
                                    if r_v17_1044 then
                                        local r_v19_656 = r_v1_2559.PrimaryPart.Position
                                        local r_v18_509 = r_v15_1352.PrimaryPart.Position
                                        if ((r_v19_656 - r_v18_509).Magnitude <= r_v9_2369) then
                                            r_v16_1210 = true
                                        end
                                    else
                                        r_v16_1210 = true
                                    end
                                    local r_v19_658 = r_v16_1210
                                    if r_v16_1210 then
                                        local r_v22_418 = r_v1_1351[r_v1_2559]
                                        r_v19_658 = not r_v22_418
                                    end
                                    if r_v19_658 then
                                        local r_v18_512 = r_v1_2559
                                        r_v1_1351[r_v18_512] = true
                                        task.spawn(function()
                                            for r_v6_2795 = 1, 3 do
                                                local r_v7_2761 = game:GetService("ReplicatedStorage")
                                                local r_v1_2819 = r_v7_2761.Remotes.Input
                                                local r_v7_2764 = r_v1_2559
                                                r_v1_2819:FireServer("ChangePriority", r_v7_2764)
                                                task.wait(0.15)
                                            end
                                        end)
                                    end
                                end
                                r_v9_2369 = nil
                            end
                            r_v7_2478 = nil
                        end
                    else
                        r_v1_1351 = {}
                    end
                end
                pcall(r_v2_987)
                task.wait(0.5)
            end
            o_v62_6 = false
        end
        r_v4_654(r_v2_449)
    end
    MasterSyncLoop = function()
        task.spawn(function()
            while true do
                local r_v4_1428 = r_v40_42.sync_role
                if r_v4_1428 ~= "\224\184\171\224\184\177\224\184\167\224\184\149\224\184\181\224\185\137 (Master)" then
                    break
                end
                local r_v10_657 = r_v22_34.Character
                local r_v4_1429 = r_v10_657
                if r_v10_657 then
                    r_v10_657 = r_v22_34.Character
                    r_v4_1429 = r_v10_657:FindFirstChild("HumanoidRootPart")
                end
                r_v10_657 = r_v4_1429
                local r_v3_1066 = r_v69_100()
                local r_v8_1490 = r_v10_657 and (tostring(r_v10_657.CFrame))
                local r_v5_1236 = r_v8_1490 or ("")
                local r_v8_1492 = game.PlaceId
                local r_v14_1197 = r_v71_75()
                local r_v1_1359 = {
                    ["World"] = r_v3_1066,
                    ["CFrame"] = r_v5_1236,
                    ["GameId"] = r_v8_1492,
                    ["IsLobby"] = r_v14_1197
                }
                pcall(function()
                    local r_v2_1895 = r_v22_33
                    writefile(o_v57_9, r_v2_1895.JSONEncode(r_v2_1895, r_v1_1359))
                end)
                task.wait(0.2)
            end
        end)
    end
    AltSyncLoop = function()
        task.spawn(function()
            while true do
                local r_v4_1435 = r_v40_42.sync_role
                if r_v4_1435 ~= "\224\184\156\224\184\185\224\185\137\224\184\149\224\184\178\224\184\161 (Alt)" then
                    break
                end
                if isfile(o_v57_9) then
                    pcall(function()
                        local r_v10_1177 = readfile
                        r_v10_1177 = r_v22_33:JSONDecode(r_v10_1177(o_v57_9))
                        if r_v10_1177 then
                            local r_v3_1945 = r_v10_1177.GameId
                            local r_v5_2172 = game.PlaceId
                            local r_v2_1898 = r_v3_1945 ~= r_v5_2172
                            local r_v4_2990 = r_v2_1898
                            if r_v2_1898 then
                                local r_v5_2173 = r_v71_75()
                                r_v4_2990 = not r_v5_2173
                            end
                            if r_v4_2990 then
                                local r_v4_2994 = game:GetService("TeleportService")
                                local r_v2_1901 = r_v10_1177.GameId
                                local r_v3_1949 = game.JobId
                                r_v4_2994:TeleportToPlaceInstance(r_v2_1901, r_v3_1949, r_v22_34)
                            else
                                local r_v2_1902 = r_v10_1177.IsLobby
                                local r_v4_2995 = r_v2_1902
                                if r_v2_1902 then
                                    local r_v6_2526 = r_v71_75()
                                    local r_v2_1903 = r_v6_2526
                                    if r_v6_2526 then
                                        local r_v6_2527 = r_v10_1177.CFrame
                                        r_v2_1903 = r_v6_2527 ~= ""
                                    end
                                    r_v4_2995 = r_v2_1903
                                end
                                if r_v4_2995 then
                                    local r_v2_1904 = r_v22_34.Character
                                    local r_v4_2996 = r_v2_1904
                                    if r_v2_1904 then
                                        r_v2_1904 = r_v22_34.Character
                                        r_v4_2996 = r_v2_1904:FindFirstChild("HumanoidRootPart")
                                    end
                                    r_v2_1904 = r_v4_2996
                                    if r_v2_1904 then
                                        r_v2_1904.CFrame = r_v31_23(r_v10_1177.CFrame)
                                    end
                                end
                            end
                        end
                    end)
                end
                task.wait(0.2)
            end
        end)
    end
    local o_v64_6
    local o_v61_7 = function()
        if r_v71_75() then
            return
        end
        local r_v1_614 = r_v69_99.HUD
        local r_v10_310 = "MissionEnd"
        r_v10_310 = r_v1_614:WaitForChild(r_v10_310)
        repeat
            local r_v4_665 = task
            r_v4_665.wait()
            local r_v4_667 = "Visible"
        until r_v10_310[r_v4_667]
        task.wait(2)
        local r_v2_461 = false
        local r_v3_473 = r_v3_5
        r_v3_473 = ""
        if r_v40_42.stop_max_runs_enable then
            r_v40_42.current_runs = r_v40_42.current_runs + 1
            Save()
            local r_v4_675 = r_v40_42.current_runs
            local r_v5_541 = r_v40_42.stop_max_runs
            if (r_v4_675 >= r_v5_541) then
                r_v2_461 = true
                local r_v7_642 = tostring(r_v40_42.stop_max_runs)
                local r_v4_676 = "\224\184\132\224\184\163\224\184\154\224\184\136\224\184\179\224\184\153\224\184\167\224\184\153\224\184\163\224\184\173\224\184\154\224\184\151\224\184\181\224\185\136\224\184\129\224\184\179\224\184\171\224\184\153\224\184\148 (" .. (r_v7_642 .. ")")
                r_v40_42.current_runs = 0
                Save()
                r_v3_473 = r_v4_676
            end
        end
        local r_v8_657 = r_v40_42.stop_item_drop_enable
        local r_v5_542 = r_v8_657
        if r_v8_657 then
            local r_v7_644 = r_v40_42.stop_item_name
            r_v5_542 = r_v7_644 ~= ""
        end
        if r_v5_542 then
            local r_v5_546 = pairs
            local r_v11_463 = getgenv()
            local r_v9_583 = r_v11_463.MatchDrops
            for r_v5_546, r_v9_584 in r_v5_546(r_v9_583) do
                local r_v14_523 = string.find
                local r_v12_389 = string
                local r_v12_390 = r_v12_389.lower(r_v5_546)
                local r_v13_439 = string.lower
                local r_v16_283 = r_v40_42.stop_item_name
                if not (r_v14_523(r_v12_390, r_v13_439(r_v16_283))) then
                    continue
                end
                r_v3_473 = "\224\185\132\224\184\148\224\185\137\224\184\163\224\184\177\224\184\154\224\185\132\224\184\173\224\185\128\224\184\151\224\184\161\224\185\128\224\184\155\224\185\137\224\184\178\224\184\171\224\184\161\224\184\178\224\184\162: " .. r_v5_546
                r_v2_461 = true
                break
            end
        end
        if r_v2_461 then
            r_v40_42.auto_join_game = false
            r_v40_42.auto_replay = false
            r_v40_42.smart_auto_next = false
            Save()
            local r_v8_671 = "\nStar Hub Auto Stop: \n" .. r_v3_473
            r_v22_34:Kick(r_v8_671)
        end
    end
    o_v62_6 = false
    local o_v65_5 = function()
        local r_v4_677 = o_v64_6 or (r_v71_75())
        if r_v4_677 then
            return
        end
        o_v64_6 = true
        local r_v4_678 = task.spawn
        local r_v2_465 = function()
            while true do
                if not (r_v40_42.auto_skill_boss) then
                    break
                end
                local r_v10_666 = function()
                    local r_v10_1178 = {}
                    local r_v2_1905 = {}
                    local r_v1_2575 = pairs
                    local r_v6_2533 = workspace.Enemies
                    local r_v4_3000, r_v3_1959, r_v5_2186 = r_v1_2575(r_v6_2533.GetChildren(r_v6_2533))
                    local r_v6_2535 = r_v4_3000
                    for r_v8_2689, r_v7_2498 in r_v6_2535, r_v3_1959, r_v5_2186 do
                        if r_v7_2498.PrimaryPart then
                            local r_v9_2383 = table
                            r_v9_2383.insert(r_v2_1905, r_v7_2498)
                            local r_v11_1998 = r_v7_2498:GetAttribute("TitleString")
                            local r_v14_2186 = r_v11_1998 == "Boss"
                            local r_v9_2385 = r_v14_2186
                            if not r_v14_2186 then
                                local r_v11_2001 = r_v7_2498:GetAttribute("OriginalTitleString")
                                r_v9_2385 = r_v11_2001 == "Boss"
                            end
                            if r_v9_2385 then
                                local r_v9_2388 = table
                                r_v9_2388.insert(r_v10_1178, r_v7_2498)
                            end
                        end
                    end
                    if ((#r_v10_1178) > 0) then
                        local r_v3_1961 = {}
                        local r_v1_2580 = pairs
                        local r_v9_2386 = {
                            r_v74_49()
                        }
                        for r_v7_2501, r_v9_2387 in r_v1_2580(unpack(r_v9_2386)) do
                            local r_v12_1647 = r_v40_42.auto_skill_boss_unit
                            local r_v13_1883 = r_v12_1647 ~= ""
                            local r_v14_2190 = true
                            local r_v11_2003 = r_v13_1883
                            if r_v13_1883 then
                                local r_v12_1648 = r_v40_42.auto_skill_boss_unit
                                r_v11_2003 = r_v12_1648 ~= "\224\184\151\224\184\184\224\184\129\224\184\149\224\184\177\224\184\167 (All)"
                            end
                            if r_v11_2003 then
                                local r_v12_1650 = r_v40_42.auto_skill_boss_unit
                                local r_v13_1887 = r_v12_1650 == "\224\185\132\224\184\161\224\185\136\224\185\132\224\184\148\224\185\137\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129 (None)"
                                r_v11_2003 = r_v13_1887
                                if not r_v13_1887 then
                                    local r_v12_1651 = string.find
                                    local r_v17_1059 = string.lower(r_v9_2387.Name)
                                    local r_v16_1226 = string.lower
                                    local r_v19_672 = r_v40_42.auto_skill_boss_unit
                                    local r_v15_1367 = r_v12_1651(r_v17_1059, r_v16_1226(r_v19_672))
                                    r_v11_2003 = not r_v15_1367
                                end
                                if r_v11_2003 then
                                    r_v14_2190 = false
                                end
                            end
                            r_v11_2003 = r_v14_2190
                            if r_v14_2190 then
                                r_v11_2003 = r_v9_2387.PrimaryPart
                            end
                            if r_v11_2003 then
                                local r_v12_1655 = r_v9_2387:GetAttribute("Range")
                                r_v11_2003 = r_v12_1655
                                if not r_v12_1655 then
                                    local r_v20_849 = r_v78_33(r_v9_2387.Name)
                                    local r_v16_1231 = r_v20_849.Range
                                    r_v11_2003 = r_v16_1231 or 0
                                end
                                local r_v16_1230, r_v17_1062, r_v20_848 = pairs(r_v2_1905)
                                local r_v12_1658 = 0
                                local r_v13_1893 = 0
                                for r_v15_1378, r_v19_683 in r_v16_1230, r_v17_1062, r_v20_848 do
                                    local r_v22_426 = r_v9_2387.PrimaryPart.Position
                                    local r_v23_323 = r_v19_683.PrimaryPart.Position
                                    if ((r_v22_426 - r_v23_323).Magnitude <= r_v11_2003) then
                                        local r_v21_498 = r_v12_1658 + 1
                                        local r_v25_252 = r_v19_683:GetAttribute("TitleString")
                                        local r_v24_306 = r_v25_252 == "Boss"
                                        r_v12_1658 = r_v21_498
                                        local r_v22_429 = r_v24_306
                                        if not r_v24_306 then
                                            local r_v25_256 = r_v19_683:GetAttribute("OriginalTitleString")
                                            r_v22_429 = r_v25_256 == "Boss"
                                        end
                                        if r_v22_429 then
                                            r_v13_1893 = r_v13_1893 + 1
                                        end
                                    end
                                end
                                local r_v17_1066 = r_v40_42.auto_skill_boss_trigger_condition
                                local r_v16_1232 = r_v17_1066 == "\224\184\129\224\184\148\224\185\128\224\184\161\224\184\183\224\185\136\224\184\173\224\184\161\224\184\181\224\185\129\224\184\132\224\185\136\224\184\154\224\184\173\224\184\170\224\185\131\224\184\153\224\184\167\224\184\135\224\185\128\224\184\151\224\185\136\224\184\178\224\184\153\224\184\177\224\185\137\224\184\153"
                                local r_v15_1379 = false
                                if r_v16_1232 then
                                    if ((r_v13_1893 > 0) and (r_v12_1658 == r_v13_1893)) then
                                        r_v15_1379 = true
                                    end
                                else
                                    local r_v18_539 = r_v40_42.auto_skill_boss_count
                                    local r_v20_857 = r_v18_539 or 1
                                    if (r_v13_1893 >= r_v20_857) then
                                        r_v15_1379 = true
                                    end
                                end
                                if r_v15_1379 then
                                    local r_v19_689 = table
                                    r_v19_689.insert(r_v3_1961, r_v9_2387)
                                end
                                r_v11_2003 = nil
                            end
                        end
                        if ((#r_v3_1961) > 0) then
                            if (r_v40_42.auto_skill_boss_target_amount == "\224\184\129\224\184\148\224\184\149\224\184\177\224\184\167\224\185\128\224\184\148\224\184\181\224\184\162\224\184\167 (\224\184\173\224\184\177\224\184\155\224\185\128\224\184\129\224\184\163\224\184\148\224\184\170\224\184\185\224\184\135\224\184\170\224\184\184\224\184\148)") then
                                table.sort(r_v3_1961, function(r_v10_1266, r_v2_2045)
                                    local r_v6_2799 = r_v10_1266:FindFirstChild("UpgradeTag")
                                    local r_v3_2127 = r_v6_2799
                                    if r_v6_2799 then
                                        local r_v8_2948 = r_v10_1266.UpgradeTag
                                        r_v3_2127 = r_v8_2948.Value
                                    end
                                    local r_v4_3234 = r_v3_2127 or 0
                                    local r_v7_2771 = r_v2_2045:FindFirstChild("UpgradeTag")
                                    local r_v6_2801 = r_v7_2771
                                    if r_v7_2771 then
                                        local r_v9_2648 = r_v2_2045.UpgradeTag
                                        r_v6_2801 = r_v9_2648.Value
                                    end
                                    local r_v5_2403 = r_v6_2801 or 0
                                    return (r_v4_3234 > r_v5_2403)
                                end)
                                local r_v6_2541 = r_v3_1961[1]
                                r_v3_1961 = {
                                    r_v6_2541
                                }
                            end
                            local r_v6_2542 = ipairs
                            for r_v6_2543, r_v14_2195 in r_v6_2542(r_v3_1961) do
                                if (r_v40_42.auto_skill_boss_mode == "Multiple (\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129\224\184\138\224\185\136\224\184\173\224\184\135\224\184\170\224\184\129\224\184\180\224\184\165)") then
                                    o_v16_14(r_v14_2195, "")
                                    task.spawn(function()
                                        local r_v10_1267 = "MultipleAbilities"
                                        r_v10_1267 = r_v69_99:FindFirstChild(r_v10_1267)
                                        local r_v4_3240 = r_v10_1267 and (r_v10_1267:FindFirstChild(("Frame")))
                                        if r_v4_3240 then
                                            local r_v2_2050 = 0
                                            local r_v1_2825 = ipairs
                                            local r_v6_2804 = r_v10_1267.Frame
                                            local r_v4_3242, r_v3_2131, r_v5_2406 = r_v1_2825(r_v6_2804.GetChildren(r_v6_2804))
                                            local r_v6_2806 = r_v4_3242
                                            for r_v8_2955, r_v1_2826 in r_v6_2806, r_v3_2131, r_v5_2406 do
                                                if (r_v1_2826.Name == "ImageButton") then
                                                    r_v2_2050 = r_v2_2050 + 1
                                                    local r_v13_2107 = r_v40_42.auto_skill_boss_multi_index
                                                    local r_v14_2437 = r_v13_2107 or 1
                                                    if (r_v2_2050 == r_v14_2437) then
                                                        local r_v14_2439 = getgenv()
                                                        r_v14_2439.IsAutoBuffClicking = true
                                                        pcall(function()
                                                            firesignal(r_v1_2826.Activated)
                                                        end)
                                                        pcall(function()
                                                            firesignal(r_v1_2826.MouseButton1Click)
                                                        end)
                                                        task.wait(0.2)
                                                        local r_v14_2447 = getgenv()
                                                        r_v14_2447.IsAutoBuffClicking = false
                                                        break
                                                    end
                                                end
                                            end
                                        end
                                    end)
                                else
                                    o_v16_14(r_v14_2195, "")
                                end
                                task.wait(0.3)
                            end
                        end
                    end
                end
                pcall(r_v10_666)
                task.wait(0.5)
            end
            o_v64_6 = false
        end
        r_v4_678(r_v2_465)
    end
    o_v64_6 = false
    o_v66_6 = false
    o_v68_6 = false
    OnGameEnd = function()
        if (not r_v71_75()) then
            local r_v1_629 = r_v69_99.HUD
            local r_v10_317 = "MissionEnd"
            r_v10_317 = r_v1_629:WaitForChild(r_v10_317)
            repeat
                local r_v4_685 = task
                r_v4_685.wait()
                local r_v4_687 = "Visible"
            until r_v10_317[r_v4_687]
            task.wait(1.5)
            task.spawn(o_v61_7)
            if r_v40_42.macro_record then
                r_v40_42.macro_record = false
                StopMacroRecord()
                Save()
                local r_v2_482 = getgenv()
                if r_v2_482.MacroRecordToggle then
                    local r_v2_485 = getgenv()
                    r_v2_485.MacroRecordToggle:Set(false, true)
                end
            end
            if r_v40_42.webhook_end_game then
                local r_v26_46
                local r_v2_487 = {}
                local r_v1_643 = 0
                local r_v1_646 = r_v10_317:FindFirstChild("BG")
                local r_v6_679 = r_v1_646 ~= nil
                local r_v4_707 = r_v6_679
                if r_v6_679 then
                    local r_v7_662 = r_v1_646:FindFirstChild("Times")
                    r_v4_707 = r_v7_662 ~= nil
                end
                if r_v4_707 then
                    pcall(function()
                        local r_v10_670 = tonumber
                        local r_v9_1340 = r_v29_27((r_v1_646:FindFirstChild("Times")).Text, "\n")
                        local r_v2_1009 = r_v10_670((r_v29_27(r_v9_1340[2], "seconds"))[1])
                        r_v1_643 = r_v2_1009 or 0
                    end)
                end
                local r_v6_683 = ((o_v2_13 ~= nil) and o_v2_13) or ("Victory")
                local r_v8_690 = r_v3_5
                r_v8_690 = ""
                local r_v7_666 = function()
                    local r_v10_672
                    local r_v2_1010 = function()
                        local r_v4_3001 = game.Players
                        local r_v10_1180 = "LocalPlayer"
                        r_v10_1180 = r_v4_3001[r_v10_1180]
                        local r_v2_1909 = r_v10_1180.PlayerGui
                        local r_v3_1967 = r_v2_1909:FindFirstChild("HUD")
                        local r_v4_3002 = r_v3_1967
                        if r_v3_1967 then
                            local r_v6_2552 = r_v10_1180.PlayerGui.HUD:FindFirstChild("StorageMenu")
                            r_v2_1909 = r_v6_2552
                            if r_v6_2552 then
                                local r_v7_2516 = r_v10_1180.PlayerGui.HUD.StorageMenu:FindFirstChild("Page")
                                local r_v5_2199 = r_v7_2516
                                if r_v7_2516 then
                                    local r_v11_2019 = r_v10_1180.PlayerGui.HUD
                                    local r_v14_2207 = r_v11_2019.StorageMenu.Page:FindFirstChild("Main")
                                    local r_v8_2712 = r_v14_2207
                                    if r_v14_2207 then
                                        local r_v15_1390 = r_v10_1180.PlayerGui.HUD
                                        local r_v13_1914 = r_v15_1390.StorageMenu.Page.Main:FindFirstChild("Bottom")
                                        local r_v9_2403 = r_v13_1914
                                        if r_v13_1914 then
                                            local r_v16_1247 = r_v10_1180.PlayerGui.HUD
                                            local r_v12_1682 = r_v16_1247.StorageMenu.Page
                                            r_v9_2403 = r_v12_1682.Main.Bottom:FindFirstChild("Items")
                                        end
                                        r_v8_2712 = r_v9_2403
                                    end
                                    r_v5_2199 = r_v8_2712
                                end
                                r_v2_1909 = r_v5_2199
                            end
                            r_v4_3002 = r_v2_1909
                        end
                        r_v2_1909 = r_v4_3002
                        if r_v2_1909 then
                            local r_v4_3004, r_v3_1969, r_v5_2200 = pairs(r_v2_1909.GetChildren(r_v2_1909))
                            local r_v6_2555 = r_v4_3004
                            for r_v8_2713, r_v7_2518 in r_v6_2555, r_v3_1969, r_v5_2200 do
                                local r_v9_2404 = "Name"
                                r_v9_2404 = r_v7_2518[r_v9_2404]
                                local r_v15_1396 = r_v7_2518.GetDescendants
                                local r_v1_2594 = pairs
                                local r_v12_1681 = {
                                    r_v15_1396(r_v7_2518)
                                }
                                for r_v12_1685, r_v15_1402 in r_v1_2594(unpack(r_v12_1681)) do
                                    local r_v16_1252 = (r_v15_1402:IsA("TextLabel")) and ((r_v15_1402.Text) and (r_v15_1402.Visible))
                                    if r_v16_1252 then
                                        local r_v16_1254 = string.match(r_v15_1402.Text, "x(%d+)")
                                        if r_v16_1254 then
                                            r_v10_672[r_v9_2404] = tonumber(r_v16_1254)
                                            r_v16_1254 = nil
                                            break
                                        else
                                            r_v16_1254 = nil
                                        end
                                    end
                                end
                            end
                        end
                    end
                    r_v10_672 = {}
                    pcall(r_v2_1010)
                    pcall(function()
                        local r_v2_1913 = game:GetService("ReplicatedStorage")
                        local r_v4_3005 = r_v2_1913.Remotes
                        local r_v10_1183 = "Server"
                        r_v10_1183 = r_v4_3005[r_v10_1183]
                        local r_v2_1916 = "Units"
                        r_v2_1916 = r_v10_1183:InvokeServer("Data", r_v2_1916)
                        if (type(r_v2_1916) == "table") then
                            local r_v1_2604 = pairs
                            for r_v8_2725, r_v7_2525 in r_v1_2604(r_v2_1916) do
                                local r_v13_1927 = type(r_v7_2525)
                                local r_v9_2411 = (r_v13_1927 == "table") and (r_v7_2525.Name)
                                if r_v9_2411 then
                                    local r_v9_2415 = r_v7_2525.Name
                                    local r_v12_1696 = r_v10_672[r_v7_2525.Name]
                                    local r_v11_2037 = r_v12_1696 or 0
                                    r_v10_672[r_v9_2415] = r_v11_2037 + 1
                                end
                            end
                        end
                        local r_v3_1978 = (r_v10_1183:InvokeServer("Data", "Materials")) or ((r_v10_1183:InvokeServer("Data", "Inventory")) or (r_v10_1183:InvokeServer("Data", "Items")))
                        if (type(r_v3_1978) == "table") then
                            local r_v5_2210 = pairs
                            for r_v5_2210, r_v9_2414 in r_v5_2210(r_v3_1978) do
                                if (type(r_v9_2414) == "table") then
                                    local r_v11_2040 = state
                                    local r_v14_2224 = (r_v9_2414.Name) or ((r_v9_2414.ItemName) or (tostring(r_v5_2210)))
                                    local r_v15_1417 = tonumber(r_v9_2414.Amount)
                                    r_v11_2040 = r_v15_1417
                                    if not r_v15_1417 then
                                        local r_v17_1107 = tonumber(r_v9_2414.Value)
                                        local r_v12_1706 = r_v17_1107
                                        if not r_v17_1107 then
                                            local r_v19_721 = tonumber(r_v9_2414.Count)
                                            r_v12_1706 = r_v19_721 or 1
                                        end
                                        r_v11_2040 = r_v12_1706
                                    end
                                    local r_v17_1105 = type(r_v14_2224)
                                    local r_v15_1421 = r_v17_1105 == "string"
                                    local r_v13_1941 = r_v15_1421
                                    if r_v15_1421 then
                                        local r_v16_1272 = r_v10_672[r_v14_2224]
                                        r_v13_1941 = not r_v16_1272
                                    end
                                    if r_v13_1941 then
                                        r_v10_672[r_v14_2224] = r_v11_2040
                                    end
                                else
                                    local r_v15_1415 = type(r_v9_2414)
                                    local r_v13_1937 = r_v15_1415 == "number"
                                    local r_v14_2225 = r_v13_1937
                                    if r_v13_1937 then
                                        local r_v15_1420 = type(r_v5_2210)
                                        r_v14_2225 = r_v15_1420 == "string"
                                    end
                                    if r_v14_2225 then
                                        if (not r_v10_672[r_v5_2210]) then
                                            r_v10_672[r_v5_2210] = r_v9_2414
                                        end
                                    end
                                end
                            end
                        end
                    end)
                    return r_v10_672
                end
                local r_v9_595 = r_v7_666()
                local r_v1_652 = {}
                local r_v1_653 = 0
                local r_v13_442 = function()
                    if r_v1_646 then
                        local r_v2_1016
                        local r_v10_673 = r_v1_646
                        local r_v2_1014 = r_v10_673:FindFirstChild("Rewards")
                        local r_v4_1452 = r_v2_1014
                        if not r_v2_1014 then
                            r_v2_1016 = state
                            local r_v5_1249 = r_v1_646:FindFirstChild("RewardList")
                            r_v10_673 = r_v5_1249
                            if not r_v5_1249 then
                                r_v10_673 = (r_v1_646:FindFirstChild("Drop")) or ((r_v1_646:FindFirstChild(("Reward"))) or (r_v1_646:FindFirstChild(("Items"))))
                            end
                            r_v4_1452 = r_v10_673
                        end
                        r_v10_673 = r_v4_1452
                        if r_v10_673 then
                            r_v2_1016 = false
                            local r_v4_1454, r_v3_1079, r_v5_1251 = pairs(r_v10_673.GetChildren(r_v10_673))
                            local r_v6_1447 = r_v4_1454
                            for r_v8_1517, r_v7_1452 in r_v6_1447, r_v3_1079, r_v5_1251 do
                                local r_v9_1356 = (r_v7_1452:IsA("GuiObject")) and (r_v7_1452.Visible)
                                if r_v9_1356 then
                                    local r_v9_1363 = "Name"
                                    r_v9_1363 = r_v7_1452[r_v9_1363]
                                    local r_v14_1222 = 1
                                    local r_v16_658 = r_v7_1452.GetDescendants
                                    local r_v1_1385 = pairs
                                    local r_v15_749 = {
                                        r_v16_658(r_v7_1452)
                                    }
                                    for r_v15_750, r_v16_660 in r_v1_1385(unpack(r_v15_749)) do
                                        local r_v20_411 = r_v16_660:IsA("TextLabel")
                                        local r_v17_559 = r_v20_411
                                        if r_v20_411 then
                                            local r_v18_248 = r_v16_660.Visible
                                            local r_v20_417 = r_v18_248
                                            if r_v18_248 then
                                                local r_v21_273 = r_v16_660.Text
                                                r_v20_417 = r_v21_273 ~= ""
                                            end
                                            r_v17_559 = r_v20_417
                                        end
                                        if r_v17_559 then
                                            local r_v17_566 = "Text"
                                            r_v17_566 = r_v16_660[r_v17_566]
                                            local r_v20_421 = string.match(r_v17_566, "^x?%s*(%d+)$")
                                            if r_v20_421 then
                                                r_v14_1222 = tonumber(r_v20_421)
                                            else
                                                local r_v21_278 = r_v17_566 ~= r_v9_1363
                                                local r_v18_255 = r_v21_278
                                                if r_v21_278 then
                                                    local r_v25_177 = tonumber(r_v17_566)
                                                    local r_v23_194 = not r_v25_177
                                                    local r_v21_280 = r_v23_194
                                                    if r_v23_194 then
                                                        local r_v25_179 = string.match(r_v17_566, "^x?%s*(%d+)$")
                                                        r_v21_280 = not r_v25_179
                                                    end
                                                    r_v18_255 = r_v21_280
                                                end
                                                if r_v18_255 then
                                                    local r_v18_258 = string.lower(r_v9_1363)
                                                    local r_v21_283 = (r_v18_258 == "frame") or ((r_v18_258 == "imagelabel") or ((r_v18_258 == "template") or ((r_v18_258 == "item") or ((r_v18_258 == ("reward")) or ((r_v18_258 == ("drop")) or (tonumber(r_v9_1363)))))))
                                                    if r_v21_283 then
                                                        r_v9_1363 = r_v17_566
                                                    end
                                                end
                                            end
                                        end
                                    end
                                    local r_v11_1087 = {
                                        ["frame"] = true,
                                        ["imagelabel"] = true,
                                        ["template"] = true,
                                        ["item"] = true,
                                        ["uilistlayout"] = true,
                                        ["uigridlayout"] = true,
                                        ["uicorner"] = true,
                                        ["uipadding"] = true,
                                        ["reward"] = true,
                                        ["drop"] = true,
                                        ["rewards"] = true,
                                        ["drops"] = true
                                    }
                                    local r_v17_564 = type(r_v9_1363)
                                    local r_v15_753 = r_v17_564 == "string"
                                    local r_v13_1024 = r_v15_753
                                    if r_v15_753 then
                                        local r_v17_565 = r_v9_1363 ~= ""
                                        local r_v15_754 = r_v17_565
                                        if r_v17_565 then
                                            local r_v22_266 = tonumber(r_v9_1363)
                                            local r_v18_254 = not r_v22_266
                                            local r_v17_567 = r_v18_254
                                            if r_v18_254 then
                                                local r_v22_267 = string.lower
                                                local r_v21_279 = r_v11_1087[r_v22_267(r_v9_1363)]
                                                r_v17_567 = not r_v21_279
                                            end
                                            r_v15_754 = r_v17_567
                                        end
                                        r_v13_1024 = r_v15_754
                                    end
                                    if r_v13_1024 then
                                        local r_v17_568 = r_v1_652[r_v9_1363]
                                        local r_v15_756 = r_v17_568 or 0
                                        r_v1_652[r_v9_1363] = r_v15_756 + r_v14_1222
                                        r_v2_1016 = true
                                    end
                                end
                            end
                            if r_v2_1016 then
                                r_v1_653 = 3
                            end
                        end
                    end
                    local r_v10_674 = r_v1_646 and (r_v1_646:FindFirstChild(("Title")))
                    if r_v10_674 then
                        local r_v2_1018 = string.lower(r_v1_646.Title.Text)
                        local r_v10_676 = (string.find(r_v2_1018, "defeat")) or ((string.find(r_v2_1018, "lose")) or (string.find(r_v2_1018, "fail")))
                        if r_v10_676 then
                            r_v6_683 = "Defeat"
                        end
                    end
                end
                pcall(r_v13_442)
                if (r_v1_653 < 3) then
                    local r_v13_444 = function()
                        local r_v2_1022 = game:GetService("ReplicatedStorage")
                        local r_v1_1401 = r_v2_1022.Remotes.Server
                        local r_v10_681 = "MissionEndInfo"
                        r_v10_681 = r_v1_1401:InvokeServer(r_v10_681)
                        if (type(r_v10_681) == "table") then
                            local r_v3_1091
                            local r_v2_1028
                            local r_v3_1087 = r_v10_681.Result
                            local r_v2_1027 = r_v3_1087 == "Defeat"
                            local r_v4_1461 = r_v2_1027
                            if not r_v2_1027 then
                                local r_v6_1462 = r_v10_681.Result
                                local r_v5_1265 = r_v6_1462 == "Lose"
                                r_v2_1028 = r_v5_1265
                                if not r_v5_1265 then
                                    local r_v7_1466 = r_v10_681.Result
                                    local r_v8_1530 = r_v7_1466 == "Fail"
                                    local r_v5_1268 = r_v8_1530
                                    if not r_v8_1530 then
                                        local r_v7_1468 = r_v10_681.Success
                                        r_v5_1268 = r_v7_1468 == false
                                    end
                                    r_v2_1028 = r_v5_1268
                                end
                                r_v4_1461 = r_v2_1028
                            end
                            if r_v4_1461 then
                                r_v6_683 = "Defeat"
                            end
                            r_v2_1028 = state
                            local r_v3_1090 = r_v10_681.Reward
                            local r_v4_1463 = r_v3_1090
                            if not r_v3_1090 then
                                local r_v6_1466 = r_v10_681.Rewards
                                r_v3_1091 = r_v6_1466
                                if not r_v6_1466 then
                                    r_v3_1091 = (r_v10_681.Drop) or ((r_v10_681.Drops) or (r_v10_681.items))
                                end
                                r_v4_1463 = r_v3_1091
                            end
                            r_v3_1091 = r_v2_1028
                            r_v2_1028 = r_v4_1463
                            local r_v4_1464 = r_v2_1028
                            if r_v2_1028 then
                                local r_v8_1534 = type(r_v2_1028)
                                r_v4_1464 = r_v8_1534 == "table"
                            end
                            if r_v4_1464 then
                                r_v3_1091 = false
                                local r_v7_1471 = {
                                    pairs(r_v2_1028)
                                }
                                local r_v8_1536 = r_v7_1471[3]
                                local r_v6_1470 = r_v7_1471[2]
                                local r_v5_1272 = r_v7_1471[1]
                                for r_v7_1471, r_v9_1378 in r_v5_1272, r_v6_1470, r_v8_1536 do
                                    local r_v14_1236 = state
                                    local r_v16_671 = type(r_v9_1378)
                                    local r_v11_1098 = (r_v16_671 == "string") and r_v9_1378
                                    local r_v4_1467 = r_v11_1098
                                    if not r_v11_1098 then
                                        local r_v12_906 = r_v9_1378.Name
                                        r_v11_1098 = r_v12_906
                                        if not r_v12_906 then
                                            r_v11_1098 = (r_v9_1378.ItemName) or (tostring(r_v7_1471))
                                        end
                                        r_v4_1467 = r_v11_1098
                                    end
                                    r_v11_1098 = r_v14_1236
                                    local r_v12_905 = tonumber(r_v9_1378.Amount)
                                    r_v14_1236 = r_v4_1467
                                    local r_v4_1468 = r_v12_905
                                    if not r_v12_905 then
                                        local r_v16_677 = tonumber(r_v9_1378.Value)
                                        local r_v13_1041 = r_v16_677
                                        if not r_v16_677 then
                                            local r_v20_433 = tonumber(r_v9_1378.Count)
                                            r_v13_1041 = r_v20_433 or 1
                                        end
                                        r_v4_1468 = r_v13_1041
                                    end
                                    r_v11_1098 = r_v4_1468
                                    local r_v16_675 = type(r_v14_1236)
                                    local r_v12_907 = r_v16_675 == "string"
                                    local r_v4_1469 = r_v12_907
                                    if r_v12_907 then
                                        local r_v16_679 = r_v14_1236 ~= ""
                                        local r_v12_910 = r_v16_679
                                        if r_v16_679 then
                                            local r_v20_435 = tonumber(r_v14_1236)
                                            r_v12_910 = not r_v20_435
                                        end
                                        r_v4_1469 = r_v12_910
                                    end
                                    if r_v4_1469 then
                                        local r_v16_683 = r_v1_652[r_v14_1236]
                                        local r_v12_911 = r_v16_683 or 0
                                        r_v1_652[r_v14_1236] = r_v12_911 + r_v11_1098
                                        r_v3_1091 = true
                                    end
                                end
                                if r_v3_1091 then
                                    r_v1_653 = 2
                                end
                            end
                        end
                    end
                    pcall(r_v13_444)
                end
                if (r_v1_653 < 2) then
                    local r_v15_329 = getgenv()
                    local r_v13_446 = r_v15_329.MatchDrops
                    local r_v4_718 = r_v13_446
                    if r_v13_446 then
                        local r_v15_332 = type((getgenv()).MatchDrops)
                        r_v4_718 = r_v15_332 == "table"
                    end
                    if r_v4_718 then
                        local r_v1_659 = pairs
                        local r_v17_238 = getgenv()
                        local r_v15_333 = r_v17_238.MatchDrops
                        local r_v16_291 = {
                            r_v1_659(r_v15_333)
                        }
                        local r_v4_720 = r_v16_291[1]
                        local r_v13_450 = r_v16_291[2]
                        local r_v12_398 = r_v16_291[3]
                        local r_v15_334 = r_v4_720
                        for r_v16_291, r_v17_240 in r_v15_334, r_v13_450, r_v12_398 do
                            r_v1_652[r_v16_291] = r_v17_240
                        end
                    end
                end
                local r_v1_658 = pairs
                local r_v16_286 = r_v1_652
                for r_v16_286, r_v17_236 in r_v1_658(r_v16_286) do
                    local r_v20_140 = (r_v9_595[r_v16_286]) or r_v17_236
                    if (r_v20_140 < r_v17_236) then
                        r_v20_140 = r_v17_236
                    end
                    local r_v28_29 = tostring(r_v17_236)
                    local r_v29_32 = tostring(r_v20_140)
                    local r_v26_32 = " | \224\185\131\224\184\153\224\184\129\224\184\163\224\184\176\224\185\128\224\184\155\224\185\139\224\184\178: " .. (r_v29_32 .. "]\n")
                    local r_v23_39 = " [\224\184\148\224\184\163\224\184\173\224\184\155: x" .. (r_v28_29 .. r_v26_32)
                    local r_v18_91 = "\226\128\162 " .. (r_v16_286 .. r_v23_39)
                    r_v8_690 = r_v8_690 .. r_v18_91
                end
                if (r_v8_690 == "") then
                    r_v8_690 = "\224\185\132\224\184\161\224\185\136\224\184\161\224\184\181\224\185\132\224\184\173\224\185\128\224\184\151\224\184\161\224\184\148\224\184\163\224\184\173\224\184\155"
                end
                local r_v15_338 = getgenv()
                r_v15_338.MatchDrops = {}
                local r_v15_340 = "```"
                local r_v18_90 = r_v6_683 == "Victory"
                local r_v16_299 = state
                local r_v12_404 = (r_v18_90 and ("+")) or ("-")
                local r_v20_148 = (r_v6_683 == "Victory") and ("\226\156\133")
                r_v16_299 = r_v20_148
                if not r_v20_148 then
                    r_v16_299 = "\226\157\140"
                end
                local r_v21_109 = r_v88_10()
                local r_v17_248 = r_v21_109 or 0
                local r_v22_79 = r_v89_11()
                local r_v20_151 = r_v22_79 or 0
                local r_v23_44 = r_v90_10()
                local r_v18_98 = r_v23_44 or 0
                local r_v24_56 = r_v91_11()
                local r_v21_113 = r_v24_56 or 0
                local r_v23_47 = o_v2_15.Gems
                local r_v22_83 = r_v17_248 - r_v23_47
                local r_v24_58 = o_v2_15.Gold
                local r_v23_48 = r_v20_151 - r_v24_58
                local r_v25_46 = o_v2_15.Stardust
                local r_v24_59 = r_v18_98 - r_v25_46
                local r_v26_38 = o_v2_15.GauntletTokens
                local r_v25_47 = r_v21_113 - r_v26_38
                r_v40_53.TotalGems = r_v40_53.TotalGems + r_v22_83
                r_v40_53.TotalGold = r_v40_53.TotalGold + r_v23_48
                r_v40_53.TotalStardust = r_v40_53.TotalStardust + r_v24_59
                r_v40_53.TotalRuns = r_v40_53.TotalRuns + 1
                local r_v35_24 = r_v40_53.TotalPlayTime
                local r_v29_47 = math.round(r_v1_643)
                r_v40_53.TotalPlayTime = r_v35_24 + r_v29_47
                r_v49_53()
                local r_v27_41 = o_v2_11()
                if r_v27_41 then
                    local r_v28_43 = r_v27_41.Mode
                    local r_v30_32 = tostring(r_v27_41.Detail)
                    if (r_v28_43 == "\224\184\171\224\184\173\224\184\132\224\184\173\224\184\162") then
                        r_v26_46 = "[\224\184\171\224\184\173\224\184\132\224\184\173\224\184\162] \224\184\138\224\184\177\224\185\137\224\184\153 " .. r_v30_32
                    else
                        if (r_v28_43 == "\224\185\128\224\184\153\224\184\183\224\185\137\224\184\173\224\185\128\224\184\163\224\184\183\224\185\136\224\184\173\224\184\135") then
                            r_v26_46 = "[\224\185\128\224\184\153\224\184\183\224\185\137\224\184\173\224\185\128\224\184\163\224\184\183\224\185\136\224\184\173\224\184\135] \224\185\128\224\184\165\224\185\128\224\184\167\224\184\165 " .. r_v30_32
                        else
                            if (r_v28_43 == "\224\184\159\224\184\178\224\184\163\224\185\140\224\184\161") then
                                local r_v32_41 = (r_v49_54[r_v30_32]) or (("\224\184\148\224\185\136\224\184\178\224\184\153 ") .. r_v30_32)
                                r_v26_46 = "[\224\184\159\224\184\178\224\184\163\224\185\140\224\184\161] " .. r_v32_41
                            else
                                if (r_v28_43 == "\224\185\128\224\184\163\224\184\148") then
                                    local r_v33_60 = (r_v49_55[r_v30_32]) or (("\224\184\148\224\185\136\224\184\178\224\184\153 ") .. r_v30_32)
                                    r_v26_46 = "[\224\185\128\224\184\163\224\184\148] " .. r_v33_60
                                else
                                    local r_v39_61 = "] \224\185\128\224\184\165\224\185\128\224\184\167\224\184\165 " .. r_v30_32
                                    r_v26_46 = "[" .. (r_v28_43 .. r_v39_61)
                                end
                            end
                        end
                    end
                else
                    local r_v30_34 = "\224\184\129\224\184\185\224\185\132\224\184\161\224\185\136\224\184\163\224\184\185\224\185\137"
                    pcall(function()
                        local r_v4_1472 = r_v69_99.HUD.TopFrame.MapName
                        r_v30_34 = r_v4_1472.Text
                    end)
                    if ((r_v30_34 == "") or (r_v30_34 == ("Map Name"))) then
                        pcall(function()
                            local r_v2_1036 = game:GetService("ReplicatedStorage")
                            local r_v4_1473 = r_v2_1036.Map
                            r_v30_34 = r_v4_1473.Value
                        end)
                    end
                    r_v26_46 = r_v30_34
                end
                local r_v48_56 = tostring(r_v87_11())
                local r_v49_68 = "\n" .. r_v15_340
                local r_v45_59 = "\nWave: " .. (r_v48_56 .. r_v49_68)
                local r_v43_45 = "yaml\nMap: " .. (r_v26_46 .. r_v45_59)
                local r_v40_64 = r_v15_340 .. r_v43_45
                local r_v33_53 = {
                    ["name"] = "\240\159\151\186\239\184\143 **MATCH INFO**",
                    ["value"] = r_v40_64,
                    ["inline"] = false
                }
                local r_v54_51 = string.upper(r_v6_683)
                local r_v53_51 = "\n" .. r_v15_340
                local r_v48_59 = " " .. (r_v54_51 .. r_v53_51)
                local r_v47_53 = " " .. (r_v16_299 .. r_v48_59)
                local r_v42_57 = "diff\n" .. (r_v12_404 .. r_v47_53)
                local r_v43_50 = r_v15_340 .. r_v42_57
                local r_v37_50 = {
                    ["name"] = "\226\154\148\239\184\143 **STATUS**",
                    ["value"] = r_v43_50,
                    ["inline"] = true
                }
                local r_v49_74 = o_v8_31(math.round(r_v1_643))
                local r_v54_54 = math.round
                local r_v52_58 = r_v100_10()
                local r_v51_58 = r_v52_58 - r_v99_11
                local r_v53_54 = o_v8_31(r_v54_54(r_v51_58))
                local r_v46_60 = "\n" .. r_v15_340
                local r_v50_63 = "\nReal   : " .. (r_v53_54 .. r_v46_60)
                local r_v44_66 = "yaml\nIn-Game: " .. (r_v49_74 .. r_v50_63)
                local r_v42_62 = r_v15_340 .. r_v44_66
                local r_v39_51 = {
                    ["name"] = "\226\143\177\239\184\143 **TIME ELAPSED**",
                    ["value"] = r_v42_62,
                    ["inline"] = true
                }
                local r_v48_66 = tostring(r_v22_83)
                local r_v54_58 = tostring(r_v17_248)
                local r_v52_62 = tostring(r_v23_48)
                local r_v59_71 = tostring(r_v20_151)
                local r_v63_89 = tostring(r_v24_59)
                local r_v67_103 = tostring(r_v18_98)
                local r_v71_80 = tostring(r_v25_47)
                local r_v75_43 = tostring(r_v21_113)
                local r_v74_55 = ")\n" .. r_v15_340
                local r_v70_95 = " (Total: " .. (r_v75_43 .. r_v74_55)
                local r_v66_100 = ")\n[G-Coins]  +" .. (r_v71_80 .. r_v70_95)
                local r_v62_87 = " (Total: " .. (r_v67_103 .. r_v66_100)
                local r_v58_75 = ")\n[Stardust] +" .. (r_v63_89 .. r_v62_87)
                local r_v55_66 = " (Total: " .. (r_v59_71 .. r_v58_75)
                local r_v53_57 = ")\n[Gold]     +" .. (r_v52_62 .. r_v55_66)
                local r_v49_79 = " (Total: " .. (r_v54_58 .. r_v53_57)
                local r_v45_75 = "ini\n[Gems]     +" .. (r_v48_66 .. r_v49_79)
                local r_v44_71 = r_v15_340 .. r_v45_75
                local r_v41_47 = {
                    ["name"] = "\240\159\146\142 **REWARDS & ECONOMY**",
                    ["value"] = r_v44_71,
                    ["inline"] = true
                }
                local r_v48_70 = "\n" .. r_v15_340
                local r_v47_69 = "yaml\n" .. (r_v8_690 .. r_v48_70)
                local r_v45_80 = r_v15_340 .. r_v47_69
                local r_v40_71 = {
                    ["name"] = "\240\159\142\129 **DROPS / REWARDS**",
                    ["value"] = r_v45_80,
                    ["inline"] = true
                }
                local r_v46_69 = tostring(r_v92_10())
                local r_v51_66 = tostring(r_v93_11())
                local r_v36_67 = "\n" .. r_v15_340
                local r_v38_69 = "\n\226\152\133 Star Pass   : Tier " .. (r_v51_66 .. r_v36_67)
                local r_v50_79 = "fix\n\226\152\133 Level       : " .. (r_v46_69 .. r_v38_69)
                local r_v47_74 = r_v15_340 .. r_v50_79
                local r_v43_57 = {
                    ["name"] = "\240\159\147\136 **PLAYER PROGRESSION**",
                    ["value"] = r_v47_74,
                    ["inline"] = false
                }
                r_v2_487 = {
                    r_v33_53,
                    r_v37_50,
                    r_v39_51,
                    r_v41_47,
                    r_v40_71,
                    r_v43_57
                }
                SendWebhook(r_v2_487)
                local r_v39_52 = r_v6_683 == "Victory"
                local r_v33_55 = r_v39_52
                if r_v39_52 then
                    local r_v39_56 = r_v27_41
                    if r_v27_41 then
                        local r_v43_62 = r_v27_41.Mode
                        r_v39_56 = r_v43_62 == "\224\184\171\224\184\173\224\184\132\224\184\173\224\184\162"
                    end
                    r_v33_55 = r_v39_56
                end
                if r_v33_55 then
                    local r_v37_63 = tonumber(r_v27_41.Detail)
                    if r_v37_63 then
                        o_v1_10("\224\184\171\224\184\173\224\184\132\224\184\173\224\184\162", (tostring(r_v37_63 + 1)), "Tower")
                    end
                end
            end
        end
    end
    local o_v73_5 = r_v69_100()
    local o_v71_4 = o_v73_5 ~= (-1)
    local o_v69_7 = o_v71_4
    if o_v71_4 then
        local o_v73_6 = r_v69_100()
        o_v69_7 = o_v73_6 ~= (-2)
    end
    if o_v69_7 then
        local o_v70_9 = r_v69_99:WaitForChild("LoadingScreen", 5)
        local o_v69_9 = o_v70_9 and (o_v70_9:FindFirstChild(("Frame")))
        if o_v69_9 then
            repeat
                local o_v71_19 = task
                o_v71_19.wait()
                local o_v71_25 = o_v70_9.Frame.Visible
            until not o_v71_25
        end
        if (not r_v71_75()) then
            r_v100_11()
            local o_v71_21 = task
            o_v71_21.spawn(o_v11_29)
            if r_v40_42.auto_buff then
                task.spawn(AutoBuff)
            end
            if r_v40_42.auto_vote_extreme then
                task.spawn(AutoVoteExtreme)
            end
            if r_v40_42.auto_vote_normal then
                task.spawn(AutoVoteNormal)
            end
            local o_v69_42 = (r_v40_42.auto_2x) or (r_v40_42.auto_3x)
            if o_v69_42 then
                task.spawn(AutoChangeSpeed)
            end
            if r_v40_42.auto_battle then
                task.spawn(AutoBattle)
            end
            if r_v40_42.smart_auto_next then
                task.spawn(SmartAutoNext)
            end
            if r_v40_42.auto_replay then
                task.spawn(AutoReplay)
            end
            if r_v40_42.auto_next_story then
                task.spawn(AutoNextStory)
            end
            if r_v40_42.macro_record then
                task.spawn(StartMacroRecord)
            end
            if r_v40_42.macro_playback then
                task.spawn(StartMacroPlayback)
            end
            if r_v40_42.auto_upgrade then
                task.spawn(AutoUpgrade)
            end
            if r_v40_42.smart_skip_enable then
                task.spawn(SmartSkipWaveLoop)
            end
            if r_v40_42.auto_upgrade_sell then
                task.spawn(AutoSell)
            end
            if r_v40_42.auto_farm_enable then
                task.spawn(AutoFarmSetup)
            end
            local o_v71_109 = task
            o_v71_109.spawn(o_v43_16)
            if r_v40_42.auto_target_boss then
                task.spawn(o_v63_5)
            end
            if r_v40_42.auto_skill_boss then
                task.spawn(o_v65_5)
            end
            if r_v40_42.auto_specific_upgrade then
                task.spawn(o_v67_5)
            end
            if r_v40_42.auto_cleanse_enable then
                task.spawn(AutoCleanseLoop)
            end
            if r_v40_42.fps_wipe_map then
                task.spawn(WipeMapLoop)
            end
            if r_v40_42.fps_strip_enemy then
                task.spawn(StripEnemyLoop)
            end
            if r_v40_42.auto_stop_g_enable then
                task.spawn(AutoGauntletStop)
            end
            if r_v40_42.stop_at_wave_enable then
                task.spawn(AutoWaveStopLoop)
            end
            if r_v40_42.auto_killua_enable then
                task.spawn(AutoKilluaLoop)
            end
            if r_v40_42.smart_fps_saver_enable then
                task.spawn(AutoFpsSaverLoop)
            end
            if (r_v40_42.sync_role == "\224\184\171\224\184\177\224\184\167\224\184\149\224\184\181\224\185\137 (Master)") then
                task.spawn(MasterSyncLoop)
            else
                if (r_v40_42.sync_role == "\224\184\156\224\184\185\224\185\137\224\184\149\224\184\178\224\184\161 (Alt)") then
                    task.spawn(AltSyncLoop)
                end
            end
            local o_v71_145 = task
            o_v71_145.spawn(o_v54_8)
            local o_v71_147 = task
            o_v71_147.spawn(o_v55_7)
            task.spawn(OnGameEnd)
        else
            if r_v40_42.auto_evolve_exp then
                task.spawn(AutoEvolveEXP)
            end
            if r_v40_42.auto_claim_tasks then
                task.spawn(AutoClaimTasksLoop)
            end
            task.wait(1)
            if r_v40_42.auto_join_game then
                task.spawn(AutoJoinGame)
            end
            if r_v40_42.auto_join_tower then
                task.spawn(AutoTower)
            end
            if r_v40_42.auto_summon_enable then
                task.spawn(AutoSummonLoop)
            end
        end
        if r_v40_42.auto_skip_gui then
            task.spawn(AutoSkipGUI)
        end
        if r_v40_42.fps_boost then
            pcall(function()
                local r_v10_382 = game
                ;(loadstring(r_v10_382.HttpGet(r_v10_382, "https://pastebin.com/raw/CnN5kYRT")))()
            end)
        end
        if r_v40_42.anonymous_mode then
            task.spawn(o_v54_6)
        end
        if r_v40_42.hide_unit_effects then
            task.spawn(o_v69_5)
        end
    end
    local o_v73_8 = r_v69_100()
    local o_v69_10 = (o_v73_8 == (-2)) and (r_v40_42.auto_join_game)
    if o_v69_10 then
        task.spawn(AutoJoinGame)
    end
    task.spawn(function()
        if r_v40_42.disable_3d_rendering then
            ToggleBlackScreen(true)
        end
        if r_v40_42.anti_afk then
            local r_v1_675 = pairs
            local r_v3_492 = getconnections
            local r_v6_688 = r_v22_34.Idled
            for r_v5_572, r_v6_689 in r_v1_675(r_v3_492(r_v6_688)) do
                r_v6_689:Disable()
            end
        end
    end)
    local o_v69_15 = pairs
    local o_v73_15 = r_v17_48
    local o_v75_14 = o_v73_15.GetChildren
    local o_v74_13 = {
        o_v75_14(o_v73_15)
    }
    for o_v69_26, o_v73_21 in o_v69_15(unpack(o_v74_13)) do
        if (o_v73_21.Name == "StarHub_ASTD") then
            o_v73_21:Destroy()
        end
    end
    local o_v70_18 = Instance.new("ScreenGui")
    o_v70_18.Name = "StarHub_ASTD"
    o_v70_18.Parent = r_v17_48
    o_v70_18.ResetOnSpawn = false
    local o_v72_45 = Enum.ZIndexBehavior
    o_v70_18.ZIndexBehavior = o_v72_45.Sibling
    local o_v73_41 = UDim.new(0, 8)
    local o_v69_32 = {
        ["CornerRadius"] = o_v73_41,
        ["AnimSpeed"] = 0.25
    }
    local o_v73_43 = {}
    local o_v69_33 = {
        ["Texts"] = o_v73_43
    }
    local o_v73_44 = function(r_v10_322)
        local r_v2_491 = r_v49_60[r_v10_322]
        local r_v4_727 = r_v2_491
        if not r_v2_491 then
            local r_v3_497 = Enum.Font
            r_v2_491 = r_v3_497.GothamBold
            r_v4_727 = r_v2_491
        end
        r_v2_491 = r_v4_727
        local r_v4_729, r_v3_496, r_v5_574 = pairs(o_v69_33.Texts)
        local r_v6_691 = r_v4_729
        for r_v8_699, r_v7_672 in r_v6_691, r_v3_496, r_v5_574 do
            local r_v9_601 = r_v7_672
            if r_v7_672 then
                r_v9_601 = (r_v7_672.Parent) and ((r_v7_672:IsA("TextLabel")) or ((r_v7_672:IsA(("TextButton"))) or (r_v7_672:IsA(("TextBox")))))
            end
            if r_v9_601 then
                r_v7_672.Font = r_v2_491
            end
        end
        r_v10_322 = nil
    end
    local o_v74_42 = function(r_v10_323)
        r_v60_90.Accent = r_v10_323
        r_v40_42.theme_accent_r = math.floor(r_v10_323.R * 255)
        r_v40_42.theme_accent_g = math.floor(r_v10_323.G * 255)
        r_v40_42.theme_accent_b = math.floor(r_v10_323.B * 255)
        Save()
        local r_v1_689 = pairs
        local r_v5_590 = o_v69_33.Texts
        for r_v6_707, r_v8_715 in r_v1_689(r_v5_590) do
            local r_v7_680 = r_v8_715
            if r_v8_715 then
                r_v7_680 = r_v8_715.Parent
            end
            if r_v7_680 then
                local r_v14_546 = TweenInfo.new(0.3)
                local r_v9_613 = {
                    ["TextColor3"] = r_v10_323
                }
                ;(r_v13_49:Create(r_v8_715, r_v14_546, r_v9_613)):Play()
            end
        end
        r_v10_323 = nil
    end
    local o_v75_41 = Instance.new("ImageButton", o_v70_18)
    local o_v77_30 = r_v40_42.toggle_size
    local o_v75_42 = o_v77_30 or 50
    o_v75_41.Size = UDim2.new(0, o_v75_42, 0, o_v75_42)
    o_v75_41.Position = UDim2.new(0, 15, 0, 15)
    o_v75_41.BackgroundColor3 = r_v60_90.SidebarBg
    o_v75_41.Image = "rbxthumb://type=Asset&id=110070009923641&w=150&h=150"
    o_v75_41.ZIndex = 9999
    local o_v77_37 = Instance.new("UICorner", o_v75_41)
    o_v77_37.CornerRadius = UDim.new(1, 0)
    local o_v77_39 = Instance.new("UIStroke", o_v75_41)
    o_v77_39.Color = r_v60_90.Outline
    o_v77_39.Thickness = 1.5
    local o_v76_49 = nil
    local o_v78_45 = nil
    local o_v79_36 = nil
    local o_v80_35 = nil
    local o_v80_36 = false
    o_v75_41.InputBegan:Connect(function(r_v10_324)
        local r_v3_509 = r_v10_324.UserInputType
        local r_v5_593 = Enum.UserInputType.MouseButton1
        local r_v2_501 = r_v3_509 == r_v5_593
        local r_v4_738 = r_v2_501
        if not r_v2_501 then
            local r_v3_510 = r_v10_324.UserInputType
            local r_v5_595 = Enum.UserInputType.Touch
            r_v4_738 = r_v3_510 == r_v5_595
        end
        if r_v4_738 then
            o_v76_49 = true
            o_v80_36 = false
            o_v79_36 = r_v10_324.Position
            o_v80_35 = o_v75_41.Position
            r_v10_324.Changed:Connect(function()
                local r_v4_1474 = r_v10_324.UserInputState
                local r_v10_688 = Enum.UserInputState.End
                if (r_v4_1474 == r_v10_688) then
                    o_v76_49 = false
                end
            end)
        end
    end)
    o_v75_41.InputChanged:Connect(function(r_v10_326)
        local r_v3_513 = r_v10_326.UserInputType
        local r_v5_600 = Enum.UserInputType.MouseMovement
        local r_v2_504 = r_v3_513 == r_v5_600
        local r_v4_740 = r_v2_504
        if not r_v2_504 then
            local r_v3_514 = r_v10_326.UserInputType
            local r_v5_602 = Enum.UserInputType.Touch
            r_v4_740 = r_v3_514 == r_v5_602
        end
        if r_v4_740 then
            o_v78_45 = r_v10_326
        end
        r_v10_326 = nil
    end)
    r_v12_49.InputChanged:Connect(function(r_v10_327)
        if ((r_v10_327 == o_v78_45) and o_v76_49) then
            local r_v4_742 = r_v10_327.Position
            local r_v2_509 = o_v79_36
            r_v2_509 = r_v4_742 - r_v2_509
            if (r_v2_509.Magnitude > 5) then
                o_v80_36 = true
            end
            local r_v5_606 = UDim2.new
            local r_v8_737 = o_v80_35.X.Scale
            local r_v9_634 = o_v80_35.X.Offset
            local r_v14_566 = r_v2_509.X
            local r_v7_708 = r_v9_634 + r_v14_566
            local r_v9_635 = o_v80_35.Y.Scale
            local r_v11_505 = o_v80_35.Y.Offset
            local r_v13_483 = r_v2_509.Y
            o_v75_41.Position = r_v5_606(r_v8_737, r_v7_708, r_v9_635, r_v11_505 + r_v13_483)
        end
        r_v10_327 = nil
    end)
    local o_v83_29 = function(r_v10_328)
        if ((r_v10_328 == "") or (not r_v10_328)) then
            o_v75_41.Image = "rbxthumb://type=Asset&id=110070009923641&w=150&h=150"
            return
        end
        local r_v2_514 = string.find
        local r_v4_747 = (r_v2_514(r_v10_328, "rbxassetid://")) or (tonumber(r_v10_328))
        if r_v4_747 then
            local r_v5_615 = (tonumber(r_v10_328)) and (("rbxassetid://") .. r_v10_328)
            o_v75_41.Image = r_v5_615 or r_v10_328
            return
        end
        task.spawn(function()
            pcall(function()
                local r_v10_1184 = getsynasset
                local r_v4_3011 = r_v10_1184
                if not r_v10_1184 then
                    r_v10_1184 = getcustomasset
                    r_v4_3011 = r_v10_1184
                end
                local r_v2_1918 = request
                r_v10_1184 = r_v4_3011
                local r_v4_3012 = r_v2_1918
                if not r_v2_1918 then
                    local r_v5_2211 = http_request
                    r_v2_1918 = r_v5_2211
                    if not r_v5_2211 then
                        r_v2_1918 = (syn.request) or (fluxus.request)
                    end
                    r_v4_3012 = r_v2_1918
                end
                r_v2_1918 = r_v4_3012
                if ((not r_v10_1184) or (not r_v2_1918)) then
                    return
                end
                local r_v3_1983 = "Url"
                local r_v9_2422 = {
                    ["User-Agent"] = "Mozilla/5.0"
                }
                r_v3_1983 = r_v2_1918({
                    [r_v3_1983] = r_v10_328,
                    ["Method"] = "GET",
                    ["Headers"] = r_v9_2422
                })
                if (r_v3_1983.StatusCode == 200) then
                    local r_v8_2736 = tostring(127659)
                    local r_v5_2218 = r_v8_2736 .. ".png"
                    r_v5_2218 = "starhub_toggle_" .. r_v5_2218
                    writefile(r_v5_2218, r_v3_1983.Body)
                    o_v75_41.Image = r_v10_1184(r_v5_2218)
                end
            end)
        end)
    end
    local o_v84_19 = Instance.new("Frame", o_v70_18)
    local o_v86_10 = r_v40_42.ui_width
    local o_v84_20 = o_v86_10 or 500
    local o_v87_11 = r_v40_42.ui_height
    local o_v85_17 = o_v87_11 or 300
    o_v84_19.Size = UDim2.new(0, o_v84_20, 0, o_v85_17)
    o_v84_19.Position = UDim2.new(0.5, -(o_v84_20 / 2), 0.5, -(o_v85_17 / 2))
    o_v84_19.BackgroundColor3 = r_v60_90.MainBg
    o_v84_19.Active = true
    o_v84_19.ClipsDescendants = true
    o_v84_19.ZIndex = 1
    local o_v87_19 = Instance.new("UICorner", o_v84_19)
    o_v87_19.CornerRadius = o_v69_32.CornerRadius
    local o_v87_21 = Instance.new("UIStroke", o_v84_19)
    o_v87_21.Color = r_v60_90.Outline
    o_v87_21.Thickness = 1.5
    local o_v88_38 = Instance.new("ImageLabel", o_v84_19)
    o_v88_38.Name = "StarHub_Bg"
    o_v88_38.Size = UDim2.new(1, 0, 1, 0)
    o_v88_38.ZIndex = 0
    o_v88_38.BackgroundTransparency = 1
    local o_v91_38 = Enum.ScaleType
    o_v88_38.ScaleType = o_v91_38.Crop
    o_v88_38.ClipsDescendants = true
    local o_v89_44 = Instance.new("Frame", o_v88_38)
    o_v89_44.Size = UDim2.new(1, 0, 1, 0)
    o_v89_44.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    local o_v95_26 = r_v40_42.bg_transparency
    local o_v93_45 = o_v95_26
    if o_v95_26 then
        local o_v96_13 = r_v40_42.bg_transparency
        o_v93_45 = o_v96_13 / 100
    end
    o_v89_44.BackgroundTransparency = o_v93_45 or 0.45
    o_v89_44.ZIndex = 0
    o_v89_44.BorderSizePixel = 0
    local o_v90_56 = Instance.new("Frame", o_v84_19)
    local o_v91_57 = Instance.new("Frame", o_v84_19)
    local o_v92_61 = function(r_v10_330)
        if ((r_v10_330 == "") or (not r_v10_330)) then
            o_v88_38.Image = ""
            o_v84_19.BackgroundTransparency = 0
            o_v91_57.BackgroundTransparency = 0
            o_v90_56.BackgroundTransparency = 0
            return
        end
        local r_v2_531 = string.find
        local r_v4_756 = (r_v2_531(r_v10_330, "rbxassetid://")) or (tonumber(r_v10_330))
        if r_v4_756 then
            local r_v5_629 = (tonumber(r_v10_330)) and (("rbxassetid://") .. r_v10_330)
            o_v88_38.Image = r_v5_629 or r_v10_330
            o_v84_19.BackgroundTransparency = 0.2
            o_v91_57.BackgroundTransparency = 0.25
            o_v90_56.BackgroundTransparency = 0.25
            return
        end
        task.spawn(function()
            pcall(function()
                local r_v10_1185 = getsynasset
                local r_v4_3020 = r_v10_1185
                if not r_v10_1185 then
                    r_v10_1185 = getcustomasset
                    r_v4_3020 = r_v10_1185
                end
                r_v10_1185 = r_v4_3020
                local r_v2_1921 = request
                local r_v4_3021 = r_v2_1921
                if not r_v2_1921 then
                    local r_v5_2219 = http_request
                    r_v2_1921 = r_v5_2219
                    if not r_v5_2219 then
                        r_v2_1921 = (syn.request) or (fluxus.request)
                    end
                    r_v4_3021 = r_v2_1921
                end
                r_v2_1921 = r_v4_3021
                if ((not r_v10_1185) or (not r_v2_1921)) then
                    return
                end
                local r_v3_1988 = "Url"
                local r_v9_2438 = {
                    ["User-Agent"] = "Mozilla/5.0"
                }
                r_v3_1988 = r_v2_1921({
                    [r_v3_1988] = r_v10_330,
                    ["Method"] = "GET",
                    ["Headers"] = r_v9_2438
                })
                if (r_v3_1988.StatusCode == 200) then
                    local r_v8_2747 = tostring(127659)
                    local r_v5_2226 = r_v8_2747 .. ".png"
                    r_v5_2226 = "starhub_bg_" .. r_v5_2226
                    writefile(r_v5_2226, r_v3_1988.Body)
                    o_v88_38.Image = r_v10_1185(r_v5_2226)
                    o_v84_19.BackgroundTransparency = 0.2
                    o_v91_57.BackgroundTransparency = 0.25
                    o_v90_56.BackgroundTransparency = 0.25
                end
            end)
        end)
    end
    local o_v93_54 = Instance.new("UIScale", o_v84_19)
    o_v93_54.Scale = 1
    local o_v94_49 = Instance.new("Frame", o_v70_18)
    o_v94_49.Size = UDim2.new(0, 220, 0, 45)
    o_v94_49.Position = UDim2.new(0.5, (-110), 0, 20)
    o_v94_49.BackgroundColor3 = r_v60_90.TopbarBg
    o_v94_49.Visible = false
    o_v94_49.Active = true
    local o_v95_48 = Instance.new("UICorner", o_v94_49)
    o_v95_48.CornerRadius = UDim.new(0, 8)
    local o_v95_50 = Instance.new("UIStroke", o_v94_49)
    o_v95_50.Color = r_v60_90.Outline
    o_v95_50.Thickness = 1.5
    local o_v96_46 = Instance.new("UIScale", o_v94_49)
    o_v96_46.Scale = 1
    local o_v97_47 = Instance.new("TextLabel", o_v94_49)
    o_v97_47.Size = UDim2.new(1, (-85), 1, 0)
    o_v97_47.Position = UDim2.new(0, 45, 0, 0)
    o_v97_47.BackgroundTransparency = 1
    o_v97_47.Text = "Star Hub (\224\184\162\224\185\136\224\184\173)"
    o_v97_47.TextColor3 = r_v60_90.Accent
    local o_v99_49 = Enum.Font
    o_v97_47.Font = o_v99_49.GothamBold
    o_v97_47.TextSize = 14
    local o_v99_52 = Enum.TextXAlignment
    o_v97_47.TextXAlignment = o_v99_52.Left
    table.insert(o_v69_33.Texts, o_v97_47)
    local o_v98_65 = Instance.new("TextButton", o_v94_49)
    o_v98_65.Size = UDim2.new(0, 40, 1, 0)
    o_v98_65.Position = UDim2.new(1, (-40), 0, 0)
    o_v98_65.BackgroundTransparency = 1
    o_v98_65.Text = "\240\159\148\131"
    o_v98_65.TextColor3 = r_v60_90.Text
    local o_v100_70 = Enum.Font
    o_v98_65.Font = o_v100_70.GothamBold
    o_v98_65.TextSize = 18
    local o_v96_66 = nil
    local o_v99_73 = nil
    local o_v100_72 = nil
    local o_v101_63 = nil
    o_v94_49.InputBegan:Connect(function(r_v10_332)
        local r_v3_548 = r_v10_332.UserInputType
        local r_v5_636 = Enum.UserInputType.MouseButton1
        local r_v2_544 = r_v3_548 == r_v5_636
        local r_v4_763 = r_v2_544
        if not r_v2_544 then
            local r_v3_549 = r_v10_332.UserInputType
            local r_v5_638 = Enum.UserInputType.Touch
            r_v4_763 = r_v3_549 == r_v5_638
        end
        if r_v4_763 then
            o_v96_66 = true
            o_v100_72 = r_v10_332.Position
            o_v101_63 = o_v94_49.Position
            r_v10_332.Changed:Connect(function()
                local r_v4_1479 = r_v10_332.UserInputState
                local r_v10_692 = Enum.UserInputState.End
                if (r_v4_1479 == r_v10_692) then
                    o_v96_66 = false
                end
            end)
        end
    end)
    o_v94_49.InputChanged:Connect(function(r_v10_334)
        local r_v3_553 = r_v10_334.UserInputType
        local r_v5_646 = Enum.UserInputType.MouseMovement
        local r_v2_548 = r_v3_553 == r_v5_646
        local r_v4_765 = r_v2_548
        if not r_v2_548 then
            local r_v3_554 = r_v10_334.UserInputType
            local r_v5_648 = Enum.UserInputType.Touch
            r_v4_765 = r_v3_554 == r_v5_648
        end
        if r_v4_765 then
            o_v99_73 = r_v10_334
        end
        r_v10_334 = nil
    end)
    r_v12_49.InputChanged:Connect(function(r_v10_335)
        if ((r_v10_335 == o_v99_73) and o_v96_66) then
            local r_v4_767 = r_v10_335.Position
            local r_v2_553 = o_v100_72
            r_v2_553 = r_v4_767 - r_v2_553
            local r_v3_557 = "Scale"
            r_v3_557 = o_v96_46[r_v3_557]
            local r_v5_652 = UDim2.new
            local r_v8_782 = o_v101_63.X.Scale
            local r_v9_668 = o_v101_63.X.Offset
            local r_v11_526 = r_v2_553.X
            local r_v14_595 = r_v11_526 / r_v3_557
            local r_v7_749 = r_v9_668 + r_v14_595
            local r_v9_669 = o_v101_63.Y.Scale
            local r_v11_529 = o_v101_63.Y.Offset
            local r_v12_442 = r_v2_553.Y
            local r_v13_503 = r_v12_442 / r_v3_557
            o_v94_49.Position = r_v5_652(r_v8_782, r_v7_749, r_v9_669, r_v11_529 + r_v13_503)
        end
        r_v10_335 = nil
    end)
    o_v90_56.Size = UDim2.new(1, 0, 0, 35)
    o_v90_56.BackgroundColor3 = r_v60_90.TopbarBg
    o_v90_56.BorderSizePixel = 0
    o_v90_56.ZIndex = 1
    local o_v103_58 = Instance.new("TextLabel", o_v90_56)
    o_v103_58.Size = UDim2.new(0, 250, 1, 0)
    o_v103_58.Position = UDim2.new(0, 15, 0, 0)
    o_v103_58.BackgroundTransparency = 1
    o_v103_58.Text = "Star Hub | LARB Upgrade | kuy https://discord.gg/gjpU2ZErPp"
    o_v103_58.TextColor3 = r_v60_90.SubText
    local o_v105_42 = Enum.Font
    o_v103_58.Font = o_v105_42.GothamSemibold
    o_v103_58.TextSize = 14
    local o_v105_45 = Enum.TextXAlignment
    o_v103_58.TextXAlignment = o_v105_45.Left
    local o_v104_58 = Instance.new("TextButton", o_v90_56)
    o_v104_58.Size = UDim2.new(0, 40, 1, 0)
    o_v104_58.Position = UDim2.new(1, (-40), 0, 0)
    o_v104_58.BackgroundTransparency = 1
    o_v104_58.Text = "\226\157\140"
    o_v104_58.TextColor3 = r_v60_90.SubText
    local o_v107_51 = Enum.Font
    o_v104_58.Font = o_v107_51.GothamMedium
    o_v104_58.TextSize = 16
    o_v104_58.MouseEnter:Connect(function()
        local r_v3_559 = TweenInfo.new(0.2)
        local r_v8_785 = Color3
        local r_v8_786 = r_v8_785.fromRGB(255, 50, 50)
        local r_v11_534 = Color3.fromRGB(255, 255, 255)
        ;(r_v13_49:Create(o_v104_58, r_v3_559, {
            ["BackgroundColor3"] = r_v8_786,
            ["BackgroundTransparency"] = 0,
            ["TextColor3"] = r_v11_534
        })):Play()
    end)
    o_v104_58.MouseLeave:Connect(function()
        local r_v3_561 = TweenInfo.new(0.2)
        local r_v7_760 = r_v60_90.SubText
        ;(r_v13_49:Create(o_v104_58, r_v3_561, {
            ["BackgroundTransparency"] = 1,
            ["TextColor3"] = r_v7_760
        })):Play()
    end)
    local o_v105_65 = Instance.new("TextButton", o_v90_56)
    o_v105_65.Size = UDim2.new(0, 40, 1, 0)
    o_v105_65.Position = UDim2.new(1, (-80), 0, 0)
    o_v105_65.BackgroundTransparency = 1
    o_v105_65.Text = "\226\128\148"
    o_v105_65.TextColor3 = r_v60_90.SubText
    local o_v108_70 = Enum.Font
    o_v105_65.Font = o_v108_70.GothamMedium
    o_v105_65.TextSize = 16
    o_v105_65.MouseEnter:Connect(function()
        local r_v3_563 = TweenInfo.new(0.2)
        local r_v6_776 = r_v60_90.ElementBg
        ;(r_v13_49:Create(o_v105_65, r_v3_563, {
            ["BackgroundColor3"] = r_v6_776,
            ["BackgroundTransparency"] = 0
        })):Play()
    end)
    o_v105_65.MouseLeave:Connect(function()
        local r_v3_565 = TweenInfo.new(0.2)
        ;(r_v13_49:Create(o_v105_65, r_v3_565, {
            ["BackgroundTransparency"] = 1
        })):Play()
    end)
    local o_v106_85
    local o_v107_76 = function(r_v10_340)
        o_v106_85 = r_v10_340
        if o_v106_85 then
            o_v94_49.Visible = false
            o_v84_19.Visible = true
        else
            o_v84_19.Visible = false
            o_v94_49.Visible = false
        end
        r_v10_340 = nil
    end
    o_v106_85 = true
    o_v75_41.Activated:Connect(function()
        if o_v80_36 then
            return
        end
        if o_v94_49.Visible then
            o_v94_49.Visible = false
            o_v84_19.Visible = true
            o_v106_85 = true
        else
            o_v107_76(not o_v106_85)
        end
    end)
    o_v104_58.MouseButton1Click:Connect(function()
        o_v107_76(false)
    end)
    o_v105_65.MouseButton1Click:Connect(function()
        o_v107_76(false)
        o_v94_49.Visible = true
    end)
    o_v98_65.MouseButton1Click:Connect(function()
        o_v107_76(true)
    end)
    local o_v108_91 = tick()
    r_v12_49.InputBegan:Connect(function(r_v10_352, r_v2_571)
        local r_v5_677 = not r_v2_571
        o_v108_91 = tick()
        local r_v3_579 = r_v5_677
        if r_v5_677 then
            local r_v6_788 = r_v10_352.UserInputType
            local r_v8_802 = Enum.UserInputType.Keyboard
            r_v3_579 = r_v6_788 == r_v8_802
        end
        if r_v3_579 then
            local r_v5_679 = r_v40_42.ui_toggle_key
            r_v3_579 = r_v5_679
            if not r_v5_679 then
                r_v3_579 = "RightControl"
            end
            if (r_v10_352.KeyCode.Name == r_v3_579) then
                if o_v94_49.Visible then
                    o_v94_49.Visible = false
                    o_v84_19.Visible = true
                    o_v106_85 = true
                else
                    o_v107_76(not o_v106_85)
                end
            end
        end
        r_v2_571 = nil
        r_v10_352 = nil
    end)
    r_v12_49.InputChanged:Connect(function()
        o_v108_91 = tick()
    end)
    task.spawn(function()
        while true do
            local r_v1_753 = task.wait
            if not (r_v1_753(1)) then
                break
            end
            local r_v4_801 = (r_v40_42.auto_hide_ui) and o_v106_85
            if r_v4_801 then
                local r_v2_575 = tick()
                local r_v4_802 = r_v2_575 - o_v108_91
                local r_v3_582 = r_v40_42.auto_hide_delay
                local r_v10_360 = r_v3_582 or 15
                if (r_v4_802 >= r_v10_360) then
                    o_v107_76(false)
                    o_v94_49.Visible = true
                end
            end
        end
    end)
    local o_v109_82 = Instance.new("Frame", o_v84_19)
    o_v109_82.Size = UDim2.new(1, 0, 1, (-35))
    o_v109_82.Position = UDim2.new(0, 0, 0, 35)
    o_v109_82.BackgroundTransparency = 1
    o_v109_82.ZIndex = 1
    o_v91_57.Parent = o_v109_82
    o_v91_57.Size = UDim2.new(0, 180, 1, 0)
    o_v91_57.BackgroundColor3 = r_v60_90.SidebarBg
    o_v91_57.BorderSizePixel = 0
    o_v91_57.ZIndex = 1
    local o_v110_81 = Instance.new("Frame", o_v91_57)
    o_v110_81.BackgroundTransparency = 1
    local o_v111_76 = Instance.new("ImageLabel", o_v110_81)
    local o_v113_47 = r_v40_42.logo_size
    local o_v111_77 = o_v113_47 or 56
    o_v111_76.Size = UDim2.new(0, o_v111_77, 0, o_v111_77)
    o_v111_76.Position = UDim2.new(0.5, -(o_v111_77 / 2), 0, 15)
    o_v111_76.BackgroundTransparency = 1
    o_v111_76.Image = "rbxthumb://type=Asset&id=110070009923641&w=150&h=150"
    local o_v113_52 = function(r_v10_363)
        if ((r_v10_363 == "") or (not r_v10_363)) then
            o_v111_76.Image = "rbxthumb://type=Asset&id=110070009923641&w=150&h=150"
            return
        end
        local r_v2_584 = string.find
        local r_v4_807 = (r_v2_584(r_v10_363, "rbxassetid://")) or (tonumber(r_v10_363))
        if r_v4_807 then
            local r_v5_699 = (tonumber(r_v10_363)) and (("rbxassetid://") .. r_v10_363)
            o_v111_76.Image = r_v5_699 or r_v10_363
            return
        end
        task.spawn(function()
            pcall(function()
                local r_v10_1186 = getsynasset
                local r_v4_3032 = r_v10_1186
                if not r_v10_1186 then
                    r_v10_1186 = getcustomasset
                    r_v4_3032 = r_v10_1186
                end
                local r_v2_1924 = request
                r_v10_1186 = r_v4_3032
                local r_v4_3033 = r_v2_1924
                if not r_v2_1924 then
                    local r_v5_2227 = http_request
                    r_v2_1924 = r_v5_2227
                    if not r_v5_2227 then
                        r_v2_1924 = (syn.request) or (fluxus.request)
                    end
                    r_v4_3033 = r_v2_1924
                end
                local r_v3_1990 = not r_v10_1186
                r_v2_1924 = r_v4_3033
                if (r_v3_1990 or (not r_v2_1924)) then
                    return
                end
                local r_v3_1993 = "Url"
                local r_v9_2457 = {
                    ["User-Agent"] = "Mozilla/5.0"
                }
                r_v3_1993 = r_v2_1924({
                    [r_v3_1993] = r_v10_363,
                    ["Method"] = "GET",
                    ["Headers"] = r_v9_2457
                })
                if (r_v3_1993.StatusCode == 200) then
                    local r_v8_2761 = tostring(127659)
                    local r_v5_2234 = r_v8_2761 .. ".png"
                    r_v5_2234 = "starhub_logo_" .. r_v5_2234
                    writefile(r_v5_2234, r_v3_1993.Body)
                    o_v111_76.Image = r_v10_1186(r_v5_2234)
                end
            end)
        end)
    end
    o_v110_81.Size = UDim2.new(1, 0, 0, (15 + o_v111_77) + 45)
    local o_v114_53 = Instance.new("TextLabel", o_v110_81)
    o_v114_53.Size = UDim2.new(1, 0, 0, 20)
    o_v114_53.Position = UDim2.new(0, 0, 0, (15 + o_v111_77) + 5)
    o_v114_53.BackgroundTransparency = 1
    o_v114_53.Text = (r_v40_42.custom_hub_title) or ("LARB HUB")
    o_v114_53.TextColor3 = r_v60_90.Text
    local o_v117_39 = Enum.Font
    o_v114_53.Font = o_v117_39.GothamBlack
    o_v114_53.TextSize = 20
    local o_v115_51 = Instance.new("TextLabel", o_v110_81)
    o_v115_51.Size = UDim2.new(1, 0, 0, 15)
    o_v115_51.Position = UDim2.new(0, 0, 0, (15 + o_v111_77) + 25)
    o_v115_51.BackgroundTransparency = 1
    local o_v122_22 = r_v22_34.Name
    local o_v120_40 = " | " .. o_v122_22
    local o_v119_46 = r_v41_36 .. o_v120_40
    o_v115_51.Text = "V " .. o_v119_46
    o_v115_51.TextColor3 = r_v60_90.Accent
    local o_v118_54 = Enum.Font
    o_v115_51.Font = o_v118_54.GothamSemibold
    o_v115_51.TextSize = 12
    table.insert(o_v69_33.Texts, o_v115_51)
    local o_v116_60 = Instance.new("ScrollingFrame", o_v91_57)
    o_v116_60.Size = UDim2.new(1, 0, 1, -((15 + o_v111_77) + 55))
    o_v116_60.Position = UDim2.new(0, 0, 0, (15 + o_v111_77) + 45)
    o_v116_60.BackgroundTransparency = 1
    o_v116_60.ScrollBarThickness = 0
    local o_v117_69 = Instance.new("UIListLayout", o_v116_60)
    o_v117_69.Padding = UDim.new(0, 5)
    local o_v119_72 = Enum.HorizontalAlignment
    o_v117_69.HorizontalAlignment = o_v119_72.Center
    local o_v118_78 = Instance.new("Frame", o_v109_82)
    o_v118_78.Size = UDim2.new(1, (-180), 1, 0)
    o_v118_78.Position = UDim2.new(0, 180, 0, 0)
    o_v118_78.BackgroundTransparency = 1
    o_v118_78.ClipsDescendants = true
    local o_v118_83 = nil
    local o_v119_80 = nil
    local o_v120_81 = nil
    local o_v121_67 = nil
    o_v90_56.InputBegan:Connect(function(r_v10_365)
        local r_v3_595 = r_v10_365.UserInputType
        local r_v5_703 = Enum.UserInputType.MouseButton1
        local r_v2_591 = r_v3_595 == r_v5_703
        local r_v4_811 = r_v2_591
        if not r_v2_591 then
            local r_v3_596 = r_v10_365.UserInputType
            local r_v5_705 = Enum.UserInputType.Touch
            r_v4_811 = r_v3_596 == r_v5_705
        end
        if r_v4_811 then
            o_v118_83 = true
            o_v120_81 = r_v10_365.Position
            o_v121_67 = o_v84_19.Position
            r_v10_365.Changed:Connect(function()
                local r_v4_1482 = r_v10_365.UserInputState
                local r_v10_695 = Enum.UserInputState.End
                if (r_v4_1482 == r_v10_695) then
                    o_v118_83 = false
                end
            end)
        end
    end)
    o_v90_56.InputChanged:Connect(function(r_v10_367)
        local r_v3_600 = r_v10_367.UserInputType
        local r_v5_713 = Enum.UserInputType.MouseMovement
        local r_v2_595 = r_v3_600 == r_v5_713
        local r_v4_813 = r_v2_595
        if not r_v2_595 then
            local r_v3_601 = r_v10_367.UserInputType
            local r_v5_715 = Enum.UserInputType.Touch
            r_v4_813 = r_v3_601 == r_v5_715
        end
        if r_v4_813 then
            o_v119_80 = r_v10_367
        end
        r_v10_367 = nil
    end)
    r_v12_49.InputChanged:Connect(function(r_v10_368)
        if ((r_v10_368 == o_v119_80) and o_v118_83) then
            local r_v4_815 = r_v10_368.Position
            local r_v2_600 = o_v120_81
            r_v2_600 = r_v4_815 - r_v2_600
            local r_v3_604 = "Scale"
            r_v3_604 = o_v93_54[r_v3_604]
            local r_v5_719 = UDim2.new
            local r_v8_844 = o_v121_67.X.Scale
            local r_v9_724 = o_v121_67.X.Offset
            local r_v11_565 = r_v2_600.X
            local r_v14_649 = r_v11_565 / r_v3_604
            local r_v7_816 = r_v9_724 + r_v14_649
            local r_v9_725 = o_v121_67.Y.Scale
            local r_v11_568 = o_v121_67.Y.Offset
            local r_v12_465 = r_v2_600.Y
            local r_v13_538 = r_v12_465 / r_v3_604
            o_v84_19.Position = r_v5_719(r_v8_844, r_v7_816, r_v9_725, r_v11_568 + r_v13_538)
        end
        r_v10_368 = nil
    end)
    local o_v124_41 = {}
    local o_v121_71 = {
        ["Tabs"] = o_v124_41
    }
    local o_v121_72 = true
    local o_v121_73 = nil
    o_v121_71.CreateTab = function(r_v10_369, r_v2_601, r_v3_605)
        local r_v5_721 = 0
        r_v5_721 = {
            ["ElementCount"] = r_v5_721
        }
        local r_v4_820 = Instance.new("TextButton", o_v116_60)
        r_v4_820.Size = UDim2.new(1, (-20), 0, 42)
        r_v4_820.BackgroundColor3 = r_v60_90.SidebarBg
        local r_v14_661 = "   " .. r_v3_605
        local r_v9_737 = r_v2_601 .. r_v14_661
        r_v4_820.Text = "   " .. r_v9_737
        r_v4_820.TextColor3 = r_v60_90.SubText
        local r_v7_830 = Enum.Font
        r_v4_820.Font = r_v7_830.GothamSemibold
        r_v4_820.TextSize = 14
        local r_v7_833 = Enum.TextXAlignment
        r_v4_820.TextXAlignment = r_v7_833.Left
        local r_v4_829 = Instance.new("UICorner", r_v4_820)
        r_v4_829.CornerRadius = UDim.new(0, 6)
        local r_v4_831 = Instance.new("Frame", r_v4_820)
        r_v4_831.Size = UDim2.new(0, 4, 0, 0)
        r_v4_831.Position = UDim2.new(0, 0, 0.5, 0)
        r_v4_831.BackgroundColor3 = r_v60_90.Accent
        local r_v4_836 = Instance.new("UICorner", r_v4_831)
        r_v4_836.CornerRadius = UDim.new(1, 0)
        local r_v4_838 = Instance.new("ScrollingFrame", o_v118_78)
        r_v4_838.Size = UDim2.new(1, 0, 1, 0)
        r_v4_838.BackgroundTransparency = 1
        r_v4_838.ScrollBarThickness = 4
        r_v4_838.ScrollBarImageColor3 = r_v60_90.Accent
        r_v4_838.Visible = o_v121_72
        local r_v4_845 = Instance.new("UIListLayout", r_v4_838)
        r_v4_845.Padding = UDim.new(0, 12)
        local r_v11_624 = Enum.HorizontalAlignment
        r_v4_845.HorizontalAlignment = r_v11_624.Center
        local r_v11_626 = Enum.SortOrder
        r_v4_845.SortOrder = r_v11_626.LayoutOrder
        local r_v14_718 = Instance.new("UIPadding", r_v4_838)
        r_v14_718.PaddingTop = UDim.new(0, 20)
        r_v14_718.PaddingBottom = UDim.new(0, 30)
        ;(r_v4_845:GetPropertyChangedSignal("AbsoluteContentSize")):Connect(function()
            r_v4_838.CanvasSize = UDim2.new(0, 0, 0, r_v4_845.AbsoluteContentSize.Y + 50)
        end)
        if o_v121_72 then
            r_v4_820.TextColor3 = r_v60_90.Accent
            r_v4_820.BackgroundColor3 = r_v60_90.ElementBg
            r_v4_831.Size = UDim2.new(0, 5, 0.6, (-6))
            o_v121_73 = r_v4_820
            o_v121_72 = false
        end
        r_v4_820.MouseButton1Click:Connect(function()
            if (o_v121_73 == r_v4_820) then
                return
            end
            local r_v4_1486, r_v10_699, r_v2_1047 = pairs(o_v121_71.Tabs)
            local r_v3_1113 = r_v4_1486
            for r_v5_1298, r_v6_1491 in r_v3_1113, r_v10_699, r_v2_1047 do
                local r_v1_1433 = r_v6_1491.Page
                r_v1_1433.Visible = false
                local r_v7_1493 = r_v6_1491.Btn
                local r_v14_1248 = TweenInfo.new(o_v69_32.AnimSpeed)
                local r_v13_1051 = r_v60_90.SubText
                local r_v15_782 = r_v60_90.SidebarBg
                ;(r_v13_49:Create(r_v7_1493, r_v14_1248, {
                    ["TextColor3"] = r_v13_1051,
                    ["BackgroundColor3"] = r_v15_782
                })):Play()
                local r_v7_1494 = r_v6_1491.Indicator
                local r_v14_1251 = TweenInfo.new(o_v69_32.AnimSpeed)
                local r_v12_925 = UDim2.new(0, 4, 0, 0)
                ;(r_v13_49:Create(r_v7_1494, r_v14_1251, {
                    ["Size"] = r_v12_925
                })):Play()
            end
            r_v4_838.Visible = true
            o_v121_73 = r_v4_820
            local r_v6_1494 = TweenInfo.new(o_v69_32.AnimSpeed)
            local r_v7_1498 = r_v60_90.Accent
            local r_v14_1257 = r_v60_90.ElementBg
            ;(r_v13_49:Create(r_v4_820, r_v6_1494, {
                ["TextColor3"] = r_v7_1498,
                ["BackgroundColor3"] = r_v14_1257
            })):Play()
            local r_v6_1496 = TweenInfo.new(o_v69_32.AnimSpeed, Enum.EasingStyle.Back)
            local r_v9_1410 = UDim2.new(0, 5, 0.6, (-6))
            local r_v11_1130 = UDim2.new(0, 0, 0.2, 0)
            ;(r_v13_49:Create(r_v4_831, r_v6_1496, {
                ["Size"] = r_v9_1410,
                ["Position"] = r_v11_1130
            })):Play()
        end)
        r_v5_721.Btn = r_v4_820
        r_v5_721.Page = r_v4_838
        r_v5_721.Indicator = r_v4_831
        table.insert(o_v121_71.Tabs, r_v5_721)
        r_v5_721.AddLabel = function(r_v10_709, r_v2_1056)
            r_v10_709.ElementCount = r_v10_709.ElementCount + 1
            local r_v1_1445 = Instance.new
            local r_v3_1121 = "Frame"
            r_v3_1121 = r_v1_1445(r_v3_1121, r_v4_838)
            r_v3_1121.Size = UDim2.new(1, (-30), 0, 28)
            r_v3_1121.BackgroundTransparency = 1
            r_v3_1121.LayoutOrder = r_v10_709.ElementCount
            local r_v1_1449 = Instance.new
            local r_v5_1319 = "TextLabel"
            r_v5_1319 = r_v1_1449(r_v5_1319, r_v3_1121)
            r_v5_1319.Size = UDim2.new(1, 0, 1, 0)
            r_v5_1319.Position = UDim2.new(0, 5, 0, 0)
            r_v5_1319.BackgroundTransparency = 1
            r_v5_1319.Text = r_v2_1056
            r_v5_1319.TextColor3 = r_v60_90.Accent
            local r_v6_1521 = Enum.Font
            r_v5_1319.Font = r_v6_1521.GothamBlack
            r_v5_1319.TextSize = 16
            local r_v6_1524 = Enum.TextXAlignment
            r_v5_1319.TextXAlignment = r_v6_1524.Left
            table.insert(o_v69_33.Texts, r_v5_1319)
            r_v2_1056 = nil
            r_v10_709 = nil
        end
        r_v5_721.AddParagraph = function(r_v10_710, r_v2_1057, r_v3_1122)
            r_v10_710.ElementCount = r_v10_710.ElementCount + 1
            local r_v5_1325 = Instance.new("Frame", r_v4_838)
            r_v5_1325.Size = UDim2.new(1, (-40), 0, 100)
            r_v5_1325.BackgroundColor3 = r_v60_90.ElementBg
            r_v5_1325.LayoutOrder = r_v10_710.ElementCount
            local r_v4_1528 = Instance.new("UICorner", r_v5_1325)
            r_v4_1528.CornerRadius = o_v69_32.CornerRadius
            local r_v4_1530 = Instance.new("UIStroke", r_v5_1325)
            r_v4_1530.Color = r_v60_90.Outline
            local r_v6_1554 = Instance.new("UIPadding", r_v5_1325)
            r_v6_1554.PaddingLeft = UDim.new(0, 15)
            r_v6_1554.PaddingRight = UDim.new(0, 15)
            r_v6_1554.PaddingTop = UDim.new(0, 10)
            r_v6_1554.PaddingBottom = UDim.new(0, 10)
            local r_v4_1542 = Instance.new("TextLabel", r_v5_1325)
            r_v4_1542.Size = UDim2.new(1, 0, 0, 24)
            r_v4_1542.BackgroundTransparency = 1
            r_v4_1542.Text = r_v2_1057
            r_v4_1542.TextColor3 = r_v60_90.Accent
            local r_v9_1480 = Enum.Font
            r_v4_1542.Font = r_v9_1480.GothamBold
            r_v4_1542.TextSize = 15
            local r_v9_1483 = Enum.TextXAlignment
            r_v4_1542.TextXAlignment = r_v9_1483.Left
            table.insert(o_v69_33.Texts, r_v4_1542)
            local r_v4_1553 = Instance.new("TextLabel", r_v5_1325)
            r_v4_1553.Size = UDim2.new(1, 0, 1, (-24))
            r_v4_1553.Position = UDim2.new(0, 0, 0, 24)
            r_v4_1553.BackgroundTransparency = 1
            r_v4_1553.Text = r_v3_1122
            r_v4_1553.TextColor3 = r_v60_90.SubText
            local r_v14_1341 = Enum.Font
            r_v4_1553.Font = r_v14_1341.Gotham
            r_v4_1553.TextSize = 14
            local r_v14_1344 = Enum.TextXAlignment
            r_v4_1553.TextXAlignment = r_v14_1344.Left
            local r_v14_1346 = Enum.TextYAlignment
            r_v4_1553.TextYAlignment = r_v14_1346.Top
            r_v4_1553.TextWrapped = true
            local r_v1_1493 = {
                ["Set"] = (function(r_v10_1187, r_v2_1926)
                    if r_v2_1926.Title then
                        r_v4_1542.Text = r_v2_1926.Title
                    end
                    if r_v2_1926.Content then
                        r_v4_1553.Text = r_v2_1926.Content
                    end
                    r_v2_1926 = nil
                end)
            }
            return r_v1_1493
        end
        r_v5_721.AddButton = function(r_v10_711, r_v2_1058, r_v3_1123)
            r_v10_711.ElementCount = r_v10_711.ElementCount + 1
            local r_v4_1568 = Instance.new("TextButton", r_v4_838)
            r_v4_1568.Size = UDim2.new(1, (-40), 0, 45)
            r_v4_1568.BackgroundColor3 = r_v60_90.ElementBg
            r_v4_1568.LayoutOrder = r_v10_711.ElementCount
            r_v4_1568.Text = r_v2_1058
            r_v4_1568.TextColor3 = r_v60_90.Text
            local r_v8_1659 = Enum.Font
            r_v4_1568.Font = r_v8_1659.GothamBold
            r_v4_1568.TextSize = 15
            local r_v4_1577 = Instance.new("UICorner", r_v4_1568)
            r_v4_1577.CornerRadius = o_v69_32.CornerRadius
            local r_v4_1579 = Instance.new("UIStroke", r_v4_1568)
            r_v4_1579.Color = r_v60_90.Outline
            r_v4_1568.MouseButton1Click:Connect(function()
                local r_v3_2001 = TweenInfo.new(0.1)
                local r_v8_2773 = Color3.fromRGB(50, 50, 55)
                ;(r_v13_49:Create(r_v4_1568, r_v3_2001, {
                    ["BackgroundColor3"] = r_v8_2773
                })):Play()
                task.wait(0.1)
                local r_v3_2004 = TweenInfo.new(0.1)
                local r_v6_2623 = r_v60_90.ElementBg
                ;(r_v13_49:Create(r_v4_1568, r_v3_2004, {
                    ["BackgroundColor3"] = r_v6_2623
                })):Play()
                r_v3_1123()
            end)
            r_v10_711 = nil
            r_v2_1058 = nil
        end
        r_v5_721.AddToggle = function(r_v10_712, r_v2_1059, r_v3_1125, r_v5_1333, r_v6_1587)
            r_v10_712.ElementCount = r_v10_712.ElementCount + 1
            local r_v8_1677 = Instance.new("Frame", r_v4_838)
            r_v8_1677.Size = UDim2.new(1, (-40), 0, 60)
            r_v8_1677.BackgroundColor3 = r_v60_90.ElementBg
            r_v8_1677.LayoutOrder = r_v10_712.ElementCount
            local r_v4_1595 = Instance.new("UICorner", r_v8_1677)
            r_v4_1595.CornerRadius = o_v69_32.CornerRadius
            local r_v4_1597 = Instance.new("UIStroke", r_v8_1677)
            r_v4_1597.Color = r_v60_90.Outline
            local r_v7_1651 = Instance.new("UIPadding", r_v8_1677)
            r_v7_1651.PaddingLeft = UDim.new(0, 15)
            r_v7_1651.PaddingRight = UDim.new(0, 15)
            local r_v9_1569 = Instance.new("TextLabel", r_v8_1677)
            r_v9_1569.Size = UDim2.new(1, (-70), 0, 32)
            r_v9_1569.Position = UDim2.new(0, 0, 0, 2)
            r_v9_1569.BackgroundTransparency = 1
            r_v9_1569.Text = r_v2_1059
            r_v9_1569.TextColor3 = r_v60_90.Text
            local r_v14_1417 = Enum.Font
            r_v9_1569.Font = r_v14_1417.GothamBold
            r_v9_1569.TextSize = 15
            local r_v14_1420 = Enum.TextXAlignment
            r_v9_1569.TextXAlignment = r_v14_1420.Left
            local r_v14_1424 = Instance.new("TextLabel", r_v8_1677)
            r_v14_1424.Size = UDim2.new(1, (-70), 0, 18)
            r_v14_1424.Position = UDim2.new(0, 0, 0, 32)
            r_v14_1424.BackgroundTransparency = 1
            r_v14_1424.Text = r_v3_1125
            r_v14_1424.TextColor3 = r_v60_90.SubText
            local r_v11_1278 = Enum.Font
            r_v14_1424.Font = r_v11_1278.GothamMedium
            r_v14_1424.TextSize = 13
            local r_v11_1281 = Enum.TextXAlignment
            r_v14_1424.TextXAlignment = r_v11_1281.Left
            local r_v4_1641 = Instance.new("Frame", r_v8_1677)
            r_v4_1641.Size = UDim2.new(0, 48, 0, 24)
            r_v4_1641.Position = UDim2.new(1, (-48), 0.5, (-12))
            local r_v15_867 = r_v5_1333
            if r_v5_1333 then
                r_v15_867 = r_v60_90.Accent
            end
            r_v4_1641.BackgroundColor3 = r_v15_867 or (r_v60_90.MainBg)
            local r_v4_1646 = Instance.new("UICorner", r_v4_1641)
            r_v4_1646.CornerRadius = UDim.new(1, 0)
            local r_v4_1648 = Instance.new("Frame", r_v4_1641)
            r_v4_1648.Size = UDim2.new(0, 18, 0, 18)
            local r_v16_764 = r_v5_1333
            if r_v5_1333 then
                r_v16_764 = UDim2.new(1, (-21), 0.5, (-9))
            end
            r_v4_1648.Position = r_v16_764 or (UDim2.new(0, 3, 0.5, (-9)))
            r_v4_1648.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            local r_v4_1653 = Instance.new("UICorner", r_v4_1648)
            r_v4_1653.CornerRadius = UDim.new(1, 0)
            local r_v12_1071 = r_v5_1333
            local r_v15_894 = Instance.new("TextButton", r_v8_1677)
            r_v15_894.Size = UDim2.new(1, 0, 1, 0)
            r_v15_894.BackgroundTransparency = 1
            r_v15_894.Text = ""
            r_v15_894.MouseButton1Click:Connect(function()
                r_v12_1071 = not r_v12_1071
                local r_v5_2251 = TweenInfo.new(0.3, Enum.EasingStyle.Back)
                local r_v8_2781 = (r_v12_1071 and (UDim2.new(1, (-21), 0.5, (-9)))) or (UDim2.new(0, 3, 0.5, (-9)))
                ;(r_v13_49:Create(r_v4_1648, r_v5_2251, {
                    ["Position"] = r_v8_2781
                })):Play()
                local r_v5_2253 = TweenInfo.new(0.3)
                local r_v8_2784 = (r_v12_1071 and (r_v60_90.Accent)) or (r_v60_90.MainBg)
                ;(r_v13_49:Create(r_v4_1641, r_v5_2253, {
                    ["BackgroundColor3"] = r_v8_2784
                })):Play()
                r_v6_1587(r_v12_1071)
            end)
            local r_v1_1559 = {
                ["Set"] = (function(r_v10_1201, r_v2_1935, r_v3_2009)
                    if (r_v12_1071 ~= r_v2_1935) then
                        r_v12_1071 = r_v2_1935
                        local r_v7_2595 = TweenInfo.new(0.3, Enum.EasingStyle.Back)
                        local r_v14_2294 = (r_v12_1071 and (UDim2.new(1, (-21), 0.5, (-9)))) or (UDim2.new(0, 3, 0.5, (-9)))
                        ;(r_v13_49:Create(r_v4_1648, r_v7_2595, {
                            ["Position"] = r_v14_2294
                        })):Play()
                        local r_v7_2597 = TweenInfo.new(0.3)
                        local r_v14_2297 = (r_v12_1071 and (r_v60_90.Accent)) or (r_v60_90.MainBg)
                        ;(r_v13_49:Create(r_v4_1641, r_v7_2597, {
                            ["BackgroundColor3"] = r_v14_2297
                        })):Play()
                        if (not r_v3_2009) then
                            r_v6_1587(r_v12_1071)
                        end
                    end
                    r_v3_2009 = nil
                    r_v2_1935 = nil
                end)
            }
            return r_v1_1559
        end
        r_v5_721.AddSlider = function(r_v10_713, r_v2_1060, r_v3_1126, r_v5_1334, r_v6_1588, r_v8_1678)
            r_v10_713.ElementCount = r_v10_713.ElementCount + 1
            local r_v1_1561 = Instance.new
            local r_v7_1656 = "Frame"
            r_v7_1656 = r_v1_1561(r_v7_1656, r_v4_838)
            r_v7_1656.Size = UDim2.new(1, (-40), 0, 70)
            r_v7_1656.BackgroundColor3 = r_v60_90.ElementBg
            r_v7_1656.LayoutOrder = r_v10_713.ElementCount
            local r_v4_1678 = Instance.new("UICorner", r_v7_1656)
            r_v4_1678.CornerRadius = o_v69_32.CornerRadius
            local r_v4_1680 = Instance.new("UIStroke", r_v7_1656)
            r_v4_1680.Color = r_v60_90.Outline
            local r_v1_1569 = Instance.new
            local r_v9_1595 = "UIPadding"
            r_v9_1595 = r_v1_1569(r_v9_1595, r_v7_1656)
            r_v9_1595.PaddingLeft = UDim.new(0, 15)
            r_v9_1595.PaddingRight = UDim.new(0, 15)
            local r_v1_1572 = Instance.new
            local r_v14_1455 = "TextLabel"
            r_v14_1455 = r_v1_1572(r_v14_1455, r_v7_1656)
            r_v14_1455.Size = UDim2.new(1, (-60), 0, 30)
            r_v14_1455.Position = UDim2.new(0, 0, 0, 6)
            r_v14_1455.BackgroundTransparency = 1
            r_v14_1455.Text = r_v2_1060
            r_v14_1455.TextColor3 = r_v60_90.Text
            local r_v11_1328 = Enum.Font
            r_v14_1455.Font = r_v11_1328.GothamBold
            r_v14_1455.TextSize = 15
            local r_v11_1331 = Enum.TextXAlignment
            r_v14_1455.TextXAlignment = r_v11_1331.Left
            local r_v4_1706 = Instance.new("TextBox", r_v7_1656)
            r_v4_1706.Size = UDim2.new(0, 60, 0, 30)
            r_v4_1706.Position = UDim2.new(1, (-60), 0, 6)
            r_v4_1706.BackgroundTransparency = 1
            r_v4_1706.Text = tostring(r_v6_1588)
            r_v4_1706.TextColor3 = r_v60_90.Accent
            local r_v12_1129 = Enum.Font
            r_v4_1706.Font = r_v12_1129.GothamBold
            r_v4_1706.TextSize = 15
            local r_v12_1132 = Enum.TextXAlignment
            r_v4_1706.TextXAlignment = r_v12_1132.Right
            r_v4_1706.ClearTextOnFocus = false
            table.insert(o_v69_33.Texts, r_v4_1706)
            local r_v4_1719 = Instance.new("Frame", r_v7_1656)
            r_v4_1719.Size = UDim2.new(1, 0, 0, 8)
            r_v4_1719.Position = UDim2.new(0, 0, 0, 45)
            r_v4_1719.BackgroundColor3 = r_v60_90.MainBg
            local r_v4_1724 = Instance.new("UICorner", r_v4_1719)
            r_v4_1724.CornerRadius = UDim.new(1, 0)
            local r_v4_1726 = Instance.new("Frame", r_v4_1719)
            local r_v1_1599 = math.clamp
            local r_v16_851 = r_v6_1588 - r_v3_1126
            local r_v17_720 = r_v5_1334 - r_v3_1126
            local r_v15_973 = r_v16_851 / r_v17_720
            r_v15_973 = r_v1_1599(r_v15_973, 0, 1)
            r_v4_1726.Size = UDim2.new(r_v15_973, 0, 1, 0)
            r_v4_1726.BackgroundColor3 = r_v60_90.Accent
            local r_v4_1732 = Instance.new("UICorner", r_v4_1726)
            r_v4_1732.CornerRadius = UDim.new(1, 0)
            local r_v1_1604 = Instance.new
            local r_v16_864 = "TextButton"
            r_v16_864 = r_v1_1604(r_v16_864, r_v4_1726)
            r_v16_864.Size = UDim2.new(0, 18, 0, 18)
            r_v16_864.Position = UDim2.new(1, (-9), 0.5, (-9))
            r_v16_864.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            r_v16_864.Text = ""
            local r_v4_1744 = Instance.new("UICorner", r_v16_864)
            r_v4_1744.CornerRadius = UDim.new(1, 0)
            local r_v1_1611 = false
            local r_v1_1612 = function(r_v10_1203)
                r_v10_1203 = math.clamp(r_v10_1203, 0, 1)
                r_v4_1726.Size = UDim2.new(r_v10_1203, 0, 1, 0)
                local r_v1_2665 = math.floor
                local r_v6_2641 = (r_v5_1334 - r_v3_1126) * r_v10_1203
                local r_v2_1941 = r_v1_2665(r_v3_1126 + r_v6_2641)
                r_v4_1706.Text = tostring(r_v2_1941)
                r_v8_1678(r_v2_1941)
                r_v10_1203 = nil
            end
            r_v16_864.InputBegan:Connect(function(r_v10_1204)
                local r_v3_2019 = r_v10_1204.UserInputType
                local r_v5_2270 = Enum.UserInputType.MouseButton1
                local r_v2_1942 = r_v3_2019 == r_v5_2270
                local r_v4_3077 = r_v2_1942
                if not r_v2_1942 then
                    local r_v3_2020 = r_v10_1204.UserInputType
                    local r_v5_2272 = Enum.UserInputType.Touch
                    r_v4_3077 = r_v3_2020 == r_v5_2272
                end
                if r_v4_3077 then
                    r_v1_1611 = true
                end
                r_v10_1204 = nil
            end)
            r_v12_49.InputEnded:Connect(function(r_v10_1205)
                local r_v3_2021 = r_v10_1205.UserInputType
                local r_v5_2274 = Enum.UserInputType.MouseButton1
                local r_v2_1944 = r_v3_2021 == r_v5_2274
                local r_v4_3078 = r_v2_1944
                if not r_v2_1944 then
                    local r_v3_2022 = r_v10_1205.UserInputType
                    local r_v5_2276 = Enum.UserInputType.Touch
                    r_v4_3078 = r_v3_2022 == r_v5_2276
                end
                if r_v4_3078 then
                    r_v1_1611 = false
                end
                r_v10_1205 = nil
            end)
            r_v12_49.InputChanged:Connect(function(r_v10_1206)
                local r_v2_1946 = r_v1_1611
                local r_v4_3079 = r_v2_1946
                if r_v2_1946 then
                    local r_v6_2653 = r_v10_1206.UserInputType
                    local r_v8_2809 = Enum.UserInputType.MouseMovement
                    local r_v5_2277 = r_v6_2653 == r_v8_2809
                    local r_v2_1947 = r_v5_2277
                    if not r_v5_2277 then
                        local r_v6_2654 = r_v10_1206.UserInputType
                        local r_v8_2811 = Enum.UserInputType.Touch
                        r_v2_1947 = r_v6_2654 == r_v8_2811
                    end
                    r_v4_3079 = r_v2_1947
                end
                if r_v4_3079 then
                    local r_v2_1948 = r_v10_1206.Position.X
                    local r_v3_2025 = r_v4_1719.AbsolutePosition.X
                    local r_v4_3080 = r_v2_1948 - r_v3_2025
                    local r_v2_1949 = r_v4_1719.AbsoluteSize.X
                    r_v2_1949 = r_v4_3080 / r_v2_1949
                    r_v1_1612(r_v2_1949)
                end
                r_v10_1206 = nil
            end)
            r_v4_1706.FocusLost:Connect(function()
                local r_v1_2673 = tonumber
                local r_v10_1207 = r_v4_1706.Text
                r_v10_1207 = r_v1_2673(r_v10_1207)
                if r_v10_1207 then
                    r_v10_1207 = math.clamp(r_v10_1207, r_v3_1126, r_v5_1334)
                    local r_v2_1954 = r_v10_1207 - r_v3_1126
                    local r_v3_2031 = r_v5_1334 - r_v3_1126
                    r_v2_1954 = r_v2_1954 / r_v3_2031
                    r_v4_1726.Size = UDim2.new(r_v2_1954, 0, 1, 0)
                    r_v4_1706.Text = tostring(r_v10_1207)
                    r_v8_1678(r_v10_1207)
                else
                    local r_v1_2679 = math.floor
                    local r_v8_2826 = r_v5_1334 - r_v3_1126
                    local r_v7_2639 = r_v4_1726.Size.X.Scale
                    local r_v6_2671 = r_v8_2826 * r_v7_2639
                    local r_v2_1956 = r_v1_2679(r_v3_1126 + r_v6_2671)
                    r_v4_1706.Text = tostring(r_v2_1956)
                end
            end)
            r_v6_1588 = nil
            r_v2_1060 = nil
            r_v10_713 = nil
        end
        r_v5_721.AddTextbox = function(r_v10_714, r_v2_1061, r_v3_1128)
            r_v10_714.ElementCount = r_v10_714.ElementCount + 1
            local r_v5_1341 = Instance.new("Frame", r_v4_838)
            r_v5_1341.Size = UDim2.new(1, (-40), 0, 48)
            r_v5_1341.BackgroundColor3 = r_v60_90.MainBg
            r_v5_1341.LayoutOrder = r_v10_714.ElementCount
            local r_v4_1772 = Instance.new("UICorner", r_v5_1341)
            r_v4_1772.CornerRadius = o_v69_32.CornerRadius
            local r_v4_1774 = Instance.new("UIStroke", r_v5_1341)
            r_v4_1774.Color = r_v60_90.Outline
            local r_v4_1776 = Instance.new("TextBox", r_v5_1341)
            r_v4_1776.Size = UDim2.new(1, (-30), 1, 0)
            r_v4_1776.Position = UDim2.new(0, 15, 0, 0)
            r_v4_1776.BackgroundTransparency = 1
            r_v4_1776.PlaceholderText = r_v2_1061
            r_v4_1776.Text = ""
            r_v4_1776.TextColor3 = r_v60_90.Text
            local r_v7_1691 = Enum.Font
            r_v4_1776.Font = r_v7_1691.GothamSemibold
            r_v4_1776.TextSize = 15
            local r_v7_1694 = Enum.TextXAlignment
            r_v4_1776.TextXAlignment = r_v7_1694.Left
            r_v4_1776.ClearTextOnFocus = false
            r_v4_1776.FocusLost:Connect(function()
                r_v3_1128(r_v4_1776.Text)
            end)
            local r_v1_1638 = {
                ["Set"] = (function(r_v10_1209, r_v2_1958)
                    r_v4_1776.Text = r_v2_1958
                    r_v2_1958 = nil
                end),
                ["Get"] = (function(r_v10_1211)
                    local r_v1_2683 = r_v4_1776.Text
                    return r_v1_2683
                end)
            }
            return r_v1_1638
        end
        r_v5_721.AddDropdown = function(r_v10_715, r_v2_1062, r_v3_1129, r_v5_1342)
            r_v10_715.ElementCount = r_v10_715.ElementCount + 1
            local r_v4_1795 = Instance.new("Frame", r_v4_838)
            r_v4_1795.Size = UDim2.new(1, (-40), 0, 50)
            r_v4_1795.BackgroundColor3 = r_v60_90.ElementBg
            r_v4_1795.LayoutOrder = r_v10_715.ElementCount
            r_v4_1795.ClipsDescendants = true
            local r_v4_1801 = Instance.new("UICorner", r_v4_1795)
            r_v4_1801.CornerRadius = o_v69_32.CornerRadius
            local r_v4_1803 = Instance.new("UIStroke", r_v4_1795)
            r_v4_1803.Color = r_v60_90.Outline
            local r_v4_1805 = Instance.new("TextButton", r_v4_1795)
            r_v4_1805.Size = UDim2.new(1, 0, 0, 50)
            r_v4_1805.BackgroundTransparency = 1
            local r_v17_755 = r_v3_1129[1]
            local r_v13_1333 = " : " .. (r_v17_755 or ("None"))
            local r_v14_1526 = r_v2_1062 .. r_v13_1333
            r_v4_1805.Text = "    " .. r_v14_1526
            r_v4_1805.TextColor3 = r_v60_90.Text
            local r_v9_1674 = Enum.Font
            r_v4_1805.Font = r_v9_1674.GothamBold
            r_v4_1805.TextSize = 15
            local r_v9_1677 = Enum.TextXAlignment
            r_v4_1805.TextXAlignment = r_v9_1677.Left
            local r_v4_1814 = Instance.new("TextLabel", r_v4_1805)
            r_v4_1814.Size = UDim2.new(0, 20, 1, 0)
            r_v4_1814.Position = UDim2.new(1, (-30), 0, 0)
            r_v4_1814.BackgroundTransparency = 1
            r_v4_1814.Text = "\226\150\188"
            r_v4_1814.TextColor3 = r_v60_90.SubText
            local r_v14_1550 = Enum.Font
            r_v4_1814.Font = r_v14_1550.GothamBold
            r_v4_1814.TextSize = 13
            local r_v4_1823 = Instance.new("ScrollingFrame", r_v4_1795)
            r_v4_1823.Size = UDim2.new(1, (-20), 1, (-55))
            r_v4_1823.Position = UDim2.new(0, 10, 0, 50)
            r_v4_1823.BackgroundTransparency = 1
            r_v4_1823.ScrollBarThickness = 3
            r_v4_1823.ScrollBarImageColor3 = r_v60_90.Accent
            r_v4_1823.BorderSizePixel = 0
            local r_v4_1831 = Instance.new("UIListLayout", r_v4_1823)
            r_v4_1831.Padding = UDim.new(0, 6)
            ;(r_v4_1831:GetPropertyChangedSignal("AbsoluteContentSize")):Connect(function()
                r_v4_1823.CanvasSize = UDim2.new(0, 0, 0, r_v4_1831.AbsoluteContentSize.Y + 10)
            end)
            local r_v11_1451 = (r_v3_1129[1]) or ("None")
            local r_v1_1680 = {
                ["CurrentOption"] = r_v11_1451,
                ["open"] = false
            }
            r_v4_1805.MouseButton1Click:Connect(function()
                r_v1_1680.open = not r_v1_1680.open
                local r_v10_1217 = ((r_v1_1680.open) and ("\226\150\178")) or ("\226\150\188")
                r_v4_1814.Text = r_v10_1217
                r_v10_1217 = 50
                if r_v1_1680.open then
                    local r_v6_2690 = r_v4_1823:GetChildren()
                    local r_v4_3093 = ((#r_v6_2690) - 1) * 44
                    local r_v2_1969 = 10
                    r_v2_1969 = r_v4_3093 + r_v2_1969
                    local r_v5_2310 = math.min(r_v2_1969, 180)
                    r_v10_1217 = 50 + r_v5_2310
                end
                local r_v6_2695 = TweenInfo.new(0.3, Enum.EasingStyle.Quart)
                local r_v9_2543 = UDim2
                local r_v9_2544 = r_v9_2543.new(1, (-40), 0, r_v10_1217)
                ;(r_v13_49:Create(r_v4_1795, r_v6_2695, {
                    ["Size"] = r_v9_2544
                })):Play()
            end)
            r_v1_1680.Refresh = function(r_v10_1218, r_v2_1973, r_v3_2057)
                local r_v1_2693 = pairs
                local r_v8_2843 = r_v4_1823
                local r_v9_2546 = r_v8_2843.GetChildren
                for r_v7_2657, r_v9_2547 in r_v1_2693(r_v9_2546(r_v8_2843)) do
                    if r_v9_2547.IsA(r_v9_2547, "TextButton") then
                        r_v9_2547:Destroy()
                    end
                end
                local r_v6_2698 = r_v3_2057
                if not r_v3_2057 then
                    r_v6_2698 = (r_v2_1973[1]) or ("None")
                end
                r_v10_1218.CurrentOption = r_v6_2698
                local r_v13_2022 = r_v10_1218.CurrentOption
                local r_v14_2345 = " : " .. r_v13_2022
                local r_v7_2662 = r_v2_1062 .. r_v14_2345
                r_v4_1805.Text = "    " .. r_v7_2662
                local r_v1_2703 = pairs
                for r_v7_2665, r_v1_2705 in r_v1_2703(r_v2_1973) do
                    local r_v14_2349 = Instance.new("TextButton", r_v4_1823)
                    r_v14_2349.Size = UDim2.new(1, (-10), 0, 38)
                    r_v14_2349.BackgroundColor3 = r_v60_90.MainBg
                    local r_v12_1780 = r_v1_2705
                    r_v14_2349.Text = "    " .. r_v12_1780
                    r_v14_2349.TextColor3 = r_v60_90.SubText
                    local r_v13_2037 = Enum.Font
                    r_v14_2349.Font = r_v13_2037.GothamMedium
                    r_v14_2349.TextSize = 14
                    local r_v13_2040 = Enum.TextXAlignment
                    r_v14_2349.TextXAlignment = r_v13_2040.Left
                    local r_v11_2157 = Instance.new("UICorner", r_v14_2349)
                    r_v11_2157.CornerRadius = UDim.new(0, 6)
                    r_v14_2349.MouseButton1Click:Connect(function()
                        r_v10_1218.CurrentOption = r_v1_2705
                        local r_v7_2783 = r_v1_2705
                        local r_v6_2810 = " : " .. r_v7_2783
                        local r_v3_2135 = r_v2_1062 .. r_v6_2810
                        r_v4_1805.Text = "    " .. r_v3_2135
                        r_v1_1680.open = false
                        r_v4_1814.Text = "\226\150\188"
                        local r_v3_2140 = TweenInfo.new(0.3, Enum.EasingStyle.Quart)
                        local r_v8_2965 = UDim2.new(1, (-40), 0, 50)
                        ;(r_v13_49:Create(r_v4_1795, r_v3_2140, {
                            ["Size"] = r_v8_2965
                        })):Play()
                        r_v5_1342(r_v1_2705)
                    end)
                end
                r_v3_2057 = nil
                r_v2_1973 = nil
            end
            r_v1_1680.Set = function(r_v10_1220, r_v2_1974)
                r_v10_1220.CurrentOption = r_v2_1974
                local r_v7_2669 = " : " .. r_v2_1974
                local r_v6_2705 = r_v2_1062 .. r_v7_2669
                r_v4_1805.Text = "    " .. r_v6_2705
                r_v10_1220 = nil
                r_v2_1974 = nil
            end
            local r_v13_1389 = r_v1_1680.CurrentOption
            r_v1_1680:Refresh(r_v3_1129, r_v13_1389)
            return r_v1_1680
        end
        r_v5_721.AddKeybind = function(r_v10_716, r_v2_1063, r_v3_1130, r_v5_1343)
            r_v10_716.ElementCount = r_v10_716.ElementCount + 1
            local r_v1_1687 = Instance.new
            local r_v6_1626 = "Frame"
            r_v6_1626 = r_v1_1687(r_v6_1626, r_v4_838)
            r_v6_1626.Size = UDim2.new(1, (-40), 0, 48)
            r_v6_1626.BackgroundColor3 = r_v60_90.MainBg
            r_v6_1626.LayoutOrder = r_v10_716.ElementCount
            local r_v4_1857 = Instance.new("UICorner", r_v6_1626)
            r_v4_1857.CornerRadius = o_v69_32.CornerRadius
            local r_v4_1859 = Instance.new("UIStroke", r_v6_1626)
            r_v4_1859.Color = r_v60_90.Outline
            local r_v1_1695 = Instance.new
            local r_v8_1779 = "TextLabel"
            r_v8_1779 = r_v1_1695(r_v8_1779, r_v6_1626)
            r_v8_1779.Size = UDim2.new(1, (-120), 1, 0)
            r_v8_1779.Position = UDim2.new(0, 15, 0, 0)
            r_v8_1779.BackgroundTransparency = 1
            r_v8_1779.Text = r_v2_1063
            r_v8_1779.TextColor3 = r_v60_90.Text
            local r_v7_1775 = Enum.Font
            r_v8_1779.Font = r_v7_1775.GothamBold
            r_v8_1779.TextSize = 14
            local r_v7_1778 = Enum.TextXAlignment
            r_v8_1779.TextXAlignment = r_v7_1778.Left
            local r_v4_1879 = Instance.new("TextButton", r_v6_1626)
            r_v4_1879.Size = UDim2.new(0, 90, 0, 30)
            r_v4_1879.Position = UDim2.new(1, (-105), 0.5, (-15))
            r_v4_1879.BackgroundColor3 = r_v60_90.ElementBg
            r_v4_1879.Text = tostring(r_v3_1130)
            r_v4_1879.TextColor3 = r_v60_90.Accent
            local r_v14_1626 = Enum.Font
            r_v4_1879.Font = r_v14_1626.GothamBold
            r_v4_1879.TextSize = 13
            local r_v4_1888 = Instance.new("UICorner", r_v4_1879)
            r_v4_1888.CornerRadius = UDim.new(0, 6)
            local r_v4_1890 = Instance.new("UIStroke", r_v4_1879)
            r_v4_1890.Color = r_v60_90.Outline
            local r_v1_1716 = false
            r_v4_1879.MouseButton1Click:Connect(function()
                if r_v1_1716 then
                    return
                end
                r_v1_1716 = true
                r_v4_1879.Text = "\224\184\129\224\184\148\224\184\155\224\184\184\224\185\136\224\184\161..."
                local r_v4_3105 = nil
                local r_v3_2066 = game:GetService("UserInputService")
                r_v4_3105 = r_v3_2066.InputBegan:Connect(function(r_v10_1278)
                    local r_v4_3251 = r_v10_1278.UserInputType
                    local r_v2_2060 = Enum.UserInputType.Keyboard
                    if (r_v4_3251 == r_v2_2060) then
                        local r_v4_3252 = r_v10_1278.KeyCode
                        local r_v2_2062 = "Name"
                        r_v2_2062 = r_v4_3252[r_v2_2062]
                        r_v4_1879.Text = r_v2_2062
                        r_v5_1343(r_v2_2062)
                        r_v1_1716 = false
                        r_v4_3105:Disconnect()
                    end
                    r_v10_1278 = nil
                end)
            end)
            r_v10_716 = nil
            r_v3_1130 = nil
            r_v2_1063 = nil
        end
        return r_v5_721
    end
    GetEquippedUnitsSlots = function()
        local r_v1_804 = {
            "\224\185\132\224\184\161\224\185\136\224\185\132\224\184\148\224\185\137\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129 (None)"
        }
        pcall(function()
            local r_v10_717 = r_v69_99
            local r_v2_1066 = r_v10_717:FindFirstChild("HUD")
            local r_v4_1895 = r_v2_1066
            if r_v2_1066 then
                local r_v5_1349 = r_v69_99.HUD:FindFirstChild("BottomFrame")
                r_v10_717 = r_v5_1349
                if r_v5_1349 then
                    r_v10_717 = r_v69_99.HUD.BottomFrame:FindFirstChild("Unit")
                end
                r_v4_1895 = r_v10_717
            end
            r_v10_717 = r_v4_1895
            if r_v10_717 then
                local r_v4_1897, r_v2_1068, r_v3_1134 = pairs(r_v10_717.GetChildren(r_v10_717))
                local r_v5_1355 = r_v4_1897
                for r_v6_1636, r_v8_1786 in r_v5_1355, r_v2_1068, r_v3_1134 do
                    if (r_v8_1786.ClassName == "Frame") then
                        local r_v7_1791 = "Unit"
                        r_v7_1791 = r_v8_1786:FindFirstChild(r_v7_1791)
                        local r_v9_1776 = r_v7_1791
                        if r_v7_1791 then
                            local r_v12_1263 = r_v7_1791.Value
                            local r_v13_1443 = r_v12_1263 ~= ""
                            local r_v14_1649 = r_v13_1443
                            if r_v13_1443 then
                                local r_v12_1264 = r_v7_1791.Value
                                r_v14_1649 = r_v12_1264 ~= "None"
                            end
                            r_v9_1776 = r_v14_1649
                        end
                        if r_v9_1776 then
                            local r_v9_1777 = table.find
                            if (not r_v9_1777(r_v1_804, r_v7_1791.Value)) then
                                table.insert(r_v1_804, r_v7_1791.Value)
                            end
                        end
                    end
                end
            end
        end)
        if ((#r_v1_804) == 1) then
            table.insert(r_v1_804, "\224\185\132\224\184\161\224\185\136\224\184\158\224\184\154\224\184\149\224\184\177\224\184\167\224\184\165\224\184\176\224\184\132\224\184\163\224\185\131\224\184\153\224\184\170\224\184\165\224\185\135\224\184\173\224\184\149")
        end
        return r_v1_804
    end
    InitializeUI = function()
        T_Main = o_v121_71:CreateTab("\240\159\143\160", "\224\184\171\224\184\153\224\185\137\224\184\178\224\184\171\224\184\165\224\184\177\224\184\129")
        T_Farm = o_v121_71:CreateTab("\240\159\146\176", "\224\184\159\224\184\178\224\184\163\224\185\140\224\184\161/\224\184\130\224\184\178\224\184\162")
        T_Macro = o_v121_71:CreateTab("\226\150\182\239\184\143", "\224\184\161\224\184\178\224\185\130\224\184\132\224\184\163")
        T_Gauntlet = o_v121_71:CreateTab("\240\159\165\138", "Gauntlet")
        T_Advanced = o_v121_71:CreateTab("\226\154\153\239\184\143", "\224\184\154\224\184\177\224\184\159/\224\184\130\224\184\177\224\185\137\224\184\153\224\184\170\224\184\185\224\184\135")
        T_Snipe = o_v121_71:CreateTab("\240\159\142\175", "\224\184\149\224\185\136\224\184\173\224\184\170\224\184\185\224\185\137\224\184\158\224\184\180\224\185\128\224\184\168\224\184\169")
        T_Stop = o_v121_71:CreateTab("\240\159\155\145", "\224\184\171\224\184\162\224\184\184\224\184\148\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180")
        T_Lobby = o_v121_71:CreateTab("\240\159\142\174", "\224\184\165\224\185\135\224\184\173\224\184\154\224\184\154\224\184\181\224\185\137")
        T_Webhook = o_v121_71:CreateTab("\240\159\140\144", "\224\185\128\224\184\167\224\185\135\224\184\154\224\184\174\224\184\184\224\184\132")
        T_Misc = o_v121_71:CreateTab("\240\159\155\160\239\184\143", "\224\184\149\224\184\177\224\185\137\224\184\135\224\184\132\224\185\136\224\184\178\224\184\173\224\184\183\224\185\136\224\184\153\224\185\134")
        T_Main:AddLabel("\240\159\147\138 \224\184\170\224\184\150\224\184\180\224\184\149\224\184\180\224\184\156\224\184\185\224\185\137\224\185\128\224\184\165\224\185\136\224\184\153 (Lifetime Stats)")
        local r_v11_673 = function(r_v10_718)
            local r_v1_1727 = string.format
            local r_v3_1137 = r_v10_718 / 3600
            return r_v1_1727("%.1f \224\184\138\224\184\177\224\185\136\224\184\167\224\185\130\224\184\161\224\184\135", r_v3_1137)
        end
        local r_v1_831 = T_Main
        local r_v19_138 = tostring(r_v40_53.TotalGems)
        local r_v23_55 = tostring(r_v40_53.TotalGold)
        local r_v28_53 = tostring(r_v40_53.TotalStardust)
        local r_v29_59 = tostring(r_v40_53.TotalRuns)
        local r_v33_68 = r_v11_673(r_v40_53.TotalPlayTime)
        local r_v30_41 = " \224\184\163\224\184\173\224\184\154" .. ("\n\226\143\177\239\184\143 \224\185\128\224\184\167\224\184\165\224\184\178\224\185\128\224\184\165\224\185\136\224\184\153\224\184\163\224\184\167\224\184\161: " .. r_v33_68)
        local r_v26_51 = "\n\240\159\142\174 \224\185\128\224\184\165\224\185\136\224\184\153\224\184\136\224\184\154\224\185\132\224\184\155\224\185\129\224\184\165\224\185\137\224\184\167: " .. (r_v29_59 .. r_v30_41)
        local r_v22_90 = "\n\226\156\168 Stardust \224\184\163\224\184\167\224\184\161: " .. (r_v28_53 .. r_v26_51)
        local r_v20_193 = "\n\240\159\146\176 \224\185\128\224\184\135\224\184\180\224\184\153\224\184\163\224\184\167\224\184\161: " .. (r_v23_55 .. r_v22_90)
        local r_v15_440 = "\240\159\146\142 \224\185\128\224\184\158\224\184\138\224\184\163\224\184\163\224\184\167\224\184\161: " .. (r_v19_138 .. r_v20_193)
        r_v1_831:AddParagraph("\224\184\130\224\185\137\224\184\173\224\184\161\224\184\185\224\184\165\224\184\170\224\184\176\224\184\170\224\184\161\224\184\150\224\184\178\224\184\167\224\184\163 (\224\184\149\224\184\177\224\185\137\224\184\135\224\185\129\224\184\149\224\185\136\224\185\131\224\184\138\224\185\137\224\184\170\224\184\132\224\184\163\224\184\180\224\184\155\224\184\149\224\185\140):", r_v15_440)
        T_Main:AddLabel("\240\159\142\175 \224\184\138\224\185\136\224\184\167\224\184\162\224\185\128\224\184\171\224\184\165\224\184\183\224\184\173\224\185\131\224\184\153\224\184\148\224\185\136\224\184\178\224\184\153 (GUI)")
        local r_v1_833 = nil
        local r_v13_646 = nil
        local r_v1_834 = T_Main
        local r_v20_197 = r_v40_42.auto_vote_extreme
        r_v1_833 = r_v1_834:AddToggle("\224\185\130\224\184\171\224\184\167\224\184\149\224\185\130\224\184\171\224\184\161\224\184\148 Extreme", "\224\185\130\224\184\171\224\184\167\224\184\149\224\185\130\224\184\171\224\184\161\224\184\148\224\184\132\224\184\167\224\184\178\224\184\161\224\184\162\224\184\178\224\184\129\224\184\170\224\184\185\224\184\135\224\184\170\224\184\184\224\184\148\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180", r_v20_197, function(r_v10_719)
            r_v40_42.auto_vote_extreme = r_v10_719
            Save()
            local r_v4_1903 = r_v10_719
            if r_v10_719 then
                r_v4_1903 = r_v13_646
            end
            if r_v4_1903 then
                r_v13_646:Set(false, true)
            end
            if ((not r_v71_75()) and r_v10_719) then
                task.spawn(AutoVoteExtreme)
            end
            r_v10_719 = nil
        end)
        local r_v1_835 = T_Main
        local r_v19_146 = r_v40_42.auto_vote_normal
        local r_v16_381 = r_v1_835:AddToggle("\224\185\130\224\184\171\224\184\167\224\184\149\224\185\130\224\184\171\224\184\161\224\184\148 Normal", "\224\185\130\224\184\171\224\184\167\224\184\149\224\185\130\224\184\171\224\184\161\224\184\148\224\184\132\224\184\167\224\184\178\224\184\161\224\184\162\224\184\178\224\184\129\224\184\155\224\184\129\224\184\149\224\184\180\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180", r_v19_146, function(r_v10_720)
            r_v40_42.auto_vote_normal = r_v10_720
            Save()
            local r_v4_1913 = r_v10_720
            if r_v10_720 then
                r_v4_1913 = r_v1_833
            end
            if r_v4_1913 then
                r_v1_833:Set(false, true)
            end
            if ((not r_v71_75()) and r_v10_720) then
                task.spawn(AutoVoteNormal)
            end
            r_v10_720 = nil
        end)
        local r_v1_836 = nil
        r_v13_646 = r_v16_381
        local r_v17_316 = nil
        local r_v1_837 = T_Main
        local r_v22_98 = r_v40_42.auto_2x
        r_v1_836 = r_v1_837:AddToggle("\224\184\132\224\184\167\224\184\178\224\184\161\224\185\128\224\184\163\224\185\135\224\184\167 x2", "\224\185\128\224\184\163\224\185\136\224\184\135\224\184\132\224\184\167\224\184\178\224\184\161\224\185\128\224\184\163\224\185\135\224\184\167\224\185\128\224\184\129\224\184\161 2 \224\185\128\224\184\151\224\185\136\224\184\178\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180", r_v22_98, function(r_v10_721)
            r_v40_42.auto_2x = r_v10_721
            Save()
            local r_v4_1923 = r_v10_721
            if r_v10_721 then
                r_v4_1923 = r_v17_316
            end
            if r_v4_1923 then
                r_v17_316:Set(false, true)
                r_v40_42.auto_3x = false
            end
            if ((not r_v71_75()) and r_v10_721) then
                AutoChangeSpeed()
            end
            r_v10_721 = nil
        end)
        local r_v1_838 = T_Main
        local r_v23_65 = r_v40_42.auto_3x
        r_v17_316 = r_v1_838:AddToggle("\224\184\132\224\184\167\224\184\178\224\184\161\224\185\128\224\184\163\224\185\135\224\184\167 x3", "\224\185\128\224\184\163\224\185\136\224\184\135\224\184\132\224\184\167\224\184\178\224\184\161\224\185\128\224\184\163\224\185\135\224\184\167\224\185\128\224\184\129\224\184\161 3 \224\185\128\224\184\151\224\185\136\224\184\178\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180", r_v23_65, function(r_v10_722)
            r_v40_42.auto_3x = r_v10_722
            Save()
            local r_v4_1934 = r_v10_722
            if r_v10_722 then
                r_v4_1934 = r_v1_836
            end
            if r_v4_1934 then
                r_v1_836:Set(false, true)
                r_v40_42.auto_2x = false
            end
            if ((not r_v71_75()) and r_v10_722) then
                AutoChangeSpeed()
            end
            r_v10_722 = nil
        end)
        local r_v1_839 = T_Main
        local r_v24_76 = r_v40_42.auto_battle
        r_v1_839:AddToggle("\224\184\149\224\185\136\224\184\173\224\184\170\224\184\185\224\185\137\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180 (Auto Battle)", "\224\185\131\224\184\138\224\185\137\224\185\128\224\184\158\224\184\138\224\184\163\224\184\165\224\184\135\224\185\128\224\184\165\224\185\136\224\184\153\224\184\148\224\185\136\224\184\178\224\184\153\224\185\129\224\184\154\224\184\154 AutoPlay", r_v24_76, function(r_v10_723)
            r_v40_42.auto_battle = r_v10_723
            Save()
            if ((not r_v71_75()) and r_v10_723) then
                AutoBattle()
            end
            r_v10_723 = nil
        end)
        local r_v1_840 = T_Main
        local r_v26_63 = tostring(r_v40_42.auto_battle_gems)
        local r_v22_102 = "\224\185\128\224\184\158\224\184\138\224\184\163\224\184\130\224\184\177\224\185\137\224\184\153\224\184\149\224\185\136\224\184\179 Auto Battle (\224\184\132\224\185\136\224\184\178\224\184\155\224\184\177\224\184\136\224\184\136\224\184\184\224\184\154\224\184\177\224\184\153: " .. (r_v26_63 .. ")")
        r_v1_840:AddTextbox(r_v22_102, function(r_v10_724)
            local r_v2_1105 = tonumber(r_v10_724)
            if r_v2_1105 then
                if (r_v2_1105 < 20) then
                    r_v2_1105 = 20
                end
                r_v40_42.auto_battle_gems = r_v2_1105
                Save()
                r_v67_92("\224\184\149\224\184\177\224\185\137\224\184\135\224\184\132\224\185\136\224\184\178", "\224\185\128\224\184\158\224\184\138\224\184\163\224\184\130\224\184\177\224\185\137\224\184\153\224\184\149\224\185\136\224\184\179 Auto Battle \224\184\149\224\184\177\224\185\137\224\184\135\224\185\128\224\184\155\224\185\135\224\184\153 " .. (tostring(r_v2_1105)), 3)
            end
            r_v10_724 = nil
        end)
        T_Main:AddLabel("\240\159\143\134 \224\184\136\224\184\154\224\185\128\224\184\129\224\184\161 (Game End)")
        local r_v1_842 = T_Main
        local r_v24_82 = r_v40_42.smart_auto_next
        r_v1_842:AddToggle("\224\185\128\224\184\165\224\185\136\224\184\153\224\184\139\224\185\137\224\184\179/\224\184\165\224\184\184\224\184\162\224\184\149\224\185\136\224\184\173\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180 (Smart Next)", "\224\185\129\224\184\158\224\185\137\224\184\171\224\184\173\224\184\132\224\184\173\224\184\162=Replay / \224\184\138\224\184\153\224\184\176=Next Story", r_v24_82, function(r_v10_725)
            r_v40_42.smart_auto_next = r_v10_725
            Save()
            if ((not r_v71_75()) and r_v10_725) then
                task.spawn(SmartAutoNext)
            end
            r_v10_725 = nil
        end)
        local r_v1_843 = T_Main
        local r_v24_85 = r_v40_42.auto_replay
        r_v1_843:AddToggle("\224\185\128\224\184\163\224\184\180\224\185\136\224\184\161\224\185\128\224\184\129\224\184\161\224\185\128\224\184\148\224\184\180\224\184\161\224\184\139\224\185\137\224\184\179\224\185\128\224\184\170\224\184\161\224\184\173 (Replay)", "\224\184\129\224\184\148\224\185\128\224\184\165\224\185\136\224\184\153\224\184\148\224\185\136\224\184\178\224\184\153\224\185\128\224\184\148\224\184\180\224\184\161\224\184\139\224\185\137\224\184\179\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180", r_v24_85, function(r_v10_726)
            r_v40_42.auto_replay = r_v10_726
            Save()
            if ((not r_v71_75()) and r_v10_726) then
                task.spawn(AutoReplay)
            end
            r_v10_726 = nil
        end)
        local r_v1_844 = T_Main
        local r_v24_88 = r_v40_42.auto_next_story
        r_v1_844:AddToggle("\224\185\132\224\184\155\224\184\148\224\185\136\224\184\178\224\184\153\224\184\150\224\184\177\224\184\148\224\185\132\224\184\155\224\185\128\224\184\170\224\184\161\224\184\173 (Next Story)", "\224\184\129\224\184\148\224\184\165\224\184\184\224\184\162\224\185\128\224\184\153\224\184\183\224\185\137\224\184\173\224\185\128\224\184\163\224\184\183\224\185\136\224\184\173\224\184\135\224\184\148\224\185\136\224\184\178\224\184\153\224\184\150\224\184\177\224\184\148\224\185\132\224\184\155\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180", r_v24_88, function(r_v10_727)
            r_v40_42.auto_next_story = r_v10_727
            Save()
            if ((not r_v71_75()) and r_v10_727) then
                task.spawn(AutoNextStory)
            end
            r_v10_727 = nil
        end)
        T_Farm:AddLabel("\240\159\146\142 \224\184\173\224\184\173\224\185\130\224\184\149\224\185\137\224\184\167\224\184\178\224\184\135\224\184\149\224\184\177\224\184\167\224\185\128\224\184\135\224\184\180\224\184\153 (\224\184\167\224\184\178\224\184\135\224\185\132\224\184\148\224\185\137 1 \224\184\149\224\184\177\224\184\167\224\185\128\224\184\151\224\185\136\224\184\178\224\184\153\224\184\177\224\185\137\224\184\153)")
        local r_v1_846 = T_Farm
        local r_v24_92 = r_v40_42.auto_farm_enable
        r_v1_846:AddToggle("\224\185\128\224\184\155\224\184\180\224\184\148\224\185\131\224\184\138\224\185\137\224\184\173\224\184\173\224\185\130\224\184\149\224\185\137\224\184\167\224\184\178\224\184\135\224\184\149\224\184\177\224\184\167\224\184\159\224\184\178\224\184\163\224\185\140\224\184\161", "\224\184\170\224\185\129\224\184\129\224\184\153\224\184\171\224\184\178 Base_Part \224\185\129\224\184\165\224\185\137\224\184\167\224\184\167\224\184\178\224\184\155\224\185\132\224\184\155\224\184\167\224\184\178\224\184\135", r_v24_92, function(r_v10_728)
            r_v40_42.auto_farm_enable = r_v10_728
            Save()
            if ((not r_v71_75()) and r_v10_728) then
                task.spawn(AutoFarmSetup)
            end
            r_v10_728 = nil
        end)
        local r_v21_167 = T_Farm:AddDropdown("\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129\224\184\162\224\184\185\224\184\153\224\184\180\224\184\149\224\184\151\224\184\179\224\185\128\224\184\135\224\184\180\224\184\153", r_v49_62, function(r_v10_729)
            r_v40_42.auto_farm_unit = r_v10_729
            Save()
            r_v10_729 = nil
        end)
        local r_v22_110 = (r_v40_42.auto_farm_unit) or ("Speedwagon")
        r_v21_167:Set(r_v22_110)
        local r_v1_852 = T_Farm
        local r_v27_62 = r_v40_42
        local r_v26_82 = function(r_v10_730)
            r_v40_42.auto_farm_upgrade_wave = r_v10_730
            Save()
            r_v10_730 = nil
        end
        local r_v28_80 = r_v27_62.auto_farm_upgrade_wave
        local r_v25_89 = r_v28_80 or 15
        r_v1_852:AddSlider("\224\184\173\224\184\177\224\184\155\224\184\149\224\184\177\224\184\153\224\185\128\224\184\161\224\184\183\224\185\136\224\184\173\224\184\150\224\184\182\224\184\135\224\185\128\224\184\167\224\184\159...", 1, 100, r_v25_89, r_v26_82)
        T_Farm:AddLabel("\240\159\146\176 \224\184\149\224\184\177\224\185\137\224\184\135\224\184\132\224\185\136\224\184\178\224\184\173\224\184\173\224\185\130\224\184\149\224\185\137\224\184\159\224\184\178\224\184\163\224\185\140\224\184\161 (\224\184\173\224\184\177\224\184\155\224\185\128\224\184\129\224\184\163\224\184\148/\224\184\130\224\184\178\224\184\162\224\184\151\224\184\177\224\185\136\224\184\167\224\185\132\224\184\155)")
        local r_v21_173 = T_Farm
        local r_v25_93 = r_v40_42.auto_upgrade
        r_v21_173:AddToggle("\224\184\173\224\184\177\224\184\155\224\185\128\224\184\129\224\184\163\224\184\148\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180", "\224\184\173\224\184\177\224\184\155\224\185\128\224\184\165\224\185\128\224\184\167\224\184\165\224\184\162\224\184\185\224\184\153\224\184\180\224\184\149\224\185\128\224\184\161\224\184\183\224\185\136\224\184\173\224\185\128\224\184\135\224\184\180\224\184\153\224\184\158\224\184\173", r_v25_93, function(r_v10_731)
            r_v40_42.auto_upgrade = r_v10_731
            Save()
            if ((not r_v71_75()) and r_v10_731) then
                AutoUpgrade()
            end
            r_v10_731 = nil
        end)
        T_Farm:AddTextbox("\224\184\136\224\184\179\224\184\153\224\184\167\224\184\153\224\185\128\224\184\135\224\184\180\224\184\153\224\184\129\224\185\136\224\184\173\224\184\153\224\184\173\224\184\177\224\184\155\224\185\128\224\184\129\224\184\163\224\184\148...", function(r_v10_732)
            r_v40_42.auto_upgrade_money = (tonumber(r_v10_732)) or (r_v40_42.auto_upgrade_money)
            Save()
            r_v10_732 = nil
        end)
        T_Farm:AddTextbox("\224\185\128\224\184\163\224\184\180\224\185\136\224\184\161\224\184\173\224\184\177\224\184\155\224\185\128\224\184\129\224\184\163\224\184\148\224\185\128\224\184\161\224\184\183\224\185\136\224\184\173\224\184\150\224\184\182\224\184\135\224\185\128\224\184\167\224\184\159\224\184\151\224\184\181\224\185\136...", function(r_v10_733)
            r_v40_42.auto_upgrade_wave = (tonumber(r_v10_733)) or (r_v40_42.auto_upgrade_wave)
            Save()
            r_v10_733 = nil
        end)
        T_Farm:AddTextbox("\224\184\171\224\184\162\224\184\184\224\184\148\224\184\173\224\184\177\224\184\155\224\185\128\224\184\129\224\184\163\224\184\148\224\185\128\224\184\161\224\184\183\224\185\136\224\184\173\224\184\150\224\184\182\224\184\135\224\185\128\224\184\167\224\184\159\224\184\151\224\184\181\224\185\136...", function(r_v10_734)
            r_v40_42.auto_upgrade_wave_stop = (tonumber(r_v10_734)) or (r_v40_42.auto_upgrade_wave_stop)
            Save()
            r_v10_734 = nil
        end)
        T_Farm:AddLabel("\240\159\155\161\239\184\143 \224\184\149\224\184\177\224\185\137\224\184\135\224\184\132\224\185\136\224\184\178\224\184\130\224\184\178\224\184\162\224\185\129\224\184\165\224\184\176\224\185\129\224\184\154\224\184\165\224\185\135\224\184\132\224\184\165\224\184\180\224\184\170\224\184\149\224\185\140 (Safe Sell)")
        local r_v21_178 = T_Farm
        local r_v25_100 = r_v40_42.auto_upgrade_sell
        r_v21_178:AddToggle("\224\184\130\224\184\178\224\184\162\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180", "\224\184\130\224\184\178\224\184\162\224\184\162\224\184\185\224\184\153\224\184\180\224\184\149\224\184\151\224\184\180\224\185\137\224\184\135\224\184\171\224\184\161\224\184\148\224\185\128\224\184\161\224\184\183\224\185\136\224\184\173\224\184\150\224\184\182\224\184\135\224\185\128\224\184\167\224\184\159\224\184\151\224\184\181\224\185\136\224\184\149\224\184\177\224\185\137\224\184\135", r_v25_100, function(r_v10_735)
            r_v40_42.auto_upgrade_sell = r_v10_735
            Save()
            if ((not r_v71_75()) and r_v10_735) then
                AutoSell()
            end
            r_v10_735 = nil
        end)
        T_Farm:AddTextbox("\224\184\130\224\184\178\224\184\162\224\184\162\224\184\185\224\184\153\224\184\180\224\184\149\224\184\151\224\184\177\224\185\137\224\184\135\224\184\171\224\184\161\224\184\148\224\185\128\224\184\161\224\184\183\224\185\136\224\184\173\224\184\150\224\184\182\224\184\135\224\185\128\224\184\167\224\184\159\224\184\151\224\184\181\224\185\136...", function(r_v10_736)
            r_v40_42.auto_upgrade_wave_sell = (tonumber(r_v10_736)) or (r_v40_42.auto_upgrade_wave_sell)
            Save()
            r_v10_736 = nil
        end)
        local r_v22_147 = T_Farm:AddTextbox("\224\184\163\224\184\178\224\184\162\224\184\138\224\184\183\224\185\136\224\184\173\224\184\171\224\185\137\224\184\178\224\184\161\224\184\130\224\184\178\224\184\162 (\224\184\158\224\184\180\224\184\161\224\184\158\224\185\140\224\185\128\224\184\173\224\184\135,\224\184\132\224\184\177\224\185\136\224\184\153\224\184\148\224\185\137\224\184\167\224\184\162\224\184\165\224\184\185\224\184\129\224\184\153\224\185\137\224\184\179)", function(r_v10_737)
            r_v40_42.auto_sell_blacklist = r_v10_737
            Save()
            r_v10_737 = nil
        end)
        local r_v24_114 = (r_v40_42.auto_sell_blacklist) or ("")
        r_v22_147:Set(r_v24_114)
        T_Farm:AddDropdown("\226\158\149 \224\185\128\224\184\165\224\184\183\224\184\173\224\184\129\224\184\161\224\184\173\224\184\153\224\184\151\224\184\181\224\185\136\224\184\171\224\185\137\224\184\178\224\184\161\224\184\130\224\184\178\224\184\162 (\224\185\128\224\184\158\224\184\180\224\185\136\224\184\161\224\184\173\224\184\173\224\185\130\224\184\149\224\185\137)", {
            "W3Octo",
            "Speedwagon",
            "Bulma (Super Money Corp)",
            "Hoshino",
            "Daydayfarm",
            "Erwin",
            "Merlin",
            "Brook6"
        }, function(r_v10_738)
            local r_v2_1150 = r_v40_42.auto_sell_blacklist
            local r_v4_2011 = r_v2_1150
            if not r_v2_1150 then
                r_v2_1150 = ""
                r_v4_2011 = r_v2_1150
            end
            r_v2_1150 = r_v4_2011
            local r_v4_2012 = string.find
            local r_v6_1683 = string
            local r_v6_1684 = r_v6_1683.lower(r_v2_1150)
            local r_v5_1411 = string.lower
            if (not r_v4_2012(r_v6_1684, r_v5_1411(r_v10_738))) then
                if (r_v2_1150 == "") then
                    r_v2_1150 = r_v10_738
                else
                    local r_v3_1198 = ", " .. r_v10_738
                    r_v2_1150 = r_v2_1150 .. r_v3_1198
                end
                r_v40_42.auto_sell_blacklist = r_v2_1150
                Save()
                r_v22_147:Set(r_v2_1150)
                r_v67_92("Blacklist", "\224\185\128\224\184\158\224\184\180\224\185\136\224\184\161 " .. r_v10_738 .. " \224\184\165\224\184\135\224\185\131\224\184\153\224\184\163\224\184\178\224\184\162\224\184\129\224\184\178\224\184\163\224\184\171\224\185\137\224\184\178\224\184\161\224\184\130\224\184\178\224\184\162\224\185\129\224\184\165\224\185\137\224\184\167", 3)
            end
            r_v10_738 = nil
        end)
        T_Macro:AddLabel("\240\159\147\140 \224\184\170\224\184\150\224\184\178\224\184\153\224\184\176\224\184\155\224\184\177\224\184\136\224\184\136\224\184\184\224\184\154\224\184\177\224\184\153 (Status)")
        local r_v24_129 = T_Macro:AddParagraph("\224\184\130\224\185\137\224\184\173\224\184\161\224\184\185\224\184\165\224\185\130\224\184\155\224\184\163\224\185\132\224\184\159\224\184\165\224\185\140", "\224\184\129\224\184\179\224\184\165\224\184\177\224\184\135\224\184\148\224\184\182\224\184\135\224\184\130\224\185\137\224\184\173\224\184\161\224\184\185\224\184\165...")
        local r_v25_114 = T_Macro:AddParagraph("\224\184\170\224\184\150\224\184\178\224\184\153\224\184\176\224\184\129\224\184\178\224\184\163\224\184\151\224\184\179\224\184\135\224\184\178\224\184\153", "\224\184\129\224\184\179\224\184\165\224\184\177\224\184\135\224\185\128\224\184\149\224\184\163\224\184\181\224\184\162\224\184\161\224\184\158\224\184\163\224\185\137\224\184\173\224\184\161...")
        task.spawn(function()
            while true do
                if r_v24_129 == nil then
                    break
                end
                local r_v10_740 = r_v40_43[r_v40_42.macro_profile]
                local r_v4_2016 = r_v10_740
                if r_v10_740 then
                    local r_v5_1423 = r_v40_43[r_v40_42.macro_profile].Macro
                    local r_v3_1204 = r_v5_1423 ~= nil
                    local r_v10_741 = r_v3_1204
                    if r_v3_1204 then
                        local r_v5_1424 = r_v40_43[r_v40_42.macro_profile].Units
                        r_v10_741 = r_v5_1424 ~= nil
                    end
                    r_v4_2016 = r_v10_741
                end
                if r_v4_2016 then
                    local r_v6_1699 = string.format
                    local r_v14_1679 = tostring(#r_v40_43[r_v40_42.macro_profile].Macro)
                    local r_v9_1808 = table.concat
                    local r_v12_1278 = r_v33_30(r_v40_43[r_v40_42.macro_profile].Units)
                    local r_v8_1844 = r_v6_1699("\224\184\136\224\184\179\224\184\153\224\184\167\224\184\153\224\184\130\224\184\177\224\185\137\224\184\153\224\184\149\224\184\173\224\184\153\224\184\151\224\184\177\224\185\137\224\184\135\224\184\171\224\184\161\224\184\148: %s\n\224\184\162\224\184\185\224\184\153\224\184\180\224\184\149\224\185\131\224\184\153\224\184\163\224\184\176\224\184\154\224\184\154: %s", r_v14_1679, r_v9_1808(r_v12_1278, ", "))
                    r_v24_129:Set({
                        ["Title"] = "\224\184\163\224\184\178\224\184\162\224\184\165\224\184\176\224\185\128\224\184\173\224\184\181\224\184\162\224\184\148\224\184\130\224\184\173\224\184\135\224\184\161\224\184\178\224\185\130\224\184\132\224\184\163\224\184\151\224\184\181\224\185\136\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129:",
                        ["Content"] = r_v8_1844
                    })
                end
                task.wait(1)
            end
        end)
        task.spawn(function()
            while true do
                if r_v25_114 == nil then
                    break
                end
                local r_v4_2023 = (o_v29_5 ~= nil) and (r_v40_43[r_v40_42.macro_profile])
                if r_v4_2023 then
                    local r_v10_749 = r_v40_43[r_v40_42.macro_profile]
                    local r_v2_1158 = "Macro"
                    local r_v4_2024 = r_v10_749[r_v2_1158]
                    local r_v10_750 = o_v29_5
                    r_v10_750 = r_v4_2024[r_v10_750]
                    if (r_v10_750 ~= nil) then
                        local r_v3_1219 = state
                        local r_v5_1436 = r_v10_750.Target
                        r_v2_1158 = r_v5_1436
                        if r_v5_1436 then
                            local r_v6_1714 = r_v10_750.Target
                            r_v2_1158 = r_v6_1714.Name
                        end
                        local r_v1_1798 = r_v3_1219
                        local r_v4_2026 = r_v2_1158 or nil
                        local r_v3_1226 = r_v1_1798
                        local r_v8_1861 = r_v10_750.Target
                        r_v2_1158 = r_v4_2026
                        local r_v5_1445 = r_v8_1861
                        if r_v8_1861 then
                            local r_v7_1848 = r_v10_750.Target
                            r_v5_1445 = r_v7_1848.Index
                        end
                        local r_v4_2027 = r_v5_1445 or nil
                        r_v5_1445 = r_v1_1798
                        local r_v9_1830 = tonumber(r_v10_750.Time)
                        r_v3_1226 = r_v4_2027
                        local r_v6_1717 = r_v9_1830 and (string.format("%.14f", r_v10_750.Time))
                        local r_v4_2028 = r_v6_1717 or (tostring(r_v10_750.Time))
                        r_v6_1717 = r_v5_1445
                        local r_v9_1833 = r_v10_750.Remote
                        r_v5_1445 = r_v4_2028
                        local r_v8_1864 = r_v9_1833
                        if r_v9_1833 then
                            local r_v14_1705 = r_v10_750.Remote
                            r_v8_1864 = r_v14_1705[1]
                        end
                        r_v6_1717 = r_v8_1864 or nil
                        local r_v8_1867 = r_v2_3
                        r_v8_1867 = ""
                        if r_v10_750.Parameter then
                            local r_v4_2032 = pairs
                            local r_v11_1580 = r_v10_750.Parameter
                            for r_v11_1580, r_v13_1498 in r_v4_2032(r_v11_1580) do
                                local r_v16_941 = tostring(r_v11_1580)
                                local r_v18_351 = tostring(r_v13_1498)
                                local r_v15_1092 = ": " .. (r_v18_351 .. "; ")
                                local r_v12_1303 = r_v16_941 .. r_v15_1092
                                r_v8_1867 = r_v8_1867 .. r_v12_1303
                            end
                        end
                        local r_v9_1840 = string.format("%.14f", r_v100_10())
                        local r_v17_806 = string.format("\224\184\130\224\184\177\224\185\137\224\184\153\224\184\149\224\184\173\224\184\153\224\184\151\224\184\181\224\185\136: %s\n\224\185\128\224\184\155\224\185\137\224\184\178\224\184\171\224\184\161\224\184\178\224\184\162: %s[%s]\n\224\185\128\224\184\167\224\184\165\224\184\178: %s\n\224\185\128\224\184\167\224\184\165\224\184\178\224\184\151\224\184\181\224\185\136\224\184\156\224\185\136\224\184\178\224\184\153\224\185\132\224\184\155: %s\n\224\184\132\224\184\179\224\184\170\224\184\177\224\185\136\224\184\135: %s\n\224\184\158\224\184\178\224\184\163\224\184\178\224\184\161\224\184\180\224\185\128\224\184\149\224\184\173\224\184\163\224\185\140: %s", (tostring(o_v29_5)), (tostring(r_v2_1158)), (tostring(r_v3_1226)), (tostring(r_v5_1445)), r_v9_1840, (tostring(r_v6_1717)), tostring(r_v8_1867))
                        r_v25_114:Set({
                            ["Title"] = "\224\184\170\224\184\150\224\184\178\224\184\153\224\184\176\224\184\155\224\184\177\224\184\136\224\184\136\224\184\184\224\184\154\224\184\177\224\184\153",
                            ["Content"] = r_v17_806
                        })
                        r_v2_1158 = nil
                    else
                        local r_v3_1221 = string.format("%.14f", r_v100_10())
                        local r_v11_1564 = string.format("\224\185\128\224\184\129\224\184\180\224\184\148\224\184\130\224\185\137\224\184\173\224\184\156\224\184\180\224\184\148\224\184\158\224\184\165\224\184\178\224\184\148\224\184\151\224\184\181\224\185\136\224\184\130\224\184\177\224\185\137\224\184\153\224\184\149\224\184\173\224\184\153 %s!\n\224\185\128\224\184\167\224\184\165\224\184\178\224\184\151\224\184\181\224\185\136\224\184\156\224\185\136\224\184\178\224\184\153\224\185\132\224\184\155: %s", (tostring(o_v29_5)), r_v3_1221)
                        r_v25_114:Set({
                            ["Title"] = "\224\184\170\224\184\150\224\184\178\224\184\153\224\184\176\224\184\155\224\184\177\224\184\136\224\184\136\224\184\184\224\184\154\224\184\177\224\184\153",
                            ["Content"] = r_v11_1564
                        })
                    end
                else
                    local r_v2_1160 = string.format("%.14f", r_v100_10())
                    local r_v14_1686 = string.format("\224\184\170\224\184\150\224\184\178\224\184\153\224\184\176\224\184\167\224\185\136\224\184\178\224\184\135 (Idle)...\n\224\185\128\224\184\167\224\184\165\224\184\178\224\184\151\224\184\181\224\185\136\224\184\156\224\185\136\224\184\178\224\184\153\224\185\132\224\184\155: %s", r_v2_1160)
                    r_v25_114:Set({
                        ["Title"] = "\224\184\170\224\184\150\224\184\178\224\184\153\224\184\176\224\184\155\224\184\177\224\184\136\224\184\136\224\184\184\224\184\154\224\184\177\224\184\153",
                        ["Content"] = r_v14_1686
                    })
                end
                task.wait(0.1)
            end
        end)
        T_Macro:AddLabel("\240\159\142\174 \224\184\129\224\184\178\224\184\163\224\184\132\224\184\167\224\184\154\224\184\132\224\184\184\224\184\161\224\184\171\224\184\165\224\184\177\224\184\129 (Main Controls)")
        local r_v26_121 = T_Macro:AddDropdown("\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129\224\185\130\224\184\155\224\184\163\224\185\132\224\184\159\224\184\165\224\185\140\224\184\161\224\184\178\224\185\130\224\184\132\224\184\163", r_v60_81, function(r_v10_754)
            r_v40_42.macro_profile = r_v10_754
            if (r_v40_43[r_v40_42.macro_profile] == nil) then
                r_v40_43[r_v40_42.macro_profile] = {}
            end
            Save()
            r_v10_754 = nil
        end)
        local r_v27_96 = r_v40_42.macro_profile
        r_v26_121:Set(r_v27_96)
        T_Macro:AddButton("\240\159\148\132 \224\184\163\224\184\181\224\185\128\224\184\159\224\184\163\224\184\138\224\184\148\224\184\163\224\184\173\224\184\155\224\184\148\224\184\178\224\184\167\224\184\153\224\185\140\224\185\130\224\184\155\224\184\163\224\185\132\224\184\159\224\184\165\224\185\140", function()
            r_v60_81 = {}
            local r_v4_2039 = pairs
            local r_v5_1449 = r_v40_43
            for r_v5_1449, r_v6_1723 in r_v4_2039(r_v5_1449) do
                table.insert(r_v60_81, r_v5_1449)
            end
            table.sort(r_v60_81)
            local r_v10_759 = table.find
            local r_v5_1452 = r_v40_42.macro_profile
            if (not r_v10_759(r_v60_81, r_v5_1452)) then
                r_v40_42.macro_profile = (r_v60_81[1]) or ("Default Profile")
            end
            local r_v3_1237 = r_v40_42.macro_profile
            r_v26_121:Refresh(r_v60_81, r_v3_1237)
            r_v67_92("\224\184\161\224\184\178\224\185\130\224\184\132\224\184\163", "\224\184\163\224\184\181\224\185\128\224\184\159\224\184\163\224\184\138\224\184\130\224\185\137\224\184\173\224\184\161\224\184\185\224\184\165\224\185\128\224\184\163\224\184\181\224\184\162\224\184\154\224\184\163\224\185\137\224\184\173\224\184\162", 3)
        end)
        local r_v28_123 = getgenv()
        local r_v27_99 = T_Macro
        local r_v31_74 = r_v40_42.macro_record
        r_v28_123.MacroRecordToggle = r_v27_99:AddToggle("\240\159\148\180 \224\184\154\224\184\177\224\184\153\224\184\151\224\184\182\224\184\129\224\184\161\224\184\178\224\185\130\224\184\132\224\184\163 (Record)", "\224\184\129\224\184\148\224\185\128\224\184\158\224\184\183\224\185\136\224\184\173\224\185\128\224\184\163\224\184\180\224\185\136\224\184\161\224\184\154\224\184\177\224\184\153\224\184\151\224\184\182\224\184\129\224\184\129\224\184\178\224\184\163\224\184\129\224\184\163\224\184\176\224\184\151\224\184\179\224\184\165\224\184\135\224\185\131\224\184\153\224\185\130\224\184\155\224\184\163\224\185\132\224\184\159\224\184\165\224\185\140", r_v31_74, function(r_v10_765)
            r_v40_42.macro_record = r_v10_765
            Save()
            if (not r_v71_75()) then
                if r_v10_765 then
                    StartMacroRecord()
                else
                    StopMacroRecord()
                end
            end
            r_v10_765 = nil
        end)
        local r_v26_126 = T_Macro
        local r_v30_77 = r_v40_42.macro_playback
        r_v26_126:AddToggle("\226\150\182\239\184\143 \224\185\128\224\184\165\224\185\136\224\184\153\224\184\161\224\184\178\224\185\130\224\184\132\224\184\163 (Playback)", "\224\185\131\224\184\171\224\185\137\224\184\154\224\184\173\224\184\151\224\185\128\224\184\165\224\185\136\224\184\153\224\184\149\224\184\178\224\184\161\224\184\151\224\184\181\224\185\136\224\184\154\224\184\177\224\184\153\224\184\151\224\184\182\224\184\129\224\185\132\224\184\167\224\185\137", r_v30_77, function(r_v10_766)
            r_v40_42.macro_playback = r_v10_766
            Save()
            if (not r_v71_75()) then
                if r_v10_766 then
                    r_v67_92("\224\184\161\224\184\178\224\185\130\224\184\132\224\184\163", "\224\184\129\224\184\179\224\184\165\224\184\177\224\184\135\224\185\128\224\184\163\224\184\180\224\185\136\224\184\161\224\184\151\224\184\179\224\184\135\224\184\178\224\184\153Playback...", 3)
                    StartMacroPlayback()
                else
                    r_v67_92("\224\184\161\224\184\178\224\185\130\224\184\132\224\184\163", "\224\184\171\224\184\162\224\184\184\224\184\148\224\184\151\224\184\179\224\184\135\224\184\178\224\184\153Playback...", 3)
                    StopMacroPlayback()
                end
            end
            r_v10_766 = nil
        end)
        local r_v26_127 = T_Macro
        local r_v30_80 = r_v40_42.auto_change_macro_map
        r_v26_127:AddToggle("\240\159\148\128 \224\185\128\224\184\155\224\184\165\224\184\181\224\185\136\224\184\162\224\184\153\224\185\130\224\184\155\224\184\163\224\185\132\224\184\159\224\184\165\224\185\140\224\184\149\224\184\178\224\184\161\224\184\138\224\184\183\224\185\136\224\184\173\224\184\148\224\185\136\224\184\178\224\184\153", "\224\184\173\224\184\173\224\185\130\224\184\149\224\185\137\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129\224\185\130\224\184\155\224\184\163\224\185\132\224\184\159\224\184\165\224\185\140\224\184\151\224\184\181\224\185\136\224\184\138\224\184\183\224\185\136\224\184\173\224\185\128\224\184\171\224\184\161\224\184\183\224\184\173\224\184\153\224\185\129\224\184\161\224\184\158", r_v30_80, function(r_v10_767)
            r_v40_42.auto_change_macro_map = r_v10_767
            Save()
            r_v10_767 = nil
        end)
        T_Macro:AddLabel("\226\143\169 \224\184\136\224\184\177\224\184\148\224\184\129\224\184\178\224\184\163\224\184\130\224\184\177\224\185\137\224\184\153\224\184\149\224\184\173\224\184\153\224\184\161\224\184\178\224\185\130\224\184\132\224\184\163 (Step Management)")
        T_Macro:AddButton("\224\184\162\224\185\137\224\184\173\224\184\153\224\184\129\224\184\165\224\184\177\224\184\154 1 \224\184\130\224\184\177\224\185\137\224\184\153\224\184\149\224\184\173\224\184\153 (Prev Step)", function()
            if ((o_v29_5 ~= nil) and (o_v29_5 > 0)) then
                o_v29_5 = o_v29_5 - 1
            else
                o_v29_5 = 1
            end
        end)
        T_Macro:AddButton("\224\184\130\224\185\137\224\184\178\224\184\161\224\185\132\224\184\155\224\184\130\224\184\177\224\185\137\224\184\153\224\184\149\224\184\173\224\184\153\224\184\150\224\184\177\224\184\148\224\185\132\224\184\155 (Next Step)", function()
            local r_v10_771 = (o_v29_5 == nil) or (o_v29_5 < 0)
            local r_v4_2070 = r_v10_771
            if r_v10_771 then
                local r_v3_1251 = r_v40_43[r_v40_42.macro_profile].Macro
                r_v4_2070 = (#r_v3_1251) > 0
            end
            if r_v4_2070 then
                o_v29_5 = 1
            else
                local r_v2_1195 = o_v29_5 ~= nil
                local r_v4_2071 = r_v2_1195
                if r_v2_1195 then
                    local r_v5_1473 = o_v29_5 > 0
                    local r_v2_1196 = r_v5_1473
                    if r_v5_1473 then
                        local r_v7_1878 = r_v40_43[r_v40_42.macro_profile].Macro
                        local r_v8_1892 = #r_v7_1878
                        r_v2_1196 = o_v29_5 < r_v8_1892
                    end
                    r_v4_2071 = r_v2_1196
                end
                if r_v4_2071 then
                    o_v29_5 = o_v29_5 + 1
                end
            end
        end)
        T_Macro:AddButton("\224\184\163\224\184\181\224\185\128\224\184\139\224\185\135\224\184\149\224\184\130\224\184\177\224\185\137\224\184\153\224\184\149\224\184\173\224\184\153\224\185\132\224\184\155\224\184\136\224\184\184\224\184\148\224\185\128\224\184\163\224\184\180\224\185\136\224\184\161\224\184\149\224\185\137\224\184\153 (Reset)", function()
            if (o_v29_5 ~= nil) then
                o_v29_5 = nil
            end
        end)
        T_Macro:AddButton("\240\159\147\140 \224\184\154\224\184\177\224\184\135\224\184\132\224\184\177\224\184\154\224\185\128\224\184\158\224\184\180\224\185\136\224\184\161\224\184\162\224\184\185\224\184\153\224\184\180\224\184\149\224\185\131\224\184\129\224\184\165\224\185\137\224\184\149\224\184\177\224\184\167\224\185\128\224\184\130\224\185\137\224\184\178 Macro", function()
            task.spawn(ManualMapUnitToMacro)
        end)
        T_Macro:AddLabel("\240\159\147\139 \224\184\136\224\184\177\224\184\148\224\184\151\224\184\181\224\184\161\224\184\149\224\184\178\224\184\161\224\184\161\224\184\178\224\185\130\224\184\132\224\184\163 (Auto Equip)")
        local r_v28_159 = T_Macro:AddParagraph("\224\184\149\224\184\177\224\184\167\224\184\165\224\184\176\224\184\132\224\184\163\224\184\151\224\184\181\224\185\136\224\185\131\224\184\138\224\185\137\224\185\131\224\184\153\224\185\130\224\184\155\224\184\163\224\185\132\224\184\159\224\184\165\224\185\140\224\184\153\224\184\181\224\185\137:", "\224\184\129\224\184\179\224\184\165\224\184\177\224\184\135\224\185\130\224\184\171\224\184\165\224\184\148...")
        T_Macro:AddLabel("\240\159\147\139 \224\184\136\224\184\177\224\184\148\224\184\151\224\184\181\224\184\161\224\184\149\224\184\178\224\184\161\224\184\161\224\184\178\224\185\130\224\184\132\224\184\163 (Auto Equip)")
        r_v28_159 = T_Macro:AddParagraph("\224\184\149\224\184\177\224\184\167\224\184\165\224\184\176\224\184\132\224\184\163\224\184\151\224\184\181\224\185\136\224\185\131\224\184\138\224\185\137\224\185\131\224\184\153\224\185\130\224\184\155\224\184\163\224\185\132\224\184\159\224\184\165\224\185\140\224\184\153\224\184\181\224\185\137:", "\224\184\129\224\184\179\224\184\165\224\184\177\224\184\135\224\185\130\224\184\171\224\184\165\224\184\148...")
        LeaderUnitDrop = T_Macro:AddDropdown("\240\159\145\145 \224\185\128\224\184\165\224\184\183\224\184\173\224\184\129\224\184\149\224\184\177\224\184\167\224\184\165\224\184\181\224\184\148\224\185\128\224\184\148\224\184\173\224\184\163\224\185\140 (Leader)", {
            "\224\185\132\224\184\161\224\185\136\224\185\132\224\184\148\224\185\137\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129 (None)"
        }, function(r_v10_779)
            r_v40_42.macro_leader_unit = r_v10_779
            Save()
            r_v10_779 = nil
        end)
        local r_v28_164 = LeaderUnitDrop
        local r_v29_110 = (r_v40_42.macro_leader_unit) or ("\224\185\132\224\184\161\224\185\136\224\185\132\224\184\148\224\185\137\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129 (None)")
        r_v28_164:Set(r_v29_110)
        T_Macro:AddButton("\240\159\148\132 \224\185\130\224\184\171\224\184\165\224\184\148\224\184\163\224\184\178\224\184\162\224\184\138\224\184\183\224\185\136\224\184\173\224\184\149\224\184\177\224\184\167\224\184\165\224\184\176\224\184\132\224\184\163\224\185\128\224\184\158\224\184\183\224\185\136\224\184\173\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129\224\184\165\224\184\181\224\184\148\224\185\128\224\184\148\224\184\173\224\184\163\224\185\140", function()
            local r_v10_780 = r_v40_42.macro_profile
            r_v10_780 = r_v40_43[r_v10_780]
            local r_v4_2080 = r_v10_780 and (r_v10_780.Units)
            if r_v4_2080 then
                local r_v2_1204 = r_v10_780.Units
                r_v2_1204 = r_v33_30(r_v2_1204)
                local r_v3_1260 = r_v2_3
                r_v3_1260 = {
                    "\224\185\132\224\184\161\224\185\136\224\185\132\224\184\148\224\185\137\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129 (None)"
                }
                local r_v4_2084, r_v5_1481, r_v6_1753 = ipairs(r_v2_1204)
                local r_v8_1900 = r_v4_2084
                for r_v7_1885, r_v9_1859 in r_v8_1900, r_v5_1481, r_v6_1753 do
                    local r_v14_1725 = table
                    r_v14_1725.insert(r_v3_1260, r_v9_1859)
                end
                local r_v1_1839 = LeaderUnitDrop
                local r_v11_1595 = r_v40_42.macro_leader_unit
                local r_v7_1887 = (r_v11_1595 ~= "") and (r_v40_42.macro_leader_unit)
                local r_v6_1757 = r_v7_1887 or ("\224\185\132\224\184\161\224\185\136\224\185\132\224\184\148\224\185\137\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129 (None)")
                r_v1_1839:Refresh(r_v3_1260, r_v6_1757)
                r_v67_92("\224\184\173\224\184\177\224\184\155\224\185\128\224\184\148\224\184\149", "\224\184\148\224\184\182\224\184\135\224\184\163\224\184\178\224\184\162\224\184\138\224\184\183\224\185\136\224\184\173\224\184\149\224\184\177\224\184\167\224\184\165\224\184\176\224\184\132\224\184\163\224\184\136\224\184\178\224\184\129\224\184\161\224\184\178\224\185\130\224\184\132\224\184\163\224\184\170\224\184\179\224\185\128\224\184\163\224\185\135\224\184\136!", 3)
            else
                r_v67_92("\224\184\130\224\185\137\224\184\173\224\184\156\224\184\180\224\184\148\224\184\158\224\184\165\224\184\178\224\184\148", "\224\185\132\224\184\161\224\185\136\224\184\158\224\184\154\224\184\149\224\184\177\224\184\167\224\184\165\224\184\176\224\184\132\224\184\163\224\185\131\224\184\153\224\185\130\224\184\155\224\184\163\224\185\132\224\184\159\224\184\165\224\185\140\224\184\161\224\184\178\224\185\130\224\184\132\224\184\163\224\184\153\224\184\181\224\185\137", 3)
            end
        end)
        local r_v31_99 = function()
            local r_v1_1843 = task.spawn
            local r_v10_783 = function()
                local r_v10_1224 = r_v40_42.macro_profile
                r_v10_1224 = r_v40_43[r_v10_1224]
                local r_v2_1983 = not r_v10_1224
                local r_v4_3108 = r_v2_1983
                if not r_v2_1983 then
                    local r_v3_2069 = r_v10_1224.Units
                    r_v4_3108 = not r_v3_2069
                end
                if r_v4_3108 then
                    r_v67_92("Auto Equip", "\224\185\132\224\184\161\224\185\136\224\184\161\224\184\181\224\184\130\224\185\137\224\184\173\224\184\161\224\184\185\224\184\165\224\184\162\224\184\185\224\184\153\224\184\180\224\184\149\224\185\131\224\184\153\224\184\161\224\184\178\224\185\130\224\184\132\224\184\163\224\184\153\224\184\181\224\185\137!", 3)
                    return
                end
                local r_v2_1986 = r_v10_1224.Units
                r_v2_1986 = r_v33_30(r_v2_1986)
                if ((#r_v2_1986) == 0) then
                    r_v67_92("Auto Equip", "\224\185\130\224\184\155\224\184\163\224\185\132\224\184\159\224\184\165\224\185\140\224\184\161\224\184\178\224\185\130\224\184\132\224\184\163\224\184\153\224\184\181\224\185\137\224\184\162\224\184\177\224\184\135\224\185\132\224\184\161\224\185\136\224\184\161\224\184\181\224\184\149\224\184\177\224\184\167\224\184\165\224\184\176\224\184\132\224\184\163", 3)
                    return
                end
                local r_v5_2333 = function()
                    local r_v10_1279 = game.ReplicatedStorage
                    return r_v10_1279.Remotes.Server:InvokeServer("Data", "Units")
                end
                local r_v6_2718 = {
                    pcall(r_v5_2333)
                }
                local r_v3_2075 = r_v6_2718[2]
                r_v5_2333 = r_v6_2718[1]
                local r_v6_2719 = not r_v5_2333
                local r_v4_3115 = r_v6_2719
                if not r_v6_2719 then
                    local r_v7_2681 = type(r_v3_2075)
                    r_v4_3115 = r_v7_2681 ~= "table"
                end
                if r_v4_3115 then
                    r_v67_92("Auto Equip", "\224\184\148\224\184\182\224\184\135\224\184\130\224\185\137\224\184\173\224\184\161\224\184\185\224\184\165\224\184\129\224\184\163\224\184\176\224\185\128\224\184\155\224\185\139\224\184\178\224\185\132\224\184\161\224\185\136\224\184\170\224\184\179\224\185\128\224\184\163\224\185\135\224\184\136!", 3)
                    return
                end
                local r_v6_2722 = {}
                local r_v8_2870 = "macro_leader_unit"
                r_v8_2870 = r_v40_42[r_v8_2870]
                local r_v4_3118 = r_v8_2870 and ((r_v8_2870 ~= ("\224\185\132\224\184\161\224\185\136\224\185\132\224\184\148\224\185\137\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129 (None)")) and (table.find(r_v2_1986, r_v8_2870)))
                if r_v4_3118 then
                    local r_v4_3119 = table
                    r_v4_3119.insert(r_v6_2722, r_v8_2870)
                end
                local r_v4_3122, r_v7_2689, r_v9_2572 = ipairs(r_v2_1986)
                local r_v14_2363 = r_v4_3122
                for r_v11_2171, r_v13_2056 in r_v14_2363, r_v7_2689, r_v9_2572 do
                    if (r_v13_2056 ~= r_v8_2870) then
                        local r_v12_1801 = table
                        r_v12_1801.insert(r_v6_2722, r_v13_2056)
                    end
                end
                local r_v7_2690 = 0
                local r_v13_2057 = {
                    ipairs(r_v6_2722)
                }
                local r_v14_2364 = r_v13_2057[2]
                local r_v11_2172 = r_v13_2057[3]
                local r_v9_2574 = r_v13_2057[1]
                for r_v13_2057, r_v12_1803 in r_v9_2574, r_v14_2364, r_v11_2172 do
                    if (r_v13_2057 > 6) then
                        break
                    end
                    local r_v1_2738 = nil
                    local r_v1_2739 = pairs
                    for r_v19_743, r_v18_577 in r_v1_2739(r_v3_2075) do
                        local r_v21_521 = r_v18_577.Name
                        if r_v21_521 ~= r_v12_1803 then
                            continue
                        end
                        r_v1_2738 = r_v18_577
                        break
                    end
                    if r_v1_2738 then
                        pcall(function()
                            local r_v3_2164 = r_v1_2738.ID
                            local r_v7_2806 = r_v1_2738.Level
                            local r_v6_2838 = r_v7_2806 or 1
                            local r_v7_2808 = r_v1_2738.Name
                            local r_v10_1286 = {
                                ["ID"] = r_v3_2164,
                                ["Level"] = r_v6_2838,
                                ["Name"] = r_v7_2808
                            }
                            r_v10_1286 = r_v22_33:JSONEncode(r_v10_1286)
                            local r_v5_2440 = game:GetService("ReplicatedStorage")
                            r_v5_2440.Remotes.Server:InvokeServer("Equip", {
                                ["Stats"] = r_v10_1286
                            })
                        end)
                        local r_v16_1342 = r_v7_2690 + 1
                        task.wait(0.3)
                        r_v7_2690 = r_v16_1342
                    else
                        r_v67_92("Auto Equip", "\224\185\132\224\184\161\224\185\136\224\184\158\224\184\154\224\184\149\224\184\177\224\184\167\224\184\165\224\184\176\224\184\132\224\184\163: " .. r_v12_1803 .. " \224\185\131\224\184\153\224\184\129\224\184\163\224\184\176\224\185\128\224\184\155\224\185\139\224\184\178!", 3)
                    end
                end
                pcall(function()
                    local r_v2_2071 = game:GetService("ReplicatedStorage")
                    r_v2_2071.Remotes.Server:InvokeServer("Data", "Unit_Equip")
                end)
                if (r_v7_2690 > 0) then
                    r_v67_92("Auto Equip", "\224\184\136\224\184\177\224\184\148\224\184\151\224\184\181\224\184\161\224\185\128\224\184\170\224\184\163\224\185\135\224\184\136\224\184\170\224\184\180\224\185\137\224\184\153! \224\185\131\224\184\170\224\185\136\224\184\149\224\184\177\224\184\167\224\184\165\224\184\176\224\184\132\224\184\163\224\185\129\224\184\165\224\185\137\224\184\167 " .. (tostring(r_v7_2690)) .. " \224\184\149\224\184\177\224\184\167", 4)
                end
            end
            r_v1_1843(r_v10_783)
        end
        T_Macro:AddButton("\226\154\148\239\184\143 \224\184\136\224\184\177\224\184\148\224\184\151\224\184\181\224\184\161\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180 (Auto Equip)", r_v31_99)
        task.spawn(function()
            while true do
                local r_v1_1844 = task.wait
                if not (r_v1_1844(1)) then
                    break
                end
                if r_v28_159 then
                    local r_v10_787 = r_v40_42.macro_profile
                    r_v10_787 = r_v40_43[r_v10_787]
                    local r_v4_2090 = r_v10_787 and (r_v10_787.Units)
                    if r_v4_2090 then
                        local r_v2_1210 = r_v10_787.Units
                        r_v2_1210 = r_v33_30(r_v2_1210)
                        if ((#r_v2_1210) > 0) then
                            local r_v9_1871 = table.concat(r_v2_1210, "\n")
                            r_v28_159:Set({
                                ["Title"] = "\224\184\149\224\184\177\224\184\167\224\184\165\224\184\176\224\184\132\224\184\163\224\184\151\224\184\181\224\185\136\224\185\131\224\184\138\224\185\137\224\185\131\224\184\153\224\185\130\224\184\155\224\184\163\224\185\132\224\184\159\224\184\165\224\185\140\224\184\153\224\184\181\224\185\137:",
                                ["Content"] = r_v9_1871
                            })
                        else
                            r_v28_159:Set({
                                ["Title"] = "\224\184\149\224\184\177\224\184\167\224\184\165\224\184\176\224\184\132\224\184\163\224\184\151\224\184\181\224\185\136\224\185\131\224\184\138\224\185\137\224\185\131\224\184\153\224\185\130\224\184\155\224\184\163\224\185\132\224\184\159\224\184\165\224\185\140\224\184\153\224\184\181\224\185\137:",
                                ["Content"] = "\224\185\132\224\184\161\224\185\136\224\184\161\224\184\181 (\224\184\162\224\184\177\224\184\135\224\185\132\224\184\161\224\185\136\224\185\132\224\184\148\224\185\137\224\185\128\224\184\139\224\184\159\224\184\149\224\184\177\224\184\167\224\184\165\224\184\176\224\184\132\224\184\163\224\184\165\224\184\135\224\184\161\224\184\178\224\185\130\224\184\132\224\184\163)"
                            })
                        end
                    end
                end
            end
        end)
        T_Macro:AddLabel("\240\159\147\130 \224\184\136\224\184\177\224\184\148\224\184\129\224\184\178\224\184\163\224\185\132\224\184\159\224\184\165\224\185\140\224\185\130\224\184\155\224\184\163\224\185\132\224\184\159\224\184\165\224\185\140 (Profile Management)")
        local r_v28_170 = ""
        T_Macro:AddTextbox("\224\184\158\224\184\180\224\184\161\224\184\158\224\185\140\224\184\138\224\184\183\224\185\136\224\184\173\224\185\130\224\184\155\224\184\163\224\185\132\224\184\159\224\184\165\224\185\140\224\185\131\224\184\171\224\184\161\224\185\136\224\184\151\224\184\181\224\185\136\224\184\153\224\184\181\224\185\136...", function(r_v10_788)
            r_v28_170 = r_v10_788
            r_v10_788 = nil
        end)
        T_Macro:AddButton("\226\158\149 \224\184\170\224\184\163\224\185\137\224\184\178\224\184\135\224\185\130\224\184\155\224\184\163\224\185\132\224\184\159\224\184\165\224\185\140\224\185\131\224\184\171\224\184\161\224\185\136", function()
            if (string.match(r_v28_170, "[^%w%s%[%]%_]") ~= nil) then
                r_v67_92("\224\184\130\224\185\137\224\184\173\224\184\156\224\184\180\224\184\148\224\184\158\224\184\165\224\184\178\224\184\148", "\224\184\161\224\184\181\224\184\149\224\184\177\224\184\167\224\184\173\224\184\177\224\184\129\224\184\169\224\184\163\224\185\132\224\184\161\224\185\136\224\184\173\224\184\153\224\184\184\224\184\141\224\184\178\224\184\149!", 3)
                return
            end
            if (r_v40_43[r_v28_170] ~= nil) then
                r_v67_92("\224\184\130\224\185\137\224\184\173\224\184\156\224\184\180\224\184\148\224\184\158\224\184\165\224\184\178\224\184\148", "\224\184\138\224\184\183\224\185\136\224\184\173\224\184\139\224\185\137\224\184\179!", 3)
                return
            end
            r_v40_43[r_v28_170] = r_v31_24(r_v58_70)
            r_v40_42.macro_profile = r_v28_170
            Save()
            table.insert(r_v60_81, r_v28_170)
            table.sort(r_v60_81)
            local r_v2_1224 = r_v40_42.macro_profile
            r_v26_121:Refresh(r_v60_81, r_v2_1224)
            r_v67_92("\224\184\161\224\184\178\224\185\130\224\184\132\224\184\163", "\224\184\170\224\184\163\224\185\137\224\184\178\224\184\135\224\185\130\224\184\155\224\184\163\224\185\132\224\184\159\224\184\165\224\185\140: " .. r_v28_170 .. " \224\185\129\224\184\165\224\185\137\224\184\167", 3)
        end)
        T_Macro:AddButton("\240\159\151\145\239\184\143 \224\184\165\224\184\154\224\185\130\224\184\155\224\184\163\224\185\132\224\184\159\224\184\165\224\185\140\224\184\155\224\184\177\224\184\136\224\184\136\224\184\184\224\184\154\224\184\177\224\184\153", function()
            if ((#r_v60_81) <= 1) then
                r_v67_92("\224\184\130\224\185\137\224\184\173\224\184\156\224\184\180\224\184\148\224\184\158\224\184\165\224\184\178\224\184\148", "\224\185\132\224\184\161\224\185\136\224\184\170\224\184\178\224\184\161\224\184\178\224\184\163\224\184\150\224\184\165\224\184\154\224\185\130\224\184\155\224\184\163\224\185\132\224\184\159\224\184\165\224\185\140\224\184\170\224\184\184\224\184\148\224\184\151\224\185\137\224\184\178\224\184\162\224\185\132\224\184\148\224\185\137!", 3)
                return
            end
            local r_v10_809 = "macro_profile"
            r_v10_809 = r_v40_42[r_v10_809]
            local r_v5_1512 = "/" .. (r_v10_809 .. ".json")
            delfile(r_v60_70 .. r_v5_1512)
            r_v40_43[r_v10_809] = nil
            table.remove(r_v60_81, table.find(r_v60_81, r_v10_809))
            local r_v1_1869 = pairs
            for r_v6_1790, r_v8_1936 in r_v1_1869(r_v60_81) do
                if r_v8_1936 == nil then
                    continue
                end
                r_v40_42.macro_profile = r_v8_1936
                break
            end
            Save()
            local r_v5_1518 = r_v40_42.macro_profile
            r_v26_121:Refresh(r_v60_81, r_v5_1518)
            r_v67_92("\224\184\161\224\184\178\224\185\130\224\184\132\224\184\163", "\224\184\165\224\184\154\224\185\130\224\184\155\224\184\163\224\185\132\224\184\159\224\184\165\224\185\140 " .. r_v10_809 .. " \224\184\173\224\184\173\224\184\129\224\185\129\224\184\165\224\185\137\224\184\167", 3)
        end)
        T_Macro:AddButton("\226\154\160\239\184\143 \224\184\165\224\185\137\224\184\178\224\184\135\224\184\130\224\185\137\224\184\173\224\184\161\224\184\185\224\184\165\224\184\129\224\184\178\224\184\163\224\184\154\224\184\177\224\184\153\224\184\151\224\184\182\224\184\129\224\185\130\224\184\155\224\184\163\224\185\132\224\184\159\224\184\165\224\185\140\224\184\153\224\184\181\224\185\137\224\184\151\224\184\177\224\185\137\224\184\135\224\184\171\224\184\161\224\184\148", function()
            r_v40_43[r_v40_42.macro_profile] = r_v31_24(r_v58_70)
            o_v29_5 = nil
            Save()
            r_v67_92("\224\184\161\224\184\178\224\185\130\224\184\132\224\184\163", "\224\184\165\224\185\137\224\184\178\224\184\135\224\184\130\224\185\137\224\184\173\224\184\161\224\184\185\224\184\165\224\185\130\224\184\155\224\184\163\224\185\132\224\184\159\224\184\165\224\185\140\224\184\170\224\184\179\224\185\128\224\184\163\224\185\135\224\184\136", 3)
        end)
        T_Macro:AddLabel("\240\159\148\151 \224\184\153\224\184\179\224\185\128\224\184\130\224\185\137\224\184\178\224\185\130\224\184\155\224\184\163\224\185\132\224\184\159\224\184\165\224\185\140\224\184\136\224\184\178\224\184\129\224\184\165\224\184\180\224\185\137\224\184\135\224\184\129\224\185\140 (Import)")
        T_Macro:AddButton("\240\159\147\139 \224\184\132\224\184\177\224\184\148\224\184\165\224\184\173\224\184\129\224\184\161\224\184\178\224\185\130\224\184\132\224\184\163\224\184\155\224\184\177\224\184\136\224\184\136\224\184\184\224\184\154\224\184\177\224\184\153 (Copy to Clipboard)", function()
            local r_v1_1877 = r_v40_43[r_v40_42.macro_profile]
            if r_v1_1877 then
                local r_v3_1301 = function()
                    return (game:GetService("HttpService")):JSONEncode(r_v1_1877)
                end
                local r_v5_1526 = {
                    pcall(r_v3_1301)
                }
                local r_v2_1245 = r_v5_1526[2]
                r_v3_1301 = r_v5_1526[1]
                if (r_v3_1301 and r_v2_1245) then
                    local r_v1_1881 = false
                    pcall(function()
                        setclipboard(r_v2_1245)
                        r_v1_1881 = true
                    end)
                    if (not r_v1_1881) then
                        pcall(function()
                            toclipboard(r_v2_1245)
                            r_v1_1881 = true
                        end)
                    end
                    if r_v1_1881 then
                        r_v67_92("\224\184\170\224\184\179\224\185\128\224\184\163\224\185\135\224\184\136!", "\224\184\132\224\184\177\224\184\148\224\184\165\224\184\173\224\184\129\224\184\130\224\185\137\224\184\173\224\184\161\224\184\185\224\184\165\224\185\130\224\184\155\224\184\163\224\185\132\224\184\159\224\184\165\224\185\140 '" .. r_v40_42.macro_profile .. "' \224\184\165\224\184\135\224\184\132\224\184\165\224\184\180\224\184\155\224\184\154\224\184\173\224\184\163\224\185\140\224\184\148\224\185\128\224\184\163\224\184\181\224\184\162\224\184\154\224\184\163\224\185\137\224\184\173\224\184\162\224\185\129\224\184\165\224\185\137\224\184\167 \224\185\128\224\184\173\224\184\178\224\185\132\224\184\155 Ctrl+V \224\184\167\224\184\178\224\184\135\224\185\132\224\184\148\224\185\137\224\185\128\224\184\165\224\184\162!", 5)
                    else
                        r_v67_92("\224\184\130\224\185\137\224\184\173\224\184\156\224\184\180\224\184\148\224\184\158\224\184\165\224\184\178\224\184\148", "\224\184\149\224\184\177\224\184\167\224\184\163\224\184\177\224\184\153 (Executor) \224\184\130\224\184\173\224\184\135\224\184\132\224\184\184\224\184\147\224\185\132\224\184\161\224\185\136\224\184\163\224\184\173\224\184\135\224\184\163\224\184\177\224\184\154\224\184\159\224\184\177\224\184\135\224\184\129\224\185\140\224\184\138\224\184\177\224\184\153\224\184\132\224\184\177\224\184\148\224\184\165\224\184\173\224\184\129", 4)
                    end
                else
                    r_v67_92("\224\184\130\224\185\137\224\184\173\224\184\156\224\184\180\224\184\148\224\184\158\224\184\165\224\184\178\224\184\148", "\224\185\132\224\184\161\224\185\136\224\184\170\224\184\178\224\184\161\224\184\178\224\184\163\224\184\150\224\185\129\224\184\155\224\184\165\224\184\135\224\184\130\224\185\137\224\184\173\224\184\161\224\184\185\224\184\165\224\185\130\224\184\155\224\184\163\224\185\132\224\184\159\224\184\165\224\185\140\224\185\128\224\184\155\224\185\135\224\184\153\224\184\130\224\185\137\224\184\173\224\184\132\224\184\167\224\184\178\224\184\161\224\185\132\224\184\148\224\185\137", 4)
                end
            else
                r_v67_92("\224\184\130\224\185\137\224\184\173\224\184\156\224\184\180\224\184\148\224\184\158\224\184\165\224\184\178\224\184\148", "\224\185\132\224\184\161\224\185\136\224\184\158\224\184\154\224\184\130\224\185\137\224\184\173\224\184\161\224\184\185\224\184\165\224\185\131\224\184\153\224\185\130\224\184\155\224\184\163\224\185\132\224\184\159\224\184\165\224\185\140\224\184\155\224\184\177\224\184\136\224\184\136\224\184\184\224\184\154\224\184\177\224\184\153", 4)
            end
        end)
        T_Macro:AddButton("\240\159\147\165 \224\184\153\224\184\179\224\185\128\224\184\130\224\185\137\224\184\178\224\184\136\224\184\178\224\184\129\224\184\132\224\184\165\224\184\180\224\184\155\224\184\154\224\184\173\224\184\163\224\185\140\224\184\148 (Paste)", function()
            local r_v2_1251 = function()
                return getclipboard()
            end
            local r_v3_1304 = {
                pcall(r_v2_1251)
            }
            local r_v10_818 = r_v3_1304[2]
            r_v2_1251 = r_v3_1304[1]
            if ((not r_v2_1251) or ((not r_v10_818) or (r_v10_818 == ("")))) then
                r_v67_92("\224\184\130\224\185\137\224\184\173\224\184\156\224\184\180\224\184\148\224\184\158\224\184\165\224\184\178\224\184\148", "\224\184\132\224\184\165\224\184\180\224\184\155\224\184\154\224\184\173\224\184\163\224\185\140\224\184\148\224\184\167\224\185\136\224\184\178\224\184\135\224\185\128\224\184\155\224\184\165\224\185\136\224\184\178 \224\184\171\224\184\163\224\184\183\224\184\173\224\184\149\224\184\177\224\184\167\224\184\163\224\184\177\224\184\153\224\185\132\224\184\161\224\185\136\224\184\163\224\184\173\224\184\135\224\184\163\224\184\177\224\184\154", 4)
                return
            end
            local r_v5_1535 = function()
                return (game:GetService("HttpService")):JSONDecode(r_v10_818)
            end
            local r_v6_1813 = {
                pcall(r_v5_1535)
            }
            local r_v10_822 = r_v6_1813[2]
            r_v5_1535 = r_v6_1813[1]
            local r_v4_2148 = r_v5_1535
            if r_v5_1535 then
                local r_v7_1939 = type(r_v10_822)
                r_v4_2148 = r_v7_1939 == "table"
            end
            if r_v4_2148 then
                local r_v4_2149 = (r_v10_822.Macro) and (r_v10_822.Units)
                if r_v4_2149 then
                    local r_v8_1965 = tostring(6090)
                    local r_v6_1821 = "Imported_" .. r_v8_1965
                    r_v40_43[r_v6_1821] = r_v10_822
                    local r_v4_2152 = table.find
                    if (not r_v4_2152(r_v60_81, r_v6_1821)) then
                        table.insert(r_v60_81, r_v6_1821)
                    end
                    r_v40_42.macro_profile = r_v6_1821
                    table.sort(r_v60_81)
                    Save()
                    local r_v7_1952 = r_v40_42.macro_profile
                    r_v26_121:Refresh(r_v60_81, r_v7_1952)
                    r_v67_92("\224\184\170\224\184\179\224\185\128\224\184\163\224\185\135\224\184\136", "\224\184\153\224\184\179\224\185\128\224\184\130\224\185\137\224\184\178\224\185\130\224\184\155\224\184\163\224\185\132\224\184\159\224\184\165\224\185\140 " .. r_v6_1821 .. " \224\184\136\224\184\178\224\184\129\224\184\132\224\184\165\224\184\180\224\184\155\224\184\154\224\184\173\224\184\163\224\185\140\224\184\148\224\184\170\224\184\179\224\185\128\224\184\163\224\185\135\224\184\136!", 5)
                    return
                else
                    local r_v6_1822 = 0
                    local r_v1_1897 = pairs
                    for r_v14_1778, r_v11_1638 in r_v1_1897(r_v10_822) do
                        local r_v16_956 = type(r_v11_1638)
                        local r_v13_1538 = (r_v16_956 == "table") and ((r_v11_1638.Macro) and (r_v11_1638.Units))
                        if r_v13_1538 then
                            r_v40_43[r_v14_1778] = r_v11_1638
                            local r_v13_1547 = table.find
                            if (not r_v13_1547(r_v60_81, r_v14_1778)) then
                                table.insert(r_v60_81, r_v14_1778)
                            end
                            r_v40_42.macro_profile = r_v14_1778
                            r_v6_1822 = r_v6_1822 + 1
                        end
                    end
                    if (r_v6_1822 > 0) then
                        table.sort(r_v60_81)
                        Save()
                        local r_v14_1780 = r_v40_42.macro_profile
                        r_v26_121:Refresh(r_v60_81, r_v14_1780)
                        r_v67_92("\224\184\170\224\184\179\224\185\128\224\184\163\224\185\135\224\184\136", "\224\184\153\224\184\179\224\185\128\224\184\130\224\185\137\224\184\178\224\184\170\224\184\179\224\185\128\224\184\163\224\185\135\224\184\136 " .. r_v6_1822 .. " \224\185\130\224\184\155\224\184\163\224\185\132\224\184\159\224\184\165\224\185\140!", 5)
                    else
                        r_v67_92("\224\184\130\224\185\137\224\184\173\224\184\156\224\184\180\224\184\148\224\184\158\224\184\165\224\184\178\224\184\148", "\224\184\130\224\185\137\224\184\173\224\184\161\224\184\185\224\184\165\224\185\132\224\184\161\224\185\136\224\184\150\224\184\185\224\184\129\224\184\149\224\185\137\224\184\173\224\184\135", 5)
                    end
                end
            else
                r_v67_92("\224\184\130\224\185\137\224\184\173\224\184\156\224\184\180\224\184\148\224\184\158\224\184\165\224\184\178\224\184\148", "\224\184\163\224\184\185\224\184\155\224\185\129\224\184\154\224\184\154\224\185\131\224\184\153\224\184\132\224\184\165\224\184\180\224\184\155\224\184\154\224\184\173\224\184\163\224\185\140\224\184\148\224\185\132\224\184\161\224\185\136\224\185\131\224\184\138\224\185\136 JSON", 5)
            end
        end)
        local r_v28_178 = ""
        T_Macro:AddTextbox("\224\185\131\224\184\170\224\185\136\224\184\165\224\184\180\224\185\137\224\184\135\224\184\129\224\185\140 .json \224\184\151\224\184\181\224\185\136\224\184\153\224\184\181\224\185\136...", function(r_v10_823)
            r_v28_178 = r_v10_823
            r_v10_823 = nil
        end)
        T_Macro:AddButton("\226\172\135\239\184\143 \224\184\153\224\184\179\224\185\128\224\184\130\224\185\137\224\184\178\224\185\130\224\184\155\224\184\163\224\185\132\224\184\159\224\184\165\224\185\140\224\184\136\224\184\178\224\184\129\224\184\165\224\184\180\224\185\137\224\184\135\224\184\129\224\185\140", function()
            if (r_v28_178 == "") then
                r_v67_92("\224\184\130\224\185\137\224\184\173\224\184\156\224\184\180\224\184\148\224\184\158\224\184\165\224\184\178\224\184\148", "\224\185\130\224\184\155\224\184\163\224\184\148\224\185\131\224\184\170\224\185\136\224\184\165\224\184\180\224\185\137\224\184\135\224\184\129\224\185\140\224\184\129\224\185\136\224\184\173\224\184\153!", 3)
                return
            end
            local r_v2_1255 = function()
                return game:HttpGet(r_v28_178)
            end
            local r_v4_2169, r_v10_826 = pcall(r_v2_1255)
            r_v2_1255 = r_v4_2169
            if r_v2_1255 then
                local r_v5_1539 = function()
                    return (game:GetService("HttpService")):JSONDecode(r_v10_826)
                end
                local r_v6_1826 = {
                    pcall(r_v5_1539)
                }
                local r_v10_827 = r_v6_1826[2]
                r_v5_1539 = r_v6_1826[1]
                local r_v4_2172 = r_v5_1539
                if r_v5_1539 then
                    local r_v7_1970 = type(r_v10_827)
                    r_v4_2172 = r_v7_1970 == "table"
                end
                if r_v4_2172 then
                    local r_v4_2173 = (r_v10_827.Macro) and (r_v10_827.Units)
                    if r_v4_2173 then
                        local r_v8_1997 = tostring(6090)
                        local r_v6_1834 = "Imported_" .. r_v8_1997
                        r_v40_43[r_v6_1834] = r_v10_827
                        local r_v4_2176 = table.find
                        if (not r_v4_2176(r_v60_81, r_v6_1834)) then
                            table.insert(r_v60_81, r_v6_1834)
                        end
                        r_v40_42.macro_profile = r_v6_1834
                        table.sort(r_v60_81)
                        Save()
                        local r_v7_1983 = r_v40_42.macro_profile
                        r_v26_121:Refresh(r_v60_81, r_v7_1983)
                        r_v67_92("\224\184\170\224\184\179\224\185\128\224\184\163\224\185\135\224\184\136", "\224\184\153\224\184\179\224\185\128\224\184\130\224\185\137\224\184\178\224\185\130\224\184\155\224\184\163\224\185\132\224\184\159\224\184\165\224\185\140 " .. r_v6_1834 .. " \224\184\170\224\184\179\224\185\128\224\184\163\224\185\135\224\184\136!", 5)
                        return
                    else
                        local r_v6_1835 = 0
                        local r_v4_2178, r_v8_2000, r_v7_1979 = pairs(r_v10_827)
                        local r_v9_1938 = r_v4_2178
                        for r_v14_1805, r_v11_1664 in r_v9_1938, r_v8_2000, r_v7_1979 do
                            local r_v16_970 = type(r_v11_1664)
                            local r_v13_1566 = (r_v16_970 == "table") and ((r_v11_1664.Macro) and (r_v11_1664.Units))
                            if r_v13_1566 then
                                r_v40_43[r_v14_1805] = r_v11_1664
                                local r_v13_1575 = table.find
                                if (not r_v13_1575(r_v60_81, r_v14_1805)) then
                                    table.insert(r_v60_81, r_v14_1805)
                                end
                                r_v40_42.macro_profile = r_v14_1805
                                r_v6_1835 = r_v6_1835 + 1
                            end
                        end
                        if (r_v6_1835 > 0) then
                            table.sort(r_v60_81)
                            Save()
                            local r_v14_1807 = r_v40_42.macro_profile
                            r_v26_121:Refresh(r_v60_81, r_v14_1807)
                            r_v67_92("\224\184\170\224\184\179\224\185\128\224\184\163\224\185\135\224\184\136", "\224\184\153\224\184\179\224\185\128\224\184\130\224\185\137\224\184\178\224\184\170\224\184\179\224\185\128\224\184\163\224\185\135\224\184\136 " .. r_v6_1835 .. " \224\185\130\224\184\155\224\184\163\224\185\132\224\184\159\224\184\165\224\185\140!", 5)
                        else
                            r_v67_92("\224\184\130\224\185\137\224\184\173\224\184\156\224\184\180\224\184\148\224\184\158\224\184\165\224\184\178\224\184\148", "\224\185\132\224\184\161\224\185\136\224\184\158\224\184\154\224\185\130\224\184\132\224\184\163\224\184\135\224\184\170\224\184\163\224\185\137\224\184\178\224\184\135\224\185\130\224\184\155\224\184\163\224\185\132\224\184\159\224\184\165\224\185\140\224\184\161\224\184\178\224\185\130\224\184\132\224\184\163\224\185\131\224\184\153\224\184\165\224\184\180\224\185\137\224\184\135\224\184\129\224\185\140\224\184\153\224\184\181\224\185\137", 5)
                        end
                    end
                else
                    r_v67_92("\224\184\130\224\185\137\224\184\173\224\184\156\224\184\180\224\184\148\224\184\158\224\184\165\224\184\178\224\184\148", "\224\184\163\224\184\185\224\184\155\224\185\129\224\184\154\224\184\154\224\184\130\224\185\137\224\184\173\224\184\161\224\184\185\224\184\165 (JSON) \224\185\132\224\184\161\224\185\136\224\184\150\224\184\185\224\184\129\224\184\149\224\185\137\224\184\173\224\184\135!", 5)
                end
            else
                r_v67_92("\224\184\130\224\185\137\224\184\173\224\184\156\224\184\180\224\184\148\224\184\158\224\184\165\224\184\178\224\184\148", "\224\185\132\224\184\161\224\185\136\224\184\170\224\184\178\224\184\161\224\184\178\224\184\163\224\184\150\224\184\148\224\184\178\224\184\167\224\184\153\224\185\140\224\185\130\224\184\171\224\184\165\224\184\148\224\184\130\224\185\137\224\184\173\224\184\161\224\184\185\224\184\165\224\184\136\224\184\178\224\184\129\224\184\165\224\184\180\224\185\137\224\184\135\224\184\129\224\185\140\224\185\132\224\184\148\224\185\137", 5)
            end
        end)
        T_Macro:AddLabel("\226\154\153\239\184\143 \224\184\149\224\184\177\224\185\137\224\184\135\224\184\132\224\185\136\224\184\178\224\184\132\224\184\167\224\184\178\224\184\161\224\185\129\224\184\161\224\185\136\224\184\153\224\184\162\224\184\179 (Precision Settings)")
        local r_v28_182 = T_Macro
        local r_v37_89 = r_v40_42.macro_record_time_offset
        r_v28_182:AddSlider("\224\185\128\224\184\158\224\184\180\224\185\136\224\184\161/\224\184\165\224\184\148 \224\185\128\224\184\167\224\184\165\224\184\178\224\184\154\224\184\177\224\184\153\224\184\151\224\184\182\224\184\129 (\224\184\167\224\184\180\224\184\153\224\184\178\224\184\151\224\184\181)", (-10), 10, r_v37_89, function(r_v10_829)
            r_v40_42.macro_record_time_offset = r_v10_829
            Save()
            r_v10_829 = nil
        end)
        local r_v28_183 = T_Macro
        local r_v37_91 = r_v40_42.macro_playback_time_offset
        r_v28_183:AddSlider("\224\185\128\224\184\158\224\184\180\224\185\136\224\184\161/\224\184\165\224\184\148 \224\185\128\224\184\167\224\184\165\224\184\178\224\185\128\224\184\165\224\185\136\224\184\153 (\224\184\167\224\184\180\224\184\153\224\184\178\224\184\151\224\184\181)", (-10), 10, r_v37_91, function(r_v10_830)
            r_v40_42.macro_playback_time_offset = r_v10_830
            Save()
            r_v10_830 = nil
        end)
        local r_v28_184 = T_Macro
        local r_v37_93 = r_v40_42.macro_magnitude
        r_v28_184:AddSlider("\224\184\163\224\184\176\224\184\162\224\184\176\224\184\132\224\184\165\224\184\178\224\184\148\224\185\128\224\184\132\224\184\165\224\184\183\224\185\136\224\184\173\224\184\153\224\184\129\224\184\178\224\184\163\224\184\167\224\184\178\224\184\135 (Magnitude)", 0, 5, r_v37_93, function(r_v10_831)
            r_v40_42.macro_magnitude = r_v10_831
            Save()
            r_v10_831 = nil
        end)
        local r_v28_185 = T_Macro
        local r_v33_103 = r_v40_42.macro_money_tracking
        r_v28_185:AddToggle("\224\185\128\224\184\138\224\185\135\224\184\132\224\185\128\224\184\135\224\184\180\224\184\153\224\185\131\224\184\171\224\185\137\224\184\158\224\184\173\224\184\129\224\185\136\224\184\173\224\184\153\224\184\163\224\184\177\224\184\153", "\224\184\149\224\184\163\224\184\167\224\184\136\224\184\170\224\184\173\224\184\154\224\184\136\224\184\179\224\184\153\224\184\167\224\184\153\224\185\128\224\184\135\224\184\180\224\184\153\224\185\131\224\184\153\224\185\128\224\184\129\224\184\161\224\185\128\224\184\170\224\184\161\224\184\173", r_v33_103, function(r_v10_832)
            r_v40_42.macro_money_tracking = r_v10_832
            Save()
            r_v10_832 = nil
        end)
        local r_v31_142 = T_Macro:AddDropdown("\224\185\130\224\184\171\224\184\161\224\184\148\224\184\136\224\184\177\224\184\154\224\185\128\224\184\167\224\184\165\224\184\178", {
            "\224\185\128\224\184\167\224\184\165\224\184\178\224\184\149\224\184\178\224\184\161\224\185\128\224\184\167\224\184\159(\224\185\129\224\184\153\224\184\176\224\184\153\224\184\179)",
            "\224\184\149\224\184\178\224\184\161\224\185\128\224\184\167\224\184\165\224\184\178\224\185\128\224\184\139\224\184\180\224\184\159\224\185\128\224\184\167\224\184\173\224\184\163\224\185\140",
            "\224\185\128\224\184\167\224\184\165\224\184\178+\224\184\163\224\184\173\224\185\128\224\184\167\224\184\159 (\224\185\129\224\184\161\224\185\136\224\184\153\224\184\162\224\184\179\224\184\170\224\184\185\224\184\135)"
        }, function(r_v10_833)
            r_v40_42.macro_timer_version = r_v10_833
            Save()
            r_v10_833 = nil
        end)
        local r_v34_113 = (r_v40_42.macro_timer_version) or ("\224\185\128\224\184\167\224\184\165\224\184\178\224\184\149\224\184\178\224\184\161\224\185\128\224\184\167\224\184\159(\224\185\129\224\184\153\224\184\176\224\184\153\224\184\179)")
        r_v31_142:Set(r_v34_113)
        T_Macro:AddLabel("\240\159\164\150 \224\184\163\224\184\176\224\184\154\224\184\154\224\184\138\224\185\136\224\184\167\224\184\162\224\185\128\224\184\171\224\184\165\224\184\183\224\184\173\224\184\130\224\184\147\224\184\176\224\185\128\224\184\165\224\185\136\224\184\153\224\184\161\224\184\178\224\185\130\224\184\132\224\184\163 (Auto Actions)")
        local r_v28_191 = T_Macro
        local r_v33_112 = r_v40_42.macro_summon
        r_v28_191:AddToggle("\224\184\167\224\184\178\224\184\135\224\184\162\224\184\185\224\184\153\224\184\180\224\184\149 (Summon)", "\224\184\173\224\184\153\224\184\184\224\184\141\224\184\178\224\184\149\224\185\131\224\184\171\224\185\137\224\184\161\224\184\178\224\185\130\224\184\132\224\184\163\224\184\167\224\184\178\224\184\135\224\184\162\224\184\185\224\184\153\224\184\180\224\184\149", r_v33_112, function(r_v10_834)
            r_v40_42.macro_summon = r_v10_834
            Save()
            r_v10_834 = nil
        end)
        local r_v28_192 = T_Macro
        local r_v33_115 = r_v40_42.macro_sell
        r_v28_192:AddToggle("\224\184\130\224\184\178\224\184\162\224\184\162\224\184\185\224\184\153\224\184\180\224\184\149 (Sell)", "\224\184\173\224\184\153\224\184\184\224\184\141\224\184\178\224\184\149\224\185\131\224\184\171\224\185\137\224\184\161\224\184\178\224\185\130\224\184\132\224\184\163\224\184\130\224\184\178\224\184\162\224\184\162\224\184\185\224\184\153\224\184\180\224\184\149", r_v33_115, function(r_v10_835)
            r_v40_42.macro_sell = r_v10_835
            Save()
            r_v10_835 = nil
        end)
        local r_v28_193 = T_Macro
        local r_v33_118 = r_v40_42.macro_upgrade
        r_v28_193:AddToggle("\224\184\173\224\184\177\224\184\155\224\185\128\224\184\129\224\184\163\224\184\148\224\184\162\224\184\185\224\184\153\224\184\180\224\184\149 (Upgrade)", "\224\184\173\224\184\153\224\184\184\224\184\141\224\184\178\224\184\149\224\185\131\224\184\171\224\185\137\224\184\161\224\184\178\224\185\130\224\184\132\224\184\163\224\184\173\224\184\177\224\184\155\224\185\128\224\184\129\224\184\163\224\184\148", r_v33_118, function(r_v10_836)
            r_v40_42.macro_upgrade = r_v10_836
            Save()
            r_v10_836 = nil
        end)
        local r_v28_194 = T_Macro
        local r_v33_121 = r_v40_42.macro_ability
        r_v28_194:AddToggle("\224\185\131\224\184\138\224\185\137\224\184\135\224\184\178\224\184\153\224\184\170\224\184\129\224\184\180\224\184\165\224\184\162\224\184\185\224\184\153\224\184\180\224\184\149 (Ability)", "\224\184\173\224\184\153\224\184\184\224\184\141\224\184\178\224\184\149\224\185\131\224\184\171\224\185\137\224\184\161\224\184\178\224\185\130\224\184\132\224\184\163\224\184\129\224\184\148\224\184\170\224\184\129\224\184\180\224\184\165", r_v33_121, function(r_v10_837)
            r_v40_42.macro_ability = r_v10_837
            Save()
            r_v10_837 = nil
        end)
        local r_v28_195 = T_Macro
        local r_v33_124 = r_v40_42.macro_skipwave
        r_v28_195:AddToggle("\224\184\130\224\185\137\224\184\178\224\184\161\224\185\128\224\184\167\224\184\159\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180 (Skip Wave)", "\224\185\131\224\184\171\224\185\137\224\184\161\224\184\178\224\185\130\224\184\132\224\184\163\224\184\129\224\184\148\224\184\130\224\185\137\224\184\178\224\184\161\224\185\128\224\184\167\224\184\159\224\185\131\224\184\171\224\185\137", r_v33_124, function(r_v10_838)
            r_v40_42.macro_skipwave = r_v10_838
            Save()
            r_v10_838 = nil
        end)
        T_Gauntlet:AddLabel("\240\159\142\175 \224\184\163\224\184\176\224\184\154\224\184\154\224\184\149\224\184\177\224\184\148\224\184\136\224\184\154 Gauntlet (Auto G Limit)")
        local r_v28_197 = T_Gauntlet
        local r_v33_128 = r_v40_42.auto_stop_g_enable
        r_v28_197:AddToggle("\224\184\155\224\184\180\224\184\148\224\185\128\224\184\129\224\184\161\224\185\128\224\184\161\224\184\183\224\185\136\224\184\173 G \224\184\132\224\184\163\224\184\154", "\224\185\128\224\184\161\224\184\183\224\185\136\224\184\173 Gauntlet Tokens \224\184\150\224\184\182\224\184\135\224\184\162\224\184\173\224\184\148 \224\184\136\224\184\176\224\185\128\224\184\149\224\184\176\224\184\173\224\184\173\224\184\129\224\185\128\224\184\129\224\184\161\224\184\151\224\184\177\224\184\153\224\184\151\224\184\181", r_v33_128, function(r_v10_839)
            r_v40_42.auto_stop_g_enable = r_v10_839
            Save()
            if r_v10_839 then
                task.spawn(AutoGauntletStop)
            end
            r_v10_839 = nil
        end)
        local r_v31_178 = T_Gauntlet:AddTextbox("\224\184\136\224\184\179\224\184\153\224\184\167\224\184\153 G \224\184\151\224\184\181\224\185\136\224\184\149\224\185\137\224\184\173\224\184\135\224\184\129\224\184\178\224\184\163 (\224\185\128\224\184\138\224\185\136\224\184\153 155)", function(r_v10_840)
            local r_v6_1850 = tonumber(r_v10_840)
            r_v40_42.auto_stop_g_target = r_v6_1850 or 155
            Save()
            r_v10_840 = nil
        end)
        local r_v34_124 = tostring
        local r_v39_123 = r_v40_42.auto_stop_g_target
        local r_v33_130 = r_v39_123 or 155
        r_v31_178:Set(r_v34_124(r_v33_130))
        T_Gauntlet:AddLabel("\240\159\143\170 \224\184\163\224\185\137\224\184\178\224\184\153\224\184\132\224\185\137\224\184\178 G (Shop)")
        T_Gauntlet:AddButton("\240\159\143\170 \224\184\167\224\184\178\224\184\163\224\185\140\224\184\155\224\185\132\224\184\155\224\184\163\224\185\137\224\184\178\224\184\153 G (\224\185\128\224\184\137\224\184\158\224\184\178\224\184\176\224\185\130\224\184\165\224\184\129 2)", function()
            if (r_v69_100() == 2) then
                local r_v1_1957 = r_v22_34.Character.HumanoidRootPart
                r_v1_1957.CFrame = CFrame.new((-2419.149409999999989), 5366.811520000000201, (-150.874877999999995), (-0.715285718), 0, 0.698832154, 0, 1, 0, (-0.698832154), 0, (-0.715285718))
            else
                r_v67_92("\224\184\130\224\185\137\224\184\173\224\184\156\224\184\180\224\184\148\224\184\158\224\184\165\224\184\178\224\184\148", "\224\184\167\224\184\178\224\184\163\224\185\140\224\184\155\224\184\163\224\185\137\224\184\178\224\184\153\224\184\132\224\185\137\224\184\178 G \224\185\131\224\184\138\224\185\137\224\185\132\224\184\148\224\185\137\224\185\131\224\184\153\224\185\130\224\184\165\224\184\129 2 \224\185\128\224\184\151\224\185\136\224\184\178\224\184\153\224\184\177\224\185\137\224\184\153!", 3)
            end
        end)
        T_Gauntlet:AddLabel("\226\156\168 \224\184\139\224\184\183\224\185\137\224\184\173\224\184\130\224\184\173\224\184\135\224\185\129\224\184\165\224\184\176\224\184\173\224\184\181\224\185\130\224\184\167 (G Shop & Crafting)")
        ShopItemsMap = {
            ["[Dazai] Unhuman"] = "BuyDazai",
            ["[Dazai] Mysterious Necklace"] = "BuyDazai2",
            ["[Dazai] Book of ending"] = "BuyDazai3",
            ["[Aizen] Aizen 5"] = "BuyAizenGauntlet",
            ["[Aizen] Ultra token"] = "BuyUltraGauntlet",
            ["Envy orb"] = "BuyEnvyGaunts",
            ["Darkness token"] = "BuyDarknessGauntlet",
            ["Boros token"] = "BuyBorosGauntlet",
            ["Shadow girl"] = "BuyShadowGirl"
        }
        ShopItemsList = {
            "[Dazai] Unhuman",
            "[Dazai] Mysterious Necklace",
            "[Dazai] Book of ending",
            "[Aizen] Aizen 5",
            "[Aizen] Ultra token",
            "Envy orb",
            "Darkness token",
            "Boros token",
            "Shadow girl"
        }
        local r_v37_144 = ShopItemsList
        local r_v32_128 = T_Gauntlet:AddDropdown("\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129\224\185\132\224\184\173\224\185\128\224\184\151\224\184\161\224\184\151\224\184\181\224\185\136\224\184\136\224\184\176\224\184\139\224\184\183\224\185\137\224\184\173", r_v37_144, function(r_v10_847)
            r_v40_42.g_shop_item = r_v10_847
            Save()
            r_v10_847 = nil
        end)
        local r_v33_142 = (r_v40_42.g_shop_item) or ("[Dazai] Unhuman")
        r_v32_128:Set(r_v33_142)
        local r_v32_132 = T_Gauntlet:AddTextbox("\224\184\136\224\184\179\224\184\153\224\184\167\224\184\153\224\184\151\224\184\181\224\185\136\224\184\149\224\185\137\224\184\173\224\184\135\224\184\129\224\184\178\224\184\163\224\184\139\224\184\183\224\185\137\224\184\173 (\224\185\131\224\184\170\224\185\136\224\184\149\224\184\177\224\184\167\224\185\128\224\184\165\224\184\130)", function(r_v10_848)
            local r_v6_1861 = tonumber(r_v10_848)
            r_v40_42.g_shop_amount = r_v6_1861 or 1
            Save()
            r_v10_848 = nil
        end)
        local r_v33_145 = tostring
        local r_v40_127 = r_v40_42.g_shop_amount
        local r_v39_144 = r_v40_127 or 1
        r_v32_132:Set(r_v33_145(r_v39_144))
        T_Gauntlet:AddButton("\240\159\155\146 \224\184\162\224\184\183\224\184\153\224\184\162\224\184\177\224\184\153\224\184\129\224\184\178\224\184\163\224\184\139\224\184\183\224\185\137\224\184\173 (Buy Item)", function()
            local r_v10_850 = (r_v40_42.g_shop_item) or ("[Dazai] Unhuman")
            local r_v1_1962 = ShopItemsMap[r_v10_850]
            local r_v3_1342 = r_v40_42.g_shop_amount
            local r_v4_2239 = r_v3_1342 or 1
            if r_v1_1962 then
                task.spawn(function()
                    local r_v8_2876 = " \224\184\136\224\184\179\224\184\153\224\184\167\224\184\153 " .. (r_v4_2239 .. " \224\184\138\224\184\180\224\185\137\224\184\153...")
                    r_v67_92("\224\184\163\224\184\176\224\184\154\224\184\154\224\184\163\224\185\137\224\184\178\224\184\153\224\184\132\224\185\137\224\184\178", "\224\184\129\224\184\179\224\184\165\224\184\177\224\184\135\224\185\128\224\184\163\224\184\180\224\185\136\224\184\161\224\184\139\224\184\183\224\185\137\224\184\173 " .. r_v10_850 .. r_v8_2876, 3)
                    local r_v1_2758 = (game:GetService("ReplicatedStorage")):WaitForChild("Remotes")
                    local r_v10_1237 = "Input"
                    r_v10_1237 = r_v1_2758:WaitForChild(r_v10_1237)
                    local r_v3_2085 = r_v4_2239
                    for r_v8_2884 = 1, r_v3_2085 do
                        r_v10_1237:FireServer(r_v1_1962)
                        task.wait(0.3)
                    end
                    local r_v7_2698 = " \224\184\132\224\184\163\224\184\154 " .. (r_v4_2239 .. " \224\184\138\224\184\180\224\185\137\224\184\153\224\185\128\224\184\163\224\184\181\224\184\162\224\184\154\224\184\163\224\185\137\224\184\173\224\184\162\224\185\129\224\184\165\224\185\137\224\184\167!")
                    r_v67_92("\224\184\170\224\184\179\224\185\128\224\184\163\224\185\135\224\184\136!", "\224\184\139\224\184\183\224\185\137\224\184\173 " .. r_v10_850 .. r_v7_2698, 4)
                end)
            else
                r_v67_92("\224\184\130\224\185\137\224\184\173\224\184\156\224\184\180\224\184\148\224\184\158\224\184\165\224\184\178\224\184\148", "\224\185\132\224\184\161\224\185\136\224\184\158\224\184\154\224\184\130\224\185\137\224\184\173\224\184\161\224\184\185\224\184\165\224\185\132\224\184\173\224\185\128\224\184\151\224\184\161\224\184\153\224\184\181\224\185\137", 3)
            end
        end)
        T_Gauntlet:AddLabel("\240\159\167\188 \224\184\173\224\184\173\224\185\130\224\184\149\224\185\137\224\184\165\224\185\137\224\184\178\224\184\135\224\184\161\224\184\173\224\184\153\224\184\170\224\185\128\224\184\149\224\184\173\224\184\163\224\185\140\224\184\158\224\184\180\224\185\128\224\184\168\224\184\169 (Decelerate/Cloner)")
        local r_v34_142 = T_Gauntlet
        local r_v39_149 = r_v40_42.auto_cleanse_enable
        r_v34_142:AddToggle("\224\185\128\224\184\155\224\184\180\224\184\148\224\184\173\224\184\173\224\185\130\224\184\149\224\185\137\224\184\129\224\184\148\224\184\170\224\184\129\224\184\180\224\184\165\224\184\165\224\185\137\224\184\178\224\184\135\224\184\161\224\184\173\224\184\153", "\224\185\129\224\184\162\224\184\129\224\184\159\224\184\177\224\184\135\224\184\129\224\185\140\224\184\138\224\184\177\224\184\153\224\184\173\224\184\180\224\184\170\224\184\163\224\184\176\224\184\136\224\184\178\224\184\129 Auto Boss", r_v39_149, function(r_v10_853)
            r_v40_42.auto_cleanse_enable = r_v10_853
            Save()
            if r_v10_853 then
                task.spawn(AutoCleanseLoop)
            end
            r_v10_853 = nil
        end)
        local r_v32_148 = T_Gauntlet:AddDropdown("\224\185\128\224\184\135\224\184\183\224\185\136\224\184\173\224\184\153\224\185\132\224\184\130\224\184\129\224\184\178\224\184\163\224\184\129\224\184\148\224\184\165\224\185\137\224\184\178\224\184\135", {
            "\224\185\128\224\184\161\224\184\183\224\185\136\224\184\173\224\184\161\224\184\173\224\184\153\224\185\128\224\184\129\224\184\180\224\184\148",
            "\224\185\128\224\184\161\224\184\183\224\185\136\224\184\173\224\184\161\224\184\173\224\184\153\224\185\128\224\184\130\224\185\137\224\184\178\224\184\167\224\184\135"
        }, function(r_v10_854)
            r_v40_42.auto_cleanse_condition = r_v10_854
            Save()
            r_v10_854 = nil
        end)
        local r_v33_150 = (r_v40_42.auto_cleanse_condition) or ("\224\185\128\224\184\161\224\184\183\224\185\136\224\184\173\224\184\161\224\184\173\224\184\153\224\185\128\224\184\129\224\184\180\224\184\148")
        r_v32_148:Set(r_v33_150)
        local r_v34_147 = T_Gauntlet
        local r_v42_114 = r_v40_42
        local r_v40_140 = function(r_v10_855)
            r_v40_42.auto_cleanse_count = r_v10_855
            Save()
            r_v10_855 = nil
        end
        local r_v43_114 = r_v42_114.auto_cleanse_count
        local r_v41_138 = r_v43_114 or 1
        r_v34_147:AddSlider("\224\184\136\224\184\179\224\184\153\224\184\167\224\184\153\224\184\161\224\184\173\224\184\153\224\185\128\224\184\155\224\185\137\224\184\178\224\184\171\224\184\161\224\184\178\224\184\162\224\184\129\224\185\136\224\184\173\224\184\153\224\184\165\224\185\137\224\184\178\224\184\135", 1, 10, r_v41_138, r_v40_140)
        local r_v32_156 = T_Gauntlet:AddDropdown("\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129\224\184\155\224\184\163\224\184\176\224\185\128\224\184\160\224\184\151\224\184\161\224\184\173\224\184\153\224\184\170\224\185\128\224\184\149\224\184\173\224\184\163\224\185\140\224\185\128\224\184\155\224\185\137\224\184\178\224\184\171\224\184\161\224\184\178\224\184\162", {
            "\224\184\151\224\184\177\224\185\137\224\184\135\224\184\171\224\184\161\224\184\148 (All)",
            "Decelerate",
            "Cloner"
        }, function(r_v10_856)
            r_v40_42.auto_cleanse_class = r_v10_856
            Save()
            r_v10_856 = nil
        end)
        local r_v33_153 = (r_v40_42.auto_cleanse_class) or ("\224\184\151\224\184\177\224\185\137\224\184\135\224\184\171\224\184\161\224\184\148 (All)")
        r_v32_156:Set(r_v33_153)
        CleanseUnitDrop = T_Gauntlet:AddDropdown("\224\184\162\224\184\185\224\184\153\224\184\180\224\184\149\224\184\151\224\184\181\224\185\136\224\185\131\224\184\138\224\185\137\224\184\170\224\184\129\224\184\180\224\184\165\224\184\165\224\185\137\224\184\178\224\184\135", {
            "\224\184\151\224\184\184\224\184\129\224\184\149\224\184\177\224\184\167 (All)",
            "\224\185\132\224\184\161\224\185\136\224\185\132\224\184\148\224\185\137\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129 (None)"
        }, function(r_v10_857)
            r_v40_42.auto_cleanse_unit = r_v10_857
            Save()
            r_v10_857 = nil
        end)
        local r_v34_154 = CleanseUnitDrop
        local r_v37_166 = (r_v40_42.auto_cleanse_unit) or ("\224\184\151\224\184\184\224\184\129\224\184\149\224\184\177\224\184\167 (All)")
        r_v34_154:Set(r_v37_166)
        T_Gauntlet:AddButton("\240\159\148\132 \224\185\130\224\184\171\224\184\165\224\184\148\224\184\163\224\184\178\224\184\162\224\184\138\224\184\183\224\185\136\224\184\173\224\184\149\224\184\177\224\184\167\224\184\165\224\184\176\224\184\132\224\184\163\224\184\136\224\184\178\224\184\129\224\184\170\224\184\165\224\185\135\224\184\173\224\184\149", function()
            local r_v10_858 = GetEquippedUnitsSlots()
            local r_v2_1317 = r_v2_3
            r_v2_1317 = {
                "\224\184\151\224\184\184\224\184\129\224\184\149\224\184\177\224\184\167 (All)"
            }
            local r_v4_2264, r_v3_1354, r_v5_1581 = pairs(r_v10_858)
            local r_v6_1877 = r_v4_2264
            for r_v8_2051, r_v7_2008 in r_v6_1877, r_v3_1354, r_v5_1581 do
                if (r_v7_2008 ~= "\224\185\132\224\184\161\224\185\136\224\185\132\224\184\148\224\185\137\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129 (None)") then
                    local r_v9_1961 = table
                    r_v9_1961.insert(r_v2_1317, r_v7_2008)
                end
            end
            local r_v1_1978 = CleanseUnitDrop
            local r_v14_1818 = r_v40_42.auto_cleanse_unit
            local r_v8_2052 = (r_v14_1818 ~= "") and (r_v40_42.auto_cleanse_unit)
            local r_v5_1582 = r_v8_2052 or ("\224\184\151\224\184\184\224\184\129\224\184\149\224\184\177\224\184\167 (All)")
            r_v1_1978:Refresh(r_v2_1317, r_v5_1582)
            r_v67_92("\224\184\173\224\184\177\224\184\155\224\185\128\224\184\148\224\184\149", "\224\185\130\224\184\171\224\184\165\224\184\148\224\184\163\224\184\178\224\184\162\224\184\138\224\184\183\224\185\136\224\184\173\224\184\149\224\184\177\224\184\167\224\184\165\224\184\176\224\184\132\224\184\163\224\184\170\224\184\179\224\184\171\224\184\163\224\184\177\224\184\154\224\184\165\224\185\137\224\184\178\224\184\135\224\184\170\224\184\150\224\184\178\224\184\153\224\184\176\224\184\170\224\184\179\224\185\128\224\184\163\224\185\135\224\184\136!", 3)
        end)
        local r_v33_166 = T_Gauntlet:AddDropdown("\224\184\155\224\184\163\224\184\176\224\185\128\224\184\160\224\184\151\224\184\170\224\184\129\224\184\180\224\184\165\224\184\151\224\184\181\224\185\136\224\185\131\224\184\138\224\185\137\224\184\165\224\185\137\224\184\178\224\184\135", {
            "Normal",
            "Multiple (\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129\224\184\138\224\185\136\224\184\173\224\184\135\224\184\170\224\184\129\224\184\180\224\184\165)"
        }, function(r_v10_859)
            r_v40_42.auto_cleanse_skill_mode = r_v10_859
            Save()
            r_v10_859 = nil
        end)
        local r_v37_169 = (r_v40_42.auto_cleanse_skill_mode) or ("Normal")
        r_v33_166:Set(r_v37_169)
        local r_v33_170 = T_Gauntlet:AddDropdown("\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129\224\184\138\224\185\136\224\184\173\224\184\135\224\184\170\224\184\129\224\184\180\224\184\165\224\184\161\224\184\177\224\184\165\224\184\149\224\184\180 (\224\184\139\224\185\137\224\184\178\224\184\162\224\185\132\224\184\155\224\184\130\224\184\167\224\184\178)", {
            "\224\184\170\224\184\129\224\184\180\224\184\165\224\184\138\224\185\136\224\184\173\224\184\135\224\184\151\224\184\181\224\185\136 1",
            "\224\184\170\224\184\129\224\184\180\224\184\165\224\184\138\224\185\136\224\184\173\224\184\135\224\184\151\224\184\181\224\185\136 2",
            "\224\184\170\224\184\129\224\184\180\224\184\165\224\184\138\224\185\136\224\184\173\224\184\135\224\184\151\224\184\181\224\185\136 3",
            "\224\184\170\224\184\129\224\184\180\224\184\165\224\184\138\224\185\136\224\184\173\224\184\135\224\184\151\224\184\181\224\185\136 4",
            "\224\184\170\224\184\129\224\184\180\224\184\165\224\184\138\224\185\136\224\184\173\224\184\135\224\184\151\224\184\181\224\185\136 5",
            "\224\184\170\224\184\129\224\184\180\224\184\165\224\184\138\224\185\136\224\184\173\224\184\135\224\184\151\224\184\181\224\185\136 6"
        }, function(r_v10_860)
            local r_v1_1985 = tonumber
            local r_v2_1320 = string.match
            r_v2_1320 = r_v1_1985(r_v2_1320(r_v10_860, "%d+"))
            r_v40_42.auto_cleanse_multi_index = r_v2_1320 or 1
            Save()
            r_v10_860 = nil
        end)
        local r_v40_163 = tostring(r_v40_42.auto_cleanse_multi_index or 1)
        r_v33_170:Set("\224\184\170\224\184\129\224\184\180\224\184\165\224\184\138\224\185\136\224\184\173\224\184\135\224\184\151\224\184\181\224\185\136 " .. r_v40_163)
        T_Advanced:AddLabel("\226\143\173\239\184\143 \224\184\130\224\185\137\224\184\178\224\184\161\224\185\128\224\184\167\224\184\159\224\184\173\224\184\177\224\184\136\224\184\137\224\184\163\224\184\180\224\184\162\224\184\176")
        T_Advanced:AddLabel("\226\143\173\239\184\143 \224\184\130\224\185\137\224\184\178\224\184\161\224\185\128\224\184\167\224\184\159\224\184\173\224\184\177\224\184\136\224\184\137\224\184\163\224\184\180\224\184\162\224\184\176 (Smart Wave Skip)")
        local r_v34_166 = T_Advanced
        local r_v41_164 = r_v40_42.smart_skip_enable
        r_v34_166:AddToggle("\224\185\128\224\184\155\224\184\180\224\184\148\224\185\131\224\184\138\224\185\137\224\184\135\224\184\178\224\184\153\224\184\130\224\185\137\224\184\178\224\184\161\224\185\128\224\184\167\224\184\159\224\184\173\224\184\177\224\184\136\224\184\137\224\184\163\224\184\180\224\184\162\224\184\176", "\224\184\130\224\185\137\224\184\178\224\184\161\224\185\128\224\184\167\224\184\159\224\184\149\224\184\178\224\184\161\224\185\128\224\184\135\224\184\183\224\185\136\224\184\173\224\184\153\224\185\132\224\184\130\224\184\148\224\185\137\224\184\178\224\184\153\224\184\165\224\185\136\224\184\178\224\184\135 (\224\184\155\224\184\180\224\184\148 Auto Skip \224\185\131\224\184\153\224\185\128\224\184\129\224\184\161\224\184\148\224\185\137\224\184\167\224\184\162)", r_v41_164, function(r_v10_861)
            r_v40_42.smart_skip_enable = r_v10_861
            Save()
            local r_v4_2275 = r_v10_861
            if r_v10_861 then
                local r_v5_1591 = r_v71_75()
                r_v4_2275 = not r_v5_1591
            end
            if r_v4_2275 then
                task.spawn(SmartSkipWaveLoop)
            end
            r_v10_861 = nil
        end)
        local r_v34_167 = T_Advanced
        local r_v42_144 = r_v40_42.smart_skip_enemy_count
        local r_v43_145 = function(r_v10_862)
            r_v40_42.smart_skip_enemy_count = r_v10_862
            Save()
            r_v10_862 = nil
        end
        local r_v40_171 = r_v42_144 or 5
        r_v34_167:AddSlider("\224\184\136\224\184\179\224\184\153\224\184\167\224\184\153\224\184\161\224\184\173\224\184\153\224\184\151\224\184\181\224\185\136\224\185\128\224\184\171\224\184\165\224\184\183\224\184\173\224\185\131\224\184\153\224\185\129\224\184\161\224\184\158\224\184\129\224\185\136\224\184\173\224\184\153\224\184\130\224\185\137\224\184\178\224\184\161", 0, 20, r_v40_171, r_v43_145)
        local r_v34_168 = T_Advanced
        local r_v42_146 = r_v40_42.smart_skip_delay
        local r_v43_148 = function(r_v10_863)
            r_v40_42.smart_skip_delay = r_v10_863
            Save()
            r_v10_863 = nil
        end
        local r_v40_173 = r_v42_146 or 0
        r_v34_168:AddSlider("\224\184\148\224\184\181\224\185\128\224\184\165\224\184\162\224\185\140\224\184\163\224\184\173\224\184\129\224\185\136\224\184\173\224\184\153\224\184\130\224\185\137\224\184\178\224\184\161\224\185\128\224\184\167\224\184\159 (\224\184\167\224\184\180\224\184\153\224\184\178\224\184\151\224\184\181)", 0, 10, r_v40_173, r_v43_148)
        T_Advanced:AddLabel("\226\154\148\239\184\143 \224\184\154\224\184\177\224\184\159\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180 (Auto Buff)")
        local r_v34_170 = T_Advanced
        local r_v41_172 = r_v40_42.auto_buff
        r_v34_170:AddToggle("\224\185\128\224\184\155\224\184\180\224\184\148\224\185\131\224\184\138\224\185\137\224\184\135\224\184\178\224\184\153\224\184\154\224\184\177\224\184\159\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180", "\224\185\131\224\184\171\224\185\137\224\184\162\224\184\185\224\184\153\224\184\180\224\184\149\224\184\129\224\184\148\224\184\154\224\184\177\224\184\159\224\184\170\224\184\129\224\184\180\224\184\165\224\185\129\224\184\154\224\184\154\224\184\173\224\184\173\224\185\130\224\184\149\224\185\137", r_v41_172, function(r_v10_864)
            r_v40_42.auto_buff = r_v10_864
            Save()
            if ((not r_v71_75()) and r_v10_864) then
                AutoBuff()
            end
            r_v10_864 = nil
        end)
        T_Advanced:AddLabel("\240\159\148\132 \224\184\149\224\184\177\224\185\137\224\184\135\224\184\132\224\185\136\224\184\178\224\184\163\224\184\178\224\184\162\224\184\138\224\184\183\224\185\136\224\184\173\224\184\149\224\184\177\224\184\167\224\184\154\224\184\177\224\184\159 (\224\184\170\224\184\179\224\185\128\224\184\163\224\185\135\224\184\136\224\184\163\224\184\185\224\184\155)")
        local r_v43_158 = {}
        local r_v37_181 = {
            ["Mode"] = "Cycle",
            ["Checks"] = r_v43_158,
            ["Ability Type"] = "Normal",
            ["Cycle Units"] = 4,
            ["Time"] = 15,
            ["Delay"] = 0
        }
        local r_v44_157 = {}
        local r_v41_178 = {
            ["Mode"] = "Cycle",
            ["Checks"] = r_v44_157,
            ["Ability Type"] = "Normal",
            ["Cycle Units"] = 5,
            ["Time"] = 9.5,
            ["Delay"] = 0
        }
        local r_v47_123 = {}
        local r_v43_163 = {
            ["Mode"] = "Cycle",
            ["Checks"] = r_v47_123,
            ["Ability Type"] = "Normal",
            ["Cycle Units"] = 4,
            ["Time"] = 5,
            ["Delay"] = 0
        }
        local r_v49_128 = {}
        local r_v44_162 = {
            ["Mode"] = "Cycle",
            ["Checks"] = r_v49_128,
            ["Ability Type"] = "Multiple",
            ["Ability Name"] = "1",
            ["Cycle Units"] = 4,
            ["Time"] = 9,
            ["Delay"] = 0
        }
        local r_v38_104 = {}
        local r_v47_128 = {
            ["Mode"] = "Cycle",
            ["Checks"] = r_v38_104,
            ["Ability Type"] = "Normal",
            ["Cycle Units"] = 4,
            ["Time"] = 5,
            ["Delay"] = 0
        }
        local r_v53_94 = {
            "attack"
        }
        local r_v49_133 = {
            ["Mode"] = "Box",
            ["Checks"] = r_v53_94,
            ["Ability Type"] = "Normal",
            ["Time"] = 13
        }
        local r_v36_99 = {
            "range"
        }
        local r_v38_109 = {
            ["Mode"] = "Pair",
            ["Checks"] = r_v36_99,
            ["Ability Type"] = "Normal",
            ["Time"] = 30
        }
        local r_v55_100 = {
            "attack",
            "range"
        }
        local r_v53_99 = {
            ["Mode"] = "Box",
            ["Checks"] = r_v55_100,
            ["Ability Type"] = "Normal",
            ["Time"] = 13
        }
        local r_v56_99 = {
            "attack",
            "range"
        }
        local r_v36_104 = {
            ["Mode"] = "Pair",
            ["Checks"] = r_v56_99,
            ["Ability Type"] = "Multiple",
            ["Ability Name"] = "Buff Ability",
            ["Time"] = 13
        }
        local r_v58_104 = {
            "attack"
        }
        local r_v55_105 = {
            ["Mode"] = "Box",
            ["Checks"] = r_v58_104,
            ["Ability Type"] = "Normal",
            ["Time"] = 13
        }
        local r_v60_125 = {}
        local r_v56_104 = {
            ["Mode"] = "Cycle",
            ["Checks"] = r_v60_125,
            ["Ability Type"] = "Normal",
            ["Cycle Units"] = 7,
            ["Time"] = 10,
            ["Delay"] = 1
        }
        local r_v62_112 = {}
        local r_v58_109 = {
            ["Mode"] = "Cycle",
            ["Checks"] = r_v62_112,
            ["Ability Type"] = "Normal",
            ["Cycle Units"] = 2,
            ["Time"] = 30,
            ["Delay"] = 0
        }
        local r_v64_108 = {}
        local r_v60_130 = {
            ["Mode"] = "Cycle",
            ["Checks"] = r_v64_108,
            ["Ability Type"] = "Normal",
            ["Cycle Units"] = 2,
            ["Time"] = 30,
            ["Delay"] = 0
        }
        local r_v66_121 = {
            "attack",
            "range"
        }
        local r_v62_117 = {
            ["Time"] = 13,
            ["Checks"] = r_v66_121,
            ["Mode"] = "Box",
            ["Ability Type"] = "Normal"
        }
        local r_v68_128 = {
            ""
        }
        local r_v64_113 = {
            ["Time"] = 10,
            ["Checks"] = r_v68_128,
            ["Mode"] = "Box",
            ["Delay"] = 0,
            ["Ability Type"] = "Normal"
        }
        local r_v70_122 = {
            ""
        }
        local r_v66_126 = {
            ["Time"] = 15,
            ["Checks"] = r_v70_122,
            ["Mode"] = "Spam",
            ["Delay"] = 0,
            ["Ability Type"] = "Normal"
        }
        local r_v72_96 = {
            ""
        }
        local r_v68_133 = {
            ["Time"] = 21,
            ["Checks"] = r_v72_96,
            ["Mode"] = "Spam",
            ["Delay"] = 0.5,
            ["Ability Type"] = "Normal"
        }
        local r_v74_81 = {
            ""
        }
        local r_v70_127 = {
            ["Time"] = 10,
            ["Checks"] = r_v74_81,
            ["Mode"] = "Box",
            ["Delay"] = 0,
            ["Ability Type"] = "Normal"
        }
        local r_v76_71 = {
            "attack",
            "range"
        }
        local r_v72_101 = {
            ["Time"] = 13,
            ["Checks"] = r_v76_71,
            ["Mode"] = "Box",
            ["Ability Type"] = "Normal"
        }
        local r_v78_63 = {
            "attack",
            "range"
        }
        local r_v74_86 = {
            ["Time"] = 1,
            ["Checks"] = r_v78_63,
            ["Mode"] = "Spam",
            ["Delay"] = 0,
            ["Ability Type"] = "Normal"
        }
        local r_v34_172 = {
            ["BenimaruTensura"] = r_v37_181,
            ["Homura7"] = r_v41_178,
            ["Jotaro Kujo P4"] = r_v43_163,
            ["Jotaro Over Heaven"] = r_v44_162,
            ["Kurumi"] = r_v47_128,
            ["Erwin"] = r_v49_133,
            ["Merlin"] = r_v38_109,
            ["Brook6"] = r_v53_99,
            ["Kisuke6"] = r_v36_104,
            ["Rayleigh"] = r_v55_105,
            ["Six Eyes Gojo"] = r_v56_104,
            ["Leafa6"] = r_v58_109,
            ["Leafa6Shiny"] = r_v60_130,
            ["Merlin6"] = r_v62_117,
            ["Gojo7"] = r_v64_113,
            ["Hoshino"] = r_v66_126,
            ["Metal Cooler"] = r_v68_133,
            ["Satorou Gojou"] = r_v70_127,
            ["Wenda"] = r_v72_101,
            ["Idol"] = r_v74_86
        }
        local r_v37_182 = r_v33_30(r_v34_172)
        local r_v39_191 = function()
            local r_v10_866 = r_v33_30(r_v40_42.auto_buff_units)
            if ((#r_v10_866) > 0) then
                return table.concat(r_v10_866, ", ")
            end
            return "\224\185\132\224\184\161\224\185\136\224\184\161\224\184\181"
        end
        local r_v41_182 = T_Advanced:AddParagraph("\224\184\162\224\184\185\224\184\153\224\184\180\224\184\149\224\184\151\224\184\181\224\185\136\224\184\129\224\184\179\224\184\165\224\184\177\224\184\135\224\184\151\224\184\179\224\184\135\224\184\178\224\184\153", r_v39_191())
        local r_v40_191 = T_Advanced:AddDropdown("\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129\224\184\162\224\184\185\224\184\153\224\184\180\224\184\149\224\184\154\224\184\177\224\184\159", r_v37_182, function(r_v10_867)
            -- empty block
        end)
        local r_v42_167 = r_v37_182[1]
        r_v40_191:Set(r_v42_167)
        T_Advanced:AddButton("\226\156\133 \224\185\128\224\184\155\224\184\180\224\184\148\224\185\131\224\184\138\224\185\137\224\184\135\224\184\178\224\184\153\224\184\162\224\184\185\224\184\153\224\184\180\224\184\149\224\184\151\224\184\181\224\185\136\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129", function()
            local r_v10_869 = "CurrentOption"
            r_v10_869 = r_v40_191[r_v10_869]
            if r_v34_172[r_v10_869] then
                local r_v1_2003 = r_v40_42.auto_buff_units
                r_v1_2003[r_v10_869] = r_v34_172[r_v10_869]
                Save()
                local r_v7_2024 = r_v39_191()
                r_v41_182:Set({
                    ["Title"] = "\224\184\162\224\184\185\224\184\153\224\184\180\224\184\149\224\184\151\224\184\181\224\185\136\224\184\129\224\184\179\224\184\165\224\184\177\224\184\135\224\184\151\224\184\179\224\184\135\224\184\178\224\184\153",
                    ["Content"] = r_v7_2024
                })
                r_v67_92("\224\184\154\224\184\177\224\184\159", "\224\185\128\224\184\155\224\184\180\224\184\148\224\185\131\224\184\138\224\185\137\224\184\135\224\184\178\224\184\153 " .. r_v10_869, 3)
            end
        end)
        T_Advanced:AddButton("\226\157\140 \224\184\155\224\184\180\224\184\148\224\185\131\224\184\138\224\185\137\224\184\135\224\184\178\224\184\153\224\184\162\224\184\185\224\184\153\224\184\180\224\184\149\224\184\151\224\184\181\224\185\136\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129", function()
            local r_v10_870 = "CurrentOption"
            r_v10_870 = r_v40_191[r_v10_870]
            if r_v40_42.auto_buff_units[r_v10_870] then
                local r_v1_2009 = r_v40_42.auto_buff_units
                r_v1_2009[r_v10_870] = nil
                Save()
                local r_v7_2032 = r_v39_191()
                r_v41_182:Set({
                    ["Title"] = "\224\184\162\224\184\185\224\184\153\224\184\180\224\184\149\224\184\151\224\184\181\224\185\136\224\184\129\224\184\179\224\184\165\224\184\177\224\184\135\224\184\151\224\184\179\224\184\135\224\184\178\224\184\153",
                    ["Content"] = r_v7_2032
                })
                r_v67_92("\224\184\154\224\184\177\224\184\159", "\224\184\155\224\184\180\224\184\148\224\185\131\224\184\138\224\185\137\224\184\135\224\184\178\224\184\153 " .. r_v10_870, 3)
            end
        end)
        T_Advanced:AddButton("\240\159\151\145\239\184\143 \224\185\128\224\184\132\224\184\165\224\184\181\224\184\162\224\184\163\224\185\140\224\184\149\224\184\177\224\184\167\224\184\154\224\184\177\224\184\159\224\184\151\224\184\177\224\185\137\224\184\135\224\184\171\224\184\161\224\184\148", function()
            r_v40_42.auto_buff_units = {}
            Save()
            r_v41_182:Set({
                ["Title"] = "\224\184\162\224\184\185\224\184\153\224\184\180\224\184\149\224\184\151\224\184\181\224\185\136\224\184\129\224\184\179\224\184\165\224\184\177\224\184\135\224\184\151\224\184\179\224\184\135\224\184\178\224\184\153",
                ["Content"] = "\224\185\132\224\184\161\224\185\136\224\184\161\224\184\181"
            })
        end)
        local r_v43_182 = function()
            local r_v10_875
            local r_v1_2016 = {
                "\224\185\132\224\184\161\224\185\136\224\185\132\224\184\148\224\185\137\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129 (None)"
            }
            local r_v2_1353 = function()
                local r_v10_1238 = r_v69_99
                local r_v2_2010 = r_v10_1238:FindFirstChild("HUD")
                local r_v4_3160 = r_v2_2010
                if r_v2_2010 then
                    local r_v5_2351 = r_v69_99.HUD:FindFirstChild("BottomFrame")
                    r_v10_1238 = r_v5_2351
                    if r_v5_2351 then
                        r_v10_1238 = r_v69_99.HUD.BottomFrame:FindFirstChild("Unit")
                    end
                    r_v4_3160 = r_v10_1238
                end
                r_v10_1238 = r_v4_3160
                if r_v10_1238 then
                    local r_v6_2743 = r_v10_1238.GetChildren
                    local r_v1_2766 = pairs
                    for r_v6_2745, r_v8_2895 in r_v1_2766(r_v6_2743(r_v10_1238)) do
                        if (r_v8_2895.ClassName == "Frame") then
                            local r_v7_2706 = "Unit"
                            r_v7_2706 = r_v8_2895:FindFirstChild(r_v7_2706)
                            local r_v9_2593 = r_v7_2706
                            if r_v7_2706 then
                                local r_v12_1815 = r_v7_2706.Value
                                local r_v13_2069 = r_v12_1815 ~= ""
                                local r_v14_2383 = r_v13_2069
                                if r_v13_2069 then
                                    local r_v12_1816 = r_v7_2706.Value
                                    r_v14_2383 = r_v12_1816 ~= "None"
                                end
                                r_v9_2593 = r_v14_2383
                            end
                            if r_v9_2593 then
                                local r_v9_2594 = table.find
                                if (not r_v9_2594(r_v10_875, r_v7_2706.Value)) then
                                    table.insert(r_v10_875, r_v7_2706.Value)
                                end
                            end
                        end
                    end
                end
            end
            r_v10_875 = r_v1_2016
            pcall(r_v2_1353)
            if ((#r_v10_875) == 1) then
                table.insert(r_v10_875, "\224\185\132\224\184\161\224\185\136\224\184\158\224\184\154\224\184\149\224\184\177\224\184\167\224\184\165\224\184\176\224\184\132\224\184\163\224\185\131\224\184\153\224\184\170\224\184\165\224\185\135\224\184\173\224\184\149")
            end
            return r_v10_875
        end
        T_Snipe:AddLabel("\226\154\161 \224\184\173\224\184\173\224\185\130\224\184\149\224\185\137\224\184\170\224\184\129\224\184\180\224\184\165\224\184\132\224\184\180\224\184\163\224\184\177\224\184\167\224\184\163\224\185\140 (Auto Killua Wish)")
        local r_v43_184 = T_Snipe
        local r_v47_137 = r_v40_42.auto_killua_enable
        r_v43_184:AddToggle("\224\185\128\224\184\155\224\184\180\224\184\148\224\184\173\224\184\173\224\185\130\224\184\149\224\185\137\224\184\130\224\184\173\224\184\158\224\184\163\224\184\132\224\184\180\224\184\163\224\184\177\224\184\167\224\184\163\224\185\140", "\224\184\129\224\184\148\224\184\170\224\184\129\224\184\180\224\184\165\224\184\130\224\184\173\224\184\158\224\184\163\224\185\131\224\184\171\224\185\137\224\185\128\224\184\173\224\184\135\224\185\129\224\184\154\224\184\154\224\184\163\224\184\167\224\184\148\224\185\128\224\184\163\224\185\135\224\184\167 (\224\185\132\224\184\161\224\185\136\224\184\129\224\184\167\224\184\153\224\184\161\224\184\178\224\185\130\224\184\132\224\184\163)", r_v47_137, function(r_v10_876)
            r_v40_42.auto_killua_enable = r_v10_876
            Save()
            if r_v10_876 then
                task.spawn(AutoKilluaLoop)
            end
            r_v10_876 = nil
        end)
        local r_v42_182 = T_Snipe:AddDropdown("\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129\224\184\158\224\184\163\224\184\151\224\184\181\224\185\136\224\184\149\224\185\137\224\184\173\224\184\135\224\184\129\224\184\178\224\184\163\224\184\130\224\184\173", {
            "Money",
            "Healing",
            "Death"
        }, function(r_v10_877)
            r_v40_42.auto_killua_wish = r_v10_877
            Save()
            r_v10_877 = nil
        end)
        local r_v44_175 = (r_v40_42.auto_killua_wish) or ("Money")
        r_v42_182:Set(r_v44_175)
        T_Snipe:AddLabel("\240\159\142\175 \224\184\163\224\184\176\224\184\154\224\184\154\224\184\165\224\185\135\224\184\173\224\184\132\224\185\128\224\184\155\224\185\137\224\184\178\224\184\154\224\184\173\224\184\170 (Boss Control)")
        local r_v43_191 = T_Snipe
        local r_v47_145 = r_v40_42.auto_target_boss
        r_v43_191:AddToggle("\224\185\128\224\184\155\224\184\165\224\184\181\224\185\136\224\184\162\224\184\153\224\185\128\224\184\155\224\185\137\224\184\178\224\184\173\224\184\173\224\185\130\224\184\149\224\185\137\224\185\128\224\184\161\224\184\183\224\185\136\224\184\173\224\185\128\224\184\136\224\184\173\224\184\154\224\184\173\224\184\170", "\224\184\129\224\184\148\224\185\128\224\184\155\224\184\165\224\184\181\224\185\136\224\184\162\224\184\153\224\185\128\224\184\155\224\185\137\224\184\178\224\184\171\224\184\161\224\184\178\224\184\162 3 \224\184\132\224\184\163\224\184\177\224\185\137\224\184\135 \224\184\151\224\184\177\224\184\153\224\184\151\224\184\181\224\184\151\224\184\181\224\185\136\224\185\128\224\184\136\224\184\173\224\184\154\224\184\173\224\184\170", r_v47_145, function(r_v10_878)
            r_v40_42.auto_target_boss = r_v10_878
            Save()
            if r_v10_878 then
                task.spawn(o_v63_5)
            end
            r_v10_878 = nil
        end)
        local r_v42_195 = T_Snipe:AddDropdown("\224\185\128\224\184\135\224\184\183\224\185\136\224\184\173\224\184\153\224\185\132\224\184\130\224\185\128\224\184\155\224\184\165\224\184\181\224\185\136\224\184\162\224\184\153\224\185\128\224\184\155\224\185\137\224\184\178\224\184\171\224\184\161\224\184\178\224\184\162", {
            "\224\184\151\224\184\177\224\184\153\224\184\151\224\184\181\224\185\128\224\184\161\224\184\183\224\185\136\224\184\173\224\184\154\224\184\173\224\184\170\224\185\128\224\184\129\224\184\180\224\184\148",
            "\224\185\128\224\184\161\224\184\183\224\185\136\224\184\173\224\184\154\224\184\173\224\184\170\224\185\128\224\184\130\224\185\137\224\184\178\224\184\163\224\184\176\224\184\162\224\184\176 (\224\185\128\224\184\130\224\185\137\224\184\178\224\184\167\224\184\135)"
        }, function(r_v10_879)
            r_v40_42.auto_target_boss_condition = r_v10_879
            Save()
            r_v10_879 = nil
        end)
        local r_v44_180 = (r_v40_42.auto_target_boss_condition) or ("\224\184\151\224\184\177\224\184\153\224\184\151\224\184\181\224\185\128\224\184\161\224\184\183\224\185\136\224\184\173\224\184\154\224\184\173\224\184\170\224\185\128\224\184\129\224\184\180\224\184\148")
        r_v42_195:Set(r_v44_180)
        local r_v42_199 = T_Snipe:AddDropdown("\224\184\162\224\184\185\224\184\153\224\184\180\224\184\149\224\184\151\224\184\181\224\185\136\224\184\149\224\185\137\224\184\173\224\184\135\224\185\128\224\184\155\224\184\165\224\184\181\224\185\136\224\184\162\224\184\153\224\185\128\224\184\155\224\185\137\224\184\178", {
            "\224\184\151\224\184\184\224\184\129\224\184\149\224\184\177\224\184\167 (All)",
            "\224\185\132\224\184\161\224\185\136\224\185\132\224\184\148\224\185\137\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129 (None)"
        }, function(r_v10_880)
            r_v40_42.auto_target_boss_unit = r_v10_880
            Save()
            r_v10_880 = nil
        end)
        local r_v45_170 = (r_v40_42.auto_target_boss_unit) or ("\224\184\151\224\184\184\224\184\129\224\184\149\224\184\177\224\184\167 (All)")
        r_v42_199:Set(r_v45_170)
        local r_v42_201 = T_Snipe
        local r_v50_155 = r_v40_42.auto_skill_boss
        r_v42_201:AddToggle("\224\184\129\224\184\148\224\184\170\224\184\129\224\184\180\224\184\165\224\184\173\224\184\173\224\185\130\224\184\149\224\185\137\224\185\128\224\184\161\224\184\183\224\185\136\224\184\173\224\184\154\224\184\173\224\184\170\224\185\128\224\184\130\224\185\137\224\184\178\224\184\163\224\184\176\224\184\162\224\184\176", "\224\185\132\224\184\161\224\185\136\224\184\149\224\185\137\224\184\173\224\184\135\224\184\163\224\184\173\224\185\128\224\184\167\224\184\165\224\184\178 \224\185\128\224\184\138\224\185\135\224\184\132\224\184\163\224\184\176\224\184\162\224\184\176\224\184\167\224\184\135\224\185\129\224\184\165\224\184\176\224\184\170\224\184\173\224\184\162\224\184\154\224\184\173\224\184\170\224\184\151\224\184\177\224\184\153\224\184\151\224\184\181", r_v50_155, function(r_v10_881)
            r_v40_42.auto_skill_boss = r_v10_881
            Save()
            if r_v10_881 then
                task.spawn(o_v65_5)
            end
            r_v10_881 = nil
        end)
        local r_v42_202 = T_Snipe
        local r_v38_130 = r_v40_42.auto_skill_boss_count
        local r_v48_141 = function(r_v10_882)
            r_v40_42.auto_skill_boss_count = r_v10_882
            Save()
            r_v10_882 = nil
        end
        local r_v49_165 = r_v38_130 or 1
        r_v42_202:AddSlider("\224\184\136\224\184\179\224\184\153\224\184\167\224\184\153\224\184\154\224\184\173\224\184\170\224\185\131\224\184\153\224\184\163\224\184\176\224\184\162\224\184\176\224\184\129\224\185\136\224\184\173\224\184\153\224\184\129\224\184\148\224\184\170\224\184\129\224\184\180\224\184\165", 1, 10, r_v49_165, r_v48_141)
        local r_v45_178 = T_Snipe:AddDropdown("\224\184\162\224\184\185\224\184\153\224\184\180\224\184\149\224\184\151\224\184\181\224\185\136\224\185\131\224\184\138\224\185\137\224\184\170\224\184\129\224\184\180\224\184\165\224\185\131\224\184\170\224\185\136\224\184\154\224\184\173\224\184\170", {
            "\224\184\151\224\184\184\224\184\129\224\184\149\224\184\177\224\184\167 (All)",
            "\224\185\132\224\184\161\224\185\136\224\185\132\224\184\148\224\185\137\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129 (None)"
        }, function(r_v10_883)
            r_v40_42.auto_skill_boss_unit = r_v10_883
            Save()
            r_v10_883 = nil
        end)
        local r_v50_162 = (r_v40_42.auto_skill_boss_unit) or ("\224\184\151\224\184\184\224\184\129\224\184\149\224\184\177\224\184\167 (All)")
        r_v45_178:Set(r_v50_162)
        local r_v47_169 = T_Snipe:AddDropdown("\224\184\155\224\184\163\224\184\176\224\185\128\224\184\160\224\184\151\224\184\170\224\184\129\224\184\180\224\184\165", {
            "Normal",
            "Multiple (\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129\224\184\138\224\185\136\224\184\173\224\184\135\224\184\170\224\184\129\224\184\180\224\184\165)"
        }, function(r_v10_884)
            r_v40_42.auto_skill_boss_mode = r_v10_884
            Save()
            r_v10_884 = nil
        end)
        local r_v50_165 = (r_v40_42.auto_skill_boss_mode) or ("Normal")
        r_v47_169:Set(r_v50_165)
        local r_v47_173 = T_Snipe:AddDropdown("\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129\224\184\138\224\185\136\224\184\173\224\184\135\224\184\170\224\184\129\224\184\180\224\184\165\224\184\161\224\184\177\224\184\165\224\184\149\224\184\180 (\224\184\139\224\185\137\224\184\178\224\184\162\224\185\132\224\184\155\224\184\130\224\184\167\224\184\178)", {
            "\224\184\170\224\184\129\224\184\180\224\184\165\224\184\138\224\185\136\224\184\173\224\184\135\224\184\151\224\184\181\224\185\136 1",
            "\224\184\170\224\184\129\224\184\180\224\184\165\224\184\138\224\185\136\224\184\173\224\184\135\224\184\151\224\184\181\224\185\136 2",
            "\224\184\170\224\184\129\224\184\180\224\184\165\224\184\138\224\185\136\224\184\173\224\184\135\224\184\151\224\184\181\224\185\136 3",
            "\224\184\170\224\184\129\224\184\180\224\184\165\224\184\138\224\185\136\224\184\173\224\184\135\224\184\151\224\184\181\224\185\136 4",
            "\224\184\170\224\184\129\224\184\180\224\184\165\224\184\138\224\185\136\224\184\173\224\184\135\224\184\151\224\184\181\224\185\136 5",
            "\224\184\170\224\184\129\224\184\180\224\184\165\224\184\138\224\185\136\224\184\173\224\184\135\224\184\151\224\184\181\224\185\136 6"
        }, function(r_v10_885)
            local r_v1_2042 = tonumber
            local r_v2_1386 = string.match
            r_v2_1386 = r_v1_2042(r_v2_1386(r_v10_885, "%d+"))
            r_v40_42.auto_skill_boss_multi_index = r_v2_1386 or 1
            Save()
            r_v10_885 = nil
        end)
        local r_v38_145 = tostring(r_v40_42.auto_skill_boss_multi_index or 1)
        local r_v50_167 = "\224\184\170\224\184\129\224\184\180\224\184\165\224\184\138\224\185\136\224\184\173\224\184\135\224\184\151\224\184\181\224\185\136 " .. r_v38_145
        r_v47_173:Set(r_v50_167)
        T_Snipe:AddLabel("\226\154\153\239\184\143 \224\185\128\224\184\135\224\184\183\224\185\136\224\184\173\224\184\153\224\185\132\224\184\130\224\184\129\224\184\178\224\184\163\224\184\129\224\184\148\224\184\170\224\184\129\224\184\180\224\184\165\224\185\131\224\184\170\224\185\136\224\184\154\224\184\173\224\184\170")
        local r_v47_181 = T_Snipe:AddDropdown("\224\184\136\224\184\177\224\184\135\224\184\171\224\184\167\224\184\176\224\184\129\224\184\178\224\184\163\224\184\129\224\184\148\224\184\170\224\184\129\224\184\180\224\184\165", {
            "\224\184\129\224\184\148\224\184\151\224\184\177\224\184\153\224\184\151\224\184\181 (\224\185\132\224\184\161\224\185\136\224\184\170\224\184\153\224\184\161\224\184\173\224\184\153\224\184\173\224\184\183\224\185\136\224\184\153)",
            "\224\184\129\224\184\148\224\185\128\224\184\161\224\184\183\224\185\136\224\184\173\224\184\161\224\184\181\224\185\129\224\184\132\224\185\136\224\184\154\224\184\173\224\184\170\224\185\131\224\184\153\224\184\167\224\184\135\224\185\128\224\184\151\224\185\136\224\184\178\224\184\153\224\184\177\224\185\137\224\184\153"
        }, function(r_v10_886)
            r_v40_42.auto_skill_boss_trigger_condition = r_v10_886
            Save()
            r_v10_886 = nil
        end)
        local r_v50_170 = (r_v40_42.auto_skill_boss_trigger_condition) or ("\224\184\129\224\184\148\224\184\151\224\184\177\224\184\153\224\184\151\224\184\181 (\224\185\132\224\184\161\224\185\136\224\184\170\224\184\153\224\184\161\224\184\173\224\184\153\224\184\173\224\184\183\224\185\136\224\184\153)")
        r_v47_181:Set(r_v50_170)
        local r_v47_185 = T_Snipe:AddDropdown("\224\184\136\224\184\179\224\184\153\224\184\167\224\184\153\224\184\149\224\184\177\224\184\167\224\184\165\224\184\176\224\184\132\224\184\163\224\184\151\224\184\181\224\185\136\224\184\136\224\184\176\224\184\129\224\184\148", {
            "\224\184\129\224\184\148\224\184\151\224\184\184\224\184\129\224\184\149\224\184\177\224\184\167\224\184\151\224\184\181\224\185\136\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129",
            "\224\184\129\224\184\148\224\184\149\224\184\177\224\184\167\224\185\128\224\184\148\224\184\181\224\184\162\224\184\167 (\224\184\173\224\184\177\224\184\155\224\185\128\224\184\129\224\184\163\224\184\148\224\184\170\224\184\185\224\184\135\224\184\170\224\184\184\224\184\148)"
        }, function(r_v10_887)
            r_v40_42.auto_skill_boss_target_amount = r_v10_887
            Save()
            r_v10_887 = nil
        end)
        local r_v50_172 = (r_v40_42.auto_skill_boss_target_amount) or ("\224\184\129\224\184\148\224\184\151\224\184\184\224\184\129\224\184\149\224\184\177\224\184\167\224\184\151\224\184\181\224\185\136\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129")
        r_v47_185:Set(r_v50_172)
        T_Snipe:AddLabel("\240\159\166\133 \224\184\148\224\184\177\224\184\129\224\184\151\224\184\178\224\184\135\224\184\149\224\184\177\224\184\167\224\184\154\224\184\180\224\184\153 (Air Unit Smart Placement)")
        local r_v45_198 = T_Snipe
        local r_v48_171 = r_v40_42.air_unit_first
        r_v45_198:AddToggle("\224\184\167\224\184\178\224\184\135\224\184\149\224\184\177\224\184\167\224\184\149\224\184\181\224\184\173\224\184\178\224\184\129\224\184\178\224\184\168\224\184\129\224\185\136\224\184\173\224\184\153\224\184\150\224\185\137\224\184\178\224\184\161\224\184\181\224\184\149\224\184\177\224\184\167\224\184\154\224\184\180\224\184\153\224\185\128\224\184\129\224\184\180\224\184\148", "\224\184\136\224\184\176\224\184\132\224\185\137\224\184\153\224\184\171\224\184\178 Hill \224\185\129\224\184\165\224\184\176\224\184\167\224\184\178\224\184\135\224\185\131\224\184\129\224\184\165\224\185\137\224\184\149\224\184\177\224\184\167\224\184\154\224\184\180\224\184\153\224\184\151\224\184\181\224\185\136\224\184\170\224\184\184\224\184\148", r_v48_171, function(r_v10_888)
            r_v40_42.air_unit_first = r_v10_888
            Save()
            r_v10_888 = nil
        end)
        local r_v47_197 = T_Snipe:AddDropdown("\224\184\149\224\184\177\224\184\167\224\184\165\224\184\176\224\184\132\224\184\163\224\184\170\224\184\173\224\184\162\224\184\149\224\184\177\224\184\167\224\184\154\224\184\180\224\184\153", {
            "\224\185\132\224\184\161\224\185\136\224\185\132\224\184\148\224\185\137\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129 (None)"
        }, function(r_v10_889)
            r_v40_42.air_unit_name = r_v10_889
            Save()
            r_v10_889 = nil
        end)
        local r_v49_189 = (r_v40_42.air_unit_name) or ("\224\185\132\224\184\161\224\185\136\224\185\132\224\184\148\224\185\137\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129 (None)")
        r_v47_197:Set(r_v49_189)
        T_Snipe:AddLabel("\226\172\134\239\184\143 \224\184\173\224\184\177\224\184\155\224\185\128\224\184\129\224\184\163\224\184\148\224\185\128\224\184\137\224\184\158\224\184\178\224\184\176\224\185\128\224\184\136\224\184\178\224\184\176\224\184\136\224\184\135 (\224\184\136\224\184\177\224\184\148\224\184\132\224\184\180\224\184\167\224\184\163\224\184\178\224\184\162\224\184\149\224\184\177\224\184\167)")
        local r_v47_200 = T_Snipe
        local r_v38_169 = r_v40_42.auto_specific_upgrade
        r_v47_200:AddToggle("\224\185\128\224\184\155\224\184\180\224\184\148\224\184\173\224\184\177\224\184\155\224\185\128\224\184\129\224\184\163\224\184\148\224\184\149\224\184\177\224\184\167\224\185\128\224\184\137\224\184\158\224\184\178\224\184\176", "\224\184\136\224\184\176\224\184\173\224\184\177\224\184\155\224\185\128\224\184\129\224\184\163\224\184\148\224\184\149\224\184\178\224\184\161\224\184\132\224\184\180\224\184\167\224\184\163\224\184\178\224\184\162\224\184\129\224\184\178\224\184\163\224\184\151\224\184\181\224\185\136\224\184\132\224\184\184\224\184\147\224\184\149\224\184\177\224\185\137\224\184\135\224\185\132\224\184\167\224\185\137\224\184\148\224\185\137\224\184\178\224\184\153\224\184\165\224\185\136\224\184\178\224\184\135", r_v38_169, function(r_v10_890)
            r_v40_42.auto_specific_upgrade = r_v10_890
            Save()
            if r_v10_890 then
                task.spawn(o_v67_5)
            end
            r_v10_890 = nil
        end)
        local r_v50_190 = T_Snipe:AddTextbox("\224\184\132\224\184\180\224\184\167\224\184\155\224\184\177\224\184\136\224\184\136\224\184\184\224\184\154\224\184\177\224\184\153 (\224\185\128\224\184\138\224\185\136\224\184\153 Speedwagon:5, Bulma:10)", function(r_v10_891)
            r_v40_42.specific_upgrade_list = r_v10_891
            Save()
            r_v10_891 = nil
        end)
        local r_v48_182 = (r_v40_42.specific_upgrade_list) or ("")
        r_v50_190:Set(r_v48_182)
        local r_v50_192 = "\224\185\132\224\184\161\224\185\136\224\185\132\224\184\148\224\185\137\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129 (None)"
        local r_v50_193 = 50
        T_Snipe:AddLabel("\226\154\153\239\184\143 \224\185\128\224\184\158\224\184\180\224\185\136\224\184\161\224\184\149\224\184\177\224\184\167\224\184\165\224\184\176\224\184\132\224\184\163\224\185\128\224\184\130\224\185\137\224\184\178\224\184\132\224\184\180\224\184\167")
        local r_v38_181 = T_Snipe:AddDropdown("1. \224\185\128\224\184\165\224\184\183\224\184\173\224\184\129\224\184\149\224\184\177\224\184\167\224\184\165\224\184\176\224\184\132\224\184\163", {
            "\224\185\132\224\184\161\224\185\136\224\185\132\224\184\148\224\185\137\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129 (None)"
        }, function(r_v10_892)
            r_v50_192 = r_v10_892
            r_v10_892 = nil
        end)
        T_Snipe:AddSlider("2. \224\185\128\224\184\165\224\184\183\224\184\173\224\184\129\224\184\163\224\184\176\224\184\148\224\184\177\224\184\154\224\184\151\224\184\181\224\185\136\224\184\136\224\184\176\224\184\173\224\184\177\224\184\155\224\184\150\224\184\182\224\184\135", 1, 50, 50, function(r_v10_893)
            r_v50_193 = r_v10_893
            r_v10_893 = nil
        end)
        T_Snipe:AddButton("\226\158\149 3. \224\184\129\224\184\148\224\185\128\224\184\158\224\184\180\224\185\136\224\184\161\224\184\165\224\184\135\224\184\132\224\184\180\224\184\167\224\184\173\224\184\177\224\184\155\224\185\128\224\184\129\224\184\163\224\184\148", function()
            if ((r_v50_192 ~= "\224\185\132\224\184\161\224\185\136\224\185\132\224\184\148\224\185\137\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129 (None)") and (r_v50_192 ~= ("\224\184\151\224\184\184\224\184\129\224\184\149\224\184\177\224\184\167 (All)"))) then
                local r_v10_896 = r_v40_42.specific_upgrade_list
                local r_v4_2385 = r_v10_896
                if not r_v10_896 then
                    r_v10_896 = ""
                    r_v4_2385 = r_v10_896
                end
                r_v10_896 = r_v4_2385
                local r_v6_1949 = tostring(r_v50_193)
                local r_v2_1406 = ":" .. r_v6_1949
                r_v2_1406 = r_v50_192 .. r_v2_1406
                local r_v1_2060 = string.find
                local r_v5_1655 = string
                local r_v5_1656 = r_v5_1655.lower(r_v10_896)
                local r_v8_2125 = string.lower(r_v50_192)
                if r_v1_2060(r_v5_1656, r_v8_2125 .. ":") then
                    r_v67_92("\224\185\129\224\184\136\224\185\137\224\184\135\224\185\128\224\184\149\224\184\183\224\184\173\224\184\153", "\224\184\161\224\184\181\224\184\149\224\184\177\224\184\167\224\184\165\224\184\176\224\184\132\224\184\163\224\184\153\224\184\181\224\185\137\224\185\131\224\184\153\224\184\132\224\184\180\224\184\167\224\185\129\224\184\165\224\185\137\224\184\167 \224\185\130\224\184\155\224\184\163\224\184\148\224\185\128\224\184\132\224\184\165\224\184\181\224\184\162\224\184\163\224\185\140\224\184\129\224\185\136\224\184\173\224\184\153", 3)
                    return
                else
                    if (r_v10_896 == "") then
                        r_v10_896 = r_v2_1406
                    else
                        local r_v3_1434 = ", " .. r_v2_1406
                        r_v10_896 = r_v10_896 .. r_v3_1434
                    end
                    r_v40_42.specific_upgrade_list = r_v10_896
                    Save()
                    r_v50_190:Set(r_v10_896)
                    local r_v11_1693 = " \224\184\150\224\184\182\224\184\135\224\184\130\224\184\177\224\185\137\224\184\153 " .. r_v50_193
                    r_v67_92("\224\184\173\224\184\177\224\184\155\224\185\128\224\184\129\224\184\163\224\184\148", "\224\184\149\224\184\177\224\185\137\224\184\135\224\184\132\224\185\136\224\184\178\224\185\131\224\184\171\224\185\137\224\184\173\224\184\177\224\184\155 " .. r_v50_192 .. r_v11_1693, 3)
                end
            else
                r_v67_92("\224\185\129\224\184\136\224\185\137\224\184\135\224\185\128\224\184\149\224\184\183\224\184\173\224\184\153", "\224\185\130\224\184\155\224\184\163\224\184\148\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129\224\184\149\224\184\177\224\184\167\224\184\165\224\184\176\224\184\132\224\184\163\224\184\129\224\185\136\224\184\173\224\184\153!", 3)
            end
        end)
        T_Snipe:AddButton("\240\159\151\145\239\184\143 \224\184\165\224\185\137\224\184\178\224\184\135\224\184\132\224\184\180\224\184\167\224\184\151\224\184\177\224\185\137\224\184\135\224\184\171\224\184\161\224\184\148", function()
            r_v40_42.specific_upgrade_list = ""
            Save()
            r_v50_190:Set("")
            r_v67_92("\224\184\173\224\184\177\224\184\155\224\185\128\224\184\129\224\184\163\224\184\148", "\224\184\165\224\185\137\224\184\178\224\184\135\224\184\132\224\184\180\224\184\167\224\185\128\224\184\163\224\184\181\224\184\162\224\184\154\224\184\163\224\185\137\224\184\173\224\184\162", 3)
        end)
        T_Snipe:AddButton("\240\159\148\132 \224\185\130\224\184\171\224\184\165\224\184\148\224\184\163\224\184\178\224\184\162\224\184\138\224\184\183\224\185\136\224\184\173\224\184\149\224\184\177\224\184\167\224\184\165\224\184\176\224\184\132\224\184\163\224\184\136\224\184\178\224\184\129\224\184\170\224\184\165\224\185\135\224\184\173\224\184\149 (Equipped)", function()
            local r_v10_902 = r_v43_182()
            local r_v2_1413 = r_v2_3
            r_v2_1413 = {
                "\224\184\151\224\184\184\224\184\129\224\184\149\224\184\177\224\184\167 (All)"
            }
            local r_v4_2402, r_v3_1446, r_v5_1675 = pairs(r_v10_902)
            local r_v6_1971 = r_v4_2402
            for r_v8_2139, r_v7_2069 in r_v6_1971, r_v3_1446, r_v5_1675 do
                local r_v9_2002 = table
                r_v9_2002.insert(r_v2_1413, r_v7_2069)
            end
            local r_v14_1849 = r_v40_42.auto_target_boss_unit
            local r_v8_2141 = (r_v14_1849 ~= "") and (r_v40_42.auto_target_boss_unit)
            local r_v5_1676 = r_v8_2141 or ("\224\184\151\224\184\184\224\184\129\224\184\149\224\184\177\224\184\167 (All)")
            r_v42_199:Refresh(r_v2_1413, r_v5_1676)
            local r_v14_1851 = r_v40_42.auto_skill_boss_unit
            local r_v8_2142 = (r_v14_1851 ~= "") and (r_v40_42.auto_skill_boss_unit)
            local r_v5_1677 = r_v8_2142 or ("\224\184\151\224\184\184\224\184\129\224\184\149\224\184\177\224\184\167 (All)")
            r_v45_178:Refresh(r_v2_1413, r_v5_1677)
            local r_v14_1854 = r_v40_42.air_unit_name
            local r_v8_2144 = (r_v14_1854 ~= "") and (r_v40_42.air_unit_name)
            local r_v5_1678 = r_v8_2144 or ("\224\185\132\224\184\161\224\185\136\224\185\132\224\184\148\224\185\137\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129 (None)")
            r_v47_197:Refresh(r_v10_902, r_v5_1678)
            r_v38_181:Refresh(r_v10_902, "\224\185\132\224\184\161\224\185\136\224\185\132\224\184\148\224\185\137\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129 (None)")
            r_v67_92("\224\184\173\224\184\177\224\184\155\224\185\128\224\184\148\224\184\149", "\224\184\148\224\184\182\224\184\135\224\184\163\224\184\178\224\184\162\224\184\138\224\184\183\224\185\136\224\184\173\224\184\136\224\184\178\224\184\129\224\184\170\224\184\165\224\185\135\224\184\173\224\184\149\224\184\130\224\184\173\224\184\135\224\184\132\224\184\184\224\184\147\224\184\170\224\184\179\224\185\128\224\184\163\224\185\135\224\184\136!", 3)
        end)
        T_Stop:AddLabel("\240\159\155\145 \224\185\128\224\184\135\224\184\183\224\185\136\224\184\173\224\184\153\224\185\132\224\184\130\224\184\129\224\184\178\224\184\163\224\184\171\224\184\162\224\184\184\224\184\148\224\184\154\224\184\173\224\184\151")
        local r_v38_187 = T_Stop
        local r_v36_148 = r_v40_42.stop_max_runs_enable
        r_v38_187:AddToggle("\224\184\171\224\184\162\224\184\184\224\184\148\224\185\128\224\184\161\224\184\183\224\185\136\224\184\173\224\184\132\224\184\163\224\184\154\224\184\136\224\184\179\224\184\153\224\184\167\224\184\153\224\184\163\224\184\173\224\184\154", "\224\185\128\224\184\161\224\184\183\224\185\136\224\184\173\224\185\128\224\184\165\224\185\136\224\184\153\224\184\136\224\184\154\224\184\132\224\184\163\224\184\154 X \224\184\163\224\184\173\224\184\154 \224\184\136\224\184\176\224\185\128\224\184\149\224\184\176\224\184\173\224\184\173\224\184\129\224\185\128\224\184\129\224\184\161\224\184\151\224\184\177\224\184\153\224\184\151\224\184\181", r_v36_148, function(r_v10_903)
            r_v40_42.stop_max_runs_enable = r_v10_903
            Save()
            r_v10_903 = nil
        end)
        local r_v38_188 = T_Stop
        local r_v55_134 = tostring(r_v40_42.stop_max_runs)
        local r_v53_161 = "\224\184\136\224\184\179\224\184\153\224\184\167\224\184\153\224\184\163\224\184\173\224\184\154\224\184\151\224\184\181\224\185\136\224\184\149\224\185\137\224\184\173\224\184\135\224\184\129\224\184\178\224\184\163 (" .. (r_v55_134 .. ")")
        r_v38_188:AddTextbox(r_v53_161, function(r_v10_904)
            local r_v6_1981 = tonumber(r_v10_904)
            r_v40_42.stop_max_runs = r_v6_1981 or 10
            Save()
            r_v10_904 = nil
        end)
        local r_v38_189 = T_Stop
        local r_v55_137 = tostring(r_v40_42.current_runs)
        local r_v53_162 = "\224\184\163\224\184\181\224\185\128\224\184\139\224\185\135\224\184\149\224\184\149\224\184\177\224\184\167\224\184\153\224\184\177\224\184\154\224\184\163\224\184\173\224\184\154 (" .. (r_v55_137 .. ")")
        r_v38_189:AddButton(r_v53_162, function()
            r_v40_42.current_runs = 0
            Save()
            r_v67_92("\224\184\163\224\184\181\224\185\128\224\184\139\224\185\135\224\184\149", "\224\184\163\224\184\181\224\185\128\224\184\139\224\185\135\224\184\149\224\184\149\224\184\177\224\184\167\224\184\153\224\184\177\224\184\154\224\185\128\224\184\163\224\184\181\224\184\162\224\184\154\224\184\163\224\185\137\224\184\173\224\184\162", 3)
        end)
        local r_v38_190 = T_Stop
        local r_v36_155 = r_v40_42.stop_at_wave_enable
        r_v38_190:AddToggle("\224\184\173\224\184\173\224\184\129\224\185\128\224\184\129\224\184\161\224\185\128\224\184\161\224\184\183\224\185\136\224\184\173\224\184\150\224\184\182\224\184\135\224\185\128\224\184\167\224\184\159 (\224\184\159\224\184\178\224\184\163\224\185\140\224\184\161/\224\185\132\224\184\149\224\185\136\224\184\171\224\184\173)", "\224\185\128\224\184\149\224\184\176\224\184\173\224\184\173\224\184\129\224\185\128\224\184\161\224\184\183\224\185\136\224\184\173\224\184\150\224\184\182\224\184\135\224\185\128\224\184\167\224\184\159\224\184\151\224\184\181\224\185\136\224\184\129\224\184\179\224\184\171\224\184\153\224\184\148 (\224\184\163\224\184\176\224\184\154\224\184\154 Rejoin \224\184\136\224\184\176\224\184\158\224\184\178\224\185\128\224\184\130\224\185\137\224\184\178\224\185\131\224\184\171\224\184\161\224\185\136)", r_v36_155, function(r_v10_908)
            r_v40_42.stop_at_wave_enable = r_v10_908
            Save()
            if r_v10_908 then
                task.spawn(AutoWaveStopLoop)
            end
            r_v10_908 = nil
        end)
        local r_v46_205 = T_Stop:AddTextbox("\224\185\128\224\184\167\224\184\159\224\185\128\224\184\155\224\185\137\224\184\178\224\184\171\224\184\161\224\184\178\224\184\162\224\184\151\224\184\181\224\185\136\224\184\149\224\185\137\224\184\173\224\184\135\224\184\129\224\184\178\224\184\163\224\185\131\224\184\171\224\185\137\224\184\173\224\184\173\224\184\129 (\224\185\128\224\184\138\224\185\136\224\184\153 50)...", function(r_v10_909)
            local r_v6_1989 = tonumber(r_v10_909)
            r_v40_42.stop_at_wave_target = r_v6_1989 or 50
            Save()
            r_v10_909 = nil
        end)
        local r_v53_165 = tostring
        local r_v55_142 = r_v40_42.stop_at_wave_target
        local r_v36_157 = r_v55_142 or 50
        r_v46_205:Set(r_v53_165(r_v36_157))
        local r_v38_195 = T_Stop
        local r_v36_160 = r_v40_42.stop_max_losses_enable
        r_v38_195:AddToggle("\224\184\171\224\184\162\224\184\184\224\184\148\224\184\154\224\184\173\224\184\151\224\185\128\224\184\161\224\184\183\224\185\136\224\184\173\224\185\129\224\184\158\224\185\137\224\184\132\224\184\163\224\184\154 X \224\184\149\224\184\178", "\224\184\155\224\185\137\224\184\173\224\184\135\224\184\129\224\184\177\224\184\153\224\184\129\224\184\178\224\184\163\224\184\165\224\184\135\224\184\148\224\184\177\224\184\153\224\184\165\224\185\137\224\184\161\224\185\128\224\184\171\224\184\165\224\184\167\224\184\167\224\184\153\224\184\165\224\184\185\224\184\155", r_v36_160, function(r_v10_910)
            r_v40_42.stop_max_losses_enable = r_v10_910
            Save()
            r_v10_910 = nil
        end)
        local r_v38_196 = T_Stop
        local r_v55_148 = tostring(r_v40_42.stop_max_losses_target or 3)
        local r_v53_167 = "\224\185\129\224\184\158\224\185\137\224\184\149\224\184\180\224\184\148\224\184\129\224\184\177\224\184\153\224\184\129\224\184\181\224\185\136\224\184\149\224\184\178\224\185\131\224\184\171\224\185\137\224\184\173\224\184\173\224\184\129\224\185\128\224\184\129\224\184\161? (" .. (r_v55_148 .. ")")
        local r_v46_213 = r_v38_196:AddTextbox(r_v53_167, function(r_v10_911)
            local r_v6_1993 = tonumber(r_v10_911)
            r_v40_42.stop_max_losses_target = r_v6_1993 or 3
            Save()
            r_v10_911 = nil
        end)
        local r_v53_168 = tostring
        local r_v55_149 = r_v40_42.stop_max_losses_target
        local r_v36_163 = r_v55_149 or 3
        r_v46_213:Set(r_v53_168(r_v36_163))
        local r_v38_200 = T_Stop
        local r_v55_152 = tostring(r_v40_42.current_losses or 0)
        local r_v53_169 = "\224\184\163\224\184\181\224\185\128\224\184\139\224\185\135\224\184\149\224\184\136\224\184\179\224\184\153\224\184\167\224\184\153\224\184\129\224\184\178\224\184\163\224\185\129\224\184\158\224\185\137 (" .. (r_v55_152 .. ")")
        r_v38_200:AddButton(r_v53_169, function()
            r_v40_42.current_losses = 0
            Save()
            r_v67_92("\224\184\163\224\184\181\224\185\128\224\184\139\224\185\135\224\184\149", "\224\184\163\224\184\181\224\185\128\224\184\139\224\185\135\224\184\149\224\184\153\224\184\177\224\184\154\224\184\129\224\184\178\224\184\163\224\185\129\224\184\158\224\185\137\224\185\128\224\184\163\224\184\181\224\184\162\224\184\154\224\184\163\224\185\137\224\184\173\224\184\162", 3)
        end)
        local r_v38_201 = T_Stop
        local r_v36_168 = r_v40_42.stop_item_drop_enable
        r_v38_201:AddToggle("\224\184\171\224\184\162\224\184\184\224\184\148\224\185\128\224\184\161\224\184\183\224\185\136\224\184\173\224\184\148\224\184\163\224\184\173\224\184\155\224\184\130\224\184\173\224\184\135\224\184\151\224\184\181\224\185\136\224\184\149\224\185\137\224\184\173\224\184\135\224\184\129\224\184\178\224\184\163", "\224\184\158\224\184\180\224\184\161\224\184\158\224\185\140\224\184\138\224\184\183\224\185\136\224\184\173\224\185\132\224\184\173\224\185\128\224\184\151\224\184\161 \224\184\150\224\185\137\224\184\178\224\184\148\224\184\163\224\184\173\224\184\155\224\184\155\224\184\184\224\185\138\224\184\154 \224\184\171\224\184\162\224\184\184\224\184\148\224\185\128\224\184\130\224\185\137\224\184\178\224\184\148\224\185\136\224\184\178\224\184\153\224\184\151\224\184\177\224\184\153\224\184\151\224\184\181", r_v36_168, function(r_v10_915)
            r_v40_42.stop_item_drop_enable = r_v10_915
            Save()
            r_v10_915 = nil
        end)
        local r_v46_225 = T_Stop:AddTextbox("\224\184\138\224\184\183\224\185\136\224\184\173\224\185\132\224\184\173\224\185\128\224\184\151\224\184\161\224\184\148\224\184\163\224\184\173\224\184\155...", function(r_v10_916)
            r_v40_42.stop_item_name = r_v10_916
            Save()
            r_v10_916 = nil
        end)
        local r_v53_172 = r_v40_42.stop_item_name
        r_v46_225:Set(r_v53_172)
        T_Stop:AddLabel("\240\159\147\141 \224\184\149\224\184\177\224\185\137\224\184\135\224\184\132\224\185\136\224\184\178\224\184\136\224\184\184\224\184\148\224\185\128\224\184\129\224\184\180\224\184\148 (Custom Spawn)")
        local r_v38_207 = T_Stop
        local r_v36_174 = r_v40_42.custom_spawn_enable
        r_v38_207:AddToggle("\224\185\128\224\184\155\224\184\180\224\184\148\224\185\131\224\184\138\224\185\137\224\184\167\224\184\178\224\184\163\224\185\140\224\184\155\224\184\136\224\184\184\224\184\148\224\185\128\224\184\129\224\184\180\224\184\148", "\224\184\158\224\184\173\224\185\128\224\184\130\224\185\137\224\184\178\224\184\148\224\185\136\224\184\178\224\184\153\224\184\161\224\184\178 \224\184\136\224\184\176\224\184\167\224\184\178\224\184\163\224\185\140\224\184\155\224\184\161\224\184\178\224\184\149\224\184\179\224\185\129\224\184\171\224\184\153\224\185\136\224\184\135\224\184\151\224\184\181\224\185\136\224\185\128\224\184\139\224\184\159\224\185\132\224\184\167\224\185\137", r_v36_174, function(r_v10_917)
            r_v40_42.custom_spawn_enable = r_v10_917
            Save()
            r_v10_917 = nil
        end)
        T_Stop:AddButton("\240\159\147\141 \224\184\154\224\184\177\224\184\153\224\184\151\224\184\182\224\184\129\224\184\149\224\184\179\224\185\129\224\184\171\224\184\153\224\185\136\224\184\135\224\184\136\224\184\184\224\184\148\224\185\128\224\184\129\224\184\180\224\184\148 (\224\184\162\224\184\183\224\184\153\224\184\149\224\184\163\224\184\135\224\184\153\224\184\181\224\185\137)", function()
            if (not r_v71_75()) then
                r_v40_42.custom_spawn_cframe = tostring(r_v22_34.Character.HumanoidRootPart.CFrame)
                Save()
                r_v67_92("\224\184\136\224\184\184\224\184\148\224\185\128\224\184\129\224\184\180\224\184\148", "\224\184\154\224\184\177\224\184\153\224\184\151\224\184\182\224\184\129 CFrame \224\184\136\224\184\184\224\184\148\224\185\128\224\184\129\224\184\180\224\184\148\224\185\128\224\184\163\224\184\181\224\184\162\224\184\154\224\184\163\224\185\137\224\184\173\224\184\162!", 4)
            else
                r_v67_92("\224\184\136\224\184\184\224\184\148\224\185\128\224\184\129\224\184\180\224\184\148", "\224\184\149\224\185\137\224\184\173\224\184\135\224\184\173\224\184\162\224\184\185\224\185\136\224\185\131\224\184\153\224\184\148\224\185\136\224\184\178\224\184\153\224\184\150\224\184\182\224\184\135\224\184\136\224\184\176\224\185\128\224\184\139\224\184\159\224\185\132\224\184\148\224\185\137", 3)
            end
        end)
        T_Lobby:AddButton("\240\159\144\137 \224\184\167\224\184\178\224\184\163\224\185\140\224\184\155\224\185\132\224\184\155\224\184\136\224\184\184\224\184\148\224\184\130\224\184\173\224\184\158\224\184\163\224\185\128\224\184\151\224\184\158\224\185\128\224\184\136\224\185\137\224\184\178\224\184\161\224\184\177\224\184\135\224\184\129\224\184\163 (\224\185\128\224\184\137\224\184\158\224\184\178\224\184\176\224\185\130\224\184\165\224\184\129 1)", function()
            if (r_v69_100() == 1) then
                local r_v1_2111 = r_v22_34.Character.HumanoidRootPart
                r_v1_2111.CFrame = CFrame.new((-428.534881999999982), 180.653686999999991, (-2072.768549999999777), (-0.998923421), (-0.000000054851522), 0.0463890284, (-0.000000059199262), 1, (-0.000000092349616), (-0.0463890284), (-0.000000094996395), (-0.998923421))
            else
                r_v67_92("\224\184\130\224\185\137\224\184\173\224\184\156\224\184\180\224\184\148\224\184\158\224\184\165\224\184\178\224\184\148", "\224\184\167\224\184\178\224\184\163\224\185\140\224\184\155\224\184\130\224\184\173\224\184\158\224\184\163\224\185\131\224\184\138\224\185\137\224\185\132\224\184\148\224\185\137\224\185\131\224\184\153\224\185\130\224\184\165\224\184\129 1 \224\185\128\224\184\151\224\185\136\224\184\178\224\184\153\224\184\177\224\185\137\224\184\153!", 3)
            end
        end)
        T_Lobby:AddLabel("\240\159\154\170 \224\185\128\224\184\151\224\185\128\224\184\165\224\184\158\224\184\173\224\184\163\224\185\140\224\184\149\224\184\165\224\184\177\224\184\148 (Teleport Hub)")
        T_Lobby:AddButton("\224\184\167\224\184\178\224\184\155\224\185\132\224\184\155\224\184\171\224\184\153\224\185\137\224\184\178\224\185\130\224\184\171\224\184\161\224\184\148 Adventure", function()
            if (r_v69_100() == 1) then
                local r_v1_2114 = r_v22_34.Character.HumanoidRootPart
                r_v1_2114.CFrame = r_v25_22.W1_Story
            else
                local r_v1_2115 = r_v22_34.Character.HumanoidRootPart
                r_v1_2115.CFrame = r_v25_22.W2_Adventure
            end
        end)
        T_Lobby:AddButton("\224\184\167\224\184\178\224\184\155\224\185\132\224\184\155\224\184\171\224\184\153\224\185\137\224\184\178\224\185\130\224\184\171\224\184\161\224\184\148 Story", function()
            if (r_v69_100() == 1) then
                local r_v1_2117 = r_v22_34.Character.HumanoidRootPart
                r_v1_2117.CFrame = r_v25_22.W1_Story
            else
                local r_v1_2118 = r_v22_34.Character.HumanoidRootPart
                r_v1_2118.CFrame = r_v25_22.W2_Story
            end
        end)
        T_Lobby:AddButton("\224\184\167\224\184\178\224\184\155\224\185\132\224\184\155\224\184\171\224\184\153\224\185\137\224\184\178\224\185\130\224\184\171\224\184\161\224\184\148 Infinite", function()
            if (r_v69_100() == 1) then
                local r_v1_2120 = r_v22_34.Character.HumanoidRootPart
                r_v1_2120.CFrame = r_v25_22.W1_Infinite
            else
                local r_v1_2121 = r_v22_34.Character.HumanoidRootPart
                r_v1_2121.CFrame = r_v25_22.W2_Infinite
            end
        end)
        T_Lobby:AddButton("\224\184\167\224\184\178\224\184\155\224\185\132\224\184\155\224\184\136\224\184\184\224\184\148\224\184\139\224\184\183\224\185\137\224\184\173/\224\184\150\224\184\173\224\184\148\224\184\173\224\184\173\224\184\159 (Orb)", function()
            if (r_v69_100() == 1) then
                local r_v1_2123 = r_v22_34.Character.HumanoidRootPart
                r_v1_2123.CFrame = r_v25_22.W1_Orb
            else
                r_v67_92("\224\184\167\224\184\178\224\184\163\224\185\140\224\184\155", "\224\184\132\224\184\184\224\184\147\224\184\149\224\185\137\224\184\173\224\184\135\224\184\173\224\184\162\224\184\185\224\185\136\224\185\131\224\184\153 World 1 \224\184\129\224\185\136\224\184\173\224\184\153!", 3)
            end
        end)
        T_Lobby:AddButton("\224\184\167\224\184\178\224\184\155\224\185\132\224\184\155\224\184\171\224\184\173\224\184\132\224\184\173\224\184\162 (Tower)", function()
            if (r_v69_100() == 1) then
                local r_v1_2126 = r_v22_34.Character.HumanoidRootPart
                r_v1_2126.CFrame = r_v25_22.W1_Tower
            else
                r_v67_92("\224\184\167\224\184\178\224\184\163\224\185\140\224\184\155", "\224\184\132\224\184\184\224\184\147\224\184\149\224\185\137\224\184\173\224\184\135\224\184\173\224\184\162\224\184\185\224\185\136\224\185\131\224\184\153 World 1 \224\184\129\224\185\136\224\184\173\224\184\153!", 3)
            end
        end)
        T_Lobby:AddButton("\224\184\167\224\184\178\224\184\155\224\185\132\224\184\155 Tournament", function()
            if (r_v69_100() == 1) then
                local r_v1_2129 = r_v22_34.Character.HumanoidRootPart
                r_v1_2129.CFrame = r_v25_22.W1_Tournament
            else
                r_v67_92("\224\184\167\224\184\178\224\184\163\224\185\140\224\184\155", "\224\184\132\224\184\184\224\184\147\224\184\149\224\185\137\224\184\173\224\184\135\224\184\173\224\184\162\224\184\185\224\185\136\224\185\131\224\184\153 World 1 \224\184\129\224\185\136\224\184\173\224\184\153!", 3)
            end
        end)
        T_Lobby:AddLabel("\226\173\144 \224\184\149\224\184\185\224\185\137\224\184\170\224\184\184\224\185\136\224\184\161\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180 (Auto Summon)")
        local r_v38_218 = T_Lobby
        local r_v36_187 = r_v40_42.auto_summon_enable
        r_v38_218:AddToggle("\224\185\128\224\184\155\224\184\180\224\184\148\224\185\131\224\184\138\224\185\137\224\184\135\224\184\178\224\184\153\224\184\149\224\184\185\224\185\137\224\184\170\224\184\184\224\185\136\224\184\161\224\184\173\224\184\173\224\185\130\224\184\149\224\185\137", "\224\184\149\224\184\177\224\184\148\224\184\173\224\184\153\224\184\180\224\185\128\224\184\161\224\184\138\224\184\177\224\185\136\224\184\153 \224\185\129\224\184\165\224\184\176\224\184\170\224\184\184\224\185\136\224\184\161\224\184\149\224\184\178\224\184\161\224\185\128\224\184\135\224\184\183\224\185\136\224\184\173\224\184\153\224\185\132\224\184\130", r_v36_187, function(r_v10_974)
            r_v40_42.auto_summon_enable = r_v10_974
            Save()
            if r_v10_974 then
                task.spawn(AutoSummonLoop)
            end
            r_v10_974 = nil
        end)
        local r_v46_281 = T_Lobby:AddDropdown("\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129\224\184\149\224\184\185\224\185\137\224\184\151\224\184\181\224\185\136\224\184\136\224\184\176\224\184\170\224\184\184\224\185\136\224\184\161 (Banner)", r_v25_23, function(r_v10_975)
            r_v40_42.auto_summon_banner = r_v10_975
            Save()
            r_v10_975 = nil
        end)
        local r_v53_187 = (r_v40_42.auto_summon_banner) or ("\224\184\149\224\184\185\224\185\137 X (Standard)")
        r_v46_281:Set(r_v53_187)
        local r_v38_223 = T_Lobby
        local r_v52_162 = r_v40_42.auto_summon_amount
        local r_v55_180 = function(r_v10_976)
            local r_v5_1762 = (r_v10_976 >= 5) and 10
            r_v40_42.auto_summon_amount = r_v5_1762 or 1
            Save()
            r_v10_976 = nil
        end
        local r_v51_183 = r_v52_162 or 1
        r_v38_223:AddSlider("\224\184\170\224\184\184\224\185\136\224\184\161\224\184\129\224\184\181\224\185\136\224\184\132\224\184\163\224\184\177\224\185\137\224\184\135\224\184\149\224\185\136\224\184\173\224\184\163\224\184\173\224\184\154?", 1, 10, r_v51_183, r_v55_180)
        T_Lobby:AddLabel("\240\159\142\129 \224\184\163\224\184\177\224\184\154\224\184\163\224\184\178\224\184\135\224\184\167\224\184\177\224\184\165\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180 (Auto Claim Tasks)")
        local r_v38_225 = T_Lobby
        local r_v36_197 = r_v40_42.auto_claim_tasks
        r_v38_225:AddToggle("\224\185\128\224\184\155\224\184\180\224\184\148\224\184\163\224\184\177\224\184\154\224\184\130\224\184\173\224\184\135\224\184\163\224\184\178\224\184\135\224\184\167\224\184\177\224\184\165\224\185\128\224\184\132\224\184\167\224\184\170\224\184\151\224\184\177\224\185\137\224\184\135\224\184\171\224\184\161\224\184\148", "\224\184\148\224\184\178\224\185\128\224\184\161\224\184\136, \224\185\128\224\184\165\224\185\128\224\184\167\224\184\165, \224\185\128\224\184\167\224\184\159, \224\184\173\224\184\181\224\185\130\224\184\167, \224\184\154\224\184\173\224\184\170, \224\184\155\224\184\163\224\184\176\224\184\136\224\184\179\224\184\167\224\184\177\224\184\153", r_v36_197, function(r_v10_977)
            r_v40_42.auto_claim_tasks = r_v10_977
            Save()
            if r_v10_977 then
                task.spawn(AutoClaimTasksLoop)
            end
            r_v10_977 = nil
        end)
        T_Lobby:AddLabel("\240\159\164\150 \224\184\163\224\184\176\224\184\154\224\184\154\224\184\139\224\184\180\224\184\135\224\184\132\224\185\140\224\184\155\224\184\178\224\184\163\224\185\140\224\184\149\224\184\181\224\185\137 / \224\184\132\224\184\184\224\184\161\224\185\132\224\184\173\224\184\148\224\184\181\224\185\132\224\184\129\224\185\136 (Alt Sync)")
        local r_v46_302 = T_Lobby:AddDropdown("\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129\224\184\154\224\184\151\224\184\154\224\184\178\224\184\151\224\184\130\224\184\173\224\184\135\224\184\136\224\184\173\224\184\160\224\184\178\224\184\158\224\184\153\224\184\181\224\185\137", {
            "\224\185\128\224\184\165\224\185\136\224\184\153\224\185\128\224\184\148\224\184\181\224\185\136\224\184\162\224\184\167 (Solo)",
            "\224\184\171\224\184\177\224\184\167\224\184\149\224\184\181\224\185\137 (Master)",
            "\224\184\156\224\184\185\224\185\137\224\184\149\224\184\178\224\184\161 (Alt)"
        }, function(r_v10_978)
            r_v40_42.sync_role = r_v10_978
            Save()
            if (r_v10_978 == "\224\184\171\224\184\177\224\184\167\224\184\149\224\184\181\224\185\137 (Master)") then
                task.spawn(MasterSyncLoop)
            else
                if (r_v10_978 == "\224\184\156\224\184\185\224\185\137\224\184\149\224\184\178\224\184\161 (Alt)") then
                    task.spawn(AltSyncLoop)
                end
            end
            r_v10_978 = nil
        end)
        local r_v53_194 = (r_v40_42.sync_role) or ("\224\185\128\224\184\165\224\185\136\224\184\153\224\185\128\224\184\148\224\184\181\224\185\136\224\184\162\224\184\167 (Solo)")
        r_v46_302:Set(r_v53_194)
        T_Lobby:AddLabel("\240\159\145\165 \224\184\167\224\184\178\224\184\155\224\184\171\224\184\178\224\184\156\224\184\185\224\185\137\224\185\128\224\184\165\224\185\136\224\184\153 (Player Teleport)")
        local r_v38_232 = {}
        local r_v46_307 = pairs
        local r_v51_196 = game.Players
        local r_v52_178 = r_v51_196.GetPlayers
        local r_v55_194 = {
            r_v52_178(r_v51_196)
        }
        for r_v46_308, r_v51_199 in r_v46_307(unpack(r_v55_194)) do
            if (r_v51_199 ~= r_v22_34) then
                table.insert(r_v38_232, r_v51_199.Name)
            end
        end
        if ((#r_v38_232) == 0) then
            table.insert(r_v38_232, "\224\185\132\224\184\161\224\185\136\224\184\161\224\184\181\224\184\132\224\184\153\224\184\173\224\184\183\224\185\136\224\184\153\224\185\131\224\184\153\224\185\128\224\184\139\224\184\180\224\184\163\224\185\140\224\184\159")
        end
        local r_v53_204 = T_Lobby:AddDropdown("\224\185\128\224\184\165\224\184\183\224\184\173\224\184\129\224\184\156\224\184\185\224\185\137\224\185\128\224\184\165\224\185\136\224\184\153", r_v38_232, function(r_v10_979)
            -- empty block
        end)
        T_Lobby:AddButton("\224\184\173\224\184\177\224\184\155\224\185\128\224\184\148\224\184\149\224\184\163\224\184\178\224\184\162\224\184\138\224\184\183\224\185\136\224\184\173", function()
            local r_v10_981 = {}
            local r_v1_2147 = pairs
            local r_v5_1770 = game.Players
            local r_v4_2506, r_v2_1529, r_v3_1560 = r_v1_2147(r_v5_1770.GetPlayers(r_v5_1770))
            local r_v5_1772 = r_v4_2506
            for r_v6_2071, r_v8_2227 in r_v5_1772, r_v2_1529, r_v3_1560 do
                if (r_v8_2227 ~= r_v22_34) then
                    table.insert(r_v10_981, r_v8_2227.Name)
                end
            end
            if ((#r_v10_981) == 0) then
                table.insert(r_v10_981, "\224\185\132\224\184\161\224\185\136\224\184\161\224\184\181\224\184\132\224\184\153\224\184\173\224\184\183\224\185\136\224\184\153\224\185\131\224\184\153\224\185\128\224\184\139\224\184\180\224\184\163\224\185\140\224\184\159")
            end
            r_v53_204:Refresh(r_v10_981)
        end)
        T_Lobby:AddButton("\224\184\167\224\184\178\224\184\155\224\185\132\224\184\155\224\184\171\224\184\178\224\184\156\224\184\185\224\185\137\224\185\128\224\184\165\224\185\136\224\184\153\224\184\153\224\184\181\224\185\137!", function()
            local r_v10_982 = "CurrentOption"
            r_v10_982 = r_v53_204[r_v10_982]
            local r_v4_2508 = r_v10_982 and (game.Players:FindFirstChild(r_v10_982))
            if r_v4_2508 then
                local r_v3_1570 = game
                local r_v4_2509 = r_v3_1570.Players[r_v10_982]
                local r_v2_1539 = "Character"
                r_v2_1539 = r_v4_2509[r_v2_1539]
                local r_v4_2510 = r_v2_1539 and (r_v2_1539:FindFirstChild(("HumanoidRootPart")))
                if r_v4_2510 then
                    local r_v1_2155 = r_v22_34.Character.HumanoidRootPart
                    local r_v5_1785 = r_v2_1539.HumanoidRootPart
                    r_v1_2155.CFrame = r_v5_1785.CFrame
                end
            end
        end)
        T_Lobby:AddLabel("\240\159\154\128 \224\185\128\224\184\130\224\185\137\224\184\178\224\184\148\224\185\136\224\184\178\224\184\153\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180")
        local r_v53_208 = T_Lobby
        local r_v55_206 = r_v40_42.auto_join_game
        r_v53_208:AddToggle("\224\185\128\224\184\130\224\185\137\224\184\178\224\184\148\224\185\136\224\184\178\224\184\153\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180", "\224\185\128\224\184\130\224\185\137\224\184\178\224\185\128\224\184\165\224\185\136\224\184\153\224\184\148\224\185\136\224\184\178\224\184\153\224\184\149\224\185\136\224\184\178\224\184\135\224\185\134 \224\184\149\224\184\178\224\184\161\224\184\129\224\184\178\224\184\163\224\184\149\224\184\177\224\185\137\224\184\135\224\184\132\224\185\136\224\184\178\224\184\148\224\185\137\224\184\178\224\184\153\224\184\165\224\185\136\224\184\178\224\184\135", r_v55_206, function(r_v10_983)
            r_v40_42.auto_join_game = r_v10_983
            Save()
            local r_v4_2516 = r_v10_983
            if r_v10_983 then
                r_v4_2516 = r_v71_75()
            end
            if r_v4_2516 then
                task.spawn(AutoJoinGame)
            end
            r_v10_983 = nil
        end)
        local r_v53_209 = T_Lobby
        local r_v55_209 = r_v40_42.auto_join_tower
        r_v53_209:AddToggle("\224\185\128\224\184\130\224\185\137\224\184\178\224\184\171\224\184\173\224\184\132\224\184\173\224\184\162\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180", "\224\184\165\224\184\184\224\184\162 Tower \224\185\130\224\184\171\224\184\161\224\184\148\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180", r_v55_209, function(r_v10_984)
            r_v40_42.auto_join_tower = r_v10_984
            Save()
            local r_v4_2522 = r_v10_984
            if r_v10_984 then
                r_v4_2522 = r_v71_75()
            end
            if r_v4_2522 then
                task.spawn(AutoTower)
            end
            r_v10_984 = nil
        end)
        local r_v53_210 = T_Lobby
        local r_v55_212 = r_v40_42.auto_evolve_exp
        r_v53_210:AddToggle("\224\184\167\224\184\180\224\184\167\224\184\177\224\184\146\224\184\153\224\184\178\224\184\129\224\184\178\224\184\163 EXP\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180", "\224\184\153\224\184\179\224\185\128\224\184\168\224\184\169 EXP \224\184\161\224\184\178\224\184\163\224\184\167\224\184\161\224\184\129\224\184\177\224\184\153\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180", r_v55_212, function(r_v10_985)
            r_v40_42.auto_evolve_exp = r_v10_985
            Save()
            local r_v4_2528 = r_v10_985
            if r_v10_985 then
                r_v4_2528 = r_v71_75()
            end
            if r_v4_2528 then
                task.spawn(AutoEvolveEXP)
            end
            r_v10_985 = nil
        end)
        local r_v53_211 = T_Lobby
        local r_v55_215 = r_v40_42.auto_skip_gui
        r_v53_211:AddToggle("\224\184\130\224\185\137\224\184\178\224\184\161\224\184\171\224\184\153\224\185\137\224\184\178\224\184\149\224\185\136\224\184\178\224\184\135\224\185\129\224\184\136\224\185\137\224\184\135\224\185\128\224\184\149\224\184\183\224\184\173\224\184\153", "\224\184\129\224\184\148\224\184\155\224\184\180\224\184\148\224\184\155\224\185\135\224\184\173\224\184\154\224\184\173\224\184\177\224\184\158\224\184\129\224\184\167\224\184\153\224\185\131\224\184\136\224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180", r_v55_215, function(r_v10_986)
            r_v40_42.auto_skip_gui = r_v10_986
            Save()
            if r_v10_986 then
                task.spawn(AutoSkipGUI)
            end
            r_v10_986 = nil
        end)
        T_Lobby:AddLabel("\226\143\179 \224\184\129\224\184\178\224\184\163\224\184\149\224\184\177\224\185\137\224\184\135\224\184\132\224\185\136\224\184\178\224\185\128\224\184\130\224\185\137\224\184\178\224\184\148\224\185\136\224\184\178\224\184\153")
        local r_v53_213 = T_Lobby
        local r_v52_207 = r_v40_42.auto_join_delay
        r_v53_213:AddSlider("\224\184\148\224\184\181\224\185\128\224\184\165\224\184\162\224\185\140\224\184\129\224\185\136\224\184\173\224\184\153\224\185\128\224\184\130\224\185\137\224\184\178\224\184\148\224\185\136\224\184\178\224\184\153 (\224\184\167\224\184\180)", 0, 60, r_v52_207, function(r_v10_987)
            r_v40_42.auto_join_delay = r_v10_987
            Save()
            r_v10_987 = nil
        end)
        local r_v54_257 = T_Lobby:AddDropdown("\224\185\130\224\184\171\224\184\161\224\184\148\224\184\151\224\184\181\224\185\136\224\184\149\224\185\137\224\184\173\224\184\135\224\184\129\224\184\178\224\184\163\224\185\128\224\184\130\224\185\137\224\184\178", {
            "Story",
            "Infinite",
            "Adventure"
        }, function(r_v10_988)
            r_v40_42.auto_join_mode = r_v10_988
            Save()
            r_v10_988 = nil
        end)
        local r_v36_221 = r_v40_42.auto_join_mode
        r_v54_257:Set(r_v36_221)
        local r_v53_218 = T_Lobby
        local r_v52_213 = r_v94_10()
        local r_v55_225 = r_v40_42.auto_join_story_level
        r_v53_218:AddSlider("\224\184\148\224\185\136\224\184\178\224\184\153 Story \224\184\163\224\184\176\224\184\148\224\184\177\224\184\154", 1, r_v52_213, r_v55_225, function(r_v10_989)
            r_v40_42.auto_join_story_level = r_v10_989
            Save()
            r_v10_989 = nil
        end)
        if (r_v49_54[r_v40_42.auto_join_infinite_level] == nil) then
            r_v40_42.auto_join_infinite_level = "-1"
            Save()
        end
        local r_v53_222 = T_Lobby
        local r_v55_230 = r_v56_60(r_v49_54)
        local r_v54_269 = r_v53_222:AddDropdown("\224\184\148\224\185\136\224\184\178\224\184\153\224\185\130\224\184\171\224\184\161\224\184\148 Infinite", r_v55_230, function(r_v10_990)
            local r_v6_2096 = {
                pairs(r_v49_54)
            }
            local r_v3_1597 = r_v6_2096[3]
            local r_v2_1569 = r_v6_2096[2]
            local r_v5_1798 = r_v6_2096[1]
            for r_v6_2096, r_v8_2251 in r_v5_1798, r_v2_1569, r_v3_1597 do
                if r_v8_2251 ~= r_v10_990 then
                    continue
                end
                r_v40_42.auto_join_infinite_level = r_v6_2096
                Save()
                break
            end
            r_v10_990 = nil
        end)
        local r_v36_228 = r_v49_54[r_v40_42.auto_join_infinite_level]
        r_v54_269:Set(r_v36_228)
        if (r_v49_55[r_v40_42.auto_join_adventure_level] == nil) then
            r_v40_42.auto_join_adventure_level = "-1133"
            Save()
        end
        local r_v53_229 = T_Lobby
        local r_v55_236 = r_v56_60(r_v49_55)
        local r_v54_277 = r_v53_229:AddDropdown("\224\184\148\224\185\136\224\184\178\224\184\153\224\185\130\224\184\171\224\184\161\224\184\148 Adventure", r_v55_236, function(r_v10_991)
            local r_v6_2097 = {
                pairs(r_v49_55)
            }
            local r_v2_1570 = r_v6_2097[2]
            local r_v3_1598 = r_v6_2097[3]
            local r_v5_1800 = r_v6_2097[1]
            for r_v6_2097, r_v8_2252 in r_v5_1800, r_v2_1570, r_v3_1598 do
                if r_v8_2252 ~= r_v10_991 then
                    continue
                end
                r_v40_42.auto_join_adventure_level = r_v6_2097
                Save()
                break
            end
            r_v10_991 = nil
        end)
        local r_v36_234 = r_v49_55[r_v40_42.auto_join_adventure_level]
        r_v54_277:Set(r_v36_234)
        T_Webhook:AddLabel("\240\159\146\172 \224\184\149\224\184\177\224\185\137\224\184\135\224\184\132\224\185\136\224\184\178\224\184\129\224\184\178\224\184\163\224\184\170\224\185\136\224\184\135\224\184\130\224\185\137\224\184\173\224\184\161\224\184\185\224\184\165 (Discord)")
        local r_v54_285 = T_Webhook:AddTextbox("Discord Webhook URL...", function(r_v10_992)
            r_v40_42.webhook_url = r_v10_992
            Save()
            r_v10_992 = nil
        end)
        local r_v36_237 = (r_v40_42.webhook_url) or ("")
        r_v54_285:Set(r_v36_237)
        local r_v54_289 = T_Webhook:AddTextbox("\224\184\165\224\184\180\224\185\137\224\184\135\224\184\129\224\185\140\224\184\163\224\184\185\224\184\155\224\184\160\224\184\178\224\184\158\224\184\130\224\184\153\224\184\178\224\184\148\224\185\131\224\184\171\224\184\141\224\185\136 (Image URL)...", function(r_v10_993)
            r_v40_42.webhook_image_url = r_v10_993
            Save()
            r_v10_993 = nil
        end)
        local r_v36_239 = (r_v40_42.webhook_image_url) or ("")
        r_v54_289:Set(r_v36_239)
        local r_v54_293 = T_Webhook:AddTextbox("Discord ID \224\184\170\224\184\179\224\184\171\224\184\163\224\184\177\224\184\154\224\184\155\224\184\180\224\184\135\224\185\128\224\184\163\224\184\181\224\184\162\224\184\129...", function(r_v10_994)
            r_v40_42.webhook_discord_id = r_v10_994
            Save()
            r_v10_994 = nil
        end)
        local r_v36_241 = (r_v40_42.webhook_discord_id) or ("")
        r_v54_293:Set(r_v36_241)
        local r_v53_246 = T_Webhook
        local r_v55_249 = r_v40_42.webhook_ping_user
        r_v53_246:AddToggle("\224\185\129\224\184\151\224\185\135\224\184\129\224\184\156\224\184\185\224\185\137\224\185\131\224\184\138\224\185\137 (Ping User)", "\224\184\163\224\184\177\224\184\153\224\184\132\224\184\179\224\184\170\224\184\177\224\185\136\224\184\135 @mention \224\185\128\224\184\161\224\184\183\224\185\136\224\184\173\224\184\170\224\185\136\224\184\135\224\184\130\224\185\137\224\184\173\224\184\132\224\184\167\224\184\178\224\184\161", r_v55_249, function(r_v10_995)
            r_v40_42.webhook_ping_user = r_v10_995
            Save()
            r_v10_995 = nil
        end)
        T_Webhook:AddLabel("\226\173\144 Webhook \224\184\170\224\184\179\224\184\171\224\184\163\224\184\177\224\184\154\224\184\149\224\184\185\224\185\137\224\184\170\224\184\184\224\185\136\224\184\161 (Summon)")
        local r_v54_305 = T_Webhook:AddTextbox("Discord URL (\224\184\170\224\184\184\224\185\136\224\184\161\224\184\149\224\184\177\224\184\167\224\184\165\224\184\176\224\184\132\224\184\163)...", function(r_v10_996)
            r_v40_42.webhook_summon_url = r_v10_996
            Save()
            r_v10_996 = nil
        end)
        local r_v36_245 = (r_v40_42.webhook_summon_url) or ("")
        r_v54_305:Set(r_v36_245)
        T_Webhook:AddButton("\224\184\151\224\184\148\224\184\170\224\184\173\224\184\154\224\184\170\224\185\136\224\184\135 Webhook \224\184\170\224\184\184\224\185\136\224\184\161\224\184\149\224\184\185\224\185\137", function()
            o_v7_16("\224\184\151\224\184\148\224\184\170\224\184\173\224\184\154\224\184\170\224\184\184\224\185\136\224\184\161\224\185\132\224\184\148\224\185\137: \224\185\130\224\184\129\224\184\132\224\184\185 (Ultra Instinct)")
        end)
        T_Webhook:AddLabel("\240\159\142\168 \224\184\170\224\184\181\224\185\129\224\184\154\224\184\153\224\185\128\224\184\153\224\184\173\224\184\163\224\185\140 Webhook (Embed Colors)")
        local r_v54_317 = T_Webhook:AddDropdown("\224\184\170\224\184\181\224\185\128\224\184\167\224\184\165\224\184\178\224\184\138\224\184\153\224\184\176 (Victory)", r_v49_57, function(r_v10_998)
            r_v40_42.webhook_win_color = r_v10_998
            Save()
            r_v10_998 = nil
        end)
        local r_v36_249 = (r_v40_42.webhook_win_color) or ("\224\185\128\224\184\130\224\184\181\224\184\162\224\184\167 (Green)")
        r_v54_317:Set(r_v36_249)
        local r_v36_253 = T_Webhook:AddDropdown("\224\184\170\224\184\181\224\185\128\224\184\167\224\184\165\224\184\178\224\185\129\224\184\158\224\185\137 (Defeat)", r_v49_57, function(r_v10_999)
            r_v40_42.webhook_lose_color = r_v10_999
            Save()
            r_v10_999 = nil
        end)
        local r_v51_261 = (r_v40_42.webhook_lose_color) or ("\224\185\129\224\184\148\224\184\135 (Red)")
        r_v36_253:Set(r_v51_261)
        T_Webhook:AddLabel("\240\159\146\128 \224\185\129\224\184\136\224\185\137\224\184\135\224\185\128\224\184\149\224\184\183\224\184\173\224\184\153\224\185\128\224\184\161\224\184\183\224\185\136\224\184\173\224\184\132\224\184\180\224\184\165\224\184\132\224\184\163\224\184\154\224\184\129\224\184\179\224\184\171\224\184\153\224\184\148")
        local r_v53_263 = T_Webhook
        local r_v56_219 = r_v40_42.webhook_kill_enable
        r_v53_263:AddToggle("\224\185\128\224\184\155\224\184\180\224\184\148\224\185\131\224\184\138\224\185\137\224\184\135\224\184\178\224\184\153\224\185\129\224\184\136\224\185\137\224\184\135\224\185\128\224\184\149\224\184\183\224\184\173\224\184\153\224\184\132\224\184\180\224\184\165\224\184\161\224\184\173\224\184\153", "\224\184\153\224\184\177\224\184\154\224\184\168\224\184\158\224\185\131\224\184\153\224\185\128\224\184\129\224\184\161\224\185\129\224\184\165\224\184\176\224\185\128\224\184\149\224\184\183\224\184\173\224\184\153", r_v56_219, function(r_v10_1000)
            r_v40_42.webhook_kill_enable = r_v10_1000
            Save()
            r_v10_1000 = nil
        end)
        local r_v51_273 = T_Webhook:AddTextbox("\224\184\136\224\184\179\224\184\153\224\184\167\224\184\153\224\184\132\224\184\180\224\184\165\224\184\151\224\184\181\224\185\136\224\184\149\224\185\137\224\184\173\224\184\135\224\184\129\224\184\178\224\184\163\224\185\131\224\184\171\224\185\137\224\185\128\224\184\149\224\184\183\224\184\173\224\184\153...", function(r_v10_1001)
            local r_v6_2109 = tonumber(r_v10_1001)
            r_v40_42.webhook_kill_target = r_v6_2109 or 5000
            Save()
            r_v10_1001 = nil
        end)
        local r_v55_267 = r_v40_42.webhook_kill_target
        r_v51_273:Set(r_v55_267)
        T_Webhook:AddButton("\224\184\151\224\184\148\224\184\170\224\184\173\224\184\154\224\184\170\224\185\136\224\184\135\224\184\130\224\185\137\224\184\173\224\184\132\224\184\167\224\184\178\224\184\161\224\185\128\224\184\167\224\185\135\224\184\154\224\184\174\224\184\184\224\184\132 (Premium)", function()
            r_v67_92("\224\185\128\224\184\167\224\185\135\224\184\154\224\184\174\224\184\184\224\184\132", "\224\184\129\224\184\179\224\184\165\224\184\177\224\184\135\224\184\170\224\185\136\224\184\135\224\184\130\224\185\137\224\184\173\224\184\132\224\184\167\224\184\178\224\184\161\224\184\151\224\184\148\224\184\170\224\184\173\224\184\154\224\185\129\224\184\154\224\184\154 Premium...", 3)
            local r_v1_2201 = string.char
            local r_v10_1005 = 96
            r_v10_1005 = r_v1_2201(r_v10_1005, 96, 96)
            local r_v8_2269 = "yaml\nMap: [\224\185\128\224\184\153\224\184\183\224\185\137\224\184\173\224\185\128\224\184\163\224\184\183\224\185\136\224\184\173\224\184\135] \224\185\128\224\184\165\224\185\128\224\184\167\224\184\165 1\nWave: 45\n" .. r_v10_1005
            local r_v6_2116 = r_v10_1005 .. r_v8_2269
            local r_v4_2579 = {
                ["name"] = "\240\159\151\186\239\184\143 **MATCH INFO**",
                ["value"] = r_v6_2116,
                ["inline"] = false
            }
            local r_v7_2153 = "diff\n+ \226\156\133 VICTORY\n" .. r_v10_1005
            local r_v8_2274 = r_v10_1005 .. r_v7_2153
            local r_v2_1597 = {
                ["name"] = "\226\154\148\239\184\143 **STATUS**",
                ["value"] = r_v8_2274,
                ["inline"] = true
            }
            local r_v9_2060 = "yaml\nIn-Game: 20 \224\184\153\224\184\178\224\184\151\224\184\181 45 \224\184\167\224\184\180\224\184\153\224\184\178\224\184\151\224\184\181\nReal   : 22 \224\184\153\224\184\178\224\184\151\224\184\181 02 \224\184\167\224\184\180\224\184\153\224\184\178\224\184\151\224\184\181\n" .. r_v10_1005
            local r_v7_2158 = r_v10_1005 .. r_v9_2060
            local r_v3_1618 = {
                ["name"] = "\226\143\177\239\184\143 **TIME ELAPSED**",
                ["value"] = r_v7_2158,
                ["inline"] = true
            }
            local r_v14_1892 = "ini\n[Gems]     +20\n[Gold]     +150\n[Stardust] +10\n[G-Coins]  +5\n" .. r_v10_1005
            local r_v9_2065 = r_v10_1005 .. r_v14_1892
            local r_v5_1822 = {
                ["name"] = "\240\159\146\142 **REWARDS & ECONOMY**",
                ["value"] = r_v9_2065,
                ["inline"] = true
            }
            local r_v11_1737 = "yaml\n\226\128\162 \224\184\153\224\184\178\224\184\163\224\184\185\224\185\130\224\184\149\224\184\176 (x1)\n\226\128\162 Star Dust (x2)\n" .. r_v10_1005
            local r_v14_1897 = r_v10_1005 .. r_v11_1737
            local r_v6_2123 = {
                ["name"] = "\240\159\142\129 **DROPS / REWARDS**",
                ["value"] = r_v14_1897,
                ["inline"] = true
            }
            local r_v17_853 = tostring((r_v92_10()) or 100)
            local r_v21_349 = tostring(r_v93_11())
            local r_v18_364 = "\n" .. r_v10_1005
            local r_v16_1006 = "\n\226\152\133 Star Pass   : Tier " .. (r_v21_349 .. r_v18_364)
            local r_v13_1633 = "fix\n\226\152\133 Level       : " .. (r_v17_853 .. r_v16_1006)
            local r_v11_1742 = r_v10_1005 .. r_v13_1633
            local r_v8_2281 = {
                ["name"] = "\240\159\147\136 **PLAYER PROGRESSION**",
                ["value"] = r_v11_1742,
                ["inline"] = false
            }
            r_v2_1597 = {
                r_v4_2579,
                r_v2_1597,
                r_v3_1618,
                r_v5_1822,
                r_v6_2123,
                r_v8_2281
            }
            SendWebhook(r_v2_1597)
        end)
        T_Webhook:AddLabel("\240\159\148\148 \224\185\128\224\184\155\224\184\180\224\184\148/\224\184\155\224\184\180\224\184\148 \224\184\170\224\185\136\224\184\135\224\184\163\224\184\178\224\184\162\224\184\135\224\184\178\224\184\153")
        local r_v53_270 = T_Webhook
        local r_v56_226 = r_v40_42.webhook_end_game
        r_v53_270:AddToggle("\224\184\170\224\185\136\224\184\135\224\185\129\224\184\136\224\185\137\224\184\135\224\185\128\224\184\149\224\184\183\224\184\173\224\184\153\224\184\149\224\184\173\224\184\153\224\184\136\224\184\154\224\185\128\224\184\129\224\184\161", "\224\185\129\224\184\136\224\185\137\224\184\135\224\184\156\224\184\165\224\184\165\224\184\177\224\184\158\224\184\152\224\185\140\224\184\130\224\184\173\224\184\135\224\185\129\224\184\149\224\185\136\224\184\165\224\184\176\224\185\128\224\184\129\224\184\161\224\185\132\224\184\155\224\184\151\224\184\181\224\185\136\224\184\148\224\184\180\224\184\170\224\184\132\224\184\173\224\184\163\224\185\140\224\184\148", r_v56_226, function(r_v10_1006)
            r_v40_42.webhook_end_game = r_v10_1006
            Save()
            r_v10_1006 = nil
        end)
        local r_v53_271 = T_Webhook
        local r_v56_229 = r_v40_42.webhook_exp_evolve
        r_v53_271:AddToggle("\224\184\170\224\185\136\224\184\135\224\185\129\224\184\136\224\185\137\224\184\135\224\185\128\224\184\149\224\184\183\224\184\173\224\184\153\224\184\149\224\184\173\224\184\153 Evo EXP", "\224\185\129\224\184\136\224\185\137\224\184\135\224\184\170\224\184\150\224\184\178\224\184\153\224\184\176\224\184\129\224\184\178\224\184\163\224\184\173\224\184\177\224\184\155\224\185\129\224\184\163\224\184\135\224\184\132\224\185\140 EXP", r_v56_229, function(r_v10_1007)
            r_v40_42.webhook_exp_evolve = r_v10_1007
            Save()
            r_v10_1007 = nil
        end)
        T_Misc:AddLabel("\240\159\141\177 \224\185\128\224\184\161\224\184\153\224\184\185\224\184\158\224\184\180\224\185\128\224\184\168\224\184\169 (Special)")
        T_Misc:AddButton("\240\159\141\177 \224\184\155\224\184\184\224\185\136\224\184\161\224\184\165\224\184\178\224\184\154", function()
            local r_v1_2207 = "https://raw.githubusercontent.com/nibamako08-code/xd/main/%E0%B9%82%E0%B8%94%E0%B8%99%E0%B8%81%E0%B8%B9%E0%B9%84%E0%B8%AD%E0%B8%A5%E0%B8%B2%E0%B8%9A%E0%B8%84%E0%B8%A7%E0%B8%A2.png"
            local r_v1_2208 = "starhub_github_larb.png"
            task.spawn(function()
                pcall(function()
                    local r_v10_1287 = getsynasset
                    local r_v4_3266 = r_v10_1287
                    if not r_v10_1287 then
                        r_v10_1287 = getcustomasset
                        r_v4_3266 = r_v10_1287
                    end
                    r_v10_1287 = r_v4_3266
                    local r_v2_2081 = request
                    local r_v4_3267 = r_v2_2081
                    if not r_v2_2081 then
                        local r_v5_2445 = http_request
                        r_v2_2081 = r_v5_2445
                        if not r_v5_2445 then
                            r_v2_2081 = (syn.request) or (fluxus.request)
                        end
                        r_v4_3267 = r_v2_2081
                    end
                    r_v2_2081 = r_v4_3267
                    if (not isfile(r_v1_2208)) then
                        r_v67_92("Larb Hub", "\224\184\129\224\184\179\224\184\165\224\184\177\224\184\135\224\185\130\224\184\171\224\184\165\224\184\148\224\184\163\224\184\185\224\184\155\224\184\150\224\184\178\224\184\167\224\184\163\224\184\136\224\184\178\224\184\129 GitHub...", 3)
                        local r_v3_2174 = "Url"
                        r_v3_2174 = r_v2_2081({
                            [r_v3_2174] = r_v1_2207,
                            ["Method"] = "GET"
                        })
                        if (r_v3_2174.StatusCode == 200) then
                            writefile(r_v1_2208, r_v3_2174.Body)
                        else
                            r_v67_92("\224\184\130\224\185\137\224\184\173\224\184\156\224\184\180\224\184\148\224\184\158\224\184\165\224\184\178\224\184\148", "\224\185\132\224\184\161\224\185\136\224\184\170\224\184\178\224\184\161\224\184\178\224\184\163\224\184\150\224\184\148\224\184\182\224\184\135\224\184\163\224\184\185\224\184\155\224\184\136\224\184\178\224\184\129 GitHub \224\185\132\224\184\148\224\185\137", 3)
                            return
                        end
                    end
                    local r_v3_2175 = r_v10_1287(r_v1_2208)
                    local r_v4_3274 = Instance.new("ScreenGui", r_v17_48)
                    r_v4_3274.Name = "StarHub_LarbShow"
                    r_v4_3274.DisplayOrder = 9999
                    r_v4_3274.IgnoreGuiInset = true
                    local r_v1_2855 = Instance.new
                    local r_v6_2862 = "ImageButton"
                    r_v6_2862 = r_v1_2855(r_v6_2862, r_v4_3274)
                    r_v6_2862.Size = UDim2.new(1, 0, 1, 0)
                    r_v6_2862.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                    r_v6_2862.BackgroundTransparency = 0.2
                    r_v6_2862.Image = r_v3_2175
                    local r_v8_3016 = Enum.ScaleType
                    r_v6_2862.ScaleType = r_v8_3016.Fit
                    r_v6_2862.MouseButton1Click:Connect(function()
                        r_v4_3274:Destroy()
                    end)
                end)
            end)
        end)
        T_Misc:AddLabel("\240\159\154\128 FPS Boost \224\185\129\224\184\154\224\184\154\224\184\174\224\184\178\224\184\163\224\185\140\224\184\148\224\184\132\224\184\173\224\184\163\224\185\140 (\224\184\170\224\184\179\224\184\171\224\184\163\224\184\177\224\184\154\224\184\159\224\184\178\224\184\163\224\185\140\224\184\161\224\184\171\224\184\153\224\184\177\224\184\129)")
        local r_v53_275 = T_Misc
        local r_v56_235 = r_v40_42.fps_wipe_map
        r_v53_275:AddToggle("\224\184\165\224\184\154\224\185\129\224\184\161\224\184\158\224\185\129\224\184\165\224\184\176\224\184\170\224\184\180\224\185\136\224\184\135\224\184\129\224\185\136\224\184\173\224\184\170\224\184\163\224\185\137\224\184\178\224\184\135 (\224\185\128\224\184\171\224\184\165\224\184\183\224\184\173\224\185\129\224\184\132\224\185\136\224\184\151\224\184\178\224\184\135\224\185\128\224\184\148\224\184\180\224\184\153)", "\224\185\128\224\184\132\224\184\165\224\184\181\224\184\162\224\184\163\224\185\140\224\185\130\224\184\159\224\184\165\224\185\128\224\184\148\224\184\173\224\184\163\224\185\140 Don't Care \224\185\129\224\184\165\224\184\176 Others", r_v56_235, function(r_v10_1011)
            r_v40_42.fps_wipe_map = r_v10_1011
            Save()
            if r_v10_1011 then
                task.spawn(WipeMapLoop)
            end
            r_v10_1011 = nil
        end)
        local r_v53_276 = T_Misc
        local r_v56_238 = r_v40_42.fps_strip_enemy
        r_v53_276:AddToggle("\224\184\165\224\184\154\224\184\149\224\184\177\224\184\167\224\184\161\224\184\173\224\184\153\224\184\170\224\185\128\224\184\149\224\184\173\224\184\163\224\185\140 (\224\185\128\224\184\171\224\184\165\224\184\183\224\184\173\224\185\129\224\184\132\224\185\136\224\184\171\224\184\177\224\184\167\224\184\129\224\184\177\224\184\154\224\184\165\224\184\179\224\184\149\224\184\177\224\184\167)", "\224\184\151\224\184\179\224\184\165\224\184\178\224\184\162\224\184\138\224\184\184\224\184\148\224\185\129\224\184\165\224\184\176\224\184\138\224\184\180\224\185\137\224\184\153\224\184\170\224\185\136\224\184\167\224\184\153\224\184\151\224\184\181\224\185\136\224\185\132\224\184\161\224\185\136\224\184\136\224\184\179\224\185\128\224\184\155\224\185\135\224\184\153 \224\184\155\224\185\137\224\184\173\224\184\135\224\184\129\224\184\177\224\184\153\224\185\129\224\184\165\224\184\132", r_v56_238, function(r_v10_1012)
            r_v40_42.fps_strip_enemy = r_v10_1012
            Save()
            if r_v10_1012 then
                task.spawn(StripEnemyLoop)
            end
            r_v10_1012 = nil
        end)
        T_Misc:AddLabel("\226\154\161 \224\184\155\224\184\163\224\184\176\224\184\170\224\184\180\224\184\151\224\184\152\224\184\180\224\184\160\224\184\178\224\184\158\224\185\128\224\184\132\224\184\163\224\184\183\224\185\136\224\184\173\224\184\135 (Performance)")
        local r_v53_278 = T_Misc
        local r_v56_242 = r_v40_42.smart_fps_saver_enable
        r_v53_278:AddToggle("\240\159\155\161\239\184\143 \224\184\163\224\184\176\224\184\154\224\184\154\224\184\129\224\184\177\224\184\153\224\184\132\224\184\173\224\184\161\224\184\132\224\185\137\224\184\178\224\184\135\224\184\173\224\184\177\224\184\136\224\184\137\224\184\163\224\184\180\224\184\162\224\184\176", "\224\184\150\224\185\137\224\184\178 FPS \224\184\149\224\184\129\224\185\128\224\184\129\224\184\180\224\184\153 10 \224\184\167\224\184\180\224\184\153\224\184\178\224\184\151\224\184\181 \224\184\136\224\184\176\224\185\128\224\184\155\224\184\180\224\184\148\224\185\130\224\184\171\224\184\161\224\184\148\224\184\137\224\184\184\224\184\129\224\185\128\224\184\137\224\184\180\224\184\153\224\185\131\224\184\171\224\185\137", r_v56_242, function(r_v10_1013)
            r_v40_42.smart_fps_saver_enable = r_v10_1013
            Save()
            if r_v10_1013 then
                task.spawn(AutoFpsSaverLoop)
            end
            r_v10_1013 = nil
        end)
        local r_v53_279 = T_Misc
        local r_v60_173 = r_v40_42
        local r_v58_199 = function(r_v10_1014)
            r_v40_42.smart_fps_saver_threshold = r_v10_1014
            Save()
            r_v10_1014 = nil
        end
        local r_v59_179 = r_v60_173.smart_fps_saver_threshold
        local r_v57_220 = r_v59_179 or 15
        r_v53_279:AddSlider("FPS \224\184\130\224\184\177\224\185\137\224\184\153\224\184\149\224\185\136\224\184\179\224\184\151\224\184\181\224\185\136\224\185\128\224\184\155\224\185\135\224\184\153\224\184\130\224\184\181\224\184\148\224\184\173\224\184\177\224\184\153\224\184\149\224\184\163\224\184\178\224\184\162", 5, 30, r_v57_220, r_v58_199)
        local r_v51_325 = T_Misc:AddDropdown("\224\185\130\224\184\171\224\184\161\224\184\148\224\184\137\224\184\184\224\184\129\224\185\128\224\184\137\224\184\180\224\184\153\224\184\151\224\184\181\224\185\136\224\184\136\224\184\176\224\185\131\224\184\138\224\185\137", {
            "\224\185\128\224\184\155\224\184\180\224\184\148\224\184\136\224\184\173\224\184\148\224\184\179 (Black Screen)",
            "\224\184\165\224\184\154\224\184\149\224\184\177\224\184\167\224\184\161\224\184\173\224\184\153\224\184\170\224\185\128\224\184\149\224\184\173\224\184\163\224\185\140 (Strip Enemy)"
        }, function(r_v10_1015)
            r_v40_42.smart_fps_saver_action = r_v10_1015
            Save()
            r_v10_1015 = nil
        end)
        local r_v55_281 = (r_v40_42.smart_fps_saver_action) or ("\224\185\128\224\184\155\224\184\180\224\184\148\224\184\136\224\184\173\224\184\148\224\184\179 (Black Screen)")
        r_v51_325:Set(r_v55_281)
        local r_v53_284 = T_Misc
        local r_v56_252 = r_v40_42.fps_boost
        r_v53_284:AddToggle("\224\184\165\224\184\148\224\184\129\224\184\163\224\184\178\224\184\159\224\184\180\224\184\129\224\185\128\224\184\158\224\184\180\224\185\136\224\184\161 FPS", "\224\184\165\224\184\154\224\184\170\224\184\180\224\185\136\224\184\135\224\185\132\224\184\161\224\185\136\224\184\136\224\184\179\224\185\128\224\184\155\224\185\135\224\184\153\224\184\173\224\184\173\224\184\129", r_v56_252, function(r_v10_1016)
            r_v40_42.fps_boost = r_v10_1016
            Save()
            if r_v10_1016 then
                pcall(function()
                    local r_v3_2092 = workspace
                    local r_v4_3166, r_v10_1240, r_v2_2013 = pairs(r_v3_2092.GetDescendants(r_v3_2092))
                    local r_v3_2094 = r_v4_3166
                    for r_v5_2360, r_v6_2749 in r_v3_2094, r_v10_1240, r_v2_2013 do
                        if r_v6_2749.IsA(r_v6_2749, "BasePart") then
                            local r_v7_2709 = Enum.Material
                            r_v6_2749.Material = r_v7_2709.SmoothPlastic
                        end
                        local r_v8_2899 = (r_v6_2749:IsA("Texture")) or (r_v6_2749:IsA(("Decal")))
                        if r_v8_2899 then
                            r_v6_2749:Destroy()
                        end
                    end
                end)
            end
            r_v10_1016 = nil
        end)
        local r_v53_285 = T_Misc
        local r_v56_255 = r_v40_42.hide_unit_effects
        r_v53_285:AddToggle("\224\184\155\224\184\180\224\184\148\224\185\128\224\184\173\224\184\159\224\185\128\224\184\159\224\184\132\224\184\149\224\184\177\224\184\167\224\184\165\224\184\176\224\184\132\224\184\163 (Hide Effects)", "\224\184\165\224\184\154\224\185\129\224\184\170\224\184\135/\224\184\173\224\184\173\224\184\163\224\185\136\224\184\178\224\184\163\224\184\173\224\184\154\224\184\149\224\184\177\224\184\167\224\184\165\224\184\176\224\184\132\224\184\163 (\224\184\160\224\184\178\224\184\158\224\185\129\224\184\161\224\184\158\224\184\162\224\184\177\224\184\135\224\184\170\224\184\167\224\184\162\224\185\128\224\184\171\224\184\161\224\184\183\224\184\173\224\184\153\224\185\128\224\184\148\224\184\180\224\184\161)", r_v56_255, function(r_v10_1017)
            r_v40_42.hide_unit_effects = r_v10_1017
            Save()
            if r_v10_1017 then
                task.spawn(o_v69_5)
            end
            r_v10_1017 = nil
        end)
        local r_v51_337 = T_Misc:AddTextbox("\224\184\136\224\184\179\224\184\129\224\184\177\224\184\148 FPS (\224\184\158\224\184\180\224\184\161\224\184\158\224\185\140 0 \224\185\128\224\184\158\224\184\183\224\185\136\224\184\173\224\184\165\224\184\183\224\185\136\224\184\153\224\184\155\224\184\163\224\184\181\224\185\138\224\184\148)", function(r_v10_1018)
            local r_v4_2623 = tonumber(r_v10_1018)
            if r_v4_2623 then
                r_v40_42.fps_cap = r_v4_2623
                local r_v3_1644 = function()
                    if (r_v4_2623 == 0) then
                        setfpscap(9999)
                    else
                        setfpscap(r_v4_2623)
                    end
                end
                Save()
                pcall(r_v3_1644)
                r_v67_92("\224\184\149\224\184\177\224\185\137\224\184\135\224\184\132\224\185\136\224\184\178", "\224\184\136\224\184\179\224\184\129\224\184\177\224\184\148 FPS \224\185\128\224\184\155\224\185\135\224\184\153: " .. (tostring(r_v4_2623)), 3)
            else
                r_v67_92("\224\184\130\224\185\137\224\184\173\224\184\156\224\184\180\224\184\148\224\184\158\224\184\165\224\184\178\224\184\148", "\224\184\129\224\184\163\224\184\184\224\184\147\224\184\178\224\185\131\224\184\170\224\185\136\224\184\149\224\184\177\224\184\167\224\185\128\224\184\165\224\184\130\224\185\128\224\184\151\224\185\136\224\184\178\224\184\153\224\184\177\224\185\137\224\184\153!", 3)
            end
            r_v10_1018 = nil
        end)
        local r_v56_257 = r_v40_42.fps_cap
        local r_v55_285 = r_v56_257 or 0
        r_v51_337:Set(r_v55_285)
        local r_v53_290 = T_Misc
        local r_v56_260 = r_v40_42.anti_afk
        r_v53_290:AddToggle("\224\184\155\224\185\137\224\184\173\224\184\135\224\184\129\224\184\177\224\184\153\224\184\171\224\184\165\224\184\184\224\184\148 (Anti-AFK)", "\224\184\129\224\184\177\224\184\153\224\185\130\224\184\163\224\184\154\224\184\165\224\185\135\224\184\173\224\184\129\224\184\139\224\185\140\224\184\149\224\184\177\224\184\148\224\185\128\224\184\138\224\184\183\224\185\136\224\184\173\224\184\161\224\184\149\224\185\136\224\184\173", r_v56_260, function(r_v10_1019)
            r_v40_42.anti_afk = r_v10_1019
            Save()
            if r_v10_1019 then
                local r_v1_2238 = pairs
                local r_v5_1845 = getconnections
                local r_v8_2303 = r_v22_34.Idled
                for r_v6_2149, r_v8_2304 in r_v1_2238(r_v5_1845(r_v8_2303)) do
                    r_v8_2304:Disable()
                end
            end
            r_v10_1019 = nil
        end)
        local r_v53_291 = T_Misc
        local r_v56_263 = r_v40_42.disable_3d_rendering
        r_v53_291:AddToggle("\224\184\155\224\184\180\224\184\148\224\184\129\224\184\178\224\184\163\224\185\128\224\184\163\224\184\153\224\185\128\224\184\148\224\184\173\224\184\163\224\185\140\224\184\160\224\184\178\224\184\158 3D", "\224\184\136\224\184\173\224\184\160\224\184\178\224\184\158\224\184\161\224\184\183\224\184\148 \224\184\138\224\185\136\224\184\167\224\184\162\224\184\155\224\184\163\224\184\176\224\184\171\224\184\162\224\184\177\224\184\148 CPU 100%", r_v56_263, function(r_v10_1020)
            r_v40_42.disable_3d_rendering = r_v10_1020
            Save()
            ToggleBlackScreen(r_v10_1020)
            r_v10_1020 = nil
        end)
        T_Misc:AddLabel("\240\159\145\129\239\184\143 \224\184\139\224\185\136\224\184\173\224\184\153\224\184\171\224\184\153\224\185\137\224\184\178\224\184\149\224\185\136\224\184\178\224\184\135 UI \224\184\173\224\184\177\224\184\149\224\185\130\224\184\153\224\184\161\224\184\177\224\184\149\224\184\180 (Auto Hide)")
        local r_v53_293 = T_Misc
        local r_v58_222 = r_v40_42.auto_hide_ui
        local r_v56_267 = r_v58_222 or false
        r_v53_293:AddToggle("\224\185\128\224\184\155\224\184\180\224\184\148\224\185\131\224\184\138\224\185\137\224\184\135\224\184\178\224\184\153 Auto Hide", "\224\185\128\224\184\161\224\184\183\224\185\136\224\184\173\224\185\132\224\184\161\224\185\136\224\184\161\224\184\181\224\184\129\224\184\178\224\184\163\224\184\130\224\184\162\224\184\177\224\184\154\224\185\128\224\184\161\224\184\178\224\184\170\224\185\140 \224\184\171\224\184\153\224\185\137\224\184\178\224\184\149\224\185\136\224\184\178\224\184\135\224\184\136\224\184\176\224\184\158\224\184\177\224\184\154\224\185\128\224\184\129\224\185\135\224\184\154\224\185\128\224\184\173\224\184\135", r_v56_267, function(r_v10_1021)
            r_v40_42.auto_hide_ui = r_v10_1021
            Save()
            r_v10_1021 = nil
        end)
        local r_v53_294 = T_Misc
        local r_v59_205 = r_v40_42.auto_hide_delay
        local r_v58_225 = function(r_v10_1022)
            r_v40_42.auto_hide_delay = r_v10_1022
            Save()
            r_v10_1022 = nil
        end
        local r_v57_251 = r_v59_205 or 15
        r_v53_294:AddSlider("\224\184\148\224\184\181\224\185\128\224\184\165\224\184\162\224\185\140\224\184\158\224\184\177\224\184\154\224\184\171\224\184\153\224\185\137\224\184\178\224\184\149\224\185\136\224\184\178\224\184\135 (\224\184\167\224\184\180\224\184\153\224\184\178\224\184\151\224\184\181)", 5, 120, r_v57_251, r_v58_225)
        T_Misc:AddLabel("\226\140\168\239\184\143 \224\184\132\224\184\181\224\184\162\224\185\140\224\184\165\224\184\177\224\184\148\224\185\128\224\184\155\224\184\180\224\184\148/\224\184\155\224\184\180\224\184\148\224\184\171\224\184\153\224\185\137\224\184\178\224\184\149\224\185\136\224\184\178\224\184\135 (Keybind)")
        local r_v53_296 = T_Misc
        local r_v52_300 = (r_v40_42.ui_toggle_key) or ("RightControl")
        r_v53_296:AddKeybind("\224\184\155\224\184\184\224\185\136\224\184\161\224\185\128\224\184\155\224\184\180\224\184\148/\224\184\155\224\184\180\224\184\148 UI (\224\184\132\224\185\136\224\184\178\224\185\128\224\184\163\224\184\180\224\185\136\224\184\161\224\184\149\224\185\137\224\184\153 RightControl)", r_v52_300, function(r_v10_1023)
            r_v40_42.ui_toggle_key = r_v10_1023
            Save()
            r_v67_92("\224\184\149\224\184\177\224\185\137\224\184\135\224\184\132\224\185\136\224\184\178\224\184\132\224\184\181\224\184\162\224\185\140\224\184\165\224\184\177\224\184\148", "\224\185\128\224\184\155\224\184\165\224\184\181\224\185\136\224\184\162\224\184\153\224\184\155\224\184\184\224\185\136\224\184\161\224\185\128\224\184\155\224\184\180\224\184\148/\224\184\155\224\184\180\224\184\148 UI \224\185\128\224\184\155\224\185\135\224\184\153: " .. r_v10_1023, 3)
            r_v10_1023 = nil
        end)
        local r_v56_275 = r_v69_100()
        local r_v55_293 = r_v56_275 ~= (-1)
        local r_v53_297 = r_v55_293
        if r_v55_293 then
            local r_v56_276 = r_v69_100()
            r_v53_297 = r_v56_276 ~= (-2)
        end
        if r_v53_297 then
            T_Misc:AddLabel("\240\159\142\173 \224\184\132\224\184\167\224\184\178\224\184\161\224\185\128\224\184\155\224\185\135\224\184\153\224\184\170\224\185\136\224\184\167\224\184\153\224\184\149\224\184\177\224\184\167 (\224\184\138\224\184\183\224\185\136\224\184\173\224\184\155\224\184\165\224\184\173\224\184\161)")
            local r_v53_299 = T_Misc
            local r_v56_280 = r_v40_42.anonymous_mode
            r_v53_299:AddToggle("\224\184\139\224\185\136\224\184\173\224\184\153\224\184\138\224\184\183\224\185\136\224\184\173\224\184\136\224\184\163\224\184\180\224\184\135 (Anonymous)", "\224\185\128\224\184\155\224\184\180\224\184\148\224\185\128\224\184\158\224\184\183\224\185\136\224\184\173\224\185\129\224\184\170\224\184\148\224\184\135\224\184\138\224\184\183\224\185\136\224\184\173\224\184\155\224\184\165\224\184\173\224\184\161", r_v56_280, function(r_v10_1024)
                r_v40_42.anonymous_mode = r_v10_1024
                Save()
                if r_v10_1024 then
                    o_v54_6()
                else
                    o_v53_5(false)
                end
                r_v10_1024 = nil
            end)
            local r_v51_378 = T_Misc:AddTextbox("\224\184\158\224\184\180\224\184\161\224\184\158\224\185\140\224\184\138\224\184\183\224\185\136\224\184\173\224\184\155\224\184\165\224\184\173\224\184\161\224\184\151\224\184\181\224\185\136\224\184\136\224\184\176\224\184\149\224\184\177\224\185\137\224\184\135...", function(r_v10_1025)
                r_v40_42.anonymous_mode_name = r_v10_1025
                Save()
                if r_v40_42.anonymous_mode then
                    o_v54_6()
                end
                r_v10_1025 = nil
            end)
            local r_v56_282 = r_v40_42.anonymous_mode_name
            local r_v55_298 = r_v56_282 or ("StarHuBUser")
            r_v51_378:Set(r_v55_298)
            local r_v53_306 = T_Misc
            local r_v56_288 = r_v40_42.anon_use_gradient
            r_v53_306:AddToggle("\224\184\138\224\184\183\224\185\136\224\184\173\224\184\155\224\184\165\224\184\173\224\184\161\224\185\132\224\184\165\224\185\136\224\184\170\224\184\181 2 \224\184\170\224\184\181 (Gradient)", "\224\185\131\224\184\138\224\185\137\224\184\170\224\184\181\224\184\156\224\184\170\224\184\161\224\184\148\224\185\137\224\184\178\224\184\153\224\184\165\224\185\136\224\184\178\224\184\135", r_v56_288, function(r_v10_1027)
                r_v40_42.anon_use_gradient = r_v10_1027
                Save()
                o_v53_5(r_v40_42.anonymous_mode)
                r_v10_1027 = nil
            end)
            local r_v53_307 = T_Misc
            local r_v56_291 = r_v40_42.rainbow_anon_name
            r_v53_307:AddToggle("\224\184\138\224\184\183\224\185\136\224\184\173\224\184\155\224\184\165\224\184\173\224\184\161\224\184\170\224\184\181\224\184\163\224\184\184\224\185\137\224\184\135\224\184\148\224\184\177\224\185\137\224\184\135\224\185\128\224\184\148\224\184\180\224\184\161 (Rainbow)", "\224\185\129\224\184\154\224\184\154\224\185\129\224\184\163\224\184\129\224\184\170\224\184\184\224\184\148\224\184\130\224\184\173\224\184\135 Star Hub", r_v56_291, function(r_v10_1028)
                r_v40_42.rainbow_anon_name = r_v10_1028
                Save()
                o_v53_5(r_v40_42.anonymous_mode)
                r_v10_1028 = nil
            end)
            local r_v51_398 = T_Misc:AddDropdown("\240\159\142\168 \224\184\170\224\184\181\224\184\151\224\184\181\224\185\136 1 (Color 1)", r_v49_59, function(r_v10_1029)
                r_v40_42.anon_color1 = r_v10_1029
                Save()
                if r_v40_42.anon_use_gradient then
                    o_v54_6()
                end
                r_v10_1029 = nil
            end)
            local r_v55_305 = (r_v40_42.anon_color1) or ("\224\185\129\224\184\148\224\184\135 (Red)")
            r_v51_398:Set(r_v55_305)
            local r_v51_406 = T_Misc:AddDropdown("\240\159\142\168 \224\184\170\224\184\181\224\184\151\224\184\181\224\185\136 2 (Color 2)", r_v49_59, function(r_v10_1031)
                r_v40_42.anon_color2 = r_v10_1031
                Save()
                if r_v40_42.anon_use_gradient then
                    o_v54_6()
                end
                r_v10_1031 = nil
            end)
            local r_v55_309 = (r_v40_42.anon_color2) or ("\224\184\153\224\185\137\224\184\179\224\185\128\224\184\135\224\184\180\224\184\153 (Blue)")
            r_v51_406:Set(r_v55_309)
        end
        T_Misc:AddLabel("\240\159\150\188\239\184\143 \224\184\158\224\184\183\224\185\137\224\184\153\224\184\171\224\184\165\224\184\177\224\184\135\224\185\129\224\184\165\224\184\176\224\185\130\224\184\165\224\185\130\224\184\129\224\185\137 (UI Design)")
        local r_v51_386 = T_Misc:AddTextbox("\224\185\128\224\184\155\224\184\165\224\184\181\224\185\136\224\184\162\224\184\153\224\184\138\224\184\183\224\185\136\224\184\173 Hub (Custom Title)...", function(r_v10_1026)
            if (r_v10_1026 == "") then
                r_v10_1026 = "LARB HUB"
            end
            r_v40_42.custom_hub_title = r_v10_1026
            Save()
            if o_v114_53 then
                o_v114_53.Text = r_v10_1026
            end
            r_v10_1026 = nil
        end)
        local r_v55_301 = (r_v40_42.custom_hub_title) or ("LARB HUB")
        r_v51_386:Set(r_v55_301)
        local r_v51_402 = T_Misc:AddTextbox("\224\185\131\224\184\170\224\185\136\224\184\165\224\184\180\224\185\137\224\184\135\224\184\129\224\185\140\224\184\163\224\184\185\224\184\155\224\184\158\224\184\183\224\185\137\224\184\153\224\184\171\224\184\165\224\184\177\224\184\135 UI...", function(r_v10_1030)
            r_v40_42.custom_bg_url = r_v10_1030
            Save()
            o_v92_61(r_v10_1030)
            r_v10_1030 = nil
        end)
        local r_v55_307 = (r_v40_42.custom_bg_url) or ("")
        r_v51_402:Set(r_v55_307)
        if r_v40_42.custom_bg_url then
            o_v92_61(r_v40_42.custom_bg_url)
        end
        local r_v51_412 = T_Misc:AddTextbox("\224\185\131\224\184\170\224\185\136\224\184\165\224\184\180\224\185\137\224\184\135\224\184\129\224\185\140\224\184\163\224\184\185\224\184\155\224\185\130\224\184\165\224\185\130\224\184\129\224\185\137 (\224\184\148\224\185\137\224\184\178\224\184\153\224\184\139\224\185\137\224\184\178\224\184\162\224\184\154\224\184\153)...", function(r_v10_1032)
            r_v40_42.custom_logo_url = r_v10_1032
            Save()
            o_v113_52(r_v10_1032)
            r_v10_1032 = nil
        end)
        local r_v55_313 = (r_v40_42.custom_logo_url) or ("")
        r_v51_412:Set(r_v55_313)
        if r_v40_42.custom_logo_url then
            o_v113_52(r_v40_42.custom_logo_url)
        end
        local r_v51_418 = T_Misc:AddTextbox("\224\185\131\224\184\170\224\185\136\224\184\165\224\184\180\224\185\137\224\184\135\224\184\129\224\185\140\224\184\163\224\184\185\224\184\155\224\184\155\224\184\184\224\185\136\224\184\161\224\184\162\224\185\136\224\184\173 UI (\224\184\167\224\184\135\224\184\129\224\184\165\224\184\161)...", function(r_v10_1033)
            r_v40_42.toggle_img_url = r_v10_1033
            Save()
            o_v83_29(r_v10_1033)
            r_v10_1033 = nil
        end)
        local r_v55_317 = (r_v40_42.toggle_img_url) or ("")
        r_v51_418:Set(r_v55_317)
        if r_v40_42.toggle_img_url then
            o_v83_29(r_v40_42.toggle_img_url)
        end
        T_Misc:AddLabel("\240\159\147\143 \224\184\155\224\184\163\224\184\177\224\184\154\224\185\129\224\184\149\224\185\136\224\184\135\224\184\170\224\184\177\224\184\148\224\184\170\224\185\136\224\184\167\224\184\153 (Sizes & Opacity)")
        local r_v53_338 = T_Misc
        local r_v59_251 = r_v40_42.bg_transparency
        local r_v57_300 = r_v59_251 or 45
        r_v53_338:AddSlider("\224\184\132\224\184\167\224\184\178\224\184\161\224\184\161\224\184\183\224\184\148\224\184\130\224\184\173\224\184\135\224\184\158\224\184\183\224\185\137\224\184\153\224\184\171\224\184\165\224\184\177\224\184\135 (Bg Dim %)", 0, 100, r_v57_300, function(r_v10_1034)
            r_v40_42.bg_transparency = r_v10_1034
            Save()
            o_v89_44.BackgroundTransparency = r_v10_1034 / 100
            r_v10_1034 = nil
        end)
        local r_v53_339 = T_Misc
        local r_v59_253 = r_v40_42.toggle_size
        local r_v58_275 = function(r_v10_1035)
            r_v40_42.toggle_size = r_v10_1035
            Save()
            o_v75_41.Size = UDim2.new(0, r_v10_1035, 0, r_v10_1035)
            r_v10_1035 = nil
        end
        local r_v57_302 = r_v59_253 or 50
        r_v53_339:AddSlider("\224\184\130\224\184\153\224\184\178\224\184\148\224\184\155\224\184\184\224\185\136\224\184\161\224\184\162\224\185\136\224\184\173 UI (Toggle Size)", 30, 100, r_v57_302, r_v58_275)
        local r_v53_340 = T_Misc
        local r_v60_222 = r_v40_42
        local r_v58_278 = function(r_v10_1036)
            r_v40_42.logo_size = r_v10_1036
            Save()
            o_v111_76.Size = UDim2.new(0, r_v10_1036, 0, r_v10_1036)
            o_v111_76.Position = UDim2.new(0.5, -(r_v10_1036 / 2), 0, 15)
            o_v114_53.Position = UDim2.new(0, 0, 0, (15 + r_v10_1036) + 5)
            o_v115_51.Position = UDim2.new(0, 0, 0, (15 + r_v10_1036) + 25)
            o_v110_81.Size = UDim2.new(1, 0, 0, (15 + r_v10_1036) + 45)
            o_v116_60.Position = UDim2.new(0, 0, 0, (15 + r_v10_1036) + 45)
            o_v116_60.Size = UDim2.new(1, 0, 1, -((15 + r_v10_1036) + 55))
            r_v10_1036 = nil
        end
        local r_v59_255 = r_v60_222.logo_size
        local r_v57_304 = r_v59_255 or 56
        r_v53_340:AddSlider("\224\184\130\224\184\153\224\184\178\224\184\148\224\185\130\224\184\165\224\185\130\224\184\129\224\185\137 (Logo Size)", 30, 120, r_v57_304, r_v58_278)
        local r_v53_341 = T_Misc
        local r_v57_306 = r_v40_42.ui_width
        r_v53_341:AddSlider("\224\184\132\224\184\167\224\184\178\224\184\161\224\184\129\224\184\167\224\185\137\224\184\178\224\184\135\224\184\171\224\184\153\224\185\137\224\184\178\224\184\149\224\185\136\224\184\178\224\184\135 (Width)", 400, 800, r_v57_306, function(r_v10_1037)
            r_v40_42.ui_width = r_v10_1037
            Save()
            local r_v5_1911 = TweenInfo.new(0.2)
            local r_v7_2205 = UDim2.new(0, r_v40_42.ui_width, 0, r_v40_42.ui_height)
            ;(r_v13_49:Create(o_v84_19, r_v5_1911, {
                ["Size"] = r_v7_2205
            })):Play()
            r_v10_1037 = nil
        end)
        local r_v53_342 = T_Misc
        local r_v57_308 = r_v40_42.ui_height
        r_v53_342:AddSlider("\224\184\132\224\184\167\224\184\178\224\184\161\224\184\170\224\184\185\224\184\135\224\184\171\224\184\153\224\185\137\224\184\178\224\184\149\224\185\136\224\184\178\224\184\135 (Height)", 250, 600, r_v57_308, function(r_v10_1038)
            r_v40_42.ui_height = r_v10_1038
            Save()
            local r_v5_1914 = TweenInfo.new(0.2)
            local r_v7_2209 = UDim2.new(0, r_v40_42.ui_width, 0, r_v40_42.ui_height)
            ;(r_v13_49:Create(o_v84_19, r_v5_1914, {
                ["Size"] = r_v7_2209
            })):Play()
            r_v10_1038 = nil
        end)
        T_Misc:AddLabel("\240\159\142\168 \224\185\129\224\184\149\224\185\136\224\184\135\224\184\170\224\184\181\224\185\129\224\184\165\224\184\176\224\184\152\224\184\181\224\184\161 (Themes)")
        local r_v51_452 = T_Misc:AddDropdown("\224\184\159\224\184\173\224\184\153\224\184\149\224\185\140\224\184\149\224\184\177\224\184\167\224\184\171\224\184\153\224\184\177\224\184\135\224\184\170\224\184\183\224\184\173 (Font Style)", r_v49_61, function(r_v10_1039)
            r_v40_42.ui_font = r_v10_1039
            Save()
            o_v73_44(r_v10_1039)
            r_v10_1039 = nil
        end)
        local r_v55_328 = (r_v40_42.ui_font) or ("Gotham Bold")
        r_v51_452:Set(r_v55_328)
        task.spawn(function()
            task.wait(0.5)
            local r_v10_1043 = (r_v40_42.ui_font) or ("Gotham Bold")
            o_v73_44(r_v10_1043)
        end)
        T_Misc:AddLabel("\240\159\148\165 \224\184\152\224\184\181\224\184\161\224\184\170\224\184\179\224\185\128\224\184\163\224\185\135\224\184\136\224\184\163\224\184\185\224\184\155 (Presets)")
        T_Misc:AddButton("\240\159\140\153 \224\184\152\224\184\181\224\184\161 Dark Night (\224\184\148\224\184\177\224\185\137\224\184\135\224\185\128\224\184\148\224\184\180\224\184\161)", function()
            r_v60_90.MainBg = Color3.fromRGB(20, 20, 22)
            r_v60_90.ElementBg = Color3.fromRGB(30, 30, 35)
            r_v40_42.theme_main_r = 20
            r_v40_42.theme_main_g = 20
            r_v40_42.theme_main_b = 22
            r_v40_42.theme_element_r = 30
            r_v40_42.theme_element_g = 30
            r_v40_42.theme_element_b = 35
            o_v74_42(Color3.fromRGB(255, 60, 60))
            o_v84_19.BackgroundColor3 = r_v60_90.MainBg
        end)
        T_Misc:AddButton("\240\159\166\160 \224\184\152\224\184\181\224\184\161 Hacker Green", function()
            r_v60_90.MainBg = Color3.fromRGB(10, 15, 10)
            r_v60_90.ElementBg = Color3.fromRGB(15, 25, 15)
            r_v40_42.theme_main_r = 10
            r_v40_42.theme_main_g = 15
            r_v40_42.theme_main_b = 10
            r_v40_42.theme_element_r = 15
            r_v40_42.theme_element_g = 25
            r_v40_42.theme_element_b = 15
            o_v74_42(Color3.fromRGB(0, 255, 100))
            o_v84_19.BackgroundColor3 = r_v60_90.MainBg
        end)
        T_Misc:AddButton("\240\159\146\156 \224\184\152\224\184\181\224\184\161 Cyberpunk Purple", function()
            r_v60_90.MainBg = Color3.fromRGB(15, 10, 25)
            r_v60_90.ElementBg = Color3.fromRGB(25, 15, 40)
            r_v40_42.theme_main_r = 15
            r_v40_42.theme_main_g = 10
            r_v40_42.theme_main_b = 25
            r_v40_42.theme_element_r = 25
            r_v40_42.theme_element_g = 15
            r_v40_42.theme_element_b = 40
            o_v74_42(Color3.fromRGB(180, 0, 255))
            o_v84_19.BackgroundColor3 = r_v60_90.MainBg
        end)
        T_Misc:AddLabel("\240\159\150\140\239\184\143 \224\185\128\224\184\165\224\184\183\224\184\173\224\184\129\224\184\170\224\184\181\224\184\149\224\184\177\224\184\167\224\184\173\224\184\177\224\184\129\224\184\169\224\184\163\224\185\129\224\184\165\224\184\176\224\185\129\224\184\150\224\184\154 (Accent Color)")
        local r_v55_352 = Instance.new("ScrollingFrame", T_Misc.Page)
        r_v55_352.Size = UDim2.new(1, (-40), 0, 180)
        r_v55_352.BackgroundColor3 = r_v60_90.ElementBg
        r_v55_352.ScrollBarThickness = 2
        r_v55_352.ScrollBarImageColor3 = r_v60_90.Accent
        local r_v57_330 = T_Misc.ElementCount
        r_v55_352.LayoutOrder = r_v57_330 + 1
        local r_v55_358 = T_Misc
        local r_v57_332 = T_Misc.ElementCount
        r_v55_358.ElementCount = r_v57_332 + 1
        local r_v52_374 = Instance.new("UICorner", r_v55_352)
        r_v52_374.CornerRadius = o_v69_32.CornerRadius
        local r_v52_376 = Instance.new("UIStroke", r_v55_352)
        r_v52_376.Color = r_v60_90.Outline
        local r_v52_378 = Instance.new("UIGridLayout", r_v55_352)
        r_v52_378.CellSize = UDim2.new(0, 30, 0, 30)
        r_v52_378.CellPadding = UDim2.new(0, 10, 0, 10)
        local r_v58_330 = Enum.HorizontalAlignment
        r_v52_378.HorizontalAlignment = r_v58_330.Center
        local r_v58_332 = Enum.VerticalAlignment
        r_v52_378.VerticalAlignment = r_v58_332.Top
        local r_v56_374 = Instance.new("UIPadding", r_v55_352)
        r_v56_374.PaddingTop = UDim.new(0, 15)
        r_v56_374.PaddingBottom = UDim.new(0, 15)
        local r_v58_343 = Color3.fromRGB(255, 60, 60)
        local r_v59_324 = Color3.fromRGB(255, 100, 100)
        local r_v60_286 = Color3.fromRGB(220, 20, 60)
        local r_v61_210 = Color3.fromRGB(255, 0, 127)
        local r_v62_190 = Color3.fromRGB(255, 153, 204)
        local r_v63_175 = Color3.fromRGB(255, 50, 100)
        local r_v64_146 = Color3.fromRGB(138, 43, 226)
        local r_v65_140 = Color3.fromRGB(180, 0, 255)
        local r_v66_143 = Color3.fromRGB(148, 0, 211)
        local r_v67_138 = Color3.fromRGB(218, 112, 214)
        local r_v68_145 = Color3.fromRGB(255, 50, 255)
        local r_v69_142 = Color3.fromRGB(120, 80, 255)
        local r_v70_139 = Color3.fromRGB(80, 140, 255)
        local r_v71_120 = Color3.fromRGB(0, 191, 255)
        local r_v72_113 = Color3.fromRGB(65, 105, 225)
        local r_v73_97 = Color3.fromRGB(0, 0, 255)
        local r_v74_98 = Color3.fromRGB(0, 255, 255)
        local r_v75_80 = Color3.fromRGB(50, 255, 255)
        local r_v76_86 = Color3.fromRGB(0, 255, 170)
        local r_v77_69 = Color3.fromRGB(50, 255, 50)
        local r_v78_75 = Color3.fromRGB(0, 255, 100)
        local r_v79_65 = Color3.fromRGB(124, 252, 0)
        local r_v80_76 = Color3.fromRGB(46, 139, 87)
        local r_v81_61 = Color3.fromRGB(0, 128, 0)
        local r_v82_59 = Color3.fromRGB(255, 255, 50)
        local r_v83_56 = Color3.fromRGB(255, 215, 0)
        local r_v84_48 = Color3.fromRGB(255, 180, 50)
        local r_v85_44 = Color3.fromRGB(255, 140, 0)
        local r_v86_36 = Color3.fromRGB(255, 69, 0)
        local r_v87_30 = Color3.fromRGB(255, 100, 0)
        local r_v88_29 = Color3.fromRGB(255, 255, 255)
        local r_v89_28 = Color3.fromRGB(200, 200, 200)
        local r_v90_24 = Color3.fromRGB(150, 150, 150)
        local r_v57_394 = Color3.fromRGB
        local r_v91_25 = {
            r_v57_394(100, 100, 100)
        }
        local r_v52_386 = {
            r_v58_343,
            r_v59_324,
            r_v60_286,
            r_v61_210,
            r_v62_190,
            r_v63_175,
            r_v64_146,
            r_v65_140,
            r_v66_143,
            r_v67_138,
            r_v68_145,
            r_v69_142,
            r_v70_139,
            r_v71_120,
            r_v72_113,
            r_v73_97,
            r_v74_98,
            r_v75_80,
            r_v76_86,
            r_v77_69,
            r_v78_75,
            r_v79_65,
            r_v80_76,
            r_v81_61,
            r_v82_59,
            r_v83_56,
            r_v84_48,
            r_v85_44,
            r_v86_36,
            r_v87_30,
            r_v88_29,
            r_v89_28,
            r_v90_24,
            unpack(r_v91_25)
        }
        local r_v57_395 = pairs
        for r_v57_397, r_v62_191 in r_v57_395(r_v52_386) do
            local r_v63_177 = Instance.new("TextButton", r_v55_352)
            r_v63_177.BackgroundColor3 = r_v62_191
            r_v63_177.Text = ""
            local r_v64_155 = Instance.new("UICorner", r_v63_177)
            r_v64_155.CornerRadius = UDim.new(1, 0)
            r_v63_177.MouseButton1Click:Connect(function()
                o_v74_42(r_v62_191)
            end)
        end
        ;(r_v52_378:GetPropertyChangedSignal("AbsoluteContentSize")):Connect(function()
            r_v55_352.CanvasSize = UDim2.new(0, 0, 0, r_v52_378.AbsoluteContentSize.Y + 30)
        end)
        T_Misc:AddLabel("\226\154\160\239\184\143 \224\184\173\224\184\177\224\184\153\224\184\149\224\184\163\224\184\178\224\184\162 (Danger Zone)")
        T_Misc:AddButton("\240\159\151\145\239\184\143 \224\184\165\224\185\137\224\184\178\224\184\135\224\184\130\224\185\137\224\184\173\224\184\161\224\184\185\224\184\165\224\184\151\224\184\177\224\185\137\224\184\135\224\184\171\224\184\161\224\184\148 (Factory Reset)", function()
            local r_v10_1080
            r_v10_1080 = function(r_v10_1245)
                if isfolder(r_v10_1245) then
                    local r_v1_2788 = pairs
                    local r_v5_2363 = listfiles
                    for r_v6_2753, r_v8_2901 in r_v1_2788(r_v5_2363(r_v10_1245)) do
                        if isfolder(r_v8_2901) then
                            r_v10_1080(r_v8_2901)
                        else
                            delfile(r_v8_2901)
                        end
                    end
                end
                r_v10_1245 = nil
            end
            pcall(function()
                r_v10_1080("StarHub")
            end)
            r_v67_92("\224\184\163\224\184\181\224\185\128\224\184\139\224\185\135\224\184\149\224\184\163\224\184\176\224\184\154\224\184\154", "\224\184\165\224\185\137\224\184\178\224\184\135\224\184\130\224\185\137\224\184\173\224\184\161\224\184\185\224\184\165\224\184\151\224\184\177\224\185\137\224\184\135\224\184\171\224\184\161\224\184\148\224\185\129\224\184\165\224\185\137\224\184\167 \224\184\129\224\184\163\224\184\184\224\184\147\224\184\178\224\184\163\224\184\181\224\184\170\224\184\149\224\184\178\224\184\163\224\185\140\224\184\151\224\184\170\224\184\132\224\184\163\224\184\180\224\184\155\224\184\149\224\185\140!", 5)
            task.wait(1)
            r_v22_34:Kick("Star Hub - Factory Reset Complete")
        end)
    end
    if r_v40_42.auto_execute then
        if (not _G.auto_executed) then
            local o_v121_84 = _G
            o_v121_84.auto_executed = true
            pcall(function()
                local r_v10_379 = game
                ;(loadstring(r_v10_379.HttpGet(r_v10_379, "https://api.irisapp.ca/Scripts/IrisBetterCompat.lua")))()
            end)
            pcall(function()
                local r_v3_619 = game
                queue_on_teleport((loadstring(r_v3_619.HttpGet(r_v3_619, "https://raw.githubusercontent.com/nibamako08-code/UI/refs/heads/main/NEWMC.lua")))())
            end)
        end
    end
    InitializeUI()
    r_v67_92("Star Hub Load Success!", "\224\184\163\224\184\176\224\184\154\224\184\154\224\184\151\224\184\179\224\184\135\224\184\178\224\184\153\224\184\170\224\184\161\224\184\154\224\184\185\224\184\163\224\184\147\224\185\140\224\185\129\224\184\165\224\185\137\224\184\167\224\185\131\224\184\153\224\185\128\224\184\167\224\184\165\224\184\178 " .. (string.format("%.2f", (os.clock()) - r_v14_33)) .. " \224\184\167\224\184\180", 5)
    local o_v133_13 = os
    print("[Star Hub] System Online: working " .. (tostring((o_v133_13.clock()) - r_v14_33)))
    task.spawn(function()
        local r_v4_874 = game:GetService("TeleportService")
        ;(function()
            pcall(function()
                local r_v10_1246 = r_v17_48
                local r_v2_2018 = r_v10_1246:FindFirstChild("RobloxPromptGui")
                local r_v4_3177 = r_v2_2018
                if r_v2_2018 then
                    r_v10_1246 = r_v17_48.RobloxPromptGui
                    r_v4_3177 = r_v10_1246:FindFirstChild("promptOverlay")
                end
                r_v10_1246 = r_v4_3177
                if r_v10_1246 then
                    r_v10_1246.ChildAdded:Connect(function(r_v10_1288)
                        if (r_v10_1288.Name == "ErrorPrompt") then
                            r_v67_92("\224\184\163\224\184\176\224\184\154\224\184\154\224\184\155\224\185\137\224\184\173\224\184\135\224\184\129\224\184\177\224\184\153", "\224\184\149\224\184\163\224\184\167\224\184\136\224\184\158\224\184\154\224\184\155\224\184\177\224\184\141\224\184\171\224\184\178\224\184\129\224\184\178\224\184\163\224\185\128\224\184\138\224\184\183\224\185\136\224\184\173\224\184\161\224\184\149\224\185\136\224\184\173! \224\184\129\224\184\179\224\184\165\224\184\177\224\184\135\224\185\128\224\184\130\224\185\137\224\184\178\224\185\128\224\184\129\224\184\161\224\185\131\224\184\171\224\184\161\224\185\136\224\185\131\224\184\153 5 \224\184\167\224\184\180\224\184\153\224\184\178\224\184\151\224\184\181...", 5)
                            task.wait(5)
                            if ((#game.Players:GetPlayers()) <= 1) then
                                game.Players.LocalPlayer:Kick("\nStar Hub: Rejoining System...")
                                local r_v4_3306 = task
                                r_v4_3306.wait()
                                local r_v2_2096 = game.PlaceId
                                local r_v5_2474 = game.Players
                                r_v4_874:Teleport(r_v2_2096, r_v5_2474.LocalPlayer)
                            else
                                local r_v2_2097 = game.PlaceId
                                local r_v3_2193 = game.JobId
                                local r_v6_2883 = game.Players
                                r_v4_874:TeleportToPlaceInstance(r_v2_2097, r_v3_2193, r_v6_2883.LocalPlayer)
                            end
                        end
                        r_v10_1288 = nil
                    end)
                end
            end)
        end)()
    end)
    return
end
return (function()
    while true do
        -- optimized-out if statement
        local r_v1_60 = l2
        local r_v4_34 = l1
        l1 = r_v1_60
        l2 = r_v4_34
        r_v1_3()
    end
end)()
