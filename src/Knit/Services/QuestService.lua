local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Knit = require(ReplicatedStorage.Packages.Knit)

local DataService

local Quests = script.Parent.Quests

local QuestService = Knit.CreateService({
	Name = "QuestService",
	Client = {},
	QuestCache = {},
})

type Quest = {
	Id: string,
	Name: string,
	TimeBegan: number,
}

function QuestService:GiveQuest(player: Player, questName: string)
	assert(questName, "QuestName not valid!")

	DataService:Update(player, "Quests", function(data)
		local questData: Quest = {
			Id = nil,
			Name = questName,

			TimeBegan = os.clock(),
		}

		table.insert(data, questData)
	end)
end

function QuestService:KnitInit()
	for _, module in Quests:GetChildren() do
		if module:IsA("ModuleScript") then
			self.QuestCache[module.Name] = require(module)
		end
	end
end

function QuestService:KnitStart()
	DataService = Knit.GetService("DataService")
end

return QuestService
