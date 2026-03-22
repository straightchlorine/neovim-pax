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
      if version and vim.uv.fs_stat(entry .. '/bin/javac') then
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

-- Auto-generate Eclipse project files for plain Java projects (no Maven/Gradle)
-- so jdtls can resolve source roots and packages correctly.
local function ensure_eclipse_files(root)
  if not root then return end

  -- Skip if this is a build-tool project
  for _, marker in ipairs({ 'pom.xml', 'build.gradle', 'build.gradle.kts', 'mvnw', 'gradlew' }) do
    if vim.uv.fs_stat(root .. '/' .. marker) then return end
  end

  -- Find source directories
  local src_dirs = {}
  for _, candidate in ipairs({ 'src', 'source' }) do
    if vim.uv.fs_stat(root .. '/' .. candidate) then
      table.insert(src_dirs, candidate)
    end
  end
  if #src_dirs == 0 then return end

  -- Generate .classpath if missing
  if not vim.uv.fs_stat(root .. '/.classpath') then
    local entries = {}
    for _, src in ipairs(src_dirs) do
      table.insert(entries, ('  <classpathentry kind="src" path="%s"/>'):format(src))
    end
    local out = vim.uv.fs_stat(root .. '/out') and 'out' or 'bin'
    table.insert(entries, ('  <classpathentry kind="output" path="%s"/>'):format(out))
    table.insert(entries, '  <classpathentry kind="con" path="org.eclipse.jdt.launching.JRE_CONTAINER"/>')

    local content = '<?xml version="1.0" encoding="UTF-8"?>\n<classpath>\n'
      .. table.concat(entries, '\n') .. '\n</classpath>\n'
    local f = io.open(root .. '/.classpath', 'w')
    if f then f:write(content); f:close() end
  end

  -- Generate .project if missing
  if not vim.uv.fs_stat(root .. '/.project') then
    local name = vim.fn.fnamemodify(root, ':t')
    local content = '<?xml version="1.0" encoding="UTF-8"?>\n'
      .. '<projectDescription>\n'
      .. '  <name>' .. name .. '</name>\n'
      .. '  <buildSpec>\n'
      .. '    <buildCommand>\n'
      .. '      <name>org.eclipse.jdt.core.javabuilder</name>\n'
      .. '    </buildCommand>\n'
      .. '  </buildSpec>\n'
      .. '  <natures>\n'
      .. '    <nature>org.eclipse.jdt.core.javanature</nature>\n'
      .. '  </natures>\n'
      .. '</projectDescription>\n'
    local f = io.open(root .. '/.project', 'w')
    if f then f:write(content); f:close() end
  end
end

local root_dir = require('jdtls.setup').find_root({'pom.xml', 'build.gradle', 'mvnw', 'gradlew', '.iml', 'build.xml', '.git'})

-- Per-project workspace data directory to avoid stale/conflicting metadata
local project_name = root_dir and vim.fn.fnamemodify(root_dir, ':t') or 'default'
local data_dir = vim.fn.stdpath('cache') .. '/jdtls/' .. project_name

ensure_eclipse_files(root_dir)

local config = {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', vim.fn.glob(mason .. '/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
    '-configuration', mason .. '/jdtls/config_linux',
    '-data', data_dir,
  },
  root_dir = root_dir,
  settings = {
    java = {
      configuration = {
        runtimes = discover_runtimes(),
      },
    },
  },
  init_options = {
    bundles = discover_bundles(),
  },
}

require('jdtls').start_or_attach(config)

-- vim: filetype=lua:expandtab:shiftwidth=2:tabstop=4:softtabstop=2:textwidth=80
