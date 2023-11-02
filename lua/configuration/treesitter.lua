--- treesitter.lua
-- Configuration for nvim-treesitter plugin.

require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    'c',
    'cpp',
    'cmake',
    'lua',
    'bash',
    'bibtex',
    'css',
    'diff',
    'comment',
    'dockerfile',
    'git_config',
    'git_rebase',
    'groovy',
    'html',
    'json',
    'xml',
    'yaml',
    'java',
    'kotlin',
    'latex',
    'lua',
    'luadoc',
    'luap',
    'markdown_inline',
    'ninja',
    'python',
    'r',
    'rust',
    'ruby',
    'toml',
    'verilog',
    'vim',
    'vimdoc'
  },

  sync_install = false,
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
