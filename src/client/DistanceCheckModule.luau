-- load modules
local HumanoidStateModule = require(script.Parent:WaitForChild("IntervalCheck"):WaitForChild("HumanoidStateModule"))


DistanceCheckModule = {}

DistanceCheckModule.DistanceCheck = function(Part: BasePart, Threshold: number)
    local hrp: BasePart = HumanoidStateModule.HumanoidRootPart 
    if not hrp then return false end

    local distance = (hrp.Position - Part.Position).Magnitude
    return distance <= Threshold
end

return DistanceCheckModule