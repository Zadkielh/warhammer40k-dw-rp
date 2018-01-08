SCHEMA.name = "Test RP"
SCHEMA.introName = "Test RP"
SCHEMA.author = "Zadkiel"
SCHEMA.desc = ""

nut.currency.set("", "Credit", "Credits")
nut.config.menuMusic = "sound/PRMmuN7wdFFH.128.mp3"

nut.util.include("libs/cl_40k_hud2.lua")
nut.util.include("libs/cl_fonts.lua")
nut.util.include("sh_schema_commands.lua")
nut.util.include("sh_flags.lua")
nut.util.include("sh_chatcommands.lua")
nut.util.include("sh_models.lua")

function SCHEMA:PlayerLoadedChar(client, netChar, prevChar)
    if (prevChar) then
        client:notifyLocalized("Loaded Character")
    end

    local char = client:getChar()
	
    if (char) then
       return char
    end
end

----------------------------
---- Spawn related ---------
----------------------------

function SCHEMA:PostPlayerLoadout(client)

	if (IsValid(client)) then
				
			if client:getChar():getClass() != nil then
				ClassKeepValues(client) 
			end
			
			--if client:Team() != nil then
				--FactionKeepValues(client, client:Team())
			--end
			
	end
end



-----------------------------------------------------------------------------------------------------------------------------------------------
--[[function FactionKeepValues(client, faction)
	
	if (IsValid(client)) then
	
		local id = nut.faction.indices[faction]
		
			client:SetHealth(id.health) 
			client:SetMaxHealth(id.health)
			client:SetArmor(id.armor)

	end
end--]]


function ClassKeepValues(client)

	if (IsValid(client)) then
		
		for k, v in pairs(nut.class.list) do
		
		client:SetHealth(v.health)
		client:SetMaxHealth(v.health)
		client:SetArmor(v.armor)
		client:SetModel(v.model)
		
		
		
			for key, var in pairs(v.weapons)  do
				client:Give(key)
				
			end
		
		end
	end 
end


