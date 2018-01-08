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
