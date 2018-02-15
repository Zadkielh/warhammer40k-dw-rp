nut.chat.register("advert", {
	onCanSay =  function(speaker, text)
		return speaker:getChar():hasFlags("Vox")
	end,
	onCanHear = 1000000,
	onChatAdd = function(speaker, text)
		chat.AddText(Color(255, 162, 0), " [Advert] " .. speaker:Nick() .. ":", color_white, text)
	end,
	prefix = {"/advert"}
})

nut.chat.register("gmannouncement", {
	onCanSay =  function(speaker, text)
		return speaker:getChar():hasFlags("GM")
	end,
	onCanHear = 1000000,
	onChatAdd = function(speaker, text)
		chat.AddText(Color(102, 0, 204), " [GM-Announcement] ", color_white, text)
	end,
	prefix = {"/gad"}
})



nut.command.add("ko", {
    adminOnly = true,
    syntax = "<string name>",
    onRun = function(client, args)
        local Target = nut.command.findPlayer(client, args[1])
        if not IsValid(Target) then return end

        local TargetClass = table.concat(args," ", 2)

		Target:setRagdolled(true)

        client:notify("Knocked Out")

    end
})

