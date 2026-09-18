-- load modules
local CollisionCheckModule = require(script.Parent:WaitForChild("IntervalCheck"):WaitForChild("CollisionCheckModule"))
local HumanoidStateModule = require(script.Parent:WaitForChild("IntervalCheck"):WaitForChild("HumanoidStateModule"))
local KillBrickModule = require(script.Parent:WaitForChild("ClientObjects"):WaitForChild("KillBrickModule"))


-- custom touch event
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CustomTouchEvent: BindableEvent = ReplicatedStorage:WaitForChild("CustomTouchEvent")
local CustomTouchEndedEvent: BindableEvent = ReplicatedStorage:WaitForChild("CustomTouchEndedEvent")

-- dictionaries for touch events
local TouchActions = {
    ["KillBrick"] = function(part, humanoid) KillBrickModule.Kill(part, humanoid) end
}

local TouchEndedActions = {
    ["TestPart"] = function(part, humanoid) KillBrickModule.Kill(part, humanoid) end
}

CustomTouchEvent.Event:Connect(function()
    for _, part: BasePart in CollisionCheckModule.PartsInPlayer do
        if not part:HasTag("TouchTrigger") then continue end

        local Tags = part:GetTags()
        for _, Tag in Tags do
            local Action = TouchActions[Tag]
            if Action then 
                task.spawn(Action, part, HumanoidStateModule.Humanoid)
            end
        end
    end
end)

CustomTouchEndedEvent.Event:Connect(function(part: BasePart)
    if not part:HasTag("TouchTrigger") then return end

    local Tags = part:GetTags()
    for _, Tag in Tags do
        local Action = TouchEndedActions[Tag]
        if Action then 
            task.spawn(Action, part, HumanoidStateModule.Humanoid)
        end
    end
end)