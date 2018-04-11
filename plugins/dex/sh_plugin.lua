PLUGIN.name = "Dexterity"
PLUGIN.author = "Zadkiel"
PLUGIN.desc = "Increases jump height, and reflexes"

if (SERVER) then

	function PLUGIN:EntityTakeDamage(client, dmg)
	
	if (client:IsPlayer()) then
		if (dmg:IsDamageType(DMG_FALL)) then return end
		
		local uniqueID = client:SteamID()
		local value = (client:getChar():getAttrib("dex", 0) * 0.2)
		
			if (IsValid(client)) then
				local character = client:getChar()
				local chance = math.random(0, 100)
				
					if (chance + value) >= 90 then
						
						dmg:SetDamage( dmg:GetDamage() * 0.25)
						client:TakeDamageInfo( dmg )
						--dmg:SetDamage(0)
					end
			end
			
		end
	end

	
	function PLUGIN:PostPlayerLoadout(client)
	
		local value = client:getChar():getAttrib("dex", 0)
	
		if (IsValid(client)) then
			local uniqueID = "nutDex"..client:SteamID()
			timer.Create(uniqueID, 0.25, 0, function()
			if !IsValid(client) then return end
			if ( (client:KeyDown( IN_JUMP )) or (client:KeyDown(IN_DUCK)) )	then
				client:getChar():updateAttrib("dex", 0.001)
				end
			end)
			else
					timer.Remove(uniqueID)
			end
	
		end

end

