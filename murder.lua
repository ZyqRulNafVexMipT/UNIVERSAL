-- MVSD - Xeric v2
-- by Crackl on scriptblox.

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

-- Player
local localPlayer = Players.LocalPlayer

-- Configuration
_G.HeadSize       = 5
_G.HitboxEnabled   = false
_G.ESPEnabled      = false
_G.CooldownValue   = 0
_G.WalkSpeed       = 16
_G.AutoExecute     = false

-- UI Setup (Rayfield)
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
local window = Rayfield:CreateWindow({
    LoadingTitle       = "MVSD - VortX",
    Name               = "VortX - MVSD V1",
    LoadingSubtitle    = "BY VORTX",
    Theme              = "Amethyst",
    KeySystem          = false,
    Discord = {
        Enabled        = true,
        RememberJoins  = true,
        Invite         = "https://discord.gg/aVYJBJce"
    },
    ConfigurationSaving = {
        Enabled        = true,
        FolderName     = "MVSDXeric",
        FileName       = "Config"
    }
})

-- Main Tab
local mainTab = window:CreateTab("Main", "user")
mainTab:CreateDivider("Hitbox & ESP Controls")

-- Hitbox size slider
local hitboxSlider = mainTab:CreateSlider({
    Name         = "Hitbox Size",
    CurrentValue = _G.HeadSize,
    Range        = {1, 100},
    Increment    = 1,
    Suffix       = "studs",
    Flag         = "HitboxSize",
    Callback     = function(value)
        _G.HeadSize = value
    end
})

-- Toggle hitbox modification
local hitboxToggle = mainTab:CreateToggle({
    Name         = "Enable Hitbox Modification",
    CurrentValue = _G.HitboxEnabled,
    Flag         = "HitboxEnabled",
    Callback     = function(enabled)
        _G.HitboxEnabled = enabled
    end
})

-- Toggle ESP
local espToggle = mainTab:CreateToggle({
    Name         = "Enable ESP",
    CurrentValue = _G.ESPEnabled,
    Flag         = "ESPEnabled",
    Callback     = function(enabled)
        _G.ESPEnabled = enabled
    end
})

-- Reset to defaults
mainTab:CreateButton({
    Name     = "Reset to Default",
    Callback = function()
        hitboxSlider:Set(5)
        hitboxToggle:Set(false)
        espToggle:Set(false)
        cooldownSlider:Set(0)
        walkSpeedSlider:Set(16)
        autoExecToggle:Set(false)
    end
})

-- Tool Cooldown Controls
mainTab:CreateDivider("Tool Cooldown Controls")
local cooldownSlider = mainTab:CreateSlider({
    Name         = "Cooldown",
    CurrentValue = _G.CooldownValue,
    Range        = {0, 2.5},
    Increment    = 0.1,
    Suffix       = "s",
    Flag         = "CooldownValue",
    Callback     = function(value)
        _G.CooldownValue = value
        -- Apply cooldown to all tools in backpack and character
        local backpack = localPlayer:WaitForChild("Backpack", 5)
        if backpack then
            for _, tool in ipairs(backpack:GetChildren()) do
                if tool:IsA("Tool") and tool:GetAttribute("Cooldown") then
                    tool:SetAttribute("Cooldown", value)
                end
            end
        end
        if localPlayer.Character then
            for _, tool in ipairs(localPlayer.Character:GetChildren()) do
                if tool:IsA("Tool") and tool:GetAttribute("Cooldown") then
                    tool:SetAttribute("Cooldown", value)
                end
            end
        end
    end
})

mainTab:CreateButton({
    Name     = "Check Cooldowns",
    Callback = function()
        local backpack = localPlayer:WaitForChild("Backpack", 5)
        if backpack then
            for _, tool in ipairs(backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    print(tool.Name .. ": " .. tostring(tool:GetAttribute("Cooldown")))
                end
            end
        end
        if localPlayer.Character then
            for _, tool in ipairs(localPlayer.Character:GetChildren()) do
                if tool:IsA("Tool") then
                    print(tool.Name .. ": " .. tostring(tool:GetAttribute("Cooldown")))
                end
            end
        end
    end
})

-- Movement Controls
mainTab:CreateDivider("Movement Controls")
local walkSpeedSlider = mainTab:CreateSlider({
    Name         = "WalkSpeed",
    CurrentValue = _G.WalkSpeed,
    Range        = {16, 250},
    Increment    = 1,
    Suffix       = "studs/s",
    Flag         = "WalkSpeed",
    Callback     = function(value)
        _G.WalkSpeed = value
        if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
            localPlayer.Character.Humanoid.WalkSpeed = value
        end
    end
})

-- Auto Execute Controls
mainTab:CreateDivider("Auto Execute Controls")
local autoExecToggle = mainTab:CreateToggle({
    Name         = "Auto Execute",
    CurrentValue = _G.AutoExecute,
    Flag         = "AutoExecute",
    Callback     = function(enabled)
        _G.AutoExecute = enabled
        if enabled and syn and syn.queue_on_teleport then
            syn.queue_on_teleport(
                "loadstring(game:HttpGet(\"https://raw.githubusercontent.com/xeric-rblx/MVSD/refs/heads/main/MVSD.lua\"))()"
            )
        end
    end
})

-- ESP and Hitbox Updates
local function updateHitboxes()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            if _G.HitboxEnabled then
                hrp.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
                hrp.Transparency = 0.7
                hrp.BrickColor = BrickColor.new("Really blue")
                hrp.Material = Enum.Material.Neon
                hrp.CanCollide = false
            else
                -- Reset to default
                hrp.Size = Vector3.new(2, 2, 1)
                hrp.Transparency = 0
                hrp.Material = Enum.Material.SmoothPlastic
                hrp.CanCollide = true
            end
        end
    end

    if _G.ESPEnabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer then
                if not player:FindFirstChild("Highlight") then
                    local highlight = Instance.new("Highlight")
                    highlight.Adornee = player.Character
                    highlight.FillTransparency = 1
                    highlight.OutlineColor = Color3.fromRGB(0, 0, 255)
                    highlight.OutlineTransparency = 0
                    highlight.Parent = CoreGui
                end
            end
        end
    else
        for _, highlight in ipairs(CoreGui:GetDescendants()) do
            if highlight:IsA("Highlight") then
                highlight:Destroy()
            end
        end
    end
end

RunService.RenderStepped:Connect(updateHitboxes)

-- Ensure WalkSpeed on respawn
localPlayer.CharacterAdded:Connect(function(char)
    char:WaitForChild("Humanoid").WalkSpeed = _G.WalkSpeed
end)

-- Initial execution
if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then
    localPlayer.Character.Humanoid.WalkSpeed = _G.WalkSpeed
end

print("MVSD - VortX V1 loaded successfully!")
