local PhysicsService = game:GetService("PhysicsService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)
local Observers = require(ReplicatedStorage.Packages.Observers) --/ "sleitnick/observers@^0.3.2"

local COLLISION_GROUP_NAME = "Characters"

PhysicsService:RegisterCollisionGroup(COLLISION_GROUP_NAME)
PhysicsService:CollisionGroupSetCollidable(COLLISION_GROUP_NAME, COLLISION_GROUP_NAME, false)

local CharacterService = Knit.CreateService({
	Name = "CharacterService",
})

function CharacterService:KnitStart()
	local function DescendantAdded(descendant)
		if descendant:IsA("BasePart") then
			descendant.CollisionGroup = COLLISION_GROUP_NAME
		end
	end

	Observers.observeCharacter(function(player, character)
		local descendantAddedConn = character.DescendantAdded:Connect(DescendantAdded)
		for _, descendant in character:GetDescendants() do
			task.spawn(DescendantAdded, descendant)
		end

		return function()
			descendantAddedConn:Disconnect()
		end
	end)
end

return CharacterService
