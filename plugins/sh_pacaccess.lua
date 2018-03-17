PLUGIN.name = "PAC Restriction"
PLUGIN.desc = "Restricts PAC"
PLUGIN.author = "Zadkiel"

hook.Add("PrePACConfigApply", "FlagCheck", function(ply, outfit_data)
	if ply:getChar():hasFlags("P") then
		return true
	else
		return false, "you do not have the correct flag to use PAC."
	end
end)	