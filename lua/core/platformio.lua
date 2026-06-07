-- PlatformIO integration - using snacks.nvim

local M = {}

-- roots with an in-flight compiledb run, so we never launch two at once.
local generating = {}

local function notify(msg, level)
  vim.notify(msg, level or vim.log.levels.INFO, { title = "PlatformIO" })
end

local function has_pio()
  if vim.fn.executable("pio") == 1 then
    return true
  end
  notify("`pio` not found.", vim.log.levels.ERROR)
  return false
end

-- Nearest ancestor dir holding platformio.ini, else nil
local function project_root(buf)
  local fname = vim.api.nvim_buf_get_name(buf or 0)
  return vim.fs.root(fname ~= "" and fname or (buf or 0), { "platformio.ini" })
end

-- Run a pio command in a fresh Snacks terminal
local function pio(args, opts)
  if not has_pio() then
    return
  end
  opts = opts or {}
  local root = project_root()
  if not root and not opts.no_project then
    notify("No platformio.ini found. Run :PioInit first.", vim.log.levels.WARN)
    return
  end
  Snacks.terminal.open("pio " .. args, {
    cwd = root or vim.fn.getcwd(),
    -- interactive only for long-running cmds;
    -- one-shot cmds in normal mode
    interactive = opts.interactive or false,
    auto_close = false,
    win = { position = opts.position or "float" },
  })
end

-- Generate compile_commands.json and restart clangd to pick it up
local function run_compiledb(root, opts)
  opts = opts or {}
  if generating[root] then
    return
  end
  generating[root] = true
  if not opts.silent then
    notify("Generating compile_commands.json…")
  end
  vim.system({ "pio", "run", "-t", "compiledb" }, { cwd = root, text = true }, function(res)
    vim.schedule(function()
      generating[root] = nil
      if res.code == 0 then
        pcall(vim.cmd, "LspRestart clangd")
        notify("clangd index ready (compile_commands.json updated)")
      elseif not opts.silent then
        notify("compiledb failed:\n" .. (res.stderr or ""), vim.log.levels.ERROR)
      end
    end)
  end)
end

-- Manual refresh
function M.compiledb()
  if not has_pio() then
    return
  end
  local root = project_root()
  if not root then
    notify("No platformio.ini found.", vim.log.levels.WARN)
    return
  end
  run_compiledb(root, { silent = false })
end

-- Auto refresh
local function ensure_compiledb(buf, mode)
  if vim.fn.executable("pio") == 0 then
    return
  end
  local root = project_root(buf)
  if not root then
    return
  end
  local cdb = vim.uv.fs_stat(root .. "/compile_commands.json")
  if mode == "missing" then
    if cdb then
      return
    end
  else -- "stale"
    local ini = vim.uv.fs_stat(root .. "/platformio.ini")
    if cdb and ini and cdb.mtime.sec >= ini.mtime.sec then
      return
    end
  end
  run_compiledb(root, { silent = true })
end

-- Serial-monitor lifecycle.
--
-- Tracking the monitor terminal buffer and delete it before port ops.
-- Every monitor should be a fresh session - port always released.
local serial = { buf = nil }

local function stop_serial()
  if serial.buf and vim.api.nvim_buf_is_valid(serial.buf) then
    pcall(vim.api.nvim_buf_delete, serial.buf, { force = true })
  end
  serial.buf = nil
end

local function open_serial(args)
  if not has_pio() then
    return
  end
  local root = project_root()
  if not root then
    notify("No platformio.ini found. Run :PioInit first.", vim.log.levels.WARN)
    return
  end
  stop_serial()
  local term = Snacks.terminal.open("pio " .. args, {
    cwd = root,
    interactive = true,
    auto_close = true,
    win = { position = "float", bo = { bufhidden = "wipe" } },
  })
  serial.buf = term and term.buf or nil
end

local actions = {
  -- interactive = true -> insert mode (autoscroll)
  build = function()
    pio("run", { interactive = true })
  end,
  -- free the port first (kill any open monitor) so upload can claim it.
  upload = function()
    stop_serial()
    pio("run -t upload", { interactive = true })
  end,
  uploadmon = function()
    open_serial("run -t upload && pio device monitor")
  end,
  monitor = function()
    open_serial("device monitor")
  end,
  clean = function()
    pio("run -t clean")
  end,
  -- Drop empty ports, regardless of port type.
  devices = function()
    Snacks.terminal.open(
      [[pio device list | awk 'BEGIN{RS="";ORS="\n\n"} $0 !~ /Hardware ID: n\/a/']],
      { cwd = vim.fn.getcwd(), interactive = false, auto_close = false, win = { position = "float" } }
    )
  end,
  compiledb = function()
    M.compiledb()
  end,
}

function M.init()
  local cmd = vim.api.nvim_create_user_command

  cmd("PioBuild", actions.build, { desc = "PlatformIO: build" })
  cmd("PioUpload", actions.upload, { desc = "PlatformIO: upload" })
  cmd("PioUploadMonitor", actions.uploadmon, { desc = "PlatformIO: upload + monitor" })
  cmd("PioMonitor", actions.monitor, { desc = "PlatformIO: serial monitor" })
  cmd("PioClean", actions.clean, { desc = "PlatformIO: clean" })
  cmd("PioDevices", actions.devices, { desc = "PlatformIO: list devices" })
  cmd("PioCompileDb", actions.compiledb, { desc = "PlatformIO: regen compile_commands.json" })

  cmd("PioInit", function()
    if not has_pio() then
      return
    end
    vim.ui.input({ prompt = "Board id (e.g. esp32dev, esp32-s3-devkitc-1): " }, function(board)
      if not board or board == "" then
        return
      end
      Snacks.terminal.open(
        ("pio project init --board %s"):format(board),
        { cwd = vim.fn.getcwd(), interactive = false, auto_close = false }
      )
    end)
  end, { desc = "PlatformIO: init project (pick board)" })

  cmd("PioLib", function()
    if not has_pio() then
      return
    end
    vim.ui.input({ prompt = "Library to install (name or id): " }, function(lib)
      if not lib or lib == "" then
        return
      end
      pio(("pkg install --library %q"):format(lib))
    end)
  end, { desc = "PlatformIO: install library" })

  cmd("PioMenu", function()
    local items = {
      { name = "Build", run = actions.build },
      { name = "Upload", run = actions.upload },
      { name = "Upload + Monitor", run = actions.uploadmon },
      { name = "Monitor", run = actions.monitor },
      { name = "Clean", run = actions.clean },
      { name = "Devices", run = actions.devices },
      { name = "Regen compile_commands (clangd)", run = actions.compiledb },
      {
        name = "Install library",
        run = function()
          vim.cmd("PioLib")
        end,
      },
      {
        name = "Init project",
        run = function()
          vim.cmd("PioInit")
        end,
      },
    }
    vim.ui.select(items, {
      prompt = "PlatformIO",
      format_item = function(it)
        return it.name
      end,
    }, function(choice)
      if choice then
        choice.run()
      end
    end)
  end, { desc = "PlatformIO: action menu" })

  local grp = vim.api.nvim_create_augroup("PlatformIO", { clear = true })

  -- Buffer-local keymaps
  vim.api.nvim_create_autocmd("FileType", {
    group = grp,
    pattern = { "c", "cpp", "arduino", "objc", "objcpp" },
    callback = function(ev)
      local function map(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, desc = desc, silent = true })
      end
      map("<leader>Pp", "<cmd>PioMenu<cr>", "platformio: menu")
      map("<leader>Pb", actions.build, "platformio: build")
      map("<leader>Pu", actions.upload, "platformio: upload")
      map("<leader>PU", actions.uploadmon, "platformio: upload + monitor")
      map("<leader>Pm", actions.monitor, "platformio: monitor")
      map("<leader>Pc", actions.clean, "platformio: clean")
      map("<leader>Pd", actions.devices, "platformio: device list")
      map("<leader>PD", actions.compiledb, "platformio: regen compile_commands")
      map("<leader>Pi", "<cmd>PioInit<cr>", "platformio: init project")
      map("<leader>Pl", "<cmd>PioLib<cr>", "platformio: install library")

      ensure_compiledb(ev.buf, "stale")
    end,
  })

  -- First save of a fresh project generate compile_commands.json for clangd
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = grp,
    pattern = { "*.c", "*.cpp", "*.cc", "*.h", "*.hpp", "*.ino" },
    callback = function(ev)
      ensure_compiledb(ev.buf, "missing")
    end,
  })
end

return M
