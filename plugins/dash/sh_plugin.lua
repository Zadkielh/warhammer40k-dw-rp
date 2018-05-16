PLUGIN.name = "Dash"
PLUGIN.author = "Zadkiel"
PLUGIN.desc = "Enables dashing"

if (SERVER) then
	function PLUGIN:PostPlayerLoadout(client)
	local uniqueID = "nutDash"..client:SteamID()
		client:setNetVar("dash", false)
		client:SetNWBool("CanPound", false)
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
			if client:IsOnGround() then
				if !client:getNetVar("dash") then
				local value = (25 - ((char:getAttrib("end", 0) * 0.1)))

				if client:getLocalVar("stm") <= value then client:setNetVar("dash", true) return end
			
				local value = client:getLocalVar("stm") - (25 - ((char:getAttrib("end", 0) * 0.1)))
				client:setLocalVar("stm", value)
			
				client:setNetVar("dash", true)
				local speed = 0.1 + (char:getAttrib("dex", 0) * 0.0005)
			
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

		if !client:IsOnGround() and client:GetNWBool("JumpPackEnabled") then
			local tr = util.TraceLine({
    		start = client:GetPos(),
   			endpos = client:GetPos() - Vector(0, 0, 35000),
    		filter = client
			})
			local groundpos = tr.HitPos
			if client:GetPos():Distance(groundpos) > 800 then
				if (moveData:KeyDown(IN_WALK)) then
					client:SetNWBool("CanPound", true)
					moveData:SetVelocity( vel - Vector(0, 0, 350))
					
					hook.Add("GetFallDamage", "AssaultSmash", function(ply,spd)
						if ply:GetNWBool("CanPound") then
							ply:GodEnable()
							timer.Simple(0.5, function()
								ply:GodDisable()
							end)
							
							local ef = EffectData()
							ef:SetOrigin(ply:GetPos())
							ef:SetScale(600)
							util.Effect("ThumperDust",ef,true,true)
							util.Effect("zad_medium_explosion",ef,true,true)
							util.Effect("ThumperDust",ef,true,true)
							util.Effect("ThumperDust",ef,true,true)
							ply:EmitSound("ambient/explosions/explode_4.wav",511,35)
												
							util.BlastDamage(ply,ply,ply:GetPos(),spd/6,250)
							ply:SetNWBool("CanPound", false)
							return 0
										
						end
					end
					)
				end
			end
		end
		
	end
end


function PLUGIN:HUDPaintBackground()
	if LocalPlayer():GetNWBool("JumpPackEnabled") then
	local x = ScrW() * 0.95
	local y = ScrH() * 0.6
	local w = 50
	local h = 250
	local red = 255
	local blue = 0
	local green = 205
	local opacity = 150
	
	local value = LocalPlayer():GetAmmoCount("AirboatGun")

	local tr = util.TraceLine({
    	start = LocalPlayer():GetPos(),
   		endpos = LocalPlayer():GetPos() - Vector(0, 0, 35000),
    	filter = LocalPlayer()
	})
	local groundpos = tr.HitPos

	if value <= 750 then
		blue = 0
		green = 50
		red = 250
		opacity = 150
	end

	if value >= 120 then
		blue = 0
		green = 255
		red = 50
		opacity = 150
	end

	if LocalPlayer():GetPos():Distance(groundpos) > 800 then
		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(Material("vgui/ironwill.png"))
		surface.DrawTexturedRect(x, y - 60, 50, 50)
	end
	
	surface.SetDrawColor(red, green, blue, opacity)
	surface.DrawRect(x, y, w, h * value / 150)
	surface.DrawOutlinedRect(x, y, w, h)
	end
end