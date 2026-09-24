--[[
the point of this is so that other client objects can get inputs from here instead of using
UserInputService:IsKeyPressed or using ContextActionService a lot. hopefully this is an 
optimization and not just me overcomplicating this.
]]

-- load services
local ContextActionService = game:GetService("ContextActionService")


-- load modules
local InputModule = require(script:WaitForChild("InputModule"))


local function HandleInput(ActionName, InputState, InputObject: InputObject)
    local InputObjectType 
    if InputObject.UserInputType == Enum.UserInputType.Keyboard then InputObjectType = InputObject.KeyCode
    elseif InputObject.UserInputType == Enum.UserInputType.MouseButton1 then InputObjectType = InputObject.UserInputType end

    if InputState == Enum.UserInputState.Begin then
        InputModule.AddInput(InputObjectType)
    elseif InputState == Enum.UserInputState.End then
        InputModule.RemoveInput(InputObjectType)
    end

    return Enum.ContextActionResult.Pass
end

ContextActionService:BindAction("AllInputs", HandleInput, false, table.unpack(Enum.UserInputType:GetEnumItems()))
