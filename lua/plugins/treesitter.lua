-- nvim-treesitter (main branch, Neovim 0.12+)
-- https://github.com/nvim-treesitter/nvim-treesitter/tree/main
--
-- Archived; left for parser installation + structural highlighting.

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    local ts = require("nvim-treesitter")

    -- Arduino .ino files are C++
    vim.treesitter.language.register("cpp", "arduino")

    local ensure_installed = {
      "bash",
      "c",
      "cpp",
      "c_sharp",
      "css",
      "dockerfile",
      "gitcommit",
      "gitignore",
      "go",
      "html",
      "java",
      "javascript",
      "json",
      "latex",
      "lua",
      "luadoc",
      "markdown",
      "markdown_inline",
      "python",
      "regex",
      "rust",
      "sql",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "vue",
      "yaml",
    }

    local installed = ts.get_installed("parsers")
    local missing = vim.tbl_filter(function(p)
      return not vim.tbl_contains(installed, p)
    end, ensure_installed)
    if #missing > 0 then
      ts.install(missing)
    end

    -- Core drives highlight + indent per buffer.
    -- For now nvim-ufo (ufo.lua) owns folding via its providers.
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(ev)
        local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
        if not lang or not pcall(vim.treesitter.start, ev.buf, lang) then
          return
        end
        vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })

    require("nvim-ts-autotag").setup()
  end,
}
