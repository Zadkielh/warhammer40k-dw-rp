FACTION.name = "Death Watch Apothecary"
FACTION.desc = ""
FACTION.color = Color(255, 255, 255)
FACTION.isDefault = false
FACTION.models = {
	"models/zadkiel/deathwatch/players/apothecary_marine_player.mdl"
}
FACTION.armor = 150
FACTION.maxhealth = 250
FACTION.health = 250

function FACTION:onSpawn(client)
		client:SetArmor(self.armor) -- Sets armour
		client:SetMaxHealth(self.maxhealth) -- Sets maxhealth, that means the health you can be healed to.
		client:SetHealth(self.health) -- Sets your health, you can not be healed to this amount unless your maxhealth is the same. This is needed because gmod sets your health to 100 by default.
    	client:SetModelScale( 1.36, 0)
end

FACTION.pay = 25
FACTION.isGloballyRecognized = true
FACTION_DW_APOTH = FACTION.index