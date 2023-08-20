--[[
	Utility functions for detecting clusters of instances / players
]]

local ClusterUtil = {}

local function extractPosition(instance: Instance): Vector3
    if instance:IsA("Model") then
        return instance:GetPivot()
    elseif instance:IsA("Attachment") then
        return instance.WorldPosition
    end

    return instance.Position
end

-- Returns the combined magnitude of provided instances relative to the target.
-- Lower magnitudes indicate a larger cluster aronud the target.
function ClusterUtil.fromInstance(target: Instance, instances: { Instance }): number
	-- Declare variables for main logic
	local originPosition: Vector3 = extractPosition(target)
	local magnitude: number = 0

	-- Loop through instances in table and add magnitude
	for _, instance in instances do
		magnitude += (extractPosition(instance) - originPosition).Magnitude
	end
	return magnitude
end

-- Given table of canidates and nearby instances, find canidate
-- that has the largest cluster. Useful for finding high-activity areas.
function ClusterUtil.fromTable(canidates: { Instance }, instances: { Instance }): Instance
    -- Declare variables
    local smallest: number = math.huge
    local bestCanidate: Instance

    -- Find canidate with smallest magnitude to find instance with \\
    for _, canidate in canidates do
        local cluster: number = ClusterUtil.fromInstance(canidate, instances)
        if cluster < smallest then
            smallest = cluster
            bestCanidate = canidate
        end
    end

    -- Return best canidate
    return bestCanidate
end

return ClusterUtil
