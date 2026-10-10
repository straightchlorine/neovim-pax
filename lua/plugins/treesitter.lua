-- nvim-treesitter (main branch, Neovim 0.12+)
-- https://github.com/nvim-treesitter/nvim-treesitter/tree/main
--
-- Parser installation, highlighting, indent and folding.

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    local ts = require("nvim-treesitter")

    -- Arduino .ino files are C++
    vim.treesitter.language.register("cpp", "arduino")
    vim.treesitter.language.register("ssh_config", "sshconfig")
    vim.treesitter.language.register("git_config", "gitconfig")
    vim.treesitter.language.register("ini", { "dosini", "confini" })

    local ensure_installed = {
      "bash",
      "c",
      "cpp",
      "c_sharp",
      "css",
      "diff",
      "dockerfile",
      "gitattributes",
      "gitcommit",
      "git_config",
      "gitignore",
      "ini",
      "ssh_config",
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

    -- Core drives highlight + indent + folding per buffer.
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(ev)
        local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
        if not lang or not pcall(vim.treesitter.start, ev.buf, lang) then
          return
        end
        vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        vim.wo[0][0].foldmethod = "expr"
        vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
      end,
    })
  end,
}
