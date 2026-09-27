-- import modules
local MusicZoneModule = require(script.Parent:WaitForChild("MusicZoneModule"))
local DistanceCheckModule = require(script.Parent.Parent:WaitForChild("DistanceCheckModule"))


local PulseParts = {}
local AverageLoudness = 0
local SmoothingFactor = 0.025


MusicPulsePart = {}

MusicPulsePart.Interval = 0
MusicPulsePart.Type = "RenderStepped"

MusicPulsePart.Run = function(DeltaTime: number)
    local PlaybackLoudness
    if MusicZoneModule.CurrentSong then
        PlaybackLoudness = MusicZoneModule.CurrentSong.PlaybackLoudness
    else return end

    if AverageLoudness == 0 then
		AverageLoudness = PlaybackLoudness
	else
		-- exponential moving average formula
		AverageLoudness = AverageLoudness + (PlaybackLoudness - AverageLoudness) * SmoothingFactor
	end

    for _, Part: BasePart in ipairs(PulseParts) do
        if not DistanceCheckModule.DistanceCheck(Part, 150) then continue end
        MusicPulsePart.Pulse(Part, PlaybackLoudness)
    end
end

MusicPulsePart.Pulse = function(Part: BasePart, PlaybackLoudness: number)
    if AverageLoudness <= 0 then 
        Part.Transparency = 0 
    return end

    local Ratio = PlaybackLoudness / AverageLoudness
    local TargetTransparency = 0.8 - (Ratio * 0.3)
    Part.Transparency = math.clamp(TargetTransparency, 0.2, 0.8)
end

MusicPulsePart.InitializePart = function(Part: BasePart)
    table.insert(PulseParts, Part)
end

return MusicPulsePart