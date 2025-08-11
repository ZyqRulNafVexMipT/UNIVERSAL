local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/BexruzScripts/Blue-lock-no-cd-reo-get-any-style-script.-WORKS-WITH-WORLD-CLASSES-/refs/heads/main/Rayfieldmod2'))()

local Window = Rayfield:CreateWindow({
   Name = "Exuso Hub",
   Icon = 0,
   LoadingTitle = "VortX Hub",
   LoadingSubtitle = "By Owner Of VortX",
   Theme = "DarkBluemod",
   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,
   ConfigurationSaving = {
      Enabled = false,
      FolderName = "Exuso_r",
      FileName = "Exuso r"
   },
   Discord = {
      Enabled = true,
      Invite = "https://discord.gg/aVYJBJce",
      RememberJoins = true
   },
local Tab = Window:CreateTab("Home", nil)
local Section = Tab:CreateSection("Home")

local isSpamming = false
Tab:CreateToggle({
    Name = "freeze rope",
    CurrentValue = false,
    Callback = function(value)
        isSpamming = value
        task.spawn(function()
            while isSpamming do
                game:GetService("ReplicatedStorage"):WaitForChild("Frontman_Remotes"):WaitForChild("green"):FireServer()
                task.wait(0.4)
            end
        end)
    end
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")

Tab:CreateButton({
    Name = "Fling All",
    Callback = function()
        local purchaseArgs = {0, "Overkill"}
        RS:WaitForChild("Gamepasses_Remotes"):WaitForChild("PurchaseShop"):FireServer(unpack(purchaseArgs))
        task.wait(0.2)
        local remotePath = LocalPlayer:WaitForChild("Backpack"):WaitForChild("OverGlove"):WaitForChild("Event")
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local args = {
                    "slash",
                    player.Character,
                    Vector3.new(-9999999999999, 9999999999, 999999999999)
                }
                remotePath:FireServer(unpack(args))
            end
        end
    end
})

Tab:CreateButton({
    Name = "kill all (DO NOT BUY FRONTMAN OR IT WILL STOP WORKING)",
    Callback = function()
        RS:WaitForChild("Frontman_Remotes"):WaitForChild("red"):FireServer()
    end
})

Tab:CreateButton({
    Name = "get inf money real 100%",
    Callback = function()
        local args = {"inf"}
        RS:WaitForChild("CratesUtilities"):WaitForChild("Remotes"):WaitForChild("GiveReward"):FireServer(unpack(args))
    end
})

Tab:CreateButton({
    Name = "get a random gear",
    Callback = function()
        local args = {
 "9999999"
}
game:GetService("ReplicatedStorage"):WaitForChild("FreeGear_Remotes"):WaitForChild("FreeGearEvent"):FireServer(unpack(args))
    end
})
