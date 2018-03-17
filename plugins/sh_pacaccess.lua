PLUGIN.name = "PAC Restriction"
PLUGIN.desc = "Restricts PAC"
PLUGIN.author = "Zadkiel"

	
hook.Add("PrePACConfigApply", "FlagCheck", function(ply, outfit_data)
	if not ply:getChar():hasFlags() then
		return false, "you do not have the correct flag to use PAC."
	end
end)	