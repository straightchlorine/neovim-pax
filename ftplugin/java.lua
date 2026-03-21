--- java.lua
-- Configuration for java support provided by jdtls.
-- All tooling resolved from Mason packages automatically.
---

local mason = vim.fn.stdpath('data') .. '/mason/packages'

-- Discover installed JVM runtimes under /usr/lib/jvm/
-- Supports both Gentoo (openjdk-25, openjdk-bin-11) and Arch (java-21-openjdk) naming
local function discover_runtimes()
  local runtimes = {}
  local jvm_dir = '/usr/lib/jvm'
  local entries = vim.fn.globpath(jvm_dir, '*', false, true)
  for _, entry in ipairs(entries) do
    if vim.fn.isdirectory(entry) == 1 then
      local name = vim.fn.fnamemodify(entry, ':t')
      local version = name:match('(%d+)')
      if version then
        table.insert(runtimes, {
          name = 'JavaSE-' .. version,
          path = entry .. '/',
        })
      end
    end
  end
  return runtimes
end

-- Collect all extension bundles (debug, test, decompiler, dependency)
local function discover_bundles()
  local bundles = {}
  local sources = {
    mason .. '/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar',
    mason .. '/java-test/extension/server/*.jar',
    mason .. '/vscode-java-decompiler/server/*.jar',
    mason .. '/vscode-java-dependency/extension/server/*.jar',
  }
  for _, pattern in ipairs(sources) do
    local jars = vim.fn.glob(pattern, 1)
    if jars ~= '' then
      vim.list_extend(bundles, vim.split(jars, '\n'))
    end
  end
  return bundles
end

local config = {
  cmd = {
    'java'                                                ,
    '-Declipse.application=org.eclipse.jdt.ls.core.id1'  ,
    '-Dosgi.bundles.defaultStartLevel=4'                 ,
    '-Declipse.product=org.eclipse.jdt.ls.core.product'  ,
    '-Dlog.protocol=true'                                ,
    '-Dlog.level=ALL'                                    ,
    '-Xmx1g'                                             ,
    '--add-modules=ALL-SYSTEM'                           ,
    '--add-opens'                                        , 'java.base/java.util=ALL-UNNAMED'  ,
    '--add-opens'                                        , 'java.base/java.lang=ALL-UNNAMED'  ,
    '-jar'                                               , vim.fn.glob(mason .. '/jdtls/plugins/org.eclipse.equinox.launcher_*.jar') ,
    '-configuration'                                     , mason .. '/jdtls/config_linux'     ,
    '-data'                                              , vim.fn.stdpath('cache') .. '/jdtls/workspace'
  },
  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
  settings = {
    java = {
      configuration = {
        runtimes = discover_runtimes()
      }
    }
  },
  init_options = {
    bundles = discover_bundles()
  },
}

require('jdtls').start_or_attach(config)

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
