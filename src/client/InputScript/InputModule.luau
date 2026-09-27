local InputModule = {}

InputModule.Interval = 0
InputModule.Type = "Heartbeat"

InputModule.HeldInputs = {}
InputModule.PreviousHeldInputs = {}

InputModule.IsHoldingAny = function(InputList: {})
    for _, Input in ipairs(InputList) do
        if InputModule.HeldInputs[Input] then
            return true
        end
    end
    return false
end

InputModule.Pressed = function(InputList: {})
    for _, Input in ipairs(InputList) do
        local IsHeldNow = InputModule.HeldInputs[Input]
        local WasHeldLastFrame = InputModule.PreviousHeldInputs[Input]

        if IsHeldNow and not WasHeldLastFrame then
            return true
        end
    end
    return false
end 

InputModule.AddInput = function(Input)
    InputModule.HeldInputs[Input] = true
end

InputModule.RemoveInput = function(Input)
    InputModule.HeldInputs[Input] = nil
end

InputModule.Run = function()
    table.clear(InputModule.PreviousHeldInputs)
    for Key, Value in pairs(InputModule.HeldInputs) do
        InputModule.PreviousHeldInputs[Key] = Value
    end
end

return InputModule