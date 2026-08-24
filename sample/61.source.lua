repeat
    task.wait(5)
until game:IsLoaded()
game:GetService("RunService"):Set3dRenderingEnabled(false)
local t1 = {
	MaxPlayersToLeave = 15,
	MaxTimeInMinutes = 12,
	TargetMaxPlayers = 12,
	AbsoluteMaxLimit = 15,
	WebhookURL = " ",
	HopOnAdmin = true,
	AdminIDs = {
		12345678,
		87654321
	},
	GroupID = 33720745,
	AdminMinRank = 250
}
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local timestamp = tick()
local function v5(p1)
    if table.find(t1.AdminIDs, p1.UserId) then
        return true
    end

    local v21 = game.CreatorType == Enum.CreatorType.User

    if v21 then
        v21 = p1.UserId == game.CreatorId
    end

    if v21 then
        return true
    end

    if t1.GroupID > 0 then
        local ok, result = pcall(function()
            return p1:GetRankInGroup(t1.GroupID)
        end)

        if ok then
            ok = result >= t1.AdminMinRank
        end

        if ok then
            return true
        end
    end

    return false
end
local u6
local function v7(p2, p3, p4, p5, p6, p7)
    if t1.WebhookURL == "" then
        return
    end

    local v30 = not p6 and "🌐 (จาก Roblox API)" or "📦 (จาก Cache ในเครื่อง)"
    local n1 = 45055

    if p6 then
        n1 = 5763719
    end

    if p7 == "Admin" then
        n1 = 16711680
        p2 = "🚨 แอดมินเข้าเกม! ย้ายฉุกเฉิน!"
    end

    local v32 = "**[Bot Notification]** " .. v30
    local v33 = game.Name .. " (ID: " .. tostring(game.PlaceId) .. ")"
    local t2 = {
		name = "🗺\239\184\143 Map & PlaceID",
		value = v33,
		inline = false
	}
    local LocalPlayerName = Players.LocalPlayer.Name
    local t3 = {
		name = "🤖 Account",
		value = LocalPlayerName,
		inline = true
	}
    local t4 = {
		name = "🚀 Status",
		value = p2,
		inline = true
	}
    local v38 = tostring(p3) .. " > " .. tostring(p4)
    local t5 = {
		name = "👥 Players",
		value = v38,
		inline = true
	}
    local v40 = "```" .. tostring(p5) .. "```"
    local t6 = {
		name = "🔗 JobId",
		value = v40,
		inline = false
	}
    local t7 = {
		content = v32,
		embeds = {{
			color = n1,
			fields = {
				t2,
				t3,
				t4,
				t5,
				t6
			}
		}}
	}

    u6(t1.WebhookURL, "POST", HttpService:JSONEncode(t7))
end
function u6(p8, p9, p10)
    local _syn = syn

    if _syn then
        _syn = syn.request
    end

    if not _syn then
        _syn = http_request

        if not _syn then
            _syn = request

            if not _syn then
                _syn = http

                if _syn then
                    _syn = http.request
                end
            end
        end
    end

    if _syn then
        local v16 = p9 or "GET"
        local t8 = {
			["Content-Type"] = "application/json"
		}

        return _syn({
			Url = p8,
			Method = v16,
			Headers = t8,
			Body = p10
		})
    end

    local ok, result = pcall(function()
        local v66 = p9 == "POST"

        if v66 then
            v66 = HttpService:PostAsync(p8, p10)
        end

        if not v66 then
            v66 = game:HttpGet(p8)
        end

        return v66
    end)

    return {
		Success = ok,
		Body = result
	}
end
local function v8(p11)
    local v44 = #Players:GetPlayers()
    local v45 = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
    local v46 = tostring(game.PlaceId) .. "_ServerList.json"
    local v47 = u6(v45)
    local data
    local v49 = false
    local Success = v47.Success
    if Success then
        Success = v47.Body

        if Success then
            Success = not v47.Body:find("Error")
        end
    end
    if Success then
        local data2 = HttpService:JSONDecode(v47.Body)
        local v52 = data2

        if data2 then
            v52 = data2.data and #data2.data > 0
        end

        if v52 then
            data = data2.data
            pcall(function()
                writefile(v46, HttpService:JSONEncode(data))
            end)
        end
    end
    if not data and isfile(v46) then
        data = HttpService:JSONDecode(readfile(v46))
        v49 = true
    end
    if data then
        math.randomseed(tick() + math.random(1, 100000))
        local t9 = {}
        for v56, v57 in ipairs(data) do

            local v58 = v57.id ~= game.JobId

            if v58 then
                v58 = v57.playing <= t1.AbsoluteMaxLimit
            end

            if v58 then
                table.insert(t9, v57)
            end
        end
        if #t9 > 0 then
            local v59 = t9[math.random(1, #t9)]

            v7("ย้ายเซิร์ฟเวอร์สำเร็จ!", v44, v59.playing, v59.id, v49, p11)
            task.wait(1)
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, v59.id, Players.LocalPlayer)

            return
        end
    end
end
Players.PlayerAdded:Connect(function(player)
    if t1.HopOnAdmin and v5(player) then
        print("🚨 ตรวจพบแอดมิน: " .. player.Name .. " กำลังทำการหลบหนี!")
        v8("Admin")
    end
end)
for _, player in ipairs(Players:GetPlayers()) do
    local v11 = player ~= Players.LocalPlayer

    if v11 then
        v11 = t1.HopOnAdmin and v5(player)
    end

    if v11 then
        print("🚨 เซิร์ฟนี้มีแอดมินอยู่แล้ว: " .. player.Name .. " กำลังทำการหลบหนี!")
        v8("Admin")

        break
    end
end
task.spawn(function()
    while task.wait(5) do
        local players = Players:GetPlayers()
        local _tick = tick
        local v63 = #players
        local v64 = (_tick() - timestamp) / 60
        local v65 = v63 > t1.MaxPlayersToLeave

        if not v65 then
            v65 = v64 >= t1.MaxTimeInMinutes
        end

        if v65 then
            v8("Normal")
            task.wait(10)
        end
    end
end)
print("✅ V6")
