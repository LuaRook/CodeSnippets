local function getClusterAroundInstance<T>(instance: Instance, predicate: () -> T): number
	assert(type(predicate) == "function", `Predicate should be function; got {type(predicate)}`)
	local instances: T = predicate()
	local originPosition = extractPosition(instance)

	local cluster = 0
	for _, instance in instances do
		cluster += (extractPosition(instance) - originPosition).Magnitude
	end
	return cluster
end

return getClusterAroundInstance
