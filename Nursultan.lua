-- [[ NURSULTAN CLIENT UI LIBRARY — MASTER CORE ENGINE ]] --
-- Sharp Square Rectilinear Aesthetics (0 CornerRadius), Harmonized Spring Tweens,
-- 10 Ready-To-Use Skybox Presets + Custom Texture Inputs,
-- Advanced Visuals Manager: Blur Size Slider, Particle Count/Speed/Size Sliders, Custom Particle Image/Texture ID,
-- Roblox UIScale Integration for Perfect Radio HUD Scaling (Zero Clipping / Zero Overflow),
-- Full Mode Name Display in Keybind Badges (e.g., "F [TOGGLE]", "R [HOLD]", "ALWAYS"),
-- Clean Keybind Mode Popup (Header-less 3 buttons), Fixed Radio HUD Transparency Sync across all sub-elements,
-- Radio HUD Scale Reduction (50% - 100%), Unclipped Dropdowns & Popups, Tab Navigation Settings Modal.

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
        ["Monochrome Slate"] = {
            Background   = Color3.fromRGB(14, 16, 20),
            Header       = Color3.fromRGB(28, 34, 42),
            Block        = Color3.fromRGB(20, 24, 30),
            Card         = Color3.fromRGB(34, 40, 50),
            CardHover    = Color3.fromRGB(48, 58, 72),
            Stroke       = Color3.fromRGB(60, 72, 88),
            StrokeHover  = Color3.fromRGB(140, 160, 190),
            StrokeActive = Color3.fromRGB(255, 255, 255),
            Accent       = Color3.fromRGB(245, 248, 252),
            AccentDim    = Color3.fromRGB(170, 182, 200),
            Text         = Color3.fromRGB(255, 255, 255),
            TextDim      = Color3.fromRGB(150, 160, 180)
        },
        ["Lavender Mist"] = {
            Background   = Color3.fromRGB(20, 16, 32),
            Header       = Color3.fromRGB(44, 36, 68),
            Block        = Color3.fromRGB(30, 24, 46),
            Card         = Color3.fromRGB(56, 46, 84),
            CardHover    = Color3.fromRGB(72, 58, 108),
            Stroke       = Color3.fromRGB(95, 78, 140),
            StrokeHover  = Color3.fromRGB(145, 120, 210),
            StrokeActive = Color3.fromRGB(195, 180, 255),
            Accent       = Color3.fromRGB(195, 180, 255),
            AccentDim    = Color3.fromRGB(145, 130, 195),
            Text         = Color3.fromRGB(250, 246, 255),
            TextDim      = Color3.fromRGB(175, 160, 205)
        },
        ["Nordic Sage"] = {
            Background   = Color3.fromRGB(14, 24, 18),
            Header       = Color3.fromRGB(32, 54, 42),
            Block        = Color3.fromRGB(22, 38, 29),
            Card         = Color3.fromRGB(40, 68, 52),
            CardHover    = Color3.fromRGB(52, 88, 68),
            Stroke       = Color3.fromRGB(68, 115, 88),
            StrokeHover  = Color3.fromRGB(105, 175, 135),
            StrokeActive = Color3.fromRGB(145, 235, 180),
            Accent       = Color3.fromRGB(145, 235, 180),
            AccentDim    = Color3.fromRGB(105, 175, 130),
            Text         = Color3.fromRGB(242, 253, 246),
            TextDim      = Color3.fromRGB(150, 195, 165)
        },
        ["Rose Gold"] = {
            Background   = Color3.fromRGB(26, 16, 19),
            Header       = Color3.fromRGB(58, 34, 42),
            Block        = Color3.fromRGB(40, 24, 29),
            Card         = Color3.fromRGB(74, 44, 54),
            CardHover    = Color3.fromRGB(96, 56, 70),
            Stroke       = Color3.fromRGB(130, 75, 92),
            StrokeHover  = Color3.fromRGB(195, 115, 140),
            StrokeActive = Color3.fromRGB(255, 175, 195),
            Accent       = Color3.fromRGB(255, 175, 195),
            AccentDim    = Color3.fromRGB(195, 125, 142),
            Text         = Color3.fromRGB(255, 245, 248),
            TextDim      = Color3.fromRGB(195, 155, 168)
        },
        ["Ocean Breeze"] = {
            Background   = Color3.fromRGB(14, 22, 34),
            Header       = Color3.fromRGB(28, 48, 72),
            Block        = Color3.fromRGB(20, 34, 52),
            Card         = Color3.fromRGB(36, 62, 92),
            CardHover    = Color3.fromRGB(48, 80, 118),
            Stroke       = Color3.fromRGB(65, 110, 160),
            StrokeHover  = Color3.fromRGB(100, 165, 230),
            StrokeActive = Color3.fromRGB(130, 205, 255),
            Accent       = Color3.fromRGB(130, 205, 255),
            AccentDim    = Color3.fromRGB(95, 155, 195),
            Text         = Color3.fromRGB(242, 250, 255),
            TextDim      = Color3.fromRGB(150, 185, 215)
        },
        ["Sakura Blossom"] = {
            Background   = Color3.fromRGB(26, 15, 23),
            Header       = Color3.fromRGB(58, 32, 52),
            Block        = Color3.fromRGB(40, 22, 36),
            Card         = Color3.fromRGB(74, 42, 68),
            CardHover    = Color3.fromRGB(96, 54, 88),
            Stroke       = Color3.fromRGB(130, 72, 118),
            StrokeHover  = Color3.fromRGB(195, 110, 175),
            StrokeActive = Color3.fromRGB(255, 170, 225),
            Accent       = Color3.fromRGB(255, 170, 225),
            AccentDim    = Color3.fromRGB(195, 120, 170),
            Text         = Color3.fromRGB(255, 245, 252),
            TextDim      = Color3.fromRGB(195, 150, 182)
        },
        ["Muted Mint"] = {
            Background   = Color3.fromRGB(14, 24, 24),
            Header       = Color3.fromRGB(28, 52, 50),
            Block        = Color3.fromRGB(20, 36, 35),
            Card         = Color3.fromRGB(36, 68, 65),
            CardHover    = Color3.fromRGB(48, 88, 84),
            Stroke       = Color3.fromRGB(65, 120, 115),
            StrokeHover  = Color3.fromRGB(100, 185, 175),
            StrokeActive = Color3.fromRGB(130, 245, 225),
            Accent       = Color3.fromRGB(130, 245, 225),
            AccentDim    = Color3.fromRGB(95, 185, 170),
            Text         = Color3.fromRGB(242, 255, 252),
            TextDim      = Color3.fromRGB(150, 195, 188)
        },
        ["Sunset Amber"] = {
            Background   = Color3.fromRGB(26, 17, 12),
            Header       = Color3.fromRGB(58, 36, 24),
            Block        = Color3.fromRGB(40, 25, 16),
            Card         = Color3.fromRGB(76, 48, 30),
            CardHover    = Color3.fromRGB(98, 62, 38),
            Stroke       = Color3.fromRGB(135, 84, 50),
            StrokeHover  = Color3.fromRGB(200, 128, 75),
            StrokeActive = Color3.fromRGB(255, 180, 110),
            Accent       = Color3.fromRGB(255, 180, 110),
            AccentDim    = Color3.fromRGB(195, 130, 75),
            Text         = Color3.fromRGB(255, 248, 242),
            TextDim      = Color3.fromRGB(195, 158, 135)
        },
        ["Platinum Steel"] = {
            Background   = Color3.fromRGB(20, 22, 26),
            Header       = Color3.fromRGB(46, 50, 58),
            Block        = Color3.fromRGB(32, 35, 41),
            Card         = Color3.fromRGB(60, 65, 76),
            CardHover    = Color3.fromRGB(78, 85, 98),
            Stroke       = Color3.fromRGB(105, 115, 132),
            StrokeHover  = Color3.fromRGB(160, 175, 200),
            StrokeActive = Color3.fromRGB(220, 235, 255),
            Accent       = Color3.fromRGB(220, 235, 255),
            AccentDim    = Color3.fromRGB(160, 172, 190),
            Text         = Color3.fromRGB(250, 252, 255),
            TextDim      = Color3.fromRGB(165, 175, 190)
        },
        ["Aura Indigo"] = {
            Background   = Color3.fromRGB(18, 14, 32),
            Header       = Color3.fromRGB(40, 30, 72),
            Block        = Color3.fromRGB(28, 21, 50),
            Card         = Color3.fromRGB(52, 40, 92),
            CardHover    = Color3.fromRGB(68, 52, 120),
            Stroke       = Color3.fromRGB(92, 70, 160),
            StrokeHover  = Color3.fromRGB(140, 105, 230),
            StrokeActive = Color3.fromRGB(185, 150, 255),
            Accent       = Color3.fromRGB(185, 150, 255),
            AccentDim    = Color3.fromRGB(135, 105, 195),
            Text         = Color3.fromRGB(248, 245, 255),
            TextDim      = Color3.fromRGB(170, 155, 205)
        },
        ["Cyber Neon"] = {
            Background   = Color3.fromRGB(10, 14, 22),
            Header       = Color3.fromRGB(18, 28, 46),
            Block        = Color3.fromRGB(14, 20, 34),
            Card         = Color3.fromRGB(24, 38, 62),
            CardHover    = Color3.fromRGB(34, 52, 85),
            Stroke       = Color3.fromRGB(40, 75, 120),
            StrokeHover  = Color3.fromRGB(0, 220, 255),
            StrokeActive = Color3.fromRGB(0, 255, 230),
            Accent       = Color3.fromRGB(0, 235, 255),
            AccentDim    = Color3.fromRGB(0, 160, 195),
            Text         = Color3.fromRGB(240, 255, 255),
            TextDim      = Color3.fromRGB(130, 185, 215)
        },
        ["Crimson Blood"] = {
            Background   = Color3.fromRGB(22, 10, 12),
            Header       = Color3.fromRGB(48, 16, 20),
            Block        = Color3.fromRGB(34, 12, 15),
            Card         = Color3.fromRGB(58, 22, 28),
            CardHover    = Color3.fromRGB(80, 28, 36),
            Stroke       = Color3.fromRGB(110, 38, 48),
            StrokeHover  = Color3.fromRGB(220, 60, 75),
            StrokeActive = Color3.fromRGB(255, 80, 95),
            Accent       = Color3.fromRGB(255, 75, 90),
            AccentDim    = Color3.fromRGB(185, 50, 65),
            Text         = Color3.fromRGB(255, 242, 244),
            TextDim      = Color3.fromRGB(195, 135, 142)
        },
        ["Emerald Dragon"] = {
            Background   = Color3.fromRGB(10, 22, 14),
            Header       = Color3.fromRGB(18, 48, 28),
            Block        = Color3.fromRGB(12, 34, 20),
            Card         = Color3.fromRGB(22, 58, 34),
            CardHover    = Color3.fromRGB(30, 80, 46),
            Stroke       = Color3.fromRGB(42, 115, 66),
            StrokeHover  = Color3.fromRGB(60, 215, 110),
            StrokeActive = Color3.fromRGB(85, 255, 145),
            Accent       = Color3.fromRGB(70, 240, 130),
            AccentDim    = Color3.fromRGB(45, 175, 92),
            Text         = Color3.fromRGB(242, 255, 245),
            TextDim      = Color3.fromRGB(135, 195, 152)
        },
        ["Amethyst Violet"] = {
            Background   = Color3.fromRGB(18, 10, 26),
            Header       = Color3.fromRGB(42, 20, 62),
            Block        = Color3.fromRGB(28, 14, 42),
            Card         = Color3.fromRGB(52, 26, 78),
            CardHover    = Color3.fromRGB(70, 34, 105),
            Stroke       = Color3.fromRGB(98, 48, 145),
            StrokeHover  = Color3.fromRGB(170, 90, 240),
            StrokeActive = Color3.fromRGB(210, 130, 255),
            Accent       = Color3.fromRGB(195, 115, 255),
            AccentDim    = Color3.fromRGB(140, 78, 195),
            Text         = Color3.fromRGB(252, 242, 255),
            TextDim      = Color3.fromRGB(180, 140, 210)
        },
        ["Solar Gold"] = {
            Background   = Color3.fromRGB(24, 18, 10),
            Header       = Color3.fromRGB(52, 38, 16),
            Block        = Color3.fromRGB(36, 26, 12),
            Card         = Color3.fromRGB(66, 48, 20),
            CardHover    = Color3.fromRGB(90, 65, 26),
            Stroke       = Color3.fromRGB(125, 90, 32),
            StrokeHover  = Color3.fromRGB(220, 165, 45),
            StrokeActive = Color3.fromRGB(255, 205, 65),
            Accent       = Color3.fromRGB(255, 195, 45),
            AccentDim    = Color3.fromRGB(190, 140, 30),
            Text         = Color3.fromRGB(255, 250, 240),
            TextDim      = Color3.fromRGB(195, 170, 130)
        },
        ["Midnight Abyss"] = {
            Background   = Color3.fromRGB(8, 9, 11),
            Header       = Color3.fromRGB(18, 20, 24),
            Block        = Color3.fromRGB(12, 14, 17),
            Card         = Color3.fromRGB(24, 27, 33),
            CardHover    = Color3.fromRGB(36, 40, 50),
            Stroke       = Color3.fromRGB(55, 62, 75),
            StrokeHover  = Color3.fromRGB(200, 215, 240),
            StrokeActive = Color3.fromRGB(255, 255, 255),
            Accent       = Color3.fromRGB(255, 255, 255),
            AccentDim    = Color3.fromRGB(170, 182, 200),
            Text         = Color3.fromRGB(255, 255, 255),
            TextDim      = Color3.fromRGB(140, 150, 168)
        },
        ["Cyberpunk 2077"] = {
            Background   = Color3.fromRGB(16, 16, 20),
            Header       = Color3.fromRGB(38, 36, 14),
            Block        = Color3.fromRGB(26, 25, 10),
            Card         = Color3.fromRGB(48, 45, 16),
            CardHover    = Color3.fromRGB(68, 64, 20),
            Stroke       = Color3.fromRGB(120, 112, 25),
            StrokeHover  = Color3.fromRGB(230, 215, 30),
            StrokeActive = Color3.fromRGB(255, 240, 35),
            Accent       = Color3.fromRGB(255, 235, 0),
            AccentDim    = Color3.fromRGB(185, 170, 0),
            Text         = Color3.fromRGB(255, 254, 235),
            TextDim      = Color3.fromRGB(185, 180, 140)
        },
        ["Toxic Lime"] = {
            Background   = Color3.fromRGB(12, 20, 12),
            Header       = Color3.fromRGB(26, 46, 20),
            Block        = Color3.fromRGB(18, 32, 14),
            Card         = Color3.fromRGB(34, 62, 24),
            CardHover    = Color3.fromRGB(46, 85, 32),
            Stroke       = Color3.fromRGB(75, 140, 48),
            StrokeHover  = Color3.fromRGB(140, 235, 60),
            StrokeActive = Color3.fromRGB(170, 255, 75),
            Accent       = Color3.fromRGB(160, 255, 60),
            AccentDim    = Color3.fromRGB(110, 185, 40),
            Text         = Color3.fromRGB(245, 255, 240),
            TextDim      = Color3.fromRGB(150, 195, 140)
        },
        ["Dracula Dark"] = {
            Background   = Color3.fromRGB(18, 16, 24),
            Header       = Color3.fromRGB(40, 32, 56),
            Block        = Color3.fromRGB(28, 22, 40),
            Card         = Color3.fromRGB(50, 38, 72),
            CardHover    = Color3.fromRGB(68, 50, 98),
            Stroke       = Color3.fromRGB(95, 68, 138),
            StrokeHover  = Color3.fromRGB(220, 100, 180),
            StrokeActive = Color3.fromRGB(255, 120, 210),
            Accent       = Color3.fromRGB(255, 120, 190),
            AccentDim    = Color3.fromRGB(185, 80, 135),
            Text         = Color3.fromRGB(248, 245, 255),
            TextDim      = Color3.fromRGB(175, 155, 200)
        },
        ["Tokyo Night"] = {
            Background   = Color3.fromRGB(15, 17, 26),
            Header       = Color3.fromRGB(26, 32, 52),
            Block        = Color3.fromRGB(19, 23, 38),
            Card         = Color3.fromRGB(33, 41, 68),
            CardHover    = Color3.fromRGB(44, 55, 90),
            Stroke       = Color3.fromRGB(65, 82, 135),
            StrokeHover  = Color3.fromRGB(120, 155, 255),
            StrokeActive = Color3.fromRGB(160, 190, 255),
            Accent       = Color3.fromRGB(122, 162, 247),
            AccentDim    = Color3.fromRGB(85, 120, 195),
            Text         = Color3.fromRGB(240, 245, 255),
            TextDim      = Color3.fromRGB(145, 165, 210)
        }
    },
    CategoryIcons = {
        ["COMBAT"]   = "rbxassetid://111457651714934",
        ["PLAYER"]   = "rbxassetid://93915156103067",
        ["VISUALS"]  = "rbxassetid://102976018150012",
        ["ESP"]      = "rbxassetid://102976018150012",
        ["WORLD"]    = "rbxassetid://18870359747",
        ["WOROLD"]   = "rbxassetid://18870359747",
        ["MOVEMENT"] = "rbxassetid://13587579249",
        ["SKINS"]    = "rbxassetid://11955919597",
        ["SPOOFER"]  = "rbxassetid://122540234795087"
    },
    CurrentThemeName = "Monochrome Slate",
    ToggleKey = Enum.KeyCode.RightShift,
    Blocks = {},
    ModalElements = {},
    KeybindList = {},
    Connections = {},
    OpenDropdowns = {},
    Enabled = true,
    ListeningKeybind = false,
    BlurEnabled = true,
    BlurSize = 18,
    MenuBgImage = "",
    MenuBgTransparency = 30,
    SnowEnabled = true,
    ParticleCount = 50,
    ParticleSpeed = 1.0,
    ParticleSize = 4,
    ParticleTexture = "",
    RadioHUDVisible = true,
    RadioHUDTransparency = 0,
    RadioHUDScale = 100,
    WatermarkText = "STAR.UI",
    ConfigFolder = "NursultanClient",
    MusicFolder = "Nursultan/Music",
    Fonts = {
        Header = Enum.Font.GothamBold,
        Label = Enum.Font.GothamMedium,
        Badge = Enum.Font.GothamBold
    }
}

Library.Theme = Library.Themes["Monochrome Slate"] or Library.Themes[Library.CurrentThemeName]
Library.BlockProto = {}

local DUR_FAST   = 0.12
local DUR_NORMAL = 0.18
local DUR_MODAL  = 0.22

local EASE_SMOOTH = Enum.EasingStyle.Quart
local EASE_SPRING = Enum.EasingStyle.Back
local DIR_OUT     = Enum.EasingDirection.Out
local DIR_IN      = Enum.EasingDirection.In

local ActiveTweens = {}
local UI = {}

local function smoothTween(object, duration, properties, easingStyle, easingDirection)
    easingStyle = easingStyle or EASE_SMOOTH
    easingDirection = easingDirection or DIR_OUT

    if ActiveTweens[object] then
        pcall(function() ActiveTweens[object]:Cancel() end)
        ActiveTweens[object] = nil
    end

    local anim = TweenService:Create(object, TweenInfo.new(duration, easingStyle, easingDirection), properties)
    ActiveTweens[object] = anim
    anim:Play()

    anim.Completed:Connect(function()
        if ActiveTweens[object] == anim then
            ActiveTweens[object] = nil
        end
    end)
    return anim
end

local function resolveSoundCloudToMp3(scUrl)
    local clientId = "iZ864qAfWFxgqnosawMuUZqq800acFi6"
    local encodedUrl = scUrl:gsub("([^%w%-%_%.%~])", function(c)
        return string.format("%%%02X", string.byte(c))
    end)

    -- Stage 1: Official SoundCloud API V2 Resolve Endpoint
    local apiResolveUrl = "https://api-v2.soundcloud.com/resolve?url=" .. encodedUrl .. "&client_id=" .. clientId
    local ok, jsonText = pcall(function() return game:HttpGet(apiResolveUrl, true) end)

    if ok and jsonText and jsonText:find("media") then
        local okDecode, data = pcall(function() return HttpService:JSONDecode(jsonText) end)
        if okDecode and data and data.media and data.media.transcodings then
            local streamTargetUrl = nil
            for _, tc in ipairs(data.media.transcodings) do
                if tc.format and tc.format.protocol == "progressive" then
                    streamTargetUrl = tc.url
                    break
                end
            end
            if not streamTargetUrl and #data.media.transcodings > 0 then
                streamTargetUrl = data.media.transcodings[1].url
            end

            if streamTargetUrl then
                local fetchStreamUrl = streamTargetUrl .. "?client_id=" .. clientId
                local ok2, jsonStream = pcall(function() return game:HttpGet(fetchStreamUrl, true) end)
                if ok2 and jsonStream then
                    local okDec2, streamData = pcall(function() return HttpService:JSONDecode(jsonStream) end)
                    if okDec2 and streamData and streamData.url then
                        local okAudio, audioBytes = pcall(function() return game:HttpGet(streamData.url, true) end)
                        if okAudio and audioBytes and #audioBytes > 1000 then
                            return audioBytes
                        end
                    end
                end
            end
        end
    end

    -- Stage 2: Public SoundCloud API Proxy Fallback
    local proxyUrl = "https://api.bongo.best/soundcloud?url=" .. encodedUrl
    local okProxy, proxyJson = pcall(function() return game:HttpGet(proxyUrl, true) end)
    if okProxy and proxyJson then
        local okDecProxy, proxyData = pcall(function() return HttpService:JSONDecode(proxyJson) end)
        if okDecProxy and proxyData and (proxyData.url or proxyData.audio_url) then
            local directAudioUrl = proxyData.url or proxyData.audio_url
            local okAudio, audioBytes = pcall(function() return game:HttpGet(directAudioUrl, true) end)
            if okAudio and audioBytes and #audioBytes > 1000 then
                return audioBytes
            end
        end
    end

    return nil
end

local function formatAssetId(raw)
    if not raw or raw == "" then return "" end
    local str = tostring(raw):match("^%s*(.-)%s*$") -- Trim whitespace

    -- 1. Already formatted rbxassetid
    if str:sub(1, 13) == "rbxassetid://" then
        return str
    end

    -- 2. Pure numeric Roblox ID
    if tonumber(str) then
        return "rbxassetid://" .. str
    end

    -- 3. HTTP / HTTPS external URL (SoundCloud / Direct Audio Stream / Web Link)
    if str:sub(1, 7) == "http://" or str:sub(1, 8) == "https://" then
        if writefile and getcustomasset then
            local tempFileName = "star_radio_stream.mp3"

            if str:find("soundcloud.com") then
                local audioBytes = resolveSoundCloudToMp3(str)
                if audioBytes then
                    pcall(function() writefile(tempFileName, audioBytes) end)
                    if isfile and isfile(tempFileName) then
                        local okAsset, customAsset = pcall(function() return getcustomasset(tempFileName) end)
                        if okAsset and customAsset and customAsset ~= "" then
                            return customAsset
                        end
                    end
                end
            else
                local success, content = pcall(function()
                    return game:HttpGet(str, true)
                end)

                if success and content and #content > 1000 then
                    pcall(function() writefile(tempFileName, content) end)
                    if isfile and isfile(tempFileName) then
                        local okAsset, customAsset = pcall(function() return getcustomasset(tempFileName) end)
                        if okAsset and customAsset and customAsset ~= "" then
                            return customAsset
                        end
                    end
                end
            end
        end

        -- Fallback: Extract numeric ID if URL contains digits
        local numericMatch = str:match("(%d%d%d%d%d+)")
        if numericMatch then
            return "rbxassetid://" .. numericMatch
        end
        return str
    end

    -- 4. Clean digits fallback
    local cleanDigits = str:gsub("%D", "")
    if cleanDigits ~= "" then
        return "rbxassetid://" .. cleanDigits
    end

    return str
end

local function formatTime(seconds)
    seconds = math.max(0, math.floor(seconds or 0))
    local mins = math.floor(seconds / 60)
    local secs = seconds % 60
    return string.format("%02d:%02d", mins, secs)
end

local function addCorner(parent, radius)
    if not parent then return end
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 6)
    corner.Parent = parent
    return corner
end

pcall(function()
    if makefolder and isfolder then
        if not isfolder(Library.ConfigFolder) then
            makefolder(Library.ConfigFolder)
        end
        if not isfolder(Library.MusicFolder) then
            makefolder(Library.MusicFolder)
        end
    end
end)

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local ParentContainer = nil
pcall(function()
    if gethui then
        local h = gethui()
        if h and (h:IsA("ScreenGui") or h:IsA("Folder") or h:IsA("BasePlayerGui")) then
            ParentContainer = h
        end
    end
end)
if not ParentContainer then
    pcall(function()
        if CoreGui then ParentContainer = CoreGui end
    end)
end
if not ParentContainer then
    pcall(function()
        ParentContainer = Players.LocalPlayer:WaitForChild("PlayerGui")
    end)
end
if not ParentContainer then
    ParentContainer = CoreGui
end

pcall(function()
    if gethui and gethui():FindFirstChild("NursultanGUI") then
        gethui().NursultanGUI:Destroy()
    end
end)
pcall(function()
    if Players.LocalPlayer and Players.LocalPlayer:FindFirstChild("PlayerGui") and Players.LocalPlayer.PlayerGui:FindFirstChild("NursultanGUI") then
        Players.LocalPlayer.PlayerGui.NursultanGUI:Destroy()
    end
end)
pcall(function()
    if CoreGui and CoreGui:FindFirstChild("NursultanGUI") then
        CoreGui.NursultanGUI:Destroy()
    end
end)
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
MenuBlur.Size = Library.BlurSize
MenuBlur.Enabled = Library.BlurEnabled and Library.Enabled
MenuBlur.Parent = Lighting

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "NursultanGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 999999999
ScreenGui.Parent = ParentContainer

local ParticleGuiContainer = Instance.new("Frame")
ParticleGuiContainer.Name = "ParticleGuiContainer"
ParticleGuiContainer.Size = UDim2.new(1, 0, 1, 0)
ParticleGuiContainer.BackgroundTransparency = 1
ParticleGuiContainer.ClipsDescendants = false
ParticleGuiContainer.ZIndex = 1
ParticleGuiContainer.Parent = ScreenGui

local MenuBgImage = Instance.new("ImageLabel")
MenuBgImage.Name = "MenuBgImage"
MenuBgImage.Size = UDim2.new(1, 0, 1, 0)
MenuBgImage.BackgroundTransparency = 1
MenuBgImage.ScaleType = Enum.ScaleType.Crop
MenuBgImage.ImageTransparency = 0.3
MenuBgImage.Visible = false
MenuBgImage.ZIndex = 0
MenuBgImage.Parent = ParticleGuiContainer

local function updateMenuBgImage()
    local formatted = formatAssetId(Library.MenuBgImage or "")
    if formatted ~= "" then
        MenuBgImage.Image = formatted
        MenuBgImage.ImageTransparency = (Library.MenuBgTransparency or 30) / 100
        MenuBgImage.Visible = Library.Enabled
    else
        MenuBgImage.Visible = false
    end
end

local Container = Instance.new("Frame")
Container.Name = "BlockContainer"
Container.Size = UDim2.new(1, 0, 1, 0)
Container.BackgroundTransparency = 1
Container.ClipsDescendants = false
Container.ZIndex = 10
Container.Parent = ScreenGui

local ContainerUIScale = Instance.new("UIScale")
ContainerUIScale.Name = "ContainerUIScale"
ContainerUIScale.Scale = 1
ContainerUIScale.Parent = Container

local SnowFolder = Instance.new("Frame")
SnowFolder.Name = "SnowParticles"
SnowFolder.Size = UDim2.new(1, 0, 1, 0)
SnowFolder.BackgroundTransparency = 1
SnowFolder.ClipsDescendants = false
SnowFolder.ZIndex = 1
SnowFolder.Parent = ParticleGuiContainer

local Flakes = {}

local function rebuildParticles()
    for _, f in ipairs(Flakes) do
        if f.Instance then f.Instance:Destroy() end
    end
    Flakes = {}

    local count = Library.ParticleCount or 50
    local pSize = Library.ParticleSize or 4
    local textureId = formatAssetId(Library.ParticleTexture or "")

    for i = 1, count do
        local pInst
        if textureId ~= "" then
            pInst = Instance.new("ImageLabel")
            pInst.Image = textureId
            pInst.BackgroundTransparency = 1
        else
            pInst = Instance.new("Frame")
            pInst.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            pInst.BackgroundTransparency = math.random(3, 7) / 10
        end

        pInst.Name = "Flake_" .. i
        pInst.Size = UDim2.new(0, pSize, 0, pSize)
        pInst.Position = UDim2.new(math.random(), 0, math.random(), 0)
        pInst.BorderSizePixel = 0
        pInst.ZIndex = 1
        pInst.Parent = SnowFolder

        table.insert(Flakes, {
            Instance = pInst,
            BaseSpeed = math.random(6, 20) / 1000,
            Drift = (math.random() - 0.5) * 0.002,
            X = math.random(),
            Y = math.random()
        })
    end
end

rebuildParticles()

local function trackConnection(conn)
    table.insert(Library.Connections, conn)
    return conn
end

local snowConn = RunService.RenderStepped:Connect(function(dt)
    if Library.Enabled and ScreenGui.Enabled and Library.SnowEnabled then
        local spdMult = Library.ParticleSpeed or 1.0
        for _, f in ipairs(Flakes) do
            f.Y = f.Y + (f.BaseSpeed * dt * 60 * spdMult)
            f.X = f.X + (f.Drift * dt * 60)
            if f.Y > 1.05 then
                f.Y = -0.05
                f.X = math.random()
            end
            f.Instance.Position = UDim2.new(f.X, 0, f.Y, 0)
        end
    end
end)
trackConnection(snowConn)


local TopWatermark = Instance.new("Frame")
TopWatermark.Name = "StarTopWatermark"
TopWatermark.Size = UDim2.new(0, 420, 0, 32)
TopWatermark.Position = UDim2.new(0.5, -210, 0, 10)
TopWatermark.BackgroundColor3 = Library.Theme.Block
TopWatermark.BackgroundTransparency = 0.06
TopWatermark.BorderSizePixel = 0
TopWatermark.ClipsDescendants = true
TopWatermark.Parent = ScreenGui

addCorner(TopWatermark, 8)

local TopWMarkStroke = Instance.new("UIStroke")
TopWMarkStroke.Color = Library.Theme.StrokeActive
TopWMarkStroke.Transparency = 0.2
TopWMarkStroke.Thickness = 1.2
TopWMarkStroke.Parent = TopWatermark

local WMarkContent = Instance.new("Frame")
WMarkContent.Name = "WMarkContent"
WMarkContent.Size = UDim2.new(1, 0, 1, 0)
WMarkContent.BackgroundTransparency = 1
WMarkContent.Parent = TopWatermark

local TopWMarkLayout = Instance.new("UIListLayout")
TopWMarkLayout.FillDirection = Enum.FillDirection.Horizontal
TopWMarkLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TopWMarkLayout.VerticalAlignment = Enum.VerticalAlignment.Center
TopWMarkLayout.Padding = UDim.new(0, 6)
TopWMarkLayout.Parent = WMarkContent

local TopWMarkIcon = Instance.new("ImageLabel")
TopWMarkIcon.Name = "TopWMarkIcon"
TopWMarkIcon.Size = UDim2.new(0, 18, 0, 18)
TopWMarkIcon.BackgroundTransparency = 1
TopWMarkIcon.Image = "rbxassetid://93992148478224"
TopWMarkIcon.ImageColor3 = Library.Theme.Accent
TopWMarkIcon.Parent = WMarkContent

local TopWMarkTitle = Instance.new("TextLabel")
TopWMarkTitle.Name = "TopWMarkTitle"
TopWMarkTitle.AutomaticSize = Enum.AutomaticSize.X
TopWMarkTitle.Size = UDim2.new(0, 0, 1, 0)
TopWMarkTitle.BackgroundTransparency = 1
TopWMarkTitle.Font = Library.Fonts.Header
TopWMarkTitle.Text = Library.WatermarkText or "STAR.UI"
TopWMarkTitle.TextColor3 = Library.Theme.Accent
TopWMarkTitle.TextSize = 11.5
TopWMarkTitle.Parent = WMarkContent
UI.TopWMarkTitle = TopWMarkTitle

local function addWMarkSep()
    local Sep = Instance.new("TextLabel")
    Sep.Size = UDim2.new(0, 6, 1, 0)
    Sep.BackgroundTransparency = 1
    Sep.Font = Library.Fonts.Label
    Sep.Text = "|"
    Sep.TextColor3 = Library.Theme.TextDim
    Sep.TextSize = 10
    Sep.Parent = WMarkContent
    return Sep
end

addWMarkSep()

local LocalPlayer = Players.LocalPlayer
local PlayerHeadshot = Instance.new("ImageLabel")
PlayerHeadshot.Name = "PlayerHeadshot"
PlayerHeadshot.Size = UDim2.new(0, 18, 0, 18)
PlayerHeadshot.BackgroundTransparency = 1
PlayerHeadshot.Image = "rbxthumb://type=AvatarHeadShot&id=" .. (LocalPlayer and LocalPlayer.UserId or 1) .. "&w=48&h=48"
PlayerHeadshot.Parent = WMarkContent

local PlayerNameLabel = Instance.new("TextLabel")
PlayerNameLabel.Name = "PlayerNameLabel"
PlayerNameLabel.Size = UDim2.new(0, 70, 1, 0)
PlayerNameLabel.BackgroundTransparency = 1
PlayerNameLabel.Font = Library.Fonts.Label
PlayerNameLabel.Text = LocalPlayer and LocalPlayer.DisplayName or "User"
PlayerNameLabel.TextColor3 = Library.Theme.Text
PlayerNameLabel.TextSize = 10.5
PlayerNameLabel.TextTruncate = Enum.TextTruncate.AtEnd
PlayerNameLabel.Parent = WMarkContent

addWMarkSep()

local WMarkFpsLabel = Instance.new("TextLabel")
WMarkFpsLabel.Name = "WMarkFpsLabel"
WMarkFpsLabel.Size = UDim2.new(0, 48, 1, 0)
WMarkFpsLabel.BackgroundTransparency = 1
WMarkFpsLabel.Font = Library.Fonts.Badge
WMarkFpsLabel.Text = "60 FPS"
WMarkFpsLabel.TextColor3 = Library.Theme.Accent
WMarkFpsLabel.TextSize = 10
WMarkFpsLabel.Parent = WMarkContent

addWMarkSep()

local WMarkPingLabel = Instance.new("TextLabel")
WMarkPingLabel.Name = "WMarkPingLabel"
WMarkPingLabel.Size = UDim2.new(0, 42, 1, 0)
WMarkPingLabel.BackgroundTransparency = 1
WMarkPingLabel.Font = Library.Fonts.Badge
WMarkPingLabel.Text = "0 ms"
WMarkPingLabel.TextColor3 = Library.Theme.Accent
WMarkPingLabel.TextSize = 10
WMarkPingLabel.Parent = WMarkContent

addWMarkSep()

local WMarkTimeLabel = Instance.new("TextLabel")
WMarkTimeLabel.Name = "WMarkTimeLabel"
WMarkTimeLabel.Size = UDim2.new(0, 56, 1, 0)
WMarkTimeLabel.BackgroundTransparency = 1
WMarkTimeLabel.Font = Library.Fonts.Badge
WMarkTimeLabel.Text = "00:00:00"
WMarkTimeLabel.TextColor3 = Library.Theme.Text
WMarkTimeLabel.TextSize = 10
WMarkTimeLabel.Parent = WMarkContent

UI.Watermark = TopWatermark
UI.WMarkStroke = TopWMarkStroke
UI.WMarkIcon = TopWMarkIcon
UI.WMarkTitle = TopWMarkTitle
UI.PlayerNameLabel = PlayerNameLabel
UI.WMarkFpsLabel = WMarkFpsLabel
UI.WMarkPingLabel = WMarkPingLabel
UI.WMarkTimeLabel = WMarkTimeLabel
UI.WMarkPingLabel = WMarkPingLabel
UI.WMarkTimeLabel = WMarkTimeLabel

local fpsFrameCount = 0
local lastFpsCheck = tick()

trackConnection(RunService.RenderStepped:Connect(function(dt)
    fpsFrameCount = fpsFrameCount + 1
    local now = tick()
    if now - lastFpsCheck >= 1 then
        local currentFps = fpsFrameCount
        fpsFrameCount = 0
        lastFpsCheck = now

        local pingMs = 0
        pcall(function()
            local stats = game:GetService("Stats")
            local dataPing = stats.Network.ServerStatsItem:FindFirstChild("Data Ping")
            if dataPing then
                pingMs = math.floor(dataPing:GetValue())
            elseif LocalPlayer then
                pingMs = math.floor(LocalPlayer:GetNetworkPing() * 1000)
            end
        end)

        local timeNow = os.date("%H:%M:%S")
        if WMarkFpsLabel then WMarkFpsLabel.Text = currentFps .. " FPS" end
        if WMarkPingLabel then WMarkPingLabel.Text = pingMs .. " ms" end
        if WMarkTimeLabel then WMarkTimeLabel.Text = timeNow end
    end
end))

local GearBtnFrame = Instance.new("Frame")
GearBtnFrame.Name = "GearButtonFrame"
GearBtnFrame.Size = UDim2.new(0, 36, 0, 36)
GearBtnFrame.Position = UDim2.new(1, -48, 0, 10)
GearBtnFrame.BackgroundColor3 = Library.Theme.Block
GearBtnFrame.BackgroundTransparency = 0.06
GearBtnFrame.BorderSizePixel = 0
GearBtnFrame.Parent = ScreenGui
UI.GearBtnFrame = GearBtnFrame

addCorner(GearBtnFrame, 18)

local GearStroke = Instance.new("UIStroke")
GearStroke.Color = Library.Theme.Accent
GearStroke.Transparency = 0.25
GearStroke.Thickness = 1.2
GearStroke.Parent = GearBtnFrame
UI.GearStroke = GearStroke

local GearIcon = Instance.new("ImageButton")
GearIcon.Name = "GearIcon"
GearIcon.Size = UDim2.new(0, 20, 0, 20)
GearIcon.Position = UDim2.new(0.5, -10, 0.5, -10)
GearIcon.BackgroundTransparency = 1
GearIcon.Image = "rbxassetid://7059346373"
GearIcon.ImageColor3 = Library.Theme.Accent
GearIcon.Parent = GearBtnFrame
UI.GearIcon = GearIcon

GearBtnFrame.MouseEnter:Connect(function()
    smoothTween(GearBtnFrame, DUR_FAST, { BackgroundColor3 = Library.Theme.Header })
    smoothTween(GearStroke, DUR_FAST, { Transparency = 0 })
    smoothTween(GearIcon, DUR_FAST, { Size = UDim2.new(0, 22, 0, 22), Position = UDim2.new(0.5, -11, 0.5, -11) })
end)

GearBtnFrame.MouseLeave:Connect(function()
    smoothTween(GearBtnFrame, DUR_FAST, { BackgroundColor3 = Library.Theme.Block })
    smoothTween(GearStroke, DUR_FAST, { Transparency = 0.25 })
    smoothTween(GearIcon, DUR_FAST, { Size = UDim2.new(0, 20, 0, 20), Position = UDim2.new(0.5, -10, 0.5, -10) })
end)

local isDraggingGear = false
local dragGearStart = nil
local startGearPos = nil

GearIcon.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDraggingGear = true
        dragGearStart = input.Position
        startGearPos = GearBtnFrame.Position
    end
end)

trackConnection(UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDraggingGear = false
    end
end))

trackConnection(UserInputService.InputChanged:Connect(function(input)
    if isDraggingGear and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragGearStart
        GearBtnFrame.Position = UDim2.new(startGearPos.X.Scale, startGearPos.X.Offset + delta.X, startGearPos.Y.Scale, startGearPos.Y.Offset + delta.Y)
    end
end))

local SettingsModal

local function makeDraggable(frame, dragHandle)
    local dragging = false
    local dragInput, dragStart, startPos

    trackConnection(dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            if SettingsModal and SettingsModal.Visible and frame ~= SettingsModal then
                return
            end

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
            if SettingsModal and SettingsModal.Visible and frame ~= SettingsModal then
                dragging = false
                return
            end
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

local function makeResizable(targetFrame, gripBtn, minW, minH, maxW, maxH, onResize)
    minW = minW or 180
    minH = minH or 80
    maxW = maxW or 1000
    maxH = maxH or 900

    local isResizing = false
    local startMousePos = nil
    local startFrameSize = nil

    gripBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isResizing = true
            startMousePos = input.Position
            startFrameSize = targetFrame.AbsoluteSize
        end
    end)

    trackConnection(UserInputService.InputChanged:Connect(function(input)
        if isResizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - startMousePos
            local newW = math.clamp(startFrameSize.X + delta.X, minW, maxW)
            local newH = math.clamp(startFrameSize.Y + delta.Y, minH, maxH)
            targetFrame.Size = UDim2.new(0, newW, 0, newH)
            if onResize then
                onResize(newW, newH)
            end
        end
    end))

    trackConnection(UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isResizing = false
        end
    end))
end

local function makeScalable(targetFrame, uiScaleElem, gripBtn, baseW, baseH, minScale, maxScale)
    baseW = baseW or (targetFrame.Size.X.Offset > 0 and targetFrame.Size.X.Offset or 260)
    baseH = baseH or (targetFrame.Size.Y.Offset > 0 and targetFrame.Size.Y.Offset or 168)
    minScale = minScale or 0.60
    maxScale = maxScale or 1.40

    local isScaling = false
    local startMousePos = nil
    local startScale = 1.0

    gripBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isScaling = true
            startMousePos = input.Position
            startScale = uiScaleElem.Scale
        end
    end)

    trackConnection(UserInputService.InputChanged:Connect(function(input)
        if isScaling and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - startMousePos
            local scaleDelta = (delta.X + delta.Y) / 250
            local newScale = math.clamp(startScale + scaleDelta, minScale, maxScale)
            targetFrame.Size = UDim2.new(0, baseW, 0, baseH)
            uiScaleElem.Scale = newScale
        end
    end))

    trackConnection(UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isScaling = false
        end
    end))
end

makeDraggable(TopWatermark, TopWatermark)

local KeybindHUDFrame = Instance.new("Frame")
KeybindHUDFrame.Name = "KeybindHUDOverlay"
KeybindHUDFrame.Size = UDim2.new(0, 230, 0, 32)
KeybindHUDFrame.Position = UDim2.new(1, -245, 0.35, 0)
KeybindHUDFrame.BackgroundColor3 = Library.Theme.Block
KeybindHUDFrame.BackgroundTransparency = 0.06
KeybindHUDFrame.BorderSizePixel = 0
KeybindHUDFrame.ClipsDescendants = true
KeybindHUDFrame.Parent = ScreenGui
UI.KeybindHUDFrame = KeybindHUDFrame

addCorner(KeybindHUDFrame, 8)

local KeybindHUDUIScale = Instance.new("UIScale")
KeybindHUDUIScale.Name = "KeybindHUDUIScale"
KeybindHUDUIScale.Scale = 1
KeybindHUDUIScale.Parent = KeybindHUDFrame

local KeybindHUDStroke = Instance.new("UIStroke")
KeybindHUDStroke.Color = Library.Theme.Stroke
KeybindHUDStroke.Transparency = 0.3
KeybindHUDStroke.Thickness = 1.0
KeybindHUDStroke.Parent = KeybindHUDFrame
UI.KeybindHUDStroke = KeybindHUDStroke

local KeybindHUDHeader = Instance.new("Frame")
KeybindHUDHeader.Size = UDim2.new(1, 0, 0, 32)
KeybindHUDHeader.BackgroundColor3 = Library.Theme.Header
KeybindHUDHeader.BackgroundTransparency = 0.10
KeybindHUDHeader.BorderSizePixel = 0
KeybindHUDHeader.Parent = KeybindHUDFrame
UI.KeybindHUDHeader = KeybindHUDHeader
addCorner(KeybindHUDHeader, 8)

local HUDDot = Instance.new("Frame")
HUDDot.Size = UDim2.new(0, 6, 0, 6)
HUDDot.Position = UDim2.new(0, 10, 0.5, -3)
HUDDot.BackgroundColor3 = Library.Theme.Accent
HUDDot.BorderSizePixel = 0
HUDDot.Visible = false
HUDDot.Parent = KeybindHUDHeader
UI.HUDDot = HUDDot

local HUDIcon = Instance.new("ImageLabel")
HUDIcon.Name = "HUDIcon"
HUDIcon.Size = UDim2.new(0, 16, 0, 16)
HUDIcon.Position = UDim2.new(0, 10, 0.5, -8)
HUDIcon.BackgroundTransparency = 1
HUDIcon.Image = "rbxassetid://11710306232"
HUDIcon.ImageColor3 = Library.Theme.Accent
HUDIcon.ZIndex = 12
HUDIcon.Parent = KeybindHUDHeader
UI.HUDIcon = HUDIcon

local HUDTitle = Instance.new("TextLabel")
HUDTitle.Size = UDim2.new(1, -60, 1, 0)
HUDTitle.Position = UDim2.new(0, 32, 0, 0)
HUDTitle.BackgroundTransparency = 1
HUDTitle.Font = Library.Fonts.Header
HUDTitle.Text = "KEYBINDS"
HUDTitle.TextColor3 = Library.Theme.Text
HUDTitle.TextSize = 11
HUDTitle.TextXAlignment = Enum.TextXAlignment.Left
HUDTitle.Parent = KeybindHUDHeader
UI.HUDTitle = HUDTitle

local HUDCountLabel = Instance.new("TextLabel")
HUDCountLabel.Size = UDim2.new(0, 30, 1, 0)
HUDCountLabel.Position = UDim2.new(1, -36, 0, 0)
HUDCountLabel.BackgroundTransparency = 1
HUDCountLabel.Font = Library.Fonts.Badge
HUDCountLabel.Text = "(0)"
HUDCountLabel.TextColor3 = Library.Theme.Accent
HUDCountLabel.TextSize = 10
HUDCountLabel.TextXAlignment = Enum.TextXAlignment.Right
HUDCountLabel.Parent = KeybindHUDHeader
UI.HUDCountLabel = HUDCountLabel

local HUDListHolder = Instance.new("Frame")
HUDListHolder.Size = UDim2.new(1, -12, 0, 0)
HUDListHolder.Position = UDim2.new(0, 6, 0, 36)
HUDListHolder.BackgroundTransparency = 1
HUDListHolder.Parent = KeybindHUDFrame

local HUDListLayout = Instance.new("UIListLayout")
HUDListLayout.SortOrder = Enum.SortOrder.LayoutOrder
HUDListLayout.Padding = UDim.new(0, 4)
HUDListLayout.Parent = HUDListHolder

makeDraggable(KeybindHUDFrame, KeybindHUDHeader)

local KeybindResizeGrip = Instance.new("TextButton")
KeybindResizeGrip.Name = "KeybindResizeGrip"
KeybindResizeGrip.Size = UDim2.new(0, 16, 0, 16)
KeybindResizeGrip.Position = UDim2.new(1, -14, 1, -14)
KeybindResizeGrip.BackgroundTransparency = 1
KeybindResizeGrip.Font = Library.Fonts.Badge
KeybindResizeGrip.Text = "◢"
KeybindResizeGrip.TextColor3 = Library.Theme.TextDim
KeybindResizeGrip.TextSize = 11
KeybindResizeGrip.ZIndex = 100
KeybindResizeGrip.Parent = KeybindHUDFrame

KeybindResizeGrip.MouseEnter:Connect(function()
    smoothTween(KeybindResizeGrip, DUR_FAST, { TextColor3 = Library.Theme.Accent })
end)
KeybindResizeGrip.MouseLeave:Connect(function()
    smoothTween(KeybindResizeGrip, DUR_FAST, { TextColor3 = Library.Theme.TextDim })
end)

-- Classic Resizing for Keybinds Overlay
makeResizable(KeybindHUDFrame, KeybindResizeGrip, 180, 36, 450, 500, function(newW, newH)
    UI.KeybindHUDCustomWidth = newW
    UI.KeybindHUDCustomHeight = newH
    UI.KeybindHUDUserResized = true
end)

function Library:RefreshKeybindHUD()
    for _, child in ipairs(HUDListHolder:GetChildren()) do
        if child:IsA("Frame") or child:IsA("TextLabel") then child:Destroy() end
    end

    local activeCount = 0
    local totalBinds = 0

    for featName, data in pairs(Library.KeybindList) do
        totalBinds = totalBinds + 1
        local keyStr = ""
        local modeStr = "Toggle"
        local isActive = false
        if type(data) == "table" then
            keyStr = data.Key or ""
            modeStr = data.Mode or "Toggle"
            isActive = (data.Active == true or data.ActiveState == true or modeStr == "Always")
        else
            keyStr = tostring(data)
        end

        if isActive then activeCount = activeCount + 1 end

        local Row = Instance.new("Frame")
        Row.Size = UDim2.new(1, 0, 0, 24)
        Row.BackgroundColor3 = isActive and Library.Theme.CardHover or Library.Theme.Card
        Row.BorderSizePixel = 0
        Row.Parent = HUDListHolder
        addCorner(Row, 6)

        local RowStroke = Instance.new("UIStroke")
        RowStroke.Color = isActive and Color3.fromRGB(45, 58, 75) or Library.Theme.Stroke
        RowStroke.Thickness = 1
        RowStroke.Parent = Row

        local ActiveBar = Instance.new("Frame")
        ActiveBar.Size = UDim2.new(0, 3, 1, -6)
        ActiveBar.Position = UDim2.new(0, 3, 0.5, -9)
        ActiveBar.BackgroundColor3 = isActive and Color3.fromRGB(0, 210, 255) or Library.Theme.Header
        ActiveBar.BorderSizePixel = 0
        ActiveBar.Parent = Row
        addCorner(ActiveBar, 2)

        local NameLbl = Instance.new("TextLabel")
        NameLbl.Size = UDim2.new(1, -115, 1, 0)
        NameLbl.Position = UDim2.new(0, 12, 0, 0)
        NameLbl.BackgroundTransparency = 1
        NameLbl.Font = Library.Fonts.Label
        NameLbl.Text = featName
        NameLbl.TextColor3 = isActive and Color3.fromRGB(225, 235, 250) or Library.Theme.TextDim
        NameLbl.TextSize = 10.5
        NameLbl.TextXAlignment = Enum.TextXAlignment.Left
        NameLbl.Parent = Row

        local Badge = Instance.new("TextLabel")
        Badge.Size = UDim2.new(0, 95, 0, 18)
        Badge.Position = UDim2.new(1, -98, 0.5, -9)
        Badge.BackgroundColor3 = isActive and Library.Theme.Header or Library.Theme.Block
        Badge.Font = Library.Fonts.Label
        if modeStr == "Always" or modeStr == "ALWAYS" then
            Badge.Text = "ALWAYS"
        else
            Badge.Text = keyStr .. " [" .. string.upper(tostring(modeStr)) .. "]"
        end
        Badge.TextColor3 = isActive and Color3.fromRGB(0, 210, 255) or Library.Theme.TextDim
        Badge.TextSize = 9
        Badge.BorderSizePixel = 0
        Badge.Parent = Row
        addCorner(Badge, 5)

        local BadgeStroke = Instance.new("UIStroke")
        BadgeStroke.Color = isActive and Color3.fromRGB(0, 150, 190) or Library.Theme.Stroke
        BadgeStroke.Thickness = 1
        BadgeStroke.Parent = Badge
    end

    if totalBinds == 0 then
        local EmptyRow = Instance.new("TextLabel")
        EmptyRow.Size = UDim2.new(1, 0, 0, 20)
        EmptyRow.BackgroundTransparency = 1
        EmptyRow.Font = Library.Fonts.Label
        EmptyRow.Text = "No active keybinds"
        EmptyRow.TextColor3 = Library.Theme.TextDim
        EmptyRow.TextSize = 9.5
        EmptyRow.TextXAlignment = Enum.TextXAlignment.Center
        EmptyRow.Parent = HUDListHolder
    end

    HUDCountLabel.Text = "(" .. tostring(activeCount) .. ")"

    local listHeight = HUDListLayout.AbsoluteContentSize.Y
    HUDListHolder.Size = UDim2.new(1, -12, 0, listHeight)

    local targetW = UI.KeybindHUDCustomWidth or 230
    local minReqH = 42 + listHeight
    local targetH = UI.KeybindHUDUserResized and (UI.KeybindHUDCustomHeight or minReqH) or minReqH
    if targetH < minReqH then targetH = minReqH end

    smoothTween(KeybindHUDFrame, DUR_NORMAL, { Size = UDim2.new(0, targetW, 0, targetH) })
end

local RadioHUDFrame = Instance.new("Frame")
RadioHUDFrame.Name = "RadioHUDOverlay"
RadioHUDFrame.Size = UDim2.new(0, 260, 0, 165)
RadioHUDFrame.Position = UDim2.new(1, -270, 1, -180)
RadioHUDFrame.BackgroundColor3 = Library.Theme.Block
RadioHUDFrame.BackgroundTransparency = 0.06
RadioHUDFrame.BorderSizePixel = 0
RadioHUDFrame.ClipsDescendants = false
RadioHUDFrame.Parent = ScreenGui
UI.RadioHUDFrame = RadioHUDFrame

addCorner(RadioHUDFrame, 8)

local RadioHUDUIScale = Instance.new("UIScale")
RadioHUDUIScale.Name = "RadioHUDUIScale"
RadioHUDUIScale.Scale = 1
RadioHUDUIScale.Parent = RadioHUDFrame

local RadioHUDStroke = Instance.new("UIStroke")
RadioHUDStroke.Color = Library.Theme.Stroke
RadioHUDStroke.Transparency = 0.3
RadioHUDStroke.Thickness = 1.0
RadioHUDStroke.Parent = RadioHUDFrame
UI.RadioHUDStroke = RadioHUDStroke

local RadioHeader = Instance.new("Frame")
RadioHeader.Size = UDim2.new(1, 0, 0, 28)
RadioHeader.BackgroundColor3 = Library.Theme.Header
RadioHeader.BackgroundTransparency = 0.10
RadioHeader.BorderSizePixel = 0
RadioHeader.Parent = RadioHUDFrame
UI.RadioHeader = RadioHeader
addCorner(RadioHeader, 8)

local MusicIcon = Instance.new("ImageLabel")
MusicIcon.Name = "MusicIcon"
MusicIcon.Size = UDim2.new(0, 16, 0, 16)
MusicIcon.Position = UDim2.new(0, 8, 0.5, -8)
MusicIcon.BackgroundTransparency = 1
MusicIcon.Image = "rbxassetid://17387359605"
MusicIcon.ImageColor3 = Library.Theme.Accent
MusicIcon.Parent = RadioHeader
UI.MusicIcon = MusicIcon

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
UI.RHTitle = RHTitle

local HUDPrevBtn = Instance.new("TextButton")
HUDPrevBtn.Size = UDim2.new(0, 22, 0, 20)
HUDPrevBtn.Position = UDim2.new(1, -110, 0.5, -10)
HUDPrevBtn.BackgroundColor3 = Library.Theme.Card
HUDPrevBtn.BorderSizePixel = 0
HUDPrevBtn.Font = Library.Fonts.Badge
HUDPrevBtn.Text = "<<"
HUDPrevBtn.TextColor3 = Library.Theme.Accent
HUDPrevBtn.TextSize = 9
HUDPrevBtn.Parent = RadioHeader
addCorner(HUDPrevBtn, 4)
UI.HUDPrevBtn = HUDPrevBtn

local HUDNextBtn = Instance.new("TextButton")
HUDNextBtn.Size = UDim2.new(0, 22, 0, 20)
HUDNextBtn.Position = UDim2.new(1, -85, 0.5, -10)
HUDNextBtn.BackgroundColor3 = Library.Theme.Card
HUDNextBtn.BorderSizePixel = 0
HUDNextBtn.Font = Library.Fonts.Badge
HUDNextBtn.Text = ">>"
HUDNextBtn.TextColor3 = Library.Theme.Accent
HUDNextBtn.TextSize = 9
HUDNextBtn.Parent = RadioHeader
addCorner(HUDNextBtn, 4)
UI.HUDNextBtn = HUDNextBtn

local HUDPlayBtn = Instance.new("TextButton")
HUDPlayBtn.Size = UDim2.new(0, 58, 0, 20)
HUDPlayBtn.Position = UDim2.new(1, -60, 0.5, -10)
HUDPlayBtn.BackgroundColor3 = Library.Theme.Card
HUDPlayBtn.BorderSizePixel = 0
HUDPlayBtn.Font = Library.Fonts.Badge
HUDPlayBtn.Text = "PLAY"
HUDPlayBtn.TextColor3 = Library.Theme.Accent
HUDPlayBtn.TextSize = 9
HUDPlayBtn.Parent = RadioHeader
UI.HUDPlayBtn = HUDPlayBtn

HUDPrevBtn.MouseButton1Click:Connect(function()
    if #Playlist > 0 then
        local prevIndex = CurrentTrackIndex > 1 and CurrentTrackIndex - 1 or #Playlist
        playWorkspaceTrack(prevIndex)
    end
end)

HUDNextBtn.MouseButton1Click:Connect(function()
    if #Playlist > 0 then
        local nextIndex = CurrentTrackIndex < #Playlist and CurrentTrackIndex + 1 or 1
        playWorkspaceTrack(nextIndex)
    end
end)

makeDraggable(RadioHUDFrame, RadioHeader)

local RadioResizeGrip = Instance.new("TextButton")
RadioResizeGrip.Name = "RadioResizeGrip"
RadioResizeGrip.Size = UDim2.new(0, 16, 0, 16)
RadioResizeGrip.Position = UDim2.new(1, -14, 1, -14)
RadioResizeGrip.BackgroundTransparency = 1
RadioResizeGrip.Font = Library.Fonts.Badge
RadioResizeGrip.Text = "◢"
RadioResizeGrip.TextColor3 = Library.Theme.TextDim
RadioResizeGrip.TextSize = 11
RadioResizeGrip.ZIndex = 100
RadioResizeGrip.Parent = RadioHUDFrame

RadioResizeGrip.MouseEnter:Connect(function()
    smoothTween(RadioResizeGrip, DUR_FAST, { TextColor3 = Library.Theme.Accent })
end)
RadioResizeGrip.MouseLeave:Connect(function()
    smoothTween(RadioResizeGrip, DUR_FAST, { TextColor3 = Library.Theme.TextDim })
end)

-- Vector Anchored Scaling: RadioHUDFrame (Min Scale: 0.60 | Max Scale: 1.40)
makeScalable(RadioHUDFrame, RadioHUDUIScale, RadioResizeGrip, 260, 168, 0.60, 1.40)

local HUDSoundInputBg = Instance.new("Frame")
HUDSoundInputBg.Size = UDim2.new(1, -16, 0, 26)
HUDSoundInputBg.Position = UDim2.new(0, 8, 0, 32)
HUDSoundInputBg.BackgroundColor3 = Library.Theme.Header
HUDSoundInputBg.BorderSizePixel = 0
HUDSoundInputBg.Parent = RadioHUDFrame
UI.HUDSoundInputBg = HUDSoundInputBg

local HUDSoundInput = Instance.new("TextBox")
HUDSoundInput.Size = UDim2.new(1, -10, 1, 0)
HUDSoundInput.Position = UDim2.new(0, 5, 0, 0)
HUDSoundInput.BackgroundTransparency = 1
HUDSoundInput.Font = Library.Fonts.Badge
HUDSoundInput.PlaceholderText = "Paste Roblox ID or SoundCloud / Web Link..."
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
UI.HUDSoundInput = HUDSoundInput

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
UI.SeekTimeLabel = SeekTimeLabel

local SeekTrackBg = Instance.new("TextButton")
SeekTrackBg.Size = UDim2.new(1, 0, 0, 8)
SeekTrackBg.Position = UDim2.new(0, 0, 0, 14)
SeekTrackBg.BackgroundColor3 = Library.Theme.Header
SeekTrackBg.BorderSizePixel = 0
SeekTrackBg.AutoButtonColor = false
SeekTrackBg.Text = ""
SeekTrackBg.Parent = SeekRow
UI.SeekTrackBg = SeekTrackBg

local SeekFill = Instance.new("Frame")
SeekFill.Size = UDim2.new(0, 0, 1, 0)
SeekFill.BackgroundColor3 = Library.Theme.Accent
SeekFill.BorderSizePixel = 0
SeekFill.Parent = SeekTrackBg
UI.SeekFill = SeekFill

local SeekHandle = Instance.new("Frame")
SeekHandle.Size = UDim2.new(0, 10, 0, 12)
SeekHandle.Position = UDim2.new(0, -5, 0.5, -6)
SeekHandle.BackgroundColor3 = Library.Theme.Accent
SeekHandle.BorderSizePixel = 0
SeekHandle.Parent = SeekTrackBg
UI.SeekHandle = SeekHandle

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
SpeedRow.Size = UDim2.new(1, -16, 0, 22)
SpeedRow.Position = UDim2.new(0, 8, 0, 106)
SpeedRow.BackgroundTransparency = 1
SpeedRow.Parent = RadioHUDFrame

local VolRow = Instance.new("Frame")
VolRow.Size = UDim2.new(1, -16, 0, 24)
VolRow.Position = UDim2.new(0, 8, 0, 134)
VolRow.BackgroundTransparency = 1
VolRow.Parent = RadioHUDFrame

local VolLbl = Instance.new("TextLabel")
VolLbl.Size = UDim2.new(0, 52, 1, 0)
VolLbl.Position = UDim2.new(0, 0, 0, 0)
VolLbl.BackgroundTransparency = 1
VolLbl.Font = Library.Fonts.Badge
VolLbl.Text = string.format("VOL %d%%", math.floor(RadioSound.Volume * 100 + 0.5))
VolLbl.TextColor3 = Library.Theme.Accent
VolLbl.TextSize = 9
VolLbl.TextXAlignment = Enum.TextXAlignment.Left
VolLbl.Parent = VolRow

local VolTrackBg = Instance.new("TextButton")
VolTrackBg.Size = UDim2.new(1, -58, 0, 8)
VolTrackBg.Position = UDim2.new(0, 56, 0.5, -4)
VolTrackBg.BackgroundColor3 = Library.Theme.Header
VolTrackBg.BorderSizePixel = 0
VolTrackBg.AutoButtonColor = false
VolTrackBg.ClipsDescendants = false
VolTrackBg.Text = ""
VolTrackBg.Parent = VolRow
addCorner(VolTrackBg, 4)

local VolFill = Instance.new("Frame")
VolFill.Size = UDim2.new(RadioSound.Volume, 0, 1, 0)
VolFill.BackgroundColor3 = Library.Theme.Accent
VolFill.BorderSizePixel = 0
VolFill.Parent = VolTrackBg
addCorner(VolFill, 4)

local VolHandle = Instance.new("Frame")
VolHandle.Size = UDim2.new(0, 10, 0, 12)
VolHandle.Position = UDim2.new(RadioSound.Volume, -5, 0.5, -6)
VolHandle.BackgroundColor3 = Library.Theme.Accent
VolHandle.BorderSizePixel = 0
VolHandle.ZIndex = 10
VolHandle.Parent = VolTrackBg
addCorner(VolHandle, 5)

local isDraggingVol = false
local function updateVolumeFromInput(inputX)
    local width = VolTrackBg.AbsoluteSize.X
    if width <= 0 then return end
    local relX = math.clamp((inputX - VolTrackBg.AbsolutePosition.X) / width, 0, 1)
    RadioSound.Volume = relX
    VolLbl.Text = string.format("VOL %d%%", math.floor(relX * 100 + 0.5))
    VolFill.Size = UDim2.new(relX, 0, 1, 0)
    VolHandle.Position = UDim2.new(relX, -5, 0.5, -6)
end

trackConnection(VolTrackBg.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDraggingVol = true
        updateVolumeFromInput(input.Position.X)
    end
end))

trackConnection(UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDraggingVol = false
    end
end))

trackConnection(UserInputService.InputChanged:Connect(function(input)
    if isDraggingVol and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        updateVolumeFromInput(input.Position.X)
    end
end))

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

UI.SpeedButtons = {}
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
    UI.SpeedButtons[spData.Val] = SpBtn

    SpBtn.MouseButton1Click:Connect(function()
        RadioSound.PlaybackSpeed = spData.Val
        for _, child in ipairs(SpeedRow:GetChildren()) do
            if child:IsA("TextButton") then
                local isMatch = (child.Text == spData.Text)
                smoothTween(child, DUR_FAST, {
                    BackgroundColor3 = isMatch and Library.Theme.Header or Library.Theme.Card,
                    TextColor3 = isMatch and Library.Theme.Accent or Library.Theme.TextDim
                })
            end
        end
    end)
end

local Playlist = {}
local CurrentTrackIndex = 1

local function scanMusicFiles()
    Playlist = {}
    pcall(function()
        if makefolder and isfolder and not isfolder(Library.MusicFolder) then
            makefolder(Library.MusicFolder)
        end
        if listfiles and isfolder and isfolder(Library.MusicFolder) then
            local files = listfiles(Library.MusicFolder)
            for _, path in ipairs(files) do
                local name = path:match("([^/^\\]+)$")
                if name then
                    local ext = name:sub(-4):lower()
                    if ext == ".mp3" or ext == ".wav" or ext == ".ogg" then
                        table.insert(Playlist, name)
                    end
                end
            end
        end
    end)
    return Playlist
end

local function playWorkspaceTrack(index)
    scanMusicFiles()
    if #Playlist == 0 then
        RadioTrackLabel.Text = "Drop .mp3/.wav in workspace/Nursultan/Music!"
        HUDPlayBtn.Text = "PLAY"
        if PlaySoundBtn then PlaySoundBtn.Text = "  REFRESH FOLDER" end
        return
    end

    CurrentTrackIndex = math.clamp(index or 1, 1, #Playlist)
    local fileName = Playlist[CurrentTrackIndex]
    local fullPath = Library.MusicFolder .. "/" .. fileName

    RadioTrackLabel.Text = string.format("[%d/%d] %s", CurrentTrackIndex, #Playlist, string.sub(fileName, 1, 22))
    HUDPlayBtn.Text = "LOADING..."
    if PlaySoundBtn then PlaySoundBtn.Text = "  LOADING..." end

    task.spawn(function()
        if getcustomasset and isfile and isfile(fullPath) then
            local okAsset, asset = pcall(function() return getcustomasset(fullPath) end)
            if okAsset and asset and asset ~= "" then
                pcall(function() RadioSound:Stop() end)
                RadioSound.SoundId = asset
                RadioSound.TimePosition = 0
                pcall(function() ContentProvider:PreloadAsync({RadioSound}) end)
                task.wait(0.15)
                RadioSound:Play()

                HUDPlayBtn.Text = "PAUSE"
                if PlaySoundBtn then PlaySoundBtn.Text = "  PAUSE TRACK" end
                return
            end
        end

        RadioTrackLabel.Text = "Error loading " .. string.sub(fileName, 1, 20)
        HUDPlayBtn.Text = "PLAY"
        if PlaySoundBtn then PlaySoundBtn.Text = "  PLAY TRACK" end
    end)
end

RadioSound.Ended:Connect(function()
    if not RadioSound.Looped and #Playlist > 1 then
        playWorkspaceTrack(CurrentTrackIndex + 1)
    end
end)

local function triggerPlaySound(rawId)
    if not rawId or rawId == "" then
        if RadioSound.IsPlaying then
            RadioSound:Pause()
            HUDPlayBtn.Text = "PLAY"
            if PlaySoundBtn then PlaySoundBtn.Text = "  PLAY TRACK" end
        else
            playWorkspaceTrack(CurrentTrackIndex)
        end
        return
    end

    RadioTrackLabel.Text = "Loading ID..."
    HUDPlayBtn.Text = "LOADING..."
    if PlaySoundBtn then PlaySoundBtn.Text = "  LOADING..." end

    task.spawn(function()
        local soundAsset = formatAssetId(rawId)
        if soundAsset and soundAsset ~= "" then
            pcall(function() RadioSound:Stop() end)
            RadioSound.SoundId = soundAsset
            RadioSound.TimePosition = 0

            pcall(function() ContentProvider:PreloadAsync({RadioSound}) end)
            task.wait(0.2)
            RadioSound:Play()

            local cleanName = tostring(rawId):match("([^/]+)$") or rawId
            RadioTrackLabel.Text = "Track: " .. string.sub(cleanName, 1, 28)
            HUDPlayBtn.Text = "PAUSE"
            if PlaySoundBtn then PlaySoundBtn.Text = "  PAUSE RADIO" end
        else
            RadioTrackLabel.Text = "Error loading song ID"
            HUDPlayBtn.Text = "PLAY"
            if PlaySoundBtn then PlaySoundBtn.Text = "  PLAY RADIO" end
        end
    end)
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

-- FULL TRANSPARENCY & PERFECT PROPORTIONAL SCALING (ROBLOX UISCALE)
local function updateRadioHUDProperties()
    if not RadioHUDFrame then return end
    RadioHUDFrame.Visible = Library.RadioHUDVisible
    local alpha = math.clamp((Library.RadioHUDTransparency or 0) / 100, 0, 0.95)

    RadioHUDFrame.BackgroundTransparency = math.max(0.06, alpha)
    if RadioHeader then RadioHeader.BackgroundTransparency = math.max(0.10, alpha) end

    for _, desc in ipairs(RadioHUDFrame:GetDescendants()) do
        if desc:IsA("Frame") or desc:IsA("TextButton") or desc:IsA("TextBox") then
            if desc ~= RadioHUDFrame and desc ~= RadioHeader then
                desc.BackgroundTransparency = math.max(desc.BackgroundTransparency, alpha)
            end
        end
        if desc:IsA("TextLabel") or desc:IsA("TextButton") or desc:IsA("TextBox") then
            desc.TextTransparency = alpha
        end
        if desc:IsA("ImageLabel") or desc:IsA("ImageButton") then
            desc.ImageTransparency = alpha
        end
        if desc:IsA("UIStroke") then
            desc.Transparency = math.max(0.3, alpha)
        end
    end
end

-- Modal Backdrop (Blocks clicks/interactions behind Settings Modal when open)
local ModalBackdrop = Instance.new("TextButton")
ModalBackdrop.Name = "ModalBackdrop"
ModalBackdrop.Size = UDim2.new(1, 0, 1, 0)
ModalBackdrop.Position = UDim2.new(0, 0, 0, 0)
ModalBackdrop.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ModalBackdrop.BackgroundTransparency = 0.55
ModalBackdrop.Visible = false
ModalBackdrop.Text = ""
ModalBackdrop.AutoButtonColor = false
ModalBackdrop.Active = true
ModalBackdrop.Modal = true
ModalBackdrop.ZIndex = 50
ModalBackdrop.Parent = ScreenGui
UI.ModalBackdrop = ModalBackdrop

-- ==============================================================
-- DEDICATED TAB NAVIGATION SETTINGS MODAL (520 x 420 px)
-- ==============================================================
SettingsModal = Instance.new("Frame")
SettingsModal.Name = "SettingsModal"
SettingsModal.Size = UDim2.new(0, 520, 0, 420)
SettingsModal.Position = UDim2.new(0.5, -260, 0.5, -210)
SettingsModal.BackgroundColor3 = Library.Theme.Block
SettingsModal.BackgroundTransparency = 0.04
SettingsModal.BorderSizePixel = 0
SettingsModal.ClipsDescendants = false
SettingsModal.Active = true
SettingsModal.Visible = false
SettingsModal.ZIndex = 60
SettingsModal.Parent = ScreenGui
UI.SettingsModal = SettingsModal

addCorner(SettingsModal, 14)

local ModalStroke = Instance.new("UIStroke")
ModalStroke.Color = Library.Theme.StrokeActive
ModalStroke.Transparency = 0.25
ModalStroke.Thickness = 1.2
ModalStroke.Parent = SettingsModal
UI.ModalStroke = ModalStroke

local ModalHeader = Instance.new("Frame")
ModalHeader.Name = "ModalHeader"
ModalHeader.Size = UDim2.new(1, 0, 0, 40)
ModalHeader.BackgroundColor3 = Library.Theme.Header
ModalHeader.BackgroundTransparency = 0.08
ModalHeader.BorderSizePixel = 0
ModalHeader.ZIndex = 61
ModalHeader.Parent = SettingsModal
UI.ModalHeader = ModalHeader
addCorner(ModalHeader, 14)

local ModalLogoIcon = Instance.new("ImageLabel")
ModalLogoIcon.Name = "ModalLogoIcon"
ModalLogoIcon.Size = UDim2.new(0, 20, 0, 20)
ModalLogoIcon.Position = UDim2.new(0, 12, 0.5, -10)
ModalLogoIcon.BackgroundTransparency = 1
ModalLogoIcon.Image = "rbxassetid://93992148478224"
ModalLogoIcon.ImageColor3 = Library.Theme.Accent
ModalLogoIcon.ZIndex = 22
ModalLogoIcon.Parent = ModalHeader
UI.ModalLogoIcon = ModalLogoIcon

local ModalTitle = Instance.new("TextLabel")
ModalTitle.Size = UDim2.new(1, -70, 1, 0)
ModalTitle.Position = UDim2.new(0, 38, 0, 0)
ModalTitle.BackgroundTransparency = 1
ModalTitle.Font = Library.Fonts.Header
ModalTitle.Text = (Library.WatermarkText or "STAR.UI") .. "  |  SETTINGS & MANAGER"
ModalTitle.TextColor3 = Library.Theme.Text
ModalTitle.TextSize = 11
ModalTitle.TextXAlignment = Enum.TextXAlignment.Left
ModalTitle.ZIndex = 22
ModalTitle.Parent = ModalHeader
UI.ModalTitle = ModalTitle

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

-- SIDEBAR TAB NAVIGATION (LEFT: 130px)
local ModalSidebar = Instance.new("Frame")
ModalSidebar.Name = "ModalSidebar"
ModalSidebar.Size = UDim2.new(0, 130, 1, -40)
ModalSidebar.Position = UDim2.new(0, 0, 0, 40)
ModalSidebar.BackgroundColor3 = Library.Theme.Header
ModalSidebar.BorderSizePixel = 0
ModalSidebar.ClipsDescendants = true
ModalSidebar.ZIndex = 21
ModalSidebar.Parent = SettingsModal
UI.ModalSidebar = ModalSidebar

addCorner(ModalSidebar, 14)

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SidebarLayout.Padding = UDim.new(0, 4)
SidebarLayout.Parent = ModalSidebar

local SidebarPadding = Instance.new("UIPadding")
SidebarPadding.PaddingTop = UDim.new(0, 10)
SidebarPadding.PaddingLeft = UDim.new(0, 8)
SidebarPadding.PaddingRight = UDim.new(0, 8)
SidebarPadding.Parent = ModalSidebar

-- CONTENT AREA (RIGHT: 370px)
local ModalPageContainer = Instance.new("Frame")
ModalPageContainer.Name = "ModalPageContainer"
ModalPageContainer.Size = UDim2.new(1, -130, 1, -40)
ModalPageContainer.Position = UDim2.new(0, 130, 0, 40)
ModalPageContainer.BackgroundTransparency = 1
ModalPageContainer.ClipsDescendants = true
ModalPageContainer.Active = true
ModalPageContainer.ZIndex = 62
ModalPageContainer.Parent = SettingsModal

-- MODAL BLOCKER FOR CONFIG SELECTION DROPDOWN (Click outside to close)
local ConfigDropBackdrop = Instance.new("TextButton")
ConfigDropBackdrop.Name = "ConfigDropBackdrop"
ConfigDropBackdrop.Size = UDim2.new(1, 0, 1, 0)
ConfigDropBackdrop.Position = UDim2.new(0, 0, 0, 0)
ConfigDropBackdrop.BackgroundTransparency = 1
ConfigDropBackdrop.Text = ""
ConfigDropBackdrop.AutoButtonColor = false
ConfigDropBackdrop.Active = false
ConfigDropBackdrop.Visible = false
ConfigDropBackdrop.ZIndex = 490
ConfigDropBackdrop.Parent = SettingsModal

local ModalTabs = {}
local SidebarBtns = {}

-- UNCLIPPED CONFIG SELECTION DROPDOWN (PARENTED TO TOP CONTAINER)
local ConfigDropList = Instance.new("Frame")
ConfigDropList.Name = "ConfigDropListOverlay"
ConfigDropList.Size = UDim2.new(0, 0, 0, 0)
ConfigDropList.BackgroundColor3 = Library.Theme.Block
ConfigDropList.BorderSizePixel = 0
ConfigDropList.ClipsDescendants = true
ConfigDropList.Visible = false
ConfigDropList.ZIndex = 500
ConfigDropList.Parent = ScreenGui

local ConfigDropStroke = Instance.new("UIStroke")
ConfigDropStroke.Color = Library.Theme.StrokeActive
ConfigDropStroke.Thickness = 1.2
ConfigDropStroke.ZIndex = 301
ConfigDropStroke.Parent = ConfigDropList

local ConfigDropScroll = Instance.new("ScrollingFrame")
ConfigDropScroll.Size = UDim2.new(1, 0, 1, 0)
ConfigDropScroll.BackgroundTransparency = 1
ConfigDropScroll.BorderSizePixel = 0
ConfigDropScroll.ScrollBarThickness = 3
ConfigDropScroll.ScrollBarImageColor3 = Library.Theme.Accent
ConfigDropScroll.ZIndex = 301
ConfigDropScroll.Parent = ConfigDropList

local ConfigDropLayout = Instance.new("UIListLayout")
ConfigDropLayout.SortOrder = Enum.SortOrder.LayoutOrder
ConfigDropLayout.Padding = UDim.new(0, 2)
ConfigDropLayout.Parent = ConfigDropScroll

local function createModalTab(tabName)
    local TabPage = Instance.new("ScrollingFrame")
    TabPage.Name = "Page_" .. tabName
    TabPage.Size = UDim2.new(1, -20, 1, -20)
    TabPage.Position = UDim2.new(0, 10, 0, 10)
    TabPage.BackgroundTransparency = 1
    TabPage.BorderSizePixel = 0
    TabPage.ScrollBarThickness = 4
    TabPage.ScrollBarImageColor3 = Library.Theme.Accent
    TabPage.Visible = false
    TabPage.ClipsDescendants = true
    TabPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
    TabPage.CanvasSize = UDim2.new(0, 0, 0, 450)
    TabPage.ZIndex = 63
    TabPage.Parent = ModalPageContainer

    local PageLayout = Instance.new("UIListLayout")
    PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    PageLayout.Padding = UDim.new(0, 10)
    PageLayout.Parent = TabPage

    PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        local h = math.max(PageLayout.AbsoluteContentSize.Y + 35, 380)
        TabPage.CanvasSize = UDim2.new(0, 0, 0, h)
    end)

    local TabBtn = Instance.new("TextButton")
    TabBtn.Size = UDim2.new(1, 0, 0, 32)
    TabBtn.BackgroundColor3 = Library.Theme.Card
    TabBtn.BorderSizePixel = 0
    TabBtn.Font = Library.Fonts.Header
    TabBtn.Text = string.upper(tabName)
    TabBtn.TextColor3 = Library.Theme.TextDim
    TabBtn.TextSize = 10
    TabBtn.ZIndex = 22
    TabBtn.Parent = ModalSidebar
    addCorner(TabBtn, 5)

    local TabIndicator = Instance.new("Frame")
    TabIndicator.Size = UDim2.new(0, 3, 1, 0)
    TabIndicator.Position = UDim2.new(0, 0, 0, 0)
    TabIndicator.BackgroundColor3 = Library.Theme.Accent
    TabIndicator.BorderSizePixel = 0
    TabIndicator.Visible = false
    TabIndicator.ZIndex = 23
    TabIndicator.Parent = TabBtn
    addCorner(TabIndicator, 2)

    ModalTabs[tabName] = { Page = TabPage, Btn = TabBtn, Indicator = TabIndicator }
    table.insert(SidebarBtns, TabBtn)

    TabBtn.MouseButton1Click:Connect(function()
        ConfigDropList.Visible = false
        for name, data in pairs(ModalTabs) do
            local isSelected = (name == tabName)
            data.Page.Visible = isSelected
            data.Indicator.Visible = isSelected
            smoothTween(data.Btn, DUR_FAST, {
                BackgroundColor3 = isSelected and Library.Theme.Block or Library.Theme.Card,
                TextColor3 = isSelected and Library.Theme.Accent or Library.Theme.TextDim
            })
            if isSelected then
                task.defer(function()
                    local layout = data.Page:FindFirstChildOfClass("UIListLayout")
                    if layout then
                        local h = math.max(layout.AbsoluteContentSize.Y + 35, 380)
                        data.Page.CanvasSize = UDim2.new(0, 0, 0, h)
                    end
                end)
            end
        end
    end)

    return TabPage
end

local ConfigsPage = createModalTab("Configs")
local ThemesPage  = createModalTab("Themes")
local SkyboxPage  = createModalTab("Skybox")
local RadioPage   = createModalTab("Radio")
local VisualsPage = createModalTab("Visuals")

ModalTabs["Configs"].Page.Visible = true
ModalTabs["Configs"].Indicator.Visible = true
ModalTabs["Configs"].Btn.BackgroundColor3 = Library.Theme.Block
ModalTabs["Configs"].Btn.TextColor3 = Library.Theme.Accent

-- 1. CONFIGS TAB PAGE
do
    local ConfigCard = Instance.new("Frame")
    ConfigCard.Size = UDim2.new(1, 0, 0, 160)
    ConfigCard.BackgroundColor3 = Library.Theme.Card
    ConfigCard.BorderSizePixel = 0
    ConfigCard.ZIndex = 22
    ConfigCard.Parent = ConfigsPage
    UI.ConfigCard = ConfigCard

    local ConfigNameBg = Instance.new("Frame")
    ConfigNameBg.Size = UDim2.new(1, -145, 0, 30)
    ConfigNameBg.Position = UDim2.new(0, 10, 0, 12)
    ConfigNameBg.BackgroundColor3 = Library.Theme.Header
    ConfigNameBg.BorderSizePixel = 0
    ConfigNameBg.ZIndex = 23
    ConfigNameBg.Parent = ConfigCard
    addCorner(ConfigNameBg, 5)

    local ConfigNameInput = Instance.new("TextBox")
    ConfigNameInput.Size = UDim2.new(1, -10, 1, 0)
    ConfigNameInput.Position = UDim2.new(0, 5, 0, 0)
    ConfigNameInput.BackgroundTransparency = 1
    ConfigNameInput.Font = Library.Fonts.Badge
    ConfigNameInput.PlaceholderText = "Config Name (e.g. Rage)..."
    ConfigNameInput.PlaceholderColor3 = Library.Theme.TextDim
    ConfigNameInput.Text = ""
    ConfigNameInput.TextColor3 = Library.Theme.Accent
    ConfigNameInput.TextSize = 11
    ConfigNameInput.TextXAlignment = Enum.TextXAlignment.Left
    ConfigNameInput.Active = true
    ConfigNameInput.Selectable = true
    ConfigNameInput.ClearTextOnFocus = false
    ConfigNameInput.ZIndex = 25
    ConfigNameInput.Parent = ConfigNameBg

    local ConfigDropBackdrop = Instance.new("TextButton")
    ConfigDropBackdrop.Name = "ConfigDropBackdrop"
    ConfigDropBackdrop.Size = UDim2.new(1, 0, 1, 0)
    ConfigDropBackdrop.Position = UDim2.new(0, 0, 0, 0)
    ConfigDropBackdrop.BackgroundTransparency = 1
    ConfigDropBackdrop.Visible = false
    ConfigDropBackdrop.Text = ""
    ConfigDropBackdrop.Active = true
    ConfigDropBackdrop.Modal = true
    ConfigDropBackdrop.ZIndex = 499
    ConfigDropBackdrop.Parent = ScreenGui

    local SaveCreateBtn = Instance.new("TextButton")
    SaveCreateBtn.Size = UDim2.new(0, 120, 0, 30)
    SaveCreateBtn.Position = UDim2.new(1, -130, 0, 12)
    SaveCreateBtn.BackgroundColor3 = Library.Theme.Header
    SaveCreateBtn.BorderSizePixel = 0
    SaveCreateBtn.Font = Library.Fonts.Header
    SaveCreateBtn.Text = "  SAVE"
    SaveCreateBtn.TextColor3 = Library.Theme.Accent
    SaveCreateBtn.TextSize = 10
    SaveCreateBtn.ZIndex = 23
    SaveCreateBtn.Parent = ConfigCard
    addCorner(SaveCreateBtn, 5)

    local SaveIcon = Instance.new("ImageLabel")
    SaveIcon.Size = UDim2.new(0, 16, 0, 16)
    SaveIcon.Position = UDim2.new(0, 8, 0.5, -8)
    SaveIcon.BackgroundTransparency = 1
    SaveIcon.Image = "rbxassetid://110746782819291"
    SaveIcon.ImageColor3 = Library.Theme.Accent
    SaveIcon.ZIndex = 24
    SaveIcon.Parent = SaveCreateBtn

    local ConfigSelectBg = Instance.new("Frame")
    ConfigSelectBg.Size = UDim2.new(1, -20, 0, 30)
    ConfigSelectBg.Position = UDim2.new(0, 10, 0, 50)
    ConfigSelectBg.BackgroundColor3 = Library.Theme.Header
    ConfigSelectBg.BorderSizePixel = 0
    ConfigSelectBg.ClipsDescendants = false
    ConfigSelectBg.ZIndex = 64
    ConfigSelectBg.Parent = ConfigCard
    addCorner(ConfigSelectBg, 5)

    local ConfigSelectLbl = Instance.new("TextLabel")
    ConfigSelectLbl.Size = UDim2.new(0, 95, 1, 0)
    ConfigSelectLbl.Position = UDim2.new(0, 8, 0, 0)
    ConfigSelectLbl.BackgroundTransparency = 1
    ConfigSelectLbl.Font = Library.Fonts.Label
    ConfigSelectLbl.Text = "Select Config:"
    ConfigSelectLbl.TextColor3 = Library.Theme.TextDim
    ConfigSelectLbl.TextSize = 10
    ConfigSelectLbl.TextXAlignment = Enum.TextXAlignment.Left
    ConfigSelectLbl.ZIndex = 65
    ConfigSelectLbl.Parent = ConfigSelectBg

    local ConfigDropdownBtn = Instance.new("TextButton")
    ConfigDropdownBtn.Size = UDim2.new(1, -105, 0, 24)
    ConfigDropdownBtn.Position = UDim2.new(0, 98, 0.5, -12)
    ConfigDropdownBtn.BackgroundColor3 = Library.Theme.Card
    ConfigDropdownBtn.BorderSizePixel = 0
    ConfigDropdownBtn.ClipsDescendants = false
    ConfigDropdownBtn.Font = Library.Fonts.Badge
    ConfigDropdownBtn.Text = "default.json v"
    ConfigDropdownBtn.TextColor3 = Library.Theme.Accent
    ConfigDropdownBtn.TextSize = 10
    ConfigDropdownBtn.ZIndex = 65
    ConfigDropdownBtn.Parent = ConfigSelectBg
    addCorner(ConfigDropdownBtn, 5)

    -- UNCLIPPED CONFIG SELECTION DROPDOWN (PARENTED DIRECTLY TO BUTTON)
    local ConfigDropList = Instance.new("Frame")
    ConfigDropList.Name = "ConfigDropListOverlay"
    ConfigDropList.Size = UDim2.new(1, 0, 0, 0)
    ConfigDropList.Position = UDim2.new(0, 0, 1, 4)
    ConfigDropList.BackgroundColor3 = Library.Theme.Block
    ConfigDropList.BorderSizePixel = 0
    ConfigDropList.ClipsDescendants = true
    ConfigDropList.Visible = false
    ConfigDropList.ZIndex = 500
    ConfigDropList.Parent = ConfigDropdownBtn

    local ConfigDropStroke = Instance.new("UIStroke")
    ConfigDropStroke.Color = Library.Theme.StrokeActive
    ConfigDropStroke.Thickness = 1.2
    ConfigDropStroke.ZIndex = 501
    ConfigDropStroke.Parent = ConfigDropList

    local ConfigDropScroll = Instance.new("ScrollingFrame")
    ConfigDropScroll.Size = UDim2.new(1, 0, 1, 0)
    ConfigDropScroll.BackgroundTransparency = 1
    ConfigDropScroll.BorderSizePixel = 0
    ConfigDropScroll.ScrollBarThickness = 3
    ConfigDropScroll.ScrollBarImageColor3 = Library.Theme.Accent
    ConfigDropScroll.ZIndex = 501
    ConfigDropScroll.Parent = ConfigDropList

    local ConfigDropLayout = Instance.new("UIListLayout")
    ConfigDropLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ConfigDropLayout.Padding = UDim.new(0, 2)
    ConfigDropLayout.Parent = ConfigDropScroll

    local function getSavedConfigsList()
        local configs = {}
        pcall(function()
            if listfiles and isfolder and isfolder(Library.ConfigFolder) then
                local files = listfiles(Library.ConfigFolder)
                for _, filePath in ipairs(files) do
                    local fileName = filePath:match("([^/^\\]+)%.json$") or filePath:match("([^/^\\]+)$")
                    if fileName then
                        if fileName:sub(-5) == ".json" then
                            fileName = fileName:sub(1, -6)
                        end
                        table.insert(configs, fileName)
                    end
                end
            end
        end)
        if #configs == 0 then
            table.insert(configs, "default")
        end
        return configs
    end

    local configDropOpen = false
    local function refreshConfigDropdownOptions()
        for _, child in ipairs(ConfigDropScroll:GetChildren()) do
            if child:IsA("TextButton") then child:Destroy() end
        end

        local cfgList = getSavedConfigsList()
        for _, cfgName in ipairs(cfgList) do
            local ItemBtn = Instance.new("TextButton")
            ItemBtn.Size = UDim2.new(1, -4, 0, 22)
            ItemBtn.BackgroundColor3 = (ConfigNameInput.Text == cfgName) and Library.Theme.Header or Library.Theme.Card
            ItemBtn.BorderSizePixel = 0
            ItemBtn.Font = Library.Fonts.Badge
            ItemBtn.Text = "  " .. cfgName .. ".json"
            ItemBtn.TextColor3 = (ConfigNameInput.Text == cfgName) and Library.Theme.Accent or Library.Theme.TextDim
            ItemBtn.TextSize = 10
            ItemBtn.TextXAlignment = Enum.TextXAlignment.Left
            ItemBtn.ZIndex = 302
            ItemBtn.Parent = ConfigDropScroll

            ItemBtn.MouseButton1Click:Connect(function()
                ConfigNameInput.Text = cfgName
                ConfigDropdownBtn.Text = cfgName .. ".json v"
                configDropOpen = false
                ConfigDropBackdrop.Visible = false
                local t = smoothTween(ConfigDropList, DUR_NORMAL, { Size = UDim2.new(1, 0, 0, 0) })
                t.Completed:Connect(function()
                    if not configDropOpen then ConfigDropList.Visible = false end
                end)
            end)
        end

        local totalH = math.min(#cfgList * 24, 110)
        ConfigDropScroll.CanvasSize = UDim2.new(0, 0, 0, #cfgList * 24)
        return totalH
    end

    ConfigDropdownBtn.MouseButton1Click:Connect(function()
        configDropOpen = not configDropOpen
        ConfigDropBackdrop.Visible = configDropOpen
        if configDropOpen then
            local height = refreshConfigDropdownOptions()
            ConfigDropList.Size = UDim2.new(1, 0, 0, 0)
            ConfigDropList.Visible = true
            smoothTween(ConfigDropList, DUR_NORMAL, { Size = UDim2.new(1, 0, 0, height) })
        else
            local t = smoothTween(ConfigDropList, DUR_NORMAL, { Size = UDim2.new(1, 0, 0, 0) })
            t.Completed:Connect(function()
                if not configDropOpen then ConfigDropList.Visible = false end
            end)
        end
    end)

    ConfigDropBackdrop.MouseButton1Click:Connect(function()
        if configDropOpen then
            configDropOpen = false
            ConfigDropBackdrop.Visible = false
            local t = smoothTween(ConfigDropList, DUR_NORMAL, { Size = UDim2.new(1, 0, 0, 0) })
            t.Completed:Connect(function()
                if not configDropOpen then ConfigDropList.Visible = false end
            end)
        end
    end)

    trackConnection(UserInputService.InputBegan:Connect(function(input)
        if configDropOpen and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2) then
            local clickPos = input.Position
            local dropPos = ConfigDropList.AbsolutePosition
            local dropSize = ConfigDropList.AbsoluteSize
            if clickPos.X < dropPos.X or clickPos.X > dropPos.X + dropSize.X or clickPos.Y < dropPos.Y or clickPos.Y > dropPos.Y + dropSize.Y then
                local btnPos = ConfigDropdownBtn.AbsolutePosition
                local btnSize = ConfigDropdownBtn.AbsoluteSize
                if not (clickPos.X >= btnPos.X and clickPos.X <= btnPos.X + btnSize.X and clickPos.Y >= btnPos.Y and clickPos.Y <= btnPos.Y + btnSize.Y) then
                    configDropOpen = false
                    local t = smoothTween(ConfigDropList, DUR_NORMAL, { Size = UDim2.new(1, -105, 0, 0) })
                    t.Completed:Connect(function()
                        if not configDropOpen then ConfigDropList.Visible = false end
                    end)
                end
            end
        end
    end))

    local LoadConfigBtn = Instance.new("TextButton")
    LoadConfigBtn.Size = UDim2.new(0.48, 0, 0, 30)
    LoadConfigBtn.Position = UDim2.new(0, 10, 0, 88)
    LoadConfigBtn.BackgroundColor3 = Library.Theme.Header
    LoadConfigBtn.BorderSizePixel = 0
    LoadConfigBtn.Font = Library.Fonts.Header
    LoadConfigBtn.Text = "  LOAD CONFIG"
    LoadConfigBtn.TextColor3 = Library.Theme.Text
    LoadConfigBtn.TextSize = 10
    LoadConfigBtn.ZIndex = 23
    LoadConfigBtn.Parent = ConfigCard
    addCorner(LoadConfigBtn, 5)

    local LoadIcon = Instance.new("ImageLabel")
    LoadIcon.Size = UDim2.new(0, 16, 0, 16)
    LoadIcon.Position = UDim2.new(0, 8, 0.5, -8)
    LoadIcon.BackgroundTransparency = 1
    LoadIcon.Image = "rbxassetid://17119858971"
    LoadIcon.ImageColor3 = Library.Theme.Text
    LoadIcon.ZIndex = 24
    LoadIcon.Parent = LoadConfigBtn

    local DeleteConfigBtn = Instance.new("TextButton")
    DeleteConfigBtn.Size = UDim2.new(0.48, 0, 0, 30)
    DeleteConfigBtn.Position = UDim2.new(0.52, -5, 0, 88)
    DeleteConfigBtn.BackgroundColor3 = Library.Theme.Header
    DeleteConfigBtn.BorderSizePixel = 0
    DeleteConfigBtn.Font = Library.Fonts.Header
    DeleteConfigBtn.Text = "   DELETE"
    DeleteConfigBtn.TextColor3 = Color3.fromRGB(255, 90, 90)
    DeleteConfigBtn.TextSize = 10
    DeleteConfigBtn.ZIndex = 23
    DeleteConfigBtn.Parent = ConfigCard
    addCorner(DeleteConfigBtn, 5)

    local DeleteIcon = Instance.new("ImageLabel")
    DeleteIcon.Size = UDim2.new(0, 16, 0, 16)
    DeleteIcon.Position = UDim2.new(0, 10, 0.5, -8)
    DeleteIcon.BackgroundTransparency = 1
    DeleteIcon.Image = "rbxassetid://11768918600"
    DeleteIcon.ImageColor3 = Color3.fromRGB(255, 90, 90)
    DeleteIcon.ZIndex = 24
    DeleteIcon.Parent = DeleteConfigBtn

local ConfigStatusLabel = Instance.new("TextLabel")
ConfigStatusLabel.Size = UDim2.new(1, -20, 0, 20)
ConfigStatusLabel.Position = UDim2.new(0, 10, 0, 126)
ConfigStatusLabel.BackgroundTransparency = 1
ConfigStatusLabel.Font = Library.Fonts.Label
ConfigStatusLabel.Text = "Folder: workspace/" .. Library.ConfigFolder
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
        BlurSize = Library.BlurSize,
        SnowEnabled = Library.SnowEnabled,
        ParticleCount = Library.ParticleCount,
        ParticleSpeed = Library.ParticleSpeed,
        ParticleSize = Library.ParticleSize,
        ParticleTexture = Library.ParticleTexture,
        RadioHUDVisible = Library.RadioHUDVisible,
        RadioHUDTransparency = Library.RadioHUDTransparency,
        RadioHUDScale = Library.RadioHUDScale,
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
            ConfigDropdownBtn.Text = name .. ".json v"
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
                if decoded.RadioHUDVisible ~= nil then Library.RadioHUDVisible = decoded.RadioHUDVisible end
                if decoded.RadioHUDTransparency ~= nil then Library.RadioHUDTransparency = decoded.RadioHUDTransparency end
                if decoded.RadioHUDScale ~= nil then Library.RadioHUDScale = decoded.RadioHUDScale end
                if decoded.BlurSize ~= nil then Library.BlurSize = decoded.BlurSize MenuBlur.Size = Library.BlurSize end
                if decoded.ParticleCount ~= nil then Library.ParticleCount = decoded.ParticleCount end
                if decoded.ParticleSpeed ~= nil then Library.ParticleSpeed = decoded.ParticleSpeed end
                if decoded.ParticleSize ~= nil then Library.ParticleSize = decoded.ParticleSize end
                if decoded.ParticleTexture ~= nil then Library.ParticleTexture = decoded.ParticleTexture end
                rebuildParticles()
                updateRadioHUDProperties()
                ConfigStatusLabel.Text = "Loaded: " .. name .. ".json"
                ConfigDropdownBtn.Text = name .. ".json v"
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
            ConfigNameInput.Text = "default"
            ConfigDropdownBtn.Text = "default.json v"
        end
    end)
end)

-- Menu Toggle Keybind Card
local MenuBindCard = Instance.new("Frame")
MenuBindCard.Size = UDim2.new(1, 0, 0, 75)
MenuBindCard.BackgroundColor3 = Library.Theme.Card
MenuBindCard.BorderSizePixel = 0
MenuBindCard.ZIndex = 22
MenuBindCard.Parent = ConfigsPage
addCorner(MenuBindCard, 8)

local MenuBindTitle = Instance.new("TextLabel")
MenuBindTitle.Size = UDim2.new(1, -20, 0, 18)
MenuBindTitle.Position = UDim2.new(0, 10, 0, 6)
MenuBindTitle.BackgroundTransparency = 1
MenuBindTitle.Font = Library.Fonts.Header
MenuBindTitle.Text = "MENU TOGGLE KEYBIND"
MenuBindTitle.TextColor3 = Library.Theme.Accent
MenuBindTitle.TextSize = 10.5
MenuBindTitle.TextXAlignment = Enum.TextXAlignment.Left
MenuBindTitle.ZIndex = 23
MenuBindTitle.Parent = MenuBindCard

local MenuBindRow = Instance.new("Frame")
MenuBindRow.Size = UDim2.new(1, -20, 0, 32)
MenuBindRow.Position = UDim2.new(0, 10, 0, 30)
MenuBindRow.BackgroundColor3 = Library.Theme.Block
MenuBindRow.BorderSizePixel = 0
MenuBindRow.ZIndex = 23
MenuBindRow.Parent = MenuBindCard
addCorner(MenuBindRow, 5)

local MBLbl = Instance.new("TextLabel")
MBLbl.Size = UDim2.new(1, -110, 1, 0)
MBLbl.Position = UDim2.new(0, 10, 0, 0)
MBLbl.BackgroundTransparency = 1
MBLbl.Font = Library.Fonts.Label
MBLbl.Text = "Toggle Menu Open / Close"
MBLbl.TextColor3 = Library.Theme.Text
MBLbl.TextSize = 10.5
MBLbl.TextXAlignment = Enum.TextXAlignment.Left
MBLbl.ZIndex = 24
MBLbl.Parent = MenuBindRow

local MenuKeyBtn = Instance.new("TextButton")
MenuKeyBtn.Size = UDim2.new(0, 95, 0, 20)
MenuKeyBtn.Position = UDim2.new(1, -102, 0.5, -10)
MenuKeyBtn.BackgroundColor3 = Library.Theme.Header
MenuKeyBtn.BorderSizePixel = 0
MenuKeyBtn.Font = Library.Fonts.Badge
MenuKeyBtn.Text = string.upper(Library.ToggleKey.Name)
MenuKeyBtn.TextColor3 = Library.Theme.Accent
MenuKeyBtn.TextSize = 9.5
MenuKeyBtn.ZIndex = 25
MenuKeyBtn.Parent = MenuBindRow
addCorner(MenuKeyBtn, 5)

local isListeningMenuKey = false
MenuKeyBtn.MouseButton1Click:Connect(function()
    isListeningMenuKey = true
    Library.ListeningKeybind = true
    MenuKeyBtn.Text = "..."
    MenuKeyBtn.TextColor3 = Library.Theme.TextDim
end)

trackConnection(UserInputService.InputBegan:Connect(function(input)
    if isListeningMenuKey then
        if input.UserInputType == Enum.UserInputType.Keyboard then
            if input.KeyCode ~= Enum.KeyCode.Escape and input.KeyCode ~= Enum.KeyCode.Unknown then
                Library.ToggleKey = input.KeyCode
                WMarkLabel.Text = (Library.WatermarkText or "STAR.UI") .. "  |  [" .. string.upper(Library.ToggleKey.Name) .. "]"
            end
            isListeningMenuKey = false
            Library.ListeningKeybind = false
            MenuKeyBtn.Text = string.upper(Library.ToggleKey.Name)
            MenuKeyBtn.TextColor3 = Library.Theme.Accent
        end
    end
end))
end

-- 2. THEMES TAB PAGE
do
    local ThemeCard = Instance.new("Frame")
    ThemeCard.Size = UDim2.new(1, 0, 0, 360)
    ThemeCard.BackgroundColor3 = Library.Theme.Card
    ThemeCard.BorderSizePixel = 0
    ThemeCard.ZIndex = 64
    ThemeCard.Parent = ThemesPage
    UI.ThemeCard = ThemeCard

    ThemesPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
    ThemesPage.CanvasSize = UDim2.new(0, 0, 0, 450)

    local TCLabel = Instance.new("TextLabel")
    TCLabel.Size = UDim2.new(1, -20, 0, 24)
    TCLabel.Position = UDim2.new(0, 10, 0, 8)
    TCLabel.BackgroundTransparency = 1
    TCLabel.Font = Library.Fonts.Header
    TCLabel.Text = "SELECT COLOR PALETTE (20 EYE-FRIENDLY THEMES)"
    TCLabel.TextColor3 = Library.Theme.Accent
    TCLabel.TextSize = 11
    TCLabel.TextXAlignment = Enum.TextXAlignment.Left
    TCLabel.ZIndex = 65
    TCLabel.Parent = ThemeCard
    UI.TCLabel = TCLabel

    local themeNames = {
        "Monochrome Slate", "Lavender Mist",
        "Nordic Sage", "Rose Gold",
        "Ocean Breeze", "Sakura Blossom",
        "Muted Mint", "Sunset Amber",
        "Platinum Steel", "Aura Indigo",
        "Cyber Neon", "Crimson Blood",
        "Emerald Dragon", "Amethyst Violet",
        "Solar Gold", "Midnight Abyss",
        "Cyberpunk 2077", "Toxic Lime",
        "Dracula Dark", "Tokyo Night"
    }

    for idx, thName in ipairs(themeNames) do
        local col = ((idx - 1) % 2)
        local row = math.floor((idx - 1) / 2)

        local ThBtn = Instance.new("TextButton")
        ThBtn.Size = UDim2.new(0.5, -15, 0, 26)
        ThBtn.Position = UDim2.new(col * 0.5, col == 0 and 10 or 5, 0, 36 + (row * 30))
        ThBtn.BackgroundColor3 = (thName == Library.CurrentThemeName) and Library.Theme.Header or Library.Theme.Block
        ThBtn.BorderSizePixel = 0
        ThBtn.Font = Library.Fonts.Badge
        ThBtn.Text = "  " .. thName
        ThBtn.TextColor3 = (thName == Library.CurrentThemeName) and Library.Theme.Accent or Library.Theme.TextDim
        ThBtn.TextSize = 9.5
        ThBtn.TextXAlignment = Enum.TextXAlignment.Left
        ThBtn.ZIndex = 65
        ThBtn.Parent = ThemeCard
        addCorner(ThBtn, 5)

        ThBtn.MouseEnter:Connect(function()
            smoothTween(ThBtn, DUR_FAST, { BackgroundColor3 = Color3.fromRGB(255, 255, 255), TextColor3 = Color3.fromRGB(0, 0, 0) })
        end)
        ThBtn.MouseLeave:Connect(function()
            local isMatch = (thName == Library.CurrentThemeName)
            smoothTween(ThBtn, DUR_FAST, {
                BackgroundColor3 = isMatch and Library.Theme.Header or Library.Theme.Block,
                TextColor3 = isMatch and Library.Theme.Accent or Library.Theme.TextDim
            })
        end)

        ThBtn.MouseButton1Click:Connect(function()
            Library:SetTheme(thName)
        end)
    end
end

--- 3. SKYBOX TAB PAGE (10 PRESET SKYBOXES + CUSTOM MANUAL INPUTS)
do
    local SkyPresetCard = Instance.new("Frame")
    SkyPresetCard.Size = UDim2.new(1, 0, 0, 195)
    SkyPresetCard.BackgroundColor3 = Library.Theme.Card
    SkyPresetCard.BorderSizePixel = 0
    SkyPresetCard.ZIndex = 22
    SkyPresetCard.Parent = SkyboxPage
    UI.SkyPresetCard = SkyPresetCard
    addCorner(SkyPresetCard, 8)

    local PresetTitle = Instance.new("TextLabel")
    PresetTitle.Size = UDim2.new(1, -20, 0, 20)
    PresetTitle.Position = UDim2.new(0, 10, 0, 8)
    PresetTitle.BackgroundTransparency = 1
    PresetTitle.Font = Library.Fonts.Header
    PresetTitle.Text = "READY-TO-USE PRESET SKYBOXES (26 PRESETS)"
    PresetTitle.TextColor3 = Library.Theme.Accent
    PresetTitle.TextSize = 11
    PresetTitle.TextXAlignment = Enum.TextXAlignment.Left
    PresetTitle.ZIndex = 23
    PresetTitle.Parent = SkyPresetCard
    UI.PresetTitle = PresetTitle

    local SkyboxAssets = {
        ["Black Storm"] = {
            Bk = "rbxassetid://15502511288", Dn = "rbxassetid://15502508460",
            Ft = "rbxassetid://15502510289", Lf = "rbxassetid://15502507918",
            Rt = "rbxassetid://15502509398", Up = "rbxassetid://15502511911"
        },
        ["HD"] = {
            Bk = "http://www.roblox.com/asset/?id=16553658937", Dn = "http://www.roblox.com/asset/?id=16553660713",
            Ft = "http://www.roblox.com/asset/?id=16553662144", Lf = "http://www.roblox.com/asset/?id=16553664042",
            Rt = "http://www.roblox.com/asset/?id=16553665766", Up = "http://www.roblox.com/asset/?id=16553667750"
        },
        ["Snow"] = {
            Bk = "http://www.roblox.com/asset/?id=155657655", Dn = "http://www.roblox.com/asset/?id=155674246",
            Ft = "http://www.roblox.com/asset/?id=155657609", Lf = "http://www.roblox.com/asset/?id=155657671",
            Rt = "http://www.roblox.com/asset/?id=155657619", Up = "http://www.roblox.com/asset/?id=155674931"
        },
        ["Blue Space"] = {
            Bk = "rbxassetid://15536110634", Dn = "rbxassetid://15536112543",
            Ft = "rbxassetid://15536116141", Lf = "rbxassetid://15536114370",
            Rt = "rbxassetid://15536118762", Up = "rbxassetid://15536117282"
        },
        ["Realistic"] = {
            Bk = "rbxassetid://653719502", Dn = "rbxassetid://653718790",
            Ft = "rbxassetid://653719067", Lf = "rbxassetid://653719190",
            Rt = "rbxassetid://653718931", Up = "rbxassetid://653719321"
        },
        ["Stormy"] = {
            Bk = "http://www.roblox.com/asset/?id=18703245834", Dn = "http://www.roblox.com/asset/?id=18703243349",
            Ft = "http://www.roblox.com/asset/?id=18703240532", Lf = "http://www.roblox.com/asset/?id=18703237556",
            Rt = "http://www.roblox.com/asset/?id=18703235430", Up = "http://www.roblox.com/asset/?id=18703232671"
        },
        ["Pink"] = {
            Bk = "rbxassetid://12216109205", Dn = "rbxassetid://12216109875",
            Ft = "rbxassetid://12216109489", Lf = "rbxassetid://12216110170",
            Rt = "rbxassetid://12216110471", Up = "rbxassetid://12216108877"
        },
        ["Sunset"] = {
            Bk = "rbxassetid://600830446", Dn = "rbxassetid://600831635",
            Ft = "rbxassetid://600832720", Lf = "rbxassetid://600886090",
            Rt = "rbxassetid://600833862", Up = "rbxassetid://600835177"
        },
        ["Arctic"] = {
            Bk = "http://www.roblox.com/asset/?id=225469390", Dn = "http://www.roblox.com/asset/?id=225469395",
            Ft = "http://www.roblox.com/asset/?id=225469403", Lf = "http://www.roblox.com/asset/?id=225469450",
            Rt = "http://www.roblox.com/asset/?id=225469471", Up = "http://www.roblox.com/asset/?id=225469481"
        },
        ["Space"] = {
            Bk = "http://www.roblox.com/asset/?id=166509999", Dn = "http://www.roblox.com/asset/?id=166510057",
            Ft = "http://www.roblox.com/asset/?id=166510116", Lf = "http://www.roblox.com/asset/?id=166510092",
            Rt = "http://www.roblox.com/asset/?id=166510131", Up = "http://www.roblox.com/asset/?id=166510114"
        },
        ["Roblox Default"] = {
            Bk = "rbxasset://textures/sky/sky512_bk.tex", Dn = "rbxasset://textures/sky/sky512_dn.tex",
            Ft = "rbxasset://textures/sky/sky512_ft.tex", Lf = "rbxasset://textures/sky/sky512_lf.tex",
            Rt = "rbxasset://textures/sky/sky512_rt.tex", Up = "rbxasset://textures/sky/sky512_up.tex"
        },
        ["Red Night"] = {
            Bk = "http://www.roblox.com/asset/?id=401664839", Dn = "http://www.roblox.com/asset/?id=401664862",
            Ft = "http://www.roblox.com/asset/?id=401664960", Lf = "http://www.roblox.com/asset/?id=401664881",
            Rt = "http://www.roblox.com/asset/?id=401664901", Up = "http://www.roblox.com/asset/?id=401664936"
        },
        ["Deep Space 1"] = {
            Bk = "http://www.roblox.com/asset/?id=149397692", Dn = "http://www.roblox.com/asset/?id=149397686",
            Ft = "http://www.roblox.com/asset/?id=149397697", Lf = "http://www.roblox.com/asset/?id=149397684",
            Rt = "http://www.roblox.com/asset/?id=149397688", Up = "http://www.roblox.com/asset/?id=149397702"
        },
        ["Pink Skies"] = {
            Bk = "http://www.roblox.com/asset/?id=151165214", Dn = "http://www.roblox.com/asset/?id=151165197",
            Ft = "http://www.roblox.com/asset/?id=151165224", Lf = "http://www.roblox.com/asset/?id=151165191",
            Rt = "http://www.roblox.com/asset/?id=151165206", Up = "http://www.roblox.com/asset/?id=151165227"
        },
        ["Purple Sunset"] = {
            Bk = "rbxassetid://264908339", Dn = "rbxassetid://264907909",
            Ft = "rbxassetid://264909420", Lf = "rbxassetid://264909758",
            Rt = "rbxassetid://264908886", Up = "rbxassetid://264907379"
        },
        ["Blue Night"] = {
            Bk = "http://www.roblox.com/asset/?id=12064107", Dn = "http://www.roblox.com/asset/?id=12064152",
            Ft = "http://www.roblox.com/asset/?id=12064121", Lf = "http://www.roblox.com/asset/?id=12063984",
            Rt = "http://www.roblox.com/asset/?id=12064115", Up = "http://www.roblox.com/asset/?id=12064131"
        },
        ["Blossom Daylight"] = {
            Bk = "http://www.roblox.com/asset/?id=271042516", Dn = "http://www.roblox.com/asset/?id=271077243",
            Ft = "http://www.roblox.com/asset/?id=271042556", Lf = "http://www.roblox.com/asset/?id=271042310",
            Rt = "http://www.roblox.com/asset/?id=271042467", Up = "http://www.roblox.com/asset/?id=271077958"
        },
        ["Blue Nebula"] = {
            Bk = "http://www.roblox.com/asset?id=135207744", Dn = "http://www.roblox.com/asset?id=135207662",
            Ft = "http://www.roblox.com/asset?id=135207770", Lf = "http://www.roblox.com/asset?id=135207615",
            Rt = "http://www.roblox.com/asset?id=135207695", Up = "http://www.roblox.com/asset?id=135207794"
        },
        ["Blue Planet"] = {
            Bk = "rbxassetid://218955819", Dn = "rbxassetid://218953419",
            Ft = "rbxassetid://218954524", Lf = "rbxassetid://218958493",
            Rt = "rbxassetid://218957134", Up = "rbxassetid://218950090"
        },
        ["Deep Space 2"] = {
            Bk = "http://www.roblox.com/asset/?id=159248188", Dn = "http://www.roblox.com/asset/?id=159248183",
            Ft = "http://www.roblox.com/asset/?id=159248187", Lf = "http://www.roblox.com/asset/?id=159248173",
            Rt = "http://www.roblox.com/asset/?id=159248192", Up = "http://www.roblox.com/asset/?id=159248176"
        },
        ["Summer"] = {
            Bk = "rbxassetid://16648590964", Dn = "rbxassetid://16648617436",
            Ft = "rbxassetid://16648595424", Lf = "rbxassetid://16648566370",
            Rt = "rbxassetid://16648577071", Up = "rbxassetid://16648598180"
        },
        ["Galaxy"] = {
            Bk = "rbxassetid://15983968922", Dn = "rbxassetid://15983966825",
            Ft = "rbxassetid://15983965025", Lf = "rbxassetid://15983967420",
            Rt = "rbxassetid://15983966246", Up = "rbxassetid://15983964246"
        },
        ["Stylized"] = {
            Bk = "rbxassetid://18351376859", Dn = "rbxassetid://18351374919",
            Ft = "rbxassetid://18351376800", Lf = "rbxassetid://18351376469",
            Rt = "rbxassetid://18351376457", Up = "rbxassetid://18351377189"
        },
        ["Minecraft"] = {
            Bk = "rbxassetid://8735166756", Dn = "http://www.roblox.com/asset/?id=8735166707",
            Ft = "http://www.roblox.com/asset/?id=8735231668", Lf = "http://www.roblox.com/asset/?id=8735166755",
            Rt = "http://www.roblox.com/asset/?id=8735166751", Up = "http://www.roblox.com/asset/?id=8735166729"
        },
        ["Cloudy Rain"] = {
            Bk = "http://www.roblox.com/asset/?id=4498828382", Dn = "http://www.roblox.com/asset/?id=4498828812",
            Ft = "http://www.roblox.com/asset/?id=4498829917", Lf = "http://www.roblox.com/asset/?id=4498830911",
            Rt = "http://www.roblox.com/asset/?id=4498830417", Up = "http://www.roblox.com/asset/?id=4498831746"
        },
        ["Black Cloudy Rain"] = {
            Bk = "http://www.roblox.com/asset/?id=149679669", Dn = "http://www.roblox.com/asset/?id=149681979",
            Ft = "http://www.roblox.com/asset/?id=149679690", Lf = "http://www.roblox.com/asset/?id=149679709",
            Rt = "http://www.roblox.com/asset/?id=149679722", Up = "http://www.roblox.com/asset/?id=149680199"
        }
    }

    local SkyboxPresets = {}
    for name, assets in pairs(SkyboxAssets) do
        table.insert(SkyboxPresets, {
            Name = name,
            Bk = assets.Bk, Dn = assets.Dn,
            Ft = assets.Ft, Lf = assets.Lf,
            Rt = assets.Rt, Up = assets.Up
        })
    end
    table.sort(SkyboxPresets, function(a, b) return a.Name < b.Name end)

    local SkyScroll = Instance.new("ScrollingFrame")
    SkyScroll.Size = UDim2.new(1, -20, 0, 155)
    SkyScroll.Position = UDim2.new(0, 10, 0, 32)
    SkyScroll.BackgroundTransparency = 1
    SkyScroll.BorderSizePixel = 0
    SkyScroll.ScrollBarThickness = 3
    SkyScroll.ScrollBarImageColor3 = Library.Theme.Accent
    SkyScroll.CanvasSize = UDim2.new(0, 0, 0, math.ceil(#SkyboxPresets / 2) * 28)
    SkyScroll.ZIndex = 23
    SkyScroll.Parent = SkyPresetCard

    local SkyGrid = Instance.new("UIGridLayout")
    SkyGrid.CellSize = UDim2.new(0.48, 0, 0, 24)
    SkyGrid.CellPadding = UDim2.new(0.04, 0, 0, 4)
    SkyGrid.SortOrder = Enum.SortOrder.LayoutOrder
    SkyGrid.Parent = SkyScroll

    for idx, preset in ipairs(SkyboxPresets) do
        local PBtn = Instance.new("TextButton")
        PBtn.Size = UDim2.new(1, 0, 1, 0)
        PBtn.BackgroundColor3 = Library.Theme.Header
        PBtn.BorderSizePixel = 0
        PBtn.Font = Library.Fonts.Badge
        PBtn.Text = preset.Name
        PBtn.TextColor3 = Library.Theme.Accent
        PBtn.TextSize = 9.5
        PBtn.ZIndex = 24
        PBtn.Parent = SkyScroll

        PBtn.MouseButton1Click:Connect(function()
            local skyObj = Lighting:FindFirstChildOfClass("Sky")
            if not skyObj then
                skyObj = Instance.new("Sky")
                skyObj.Name = "NursultanCustomSky"
                skyObj.Parent = Lighting
            end
            skyObj.SkyboxFt = preset.Ft
            skyObj.SkyboxBk = preset.Bk
            skyObj.SkyboxLf = preset.Lf
            skyObj.SkyboxRt = preset.Rt
            skyObj.SkyboxUp = preset.Up
            skyObj.SkyboxDn = preset.Dn
        end)
    end

    local SkyboxCard = Instance.new("Frame")
    SkyboxCard.Size = UDim2.new(1, 0, 0, 255)
    SkyboxCard.Position = UDim2.new(0, 0, 0, 205)
    SkyboxCard.BackgroundColor3 = Library.Theme.Card
    SkyboxCard.BorderSizePixel = 0
    SkyboxCard.ZIndex = 22
    SkyboxCard.Parent = SkyboxPage
    UI.SkyboxCard = SkyboxCard
    addCorner(SkyboxCard, 8)

    local SkyTitle = Instance.new("TextLabel")
    SkyTitle.Size = UDim2.new(1, -20, 0, 20)
    SkyTitle.Position = UDim2.new(0, 10, 0, 8)
    SkyTitle.BackgroundTransparency = 1
    SkyTitle.Font = Library.Fonts.Header
    SkyTitle.Text = "CUSTOM SKYBOX (4-FACE CUBE BOX OR 6-FACE PRO)"
    SkyTitle.TextColor3 = Library.Theme.Accent
    SkyTitle.TextSize = 11
    SkyTitle.TextXAlignment = Enum.TextXAlignment.Left
    SkyTitle.ZIndex = 23
    SkyTitle.Parent = SkyboxCard

    local faces = {
        { Name = "Front Face (Ft)", Key = "SkyboxFt" },
        { Name = "Back Face (Bk)", Key = "SkyboxBk" },
        { Name = "Left Face (Lf)", Key = "SkyboxLf" },
        { Name = "Right Face (Rt)", Key = "SkyboxRt" },
        { Name = "Top Face (Up)", Key = "SkyboxUp" },
        { Name = "Bottom Face (Dn)", Key = "SkyboxDn" }
    }

    local SkyInputs = {}

    for i, faceData in ipairs(faces) do
        local InputRow = Instance.new("Frame")
        InputRow.Size = UDim2.new(1, -20, 0, 26)
        InputRow.Position = UDim2.new(0, 10, 0, 30 + ((i - 1) * 28))
        InputRow.BackgroundTransparency = 1
        InputRow.ZIndex = 23
        InputRow.Parent = SkyboxCard

        local FaceLbl = Instance.new("TextLabel")
        FaceLbl.Size = UDim2.new(0, 130, 1, 0)
        FaceLbl.BackgroundTransparency = 1
        FaceLbl.Font = Library.Fonts.Label
        FaceLbl.Text = faceData.Name
        FaceLbl.TextColor3 = Library.Theme.TextDim
        FaceLbl.TextSize = 10
        FaceLbl.TextXAlignment = Enum.TextXAlignment.Left
        FaceLbl.ZIndex = 23
        FaceLbl.Parent = InputRow

        local BoxBg = Instance.new("Frame")
        BoxBg.Size = UDim2.new(1, -135, 0, 26)
        BoxBg.Position = UDim2.new(0, 135, 0.5, -13)
        BoxBg.BackgroundColor3 = Library.Theme.Header
        BoxBg.BorderSizePixel = 0
        BoxBg.ZIndex = 23
        BoxBg.Parent = InputRow
        addCorner(BoxBg, 5)

        local TxtInput = Instance.new("TextBox")
        TxtInput.Size = UDim2.new(1, -10, 1, 0)
        TxtInput.Position = UDim2.new(0, 5, 0, 0)
        TxtInput.BackgroundTransparency = 1
        TxtInput.Font = Library.Fonts.Badge
        TxtInput.PlaceholderText = "Paste Texture ID..."
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

        SkyInputs[i] = { Input = TxtInput, Key = faceData.Key, BoxBg = BoxBg }
    end

    local ApplySkyboxBtn = Instance.new("TextButton")
    ApplySkyboxBtn.Size = UDim2.new(1, -20, 0, 28)
    ApplySkyboxBtn.Position = UDim2.new(0, 10, 0, 214)
    ApplySkyboxBtn.BackgroundColor3 = Library.Theme.Header
    ApplySkyboxBtn.BorderSizePixel = 0
    ApplySkyboxBtn.Font = Library.Fonts.Header
    ApplySkyboxBtn.Text = "EXECUTE CUSTOM SKYBOX"
    ApplySkyboxBtn.TextColor3 = Library.Theme.Accent
    ApplySkyboxBtn.TextSize = 10
    ApplySkyboxBtn.ZIndex = 23
    ApplySkyboxBtn.Parent = SkyboxCard
    UI.ApplySkyboxBtn = ApplySkyboxBtn
    addCorner(ApplySkyboxBtn, 5)

    ApplySkyboxBtn.MouseButton1Click:Connect(function()
        local skyObj = Lighting:FindFirstChildOfClass("Sky")
        if not skyObj then
            skyObj = Instance.new("Sky")
            skyObj.Name = "NursultanCustomSky"
            skyObj.Parent = Lighting
        end

        local ft = formatAssetId(SkyInputs[1].Input.Text)
        local bk = formatAssetId(SkyInputs[2].Input.Text)
        local lf = formatAssetId(SkyInputs[3].Input.Text)
        local rt = formatAssetId(SkyInputs[4].Input.Text)
        local up = formatAssetId(SkyInputs[5].Input.Text)
        local dn = formatAssetId(SkyInputs[6].Input.Text)

        if ft ~= "" then skyObj.SkyboxFt = ft end
        if bk ~= "" then skyObj.SkyboxBk = bk end
        if lf ~= "" then skyObj.SkyboxLf = lf end
        if rt ~= "" then skyObj.SkyboxRt = rt end

        -- Smart mode switch: Professional 6-Face if Up/Dn entered; 4-Face Cube Box mode if empty!
        if up ~= "" then
            skyObj.SkyboxUp = up
        elseif ft ~= "" then
            skyObj.SkyboxUp = ft
        end

        if dn ~= "" then
            skyObj.SkyboxDn = dn
        elseif bk ~= "" then
            skyObj.SkyboxDn = bk
        elseif ft ~= "" then
            skyObj.SkyboxDn = ft
        end
    end)
end

--- 4. RADIO TAB PAGE (RADIO HUD & PLAYER CUSTOMIZATION)
do
    local RadioCard = Instance.new("Frame")
    RadioCard.Size = UDim2.new(1, 0, 0, 168)
    RadioCard.BackgroundColor3 = Library.Theme.Card
    RadioCard.BorderSizePixel = 0
    RadioCard.ZIndex = 22
    RadioCard.Parent = RadioPage
    UI.RadioCard = RadioCard
    addCorner(RadioCard, 8)

    local RadioCardStroke = Instance.new("UIStroke")
    RadioCardStroke.Color = Library.Theme.Stroke
    RadioCardStroke.Transparency = 0.3
    RadioCardStroke.Thickness = 1.0
    RadioCardStroke.Parent = RadioCard

    local RadioCardTitle = Instance.new("TextLabel")
    RadioCardTitle.Size = UDim2.new(1, -20, 0, 20)
    RadioCardTitle.Position = UDim2.new(0, 10, 0, 8)
    RadioCardTitle.BackgroundTransparency = 1
    RadioCardTitle.Font = Library.Fonts.Header
    RadioCardTitle.Text = "RADIO HUD & PLAYER CUSTOMIZATION"
    RadioCardTitle.TextColor3 = Library.Theme.Accent
    RadioCardTitle.TextSize = 11
    RadioCardTitle.TextXAlignment = Enum.TextXAlignment.Left
    RadioCardTitle.ZIndex = 23
    RadioCardTitle.Parent = RadioCard
    UI.RadioCardTitle = RadioCardTitle

    -- Radio HUD Visibility Toggle
    local RadioVisRow = Instance.new("TextButton")
    RadioVisRow.Size = UDim2.new(1, -20, 0, 32)
    RadioVisRow.Position = UDim2.new(0, 10, 0, 32)
    RadioVisRow.BackgroundColor3 = Library.Theme.Block
    RadioVisRow.BorderSizePixel = 0
    RadioVisRow.AutoButtonColor = false
    RadioVisRow.Text = ""
    RadioVisRow.ZIndex = 23
    RadioVisRow.Parent = RadioCard
    UI.RadioVisRow = RadioVisRow
    addCorner(RadioVisRow, 5)

    local RVLabel = Instance.new("TextLabel")
    RVLabel.Size = UDim2.new(1, -60, 1, 0)
    RVLabel.Position = UDim2.new(0, 10, 0, 0)
    RVLabel.BackgroundTransparency = 1
    RVLabel.Font = Library.Fonts.Label
    RVLabel.Text = "Show Radio Player HUD Overlay"
    RVLabel.TextColor3 = Library.Theme.Text
    RVLabel.TextSize = 10.5
    RVLabel.TextXAlignment = Enum.TextXAlignment.Left
    RVLabel.ZIndex = 24
    RVLabel.Parent = RadioVisRow
    UI.RVLabel = RVLabel

    local RVSwitchBg = Instance.new("Frame")
    RVSwitchBg.Size = UDim2.new(0, 32, 0, 16)
    RVSwitchBg.Position = UDim2.new(1, -40, 0.5, -8)
    RVSwitchBg.BackgroundColor3 = Library.RadioHUDVisible and Library.Theme.Accent or Library.Theme.Header
    RVSwitchBg.BorderSizePixel = 0
    RVSwitchBg.ZIndex = 24
    RVSwitchBg.Parent = RadioVisRow
    UI.RVSwitchBg = RVSwitchBg
    addCorner(RVSwitchBg, 9)

    local RVKnob = Instance.new("Frame")
    RVKnob.Size = UDim2.new(0, 12, 0, 12)
    RVKnob.Position = Library.RadioHUDVisible and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)
    RVKnob.BackgroundColor3 = Library.RadioHUDVisible and Library.Theme.Background or Library.Theme.TextDim
    RVKnob.BorderSizePixel = 0
    RVKnob.ZIndex = 25
    RVKnob.Parent = RVSwitchBg
    UI.RVKnob = RVKnob
    addCorner(RVKnob, 7)

    RadioVisRow.MouseButton1Click:Connect(function()
        Library.RadioHUDVisible = not Library.RadioHUDVisible
        smoothTween(RVSwitchBg, DUR_NORMAL, { BackgroundColor3 = Library.RadioHUDVisible and Library.Theme.Accent or Library.Theme.Header })
        smoothTween(RVKnob, DUR_NORMAL, {
            Position = Library.RadioHUDVisible and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6),
            BackgroundColor3 = Library.RadioHUDVisible and Library.Theme.Background or Library.Theme.TextDim
        })
        updateRadioHUDProperties()
    end)

    -- Radio HUD Transparency Slider (0% to 80%)
    local TransRow = Instance.new("Frame")
    TransRow.Size = UDim2.new(1, -20, 0, 40)
    TransRow.Position = UDim2.new(0, 10, 0, 72)
    TransRow.BackgroundColor3 = Library.Theme.Block
    TransRow.BorderSizePixel = 0
    TransRow.ZIndex = 23
    TransRow.Parent = RadioCard
    UI.TransRow = TransRow
    addCorner(TransRow, 5)

    local TransLbl = Instance.new("TextLabel")
    TransLbl.Size = UDim2.new(0, 100, 0, 18)
    TransLbl.Position = UDim2.new(0, 10, 0, 3)
    TransLbl.BackgroundTransparency = 1
    TransLbl.Font = Library.Fonts.Label
    TransLbl.Text = "HUD Transparency"
    TransLbl.TextColor3 = Library.Theme.TextDim
    TransLbl.TextSize = 10
    TransLbl.TextXAlignment = Enum.TextXAlignment.Left
    TransLbl.ZIndex = 24
    TransLbl.Parent = TransRow
    UI.TransLbl = TransLbl

    local TransBadge = Instance.new("Frame")
    TransBadge.Size = UDim2.new(0, 36, 0, 16)
    TransBadge.Position = UDim2.new(1, -46, 0, 3)
    TransBadge.BackgroundColor3 = Library.Theme.Header
    TransBadge.BorderSizePixel = 0
    TransBadge.ZIndex = 24
    TransBadge.Parent = TransRow
    UI.TransBadge = TransBadge

    local TransValInput = Instance.new("TextBox")
    TransValInput.Size = UDim2.new(1, 0, 1, 0)
    TransValInput.BackgroundTransparency = 1
    TransValInput.Font = Library.Fonts.Badge
    TransValInput.Text = tostring(Library.RadioHUDTransparency)
    TransValInput.TextColor3 = Library.Theme.Accent
    TransValInput.TextSize = 9.5
    TransValInput.ZIndex = 25
    TransValInput.Parent = TransBadge
    UI.TransValInput = TransValInput

    local TransTrackBg = Instance.new("TextButton")
    TransTrackBg.Size = UDim2.new(1, -20, 0, 6)
    TransTrackBg.Position = UDim2.new(0, 10, 0, 26)
    TransTrackBg.BackgroundColor3 = Library.Theme.Header
    TransTrackBg.BorderSizePixel = 0
    TransTrackBg.AutoButtonColor = false
    TransTrackBg.Text = ""
    TransTrackBg.ZIndex = 24
    TransTrackBg.Parent = TransRow
    UI.TransTrackBg = TransTrackBg

    local TransFill = Instance.new("Frame")
    local tRelX = math.clamp(Library.RadioHUDTransparency / 80, 0, 1)
    TransFill.Size = UDim2.new(tRelX, 0, 1, 0)
    TransFill.BackgroundColor3 = Library.Theme.Accent
    TransFill.BorderSizePixel = 0
    TransFill.ZIndex = 25
    TransFill.Parent = TransTrackBg
    UI.TransFill = TransFill

    local TransHandle = Instance.new("Frame")
    TransHandle.Size = UDim2.new(0, 8, 0, 10)
    TransHandle.Position = UDim2.new(tRelX, -4, 0.5, -5)
    TransHandle.BackgroundColor3 = Library.Theme.Accent
    TransHandle.BorderSizePixel = 0
    TransHandle.ZIndex = 26
    TransHandle.Parent = TransTrackBg
    UI.TransHandle = TransHandle

    local isDraggingTrans = false
    local function updateTransPosition(inputX)
        local width = TransTrackBg.AbsoluteSize.X
        if width <= 0 then return end
        local relX = math.clamp((inputX - TransTrackBg.AbsolutePosition.X) / width, 0, 1)
        local val = math.floor(relX * 80 + 0.5)
        Library.RadioHUDTransparency = val
        TransValInput.Text = tostring(val)
        TransFill.Size = UDim2.new(relX, 0, 1, 0)
        TransHandle.Position = UDim2.new(relX, -4, 0.5, -5)
        updateRadioHUDProperties()
    end

    trackConnection(TransTrackBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDraggingTrans = true
            updateTransPosition(input.Position.X)
        end
    end))

    trackConnection(UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDraggingTrans = false
        end
    end))

    trackConnection(UserInputService.InputChanged:Connect(function(input)
        if isDraggingTrans and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateTransPosition(input.Position.X)
        end
    end))

    TransValInput.FocusLost:Connect(function()
        local parsed = tonumber(TransValInput.Text)
        if parsed then
            parsed = math.clamp(math.floor(parsed + 0.5), 0, 80)
            Library.RadioHUDTransparency = parsed
            TransValInput.Text = tostring(parsed)
            local relX = parsed / 80
            TransFill.Size = UDim2.new(relX, 0, 1, 0)
            TransHandle.Position = UDim2.new(relX, -4, 0.5, -5)
            updateRadioHUDProperties()
        else
            TransValInput.Text = tostring(Library.RadioHUDTransparency)
        end
    end)

-- End of Radio Card Settings
end

-- 5. VISUALS TAB PAGE (ADVANCED BLUR & WALLPAPER IMAGE CONTROL)
do
    local BlurCard = Instance.new("Frame")
    BlurCard.Size = UDim2.new(1, 0, 0, 195)
    BlurCard.BackgroundColor3 = Library.Theme.Card
    BlurCard.BorderSizePixel = 0
    BlurCard.ZIndex = 22
    BlurCard.Parent = VisualsPage
    UI.BlurCard = BlurCard

    local BlurCardTitle = Instance.new("TextLabel")
    BlurCardTitle.Size = UDim2.new(1, -20, 0, 18)
    BlurCardTitle.Position = UDim2.new(0, 10, 0, 6)
    BlurCardTitle.BackgroundTransparency = 1
    BlurCardTitle.Font = Library.Fonts.Header
    BlurCardTitle.Text = "BACKGROUND BLUR & WALLPAPER IMAGE"
    BlurCardTitle.TextColor3 = Library.Theme.Accent
    BlurCardTitle.TextSize = 10.5
    BlurCardTitle.TextXAlignment = Enum.TextXAlignment.Left
    BlurCardTitle.ZIndex = 23
    BlurCardTitle.Parent = BlurCard
    UI.BlurCardTitle = BlurCardTitle

    local BlurToggleBlock = Instance.new("TextButton")
    BlurToggleBlock.Size = UDim2.new(1, -20, 0, 26)
    BlurToggleBlock.Position = UDim2.new(0, 10, 0, 26)
    BlurToggleBlock.BackgroundColor3 = Library.Theme.Block
    BlurToggleBlock.BorderSizePixel = 0
    BlurToggleBlock.AutoButtonColor = false
    BlurToggleBlock.Text = ""
    BlurToggleBlock.ZIndex = 23
    BlurToggleBlock.Parent = BlurCard
    UI.BlurToggleBlock = BlurToggleBlock

    local BTLabel = Instance.new("TextLabel")
    BTLabel.Size = UDim2.new(1, -60, 1, 0)
    BTLabel.Position = UDim2.new(0, 8, 0, 0)
    BTLabel.BackgroundTransparency = 1
    BTLabel.Font = Library.Fonts.Label
    BTLabel.Text = "Enable Blur Effect"
    BTLabel.TextColor3 = Library.Theme.Text
    BTLabel.TextSize = 10.5
    BTLabel.TextXAlignment = Enum.TextXAlignment.Left
    BTLabel.ZIndex = 24
    BTLabel.Parent = BlurToggleBlock
    UI.BTLabel = BTLabel

    local BTSwitchBg = Instance.new("Frame")
    BTSwitchBg.Size = UDim2.new(0, 32, 0, 16)
    BTSwitchBg.Position = UDim2.new(1, -40, 0.5, -8)
    BTSwitchBg.BackgroundColor3 = Library.BlurEnabled and Library.Theme.Accent or Library.Theme.Header
    BTSwitchBg.BorderSizePixel = 0
    BTSwitchBg.ZIndex = 24
    BTSwitchBg.Parent = BlurToggleBlock
    UI.BTSwitchBg = BTSwitchBg

    local BTKnob = Instance.new("Frame")
    BTKnob.Size = UDim2.new(0, 12, 0, 12)
    BTKnob.Position = Library.BlurEnabled and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)
    BTKnob.BackgroundColor3 = Library.BlurEnabled and Library.Theme.Background or Library.Theme.TextDim
    BTKnob.BorderSizePixel = 0
    BTKnob.ZIndex = 25
    BTKnob.Parent = BTSwitchBg
    UI.BTKnob = BTKnob

    BlurToggleBlock.MouseButton1Click:Connect(function()
        Library.BlurEnabled = not Library.BlurEnabled
        smoothTween(BTSwitchBg, DUR_NORMAL, { BackgroundColor3 = Library.BlurEnabled and Library.Theme.Accent or Library.Theme.Header })
        smoothTween(BTKnob, DUR_NORMAL, {
            Position = Library.BlurEnabled and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6),
            BackgroundColor3 = Library.BlurEnabled and Library.Theme.Background or Library.Theme.TextDim
        })
        MenuBlur.Enabled = Library.BlurEnabled and Library.Enabled
    end)

    -- Blur Size Slider (0 - 50)
    local BlurSizeRow = Instance.new("Frame")
    BlurSizeRow.Size = UDim2.new(1, -20, 0, 26)
    BlurSizeRow.Position = UDim2.new(0, 10, 0, 54)
    BlurSizeRow.BackgroundTransparency = 1
    BlurSizeRow.ZIndex = 23
    BlurSizeRow.Parent = BlurCard

    local BlurSizeLbl = Instance.new("TextLabel")
    BlurSizeLbl.Size = UDim2.new(0, 70, 1, 0)
    BlurSizeLbl.BackgroundTransparency = 1
    BlurSizeLbl.Font = Library.Fonts.Label
    BlurSizeLbl.Text = "Blur Size:"
    BlurSizeLbl.TextColor3 = Library.Theme.TextDim
    BlurSizeLbl.TextSize = 10
    BlurSizeLbl.TextXAlignment = Enum.TextXAlignment.Left
    BlurSizeLbl.ZIndex = 24
    BlurSizeLbl.Parent = BlurSizeRow
    UI.BlurSizeLbl = BlurSizeLbl

    local BlurValInput = Instance.new("TextBox")
    BlurValInput.Size = UDim2.new(0, 36, 0, 18)
    BlurValInput.Position = UDim2.new(1, -38, 0.5, -9)
    BlurValInput.BackgroundColor3 = Library.Theme.Header
    BlurValInput.BorderSizePixel = 0
    BlurValInput.Font = Library.Fonts.Badge
    BlurValInput.Text = tostring(Library.BlurSize)
    BlurValInput.TextColor3 = Library.Theme.Accent
    BlurValInput.TextSize = 9.5
    BlurValInput.ZIndex = 24
    BlurValInput.Parent = BlurSizeRow
    UI.BlurValInput = BlurValInput

    local BlurTrackBg = Instance.new("TextButton")
    BlurTrackBg.Size = UDim2.new(1, -125, 0, 6)
    BlurTrackBg.Position = UDim2.new(0, 72, 0.5, -3)
    BlurTrackBg.BackgroundColor3 = Library.Theme.Header
    BlurTrackBg.BorderSizePixel = 0
    BlurTrackBg.AutoButtonColor = false
    BlurTrackBg.Text = ""
    BlurTrackBg.ZIndex = 24
    BlurTrackBg.Parent = BlurSizeRow
    UI.BlurTrackBg = BlurTrackBg

    local BlurFill = Instance.new("Frame")
    local blurRelX = math.clamp(Library.BlurSize / 50, 0, 1)
    BlurFill.Size = UDim2.new(blurRelX, 0, 1, 0)
    BlurFill.BackgroundColor3 = Library.Theme.Accent
    BlurFill.BorderSizePixel = 0
    BlurFill.ZIndex = 25
    BlurFill.Parent = BlurTrackBg
    UI.BlurFill = BlurFill

    local isDraggingBlur = false
    local function updateBlurPosition(inputX)
        local width = BlurTrackBg.AbsoluteSize.X
        if width <= 0 then return end
        local relX = math.clamp((inputX - BlurTrackBg.AbsolutePosition.X) / width, 0, 1)
        local val = math.floor(relX * 50 + 0.5)
        Library.BlurSize = val
        BlurValInput.Text = tostring(val)
        BlurFill.Size = UDim2.new(relX, 0, 1, 0)
        MenuBlur.Size = val
    end

    trackConnection(BlurTrackBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDraggingBlur = true
            updateBlurPosition(input.Position.X)
        end
    end))

    trackConnection(UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDraggingBlur = false
        end
    end))

    trackConnection(UserInputService.InputChanged:Connect(function(input)
        if isDraggingBlur and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateBlurPosition(input.Position.X)
        end
    end))

    BlurValInput.FocusLost:Connect(function()
        local parsed = tonumber(BlurValInput.Text)
        if parsed then
            parsed = math.clamp(math.floor(parsed + 0.5), 0, 50)
            Library.BlurSize = parsed
            BlurValInput.Text = tostring(parsed)
            BlurFill.Size = UDim2.new(parsed / 50, 0, 1, 0)
            MenuBlur.Size = parsed
        else
            BlurValInput.Text = tostring(Library.BlurSize)
        end
    end)

    -- Wallpaper Background Texture ID Input + Apply Button
    local WallpaperBg = Instance.new("Frame")
    WallpaperBg.Size = UDim2.new(1, -20, 0, 26)
    WallpaperBg.Position = UDim2.new(0, 10, 0, 86)
    WallpaperBg.BackgroundColor3 = Library.Theme.Header
    WallpaperBg.BorderSizePixel = 0
    WallpaperBg.ZIndex = 23
    WallpaperBg.Parent = BlurCard
    UI.WallpaperBg = WallpaperBg

    local WallpaperInput = Instance.new("TextBox")
    WallpaperInput.Size = UDim2.new(1, -10, 1, 0)
    WallpaperInput.Position = UDim2.new(0, 5, 0, 0)
    WallpaperInput.BackgroundTransparency = 1
    WallpaperInput.Font = Library.Fonts.Badge
    WallpaperInput.PlaceholderText = "Paste Wallpaper Image Texture ID..."
    WallpaperInput.PlaceholderColor3 = Library.Theme.TextDim
    WallpaperInput.Text = Library.MenuBgImage
    WallpaperInput.TextColor3 = Library.Theme.Accent
    WallpaperInput.TextSize = 9.5
    WallpaperInput.TextXAlignment = Enum.TextXAlignment.Left
    WallpaperInput.Active = true
    WallpaperInput.Selectable = true
    WallpaperInput.ClearTextOnFocus = false
    WallpaperInput.ZIndex = 24
    WallpaperInput.Parent = WallpaperBg
    UI.WallpaperInput = WallpaperInput

    local ApplyWallpaperBtn = Instance.new("TextButton")
    ApplyWallpaperBtn.Size = UDim2.new(1, -20, 0, 26)
    ApplyWallpaperBtn.Position = UDim2.new(0, 10, 0, 118)
    ApplyWallpaperBtn.BackgroundColor3 = Library.Theme.Header
    ApplyWallpaperBtn.BorderSizePixel = 0
    ApplyWallpaperBtn.Font = Library.Fonts.Header
    ApplyWallpaperBtn.Text = "APPLY BACKGROUND WALLPAPER"
    ApplyWallpaperBtn.TextColor3 = Library.Theme.Accent
    ApplyWallpaperBtn.TextSize = 9.5
    ApplyWallpaperBtn.ZIndex = 23
    ApplyWallpaperBtn.Parent = BlurCard
    UI.ApplyWallpaperBtn = ApplyWallpaperBtn

    ApplyWallpaperBtn.MouseButton1Click:Connect(function()
        Library.MenuBgImage = WallpaperInput.Text
        updateMenuBgImage()
    end)

    -- Wallpaper Transparency Slider (0% - 90%)
    local WallTransRow = Instance.new("Frame")
    WallTransRow.Size = UDim2.new(1, -20, 0, 26)
    WallTransRow.Position = UDim2.new(0, 10, 0, 154)
    WallTransRow.BackgroundTransparency = 1
    WallTransRow.ZIndex = 23
    WallTransRow.Parent = BlurCard

    local WallTransLbl = Instance.new("TextLabel")
    WallTransLbl.Size = UDim2.new(0, 85, 1, 0)
    WallTransLbl.BackgroundTransparency = 1
    WallTransLbl.Font = Library.Fonts.Label
    WallTransLbl.Text = "Wallpaper Trans (%):"
    WallTransLbl.TextColor3 = Library.Theme.TextDim
    WallTransLbl.TextSize = 9.5
    WallTransLbl.TextXAlignment = Enum.TextXAlignment.Left
    WallTransLbl.ZIndex = 24
    WallTransLbl.Parent = WallTransRow
    UI.WallTransLbl = WallTransLbl

    local WallTransInput = Instance.new("TextBox")
    WallTransInput.Size = UDim2.new(0, 36, 0, 18)
    WallTransInput.Position = UDim2.new(1, -38, 0.5, -9)
    WallTransInput.BackgroundColor3 = Library.Theme.Header
    WallTransInput.BorderSizePixel = 0
    WallTransInput.Font = Library.Fonts.Badge
    WallTransInput.Text = tostring(Library.MenuBgTransparency)
    WallTransInput.TextColor3 = Library.Theme.Accent
    WallTransInput.TextSize = 9.5
    WallTransInput.ZIndex = 24
    WallTransInput.Parent = WallTransRow
    UI.WallTransInput = WallTransInput

    local WallTransTrackBg = Instance.new("TextButton")
    WallTransTrackBg.Size = UDim2.new(1, -140, 0, 6)
    WallTransTrackBg.Position = UDim2.new(0, 90, 0.5, -3)
    WallTransTrackBg.BackgroundColor3 = Library.Theme.Header
    WallTransTrackBg.BorderSizePixel = 0
    WallTransTrackBg.AutoButtonColor = false
    WallTransTrackBg.Text = ""
    WallTransTrackBg.ZIndex = 24
    WallTransTrackBg.Parent = WallTransRow
    UI.WallTransTrackBg = WallTransTrackBg

    local WallTransFill = Instance.new("Frame")
    local wallTransRelX = math.clamp(Library.MenuBgTransparency / 90, 0, 1)
    WallTransFill.Size = UDim2.new(wallTransRelX, 0, 1, 0)
    WallTransFill.BackgroundColor3 = Library.Theme.Accent
    WallTransFill.BorderSizePixel = 0
    WallTransFill.ZIndex = 25
    WallTransFill.Parent = WallTransTrackBg
    UI.WallTransFill = WallTransFill

    local isDraggingWallTrans = false
    local function updateWallTransPosition(inputX)
        local width = WallTransTrackBg.AbsoluteSize.X
        if width <= 0 then return end
        local relX = math.clamp((inputX - WallTransTrackBg.AbsolutePosition.X) / width, 0, 1)
        local val = math.floor(relX * 90 + 0.5)
        Library.MenuBgTransparency = val
        WallTransInput.Text = tostring(val)
        WallTransFill.Size = UDim2.new(relX, 0, 1, 0)
        updateMenuBgImage()
    end

    trackConnection(WallTransTrackBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDraggingWallTrans = true
            updateWallTransPosition(input.Position.X)
        end
    end))

    trackConnection(UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDraggingWallTrans = false
        end
    end))

    trackConnection(UserInputService.InputChanged:Connect(function(input)
        if isDraggingWallTrans and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateWallTransPosition(input.Position.X)
        end
    end))

    WallTransInput.FocusLost:Connect(function()
        local parsed = tonumber(WallTransInput.Text)
        if parsed then
            parsed = math.clamp(math.floor(parsed + 0.5), 0, 90)
            Library.MenuBgTransparency = parsed
            WallTransInput.Text = tostring(parsed)
            WallTransFill.Size = UDim2.new(parsed / 90, 0, 1, 0)
            updateMenuBgImage()
        else
            WallTransInput.Text = tostring(Library.MenuBgTransparency)
        end
    end)
end

-- Card 2: Falling Particles & Custom Texture Manager
do
    local ParticleCard = Instance.new("Frame")
    ParticleCard.Size = UDim2.new(1, 0, 0, 248)
    ParticleCard.BackgroundColor3 = Library.Theme.Card
    ParticleCard.BorderSizePixel = 0
    ParticleCard.ZIndex = 22
    ParticleCard.Parent = VisualsPage
    UI.ParticleCard = ParticleCard

local ParticleCardTitle = Instance.new("TextLabel")
ParticleCardTitle.Size = UDim2.new(1, -20, 0, 18)
ParticleCardTitle.Position = UDim2.new(0, 10, 0, 6)
ParticleCardTitle.BackgroundTransparency = 1
ParticleCardTitle.Font = Library.Fonts.Header
ParticleCardTitle.Text = "FALLING PARTICLES & CUSTOM TEXTURE"
ParticleCardTitle.TextColor3 = Library.Theme.Accent
ParticleCardTitle.TextSize = 10.5
ParticleCardTitle.TextXAlignment = Enum.TextXAlignment.Left
ParticleCardTitle.ZIndex = 23
ParticleCardTitle.Parent = ParticleCard

-- Particle Enable Toggle
local SnowToggleBlock = Instance.new("TextButton")
SnowToggleBlock.Size = UDim2.new(1, -20, 0, 26)
SnowToggleBlock.Position = UDim2.new(0, 10, 0, 26)
SnowToggleBlock.BackgroundColor3 = Library.Theme.Block
SnowToggleBlock.BorderSizePixel = 0
SnowToggleBlock.AutoButtonColor = false
SnowToggleBlock.Text = ""
SnowToggleBlock.ZIndex = 23
SnowToggleBlock.Parent = ParticleCard

local STLabel = Instance.new("TextLabel")
STLabel.Size = UDim2.new(1, -60, 1, 0)
STLabel.Position = UDim2.new(0, 8, 0, 0)
STLabel.BackgroundTransparency = 1
STLabel.Font = Library.Fonts.Label
STLabel.Text = "Enable Falling Particles"
STLabel.TextColor3 = Library.Theme.Text
STLabel.TextSize = 10.5
STLabel.TextXAlignment = Enum.TextXAlignment.Left
STLabel.ZIndex = 24
STLabel.Parent = SnowToggleBlock

local STSwitchBg = Instance.new("Frame")
STSwitchBg.Size = UDim2.new(0, 32, 0, 16)
STSwitchBg.Position = UDim2.new(1, -40, 0.5, -8)
STSwitchBg.BackgroundColor3 = Library.SnowEnabled and Library.Theme.Accent or Library.Theme.Header
STSwitchBg.BorderSizePixel = 0
STSwitchBg.ZIndex = 24
STSwitchBg.Parent = SnowToggleBlock

local STKnob = Instance.new("Frame")
STKnob.Size = UDim2.new(0, 12, 0, 12)
STKnob.Position = Library.SnowEnabled and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)
STKnob.BackgroundColor3 = Library.SnowEnabled and Library.Theme.Background or Library.Theme.TextDim
STKnob.BorderSizePixel = 0
STKnob.ZIndex = 25
STKnob.Parent = STSwitchBg

SnowToggleBlock.MouseButton1Click:Connect(function()
    Library.SnowEnabled = not Library.SnowEnabled
    smoothTween(STSwitchBg, DUR_NORMAL, { BackgroundColor3 = Library.SnowEnabled and Library.Theme.Accent or Library.Theme.Header })
    smoothTween(STKnob, DUR_NORMAL, {
        Position = Library.SnowEnabled and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6),
        BackgroundColor3 = Library.SnowEnabled and Library.Theme.Background or Library.Theme.TextDim
    })
    SnowFolder.Visible = Library.SnowEnabled and Library.Enabled
end)

-- Particle Count Slider (10 - 150)
local CountRow = Instance.new("Frame")
CountRow.Size = UDim2.new(1, -20, 0, 26)
CountRow.Position = UDim2.new(0, 10, 0, 56)
CountRow.BackgroundTransparency = 1
CountRow.ZIndex = 23
CountRow.Parent = ParticleCard

local CountLbl = Instance.new("TextLabel")
CountLbl.Size = UDim2.new(0, 70, 1, 0)
CountLbl.BackgroundTransparency = 1
CountLbl.Font = Library.Fonts.Label
CountLbl.Text = "Amount:"
CountLbl.TextColor3 = Library.Theme.TextDim
CountLbl.TextSize = 10
CountLbl.TextXAlignment = Enum.TextXAlignment.Left
CountLbl.ZIndex = 24
CountLbl.Parent = CountRow

local CountInput = Instance.new("TextBox")
CountInput.Size = UDim2.new(0, 36, 0, 18)
CountInput.Position = UDim2.new(1, -38, 0.5, -9)
CountInput.BackgroundColor3 = Library.Theme.Header
CountInput.BorderSizePixel = 0
CountInput.Font = Library.Fonts.Badge
CountInput.Text = tostring(Library.ParticleCount)
CountInput.TextColor3 = Library.Theme.Accent
CountInput.TextSize = 9.5
CountInput.ZIndex = 24
CountInput.Parent = CountRow

local CountTrackBg = Instance.new("TextButton")
CountTrackBg.Size = UDim2.new(1, -125, 0, 6)
CountTrackBg.Position = UDim2.new(0, 72, 0.5, -3)
CountTrackBg.BackgroundColor3 = Library.Theme.Header
CountTrackBg.BorderSizePixel = 0
CountTrackBg.AutoButtonColor = false
CountTrackBg.Text = ""
CountTrackBg.ZIndex = 24
CountTrackBg.Parent = CountRow

local CountFill = Instance.new("Frame")
local countRelX = math.clamp((Library.ParticleCount - 10) / (150 - 10), 0, 1)
CountFill.Size = UDim2.new(countRelX, 0, 1, 0)
CountFill.BackgroundColor3 = Library.Theme.Accent
CountFill.BorderSizePixel = 0
CountFill.ZIndex = 25
CountFill.Parent = CountTrackBg

local isDraggingCount = false
local function updateCountPosition(inputX)
    local width = CountTrackBg.AbsoluteSize.X
    if width <= 0 then return end
    local relX = math.clamp((inputX - CountTrackBg.AbsolutePosition.X) / width, 0, 1)
    local val = math.floor(10 + (150 - 10) * relX + 0.5)
    Library.ParticleCount = val
    CountInput.Text = tostring(val)
    CountFill.Size = UDim2.new(relX, 0, 1, 0)
    rebuildParticles()
end

trackConnection(CountTrackBg.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDraggingCount = true
        updateCountPosition(input.Position.X)
    end
end))

trackConnection(UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDraggingCount = false
    end
end))

trackConnection(UserInputService.InputChanged:Connect(function(input)
    if isDraggingCount and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        updateCountPosition(input.Position.X)
    end
end))

CountInput.FocusLost:Connect(function()
    local parsed = tonumber(CountInput.Text)
    if parsed then
        parsed = math.clamp(math.floor(parsed + 0.5), 10, 150)
        Library.ParticleCount = parsed
        CountInput.Text = tostring(parsed)
        CountFill.Size = UDim2.new((parsed - 10) / (150 - 10), 0, 1, 0)
        rebuildParticles()
    else
        CountInput.Text = tostring(Library.ParticleCount)
    end
end)

-- Fall Speed Slider (0.2x - 3.0x)
local SpeedPartRow = Instance.new("Frame")
SpeedPartRow.Size = UDim2.new(1, -20, 0, 26)
SpeedPartRow.Position = UDim2.new(0, 10, 0, 86)
SpeedPartRow.BackgroundTransparency = 1
SpeedPartRow.ZIndex = 23
SpeedPartRow.Parent = ParticleCard

local SpdPartLbl = Instance.new("TextLabel")
SpdPartLbl.Size = UDim2.new(0, 70, 1, 0)
SpdPartLbl.BackgroundTransparency = 1
SpdPartLbl.Font = Library.Fonts.Label
SpdPartLbl.Text = "Speed:"
SpdPartLbl.TextColor3 = Library.Theme.TextDim
SpdPartLbl.TextSize = 10
SpdPartLbl.TextXAlignment = Enum.TextXAlignment.Left
SpdPartLbl.ZIndex = 24
SpdPartLbl.Parent = SpeedPartRow

local SpdPartInput = Instance.new("TextBox")
SpdPartInput.Size = UDim2.new(0, 36, 0, 18)
SpdPartInput.Position = UDim2.new(1, -38, 0.5, -9)
SpdPartInput.BackgroundColor3 = Library.Theme.Header
SpdPartInput.BorderSizePixel = 0
SpdPartInput.Font = Library.Fonts.Badge
SpdPartInput.Text = string.format("%.1fx", Library.ParticleSpeed)
SpdPartInput.TextColor3 = Library.Theme.Accent
SpdPartInput.TextSize = 9.5
SpdPartInput.ZIndex = 24
SpdPartInput.Parent = SpeedPartRow

local SpdPartTrackBg = Instance.new("TextButton")
SpdPartTrackBg.Size = UDim2.new(1, -125, 0, 6)
SpdPartTrackBg.Position = UDim2.new(0, 72, 0.5, -3)
SpdPartTrackBg.BackgroundColor3 = Library.Theme.Header
SpdPartTrackBg.BorderSizePixel = 0
SpdPartTrackBg.AutoButtonColor = false
SpdPartTrackBg.Text = ""
SpdPartTrackBg.ZIndex = 24
SpdPartTrackBg.Parent = SpeedPartRow

local SpdPartFill = Instance.new("Frame")
local spdRelX = math.clamp((Library.ParticleSpeed - 0.2) / (3.0 - 0.2), 0, 1)
SpdPartFill.Size = UDim2.new(spdRelX, 0, 1, 0)
SpdPartFill.BackgroundColor3 = Library.Theme.Accent
SpdPartFill.BorderSizePixel = 0
SpdPartFill.ZIndex = 25
SpdPartFill.Parent = SpdPartTrackBg

local isDraggingSpdPart = false
local function updateSpdPartPosition(inputX)
    local width = SpdPartTrackBg.AbsoluteSize.X
    if width <= 0 then return end
    local relX = math.clamp((inputX - SpdPartTrackBg.AbsolutePosition.X) / width, 0, 1)
    local val = math.floor((0.2 + (3.0 - 0.2) * relX) * 10 + 0.5) / 10
    Library.ParticleSpeed = val
    SpdPartInput.Text = string.format("%.1fx", val)
    SpdPartFill.Size = UDim2.new(relX, 0, 1, 0)
end

trackConnection(SpdPartTrackBg.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDraggingSpdPart = true
        updateSpdPartPosition(input.Position.X)
    end
end))

trackConnection(UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDraggingSpdPart = false
    end
end))

trackConnection(UserInputService.InputChanged:Connect(function(input)
    if isDraggingSpdPart and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        updateSpdPartPosition(input.Position.X)
    end
end))

SpdPartInput.FocusLost:Connect(function()
    local parsed = tonumber(SpdPartInput.Text:gsub("[^%d%.]", ""))
    if parsed then
        parsed = math.clamp(math.floor(parsed * 10 + 0.5) / 10, 0.2, 3.0)
        Library.ParticleSpeed = parsed
        SpdPartInput.Text = string.format("%.1fx", parsed)
        SpdPartFill.Size = UDim2.new((parsed - 0.2) / (3.0 - 0.2), 0, 1, 0)
    else
        SpdPartInput.Text = string.format("%.1fx", Library.ParticleSpeed)
    end
end)

-- Particle Size Slider (2 - 16 px)
local PSizeRow = Instance.new("Frame")
PSizeRow.Size = UDim2.new(1, -20, 0, 26)
PSizeRow.Position = UDim2.new(0, 10, 0, 116)
PSizeRow.BackgroundTransparency = 1
PSizeRow.ZIndex = 23
PSizeRow.Parent = ParticleCard

local PSizeLbl = Instance.new("TextLabel")
PSizeLbl.Size = UDim2.new(0, 70, 1, 0)
PSizeLbl.BackgroundTransparency = 1
PSizeLbl.Font = Library.Fonts.Label
PSizeLbl.Text = "Size (px):"
PSizeLbl.TextColor3 = Library.Theme.TextDim
PSizeLbl.TextSize = 10
PSizeLbl.TextXAlignment = Enum.TextXAlignment.Left
PSizeLbl.ZIndex = 24
PSizeLbl.Parent = PSizeRow

local PSizeInput = Instance.new("TextBox")
PSizeInput.Size = UDim2.new(0, 36, 0, 18)
PSizeInput.Position = UDim2.new(1, -38, 0.5, -9)
PSizeInput.BackgroundColor3 = Library.Theme.Header
PSizeInput.BorderSizePixel = 0
PSizeInput.Font = Library.Fonts.Badge
PSizeInput.Text = tostring(Library.ParticleSize)
PSizeInput.TextColor3 = Library.Theme.Accent
PSizeInput.TextSize = 9.5
PSizeInput.ZIndex = 24
PSizeInput.Parent = PSizeRow

local PSizeTrackBg = Instance.new("TextButton")
PSizeTrackBg.Size = UDim2.new(1, -125, 0, 6)
PSizeTrackBg.Position = UDim2.new(0, 72, 0.5, -3)
PSizeTrackBg.BackgroundColor3 = Library.Theme.Header
PSizeTrackBg.BorderSizePixel = 0
PSizeTrackBg.AutoButtonColor = false
PSizeTrackBg.Text = ""
PSizeTrackBg.ZIndex = 24
PSizeTrackBg.Parent = PSizeRow

local PSizeFill = Instance.new("Frame")
local pSizeRelX = math.clamp((Library.ParticleSize - 2) / (16 - 2), 0, 1)
PSizeFill.Size = UDim2.new(pSizeRelX, 0, 1, 0)
PSizeFill.BackgroundColor3 = Library.Theme.Accent
PSizeFill.BorderSizePixel = 0
PSizeFill.ZIndex = 25
PSizeFill.Parent = PSizeTrackBg

local isDraggingPSize = false
local function updatePSizePosition(inputX)
    local width = PSizeTrackBg.AbsoluteSize.X
    if width <= 0 then return end
    local relX = math.clamp((inputX - PSizeTrackBg.AbsolutePosition.X) / width, 0, 1)
    local val = math.floor(2 + (16 - 2) * relX + 0.5)
    Library.ParticleSize = val
    PSizeInput.Text = tostring(val)
    PSizeFill.Size = UDim2.new(relX, 0, 1, 0)
    for _, f in ipairs(Flakes) do
        if f.Instance then f.Instance.Size = UDim2.new(0, val, 0, val) end
    end
end

trackConnection(PSizeTrackBg.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDraggingPSize = true
        updatePSizePosition(input.Position.X)
    end
end))

trackConnection(UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDraggingPSize = false
    end
end))

trackConnection(UserInputService.InputChanged:Connect(function(input)
    if isDraggingPSize and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        updatePSizePosition(input.Position.X)
    end
end))

PSizeInput.FocusLost:Connect(function()
    local parsed = tonumber(PSizeInput.Text)
    if parsed then
        parsed = math.clamp(math.floor(parsed + 0.5), 2, 16)
        Library.ParticleSize = parsed
        PSizeInput.Text = tostring(parsed)
        PSizeFill.Size = UDim2.new((parsed - 2) / (16 - 2), 0, 1, 0)
        for _, f in ipairs(Flakes) do
            if f.Instance then f.Instance.Size = UDim2.new(0, parsed, 0, parsed) end
        end
    else
        PSizeInput.Text = tostring(Library.ParticleSize)
    end
end)

-- Custom Particle Texture ID Input + Apply Button
local PartTexBg = Instance.new("Frame")
PartTexBg.Size = UDim2.new(1, -20, 0, 26)
PartTexBg.Position = UDim2.new(0, 10, 0, 146)
PartTexBg.BackgroundColor3 = Library.Theme.Header
PartTexBg.BorderSizePixel = 0
PartTexBg.ZIndex = 23
PartTexBg.Parent = ParticleCard

local PartTexInput = Instance.new("TextBox")
PartTexInput.Size = UDim2.new(1, -10, 1, 0)
PartTexInput.Position = UDim2.new(0, 5, 0, 0)
PartTexInput.BackgroundTransparency = 1
PartTexInput.Font = Library.Fonts.Badge
PartTexInput.PlaceholderText = "Paste Particle Texture ID (e.g. Snowflake/Heart)..."
PartTexInput.PlaceholderColor3 = Library.Theme.TextDim
PartTexInput.Text = Library.ParticleTexture
PartTexInput.TextColor3 = Library.Theme.Accent
PartTexInput.TextSize = 9.5
PartTexInput.TextXAlignment = Enum.TextXAlignment.Left
PartTexInput.Active = true
PartTexInput.Selectable = true
PartTexInput.ClearTextOnFocus = false
PartTexInput.ZIndex = 24
PartTexInput.Parent = PartTexBg

local ApplyPartTexBtn = Instance.new("TextButton")
ApplyPartTexBtn.Size = UDim2.new(1, -20, 0, 26)
ApplyPartTexBtn.Position = UDim2.new(0, 10, 0, 178)
ApplyPartTexBtn.BackgroundColor3 = Library.Theme.Header
ApplyPartTexBtn.BorderSizePixel = 0
ApplyPartTexBtn.Font = Library.Fonts.Header
ApplyPartTexBtn.Text = "APPLY CUSTOM PARTICLE TEXTURE"
ApplyPartTexBtn.TextColor3 = Library.Theme.Accent
ApplyPartTexBtn.TextSize = 9.5
ApplyPartTexBtn.ZIndex = 23
ApplyPartTexBtn.Parent = ParticleCard

ApplyPartTexBtn.MouseButton1Click:Connect(function()
    Library.ParticleTexture = PartTexInput.Text
    rebuildParticles()
end)

-- Ready-To-Use Quick Particle Presets (Sakura, Snowflake, Star, Square)
local PartPresetRow = Instance.new("Frame")
PartPresetRow.Size = UDim2.new(1, -20, 0, 24)
PartPresetRow.Position = UDim2.new(0, 10, 0, 210)
PartPresetRow.BackgroundTransparency = 1
PartPresetRow.ZIndex = 23
PartPresetRow.Parent = ParticleCard

local partPresets = {
    { Name = "Sakura", Tex = "rbxassetid://132601789498621" },
    { Name = "Snowflake", Tex = "rbxassetid://16471396163" },
    { Name = "Stars", Tex = "rbxassetid://112882057182762" },
    { Name = "Square", Tex = "" }
}

for idx, pTexData in ipairs(partPresets) do
    local PTexBtn = Instance.new("TextButton")
    PTexBtn.Size = UDim2.new(0.23, 0, 1, 0)
    PTexBtn.Position = UDim2.new((idx - 1) * 0.25, 0, 0, 0)
    PTexBtn.BackgroundColor3 = Library.Theme.Header
    PTexBtn.BorderSizePixel = 0
    PTexBtn.Font = Library.Fonts.Badge
    PTexBtn.Text = pTexData.Name
    PTexBtn.TextColor3 = Library.Theme.Accent
PTexBtn.TextSize = 9
    PTexBtn.ZIndex = 24
    PTexBtn.Parent = PartPresetRow

    PTexBtn.MouseButton1Click:Connect(function()
        PartTexInput.Text = pTexData.Tex
        Library.ParticleTexture = pTexData.Tex
        rebuildParticles()
    end)
end

ApplyPartTexBtn.MouseButton1Click:Connect(function()
    local formatted = formatAssetId(PartTexInput.Text)
    Library.ParticleTexture = formatted
    rebuildParticles()
end)
end



local function toggleSettingsModal(visible)
    if visible == nil then visible = not SettingsModal.Visible end
    if visible then
        ModalBackdrop.Visible = true
        SettingsModal.Visible = true
        SettingsModal.Position = UDim2.new(0.5, -260, 0.5, -190)
        SettingsModal.Size = UDim2.new(0, 520, 0, 420)
        smoothTween(ModalBackdrop, DUR_MODAL, { BackgroundTransparency = 0.45 }, EASE_SMOOTH, DIR_OUT)
        smoothTween(SettingsModal, DUR_MODAL, { Position = UDim2.new(0.5, -260, 0.5, -210) }, EASE_SPRING, DIR_OUT)
    else
        ConfigDropList.Visible = false
        configDropOpen = false
        smoothTween(ModalBackdrop, DUR_MODAL, { BackgroundTransparency = 1 }, EASE_SMOOTH, DIR_IN)
        local anim = smoothTween(SettingsModal, DUR_MODAL, { Position = UDim2.new(0.5, -260, 0.5, -170) }, EASE_SMOOTH, DIR_IN)
        anim.Completed:Connect(function()
            if not visible then
                SettingsModal.Visible = false
                ModalBackdrop.Visible = false
            end
        end)
    end
end

-- Modal Settings can ONLY be closed by clicking the CloseModalBtn (X) or GearIcon toggle
CloseModalBtn.MouseButton1Click:Connect(function()
    toggleSettingsModal(false)
end)

GearIcon.MouseButton1Click:Connect(function()
    smoothTween(GearIcon, DUR_MODAL, { Rotation = 180 }, EASE_SPRING, DIR_OUT)
    toggleSettingsModal()
end)

function Library:SetTheme(themeName)
    local t = Library.Themes[themeName]
    if not t then return end
    Library.Theme = t
    Library.CurrentThemeName = themeName

    local function st(elem, props)
        if elem then smoothTween(elem, DUR_NORMAL, props) end
    end

    st(UI.Watermark, { BackgroundColor3 = t.Block })
    st(UI.WMarkStroke, { Color = t.StrokeActive })
    st(UI.WMarkIcon, { ImageColor3 = t.Accent })
    st(UI.WMarkTitle, { TextColor3 = t.Accent })
    st(UI.PlayerNameLabel, { TextColor3 = t.Text })
    st(UI.WMarkFpsLabel, { TextColor3 = t.Accent })
    st(UI.WMarkPingLabel, { TextColor3 = t.Accent })
    st(UI.WMarkTimeLabel, { TextColor3 = t.Text })

    st(UI.GearBtnFrame, { BackgroundColor3 = t.Block })
    st(UI.GearStroke, { Color = t.Accent })
    st(UI.GearIcon, { ImageColor3 = t.Accent })

    st(UI.KeybindHUDFrame, { BackgroundColor3 = t.Block })
    st(UI.KeybindHUDHeader, { BackgroundColor3 = t.Header })
    st(UI.KeybindHUDStroke, { Color = t.Stroke })
    st(UI.HUDDot, { BackgroundColor3 = t.Accent })
    st(UI.HUDIcon, { ImageColor3 = t.Accent })
    st(UI.HUDTitle, { TextColor3 = t.Text })
    st(UI.HUDCountLabel, { TextColor3 = t.Accent })

    st(UI.RadioHUDFrame, { BackgroundColor3 = t.Block })
    st(UI.RadioHeader, { BackgroundColor3 = t.Header })
    st(UI.RadioHUDStroke, { Color = t.Stroke })
    st(UI.RHTitle, { TextColor3 = t.Text })
    st(UI.MusicIcon, { ImageColor3 = t.Accent })
    st(UI.HUDPlayBtn, { BackgroundColor3 = t.Card, TextColor3 = t.Accent })
    st(UI.HUDSoundInputBg, { BackgroundColor3 = t.Header })
    st(UI.HUDSoundInput, { TextColor3 = t.Accent })
    st(UI.SeekTimeLabel, { TextColor3 = t.Accent })
    st(UI.SeekTrackBg, { BackgroundColor3 = t.Header })
    st(UI.SeekFill, { BackgroundColor3 = t.Accent })
    st(UI.SeekHandle, { BackgroundColor3 = t.Accent })

    st(UI.SettingsModal, { BackgroundColor3 = t.Block })
    st(UI.ModalHeader, { BackgroundColor3 = t.Header })
    st(UI.ModalSidebar, { BackgroundColor3 = t.Header })
    st(UI.ModalLogoIcon, { ImageColor3 = t.Accent })
    st(UI.ModalTitle, { TextColor3 = t.Text })
    st(UI.ModalStroke, { Color = t.StrokeActive })

    for name, data in pairs(ModalTabs) do
        local isSel = data.Page.Visible
        st(data.Btn, {
            BackgroundColor3 = isSel and t.Block or t.Card,
            TextColor3 = isSel and t.Accent or t.TextDim
        })
        st(data.Indicator, { BackgroundColor3 = t.Accent })
    end

    st(UI.ConfigCard, { BackgroundColor3 = t.Card })
    st(UI.ConfigNameBg, { BackgroundColor3 = t.Header })
    st(UI.ConfigNameInput, { TextColor3 = t.Accent })
    st(UI.SaveCreateBtn, { BackgroundColor3 = t.Header, TextColor3 = t.Accent })
    st(UI.SaveIcon, { ImageColor3 = t.Accent })
    st(UI.ConfigSelectBg, { BackgroundColor3 = t.Header })
    st(UI.ConfigSelectLbl, { TextColor3 = t.TextDim })
    st(UI.ConfigDropdownBtn, { BackgroundColor3 = t.Card, TextColor3 = t.Accent })
    st(UI.ConfigDropList, { BackgroundColor3 = t.Block })
    st(UI.ConfigDropStroke, { Color = t.StrokeActive })
    st(UI.LoadConfigBtn, { BackgroundColor3 = t.Header, TextColor3 = t.Text })
    st(UI.LoadIcon, { ImageColor3 = t.Text })
    st(UI.DeleteConfigBtn, { BackgroundColor3 = t.Header })

    if UI.ThemeCard then
        st(UI.ThemeCard, { BackgroundColor3 = t.Card })
        st(UI.TCLabel, { TextColor3 = t.Accent })
        for _, child in ipairs(UI.ThemeCard:GetChildren()) do
            if child:IsA("TextButton") then
                local isMatch = (child.Text:find(themeName, 1, true) ~= nil)
                st(child, {
                    BackgroundColor3 = isMatch and t.Header or t.Block,
                    TextColor3 = isMatch and t.Accent or t.TextDim
                })
            end
        end
    end

    -- Update ALL Category Blocks and internal UI elements when theme changes
    for _, block in ipairs(Library.Blocks) do
        st(block.Frame, { BackgroundColor3 = t.Block })
        st(block.Header, { BackgroundColor3 = t.Header })
        st(block.TitleLabel, { TextColor3 = t.Text })
        st(block.Dot, { BackgroundColor3 = t.Accent })
        if block.HeaderIcon then st(block.HeaderIcon, { ImageColor3 = t.Accent }) end
        st(block.Stroke, { Color = t.Stroke })

        if block.SubTabButtons then
            for name, subData in pairs(block.SubTabButtons) do
                local isSelected = (string.upper(tostring(name)) == string.upper(tostring(block.ActiveSubTab or "")))
                st(subData.Button, {
                    BackgroundColor3 = isSelected and t.Header or t.Block,
                    TextColor3 = isSelected and Color3.fromRGB(225, 235, 250) or Color3.fromRGB(130, 142, 160)
                })
                if subData.Stroke then
                    st(subData.Stroke, {
                        Color = isSelected and Color3.fromRGB(90, 110, 140) or t.Stroke,
                        Transparency = isSelected and 0.2 or 0.6
                    })
                end
            end
        end

        for _, elem in ipairs(block.Elements) do
            if elem.Type == "Toggle" then
                st(elem.Frame, { BackgroundColor3 = t.Card })
                if elem.Stroke then st(elem.Stroke, { Color = t.Stroke }) end
                if elem.Label then st(elem.Label, { TextColor3 = elem.GetState() and t.Text or t.TextDim }) end
                if elem.KeyBadgeBtn then st(elem.KeyBadgeBtn, { BackgroundColor3 = t.Header, TextColor3 = t.Accent }) end
                if elem.SwitchBg then st(elem.SwitchBg, { BackgroundColor3 = elem.GetState() and t.Accent or t.Header }) end
                if elem.Knob then st(elem.Knob, { BackgroundColor3 = elem.GetState() and t.Background or t.TextDim }) end
            elseif elem.Type == "Slider" then
                st(elem.Frame, { BackgroundColor3 = t.Card })
                if elem.Stroke then st(elem.Stroke, { Color = t.Stroke }) end
                if elem.Label then st(elem.Label, { TextColor3 = t.TextDim }) end
                if elem.Badge then st(elem.Badge, { BackgroundColor3 = t.Header }) end
                if elem.ValInput then st(elem.ValInput, { TextColor3 = t.Accent }) end
                if elem.TrackBg then st(elem.TrackBg, { BackgroundColor3 = t.Header }) end
                if elem.Fill then st(elem.Fill, { BackgroundColor3 = t.Accent }) end
                if elem.Handle then st(elem.Handle, { BackgroundColor3 = t.Accent }) end
            elseif elem.Type == "Dropdown" then
                st(elem.Frame, { BackgroundColor3 = t.Card })
                if elem.Stroke then st(elem.Stroke, { Color = t.Stroke }) end
                if elem.Label then st(elem.Label, { TextColor3 = t.TextDim }) end
                if elem.DropdownBtn then st(elem.DropdownBtn, { BackgroundColor3 = t.Header, TextColor3 = t.Accent }) end
                if elem.DropList then st(elem.DropList, { BackgroundColor3 = t.Block }) end
            elseif elem.Type == "Button" then
                st(elem.Btn, { BackgroundColor3 = t.Header, TextColor3 = t.Accent })
                if elem.Stroke then st(elem.Stroke, { Color = t.Stroke }) end
            elseif elem.Type == "Keybind" then
                st(elem.Frame, { BackgroundColor3 = t.Card })
                if elem.Label then st(elem.Label, { TextColor3 = t.TextDim }) end
                if elem.KeyBtn then st(elem.KeyBtn, { BackgroundColor3 = t.Header, TextColor3 = t.Accent }) end
            elseif elem.Type == "Label" then
                if elem.TextLabel then st(elem.TextLabel, { TextColor3 = t.AccentDim }) end
                if elem.Dot then st(elem.Dot, { BackgroundColor3 = t.Accent }) end
            end
        end
    end

    st(UI.SkyPresetCard, { BackgroundColor3 = t.Card })
    st(UI.PresetTitle, { TextColor3 = t.Accent })
    st(UI.SkyboxCard, { BackgroundColor3 = t.Card })
    st(UI.ApplySkyboxBtn, { BackgroundColor3 = t.Header, TextColor3 = t.Accent })
    if type(SkyInputs) == "table" then
        for _, item in ipairs(SkyInputs) do
            if item and item.BoxBg then st(item.BoxBg, { BackgroundColor3 = t.Header }) end
            if item and item.Input then st(item.Input, { TextColor3 = t.Accent }) end
        end
    end

    st(UI.RadioCard, { BackgroundColor3 = t.Card })
    st(UI.RadioCardTitle, { TextColor3 = t.Accent })
    st(UI.RadioVisRow, { BackgroundColor3 = t.Block })
    st(UI.RVLabel, { TextColor3 = t.Text })
    st(UI.RVSwitchBg, { BackgroundColor3 = Library.RadioHUDVisible and t.Accent or t.Header })
    st(UI.RVKnob, { BackgroundColor3 = Library.RadioHUDVisible and t.Background or t.TextDim })
    st(UI.TransRow, { BackgroundColor3 = t.Block })
    st(UI.TransLbl, { TextColor3 = t.TextDim })
    st(UI.TransBadge, { BackgroundColor3 = t.Header })
    st(UI.TransValInput, { TextColor3 = t.Accent })
    st(UI.TransTrackBg, { BackgroundColor3 = t.Header })
    st(UI.TransFill, { BackgroundColor3 = t.Accent })
    st(UI.TransHandle, { BackgroundColor3 = t.Accent })
    st(UI.ScaleRow, { BackgroundColor3 = t.Block })
    st(UI.ScaleLbl, { TextColor3 = t.TextDim })
    st(UI.ScaleBadge, { BackgroundColor3 = t.Header })
    st(UI.ScaleValInput, { TextColor3 = t.Accent })
    st(UI.ScaleTrackBg, { BackgroundColor3 = t.Header })
    st(UI.ScaleFill, { BackgroundColor3 = t.Accent })
    st(UI.ScaleHandle, { BackgroundColor3 = t.Accent })
    st(UI.SoundInputBg, { BackgroundColor3 = t.Header })
    st(UI.TabSoundInput, { TextColor3 = t.Accent })
    st(UI.PlaySoundBtn, { BackgroundColor3 = t.Header, TextColor3 = t.Accent })

    st(UI.BlurCard, { BackgroundColor3 = t.Card })
    st(UI.BlurCardTitle, { TextColor3 = t.Accent })
    st(UI.BlurToggleBlock, { BackgroundColor3 = t.Block })
    st(UI.BTLabel, { TextColor3 = t.Text })
    st(UI.BTSwitchBg, { BackgroundColor3 = Library.BlurEnabled and t.Accent or t.Header })
    st(UI.BTKnob, { BackgroundColor3 = Library.BlurEnabled and t.Background or t.TextDim })
    st(UI.BlurSizeLbl, { TextColor3 = t.TextDim })
    st(UI.BlurValInput, { BackgroundColor3 = t.Header, TextColor3 = t.Accent })
    st(UI.BlurTrackBg, { BackgroundColor3 = t.Header })
    st(UI.BlurFill, { BackgroundColor3 = t.Accent })
    st(UI.WallpaperBg, { BackgroundColor3 = t.Header })
    st(UI.WallpaperInput, { TextColor3 = t.Accent })
    st(UI.ApplyWallpaperBtn, { BackgroundColor3 = t.Header, TextColor3 = t.Accent })
    st(UI.WallTransLbl, { TextColor3 = t.TextDim })
    st(UI.WallTransInput, { BackgroundColor3 = t.Header, TextColor3 = t.Accent })
    st(UI.WallTransTrackBg, { BackgroundColor3 = t.Header })
    st(UI.WallTransFill, { BackgroundColor3 = t.Accent })

    st(UI.ParticleCard, { BackgroundColor3 = t.Card })
    st(UI.ParticleCardTitle, { TextColor3 = t.Accent })
    st(UI.SnowToggleBlock, { BackgroundColor3 = t.Block })
    st(UI.STLabel, { TextColor3 = t.Text })
    st(UI.STSwitchBg, { BackgroundColor3 = Library.SnowEnabled and t.Accent or t.Header })
    st(UI.STKnob, { BackgroundColor3 = Library.SnowEnabled and t.Background or t.TextDim })
    st(UI.CountLbl, { TextColor3 = t.TextDim })
    st(UI.CountInput, { BackgroundColor3 = t.Header, TextColor3 = t.Accent })
    st(UI.CountTrackBg, { BackgroundColor3 = t.Header })
    st(UI.CountFill, { BackgroundColor3 = t.Accent })
    st(UI.SpdPartLbl, { TextColor3 = t.TextDim })
    st(UI.SpdPartInput, { BackgroundColor3 = t.Header, TextColor3 = t.Accent })
    st(UI.SpdPartTrackBg, { BackgroundColor3 = t.Header })
    st(UI.SpdPartFill, { BackgroundColor3 = t.Accent })
    st(UI.PSizeLbl, { TextColor3 = t.TextDim })
    st(UI.PSizeInput, { BackgroundColor3 = t.Header, TextColor3 = t.Accent })
    st(UI.PSizeTrackBg, { BackgroundColor3 = t.Header })
    st(UI.PSizeFill, { BackgroundColor3 = t.Accent })
    st(UI.PartTexBg, { BackgroundColor3 = t.Header })
    st(UI.PartTexInput, { TextColor3 = t.Accent })
    st(UI.ApplyPartTexBtn, { BackgroundColor3 = t.Header, TextColor3 = t.Accent })

    st(UI.KeybindHUDFrame, { BackgroundColor3 = t.Block })
    st(UI.KeybindHUDHeader, { BackgroundColor3 = t.Header })
    st(UI.KeybindHUDStroke, { Color = t.Stroke })
    st(UI.HUDIcon, { ImageColor3 = t.Accent })
    st(UI.HUDTitle, { TextColor3 = t.Text })
    st(UI.HUDCountLabel, { TextColor3 = t.Accent })

    st(UI.RadioHUDFrame, { BackgroundColor3 = t.Block })
    st(UI.RadioHUDStroke, { Color = t.Stroke })
    st(UI.RadioHeader, { BackgroundColor3 = t.Header })
    st(UI.MusicIcon, { ImageColor3 = t.Accent })
    st(UI.RHTitle, { TextColor3 = t.Text })
    st(UI.HUDPrevBtn, { BackgroundColor3 = t.Card, TextColor3 = t.Accent })
    st(UI.HUDNextBtn, { BackgroundColor3 = t.Card, TextColor3 = t.Accent })
    st(UI.HUDPlayBtn, { BackgroundColor3 = t.Card, TextColor3 = t.Accent })
    st(UI.HUDSoundInputBg, { BackgroundColor3 = t.Header })
    st(UI.HUDSoundInput, { TextColor3 = t.Accent })
    st(UI.RadioTrackLabel, { TextColor3 = t.TextDim })
    st(UI.SeekTimeLabel, { TextColor3 = t.Accent })
    st(UI.SeekTrackBg, { BackgroundColor3 = t.Header })
    st(UI.SeekFill, { BackgroundColor3 = t.Accent })
    st(UI.SeekHandle, { BackgroundColor3 = t.Accent })
    st(UI.VolLbl, { TextColor3 = t.Accent })
    st(UI.VolTrackBg, { BackgroundColor3 = t.Header })
    st(UI.VolFill, { BackgroundColor3 = t.Accent })
    st(UI.VolHandle, { BackgroundColor3 = t.Accent })

    if UI.SpeedButtons then
        for speedVal, sBtn in pairs(UI.SpeedButtons) do
            local isSel = (math.abs((RadioSound.PlaybackSpeed or 1.0) - speedVal) < 0.05)
            st(sBtn, {
                BackgroundColor3 = isSel and t.Card or t.Header,
                TextColor3 = isSel and t.Accent or t.TextDim
            })
        end
    end

    for _, block in ipairs(Library.Blocks) do
        if block.Frame then smoothTween(block.Frame, DUR_NORMAL, { BackgroundColor3 = t.Block }) end
        if block.Stroke then smoothTween(block.Stroke, DUR_NORMAL, { Color = t.Stroke }) end
        if block.Header then smoothTween(block.Header, DUR_NORMAL, { BackgroundColor3 = t.Header }) end
        if block.TopGlow then smoothTween(block.TopGlow, DUR_NORMAL, { BackgroundColor3 = t.Accent }) end
        if block.Dot then smoothTween(block.Dot, DUR_NORMAL, { BackgroundColor3 = t.Accent }) end
        if block.TitleLabel then smoothTween(block.TitleLabel, DUR_NORMAL, { TextColor3 = t.Text }) end
        if block.Content then smoothTween(block.Content, DUR_NORMAL, { ScrollBarImageColor3 = t.Accent }) end

        if block.SubTabButtons then
            for name, data in pairs(block.SubTabButtons) do
                local sel = (string.upper(tostring(name)) == string.upper(tostring(block.ActiveSubTab or "")))
                if data.Button then
                    smoothTween(data.Button, DUR_NORMAL, {
                        BackgroundColor3 = sel and t.Header or t.Block,
                        TextColor3 = sel and Color3.fromRGB(225, 235, 250) or Color3.fromRGB(130, 142, 160)
                    })
                end
                if data.Stroke then
                    smoothTween(data.Stroke, DUR_NORMAL, {
                        Color = sel and Color3.fromRGB(90, 110, 140) or t.Stroke,
                        Transparency = sel and 0.2 or 0.6
                    })
                end
            end
        end

        for _, elem in ipairs(block.Elements) do
            if elem.Type == "Section" then
                if elem.Line then smoothTween(elem.Line, DUR_NORMAL, { BackgroundColor3 = t.Stroke }) end
                if elem.TitleBg then smoothTween(elem.TitleBg, DUR_NORMAL, { BackgroundColor3 = t.Block }) end
                if elem.TitleLbl then smoothTween(elem.TitleLbl, DUR_NORMAL, { TextColor3 = t.Accent }) end
            elseif elem.Type == "SubTab" then
                if elem.TabRow then smoothTween(elem.TabRow, DUR_NORMAL, { BackgroundColor3 = t.Header }) end
                if elem.Buttons then
                    for _, btn in ipairs(elem.Buttons) do
                        local btnTextUpper = string.upper(btn.Text)
                        local blockTabUpper = string.upper(block.ActiveSubTab or "")
                        local sel = (btnTextUpper == blockTabUpper)
                        smoothTween(btn, DUR_NORMAL, {
                            BackgroundColor3 = sel and t.Block or t.Header,
                            TextColor3 = sel and Color3.fromRGB(225, 235, 250) or Color3.fromRGB(130, 142, 160)
                        })
                    end
                end
            elseif elem.Type == "Toggle" then
                smoothTween(elem.Frame, DUR_NORMAL, { BackgroundColor3 = t.Card })
                smoothTween(elem.Stroke, DUR_NORMAL, { Color = elem.GetState() and t.StrokeHover or t.Stroke })
                smoothTween(elem.SwitchBg, DUR_NORMAL, { BackgroundColor3 = elem.GetState() and t.Accent or t.Header })
                smoothTween(elem.Knob, DUR_NORMAL, { BackgroundColor3 = elem.GetState() and t.Background or t.TextDim })
                smoothTween(elem.Label, DUR_NORMAL, { TextColor3 = elem.GetState() and Color3.fromRGB(225, 235, 250) or t.TextDim })
                if elem.KeyBadgeBtn then smoothTween(elem.KeyBadgeBtn, DUR_NORMAL, { BackgroundColor3 = t.Header, TextColor3 = t.Accent }) end
                if elem.ModePopup then smoothTween(elem.ModePopup, DUR_NORMAL, { BackgroundColor3 = t.Block }) end
                if elem.PopupStroke then smoothTween(elem.PopupStroke, DUR_NORMAL, { Color = t.StrokeActive }) end
            elseif elem.Type == "Slider" then
                smoothTween(elem.Frame, DUR_NORMAL, { BackgroundColor3 = t.Card })
                smoothTween(elem.Stroke, DUR_NORMAL, { Color = t.Stroke })
                smoothTween(elem.Label, DUR_NORMAL, { TextColor3 = t.TextDim })
                smoothTween(elem.ValBadge, DUR_NORMAL, { BackgroundColor3 = t.Header })
                smoothTween(elem.ValInput, DUR_NORMAL, { TextColor3 = Color3.fromRGB(225, 235, 250) })
                smoothTween(elem.TrackBg, DUR_NORMAL, { BackgroundColor3 = t.Header })
                smoothTween(elem.Fill, DUR_NORMAL, { BackgroundColor3 = t.Accent })
                smoothTween(elem.Handle, DUR_NORMAL, { BackgroundColor3 = t.Accent })
            elseif elem.Type == "Button" then
                smoothTween(elem.Frame, DUR_NORMAL, { BackgroundColor3 = t.Card, TextColor3 = Color3.fromRGB(225, 235, 250) })
                smoothTween(elem.Stroke, DUR_NORMAL, { Color = t.Stroke })
            elseif elem.Type == "Dropdown" then
                smoothTween(elem.Frame, DUR_NORMAL, { BackgroundColor3 = t.Card })
                smoothTween(elem.Stroke, DUR_NORMAL, { Color = t.Stroke })
                smoothTween(elem.Label, DUR_NORMAL, { TextColor3 = t.TextDim })
                if elem.SelBadge then smoothTween(elem.SelBadge, DUR_NORMAL, { BackgroundColor3 = t.Header, TextColor3 = Color3.fromRGB(225, 235, 250) }) end
                if elem.DropdownBtn then smoothTween(elem.DropdownBtn, DUR_NORMAL, { BackgroundColor3 = t.Header, TextColor3 = Color3.fromRGB(225, 235, 250) }) end
            elseif elem.Type == "Keybind" then
                smoothTween(elem.Frame, DUR_NORMAL, { BackgroundColor3 = t.Card })
                smoothTween(elem.Stroke, DUR_NORMAL, { Color = t.Stroke })
                smoothTween(elem.Label, DUR_NORMAL, { TextColor3 = t.TextDim })
                smoothTween(elem.KeyBtn, DUR_NORMAL, { BackgroundColor3 = t.Header, TextColor3 = t.Accent })
                if elem.ModePopup then smoothTween(elem.ModePopup, DUR_NORMAL, { BackgroundColor3 = t.Block }) end
                if elem.PopupStroke then smoothTween(elem.PopupStroke, DUR_NORMAL, { Color = t.StrokeActive }) end
            end
        end
    end

    if Library.RefreshKeybindHUD then Library:RefreshKeybindHUD() end

    pcall(function()
        local binds = {}
        for featName, data in pairs(Library.KeybindList) do
            if type(data) == "table" and data.Key and data.Key ~= "NONE" and data.Key ~= "" then
                table.insert(binds, { Name = featName, Data = data })
            end
        end
        if #binds > 0 then
            local randomPick = binds[math.random(1, #binds)]
            local origActive = randomPick.Data.Active
            randomPick.Data.Active = true
            if Library.RefreshKeybindHUD then Library:RefreshKeybindHUD() end

            task.delay(0.28, function()
                randomPick.Data.Active = origActive
                if Library.RefreshKeybindHUD then Library:RefreshKeybindHUD() end
            end)
        end
    end)
end

function Library:SetVisible(visible)
    if not visible and SettingsModal and SettingsModal.Visible then
        if toggleSettingsModal then
            toggleSettingsModal(false)
        else
            SettingsModal.Visible = false
            if ModalBackdrop then ModalBackdrop.Visible = false end
        end
    end
    Library.Enabled = visible
    ScreenGui.Enabled = true
    if GearBtnFrame then GearBtnFrame.Visible = visible end

    if visible then
        Container.Visible = true
        if GearBtnFrame then GearBtnFrame.Visible = true end
        ContainerUIScale.Scale = 0.93
        smoothTween(ContainerUIScale, DUR_NORMAL, { Scale = 1.0 }, EASE_SPRING, DIR_OUT)

        if Library.BlurEnabled then
            MenuBlur.Enabled = true
            MenuBlur.Size = Library.BlurSize
        end
        SnowFolder.Visible = Library.SnowEnabled
        MenuBgImage.Visible = (formatAssetId(Library.MenuBgImage or "") ~= "")

        for i, blockData in ipairs(Library.Blocks) do
            local f = blockData.Frame
            if f then
                f.Visible = true
                if blockData.DefaultPos and not blockData.HasBeenShown then
                    f.Position = blockData.DefaultPos
                    blockData.HasBeenShown = true
                end
                if blockData.UpdateHeight then
                    pcall(blockData.UpdateHeight)
                end
            end
        end
        if WindowInstance and WindowInstance.Frame then
            WindowInstance.Frame.Visible = true
        end
    else
        smoothTween(ContainerUIScale, DUR_FAST, { Scale = 0.93 }, EASE_SMOOTH, DIR_OUT)
        smoothTween(MenuBlur, DUR_FAST, { Size = 0 })

        task.delay(DUR_FAST, function()
            if not Library.Enabled then
                Container.Visible = false
                MenuBlur.Enabled = false
                SnowFolder.Visible = false
                MenuBgImage.Visible = false
                SettingsModal.Visible = false
                ConfigDropList.Visible = false
                configDropOpen = false
                if GearBtnFrame then GearBtnFrame.Visible = false end
                if WindowInstance and WindowInstance.Frame then
                    WindowInstance.Frame.Visible = false
                end
                for i, blockData in ipairs(Library.Blocks) do
                    if blockData.Frame then blockData.Frame.Visible = false end
                end
            end
        end)
    end

    if Library.RefreshKeybindHUD then Library:RefreshKeybindHUD() end
    updateRadioHUDProperties()
end

function Library:Toggle()
    Library:SetVisible(not Library.Enabled)
end

function Library:SetWatermark(text)
    if type(text) == "string" and text ~= "" then
        Library.WatermarkText = text
        if UI and UI.TopWMarkTitle then
            UI.TopWMarkTitle.Text = text
        end
        if UI and UI.ModalTitle then
            UI.ModalTitle.Text = text .. "  |  SETTINGS & MANAGER"
        end
        if WMarkLabel then
            WMarkLabel.Text = text .. "  |  [" .. string.upper(Library.ToggleKey.Name) .. "]"
        end
    end
end

local function parseElementArgs(arg1, arg2, arg3, arg4, arg5)
    local name = "Element"
    local default = nil
    local callback = function() end
    local options = {}
    local min, max = 0, 100

    if type(arg2) == "table" then
        name = arg2.Text or arg2.Title or tostring(arg1)
        default = (arg2.Default ~= nil) and arg2.Default or arg2.Val
        callback = arg2.Callback or arg2.callback or function() end
        options = arg2.Values or arg2.Options or {}
        min = arg2.Min or 0
        max = arg2.Max or 100
    else
        name = tostring(arg1)
        default = arg2
        if type(arg3) == "function" then
            callback = arg3
        elseif type(arg4) == "function" then
            callback = arg4
        elseif type(arg5) == "function" then
            callback = arg5
        end
        if type(arg2) == "table" then options = arg2 end
        if type(arg3) == "table" then options = arg3 end
        if type(arg2) == "number" then min = arg2 end
        if type(arg3) == "number" then max = arg3 end
        if type(arg4) == "number" and default == nil then default = arg4 end
    end

    return {
        Name = name,
        Default = default,
        Callback = callback,
        Options = options,
        Min = min,
        Max = max
    }
end

local WindowInstance = nil

local function getOrCreateMainWindow(title)
    if WindowInstance then
        if title and title ~= "" and WindowInstance.TitleLabel then
            WindowInstance.TitleLabel.Text = string.upper(tostring(title))
        end
        return WindowInstance
    end

    local WindowFrame = Instance.new("Frame")
    WindowFrame.Name = "NursultanMainWindow"
    WindowFrame.Size = UDim2.new(0, 640, 0, 490)
    WindowFrame.Position = UDim2.new(0.5, -320, 0.5, -245)
    WindowFrame.BackgroundColor3 = Library.Theme.Block
    WindowFrame.BackgroundTransparency = 0.04
    WindowFrame.BorderSizePixel = 0
    WindowFrame.ClipsDescendants = false
    WindowFrame.Visible = Library.Enabled
    WindowFrame.ZIndex = 10
    WindowFrame.Parent = Container
    addCorner(WindowFrame, 8)

    local FrameStroke = Instance.new("UIStroke")
    FrameStroke.Color = Library.Theme.Stroke
    FrameStroke.Transparency = 0.3
    FrameStroke.Thickness = 1.0
    FrameStroke.Parent = WindowFrame

    local Header = Instance.new("Frame")
    Header.Name = "WindowHeader"
    Header.Size = UDim2.new(1, 0, 0, 38)
    Header.BackgroundColor3 = Library.Theme.Header
    Header.BackgroundTransparency = 0.08
    Header.BorderSizePixel = 0
    Header.ZIndex = 11
    Header.Parent = WindowFrame
    addCorner(Header, 8)

    local Dot = Instance.new("Frame")
    Dot.Size = UDim2.new(0, 6, 0, 6)
    Dot.Position = UDim2.new(0, 12, 0.5, -3)
    Dot.BackgroundColor3 = Library.Theme.Accent
    Dot.BorderSizePixel = 0
    Dot.ZIndex = 12
    Dot.Parent = Header

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -70, 1, 0)
    TitleLabel.Position = UDim2.new(0, 25, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Font = Library.Fonts.Header
    TitleLabel.Text = string.upper(title or Library.WatermarkText or "NURSULTAN HUB")
    TitleLabel.TextColor3 = Library.Theme.Text
    TitleLabel.TextSize = 12
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.ZIndex = 12
    TitleLabel.Parent = Header

    makeDraggable(WindowFrame, Header)

    local TabBar = Instance.new("Frame")
    TabBar.Name = "TabBar"
    TabBar.Size = UDim2.new(1, -16, 0, 32)
    TabBar.Position = UDim2.new(0, 8, 0, 42)
    TabBar.BackgroundColor3 = Library.Theme.Header
    TabBar.BorderSizePixel = 0
    TabBar.ZIndex = 11
    TabBar.Parent = WindowFrame
    addCorner(TabBar, 6)

    local TabBarLayout = Instance.new("UIListLayout")
    TabBarLayout.FillDirection = Enum.FillDirection.Horizontal
    TabBarLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabBarLayout.Padding = UDim.new(0, 4)
    TabBarLayout.Parent = TabBar

    local TabBarPadding = Instance.new("UIPadding")
    TabBarPadding.PaddingTop = UDim.new(0, 3)
    TabBarPadding.PaddingBottom = UDim.new(0, 3)
    TabBarPadding.PaddingLeft = UDim.new(0, 4)
    TabBarPadding.PaddingRight = UDim.new(0, 4)
    TabBarPadding.Parent = TabBar

    local TabContent = Instance.new("Frame")
    TabContent.Name = "TabContent"
    TabContent.Size = UDim2.new(1, -16, 1, -82)
    TabContent.Position = UDim2.new(0, 8, 0, 78)
    TabContent.BackgroundTransparency = 1
    TabContent.ZIndex = 11
    TabContent.Parent = WindowFrame

    WindowInstance = {
        Frame = WindowFrame,
        Header = Header,
        TitleLabel = TitleLabel,
        TabBar = TabBar,
        TabContent = TabContent,
        Tabs = {},
        ActiveTab = nil
    }

    return WindowInstance
end

local function createTabObj(tabTitle)
    local win = getOrCreateMainWindow()
    local tabTitleStr = tostring(tabTitle)

    local TabPage = Instance.new("ScrollingFrame")
    TabPage.Name = "TabPage_" .. tabTitleStr
    TabPage.Size = UDim2.new(1, 0, 1, 0)
    TabPage.BackgroundTransparency = 1
    TabPage.BorderSizePixel = 0
    TabPage.ScrollBarThickness = 3
    TabPage.ScrollBarImageColor3 = Library.Theme.Accent
    TabPage.Visible = false
    TabPage.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabPage.AutomaticCanvasSize = Enum.AutomaticSize.Y
    TabPage.ZIndex = 11
    TabPage.Parent = win.TabContent

    local LeftColumn = Instance.new("Frame")
    LeftColumn.Name = "LeftColumn"
    LeftColumn.Size = UDim2.new(0.495, -2, 1, 0)
    LeftColumn.Position = UDim2.new(0, 0, 0, 0)
    LeftColumn.BackgroundTransparency = 1
    LeftColumn.Parent = TabPage

    local LeftLayout = Instance.new("UIListLayout")
    LeftLayout.SortOrder = Enum.SortOrder.LayoutOrder
    LeftLayout.Padding = UDim.new(0, 8)
    LeftLayout.Parent = LeftColumn

    local RightColumn = Instance.new("Frame")
    RightColumn.Name = "RightColumn"
    RightColumn.Size = UDim2.new(0.495, -2, 1, 0)
    RightColumn.Position = UDim2.new(0.505, 2, 0, 0)
    RightColumn.BackgroundTransparency = 1
    RightColumn.Parent = TabPage

    local RightLayout = Instance.new("UIListLayout")
    RightLayout.SortOrder = Enum.SortOrder.LayoutOrder
    RightLayout.Padding = UDim.new(0, 8)
    RightLayout.Parent = RightColumn

    local TabBtn = Instance.new("TextButton")
    TabBtn.Name = "TabBtn_" .. tabTitleStr
    TabBtn.AutomaticSize = Enum.AutomaticSize.X
    TabBtn.Size = UDim2.new(0, 80, 1, 0)
    TabBtn.BackgroundColor3 = Library.Theme.Card
    TabBtn.BorderSizePixel = 0
    TabBtn.Font = Library.Fonts.Header
    TabBtn.Text = "  " .. string.upper(tabTitleStr) .. "  "
    TabBtn.TextColor3 = Library.Theme.TextDim
    TabBtn.TextSize = 10.5
    TabBtn.ZIndex = 12
    TabBtn.Parent = win.TabBar
    addCorner(TabBtn, 4)

    local TabIndicator = Instance.new("Frame")
    TabIndicator.Size = UDim2.new(1, 0, 0, 2)
    TabIndicator.Position = UDim2.new(0, 0, 1, -2)
    TabIndicator.BackgroundColor3 = Library.Theme.Accent
    TabIndicator.BorderSizePixel = 0
    TabIndicator.Visible = false
    TabIndicator.ZIndex = 13
    TabIndicator.Parent = TabBtn

    local TabObj = {
        Title = tabTitleStr,
        Page = TabPage,
        LeftColumn = LeftColumn,
        RightColumn = RightColumn,
        TabBtn = TabBtn,
        TabIndicator = TabIndicator,
        Groupboxes = {}
    }

    local function selectTab()
        for _, t in ipairs(win.Tabs) do
            local isSel = (t == TabObj)
            t.Page.Visible = isSel
            t.TabIndicator.Visible = isSel
            smoothTween(t.TabBtn, DUR_FAST, {
                BackgroundColor3 = isSel and Library.Theme.Block or Library.Theme.Card,
                TextColor3 = isSel and Library.Theme.Accent or Library.Theme.TextDim
            })
        end
        win.ActiveTab = TabObj
    end

    TabBtn.MouseButton1Click:Connect(selectTab)

    table.insert(win.Tabs, TabObj)
    if #win.Tabs == 1 then
        selectTab()
    end

    function TabObj:AddGroupbox(title, side)
        side = side or "left"
        local parentColumn = (string.lower(tostring(side)) == "right") and TabObj.RightColumn or TabObj.LeftColumn

        local GroupFrame = Instance.new("Frame")
        GroupFrame.Name = "Group_" .. tostring(title)
        GroupFrame.Size = UDim2.new(1, 0, 0, 32)
        GroupFrame.AutomaticSize = Enum.AutomaticSize.Y
        GroupFrame.BackgroundColor3 = Library.Theme.Block
        GroupFrame.BackgroundTransparency = 0.04
        GroupFrame.BorderSizePixel = 0
        GroupFrame.ZIndex = 12
        GroupFrame.Parent = parentColumn
        addCorner(GroupFrame, 6)

        local GroupStroke = Instance.new("UIStroke")
        GroupStroke.Color = Library.Theme.Stroke
        GroupStroke.Transparency = 0.3
        GroupStroke.Thickness = 1
        GroupStroke.Parent = GroupFrame

        local GroupHeader = Instance.new("Frame")
        GroupHeader.Name = "GroupHeader"
        GroupHeader.Size = UDim2.new(1, 0, 0, 26)
        GroupHeader.BackgroundColor3 = Library.Theme.Header
        GroupHeader.BorderSizePixel = 0
        GroupHeader.ZIndex = 13
        GroupHeader.Parent = GroupFrame
        addCorner(GroupHeader, 6)

        local Dot = Instance.new("Frame")
        Dot.Size = UDim2.new(0, 5, 0, 5)
        Dot.Position = UDim2.new(0, 8, 0.5, -2)
        Dot.BackgroundColor3 = Library.Theme.Accent
        Dot.BorderSizePixel = 0
        Dot.ZIndex = 14
        Dot.Parent = GroupHeader

        local TitleLbl = Instance.new("TextLabel")
        TitleLbl.Size = UDim2.new(1, -20, 1, 0)
        TitleLbl.Position = UDim2.new(0, 18, 0, 0)
        TitleLbl.BackgroundTransparency = 1
        TitleLbl.Font = Library.Fonts.Header
        TitleLbl.Text = string.upper(tostring(title))
        TitleLbl.TextColor3 = Library.Theme.Text
        TitleLbl.TextSize = 10.5
        TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
        TitleLbl.ZIndex = 14
        TitleLbl.Parent = GroupHeader

        local ContentContainer = Instance.new("Frame")
        ContentContainer.Name = "ContentContainer"
        ContentContainer.Size = UDim2.new(1, 0, 0, 0)
        ContentContainer.Position = UDim2.new(0, 0, 0, 26)
        ContentContainer.AutomaticSize = Enum.AutomaticSize.Y
        ContentContainer.BackgroundTransparency = 1
        ContentContainer.ZIndex = 13
        ContentContainer.Parent = GroupFrame

        local ContentLayout = Instance.new("UIListLayout")
        ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ContentLayout.Padding = UDim.new(0, 5)
        ContentLayout.Parent = ContentContainer

        local ContentPadding = Instance.new("UIPadding")
        ContentPadding.PaddingTop = UDim.new(0, 6)
        ContentPadding.PaddingBottom = UDim.new(0, 6)
        ContentPadding.PaddingLeft = UDim.new(0, 6)
        ContentPadding.PaddingRight = UDim.new(0, 6)
        ContentPadding.Parent = ContentContainer

        local GroupObj = {
            Frame = GroupFrame,
            Content = ContentContainer
        }

        function GroupObj:AddToggle(arg1, arg2, arg3, arg4, arg5)
            local parsed = parseElementArgs(arg1, arg2, arg3, arg4, arg5)
            local name = parsed.Name
            local default = (parsed.Default == true)
            local callback = parsed.Callback

            local ToggleBtn = Instance.new("TextButton")
            ToggleBtn.Name = name .. "_Toggle"
            ToggleBtn.Size = UDim2.new(1, 0, 0, 32)
            ToggleBtn.BackgroundColor3 = Library.Theme.Card
            ToggleBtn.BorderSizePixel = 0
            ToggleBtn.AutoButtonColor = false
            ToggleBtn.Font = Library.Fonts.Label
            ToggleBtn.Text = "  " .. name
            ToggleBtn.TextColor3 = default and Library.Theme.Text or Library.Theme.TextDim
            ToggleBtn.TextSize = 11.5
            ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left
            ToggleBtn.ZIndex = 14
            ToggleBtn.Parent = ContentContainer
            addCorner(ToggleBtn, 6)

            local Stroke = Instance.new("UIStroke")
            Stroke.Color = default and Library.Theme.StrokeHover or Library.Theme.Stroke
            Stroke.Thickness = 1
            Stroke.Parent = ToggleBtn

            local SwitchBg = Instance.new("Frame")
            SwitchBg.Size = UDim2.new(0, 34, 0, 18)
            SwitchBg.Position = UDim2.new(1, -40, 0.5, -9)
            SwitchBg.BackgroundColor3 = default and Library.Theme.Accent or Library.Theme.Header
            SwitchBg.BorderSizePixel = 0
            SwitchBg.ZIndex = 15
            SwitchBg.Parent = ToggleBtn
            addCorner(SwitchBg, 9)

            local Knob = Instance.new("Frame")
            Knob.Size = UDim2.new(0, 12, 0, 12)
            Knob.Position = default and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 3, 0.5, -6)
            Knob.BackgroundColor3 = default and Library.Theme.Background or Library.Theme.TextDim
            Knob.BorderSizePixel = 0
            Knob.ZIndex = 16
            Knob.Parent = SwitchBg
            addCorner(Knob, 6)

            local isToggled = default
            ToggleBtn.MouseButton1Click:Connect(function()
                isToggled = not isToggled
                smoothTween(SwitchBg, DUR_FAST, { BackgroundColor3 = isToggled and Library.Theme.Accent or Library.Theme.Header })
                smoothTween(Knob, DUR_FAST, {
                    Position = isToggled and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 3, 0.5, -6),
                    BackgroundColor3 = isToggled and Library.Theme.Background or Library.Theme.TextDim
                })
                smoothTween(ToggleBtn, DUR_FAST, { TextColor3 = isToggled and Library.Theme.Text or Library.Theme.TextDim })
                smoothTween(Stroke, DUR_FAST, { Color = isToggled and Library.Theme.StrokeHover or Library.Theme.Stroke })
                task.spawn(function() pcall(callback, isToggled) end)
            end)

            return { Frame = ToggleBtn, SetState = function(v) isToggled = v end }
        end
        GroupObj.CreateToggle = GroupObj.AddToggle

        function GroupObj:AddSlider(arg1, arg2, arg3, arg4, arg5)
            local parsed = parseElementArgs(arg1, arg2, arg3, arg4, arg5)
            local name = parsed.Name
            local min = parsed.Min
            local max = parsed.Max
            local default = parsed.Default or min
            local callback = parsed.Callback

            local SliderFrame = Instance.new("Frame")
            SliderFrame.Name = name .. "_Slider"
            SliderFrame.Size = UDim2.new(1, 0, 0, 42)
            SliderFrame.BackgroundColor3 = Library.Theme.Card
            SliderFrame.BorderSizePixel = 0
            SliderFrame.ZIndex = 14
            SliderFrame.Parent = ContentContainer
            addCorner(SliderFrame, 6)

            local Stroke = Instance.new("UIStroke")
            Stroke.Color = Library.Theme.Stroke
            Stroke.Thickness = 1
            Stroke.Parent = SliderFrame

            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, -60, 0, 18)
            Label.Position = UDim2.new(0, 10, 0, 4)
            Label.BackgroundTransparency = 1
            Label.Font = Library.Fonts.Label
            Label.Text = name
            Label.TextColor3 = Library.Theme.TextDim
            Label.TextSize = 11
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.ZIndex = 15
            Label.Parent = SliderFrame

            local ValBadge = Instance.new("Frame")
            ValBadge.AutomaticSize = Enum.AutomaticSize.X
            ValBadge.Size = UDim2.new(0, 36, 0, 16)
            ValBadge.Position = UDim2.new(1, -44, 0, 5)
            ValBadge.BackgroundColor3 = Library.Theme.Header
            ValBadge.BorderSizePixel = 0
            ValBadge.ZIndex = 15
            ValBadge.Parent = SliderFrame
            addCorner(ValBadge, 4)

            local ValInput = Instance.new("TextBox")
            ValInput.AutomaticSize = Enum.AutomaticSize.X
            ValInput.Size = UDim2.new(1, 0, 1, 0)
            ValInput.BackgroundTransparency = 1
            ValInput.Font = Library.Fonts.Header
            ValInput.Text = tostring(default)
            ValInput.TextColor3 = Library.Theme.Accent
            ValInput.TextSize = 10
            ValInput.ZIndex = 16
            ValInput.Parent = ValBadge

            local TrackBg = Instance.new("Frame")
            TrackBg.Size = UDim2.new(1, -20, 0, 6)
            TrackBg.Position = UDim2.new(0, 10, 0, 26)
            TrackBg.BackgroundColor3 = Library.Theme.Header
            TrackBg.BorderSizePixel = 0
            TrackBg.ZIndex = 15
            TrackBg.Parent = SliderFrame
            addCorner(TrackBg, 3)

            local fillRatio = (default - min) / (max - min)
            local Fill = Instance.new("Frame")
            Fill.Size = UDim2.new(fillRatio, 0, 1, 0)
            Fill.BackgroundColor3 = Library.Theme.Accent
            Fill.BorderSizePixel = 0
            Fill.ZIndex = 16
            Fill.Parent = TrackBg
            addCorner(Fill, 3)

            local currentVal = default
            local function updateSlider(input)
                local pos = input.Position.X
                local trackAbsPos = TrackBg.AbsolutePosition.X
                local trackAbsSize = TrackBg.AbsoluteSize.X
                local pct = math.clamp((pos - trackAbsPos) / trackAbsSize, 0, 1)
                currentVal = math.floor(min + (max - min) * pct + 0.5)
                Fill.Size = UDim2.new(pct, 0, 1, 0)
                ValInput.Text = tostring(currentVal)
                task.spawn(function() pcall(callback, currentVal) end)
            end

            local dragging = false
            TrackBg.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                    updateSlider(input)
                end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    updateSlider(input)
                end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
            end)

            return { Frame = SliderFrame, SetValue = function(v) currentVal = v; ValInput.Text = tostring(v) end }
        end
        GroupObj.CreateSlider = GroupObj.AddSlider

        function GroupObj:AddDropdown(arg1, arg2, arg3, arg4, arg5)
            local parsed = parseElementArgs(arg1, arg2, arg3, arg4, arg5)
            local name = parsed.Name
            local options = parsed.Options
            local default = parsed.Default or options[1] or "None"
            local callback = parsed.Callback

            local DropFrame = Instance.new("Frame")
            DropFrame.Name = name .. "_Dropdown"
            DropFrame.Size = UDim2.new(1, 0, 0, 36)
            DropFrame.BackgroundColor3 = Library.Theme.Card
            DropFrame.BorderSizePixel = 0
            DropFrame.ZIndex = 14
            DropFrame.Parent = ContentContainer
            addCorner(DropFrame, 6)

            local Stroke = Instance.new("UIStroke")
            Stroke.Color = Library.Theme.Stroke
            Stroke.Thickness = 1
            Stroke.Parent = DropFrame

            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(0.5, 0, 0, 26)
            Label.Position = UDim2.new(0, 10, 0, 5)
            Label.BackgroundTransparency = 1
            Label.Font = Library.Fonts.Label
            Label.Text = name
            Label.TextColor3 = Library.Theme.TextDim
            Label.TextSize = 11
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.ZIndex = 15
            Label.Parent = DropFrame

            local SelBadge = Instance.new("TextLabel")
            SelBadge.AutomaticSize = Enum.AutomaticSize.X
            SelBadge.Size = UDim2.new(0, 50, 0, 20)
            SelBadge.Position = UDim2.new(1, -60, 0.5, -10)
            SelBadge.BackgroundColor3 = Library.Theme.Header
            SelBadge.Font = Library.Fonts.Header
            SelBadge.Text = tostring(default)
            SelBadge.TextColor3 = Library.Theme.Accent
            SelBadge.TextSize = 10
            SelBadge.ZIndex = 15
            SelBadge.Parent = DropFrame
            addCorner(SelBadge, 4)

            return { Frame = DropFrame }
        end
        GroupObj.CreateDropdown = GroupObj.AddDropdown

        function GroupObj:AddButton(arg1, arg2)
            local name = tostring(arg1)
            local callback = arg2 or function() end
            if type(arg1) == "table" then
                name = arg1.Text or arg1.Title or "Button"
                callback = arg1.Callback or function() end
            end

            local BtnFrame = Instance.new("TextButton")
            BtnFrame.Name = name .. "_Button"
            BtnFrame.Size = UDim2.new(1, 0, 0, 32)
            BtnFrame.BackgroundColor3 = Library.Theme.Card
            BtnFrame.BorderSizePixel = 0
            BtnFrame.AutoButtonColor = false
            BtnFrame.Font = Library.Fonts.Label
            BtnFrame.Text = name
            BtnFrame.TextColor3 = Library.Theme.Text
            BtnFrame.TextSize = 11.5
            BtnFrame.ZIndex = 14
            BtnFrame.Parent = ContentContainer
            addCorner(BtnFrame, 6)

            local Stroke = Instance.new("UIStroke")
            Stroke.Color = Library.Theme.Stroke
            Stroke.Thickness = 1
            Stroke.Parent = BtnFrame

            BtnFrame.MouseButton1Click:Connect(function()
                task.spawn(function() pcall(callback) end)
            end)

            return { Frame = BtnFrame }
        end
        GroupObj.CreateButton = GroupObj.AddButton

        function GroupObj:AddLabel(text)
            local LblFrame = Instance.new("Frame")
            LblFrame.Size = UDim2.new(1, 0, 0, 22)
            LblFrame.BackgroundTransparency = 1
            LblFrame.ZIndex = 14
            LblFrame.Parent = ContentContainer

            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, -10, 1, 0)
            Label.Position = UDim2.new(0, 5, 0, 0)
            Label.BackgroundTransparency = 1
            Label.Font = Library.Fonts.Label
            Label.Text = tostring(text)
            Label.TextColor3 = Library.Theme.TextDim
            Label.TextSize = 11
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.ZIndex = 15
            Label.Parent = LblFrame

            return { Frame = LblFrame }
        end

        function GroupObj:AddSection(sectionTitle)
            local SectionFrame = Instance.new("Frame")
            SectionFrame.Name = sectionTitle .. "_Section"
            SectionFrame.Size = UDim2.new(1, 0, 0, 22)
            SectionFrame.BackgroundTransparency = 1
            SectionFrame.ZIndex = 14
            SectionFrame.Parent = ContentContainer

            local Line = Instance.new("Frame")
            Line.Size = UDim2.new(1, -16, 0, 1)
            Line.Position = UDim2.new(0, 8, 0.5, 0)
            Line.BackgroundColor3 = Library.Theme.Stroke
            Line.BorderSizePixel = 0
            Line.ZIndex = 15
            Line.Parent = SectionFrame

            local TitleBg = Instance.new("Frame")
            TitleBg.AutomaticSize = Enum.AutomaticSize.X
            TitleBg.Size = UDim2.new(0, 0, 0, 14)
            TitleBg.Position = UDim2.new(0, 14, 0.5, -7)
            TitleBg.BackgroundColor3 = Library.Theme.Block
            TitleBg.BorderSizePixel = 0
            TitleBg.ZIndex = 16
            TitleBg.Parent = SectionFrame

            local TitleLbl = Instance.new("TextLabel")
            TitleLbl.AutomaticSize = Enum.AutomaticSize.X
            TitleLbl.Size = UDim2.new(0, 0, 1, 0)
            TitleLbl.BackgroundTransparency = 1
            TitleLbl.Font = Library.Fonts.Badge
            TitleLbl.Text = " " .. string.upper(tostring(sectionTitle)) .. " "
            TitleLbl.TextColor3 = Library.Theme.Accent
            TitleLbl.TextSize = 8.5
            TitleLbl.ZIndex = 17
            TitleLbl.Parent = TitleBg

            return { Frame = SectionFrame }
        end

        return GroupObj
    end

    TabObj.AddLeftGroupbox = function(_, title) return TabObj:AddGroupbox(title, "left") end
    TabObj.AddRightGroupbox = function(_, title) return TabObj:AddGroupbox(title, "right") end
    TabObj.CreateWindow = function(_, title) return TabObj:AddGroupbox(title, "left") end
    TabObj.CreateGroupbox = function(_, title) return TabObj:AddGroupbox(title, "left") end

    return TabObj
end

function Library:CreateWindow(hubTitle, gameTitle)
    local hubStr = "NURSULTAN HUB"
    if type(hubTitle) == "table" then
        hubStr = hubTitle.Title or hubTitle.Text or "NURSULTAN HUB"
    elseif type(hubTitle) == "string" and hubTitle ~= "" then
        hubStr = hubTitle
    end

    ScreenGui.Enabled = true
    Container.Visible = true
    Library.Enabled = true
    Library:SetWatermark(hubStr)
    return Library
end

function Library:Init(...)
    return Library:CreateWindow(...)
end

function Library:CreateTab(title, pos)
    return Library:CreateBlock(title, pos)
end
Library.AddTab = Library.CreateTab
Library.AddBlock = Library.CreateBlock

trackConnection(UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if Library.ListeningKeybind then return end

    local focused = UserInputService:GetFocusedTextBox()
    if focused then return end

    if input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == Library.ToggleKey or input.KeyCode == Enum.KeyCode.RightShift then
            Library:Toggle()
        end
    end
end))


function Library:CreateBlock(title, defaultPosition)
    ScreenGui.Enabled = true
    Container.Visible = true
    Library.Enabled = true

    local Block = {
        Title = title or "Category",
        Expanded = true,
        Elements = {},
        CustomWidth = 245,
        CustomHeight = 360
    }

    local blockIndex = #Library.Blocks
    defaultPosition = defaultPosition or UDim2.new(0, 15 + (blockIndex * 255), 0, 50)
    Block.DefaultPos = defaultPosition

    -- Parent to Container so ContainerUIScale and Container.Visible smoothly control block animations
    local Frame = Instance.new("Frame")
    Frame.Name = title .. "_Block"
    Frame.Size = UDim2.new(0, 245, 0, 360)
    Frame.Position = defaultPosition
    Frame.BackgroundColor3 = Library.Theme.Block
    Frame.BackgroundTransparency = 0.04
    Frame.BorderSizePixel = 0
    Frame.ClipsDescendants = false
    Frame.Visible = Library.Enabled
    Frame.ZIndex = 10
    Frame.Parent = Container
    Block.Frame = Frame

    addCorner(Frame, 8)

    local FrameStroke = Instance.new("UIStroke")
    FrameStroke.Color = Library.Theme.Stroke
    FrameStroke.Transparency = 0.3
    FrameStroke.Thickness = 1.0
    FrameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    FrameStroke.Parent = Frame
    Block.Stroke = FrameStroke

    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Size = UDim2.new(1, 0, 0, 38)
    Header.BackgroundColor3 = Library.Theme.Header
    Header.BackgroundTransparency = 0.08
    Header.BorderSizePixel = 0
    Header.ZIndex = 11
    Header.Parent = Frame
    Block.Header = Header
    addCorner(Header, 8)

    local upperTitle = string.upper(tostring(title or ""))
    local matchedIcon = Library.CategoryIcons[upperTitle]

    local Dot = Instance.new("Frame")
    Dot.Size = UDim2.new(0, 6, 0, 6)
    Dot.Position = UDim2.new(0, 12, 0.5, -3)
    Dot.BackgroundColor3 = Library.Theme.Accent
    Dot.BorderSizePixel = 0
    Dot.ZIndex = 12
    Dot.Parent = Header
    Block.Dot = Dot

    if matchedIcon then
        Dot.Visible = false
        local HeaderIcon = Instance.new("ImageLabel")
        HeaderIcon.Name = "HeaderIcon"
        HeaderIcon.Size = UDim2.new(0, 16, 0, 16)
        HeaderIcon.Position = UDim2.new(0, 10, 0.5, -8)
        HeaderIcon.BackgroundTransparency = 1
        HeaderIcon.Image = matchedIcon
        HeaderIcon.ImageColor3 = Library.Theme.Accent
        HeaderIcon.ZIndex = 12
        HeaderIcon.Parent = Header
        Block.HeaderIcon = HeaderIcon
    end

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -65, 1, 0)
    TitleLabel.Position = matchedIcon and UDim2.new(0, 32, 0, 0) or UDim2.new(0, 25, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Font = Library.Fonts.Header
    TitleLabel.Text = string.upper(title)
    TitleLabel.TextColor3 = Library.Theme.Text
    TitleLabel.TextSize = 12
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.ZIndex = 12
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
    CollapseBtn.ZIndex = 12
    CollapseBtn.Parent = Header

    local Content = Instance.new("ScrollingFrame")
    Content.Name = "Content"
    Content.Size = UDim2.new(1, 0, 1, -38)
    Content.Position = UDim2.new(0, 0, 0, 38)
    Content.BackgroundTransparency = 1
    Content.ClipsDescendants = true
    Content.Visible = true
    Content.BorderSizePixel = 0
    Content.ScrollBarThickness = 3
    Content.ScrollBarImageColor3 = Library.Theme.Accent
    Content.CanvasSize = UDim2.new(0, 0, 0, 0)
    Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Content.ZIndex = 11
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

    local ResizeGrip = Instance.new("TextButton")
    ResizeGrip.Name = "ResizeGrip"
    ResizeGrip.Size = UDim2.new(0, 16, 0, 16)
    ResizeGrip.Position = UDim2.new(1, -14, 1, -14)
    ResizeGrip.BackgroundTransparency = 1
    ResizeGrip.Font = Library.Fonts.Badge
    ResizeGrip.Text = "◢"
    ResizeGrip.TextColor3 = Library.Theme.TextDim
    ResizeGrip.TextSize = 11
    ResizeGrip.ZIndex = 50
    ResizeGrip.Parent = Frame
    Block.ResizeGrip = ResizeGrip

    ResizeGrip.MouseEnter:Connect(function()
        smoothTween(ResizeGrip, DUR_FAST, { TextColor3 = Library.Theme.Accent })
    end)
    ResizeGrip.MouseLeave:Connect(function()
        smoothTween(ResizeGrip, DUR_FAST, { TextColor3 = Library.Theme.TextDim })
    end)

    makeResizable(Frame, ResizeGrip, 200, 120, 600, 850, function(newW, newH)
        Block.CustomWidth = newW
        Block.CustomHeight = newH
        if Block.Expanded then
            Content.Size = UDim2.new(1, 0, 1, -38)
        end
    end)

    local function updateHeight()
        local layoutHeight = UIListLayout.AbsoluteContentSize.Y + 16
        Content.CanvasSize = UDim2.new(0, 0, 0, layoutHeight)
    end
    Block.UpdateHeight = updateHeight
    UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateHeight)

    CollapseBtn.MouseButton1Click:Connect(function()
        Block.Expanded = not Block.Expanded
        CollapseBtn.Text = Block.Expanded and "-" or "+"
        smoothTween(CollapseBtn, DUR_NORMAL, { Rotation = Block.Expanded and 0 or 180 })
        smoothTween(CollapseBtn, DUR_FAST, { TextColor3 = Block.Expanded and Library.Theme.Text or Library.Theme.TextDim })

        if Block.Expanded then
            Content.Visible = true
            ResizeGrip.Visible = true
            Frame.Size = UDim2.new(0, Block.CustomWidth or 245, 0, Block.CustomHeight or 360)
        else
            Content.Visible = false
            ResizeGrip.Visible = false
            Frame.Size = UDim2.new(0, Block.CustomWidth or 245, 0, 38)
        end
    end)

    Block.ActiveSubTab = nil
    Block.SubTabButtons = {}
    Block.RegisteredSubTabs = {}

    local function registerElement(elemData, explicitSubTab)
        local activeSub = explicitSubTab or Block.ActiveSubTab
        if activeSub then
            elemData.SubTab = string.upper(tostring(activeSub))
            if Block.ActiveSubTab then
                local isMatch = (elemData.SubTab == string.upper(tostring(Block.ActiveSubTab)))
                elemData.Frame.Visible = isMatch
            else
                elemData.Frame.Visible = true
            end
        else
            elemData.Frame.Visible = true
        end
        table.insert(Block.Elements, elemData)
    end

    function Block:AddSubTabs(tabList, callback, ...)
        if type(tabList) == "string" then
            local args = { tabList, callback, ... }
            local newTabs = {}
            local cb = nil
            for _, arg in ipairs(args) do
                if type(arg) == "string" then
                    table.insert(newTabs, arg)
                elseif type(arg) == "function" then
                    cb = arg
                end
            end
            tabList = newTabs
            if cb then callback = cb end
        end

        if type(tabList) ~= "table" or #tabList == 0 then return end
        Block.RegisteredSubTabs = tabList

        local existingHolder = Content:FindFirstChild("SubTabHolder")
        if existingHolder then existingHolder:Destroy() end

        local SubTabHolder = Instance.new("Frame")
        SubTabHolder.Name = "SubTabHolder"
        SubTabHolder.Size = UDim2.new(1, 0, 0, 26)
        SubTabHolder.BackgroundColor3 = Library.Theme.Card
        SubTabHolder.BorderSizePixel = 0
        SubTabHolder.ZIndex = 12
        SubTabHolder.Parent = Content
        addCorner(SubTabHolder, 6)

        local SubTabStroke = Instance.new("UIStroke")
        SubTabStroke.Color = Library.Theme.Stroke
        SubTabStroke.Transparency = 0.3
        SubTabStroke.Thickness = 1
        SubTabStroke.Parent = SubTabHolder

        local SubListLayout = Instance.new("UIListLayout")
        SubListLayout.FillDirection = Enum.FillDirection.Horizontal
        SubListLayout.SortOrder = Enum.SortOrder.LayoutOrder
        SubListLayout.Padding = UDim.new(0, 3)
        SubListLayout.Parent = SubTabHolder

        local SubPadding = Instance.new("UIPadding")
        SubPadding.PaddingTop = UDim.new(0, 3)
        SubPadding.PaddingBottom = UDim.new(0, 3)
        SubPadding.PaddingLeft = UDim.new(0, 3)
        SubPadding.PaddingRight = UDim.new(0, 3)
        SubPadding.Parent = SubTabHolder

        local numTabs = #tabList
        for i, tabName in ipairs(tabList) do
            local strTabName = tostring(tabName)
            local TabBtn = Instance.new("TextButton")
            TabBtn.Name = "SubTab_" .. strTabName
            TabBtn.Size = UDim2.new(1 / numTabs, -(math.floor((numTabs - 1) * 3 / numTabs)), 1, 0)
            TabBtn.BackgroundColor3 = (i == 1) and Library.Theme.Header or Library.Theme.Block
            TabBtn.BorderSizePixel = 0
            TabBtn.Font = Library.Fonts.Label
            TabBtn.Text = strTabName
            TabBtn.TextColor3 = (i == 1) and Color3.fromRGB(225, 235, 250) or Color3.fromRGB(130, 142, 160)
            TabBtn.TextSize = 10
            TabBtn.ZIndex = 13
            TabBtn.Parent = SubTabHolder
            addCorner(TabBtn, 5)

            local TabBtnStroke = Instance.new("UIStroke")
            TabBtnStroke.Color = (i == 1) and Color3.fromRGB(90, 110, 140) or Library.Theme.Stroke
            TabBtnStroke.Transparency = (i == 1) and 0.2 or 0.6
            TabBtnStroke.Thickness = 1
            TabBtnStroke.Parent = TabBtn

            Block.SubTabButtons[strTabName] = { Button = TabBtn, Stroke = TabBtnStroke }

            TabBtn.MouseEnter:Connect(function()
                local isSel = (string.upper(tostring(strTabName)) == string.upper(tostring(Block.ActiveSubTab or "")))
                if not isSel then
                    smoothTween(TabBtn, DUR_FAST, { BackgroundColor3 = Library.Theme.CardHover, TextColor3 = Color3.fromRGB(180, 195, 215) })
                end
            end)

            TabBtn.MouseLeave:Connect(function()
                local isSel = (string.upper(tostring(strTabName)) == string.upper(tostring(Block.ActiveSubTab or "")))
                if not isSel then
                    smoothTween(TabBtn, DUR_FAST, { BackgroundColor3 = Library.Theme.Block, TextColor3 = Color3.fromRGB(130, 142, 160) })
                end
            end)

            TabBtn.MouseButton1Click:Connect(function()
                Block:SetCurrentSubTab(strTabName)
                if callback then callback(strTabName) end
            end)
        end

        Block.ActiveSubTab = string.upper(tostring(tabList[1]))
        task.defer(updateHeight)
        return SubTabHolder
    end

    function Block:AddSubTab(tabName, callback)
        if type(tabName) == "table" then
            return Block:AddSubTabs(tabName, callback)
        end
        local currentList = Block.RegisteredSubTabs or {}
        local found = false
        for _, name in ipairs(currentList) do
            if string.upper(tostring(name)) == string.upper(tostring(tabName)) then
                found = true
                break
            end
        end
        if not found then
            table.insert(currentList, tostring(tabName))
            Block:AddSubTabs(currentList, callback)
        end
        Block:SetCurrentSubTab(tabName)
        return Block
    end
    Block.CreateTab = Block.AddSubTab
    Block.AddTab = Block.AddSubTab
    Block.CreateSubTab = Block.AddSubTab
    Block.CreateSubTabs = Block.AddSubTabs

    function Block:SetCurrentSubTab(tabName)
        if not tabName then return end
        local targetName = string.upper(tostring(tabName))
        Block.ActiveSubTab = targetName

        for name, data in pairs(Block.SubTabButtons) do
            local isSelected = (string.upper(tostring(name)) == targetName)
            smoothTween(data.Button, DUR_FAST, {
                BackgroundColor3 = isSelected and Library.Theme.Header or Library.Theme.Block,
                TextColor3 = isSelected and Color3.fromRGB(225, 235, 250) or Color3.fromRGB(130, 142, 160)
            })
            smoothTween(data.Stroke, DUR_FAST, {
                Color = isSelected and Color3.fromRGB(90, 110, 140) or Library.Theme.Stroke,
                Transparency = isSelected and 0.2 or 0.6
            })
        end

        for _, elemData in ipairs(Block.Elements) do
            if elemData.SubTab then
                local shouldShow = (string.upper(tostring(elemData.SubTab)) == targetName)
                elemData.Frame.Visible = shouldShow
            end
        end

        task.defer(updateHeight)
    end


    function Block:AddSection(text)
        return Block:AddLabel(text)
    end

    function Block:AddLabel(text)
        local LabelFrame = Instance.new("Frame")
        LabelFrame.Size = UDim2.new(1, 0, 0, 22)
        LabelFrame.BackgroundTransparency = 1
        LabelFrame.Parent = Content

        local Dot = Instance.new("Frame")
        Dot.Size = UDim2.new(0, 3, 0, 10)
        Dot.Position = UDim2.new(0, 2, 0.5, -5)
        Dot.BackgroundColor3 = Library.Theme.Accent
        Dot.BorderSizePixel = 0
        Dot.Parent = LabelFrame
        addCorner(Dot, 2)

        local TextLabel = Instance.new("TextLabel")
        TextLabel.Size = UDim2.new(1, -12, 1, 0)
        TextLabel.Position = UDim2.new(0, 10, 0, 0)
        TextLabel.BackgroundTransparency = 1
        TextLabel.Font = Library.Fonts.Header
        TextLabel.Text = string.upper(text)
        TextLabel.TextColor3 = Library.Theme.AccentDim
        TextLabel.TextSize = 9.5
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left
        TextLabel.Parent = LabelFrame

        registerElement({ Type = "Label", Frame = LabelFrame })
    end

    function Block:AddToggle(name, default, callback, defaultKey, defaultMode)
        callback = callback or function() end
        local state = default or false
        local boundInput = defaultKey or Enum.KeyCode.Unknown
        local mode = defaultMode or "Toggle"
        local listening = false

        local ToggleBtn = Instance.new("TextButton")
        ToggleBtn.Name = name .. "_Toggle"
        ToggleBtn.Size = UDim2.new(1, 0, 0, 34)
        ToggleBtn.BackgroundColor3 = Library.Theme.Card
        ToggleBtn.BorderSizePixel = 0
        ToggleBtn.AutoButtonColor = false
        ToggleBtn.Text = ""
        ToggleBtn.Parent = Content
        addCorner(ToggleBtn, 5)

        local Stroke = Instance.new("UIStroke")
        Stroke.Color = Library.Theme.Stroke
        Stroke.Thickness = 1
        Stroke.Parent = ToggleBtn

        ToggleBtn.MouseEnter:Connect(function()
            smoothTween(ToggleBtn, DUR_FAST, { BackgroundColor3 = Library.Theme.CardHover })
            smoothTween(Stroke, DUR_FAST, { Color = Color3.fromRGB(255, 255, 255) })
        end)
        ToggleBtn.MouseLeave:Connect(function()
            smoothTween(ToggleBtn, DUR_FAST, { BackgroundColor3 = Library.Theme.Card })
            smoothTween(Stroke, DUR_FAST, { Color = Library.Theme.Stroke })
        end)

        ToggleBtn.ClipsDescendants = true

        local hasKeybind = (defaultKey ~= nil and defaultKey ~= Enum.KeyCode.Unknown)

        local Label = Instance.new("TextLabel")
        Label.Size = hasKeybind and UDim2.new(1, -135, 1, 0) or UDim2.new(1, -50, 1, 0)
        Label.Position = UDim2.new(0, 10, 0, 0)
        Label.BackgroundTransparency = 1
        Label.Font = Library.Fonts.Label
        Label.Text = name
        Label.TextColor3 = state and Library.Theme.Text or Library.Theme.TextDim
        Label.TextSize = 11.5
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.TextTruncate = Enum.TextTruncate.AtEnd
        Label.Parent = ToggleBtn

        local KeyBadgeBtn = Instance.new("TextButton")
        KeyBadgeBtn.Name = "KeyBadge"
        KeyBadgeBtn.Size = UDim2.new(0, 85, 0, 18)
        KeyBadgeBtn.Position = UDim2.new(1, -129, 0.5, -9)
        KeyBadgeBtn.BackgroundColor3 = Library.Theme.Header
        KeyBadgeBtn.BorderSizePixel = 0
        KeyBadgeBtn.Font = Library.Fonts.Label
        KeyBadgeBtn.Text = "NONE"
        KeyBadgeBtn.TextColor3 = Color3.fromRGB(0, 210, 255)
        KeyBadgeBtn.TextSize = 9
        KeyBadgeBtn.ZIndex = 6
        KeyBadgeBtn.Visible = hasKeybind
        KeyBadgeBtn.Parent = ToggleBtn
        addCorner(KeyBadgeBtn, 4)

        local SwitchBg = Instance.new("Frame")
        SwitchBg.Size = UDim2.new(0, 32, 0, 18)
        SwitchBg.Position = UDim2.new(1, -40, 0.5, -9)
        SwitchBg.BackgroundColor3 = state and Library.Theme.Accent or Library.Theme.Header
        SwitchBg.BorderSizePixel = 0
        SwitchBg.ZIndex = 6
        SwitchBg.Parent = ToggleBtn
        addCorner(SwitchBg, 9)

        local SwitchStroke = Instance.new("UIStroke")
        SwitchStroke.Color = state and Library.Theme.Accent or Library.Theme.Stroke
        SwitchStroke.Thickness = 1
        SwitchStroke.Parent = SwitchBg

        local Knob = Instance.new("Frame")
        Knob.Size = UDim2.new(0, 14, 0, 14)
        Knob.Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
        Knob.BackgroundColor3 = state and Library.Theme.Background or Library.Theme.TextDim
        Knob.BorderSizePixel = 0
        Knob.ZIndex = 7
        Knob.Parent = SwitchBg
        addCorner(Knob, 7)

        local ModePopup = Instance.new("Frame")
        ModePopup.Name = "ModePopup_" .. name
        ModePopup.Size = UDim2.new(0, 88, 0, 70)
        ModePopup.BackgroundColor3 = Library.Theme.Block
        ModePopup.BorderSizePixel = 0
        ModePopup.Visible = false
        ModePopup.ZIndex = 150
        ModePopup.Parent = Container

        local PopupStroke = Instance.new("UIStroke")
        PopupStroke.Color = Library.Theme.StrokeActive
        PopupStroke.Thickness = 1.2
        PopupStroke.Parent = ModePopup

        local PopupPadding = Instance.new("UIPadding")
        PopupPadding.PaddingTop = UDim.new(0, 3)
        PopupPadding.PaddingBottom = UDim.new(0, 3)
        PopupPadding.PaddingLeft = UDim.new(0, 3)
        PopupPadding.PaddingRight = UDim.new(0, 3)
        PopupPadding.Parent = ModePopup

        local PopupLayout = Instance.new("UIListLayout")
        PopupLayout.SortOrder = Enum.SortOrder.LayoutOrder
        PopupLayout.Padding = UDim.new(0, 2)
        PopupLayout.Parent = ModePopup

        local modes = { "Toggle", "Hold", "Always" }
        local modeBtns = {}

        local function getKeyName(inp)
            if not inp or inp == Enum.KeyCode.Unknown then return "NONE" end
            if typeof(inp) == "EnumItem" then
                if inp.EnumType == Enum.UserInputType then
                    if inp == Enum.UserInputType.MouseButton1 then return "MB1"
                    elseif inp == Enum.UserInputType.MouseButton2 then return "MB2"
                    elseif inp == Enum.UserInputType.MouseButton3 then return "MB3"
                    else return string.upper(inp.Name) end
                elseif inp.EnumType == Enum.KeyCode then
                    return string.upper(inp.Name)
                end
            end
            return "NONE"
        end

        local function updateKeyDisplay()
            local keyStr = getKeyName(boundInput)
            if keyStr == "NONE" and mode ~= "Always" then
                KeyBadgeBtn.Text = "NONE"
            elseif mode == "Always" then
                KeyBadgeBtn.Text = "ALWAYS"
            else
                KeyBadgeBtn.Text = keyStr .. " [" .. string.upper(tostring(mode)) .. "]"
            end

            if keyStr ~= "NONE" or mode == "Always" then
                Library.KeybindList[name] = {
                    Key = (mode == "Always" and "ALWAYS" or keyStr),
                    Mode = mode,
                    Active = state
                }
            else
                Library.KeybindList[name] = nil
            end

            if Library.RefreshKeybindHUD then Library:RefreshKeybindHUD() end
        end

        for _, m in ipairs(modes) do
            local MBtn = Instance.new("TextButton")
            MBtn.Size = UDim2.new(1, 0, 0, 20)
            MBtn.BackgroundColor3 = (m == mode) and Library.Theme.Header or Library.Theme.Card
            MBtn.BorderSizePixel = 0
            MBtn.Font = Library.Fonts.Badge
            MBtn.Text = m
            MBtn.TextColor3 = (m == mode) and Library.Theme.Accent or Library.Theme.TextDim
            MBtn.TextSize = 9
            MBtn.ZIndex = 152
            MBtn.Parent = ModePopup
            modeBtns[m] = MBtn

            MBtn.MouseButton1Click:Connect(function()
                mode = m
                for mName, btn in pairs(modeBtns) do
                    btn.BackgroundColor3 = (mName == mode) and Library.Theme.Header or Library.Theme.Card
                    btn.TextColor3 = (mName == mode) and Library.Theme.Accent or Library.Theme.TextDim
                end
                updateKeyDisplay()
                ModePopup.Visible = false
            end)
        end

        updateKeyDisplay()

        local function updateToggle(fireCallback)
            if fireCallback == nil then fireCallback = true end
            smoothTween(SwitchBg, DUR_NORMAL, { BackgroundColor3 = state and Library.Theme.Accent or Library.Theme.Header })
            smoothTween(SwitchStroke, DUR_NORMAL, { Color = state and Library.Theme.Accent or Library.Theme.Stroke })
            smoothTween(Knob, DUR_NORMAL, {
                Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7),
                BackgroundColor3 = state and Library.Theme.Background or Library.Theme.TextDim
            })
            smoothTween(Label, DUR_NORMAL, { TextColor3 = state and Library.Theme.Text or Library.Theme.TextDim })
            smoothTween(Stroke, DUR_NORMAL, { Color = state and Library.Theme.StrokeHover or Library.Theme.Stroke })

            if Library.KeybindList[name] then
                Library.KeybindList[name].Active = state
                if Library.RefreshKeybindHUD then Library:RefreshKeybindHUD() end
            end

            if fireCallback then
                task.spawn(function() pcall(callback, state) end)
            end
        end

        ToggleBtn.MouseEnter:Connect(function()
            smoothTween(ToggleBtn, DUR_FAST, { BackgroundColor3 = Library.Theme.CardHover })
            smoothTween(Stroke, DUR_FAST, { Color = state and Library.Theme.Accent or Library.Theme.StrokeHover })
            if not state then smoothTween(Label, DUR_FAST, { TextColor3 = Library.Theme.Text }) end
        end)

        ToggleBtn.MouseLeave:Connect(function()
            smoothTween(ToggleBtn, DUR_FAST, { BackgroundColor3 = Library.Theme.Card })
            smoothTween(Stroke, DUR_FAST, { Color = state and Library.Theme.StrokeHover or Library.Theme.Stroke })
            if not state then smoothTween(Label, DUR_FAST, { TextColor3 = Library.Theme.TextDim }) end
        end)

        ToggleBtn.MouseButton1Click:Connect(function()
            if listening then return end
            state = not state
            updateToggle(true)
        end)

        KeyBadgeBtn.MouseButton1Click:Connect(function()
            if listening then return end
            listening = true
            Library.ListeningKeybind = true
            KeyBadgeBtn.Text = "..."
            KeyBadgeBtn.TextColor3 = Library.Theme.TextDim
            smoothTween(Stroke, DUR_FAST, { Color = Library.Theme.Accent })
        end)

        KeyBadgeBtn.MouseButton2Click:Connect(function()
            if listening then return end
            ModePopup.Visible = not ModePopup.Visible
            if ModePopup.Visible then
                local btnPos = KeyBadgeBtn.AbsolutePosition
                local btnSize = KeyBadgeBtn.AbsoluteSize
                ModePopup.Position = UDim2.new(0, btnPos.X - 4, 0, btnPos.Y + btnSize.Y + 4)
                smoothTween(ModePopup, DUR_FAST, { Size = UDim2.new(0, 88, 0, 70) })
            end
        end)

        trackConnection(UserInputService.InputBegan:Connect(function(input)
            if ModePopup.Visible and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2) then
                local clickPos = input.Position
                local popPos = ModePopup.AbsolutePosition
                local popSize = ModePopup.AbsoluteSize
                if clickPos.X < popPos.X or clickPos.X > popPos.X + popSize.X or clickPos.Y < popPos.Y or clickPos.Y > popPos.Y + popSize.Y then
                    local btnPos = KeyBadgeBtn.AbsolutePosition
                    local btnSize = KeyBadgeBtn.AbsoluteSize
                    if not (clickPos.X >= btnPos.X and clickPos.X <= btnPos.X + btnSize.X and clickPos.Y >= btnPos.Y and clickPos.Y <= btnPos.Y + btnSize.Y) then
                        ModePopup.Visible = false
                    end
                end
            end
        end))

        local function isInputMatch(inp)
            if not boundInput or boundInput == Enum.KeyCode.Unknown then return false end
            if typeof(boundInput) == "EnumItem" then
                if boundInput.EnumType == Enum.KeyCode then
                    return inp.UserInputType == Enum.UserInputType.Keyboard and inp.KeyCode == boundInput
                elseif boundInput.EnumType == Enum.UserInputType then
                    return inp.UserInputType == boundInput
                end
            end
            return false
        end

        trackConnection(UserInputService.InputBegan:Connect(function(input, gpe)
            if listening then
                local validBind = nil
                if input.UserInputType == Enum.UserInputType.Keyboard then
                    if input.KeyCode == Enum.KeyCode.Escape or input.KeyCode == Enum.KeyCode.Backspace then
                        validBind = Enum.KeyCode.Unknown
                    else
                        validBind = input.KeyCode
                    end
                elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                    validBind = Enum.UserInputType.MouseButton1
                elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
                    validBind = Enum.UserInputType.MouseButton2
                elseif input.UserInputType == Enum.UserInputType.MouseButton3 then
                    validBind = Enum.UserInputType.MouseButton3
                end

                if validBind ~= nil then
                    boundInput = validBind
                    task.delay(0.05, function()
                        listening = false
                        Library.ListeningKeybind = false
                    end)
                    KeyBadgeBtn.TextColor3 = Library.Theme.Accent
                    smoothTween(Stroke, DUR_FAST, { Color = Library.Theme.Stroke })
                    updateKeyDisplay()
                end
            elseif not gpe and boundInput ~= Enum.KeyCode.Unknown then
                if isInputMatch(input) then
                    if mode == "Toggle" then
                        state = not state
                        updateToggle(true)
                    elseif mode == "Hold" then
                        state = true
                        updateToggle(true)
                    end
                end
            end
        end))

        trackConnection(UserInputService.InputEnded:Connect(function(input, gpe)
            if not gpe and boundInput ~= Enum.KeyCode.Unknown then
                if isInputMatch(input) then
                    if mode == "Hold" then
                        state = false
                        updateToggle(true)
                    end
                end
            end
        end))

        local elemData = {
            Type = "Toggle",
            Frame = ToggleBtn,
            Stroke = Stroke,
            SwitchBg = SwitchBg,
            Knob = Knob,
            Label = Label,
            KeyBadgeBtn = KeyBadgeBtn,
            ModePopup = ModePopup,
            PopupStroke = PopupStroke,
            GetState = function() return state end
        }
        registerElement(elemData)

        return {
            Set = function(_, newState)
                state = newState
                updateToggle(true)
            end,
            SetKeybind = function(_, newKey, newMode)
                if newKey then boundKey = newKey end
                if newMode then mode = newMode end
                updateKeyDisplay()
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
        addCorner(DropFrame, 6)

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

        HeaderBtn.MouseEnter:Connect(function()
            smoothTween(DropFrame, DUR_FAST, { BackgroundColor3 = Library.Theme.CardHover })
            smoothTween(Stroke, DUR_FAST, { Color = isOpen and Library.Theme.StrokeActive or Library.Theme.StrokeHover })
            smoothTween(Label, DUR_FAST, { TextColor3 = Library.Theme.Text })
        end)

        HeaderBtn.MouseLeave:Connect(function()
            smoothTween(DropFrame, DUR_FAST, { BackgroundColor3 = Library.Theme.Card })
            smoothTween(Stroke, DUR_FAST, { Color = isOpen and Library.Theme.StrokeActive or Library.Theme.Stroke })
            smoothTween(Label, DUR_FAST, { TextColor3 = Library.Theme.TextDim })
        end)

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
        addCorner(SelBadge, 4)

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
                    smoothTween(OptionContainer, DUR_NORMAL, { Size = UDim2.new(1, -16, 0, 0) })
                    smoothTween(DropFrame, DUR_NORMAL, { Size = UDim2.new(1, 0, 0, 36) })
                    smoothTween(Stroke, DUR_FAST, { Color = Library.Theme.Stroke })
                    updateHeight()
                end
            end
        }
        table.insert(Library.OpenDropdowns, dropdownObject)

        registerElement({
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
            smoothTween(OptionContainer, DUR_NORMAL, { Size = UDim2.new(1, -16, 0, optH) })
            smoothTween(DropFrame, DUR_NORMAL, { Size = UDim2.new(1, 0, 0, targetH) })
            smoothTween(Stroke, DUR_FAST, { Color = isOpen and Library.Theme.StrokeActive or Library.Theme.Stroke })
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
        BtnFrame.TextColor3 = Color3.fromRGB(225, 235, 250)
        BtnFrame.TextSize = 10.5
        BtnFrame.Parent = Content
        addCorner(BtnFrame, 6)

        local Stroke = Instance.new("UIStroke")
        Stroke.Color = Library.Theme.Stroke
        Stroke.Thickness = 1
        Stroke.Parent = BtnFrame

        registerElement({
            Type = "Button",
            Frame = BtnFrame,
            Stroke = Stroke
        })

        BtnFrame.MouseEnter:Connect(function()
            smoothTween(BtnFrame, DUR_FAST, { BackgroundColor3 = Library.Theme.CardHover })
            smoothTween(Stroke, DUR_FAST, { Color = Library.Theme.AccentDim })
        end)

        BtnFrame.MouseLeave:Connect(function()
            smoothTween(BtnFrame, DUR_FAST, { BackgroundColor3 = Library.Theme.Card })
            smoothTween(Stroke, DUR_FAST, { Color = Library.Theme.Stroke })
        end)

        BtnFrame.MouseButton1Click:Connect(function()
            local anim = smoothTween(BtnFrame, 0.06, { Size = UDim2.new(1, -4, 0, 30) }, EASE_SMOOTH, DIR_OUT)
            anim.Completed:Connect(function()
                smoothTween(BtnFrame, 0.1, { Size = UDim2.new(1, 0, 0, 32) }, EASE_SPRING, DIR_OUT)
            end)
            task.spawn(callback)
        end)
    end

    -- SLIDER WITH INTERACTIVE NUMBER TEXTBOX INPUT
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
        addCorner(SliderFrame, 6)

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
        addCorner(ValBadge, 4)

        local ValStroke = Instance.new("UIStroke")
        ValStroke.Color = Library.Theme.Stroke
        ValStroke.Thickness = 1
        ValStroke.Parent = ValBadge

        local ValInput = Instance.new("TextBox")
        ValInput.Size = UDim2.new(1, 0, 1, 0)
        ValInput.BackgroundTransparency = 1
        ValInput.Font = Library.Fonts.Label
        ValInput.Text = tostring(value)
        ValInput.TextColor3 = Color3.fromRGB(225, 235, 250)
        ValInput.TextSize = 10
        ValInput.TextXAlignment = Enum.TextXAlignment.Center
        ValInput.Active = true
        ValInput.Selectable = true
        ValInput.ClearTextOnFocus = false
        ValInput.ZIndex = 10
        ValInput.Parent = ValBadge

        local TrackBg = Instance.new("TextButton")
        TrackBg.Size = UDim2.new(1, -20, 0, 6)
        TrackBg.Position = UDim2.new(0, 10, 0, 30)
        TrackBg.BackgroundColor3 = Library.Theme.Header
        TrackBg.BorderSizePixel = 0
        TrackBg.AutoButtonColor = false
        TrackBg.Text = ""
        TrackBg.Parent = SliderFrame
        addCorner(TrackBg, 3)

        local Fill = Instance.new("Frame")
        local initRelX = (value - min) / (max - min)
        Fill.Size = UDim2.new(initRelX, 0, 1, 0)
        Fill.BackgroundColor3 = Library.Theme.Accent
        Fill.BorderSizePixel = 0
        Fill.Parent = TrackBg
        addCorner(Fill, 3)

        local Handle = Instance.new("Frame")
        Handle.Size = UDim2.new(0, 10, 0, 12)
        Handle.Position = UDim2.new(initRelX, -5, 0.5, -6)
        Handle.BackgroundColor3 = Library.Theme.Accent
        Handle.BorderSizePixel = 0
        Handle.Parent = TrackBg
        addCorner(Handle, 4)

        SliderFrame.MouseEnter:Connect(function()
            smoothTween(SliderFrame, DUR_FAST, { BackgroundColor3 = Library.Theme.CardHover })
            smoothTween(Stroke, DUR_FAST, { Color = Library.Theme.StrokeHover })
            smoothTween(Label, DUR_FAST, { TextColor3 = Library.Theme.Text })
            smoothTween(ValStroke, DUR_FAST, { Color = Library.Theme.StrokeActive })
        end)

        SliderFrame.MouseLeave:Connect(function()
            smoothTween(SliderFrame, DUR_FAST, { BackgroundColor3 = Library.Theme.Card })
            if not isDragging then
                smoothTween(Stroke, DUR_FAST, { Color = Library.Theme.Stroke })
            end
            smoothTween(Label, DUR_FAST, { TextColor3 = Library.Theme.TextDim })
            smoothTween(ValStroke, DUR_FAST, { Color = Library.Theme.Stroke })
        end)

        local isDragging = false

        local function setSliderVal(num, triggerCallback)
            num = math.clamp(math.floor(num + 0.5), min, max)
            value = num
            ValInput.Text = tostring(value)

            local relX = (max > min) and ((value - min) / (max - min)) or 0
            Fill.Size = UDim2.new(relX, 0, 1, 0)
            Handle.Position = UDim2.new(relX, -5, 0.5, -6)

            if triggerCallback then
                task.spawn(function() pcall(callback, value) end)
            end
        end

        ValInput.FocusLost:Connect(function(enterPressed)
            local parsed = tonumber(ValInput.Text)
            if parsed then
                setSliderVal(parsed, true)
            else
                ValInput.Text = tostring(value)
            end
        end)

        local function updateSliderPosition(inputX)
            local barWidth = TrackBg.AbsoluteSize.X
            if barWidth <= 0 then return end
            local relX = math.clamp((inputX - TrackBg.AbsolutePosition.X) / barWidth, 0, 1)
            local newValue = math.floor(min + (max - min) * relX + 0.5)

            Fill.Size = UDim2.new(relX, 0, 1, 0)
            Handle.Position = UDim2.new(relX, -5, 0.5, -6)

            if newValue ~= value then
                value = newValue
                ValInput.Text = tostring(value)
                task.spawn(function() pcall(callback, value) end)
            end
        end

        trackConnection(TrackBg.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                isDragging = true
                smoothTween(Stroke, DUR_FAST, { Color = Library.Theme.StrokeActive })
                updateSliderPosition(input.Position.X)
            end
        end))

        trackConnection(UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                if isDragging then
                    isDragging = false
                    smoothTween(Stroke, DUR_FAST, { Color = Library.Theme.Stroke })
                end
            end
        end))

        trackConnection(UserInputService.InputChanged:Connect(function(input)
            if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                updateSliderPosition(input.Position.X)
            end
        end))

        registerElement({
            Type = "Slider",
            Frame = SliderFrame,
            Stroke = Stroke,
            Label = Label,
            ValBadge = ValBadge,
            ValInput = ValInput
        })
    end

    -- KEYBIND WITH FULL MODE NAME DISPLAY (e.g. "F [TOGGLE]", "R [HOLD]", "ALWAYS")
    function Block:AddKeybind(name, defaultKey, callback)
        callback = callback or function() end
        local boundKey = defaultKey or Enum.KeyCode.Unknown
        local mode = "Toggle" -- Modes: "Toggle", "Hold", "Always"
        local activeState = false
        local listening = false

        local BindFrame = Instance.new("Frame")
        BindFrame.Name = name .. "_Keybind"
        BindFrame.Size = UDim2.new(1, 0, 0, 32)
        BindFrame.BackgroundColor3 = Library.Theme.Card
        BindFrame.BorderSizePixel = 0
        BindFrame.Parent = Content
        addCorner(BindFrame, 6)

        local Stroke = Instance.new("UIStroke")
        Stroke.Color = Library.Theme.Stroke
        Stroke.Thickness = 1
        Stroke.Parent = BindFrame

        BindFrame.MouseEnter:Connect(function()
            smoothTween(BindFrame, DUR_FAST, { BackgroundColor3 = Library.Theme.CardHover })
            smoothTween(Stroke, DUR_FAST, { Color = Library.Theme.StrokeHover })
            smoothTween(Label, DUR_FAST, { TextColor3 = Library.Theme.Text })
        end)

        BindFrame.MouseLeave:Connect(function()
            smoothTween(BindFrame, DUR_FAST, { BackgroundColor3 = Library.Theme.Card })
            if not listening then
                smoothTween(Stroke, DUR_FAST, { Color = Library.Theme.Stroke })
            end
            smoothTween(Label, DUR_FAST, { TextColor3 = Library.Theme.TextDim })
        end)

        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -105, 1, 0)
        Label.Position = UDim2.new(0, 10, 0, 0)
        Label.BackgroundTransparency = 1
        Label.Font = Library.Fonts.Label
        Label.Text = name
        Label.TextColor3 = Library.Theme.TextDim
        Label.TextSize = 11
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = BindFrame

        local KeyBtn = Instance.new("TextButton")
        KeyBtn.Size = UDim2.new(0, 92, 0, 20)
        KeyBtn.Position = UDim2.new(1, -98, 0.5, -10)
        KeyBtn.BackgroundColor3 = Library.Theme.Header
        KeyBtn.BorderSizePixel = 0
        KeyBtn.Font = Library.Fonts.Badge
        KeyBtn.Text = "NONE [TOGGLE]"
        KeyBtn.TextColor3 = Library.Theme.Accent
        KeyBtn.TextSize = 8.5
        KeyBtn.ZIndex = 10
        KeyBtn.Parent = BindFrame
        addCorner(KeyBtn, 4)

        -- CLEAN HEADER-LESS MODE POPUP MENU (3 BUTTONS)
        local ModePopup = Instance.new("Frame")
        ModePopup.Name = "ModePopup_" .. name
        ModePopup.Size = UDim2.new(0, 88, 0, 70)
        ModePopup.BackgroundColor3 = Library.Theme.Block
        ModePopup.BorderSizePixel = 0
        ModePopup.Visible = false
        ModePopup.ZIndex = 150
        ModePopup.Parent = Container
        addCorner(ModePopup, 6)

        local PopupStroke = Instance.new("UIStroke")
        PopupStroke.Color = Library.Theme.StrokeActive
        PopupStroke.Thickness = 1.2
        PopupStroke.Parent = ModePopup

        local PopupPadding = Instance.new("UIPadding")
        PopupPadding.PaddingTop = UDim.new(0, 3)
        PopupPadding.PaddingBottom = UDim.new(0, 3)
        PopupPadding.PaddingLeft = UDim.new(0, 3)
        PopupPadding.PaddingRight = UDim.new(0, 3)
        PopupPadding.Parent = ModePopup

        local PopupLayout = Instance.new("UIListLayout")
        PopupLayout.SortOrder = Enum.SortOrder.LayoutOrder
        PopupLayout.Padding = UDim.new(0, 2)
        PopupLayout.Parent = ModePopup

        local modes = { "Toggle", "Hold", "Always" }
        local modeBtns = {}

        local function updateDisplay()
            if mode == "Always" then
                KeyBtn.Text = "ALWAYS"
            else
                KeyBtn.Text = string.upper(boundKey.Name) .. " [" .. string.upper(mode) .. "]"
            end
            Library.KeybindList[name] = {
                Key = string.upper(boundKey.Name),
                Mode = mode
            }
            if Library.RefreshKeybindHUD then Library:RefreshKeybindHUD() end
        end

        for _, m in ipairs(modes) do
            local MBtn = Instance.new("TextButton")
            MBtn.Size = UDim2.new(1, 0, 0, 20)
            MBtn.BackgroundColor3 = (m == mode) and Library.Theme.Header or Library.Theme.Card
            MBtn.BorderSizePixel = 0
            MBtn.Font = Library.Fonts.Badge
            MBtn.Text = m
            MBtn.TextColor3 = (m == mode) and Library.Theme.Accent or Library.Theme.TextDim
            MBtn.TextSize = 9
            MBtn.ZIndex = 152
            MBtn.Parent = ModePopup
            modeBtns[m] = MBtn

            MBtn.MouseButton1Click:Connect(function()
                mode = m
                for mName, btn in pairs(modeBtns) do
                    btn.BackgroundColor3 = (mName == mode) and Library.Theme.Header or Library.Theme.Card
                    btn.TextColor3 = (mName == mode) and Library.Theme.Accent or Library.Theme.TextDim
                end
                updateDisplay()
                ModePopup.Visible = false
                if mode == "Always" then
                    activeState = true
                    task.spawn(function() pcall(callback, boundKey, mode, true) end)
                end
            end)
        end

        updateDisplay()

        local function toggleModePopup()
            ModePopup.Visible = not ModePopup.Visible
            if ModePopup.Visible then
                local btnPos = KeyBtn.AbsolutePosition
                local btnSize = KeyBtn.AbsoluteSize
                ModePopup.Position = UDim2.new(0, btnPos.X - 4, 0, btnPos.Y + btnSize.Y + 4)
                smoothTween(ModePopup, DUR_FAST, { Size = UDim2.new(0, 88, 0, 70) })
            end
        end

        -- Left Click: Set Key
        KeyBtn.MouseButton1Click:Connect(function()
            if ModePopup.Visible then ModePopup.Visible = false return end
            listening = true
            Library.ListeningKeybind = true
            KeyBtn.Text = "..."
            KeyBtn.TextColor3 = Library.Theme.TextDim
            smoothTween(Stroke, DUR_FAST, { Color = Library.Theme.Accent })
        end)

        -- Right Click: Open Unclipped Mode Menu
        KeyBtn.MouseButton2Click:Connect(function()
            toggleModePopup()
        end)

        BindFrame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton2 then
                toggleModePopup()
            end
        end)

        -- Close Mode Popup when clicking outside
        trackConnection(UserInputService.InputBegan:Connect(function(input)
            if ModePopup.Visible and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2) then
                local clickPos = input.Position
                local popPos = ModePopup.AbsolutePosition
                local popSize = ModePopup.AbsoluteSize
                if clickPos.X < popPos.X or clickPos.X > popPos.X + popSize.X or clickPos.Y < popPos.Y or clickPos.Y > popPos.Y + popSize.Y then
                    local btnPos = KeyBtn.AbsolutePosition
                    local btnSize = KeyBtn.AbsoluteSize
                    if not (clickPos.X >= btnPos.X and clickPos.X <= btnPos.X + btnSize.X and clickPos.Y >= btnPos.Y and clickPos.Y <= btnPos.Y + btnSize.Y) then
                        ModePopup.Visible = false
                    end
                end
            end
        end))

        registerElement({
            Type = "Keybind",
            Frame = BindFrame,
            Stroke = Stroke,
            Label = Label,
            KeyBtn = KeyBtn,
            ModePopup = ModePopup,
            PopupStroke = PopupStroke
        })

        -- Keyboard events handling Hold, Toggle, Always modes
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
                    KeyBtn.TextColor3 = Library.Theme.Accent
                    smoothTween(Stroke, DUR_FAST, { Color = Library.Theme.Stroke })

                    updateDisplay()
                    task.spawn(function() pcall(callback, boundKey, mode, activeState) end)
                end
            elseif not gpe and boundKey ~= Enum.KeyCode.Unknown then
                if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == boundKey then
                    if mode == "Toggle" then
                        activeState = not activeState
                    elseif mode == "Hold" then
                        activeState = true
                    end
                    if Library.KeybindList[name] then
                        Library.KeybindList[name].Active = activeState
                        if Library.RefreshKeybindHUD then Library:RefreshKeybindHUD() end
                    end
                    task.spawn(function() pcall(callback, boundKey, mode, activeState) end)
                end
            end
        end))

        trackConnection(UserInputService.InputEnded:Connect(function(input, gpe)
            if not gpe and boundKey ~= Enum.KeyCode.Unknown then
                if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == boundKey then
                    if mode == "Hold" then
                        activeState = false
                        if Library.KeybindList[name] then
                            Library.KeybindList[name].Active = false
                            if Library.RefreshKeybindHUD then Library:RefreshKeybindHUD() end
                        end
                        task.spawn(function() pcall(callback, boundKey, mode, false) end)
                    end
                end
            end
        end))
    end
    -- 1. REDESIGNED MULTI-SELECT COMPONENT
    function Block:AddMultiSelect(name, options, defaultSelected, callback)
        options = options or {}
        defaultSelected = defaultSelected or {}
        callback = callback or function() end

        local selectedMap = {}
        if type(defaultSelected) == "table" then
            for k, v in pairs(defaultSelected) do
                if type(k) == "number" then
                    selectedMap[v] = true
                elseif v == true then
                    selectedMap[k] = true
                end
            end
        end

        local MultiFrame = Instance.new("Frame")
        MultiFrame.Name = name .. "_MultiSelect"
        MultiFrame.Size = UDim2.new(1, 0, 0, 36)
        MultiFrame.BackgroundColor3 = Library.Theme.Card
        MultiFrame.BorderSizePixel = 0
        MultiFrame.ClipsDescendants = true
        MultiFrame.ZIndex = 5
        MultiFrame.Parent = Content
        addCorner(MultiFrame, 6)

        local Stroke = Instance.new("UIStroke")
        Stroke.Color = Library.Theme.Stroke
        Stroke.Thickness = 1
        Stroke.Parent = MultiFrame

        local HeaderBtn = Instance.new("TextButton")
        HeaderBtn.Size = UDim2.new(1, 0, 0, 36)
        HeaderBtn.BackgroundTransparency = 1
        HeaderBtn.Text = ""
        HeaderBtn.ZIndex = 6
        HeaderBtn.Parent = MultiFrame

        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -125, 1, 0)
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
        SelBadge.Size = UDim2.new(0, 110, 0, 20)
        SelBadge.Position = UDim2.new(1, -115, 0.5, -10)
        SelBadge.BackgroundColor3 = Library.Theme.Header
        SelBadge.BorderSizePixel = 0
        SelBadge.Font = Library.Fonts.Badge
        SelBadge.Text = "0 Selected"
        SelBadge.TextColor3 = Color3.fromRGB(225, 235, 250)
        SelBadge.TextSize = 9.5
        SelBadge.ZIndex = 6
        SelBadge.Parent = HeaderBtn
        addCorner(SelBadge, 4)

        local OptionContainer = Instance.new("Frame")
        OptionContainer.Size = UDim2.new(1, -16, 0, 0)
        OptionContainer.Position = UDim2.new(0, 8, 0, 36)
        OptionContainer.BackgroundTransparency = 1
        OptionContainer.ClipsDescendants = true
        OptionContainer.ZIndex = 7
        OptionContainer.Parent = MultiFrame

        local OptionLayout = Instance.new("UIListLayout")
        OptionLayout.SortOrder = Enum.SortOrder.LayoutOrder
        OptionLayout.Padding = UDim.new(0, 3)
        OptionLayout.Parent = OptionContainer

        local isOpen = false
        local function updateBadge()
            local selectedList = {}
            for _, opt in ipairs(options) do
                if selectedMap[opt] then table.insert(selectedList, opt) end
            end
            if #selectedList == 0 then
                SelBadge.Text = "None"
            elseif #selectedList == 1 then
                SelBadge.Text = selectedList[1]
            else
                SelBadge.Text = #selectedList .. " Selected"
            end
            task.spawn(function() pcall(callback, selectedMap, selectedList) end)
        end

        local function buildOptions()
            for _, child in ipairs(OptionContainer:GetChildren()) do
                if child:IsA("TextButton") then child:Destroy() end
            end
            for _, opt in ipairs(options) do
                local isSel = selectedMap[opt]
                local OptBtn = Instance.new("TextButton")
                OptBtn.Size = UDim2.new(1, 0, 0, 24)
                OptBtn.BackgroundColor3 = isSel and Library.Theme.Header or Library.Theme.Card
                OptBtn.BorderSizePixel = 0
                OptBtn.Text = ""
                OptBtn.ZIndex = 8
                OptBtn.Parent = OptionContainer
                addCorner(OptBtn, 4)

                local OptStroke = Instance.new("UIStroke")
                OptStroke.Color = isSel and Library.Theme.Accent or Library.Theme.Stroke
                OptStroke.Thickness = 1
                OptStroke.Parent = OptBtn

                local CheckSquare = Instance.new("Frame")
                CheckSquare.Size = UDim2.new(0, 14, 0, 14)
                CheckSquare.Position = UDim2.new(0, 7, 0.5, -7)
                CheckSquare.BackgroundColor3 = isSel and Library.Theme.Header or Library.Theme.Block
                CheckSquare.BorderSizePixel = 0
                CheckSquare.ZIndex = 9
                CheckSquare.Parent = OptBtn
                addCorner(CheckSquare, 3)

                local SquareStroke = Instance.new("UIStroke")
                SquareStroke.Color = isSel and Library.Theme.Accent or Library.Theme.Stroke
                SquareStroke.Thickness = 1
                SquareStroke.Parent = CheckSquare

                if isSel then
                    local CheckMark = Instance.new("TextLabel")
                    CheckMark.Size = UDim2.new(1, 0, 1, 0)
                    CheckMark.BackgroundTransparency = 1
                    CheckMark.Font = Library.Fonts.Badge
                    CheckMark.Text = "✓"
                    CheckMark.TextColor3 = Library.Theme.Accent
                    CheckMark.TextSize = 10
                    CheckMark.ZIndex = 10
                    CheckMark.Parent = CheckSquare
                end

                local OptLabel = Instance.new("TextLabel")
                OptLabel.Size = UDim2.new(1, -30, 1, 0)
                OptLabel.Position = UDim2.new(0, 28, 0, 0)
                OptLabel.BackgroundTransparency = 1
                OptLabel.Font = Library.Fonts.Label
                OptLabel.Text = opt
                OptLabel.TextColor3 = isSel and Color3.fromRGB(225, 235, 250) or Library.Theme.TextDim
                OptLabel.TextSize = 10.5
                OptLabel.TextXAlignment = Enum.TextXAlignment.Left
                OptLabel.ZIndex = 9
                OptLabel.Parent = OptBtn

                OptBtn.MouseButton1Click:Connect(function()
                    selectedMap[opt] = not selectedMap[opt]
                    buildOptions()
                    updateBadge()
                end)
            end
        end

        HeaderBtn.MouseButton1Click:Connect(function()
            isOpen = not isOpen
            if isOpen then
                buildOptions()
                local targetH = 36 + (#options * 27) + 6
                smoothTween(OptionContainer, DUR_NORMAL, { Size = UDim2.new(1, -16, 0, #options * 27) })
                smoothTween(MultiFrame, DUR_NORMAL, { Size = UDim2.new(1, 0, 0, targetH) })
                smoothTween(Stroke, DUR_FAST, { Color = Library.Theme.StrokeActive })
            else
                smoothTween(OptionContainer, DUR_NORMAL, { Size = UDim2.new(1, -16, 0, 0) })
                smoothTween(MultiFrame, DUR_NORMAL, { Size = UDim2.new(1, 0, 0, 36) })
                smoothTween(Stroke, DUR_FAST, { Color = Library.Theme.Stroke })
            end
            updateHeight()
        end)

        updateBadge()
        registerElement({
            Type = "MultiSelect",
            Frame = MultiFrame,
            Stroke = Stroke,
            Label = Label,
            SelBadge = SelBadge
        })
        return {
            GetSelected = function() return selectedMap end
        }
    end
    Block.AddMultiDropdown = Block.AddMultiSelect

    -- 2. MODERN COLORPIXEL (COLOR PICKER) WITH HSV CANVAS & HUE/VALUE SLIDERS (MATCHING USER PHOTO)
    function Block:AddColorPixel(name, defaultColor, position, callback)
        if type(position) == "function" then
            callback = position
            position = "right"
        end
        position = tostring(position or "right"):lower()
        defaultColor = defaultColor or Color3.fromRGB(0, 235, 255)
        callback = callback or function() end

        local currentColor = defaultColor
        local h, s, v = Color3.toHSV(currentColor)

        local PixelFrame = Instance.new("Frame")
        PixelFrame.Name = name .. "_ColorPixel"
        PixelFrame.Size = UDim2.new(1, 0, 0, 32)
        PixelFrame.BackgroundColor3 = Library.Theme.Card
        PixelFrame.BorderSizePixel = 0
        PixelFrame.ZIndex = 5
        PixelFrame.Parent = Content
        addCorner(PixelFrame, 6)

        local Stroke = Instance.new("UIStroke")
        Stroke.Color = Library.Theme.Stroke
        Stroke.Thickness = 1
        Stroke.Parent = PixelFrame

        local ColorPreview = Instance.new("TextButton")
        ColorPreview.Size = UDim2.new(0, 20, 0, 20)
        if position == "left" then
            ColorPreview.Position = UDim2.new(0, 8, 0.5, -10)
        else
            ColorPreview.Position = UDim2.new(1, -28, 0.5, -10)
        end
        ColorPreview.BackgroundColor3 = currentColor
        ColorPreview.BorderSizePixel = 0
        ColorPreview.Text = ""
        ColorPreview.ZIndex = 6
        ColorPreview.Parent = PixelFrame
        addCorner(ColorPreview, 6)

        local PreviewStroke = Instance.new("UIStroke")
        PreviewStroke.Color = Library.Theme.StrokeActive
        PreviewStroke.Thickness = 1
        PreviewStroke.Parent = ColorPreview

        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(1, -45, 1, 0)
        if position == "left" then
            Label.Position = UDim2.new(0, 34, 0, 0)
            Label.TextXAlignment = Enum.TextXAlignment.Left
        else
            Label.Position = UDim2.new(0, 10, 0, 0)
            Label.TextXAlignment = Enum.TextXAlignment.Left
        end
        Label.BackgroundTransparency = 1
        Label.Font = Library.Fonts.Label
        Label.Text = name
        Label.TextColor3 = Library.Theme.Text
        Label.TextSize = 10.5
        Label.ZIndex = 6
        Label.Parent = PixelFrame

        -- HSV Color Picker Popup Window
        local PickerPopup = Instance.new("Frame")
        PickerPopup.Name = "ColorPicker_" .. name
        PickerPopup.Size = UDim2.new(0, 210, 0, 205)
        PickerPopup.BackgroundColor3 = Library.Theme.Block
        PickerPopup.BorderSizePixel = 0
        PickerPopup.Visible = false
        PickerPopup.ZIndex = 600
        PickerPopup.Parent = ScreenGui
        addCorner(PickerPopup, 8)

        local PickerStroke = Instance.new("UIStroke")
        PickerStroke.Color = Library.Theme.StrokeActive
        PickerStroke.Thickness = 1.2
        PickerStroke.ZIndex = 601
        PickerStroke.Parent = PickerPopup

        -- Top Integrated Header Bar
        local PickerHeader = Instance.new("Frame")
        PickerHeader.Name = "PickerHeader"
        PickerHeader.Size = UDim2.new(1, 0, 0, 24)
        PickerHeader.BackgroundColor3 = Library.Theme.Header
        PickerHeader.BorderSizePixel = 0
        PickerHeader.ZIndex = 602
        PickerHeader.Parent = PickerPopup
        addCorner(PickerHeader, 8)

        local HeaderTitle = Instance.new("TextLabel")
        HeaderTitle.Size = UDim2.new(1, -30, 1, 0)
        HeaderTitle.Position = UDim2.new(0, 8, 0, 0)
        HeaderTitle.BackgroundTransparency = 1
        HeaderTitle.Font = Library.Fonts.Badge
        HeaderTitle.Text = "COLOR PICKER"
        HeaderTitle.TextColor3 = Library.Theme.TextDim
        HeaderTitle.TextSize = 9
        HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
        HeaderTitle.ZIndex = 603
        HeaderTitle.Parent = PickerHeader

        -- Built-in Header Close Button (X)
        local CloseBtn = Instance.new("TextButton")
        CloseBtn.Name = "CloseBtn"
        CloseBtn.Size = UDim2.new(0, 24, 1, 0)
        CloseBtn.Position = UDim2.new(1, -24, 0, 0)
        CloseBtn.BackgroundTransparency = 1
        CloseBtn.Font = Library.Fonts.Badge
        CloseBtn.Text = "✕"
        CloseBtn.TextColor3 = Library.Theme.TextDim
        CloseBtn.TextSize = 11
        CloseBtn.ZIndex = 604
        CloseBtn.Parent = PickerHeader

        CloseBtn.MouseEnter:Connect(function()
            smoothTween(CloseBtn, DUR_FAST, { TextColor3 = Color3.fromRGB(255, 80, 80) })
        end)
        CloseBtn.MouseLeave:Connect(function()
            smoothTween(CloseBtn, DUR_FAST, { TextColor3 = Library.Theme.TextDim })
        end)
        CloseBtn.MouseButton1Click:Connect(function()
            PickerPopup.Visible = false
        end)

        -- Saturation/Value Main Box Canvas
        local SatValBox = Instance.new("ImageLabel")
        SatValBox.Size = UDim2.new(0, 155, 0, 125)
        SatValBox.Position = UDim2.new(0, 8, 0, 30)
        SatValBox.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
        SatValBox.BorderSizePixel = 0
        SatValBox.Image = "rbxassetid://4155801252"
        SatValBox.ZIndex = 602
        SatValBox.Parent = PickerPopup
        addCorner(SatValBox, 4)

        local SatValCursor = Instance.new("Frame")
        SatValCursor.Size = UDim2.new(0, 10, 0, 10)
        SatValCursor.Position = UDim2.new(s, -5, 1 - v, -5)
        SatValCursor.BackgroundTransparency = 1
        SatValCursor.ZIndex = 603
        SatValCursor.Parent = SatValBox
        addCorner(SatValCursor, 5)

        local CursorStroke = Instance.new("UIStroke")
        CursorStroke.Color = Color3.fromRGB(255, 255, 255)
        CursorStroke.Thickness = 1.5
        CursorStroke.Parent = SatValCursor

        -- Vertical Rainbow Hue Slider (Right Bar)
        local HueBar = Instance.new("Frame")
        HueBar.Size = UDim2.new(0, 24, 0, 125)
        HueBar.Position = UDim2.new(0, 172, 0, 30)
        HueBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        HueBar.BorderSizePixel = 0
        HueBar.ZIndex = 602
        HueBar.Parent = PickerPopup
        addCorner(HueBar, 4)

        local HueGrad = Instance.new("UIGradient")
        HueGrad.Rotation = 90
        HueGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
            ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
            ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
            ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)),
            ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
            ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))
        })
        HueGrad.Parent = HueBar

        local HueCursor = Instance.new("Frame")
        HueCursor.Size = UDim2.new(1, 4, 0, 4)
        HueCursor.Position = UDim2.new(0, -2, h, -2)
        HueCursor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        HueCursor.BorderSizePixel = 0
        HueCursor.ZIndex = 603
        HueCursor.Parent = HueBar
        addCorner(HueCursor, 2)

        -- Bottom Value / Brightness Bar
        local ValBar = Instance.new("Frame")
        ValBar.Size = UDim2.new(0, 155, 0, 18)
        ValBar.Position = UDim2.new(0, 8, 0, 160)
        ValBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ValBar.BorderSizePixel = 0
        ValBar.ZIndex = 602
        ValBar.Parent = PickerPopup
        addCorner(ValBar, 4)

        local ValGrad = Instance.new("UIGradient")
        ValGrad.Rotation = 0
        ValGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
            ColorSequenceKeypoint.new(1, Color3.fromHSV(h, s, 1))
        })
        ValGrad.Parent = ValBar

        local ValCursor = Instance.new("Frame")
        ValCursor.Size = UDim2.new(0, 4, 1, 4)
        ValCursor.Position = UDim2.new(v, -2, 0, -2)
        ValCursor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ValCursor.BorderSizePixel = 0
        ValCursor.ZIndex = 603
        ValCursor.Parent = ValBar
        addCorner(ValCursor, 2)

        -- Live Hex Text Input Box & Small Preview Badge
        local HexBoxBg = Instance.new("Frame")
        HexBoxBg.Size = UDim2.new(0, 155, 0, 18)
        HexBoxBg.Position = UDim2.new(0, 8, 0, 180)
        HexBoxBg.BackgroundColor3 = Library.Theme.Header
        HexBoxBg.BorderSizePixel = 0
        HexBoxBg.ZIndex = 602
        HexBoxBg.Parent = PickerPopup
        addCorner(HexBoxBg, 4)

        local HexInput = Instance.new("TextBox")
        HexInput.Size = UDim2.new(1, -6, 1, 0)
        HexInput.Position = UDim2.new(0, 3, 0, 0)
        HexInput.BackgroundTransparency = 1
        HexInput.Font = Library.Fonts.Badge
        HexInput.Text = "#" .. currentColor:ToHex()
        HexInput.TextColor3 = Library.Theme.Accent
        HexInput.TextSize = 9.5
        HexInput.TextXAlignment = Enum.TextXAlignment.Center
        HexInput.ZIndex = 603
        HexInput.Parent = HexBoxBg

        local PickerPreview = Instance.new("Frame")
        PickerPreview.Size = UDim2.new(0, 24, 0, 38)
        PickerPreview.Position = UDim2.new(0, 172, 0, 160)
        PickerPreview.BackgroundColor3 = currentColor
        PickerPreview.BorderSizePixel = 0
        PickerPreview.ZIndex = 602
        PickerPreview.Parent = PickerPopup
        addCorner(PickerPreview, 4)

        local function updateColor(fireCallback)
            currentColor = Color3.fromHSV(h, s, v)
            ColorPreview.BackgroundColor3 = currentColor
            PickerPreview.BackgroundColor3 = currentColor
            SatValBox.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
            ValGrad.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
                ColorSequenceKeypoint.new(1, Color3.fromHSV(h, s, 1))
            })
            SatValCursor.Position = UDim2.new(s, -5, 1 - v, -5)
            HueCursor.Position = UDim2.new(0, -2, h, -2)
            ValCursor.Position = UDim2.new(v, -2, 0, -2)
            HexInput.Text = "#" .. currentColor:ToHex()
            if fireCallback then
                task.spawn(function() pcall(callback, currentColor) end)
            end
        end

        local draggingSatVal = false
        local draggingHue = false
        local draggingVal = false

        SatValBox.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                draggingSatVal = true
            end
        end)
        HueBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                draggingHue = true
            end
        end)
        ValBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                draggingVal = true
            end
        end)

        trackConnection(UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                draggingSatVal = false
                draggingHue = false
                draggingVal = false
            end
        end))

        trackConnection(UserInputService.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                if draggingSatVal then
                    local mousePos = UserInputService:GetMouseLocation()
                    local boxPos = SatValBox.AbsolutePosition
                    local boxSize = SatValBox.AbsoluteSize
                    s = math.clamp((mousePos.X - boxPos.X) / boxSize.X, 0, 1)
                    v = math.clamp(1 - ((mousePos.Y - 36 - boxPos.Y) / boxSize.Y), 0, 1)
                    updateColor(true)
                elseif draggingHue then
                    local mousePos = UserInputService:GetMouseLocation()
                    local barPos = HueBar.AbsolutePosition
                    local barSize = HueBar.AbsoluteSize
                    h = math.clamp((mousePos.Y - 36 - barPos.Y) / barSize.Y, 0, 1)
                    updateColor(true)
                elseif draggingVal then
                    local mousePos = UserInputService:GetMouseLocation()
                    local barPos = ValBar.AbsolutePosition
                    local barSize = ValBar.AbsoluteSize
                    v = math.clamp((mousePos.X - barPos.X) / barSize.X, 0, 1)
                    updateColor(true)
                end
            end
        end))

        HexInput.FocusLost:Connect(function()
            local hex = HexInput.Text:gsub("#", "")
            local ok, parsed = pcall(function() return Color3.fromHex(hex) end)
            if ok and parsed then
                h, s, v = Color3.toHSV(parsed)
                updateColor(true)
            end
        end)

        -- Close Button (X)
        local CloseBtn = Instance.new("TextButton")
        CloseBtn.Name = "CloseBtn"
        CloseBtn.Size = UDim2.new(0, 16, 0, 16)
        CloseBtn.Position = UDim2.new(1, -20, 0, 4)
        CloseBtn.BackgroundTransparency = 1
        CloseBtn.Font = Library.Fonts.Badge
        CloseBtn.Text = "✕"
        CloseBtn.TextColor3 = Library.Theme.TextDim
        CloseBtn.TextSize = 11
        CloseBtn.ZIndex = 605
        CloseBtn.Parent = PickerPopup

        CloseBtn.MouseEnter:Connect(function()
            smoothTween(CloseBtn, DUR_FAST, { TextColor3 = Color3.fromRGB(255, 80, 80) })
        end)
        CloseBtn.MouseLeave:Connect(function()
            smoothTween(CloseBtn, DUR_FAST, { TextColor3 = Library.Theme.TextDim })
        end)
        CloseBtn.MouseButton1Click:Connect(function()
            PickerPopup.Visible = false
        end)

        trackConnection(UserInputService.InputBegan:Connect(function(input)
            if PickerPopup.Visible and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 or input.UserInputType == Enum.UserInputType.Touch) then
                if draggingSatVal or draggingHue or draggingVal then return end
                local mousePos = UserInputService:GetMouseLocation()
                local popPos = PickerPopup.AbsolutePosition
                local popSize = PickerPopup.AbsoluteSize
                if mousePos.X < popPos.X or mousePos.X > popPos.X + popSize.X or (mousePos.Y - 36) < popPos.Y or (mousePos.Y - 36) > popPos.Y + popSize.Y then
                    local btnPos = ColorPreview.AbsolutePosition
                    local btnSize = ColorPreview.AbsoluteSize
                    if not (mousePos.X >= btnPos.X and mousePos.X <= btnPos.X + btnSize.X and (mousePos.Y - 36) >= btnPos.Y and (mousePos.Y - 36) <= btnPos.Y + btnSize.Y) then
                        PickerPopup.Visible = false
                    end
                end
            end
        end))

        ColorPreview.MouseButton1Click:Connect(function()
            PickerPopup.Visible = not PickerPopup.Visible
            if PickerPopup.Visible then
                local prevPos = ColorPreview.AbsolutePosition
                local prevSize = ColorPreview.AbsoluteSize
                PickerPopup.Position = UDim2.new(0, prevPos.X - 190, 0, prevPos.Y + prevSize.Y + 6)
            end
        end)

        registerElement({
            Type = "ColorPixel",
            Frame = PixelFrame,
            Stroke = Stroke,
            Label = Label,
            ColorPreview = ColorPreview
        })

        return {
            SetColor = function(_, newColor)
                currentColor = newColor
                h, s, v = Color3.toHSV(currentColor)
                updateColor(true)
            end,
            GetColor = function() return currentColor end
        }
    end
    Block.AddColorPicker = Block.AddColorPixel

    -- 3. TEXTBAR (SIMPLE TEXT INPUT)
    function Block:AddTextBar(name, defaultText, placeholder, callback)
        if type(placeholder) == "function" then
            callback = placeholder
            placeholder = "Enter text..."
        end
        defaultText = defaultText or ""
        placeholder = placeholder or "Enter text..."
        callback = callback or function() end

        local TextFrame = Instance.new("Frame")
        TextFrame.Name = name .. "_TextBar"
        TextFrame.Size = UDim2.new(1, 0, 0, 34)
        TextFrame.BackgroundColor3 = Library.Theme.Card
        TextFrame.BorderSizePixel = 0
        TextFrame.ZIndex = 5
        TextFrame.Parent = Content
        addCorner(TextFrame, 6)

        local Stroke = Instance.new("UIStroke")
        Stroke.Color = Library.Theme.Stroke
        Stroke.Thickness = 1
        Stroke.Parent = TextFrame

        local Label = Instance.new("TextLabel")
        Label.Size = UDim2.new(0.4, 0, 1, 0)
        Label.Position = UDim2.new(0, 10, 0, 0)
        Label.BackgroundTransparency = 1
        Label.Font = Library.Fonts.Label
        Label.Text = name
        Label.TextColor3 = Library.Theme.TextDim
        Label.TextSize = 10.5
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.ZIndex = 6
        Label.Parent = TextFrame

        local InputBg = Instance.new("Frame")
        InputBg.Size = UDim2.new(0.55, -5, 0, 22)
        InputBg.Position = UDim2.new(0.45, 0, 0.5, -11)
        InputBg.BackgroundColor3 = Library.Theme.Header
        InputBg.BorderSizePixel = 0
        InputBg.ZIndex = 6
        InputBg.Parent = TextFrame
        addCorner(InputBg, 4)

        local TextInput = Instance.new("TextBox")
        TextInput.Size = UDim2.new(1, -8, 1, 0)
        TextInput.Position = UDim2.new(0, 4, 0, 0)
        TextInput.BackgroundTransparency = 1
        TextInput.Font = Library.Fonts.Badge
        TextInput.PlaceholderText = placeholder
        TextInput.PlaceholderColor3 = Library.Theme.TextDim
        TextInput.Text = defaultText
        TextInput.TextColor3 = Library.Theme.Accent
        TextInput.TextSize = 10
        TextInput.TextXAlignment = Enum.TextXAlignment.Left
        TextInput.ClearTextOnFocus = false
        TextInput.ZIndex = 7
        TextInput.Parent = InputBg

        TextInput.FocusLost:Connect(function(enterPressed)
            task.spawn(function() pcall(callback, TextInput.Text, enterPressed) end)
        end)

        registerElement({
            Type = "TextBar",
            Frame = TextFrame,
            Stroke = Stroke,
            Label = Label,
            InputBg = InputBg,
            TextInput = TextInput
        })

        return {
            SetText = function(_, txt)
                TextInput.Text = tostring(txt or "")
                task.spawn(function() pcall(callback, TextInput.Text, false) end)
            end,
            GetText = function() return TextInput.Text end
        }
    end
    Block.AddInput = Block.AddTextBar
    Block.AddTextBox = Block.AddTextBar

    function Block:AddSection(sectionTitle, subTab)
        local SectionFrame = Instance.new("Frame")
        SectionFrame.Name = sectionTitle .. "_Section"
        SectionFrame.Size = UDim2.new(1, 0, 0, 22)
        SectionFrame.BackgroundTransparency = 1
        SectionFrame.Parent = Content

        registerElement({ Type = "Section", Frame = SectionFrame }, subTab)

        local Line = Instance.new("Frame")
        Line.Size = UDim2.new(1, -16, 0, 1)
        Line.Position = UDim2.new(0, 8, 0.5, 0)
        Line.BackgroundColor3 = Library.Theme.Stroke
        Line.BorderSizePixel = 0
        Line.Parent = SectionFrame

        local TitleBg = Instance.new("Frame")
        TitleBg.AutomaticSize = Enum.AutomaticSize.X
        TitleBg.Size = UDim2.new(0, 0, 0, 14)
        TitleBg.Position = UDim2.new(0, 14, 0.5, -7)
        TitleBg.BackgroundColor3 = Library.Theme.Block
        TitleBg.BorderSizePixel = 0
        TitleBg.Parent = SectionFrame

        local TitleLbl = Instance.new("TextLabel")
        TitleLbl.AutomaticSize = Enum.AutomaticSize.X
        TitleLbl.Size = UDim2.new(0, 0, 1, 0)
        TitleLbl.BackgroundTransparency = 1
        TitleLbl.Font = Library.Fonts.Badge
        TitleLbl.Text = " " .. string.upper(sectionTitle) .. " "
        TitleLbl.TextColor3 = Library.Theme.Accent
        TitleLbl.TextSize = 8.5
        TitleLbl.Parent = TitleBg

        updateHeight()
        return SectionFrame
    end

    function Block:AddGroupbox(title)
        Block:AddSection(title)
        return Block
    end
    Block.AddLeftGroupbox = Block.AddGroupbox
    Block.AddRightGroupbox = Block.AddGroupbox
    Block.CreateWindow = Block.AddGroupbox

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
