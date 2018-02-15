SCHEMA.name = "Warhammer 40k RP"
SCHEMA.introName = "Warhammer 40k: Deathwatch RP"
SCHEMA.author = "Zadkiel"
SCHEMA.desc = ""

nut.currency.set("", "Credit", "Credits")
nut.config.menuMusic = "sound/bloodystream.mp3"

nut.util.includeDir("libs")
nut.util.includeDir("lua/commands")
nut.util.include("lua/sh_flags.lua")
nut.util.include("lua/sh_models.lua")
nut.util.includeDir("lua/medical")
nut.util.includeDir("lua/server")
print([[

////////////////////////////////////////////
//// Zadkiel's Schema has been loaded	////
//// succesfully, if there are any	////
//// problems, report them to Zadkiel	////
////					////
//// Have a good day!			////
////					////
////////////////////////////////////////////

]]
)

function GM:GetGameDescription()
	return "Warhammer 40k RP"
end

--------------------------------------------------------------------------------------------------------------------------------------------


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


------------------------------- VGUI TESTING ----------------------------------------
/*
function SCHEMA:CreateMenuButtons(tabs)			
		tabs["Tech Tree"] = function(panel)
			panel:Add("nut_TechTree")
		end
end
*/

--- Adds a panel in the f4 menu called Tech Tree



