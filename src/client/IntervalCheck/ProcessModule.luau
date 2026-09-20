local Process = {}

-- current processes stored here
Process.Processes = {} :: {Process}

-- process object
Process.__index = Process

export type Process = typeof(setmetatable({} :: {
    Interval: number,
    Run: (DeltaTime: number?) -> (),
    LastRun: number
}, Process))

function Process.new(Interval: number, Run: (DeltaTime: number?) -> ()): Process
    local self = setmetatable({} :: any, Process)

    self.Interval = Interval
    self.Run = Run
    self.LastRun = 0

    return self
end

-- useful functions for processes
Process.InsertProcess = function(Process: Process)
    table.insert(Process.Processes, Process)
end

Process.RemoveProcess = function(Process: Process)
    table.remove(Process.Processes, table.find(Process.Processes, Process))
end

return Process