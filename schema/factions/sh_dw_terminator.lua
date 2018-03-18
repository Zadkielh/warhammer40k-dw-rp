FACTION.name = "Death Watch Terminator"
FACTION.desc = ""
FACTION.color = Color(0, 230, 255)
FACTION.isDefault = false
FACTION.models = {
	"models/zadkiel/deathwatch/players/terminator_ind_player.mdl"
}
FACTION.armor = 500
FACTION.maxhealth = 3500
FACTION.health = 3500

function FACTION:onSpawn(client)
		client:SetArmor(self.armor) -- Sets armour
		client:SetMaxHealth(self.maxhealth) -- Sets maxhealth, that means the health you can be healed to.
		client:SetHealth(self.health) -- Sets your health, you can not be healed to this amount unless your maxhealth is the same. This is needed because gmod sets your health to 100 by default.
		client:SetWalkSpeed(nut.config.get("walkSpeed") + 40)
end

FACTION.pay = 10
FACTION.isGloballyRecognized = true
FACTION_DW_TERMI = FACTION.index