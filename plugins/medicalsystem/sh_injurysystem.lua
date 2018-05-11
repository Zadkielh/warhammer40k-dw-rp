nut.util.include("sh_injuries.lua")

nut.command.add("applyinjury", {
    adminOnly = true,
    syntax = "<name>",
    onRun = function(client, args)


        local Target = nut.command.findPlayer(client, args[1])
        if not IsValid(Target) then return end

		local char = client:getChar()
		local ply = char:getPlayer()

			ApplyInjury(Target)
			
			client:ChatPrint(Target.MedicResult)

    end
})

function KeepInjury( client, attacker, dmg )
	local char = client:getChar()
	if (client == attacker or dmg:GetDamageType() == DMG_FALL) then
		client.KeepInjury = true
	else
		client.KeepInjury = false
	end
end
hook.Add( "DoPlayerDeath", "KeepInjuryOnSuicide", KeepInjury	)

function PreventInjury(id)
	
	local character = nut.char.loaded[id]
	if IsValid(character) then
		local client = character:getPlayer()
		client.InjuryRoll = 20
		Result = nil
	end
end
hook.Add( "CharacterLoaded", "InjuryRollprevent", PreventInjury )

function ApplyInjury(client)

	/*for k, v in pairs(Insert Table of Factions to exclude) do
		if client:getChar():getFaction() == v then return end
	end*/
	
	if client.KeepInjury == true then return end
	
	
		local char = client:getChar()
		
			client.InjuryRoll = math.random(1, 15)
			print(client.InjuryRoll .. " InjuryRoll")

			client.MinorRoll = MinorInjuries[math.random(#MinorInjuries)]
			client.ModerateRoll = ModerateInjuries[math.random(#ModerateInjuries)]
			client.MajorRoll = MajorInjuries[math.random(#MajorInjuries)]
			client.MoveRoll = math.random( 0, 8)
			client.MoveMsg = ""

			print(client.MoveRoll .. " MoveRoll")
			print(client.MinorRoll.name)
			print(client.ModerateRoll.name)
			print(client.MajorRoll.name)

			if client.InjuryRoll <= 10 then 
			
				
		
					
			
				if client.InjuryRoll <= 5 then 
				
					client.MedicResult = ("Severe Injury: " .. client.MajorRoll.name) 
					Result = client.MajorRoll.desc
					client:SetHealth(client:Health() * 0.5)
					client:getChar():updateAttrib(client.MajorRoll.attribute, client.MajorRoll.modifier)
					client:ChatPrint(Result)
				
				elseif ((client.InjuryRoll > 5) and (client.InjuryRoll <= 10)) then
					
					client.MedicResult = ("Moderate Injury: " .. client.ModerateRoll.name)
					Result = client.ModerateRoll.desc
					client:SetHealth(client:Health() * 0.7)
					client:getChar():updateAttrib(client.ModerateRoll.attribute, client.ModerateRoll.modifier)
					client:ChatPrint(Result)
				
				end
			
			elseif ((client.InjuryRoll <= 15) and (client.InjuryRoll > 10)) then
			
				client.MedicResult = ("Minor Injury: " .. client.MinorRoll.name  )
				Result = client.MinorRoll.desc
				client:ChatPrint(Result)
		
			end

			if client.MoveRoll <= 4 then 
				client.MoveMsg  = MovementInjuries[client.MoveRoll].desc
				client.MoveName = MovementInjuries[client.MoveRoll].name
				print(client.MoveName)
				client:SetRunSpeed(MovementInjuries[client.MoveRoll].run)
				client:SetWalkSpeed(MovementInjuries[client.MoveRoll].walk)
				client.MedicResult = client.MedicResult .. "\n" .. "Movement Injury: " .. client.MoveName
				Result = Result .."\n".. client.MoveMsg
			end
		client.KeepInjury = true
		
end

function PLUGIN:EntityTakeDamage( target, info )
	if(target:IsNPC()) then return end
	if( IsValid(target) and (target:IsPlayer() or target:IsBot())) then
		local uniqueID = "Bleedout"..target:SteamID()
		if (target:GetNWBool( "IsRagdolled" ) == false ) then
			if( (target:Health() <= info:GetDamage()) and (info:GetDamageType() != (DMG_FALL or DMG_DISSOLVE or DMG_BURN))) then
				local time = 20 + (target:getChar():getAttrib("con", 0) / 0.4)

					info:ScaleDamage( 0 )
					target:setRagdolled(true, time, time)
					target:GodEnable()
					target:SetNWBool( "IsRagdolled", true )
					target:SetHealth(10)
					target:SetNoTarget( true )
					target:SetNWInt( "BleedTimer", time )
					net.Start( "openRespawnMenu" )
					net.Send( target )
					
					
					timer.Create( uniqueID, time, 1, function()
						if !IsValid(target) then return end
							target:Kill()
							target:SetNoTarget( false )
					end)
			end
		end
	end
end

function PLUGIN:PlayerDeath(client)
	if (client:GetNWBool( "IsRagdolled" ) == true ) then
		client:SetNWBool( "IsRagdolled", false)
	end
	local uniqueID = "Bleedout"..client:SteamID()
	if timer.Exists( uniqueID ) then
		timer.Remove( uniqueID )
	end

	client:SetNoTarget( false )
end

net.Receive( "RespawnActivate", function( len, ply)
	print("Message Received")
	ply:SetNoTarget( true )
	ply:Kill()
end)