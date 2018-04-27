FACTION.name = "Event Characters"
FACTION.desc = ""
FACTION.color = Color(255, 255, 255)
FACTION.isDefault = false
FACTION.models = {
	"models/breen.mdl"
}
FACTION.armor = 200
FACTION.maxhealth = 2000
FACTION.health = 2000

function FACTION:onSpawn(client)
		client:SetArmor(self.armor) -- Sets armour
		client:SetMaxHealth(self.maxhealth) -- Sets maxhealth, that means the health you can be healed to.
		client:SetHealth(self.health) -- Sets your health, you can not be healed to this amount unless your maxhealth is the same. This is needed because gmod sets your health to 100 by default.
end
FACTION.pay = 40
FACTION.isGloballyRecognized = true

FACTION_EVENT = FACTION.index