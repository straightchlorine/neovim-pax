-- lualine.nvim
-- https://github.com/nvim-lualine/lualine.nvim

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "folke/trouble.nvim",
  },
  config = function()
    local lualine = require("lualine")
    local trouble = require("trouble")

    local symbols = trouble.statusline({
      mode = "lsp_document_symbols",
      groups = {},
      title = false,
      filter = { range = true },
      format = " {kind_icon} {symbol.name:Normal}",
      hl_group = "lualine_c_normal",
    })

    -- get the lsp clients active in the current buffer
    local function lsp_status()
      local clients = vim.lsp.get_clients()
      if next(clients) == nil then
        return "No LSP"
      end
      local client_names = {}
      for _, client in ipairs(clients) do
        table.insert(client_names, client.name)
      end
      return " " .. table.concat(client_names, ", ")
    end

    lualine.setup({
      options = {
        theme = "auto",
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
        disabled_filetypes = { statusline = { "dashboard", "alpha" } },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          { "filename", path = 1 },
          { symbols.get, cond = symbols.has },
        },
        lualine_x = { lsp_status, "encoding", "fileformat", "filetype", "filesize" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {
        lualine_a = { { "buffers", mode = 2 } },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "tabs" },
      },
      extensions = { "nvim-tree", "fugitive", "trouble" },
    })
  end,
}
