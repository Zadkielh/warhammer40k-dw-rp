FACTION.name = "Death Watch Primaris"
FACTION.desc = ""
FACTION.color = Color(255, 255, 255)
FACTION.isDefault = false
FACTION.models = {
	"models/zadkiel/deathwatch/players/primaris_deathwatch_player.mdl"
}
FACTION.armor = 400
FACTION.maxhealth = 2750
FACTION.health = 2750

function FACTION:onSpawn(client)
		client:SetArmor(self.armor) -- Sets armour
		client:SetMaxHealth(self.maxhealth) -- Sets maxhealth, that means the health you can be healed to.
		client:SetHealth(self.health) -- Sets your health, you can not be healed to this amount unless your maxhealth is the same. This is needed because gmod sets your health to 100 by default.
    	client:SetModelScale( 1.5, 0)
end

FACTION.pay = 25
FACTION.isGloballyRecognized = true
FACTION_DW_PRIM = FACTION.index