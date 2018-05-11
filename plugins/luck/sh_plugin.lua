PLUGIN.name = "Luck "
PLUGIN.author = "Zadkiel"
PLUGIN.desc = "Adds a luck attribute."

if (SERVER) then
	function PLUGIN:EntityTakeDamage(client, dmg)
		if (dmg:GetAttacker():IsPlayer()) then
			if weapons.IsBasedOn( dmg:GetAttacker():GetActiveWeapon():GetClass(), "tfa_melee_base" ) then
				if (dmg:IsDamageType(DMG_FALL)) then 
					return
				end

			local luck = dmg:GetAttacker():getChar():getAttrib("luck", 0) * 0.2
			local power = dmg:GetAttacker():getChar():getAttrib("str", 0) / 100
			local crit = math.random(0, 100)

			if crit <= luck then
				dmg:ScaleDamage( 2 + power)
				dmg:SetDamageType( DMG_DIRECT )
				dmg:GetAttacker():getChar():updateAttrib("luck", 0.1)
				dmg:GetAttacker():EmitSound("weapons/gauss/fire1.wav", 100)
			end

			end
		end		
	end

	function PLUGIN:PostPlayerLoadout(client)
		timer.Simple(1, function()
			client:SetMaxHealth(client:GetMaxHealth() + (client:getChar():getAttrib("con", 0) * 2.5) )
			client:SetHealth(client:Health() + (client:getChar():getAttrib("con", 0) * 2.5) )
		end)
	end
end
