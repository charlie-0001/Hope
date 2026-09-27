-- load services
local UserInputService = game:GetService("UserInputService")


-- load modules
local InputModule = require(script:WaitForChild("InputModule"))


local function OnInputBegan(Input, GameProcessed)
    local InputType = Input.UserInputType

    if InputType == Enum.UserInputType.Keyboard then
        InputModule.AddInput(Input.KeyCode)
    elseif InputType == Enum.UserInputType.MouseButton1 then
        InputModule.AddInput(InputType)
    elseif InputType == Enum.UserInputType.Touch then
        InputModule.AddInput(InputType)
    end
end

local function OnInputEnded(Input, GameProcessed)
    local InputType = Input.UserInputType

    if InputType == Enum.UserInputType.Keyboard then
        InputModule.RemoveInput(Input.KeyCode)
    elseif InputType == Enum.UserInputType.MouseButton1 then
        InputModule.RemoveInput(InputType)
    end
end

UserInputService.InputBegan:Connect(OnInputBegan)
UserInputService.InputEnded:Connect(OnInputEnded)