local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)
local Promise = require(ReplicatedStorage.Packages.Promise)

local PartyService = Knit.CreateService({
	Name = "PartyService",
})

local function getReservedServerId()
	return Promise.new(function(resolve)
		resolve(TeleportService:ReserveServer(PLACE_ID))
	end):catch(warn)
end

function PartyService:ReserveServer()
	return Promise.retryWithDelay(getReservedServerId, 5, 5)
end

function PartyService:TeleportParty(party)
	self:ReserveServer()
		:andThen(function(serverId)
			TeleportService:TeleportToPrivateServer(PLACE_ID, serverId, party)
		end)
		:catch(warn)
end

return PartyService
