local load_core = function()
  -- options first: it sets vim.g.loaded_* guards and globals
  require("core.options")
  require("core.lazy")
  require("core.mappings")
  require("core.platformio").init()
end

load_core()
