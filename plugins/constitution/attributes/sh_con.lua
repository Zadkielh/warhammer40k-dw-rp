ATTRIBUTE.name = "Constitution"
ATTRIBUTE.desc = "Increases Hit Points."

function ATTRIBUTE:onSetup(client, value)
	local value = client:getChar():getAttrib("con", 0)
end