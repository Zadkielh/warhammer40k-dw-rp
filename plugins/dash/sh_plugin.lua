PLUGIN.name = "Dash"
PLUGIN.author = "Zadkiel"
PLUGIN.desc = "Enables dashing"

if (SERVER) then
	function PLUGIN:PostPlayerLoadout(client)
	local uniqueID = "nutDash"..client:SteamID()
		client:setNetVar("dash", false)
		timer.Create( uniqueID, 1, 0, function()
			client:setNetVar("dash", false)
		end
		)
	end
	
	function PLUGIN:Move(client, moveData)
	local ang = moveData:GetMoveAngles()
	local pos = moveData:GetOrigin()
	local vel = moveData:GetVelocity()
	local char = client:getChar()
		
		if (moveData:KeyDown(IN_WALK)) then
			if client:GetVelocity():Length() < 100 then return end
			if !client:IsOnGround() then return end
			if !client:getNetVar("dash") then
			local value = (25 - ((char:getAttrib("end", 0) * 0.1)))

			if client:getLocalVar("stm") <= value then client:setNetVar("dash", true) return end
			
			local value = client:getLocalVar("stm") - (25 - ((char:getAttrib("end", 0) * 0.1)))
			client:setLocalVar("stm", value)
			
			client:setNetVar("dash", true)
			local speed = 0.1 + (char:getAttrib("dex", 0) * 0.0005)
			print(speed)
			
			vel = vel + ang:Forward() * moveData:GetForwardSpeed() * speed
			vel = vel + ang:Right() * moveData:GetSideSpeed() * speed
			vel = vel + ang:Up() * moveData:GetUpSpeed() * speed
			
			moveData:SetVelocity( vel - Vector(0, 0, 5000) )

			char:updateAttrib("end", 0.01)
			char:updateAttrib("stm", 0.01)
			char:updateAttrib("dex", 0.01)
			
			end
		end
	end

end
