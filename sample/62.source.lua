-- This file was generated at discord.gg/syncrypt

local v1 = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local MarketplaceService = game:GetService("MarketplaceService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local LocalizationService = game:GetService("LocalizationService")
local HttpService = game:GetService("HttpService")
local ClientId = RbxAnalyticsService:GetClientId()
local s1 = "en-us"
pcall(function()
    s1 = LocalizationService.RobloxLocaleId
end)
s1 = string.lower(s1 or "en-us")

local v8 = string.match(s1, "^[^%-]+") or "en"
local t1 = {}
local t2 = {
    "Overflow",
    "Key System",
    "Info",
    "UI",
    "Key",
    "Enter your key",
    "Enter key...",
    "Check Key",
    "Verify the key you entered",
    "Correct Key!",
    "Incorrect Key!",
    "Copy Key Link",
    "Copy your personal HWID key URL",
    "Copied key link to clipboard!",
    "Clipboard unavailable. URL printed to console.",
    "Version",
    "Your HWID",
    "Copy HWID",
    "Copy your HWID to the clipboard",
    "HWID copied!",
    "Menu",
    "Configure the UI below.",
    "Menu Bind",
    "Unload",
    "Unload the Overflow UI",
    "loaded successfully!"
}
if v8 ~= "en" then
    local n1 = 0
    for v14, v15 in ipairs(t2) do
        local v16 = v15

        n1 += 1
        task.spawn(function()
            local ok, result = pcall(function()
                local v83 = v16
                local v84 = HttpService:UrlEncode(v83)
                local v85 = v8
                local v86 = "https://api.mymemory.translated.net/get?q=" .. v84 .. "&langpair=en|" .. HttpService:UrlEncode(v85)
                local v87 = game:HttpGet(v86)
                local data = HttpService:JSONDecode(v87)
                local v89 = data

                if data then
                    v89 = data.responseData

                    if v89 then
                        v89 = data.responseData.translatedText
                    end
                end

                if v89 then
                    return data.responseData.translatedText
                end

                return nil
            end)

            if ok then
                ok = result and result ~= ""
            end

            if ok then
                t1[v16] = result
            else
                t1[v16] = v16
            end

            n1 -= 1
        end)
    end
    while n1 > 0 do
        task.wait()
    end
else
    for _, v in ipairs(t2) do
        t1[v] = v
    end
end
local function v19(p1)
    return t1[p1] or p1
end
local s2 = "Unknown Game"
pcall(function()
    local ProductInfo = MarketplaceService:GetProductInfo(game.PlaceId)

    if ProductInfo and ProductInfo.Name then
        s2 = ProductInfo.Name
    end
end)

local v21 = "https://vivaldiluasystems.zya.me/?hwid=" .. ClientId
local v22 = v1
local v23 = (t1.Overflow or "Overflow") .. " | " .. s2
local uDim2 = UDim2.fromOffset(700, 500)
local KeyCode = Enum.KeyCode
local CreateWindow = v22.CreateWindow
local RightControl = KeyCode.RightControl
local v28 = CreateWindow(v22, {
    Title = v23,
    SubTitle = "v1.0.46",
    TabWidth = 160,
    Size = uDim2,
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = RightControl
})
local v29 = v28:AddTab({
    Title = t1["Key System"] or "Key System",
    Icon = "key"
})
local v30 = v28:AddTab({
    Title = t1.Info or "Info",
    Icon = "info"
})
local v31 = v28:AddTab({
    Title = t1.UI or "UI",
    Icon = "settings"
})
local v32 = t1.Key or "Key"
local v33 = t1["Enter your key"] or "Enter your key"
local AddInput = v29.AddInput
local v35 = t1["Enter key..."] or "Enter key..."
local v36 = AddInput(v29, "KeyInput", {
    Title = v32,
    Description = v33,
    Default = "",
    Placeholder = v35,
    Numeric = false,
    Finished = false,
    Callback = function(_)
end
})
local v37 = t1["Check Key"] or "Check Key"
local v38 = t1["Verify the key you entered"] or "Verify the key you entered"
v29:AddButton({
    Title = v37,
    Description = v38,
    Callback = function()
    if v36.Value == "TempKEY1010101010" then
        local v61 = v1
        local v62 = t1["Key System"] or "Key System"
        local Notify = v61.Notify
        local v64 = t1["Correct Key!"] or "Correct Key!"

        Notify(v61, {
                Title = v62,
                Content = v64,
                Duration = 5
            })

        return
    end

    local v65 = v1
    local v66 = t1["Key System"] or "Key System"
    local v67 = t1["Incorrect Key!"] or "Incorrect Key!"

    v65:Notify({
            Title = v66,
            Content = v67,
            Duration = 5
        })
end
})
local AddButton = v29.AddButton
local v40 = t1["Copy Key Link"] or "Copy Key Link"
local v41 = t1["Copy your personal HWID key URL"] or "Copy your personal HWID key URL"
AddButton(v29, {
    Title = v40,
    Description = v41,
    Callback = function()
    if setclipboard then
        setclipboard(v21)

        local v68 = v1
        local v69 = t1["Key System"] or "Key System"
        local Notify = v68.Notify
        local v71 = t1["Copied key link to clipboard!"] or "Copied key link to clipboard!"

        Notify(v68, {
                Title = v69,
                Content = v71,
                Duration = 5
            })

        return
    end

    warn(v21)

    local v72 = v1
    local v73 = t1["Key System"] or "Key System"
    local Notify = v72.Notify
    local v75 = t1["Clipboard unavailable. URL printed to console."] or "Clipboard unavailable. URL printed to console."

    Notify(v72, {
            Title = v73,
            Content = v75,
            Duration = 5
        })
end
})
local v42 = t1.Overflow or "Overflow"
local v43 = s2
local v44 = t1.Version or "Version"
v30:AddParagraph({
    Title = v42,
    Content = v43 .. "\n" .. v44 .. " 1.0.46"
})
v30:AddParagraph({
    Title = t1["Your HWID"] or "Your HWID",
    Content = ClientId
})
local v45 = t1["Copy HWID"] or "Copy HWID"
local v46 = t1["Copy your HWID to the clipboard"] or "Copy your HWID to the clipboard"
v30:AddButton({
    Title = v45,
    Description = v46,
    Callback = function()
    if setclipboard then
        setclipboard(ClientId)

        local v76 = v1
        local v77 = t1.HWID or "HWID"
        local v78 = t1["HWID copied!"] or "HWID copied!"

        v76:Notify({
                Title = v77,
                Content = v78,
                Duration = 5
            })

        return
    end

    warn(ClientId)

    local v79 = v1
    local v80 = t1.HWID or "HWID"
    local v81 = t1["Clipboard unavailable. HWID printed to console."] or "Clipboard unavailable. HWID printed to console."

    v79:Notify({
            Title = v80,
            Content = v81,
            Duration = 5
        })
end
})
local v47 = t1.Menu or "Menu"
local AddParagraph = v31.AddParagraph
local v49 = v19("Configure the UI below.")

AddParagraph(v31, {
    Title = v47,
    Content = v49
})
v31:AddKeybind("MenuBind", {
    Title = t1["Menu Bind"] or "Menu Bind",
    Mode = "Toggle",
    Default = "MB2",
    Callback = function(_)
end
})
local v50 = t1.Unload or "Unload"
local AddButton2 = v31.AddButton
local v52 = v19("Unload the Overflow UI")

AddButton2(v31, {
    Title = v50,
    Description = v52,
    Callback = function()
    v1:Destroy()
end
})
v28:SelectTab(1)

local v53 = t1.Overflow or "Overflow"
local v54 = s2 .. " " .. (t1["loaded successfully!"] or "loaded successfully!")

v1:Notify({
    Title = v53,
    Content = v54,
    Duration = 5
})