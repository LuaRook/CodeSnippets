local function extractPosition(instance: Instance)
	assert(typeof(instance) == "Instance", `Instance expected; got {typeof(instance)}`)

	if instance:IsA("Model") then
		return instance.PrimaryPart.Position
	elseif instance:IsA("Attachment") then
		return instance.WorldPosition
	end

	return instance.Position
end

return extractPosition
