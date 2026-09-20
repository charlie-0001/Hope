-- load services
local RunService = game:GetService("RunService")


-- load modules
local TurretModule = require(script.Parent:WaitForChild("ClientObjects"):WaitForChild("TurretModule"))
local ProcessModule = require(script:WaitForChild("ProcessModule"))
local HumanoidStateModule = require(script:WaitForChild("HumanoidStateModule"))
local CollisionCheckModule = require(script:WaitForChild("CollisionCheckModule"))
local InputModule = require(script.Parent:WaitForChild("Input"):WaitForChild("InputModule"))


-- load all processes and add them to a table
local HumanoidStateProcess = ProcessModule.new(
    HumanoidStateModule.Interval, 
    HumanoidStateModule.Run
)
ProcessModule.InsertProcess(HumanoidStateProcess)

local CollisionCheckProcess = ProcessModule.new(
    CollisionCheckModule.Interval,
    CollisionCheckModule.Run
)
ProcessModule.InsertProcess(CollisionCheckProcess)

local TurretProcess = ProcessModule.new(
    TurretModule.Interval,
    TurretModule.Run
)
ProcessModule.InsertProcess(TurretProcess)

local InputProcess = ProcessModule.new(
    InputModule.Interval,
    InputModule.Run
)
ProcessModule.InsertProcess(InputProcess)
-- end process loading here


RunService.Heartbeat:Connect(function (DeltaTime: number)
    for _, Process in ipairs(ProcessModule.Processes) do
        Process.LastRun += DeltaTime
        if Process.LastRun >= Process.Interval then
            Process.Run(DeltaTime)
            Process.LastRun = 0
        end
    end
end)

