PLUGIN.name = "Constitution "
PLUGIN.author = "Zadkiel"
PLUGIN.desc = "Adds a toughness attribute."

if (SERVER) then
	function PLUGIN:EntityTakeDamage(client, dmg)

		if (client:IsPlayer()) then
		
			if (dmg:IsDamageType(DMG_FALL)) then 
				return
			end
		
			if (IsValid(client)) then
				client:getChar():updateAttrib("con", 0.01)
			end
			
			dmg:ScaleDamage( client:getChar():getAttrib("con", 0) / 100) // Damage is now half of what you would normally take.
		end		
	end
end
