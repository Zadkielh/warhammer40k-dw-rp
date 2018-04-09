nut.trait = nut.trait or {}
nut.trait.list = nut.trait.list or {}

-- Adds a flag that does something when set.
function nut.trait.add(trait, desc, callback)
	-- Add the flag to a list, storing the description and callback (if there is one).
	nut.trait.list[trait] = {desc = desc, callback = callback}
end

if (SERVER) then
	-- Called to apply flags when a player has spawned.
	function nut.trait.onSpawn(client)
		-- Check if they have a valid character.
		if (client:getChar()) then
			-- Get all of the character's flags.
			local traits = client:getChar():getTraits()

			for i = 1, #traits do
				-- Get each individual flag.
				local trait = traits:sub(i, i)
				local info = nut.trait.list[trait]

				-- Check if the flag has a callback.
				if (info and info.callback) then
					-- Run the callback, passing the player and true so they get whatever benefits.
					info.callback(client, true)
				end
			end
		end
	end
end

do
	-- Extend the character metatable to allow flag giving/taking.
	local character = nut.meta.character

	-- Flags can only be set server-side.
		-- Set the flag data to the flag string.
		function character:setTraits(traits)
			self:setData("t", traits)
		end

		-- Add a flag to the flag string.
		function character:giveTraits(traits)
			local addedTraits = ""

			-- Get the individual flags within the flag string.
			for i = 1, #traits do
				local trait = traits:sub(i, i)
				local info = nut.trait.list[trait]

				if (info) then
					if (!character:hasTraits(trait)) then
						addedTraits = addedTraits..trait
					end

					if (info.callback) then
						-- Pass the player and true (true for the flag being given.)
						info.callback(self:getPlayer(), true)
					end
				end
			end

			-- Only change the flag string if it is different.
			if (addedTraits != "") then
				self:setTraits(self:getTraits()..addedTraits)
			end
		end

		-- Remove the flags from the flag string.
		function character:takeTraits(traits)
			local oldTraits = self:getTraits()
			local newTraits = oldTraits

			-- Get the individual flags within the flag string.
			for i = 1, #traits do
				local trait = traits:sub(i, i)
				local info = nut.trait.list[trait]

				-- Call the callback if the flag has been registered.
				if (info and info.callback) then
					-- Pass the player and false (false since the flag is being taken)
					info.callback(self:getPlayer(), false)
				end

				newTraits = newTraits:gsub(trait, "")
			end

			if (newTraits != oldTraits) then
				self:setTraits(newTraits)
			end
		end

	-- Return the flag string.
	function character:getTraits()
		return self:getData("t", "")
	end

	-- Check if the flag string contains the flags specified.
	function character:hasTraits(traits)
		for i = 1, #traits do
			if (self:getTraits():find(traits:sub(i, i), 1, true)) then
				return true
			end
		end

		return false
	end
end

do
	nut.trait.add("1", "Primaris", function(client, isGiven)
		if (isGiven) then
			client:SetHealth(2750)
			client:SetMaxHealth(2750)
			client:SetArmor(400)
		end
	end)
	nut.trait.add("2", "Primaris Grav", function(client, isGiven)
		if (isGiven) then
			client:SetHealth(2750)
			client:SetMaxHealth(2750)
			client:SetArmor(450)
		end
	end)
	nut.trait.add("3", "Primaris Reiver", function(client, isGiven)
		if (isGiven) then
			client:SetHealth(2750)
			client:SetMaxHealth(2750)
			client:SetArmor(250)
		end
	end)
	nut.trait.add("4", "Scout", function(client, isGiven)
		if (isGiven) then
			client:SetHealth(2000)
			client:SetMaxHealth(2000)
			client:SetArmor(100)
		end
	end)
	nut.trait.add("5", "Terminator", function(client, isGiven)
		if (isGiven) then
			client:SetHealth(3500)
			client:SetMaxHealth(3500)
			client:SetArmor(500)
		end
	end)
	
	nut.trait.add("f", "Immune to Ignition", function(client, isGiven)
		if (isGiven) then
			local ID = "nutFlagF"..client:SteamID()
			if timer.Exists( ID ) then
				timer.Remove( ID )
			end
			timer.Create(ID, 0.1, 0, function() 
				if client:IsOnFire() then
					client:Extinguish()
				end
			end)
		end
	end)
end
