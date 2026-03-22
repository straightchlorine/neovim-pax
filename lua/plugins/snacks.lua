-- snacks.nvim
-- https://github.com/folke/snacks.nvim

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- Disable animations globally
    animate = { enabled = false },
    bigfile = { enabled = true },
    bufdelete = { enabled = true },
    debug = { enabled = true },
    dim = { enabled = true },
    image = { enabled = true },
    indent = {
      enabled = true,
      animate = { enabled = false },
      scope = {
        enabled = true,
        animate = { enabled = false },
      },
    },
    input = { enabled = true },
    lazygit = { enabled = false },
    notifier = { enabled = true },
    notify = { enabled = true },
    profiler = { enabled = true },
    picker = {
      enabled = true,
      win = {
        keys = {
          ["<c-n>"] = "down",
          ["<c-p>"] = "up",
        },
      },
    },
    explorer = { enabled = true },
    quickfile = { enabled = true },
    rename = { enabled = true },
    scope = { enabled = false },
    scratch = { enabled = true },
    statuscolumn = { enabled = true },
    terminal = {
      enabled = true,
      win = {
        style = "terminal",
      },
    },
    toggle = { enabled = true, notify = true, which_key = true },
    util = { enabled = true },
    words = { enabled = true },
  },
  config = function(_, opts)
    require("snacks").setup(opts)
    -- Snacks handles all UI interfaces since dressing.nvim is archived
    vim.ui.select = Snacks.picker.select
    vim.ui.input = Snacks.input
    vim.notify = Snacks.notifier
  end,
  keys = {
    -- stylua: ignore start
    -- pickers
    { "<leader><space>", function() Snacks.picker.smart() end, desc = "picker: smart find files" },
    { "<leader>,", function() Snacks.picker.buffers() end, desc = "picker: buffers" },
    { "<leader>/", function() Snacks.picker.grep() end, desc = "picker: grep" },
    { "<leader>:", function() Snacks.picker.command_history() end, desc = "picker: command history" },
    { "<leader>sN", function() Snacks.picker.notifications() end, desc = "picker: notification history" },
    -- find
    { "<leader>Fb", function() Snacks.picker.buffers() end, desc = "find: buffers" },
    { "<leader>Fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "find: config file" },
    { "<leader>Ff", function() Snacks.picker.files() end, desc = "find: files" },
    { "<leader>Fg", function() Snacks.picker.git_files() end, desc = "find: git files" },
    { "<leader>Fp", function() Snacks.picker.projects() end, desc = "find: projects"},
    { "<leader>Fr", function() Snacks.picker.recent() end, desc = "find: recent" },
    -- git (telescope-style pickers)
    { "<leader>Gb", function() Snacks.picker.git_branches() end, desc = "git: branches" },
    { "<leader>Gl", function() Snacks.picker.git_log() end, desc = "git: log" },
    { "<leader>GL", function() Snacks.picker.git_log_line() end, desc = "git: log line" },
    { "<leader>GS", function() Snacks.picker.git_stash() end, desc = "git: stash" },
    { "<leader>Gs", function() Snacks.picker.git_status() end, desc = "git: status" },
    { "<leader>Gd", function() Snacks.picker.git_diff() end, desc = "git: diff (hunks)" },
    { "<leader>Gf", function() Snacks.picker.git_log_file() end, desc = "git: log file" },
    -- grep
    { "<leader>sb", function() Snacks.picker.lines() end, desc = "search: buffer lines" },
    { "<leader>sB", function() Snacks.picker.grep_buffers() end, desc = "search: grep open buffers" },
    { "<leader>sg", function() Snacks.picker.grep() end, desc = "search: grep", },
    { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "search: word under cursor", mode = { "n", "x" } },
    -- search
    { '<leader>s"', function() Snacks.picker.registers() end, desc = "search: registers" },
    { "<leader>s/", function() Snacks.picker.search_history() end, desc = "search: history" },
    { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "search: autocmds" },
    { "<leader>sc", function() Snacks.picker.command_history() end, desc = "search: command history" },
    { "<leader>sC", function() Snacks.picker.commands() end, desc = "search: commands" },
    { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "search: diagnostics" },
    { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end, desc = "search: buffer diagnostics" },
    { "<leader>sh", function() Snacks.picker.help() end, desc = "search: help pages" },
    { "<leader>sH", function() Snacks.picker.highlights() end, desc = "search: highlights" },
    { "<leader>si", function() Snacks.picker.icons() end, desc = "search: icons" },
    { "<leader>sj", function() Snacks.picker.jumps() end, desc = "search: jumps" },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "search: keymaps" },
    { "<leader>sl", function() Snacks.picker.loclist() end, desc = "search: location list" },
    { "<leader>sm", function() Snacks.picker.marks() end, desc = "search: marks" },
    { "<leader>sM", function() Snacks.picker.man() end, desc = "search: man pages" },
    { "<leader>sp", function() Snacks.picker.lazy() end, desc = "search: plugin spec" },
    { "<leader>sq", function() Snacks.picker.qflist() end, desc = "search: quickfix list" },
    { "<leader>sR", function() Snacks.picker.resume() end, desc = "search: resume" },
    { "<leader>su", function() Snacks.picker.undo() end, desc = "search: undo history" },
    { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "ui: colorschemes" },
    -- lsp (these override the lspconfig mappings to use snacks picker)
    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "lsp: goto definition" },
    { "gD", function() Snacks.picker.lsp_declarations() end, desc = "lsp: goto declaration" },
    { "gR", function() Snacks.picker.lsp_references() end, nowait = true, desc = "lsp: references"  },
    { "gI", function() Snacks.picker.lsp_implementations() end, desc = "lsp: goto implementation" },
    { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "lsp: goto type definition" },
    { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "lsp: symbols" },
    { "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "lsp: workspace symbols" },
    -- terminal
    { "<leader>ft", function() Snacks.terminal() end, desc = "terminal: toggle floating" },
    { "<leader>fT", function() Snacks.terminal(nil, { win = { position = "bottom" } }) end, desc = "terminal: toggle bottom split" },
    { "<c-/>", function() Snacks.terminal() end, desc = "terminal: toggle floating", mode = { "n", "t" } },
    { "<c-_>", function() Snacks.terminal() end, desc = "terminal: toggle floating (which-key)", mode = { "n", "t" } }, -- <c-/> sometimes shows as <c-_>
    -- explorer
    { "<leader>e", function() Snacks.explorer() end, desc = "explorer: file tree" },
    --stylua: ignore end
  },
}
