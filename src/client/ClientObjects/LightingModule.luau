-- load services
local TweenService = game:GetService("TweenService")
t

local Lighting = game:GetService("Lighting")
local ColorCorrection = Lighting:WaitForChild("ColorCorrection")
local DepthOfField = Lighting:WaitForChild("DepthOfField")
local Atmosphere = Lighting:WaitForChild("Atmosphere")


-- store old lighting changers to return end if theyre touched again
local CurrentLighting: BasePart? = nil
local CurrentAtmosphere: BasePart? = nil
local CurrentColorCorrection: BasePart? = nil
local CurrentDepthOfField: BasePart? = nil


-- valid actions for all lighting
local LightingActions = {"Ambient", "Brightness", "ColorShift_Bottom", "ColorShift_Top", "EnvironmentDiffuseScale", 
"OutdoorAmbient", "ClockTime", "ExposureCompensation"}

local AtmosphereActions = {"Density", "Offset", "Color", "Decay", "Glare", "Haze"}

local ColorCorrectionActions = {"Brightness", "Contrast", "Saturation", "TintColor"}

local DepthOfFieldActions = {"FarIntensity", "FocusDistance", "InFocusRadius", "NearIntensity"}



-- begin module
LightingModule = {}

-- all of these functions are lowkey the same. might be better to just centralize them somehow. its kind of minor though.
LightingModule.ChangeLighting = function(Part: BasePart)
    if Part == CurrentLighting then return end
    CurrentLighting = Part

    local Attributes = Part:GetAttributes()
    local TweenTime = Part:GetAttribute("TweenTime") or 1

    for Name, Value in pairs(Attributes) do
        if table.find(LightingActions, Name) then
            if Lighting[Name] == Value then continue end -- skip tweening if values are the same

            local NewTweenInfo = TweenInfo.new(TweenTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
            local NewTween = TweenService:Create(Lighting, NewTweenInfo, {[Name] = Value})
            NewTween:Play()
        end
    end

    local GlobalShadows = Part:GetAttribute("GlobalShadows") or false
    Lighting.GlobalShadows = GlobalShadows
end

LightingModule.ChangeAtmosphere = function(Part: BasePart)
    if Part == CurrentAtmosphere then return end
    CurrentAtmosphere = Part

    local Attributes = Part:GetAttributes()
    local TweenTime = Part:GetAttribute("TweenTime") or 1

    for Name, Value in pairs(Attributes) do
        if table.find(AtmosphereActions, Name) then
            if AtmosphereActions[Name] == Value then continue end

            local NewTweenInfo = TweenInfo.new(TweenTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
            local NewTween = TweenService:Create(Atmosphere, NewTweenInfo, {[Name] = Value})
            NewTween:Play()
        end
    end
end

LightingModule.ChangeDepthOfField = function(Part: BasePart)
    if Part == CurrentDepthOfField then return end
    CurrentDepthOfField = Part

    local Attributes = Part:GetAttributes()
    local TweenTime = Part:GetAttribute("TweenTime") or 1

    for Name, Value in pairs(Attributes) do
        if table.find(DepthOfFieldActions, Name) then
            if DepthOfFieldActions[Name] == Value then continue end 

            local NewTweenInfo = TweenInfo.new(TweenTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
            local NewTween = TweenService:Create(DepthOfField, NewTweenInfo, {[Name] = Value})
            NewTween:Play()
        end
    end
end

LightingModule.ChangeColorCorrection = function(Part: BasePart)
    if Part == CurrentColorCorrection then return end
    CurrentColorCorrection = Part

    local Attributes = Part:GetAttributes()
    local TweenTime = Part:GetAttribute("TweenTime") or 1

    for Name, Value in pairs(Attributes) do
        if table.find(ColorCorrectionActions, Name) then
            if ColorCorrection[Name] == Value then continue end

            local NewTweenInfo = TweenInfo.new(TweenTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
            local NewTween = TweenService:Create(ColorCorrection, NewTweenInfo, {[Name] = Value})
            NewTween:Play()
        end
    end
end

return LightingModule