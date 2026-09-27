-- load services
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")


-- load modules
local HumanoidStateModule = require(script.Parent:WaitForChild("HumanoidStateModule"))


-- global references
local OverlapParams = OverlapParams.new()
OverlapParams.FilterType = Enum.RaycastFilterType.Exclude
local CustomTouchEvent: BindableEvent = ReplicatedStorage:WaitForChild("CustomTouchEvent")
local CustomTouchEndedEvent: BindableEvent = ReplicatedStorage:WaitForChild("CustomTouchEndedEvent")

-- touch ended
local OldPartsInPlayer = {} :: {Instance}

local CurrentPartsMap = {} :: {Instance}
local CurrentPartsList = {} :: {Instance}

-- module
local CollisionCheck = {}

CollisionCheck.Interval = 0
CollisionCheck.Type = "RenderStepped"

CollisionCheck.PartsInPlayer = {} :: {Instance}

CollisionCheck.Run = function()
    if HumanoidStateModule.Inert then return end

    OverlapParams.FilterDescendantsInstances = {HumanoidStateModule.Character}

    table.clear(CurrentPartsList)
    table.clear(CurrentPartsMap)

    for _, Child in HumanoidStateModule.Character:GetChildren() do
		if Child:IsA("BasePart") then
			local Parts = Workspace:GetPartsInPart(Child, OverlapParams)
			for i = 1, #Parts do
				local Part = Parts[i]
				if not CurrentPartsMap[Part] then
					CurrentPartsMap[Part] = true
					table.insert(CurrentPartsList, Part)
				end
			end
		end
	end

	for i = 1, #OldPartsInPlayer do
		local OldPart = OldPartsInPlayer[i]
		if not CurrentPartsMap[OldPart] then
			CustomTouchEndedEvent:Fire(OldPart)
		end
	end

	OldPartsInPlayer = table.clone(CurrentPartsList)
	CollisionCheck.PartsInPlayer = CurrentPartsList

	CustomTouchEvent:Fire()
end

return CollisionCheck