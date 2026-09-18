-- load services
local CollectionService = game:GetService("CollectionService")


StudioOnlyModule = {}

StudioOnlyModule.HideParts = function()
    local StudioOnlyParts = CollectionService:GetTagged("StudioOnly")

    for _, part: BasePart in StudioOnlyParts do
        part.Transparency = 1
        part.CanCollide = false
    end

    CollectionService:GetInstanceAddedSignal("StudioOnly"):Connect(function(part: BasePart)
        part.Transparency = 1
        part.CanCollide = false
    end)
end

return StudioOnlyModule 