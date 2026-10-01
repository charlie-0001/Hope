-- import modules
local MusicZoneModule = require(script.Parent:WaitForChild("MusicZoneModule"))
local DistanceCheckModule = require(script.Parent.Parent:WaitForChild("DistanceCheckModule"))


local PulseParts = {}
local CurrentTransparency = {}

local AverageLoudness = 0
local SmoothingFactor = 0.005


MusicPulsePart = {}

MusicPulsePart.Interval = 0.05
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
        local DistanceCheck = Part:GetAttribute("DistanceCheck")
        if DistanceCheck == true then 
            local DistanceCheckLength = Part:GetAttribute("DistanceCheckLength") or 150
            if not DistanceCheckModule.DistanceCheck(Part, DistanceCheckLength) then continue end
        end
        MusicPulsePart.Pulse(Part, PlaybackLoudness)
    end
end

MusicPulsePart.Pulse = function(Part: BasePart, PlaybackLoudness: number)
    if AverageLoudness <= 0 then 
        Part.Transparency = 0 
    return end

    local Ratio = PlaybackLoudness / AverageLoudness
    local TargetTransparency = 0.75 - ((Ratio - 1) * 0.2)
    TargetTransparency = math.clamp(TargetTransparency, 0, 0.9)

    local Current = CurrentTransparency[Part] or Part.Transparency
    local NewTransparency = Current + (TargetTransparency - Current) * 0.25

    CurrentTransparency[Part] = NewTransparency
    Part.Transparency = NewTransparency
end

MusicPulsePart.InitializePart = function(Part: BasePart)
    table.insert(PulseParts, Part)
end

return MusicPulsePart