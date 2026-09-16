-- load modules
local CollisionCheckModule = require(script.Parent:WaitForChild("IntervalCheck"):WaitForChild("CollisionCheckModule"))
local HumanoidStateModule = require(script.Parent:WaitForChild("IntervalCheck"):WaitForChild("HumanoidStateModule"))
local KillBrickModule = require(script.Parent:WaitForChild("ClientObjects"):WaitForChild("KillBrickModule"))

-- load services
local CollectionService = game:GetService("CollectionService")

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
        if not part:HasTag("ClientObject") then continue end

        local tags = part:GetTags()
        for _, tag in tags do
            local action = TouchActions[tag]
            if action then 
                task.spawn(action, part, HumanoidStateModule.Humanoid)
            end
        end
    end
end)

CustomTouchEndedEvent.Event:Connect(function(part: BasePart)
    if not part:HasTag("ClientObject") then return end

    local tags = part:GetTags()
    for _, tag in tags do
        local action = TouchEndedActions[tag]
        if action then 
            task.spawn(action, part, HumanoidStateModule.Humanoid)
        end
    end
end)