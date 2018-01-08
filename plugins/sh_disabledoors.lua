PLUGIN.name = "Disable Doors"
PLUGIN.author = "SleepyMode"
PLUGIN.desc = "A simple system to disable doors by default."

nut.config.add("disableDoors", true, "Whether or not all doors should be disabled by default.", function(oldValue, newValue)
		for k, v in pairs( ents.FindByClass( "door_*" ) ) do
			v:setNetVar("disabled", newValue)
		end
end, {
	category = "server"
})
