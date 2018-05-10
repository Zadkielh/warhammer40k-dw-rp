ITEM.name = "Combat Enhancer"
ITEM.model = "models/Items/BoxFlares.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.desc = "Enhances Stamina, Endurance and Dexterity for a small period."
ITEM.category = "Medical"
ITEM.heal = 0
ITEM.uses = 1
ITEM.reps = 5
ITEM.bandage = false

ITEM.functions.Use = {
	onRun = function(item)
	local client = item.player
		local char = client:getChar()
		if (char and client:Alive()) then
			char:addBoost(item.uniqueID, "stm",20)
			char:addBoost(item.uniqueID, "end", 20)
			char:addBoost(item.uniqueID, "dex", 20)
				
				local charID = char:getID()
				local name = item.name
						timer.Create("DrugEffect_" .. item.uniqueID .. "_" .. client:EntIndex(), 120, 1, function()
							if (client and IsValid(client)) then
								local curChar = client:getChar()
								if (curChar and curChar:getID() == charID) then
									client:notifyLocalized("drugWornout", name)
									char:removeBoost(item.uniqueID, "stm")
									char:removeBoost(item.uniqueID, "end")
									char:removeBoost(item.uniqueID, "dex")
								end
							end
						end)
			
			return true
		end

		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}
