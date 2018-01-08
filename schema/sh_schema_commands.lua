
--[[nut.command.add("request", {
	syntax = "<string text>",
	onRun = function(client, arguments)
		if ((client.nutNextReq or 0) < CurTime()) then
			local text = table.concat(arguments, " ")
			local item = client:getChar():getInv():hasItem("request")

			if (item) then
				if (text:find("%S")) then
					client.nutNextReq = CurTime() + 5
					nut.chat.send(client, "request", "["..item:getData("name", client:Name())..", "..item:getData("id", "ERROR").."] "..text)

					return client:EmitSound("buttons/combine_button5.wav", 50, 40)
				end
			else
				return "@noReqDev"
			end

			client.nutNextReq = CurTime() + 1
			client:EmitSound("buttons/combine_button3.wav", 75, 150)
		end
	end
})
]]
nut.command.add("charsetclass", {
    adminOnly = true,
    syntax = "<string name> <string class>",
    onRun = function(client, args)
        local Target = nut.command.findPlayer(client, args[1])
        if not IsValid(Target) then return end

        local TargetClass = table.concat(args," ", 2)

        for ClassID,Class in ipairs(nut.class.list) do
            if Class.uniqueID == TargetClass then

                local Char = Target:getChar()
                local OldClass = Char:getClass()
                Char:setClass(ClassID)

                hook.Run("OnPlayerJoinClass", client, ClassID, OldClass)
                client:notify("Class changed", L(Class.name, Target))
                return true
            end
        end

        client:notify("Non existant class")

    end
})

nut.command.add("charkickclass", {
    adminOnly = true,
    syntax = "<string name>",
    onRun = function(client, args)
        local Target = nut.command.findPlayer(client, args[1])
        if not IsValid(Target) then return end

		local char = Target:getChar()
        	char:setClass()
					client:notify("You kicked", L(Target))

			local client = char:getPlayer()
			hook.Run("OnPlayerJoinClass", client, class)



    end
})
--[[
nut.command.add("examine", {
    adminOnly = false,
    syntax = "",
    onRun = function(client, args)


        local Target = client:GetEyeTraceNoCursor().Entity
        if not IsValid(Target) then client:notify("error") return end

		local char = client:getChar()
		local ply = char:getPlayer()

			if char:hasFlags("M") then
			timer.Simple(0.1, function() client:ChatPrint("You start examining the patient") end )
        	timer.Simple(5, function()
			if Target.deathroll > 10 then
			client:ChatPrint("Patient has no injuries")
			elseif Target.deathroll <= 10 and Target.deathroll >= 8 then
			client:ChatPrint(Target.minorroll.name .. " \n" .. Target.movemsg )
			elseif Target.deathroll <= 7 and Target.deathroll >=5 then
			client:ChatPrint(Target.moderateroll.name .. " \n" .. Target.movemsg)
			elseif Target.deathroll <= 4 and Target.deathroll >=1 then
			client:ChatPrint(Target.majorroll.name .. " \n" .. Target.movemsg)
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
    syntax = "<string bodypart>",
    onRun = function(client, args)


        local Target = client:GetEyeTraceNoCursor().Entity
        if not IsValid(Target) then return end

		local char = client:getChar()
		local ply = char:getPlayer()
		local items = char:getInv():getItems()
		local inv = client:getChar():getInv()


		if IsValid(client) and IsValid(Target) then
			if char:hasFlags("M") then

				if args[1] == "legs" or args[1] == "Legs" then
					for k, v in pairs(items) do
						print(v.name)
						if v != nil then

							if (v.name == "Splint" and (Target.movemsg == "Broken Leg" or Target.movemsg == "Fractured Foot Bone" or Target.movemsg == "Sprained Ankle")) then


								client:notify("You have begun treating the patient.")

									Target:SetWalkSpeed(10)
									Target:SetRunSpeed(10)
									client:SetWalkSpeed(10)
									client:SetRunSpeed(10)

								timer.Simple(20, function()
									Target:SetWalkSpeed(nut.config.get("walkSpeed") - 20)
									Target:SetRunSpeed(nut.config.get("runSpeed") - 20)
									client:SetWalkSpeed(nut.config.get("walkSpeed"))
									client:SetRunSpeed(nut.config.get("runSpeed"))
									Target.movemsg = ""
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
						print(v.name)
						if v != nil then

							if (v.name == "Large Kit of Advanced Surgical Tools" and (Target.deathroll > 1 and Target.deathroll <= 5)) then

								client:notify("You have begun treating the patient.")

									Target:SetWalkSpeed(10)
									Target:SetRunSpeed(10)
									client:SetWalkSpeed(10)
									client:SetRunSpeed(10)

								timer.Create("MajorRegen", 1, 100, function()
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

									Target.deathroll = 20
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
						print(v.name)
						if v != nil then

							if (v.name == "Large Kit of Medical Tools" and Target.deathroll > 5 and Target.deathroll < 8) then

								client:notify("You have begun treating the patient.")

									Target:SetWalkSpeed(10)
									Target:SetRunSpeed(10)
									client:SetWalkSpeed(10)
									client:SetRunSpeed(10)

								timer.Create("ModerateRegen", 1, 30, function()
									while client:Health() < client:GetMaxHealth() do
										client:SetHealth(client:Health() + 2)
									end
								end
								)

								timer.Simple(40, function()
									Target:SetWalkSpeed(nut.config.get("walkSpeed") )
									Target:SetRunSpeed(nut.config.get("runSpeed") )

									client:SetWalkSpeed(nut.config.get("walkSpeed") )
									client:SetRunSpeed(nut.config.get("runSpeed") )

									Target.deathroll = 20
									client:notify("You are done treating the patient")


								end
								)
								break
							else

							end
						end
					end
				elseif args[1] == "burns" or args[1] == "Burns" or args[1] == "Burn" or args[1] == "burn"then
					for k, v in pairs(items) do
						print(v.name)
						if v != nil then

							if ((v.name == "Acetaminophen" and v.name == "Antibiotics") and (Target.moderateroll.name == "Second Degree Burns")) then

								client:notify("You have begun treating the patient.")

									Target:SetWalkSpeed(10)
									Target:SetRunSpeed(10)
									client:SetWalkSpeed(10)
									client:SetRunSpeed(10)

								timer.Create("BurnRegen", 1, 20, function()
									while client:Health() < client:GetMaxHealth() do
										client:SetHealth(client:Health() + 1)
									end
								end
								)

								timer.Simple(30, function()
									Target:SetWalkSpeed(nut.config.get("walkSpeed") )
									Target:SetRunSpeed(nut.config.get("runSpeed") )

									client:SetWalkSpeed(nut.config.get("walkSpeed") )
									client:SetRunSpeed(nut.config.get("runSpeed") )

									Target.deathroll = 20
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
						print(v.name)
						if v != nil then

							if ((v.name == "Bandage" and "Alcohol" and "Pliers") and (Target.moderateroll.name == moderateinjuries[4].name)) then

								client:notify("You have begun treating the patient.")

									Target:SetWalkSpeed(10)
									Target:SetRunSpeed(10)
									client:SetWalkSpeed(10)
									client:SetRunSpeed(10)

								timer.Create("ShrapnelRegen", 1, 20, function()
									while client:Health() < client:GetMaxHealth() do
										client:SetHealth(client:Health() + 1)
									end
								end
								)

								timer.Simple(30, function()
									Target:SetWalkSpeed(nut.config.get("walkSpeed") )
									Target:SetRunSpeed(nut.config.get("runSpeed") )

									client:SetWalkSpeed(nut.config.get("walkSpeed") )
									client:SetRunSpeed(nut.config.get("runSpeed") )



									Target.deathroll = 20
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
						print(v.name)
						if v != nil then

							if ((v.name == "Bandage" and "Alcohol" and "Scalpel") and (Target.moderateroll.name == "Infection" or Target.minorroll.name == "Severe Infection")) then

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
								timer.Simple(30, function()
									Target:SetWalkSpeed(nut.config.get("walkSpeed") )
									Target:SetRunSpeed(nut.config.get("runSpeed") )

									client:SetWalkSpeed(nut.config.get("walkSpeed") )
									client:SetRunSpeed(nut.config.get("runSpeed") )



									Target.deathroll = 20
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
]]
nut.command.add("promote", {
    adminOnly = false,
    syntax = "< Look at target player >",
    onRun = function(client, args)


        local Target = client:GetEyeTraceNoCursor().Entity
        if not IsValid(Target) then client:notify("Not a valid target") return end

		local char = client:getChar()
		local ply = char:getPlayer()

			if char:hasFlags("T") then
				if Target:getChar():getFaction() == FACTION_RECRUIT then
					Target:setFaction(FACTION_TEST)
				else
					client:notify("Character is not a recruit")
				end
			else
				client:notify("You are not a qualified trainer")
			end
		end
})



