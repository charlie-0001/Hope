-- load modules
local CollisionCheckModule = require(script.Parent:WaitForChild("IntervalCheck"):WaitForChild("CollisionCheckModule"))
local HumanoidStateModule = require(script.Parent:WaitForChild("IntervalCheck"):WaitForChild("HumanoidStateModule"))
local KillBrickModule = require(script.Parent:WaitForChild("ClientObjects"):WaitForChild("KillBrickModule"))
local LightingModule = require(script.Parent:WaitForChild("ClientObjects"):WaitForChild("LightingModule"))


-- custom touch event
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CustomTouchEvent: BindableEvent = ReplicatedStorage:WaitForChild("CustomTouchEvent")
local CustomTouchEndedEvent: BindableEvent = ReplicatedStorage:WaitForChild("CustomTouchEndedEvent")

-- dictionaries for touch events
local TouchActions = {
    ["KillBrick"] = function(Part, Humanoid) KillBrickModule.Kill(Part, Humanoid) end,
    ["LightingChanger"] = function(Part) LightingModule.ChangeLighting(Part) end,
    ["ColorCorrectionChanger"] = function(Part) LightingModule.ChangeColorCorrection(Part) end,
    ["AtmosphereChanger"] = function(Part) LightingModule.ChangeAtmosphere(Part) end,
    ["DepthOfFieldChanger"] = function(Part) LightingModule.ChangeDepthOfField(Part) end
}

local TouchEndedActions = {
    ["TestPart"] = function(Part, Humanoid) KillBrickModule.Kill(Part, Humanoid) end
}

CustomTouchEvent.Event:Connect(function()
    for _, Part: BasePart in CollisionCheckModule.PartsInPlayer do
        if not Part:HasTag("TouchTrigger") then continue end

        local Tags = Part:GetTags()
        for _, Tag in Tags do
            local Action = TouchActions[Tag]
            if Action then 
                task.spawn(Action, Part, HumanoidStateModule.Humanoid)
            end
        end
    end
end)

CustomTouchEndedEvent.Event:Connect(function(Part: BasePart)
    if not Part:HasTag("TouchTrigger") then return end

    local Tags = Part:GetTags()
    for _, Tag in Tags do
        local Action = TouchEndedActions[Tag]
        if Action then 
            task.spawn(Action, Part, HumanoidStateModule.Humanoid)
        end
    end
end)