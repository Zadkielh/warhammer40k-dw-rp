FACTION.name = "Death Watch Captain"
FACTION.desc = ""
FACTION.color = Color(0, 89, 255)
FACTION.isDefault = false
FACTION.models = {
	"models/lotusservers/characters/deathwatch/players/deathwatch_players.mdl"
}
FACTION.armor = 200
FACTION.maxhealth = 250
FACTION.health = 250

function FACTION:onSpawn(client)
		client:SetArmor(self.armor) -- Sets armour
		client:SetMaxHealth(self.maxhealth) -- Sets maxhealth, that means the health you can be healed to.
		client:SetHealth(self.health) -- Sets your health, you can not be healed to this amount unless your maxhealth is the same. This is needed because gmod sets your health to 100 by default.
end

FACTION.pay = 30
FACTION.isGloballyRecognized = true
FACTION_DW_CPT = FACTION.index