-- Load Rayfield Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Create Rayfield Window
local Window = Rayfield:CreateWindow({
    Name = "Tank Game Simulator - Inf Upgrades",
    LoadingTitle = "Infinite Upgrades",
    LoadingSubtitle = "by VortX",
    Icon = 108632720139222,
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "TankGameSimulator",
        FileName = "InfUpgrades"
    },
    Discord = {
        Enabled = true,
        Invite = "6UaRDjBY42",
        RememberJoins = true
    },
    KeySystem = false,
    KeySettings = {
        Title = "Tank Game Simulator Keysystem",
        Subtitle = "Sorry I need more member :)",
        Note = "Get from discord server : discord.gg/6UaRDjBY42",
        FileName = "TankGameKey",
        SaveKey = false,
        GrabKeyFromSite = false,
        Key = {"TankGame-0001-111"}
    }
})

-- Global Variables
_G.InfUpgrades = false

-- Notification Function
local function Notification(title, content, duration)
    Rayfield:Notify({
        Title = title,
        Content = content,
        Duration = duration or 3,
        Image = 108632720139222
    })
end

-- Create Tabs
local MainTab = Window:CreateTab("Main")

-- Main Section
local MainSection = MainTab:CreateSection("Infinite Upgrades")

-- Toggle for Infinite Upgrades
local InfUpgradesToggle = MainTab:CreateToggle({
    Name = "Infinite Upgrades",
    CurrentValue = false,
    Flag = "InfUpgrades",
    Callback = function(Value)
        _G.InfUpgrades = Value
        if Value then
            Notification("Infinite Upgrades", "Infinite Upgrades enabled!", 3)
        else
            Notification("Infinite Upgrades", "Infinite Upgrades disabled!", 3)
        end
    end
})

-- Function to upgrade skills
local function UpgradeSkills()
    local skills = {
        "Body Damage",
        "Bullet Damage",
        "Bullet Penetration",
        "Health Regeneration",
        "Max Health",
        "Movement Speed",
        "Reload",
        "Shield"
    }
    for _, skill in ipairs(skills) do
        local args = { skill }
        game:GetService("ReplicatedStorage"):WaitForChild("Skills"):WaitForChild("Upgrade"):FireServer(unpack(args))
    end
end

-- Main loop for infinite upgrades
task.spawn(function()
    while wait() do
        if _G.InfUpgrades then
            game.Players.localPlayer.Character.Humanoid.JumpPower = 100
            game.Players.LocalPlayer.SkillPoints.Value = 1
            UpgradeSkills()
        end
    end
end)

-- Final notification
Rayfield:Notify({
    Title = "Tank Game Simulator",
    Content = "Script loaded successfully!",
    Duration = 5,
    Image = 108632720139222
})

-- Initialize
Rayfield:LoadConfiguration()
