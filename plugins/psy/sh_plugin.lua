PLUGIN.name = "Psyniscience"
PLUGIN.author = "Zadkiel"
PLUGIN.desc = "Increases psychic power."

local playerMeta = FindMetaTable("Player")

if (SERVER) then
	function PLUGIN:PostPlayerLoadout(client)
		client:setLocalVar("psy", 0)
		if client:getChar():hasFlags("*") then
			client:setLocalVar("psy", client:getChar():getAttrib("psy", 0))
		end
	end

	local playerMeta = FindMetaTable("Player")

	function playerMeta:restorePsy()
		local current = self:getLocalVar("psy", 0)
		local value = math.Clamp(current + 1, 0, self:getChar():getAttrib("psy", 0))
		
		if client:getChar():hasFlags("*") then
			self:setLocalVar("psy", value)
			if self:getLocalVar("psy") < self:getChar():getAttrib("psy", 0) then
				self:updateAttrib("psy", 0.001)	
			end
		end
	end

else
	nut.bar.add(function()
		return LocalPlayer():getLocalVar("psy", 0) / 100
	end, Color(150, 20, 150), nil, "psy")
end
