local InputModule = {}

InputModule.Interval = 0

InputModule.HeldInputs = {}
InputModule.JustPressedInputs = {}

InputModule.IsHoldingAny = function(InputList: {})
    for _, Input in ipairs(InputList) do
        if table.find(InputModule.HeldInputs, Input) then
            return true
        end
    end
    return false
end

InputModule.Pressed = function(InputList: {})
    for _, Input in ipairs(InputList) do
        if table.find(InputModule.JustPressedInputs, Input) then
            return true
        end
    end
    return false
end

InputModule.Run = function()
    -- add stuff for JustPressedInputs later
end

return InputModule