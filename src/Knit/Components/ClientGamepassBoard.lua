local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Gamepasses = require(ReplicatedStorage.Common.Gamepasses)
local TroveExtension = require(ReplicatedStorage.Common.Extensions.TroveExtension)

local Info = {
	Gamepasses = {},
	Products = {},
}

for i, id in Gamepasses.Gamepasses do
	local data = MarketplaceService:GetProductInfo(id, Enum.InfoType.GamePass)
	data.GamepassId = id
	Info.Gamepasses[i] = data
end

for i, id in Gamepasses.Products do
	local data = MarketplaceService:GetProductInfo(id, Enum.InfoType.Product)
	Info.Products[i] = data
end

local ClientGamepassBoard = Component.new({ Tag = "GamepassBoard", Extensions = { TroveExtension } })

function ClientGamepassBoard:Start()
	self.Streamable = self._trove:Construct(Streamable, self.Instance, "Board")

	self._trove:Add(self.Streamable:Observe(function(part, trove)
		local mounted = Roact.mount(Roact.createElement(GamepassBoardApp, { data = Info }), part, self.Instance.Name)
		trove:Add(function()
			Roact.unmount(mounted)
		end)
	end))
end

return ClientGamepassBoard
