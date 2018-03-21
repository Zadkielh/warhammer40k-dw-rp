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

nut.chat.register("emperor", { -- Edit this
    onCanSay =  function(speaker, text)
		return speaker:IsAdmin() end,
	onCanHear = 1000000,
    onChatAdd = function(speaker, text)
        chat.AddText(Color(255, 255, 0 ), text) -- Edit the numbers
    end,
    prefix = {"/emperor"} -- Edit this, this is the command
})

nut.chat.register("slaanesh", { -- Edit this
    onCanSay =  function(speaker, text)
			return speaker:IsAdmin() end,
	onCanHear = 1000000,
    onChatAdd = function(speaker, text)
        chat.AddText(Color(128, 0, 128 ), text) -- Edit the numbers
    end,
    prefix = {"/slaanesh"} -- Edit this, this is the command
})
		
nut.chat.register("nurgle", { -- Edit this
    onCanSay =  function(speaker, text)
			return speaker:IsAdmin() end,
	onCanHear = 1000000,
    onChatAdd = function(speaker, text)
        chat.AddText(Color(0, 255, 0 ), text) -- Edit the numbers
    end,
    prefix = {"/nurgle"} -- Edit this, this is the command
})
			
nut.chat.register("tzeentch", { -- Edit this
    onCanSay =  function(speaker, text)
			return speaker:IsAdmin() end,
	onCanHear = 1000000,
    onChatAdd = function(speaker, text)
        chat.AddText(Color(0, 0, 255 ), text) -- Edit the numbers
    end,
    prefix = {"/tzeentch"} -- Edit this, this is the command
})

nut.chat.register("khorne", { -- Edit this
    onCanSay =  function(speaker, text)
			return speaker:IsAdmin() end,
	onCanHear = 1000000,
    onChatAdd = function(speaker, text)
        chat.AddText(Color(255, 0, 0 ), text) -- Edit the numbers
    end,
    prefix = {"/khorne"} -- Edit this, this is the command
})

nut.chat.register("chaos", { -- Edit this
    onCanSay =  function(speaker, text)
			return speaker:IsAdmin() end,
	onCanHear = 1000000,
    onChatAdd = function(speaker, text)
        chat.AddText(Color(64, 64, 64 ), text) -- Edit the numbers
    end,
    prefix = {"/chaos"} -- Edit this, this is the command
})
