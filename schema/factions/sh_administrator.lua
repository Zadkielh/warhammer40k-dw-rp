FACTION.name = "fAdminName"
FACTION.desc = "fAdminDesc"
FACTION.color = Color(237, 179, 97)
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

FACTION_ADMIN = FACTION.index