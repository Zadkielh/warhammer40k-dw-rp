nut.command.add("revive", {
    adminOnly = true,
    syntax = "<string name>",
    onRun = function(client, args)
        local Target = nut.command.findPlayer(client, args[1])
        if not IsValid(Target) then return end
		
		

        local TargetClass = table.concat(args," ", 2)

		Target:setRagdolled(false)

        client:notify("Revived")

    end
})

nut.command.add("resuscitate", {
    adminOnly = false,
    syntax = "",
    onRun = function(client, args)


        local Target = client:GetEyeTraceNoCursor().Entity
        if not IsValid(Target) then client:notify("error") return end

		local char = client:getChar()
		local ply = char:getPlayer()

			if char:hasFlags("M") then
				for k, v in pairs(items) do
					if v != nil then

						if (v.name == "Epinephrine" ) then
							timer.Simple(0.1, function() client:ChatPrint("You insert the Epinephrine") end )
							timer.Simple(2, function()
								Target:setRagdolled(false)
								timer.Simple(3, function()
									target:GodDisable()
									target:SetNoTarget( false )
								end)
								timer.Create("MarineRegen", 0.25, 0, function()
								if target:Health() < (target:GetMaxHealth() / 4) then
									target:SetHealth(math.Approach(target:Health(), target:GetMaxHealth(), 5))
								end
								if target:Health() >= (target:GetMaxHealth() / 4) then
									timer.Remove( "MarineRegen" )
								end
							end)
							end
							)
							break
						else	
							client:notify("Sorry, you do not have the required tools")
							

						end
					end
				
				end
				
				else
					client:notify("Sorry, you are not qualified to do such an action")
			end
	end
})

nut.command.add("examine", {
    adminOnly = false,
    syntax = "Either look at a player or type their name",
    onRun = function(client, args)


        local Target = nut.command.findPlayer(client, args[1]) or client:GetEyeTraceNoCursor().Entity
        if not IsValid(Target) then client:notify("error") return end

		local char = client:getChar()
		local ply = char:getPlayer()

			if char:hasFlags("M") then
			timer.Simple(0.1, function() client:ChatPrint("You start examining the patient") end )
        	timer.Simple(5, function()
					if Target.MedicResult == "" then
						client:ChatPrint("Patient has no injuries.")
					else
						client:ChatPrint(Target.MedicResult)
					end
			end
			)
			else
			client:notify("Sorry, you are not qualified to do such an action")

		end
    end
})



nut.command.add("treat", {
    adminOnly = false,
    syntax = "<string bodypart> <look at target>",
    onRun = function(client, args)


        local Target = client or client:GetEyeTraceNoCursor().Entity
        if not IsValid(Target) then return end

		local char = client:getChar()
		local ply = char:getPlayer()
		local items = char:getInv():getItems()
		local inv = client:getChar():getInv()


		if IsValid(client) and IsValid(Target) then
			if char:hasFlags("M") then

				if args[1] == "legs" or args[1] == "Legs" then
					for k, v in pairs(items) do
						if v != nil then

							if (v.name == "Splint" and (Target.MoveMsg == "Broken Leg" or Target.MoveMsg == "Fractured Foot Bone" or Target.MoveMsg == "Sprained Ankle")) then


								client:notify("You have begun treating the patient.")

									Target:SetWalkSpeed(10)
									Target:SetRunSpeed(10)
									client:SetWalkSpeed(10)
									client:SetRunSpeed(10)

								timer.Simple(10, function()
									Target:SetWalkSpeed(nut.config.get("walkSpeed"))
									Target:SetRunSpeed(nut.config.get("runSpeed"))
									client:SetWalkSpeed(nut.config.get("walkSpeed"))
									client:SetRunSpeed(nut.config.get("runSpeed"))
									Target.MoveMsg = ""
									Target.KeepInjury = false
									client:notify("You are done treating the patient")
									inv:remove(k)
								end
								)
								break
							else

							end
						end
					end
				elseif args[1] == "major" or args[1] == "Major" then
					for k, v in pairs(items) do
						if v != nil then

							if (v.name == "Large Kit of Advanced Surgical Tools" and Target.InjuryRoll <= 5) then

								client:notify("You have begun treating the patient.")

									Target:SetWalkSpeed(10)
									Target:SetRunSpeed(10)
									client:SetWalkSpeed(10)
									client:SetRunSpeed(10)

								timer.Create("MajorRegen", 0.25, 0, function()
									while Target:Health() < Target:GetMaxHealth() do
										Target:SetHealth(Target:Health() + 5)
									end
									if target:Health() >= (target:GetMaxHealth()) then
										timer.Remove( "MajorRegen" )
									end
								end
								)

								timer.Simple(10, function()
									Target:SetWalkSpeed(nut.config.get("walkSpeed") )
									Target:SetRunSpeed(nut.config.get("runSpeed") )
									client:SetWalkSpeed(nut.config.get("walkSpeed") )
									client:SetRunSpeed(nut.config.get("runSpeed") )
									Target:getChar():updateAttrib(Target.MajorRoll.attribute, 5)

									Target.InjuryRoll = 20
									Result = ""
									Target.MedicResult = ""
									Target.KeepInjury = false
									client:notify("You are done treating the patient")
									-- Regen Timer
								end
								)
								break
							else

							end
						end
					end
				elseif args[1] == "moderate" or args[1] == "Moderate" then
					for k, v in pairs(items) do
						if v != nil then

							if (v.name == "Large Kit of Medical Tools" and (Target.InjuryRoll > 5) and (Target.InjuryRoll <= 10)) then
								
								client:notify("You have begun treating the patient.")

									Target:SetWalkSpeed(10)
									Target:SetRunSpeed(10)
									client:SetWalkSpeed(10)
									client:SetRunSpeed(10)

								timer.Create("ModerateRegen", 0.25, 0, function()
									while Target:Health() < Target:GetMaxHealth() do
										Target:SetHealth(Target:Health() + 2.5)
									end
									if target:Health() >= (target:GetMaxHealth()) then
										timer.Remove( "ModerateRegen" )
									end
								end
								)

								timer.Simple(10, function()
									Target:SetWalkSpeed(nut.config.get("walkSpeed") )
									Target:SetRunSpeed(nut.config.get("runSpeed") )
									client:SetWalkSpeed(nut.config.get("walkSpeed") )
									client:SetRunSpeed(nut.config.get("runSpeed") )
									Target:getChar():updateAttrib(Target.ModerateRoll.attribute, 5)

									Target.InjuryRoll = 20
									Result = ""
									Target.MedicResult = ""
									Target.KeepInjury = false
									client:notify("You are done treating the patient")
									-- Regen Timer
								end
								)
								break
							else

							end
						end
					end
				elseif args[1] == "burns" or args[1] == "Burns" or args[1] == "Burn" or args[1] == "burn"then
					for k, v in pairs(items) do
						if v != nil then

							if ((v.name == "Acetaminophen" and v.name == "Antibiotics") and (Target.ModerateRoll.name == "Second Degree Burns")) then

								client:notify("You have begun treating the patient.")

									Target:SetWalkSpeed(10)
									Target:SetRunSpeed(10)
									client:SetWalkSpeed(10)
									client:SetRunSpeed(10)

								timer.Create("BurnRegen", 0.25, 200, function()
									while Target:Health() < Target:GetMaxHealth() do
										Target:SetHealth(Target:Health() + 1)
									end
								end
								)

								timer.Simple(10, function()
									Target:SetWalkSpeed(nut.config.get("walkSpeed") )
									Target:SetRunSpeed(nut.config.get("runSpeed") )

									client:SetWalkSpeed(nut.config.get("walkSpeed") )
									client:SetRunSpeed(nut.config.get("runSpeed") )

									Target:getChar():updateAttrib(Target.ModerateRoll.attribute, 5)

									Target.InjuryRoll = 20
									Result = ""
									Target.MedicResult = ""
									Target.KeepInjury = false
									client:notify("You are done treating the patient")


								end
								)
								break

							else

							end
						end
					end
				elseif args[1] == "Shrapnel" or args[1] == "shrapnel" then
					for k, v in pairs(items) do
						if v != nil then

							if ((v.name == "Bandage" and "Alcohol" and "Pliers") and (Target.ModerateRoll.name == moderateinjuries[4].name)) then

								client:notify("You have begun treating the patient.")

									Target:SetWalkSpeed(10)
									Target:SetRunSpeed(10)
									client:SetWalkSpeed(10)
									client:SetRunSpeed(10)

								timer.Create("ShrapnelRegen", 0.25, 100, function()
									while Target:Health() < Target:GetMaxHealth() do
										Target:SetHealth(Target:Health() + 2.5)
									end
								end
								)

								timer.Simple(10, function()
									Target:SetWalkSpeed(nut.config.get("walkSpeed") )
									Target:SetRunSpeed(nut.config.get("runSpeed") )

									client:SetWalkSpeed(nut.config.get("walkSpeed") )
									client:SetRunSpeed(nut.config.get("runSpeed") )



									Target:getChar():updateAttrib(Target.ModerateRoll.attribute, 5)

									Target.InjuryRoll = 20
									Result = ""
									Target.KeepInjury = false
									Target.MedicResult = ""
									client:notify("You are done treating the patient")


								end
								)
								break

							else

							end
						end
					end
				elseif args[1] == "Infection" or args[1] == "infection" then
					for k, v in pairs(items) do
						if v != nil then

							if ((v.name == "Bandage" and "Alcohol" and "Scalpel") and (Target.ModerateRoll.name == "Infection" or Target.MajorRoll.name == "Severe Infection")) then

								client:notify("You have begun treating the patient.")

									Target:SetWalkSpeed(10)
									Target:SetRunSpeed(10)
									client:SetWalkSpeed(10)
									client:SetRunSpeed(10)

								timer.Create("InfectionRegen", 1, 100, function()
									while client:Health() < client:GetMaxHealth() do
										client:SetHealth(client:Health() + 3)
									end
								end
								)
								timer.Simple(10, function()
									Target:SetWalkSpeed(nut.config.get("walkSpeed") )
									Target:SetRunSpeed(nut.config.get("runSpeed") )

									client:SetWalkSpeed(nut.config.get("walkSpeed") )
									client:SetRunSpeed(nut.config.get("runSpeed") )



									Target:getChar():updateAttrib(Target.ModerateRoll.attribute, 5)

									Target.InjuryRoll = 20
									Result = ""
									Target.MedicResult = ""
									Target.KeepInjury = false
									client:notify("You are done treating the patient")

								end
								)
								break

							else

							end
						end
					end
				end

			else
			client:notify("Sorry, you are not qualified to perform such an action")
		end
	end
	end
})