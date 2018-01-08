-- Set the 'nice' display name for the class.
CLASS.name = "Flame Trooper"
-- Set the faction that the class belongs to.
CLASS.faction = FACTION_CT
CLASS.model = "models/Barney.mdl"
CLASS.health = 150
CLASS.armor = 80
CLASS.weapons = {

	"cw_ak74",
	"weapon_frag",

}
-- Set what happens when the player has been switched to this class.
-- It passes the player which just switched.
function CLASS:onSet(client)
		client:SetModel(self.model)
		client:SetHealth(self.health)
		
		for key, var in pairs(self.weapons)  do
				client:Give(key)
				client:GiveAmmo( 120, "AR2", false )
				client:GiveAmmo( 2, "Grenade", false )
		end

end

function CLASS:onLeave(client)
		
		for key, var in pairs(self.weapons)  do
				client:StripWeapon(key)
		end
end

function CLASS:onCanBe(client)
		return true
end

-- CLASS.index is defined internall when the class is registered.
-- It is basically the class's numeric ID.
-- We set a global variable to save this index for easier reference.
CLASS_FLAME_TROOPER = CLASS.index



