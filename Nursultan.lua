-- [[ NURSULTAN CLIENT UI LIBRARY — MASTER CORE ENGINE ]] --
-- Sharp Square Rectilinear Aesthetics (0 Corner Radius), Full Live Theme Switcher,
-- Custom Image Icons for Save (110746782819291) & Delete (81109897851133),
-- Workspace JSON Config Manager, Radio HUD Overlay with Seek Slider, Bulletproof RightShift Toggle.

local HttpService      = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local TweenService     = game:GetService("TweenService")
local RunService       = game:GetService("RunService")
local SoundService     = game:GetService("SoundService")
local Lighting         = game:GetService("Lighting")
local CoreGui          = game:GetService("CoreGui")
local Players          = game:GetService("Players")

local Library = {
    Themes = {
        ["Monochrome Dark"] = {
            Background   = Color3.fromRGB(12, 12, 14),
            Header       = Color3.fromRGB(20, 20, 24),
            Block        = Color3.fromRGB(16, 16, 19),
            Card         = Color3.fromRGB(22, 22, 27),
            CardHover    = Color3.fromRGB(30, 30, 38),
            Stroke       = Color3.fromRGB(42, 42, 52),
            StrokeHover  = Color3.fromRGB(90, 90, 105),
            StrokeActive = Color3.fromRGB(240, 240, 245),
            Accent       = Color3.fromRGB(255, 255, 255),
            AccentDim    = Color3.fromRGB(170, 170, 185),
            Text         = Color3.fromRGB(245, 245, 250),
            TextDim      = Color3.fromRGB(140, 140, 155)
        },
        ["Midnight Purple"] = {
            Background   = Color3.fromRGB(12, 10, 18),
            Header       = Color3.fromRGB(22, 18, 32),
            Block        = Color3.fromRGB(16, 14, 24),
            Card         = Color3.fromRGB(24, 20, 36),
            CardHover    = Color3.fromRGB(34, 28, 50),
            Stroke       = Color3.fromRGB(55, 45, 80),
            StrokeHover  = Color3.fromRGB(120, 90, 180),
            StrokeActive = Color3.fromRGB(180, 130, 255),
            Accent       = Color3.fromRGB(175, 95, 255),
            AccentDim    = Color3.fromRGB(130, 65, 200),
            Text         = Color3.fromRGB(250, 245, 255),
            TextDim      = Color3.fromRGB(160, 145, 180)
        },
        ["Emerald Cyan"] = {
            Background   = Color3.fromRGB(10, 16, 18),
            Header       = Color3.fromRGB(16, 26, 30),
            Block        = Color3.fromRGB(13, 22, 25),
            Card         = Color3.fromRGB(18, 32, 36),
            CardHover    = Color3.fromRGB(26, 44, 50),
            Stroke       = Color3.fromRGB(40, 75, 85),
            StrokeHover  = Color3.fromRGB(80, 150, 170),
            StrokeActive = Color3.fromRGB(0, 230, 255),
            Accent       = Color3.fromRGB(0, 220, 240),
            AccentDim    = Color3.fromRGB(0, 160, 180),
            Text         = Color3.fromRGB(240, 255, 255),
            TextDim      = Color3.fromRGB(140, 175, 185)
        },
        ["Ruby Red"] = {
            Background   = Color3.fromRGB(18, 10, 12),
            Header       = Color3.fromRGB(30, 16, 20),
            Block        = Color3.fromRGB(24, 13, 16),
            Card         = Color3.fromRGB(34, 18, 22),
            CardHover    = Color3.fromRGB(48, 24, 30),
            Stroke       = Color3.fromRGB(75, 40, 50),
            StrokeHover  = Color3.fromRGB(160, 70, 90),
            StrokeActive = Color3.fromRGB(255, 80, 110),
            Accent       = Color3.fromRGB(255, 65, 95),
            AccentDim    = Color3.fromRGB(190, 45, 70),
            Text         = Color3.fromRGB(255, 245, 248),
            TextDim      = Color3.fromRGB(180, 140, 150)
        }
    },
    CurrentThemeName = "Monochrome Dark",
    ToggleKey = Enum.KeyCode.RightShift,
    Blocks = {},
    ModalElements = {},
    KeybindList = {},
    Connections = {},
    OpenDropdowns = {},
    Enabled = true,
    Animating = false,
    ListeningKeybind = false,
    BlurEnabled = true,
    BlurSize = 18,
    SnowEnabled = true,
    SnowCount = 50,
    ConfigFolder = "NursultanClient",
    Fonts = {
        Header = Enum.Font.GothamBold,
        Label = Enum.Font.GothamMedium,
        Badge = Enum.Font.GothamBold
    }
}

Library.Theme = Library.Themes["Monochrome Dark"]

local function formatAssetId(raw)
    if not raw or raw == "" then return "" end
    raw = tostring(raw):gsub("%s+", "")
    if tonumber(raw) then
        return "rbxassetid://" .. raw
    elseif not raw:find("rbxassetid://") then
        local match = raw:match("%d+")
        if match then return "rbxassetid://" .. match end
    end
    return raw
end

local function formatTime(seconds)
    seconds = math.max(0, math.floor(seconds or 0))
    local mins = math.floor(seconds / 60)
    local secs = seconds % 60
    return string.format("%02d:%02d", mins, secs)
end

pcall(function()
    if makefolder and isfolder then
        if not isfolder(Library.ConfigFolder) then
            makefolder(Library.ConfigFolder)
        end
    end
end)

local ParentContainer = nil
pcall(function() ParentContainer = CoreGui end)
if not ParentContainer or not pcall(function() return ParentContainer.Name end) then
    ParentContainer = Players.LocalPlayer:WaitForChild("PlayerGui")
end

if ParentContainer:FindFirstChild("NursultanGUI") then
    ParentContainer.NursultanGUI:Destroy()
end
if Lighting:FindFirstChild("NursultanMenuBlur") then
    Lighting.NursultanMenuBlur:Destroy()
end
if SoundService:FindFirstChild("NursultanRadioSound") then
    SoundService.NursultanRadioSound:Destroy()
end

local RadioSound = Instance.new("Sound")
RadioSound.Name = "NursultanRadioSound"
RadioSound.Looped = true
RadioSound.Volume = 0.5
RadioSound.PlaybackSpeed = 1.0
RadioSound.Parent = SoundService

local MenuBlur = Instance.new("BlurEffect")
MenuBlur.Name = "NursultanMenuBlur"
MenuBlur.Size = 0
MenuBlur.Enabled = false
MenuBlur.Parent = Lighting

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NursultanGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = ParentContainer

local Container = Instance.new("Frame")
Container.Name = "BlockContainer"
Container.Size = UDim2.new(1, 0, 1, 0)
Container.BackgroundTransparency = 1
Container.Parent = ScreenGui

local SnowFolder = Instance.new("Folder")
SnowFolder.Name = "SnowParticles"
SnowFolder.Parent = Container

local Flakes = {}
for i = 1, 50 do
    local Flake = Instance.new("Frame")
    Flake.Name = "Flake_" .. i
    local flakeSize = math.random(2, 5)
    Flake.Size = UDim2.new(0, flakeSize, 0, flakeSize)
    Flake.Position = UDim2.new(math.random(), 0, math.random(), 0)
    Flake.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Flake.BackgroundTransparency = math.random(3, 7) / 10
    Flake.BorderSizePixel = 0
    Flake.Parent = SnowFolder

    table.insert(Flakes, {
        Frame = Flake,
        Speed = math.random(6, 20) / 1000,
        Drift = (math.random() - 0.5) * 0.002,
        X = math.random(),
        Y = math.random()
    })
end

local function trackConnection(conn)
    table.insert(Library.Connections, conn)
    return conn
end

trackConnection(RunService.RenderStepped:Connect(function(dt)
    if Library.Enabled and ScreenGui.Enabled and Library.SnowEnabled then
        for _, f in ipairs(Flakes) do
            f.Y = f.Y + (f.Speed * dt * 60)
            f.X = f.X + (f.Drift * dt * 60)
            if f.Y > 1.05 then
                f.Y = -0.05
                f.X = math.random()
            end
            f.Frame.Position = UDim2.new(f.X, 0, f.Y, 0)
        end
    end
end))

-- Watermark (No Rounded Corners)
local Watermark = Instance.new("Frame")
Watermark.Name = "Watermark"
Watermark.Size = UDim2.new(0, 270, 0, 32)
Watermark.Position = UDim2.new(0, 15, 0, 15)
Watermark.BackgroundColor3 = Library.Theme.Block
Watermark.BorderSizePixel = 0
Watermark.Parent = Container

local WMarkStroke = Instance.new("UIStroke")
WMarkStroke.Color = Library.Theme.Stroke
WMarkStroke.Thickness = 1.2
WMarkStroke.Parent = Watermark

local WMarkAccent = Instance.new("Frame")
WMarkAccent.Size = UDim2.new(0, 3, 0, 18)
WMarkAccent.Position = UDim2.new(0, 8, 0.5, -9)
WMarkAccent.BackgroundColor3 = Library.Theme.Accent
WMarkAccent.BorderSizePixel = 0
WMarkAccent.Parent = Watermark

local WMarkLabel = Instance.new("TextLabel")
WMarkLabel.Size = UDim2.new(1, -20, 1, 0)
WMarkLabel.Position = UDim2.new(0, 18, 0, 0)
WMarkLabel.BackgroundTransparency = 1
WMarkLabel.Font = Library.Fonts.Header
WMarkLabel.Text = "NURSULTAN CLIENT  |  [RIGHT SHIFT]"
WMarkLabel.TextColor3 = Library.Theme.Text
WMarkLabel.TextSize = 11
WMarkLabel.TextXAlignment = Enum.TextXAlignment.Left
WMarkLabel.Parent = Watermark

-- Gear Icon Button (No Rounded Corners)
local GearBtnFrame = Instance.new("Frame")
GearBtnFrame.Name = "GearButtonFrame"
GearBtnFrame.Size = UDim2.new(0, 38, 0, 38)
GearBtnFrame.Position = UDim2.new(1, -53, 0, 15)
GearBtnFrame.BackgroundColor3 = Library.Theme.Block
GearBtnFrame.BorderSizePixel = 0
GearBtnFrame.Parent = Container

local GearStroke = Instance.new("UIStroke")
GearStroke.Color = Library.Theme.Accent
GearStroke.Thickness = 1.5
GearStroke.Parent = GearBtnFrame

local GearIcon = Instance.new("ImageButton")
GearIcon.Name = "GearIcon"
GearIcon.Size = UDim2.new(0, 22, 0, 22)
GearIcon.Position = UDim2.new(0.5, -11, 0.5, -11)
GearIcon.BackgroundTransparency = 1
GearIcon.Image = "rbxassetid://7059346373"
GearIcon.ImageColor3 = Library.Theme.Accent
GearIcon.Parent = GearBtnFrame

local function tween(object, duration, properties, easingStyle, easingDirection)
    easingStyle = easingStyle or Enum.EasingStyle.Quart
    easingDirection = easingDirection or Enum.EasingDirection.Out
    local anim = TweenService:Create(object, TweenInfo.new(duration, easingStyle, easingDirection), properties)
    anim:Play()
    return anim
end

local function makeDraggable(frame, dragHandle)
    local dragging = false
    local dragInput, dragStart, startPos

    trackConnection(dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            local endedConn
            endedConn = UserInputService.InputEnded:Connect(function(endInput)
                if endInput.UserInputType == Enum.UserInputType.MouseButton1 or endInput.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                    if endedConn then endedConn:Disconnect() end
                end
            end)
        end
    end))

    trackConnection(dragHandle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end))

    trackConnection(UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            local newPos = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
            frame.Position = newPos
            for _, b in ipairs(Library.Blocks) do
                if b.Frame == frame then
                    b.DefaultPos = newPos
                    break
                end
            end
        end
    end))
end

-- Keybind HUD (No Rounded Corners)
local KeybindHUDFrame = Instance.new("Frame")
KeybindHUDFrame.Name = "KeybindHUDOverlay"
KeybindHUDFrame.Size = UDim2.new(0, 190, 0, 32)
KeybindHUDFrame.Position = UDim2.new(1, -205, 0.3, 0)
KeybindHUDFrame.BackgroundColor3 = Library.Theme.Block
KeybindHUDFrame.BorderSizePixel = 0
KeybindHUDFrame.Parent = Container

local KeybindHUDStroke = Instance.new("UIStroke")
KeybindHUDStroke.Color = Library.Theme.Stroke
KeybindHUDStroke.Thickness = 1.2
KeybindHUDStroke.Parent = KeybindHUDFrame

local KeybindHUDHeader = Instance.new("Frame")
KeybindHUDHeader.Size = UDim2.new(1, 0, 0, 28)
KeybindHUDHeader.BackgroundColor3 = Library.Theme.Header
KeybindHUDHeader.BorderSizePixel = 0
KeybindHUDHeader.Parent = KeybindHUDFrame

local HUDDot = Instance.new("Frame")
HUDDot.Size = UDim2.new(0, 5, 0, 5)
HUDDot.Position = UDim2.new(0, 10, 0.5, -2.5)
HUDDot.BackgroundColor3 = Library.Theme.Accent
HUDDot.BorderSizePixel = 0
HUDDot.Parent = KeybindHUDHeader

local HUDTitle = Instance.new("TextLabel")
HUDTitle.Size = UDim2.new(1, -25, 1, 0)
HUDTitle.Position = UDim2.new(0, 20, 0, 0)
HUDTitle.BackgroundTransparency = 1
HUDTitle.Font = Library.Fonts.Header
HUDTitle.Text = "KEYBINDS"
HUDTitle.TextColor3 = Library.Theme.Text
HUDTitle.TextSize = 11
HUDTitle.TextXAlignment = Enum.TextXAlignment.Left
HUDTitle.Parent = KeybindHUDHeader

local HUDListHolder = Instance.new("Frame")
HUDListHolder.Size = UDim2.new(1, -12, 0, 0)
HUDListHolder.Position = UDim2.new(0, 6, 0, 32)
HUDListHolder.BackgroundTransparency = 1
HUDListHolder.Parent = KeybindHUDFrame

local HUDListLayout = Instance.new("UIListLayout")
HUDListLayout.SortOrder = Enum.SortOrder.LayoutOrder
HUDListLayout.Padding = UDim.new(0, 3)
HUDListLayout.Parent = HUDListHolder

makeDraggable(KeybindHUDFrame, KeybindHUDHeader)

function Library:RefreshKeybindHUD()
    for _, child in ipairs(HUDListHolder:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end

    local count = 0
    for featName, keyName in pairs(Library.KeybindList) do
        count = count + 1

        local Row = Instance.new("Frame")
        Row.Size = UDim2.new(1, 0, 0, 22)
        Row.BackgroundColor3 = Library.Theme.Card
        Row.BorderSizePixel = 0
        Row.Parent = HUDListHolder

        local NameLbl = Instance.new("TextLabel")
        NameLbl.Size = UDim2.new(1, -55, 1, 0)
        NameLbl.Position = UDim2.new(0, 6, 0, 0)
        NameLbl.BackgroundTransparency = 1
        NameLbl.Font = Library.Fonts.Label
        NameLbl.Text = featName
        NameLbl.TextColor3 = Library.Theme.TextDim
        NameLbl.TextSize = 10
        NameLbl.TextXAlignment = Enum.TextXAlignment.Left
        NameLbl.Parent = Row

        local Badge = Instance.new("TextLabel")
        Badge.Size = UDim2.new(0, 45, 0, 16)
        Badge.Position = UDim2.new(1, -48, 0.5, -8)
        Badge.BackgroundColor3 = Library.Theme.Header
        Badge.Font = Library.Fonts.Badge
        Badge.Text = keyName
        Badge.TextColor3 = Library.Theme.Accent
        Badge.TextSize = 9
        Badge.BorderSizePixel = 0
        Badge.Parent = Row
    end

    local listHeight = HUDListLayout.AbsoluteContentSize.Y
    HUDListHolder.Size = UDim2.new(1, -12, 0, listHeight)
    tween(KeybindHUDFrame, 0.2, { Size = UDim2.new(0, 190, 0, 34 + listHeight) })
end

-- Radio HUD Frame (No Rounded Corners)
local RadioHUDFrame = Instance.new("Frame")
RadioHUDFrame.Name = "RadioHUDOverlay"
RadioHUDFrame.Size = UDim2.new(0, 260, 0, 165)
RadioHUDFrame.Position = UDim2.new(1, -275, 1, -180)
RadioHUDFrame.BackgroundColor3 = Library.Theme.Block
RadioHUDFrame.BorderSizePixel = 0
RadioHUDFrame.Parent = Container

local RadioHUDStroke = Instance.new("UIStroke")
RadioHUDStroke.Color = Library.Theme.Stroke
RadioHUDStroke.Thickness = 1.2
RadioHUDStroke.Parent = RadioHUDFrame

local RadioHeader = Instance.new("Frame")
RadioHeader.Size = UDim2.new(1, 0, 0, 28)
RadioHeader.BackgroundColor3 = Library.Theme.Header
RadioHeader.BorderSizePixel = 0
RadioHeader.Parent = RadioHUDFrame

local MusicIcon = Instance.new("ImageLabel")
MusicIcon.Name = "MusicIcon"
MusicIcon.Size = UDim2.new(0, 16, 0, 16)
MusicIcon.Position = UDim2.new(0, 8, 0.5, -8)
MusicIcon.BackgroundTransparency = 1
MusicIcon.Image = "rbxassetid://17387359605"
MusicIcon.ImageColor3 = Library.Theme.Accent
MusicIcon.Parent = RadioHeader

local RHTitle = Instance.new("TextLabel")
RHTitle.Size = UDim2.new(1, -85, 1, 0)
RHTitle.Position = UDim2.new(0, 28, 0, 0)
RHTitle.BackgroundTransparency = 1
RHTitle.Font = Library.Fonts.Header
RHTitle.Text = "RADIO PLAYER"
RHTitle.TextColor3 = Library.Theme.Text
RHTitle.TextSize = 11
RHTitle.TextXAlignment = Enum.TextXAlignment.Left
RHTitle.Parent = RadioHeader

local HUDPlayBtn = Instance.new("TextButton")
HUDPlayBtn.Size = UDim2.new(0, 55, 0, 20)
HUDPlayBtn.Position = UDim2.new(1, -60, 0.5, -10)
HUDPlayBtn.BackgroundColor3 = Library.Theme.Card
HUDPlayBtn.BorderSizePixel = 0
HUDPlayBtn.Font = Library.Fonts.Badge
HUDPlayBtn.Text = "PLAY"
HUDPlayBtn.TextColor3 = Library.Theme.Accent
HUDPlayBtn.TextSize = 9
HUDPlayBtn.Parent = RadioHeader

makeDraggable(RadioHUDFrame, RadioHeader)

local HUDSoundInputBg = Instance.new("Frame")
HUDSoundInputBg.Size = UDim2.new(1, -16, 0, 26)
HUDSoundInputBg.Position = UDim2.new(0, 8, 0, 32)
HUDSoundInputBg.BackgroundColor3 = Library.Theme.Header
HUDSoundInputBg.BorderSizePixel = 0
HUDSoundInputBg.Parent = RadioHUDFrame

local HUDSoundInput = Instance.new("TextBox")
HUDSoundInput.Size = UDim2.new(1, -10, 1, 0)
HUDSoundInput.Position = UDim2.new(0, 5, 0, 0)
HUDSoundInput.BackgroundTransparency = 1
HUDSoundInput.Font = Library.Fonts.Badge
HUDSoundInput.PlaceholderText = "Paste Sound ID (e.g. 1837843912)..."
HUDSoundInput.PlaceholderColor3 = Library.Theme.TextDim
HUDSoundInput.Text = ""
HUDSoundInput.TextColor3 = Library.Theme.Accent
HUDSoundInput.TextSize = 10
HUDSoundInput.TextXAlignment = Enum.TextXAlignment.Left
HUDSoundInput.Active = true
HUDSoundInput.Selectable = true
HUDSoundInput.ClearTextOnFocus = false
HUDSoundInput.ZIndex = 15
HUDSoundInput.Parent = HUDSoundInputBg

local RadioTrackLabel = Instance.new("TextLabel")
RadioTrackLabel.Size = UDim2.new(1, -16, 0, 14)
RadioTrackLabel.Position = UDim2.new(0, 8, 0, 61)
RadioTrackLabel.BackgroundTransparency = 1
RadioTrackLabel.Font = Library.Fonts.Label
RadioTrackLabel.Text = "No Track Playing"
RadioTrackLabel.TextColor3 = Library.Theme.TextDim
RadioTrackLabel.TextSize = 9
RadioTrackLabel.TextXAlignment = Enum.TextXAlignment.Left
RadioTrackLabel.Parent = RadioHUDFrame

local SeekRow = Instance.new("Frame")
SeekRow.Size = UDim2.new(1, -16, 0, 26)
SeekRow.Position = UDim2.new(0, 8, 0, 78)
SeekRow.BackgroundTransparency = 1
SeekRow.Parent = RadioHUDFrame

local SeekTimeLabel = Instance.new("TextLabel")
SeekTimeLabel.Size = UDim2.new(1, 0, 0, 12)
SeekTimeLabel.Position = UDim2.new(0, 0, 0, 0)
SeekTimeLabel.BackgroundTransparency = 1
SeekTimeLabel.Font = Library.Fonts.Badge
SeekTimeLabel.Text = "00:00 / 00:00"
SeekTimeLabel.TextColor3 = Library.Theme.Accent
SeekTimeLabel.TextSize = 9
SeekTimeLabel.TextXAlignment = Enum.TextXAlignment.Right
SeekTimeLabel.Parent = SeekRow

local SeekTrackBg = Instance.new("TextButton")
SeekTrackBg.Size = UDim2.new(1, 0, 0, 8)
SeekTrackBg.Position = UDim2.new(0, 0, 0, 14)
SeekTrackBg.BackgroundColor3 = Library.Theme.Header
SeekTrackBg.BorderSizePixel = 0
SeekTrackBg.AutoButtonColor = false
SeekTrackBg.Text = ""
SeekTrackBg.Parent = SeekRow

local SeekFill = Instance.new("Frame")
SeekFill.Size = UDim2.new(0, 0, 1, 0)
SeekFill.BackgroundColor3 = Library.Theme.Accent
SeekFill.BorderSizePixel = 0
SeekFill.Parent = SeekTrackBg

local SeekHandle = Instance.new("Frame")
SeekHandle.Size = UDim2.new(0, 10, 0, 12)
SeekHandle.Position = UDim2.new(0, -5, 0.5, -6)
SeekHandle.BackgroundColor3 = Library.Theme.Accent
SeekHandle.BorderSizePixel = 0
SeekHandle.Parent = SeekTrackBg

local isSeeking = false
trackConnection(SeekTrackBg.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isSeeking = true
        local width = SeekTrackBg.AbsoluteSize.X
        if width > 0 and RadioSound.TimeLength > 0 then
            local relX = math.clamp((input.Position.X - SeekTrackBg.AbsolutePosition.X) / width, 0, 1)
            RadioSound.TimePosition = relX * RadioSound.TimeLength
        end
    end
end))

trackConnection(UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isSeeking = false
    end
end))

trackConnection(UserInputService.InputChanged:Connect(function(input)
    if isSeeking and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local width = SeekTrackBg.AbsoluteSize.X
        if width > 0 and RadioSound.TimeLength > 0 then
            local relX = math.clamp((input.Position.X - SeekTrackBg.AbsolutePosition.X) / width, 0, 1)
            RadioSound.TimePosition = relX * RadioSound.TimeLength
        end
    end
end))

trackConnection(RunService.RenderStepped:Connect(function()
    if RadioSound.IsPlaying or RadioSound.TimePosition > 0 then
        local totalLength = RadioSound.TimeLength
        local currentPos = RadioSound.TimePosition
        if totalLength > 0 then
            local progress = math.clamp(currentPos / totalLength, 0, 1)
            if not isSeeking then
                SeekFill.Size = UDim2.new(progress, 0, 1, 0)
                SeekHandle.Position = UDim2.new(progress, -5, 0.5, -6)
            end
            SeekTimeLabel.Text = formatTime(currentPos) .. " / " .. formatTime(totalLength)
        else
            SeekTimeLabel.Text = formatTime(currentPos) .. " / --:--"
        end
    else
        SeekTimeLabel.Text = "00:00 / 00:00"
        if not isSeeking then
            SeekFill.Size = UDim2.new(0, 0, 1, 0)
            SeekHandle.Position = UDim2.new(0, -5, 0.5, -6)
        end
    end
end))

local SpeedRow = Instance.new("Frame")
SpeedRow.Size = UDim2.new(1, -16, 0, 24)
SpeedRow.Position = UDim2.new(0, 8, 0, 110)
SpeedRow.BackgroundTransparency = 1
SpeedRow.Parent = RadioHUDFrame

local SpeedLbl = Instance.new("TextLabel")
SpeedLbl.Size = UDim2.new(0, 45, 1, 0)
SpeedLbl.BackgroundTransparency = 1
SpeedLbl.Font = Library.Fonts.Label
SpeedLbl.Text = "Speed:"
SpeedLbl.TextColor3 = Library.Theme.TextDim
SpeedLbl.TextSize = 10
SpeedLbl.TextXAlignment = Enum.TextXAlignment.Left
SpeedLbl.Parent = SpeedRow

local speeds = {
    { Text = "0.5x", Val = 0.5 },
    { Text = "1.0x", Val = 1.0 },
    { Text = "1.25x", Val = 1.25 },
    { Text = "1.5x", Val = 1.5 },
    { Text = "2.0x", Val = 2.0 }
}

for i, spData in ipairs(speeds) do
    local SpBtn = Instance.new("TextButton")
    SpBtn.Size = UDim2.new(0, 36, 0, 18)
    SpBtn.Position = UDim2.new(0, 45 + ((i - 1) * 39), 0.5, -9)
    SpBtn.BackgroundColor3 = (spData.Val == RadioSound.PlaybackSpeed) and Library.Theme.Header or Library.Theme.Card
    SpBtn.BorderSizePixel = 0
    SpBtn.Font = Library.Fonts.Badge
    SpBtn.Text = spData.Text
    SpBtn.TextColor3 = (spData.Val == RadioSound.PlaybackSpeed) and Library.Theme.Accent or Library.Theme.TextDim
    SpBtn.TextSize = 9
    SpBtn.Parent = SpeedRow

    SpBtn.MouseButton1Click:Connect(function()
        RadioSound.PlaybackSpeed = spData.Val
        for _, child in ipairs(SpeedRow:GetChildren()) do
            if child:IsA("TextButton") then
                local isMatch = (child.Text == spData.Text)
                tween(child, 0.15, {
                    BackgroundColor3 = isMatch and Library.Theme.Header or Library.Theme.Card,
                    TextColor3 = isMatch and Library.Theme.Accent or Library.Theme.TextDim
                })
            end
        end
    end)
end

local function triggerPlaySound(rawId)
    local soundAsset = formatAssetId(rawId)
    if soundAsset ~= "" then
        RadioSound.SoundId = soundAsset
        RadioSound:Play()
        RadioTrackLabel.Text = "Track: " .. soundAsset
        HUDPlayBtn.Text = "PAUSE"
        print("[Nursultan] Playing Sound Track:", soundAsset)
    end
end

HUDSoundInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        triggerPlaySound(HUDSoundInput.Text)
    end
end)

HUDPlayBtn.MouseButton1Click:Connect(function()
    if RadioSound.IsPlaying then
        RadioSound:Pause()
        HUDPlayBtn.Text = "PLAY"
    else
        if HUDSoundInput.Text ~= "" then
            triggerPlaySound(HUDSoundInput.Text)
        elseif RadioSound.SoundId ~= "" then
            RadioSound:Play()
            HUDPlayBtn.Text = "PAUSE"
        end
    end
end)

-- Settings Modal Frame (No Rounded Corners)
local SettingsModal = Instance.new("Frame")
SettingsModal.Name = "SettingsModal"
SettingsModal.Size = UDim2.new(0, 480, 0, 460)
SettingsModal.Position = UDim2.new(0.5, -240, 0.5, -230)
SettingsModal.BackgroundColor3 = Library.Theme.Block
SettingsModal.BorderSizePixel = 0
SettingsModal.Visible = false
SettingsModal.ZIndex = 20
SettingsModal.Parent = Container

local ModalStroke = Instance.new("UIStroke")
ModalStroke.Color = Library.Theme.StrokeActive
ModalStroke.Thickness = 1.5
ModalStroke.Parent = SettingsModal

local ModalHeader = Instance.new("Frame")
ModalHeader.Name = "ModalHeader"
ModalHeader.Size = UDim2.new(1, 0, 0, 40)
ModalHeader.BackgroundColor3 = Library.Theme.Header
ModalHeader.BorderSizePixel = 0
ModalHeader.ZIndex = 21
ModalHeader.Parent = SettingsModal

local ModalTitle = Instance.new("TextLabel")
ModalTitle.Size = UDim2.new(1, -50, 1, 0)
ModalTitle.Position = UDim2.new(0, 15, 0, 0)
ModalTitle.BackgroundTransparency = 1
ModalTitle.Font = Library.Fonts.Header
ModalTitle.Text = "CLIENT SETTINGS, JSON CONFIGS & SKYBOX"
ModalTitle.TextColor3 = Library.Theme.Text
ModalTitle.TextSize = 11
ModalTitle.TextXAlignment = Enum.TextXAlignment.Left
ModalTitle.ZIndex = 22
ModalTitle.Parent = ModalHeader

local CloseModalBtn = Instance.new("TextButton")
CloseModalBtn.Size = UDim2.new(0, 26, 0, 26)
CloseModalBtn.Position = UDim2.new(1, -34, 0.5, -13)
CloseModalBtn.BackgroundTransparency = 1
CloseModalBtn.Font = Library.Fonts.Header
CloseModalBtn.Text = "X"
CloseModalBtn.TextColor3 = Library.Theme.TextDim
CloseModalBtn.TextSize = 13
CloseModalBtn.ZIndex = 22
CloseModalBtn.Parent = ModalHeader

makeDraggable(SettingsModal, ModalHeader)

local ModalScroll = Instance.new("ScrollingFrame")
ModalScroll.Size = UDim2.new(1, -20, 1, -55)
ModalScroll.Position = UDim2.new(0, 10, 0, 48)
ModalScroll.BackgroundTransparency = 1
ModalScroll.BorderSizePixel = 0
ModalScroll.ScrollBarThickness = 4
ModalScroll.ScrollBarImageColor3 = Library.Theme.Accent
ModalScroll.ZIndex = 21
ModalScroll.Parent = SettingsModal

local ModalLayout = Instance.new("UIListLayout")
ModalLayout.SortOrder = Enum.SortOrder.LayoutOrder
ModalLayout.Padding = UDim.new(0, 8)
ModalLayout.Parent = ModalScroll

ModalLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ModalScroll.CanvasSize = UDim2.new(0, 0, 0, ModalLayout.AbsoluteContentSize.Y + 20)
end)

local function addModalSectionLabel(text)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -10, 0, 22)
    Frame.BackgroundTransparency = 1
    Frame.ZIndex = 22
    Frame.Parent = ModalScroll

    local Lbl = Instance.new("TextLabel")
    Lbl.Size = UDim2.new(0, 0, 1, 0)
    Lbl.AutomaticSize = Enum.AutomaticSize.X
    Lbl.BackgroundTransparency = 1
    Lbl.Font = Library.Fonts.Header
    Lbl.Text = string.upper(text)
    Lbl.TextColor3 = Library.Theme.Accent
    Lbl.TextSize = 11
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.ZIndex = 22
    Lbl.Parent = Frame

    local Line = Instance.new("Frame")
    Line.Size = UDim2.new(1, 0, 0, 1)
    Line.Position = UDim2.new(0, 0, 0.5, 0)
    Line.BackgroundColor3 = Library.Theme.Stroke
    Line.BorderSizePixel = 0
    Line.ZIndex = 22
    Line.Parent = Frame

    Lbl:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        local w = Lbl.AbsoluteSize.X
        Line.Position = UDim2.new(0, w + 10, 0.5, 0)
        Line.Size = UDim2.new(1, -(w + 10), 0, 1)
    end)

    table.insert(Library.ModalElements, { Label = Lbl, Line = Line })
end

addModalSectionLabel("Workspace Config Manager")

local ConfigCard = Instance.new("Frame")
ConfigCard.Size = UDim2.new(1, -10, 0, 120)
ConfigCard.BackgroundColor3 = Library.Theme.Card
ConfigCard.BorderSizePixel = 0
ConfigCard.ZIndex = 22
ConfigCard.Parent = ModalScroll

local ConfigNameBg = Instance.new("Frame")
ConfigNameBg.Size = UDim2.new(1, -145, 0, 30)
ConfigNameBg.Position = UDim2.new(0, 8, 0, 10)
ConfigNameBg.BackgroundColor3 = Library.Theme.Header
ConfigNameBg.BorderSizePixel = 0
ConfigNameBg.ZIndex = 23
ConfigNameBg.Parent = ConfigCard

local ConfigNameInput = Instance.new("TextBox")
ConfigNameInput.Size = UDim2.new(1, -10, 1, 0)
ConfigNameInput.Position = UDim2.new(0, 5, 0, 0)
ConfigNameInput.BackgroundTransparency = 1
ConfigNameInput.Font = Library.Fonts.Badge
ConfigNameInput.PlaceholderText = "Config Name (e.g. Rage, Legit)..."
ConfigNameInput.PlaceholderColor3 = Library.Theme.TextDim
ConfigNameInput.Text = "default"
ConfigNameInput.TextColor3 = Library.Theme.Accent
ConfigNameInput.TextSize = 11
ConfigNameInput.TextXAlignment = Enum.TextXAlignment.Left
ConfigNameInput.Active = true
ConfigNameInput.Selectable = true
ConfigNameInput.ClearTextOnFocus = false
ConfigNameInput.ZIndex = 25
ConfigNameInput.Parent = ConfigNameBg

-- Save Config Button with Custom Image Icon: rbxassetid://110746782819291
local SaveCreateBtn = Instance.new("TextButton")
SaveCreateBtn.Size = UDim2.new(0, 125, 0, 30)
SaveCreateBtn.Position = UDim2.new(1, -133, 0, 10)
SaveCreateBtn.BackgroundColor3 = Library.Theme.Header
SaveCreateBtn.BorderSizePixel = 0
SaveCreateBtn.Font = Library.Fonts.Header
SaveCreateBtn.Text = "  SAVE"
SaveCreateBtn.TextColor3 = Library.Theme.Accent
SaveCreateBtn.TextSize = 10
SaveCreateBtn.ZIndex = 23
SaveCreateBtn.Parent = ConfigCard

local SaveIcon = Instance.new("ImageLabel")
SaveIcon.Size = UDim2.new(0, 16, 0, 16)
SaveIcon.Position = UDim2.new(0, 8, 0.5, -8)
SaveIcon.BackgroundTransparency = 1
SaveIcon.Image = "rbxassetid://110746782819291"
SaveIcon.ImageColor3 = Library.Theme.Accent
SaveIcon.ZIndex = 24
SaveIcon.Parent = SaveCreateBtn

-- Action Buttons Row: Load & Delete (Delete Icon: rbxassetid://81109897851133)
local LoadConfigBtn = Instance.new("TextButton")
LoadConfigBtn.Size = UDim2.new(0.48, 0, 0, 30)
LoadConfigBtn.Position = UDim2.new(0, 8, 0, 50)
LoadConfigBtn.BackgroundColor3 = Library.Theme.Header
LoadConfigBtn.BorderSizePixel = 0
LoadConfigBtn.Font = Library.Fonts.Header
LoadConfigBtn.Text = "LOAD CONFIG"
LoadConfigBtn.TextColor3 = Library.Theme.Text
LoadConfigBtn.TextSize = 11
LoadConfigBtn.ZIndex = 23
LoadConfigBtn.Parent = ConfigCard

local DeleteConfigBtn = Instance.new("TextButton")
DeleteConfigBtn.Size = UDim2.new(0.48, 0, 0, 30)
DeleteConfigBtn.Position = UDim2.new(0.52, -4, 0, 50)
DeleteConfigBtn.BackgroundColor3 = Library.Theme.Header
DeleteConfigBtn.BorderSizePixel = 0
DeleteConfigBtn.Font = Library.Fonts.Header
DeleteConfigBtn.Text = "   DELETE"
DeleteConfigBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
DeleteConfigBtn.TextSize = 11
DeleteConfigBtn.ZIndex = 23
DeleteConfigBtn.Parent = ConfigCard

local DeleteIcon = Instance.new("ImageLabel")
DeleteIcon.Size = UDim2.new(0, 16, 0, 16)
DeleteIcon.Position = UDim2.new(0, 12, 0.5, -8)
DeleteIcon.BackgroundTransparency = 1
DeleteIcon.Image = "rbxassetid://81109897851133"
DeleteIcon.ImageColor3 = Color3.fromRGB(255, 90, 90)
DeleteIcon.ZIndex = 24
DeleteIcon.Parent = DeleteConfigBtn

local ConfigStatusLabel = Instance.new("TextLabel")
ConfigStatusLabel.Size = UDim2.new(1, -16, 0, 20)
ConfigStatusLabel.Position = UDim2.new(0, 8, 0, 90)
ConfigStatusLabel.BackgroundTransparency = 1
ConfigStatusLabel.Font = Library.Fonts.Label
ConfigStatusLabel.Text = "Config Folder: workspace/" .. Library.ConfigFolder
ConfigStatusLabel.TextColor3 = Library.Theme.TextDim
ConfigStatusLabel.TextSize = 10
ConfigStatusLabel.TextXAlignment = Enum.TextXAlignment.Left
ConfigStatusLabel.ZIndex = 23
ConfigStatusLabel.Parent = ConfigCard

SaveCreateBtn.MouseButton1Click:Connect(function()
    local name = ConfigNameInput.Text:gsub("%s+", "")
    if name == "" then name = "default" end
    local filePath = Library.ConfigFolder .. "/" .. name .. ".json"

    local data = {
        Theme = Library.CurrentThemeName,
        BlurEnabled = Library.BlurEnabled,
        SnowEnabled = Library.SnowEnabled,
        Blocks = {}
    }

    for _, block in ipairs(Library.Blocks) do
        local blockData = { Title = block.Title, Expanded = block.Expanded, Elements = {} }
        for _, elem in ipairs(block.Elements) do
            if elem.Type == "Toggle" then
                table.insert(blockData.Elements, { Type = "Toggle", Name = elem.Label.Text, Value = elem.GetState() })
            end
        end
        table.insert(data.Blocks, blockData)
    end

    pcall(function()
        if writefile then
            writefile(filePath, HttpService:JSONEncode(data))
            ConfigStatusLabel.Text = "Saved: " .. name .. ".json"
            print("[Nursultan] Saved config to workspace:", filePath)
        end
    end)
end)

LoadConfigBtn.MouseButton1Click:Connect(function()
    local name = ConfigNameInput.Text:gsub("%s+", "")
    if name == "" then name = "default" end
    local filePath = Library.ConfigFolder .. "/" .. name .. ".json"

    pcall(function()
        if readfile and isfile and isfile(filePath) then
            local decoded = HttpService:JSONDecode(readfile(filePath))
            if decoded then
                if decoded.Theme then Library:SetTheme(decoded.Theme) end
                ConfigStatusLabel.Text = "Loaded: " .. name .. ".json"
                print("[Nursultan] Loaded config from workspace:", filePath)
            end
        else
            ConfigStatusLabel.Text = "Config not found: " .. name .. ".json"
        end
    end)
end)

DeleteConfigBtn.MouseButton1Click:Connect(function()
    local name = ConfigNameInput.Text:gsub("%s+", "")
    if name == "" then name = "default" end
    local filePath = Library.ConfigFolder .. "/" .. name .. ".json"

    pcall(function()
        if delfile and isfile and isfile(filePath) then
            delfile(filePath)
            ConfigStatusLabel.Text = "Deleted: " .. name .. ".json"
            print("[Nursultan] Deleted config:", filePath)
        end
    end)
end)

addModalSectionLabel("Custom Skybox Manager")

local SkyboxCard = Instance.new("Frame")
SkyboxCard.Size = UDim2.new(1, -10, 0, 185)
SkyboxCard.BackgroundColor3 = Library.Theme.Card
SkyboxCard.BorderSizePixel = 0
SkyboxCard.ZIndex = 22
SkyboxCard.Parent = ModalScroll

local SkyInputs = {}
local faces = {
    { Name = "Skybox Front / Back (Line 1)", Key1 = "SkyboxFt", Key2 = "SkyboxBk" },
    { Name = "Skybox Left / Right (Line 2)", Key1 = "SkyboxLf", Key2 = "SkyboxRt" },
    { Name = "Skybox Top Texture (Line 3)", Key1 = "SkyboxUp", Key2 = nil },
    { Name = "Skybox Bottom Texture (Line 4)", Key1 = "SkyboxDn", Key2 = nil }
}

for i, faceData in ipairs(faces) do
    local InputRow = Instance.new("Frame")
    InputRow.Size = UDim2.new(1, -16, 0, 32)
    InputRow.Position = UDim2.new(0, 8, 0, 8 + ((i - 1) * 36))
    InputRow.BackgroundTransparency = 1
    InputRow.ZIndex = 23
    InputRow.Parent = SkyboxCard

    local FaceLbl = Instance.new("TextLabel")
    FaceLbl.Size = UDim2.new(0, 180, 1, 0)
    FaceLbl.BackgroundTransparency = 1
    FaceLbl.Font = Library.Fonts.Label
    FaceLbl.Text = faceData.Name
    FaceLbl.TextColor3 = Library.Theme.TextDim
    FaceLbl.TextSize = 10
    FaceLbl.TextXAlignment = Enum.TextXAlignment.Left
    FaceLbl.ZIndex = 23
    FaceLbl.Parent = InputRow

    local BoxBg = Instance.new("Frame")
    BoxBg.Size = UDim2.new(1, -185, 0, 26)
    BoxBg.Position = UDim2.new(0, 185, 0.5, -13)
    BoxBg.BackgroundColor3 = Library.Theme.Header
    BoxBg.BorderSizePixel = 0
    BoxBg.ZIndex = 23
    BoxBg.Parent = InputRow

    local TxtInput = Instance.new("TextBox")
    TxtInput.Size = UDim2.new(1, -10, 1, 0)
    TxtInput.Position = UDim2.new(0, 5, 0, 0)
    TxtInput.BackgroundTransparency = 1
    TxtInput.Font = Library.Fonts.Badge
    TxtInput.PlaceholderText = "Paste Texture ID or rbxassetid://..."
    TxtInput.PlaceholderColor3 = Library.Theme.TextDim
    TxtInput.Text = ""
    TxtInput.TextColor3 = Library.Theme.Accent
    TxtInput.TextSize = 10
    TxtInput.TextXAlignment = Enum.TextXAlignment.Left
    TxtInput.Active = true
    TxtInput.Selectable = true
    TxtInput.ClearTextOnFocus = false
    TxtInput.ZIndex = 35
    TxtInput.Parent = BoxBg

    SkyInputs[i] = { Input = TxtInput, Key1 = faceData.Key1, Key2 = faceData.Key2, BoxBg = BoxBg }
end

local ApplySkyboxBtn = Instance.new("TextButton")
ApplySkyboxBtn.Size = UDim2.new(1, -16, 0, 28)
ApplySkyboxBtn.Position = UDim2.new(0, 8, 0, 150)
ApplySkyboxBtn.BackgroundColor3 = Library.Theme.Header
ApplySkyboxBtn.BorderSizePixel = 0
ApplySkyboxBtn.Font = Library.Fonts.Header
ApplySkyboxBtn.Text = "EXECUTE CUSTOM SKYBOX"
ApplySkyboxBtn.TextColor3 = Library.Theme.Accent
ApplySkyboxBtn.TextSize = 11
ApplySkyboxBtn.ZIndex = 23
ApplySkyboxBtn.Parent = SkyboxCard

ApplySkyboxBtn.MouseButton1Click:Connect(function()
    local skyObj = Lighting:FindFirstChildOfClass("Sky")
    if not skyObj then
        skyObj = Instance.new("Sky")
        skyObj.Name = "NursultanCustomSky"
        skyObj.Parent = Lighting
    end

    for idx, item in ipairs(SkyInputs) do
        local formatted = formatAssetId(item.Input.Text)
        if formatted ~= "" then
            if item.Key1 then pcall(function() skyObj[item.Key1] = formatted end) end
            if item.Key2 then pcall(function() skyObj[item.Key2] = formatted end) end
        end
    end
    print("[Nursultan] Custom Skybox Executed!")
end)

addModalSectionLabel("Visual Effects & Render")

local BlurToggleBlock = Instance.new("TextButton")
BlurToggleBlock.Size = UDim2.new(1, -10, 0, 36)
BlurToggleBlock.BackgroundColor3 = Library.Theme.Card
BlurToggleBlock.BorderSizePixel = 0
BlurToggleBlock.AutoButtonColor = false
BlurToggleBlock.Text = ""
BlurToggleBlock.ZIndex = 22
BlurToggleBlock.Parent = ModalScroll

local BTLabel = Instance.new("TextLabel")
BTLabel.Size = UDim2.new(1, -60, 1, 0)
BTLabel.Position = UDim2.new(0, 12, 0, 0)
BTLabel.BackgroundTransparency = 1
BTLabel.Font = Library.Fonts.Label
BTLabel.Text = "Background Blur Effect"
BTLabel.TextColor3 = Library.Theme.Text
BTLabel.TextSize = 12
BTLabel.TextXAlignment = Enum.TextXAlignment.Left
BTLabel.ZIndex = 23
BTLabel.Parent = BlurToggleBlock

local BTSwitchBg = Instance.new("Frame")
BTSwitchBg.Size = UDim2.new(0, 36, 0, 20)
BTSwitchBg.Position = UDim2.new(1, -48, 0.5, -10)
BTSwitchBg.BackgroundColor3 = Library.BlurEnabled and Library.Theme.Accent or Library.Theme.Header
BTSwitchBg.BorderSizePixel = 0
BTSwitchBg.ZIndex = 23
BTSwitchBg.Parent = BlurToggleBlock

local BTKnob = Instance.new("Frame")
BTKnob.Size = UDim2.new(0, 16, 0, 16)
BTKnob.Position = Library.BlurEnabled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
BTKnob.BackgroundColor3 = Library.BlurEnabled and Library.Theme.Background or Library.Theme.TextDim
BTKnob.BorderSizePixel = 0
BTKnob.ZIndex = 24
BTKnob.Parent = BTSwitchBg

BlurToggleBlock.MouseButton1Click:Connect(function()
    Library.BlurEnabled = not Library.BlurEnabled
    tween(BTSwitchBg, 0.18, { BackgroundColor3 = Library.BlurEnabled and Library.Theme.Accent or Library.Theme.Header })
    tween(BTKnob, 0.18, {
        Position = Library.BlurEnabled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8),
        BackgroundColor3 = Library.BlurEnabled and Library.Theme.Background or Library.Theme.TextDim
    }, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    MenuBlur.Enabled = Library.BlurEnabled and Library.Enabled
end)

local SnowToggleBlock = Instance.new("TextButton")
SnowToggleBlock.Size = UDim2.new(1, -10, 0, 36)
SnowToggleBlock.BackgroundColor3 = Library.Theme.Card
SnowToggleBlock.BorderSizePixel = 0
SnowToggleBlock.AutoButtonColor = false
SnowToggleBlock.Text = ""
SnowToggleBlock.ZIndex = 22
SnowToggleBlock.Parent = ModalScroll

local STLabel = Instance.new("TextLabel")
STLabel.Size = UDim2.new(1, -60, 1, 0)
STLabel.Position = UDim2.new(0, 12, 0, 0)
STLabel.BackgroundTransparency = 1
STLabel.Font = Library.Fonts.Label
STLabel.Text = "Screen Snow Falling Particles"
STLabel.TextColor3 = Library.Theme.Text
STLabel.TextSize = 12
STLabel.TextXAlignment = Enum.TextXAlignment.Left
STLabel.ZIndex = 23
STLabel.Parent = SnowToggleBlock

local STSwitchBg = Instance.new("Frame")
STSwitchBg.Size = UDim2.new(0, 36, 0, 20)
STSwitchBg.Position = UDim2.new(1, -48, 0.5, -10)
STSwitchBg.BackgroundColor3 = Library.SnowEnabled and Library.Theme.Accent or Library.Theme.Header
STSwitchBg.BorderSizePixel = 0
STSwitchBg.ZIndex = 23
STSwitchBg.Parent = SnowToggleBlock

local STKnob = Instance.new("Frame")
STKnob.Size = UDim2.new(0, 16, 0, 16)
STKnob.Position = Library.SnowEnabled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
STKnob.BackgroundColor3 = Library.SnowEnabled and Library.Theme.Background or Library.Theme.TextDim
STKnob.BorderSizePixel = 0
STKnob.ZIndex = 24
STKnob.Parent = STSwitchBg

SnowToggleBlock.MouseButton1Click:Connect(function()
    Library.SnowEnabled = not Library.SnowEnabled
    tween(STSwitchBg, 0.18, { BackgroundColor3 = Library.SnowEnabled and Library.Theme.Accent or Library.Theme.Header })
    tween(STKnob, 0.18, {
        Position = Library.SnowEnabled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8),
        BackgroundColor3 = Library.SnowEnabled and Library.Theme.Background or Library.Theme.TextDim
    }, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    SnowFolder.Visible = Library.SnowEnabled and Library.Enabled
end)

addModalSectionLabel("Themes & Customization")

local ThemeCard = Instance.new("Frame")
ThemeCard.Size = UDim2.new(1, -10, 0, 40)
ThemeCard.BackgroundColor3 = Library.Theme.Card
ThemeCard.BorderSizePixel = 0
ThemeCard.ZIndex = 22
ThemeCard.Parent = ModalScroll

local TCLabel = Instance.new("TextLabel")
TCLabel.Size = UDim2.new(0, 150, 1, 0)
TCLabel.Position = UDim2.new(0, 12, 0, 0)
TCLabel.BackgroundTransparency = 1
TCLabel.Font = Library.Fonts.Label
TCLabel.Text = "Color Theme"
TCLabel.TextColor3 = Library.Theme.Text
TCLabel.TextSize = 12
TCLabel.TextXAlignment = Enum.TextXAlignment.Left
TCLabel.ZIndex = 23
TCLabel.Parent = ThemeCard

local themeNames = {"Monochrome Dark", "Midnight Purple", "Emerald Cyan", "Ruby Red"}
for idx, thName in ipairs(themeNames) do
    local ThBtn = Instance.new("TextButton")
    ThBtn.Size = UDim2.new(0, 70, 0, 24)
    ThBtn.Position = UDim2.new(1, -295 + ((idx - 1) * 73), 0.5, -12)
    ThBtn.BackgroundColor3 = (thName == Library.CurrentThemeName) and Library.Theme.Accent or Library.Theme.Header
    ThBtn.BorderSizePixel = 0
    ThBtn.Font = Library.Fonts.Badge
    ThBtn.Text = string.sub(thName, 1, 9)
    ThBtn.TextColor3 = (thName == Library.CurrentThemeName) and Library.Theme.Background or Library.Theme.TextDim
    ThBtn.TextSize = 9
    ThBtn.ZIndex = 24
    ThBtn.Parent = ThemeCard

    ThBtn.MouseButton1Click:Connect(function()
        Library:SetTheme(thName)
    end)
end

local function toggleSettingsModal(visible)
    if visible == nil then visible = not SettingsModal.Visible end
    if visible then
        SettingsModal.Visible = true
        SettingsModal.Position = UDim2.new(0.5, -240, 0.5, -210)
        SettingsModal.Size = UDim2.new(0, 480, 0, 460)
        tween(SettingsModal, 0.3, { Position = UDim2.new(0.5, -240, 0.5, -230) }, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    else
        tween(SettingsModal, 0.2, { Position = UDim2.new(0.5, -240, 0.5, -190) }, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
        task.wait(0.2)
        SettingsModal.Visible = false
    end
end

CloseModalBtn.MouseButton1Click:Connect(function()
    toggleSettingsModal(false)
end)

GearIcon.MouseButton1Click:Connect(function()
    tween(GearIcon, 0.3, { Rotation = 180 }, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    toggleSettingsModal()
end)

-- FULL LIVE THEME SWITCHER ENGINE (Updates Modal + All Blocks live!)
function Library:SetTheme(themeName)
    local t = Library.Themes[themeName]
    if not t then return end
    Library.Theme = t
    Library.CurrentThemeName = themeName

    tween(Watermark, 0.2, { BackgroundColor3 = t.Block })
    tween(WMarkStroke, 0.2, { Color = t.Stroke })
    tween(WMarkAccent, 0.2, { BackgroundColor3 = t.Accent })
    tween(WMarkLabel, 0.2, { TextColor3 = t.Text })

    tween(GearBtnFrame, 0.2, { BackgroundColor3 = t.Block })
    tween(GearStroke, 0.2, { Color = t.Accent })
    tween(GearIcon, 0.2, { ImageColor3 = t.Accent })

    tween(KeybindHUDFrame, 0.2, { BackgroundColor3 = t.Block })
    tween(KeybindHUDHeader, 0.2, { BackgroundColor3 = t.Header })
    tween(KeybindHUDStroke, 0.2, { Color = t.Stroke })
    tween(HUDDot, 0.2, { BackgroundColor3 = t.Accent })
    tween(HUDTitle, 0.2, { TextColor3 = t.Text })

    tween(RadioHUDFrame, 0.2, { BackgroundColor3 = t.Block })
    tween(RadioHeader, 0.2, { BackgroundColor3 = t.Header })
    tween(RadioHUDStroke, 0.2, { Color = t.Stroke })
    tween(RHTitle, 0.2, { TextColor3 = t.Text })
    tween(MusicIcon, 0.2, { ImageColor3 = t.Accent })
    tween(HUDPlayBtn, 0.2, { BackgroundColor3 = t.Card, TextColor3 = t.Accent })
    tween(HUDSoundInputBg, 0.2, { BackgroundColor3 = t.Header })
    tween(HUDSoundInput, 0.2, { TextColor3 = t.Accent })
    tween(SeekTimeLabel, 0.2, { TextColor3 = t.Accent })
    tween(SeekTrackBg, 0.2, { BackgroundColor3 = t.Header })
    tween(SeekFill, 0.2, { BackgroundColor3 = t.Accent })
    tween(SeekHandle, 0.2, { BackgroundColor3 = t.Accent })

    -- Update Modal Windows Live
    tween(SettingsModal, 0.2, { BackgroundColor3 = t.Block })
    tween(ModalHeader, 0.2, { BackgroundColor3 = t.Header })
    tween(ModalTitle, 0.2, { TextColor3 = t.Text })
    tween(ModalStroke, 0.2, { Color = t.StrokeActive })

    tween(ConfigCard, 0.2, { BackgroundColor3 = t.Card })
    tween(ConfigNameBg, 0.2, { BackgroundColor3 = t.Header })
    tween(ConfigNameInput, 0.2, { TextColor3 = t.Accent })
    tween(SaveCreateBtn, 0.2, { BackgroundColor3 = t.Header, TextColor3 = t.Accent })
    tween(SaveIcon, 0.2, { ImageColor3 = t.Accent })
    tween(LoadConfigBtn, 0.2, { BackgroundColor3 = t.Header, TextColor3 = t.Text })
    tween(DeleteConfigBtn, 0.2, { BackgroundColor3 = t.Header })

    tween(SkyboxCard, 0.2, { BackgroundColor3 = t.Card })
    tween(ApplySkyboxBtn, 0.2, { BackgroundColor3 = t.Header, TextColor3 = t.Accent })
    for _, item in ipairs(SkyInputs) do
        if item.BoxBg then tween(item.BoxBg, 0.2, { BackgroundColor3 = t.Header }) end
        if item.Input then tween(item.Input, 0.2, { TextColor3 = t.Accent }) end
    end

    tween(BlurToggleBlock, 0.2, { BackgroundColor3 = t.Card })
    tween(BTLabel, 0.2, { TextColor3 = t.Text })
    tween(BTSwitchBg, 0.2, { BackgroundColor3 = Library.BlurEnabled and t.Accent or t.Header })
    tween(BTKnob, 0.2, { BackgroundColor3 = Library.BlurEnabled and t.Background or t.TextDim })

    tween(SnowToggleBlock, 0.2, { BackgroundColor3 = t.Card })
    tween(STLabel, 0.2, { TextColor3 = t.Text })
    tween(STSwitchBg, 0.2, { BackgroundColor3 = Library.SnowEnabled and t.Accent or t.Header })
    tween(STKnob, 0.2, { BackgroundColor3 = Library.SnowEnabled and t.Background or t.TextDim })

    tween(ThemeCard, 0.2, { BackgroundColor3 = t.Card })
    tween(TCLabel, 0.2, { TextColor3 = t.Text })

    for _, elem in ipairs(Library.ModalElements) do
        if elem.Label then tween(elem.Label, 0.2, { TextColor3 = t.Accent }) end
        if elem.Line then tween(elem.Line, 0.2, { BackgroundColor3 = t.Stroke }) end
    end

    for _, child in ipairs(ThemeCard:GetChildren()) do
        if child:IsA("TextButton") then
            local isMatch = (child.Text == string.sub(themeName, 1, 9))
            tween(child, 0.2, {
                BackgroundColor3 = isMatch and t.Accent or t.Header,
                TextColor3 = isMatch and t.Background or t.TextDim
            })
        end
    end

    for _, block in ipairs(Library.Blocks) do
        if block.Frame then tween(block.Frame, 0.2, { BackgroundColor3 = t.Block }) end
        if block.Stroke then tween(block.Stroke, 0.2, { Color = t.Stroke }) end
        if block.Header then tween(block.Header, 0.2, { BackgroundColor3 = t.Header }) end
        if block.TopGlow then tween(block.TopGlow, 0.2, { BackgroundColor3 = t.Accent }) end
        if block.Dot then tween(block.Dot, 0.2, { BackgroundColor3 = t.Accent }) end
        if block.TitleLabel then tween(block.TitleLabel, 0.2, { TextColor3 = t.Text }) end

        for _, elem in ipairs(block.Elements) do
            if elem.Type == "Toggle" then
                tween(elem.Frame, 0.2, { BackgroundColor3 = t.Card })
                tween(elem.Stroke, 0.2, { Color = elem.GetState() and t.StrokeHover or t.Stroke })
                tween(elem.SwitchBg, 0.2, { BackgroundColor3 = elem.GetState() and t.Accent or t.Header })
                tween(elem.Knob, 0.2, { BackgroundColor3 = elem.GetState() and t.Background or t.TextDim })
                tween(elem.Label, 0.2, { TextColor3 = elem.GetState() and t.Text or t.TextDim })
            elseif elem.Type == "Slider" then
                tween(elem.Frame, 0.2, { BackgroundColor3 = t.Card })
                tween(elem.Stroke, 0.2, { Color = t.Stroke })
                tween(elem.Label, 0.2, { TextColor3 = t.TextDim })
                tween(elem.ValBadge, 0.2, { BackgroundColor3 = t.Header })
                tween(elem.ValLabel, 0.2, { TextColor3 = t.Accent })
                tween(elem.TrackBg, 0.2, { BackgroundColor3 = t.Header })
                tween(elem.Fill, 0.2, { BackgroundColor3 = t.Accent })
                tween(elem.Handle, 0.2, { BackgroundColor3 = t.Accent })
            elseif elem.Type == "Button" then
                tween(elem.Frame, 0.2, { BackgroundColor3 = t.Card, TextColor3 = t.Text })
                tween(elem.Stroke, 0.2, { Color = t.Stroke })
            elseif elem.Type == "Dropdown" then
                tween(elem.Frame, 0.2, { BackgroundColor3 = t.Card })
                tween(elem.Stroke, 0.2, { Color = t.Stroke })
                tween(elem.Label, 0.2, { TextColor3 = t.TextDim })
                tween(elem.SelBadge, 0.2, { BackgroundColor3 = t.Header, TextColor3 = t.Accent })
            elseif elem.Type == "Keybind" then
                tween(elem.Frame, 0.2, { BackgroundColor3 = t.Card })
                tween(elem.Stroke, 0.2, { Color = t.Stroke })
                tween(elem.Label, 0.2, { TextColor3 = t.TextDim })
                tween(elem.KeyBtn, 0.2, { BackgroundColor3 = t.Header, TextColor3 = t.Accent })
            end
        end
    end

    if Library.RefreshKeybindHUD then Library:RefreshKeybindHUD() end
end

function Library:SetVisible(visible)
    Library.Enabled = visible
    ScreenGui.Enabled = visible

    if visible then
        if Library.BlurEnabled then
            MenuBlur.Enabled = true
            tween(MenuBlur, 0.25, { Size = Library.BlurSize })
        end
        SnowFolder.Visible = Library.SnowEnabled

        Watermark.BackgroundTransparency = 0
        WMarkStroke.Transparency = 0
        WMarkLabel.TextTransparency = 0
        GearBtnFrame.BackgroundTransparency = 0
        KeybindHUDFrame.BackgroundTransparency = 0
        KeybindHUDStroke.Transparency = 0
        RadioHUDFrame.BackgroundTransparency = 0
        RadioHUDStroke.Transparency = 0

        for i, blockData in ipairs(Library.Blocks) do
            local f = blockData.Frame
            local targetPos = blockData.DefaultPos or f.Position
            f.Position = targetPos
            f.BackgroundTransparency = 0
            if blockData.Stroke then blockData.Stroke.Transparency = 0 end
        end
    else
        MenuBlur.Size = 0
        MenuBlur.Enabled = false
        SnowFolder.Visible = false
        SettingsModal.Visible = false
    end
end

function Library:Toggle()
    Library:SetVisible(not Library.Enabled)
end

trackConnection(UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if Library.ListeningKeybind then return end

    local focused = UserInputService:GetFocusedTextBox()
    if focused then return end

    if input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == Enum.KeyCode.RightShift or input.KeyCode == Library.ToggleKey then
            Library:Toggle()
        end
    end
end))

function Library:CreateBlock(title, defaultPosition)
    local Block = {
        Title = title or "Category",
        Expanded = true,
        Elements = {}
    }

    defaultPosition = defaultPosition or UDim2.new(0.04 + (#Library.Blocks * 0.17), 0, 0.12, 0)
    Block.DefaultPos = defaultPosition

    local Frame = Instance.new("Frame")
    Frame.Name = title .. "_Block"
    Frame.Size = UDim2.new(0, 240, 0, 42)
    Frame.Position = defaultPosition
    Frame.BackgroundColor3 = Library.Theme.Block
    Frame.BorderSizePixel = 0
    Frame.ClipsDescendants = false
    Frame.Parent = Container
    Block.Frame = Frame

    local FrameStroke = Instance.new("UIStroke")
    FrameStroke.Color = Library.Theme.Stroke
    FrameStroke.Thickness = 1.2
    FrameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    FrameStroke.Parent = Frame
    Block.Stroke = FrameStroke

    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Size = UDim2.new(1, 0, 0, 38)
    Header.BackgroundColor3 = Library.Theme.Header
    Header.BorderSizePixel = 0
    Header.Parent = Frame
    Block.Header = Header

    local TopGlow = Instance.new("Frame")
    TopGlow.Size = UDim2.new(1, -16, 0, 2)
    TopGlow.Position = UDim2.new(0, 8, 0, 2)
    TopGlow.BackgroundColor3 = Library.Theme.Accent
    TopGlow.BorderSizePixel = 0
    TopGlow.Parent = Header
    Block.TopGlow = TopGlow

    local Dot = Instance.new("Frame")
    Dot.Size = UDim2.new(0, 6, 0, 6)
    Dot.Position = UDim2.new(0, 12, 0.5, -3)
    Dot.BackgroundColor3 = Library.Theme.Accent
    Dot.BorderSizePixel = 0
    Dot.Parent = Header
    Block.Dot = Dot

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -65, 1, 0)
    TitleLabel.Position = UDim2.new(0, 25, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Font = Library.Fonts.Header
    TitleLabel.Text = string.upper(title)
    TitleLabel.TextColor3 = Library.Theme.Text
    TitleLabel.TextSize = 12
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = Header
    Block.TitleLabel = TitleLabel

    local CollapseBtn = Instance.new("TextButton")
    CollapseBtn.Size = UDim2.new(0, 26, 0, 26)
    CollapseBtn.Position = UDim2.new(1, -30, 0.5, -13)
    CollapseBtn.BackgroundTransparency = 1
    CollapseBtn.Font = Library.Fonts.Header
    CollapseBtn.Text = "-"
    CollapseBtn.TextColor3 = Library.Theme.TextDim
    CollapseBtn.TextSize = 15
    CollapseBtn.Parent = Header

    local Content = Instance.new("Frame")
    Content.Name = "Content"
    Content.Size = UDim2.new(1, 0, 0, 0)
    Content.Position = UDim2.new(0, 0, 0, 38)
    Content.BackgroundTransparency = 1
    Content.ClipsDescendants = false
    Content.Visible = true
    Content.Parent = Frame
    Block.Content = Content

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 5)
    UIListLayout.Parent = Content

    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingTop = UDim.new(0, 6)
    UIPadding.PaddingBottom = UDim.new(0, 8)
    UIPadding.PaddingLeft = UDim.new(0, 8)
    UIPadding.PaddingRight = UDim.new(0, 8)
    UIPadding.Parent = Content

    makeDraggable(Frame, Header)

    local function updateHeight()
        if Block.Expanded then
            Content.Visible = true
            local targetContentHeight = UIListLayout.AbsoluteContentSize.Y + 14
            Content.Size = UDim2.new(1, 0, 0, targetContentHeight)
            tween(Frame, 0.2, { Size = UDim2.new(0, 240, 0, 38 + targetContentHeight) })
        else
            Content.Visible = false
            Content.Size = UDim2.new(1, 0, 0, 0)
            tween(Frame, 0.2, { Size = UDim2.new(0, 240, 0, 38) })
        end
    end

    UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateHeight)

    CollapseBtn.MouseButton1Click:Connect(function()
        Block.Expanded = not Block.Expanded
        CollapseBtn.Text = Block.Expanded and "-" or "+"
        tween(CollapseBtn, 0.2, { Rotation = Block.Expanded and 0 or 180 })
        tween(CollapseBtn, 0.15, { TextColor3 = Block.Expanded and Library.Theme.Text or Library.Theme.TextDim })
        updateHeight()
    end)

    function Block:AddLabel(text)
        local LabelFrame = Instance.new("Frame")
        LabelFrame.Size = UDim2.new(1, 0, 0, 20)
        LabelFrame.BackgroundTransparency = 1
        LabelFrame.Parent = Content

        local TextLabel = Instance.new("TextLabel")
        TextLabel.Size = UDim2.new(0, 0, 1, 0)
        TextLabel.AutomaticSize = Enum.AutomaticSize.X
        TextLabel.BackgroundTransparency = 1
        TextLabel.Font = Library.Fonts.Header
        TextLabel.Text = string.upper(text)
        TextLabel.TextColor3 = Library.Theme.TextDim
        TextLabel.TextSize = 10
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left
        TextLabel.Parent = LabelFrame

        local Line = Instance.new("Frame")
        Line.Size = UDim2.new(1, 0, 0, 1)
        Line.Position = UDim2.new(0, 0, 0.5, 0)
        Line.BackgroundColor3 = Library.Theme.Stroke
        Line.BorderSizePixel = 0
        Line.Parent = LabelFrame

        TextLabel:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
            local w = TextLabel.AbsoluteSize.X
            Line.Position = UDim2.new(0, w + 8, 0.5, 0)
            Line.Size = UDim2.new(1, -(w + 8), 0, 1)
        end)
    end

    function Block:AddToggle(name, default, callback)
        callback = callback or function() end
        local state = default or false

        local ToggleBtn = Instance.new("TextButton")
        ToggleBtn.Name = name .. "_Toggle"
        ToggleBtn.Size = UDim2.new(1, 0, 0, 34)
        ToggleBtn.BackgroundColor3 = Library.Theme.Card
        ToggleBtn.BorderSizePixel = 0
        ToggleBtn.AutoButtonColor = false
        ToggleBtn.Text = ""
        ToggleBtn.Parent = Content

        local Stroke = Instance.new("UIStroke")
        Stroke.Color = Library.Theme.Stroke
        Stroke.Thickness = 1
        Stroke.Parent = ToggleBtn

        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -55, 1, 0)
        Label.Position = UDim2.new(0, 10, 0, 0)
        Label.BackgroundTransparency = 1
        Label.Font = Library.Fonts.Label
        Label.Text = name
        Label.TextColor3 = state and Library.Theme.Text or Library.Theme.TextDim
        Label.TextSize = 12
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = ToggleBtn

        local SwitchBg = Instance.new("Frame")
        SwitchBg.Size = UDim2.new(0, 32, 0, 18)
        SwitchBg.Position = UDim2.new(1, -40, 0.5, -9)
        SwitchBg.BackgroundColor3 = state and Library.Theme.Accent or Library.Theme.Header
        SwitchBg.BorderSizePixel = 0
        SwitchBg.Parent = ToggleBtn

        local SwitchStroke = Instance.new("UIStroke")
        SwitchStroke.Color = state and Library.Theme.Accent or Library.Theme.Stroke
        SwitchStroke.Thickness = 1
        SwitchStroke.Parent = SwitchBg

        local Knob = Instance.new("Frame")
        Knob.Size = UDim2.new(0, 14, 0, 14)
        Knob.Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
        Knob.BackgroundColor3 = state and Library.Theme.Background or Library.Theme.TextDim
        Knob.BorderSizePixel = 0
        Knob.ZIndex = 5
        Knob.Parent = SwitchBg

        local elemData = {
            Type = "Toggle",
            Frame = ToggleBtn,
            Stroke = Stroke,
            SwitchBg = SwitchBg,
            Knob = Knob,
            Label = Label,
            GetState = function() return state end
        }
        table.insert(Block.Elements, elemData)

        local function updateToggle()
            tween(SwitchBg, 0.18, { BackgroundColor3 = state and Library.Theme.Accent or Library.Theme.Header })
            tween(SwitchStroke, 0.18, { Color = state and Library.Theme.Accent or Library.Theme.Stroke })
            tween(Knob, 0.18, {
                Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7),
                BackgroundColor3 = state and Library.Theme.Background or Library.Theme.TextDim
            }, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            tween(Label, 0.18, { TextColor3 = state and Library.Theme.Text or Library.Theme.TextDim })
            tween(Stroke, 0.18, { Color = state and Library.Theme.StrokeHover or Library.Theme.Stroke })
            task.spawn(function() pcall(callback, state) end)
        end

        ToggleBtn.MouseEnter:Connect(function()
            tween(ToggleBtn, 0.15, { BackgroundColor3 = Library.Theme.CardHover })
            if not state then tween(Stroke, 0.15, { Color = Library.Theme.StrokeHover }) end
        end)

        ToggleBtn.MouseLeave:Connect(function()
            tween(ToggleBtn, 0.15, { BackgroundColor3 = Library.Theme.Card })
            if not state then tween(Stroke, 0.15, { Color = Library.Theme.Stroke }) end
        end)

        ToggleBtn.MouseButton1Click:Connect(function()
            state = not state
            updateToggle()
        end)

        return {
            Set = function(_, newState)
                state = newState
                updateToggle()
            end
        }
    end

    function Block:AddDropdown(name, options, default, callback)
        options = options or {}
        default = default or options[1] or ""
        callback = callback or function() end

        local selected = default
        local isOpen = false

        local DropFrame = Instance.new("Frame")
        DropFrame.Name = name .. "_Dropdown"
        DropFrame.Size = UDim2.new(1, 0, 0, 36)
        DropFrame.BackgroundColor3 = Library.Theme.Card
        DropFrame.BorderSizePixel = 0
        DropFrame.ClipsDescendants = false
        DropFrame.ZIndex = 5
        DropFrame.Parent = Content

        local Stroke = Instance.new("UIStroke")
        Stroke.Color = Library.Theme.Stroke
        Stroke.Thickness = 1
        Stroke.Parent = DropFrame

        local HeaderBtn = Instance.new("TextButton")
        HeaderBtn.Size = UDim2.new(1, 0, 0, 36)
        HeaderBtn.BackgroundTransparency = 1
        HeaderBtn.Text = ""
        HeaderBtn.ZIndex = 6
        HeaderBtn.Parent = DropFrame

        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -115, 1, 0)
        Label.Position = UDim2.new(0, 10, 0, 0)
        Label.BackgroundTransparency = 1
        Label.Font = Library.Fonts.Label
        Label.Text = name
        Label.TextColor3 = Library.Theme.TextDim
        Label.TextSize = 11
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.ZIndex = 6
        Label.Parent = HeaderBtn

        local SelBadge = Instance.new("TextLabel")
        SelBadge.Size = UDim2.new(0, 100, 0, 20)
        SelBadge.Position = UDim2.new(1, -105, 0.5, -10)
        SelBadge.BackgroundColor3 = Library.Theme.Header
        SelBadge.BorderSizePixel = 0
        SelBadge.Font = Library.Fonts.Badge
        SelBadge.Text = tostring(selected)
        SelBadge.TextColor3 = Library.Theme.Accent
        SelBadge.TextSize = 10
        SelBadge.ZIndex = 6
        SelBadge.Parent = HeaderBtn

        local OptionContainer = Instance.new("Frame")
        OptionContainer.Size = UDim2.new(1, -16, 0, 0)
        OptionContainer.Position = UDim2.new(0, 8, 0, 36)
        OptionContainer.BackgroundTransparency = 1
        OptionContainer.ClipsDescendants = true
        OptionContainer.ZIndex = 7
        OptionContainer.Parent = DropFrame

        local OptionLayout = Instance.new("UIListLayout")
        OptionLayout.SortOrder = Enum.SortOrder.LayoutOrder
        OptionLayout.Padding = UDim.new(0, 3)
        OptionLayout.Parent = OptionContainer

        local dropdownObject = {
            Close = function()
                if isOpen then
                    isOpen = false
                    tween(OptionContainer, 0.2, { Size = UDim2.new(1, -16, 0, 0) })
                    tween(DropFrame, 0.2, { Size = UDim2.new(1, 0, 0, 36) })
                    tween(Stroke, 0.15, { Color = Library.Theme.Stroke })
                    updateHeight()
                end
            end
        }
        table.insert(Library.OpenDropdowns, dropdownObject)

        table.insert(Block.Elements, {
            Type = "Dropdown",
            Frame = DropFrame,
            Stroke = Stroke,
            Label = Label,
            SelBadge = SelBadge
        })

        local function refreshDropdown()
            for _, child in ipairs(OptionContainer:GetChildren()) do
                if child:IsA("TextButton") then child:Destroy() end
            end

            for _, opt in ipairs(options) do
                local OptBtn = Instance.new("TextButton")
                OptBtn.Size = UDim2.new(1, 0, 0, 24)
                OptBtn.BackgroundColor3 = (opt == selected) and Library.Theme.Header or Library.Theme.Card
                OptBtn.BorderSizePixel = 0
                OptBtn.Font = Library.Fonts.Label
                OptBtn.Text = opt
                OptBtn.TextColor3 = (opt == selected) and Library.Theme.Accent or Library.Theme.TextDim
                OptBtn.TextSize = 11
                OptBtn.ZIndex = 8
                OptBtn.Parent = OptionContainer

                OptBtn.MouseButton1Click:Connect(function()
                    selected = opt
                    SelBadge.Text = tostring(selected)
                    dropdownObject.Close()
                    refreshDropdown()
                    task.spawn(function() pcall(callback, selected) end)
                end)
            end
        end

        refreshDropdown()

        HeaderBtn.MouseButton1Click:Connect(function()
            isOpen = not isOpen
            if isOpen then
                for _, otherDrop in ipairs(Library.OpenDropdowns) do
                    if otherDrop ~= dropdownObject then otherDrop.Close() end
                end
            end
            local targetH = isOpen and (36 + OptionLayout.AbsoluteContentSize.Y + 8) or 36
            local optH = isOpen and (OptionLayout.AbsoluteContentSize.Y + 8) or 0
            tween(OptionContainer, 0.22, { Size = UDim2.new(1, -16, 0, optH) })
            tween(DropFrame, 0.22, { Size = UDim2.new(1, 0, 0, targetH) })
            tween(Stroke, 0.15, { Color = isOpen and Library.Theme.StrokeActive or Library.Theme.Stroke })
            updateHeight()
        end)
    end

    function Block:AddButton(name, callback)
        callback = callback or function() end

        local BtnFrame = Instance.new("TextButton")
        BtnFrame.Name = name .. "_Button"
        BtnFrame.Size = UDim2.new(1, 0, 0, 32)
        BtnFrame.BackgroundColor3 = Library.Theme.Card
        BtnFrame.BorderSizePixel = 0
        BtnFrame.AutoButtonColor = false
        BtnFrame.Font = Library.Fonts.Label
        BtnFrame.Text = name
        BtnFrame.TextColor3 = Library.Theme.Text
        BtnFrame.TextSize = 12
        BtnFrame.Parent = Content

        local Stroke = Instance.new("UIStroke")
        Stroke.Color = Library.Theme.Stroke
        Stroke.Thickness = 1
        Stroke.Parent = BtnFrame

        table.insert(Block.Elements, {
            Type = "Button",
            Frame = BtnFrame,
            Stroke = Stroke
        })

        BtnFrame.MouseEnter:Connect(function()
            tween(BtnFrame, 0.15, { BackgroundColor3 = Library.Theme.CardHover })
            tween(Stroke, 0.15, { Color = Library.Theme.AccentDim })
        end)

        BtnFrame.MouseLeave:Connect(function()
            tween(BtnFrame, 0.15, { BackgroundColor3 = Library.Theme.Card })
            tween(Stroke, 0.15, { Color = Library.Theme.Stroke })
        end)

        BtnFrame.MouseButton1Click:Connect(function()
            tween(BtnFrame, 0.08, { Size = UDim2.new(1, -4, 0, 30) }, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
            task.wait(0.08)
            tween(BtnFrame, 0.12, { Size = UDim2.new(1, 0, 0, 32) }, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            task.spawn(callback)
        end)
    end

    function Block:AddSlider(name, min, max, default, callback)
        min = min or 0
        max = max or 100
        default = default or min
        callback = callback or function() end

        local value = math.clamp(default, min, max)

        local SliderFrame = Instance.new("Frame")
        SliderFrame.Name = name .. "_Slider"
        SliderFrame.Size = UDim2.new(1, 0, 0, 46)
        SliderFrame.BackgroundColor3 = Library.Theme.Card
        SliderFrame.BorderSizePixel = 0
        SliderFrame.Parent = Content

        local Stroke = Instance.new("UIStroke")
        Stroke.Color = Library.Theme.Stroke
        Stroke.Thickness = 1
        Stroke.Parent = SliderFrame

        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -65, 0, 20)
        Label.Position = UDim2.new(0, 10, 0, 4)
        Label.BackgroundTransparency = 1
        Label.Font = Library.Fonts.Label
        Label.Text = name
        Label.TextColor3 = Library.Theme.TextDim
        Label.TextSize = 11
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = SliderFrame

        local ValBadge = Instance.new("Frame")
        ValBadge.Size = UDim2.new(0, 48, 0, 18)
        ValBadge.Position = UDim2.new(1, -56, 0, 4)
        ValBadge.BackgroundColor3 = Library.Theme.Header
        ValBadge.BorderSizePixel = 0
        ValBadge.Parent = SliderFrame

        local ValStroke = Instance.new("UIStroke")
        ValStroke.Color = Library.Theme.Stroke
        ValStroke.Thickness = 1
        ValStroke.Parent = ValBadge

        local ValLabel = Instance.new("TextLabel")
        ValLabel.Size = UDim2.new(1, 0, 1, 0)
        ValLabel.BackgroundTransparency = 1
        ValLabel.Font = Library.Fonts.Badge
        ValLabel.Text = tostring(value)
        ValLabel.TextColor3 = Library.Theme.Accent
        ValLabel.TextSize = 11
        ValLabel.Parent = ValBadge

        local TrackBg = Instance.new("TextButton")
        TrackBg.Size = UDim2.new(1, -20, 0, 6)
        TrackBg.Position = UDim2.new(0, 10, 0, 30)
        TrackBg.BackgroundColor3 = Library.Theme.Header
        TrackBg.BorderSizePixel = 0
        TrackBg.AutoButtonColor = false
        TrackBg.Text = ""
        TrackBg.Parent = SliderFrame

        local Fill = Instance.new("Frame")
        local initRelX = (value - min) / (max - min)
        Fill.Size = UDim2.new(initRelX, 0, 1, 0)
        Fill.BackgroundColor3 = Library.Theme.Accent
        Fill.BorderSizePixel = 0
        Fill.Parent = TrackBg

        local Handle = Instance.new("Frame")
        Handle.Size = UDim2.new(0, 10, 0, 12)
        Handle.Position = UDim2.new(initRelX, -5, 0.5, -6)
        Handle.BackgroundColor3 = Library.Theme.Accent
        Handle.BorderSizePixel = 0
        Handle.Parent = TrackBg

        table.insert(Block.Elements, {
            Type = "Slider",
            Frame = SliderFrame,
            Stroke = Stroke,
            Label = Label,
            ValBadge = ValBadge,
            ValLabel = ValLabel,
            TrackBg = TrackBg,
            Fill = Fill,
            Handle = Handle
        })

        local isDragging = false

        local function updateSliderPosition(inputX)
            local barWidth = TrackBg.AbsoluteSize.X
            if barWidth <= 0 then return end
            local relX = math.clamp((inputX - TrackBg.AbsolutePosition.X) / barWidth, 0, 1)
            local newValue = math.floor(min + (max - min) * relX + 0.5)

            Fill.Size = UDim2.new(relX, 0, 1, 0)
            Handle.Position = UDim2.new(relX, -5, 0.5, -6)

            if newValue ~= value then
                value = newValue
                ValLabel.Text = tostring(value)
                task.spawn(function() pcall(callback, value) end)
            end
        end

        trackConnection(TrackBg.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                isDragging = true
                tween(Stroke, 0.15, { Color = Library.Theme.StrokeActive })
                updateSliderPosition(input.Position.X)
            end
        end))

        trackConnection(UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                if isDragging then
                    isDragging = false
                    tween(Stroke, 0.15, { Color = Library.Theme.Stroke })
                end
            end
        end))

        trackConnection(UserInputService.InputChanged:Connect(function(input)
            if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                updateSliderPosition(input.Position.X)
            end
        end))
    end

    function Block:AddKeybind(name, defaultKey, callback)
        callback = callback or function() end
        local boundKey = defaultKey or Enum.KeyCode.Unknown
        local listening = false

        local BindFrame = Instance.new("Frame")
        BindFrame.Size = UDim2.new(1, 0, 0, 32)
        BindFrame.BackgroundColor3 = Library.Theme.Card
        BindFrame.BorderSizePixel = 0
        BindFrame.Parent = Content

        local Stroke = Instance.new("UIStroke")
        Stroke.Color = Library.Theme.Stroke
        Stroke.Thickness = 1
        Stroke.Parent = BindFrame

        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -75, 1, 0)
        Label.Position = UDim2.new(0, 10, 0, 0)
        Label.BackgroundTransparency = 1
        Label.Font = Library.Fonts.Label
        Label.Text = name
        Label.TextColor3 = Library.Theme.TextDim
        Label.TextSize = 12
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = BindFrame

        local KeyBtn = Instance.new("TextButton")
        KeyBtn.Size = UDim2.new(0, 65, 0, 20)
        KeyBtn.Position = UDim2.new(1, -71, 0.5, -10)
        KeyBtn.BackgroundColor3 = Library.Theme.Header
        KeyBtn.BorderSizePixel = 0
        KeyBtn.Font = Library.Fonts.Badge
        KeyBtn.Text = string.upper(boundKey.Name)
        KeyBtn.TextColor3 = Library.Theme.Accent
        KeyBtn.TextSize = 10
        KeyBtn.Parent = BindFrame

        Library.KeybindList[name] = string.upper(boundKey.Name)
        if Library.RefreshKeybindHUD then Library:RefreshKeybindHUD() end

        table.insert(Block.Elements, {
            Type = "Keybind",
            Frame = BindFrame,
            Stroke = Stroke,
            Label = Label,
            KeyBtn = KeyBtn
        })

        KeyBtn.MouseButton1Click:Connect(function()
            listening = true
            Library.ListeningKeybind = true
            KeyBtn.Text = "..."
            KeyBtn.TextColor3 = Library.Theme.TextDim
            tween(Stroke, 0.15, { Color = Library.Theme.Accent })
        end)

        trackConnection(UserInputService.InputBegan:Connect(function(input, gpe)
            if listening then
                if input.UserInputType == Enum.UserInputType.Keyboard then
                    if input.KeyCode == Enum.KeyCode.Escape or input.KeyCode == Enum.KeyCode.Backspace then
                        boundKey = Enum.KeyCode.Unknown
                    else
                        boundKey = input.KeyCode
                    end
                    listening = false
                    Library.ListeningKeybind = false
                    KeyBtn.Text = string.upper(boundKey.Name)
                    KeyBtn.TextColor3 = Library.Theme.Accent
                    tween(Stroke, 0.15, { Color = Library.Theme.Stroke })

                    Library.KeybindList[name] = string.upper(boundKey.Name)
                    if Library.RefreshKeybindHUD then Library:RefreshKeybindHUD() end
                    task.spawn(function() pcall(callback, boundKey) end)
                end
            end
        end))
    end

    table.insert(Library.Blocks, Block)
    return Block
end

function Library:Unload()
    for _, conn in ipairs(Library.Connections) do
        if conn and conn.Disconnect then conn:Disconnect() end
    end
    if MenuBlur then MenuBlur:Destroy() end
    if RadioSound then RadioSound:Destroy() end
    if ScreenGui then ScreenGui:Destroy() end
end

return Library
