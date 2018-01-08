PLUGIN.name = "Speed"
PLUGIN.author = "Zadkiel"
PLUGIN.desc = "Adds a speed attribute."

if (SERVER) then
	function PLUGIN:PostPlayerLoadout(client)
		
		local uniqueID = client:SteamID()
		local RunSpeed = client:GetRunSpeed()
		
		timer.Create(uniqueID, 0.25, 0, function()
			if (IsValid(client)) then
				local character = client:getChar()

				if (client:GetMoveType() != MOVETYPE_NOCLIP) then
					
					RunSpeed = (nut.config.get("runSpeed") + (character:getAttrib("speed", 0) * 1))
					
					if (client:KeyDown( IN_SPEED ))	then
						client:getChar():updateAttrib("speed", 0.001)
						client:getChar():updateAttrib("agility", 0.0005)
						client:SetRunSpeed(RunSpeed)
					end
				
				end
				
				else
					timer.Remove(uniqueID)
			end	
		end)

	end
end
