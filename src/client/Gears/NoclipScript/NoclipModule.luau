-- load services
local ContextActionService = game:GetService("ContextActionService")


-- load modules
local InputModule = require(script.Parent.Parent.Parent:WaitForChild("Input"):WaitForChild("InputModule"))
local HumanoidStateModule = require(script.Parent.Parent.Parent:WaitForChild("IntervalCheck"):WaitForChild("HumanoidStateModule"))


local NOCLIP_SPEED_UP = "NoclipSpeedUp"
local NOCLIP_SPEED_DOWN = "NoclipSpeedDown"

local Camera = game.Workspace.CurrentCamera

-- module
NoclipModule = {}

-- keybinds
NoclipModule.NoclipSpeedUp = {Enum.KeyCode.E}
NoclipModule.NoclipSpeedDown = {Enum.KeyCode.Q}
NoclipModule.Forward = {Enum.KeyCode.W}
NoclipModule.Left = {Enum.KeyCode.A}
NoclipModule.Right = {Enum.KeyCode.D}
NoclipModule.Backward = {Enum.KeyCode.S}
NoclipModule.Up = {Enum.KeyCode.Space}

NoclipModule.Speed = 70

NoclipModule.Interval = 0

NoclipModule.Run = function(DeltaTime: number)
    local MoveVector = Vector3.zero
    local Count = 0

    if InputModule.IsHoldingAny(NoclipModule.Forward) then MoveVector += Vector3.new(0, 0, -1); Count += 1 end
    if InputModule.IsHoldingAny(NoclipModule.Backward) then MoveVector += Vector3.new(0, 0, 1); Count += 1 end
    if InputModule.IsHoldingAny(NoclipModule.Left) then MoveVector += Vector3.new(-1, 0, 0); Count += 1 end
    if InputModule.IsHoldingAny(NoclipModule.Right) then MoveVector += Vector3.new(1, 0, 0); Count += 1 end
    if InputModule.IsHoldingAny(NoclipModule.Up) then MoveVector += Vector3.new(0, 1, 0) end

    MoveVector = MoveVector * NoclipModule.Speed * DeltaTime
    if Count >= 2 then MoveVector *= (math.sqrt(2) / 2) end

    HumanoidStateModule.HumanoidRootPart.CFrame = CFrame.new(
        HumanoidStateModule.HumanoidRootPart.Position,
        HumanoidStateModule.HumanoidRootPart.Position + Camera.CFrame.LookVector)
         * CFrame.new(MoveVector)
end

NoclipModule.BindKeys = function()
    ContextActionService:BindAction(
        NOCLIP_SPEED_UP, 
        function(ActionName, InputState, InputObject)
            if ActionName == NOCLIP_SPEED_UP and InputState == Enum.UserInputState.Begin then
                if NoclipModule.Speed < 300 then
                    NoclipModule.Speed += 10
                end
            end

            return Enum.ContextActionResult.Pass
        end,
        false,
        table.unpack(NoclipModule.NoclipSpeedUp)
    )

    ContextActionService:BindAction(
        NOCLIP_SPEED_DOWN, 
        function(ActionName, InputState, InputObject)
            if ActionName == NOCLIP_SPEED_DOWN and InputState == Enum.UserInputState.Begin then
                if NoclipModule.Speed > 10 then
                    NoclipModule.Speed -= 10
                end
            end

            return Enum.ContextActionResult.Pass
        end,
        false,
        table.unpack(NoclipModule.NoclipSpeedDown)
    )
end

NoclipModule.UnbindKeys = function()
    ContextActionService:UnbindAction(NOCLIP_SPEED_UP)
    ContextActionService:UnbindAction(NOCLIP_SPEED_DOWN)
end

return NoclipModule