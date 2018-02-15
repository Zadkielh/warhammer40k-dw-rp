/*if (!nut.char) then include("sh_character.lua") end

nut.traits = nut.traits or {}
nut.traits.list = nut.traits.list or {}

function nut.traits.loadFromDir(directory)
	for k, v in ipairs(file.Find(directory.."/*.lua", "LUA")) do
		local niceName = v:sub(4, -5)
		
		if (PLUGIN) then
				TRAIT.plugin = PLUGIN.uniqueID
		end


		TRAIT = nut.traits.list[niceName] or {}

			nut.util.include(directory.."/"..v)
			TRAIT.name = "Unknown"
			TRAIT.desc = "No description availalble."

			nut.traits.list[niceName] = TRAIT
		TRAIT = nil
	end
end

function nut.traits.setup(client)
	local character = client:getChar()

	if (character) then
		for k, v in pairs(nut.traits.list) do
			if (v.onSetup) then
				v:onSetup(client, character:getTrait(k, 0))
			end
		end
	end
end

do
	local charMeta = nut.meta.character
	
	if (SERVER) then
		function charMeta:updateTrait(key, value)
			local trait = nut.traits.list[key]

			if (trait) then
				local Trait = self:getTrait()
				local client = self:getPlayer()

				trait[key] = (Trait[key] or 0) + value

				if (IsValid(client)) then
					netstream.Start(client, "trait", self:getID(), key, Trait[key])

					if (Trait.setup) then
						Trait.setup(Trait[key])
					end
				end
			end
		end
	end
end

local charMeta = nut.meta.character

		function charMeta:setTrait(key, value)
			local trait = nut.traits.list[key]

			if (trait) then
				local Trait = self:getTrait()
				local client = self:getPlayer()

				trait[key] = value

				if (IsValid(client)) then
					netstream.Start(client, "trait", self:getID(), key, trait[key])

					if (Trait.setup) then
						Trait.setup(trait[key])
					end
				end
			end
		end
		netstream.Hook("trait", function(id, key, value)
			local character = nut.char.loaded[id]

			if (character) then
				character:getTrait()[key] = value
			end
		end)

	function charMeta:getTrait(key, default)
		if not key then
			return -- Everything
		end
    
		return self:getTrait()[key] or default
	end