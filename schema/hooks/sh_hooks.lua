function SCHEMA:CanPlayerEditData(client, target)
	if (client:getChar():hasFlags("V")) then
		return true
	end

	return false
end