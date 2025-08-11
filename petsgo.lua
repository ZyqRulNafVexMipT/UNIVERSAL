local VirtualInputManager = game:GetService("VirtualInputManager")
local playerGui = game:GetService("Players").LocalPlayer.PlayerGui
local button = playerGui.Main.Bottom.Buttons.Upgrades

if button and button:IsA("TextButton") then
    local pos = button.AbsolutePosition + button.AbsoluteSize / 2
    VirtualInputManager:SendMouseButtonEvent(pos.X, pos.Y, 0, true, game, 1)
    VirtualInputManager:SendMouseButtonEvent(pos.X, pos.Y, 0, false, game, 1)
end



local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local whiteScreenGui = Instance.new("ScreenGui")
whiteScreenGui.Name = "WhiteScreenGui"
whiteScreenGui.ResetOnSpawn = false
whiteScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
whiteScreenGui.IgnoreGuiInset = true
whiteScreenGui.Parent = playerGui

local whiteFrame = Instance.new("Frame")
whiteFrame.Size = UDim2.new(1, 0, 1, 0)
whiteFrame.BackgroundColor3 = Color3.new(1, 1, 1)
whiteFrame.BorderSizePixel = 0
whiteFrame.ZIndex = 110
whiteFrame.Parent = whiteScreenGui

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(0.8, 0, 0.1, 0)
textLabel.Position = UDim2.new(0.1, 0, 0.45, 0)
textLabel.BackgroundTransparency = 1
textLabel.TextColor3 = Color3.new(0, 0, 0)
textLabel.Font = Enum.Font.SourceSansBold
textLabel.TextSize = 36
textLabel.ZIndex = 111
textLabel.Text = "Please don't close Upgrades till You get a Notification saying Script Loaded"
textLabel.Parent = whiteScreenGui

wait(3)

whiteScreenGui:Destroy()



local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "VortX Hub: Pets Go Script" .. Fluent.Version,
    SubTitle = "BY Owner Of VortX",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

--Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home" }),
    Farm = Window:AddTab({ Title = "Farm", Icon = "sprout" }),
    Event = Window:AddTab({ Title = "Event", Icon = "calendar" }),
    Fishing = Window:AddTab({ Title = "Fishing", Icon = "sailboat" }),
    Farming = Window:AddTab({ Title = "Farming", Icon = "sun" }),
    Scrolls = Window:AddTab({ Title = "Scrolls", Icon = "scroll" }),
    Mine = Window:AddTab({ Title = "Mine", Icon = "bomb" }),
    Consume = Window:AddTab({ Title = "Consume", Icon = "apple" }),
    Thieving = Window:AddTab({ Title = "Thieving", Icon = "eye-off" }),
    Merchants = Window:AddTab({ Title = "Merchants", Icon = "shopping-cart" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

do



    _G.automine = false

    local Toggle = Tabs.Mine:AddToggle("automineall", {Title = "Auto Mine All", Default = false }) 
    
    Toggle:OnChanged(function()
        _G.automine = Options.automineall.Value
        print("Auto Mine:", _G.automine)
    
        if _G.automine then

            task.spawn(function()
                while _G.automine do
                    for i = 1, 10 do
                        local args = {i}
    
                        game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Mining_Attack"):InvokeServer(unpack(args))
                    end
    
                    wait(0.1)
                end
            end)
        end
    end)
    
    Options.automineall:SetValue(false)
    
    


    _G.automine = false

    local Toggle = Tabs.Mine:AddToggle("AutoMineDirtOre", {Title = "Auto Mine Dirt Ore", Default = false }) 
    
    Toggle:OnChanged(function()
        _G.automine = Options.AutoMineDirtOre.Value  -- Sync toggle state with _G.automine
        print("Auto Mine:", _G.automine)
    
        if _G.automine then
            -- Start mining in a new thread to prevent freezing
            task.spawn(function()
                while _G.automine do
                    local args = {
                        [1] = 6  -- Mining target (Dirt Ore)
                    }
    
                    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Mining_Attack"):InvokeServer(unpack(args))
    
                    wait(0.1)  -- Delay before the next mining attempt
                end
            end)
        end
    end)
    
    Options.AutoMineDirtOre:SetValue(false)  -- Ensure it starts as false
    



_G.automine5 = false
local Toggle5 = Tabs.Mine:AddToggle("AutoMine5", {Title = "Auto Mine Stone Ore", Default = false })
Toggle5:OnChanged(function()
    _G.automine5 = Options.AutoMine5.Value
    print("Auto Mine 5:", _G.automine5)

    if _G.automine5 then
        task.spawn(function()
            while _G.automine5 do
                local args = { [1] = 5 }
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Mining_Attack"):InvokeServer(unpack(args))
                wait(0.1)
            end
        end)
    end
end)




_G.automine3 = false
local Toggle3 = Tabs.Mine:AddToggle("AutoMine3", {Title = "Auto Mine Copper Ore", Default = false })
Toggle3:OnChanged(function()
    _G.automine3 = Options.AutoMine3.Value
    print("Auto Mine 3:", _G.automine3)

    if _G.automine3 then
        task.spawn(function()
            while _G.automine3 do
                local args = { [1] = 3 }
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Mining_Attack"):InvokeServer(unpack(args))
                wait(0.1)
            end
        end)
    end
end)




_G.automine2 = false
local Toggle2 = Tabs.Mine:AddToggle("AutoMine2", {Title = "Auto Mine Iron Ore", Default = false })
Toggle2:OnChanged(function()
    _G.automine2 = Options.AutoMine2.Value
    print("Auto Mine 2:", _G.automine2)

    if _G.automine2 then
        task.spawn(function()
            while _G.automine2 do
                local args = { [1] = 2 }
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Mining_Attack"):InvokeServer(unpack(args))
                wait(0.1)
            end
        end)
    end
end)




_G.automine1 = false
local Toggle1 = Tabs.Mine:AddToggle("AutoMine1", {Title = "Auto Mine Gold Ore", Default = false })
Toggle1:OnChanged(function()
    _G.automine1 = Options.AutoMine1.Value
    print("Auto Mine 1:", _G.automine1)

    if _G.automine1 then
        task.spawn(function()
            while _G.automine1 do
                local args = { [1] = 1 }
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Mining_Attack"):InvokeServer(unpack(args))
                wait(0.1)
            end
        end)
    end
end)




_G.automine4 = false
local Toggle4 = Tabs.Mine:AddToggle("AutoMine4", {Title = "Auto Mine Emerald Ore", Default = false })
Toggle4:OnChanged(function()
    _G.automine4 = Options.AutoMine4.Value
    print("Auto Mine 4:", _G.automine4)

    if _G.automine4 then
        task.spawn(function()
            while _G.automine4 do
                local args = { [1] = 4 }
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Mining_Attack"):InvokeServer(unpack(args))
                wait(0.1)
            end
        end)
    end
end)

-- Ensure all toggles start as false
Options.AutoMine5:SetValue(false)
Options.AutoMine3:SetValue(false)
Options.AutoMine2:SetValue(false)
Options.AutoMine1:SetValue(false)
Options.AutoMine4:SetValue(false)




_G.automine9_10 = false
local Toggle9_10 = Tabs.Mine:AddToggle("AutoMine9_10", {Title = "Auto Mine Obsidian Ore", Default = false }) 

Toggle9_10:OnChanged(function()
    _G.automine9_10 = Options.AutoMine9_10.Value
    print("Auto Mine 9 & 10:", _G.automine9_10)

    if _G.automine9_10 then
        task.spawn(function()
            -- Start mining for 9
            while _G.automine9_10 do
                local args9 = { [1] = 9 }
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Mining_Attack"):InvokeServer(unpack(args9))
                wait(0.1)
            end
        end)
        
        task.spawn(function()
            -- Start mining for 10
            while _G.automine9_10 do
                local args10 = { [1] = 10 }
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Mining_Attack"):InvokeServer(unpack(args10))
                wait(0.1)
            end
        end)
    end
end)

-- Ensure the toggle starts as false
Options.AutoMine9_10:SetValue(false)




_G.automine8_7 = false
local Toggle8_7 = Tabs.Mine:AddToggle("AutoMine8_7", {Title = "Auto Mine Runic Ore", Default = false }) 

Toggle8_7:OnChanged(function()
    _G.automine8_7 = Options.AutoMine8_7.Value
    print(".", _G.automine8_7)

    if _G.automine8_7 then
        task.spawn(function()
            -- Start mining for 8
            while _G.automine8_7 do
                local args8 = { [1] = 8 }
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Mining_Attack"):InvokeServer(unpack(args8))
                wait(0.1)
            end
        end)
        
        task.spawn(function()
            -- Start mining for 7
            while _G.automine8_7 do
                local args7 = { [1] = 7 }
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Mining_Attack"):InvokeServer(unpack(args7))
                wait(0.1)
            end
        end)
    end
end)

-- Ensure the toggle starts as false
Options.AutoMine8_7:SetValue(false)




_G.autoclaim = false  -- Start with the auto-claim turned off
local Toggle = Tabs.Merchants:AddToggle("AutoBuyMiningMerchant", {Title = "Auto Buy Mining Merchant", Default = false })

Toggle:OnChanged(function()
    _G.autoclaim = Options.AutoBuyMiningMerchant.Value
    print("Auto Buy Mining Merchant toggled:", _G.autoclaim)

    if _G.autoclaim then
        -- Start auto-buying from Mining Merchant when toggled on
        task.spawn(function()
            while _G.autoclaim do
                for i = 1, 8 do
                    local args = {
                        [1] = "MiningMerchant",  -- Merchant name
                        [2] = i                  -- Claim numbers from 1 to 8
                    }

                    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("CustomMerchants_Purchase"):InvokeServer(unpack(args))
                    wait(1)  -- Small delay before the next purchase
                end
            end
        end)
    end
end)

-- Ensure the toggle starts with 'false' (disabled)
Options.AutoBuyMiningMerchant:SetValue(false)




_G.autoclaimFishing = false  -- Start with the auto-claim turned off
local ToggleFishing = Tabs.Merchants:AddToggle("AutoBuyFishingMerchant", {Title = "Auto Buy Fishing Merchant", Default = false })

ToggleFishing:OnChanged(function()
    _G.autoclaimFishing = Options.AutoBuyFishingMerchant.Value
    print("Auto Buy Fishing Merchant toggled:", _G.autoclaimFishing)

    if _G.autoclaimFishing then
        -- Start auto-buying from Fishing Merchant when toggled on
        task.spawn(function()
            while _G.autoclaimFishing do
                for i = 1, 6 do
                    local args = {
                        [1] = "FishingMerchant",  -- Merchant name
                        [2] = i                  -- Claim numbers from 1 to 6
                    }

                    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("CustomMerchants_Purchase"):InvokeServer(unpack(args))
                    wait(1)  -- Small delay before the next purchase
                end
            end
        end)
    end
end)

-- Ensure the toggle starts with 'false' (disabled)
Options.AutoBuyFishingMerchant:SetValue(false)




_G.autoclaimBlackMarket = false  -- Start with the auto-claim turned off
local ToggleBlackMarket = Tabs.Merchants:AddToggle("AutoBuyBlackMarketMerchant", {Title = "Auto Buy Thieving Merchant", Default = false })

ToggleBlackMarket:OnChanged(function()
    _G.autoclaimBlackMarket = Options.AutoBuyBlackMarketMerchant.Value
    print("Auto Buy Black Market Merchant toggled:", _G.autoclaimBlackMarket)

    if _G.autoclaimBlackMarket then
        -- Start auto-buying from Black Market Merchant when toggled on
        task.spawn(function()
            while _G.autoclaimBlackMarket do
                for i = 1, 8 do
                    local args = {
                        [1] = "BlackMarketMerchant",  -- Merchant name
                        [2] = i                      -- Claim numbers from 1 to 8
                    }

                    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("CustomMerchants_Purchase"):InvokeServer(unpack(args))
                    wait(1)  -- Small delay before the next purchase
                end
            end
        end)
    end
end)

-- Ensure the toggle starts with 'false' (disabled)
Options.AutoBuyBlackMarketMerchant:SetValue(false)




_G.automineStandard = false  -- Start with the auto-buy turned off
local ToggleStandard = Tabs.Merchants:AddToggle("AutoBuyStandardMerchant", {Title = "Auto Buy Potions Merchant", Default = false })

ToggleStandard:OnChanged(function()
    _G.automineStandard = Options.AutoBuyStandardMerchant.Value
    print("Auto Buy Standard Merchant toggled:", _G.automineStandard)

    if _G.automineStandard then
        -- Start auto-buying from Standard Merchant when toggled on
        task.spawn(function()
            while _G.automineStandard do
                for i = 1, 6 do
                    local args = {
                        [1] = "StandardMerchant",  -- Merchant name
                        [2] = i                    -- Claim numbers from 1 to 6
                    }

                    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("CustomMerchants_Purchase"):InvokeServer(unpack(args))
                    wait(1)  -- Small delay before the next purchase
                end
            end
        end)
    end
end)

-- Ensure the toggle starts with 'false' (disabled)
Options.AutoBuyStandardMerchant:SetValue(false)




-- _G Toggle for Thieving ID 689
_G.autoThieve689 = false

-- Create the UI toggle for Thieving ID 689
local Toggle689 = Tabs.Thieving:AddToggle("AutoThieve689", {Title = "Auto Thieve Merchant 1", Default = false})

Toggle689:OnChanged(function()
    _G.autoThieve689 = Options.AutoThieve689.Value
    print("Auto Thieve ID 689 toggled:", _G.autoThieve689)

    if _G.autoThieve689 then
        task.spawn(function()
            while _G.autoThieve689 do
                local args = { [1] = 1280 }
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Thieving_Thieve"):InvokeServer(unpack(args))
                wait(1)
            end
        end)
    end
end)

Options.AutoThieve689:SetValue(false)  -- Ensure the toggle starts off




-- _G Toggle for Thieving ID 690
_G.autoThieve690 = false

-- Create the UI toggle for Thieving ID 690
local Toggle690 = Tabs.Thieving:AddToggle("AutoThieve690", {Title = "Auto Thieve Merchant 2", Default = false})

Toggle690:OnChanged(function()
    _G.autoThieve690 = Options.AutoThieve690.Value
    print("Auto Thieve ID 690 toggled:", _G.autoThieve690)

    if _G.autoThieve690 then
        task.spawn(function()
            while _G.autoThieve690 do
                local args = { [1] = 1281 }
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Thieving_Thieve"):InvokeServer(unpack(args))
                wait(1)
            end
        end)
    end
end)

Options.AutoThieve690:SetValue(false)  -- Ensure the toggle starts off




-- _G Toggle for Thieving ID 691
_G.autoThieve691 = false

-- Create the UI toggle for Thieving ID 691
local Toggle691 = Tabs.Thieving:AddToggle("AutoThieve691", {Title = "Auto Thieve Merchant 3", Default = false})

Toggle691:OnChanged(function()
    _G.autoThieve691 = Options.AutoThieve691.Value
    print("Auto Thieve ID 691 toggled:", _G.autoThieve691)

    if _G.autoThieve691 then
        task.spawn(function()
            while _G.autoThieve691 do
                local args = { [1] = 1282 }
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Thieving_Thieve"):InvokeServer(unpack(args))
                wait(1)
            end
        end)
    end
end)

Options.AutoThieve691:SetValue(false)  -- Ensure the toggle starts off



-- _G Toggle for Thieving ID 693
_G.autoThieve693 = false

-- Create the UI toggle for Thieving ID 693
local Toggle693 = Tabs.Thieving:AddToggle("AutoThieve693", {Title = "Auto Thieve Merchant 4", Default = false})

Toggle693:OnChanged(function()
    _G.autoThieve693 = Options.AutoThieve693.Value
    print("Auto Thieve ID 693 toggled:", _G.autoThieve693)

    if _G.autoThieve693 then
        task.spawn(function()
            while _G.autoThieve693 do
                local args = { [1] = 1276 }
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Thieving_Thieve"):InvokeServer(unpack(args))
                wait(1)
            end
        end)
    end
end)

Options.AutoThieve693:SetValue(false)  -- Ensure the toggle starts off




-- _G Toggle for Thieving ID 692
_G.autoThieve692 = false

-- Create the UI toggle for Thieving ID 692
local Toggle692 = Tabs.Thieving:AddToggle("AutoThieve692", {Title = "Auto Thieve Merchant 5", Default = false})

Toggle692:OnChanged(function()
    _G.autoThieve692 = Options.AutoThieve692.Value
    print("Auto Thieve ID 692 toggled:", _G.autoThieve692)

    if _G.autoThieve692 then
        task.spawn(function()
            while _G.autoThieve692 do
                local args = { [1] = 1275 }
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Thieving_Thieve"):InvokeServer(unpack(args))
                wait(1)
            end
        end)
    end
end)

Options.AutoThieve692:SetValue(false)  -- Ensure the toggle starts off




-- _G Toggle for Thieving ID 694
_G.autoThieve694 = false

-- Create the UI toggle for Thieving ID 694
local Toggle694 = Tabs.Thieving:AddToggle("AutoThieve694", {Title = "Auto Thieve Merchant 6", Default = false})

Toggle694:OnChanged(function()
    _G.autoThieve694 = Options.AutoThieve694.Value
    print("Auto Thieve ID 694 toggled:", _G.autoThieve694)

    if _G.autoThieve694 then
        task.spawn(function()
            while _G.autoThieve694 do
                local args = { [1] = 1277 }
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Thieving_Thieve"):InvokeServer(unpack(args))
                wait(1)
            end
        end)
    end
end)

Options.AutoThieve694:SetValue(false)  -- Ensure the toggle starts off




-- _G Toggle for Thieving ID 695
_G.autoThieve695 = false

-- Create the UI toggle for Thieving ID 695
local Toggle695 = Tabs.Thieving:AddToggle("AutoThieve695", {Title = "Auto Thieve Merchant 7", Default = false})

Toggle695:OnChanged(function()
    _G.autoThieve695 = Options.AutoThieve695.Value
    print("Auto Thieve ID 695 toggled:", _G.autoThieve695)

    if _G.autoThieve695 then
        task.spawn(function()
            while _G.autoThieve695 do
                local args = { [1] = 1278 }
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Thieving_Thieve"):InvokeServer(unpack(args))
                wait(1)
            end
        end)
    end
end)

Options.AutoThieve695:SetValue(false)  -- Ensure the toggle starts off




-- _G Toggle for Thieving ID 696
_G.autoThieve696 = false

-- Create the UI toggle for Thieving ID 696
local Toggle696 = Tabs.Thieving:AddToggle("AutoThieve696", {Title = "Auto Thieve Merchant 8", Default = false})

Toggle696:OnChanged(function()
    _G.autoThieve696 = Options.AutoThieve696.Value
    print("Auto Thieve ID 696 toggled:", _G.autoThieve696)

    if _G.autoThieve696 then
        task.spawn(function()
            while _G.autoThieve696 do
                local args = { [1] = 1279 }
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Thieving_Thieve"):InvokeServer(unpack(args))
                wait(1)
            end
        end)
    end
end)

Options.AutoThieve696:SetValue(false)  -- Ensure the toggle starts off




_G.auto = false

-- Create the UI toggle for Autoroll
local ToggleAutoRoll = Tabs.Main:AddToggle("AutoRoll", {Title = "Fast Auto Roll", Default = false})

ToggleAutoRoll:OnChanged(function()
    _G.auto = Options.AutoRoll.Value
    print("Auto Roll toggled:", _G.auto)

    if _G.auto then
        task.spawn(function()
            while _G.auto do
                local remoteFunc = game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Eggs_Roll")
                pcall(function()
                    remoteFunc:InvokeServer()
                end)
                wait(0.1)
            end
        end)
    end
end)

Options.AutoRoll:SetValue(false)  -- Ensure the toggle starts off




_G.automine = false

-- Create the UI toggle for Auto Claim Forever Pack
local ToggleAutoClaimForeverPack = Tabs.Main:AddToggle("AutoClaimForeverPack", {Title = "Auto Claim Free Forever Pack", Default = false})

ToggleAutoClaimForeverPack:OnChanged(function()
    _G.automine = Options.AutoClaimForeverPack.Value
    print("Auto Claim Forever Pack toggled:", _G.automine)

    if _G.automine then
        task.spawn(function()
            while _G.automine do
                local args = {
                    [1] = "Default"
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("ForeverPacks: Claim Free"):InvokeServer(unpack(args))
                wait(10)  -- Claim every 10 seconds
            end
        end)
    end
end)

Options.AutoClaimForeverPack:SetValue(false)  -- Ensure the toggle starts off




_G.automine = false

-- Create the UI toggle for Bonus Rolls Claim
local ToggleBonusRollsClaim = Tabs.Main:AddToggle("BonusRollsClaim", {Title = "Auto Claim Bonus Rolls", Default = false})

ToggleBonusRollsClaim:OnChanged(function()
    _G.automine = Options.BonusRollsClaim.Value
    print("Bonus Rolls Claim toggled:", _G.automine)

    if _G.automine then
        task.spawn(function()
            while _G.automine do
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Bonus Rolls: Claim"):InvokeServer()
                wait(10)  -- Claim every 10 seconds
            end
        end)
    end
end)

Options.BonusRollsClaim:SetValue(false)




_G.autominePotion = false  -- Start with the auto-buy turned off
local TogglePotion = Tabs.Main:AddToggle("AutoBuyPotionVendingMachine", {Title = "Auto Buy Potion Vending Machine", Default = false })

TogglePotion:OnChanged(function()
    _G.autominePotion = Options.AutoBuyPotionVendingMachine.Value
    print("Auto Buy Potion Vending Machine toggled:", _G.autominePotion)

    if _G.autominePotion then
        -- Start auto-buying from Potion Vending Machine when toggled on
        task.spawn(function()
            while _G.autominePotion do
                local args = {
                    [1] = "PotionVendingMachine"  -- Vending machine name
                }

                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("VendingMachines_Purchase"):InvokeServer(unpack(args))
                wait(1)  -- Delay between purchases to avoid spamming
            end
        end)
    end
end)

-- Ensure the toggle starts with 'false' (disabled)
Options.AutoBuyPotionVendingMachine:SetValue(false)




_G.automine = false

-- Create the UI toggle for Ice Fishing Merchant Auto Claim
local ToggleIceFishingMerchant = Tabs.Merchants:AddToggle("IceFishingMerchant", {Title = "Auto Buy Ice Fishing Merchant", Default = false})

ToggleIceFishingMerchant:OnChanged(function()
    _G.automine = Options.IceFishingMerchant.Value
    print("Ice Fishing Merchant Auto Claim toggled:", _G.automine)

    if _G.automine then
        task.spawn(function()
            while _G.automine do
                for i = 1, 6 do  -- Claim for items 1-6
                    local args = {
                        [1] = "IceFishingMerchant",
                        [2] = i
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("CustomMerchants_Purchase"):InvokeServer(unpack(args))
                    wait(0.75)  -- Claim every 10 seconds
                end
            end
        end)
    end
end)

Options.IceFishingMerchant:SetValue(false)  -- Ensure the toggle starts off




local ToggleFishingClaim = Tabs.Fishing:AddToggle("FishingClaimToggle", {Title = "Auto Claim Fishing Storage", Default = false})

-- Variable to track the toggle state
_G.automine = false

ToggleFishingClaim:OnChanged(function()
    _G.automine = Options.FishingClaimToggle.Value
    print("Fishing Auto Claim toggled:", _G.automine)

    if _G.automine then
        -- Run in a separate thread to prevent freezing
        task.spawn(function()
            while _G.automine do
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Fishing_FishermanClaim"):InvokeServer()
                wait(3)  -- Wait 3 seconds before claiming again
            end
        end)
    end
end)

Options.FishingClaimToggle:SetValue(false)  -- Ensure the toggle starts in the off position




Tabs.Scrolls:AddParagraph({
    Title = "Consume Mining Scrolls",
    Content = ""
})




_G.Consumable1AutoFarm = false

local Toggle1 = Tabs.Scrolls:AddToggle("AutoFarm_Consumable1", {Title = "Auto Consume Mining Loot Scroll", Default = false}) 
Toggle1:OnChanged(function()
    _G.Consumable1AutoFarm = Options.AutoFarm_Consumable1.Value
    if _G.Consumable1AutoFarm then
        while _G.Consumable1AutoFarm do
            local args = { "906cfdcfc402416e9291617b77a4eeb0", 1 }
            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Consumables_Consume"):InvokeServer(unpack(args))
            wait(1.5)
        end
    end
end)

Options.AutoFarm_Consumable1:SetValue(false)




_G.Consumable2AutoFarm = false

local Toggle2 = Tabs.Scrolls:AddToggle("AutoFarm_Consumable2", {Title = "Auto Consume Mining Damage Scroll", Default = false}) 
Toggle2:OnChanged(function()
    _G.Consumable2AutoFarm = Options.AutoFarm_Consumable2.Value
    if _G.Consumable2AutoFarm then
        while _G.Consumable2AutoFarm do
            local args = { "b607b9f4cf1d41408a7973173d798a41", 1 }
            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Consumables_Consume"):InvokeServer(unpack(args))
            wait(1.5)
        end
    end
end)

Options.AutoFarm_Consumable2:SetValue(false)




_G.Consumable3AutoFarm = false

local Toggle3 = Tabs.Scrolls:AddToggle("AutoFarm_Consumable3", {Title = "Auto Consume Mining Speed Scroll", Default = false}) 
Toggle3:OnChanged(function()
    _G.Consumable3AutoFarm = Options.AutoFarm_Consumable3.Value
    if _G.Consumable3AutoFarm then
        while _G.Consumable3AutoFarm do
            local args = { "fdfb140d16094475bb10d4a4129aa704", 1 }
            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Consumables_Consume"):InvokeServer(unpack(args))
            wait(1.5)
        end
    end
end)

Options.AutoFarm_Consumable3:SetValue(false)




Tabs.Scrolls:AddParagraph({
    Title = "Consume Thieving Scrolls",
    Content = ""
})




_G.Consumable1AutoFarm = false

local Toggle1 = Tabs.Scrolls:AddToggle("AutoFarm_Consumable1", {Title = "Auto Consume Thieving Success Scroll", Default = false})
Toggle1:OnChanged(function()
    _G.Consumable1AutoFarm = Options.AutoFarm_Consumable1.Value
    if _G.Consumable1AutoFarm then
        while _G.Consumable1AutoFarm do
            local args = { "1ff6558526b24ba794b66d2f8f87b439", 1 }
            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Consumables_Consume"):InvokeServer(unpack(args))
            wait(3)
        end
    end
end)

Options.AutoFarm_Consumable1:SetValue(false)




_G.Consumable2AutoFarm = false

local Toggle2 = Tabs.Scrolls:AddToggle("AutoFarm_Consumable2", {Title = "Auto Consume Thieving Luck Scroll", Default = false})
Toggle2:OnChanged(function()
    _G.Consumable2AutoFarm = Options.AutoFarm_Consumable2.Value
    if _G.Consumable2AutoFarm then
        while _G.Consumable2AutoFarm do
            local args = { "3fd77012e5b54f45a801ef52792d479f", 1 }
            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Consumables_Consume"):InvokeServer(unpack(args))
            wait(3)
        end
    end
end)

Options.AutoFarm_Consumable2:SetValue(false)




_G.Consumable3AutoFarm = false

local Toggle3 = Tabs.Scrolls:AddToggle("AutoFarm_Consumable3", {Title = "Auto Consume Thieving Speed Scroll", Default = false})
Toggle3:OnChanged(function()
    _G.Consumable3AutoFarm = Options.AutoFarm_Consumable3.Value
    if _G.Consumable3AutoFarm then
        while _G.Consumable3AutoFarm do
            local args = { "4ade382bb99e439db6b4870ce70d8984", 1 }
            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Consumables_Consume"):InvokeServer(unpack(args))
            wait(3)
        end
    end
end)

Options.AutoFarm_Consumable3:SetValue(false)




local Toggle = Tabs.Main:AddToggle("relicesp", {Title = "Relic Esp", Default = false})

local espObjects = {}

local function createESP(part)

    if part:IsA("BasePart") and not part:FindFirstChild("RelicESP") then

        local billboardGui = Instance.new("BillboardGui")
        billboardGui.Size = UDim2.new(0, 20, 0, 20)
        billboardGui.Adornee = part
        billboardGui.Parent = part

        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        frame.BackgroundTransparency = 0.5
        frame.BorderSizePixel = 0
        frame.Parent = billboardGui

        billboardGui.Enabled = true
        billboardGui.AlwaysOnTop = true

        table.insert(espObjects, billboardGui)
    end
end

local function espRelics()

    local relics = workspace.__THINGS.Relics:GetChildren()

    for _, relic in pairs(relics) do
        if relic.Name == "Relic" then
            createESP(relic)
        end
    end
end

Toggle:OnChanged(function()
    local toggleState = Toggle.Value
    if toggleState then

        espRelics()

    else

        for _, espObject in pairs(espObjects) do
            if espObject and espObject.Parent then
                espObject:Destroy()
            end
        end

        espObjects = {}
    end

    print("Toggle changed:", toggleState)
end)

Options.relicesp:SetValue(false)




local player = game.Players.LocalPlayer
local orbFolder = workspace.__THINGS.Orbs

-- Assuming you have a UI with a toggle to control teleportation
local Toggle = Tabs.Farm:AddToggle("TeleportToggle", {
    Title = "Auto Collect Orbs", 
    Default = false
})

local isTeleporting = false

-- Function to teleport the player to a specific part or mesh part
local function teleportToOrb(orb)
    if orb and orb.Parent == orbFolder then
        -- Teleport the player to the orb's position
        player.Character.HumanoidRootPart.CFrame = orb.CFrame
    end
end

-- Function to constantly teleport to orbs until they no longer exist
local function constantlyTeleportToOrbs()
    while isTeleporting do
        for _, orb in ipairs(orbFolder:GetChildren()) do
            -- Check for both Part and MeshPart types
            if (orb:IsA("Part") or orb:IsA("MeshPart")) and orb.Parent == orbFolder then
                teleportToOrb(orb)
                -- Wait before teleporting again
                wait(0.1)
            end
        end
        -- Re-check the orbs after a short delay
        wait(1)
    end
end

-- Toggle callback to enable/disable teleportation
Toggle:OnChanged(function(state)
    if state then
        -- Start teleporting if the toggle is on
        isTeleporting = true
        constantlyTeleportToOrbs()
    else
        -- Stop teleporting if the toggle is off
        isTeleporting = false
    end
end)




local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Network = ReplicatedStorage:WaitForChild("Network")
local Relic_Found = Network:WaitForChild("Relic_Found")

-- Function to collect relics from 1 to 50
local function collectRelics()
    for i = 1, 50 do
        local args = {i}
        -- Invoke the server to collect the relic
        Relic_Found:InvokeServer(unpack(args))
        wait(0.2)  -- Delay of 0.2 seconds between each collection
    end
    
    -- Show a notification when all relics are collected
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Relics Collected",
        Text = "All 50 relics have been collected!",
        Duration = 5 
    })
end

-- Add button to the UI
Tabs.Main:AddButton({
    Title = "Collect All Relics", 
    Callback = function()
        -- Start collecting relics when the button is clicked
        collectRelics()
    end
})




local Toggle = Tabs.Farm:AddToggle("autogiftteleport", {
    Title = "Auto Collect Hidden Gifts",
    Default = false
})

Toggle:OnChanged(function(state)
    getgenv().AutoGiftTeleport = state
    if state then
        task.spawn(function()
            while getgenv().AutoGiftTeleport do
                local player = game:GetService("Players").LocalPlayer
                local char = player.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")

                if hrp then
                    for _, model in ipairs(workspace.__THINGS.HiddenGifts:GetChildren()) do
                        if not getgenv().AutoGiftTeleport then break end
                        if model:IsA("Model") or model:IsA("Part") then
                            local targetPos = model:IsA("Model") and model:GetModelCFrame().Position or model.Position
                            hrp.CFrame = CFrame.new(targetPos + Vector3.new(0, 10, 0))
                            task.wait(0.8)
                        end
                    end
                end

                task.wait(1)
            end
        end)
    end
end)

Options.autogiftteleport:SetValue(false)




local Toggle = Tabs.Farm:AddToggle("autoTeleport", {Title = "Auto Collect Dig Marks", Default = false})

Toggle:OnChanged(function()
    print("Auto teleport toggle changed:", Options.autoTeleport.Value)
    
    -- Start coroutine to prevent blocking main thread
    task.spawn(function()
        while Options.autoTeleport.Value do
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local root = character:FindFirstChild("HumanoidRootPart")
            
            if root then
                -- Loop through all parts inside workspace.__THINGS.Digging
                for _, part in pairs(workspace.__THINGS.Digging:GetChildren()) do
                    if part:IsA("BasePart") then
                        -- Teleport to the part's position
                        root.CFrame = part.CFrame
                        task.wait(0.5) -- Delay to prevent teleporting too fast
                    end
                end
            end
            
            task.wait(0.1) -- Small delay before checking again
        end
    end)
end)

Options.autoTeleport:SetValue(false)  -- Set default value to false



local Toggle = Tabs.Merchants:AddToggle("autocavemerchant", {Title = "Auto Buy Cave Merchant", Default = false })

Toggle:OnChanged(function()
    print("Toggle changed:", Options.autocavemerchant.Value)

    if Options.autocavemerchant.Value then
        task.spawn(function()
            while Options.autocavemerchant.Value do
                for i = 1, 6 do
                    if not Options.autocavemerchant.Value then break end

                    local args = {
                        "CaveMerchant",
                        i
                    }

                    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("CustomMerchants_Purchase"):InvokeServer(unpack(args))
                    task.wait(0.1)
                end
            end
        end)
    end
end)

Options.autocavemerchant:SetValue(false)



local Toggle = Tabs.Mine:AddToggle("rubyoremine", {Title = "Auto Mine Ruby Ore", Default = false })

Toggle:OnChanged(function()
    print("Toggle changed:", Options.rubyoremine.Value)

    if Options.rubyoremine.Value then
        task.spawn(function()
            while Options.rubyoremine.Value do
                for _, id in ipairs({15, 12}) do
                    if not Options.rubyoremine.Value then break end

                    local args = {id}
                    game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Mining_Attack"):InvokeServer(unpack(args))
                    task.wait(0.1)
                end
            end
        end)
    end
end)

Options.rubyoremine:SetValue(false)



local Toggle = Tabs.Main:AddToggle("AutoHover", {Title = "Fast Spam Hoverboard - Annoy", Default = false})

Toggle:OnChanged(function()
    if not Options.AutoHover.Value then return end

    task.spawn(function()
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local Network = ReplicatedStorage:WaitForChild("Network")
        local EquipRemote = Network:WaitForChild("Hoverboard_RequestEquip")
        local UnequipRemote = Network:WaitForChild("Hoverboard_RequestUnequip")

        while Options.AutoHover.Value do
            EquipRemote:FireServer()
            task.wait(0.01) -- wait time after equip
            UnequipRemote:FireServer()
            task.wait(0.01) -- wait time after unequip
        end
    end)
end)

Options.AutoHover:SetValue(false)



local Toggle = Tabs.Farm:AddToggle("autobreakablesnotevent", {
    Title = "Auto Break Breakables",
    Default = false
})

Toggle:OnChanged(function()
    if not Options.autobreakablesnotevent.Value then return end

    task.spawn(function()
        local player = game.Players.LocalPlayer
        local remote = game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Breakables_PlayerDealDamage")
        local maxRadius = 350

        while Options.autobreakablesnotevent.Value do
            local character = player.Character or player.CharacterAdded:Wait()
            local root = character:FindFirstChild("HumanoidRootPart")
            if not root then
                task.wait(0.5)
                continue
            end

            -- Find closest valid model
            local closestModel, closestDistance = nil, math.huge
            for _, model in pairs(workspace.__THINGS.Breakables:GetChildren()) do
                if model:IsA("Model") and tonumber(model.Name) and model.Parent then
                    local part = model:FindFirstChild("PrimaryPart") or model:FindFirstChildWhichIsA("BasePart")
                    if part then
                        local dist = (part.Position - root.Position).Magnitude
                        if dist < closestDistance and dist <= maxRadius then
                            closestModel = model
                            closestDistance = dist
                        end
                    end
                end
            end

            -- Damage it once (not repeatedly)
            if closestModel then
                remote:FireServer(tonumber(closestModel.Name))
            end

            task.wait(0.01) -- Allow checking new closest model
        end
    end)
end)

Options.autobreakablesnotevent:SetValue(false)



local Toggle = Tabs.Farming:AddToggle("harvesttoggle", {Title = "Auto Harvest Closest Plant", Default = false})

local Harvest = game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Farming_Harvest")
local FarmPlants = workspace:WaitForChild("__THINGS"):WaitForChild("FarmPlants")
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

local function getClosestPlant()
    local closestModel = nil
    local closestDistance = math.huge

    if not localPlayer.Character or not localPlayer.Character:FindFirstChild("HumanoidRootPart") then
        return nil
    end

    local hrp = localPlayer.Character.HumanoidRootPart

    for _, model in ipairs(FarmPlants:GetChildren()) do
        if model:GetAttribute("UID") then
            local distance = (model:GetPivot().Position - hrp.Position).Magnitude
            if distance < closestDistance then
                closestDistance = distance
                closestModel = model
            end
        end
    end

    return closestModel
end

Toggle:OnChanged(function(enabled)
    if not enabled then return end

    while Options.harvesttoggle.Value do
        local plant = getClosestPlant()

        if plant then
            local uid = plant:GetAttribute("UID")
            if uid then
                pcall(function()
                    Harvest:InvokeServer(uid)
                end)
            end
        end

        wait(0.01)
    end
end)



local Toggle = Tabs.Farming:AddToggle("plantsbreak", {Title = "Auto Break Plants", Default = false})

local Network = game:GetService("ReplicatedStorage"):WaitForChild("Network")
local Breakables = workspace:WaitForChild("__THINGS"):WaitForChild("Breakables")
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

local function getClosestBreakable()
    local closestModel = nil
    local closestDistance = math.huge

    if not localPlayer.Character or not localPlayer.Character:FindFirstChild("HumanoidRootPart") then
        return nil
    end

    local hrp = localPlayer.Character.HumanoidRootPart

    for _, model in ipairs(Breakables:GetChildren()) do
        if model:GetAttribute("BreakableUID") then
            local distance = (model:GetPivot().Position - hrp.Position).Magnitude
            if distance < closestDistance then
                closestDistance = distance
                closestModel = model
            end
        end
    end

    return closestModel
end

Toggle:OnChanged(function(enabled)
    if not enabled then return end

    while Options.plantsbreak.Value do
        local breakable = getClosestBreakable()

        if breakable then
            local uid = breakable:GetAttribute("BreakableUID")
            if uid then
                pcall(function()
                    Network:WaitForChild("Breakables_PlayerDealDamage"):FireServer(uid)
                end)
            end
        end

        wait(0.01)
    end
end)



local Toggle = Tabs.Farming:AddToggle("autofarmplants", {Title = "Fast Auto Farm Plants", Default = false})

local Network = game:GetService("ReplicatedStorage"):WaitForChild("Network")

Toggle:OnChanged(function(enabled)
    while Options.autofarmplants.Value do
        pcall(function()
            Network:WaitForChild("Farming_AutoFarm"):FireServer()
        end)
        wait(0.01)
    end
end)



local Toggle = Tabs.Farming:AddToggle("autpuchas", {Title = "Auto Buy out Farming Merchant", Default = false})

local Network = game:GetService("ReplicatedStorage"):WaitForChild("Network")

Toggle:OnChanged(function(enabled)
    spawn(function()
        while Options.autpuchas.Value do
            for i = 1, 6 do
                pcall(function()
                    Network:WaitForChild("CustomMerchants_Purchase"):InvokeServer("FarmingMerchant", i)
                end)
                wait(0.9)
            end
        end
    end)
end)



local Toggle = Tabs.Main:AddToggle("autoupgradeee", {Title = "Auto Upgrade", Default = false})

local UpgradesFolder = workspace.__THINGS.Upgrades["Upgrades Frontend Render"]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PurchaseEvent = ReplicatedStorage:WaitForChild("Network"):WaitForChild("Upgrades_Purchase")

local isRunning = false

local function purchaseUpgrade(upgradeName)
    pcall(function()
        PurchaseEvent:InvokeServer(upgradeName)
    end)
end

Toggle:OnChanged(function()
    if Toggle.Value then
        if isRunning then return end
        isRunning = true

        spawn(function()
            while Toggle.Value do
                for _, model in ipairs(UpgradesFolder:GetChildren()) do
                    if not Toggle.Value then break end
                    if model:IsA("Model") then
                        purchaseUpgrade(model.Name)
                        wait(1.5)
                    end
                end
                wait(1.5)
            end
            isRunning = false
        end)
    else
        isRunning = false
    end
end)

Options.autoupgradeee:SetValue(false)



local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

local Toggle = Tabs.Fishing:AddToggle("followpad", {Title = "Bypass Fishing Position", Default = false})

local fishingdropdown = Tabs.Fishing:AddDropdown("fishingdropdown", {
    Title = "Fishing Type",
    Values = {"Normal Fishing", "Ice Fishing", "Corrupted Fishing"},
    Multi = false,
})

local pads = {
    ["Normal Fishing"] = {
        pad = workspace.MAP.INTERACT.FishingPads.Default:WaitForChild("Pad"),
        padGlow = workspace.MAP.INTERACT.FishingPads.Default:WaitForChild("PadGlow")
    },
    ["Ice Fishing"] = {
        pad = workspace.MAP.INTERACT.FishingPads:GetChildren()[4]:FindFirstChild("Pad"),
        padGlow = workspace.MAP.INTERACT.FishingPads:GetChildren()[4]:FindFirstChild("PadGlow")
    },
    ["Corrupted Fishing"] = {
        pad = workspace.MAP.INTERACT.FishingPads.Corrupted:WaitForChild("Pad"),
        padGlow = workspace.MAP.INTERACT.FishingPads.Corrupted:WaitForChild("PadGlow")
    }
}

local originalCFrames = {}
for name, parts in pairs(pads) do
    originalCFrames[name] = {
        pad = parts.pad.CFrame,
        padGlow = parts.padGlow.CFrame
    }
end

local currentType
local connection

local function tweenBack(name)
    local parts = pads[name]
    local original = originalCFrames[name]
    if parts and original then
        local info = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        TweenService:Create(parts.pad, info, {CFrame = original.pad}):Play()
        TweenService:Create(parts.padGlow, info, {CFrame = original.padGlow}):Play()
    end
end

fishingdropdown:OnChanged(function(value)
    if Toggle.Value and currentType and currentType ~= value then
        tweenBack(currentType)
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end

    currentType = value

    if Toggle.Value and pads[value] then
        local parts = pads[value]
        connection = RunService.RenderStepped:Connect(function()
            local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local cf = hrp.CFrame * CFrame.new(0, -3, 2)
                parts.pad.CFrame = cf
                parts.padGlow.CFrame = cf
            end
        end)
    end
end)

Toggle:OnChanged(function(value)
    if value then
        local selected = fishingdropdown.Value
        if not selected or not pads[selected] then return end
        currentType = selected
        local parts = pads[selected]

        connection = RunService.RenderStepped:Connect(function()
            local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local cf = hrp.CFrame * CFrame.new(0, -3, 2)
                parts.pad.CFrame = cf
                parts.padGlow.CFrame = cf
            end
        end)
    else
        if connection then
            connection:Disconnect()
            connection = nil
        end
        if currentType then
            tweenBack(currentType)
        end
    end
end)



local StarterGui = game:GetService("StarterGui")

wait(4)

StarterGui:SetCore("SendNotification", {
    Title = "Script Loaded",
    Text = "Script Fully Loaded, you can close Upgrades now",
    Duration = 5
})



local Toggle = Tabs.Event:AddToggle("auramerchant", {Title = "Auto Buy Out Aura Egg Merchant", Default = false})

Toggle:OnChanged(function()
    getgenv().auramerchantEnabled = Options.auramerchant.Value
end)

Options.auramerchant:SetValue(false)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage:WaitForChild("Network"):WaitForChild("CustomMerchants_Purchase")

task.spawn(function()
    while true do
        if getgenv().auramerchantEnabled then
            for i = 1, 6 do
                local args = {
                    "AuraEggMerchant",
                    i
                }
                Remote:InvokeServer(unpack(args))
                task.wait(1)
            end
        end
        task.wait(1)
    end
end)



local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage:WaitForChild("Network"):WaitForChild("AuraCrafting_Craft")

local shardMap = {
    ["Aura Shard"] = "Aura Shard",
    ["Exclusive Aura Shard"] = "Exclusive Aura Shard",
    ["Ultra Aura Shard"] = "Ultra Aura Shard",
}

local Dropdown = Tabs.Event:AddDropdown("ShardDropdown", {
    Title = "Select Aura Shard to Craft",
    Values = {"Aura Shard", "Exclusive Aura Shard", "Ultra Aura Shard"},
    Multi = false,
    Default = 1,
})

Dropdown:SetValue("Aura Shard")

getgenv().selectedShard = Dropdown.Value

Dropdown:OnChanged(function(Value)
    getgenv().selectedShard = Value
    print("Dropdown changed:", Value)
end)

local Toggle = Tabs.Event:AddToggle("AutoCraftToggle", {Title = "Auto Craft Auras", Default = false})

Toggle:OnChanged(function()
    getgenv().autoCraftEnabled = Options.AutoCraftToggle.Value
end)

Options.AutoCraftToggle:SetValue(false)

task.spawn(function()
    while true do
        if getgenv().autoCraftEnabled and getgenv().selectedShard then
            local args = { getgenv().selectedShard }
            local success, err = pcall(function()
                Remote:InvokeServer(unpack(args))
            end)
            if not success then
                warn("Failed to invoke AuraCrafting_Craft:", err)
            end
        end
        task.wait(1)
    end
end)



local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage:WaitForChild("Network"):WaitForChild("Fruits: Consume")

local fruitMap = {
    Orange = "e940dedd21c54b47874fdbcf4f0f8603",
    Banana = "c499d571949f4e74ab0476c69ec1529b",
    Apple = "9829b132ef924ad6aaea553d1c94fcba",
}

local MultiDropdown = Tabs.Consume:AddDropdown("MultiDropdown", {
    Title = "Select Fruits to Consume",
    Values = {"Orange", "Banana", "Apple"},
    Multi = true,
    Default = {},
})

MultiDropdown:SetValue({})

getgenv().selectedFruits = {}

MultiDropdown:OnChanged(function(Value)
    local selected = {}
    for fruitName, isSelected in pairs(Value) do
        if isSelected then
            table.insert(selected, fruitName)
        end
    end
    getgenv().selectedFruits = selected
    print("MultiDropdown changed:", table.concat(selected, ", "))
end)

local Toggle = Tabs.Consume:AddToggle("AutoConsumeToggle", {
    Title = "Auto Consume Fruits",
    Default = false,
})

Toggle:OnChanged(function()
    getgenv().autoConsumeEnabled = Options.AutoConsumeToggle.Value
end)

Options.AutoConsumeToggle:SetValue(false)

task.spawn(function()
    while true do
        if getgenv().autoConsumeEnabled then
            for _, fruitName in ipairs(getgenv().selectedFruits or {}) do
                local fruitId = fruitMap[fruitName]
                if fruitId then
                    local args = {fruitId, 1}
                    local success, err = pcall(function()
                        Remote:InvokeServer(unpack(args))
                    end)
                    if not success then
                        warn("Failed to consume fruit:", err)
                    end
                end
            end
        end
        task.wait(1)
    end
end)









-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- InterfaceManager (Allows you to have a interface managment system)

-- Hand the library over to our managers
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- You can add indexes of elements the save manager should ignore
SaveManager:SetIgnoreIndexes({})

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)


Window:SelectTab(1)


-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()
end
