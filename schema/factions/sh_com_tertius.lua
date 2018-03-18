FACTION.name = "Watch Company Tertius"
FACTION.desc = ""
FACTION.color = Color(128, 128, 0)
FACTION.isDefault = false
FACTION.models = {
	"models/zadkiel/deathwatch/players/deathwatch_mk7_aquila_player.mdl"
}
FACTION.armor = 200
FACTION.maxhealth = 2000
FACTION.health = 2000

function FACTION:onSpawn(client)
		client:SetArmor(self.armor) -- Sets armour
		client:SetMaxHealth(self.maxhealth) -- Sets maxhealth, that means the health you can be healed to.
		client:SetHealth(self.health) -- Sets your health, you can not be healed to this amount unless your maxhealth is the same. This is needed because gmod sets your health to 100 by default.
end

FACTION.pay = 25
FACTION.isGloballyRecognized = true
FACTION_PRIMUS = FACTION.index