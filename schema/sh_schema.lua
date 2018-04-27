SCHEMA.name = "Warhammer 40k RP"
SCHEMA.introName = "Warhammer 40k: Deathwatch RP"
SCHEMA.author = "Zadkiel"
SCHEMA.desc = ""

nut.currency.set("", "Credit", "Credits")

nut.util.includeDir("libs")
nut.util.includeDir("lua/commands")
nut.util.include("lua/sh_flags.lua")
nut.util.include("lua/sh_models.lua")
nut.util.includeDir("lua/medical")
nut.util.includeDir("lua/server")
nut.util.includeDir("derma")
print([[

////////////////////////////////////////////
//// Zadkiel's Schema has been loaded	////
//// succesfully, if there are any		////
//// problems, report them to Zadkiel	////
////									////
//// Have a good day!					////
////									////
////////////////////////////////////////////

]]
)

function SCHEMA:GetGameDescription()
	return "Warhammer 40k RP"
end

function SCHEMA:PlayerSwitchFlashlight(client, enabled)
		return true
end

function SCHEMA:GetFallDamage(client, speed)
	return 0
end

function SCHEMA:EntityTakeDamage(client, dmg)
	if (client:IsPlayer()) then
		local char = client:getChar()
			
		if char:hasFlags("+") then
			if (dmg:GetAttacker():IsNPC()) then 
				dmg:ScaleDamage(  1.5 - ((client:getChar():getAttrib("con", 0) / 100)) - 0.4) // Damage is now half of what you would normally take.
			end
		end		
	end
end

--------------------------------------------------------------------------------------------------------------------------------------------
function HideThings( name )
	if (name == "CHudDamageIndicator" ) then
		return false
	end
end
hook.Add( "HUDShouldDraw", "HideThings", HideThings ) 

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
	nut.trait.onSpawn(client)
	
	if client:HasGodMode() then
		client:GodDisable()
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

/*
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
end*/

nut.chat.register("hq", {
	color = Color(192, 57, 43),
	onCanSay = function(client)
		if (!client:getChar():hasFlags("V")) then
			client:notifyLocalized("notAllowed")

			return false
		end
	end,
	onChatAdd = function(speaker, text)
		chat.AddText(Color(192, 57, 43), L("icFormat", "Headquarters", text))
	end,
	prefix = {"/hq"}
})


