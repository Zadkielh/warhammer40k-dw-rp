FACTION.name = "Ordo Xenos"
FACTION.desc = "Ordo Xenos"
FACTION.color = Color(93, 95, 73)
FACTION.isDefault = false
FACTION.models = {
	"models/players/stormtrooper_custom.mdl"
}
FACTION.armor = 100
FACTION.maxhealth = 250
FACTION.health = 250

function FACTION:onSpawn(client)
		client:SetArmor(self.armor) -- Sets armour
		client:SetMaxHealth(self.maxhealth) -- Sets maxhealth, that means the health you can be healed to.
		client:SetHealth(self.health) -- Sets your health, you can not be healed to this amount unless your maxhealth is the same. This is needed because gmod sets your health to 100 by default.
end
FACTION.pay = 40
FACTION.isGloballyRecognized = true

FACTION_IST = FACTION.index