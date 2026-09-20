--[[
the point of this is so that other client objects can get inputs from here instead of using
UserInputService:IsKeyPressed or using ContextActionService a lot. hopefully this is an 
optimization and not just me overcomplicating this.
]]

-- load services
local UserInputService = game:GetService("UserInputService")


-- load modules
local InputModule = require(script:WaitForChild("InputModule"))


UserInputService.InputBegan:Connect(function(Input: InputObject)
    if Input.UserInputType == Enum.UserInputType.Keyboard then
        table.insert(InputModule.HeldInputs, Input.KeyCode)
        -- add stuff for JustPressedInputs later
    elseif Input.UserInputType == Enum.UserInputType.MouseButton1 then
        table.insert(InputModule.HeldInputs, Enum.UserInputType.MouseButton1)
    end
end)

UserInputService.InputEnded:Connect(function(Input)
    local valueToRemove = nil
    
    if Input.UserInputType == Enum.UserInputType.Keyboard then
        valueToRemove = Input.KeyCode
    elseif Input.UserInputType == Enum.UserInputType.MouseButton1 then
        valueToRemove = Enum.UserInputType.MouseButton1
    end
    
    if valueToRemove then
        local index = table.find(InputModule.HeldInputs, valueToRemove)
        if index then
            table.remove(InputModule.HeldInputs, index)
        end
    end
end)