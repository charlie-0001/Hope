local Players = game:GetService("Players")
local PhysicsService = game:GetService("PhysicsService")

PhysicsService:CollisionGroupSetCollidable("Players", "Players", false)

local function SetCollisionGroup(Character)
	for _, Part in pairs(Character:GetDescendants()) do
		if Part:IsA("BasePart") then
			Part.CollisionGroup = "Players"
		else
			if Part:IsA("Accessory") then
				Part.CanTouch = false
				Part.CanQuery = false
			end
		end
	end
end

Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(SetCollisionGroup)
	if Player.Character then
		SetCollisionGroup(Player.Character)
	end
end)

for _, Player in pairs(Players:GetPlayers()) do
	if Player.Character then
		SetCollisionGroup(Player.Character)
	end
end

-- fix collision groups