local Workspace = game:GetService("Workspace")
-- load modules
local HumanoidStateModule = require(script.Parent:WaitForChild("HumanoidState"))


-- global references
local OverlapParams = OverlapParams.new()
OverlapParams.FilterType = Enum.RaycastFilterType.Exclude


-- module
local CollisionCheck = {}

CollisionCheck.Interval = 0
CollisionCheck.PartsInPlayer = {} :: {Instance}

CollisionCheck.Run = function()
    OverlapParams.ExcludeInstances = { HumanoidStateModule.Character }

    local CharacterCFrame, CharacterSize = HumanoidStateModule.Character:GetBoundingBox()
    CollisionCheck.PartsInPlayer = Workspace:GetPartBoundsInBox(CharacterCFrame, CharacterSize, OverlapParams)
end

return CollisionCheck