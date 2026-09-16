local RunService = game:GetService("RunService")

local Process = require(script:WaitForChild("ClientManagerModule"))
local HumanoidStateModule = require(script:WaitForChild("HumanoidStateModule"))
local CollisionCheckModule = require(script:WaitForChild("CollisionCheckModule"))


-- table for processes
local Processes = {} :: { Process.Process }


-- load all processes and add them to a table
local HumanoidStateProcess = Process.new(
    HumanoidStateModule.Interval, 
    HumanoidStateModule.Run
)
table.insert(Processes, HumanoidStateProcess)

local CollisionCheckProcess = Process.new(
    CollisionCheckModule.Interval,
    CollisionCheckModule.Run
)
table.insert(Processes, CollisionCheckProcess)

-- end process loading here

RunService.RenderStepped:Connect(function (DeltaTime: number)
    for _, process in ipairs(Processes) do
        process.LastRun += DeltaTime
        if process.LastRun >= process.Interval then
            process.Run()
            process.LastRun = 0
        end
    end
end)

