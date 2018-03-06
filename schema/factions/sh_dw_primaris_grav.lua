FACTION.name = "Death Watch Primaris Gravis Armour"
FACTION.desc = ""
FACTION.color = Color(255, 255, 255)
FACTION.isDefault = false
FACTION.models = {
	"models/zadkiel/deathwatch/players/primaris_gravis_deathwatch_player.mdl"
}
FACTION.armor = 300
FACTION.maxhealth = 400
FACTION.health = 400

function FACTION:onSpawn(client)
		client:SetArmor(self.armor) -- Sets armour
		client:SetMaxHealth(self.maxhealth) -- Sets maxhealth, that means the health you can be healed to.
		client:SetHealth(self.health) -- Sets your health, you can not be healed to this amount unless your maxhealth is the same. This is needed because gmod sets your health to 100 by default.
    	client:SetModelScale( 1.5, 0)
end

FACTION.pay = 25
FACTION.isGloballyRecognized = true
FACTION_DW_PRIM_GRAV = FACTION.index