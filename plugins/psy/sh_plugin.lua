PLUGIN.name = "Psyniscience"
PLUGIN.author = "Zadkiel"
PLUGIN.desc = "Increases psychic power."

local playerMeta = FindMetaTable("Player")

if (SERVER) then
	function PLUGIN:PostPlayerLoadout(client)
	local uniqueID = ""..client:SteamID()
	local value = client:getLocalVar("psy", 0)
	
	client:setLocalVar("psy", 0)
		if client:getChar():hasFlags("*") then
			client:setLocalVar("psy", client:getChar():getAttrib("psy", 0))
			timer.Create(uniqueID, 0.25, 0, function()
				
				if IsValid(client) then
					local regen = (client:getChar():getAttrib("psy", 0) / 100 * 2.5)
					local current = client:getLocalVar("psy", 0)
					local value = math.Clamp(current + regen, 0, client:getChar():getAttrib("psy", 0))
					if (current != value) then
						
					
						if (current < (client:getChar():getAttrib("psy", 0) / 3)) then
							client:getChar():updateAttrib("psy", 0.001)
							client:getChar():updateAttrib("end", 0.001)
						end
						
						client:setLocalVar("psy", value)
					end
				else
					timer.Remove(uniqueID)
				end
			end
			)
			
		end
		
		
	end
	
	local playerMeta = FindMetaTable("Player")

	function playerMeta:restorePsy(amount)
		local current = self:getLocalVar("psy", 0)
		local value = math.Clamp(current + amount, 0, self:getChar():getAttrib("psy", 0))
		
		--if client:getChar():hasFlags("*") then
			self:setLocalVar("psy", value)
			if self:getLocalVar("psy", 0) < self:getChar():getAttrib("psy", 0) then
				self:updateAttrib("psy", 0.001)	
			end
		--end
	end

else
	nut.bar.add(function()
		return LocalPlayer():getLocalVar("psy", 0) / 100
	end, Color(150, 20, 150), nil, "psy")
end

		

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	