local RunService = game:GetService("RunService")

local Process = require(script:WaitForChild("ClientManager"))
local HumanoidStateModule = require(script:WaitForChild("HumanoidState"))

-- table for processes
local Processes = {} :: { Process.Process }


-- load all processes and add them to a table
local HumanoidStateProcess = Process.new(
    0, 
    HumanoidStateModule.Run
)
table.insert(Processes, HumanoidStateProcess)

-- end process loading here

RunService.RenderStepped:Connect(function (deltatime: number)
    for _, process in ipairs(Processes) do
        process.Run()
    end
end)

