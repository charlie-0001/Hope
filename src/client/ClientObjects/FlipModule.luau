-- load services
local CollectionServce = game:GetService("CollectionService")


-- load modules
local InputModule = require(script.Parent.Parent:WaitForChild("InputScript"):WaitForChild("InputModule"))
local HumanoidStateModule = require(script.Parent.Parent:WaitForChild("IntervalCheck"):WaitForChild("HumanoidStateModule"))


local GhostCharacter: BasePart

local function GetOppositePosition(Model: Model, ObjectForLocalSpace: BasePart)
    local BoundingBoxCFrame, BoundingBoxSize = Model:GetBoundingBox()

    local LocalPosition = BoundingBoxCFrame:PointToObjectSpace(ObjectForLocalSpace.Position)
    local OppositeLocalPosition = Vector3.new(-LocalPosition.X, -LocalPosition.Y, -LocalPosition.Z)
    local OppositeWorldPosition = BoundingBoxCFrame:PointToWorldSpace(OppositeLocalPosition)

    return OppositeWorldPosition
end


FlipModule = {}

FlipModule.Keybinds = {Enum.KeyCode.F, Enum.UserInputType.MouseButton1, Enum.UserInputType.Touch}

FlipModule.Update = function(Part: BasePart)
    local Model = Part:FindFirstAncestorOfClass("Model")
    if not Model or not Model.Parent then return end

    local GhostCharacterFolder = Model.Parent:FindFirstChild("GhostCharacters")
    if not GhostCharacterFolder then return end

    local GhostCharacterToClone = GhostCharacterFolder:FindFirstChild("GhostCharacter")

    if not GhostCharacterFolder:FindFirstChild("Clone") and GhostCharacterToClone then 
        GhostCharacter = GhostCharacterToClone:Clone()
        CollectionServce:RemoveTag(GhostCharacter, "StudioOnly")
        GhostCharacter.Name = "Clone"
        GhostCharacter.Transparency = 0.75
        GhostCharacter.Parent = GhostCharacterFolder
    end

    local OppositePosition = GetOppositePosition(Model, HumanoidStateModule.HumanoidRootPart)

    if GhostCharacter then
        GhostCharacter.Position = OppositePosition
    end

    if InputModule.Pressed(FlipModule.Keybinds) then
        HumanoidStateModule.Character:PivotTo(CFrame.new(OppositePosition))
    end
end

FlipModule.DestroyGhostCharacter = function(Part: BasePart)
    local Model = Part:FindFirstAncestorOfClass("Model")
    if not Model or not Model.Parent then return end

    local GhostCharacterFolder = Model.Parent:FindFirstChild("GhostCharacters")
    if not GhostCharacterFolder then return end

    local Clone = GhostCharacterFolder:FindFirstChild("Clone")
    if Clone then
        Clone:Destroy()
    end
end

return FlipModule