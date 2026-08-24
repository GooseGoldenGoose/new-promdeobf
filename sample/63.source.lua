-- This file was generated at discord.gg/syncrypt

getgenv().configs = {
	temp = false
}
local t1 = {
	index = -1,
	["first-executed"] = true,
	["dr-focus"] = false,
	["sl-focus"] = false,
	activated = false,
	["index-focus"] = -1,
	["tg-focus"] = false
}
local t2 = {}
local t3 = {}
local _ = Enum.ScaleType.Slice
Rect.new(23, 23, 277, 277)

local _ = UDim2.fromScale(1, 1) + UDim2.fromOffset(30, 30)

UDim2.fromOffset(-15, -15)
task.spawn(function()
    if not isfolder("sixly's Client") then
        makefolder("sixly's Client")
    end

    if not isfolder("sixly's Client/" .. game.GameId) then
        makefolder("sixly's Client/" .. game.GameId)
    end
end)

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Mouse = Players.LocalPlayer:GetMouse()
if not getsynasset and not getcustomasset then
end
local _ = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
local _syn = syn
if _syn then
    _syn = syn.request
end
if not _syn then
    local _http = http

    if _http then
        _http = http.request
    end

    if not _http and not http_request then
        local _fluxus = fluxus

        if _fluxus then
            _fluxus = fluxus.request
        end

        if not _fluxus then
            local _ = request
        end
    end
end
if not setclipboard and not toclipboard and not set_clipboard and Clipboard then
    local _ = Clipboard.set
end
function t3.generateUUID()
    return string.gsub("xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx", "[xy]", function(p1)
        local v85 = p1 == "x"

        if v85 then
            v85 = math.random(0, 15)
        end

        if not v85 then
            v85 = math.random(8, 11)
        end

        return string.format("%x", v85)
    end)
end
function t3.protected(p2)
    p2.Parent = CoreGui
    p2.Name = t3.generateUUID()
    p2.DisplayOrder = 999
    p2.IgnoreGuiInset = true
    p2:SetAttribute("protected", (tostring(t3.generateUUID())))
    p2:SetAttribute("enabled", true)
end
function t3.tween(p3, p4, p5, ...)
    TweenService:Create(p3, TweenInfo.new(p4, p5), ...):Play()
end
function t3.stroke(p6, p7, p8, p9)
    local UIStroke = Instance.new("UIStroke", p6)

    UIStroke.Thickness = p8
    UIStroke.LineJoinMode = Enum.LineJoinMode.Round
    UIStroke.Color = p9
    UIStroke.Transparency = p7
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    return UIStroke
end
function t3.device()
    return UserInputService:GetPlatform() == Enum.Platform.Windows
end
function t3.format_timer(p10)
    local v29 = math.floor(p10 / 86400)
    local v30 = math.floor(p10 % 86400 / 3600)
    local v31 = math.floor(p10 % 3600 / 60)
    local _string = string
    local v33 = p10 % 60

    return _string.format("%dd %dh %dm %ds", v29, v30, v31, v33):gsub(" 0%a+", "")
end
function t3.getXY(p11)
    local AbsoluteSizeX = p11.AbsoluteSize.X
    local AbsoluteSizeY = p11.AbsoluteSize.Y
    local v37 = math.clamp(Mouse.X - p11.AbsolutePosition.X, 0, AbsoluteSizeX)
    local v38 = math.clamp(Mouse.Y - p11.AbsolutePosition.Y, 0, AbsoluteSizeY)

    return v37 / AbsoluteSizeX, v38 / AbsoluteSizeY
end
function t3.animatedcircle(p12, p13, p14, p15)
    local v43, v44 = t3.getXY(p13)
    local v45 = t3.newobject(p12)

    v45.Size = UDim2.fromScale(0, 0)
    v45.Position = UDim2.fromScale(v43, v44)

    if not p15 then
        p15 = p13.ImageColor3
    end

    v45.ImageColor3 = p15
    v45.ZIndex = 200
    v45.Parent = p13

    local AbsoluteSizeX = p13.AbsoluteSize.X
    local tween = t3.tween
    local Circular = Enum.EasingStyle.Circular
    local v49 = UDim2.fromScale(v43, v44) - UDim2.fromOffset(AbsoluteSizeX / 2, AbsoluteSizeX / 2)
    local uDim2 = UDim2.fromOffset(AbsoluteSizeX, AbsoluteSizeX)

    tween(v45, 0.25, Circular, {
		Position = v49,
		ImageTransparency = 1,
		ImageColor3 = p14,
		Size = uDim2
	})
    spawn(function()
        wait(0.5)
        v45:Destroy()
    end)
end
function t3.color_to_byte(p16)
    local round = math.round

    return string.format("%d, %d, %d", round(p16.r * 255), round(p16.g * 255), (round(p16.b * 255)))
end
function t3.checkmouse_ingui(p17)
    if p17 == nil then
        return false
    end

    local AbsolutePosition = p17.AbsolutePosition
    local AbsoluteSize = p17.AbsoluteSize
    local v56 = Mouse.X >= AbsolutePosition.X

    if v56 then
        v56 = Mouse.X < AbsolutePosition.X + AbsoluteSize.X

        if v56 then
            v56 = Mouse.Y >= AbsolutePosition.Y

            if v56 then
                v56 = Mouse.Y < AbsolutePosition.Y + AbsoluteSize.Y
            end
        end
    end

    return v56
end
function t3.create_corner(p18, p19)
    local UICorner = Instance.new("UICorner")

    UICorner.CornerRadius = UDim.new(0, p18)

    if p19 then
        UICorner.Parent = p19
    end

    return UICorner
end
function t2.create()
    t3.reload()
    local ScreenGui = Instance.new("ScreenGui")
    t3.protected(ScreenGui)
    local Frame = Instance.new("Frame", ScreenGui)
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame.BackgroundColor3 = Color3.fromRGB(35, 34, 39)
    Frame.BackgroundTransparency = 0
    Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    Frame.Name = "@main"
    local tween = t3.tween
    local Back = Enum.EasingStyle.Back
    local v64 = t3.device()
    if v64 then
        v64 = UDim2.new(0, 700, 0, 500)
    end
    if not v64 then
        v64 = UDim2.new(0, 600, 0, 400)
    end
    tween(Frame, 0.25, Back, {
		Size = v64
	})
    t3.create_corner(10, Frame)
    local Frame2 = Instance.new("Frame", Frame)
    Frame2.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame2.BackgroundTransparency = 1
    Frame2.Position = UDim2.new(0.5, 0, 0.5, 0)
    Frame2.Size = UDim2.new(0.95, 0, 0.95, 0)
    Frame2.Name = "@page"
    Frame2.ClipsDescendants = true
    local UIPageLayout = Instance.new("UIPageLayout", Frame2)
    UIPageLayout.Animated = true
    UIPageLayout.Circular = true
    UIPageLayout.EasingStyle = Enum.EasingStyle.Cubic
    UIPageLayout.TweenTime = 0.5
    local Folder = Instance.new("Folder", Frame)
    local TextButton = Instance.new("TextButton", Folder)
    TextButton.AutoButtonColor = false
    TextButton.TextTransparency = 1
    TextButton.ZIndex = 0
    TextButton.AnchorPoint = Vector2.new(0.5, 0.5)
    TextButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TextButton.BackgroundTransparency = 1
    TextButton.Position = UDim2.new(0.5, 0, 0.5, 0)
    TextButton.Size = UDim2.new(1, 0, 1, 0)
    t3.create_corner(10, TextButton)
    local Frame3 = Instance.new("Frame", Frame)
    Frame3.Position = UDim2.new(0.019, 0, 0.5, 0)
    Frame3.BackgroundTransparency = 1
    local v70 = t3.device()
    if v70 then
        v70 = UDim2.new(0, 30, 0, 500)
    end
    if not v70 then
        v70 = UDim2.new(0, 30, 0, 400)
    end
    Frame3.Size = v70
    Frame3.AnchorPoint = Vector2.new(0.5, 0.5)
    local UIGradient = Instance.new("UIGradient", Frame3)
    UIGradient.Transparency = NumberSequence.new(0, 1)
    UIGradient.Color = ColorSequence.new(Color3.fromRGB(0, 0, 0))
    t3.create_corner(10, Frame3)
    local ImageLabel = Instance.new("ImageLabel", Frame3)
    ImageLabel.AnchorPoint = Vector2.new(0.5, 0, 0.5, 0)
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Image = "rbxassetid://110736687176185"
    ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
    ImageLabel.Size = UDim2.new(0, 35, 0, 35)
    ImageLabel.ImageTransparency = 1
    local TextButton2 = Instance.new("TextButton", Frame3)
    TextButton2.AnchorPoint = Vector2.new(0.5, 0.5)
    TextButton2.AutoButtonColor = false
    TextButton2.BackgroundTransparency = 1
    TextButton2.TextTransparency = 1
    TextButton2.Position = UDim2.new(0.5, 0, 0.5, 0)
    TextButton2.Size = UDim2.new(1, 0, 1, 0)
    local Frame4 = Instance.new("Frame", Frame)
    Frame4.Position = UDim2.new(0.98, 0, 0.5, 0)
    Frame4.BackgroundTransparency = 1
    local v75 = t3.device()
    if v75 then
        v75 = UDim2.new(0, 30, 0, 500)
    end
    if not v75 then
        v75 = UDim2.new(0, 30, 0, 400)
    end
    Frame4.Size = v75
    Frame4.AnchorPoint = Vector2.new(0.5, 0.5)
    local UIGradient2 = Instance.new("UIGradient", Frame4)
    UIGradient2.Transparency = NumberSequence.new(1, 0)
    UIGradient2.Color = ColorSequence.new(Color3.fromRGB(0, 0, 0))
    t3.create_corner(10, Frame4)
    local ImageLabel2 = Instance.new("ImageLabel", Frame4)
    ImageLabel2.AnchorPoint = Vector2.new(0.5, 0, 0.5, 0)
    ImageLabel2.BackgroundTransparency = 1
    ImageLabel2.Image = "rbxassetid://110736687176185"
    ImageLabel2.Position = UDim2.new(0.5, 0, 0.5, 0)
    ImageLabel2.Size = UDim2.new(0, 35, 0, 35)
    ImageLabel2.ImageTransparency = 1
    ImageLabel2.Rotation = 180
    local TextButton3 = Instance.new("TextButton", Frame4)
    TextButton3.AnchorPoint = Vector2.new(0.5, 0.5)
    TextButton3.AutoButtonColor = false
    TextButton3.BackgroundTransparency = 1
    TextButton3.TextTransparency = 1
    TextButton3.Position = UDim2.new(0.5, 0, 0.5, 0)
    TextButton3.Size = UDim2.new(1, 0, 1, 0)
    Frame3.MouseEnter:Connect(function()
        t3.tween(Frame3, 0.25, Enum.EasingStyle.Circular, {
			BackgroundTransparency = 0
		})
        t3.tween(ImageLabel, 0.25, Enum.EasingStyle.Circular, {
			ImageTransparency = 0
		})
    end)
    Frame3.MouseLeave:Connect(function()
        t3.tween(Frame3, 0.25, Enum.EasingStyle.Circular, {
			BackgroundTransparency = 1
		})
        t3.tween(ImageLabel, 0.25, Enum.EasingStyle.Circular, {
			ImageTransparency = 1
		})
    end)
    TextButton2.MouseButton1Click:Connect(function()
        t1["index-focus"] = t1["index-focus"] - 1
        UIPageLayout:JumpToIndex(t1["index-focus"])
    end)
    Frame4.MouseEnter:Connect(function()
        t3.tween(Frame4, 0.25, Enum.EasingStyle.Circular, {
			BackgroundTransparency = 0
		})
        t3.tween(ImageLabel2, 0.25, Enum.EasingStyle.Circular, {
			ImageTransparency = 0
		})
    end)
    Frame4.MouseLeave:Connect(function()
        t3.tween(Frame4, 0.25, Enum.EasingStyle.Circular, {
			BackgroundTransparency = 1
		})
        t3.tween(ImageLabel2, 0.25, Enum.EasingStyle.Circular, {
			ImageTransparency = 1
		})
    end)
    local MouseButton1Click = TextButton3.MouseButton1Click
    local Connect = MouseButton1Click.Connect
    Connect(MouseButton1Click, function()
        t1["index-focus"] = t1["index-focus"] + 1
        UIPageLayout:JumpToIndex(t1["index-focus"])
    end)
    local u81 = true;
    (function(p20, p21)
        local u88
        local u89
        local inputPosition
        local p21Position
        p20.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                u88 = true
                inputPosition = input.Position
                p21Position = p21.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        u88 = false
                    end
                end)
            end
        end)
        p20.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                u89 = input
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            local v99 = input == u89

            if v99 then
                v99 = u88

                if v99 then
                    v99 = not t1["sl-focus"]
                end
            end

            if v99 then
                local v100 = input.Position - inputPosition

                if not false and u81 then
                    t3.tween(p21, 0.25, Enum.EasingStyle.Back, {
						Position = UDim2.new(p21Position.X.Scale, p21Position.X.Offset + v100.X, p21Position.Y.Scale, p21Position.Y.Offset + v100.Y)
					})

                    return
                end

                if not u81 then
                    p21.Position = UDim2.new(p21Position.X.Scale, p21Position.X.Offset + v100.X, p21Position.Y.Scale, p21Position.Y.Offset + v100.Y)
                end
            end
        end)
    end)(TextButton, Frame);
    ({}).Info = function(p22)
        if not p22.Title then
        end

        if not p22.Desc then
        end
    end

    return {
		create = function()
        t1.index = t1.index + 1

        local v93 = Random.new():NextInteger(1, 999999)
        local ScrollingFrame = Instance.new("ScrollingFrame", Frame2)

        ScrollingFrame.BackgroundTransparency = 1
        ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
        ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        ScrollingFrame.ScrollBarThickness = 3
        ScrollingFrame.LayoutOrder = t1.index
        ScrollingFrame.Name = "@container_" .. v93

        local UIGridLayout = Instance.new("UIGridLayout", ScrollingFrame)

        UIGridLayout.CellSize = UDim2.new(0, 155, 0, 100)
        UIGridLayout.CellPadding = UDim2.new(0, 15, 0, 15)
        UIGridLayout.FillDirection = Enum.FillDirection.Horizontal
        Instance.new("UIPadding", ScrollingFrame).PaddingTop = UDim.new(0, 15)

        if t1["first-executed"] then
            t1["first-executed"] = false
            t1["index-focus"] = t1.index

            if ScrollingFrame.Name == tostring("@container_" .. v93) then
                UIPageLayout:JumpToIndex(ScrollingFrame.LayoutOrder)
            end
        end

        return {
				Toggle = function(p23, p24)
            local p23Title = p23.Title

            if not p23Title then
                p23Title = tostring("Toggle")
            end

            local v104 = function(p25)
                if not p24 then
                    local p23Title2 = p23.Title

                    if p23Title2 then
                        p23Title2 = getgenv().configs[p23.Title] ~= nil
                    end

                    if p23Title2 then
                        getgenv().configs[p23.Title] = p25
                    end
                end

                if p23.Callback then
                    p23.Callback(p25)
                end
            end or function()
            end
            local v105 = p24

            if p24 then
                v105 = p23.Default
            end

            if not v105 then
                v105 = getgenv().configs[p23.Title] or false
            end

            local t4 = {
						title = p23Title,
						callback = v104,
						default = v105
					}
            local Frame5 = Instance.new("Frame", ScrollingFrame)

            Frame5.BackgroundTransparency = 0
            Frame5.BackgroundColor3 = Color3.fromRGB(42, 43, 48)
            t3.create_corner(4, Frame5)

            local TextButton4 = Instance.new("TextButton", Frame5)

            TextButton4.BackgroundTransparency = 1
            TextButton4.TextTransparency = 1
            TextButton4.AutoButtonColor = false
            TextButton4.Size = UDim2.new(1, 0, 1, 0)
            TextButton4.AnchorPoint = Vector2.new(0.5, 0.5)
            TextButton4.Position = UDim2.new(0.5, 0, 0.5, 0)

            local TextLabel = Instance.new("TextLabel", Frame5)

            TextLabel.BackgroundTransparency = 1
            TextLabel.Position = UDim2.new(0.078, 0, 0.7, 0)
            TextLabel.Size = UDim2.new(0, 130, 0, 23)
            TextLabel.FontFace = Font.fromName("Montserrat", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
            TextLabel.Text = t4.title
            TextLabel.TextSize = 12
            TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left

            local Frame6 = Instance.new("Frame", Frame5)

            Frame6.BackgroundColor3 = Color3.fromRGB(47, 48, 54)
            Frame6.Position = UDim2.new(0.8, 0, 0.25, 0)
            Frame6.AnchorPoint = Vector2.new(0.5, 0.5)
            Frame6.Size = UDim2.new(0, 40, 0, 20)
            t3.create_corner(30, Frame6)
            t3.stroke(Frame6, 0, 1, Color3.fromRGB(71, 71, 71))

            local Frame7 = Instance.new("Frame", Frame6)

            Frame7.AnchorPoint = Vector2.new(0.5, 0.5)
            Frame7.BackgroundTransparency = 0
            Frame7.Position = UDim2.new(0.25, 0, 0.5, 0)
            Frame7.Size = UDim2.new(0, 12, 0, 12)
            Frame7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            t3.create_corner(30, Frame7)

            local ImageButton = Instance.new("ImageButton", Frame5)

            ImageButton.AnchorPoint = Vector2.new(0.5, 0.5)
            ImageButton.Position = UDim2.new(0.15, 0, 0.25, 0)
            ImageButton.Size = UDim2.new(0, 18, 0, 18)
            ImageButton.BackgroundTransparency = 1
            ImageButton.Image = "rbxassetid://122981459568597"
            ImageButton.ImageTransparency = 0.2
            ImageButton.ZIndex = 9

            local u113 = false

            Frame5.MouseEnter:Connect(function()
                if u113 then
                    return
                end

                t3.tween(Frame5, 0.25, Enum.EasingStyle.Circular, {
							BackgroundColor3 = Color3.fromRGB(54, 55, 62)
						})
            end)
            Frame5.MouseLeave:Connect(function()
                if u113 then
                    return
                end

                t3.tween(Frame5, 0.25, Enum.EasingStyle.Circular, {
							BackgroundColor3 = Color3.fromRGB(42, 43, 48)
						})
            end)

            local function v114(p26)
                if not loaded then
                    repeat
                        task.wait()
                    until loaded
                end

                task.spawn(t4.callback, p26)
            end

            TextButton4.MouseButton1Click:Connect(function()
                if not u113 then
                    t3.tween(Frame6, 0.25, Enum.EasingStyle.Circular, {
								BackgroundColor3 = Color3.fromRGB(88, 101, 242)
							})
                    t3.tween(Frame7, 0.25, Enum.EasingStyle.Circular, {
								Position = UDim2.new(0.75, 0, 0.5, 0)
							})
                else
                    t3.tween(Frame6, 0.25, Enum.EasingStyle.Circular, {
								BackgroundColor3 = Color3.fromRGB(54, 55, 62)
							})
                    t3.tween(Frame7, 0.25, Enum.EasingStyle.Circular, {
								Position = UDim2.new(0.25, 0, 0.5, 0)
							})
                end

                u113 = not u113
                task.spawn(v114, u113)
            end)

            if t4.default then
                t3.tween(Frame6, 0.25, Enum.EasingStyle.Circular, {
							BackgroundColor3 = Color3.fromRGB(88, 101, 242)
						})
                t3.tween(Frame7, 0.25, Enum.EasingStyle.Circular, {
							Position = UDim2.new(0.75, 0, 0.5, 0)
						})
                u113 = not u113
                task.spawn(v114, u113)
            end

            ImageButton.MouseButton1Click:Connect(function()
                t3.tween(TextButton, 0.25, Enum.EasingStyle.Circular, {
							BackgroundTransparency = 0.5
						})
                TextButton.ZIndex = 9
            end)
        end
			}
    end
	}
end
local v17 = t2.create()
local v18 = v17.create()
v17.create()
v18.Toggle({
	Title = "Auto Farm",
	Default = false,
	Callback = function(p27)
    print(p27)
end
}, false)
v18.Toggle({
	Title = "Auto Farm",
	Default = false,
	Callback = function(p28)
    print(p28)
end
}, false)
getgenv().loaded = true
