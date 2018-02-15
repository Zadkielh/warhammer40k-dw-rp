
local SCHEMA = SCHEMA


-- Injury Tables

MajorParts = {
	"Upper Abdomen",
	"Lower Abdomen",
	"Lattisimus Dorsi",
	"Erector Spinae",
	"Teres Major",
	"Pectoralis Major"
}

Parts = {
	"Shin",
	"Arm",
	"Knee",
	"Elbow"
}

MajorInjuries = {}
ModerateInjuries = {}
MinorInjuries = {}
MovementInjuries = {}

------------------------------------------------------------ MajorInjuries ------------------------------------------------------------

	MajorInjuries[0] = {
		name = "Severe Concussion",
		desc = "AGH! MY HEAD, IT.. HURTS!",
		}
	MajorInjuries[1] = {
		name = "Cracked Skull",
		desc = "*Groans extremely loud*",
		}
	MajorInjuries[2] = {
		name = "Punctured Lung",
		desc = "*Sharp breaths*\n I.. Can't.. Breath!",
		}
	MajorInjuries[3] = {
		name = "Pireced Liver",
		desc = "*Excrutiating pain in the upper abdomen*",
		}
	MajorInjuries[4] = {
		name = "Punctured Stomach",
		desc = "*Excrutiating pain in the mid abdomen*",
		}
	MajorInjuries[6] = {
		name = "Severed Limb",
		desc = "*Excrutiating pain*",
		}
	MajorInjuries[7] = {
		name = "Third Degree Burn",
		desc = "*Excrutiating pain*",
		}
	MajorInjuries[8] = {
		name = "Severe Infection",
		desc = "*groans loudly* \n Your wounds have a yellow-ish layer.",
		}
		
------------------------------------------------------------ ModerateInjuries ------------------------------------------------------------

	ModerateInjuries[0] = {
		name = "Broken Arm",
		desc = "Ugh.. My arm is really hurting.",
		}
	ModerateInjuries[1] = {
		name = "Light Concussion",
		desc = "*clenches eyes* \n *blinks rapidly* \n It's hard to see.",
		}
	ModerateInjuries[2] = {
		name = math.random(4, 9).." Broken Ribs",
		desc = "*groans* \n There's something wrong with my chest.",
		}
	ModerateInjuries[3] = {
		name = "Laceration",
		desc = "*groans loudly*",
		}
	ModerateInjuries[4] = {
		name = "Shrapnel in" .. MajorParts[math.random(#MajorParts)],
		desc = "*groans loudly*",
		}
	ModerateInjuries[4] = {
		name = "Second Degree Burns",
		desc = "*groans loudly* \n Blisters appear on the skin.",
		}
	ModerateInjuries[5] = {
		name = "Infection",
		desc = "*groans* \n Your wounds have a yellow-ish layer.",
		}

------------------------------------------------------------ MinorInjuries ------------------------------------------------------------

	MinorInjuries[0] = {
		name = "Bruise",
		desc = "I think i brusied my " .. Parts[math.random(#Parts)],
		}
	MinorInjuries[1] = {
		name = "Scracth",
		desc = "I scratched my " ..  Parts[math.random(#Parts)],
		}
	MinorInjuries[2] = {
		name = math.random(1, 3).." Broken Ribs",
		desc = "My chest, it hurts.",
		}

------------------------------------------------------------ MovementInjuries ------------------------------------------------------------
	
	MovementInjuries[0] = {
		name = "Bruised Hip",
		walk = 100,
		run = 200
		}
	
	MovementInjuries[1] = {
		name = "Fractured Foot Bone",
		walk = 90,
		run = 180
		}
	
	MovementInjuries[2] = {
		name = "Sprained Ankle",
		walk = 80,
		run = 160
		}

	MovementInjuries[3] = {
		name = "Broken Leg",
		walk = 60,
		run = 100
		}
			
	MovementInjuries[4] = {
		name = "Bloodloss"
		}
		

function KeepInjury( client, attacker, dmg )
	local char = client:getChar()
	if (client == attacker or dmg:GetDamageType() == DMG_FALL) then
		client.KeepInjury = true
	else
		client.KeepInjury = false
	end
end
hook.Add( "DoPlayerDeath", "KeepInjuryOnSuicide", KeepInjury	)

--[[function PreventInjury(id)
	local character = nut.char.loaded[id]
	local client = character:getPlayer()
	client.InjuryRoll = 20
	Result = nil
end
hook.Add( "CharacterLoaded", "InjuryRollprevent", PreventInjury )--]]

function ApplyInjury(client)

	/*for k, v in pairs(Insert Table of Factions to exclude) do
		if client:getChar():getFaction() == v then return end
	end*/
	
	if client.KeepInjury == true then return end
	
	
		local char = client:getChar()
		
			client.InjuryRoll = math.random(1, 20)
			print(client.InjuryRoll .. " InjuryRoll")
			if client.InjuryRoll <= 10 then 
			
				client.MinorRoll = MinorInjuries[math.random(#MinorInjuries)]
				client.ModerateRoll = ModerateInjuries[math.random(#ModerateInjuries)]
				client.MajorRoll = MajorInjuries[math.random(#MajorInjuries)]
				client.MoveRoll = math.random( 1, 10)
				client.MoveMsg = ""
		
					if client.MoveRoll <= 4 then 
						client.MoveMsg  = MovementInjuries[client.MoveRoll].name
					end
			
				if client.InjuryRoll <= 5 then 
				
					MedicResult = ("Severe Injury: " .. client.MajorRoll.name ) 
					Result = client.MajorRoll.desc
					client:SetHealth(client:Health() * 0.4)
					client:ChatPrint(Result)
				
				elseif ((client.InjuryRoll > 5) and (client.InjuryRoll <= 10)) then
					
					MedicResult = ("Moderate Injury: " .. client.ModerateRoll.name )
					Result = client.ModerateRoll.desc
					client:SetHealth(client:Health() * 0.7)
					client:ChatPrint(Result)
				
				end
			
			elseif ((client.InjuryRoll <= 15) and (client.InjuryRoll > 10)) then
			
				MedicResult = ("Minor Injury: " .. client.MinorRoll.name )
				Result = client.MinorRoll.desc
				client:ChatPrint(Result)
		
			end
		
		
end

function SCHEMA:EntityTakeDamage( target, info )

	/*for k, v in pairs(Insert Table of Factions to exclude) do
		if client:getChar():getFaction() == v then return end
	end*/
	
	if( IsValid(target) and target:IsPlayer()) then
		if (target:GetNWBool( "IsRagdolled" ) == false ) then
			if( (target:Health() <= info:GetDamage()) and (info:GetDamageType() != (DMG_FALL or DMG_DISSOLVE or DMG_BURN))) then
				local time = (info:GetDamage() * 1.5)
					if info:GetDamage() >= 200 then
						time = 10
					end
					info:ScaleDamage( 0 )
					target:setRagdolled(true, time, time)
					target:SetNWBool( "IsRagdolled", true )
					target:SetHealth(10)
					
					net.Start( "openRespawnMenu" )
					net.Send( target )
					
					timer.Create( "bleedOut", time, 1, function()
					local BleedOut = math.random(0, 10)
						if BleedOut < 5 then
							target:Kill()
						elseif BleedOut >= 5 then
							ApplyInjury(target)
						end
					end)
			end
		end
	end
end

function SCHEMA:PlayerDeath(client)
	if (client:GetNWBool( "IsRagdolled" ) == true ) then
		client:SetNWBool( "IsRagdolled", false)
	end
	
	if timer.Exists( "bleedOut" ) then
		timer.Remove( "bleedOut" )
	end
end

net.Receive( "RespawnActivate", function( len, ply)
	print("Message Received")
	ply:Kill()
end)