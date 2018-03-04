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


