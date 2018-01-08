----------------------------------------
---- Old Shit that i might not need ----
----------------------------------------

/*function SCHEMA:PostPlayerDeath(ply)
	
	for k, v in pairs(marines) do
	
	
	if ply:getChar():getFaction() == v then
	return end
	end
	
	if ply.KeepInjury == true then
	do return end
	else
	
	majorinjuries = {
	
	}
		majorinjuries[0] = {
			name = "Severe Concussion",
			desc = "AGH! MY HEAD, IT.. HURTS!",
			modifier = nil
			}
		majorinjuries[1] = {
			name = "Cracked Skull",
			desc = "*Groans extremely loud*",
			modifier = nil
			}
		majorinjuries[2] = {
			name = "Punctured Lung",
			desc = "*Sharp breaths*\n I.. Can't.. Breath!",
			modifier = nil
		}
		majorinjuries[3] = {
			name = "Pireced Liver",
			desc = "*Excrutiating pain in the upper abdomen*",
			modifier = nil
		}
		majorinjuries[4] = {
			name = "Punctured Stomach",
			desc = "*Excrutiating pain in the mid abdomen*",
			modifier = nil
		}
		majorinjuries[6] = {
			name = "Severed Limb",
			desc = "*Excrutiating pain*",
			modifier = nil
		}
		majorinjuries[7] = {
			name = "Third Degree Burn",
			desc = "*Excrutiating pain*",
			modifier = nil
		}
		majorinjuries[8] = {
			name = "Severe Infection",
			desc = "*groans loudly* \n Your wounds have a yellow-ish layer.",
			modifier = nil
		}
	
	MajorParts = {
		"Upper Abdomen",
		"Lower Abdomen",
		"Lattisimus Dorsi",
		"Erector Spinae",
		"Teres Major",
		"Pectoralis Major"
	}
	
	moderateinjuries = {
	
	}
		moderateinjuries[0] = {
			name = "Broken Arm",
			desc = "Ugh.. My arm is really hurting.",
			modifier = nil
		}
		moderateinjuries[1] = {
			name = "Moderate Concussion",
			desc = "*clenches eyes* \n *blinks rapidly* \n It's hard to see.",
			modifier = nil
			
		}
		moderateinjuries[2] = {
			name = math.random(4, 9).." Broken Ribs",
			desc = "*groans* \n There's something wrong with my chest.",
			modifier = nil
		}
		moderateinjuries[3] = {
			name = "Laceration",
			desc = "*groans loudly*",
			modifier = nil
		}
		moderateinjuries[4] = {
			name = "Shrapnel in" .. MajorParts[math.random(#MajorParts)],
			desc = "*groans loudly*",
			modifier = nil
		}
		moderateinjuries[4] = {
			name = "Second Degree Burns",
			desc = "*groans loudly* \n Blisters appear on the skin.",
			modifier = nil
		}
		moderateinjuries[5] = {
			name = "Infection",
			desc = "*groans* \n Your wounds have a yellow-ish layer.",
			modifier = nil
		}
	
	
	Parts = {
		"Shin",
		"Arm",
		"Knee",
		"Elbow"
	}
	
	minorinjuries = {
	
	}
		minorinjuries[0] = {
			name = "Bruise",
			desc = "I think i brusied my " .. Parts[math.random(#Parts)],
			modifier = nil
		}
		minorinjuries[1] = {
			name = "Scracth",
			desc = "I scratched my " ..  Parts[math.random(#Parts)],
			modifier = nil
		}
		minorinjuries[2] = {
			name = "Light Concussion",
			desc = "Ugh. Something doesn't feel right",
			modifier = nil
		}
		minorinjuries[3] = {
			name = math.random(1, 3).." Broken Ribs",
			desc = "My chest, it hurts.",
			modifier = nil
		}
	
	movementinjuries = {
		
	}
	
			movementinjuries[0] = {
				name = "Bruised Hip",
				walk = 100,
				run = 200
			}
	
			movementinjuries[1] = {
				name = "Fractured Foot Bone",
				walk = 90,
				run = 180
			}
	
			movementinjuries[2] = {
				name = "Sprained Ankle",
				walk = 80,
				run = 160
			}
	
			movementinjuries[3] = {
				name = "Broken Leg",
				walk = 60,
				run = 100
			}
			
			movementinjuries[4] = {
				name = "Bloodloss"
			}
	
	damageinjuries = {
	}
	
			damageinjuries[0] = {
				name = "Internal bleed",
				intBleed = -1
			}
	
			damageinjuries[1] = {
				name = "External bleed",
				bleed = 300
			}

	local char = ply:getChar()
	
	ply.deathroll = math.random(1, 5)
	
	ply.minorroll = minorinjuries[math.random(#minorinjuries)]
	
	ply.moderateroll = moderateinjuries[math.random(#moderateinjuries)]
	
	ply.majorroll = majorinjuries[math.random(#majorinjuries)]
	
	ply.bleedroll = math.random(0, 10)
	
	ply.moveroll = math.random( 0, 10)
	
	ply.movemsg = ""
	
	if ply.deathroll <= 10 then
		if ply.moveroll >= 0 and ply.moveroll <= 4 then
				ply.movemsg = movementinjuries[ply.moveroll].name
			else
				ply.movemsg = ""
			end
		end
	

	if ply.deathroll == 1 then 
		result = "AAAAAAGHHH!!!"
	elseif ply.deathroll >= 8 and ply.deathroll <= 10 then
		medresult = "Minor Injury, " .. ply.minorroll.name
		result = ply.minorroll.desc
	elseif ply.deathroll > 1 and ply.deathroll <= 5 then
		medresult = "Severe Injury, " .. ply.majorroll.name
		result = ply.majorroll.desc
	elseif ply.deathroll > 5 and ply.deathroll < 8 then
		medresult = "Moderate Injury, " .. ply.moderateroll.name
		result = ply.moderateroll.desc
		
	elseif ply.deathroll > 10 then
		result = "No Injuries."
	--if char:getFaction() == FACTION_TACMARINE then
	end
	

		rollmessage = result

	
	if timer.Exists( "IntBleed" ) then
	
		timer.Remove( "IntBleed" )
	
	end
	
	if timer.Exists( "bleed" ) then
	
		timer.Remove( "bleed" )
	
	end
	
	if timer.Exists( "HipReminder" ) then
	
		timer.Remove( "HipReminder" )
	
	end
	
	if timer.Exists( "FootReminder" ) then
	
		timer.Remove( "FootReminder" )
	
	end
	
	if timer.Exists( "AncleReminder" ) then
	
		timer.Remove( "AncleReminder" )
	
	end
	
	if timer.Exists( "FaintReminder" ) then
	
		timer.Remove( "FaintReminder" )
	
	end
	
	if timer.Exists( "LegReminder" ) then
	
		timer.Remove( "LegReminder" )
	
	end
	
	if timer.Exists( "brokenarm" ) then
	
		timer.Remove( "brokenarm" )
	
		end
	end
end
*/

/*function KeepInjury( ply, attacker, dmg )
	local char = ply:getChar()
	if (ply == attacker or dmg:GetDamageType() == DMG_FALL) then
		ply.KeepInjury = true
	else
		ply.KeepInjury = false
	end
end
hook.Add( "DoPlayerDeath", "KeepInjuryOnSuicide", KeepInjury	)*/

/*function PlayerSpawnDeathroll(id)
	local character = nut.char.loaded[id]
	local client = character:getPlayer()
	client.deathroll = 20
	rollmessage = nil
end
hook.Add( "CharacterLoaded", "deathrollprevent", PlayerSpawnDeathroll )*/

/*hook.Add("RenderScreenspaceEffects", "Concussion", function()
            DrawMotionBlur(0.1,1,0)
			DrawSobel( 0.9 ) --Draws Sobel effect
			--DrawMaterialOverlay( "effects/sw_laser_blue_front", -0.5 ) -- Draw VMT
            local modify = {}
            modify["$pp_colour_addr"] = 0
            modify["$pp_colour_addg"] = 0
            modify["$pp_colour_addb"] = 0
            modify["$pp_colour_brightness"] = -0.1
            modify["$pp_colour_contrast"] = 1
            modify["$pp_colour_colour"] = 0.1
            modify["$pp_colour_mulr"] = 0
            modify["$pp_colour_mulg"] = 0
            modify["$pp_colour_mulb"] = 0
            DrawColorModify(modify)
			end)*/

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
