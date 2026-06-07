local load_core = function()
	require("core.lazy")
	require("core.options")
	require("core.mappings")
	require("core.platformio").init()
end

load_core()
