KillBrickModule = {}

KillBrickModule.Kill = function(part: BasePart, humanoid: Humanoid)
    local power = part:GetAttribute("Power") or 5
    humanoid.Health -= power
end

return KillBrickModule