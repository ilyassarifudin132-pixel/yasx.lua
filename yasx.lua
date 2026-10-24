-- YASX HUB v2.3 ULTRA FINAL | Owner: sayangku_gacor | discord.gg/4anwdF8wF6
local OWNERS = {["sayangku_gacor"]=true, ["Sayangku_gacor"]=true, ["ilyassarifudin132-pixel"]=true}
local Lp = game.Players.LocalPlayer
local IsOwner = OWNERS[Lp.Name] or OWNERS[Lp.Name:lower()]
local MyName = Lp.DisplayName.." @"..Lp.Name

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "YASX HUB",
    Author = "Steal an Egg | Owner: sayangku_gacor",
    Folder = "YASXHUB",
    Theme = "Dark",
    User = {Enabled = true, Anonymous = false}
})
Window:Tag({Title = IsOwner and "v2.3 ULTRA | OWNER 👑" or "v2.3 ULTRA | "..Lp.Name, Color = Color3.fromHex("#30ff6a")})

local Home = Window:Tab({Title="Home", Icon="house"})
local Features = Window:Tab({Title="Features", Icon="star"})
local Egg = Window:Tab({Title="Egg", Icon="egg", Default=true})
local Pet = Window:Tab({Title="Pet", Icon="paw-print"})
local Event = Window:Tab({Title="Event", Icon="sparkles"})
local Base = Window:Tab({Title="Barn", Icon="warehouse"})
local Chat = Window:Tab({Title="YASX Chat 💬", Icon="message-circle"})
local Global = Window:Tab({Title=IsOwner and "Global Admin 👑" or "Global", Icon="shield"})
local Media = Window:Tab({Title="Media", Icon="video"})
local Config = Window:Tab({Title="Config", Icon="settings"})

-- VARS
local AutoSteal, AutoHallow, StaySafe, UpTread, UpBase = false, false, true, false, false
local MinValue, MinWeight, ColorFilter, SelectedEgg = 0, 0, "All", "All"
local SafePos = CFrame.new(0,15,0)
local HttpS = game:GetService("HttpService")

pcall(function()
    local sz = workspace:FindFirstChild("SafeZone") or workspace:FindFirstChild("SaveZone") or workspace:FindFirstChild("SpawnLocation")
    if sz then SafePos = sz.CFrame + Vector3.new(0,4,0) end
end)

-- HOME
Home:Section({Title="👤 Login: "..MyName})
local Stats = Home:Paragraph({Title="YASX v2.3 ULTRA", Desc="Loading...", Image="bar-chart-3"})
task.spawn(function() while task.wait(1) do pcall(function()
    local ls = Lp.leaderstats
    Stats:SetDesc(string.format("Money: $%s | Gems: %s\nUser: %s\nSafe: %s", ls.Money.Value, ls.Gems.Value, MyName, StaySafe and "ON 🛡️" or "OFF"))
end) end end)

-- FEATURES
Features:Section({Title="Main Features"})
Features:Toggle({Title="Auto Collect Cash", Default=false})
Features:Toggle({Title="Anti-AFK", Default=true, Callback=function(v) if v then for _,c in pairs(getconnections(Lp.Idled)) do c:Disable() end end end})
Features:Section({Title="Safe & Auto Farm"})
Features:Toggle({Title="Ava Stay di Save Zone 🛡️", Default=true, Callback=function(v) StaySafe=v end})
Features:Toggle({Title="Auto Upgrade Treadmill 🏃", Default=false, Callback=function(v) UpTread=v end})
Features:Toggle({Title="Auto Upgrade Base 🏠", Default=false, Callback=function(v) UpBase=v end})

-- EGG SUPER LENGKAP SESUAI REQUEST
Egg:Section({Title="🥚 YASX EGG STEALER v2.3"})
Egg:Toggle({Title="Auto Steal ALL Egg", Desc="Steal semua egg", Default=false, Callback=function(v) AutoSteal=v end})
Egg:Toggle({Title="Auto Steal ALL Halloween 🎃", Desc="Khusus The Hollow", Default=false, Callback=function(v) AutoHallow=v end})
Egg:Section({Title="🔍 Quick Bar Filter"})
Egg:Dropdown({Title="Jenis Hewan / Egg", Values={"All","Snowy Owl","Rhinotaur","Imp","Dog","Cat","Dragon","Halloween","Cosmic","Golden"}, Value="All", Callback=function(v) SelectedEgg=v end})
Egg:Dropdown({Title="Warna / Rarity (Napa)", Values={"All","Golden","Silver","Rainbow","Cosmic","Secret","Normal"}, Value="All", Callback=function(v) ColorFilter=v end})
Egg:Input({Title="Min. Uang ($/s)", Placeholder="1000000"}, function(v) MinValue=tonumber(v) or 0 end)
Egg:Input({Title="Min. Berat kg", Placeholder="50"}, function(v) MinWeight=tonumber(v) or 0 end)
local QuickDisplay = Egg:Paragraph({Title="📊 Quick Bar Live", Desc="Jenis: -\nBerat: -\n$/s: -\nWarna: -\nStatus: Idle"})

Pet:Section({Title="Pet"}) Pet:Toggle({Title="Equip Best Pets", Default=false})
Event:Section({Title="Event"}) Event:Toggle({Title="Auto Event The Hollow", Default=false})
Base:Section({Title="Base"}) 
Base:Button({Title="Teleport ke Safe Zone 🛡️", Callback=function() Lp.Character.HumanoidRootPart.CFrame=SafePos end})

-- CHAT SESAMA MEMBER (NAMA ASLI)
Chat:Section({Title="💬 YASX GLOBAL CHAT"})
Chat:Paragraph({Title="Kamu: "..MyName, Desc="Semua user YASX.lua bisa chat disini"})
local ChatDisplay = Chat:Paragraph({Title="Live Chat", Desc="Memuat chat..."})
Chat:Input({Title="Tulis Pesan", Placeholder="Halo guys..."}, "ChatInput")
Chat:Button({Title="KIRIM CHAT 🚀", Icon="send", Variant="Primary", Callback=function()
    local msg = Window:GetValue("ChatInput")
    if msg and msg~="" then
        pcall(function() HttpS:PostAsync("https://yasx-official-default-rtdb.firebaseio.com/yasx_chat.json", HttpS:JSONEncode({name=MyName, realName=Lp.Name, msg=msg, time=os.date("%H:%M"), isOwner=IsOwner})) end)
        Window:SetValue("ChatInput", "")
    end
end})
task.spawn(function() while task.wait(2.5) do pcall(function()
    local res = game:HttpGet("https://yasx-official-default-rtdb.firebaseio.com/yasx_chat.json?orderBy=\"$key\"&limitToLast=15")
    local data = HttpS:JSONDecode(res)
    if data then
        local txt="" for _,v in pairs(data) do txt=txt..string.format("[%s] %s %s: %s\n", v.time or "??:??", v.isOwner and "👑" or "👤", v.name, v.msg) end
        if txt~="" then ChatDisplay:SetDesc(txt) end
    end
end) end end)

-- ADMIN
if IsOwner then
    Global:Section({Title="👑 OWNER: "..MyName})
    Global:Input({Title="Broadcast", Placeholder="Update v2.3 rilis!"}, "AdminInput")
    Global:Button({Title="KIRIM KE SEMUA 🚀", Variant="Primary", Callback=function()
        local msg=Window:GetValue("AdminInput")
        if msg~="" then pcall(function() HttpS:PostAsync("https://yasx-official-default-rtdb.firebaseio.com/yasx_chat.json", HttpS:JSONEncode({name="👑 OWNER - sayangku_gacor", msg="[PENGUMUMAN] "..msg, time=os.date("%H:%M"), isOwner=true})) end) end
    end})
end

Media:Section({Title="OFFICIAL"})
Media:Button({Title="Discord - discord.gg/4anwdF8wF6", Variant="Primary", Callback=function() setclipboard("https://discord.gg/4anwdF8wF6") end})
Config:Keybind({Title="Toggle UI", Default="K", Callback=function() Window:Toggle() end})

-- LOGIC
task.spawn(function()
    while task.wait(0.35) do pcall(function()
        if (AutoSteal or AutoHallow) then
            for _,v in pairs(workspace:GetDescendants()) do
                if v:IsA("ProximityPrompt") and v.Parent.Name:lower():find("egg") then
                    local eggName = v.Parent.Parent.Name or v.Parent.Name
                    local ok = true
                    if SelectedEgg~="All" and not eggName:lower():find(SelectedEgg:lower()) then ok=false end
                    if AutoHallow and not eggName:lower():find("hallow") then ok=false end
                    if ColorFilter~="All" and not eggName:lower():find(ColorFilter:lower()) then ok=false end
                    if ok then
                        local hrp = Lp.Character and Lp.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            hrp.CFrame = v.Parent.CFrame
                            task.wait(0.12)
                            fireproximityprompt(v)
                            task.wait(0.2)
                            if StaySafe then hrp.CFrame = SafePos end
                            QuickDisplay:SetDesc(string.format("Jenis: %s\nBerat: %s kg+\n$/s: $%s+\nWarna: %s\nStatus: Steal ✅", eggName, MinWeight, MinValue, ColorFilter))
                        end
                    end
                end
            end
        end
        if UpTread then game:GetService("ReplicatedStorage"):FindFirstChild("UpgradeTreadmill") and game:GetService("ReplicatedStorage").UpgradeTreadmill:FireServer() end
        if UpBase then game:GetService("ReplicatedStorage"):FindFirstChild("UpgradeBase") and game:GetService("ReplicatedStorage").UpgradeBase:FireServer() end
    end) end
end)
WindUI:Notify({Title="YASX v2.3", Content="Welcome "..MyName, Duration=4})
