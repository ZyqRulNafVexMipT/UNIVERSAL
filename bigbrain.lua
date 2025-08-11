local Players = game:GetService("Players")

local Workspace = game:GetService("Workspace")

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local UserInputService = game:GetService("UserInputService")

local LP = Players.LocalPlayer

-- State variables

local AutoClickBook = false

local AutoCollectCoin = false

local AutoUpgrade = false

local AutoSell = false

local AutoBuyBooks = false

local InfJump = false

local WalkSpeed60 = false

local orgCF = nil

local equippedBook = nil

-- Helper functions

local function getHRP()

    local char = LP.Character or LP.CharacterAdded:Wait()

    return char:WaitForChild("HumanoidRootPart")

end

local function getHumanoid()

    local char = LP.Character or LP.CharacterAdded:Wait()

    return char:WaitForChild("Humanoid")

end

-- Initialize GUI

local ReGui = loadstring(game:HttpGet("https://raw.githubusercontent.com/depthso/Dear-ReGui/main/ReGui.lua"))()

local UI = ReGui:TabsWindow({Title = "Big Brain Simulator | Made by VortX", Size = UDim2.fromOffset(350, 250)})

-- Create tabs

local TabMain = UI:CreateTab({Name = "Main"})

local TabMovement = UI:CreateTab({Name = "Movement"})

-- Main features

local Main = TabMain:CollapsingHeader({Title = "Features"})

Main:Checkbox({Label = "Auto Click Book", Value = false, Callback = function(_, v) AutoClickBook = v end})

Main:Checkbox({Label = "Auto Collect Coin", Value = false, Callback = function(_, v) AutoCollectCoin = v end})

Main:Checkbox({Label = "Auto Upgrade", Value = false, Callback = function(_, v) AutoUpgrade = v end})

Main:Checkbox({Label = "Auto Sell", Value = false, Callback = function(_, v) AutoSell = v end})

Main:Checkbox({Label = "Auto Buy Books", Value = false, Callback = function(_, v) AutoBuyBooks = v end})

-- Movement features

local Movement = TabMovement:CollapsingHeader({Title = "Movement"})

Movement:Checkbox({Label = "Inf Jump", Value = false, Callback = function(_, v) InfJump = v end})

Movement:Checkbox({Label = "WalkSpeed 60", Value = false, Callback = function(_, v) 

    WalkSpeed60 = v 

    if getHumanoid() then

        getHumanoid().WalkSpeed = v and 60 or 16

    end

end})

-- Auto Collect Coin

task.spawn(function()

    while task.wait(0.1) do

        if AutoCollectCoin then

            local hrp = getHRP()

            local coins = Workspace:FindFirstChild("Coins")

            if hrp and coins then

                for _, v in pairs(coins:GetChildren()) do

                    if not AutoCollectCoin then break end

                    local part = v:FindFirstChild("Coin")

                    if part and part:IsA("Part") then

                        hrp.CFrame = part.CFrame + Vector3.new(0, 2, 0)

                        task.wait(0.05)

                    end

                end

            end

        end

    end

end)

-- Auto Click Book

task.spawn(function()

    while task.wait(0.05) do

        if AutoClickBook then

            if not equippedBook and LP.Backpack then

                for _, tool in pairs(LP.Backpack:GetChildren()) do

                    if tool:IsA("Tool") then

                        equippedBook = tool.Name

                        tool.Parent = LP.Character

                        break

                    end

                end

            end

            

            if equippedBook then

                pcall(function()

                    ReplicatedStorage.Remotes.BookClicked:FireServer(equippedBook)

                end)

            end

        end

    end

end)

-- Auto Upgrade

task.spawn(function()

    while task.wait(1) do

        if AutoUpgrade then

            pcall(function()

                ReplicatedStorage.Remotes.UpgradeCapacity:FireServer()

            end)

        end

    end

end)

-- Fixed Auto Sell with number format support

task.spawn(function()

    while task.wait(0.5) do

        if AutoSell then

            local hrp = getHRP()

            if not hrp then continue end

            

            -- Find the indicator text

            local indicator

            if LP.PlayerGui:FindFirstChild("MainGui") then

                local main = LP.PlayerGui.MainGui:FindFirstChild("MainContainer")

                if main then

                    local iq = main:FindFirstChild("IqContainer")

                    if iq then

                        indicator = iq:FindFirstChild("Indicator")

                    end

                end

            end

            

            -- Check if we should sell

            if indicator then

                local text = indicator.Text

                local currentStr, maxStr = text:match("([%d%.]+[KkMm]?)/?([%d%.]+[KkMm]?)")

                

                -- Function to convert formatted strings to numbers

                local function parseNumber(str)

                    if not str then return 0 end

                    str = str:gsub(",", ""):upper()

                    local num = tonumber(str:match("([%d%.]+)")) or 0

                    if str:find("K") then

                        num = num * 1000

                    elseif str:find("M") then

                        num = num * 1000000

                    end

                    return num

                end

                

                local current = parseNumber(currentStr)

                local max = parseNumber(maxStr)

                

                if current > 0 and max > 0 and current >= max then

                    -- Find sell part (check multiple possible names)

                    local sellPart = Workspace:FindFirstChild("SellPart") or 

                                    Workspace:FindFirstChild("SellPad") or

                                    Workspace:FindFirstChild("Sell") or

                                    Workspace:FindFirstChild("SellArea")

                    

                    if sellPart and sellPart:IsA("BasePart") then

                        local originalPos = hrp.CFrame

                        hrp.CFrame = sellPart.CFrame + Vector3.new(0, 3, 0)

                        task.wait(0.5) -- Wait for sell to complete

                        hrp.CFrame = originalPos

                        task.wait(2) -- Cooldown after selling

                    end

                end

            end

        end

    end

end)

-- Fixed Auto Buy Books

task.spawn(function()

    while task.wait(5) do

        if AutoBuyBooks and LP.leaderstats and LP.leaderstats:FindFirstChild("Coins") then

            local coins = LP.leaderstats.Coins.Value

            

            -- Find books folder

            local booksFolder = ReplicatedStorage:FindFirstChild("Shop") and 

                               ReplicatedStorage.Shop:FindFirstChild("Books")

            

            if booksFolder then

                local boughtSomething = false

                

                -- Buy all affordable books

                for _, book in pairs(booksFolder:GetChildren()) do

                    if book:FindFirstChild("BookConfig") and book.BookConfig:FindFirstChild("Price") then

                        local price = book.BookConfig.Price.Value

                        if coins >= price then

                            pcall(function()

                                ReplicatedStorage.Remotes.BuyBook:FireServer(book.Name)

                                coins = coins - price

                                boughtSomething = true

                                task.wait(1) -- Wait between purchases

                            end)

                        end

                    end

                end

                

                if boughtSomething then

                    task.wait(15) -- Cooldown after buying spree

                end

            end

        end

    end

end)

-- Movement systems

task.spawn(function()

    while task.wait() do

        if WalkSpeed60 and getHumanoid() then

            getHumanoid().WalkSpeed = 60

        elseif getHumanoid() then

            getHumanoid().WalkSpeed = 16

        end

    end

end)

UserInputService.JumpRequest:Connect(function()

    if InfJump and getHumanoid() then

        getHumanoid():ChangeState(Enum.HumanoidStateType.Jumping)

    end

end)

-- Initial notification

game.StarterGui:SetCore("SendNotification", {

    Title = "Big Brain Simulator | Made by VortX",

    Text = "All systems Work!",

    Duration = 5

})
