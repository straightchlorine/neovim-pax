-- neo-tree.nvim
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  opts = function(_, opts)
    local function on_move(data)
      Snacks.rename.on_rename_file(data.source, data.destination)
    end
    local events = require("neo-tree.events")
    opts.event_handlers = opts.event_handlers or {}
    vim.list_extend(opts.event_handlers, {
      { event = events.FILE_MOVED, handler = on_move },
      { event = events.FILE_RENAMED, handler = on_move },
    })
  end,
  window = {
    mappings = {
      ["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } },
      ["l"] = "focus_preview",
      ["<C-b>"] = { "scroll_preview", config = { direction = 10 } },
      ["<C-f>"] = { "scroll_preview", config = { direction = -10 } },
    },
  },
  config = function()
    vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "neotree: toggle" })
  end,
}
