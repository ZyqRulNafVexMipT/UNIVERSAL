if game.Players.LocalPlayer.PlayerGui:FindFirstChild("LoadingUI") and game.Players.LocalPlayer.PlayerGui.LoadingUI.Enabled == true then
repeat task.wait() until game.Players.LocalPlayer.PlayerGui.LoadingUI.Enabled == false
end
wait(0.5)
getgenv().TranslationCounter = nil
Name = "Door"
local success, result = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/Translation/Translation.lua"))()
end)

if success then
    Translations = result
else
    TranslationCounter = "English"
end
if Translations["English"] and Translations["English"][Name] then
loadstring(game:HttpGet("https://pastefy.app/yavAjgX3/raw"))()
repeat task.wait() until TranslationCounter
if game.CoreGui:FindFirstChild("Country") then
game.CoreGui.Country:Destroy()
end
end

function Translation(Section, Text)
	if TranslationCounter == "English" then
		return Text
	end
	local lang = Translations[TranslationCounter]
	if lang and lang[Name] and lang[Name][Section] and lang[Name][Section][Text] then
		return lang[Name][Section][Text]
	else
		return Text
	end
end
Tran = {"Main", "Misc", "Esp", "Information"}

Screech = false
ClutchHeart = false
local old
old = hookmetamethod(game,"__namecall",newcclosure(function(self,...)
    local args = {...}
    local method = getnamecallmethod()
    if tostring(self) == "Screech" and method == "FireServer" and Screech == true then
        args[1] = true
        return old(self,unpack(args))
    end
    if tostring(self) == "ClutchHeartbeat" and method == "FireServer" and ClutchHeart == true then
        args[2] = true
        return old(self,unpack(args))
    end
    return old(self,...)
end))

workspace.DescendantAdded:Connect(function(v)
if v:IsA("Model") and v.Name == "Screech" then
v:Destroy()
end
end)

------ Script --------

local EntityModules = game.ReplicatedStorage:WaitForChild("ClientModules"):WaitForChild("EntityModules")
local gameData = game.ReplicatedStorage:WaitForChild("GameData")
local floor = gameData:WaitForChild("Floor")
local isMines = floor.Value == "Mines"
local isHotel = floor.Value == "Hotel"
local isBackdoor = floor.Value == "Backdoor"

function Distance(pos)
	if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
		return (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - pos).Magnitude
	end
end

_G.GetOldBright = {
	Brightness = game.Lighting.Brightness,
	ClockTime = game.Lighting.ClockTime,
	FogEnd = game.Lighting.FogEnd,
	GlobalShadows = game.Lighting.GlobalShadows,
	OutdoorAmbient = game.Lighting.OutdoorAmbient
}

---- Script ----

local ui = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local win = ui:CreateWindow({
    Title = "VortX V1.1.0 Door",
    Icon = "door-open",
    Folder = "Article Hub",
    Size = UDim2.fromOffset(700, 320),
    Transparent = true,
    Theme = "Dark",
    SideBarWidth = 200,
})

Tabs = {
    Tab = win:Tab({Title = Translation(Tran[1], "Main")}),
    Tab1 = win:Tab({Title = Translation(Tran[2], "Misc")}),
    Tab2 = win:Tab({Title = Translation(Tran[3], "Esp")}),
    ["Info"] = win:Tab({Title = Translation(Tran[4], "Information")}),
}

local Main = Tabs.Tab
local MainTran = "Main" 
Main:Toggle({
    Title = Translation(MainTran, "Fullbright"),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
_G.FullBright = Value
while _G.FullBright do
game.Lighting.Brightness = 2
game.Lighting.ClockTime = 14
game.Lighting.FogEnd = 100000
game.Lighting.GlobalShadows = false
game.Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
task.wait()
end
for i, v in pairs(_G.GetOldBright) do
game.Lighting[i] = v
end
    end
})

Main:Toggle({
    Title = Translation(MainTran, "Instant Prompt"),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
_G.NoCooldownProximity = Value
if _G.NoCooldownProximity == true then
for i, v in pairs(workspace:GetDescendants()) do
if v.ClassName == "ProximityPrompt" then
v.HoldDuration = 0
end
end
CooldownProximity = workspace.DescendantAdded:Connect(function(Cooldown)
if _G.NoCooldownProximity == true then
if Cooldown:IsA("ProximityPrompt") then
Cooldown.HoldDuration = 0
end
end
end)
else
if CooldownProximity then
CooldownProximity:Disconnect()
CooldownProximity = nil
end
end
    end
})

Main:Section({Title = Translation(MainTran, "Anti"), TextXAlignment = "Left", TextSize = 17})

Main:Toggle({
    Title = Translation(MainTran, "Anti Screech"),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
_G.AntiScreech = Value
Screech = Value
    end
})

Main:Toggle({
    Title = Translation(MainTran, "Auto Clutch Heart Win"),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
ClutchHeart = Value
    end
})

Main:Toggle({
    Title = Translation(MainTran, "Anti Halt"),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
_G.NoHalt = Value
local HaltShade = EntityModules:FindFirstChild("Shade") or EntityModules:FindFirstChild("_Shade")
if HaltShade then
    HaltShade.Name = _G.NoHalt and "_Shade" or "Shade"
end
    end
})

Main:Toggle({
    Title = Translation(MainTran, "Anti Eyes / BackdoorLookman"),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
_G.NoEyes = Value
while _G.NoEyes do
if workspace:FindFirstChild("Eyes") then
if game:GetService("ReplicatedStorage"):FindFirstChild("RemotesFolder") then
game:GetService("ReplicatedStorage"):WaitForChild("RemotesFolder"):WaitForChild("MotorReplication"):FireServer(-649)
end
elseif workspace:FindFirstChild("BackdoorLookman") then
if game:GetService("ReplicatedStorage"):FindFirstChild("EntityInfo") then
game:GetService("ReplicatedStorage"):WaitForChild("EntityInfo"):WaitForChild("MotorReplication"):FireServer(0, -90, 0, false)
end
end
task.wait()
end
    end
})

local Misc = Tabs.Tab1
local MiscTr = "Misc"
local EntityGet = Misc:Dropdown({
    Title = Translation(MiscTr, "Choose Entity"),
    Values = {"Rush", "Seek", "Eyes", "Window", "LookMan", "BackdoorRush", "Giggle", "GloombatSwarm", "Ambush", "A-60", "A-120"},
    Value = {"Rush"},
    Multi = true,
    AllowNone = true,
    Callback = function(Value) 
_G.EntityChoose = Value
    end
})

Misc:Toggle({
    Title = Translation(MiscTr, "Notification Entity"),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
_G.NotifyEntity = Value
if _G.NotifyEntity then
EntityChild = workspace.ChildAdded:Connect(function(child)
for _, v in ipairs(_G.EntityChoose) do
    if child.Name:find(v) then
    repeat task.wait() until game.Players.LocalPlayer:DistanceFromCharacter(child:GetPivot().Position) < 1000 or not child:IsDescendantOf(workspace)
	    if child:IsDescendantOf(workspace) then
			ui:Notify({Title = v..Translation(MiscTr, " Spawn!!"), Duration = 5})
			if _G.NotifyEntityChat then
				if not _G.ChatNotify then
					TextChat = ""
				else
					TextChat = _G.ChatNotify
				end
				if TextChat then
					game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(TextChat..v..Translation(MiscTr, " Spawn!!"))
				end
			end
		end
    end
end
end)
else
if EntityChild then
EntityChild:Disconnect()
EntityChild = nil
end
end
    end
})

Misc:Button({
    Title = "Get Code Library",
    Callback = function()
local function Deciphercode(v)
local Hints = game.Players.LocalPlayer.PlayerGui:WaitForChild("PermUI"):WaitForChild("Hints")

local code = {[1] = "_",[2] = "_", [3] = "_", [4] = "_", [5] = "_"}
    for i, v in pairs(v:WaitForChild("UI"):GetChildren()) do
        if v:IsA("ImageLabel") and v.Name ~= "Image" then
            for b, n in pairs(Hints:GetChildren()) do
                if n:IsA("ImageLabel") and n.Visible and v.ImageRectOffset == n.ImageRectOffset then
                    code[tonumber(v.Name)] = n:FindFirstChild("TextLabel").Text 
                end
            end
        end
    end 
    return code
end
local function CodeAll(v)
	if v:IsA("Tool") and v.Name == "LibraryHintPaper" then
        local code = table.concat(Deciphercode(v))
        if code then
	        ui:Notify({Title = Translation(MiscTr, "Code: ")..code, Duration = 5})
			if _G.NotifyEntityChat then
				if not _G.ChatNotify then
					TextChat = ""
				else
					TextChat = _G.ChatNotify
				end
				if TextChat then
					game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(TextChat..code)
				end
			end
	        if workspace:FindFirstChild("Padlock") and Distance(workspace.Padlock:GetPivot().Position) <= 30 then
				if game:GetService("ReplicatedStorage"):FindFirstChild("RemotesFolder") then
					game:GetService("ReplicatedStorage"):WaitForChild("RemotesFolder"):WaitForChild("LP"):FireServer(code)
				end
			end
		end
    end
end
for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
	CodeAll(v)
end
for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
	CodeAll(v)
end
    end
})

Misc:Input({
    Title = Translation(MiscTr, "Input Chat"),
    Value = "",
    InputIcon = "speaker",
    Type = "Input",
    Placeholder = "Your Chat...",
    Callback = function(Value) 
_G.ChatNotify = Value
    end
})

Misc:Toggle({
    Title = Translation(MiscTr, "Notification Chat"),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
_G.NotifyEntityChat = Value
    end
})

_G.Aura = {
    "ActivateEventPrompt",
    "AwesomePrompt",
    "FusesPrompt",
    "HerbPrompt",
    "LeverPrompt",
    "LootPrompt",
    "ModulePrompt",
    "SkullPrompt",
    "UnlockPrompt",
    "ValvePrompt",
}

Misc:Toggle({
    Title = Translation(MiscTr, "Auto Loot"),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
_G.AutoLoot = Value
if _G.AutoLoot then
lootables = {}
local function LootCheck(v)
    if not table.find(lootables, v) and v:IsA("ProximityPrompt") and table.find(_G.Aura, v.Name) then
        table.insert(lootables, v)
    end
end
for _, v in ipairs(workspace:GetDescendants()) do
if v:IsA("ProximityPrompt") then
	LootCheck(v)
end
end
ChildAllNext = workspace.DescendantAdded:Connect(function(v)
if v:IsA("ProximityPrompt") then
	LootCheck(v)
end
end)
RemoveChild = workspace.DescendantRemoving:Connect(function(v)
    for i = #lootables, 1, -1 do
        if lootables[i] == v then
            table.remove(lootables, i)
            break
        end
    end
end)
else
if ChildAllNext then
ChildAllNext:Disconnect()
ChildAllNext = nil
end
if RemoveChild then
RemoveChild:Disconnect()
RemoveChild = nil
end
end
while _G.AutoLoot do
for i, v in pairs(lootables) do
	if v:IsA("ProximityPrompt") and table.find(_G.Aura, v.Name) and (v:GetAttribute("Interactions") == nil or v:GetAttribute("Interactions") <= 2) then
		if Distance(v.Parent:GetPivot().Position) <= 12 then
			fireproximityprompt(v)
		end
	end
end
task.wait(0.1)
end
    end
})

Misc:Slider({
    Title = Translation(MiscTr, "Walkspeed"),
    Step = 1,
    Value = {
        Min = 16,
        Max = 21,
        Default = 16,
    },
    Callback = function(Value)
_G.WalkSpeedTp = Value
    end
})

Misc:Toggle({
    Title = Translation(MiscTr, "WalkSpeed"),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
_G.SpeedWalk = Value
while _G.SpeedWalk do
if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = _G.WalkSpeedTp
end
task.wait()
end
    end
})

local Esp = Tabs.Tab2
local EspTr = "Esp"

Esp:Toggle({
    Title = Translation(EspTr, (isHotel and "Esp Key / Lever") or (isMines and "Esp Fuse")),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
_G.EspKey = Value
if _G.EspKey == false then
_G.KeyAdd = {}
if KeySpawn then
KeySpawn:Disconnect()
KeySpawn = nil
end
if KeyRemove then
KeyRemove:Disconnect()
KeyRemove = nil
end
for _, v in pairs(workspace:GetDescendants()) do 
if v.Name:find("Key") or v.Name == "LeverForGate" or v.Name:find("FuseObtain") then
for i, z in pairs(v:GetChildren()) do
if z.Name:find("Esp_") then
z:Destroy()
end
end
end
end
else
function Keys(v)
if ((v.Name:find("Key") or v.Name:find("FuseObtain")) and v:FindFirstChild("Hitbox")) or (v.Name == "LeverForGate" and v.PrimaryPart) then
if v:FindFirstChild("Esp_Highlight") then
	v:FindFirstChild("Esp_Highlight").FillColor = _G.ColorLight or Color3.fromRGB(255, 255, 255)
	v:FindFirstChild("Esp_Highlight").OutlineColor = _G.ColorLight or Color3.fromRGB(255, 255, 255)
end
if _G.EspHighlight == true and v:FindFirstChild("Esp_Highlight") == nil then
	local Highlight = Instance.new("Highlight")
	Highlight.Name = "Esp_Highlight"
	Highlight.FillColor = Color3.fromRGB(255, 255, 255) 
	Highlight.OutlineColor = Color3.fromRGB(255, 255, 255) 
	Highlight.FillTransparency = 0.5
	Highlight.OutlineTransparency = 0
	Highlight.Adornee = v
	Highlight.Parent = v
	elseif _G.EspHighlight == false and v:FindFirstChild("Esp_Highlight") then
	v:FindFirstChild("Esp_Highlight"):Destroy()
end
if v:FindFirstChild("Esp_Gui") and v["Esp_Gui"]:FindFirstChild("TextLabel") then
	v["Esp_Gui"]:FindFirstChild("TextLabel").Text = 
	        (_G.EspName == true and ((v.Name == "LeverForGate" and "Lever") or (v.Name:find("Key") and "Key") or (v.Name:find("FuseObtain") and "Fuse")) or "")..
            (_G.EspDistance == true and "\nDistance ("..string.format("%.0f", Distance((v.Name == "LeverForGate" and v.PrimaryPart.Position) or ((v.Name:find("Key") or v.Name:find("FuseObtain")) and v.Hitbox.Position))).."m)" or "")
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextSize = _G.EspGuiTextSize or 15
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextColor3 = _G.EspGuiTextColor or Color3.new(255, 255, 255)
end
if _G.EspGui == true and v:FindFirstChild("Esp_Gui") == nil then
	GuiEsp = Instance.new("BillboardGui", v)
	GuiEsp.Adornee = v
	GuiEsp.Name = "Esp_Gui"
	GuiEsp.Size = UDim2.new(0, 100, 0, 150)
	GuiEsp.AlwaysOnTop = true
	GuiEspText = Instance.new("TextLabel", GuiEsp)
	GuiEspText.BackgroundTransparency = 1
	GuiEspText.Font = Enum.Font.Code
	GuiEspText.Size = UDim2.new(0, 100, 0, 100)
	GuiEspText.TextSize = 15
	GuiEspText.TextColor3 = Color3.new(0,0,0) 
	GuiEspText.TextStrokeTransparency = 0.5
	GuiEspText.Text = ""
	local UIStroke = Instance.new("UIStroke")
	UIStroke.Color = Color3.new(0, 0, 0)
	UIStroke.Thickness = 1.5
	UIStroke.Parent = GuiEspText
	elseif _G.EspGui == false and v:FindFirstChild("Esp_Gui") then
	v:FindFirstChild("Esp_Gui"):Destroy()
end
end
end
local function CheckKey(v)
    if not table.find(_G.KeyAdd, v) and ((v.Name:find("Key") or v.Name:find("FuseObtain")) and v:FindFirstChild("Hitbox")) or (v.Name == "LeverForGate" and v.PrimaryPart) then
        table.insert(_G.KeyAdd, v)
    end
end
for _, v in ipairs(workspace:GetDescendants()) do
	CheckKey(v)
end
KeySpawn = workspace.DescendantAdded:Connect(function(v)
    CheckKey(v)
end)
KeyRemove = workspace.DescendantRemoving:Connect(function(v)
    for i = #_G.KeyAdd, 1, -1 do
        if _G.KeyAdd[i] == v then
            table.remove(_G.KeyAdd, i)
            break
        end
    end
end)
end
while _G.EspKey do
for i, v in pairs(_G.KeyAdd) do
if v:IsA("Model") then
Keys(v)
end
end
task.wait()
end
    end
})

Esp:Toggle({
    Title = Translation(EspTr, "Esp Door"),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
_G.EspDoor = Value
if _G.EspDoor == false then
for _, v in pairs(game.Workspace:FindFirstChild("CurrentRooms"):GetChildren()) do 
if v:isA("Model") then
for i, z in pairs(v:GetChildren()) do
if z.Name:find("Esp_") then
z:Destroy()
end
end
end
end
end
while _G.EspDoor do
for i, v in pairs(game.Workspace:FindFirstChild("CurrentRooms"):GetChildren()) do
if v:IsA("Model") and v:FindFirstChild("Door") and v.Door:FindFirstChild("Door") then
if v:FindFirstChild("Esp_Highlight") then
	v:FindFirstChild("Esp_Highlight").FillColor = _G.ColorLight or Color3.fromRGB(255, 255, 255)
	v:FindFirstChild("Esp_Highlight").OutlineColor = _G.ColorLight or Color3.fromRGB(255, 255, 255)
end
if _G.EspHighlight == true and v:FindFirstChild("Esp_Highlight") == nil then
	local Highlight = Instance.new("Highlight")
	Highlight.Name = "Esp_Highlight"
	Highlight.FillColor = Color3.fromRGB(255, 255, 255) 
	Highlight.OutlineColor = Color3.fromRGB(255, 255, 255) 
	Highlight.FillTransparency = 0.5
	Highlight.OutlineTransparency = 0
	Highlight.Adornee = v.Door
	Highlight.Parent = v
	elseif _G.EspHighlight == false and v:FindFirstChild("Esp_Highlight") then
	v:FindFirstChild("Esp_Highlight"):Destroy()
end
if v:FindFirstChild("Esp_Gui") and v["Esp_Gui"]:FindFirstChild("TextLabel") then
	v["Esp_Gui"]:FindFirstChild("TextLabel").Text = 
	        (_G.EspName == true and "Door "..((v.Door:FindFirstChild("Sign") and v.Door.Sign:FindFirstChild("Stinker") and v.Door.Sign.Stinker.Text) or (v.Door.Sign:FindFirstChild("SignText") and v.Door.Sign.SignText.Text)):gsub("^0+", "")..(v.Door:FindFirstChild("Lock") and " (lock)" or "") or "")..
            (_G.EspDistance == true and "\nDistance ("..string.format("%.0f", Distance(v.Door.Door.Position)).."m)" or "")
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextSize = _G.EspGuiTextSize or 15
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextColor3 = _G.EspGuiTextColor or Color3.new(255, 255, 255)
end
if _G.EspGui == true and v:FindFirstChild("Esp_Gui") == nil then
	GuiEsp = Instance.new("BillboardGui", v)
	GuiEsp.Adornee = v.Door
	GuiEsp.Name = "Esp_Gui"
	GuiEsp.Size = UDim2.new(0, 100, 0, 150)
	GuiEsp.AlwaysOnTop = true
	GuiEspText = Instance.new("TextLabel", GuiEsp)
	GuiEspText.BackgroundTransparency = 1
	GuiEspText.Font = Enum.Font.Code
	GuiEspText.Size = UDim2.new(0, 100, 0, 100)
	GuiEspText.TextSize = 15
	GuiEspText.TextColor3 = Color3.new(0,0,0) 
	GuiEspText.TextStrokeTransparency = 0.5
	GuiEspText.Text = ""
	local UIStroke = Instance.new("UIStroke")
	UIStroke.Color = Color3.new(0, 0, 0)
	UIStroke.Thickness = 1.5
	UIStroke.Parent = GuiEspText
	elseif _G.EspGui == false and v:FindFirstChild("Esp_Gui") then
	v:FindFirstChild("Esp_Gui"):Destroy()
end
end
end
task.wait()
end
    end
})

if isHotel then
Esp:Toggle({
    Title = Translation(EspTr, "Esp Book"),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
_G.EspBook = Value
if _G.EspBook == false then
_G.BookAdd = {}
if BookSpawn then
BookSpawn:Disconnect()
BookSpawn = nil
end
if BookRemove then
BookRemove:Disconnect()
BookRemove = nil
end
for _, v in pairs(workspace:GetDescendants()) do 
if v.Name:find("LiveHintBook") then
for i, z in pairs(v:GetChildren()) do
if z.Name:find("Esp_") then
z:Destroy()
end
end
end
end
else
function Books(v)
if v.Name:find("LiveHintBook") and v.PrimaryPart then
if v:FindFirstChild("Esp_Highlight") then
	v:FindFirstChild("Esp_Highlight").FillColor = _G.ColorLight or Color3.fromRGB(255, 255, 255)
	v:FindFirstChild("Esp_Highlight").OutlineColor = _G.ColorLight or Color3.fromRGB(255, 255, 255)
end
if _G.EspHighlight == true and v:FindFirstChild("Esp_Highlight") == nil then
	local Highlight = Instance.new("Highlight")
	Highlight.Name = "Esp_Highlight"
	Highlight.FillColor = Color3.fromRGB(255, 255, 255) 
	Highlight.OutlineColor = Color3.fromRGB(255, 255, 255) 
	Highlight.FillTransparency = 0.5
	Highlight.OutlineTransparency = 0
	Highlight.Adornee = v
	Highlight.Parent = v
	elseif _G.EspHighlight == false and v:FindFirstChild("Esp_Highlight") then
	v:FindFirstChild("Esp_Highlight"):Destroy()
end
if v:FindFirstChild("Esp_Gui") and v["Esp_Gui"]:FindFirstChild("TextLabel") then
	v["Esp_Gui"]:FindFirstChild("TextLabel").Text = 
	        (_G.EspName == true and "Book" or "")..
            (_G.EspDistance == true and "\nDistance ("..string.format("%.0f", Distance(v.PrimaryPart.Position)).."m)" or "")
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextSize = _G.EspGuiTextSize or 15
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextColor3 = _G.EspGuiTextColor or Color3.new(255, 255, 255)
end
if _G.EspGui == true and v:FindFirstChild("Esp_Gui") == nil then
	GuiEsp = Instance.new("BillboardGui", v)
	GuiEsp.Adornee = v
	GuiEsp.Name = "Esp_Gui"
	GuiEsp.Size = UDim2.new(0, 100, 0, 150)
	GuiEsp.AlwaysOnTop = true
	GuiEspText = Instance.new("TextLabel", GuiEsp)
	GuiEspText.BackgroundTransparency = 1
	GuiEspText.Font = Enum.Font.Code
	GuiEspText.Size = UDim2.new(0, 100, 0, 100)
	GuiEspText.TextSize = 15
	GuiEspText.TextColor3 = Color3.new(0,0,0) 
	GuiEspText.TextStrokeTransparency = 0.5
	GuiEspText.Text = ""
	local UIStroke = Instance.new("UIStroke")
	UIStroke.Color = Color3.new(0, 0, 0)
	UIStroke.Thickness = 1.5
	UIStroke.Parent = GuiEspText
	elseif _G.EspGui == false and v:FindFirstChild("Esp_Gui") then
	v:FindFirstChild("Esp_Gui"):Destroy()
end
end
end
local function CheckBook(v)
    if not table.find(_G.BookAdd, v) and v.Name == "LiveHintBook" then
        table.insert(_G.BookAdd, v)
    end
end
for _, v in ipairs(workspace:GetDescendants()) do
	CheckBook(v)
end
BookSpawn = workspace.DescendantAdded:Connect(function(v)
    CheckBook(v)
end)
BookRemove = workspace.DescendantRemoving:Connect(function(v)
    for i = #_G.BookAdd, 1, -1 do
        if _G.BookAdd[i] == v then
            table.remove(_G.BookAdd, i)
            break
        end
    end
end)
end
while _G.EspBook do
for i, v in pairs(_G.BookAdd) do
if v:IsA("Model") then
Books(v)
end
end
task.wait()
end
    end
})

Esp:Toggle({
    Title = Translation(EspTr, "Esp Breaker"),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
_G.EspBreaker = Value
if _G.EspBreaker == false then
_G.BreakerAdd = {}
if BreakerSpawn then
BreakerSpawn:Disconnect()
BreakerSpawn = nil
end
if BreakerRemove then
BreakerRemove:Disconnect()
BreakerRemove = nil
end
for _, v in pairs(workspace:GetDescendants()) do 
if v.Name:find("LiveBreakerPolePickup") then
for i, z in pairs(v:GetChildren()) do
if z.Name:find("Esp_") then
z:Destroy()
end
end
end
end
else
function Breakers(v)
if v.Name == "LiveBreakerPolePickup" and v:FindFirstChildOfClass("ProximityPrompt") then
if v:FindFirstChild("Esp_Highlight") then
	v:FindFirstChild("Esp_Highlight").FillColor = _G.ColorLight or Color3.fromRGB(255, 255, 255)
	v:FindFirstChild("Esp_Highlight").OutlineColor = _G.ColorLight or Color3.fromRGB(255, 255, 255)
end
if _G.EspHighlight == true and v:FindFirstChild("Esp_Highlight") == nil then
	local Highlight = Instance.new("Highlight")
	Highlight.Name = "Esp_Highlight"
	Highlight.FillColor = Color3.fromRGB(255, 255, 255) 
	Highlight.OutlineColor = Color3.fromRGB(255, 255, 255) 
	Highlight.FillTransparency = 0.5
	Highlight.OutlineTransparency = 0
	Highlight.Adornee = v
	Highlight.Parent = v
	elseif _G.EspHighlight == false and v:FindFirstChild("Esp_Highlight") then
	v:FindFirstChild("Esp_Highlight"):Destroy()
end
if v:FindFirstChild("Esp_Gui") and v["Esp_Gui"]:FindFirstChild("TextLabel") then
	v["Esp_Gui"]:FindFirstChild("TextLabel").Text = 
	        (_G.EspName == true and "Breaker" or "")..
            (_G.EspDistance == true and "\nDistance ("..string.format("%.0f", Distance(v.PrimaryPart.Position)).."m)" or "")
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextSize = _G.EspGuiTextSize or 15
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextColor3 = _G.EspGuiTextColor or Color3.new(255, 255, 255)
end
if _G.EspGui == true and v:FindFirstChild("Esp_Gui") == nil then
	GuiEsp = Instance.new("BillboardGui", v)
	GuiEsp.Adornee = v
	GuiEsp.Name = "Esp_Gui"
	GuiEsp.Size = UDim2.new(0, 100, 0, 150)
	GuiEsp.AlwaysOnTop = true
	GuiEspText = Instance.new("TextLabel", GuiEsp)
	GuiEspText.BackgroundTransparency = 1
	GuiEspText.Font = Enum.Font.Code
	GuiEspText.Size = UDim2.new(0, 100, 0, 100)
	GuiEspText.TextSize = 15
	GuiEspText.TextColor3 = Color3.new(0,0,0) 
	GuiEspText.TextStrokeTransparency = 0.5
	GuiEspText.Text = ""
	local UIStroke = Instance.new("UIStroke")
	UIStroke.Color = Color3.new(0, 0, 0)
	UIStroke.Thickness = 1.5
	UIStroke.Parent = GuiEspText
	elseif _G.EspGui == false and v:FindFirstChild("Esp_Gui") then
	v:FindFirstChild("Esp_Gui"):Destroy()
end
end
end
local function CheckBreaker(v)
    if not table.find(_G.BreakerAdd, v) and v.Name == "LiveBreakerPolePickup" then
        table.insert(_G.BreakerAdd, v)
    end
end
for _, v in ipairs(workspace:GetDescendants()) do
	CheckBreaker(v)
end
BreakerSpawn = workspace.DescendantAdded:Connect(function(v)
    CheckBreaker(v)
end)
BreakerRemove = workspace.DescendantRemoving:Connect(function(v)
for i = #_G.BreakerAdd, 1, -1 do
    if _G.BreakerAdd[i] == v then
        table.remove(_G.BreakerAdd, i)
        break
    end
end
end)
end
while _G.EspBreaker do
for i, v in pairs(_G.BreakerAdd) do
if v.Name == "LiveBreakerPolePickup" then
Breakers(v)
end
end
task.wait()
end
    end
})
end

Esp:Toggle({
    Title = Translation(EspTr, "Esp Item"),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
_G.EspItem = Value
if _G.EspItem == false then
_G.ItemAdd = {}
if ItemSpawn then
ItemSpawn:Disconnect()
ItemSpawn = nil
end
if ItemRemove then
ItemRemove:Disconnect()
ItemRemove = nil
end
for _, v in pairs(workspace:GetDescendants()) do 
if v.Name:find("Handle") then
for i, z in pairs(v:GetChildren()) do
if z.Name:find("Esp_") then
z:Destroy()
end
end
end
end
else
function Items(v)
if v.Name == "Handle" and v.Parent:FindFirstChildOfClass("ProximityPrompt") then
if v:FindFirstChild("Esp_Highlight") then
	v:FindFirstChild("Esp_Highlight").FillColor = _G.ColorLight or Color3.fromRGB(255, 255, 255)
	v:FindFirstChild("Esp_Highlight").OutlineColor = _G.ColorLight or Color3.fromRGB(255, 255, 255)
end
if _G.EspHighlight == true and v:FindFirstChild("Esp_Highlight") == nil then
	local Highlight = Instance.new("Highlight")
	Highlight.Name = "Esp_Highlight"
	Highlight.FillColor = Color3.fromRGB(255, 255, 255) 
	Highlight.OutlineColor = Color3.fromRGB(255, 255, 255) 
	Highlight.FillTransparency = 0.5
	Highlight.OutlineTransparency = 0
	Highlight.Adornee = v.Parent
	Highlight.Parent = v
	elseif _G.EspHighlight == false and v:FindFirstChild("Esp_Highlight") then
	v:FindFirstChild("Esp_Highlight"):Destroy()
end
if v:FindFirstChild("Esp_Gui") and v["Esp_Gui"]:FindFirstChild("TextLabel") then
	v["Esp_Gui"]:FindFirstChild("TextLabel").Text = 
	        (_G.EspName == true and v.Parent.Name or "")..
            (_G.EspDistance == true and "\nDistance ("..string.format("%.0f", Distance(v.Position)).."m)" or "")
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextSize = _G.EspGuiTextSize or 15
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextColor3 = _G.EspGuiTextColor or Color3.new(255, 255, 255)
end
if _G.EspGui == true and v:FindFirstChild("Esp_Gui") == nil then
	GuiEsp = Instance.new("BillboardGui", v)
	GuiEsp.Adornee = v.Parent
	GuiEsp.Name = "Esp_Gui"
	GuiEsp.Size = UDim2.new(0, 100, 0, 150)
	GuiEsp.AlwaysOnTop = true
	GuiEspText = Instance.new("TextLabel", GuiEsp)
	GuiEspText.BackgroundTransparency = 1
	GuiEspText.Font = Enum.Font.Code
	GuiEspText.Size = UDim2.new(0, 100, 0, 100)
	GuiEspText.TextSize = 15
	GuiEspText.TextColor3 = Color3.new(0,0,0) 
	GuiEspText.TextStrokeTransparency = 0.5
	GuiEspText.Text = ""
	local UIStroke = Instance.new("UIStroke")
	UIStroke.Color = Color3.new(0, 0, 0)
	UIStroke.Thickness = 1.5
	UIStroke.Parent = GuiEspText
	elseif _G.EspGui == false and v:FindFirstChild("Esp_Gui") then
	v:FindFirstChild("Esp_Gui"):Destroy()
end
end
end
local function CheckItem(v)
    if not table.find(_G.ItemAdd, v) and v.Name == "Handle" then
        table.insert(_G.ItemAdd, v)
    end
end
for _, v in ipairs(workspace:GetDescendants()) do
	CheckItem(v)
end
ItemSpawn = workspace.DescendantAdded:Connect(function(v)
    CheckItem(v)
end)
ItemRemove = workspace.DescendantRemoving:Connect(function(v)
for i = #_G.ItemAdd, 1, -1 do
    if _G.ItemAdd[i] == v then
        table.remove(_G.ItemAdd, i)
        break
    end
end
end)
end
while _G.EspItem do
for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
	if v:IsA("Tool") then
		for i, z in pairs(v:GetChildren()) do
			if z.Name:find("Esp_") then
				z:Destroy()
			end
		end
	end
end
for i, v in pairs(_G.ItemAdd) do
if v.Name == "Handle" then
Items(v)
end
end
task.wait()
end
    end
})

_G.EspEntityNameDis = {
	["FigureRig"] = "Figure",
	["SallyMoving"] = "Window",
	["RushMoving"] = "Rush",
	["Eyes"] = "Eyes",
	["SeekMovingNewClone"] = "Seek",
	["BackdoorLookman"] = "Lookman",
	["BackdoorRush"] = "Blitz",
	["GloombatSwarm"] = "Gloombat",
	["GiggleCeiling"] = "Giggle",
	["AmbushMoving"] = "Ambush"
}
Esp:Toggle({
    Title = Translation(EspTr, "Esp Entity"),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
_G.EspEntity = Value
if _G.EspEntity == false then
_G.EntityAdd = {}
if EntitySpawn then
EntitySpawn:Disconnect()
EntitySpawn = nil
end
if EntityRemove then
EntityRemove:Disconnect()
EntityRemove = nil
end
for _, v in pairs(workspace:GetDescendants()) do 
if v:IsA("Model") and (v.Name == "FigureRig" or v.Name == "SallyMoving" or v.Name == "RushMoving" or v.Name == "Eyes" or v.Name == "SeekMovingNewClone" or v.Name == "BackdoorLookman" or v.Name == "BackdoorRush" or v.Name == "GloombatSwarm" or v.Name == "GiggleCeiling" or v.Name == "AmbushMoving") then
if v.PrimaryPart then
v.PrimaryPart.Transparency = 1
end
for i, z in pairs(v:GetChildren()) do
if z.Name:find("Esp_") then
z:Destroy()
end
end
end
end
else
local function CheckEntity(v)
    if not table.find(_G.EntityAdd, v) and v:IsA("Model") and (v.Name == "FigureRig" or v.Name == "SallyMoving" or v.Name == "RushMoving" or v.Name == "Eyes" or v.Name == "SeekMovingNewClone" or v.Name == "BackdoorLookman" or v.Name == "BackdoorRush" or v.Name == "GloombatSwarm" or v.Name == "GiggleCeiling" or v.Name == "AmbushMoving") then
        table.insert(_G.EntityAdd, v)
    end
end
for _, v in ipairs(workspace:GetDescendants()) do
	CheckEntity(v)
end
EntitySpawn = workspace.DescendantAdded:Connect(function(v)
    CheckEntity(v)
end)
EntityRemove = workspace.DescendantRemoving:Connect(function(v)
for i = #_G.EntityAdd, 1, -1 do
    if _G.EntityAdd[i] == v then
        table.remove(_G.EntityAdd, i)
        break
    end
end
end)
end
while _G.EspEntity do
for i, v in pairs(_G.EntityAdd) do
if v:IsA("Model") and (v.Name == "FigureRig" or v.Name == "SallyMoving" or v.Name == "RushMoving" or v.Name == "Eyes" or v.Name == "SeekMovingNewClone" or v.Name == "BackdoorLookman" or v.Name == "BackdoorRush" or v.Name == "GloombatSwarm" or v.Name == "GiggleCeiling" or v.Name == "AmbushMoving") then
if v.PrimaryPart then
v.PrimaryPart.Transparency = 0.99
end
if v:FindFirstChild("Esp_Highlight") then
	v:FindFirstChild("Esp_Highlight").FillColor = _G.ColorLight or Color3.fromRGB(255, 255, 255)
	v:FindFirstChild("Esp_Highlight").OutlineColor = _G.ColorLight or Color3.fromRGB(255, 255, 255)
end
if _G.EspHighlight == true and v:FindFirstChild("Esp_Highlight") == nil then
	local Highlight = Instance.new("Highlight")
	Highlight.Name = "Esp_Highlight"
	Highlight.FillColor = Color3.fromRGB(255, 255, 255) 
	Highlight.OutlineColor = Color3.fromRGB(255, 255, 255) 
	Highlight.FillTransparency = 0.5
	Highlight.OutlineTransparency = 0
	Highlight.Adornee = v
	Highlight.Parent = v
	elseif _G.EspHighlight == false and v:FindFirstChild("Esp_Highlight") then
	v:FindFirstChild("Esp_Highlight"):Destroy()
end
if v:FindFirstChild("Esp_Gui") and v["Esp_Gui"]:FindFirstChild("TextLabel") then
	v["Esp_Gui"]:FindFirstChild("TextLabel").Text = 
	        (_G.EspName == true and _G.EspEntityNameDis[v.Name] or "")..
            (_G.EspDistance == true and "\nDistance ("..string.format("%.0f", Distance(v.PrimaryPart.Position)).."m)" or "")
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextSize = _G.EspGuiTextSize or 15
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextColor3 = _G.EspGuiTextColor or Color3.new(255, 255, 255)
end
if _G.EspGui == true and v:FindFirstChild("Esp_Gui") == nil then
	GuiEsp = Instance.new("BillboardGui", v)
	GuiEsp.Adornee = v
	GuiEsp.Name = "Esp_Gui"
	GuiEsp.Size = UDim2.new(0, 100, 0, 150)
	GuiEsp.AlwaysOnTop = true
	GuiEspText = Instance.new("TextLabel", GuiEsp)
	GuiEspText.BackgroundTransparency = 1
	GuiEspText.Font = Enum.Font.Code
	GuiEspText.Size = UDim2.new(0, 100, 0, 100)
	GuiEspText.TextSize = 15
	GuiEspText.TextColor3 = Color3.new(0,0,0) 
	GuiEspText.TextStrokeTransparency = 0.5
	GuiEspText.Text = ""
	local UIStroke = Instance.new("UIStroke")
	UIStroke.Color = Color3.new(0, 0, 0)
	UIStroke.Thickness = 1.5
	UIStroke.Parent = GuiEspText
	elseif _G.EspGui == false and v:FindFirstChild("Esp_Gui") then
	v:FindFirstChild("Esp_Gui"):Destroy()
end
end
end
task.wait()
end
    end
})

Esp:Toggle({
    Title = Translation(EspTr, "Esp Hiding Spots"),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
_G.EspHiding = Value
if _G.EspHiding == false then
_G.HidingAdd = {}
if HidingSpawn then
HidingSpawn:Disconnect()
HidingSpawn = nil
end
if HidingRemove then
HidingRemove:Disconnect()
HidingRemove = nil
end
for _, v in pairs(workspace:GetDescendants()) do 
if v.Name == "Bed" or v.Name == "Wardrobe" or v.Name == "Backdoor_Wardrobe" or v.Name == "Locker_Large" or v.Name == "Rooms_Locker" then
for i, z in pairs(v:GetChildren()) do
if z.Name:find("Esp_") then
z:Destroy()
end
end
end
end
else
function Hidings(v)
if (v.Name == "Bed" or v.Name == "Wardrobe" or v.Name == "Backdoor_Wardrobe" or v.Name == "Locker_Large" or v.Name == "Rooms_Locker") and v.PrimaryPart then
if v:FindFirstChild("Esp_Highlight") then
	v:FindFirstChild("Esp_Highlight").FillColor = _G.ColorLight or Color3.fromRGB(255, 255, 255)
	v:FindFirstChild("Esp_Highlight").OutlineColor = _G.ColorLight or Color3.fromRGB(255, 255, 255)
end
if _G.EspHighlight == true and v:FindFirstChild("Esp_Highlight") == nil then
	local Highlight = Instance.new("Highlight")
	Highlight.Name = "Esp_Highlight"
	Highlight.FillColor = Color3.fromRGB(255, 255, 255) 
	Highlight.OutlineColor = Color3.fromRGB(255, 255, 255) 
	Highlight.FillTransparency = 0.5
	Highlight.OutlineTransparency = 0
	Highlight.Adornee = v
	Highlight.Parent = v
	elseif _G.EspHighlight == false and v:FindFirstChild("Esp_Highlight") then
	v:FindFirstChild("Esp_Highlight"):Destroy()
end
if v:FindFirstChild("Esp_Gui") and v["Esp_Gui"]:FindFirstChild("TextLabel") then
	v["Esp_Gui"]:FindFirstChild("TextLabel").Text = 
	        (_G.EspName == true and v.Name or "")..
            (_G.EspDistance == true and "\nDistance ("..string.format("%.0f", Distance(v.PrimaryPart.Position)).."m)" or "")
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextSize = _G.EspGuiTextSize or 15
    v["Esp_Gui"]:FindFirstChild("TextLabel").TextColor3 = _G.EspGuiTextColor or Color3.new(255, 255, 255)
end
if _G.EspGui == true and v:FindFirstChild("Esp_Gui") == nil then
	GuiEsp = Instance.new("BillboardGui", v)
	GuiEsp.Adornee = v
	GuiEsp.Name = "Esp_Gui"
	GuiEsp.Size = UDim2.new(0, 100, 0, 150)
	GuiEsp.AlwaysOnTop = true
	GuiEspText = Instance.new("TextLabel", GuiEsp)
	GuiEspText.BackgroundTransparency = 1
	GuiEspText.Font = Enum.Font.Code
	GuiEspText.Size = UDim2.new(0, 100, 0, 100)
	GuiEspText.TextSize = 15
	GuiEspText.TextColor3 = Color3.new(0,0,0) 
	GuiEspText.TextStrokeTransparency = 0.5
	GuiEspText.Text = ""
	local UIStroke = Instance.new("UIStroke")
	UIStroke.Color = Color3.new(0, 0, 0)
	UIStroke.Thickness = 1.5
	UIStroke.Parent = GuiEspText
	elseif _G.EspGui == false and v:FindFirstChild("Esp_Gui") then
	v:FindFirstChild("Esp_Gui"):Destroy()
end
end
end
local function CheckHiding(v)
    if not table.find(_G.HidingAdd, v) and v.Name == "Bed" or v.Name == "Wardrobe" or v.Name == "Backdoor_Wardrobe" or v.Name == "Locker_Large" or v.Name == "Rooms_Locker" then
        table.insert(_G.HidingAdd, v)
    end
end
for _, v in ipairs(workspace:GetDescendants()) do
	CheckHiding(v)
end
BookSpawn = workspace.DescendantAdded:Connect(function(v)
    CheckHiding(v)
end)
BookRemove = workspace.DescendantRemoving:Connect(function(v)
    for i = #_G.HidingAdd, 1, -1 do
        if _G.HidingAdd[i] == v then
            table.remove(_G.HidingAdd, i)
            break
        end
    end
end)
end
while _G.EspHiding do
for i, v in pairs(_G.HidingAdd) do
if v:IsA("Model") then
Hidings(v)
end
end
task.wait()
end
    end
})

Esp:Toggle({
    Title = Translation(EspTr, "Esp Player"),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
_G.EspPlayer = Value
if _G.EspPlayer == false then
for i, v in pairs(game.Players:GetChildren()) do
	if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") then
		for x, b in pairs(v.Character:GetChildren()) do
			if b.Name:find("Esp_") then
				b:Destroy()
			end
		end
	end
end
end
while _G.EspPlayer do
for i, v in pairs(game.Players:GetChildren()) do
if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") then
if v.Character:FindFirstChild("Esp_Highlight") then
	v.Character:FindFirstChild("Esp_Highlight").FillColor = _G.ColorLight or Color3.new(255, 255, 255)
	v.Character:FindFirstChild("Esp_Highlight").OutlineColor = _G.ColorLight or Color3.new(255, 255, 255)
end
if _G.EspHighlight == true and v.Character:FindFirstChild("Esp_Highlight") == nil then
	local Highlight = Instance.new("Highlight")
	Highlight.Name = "Esp_Highlight"
	Highlight.FillColor = Color3.fromRGB(255, 255, 255) 
	Highlight.OutlineColor = Color3.fromRGB(255, 255, 255) 
	Highlight.FillTransparency = 0.5
	Highlight.OutlineTransparency = 0
	Highlight.Adornee = v.Character
	Highlight.Parent = v.Character
	elseif _G.EspHighlight == false and v.Character:FindFirstChild("Esp_Highlight") then
	v.Character:FindFirstChild("Esp_Highlight"):Destroy()
end
if v.Character:FindFirstChild("Esp_Gui") and v.Character["Esp_Gui"]:FindFirstChild("TextLabel") then
	v.Character["Esp_Gui"]:FindFirstChild("TextLabel").Text = 
	        (_G.EspName == true and v.Name or "")..
            (_G.EspDistance == true and "\nDistance ("..string.format("%.0f", Distance(v.Character.HumanoidRootPart.Position)).."m)" or "")..
            (_G.EspHealth == true and "\nHealth [ "..(v.Character.Humanoid.Health <= 0 and "Dead" or string.format("%.0f", (v.Character.Humanoid.Health))).." ]" or "")
    v.Character["Esp_Gui"]:FindFirstChild("TextLabel").TextSize = _G.EspGuiTextSize or 15
    v.Character["Esp_Gui"]:FindFirstChild("TextLabel").TextColor3 = _G.EspGuiTextColor or Color3.new(255, 255, 255)
end
if _G.EspGui == true and v.Character:FindFirstChild("Esp_Gui") == nil then
	GuiPlayerEsp = Instance.new("BillboardGui", v.Character)
	GuiPlayerEsp.Adornee = v.Character.Head
	GuiPlayerEsp.Name = "Esp_Gui"
	GuiPlayerEsp.Size = UDim2.new(0, 100, 0, 150)
	GuiPlayerEsp.AlwaysOnTop = true
	GuiPlayerEsp.StudsOffset = Vector3.new(0, 3, 0)
	GuiPlayerEspText = Instance.new("TextLabel", GuiPlayerEsp)
	GuiPlayerEspText.BackgroundTransparency = 1
	GuiPlayerEspText.Font = Enum.Font.Code
	GuiPlayerEspText.Size = UDim2.new(0, 100, 0, 100)
	GuiPlayerEspText.TextSize = 15
	GuiPlayerEspText.TextColor3 = Color3.new(0,0,0) 
	GuiPlayerEspText.TextStrokeTransparency = 0.5
	GuiPlayerEspText.Text = ""
	local UIStroke = Instance.new("UIStroke")
	UIStroke.Color = Color3.new(0, 0, 0)
	UIStroke.Thickness = 1.5
	UIStroke.Parent = GuiPlayerEspText
	elseif _G.EspGui == false and v.Character:FindFirstChild("Esp_Gui") then
	v.Character:FindFirstChild("Esp_Gui"):Destroy()
end
end
end
task.wait()
end
    end
})

Esp:Section({Title = Translation(EspTr, "Settings Esp"), TextXAlignment = "Left", TextSize = 17})

Esp:Toggle({
    Title = Translation(MiscTr, "Esp Gui"),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
_G.EspGui = Value
    end
})

Esp:Toggle({
    Title = Translation(MiscTr, "Esp HightLight"),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
_G.EspHighlight = Value
    end
})

Esp:Section({Title = Translation(EspTr, "Settings Color"), TextXAlignment = "Left", TextSize = 17})

Esp:Colorpicker({
    Title = Translation(EspTr, "Color Gui"),
    Default = Color3.fromRGB(255, 255, 255),
    Transparency = 0,
    Locked = false,
    Callback = function(Value) 
_G.EspGuiTextColor = Value
    end
})

Esp:Colorpicker({
    Title = Translation(EspTr, "Color HightLight"),
    Default = Color3.fromRGB(255, 255, 255),
    Transparency = 0,
    Locked = false,
    Callback = function(Value) 
_G.ColorLight = Value
    end
})

Esp:Slider({
    Title = Translation(EspTr, "Text Size [ Gui ]"),
    Step = 1,
    Value = {
        Min = 5,
        Max = 50,
        Default = 10,
    },
    Callback = function(Value)
_G.EspGuiTextSize = Value
    end
})

Esp:Section({Title = Translation(EspTr, "Settings Text"), TextXAlignment = "Left", TextSize = 17})

Esp:Toggle({
    Title = Translation(MiscTr, "Esp Name"),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
_G.EspName = Value
    end
})

Esp:Toggle({
    Title = Translation(MiscTr, "Esp Distance"),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
_G.EspDistance = Value
    end
})

Esp:Toggle({
    Title = Translation(MiscTr, "Esp Health"),
    Type = "Toggle",
    Default = false,
    Callback = function(Value)
_G.EspHealth = Value
    end
})
