-- load services
local CollectionService = game:GetService("CollectionService")


-- load modules
local TurretModule = require(script.Parent:WaitForChild("ClientObjects"):WaitForChild("TurretModule"))
local MusicZoneModule = require(script.Parent:WaitForChild("ClientObjects"):WaitForChild("MusicZoneModule"))
local PulsePartModule = require(script.Parent:WaitForChild("ClientObjects"):WaitForChild("PulsePartModule"))
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
    ["TurretSpawner"] = function(TurretPart: BasePart) TurretModule.InitializeTurret(TurretPart) end,
    ["GlobalSound"] = function(Sound: Sound) MusicZoneModule.LoadMusic(Sound) end,
    ["PulsePart"] = function(PulsePart: BasePart) PulsePartModule.InitializePart(PulsePart) end
}

for TagName, Action in pairs(InitializeActions) do
    for _, Instance: Instance in ipairs(CollectionService:GetTagged(TagName)) do
        if Instance:HasTag("Initialize") then continue end
        task.spawn(Action, Instance)
    end

    CollectionService:GetInstanceAddedSignal(TagName):Connect(function(Instance: Instance)
        if Instance:HasTag("Initialize") then return end
        task.spawn(Action, Instance)
    end)
end