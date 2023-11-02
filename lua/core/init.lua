--- core/init.lua
-- Initializing core as a module.
---

local load_core = function ()
  require('core.packer')
  require('core.options')
  require('core.mappings')
  require('core.theme')
end

load_core()

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
