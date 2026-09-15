-- load modules
local HumanoidStateModule = require(script.Parent:WaitForChild("HumanoidState"))


-- global references
local OverlapParams = OverlapParams.new()


local CollisionCheck = {}

CollisionCheck.Interval = 0
CollisionCheck.PartsInPlayer = {} :: {Instance}

CollisionCheck.Run = function()
    local 
end

return CollisionCheck