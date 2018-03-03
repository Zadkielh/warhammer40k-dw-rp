
nut.command.add("request", {
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

nut.command.add("data", {
	syntax = "<string name>",
	onRun = function(client, arguments)
		local target = nut.command.findPlayer(client, table.concat(arguments, " "))

		if (IsValid(target) and target:getChar()) then
			if (!hook.Run("CanPlayerViewData", client, target)) then
				return "@noViewData"
			end

			client.nutDataTarget = target
			netstream.Start(client, "plyData", target:getChar():getData("txt"), target:Name().." ["..target:getDigits().."]", hook.Run("CanPlayerEditData", client, target))
		end
	end
})

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



