BasicTeleporterModule = {}

BasicTeleporterModule.Teleport = function(Part: BasePart, Humanoid: Humanoid)
    local EndPart = (Part.Parent :: Instance):FindFirstChild("End") :: BasePart
    ((Humanoid.Parent) :: Model):PivotTo(EndPart.CFrame)
    Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp) -- removes possibility of ragdolling from noclip
end

return BasicTeleporterModule