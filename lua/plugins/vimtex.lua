-- vimtex
-- https://github.com/lervag/vimtex

return {
  "lervag/vimtex",
  lazy = false,
  init = function()
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_view_general_viewer = "zathura"

    vim.g.vimtex_complete_enabled = 1
    vim.g.vimtex_complete_bib = "simple" -- Fixed typo: comlete → complete

    vim.g.vimtex_quickfix_mode = 1
    vim.g.vimtex_quickfix_open_on_warning = 0

    vim.g.vimtex_toc_config = {
      mode = 1,
      fold_enable = 1,
      hide_line_numbers = 1,
    }

    vim.g.vimtex_compiler_latexmk = {
      build_dir = "",
      callback = 1,
      continuous = 1,
      executable = "latexmk",
      hooks = {},
      options = {
        "--shell-escape",
        "-verbose",
        "-file-line-error",
        "-synctex=1",
        "-interaction=nonstopmode",
        "-lualatex",
      },
    }

    vim.cmd([[
      let g:vimtex_syntax_conceal = {
        \ 'accents': 1,
        \ 'ligatures': 1,
        \ 'cites': 1,
        \ 'fancy': 1,
        \ 'spacing': 1,
        \ 'greek': 1,
        \ 'math_bounds': 1,
        \ 'math_delimiters': 1,
        \ 'math_fracs': 1,
        \ 'math_super_sub': 1,
        \ 'math_symbols': 1,
        \ 'sections': 1,
        \ 'styles': 1,
        \}
    ]])

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "tex" },
      callback = function()
        vim.keymap.set("n", "<leader>ll", "<cmd>VimtexCompile<cr>", { desc = "VimTeX: Compile" })
        vim.keymap.set("n", "<leader>lv", "<cmd>VimtexView<cr>", { desc = "VimTeX: View PDF" })
        vim.keymap.set("n", "<leader>lc", "<cmd>VimtexClean<cr>", { desc = "VimTeX: Clean" })
        vim.keymap.set("n", "<leader>lt", "<cmd>VimtexTocToggle<cr>", { desc = "VimTeX: Toggle TOC" })
      end,
    })
  end,
}
