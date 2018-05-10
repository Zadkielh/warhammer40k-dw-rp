PLUGIN.name = "Psyniscience"
PLUGIN.author = "Zadkiel"
PLUGIN.desc = "Increases psychic power."

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

end
nut.command.add("peril", {
    adminOnly = true,
    syntax = "<string name> <number gates>",
    onRun = function(client, args)
        local Target = nut.command.findPlayer(client, args[1])
        if not IsValid(Target) then return end
		
		client.Gates = {}
		for i = 1, (tonumber(args[2] ) or 1) do
			local gate = ents.Create( "sent_vj_warp_gate" )
			if ( !IsValid( gate ) )then return end
			gate:SetPos(Target:GetPos() + Vector( math.random(-250, 250), math.random(-250, 250), math.random(10, 20) ) ) 
			gate:SetAngles(Target:GetAngles())
			gate.SingleSpawner = true
			gate:Spawn()
			gate:Activate()
		
			table.insert(client.Gates, gate)
		end

    end
})
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	