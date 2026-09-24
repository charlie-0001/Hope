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

--[[ 
InputModule.Pressed = function(InputList: {})
    for _, Input in ipairs(InputList) do
        if table.find(InputModule.JustPressedInputs, Input) then
            return true
        end
    end
    return false
end 
]]

InputModule.AddInput = function(Input)
    table.insert(InputModule.HeldInputs, Input)
end

InputModule.RemoveInput = function(Input)
    table.remove(InputModule.HeldInputs, table.find(InputModule.HeldInputs, Input))
end

InputModule.Run = function()
    -- might use this in the future, but for now it will be empty and just bloat the game a little bit
end

return InputModule