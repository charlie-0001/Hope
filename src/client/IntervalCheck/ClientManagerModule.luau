local Process = {}
Process.__index = Process

export type Process = typeof(setmetatable({} :: {
    Interval: number,
    Run: () -> (),
    LastRun: number
}, Process))

function Process.new(Interval: number, Run: () -> ()): Process
    local self = setmetatable({} :: any, Process)

    self.Interval = Interval
    self.Run = Run
    self.LastRun = 0

    return self
end

return Process