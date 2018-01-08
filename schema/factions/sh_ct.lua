FACTION.name = "Clone Trooper"
FACTION.desc = "Clone Trooper"
FACTION.color = Color(255, 255, 255)
FACTION.isDefault = false
FACTION.models = {
	"models/gonzo/swbf2phase1/unassigned/unassigned.mdl"
}
FACTION.armor = 100
FACTION.maxhealth = 100
FACTION.health = 100

function FACTION:onSpawn(client)

	if (IsValid(client)) then
		if (client:getChar()) then
		
		client:SetArmor(self.armor) -- Sets armour
		client:SetMaxHealth(self.maxhealth) -- Sets maxhealth, that means the health you can be healed to.
		client:SetHealth(self.health) -- Sets your health, you can not be healed to this amount unless your maxhealth is the same. This is needed because gmod sets your health to 100 by default.
		end
	end
end

FACTION.pay = 10
FACTION.isGloballyRecognized = true
FACTION_CT = FACTION.index