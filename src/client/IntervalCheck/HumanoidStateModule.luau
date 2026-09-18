HumanoidState = {}

HumanoidState.Interval = 0
HumanoidState.HumanoidRootPart = nil
HumanoidState.Humanoid = nil
HumanoidState.Character = nil

HumanoidState.Run = function()
    local Player = game:GetService("Players").LocalPlayer

    local Character = Player.Character
    if not Character then return end
    HumanoidState.Character = Character

    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    if not Humanoid then return end
    HumanoidState.Humanoid = Humanoid

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    if not HumanoidRootPart then return end
    HumanoidState.HumanoidRootPart = HumanoidRootPart
end

return HumanoidState