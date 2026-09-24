-- load services
local CollectionService = game:GetService("CollectionService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")


-- load modules
local CollisionCheckModule = require(script.Parent.Parent:WaitForChild("IntervalCheck"):WaitForChild("CollisionCheckModule"))


local CurrentZone: BasePart = nil
local OldZone: BasePart = nil


MusicZoneModule = {}

MusicZoneModule.ChangeMusic = function(Part: BasePart)
    if Part == CurrentZone then return end

    local TweenTime = Part:GetAttribute("TweenTime") or 1

    local OriginalSound = Part:FindFirstChildOfClass("Sound")
    if not OriginalSound then return end
    local Sound: Sound = SoundService:FindFirstChild(OriginalSound.Name)

    if CurrentZone == nil then 
        CurrentZone = Part 
    else
        OldZone = CurrentZone
        CurrentZone = Part
    end

    -- finish this

end

MusicZoneModule.LoadMusic = function(Sound: Sound)
    print("Hi")
    if not SoundService:FindFirstChild(Sound.Name) then
        local Clone = Sound:Clone()
        Clone.Parent = SoundService
    end
end

return MusicZoneModule