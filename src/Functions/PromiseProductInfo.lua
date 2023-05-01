local function promiseProductInfo(id, infoType: Enum.InfoType?)
	return Promise.new(function(resolve, reject)
		local productInfo = MarketplaceService:GetProductInfo(id, infoType)

		if productInfo and productInfo.AssetId == id then
			resolve(productInfo)
		else
			reject("Couldn't get product info for {id}")
		end
	end)
end

return promiseProductInfo
