FACTION.name = "Recruit"
FACTION.desc = "Recruit"
FACTION.color = Color(16, 159, 0)
FACTION.isDefault = true
FACTION.models = {
	"models/breen.mdl"
}

FACTION.armor = 0
FACTION.maxhealth = 100
FACTION.health = 100
FACTION.weapons = {
 ""
}

function FACTION:onSpawn(client)

	if (IsValid(client)) then
		if (client:getChar()) then
		
		
	
		client:SetArmor(self.armor) -- Sets armour
		client:SetMaxHealth(self.maxhealth) -- Sets maxhealth, that means the health you can be healed to.
		client:SetHealth(self.health) -- Sets your health, you can not be healed to this amount unless your maxhealth is the same. This is needed because gmod sets your health to 100 by default.
		end
	end
end

FACTION.pay = 0
FACTION.isGloballyRecognized = true
FACTION_REC = FACTION.index

-- The 'nice' name of the faction.
-- A description used in tooltips in various menus.
-- A color to distinguish factions from others, used for stuff such as
-- name color in OOC chat.
-- Set the male model choices for character creation.
-- Set the female models to be the same as male models.
-- Set it so the faction requires a whitelist.
-- Return what the name will be set for character creation.

-- FACTION.index is defined when the faction is registered and is just a numeric ID.
-- Here, we create a global variable for easier reference to the ID.