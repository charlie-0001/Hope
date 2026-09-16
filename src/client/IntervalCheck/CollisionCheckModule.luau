-- load modules
local HumanoidStateModule = require(script.Parent:WaitForChild("HumanoidStateModule"))

-- load services
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- global references
local OverlapParams = OverlapParams.new()
OverlapParams.FilterType = Enum.RaycastFilterType.Exclude
local CustomTouchEvent: BindableEvent = ReplicatedStorage:WaitForChild("CustomTouchEvent")
local CustomTouchEndedEvent: BindableEvent = ReplicatedStorage:WaitForChild("CustomTouchEndedEvent")

-- touch ended
local OldPartsInPlayer = {} :: {Instance}


-- module
local CollisionCheck = {}

CollisionCheck.Interval = 0.1
CollisionCheck.PartsInPlayer = {} :: {Instance}

CollisionCheck.Run = function()
    OverlapParams.ExcludeInstances = {HumanoidStateModule.Character}

    local CharacterCFrame, CharacterSize = HumanoidStateModule.Character:GetBoundingBox()
    CollisionCheck.PartsInPlayer = Workspace:GetPartBoundsInBox(CharacterCFrame, CharacterSize, OverlapParams)

    for _, part: BasePart in OldPartsInPlayer do
        if not table.find(CollisionCheck.PartsInPlayer, part) then
            CustomTouchEndedEvent:Fire(part)
        end
    end
    
    OldPartsInPlayer = CollisionCheck.PartsInPlayer
    CustomTouchEvent:Fire()
end

return CollisionCheck