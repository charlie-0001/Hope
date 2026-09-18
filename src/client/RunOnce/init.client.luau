-- load services
local CollectionService = game:GetService("CollectionService")


-- load modules
local TurretModule = require(script.Parent:WaitForChild("ClientObjects"):WaitForChild("TurretModule"))
local StudioOnlyModule = require(script:WaitForChild("StudioOnlyModule"))


local function InitializeInstance(instance: Instance)
    if not instance:HasTag("Initialize") then return end

    local Clone = instance:Clone()
    Clone:RemoveTag("Initialize")
    Clone.Parent = instance.Parent

    instance:Destroy()
    print("Initialized new client object.")
end

local AllClientObjects = CollectionService:GetTagged("Initialize")
for _, Instance in ipairs(AllClientObjects) do
    InitializeInstance(Instance)
end

CollectionService:GetInstanceAddedSignal("Initialize"):Connect(InitializeInstance)

-- hide parts only for studio 
StudioOnlyModule.HideParts()

-- client object initialization
local InitializeActions = {
    ["TurretSpawner"] = function(TurretPart: BasePart) TurretModule.InitializeTurret(TurretPart) end
}

for TagName, Action in pairs(InitializeActions) do
    for _, Part: BasePart in ipairs(CollectionService:GetTagged(TagName)) do
        if Part:HasTag("Initialize") then continue end
        task.spawn(Action, Part)
    end

    CollectionService:GetInstanceAddedSignal(TagName):Connect(function(Part: BasePart)
        if Part:HasTag("Initialize") then return end
        task.spawn(Action, Part)
    end)
end