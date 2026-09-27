local debounce = false


KillBrickModule = {}

KillBrickModule.Kill = function(part: BasePart, humanoid: Humanoid)
    if debounce then return end
    debounce = true

    local power = part:GetAttribute("Power") or 5
    humanoid.Health -= power

    task.wait(0.1)
    debounce = false
end

return KillBrickModule