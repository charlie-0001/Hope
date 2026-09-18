local Lighting = game:GetService("Lighting")
local ColorCorrection = Lighting:WaitForChild("ColorCorrection")
local DepthOfField = Lighting:WaitForChild("DepthOfField")
local Atmosphere = Lighting:WaitForChild("Atmosphere")


-- store old lighting changers to return end if theyre touched again
local CurrentLighting: BasePart? = nil
local CurrentAtmosphere: BasePart? = nil

-- begin module
LightingModule = {}

LightingModule.ChangeLighting = function()

end

LightingModule.ChangeAtmosphere = function()

end

LightingModule.ChangeDepthOfField = function()

end

LightingModule.ChangeColorCorrection = function()

end

return LightingModule