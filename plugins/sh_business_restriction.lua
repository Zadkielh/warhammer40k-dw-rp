PLUGIN.name = "Business Restriction"
PLUGIN.desc = "Restricts Business"
PLUGIN.author = "Zadkiel"

function PLUGIN:CanPlayerUseBusiness(client, uniqueID)
	return client:IsAdmin()
end