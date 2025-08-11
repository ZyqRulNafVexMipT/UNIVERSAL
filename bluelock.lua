local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/BexruzScripts/Blue-lock-no-cd-reo-get-any-style-script.-WORKS-WITH-WORLD-CLASSES-/refs/heads/main/Rayfieldmod2'))()

local Window = Rayfield:CreateWindow({
   Name = "VortX Hub",
   Icon = 0,
   LoadingTitle = "VortX Hub",
   LoadingSubtitle = "By Owner Of VortX",
   Theme = "DarkBluemod",

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,

   ConfigurationSaving = {
      Enabled = false,
      FolderName = Exuso_r,
      FileName = "Exuso r"
   },

   Discord = {
      Enabled = true,
      Invite = "https://discord.gg/aVYJBJce",
      RememberJoins = true
   },

   KeySystem = false,
   KeySettings = {
      Title = "Exuso Hub",
      Subtitle = "A one time key system. (Link copied)",
      Note = "Discord link copied to clipboard! Paste in browser to get the key.",
      FileName = "ExusoKey",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"EXUSO621", "EXPERM2", "292"}
   }
})

Rayfield:Notify({
   Title = "Key system",
   Content = "Correct Key!",
   Duration = 1
})

Rayfield:Notify({
   Title = "Discord server",
   Content = "copied to clipboard! ",
   Duration = 6
})


local Tab = Window:CreateTab("Home", nil) 
local Section = Tab:CreateSection("Home")

Tab:CreateButton({
    Name = "spawn legendary",
    Callback = function()
        local args = {
 "Legendary"
}
game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("BuyGuarenteedCharacter"):FireServer(unpack(args))
    end,
})

Tab:CreateButton({
    Name = "spawn Mythic",
    Callback = function()
        local args = {
 "Mythic"
}
game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("BuyGuarenteedCharacter"):FireServer(unpack(args))
    end,
})

Tab:CreateButton({
    Name = "spawn World Class",
    Callback = function()
        local args = {
 "WorldClass"
}
game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("BuyGuarenteedCharacter"):FireServer(unpack(args))
    end,
})

Tab:CreateButton({
    Name = "spawn Exclusive",
    Callback = function()
        local args = {
 "Exclusive"
}
game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("BuyGuarenteedCharacter"):FireServer(unpack(args))
    end,
})

Tab:CreateButton({
    Name = "spawn Secret",
    Callback = function()
        local args = {
 "Secret"
}
game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("BuyGuarenteedCharacter"):FireServer(unpack(args))
    end,
})

local Tab = Window:CreateTab("events spawner", nil) 
local Section = Tab:CreateSection("ok")

Tab:CreateButton({
    Name = "start NEL event",
    Callback = function()
   game:GetService("ReplicatedStorage").Events.StartNELEvent:FireServer(nigga)
    end,
})

Tab:CreateButton({
    Name = "add server luck 15m",
    Callback = function()
 game:GetService("ReplicatedStorage").Events.AddServerLuck:FireServer(nigga)
    end,
})

Tab:CreateButton({
    Name = "start meme event",
    Callback = function()
local args = {
 "nigga"
}
game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("StartMemeEvent"):FireServer(unpack(args))
    end,
})

Tab:CreateButton({
    Name = "start summer event",
    Callback = function()
 local args = {
 "Nigga"
}
game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("StartSummerEvent"):FireServer(unpack(args))
    end,
})
