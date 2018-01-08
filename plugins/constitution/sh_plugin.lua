PLUGIN.name = "Constitution "
PLUGIN.author = "Zadkiel"
PLUGIN.desc = "Adds a toughness attribute."

if (SERVER) then
	function PLUGIN:EntityTakeDamage(client, dmg)
	
	if (client:IsPlayer()) then
		if (dmg:IsDamageType(DMG_FALL)) then return end
		
		local uniqueID = client:SteamID()
		local hp = client:Health()
		
			if (IsValid(client)) then
				local character = client:getChar()
					
						client:getChar():updateAttrib("con", 0.01)
					end
				
			end
		end

	
	function PLUGIN:PostPlayerLoadout(client)
	
		local value = client:getChar():getAttrib("con", 0)
	
		if (IsValid(client)) then
			print(value)
			client:SetMaxHealth(client:GetMaxHealth() + (value / 2))
			client:SetHealth(client:GetMaxHealth())
			
		end
	end
end

