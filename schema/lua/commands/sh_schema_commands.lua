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
				if Target:getChar():getFaction() == FACTION_REC then
					Target:setFaction(FACTION_DW_TAC)
				else
					client:notify("Character is not a recruit")
				end
			else
				client:notify("You are not a qualified trainer")
			end
		end
})


nut.command.add("playintro", {
    adminOnly = true,
    syntax = "<string name>",
    onRun = function(client, args)
        local Target = nut.command.findPlayer(client, args[1])
        if not IsValid(Target) then return end
		local char = Target:getChar()
			local client = char:getPlayer()
		
		net.Start( "playIntro" )
		net.Send( target )


    end
})

nut.command.add("traitgive", {
	adminOnly = true,
	syntax = "<string name> [string traits]",
	onRun = function(client, arguments)
		local target = nut.command.findPlayer(client, arguments[1])

		if (IsValid(target) and target:getChar()) then
			local traits = arguments[2]

			if (!traits) then
				local available = ""

				-- Aesthetics~~
				for k, v in SortedPairs(nut.trait.list) do
					if (!target:getChar():hasTraits(k)) then
						available = available..k
					end
				end

				return client:requestString("@traitGiveTitle", "@traitGiveDesc", function(text)
					nut.command.run(client, "traitgive", {target:Name(), text})
				end, available)
			end

			target:getChar():giveTraits(traits)

			nut.util.notifyLocalized("Gave Traits", nil, client:Name(), target:Name(), traits)
		end
	end
})

nut.command.add("traittake", {
	adminOnly = true,
	syntax = "<string name> [string traits]",
	onRun = function(client, arguments)
		local target = nut.command.findPlayer(client, arguments[1])

		if (IsValid(target) and target:getChar()) then
			local traits = arguments[2]

			if (!traits) then
				return client:requestString("@traitTakeTitle", "@traitTakeDesc", function(text)
					nut.command.run(client, "traittake", {target:Name(), text})
				end, target:getChar():getTraits())
			end

			target:getChar():takeTraits(traits)

			nut.util.notifyLocalized("Removed Traits", nil, client:Name(), traits, target:Name())
		end
	end
})


nut.command.add("checkattrib", {
	adminOnly = true,
	syntax = "<string name> [string attribute]",
	onRun = function(client, arguments)
		local target = nut.command.findPlayer(client, arguments[1])

		if (IsValid(target) and target:getChar()) then
			local attrib = arguments[2]
			if !attrib then
				client:notifyLocalized("FalseAttrib") 
				return
			end
			
			for k, v in pairs(nut.attribs.list) do
				if (nut.util.stringMatches(v.name, attrib) or nut.util.stringMatches(k, attribName) or nut.util.stringMatches("*", attrib)) then
					client:ChatPrint(target:Name().." has ".. target:getChar():getAttrib(k, 0).. " in "..v.name)
				end
			end
		end
		
	end
})


nut.chat.register("gmroll", {
	format = "(Admin Roll) %s has rolled %s.",
	color = Color(0, 255, 0),
	filter = "actions",
	font = "nutChatFontItalics",
	onCanHear = function(speaker, listener) 
	local players = player.GetAll()
	for k, v in pairs(players) do
		if v:IsAdmin() then
			Admin = v
		end
	end
	return admin
	end,
	deadCanChat = true
})

nut.command.add("gmroll", {
	adminOnly = true,
	syntax = "<string name> [number maximum]",
	onRun = function(client, arguments)
		local target = nut.command.findPlayer(client, arguments[1])
		if (IsValid(target) and target:getChar()) then
			print(target)
			local number = math.random(0, math.min(tonumber(arguments[2]) or 100, 100))
			nut.chat.send(target, "gmroll", number)
			nut.chat.send(target, "roll", number)
		end
	end
})


