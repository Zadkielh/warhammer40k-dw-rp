	nut.flag.add("p", "Physgun access.", function(client, isGiven)
		if (isGiven) then
			client:Give("weapon_physgun")
			client:SelectWeapon("weapon_physgun")
		else
			client:StripWeapon("weapon_physgun")
		end
	end)

	nut.flag.add("t", "Access to the toolgun", function(client, isGiven)
		if (isGiven) then
			client:Give("gmod_tool")
			client:SelectWeapon("gmod_tool")
		else
			client:StripWeapon("gmod_tool")
		end
	end)

	nut.flag.add("M", "Access to medic commands.")
	nut.flag.add("T", "Access to trainer commands.")
	nut.flag.add("P", "Access to PAC 3 editor.")
	nut.flag.add("A", "Access to Advert commands")
	nut.flag.add("G", "Access to GM commands")
	nut.flag.add("V", "Access to HQ commands")
	nut.flag.add("*", "Psyker flag")



		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
