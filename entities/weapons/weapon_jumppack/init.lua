if SERVER then
	AddCSLuaFile()
end

--Send files to client
AddCSLuaFile('cl_init.lua')
AddCSLuaFile('shared.lua')

--Include shared code
include('shared.lua')

--Serverside only code below here
