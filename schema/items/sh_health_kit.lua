ITEM.name = "Health Kit"
ITEM.category = "Medical"
ITEM.desc = "A large medical kit capable of more healing."
ITEM.model = "models/healthvial.mdl"
ITEM.price = 0
ITEM.functions.Use = {
	sound = "items/medshot4.wav",
	onRun = function(item)
		item.player:SetHealth(math.min(item.player:Health() + 50, 100))
	end
}
ITEM.factions = {FACTION_CP, FACTION_OW}