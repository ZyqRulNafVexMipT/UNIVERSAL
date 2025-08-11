-------------------------------------------------------------------
-- 1.  Orion Library
-------------------------------------------------------------------
local OrionLib = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/1nig1htmare1234/SCRIPTS/main/Orion.lua"
))()

-------------------------------------------------------------------
-- 2.  Grow-a-Garden helpers  (unchanged from original)
-------------------------------------------------------------------
local sellcords = CFrame.new(61.5890846, 2.99999976, 0.426792741,
    -0.00227507902, 8.04493325e-08, -0.999997437,
    -3.3761197e-12, 1, 8.04495528e-08,
    0.999997437, 1.86405197e-10, -0.00227507902)

local function getinv()
    return lp.Backpack:GetChildren()
end

local function getsellables()
    local t = {}
    for _, v in ipairs(getinv()) do
        if v.Name:find("kg") and not v:GetAttribute("Favorite") then
            table.insert(t, v.Name)
        end
    end
    local charTool = lp.Character:FindFirstChildOfClass("Tool")
    if charTool and charTool.Name:find("kg") and not charTool:GetAttribute("Favorite") then
        table.insert(t, charTool.Name)
    end
    return t
end

local function getseeds()
    local seeds = {}
    local frame = lp.PlayerGui:WaitForChild("Seed_Shop").Frame.ScrollingFrame
    for _, c in ipairs(frame:GetChildren()) do
        if c:FindFirstChild("Main_Frame") then
            table.insert(seeds, c.Name)
        end
    end
    return seeds
end

local function getgears()
    local gears = {}
    local frame = lp.PlayerGui:WaitForChild("Gear_Shop").Frame.ScrollingFrame
    for _, c in ipairs(frame:GetChildren()) do
        if c:FindFirstChild("Main_Frame") then
            table.insert(gears, c.Name)
        end
    end
    return gears
end

local function geteaster()
    local seeds = {}
    local frame = lp.PlayerGui:WaitForChild("Easter_Shop").Frame.ScrollingFrame
    for _, c in ipairs(frame:GetChildren()) do
        if c:FindFirstChild("Main_Frame") then
            table.insert(seeds, c.Name)
        end
    end
    return seeds
end

local function getgarden()
    for _, g in ipairs(workspace.Farm:GetChildren()) do
        if g:FindFirstChild("Important")
            and g.Important:FindFirstChild("Data")
            and g.Important.Data:FindFirstChild("Owner")
            and g.Important.Data.Owner.Value == lp.Name then
            return g
        end
    end
end

local garden = getgarden()

-------------------------------------------------------------------
-- 3.  ESP module  (KILOGRAM ESP ported)
-------------------------------------------------------------------
local TweenService = game:GetService("TweenService")
local fruitNames = {
    "apple","cactus","candy blossom","coconut","dragon fruit","easter egg",
    "grape","mango","peach","pineapple","blue berry"
}

local espEnabled = false
local activeTweens = {}

local function createRainbowTween(lbl)
    local colors = {Color3.new(1,0,0),Color3.new(1,.5,0),Color3.new(1,1,0),
                    Color3.new(0,1,0),Color3.new(0,0,1),Color3.new(.5,0,1),Color3.new(1,0,1)}
    local ti = TweenInfo.new(1, Enum.EasingStyle.Linear)
    spawn(function()
        while espEnabled do
            for _, c in ipairs(colors) do
                if not espEnabled then break end
                local t = TweenService:Create(lbl, ti, {TextColor3 = c})
                activeTweens[lbl] = t
                t:Play()
                t.Completed:Wait()
            end
        end
    end)
end

local billboardCache = {}
local function updateFruits()
    if not espEnabled then
        for _, b in pairs(billboardCache) do b:Destroy() end
        table.clear(billboardCache)
        return
    end
    for _, fruit in pairs(workspace:GetDescendants()) do
        if table.find(fruitNames, fruit.Name:lower()) then
            local weight = fruit:FindFirstChild("Weight")
            local variant = fruit:FindFirstChild("Variant")
            if weight and weight:IsA("NumberValue") then
                local w = math.floor(weight.Value)
                local v = (variant and variant:IsA("StringValue") and variant.Value) or "Normal"
                local show = v == "Gold" or v == "Rainbow" or w > 20
                local color = (v == "Gold" and Color3.new(1,1,0)) or Color3.new(0,0,1)

                local bill = fruit:FindFirstChild("WeightDisplay")
                if show then
                    if not bill then
                        bill = Instance.new("BillboardGui")
                        bill.Name = "WeightDisplay"
                        bill.Parent = fruit
                        bill.Adornee = fruit
                        bill.Size = UDim2.new(0,100,0,50)
                        bill.MaxDistance = 50 + w*2
                        bill.StudsOffset = Vector3.new(0,2,0)
                        bill.AlwaysOnTop = true
                        local f = Instance.new("Frame", bill)
                        f.Size = UDim2.new(1,0,1,0)
                        f.BackgroundTransparency = 1
                        local sh = Instance.new("TextLabel", f)
                        sh.Name = "Shadow"
                        sh.Text = tostring(w)
                        sh.Size = UDim2.new(1,-2,0.7,-2)
                        sh.Position = UDim2.new(0,2,0,2)
                        sh.BackgroundTransparency = 1
                        sh.TextColor3 = Color3.new(0.5,0.5,0.5)
                        sh.TextScaled = true
                        local main = Instance.new("TextLabel", f)
                        main.Name = "Main"
                        main.Text = tostring(w)
                        main.Size = UDim2.new(1,0,0.7,0)
                        main.BackgroundTransparency = 1
                        main.TextColor3 = color
                        main.TextScaled = true
                        local var = Instance.new("TextLabel", f)
                        var.Name = "Variant"
                        var.Text = (v ~= "Normal" and v or "")
                        var.Size = UDim2.new(1,0,0.3,0)
                        var.Position = UDim2.new(0,0,0.7,0)
                        var.BackgroundTransparency = 1
                        var.TextColor3 = color
                        var.TextScaled = true
                        if v == "Rainbow" then
                            createRainbowTween(main)
                            createRainbowTween(var)
                        end
                        billboardCache[bill] = true
                    else
                        local f = bill:FindFirstChild("Frame")
                        if f then
                            f.Shadow.Text = tostring(w)
                            f.Main.Text = tostring(w)
                            f.Main.TextColor3 = color
                            f.Variant.Text = (v ~= "Normal" and v or "")
                            f.Variant.TextColor3 = color
                        end
                    end
                elseif bill then
                    bill:Destroy()
                end
            end
        end
    end
end

-- draggable ☠️ button
local espButton
local function spawnEspButton()
    if espButton then espButton:Destroy() end
    espButton = Instance.new("ScreenGui")
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,50,0,50)
    btn.Position = UDim2.new(0,10,0,10)
    btn.BackgroundColor3 = Color3.new()
    btn.Text = "☠️"
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextScaled = true
    btn.Parent = espButton
    espButton.Parent = gethui() or game.CoreGui
    local dragging, start, pos
    btn.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true; start = inp.Position; pos = btn.Position
        end
    end)
    UIS.InputChanged:Connect(function(inp)
        if dragging and inp.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = inp.Position - start
            btn.Position = UDim2.new(pos.X.Scale, pos.X.Offset + delta.X, pos.Y.Scale, pos.Y.Offset + delta.Y)
        end
    end)
    UIS.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    btn.MouseButton1Click:Connect(updateFruits)
end

-------------------------------------------------------------------
-- 4.  Orion Window
-------------------------------------------------------------------
local Window = OrionLib:MakeWindow({
    Name = "VortX Hub – Grow a Garden [v1.1.2.6]",
    HidePremium = true,
    SaveConfig = true,
    IntroEnabled = false
})

local maintab   = Window:MakeTab({Name = "Main"})
local misctab   = Window:MakeTab({Name = "Misc"})
local wiptab    = Window:MakeTab({Name = "WIPE"})

-------------------------------------------------------------------
-- 5.  Main tab
-------------------------------------------------------------------
do -- Auto Farm
    local farmSec = maintab:AddSection({Name = "Auto Farm"})
    farmSec:AddToggle({
        Name = "Auto Plant",
        Default = false,
        Callback = function(v)
            _CH.candyhub.autoplant = v
        end
    })
end

do -- Collector
    local colSec = maintab:AddSection({Name = "Collector"})
    colSec:AddToggle({
        Name = "Auto Collect",
        Default = false,
        Callback = function(v)
            _CH.candyhub.autocollect = v
            while _CH.candyhub.autocollect do
                if _CH.candyhub.tpcollect then
                    local plants = garden.Important.Plants_Physical
                    for _, p in ipairs(plants:GetDescendants()) do
                        if p:IsA("Part") and p:FindFirstChildOfClass("ProximityPrompt") then
                            local old = lp.Character.HumanoidRootPart.CFrame
                            lp.Character.HumanoidRootPart.CFrame = p.CFrame
                            task.wait(_CH.candyhub.tprate/1000)
                            fireproximityprompt(p:FindFirstChildOfClass("ProximityPrompt"))
                            task.wait(_CH.candyhub.tprate/1000)
                            lp.Character.HumanoidRootPart.CFrame = old
                        end
                    end
                else
                    for _, p in ipairs(garden.Important.Plants_Physical:GetDescendants()) do
                        if p:IsA("Part") and p:FindFirstChildOfClass("ProximityPrompt") then
                            fireproximityprompt(p:FindFirstChildOfClass("ProximityPrompt"))
                        end
                    end
                end
                task.wait(_CH.candyhub.collectrate/1000)
            end
        end
    })

    colSec:AddSlider({
        Name = "Collect Rate (ms)",
        Min = 100, Max = 3000, Default = 500,
        Callback = function(v) _CH.candyhub.collectrate = v end
    })

    colSec:AddToggle({
        Name = "TP Collect",
        Default = false,
        Callback = function(v) _CH.candyhub.tpcollect = v end
    })

    colSec:AddSlider({
        Name = "TP Rate (ms)",
        Min = 1, Max = 1000, Default = 10,
        Callback = function(v) _CH.candyhub.tprate = v end
    })
end

do -- Seed Sniper
    local seedSec = maintab:AddSection({Name = "Seed Sniper"})
    seedSec:AddDropdown({
        Name = "Seeds",
        Options = getseeds(),
        Default = "Carrot",
        Callback = function(v) _CH.candyhub.selectedseeds = {v} end
    })

    seedSec:AddToggle({
        Name = "Auto Buy Selected",
        Default = false,
        Callback = function(v)
            _CH.candyhub.autobuy = v
            while _CH.candyhub.autobuy do
                for _, s in ipairs(_CH.candyhub.selectedseeds) do
                    game.ReplicatedStorage.GameEvents.BuySeedStock:FireServer(s)
                end
                task.wait(1)
            end
        end
    })
end

do -- Gear Sniper
    local gearSec = maintab:AddSection({Name = "Gear Sniper"})
    gearSec:AddDropdown({
        Name = "Gears",
        Options = getgears(),
        Default = "BasicSprinkler",
        Callback = function(v) _CH.candyhub.selectedgears = {v} end
    })

    gearSec:AddToggle({
        Name = "Auto Buy Selected Gear",
        Default = false,
        Callback = function(v)
            _CH.candyhub.autobuygear = v
            while _CH.candyhub.autobuygear do
                for _, g in ipairs(_CH.candyhub.selectedgears) do
                    local args = (g == "WateringCan") and {g,10} or {g,0}
                    game.ReplicatedStorage.GameEvents.BuySeedStock:FireServer(unpack(args))
                end
                task.wait(1)
            end
        end
    })
end

do -- Auto Sell
    local sellSec = maintab:AddSection({Name = "Auto Sell"})
    sellSec:AddToggle({
        Name = "Auto Sell",
        Default = false,
        Callback = function(v)
            _CH.candyhub.autosell = v
            while _CH.candyhub.autosell do
                if _CH.candyhub.sellonfruits ~= 0 and #getinv() >= _CH.candyhub.sellonfruits then
                    local old = lp.Character.HumanoidRootPart.CFrame
                    lp.Character.HumanoidRootPart.CFrame = sellcords
                    repeat
                        task.wait()
                        game.ReplicatedStorage.GameEvents.Sell_Inventory:FireServer()
                    until #getsellables() == 0
                    lp.Character.HumanoidRootPart.CFrame = old
                end
                task.wait(1)
            end
        end
    })

    sellSec:AddSlider({
        Name = "Sell All On Fruits",
        Min = 0, Max = 200, Default = 50,
        Callback = function(v) _CH.candyhub.sellonfruits = v end
    })
end

-------------------------------------------------------------------
-- 6.  Misc tab
-------------------------------------------------------------------
do -- ESP Toggle
    local espSec = misctab:AddSection({Name = "ESP"})
    espSec:AddToggle({
        Name = "ESP (KG)",
        Default = false,
        Callback = function(v)
            espEnabled = v
            if v then
                spawnEspButton()
                updateFruits()
            else
                if espButton then espButton:Destroy(); espButton = nil end
                updateFruits()
            end
        end
    })
end

do -- Easter / Event
    local eSec = misctab:AddSection({Name = "Events"})
    eSec:AddToggle({
        Name = "Auto Give Gold Plants",
        Default = false,
        Callback = function(v)
            _CH.candyhub.autoevent1 = v
            if v then
                for _, tool in ipairs(lp.Backpack:GetChildren()) do
                    if tool.Name:find("Gold") then
                        tool.Parent = lp.Character
                        game.ReplicatedStorage.GameEvents.EasterShopService:FireServer("SubmitHeldPlant")
                        tool.Parent = lp.Backpack
                    end
                end
            end
        end
    })

    eSec:AddToggle({
        Name = "Auto DupeBuy Supers",
        Default = false,
        Callback = function(v)
            _CH.candyhub.superdupe = v
            while _CH.candyhub.superdupe do
                for i = 1,5 do
                    game.ReplicatedStorage.GameEvents.EasterShopService:FireServer("PurchaseSeed", i)
                end
                task.wait(1)
            end
        end
    })
end

-------------------------------------------------------------------
-- 7.  Init
-------------------------------------------------------------------
OrionLib:Init()
