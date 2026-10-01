-- load services
local Debris = game:GetService("Debris")
local SoundService = game:GetService("SoundService")


local Sound: Sound = SoundService:WaitForChild("BasicLauncherSound")


BasicLauncherModule = {}

BasicLauncherModule.Launch = function(Part: BasePart, Humanoid: Humanoid)
    if Part:HasTag("On") then return end

    local RootPart = (Humanoid.Parent :: Instance):FindFirstChild("HumanoidRootPart") :: BasePart
    if not RootPart then return end

    Part:AddTag("On")

    local Power = Part:GetAttribute("Power") or 75
    local Cooldown = Part:GetAttribute("Cooldown") or 2
    local KeepMomentum = Part:GetAttribute("KeepMomentum")
    local Direction = Part.CFrame.LookVector

    Sound:Play()
    if KeepMomentum == true then
        local Velocity: BodyVelocity = Instance.new("BodyVelocity", RootPart)
        Velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        Velocity.Velocity = Direction * Power

        Debris:AddItem(Velocity, 0.01)
    else
        RootPart.AssemblyLinearVelocity = Vector3.zero + Direction * Power
    end
    

    task.wait(Cooldown)

    Part:RemoveTag("On")
end

return BasicLauncherModule