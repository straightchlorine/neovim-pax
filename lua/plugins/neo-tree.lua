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
  commands = {
    avante_add_files = function(state)
      local node = state.tree:get_node()
      local filepath = node:get_id()
      local relative_path = require("avante.utils").relative_path(filepath)

      local sidebar = require("avante").get()

      local open = sidebar:is_open()
      if not open then
        require("avante.api").ask()
        sidebar = require("avante").get()
      end

      sidebar.file_selector:add_selected_file(relative_path)

      if not open then
        sidebar.file_selector:remove_selected_file("neo-tree filesystem [1]")
      end
    end,
  },
  window = {
    mappings = {
      ["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } },
      ["l"] = "focus_preview",
      ["<C-b>"] = { "scroll_preview", config = { direction = 10 } },
      ["<C-f>"] = { "scroll_preview", config = { direction = -10 } },
      ["oa"] = "avante_add_files",
    },
  },
  config = function()
    vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "neotree: toggle" })
  end,
}
