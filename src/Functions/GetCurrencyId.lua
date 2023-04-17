local function getCurrencyId(givenAmount: number): number
	local closest = math.huge

	for amount, productId in CurrencyProducts do
		if math.abs(givenAmount - amount) < math.abs(amount - closest) then
			closest = amount
		end
	end

	return CurrencyProducts[closest]
end

return getCurrencyId
