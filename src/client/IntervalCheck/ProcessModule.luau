local Process = {}

-- current processes stored here
Process.RenderSteppedProcesses = {} :: {Process}
Process.HeartbeatProcesses = {} :: {Process}

-- process object
Process.__index = Process

export type Process = typeof(setmetatable({} :: {
    Interval: number,
    Run: (DeltaTime: number?) -> (),
    Type: string,
    LastRun: number
}, Process))

function Process.new(Interval: number, Run: (DeltaTime: number?) -> (), Type: string): Process
    local self = setmetatable({} :: any, Process)

    self.Interval = Interval
    self.Run = Run
    self.Type = Type
    self.LastRun = 0

    return self
end

-- useful functions for processes
Process.InsertProcess = function(Process: Process)
    if Process.Type == "Heartbeat" then
        table.insert(Process.HeartbeatProcesses, Process)
    elseif Process.Type == "RenderStepped" then
        table.insert(Process.RenderSteppedProcesses, Process)
    end
end

Process.RemoveProcess = function(Process: Process)
    if Process.Type == "Heartbeat" then
        table.remove(Process.HeartbeatProcesses, table.find(Process.HeartbeatProcesses, Process))
    elseif Process.Type == "RenderStepped" then
        table.remove(Process.RenderSteppedProcesses, table.find(Process.RenderSteppedProcesses, Process))
    end
end

return Process