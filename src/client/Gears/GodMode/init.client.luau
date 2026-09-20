-- load services
local Players = game:GetService("Players")


-- load modules
local HumanoidStateModule = require(script.Parent.Parent:WaitForChild("IntervalCheck"):WaitForChild("HumanoidStateModule"))


local Player = Players.LocalPlayer
local Backpack = Player:WaitForChild("Backpack")

local GodModeTool: Tool = Backpack:WaitForChild("GodMode (off)", 5) or HumanoidStateModule.Character:WaitForChild("GodMode (off)", 5)

local Invulnerable = false

GodModeTool.Activated:Connect(function()
    Invulnerable = not Invulnerable

    if not Invulnerable then 
        HumanoidStateModule.Humanoid.MaxHealth = 100
        GodModeTool.Name = "GodMode (off)"
    else
        HumanoidStateModule.Humanoid.MaxHealth = math.huge
        HumanoidStateModule.Humanoid.Health = math.huge
        GodModeTool.Name = "GodMode (on)"
    end
end)