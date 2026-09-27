local Player = game:GetService("Players").LocalPlayer


HumanoidState = {}

HumanoidState.Interval = 0
HumanoidState.Type = "Renderstepped"

HumanoidState.Character = Player.Character or Player.CharacterAdded:Wait() :: Instance
HumanoidState.Humanoid = HumanoidState.Character:WaitForChild("Humanoid") :: Humanoid
HumanoidState.HumanoidRootPart = HumanoidState.Character:WaitForChild("HumanoidRootPart") :: BasePart
HumanoidState.Inert = false

HumanoidState.Run = function()
    local Character = Player.Character or Player.CharacterAdded:Wait()
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