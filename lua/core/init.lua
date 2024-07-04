--- core/init.lua
-- Initialize core as a module
---

local load_core = function()
	require("core.lazy")
	require("core.options")
	require("core.mappings")
end

load_core()

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
