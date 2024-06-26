--- options.lua - Contains all the options. --

---
-- General options
---

vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

vim.g.python3_host_prog  = '/usr/bin/python'
vim.g.mapleader          = ' '

vim.o.termguicolors      = true
vim.o.redrawtime         = 1500

vim.o.backup             = false
vim.o.writebackup        = false
vim.o.swapfile           = false
vim.o.updatetime         = 100

vim.o.shada              = "!,'300,<50,@100,s10,h"

vim.o.confirm            = true

vim.o.switchbuf          = 'useopen'

vim.o.clipboard          = 'unnamedplus'

vim.o.undodir            = os.getenv('HOME') .. '/.local/share/nvim/undo_history'
vim.o.undofile           = true

vim.o.virtualedit        = 'block'

vim.o.autoread           = true
vim.o.autowrite          = true
vim.o.diffopt            = 'filler,iwhite,internal,algorithm:patience'

vim.o.display            = 'lastline'
vim.o.laststatus         = 3

vim.o.equalalways        = true
vim.o.viewoptions        = 'folds,cursor,curdir'
vim.o.sessionoptions     = 'curdir,folds,help,tabpages,winsize'

vim.o.showcmd            = true
vim.o.history            = 1000
vim.o.cmdwinheight       = 5
vim.o.cmdheight          = 2

vim.o.winwidth           = 35
vim.o.winminwidth        = 20

vim.o.pumheight          = 10
vim.o.helpheight         = 12
vim.o.previewheight      = 12

vim.o.syntax             = 'ON'
vim.o.magic              = true
vim.o.hidden             = true
vim.o.wildmenu           = true
vim.o.completeopt        = 'menu,noselect,preview'
vim.o.complete           = '.,w,b,k'

vim.o.errorbells         = true
vim.o.visualbell         = true


vim.o.autoindent         = true
vim.o.shiftround         = true
vim.o.expandtab          = true
vim.o.smartcase          = true
vim.o.infercase          = true
vim.o.smarttab           = true
vim.o.showtabline        = 2

vim.o.shiftwidth         = 2
vim.o.tabstop            = 2

vim.o.ttimeout           = true

vim.o.incsearch          = true
vim.o.inccommand         = 'nosplit'
vim.o.synmaxcol          = 0

vim.o.grepformat         = '%f:%l:%c:%m'
vim.o.grepprg            = 'rg --hidden --vimgrep --smart-case --'

vim.o.splitright         = true
vim.o.splitbelow         = true

vim.o.wrap               = true
vim.o.wrapscan           = true
vim.o.whichwrap          = 'h,l,<,>,[,],~'

vim.o.startofline        = false
vim.o.relativenumber     = true
vim.o.number             = true
vim.o.signcolumn         = 'yes'

vim.o.cursorline         = true
vim.o.cursorcolumn       = true
vim.o.ruler              = true

vim.o.scrolloff          = 5
vim.o.mousescroll        = 'ver:4,hor:6'

vim.o.conceallevel       = 1
vim.o.concealcursor      = 'niv'

vim.o.shortmess          = 'filmwaxstA'

vim.o.linebreak          = true
vim.o.breakat            = [[\ \	;:,!?]]

vim.opt.wildignore:append { '*.pyc', 'node_modules','.git' }
vim.opt.formatoptions:append { 'tcraj' }

---
-- Plugin related options
---

vim.g.matchup_matchparen_offset = { method = 'popup' }

vim.o.list                       = true
vim.opt.listchars:append 'space:⋅'
vim.opt.listchars:append 'eol:↴'

vim.o.foldcolumn                 = '1'
vim.o.foldlevel                  = 99
vim.o.foldlevelstart             = 99
vim.o.foldenable                 = true

vim.o.timeout                    = true
vim.o.timeoutlen                 = 300

vim.g.vimtex_view_general_viewer = 'zathura'
vim.g.vimtex_complete_enabled    = 1
vim.g.vimtex_comlete_bib         = 'simple'

vim.cmd([[
  let g:vimtex_compiler_latexmk = {
      \ 'build_dir' : '',
      \ 'callback' : 1,
      \ 'continuous' : 1,
      \ 'executable' : 'latexmk',
      \ 'hooks' : [],
      \ 'options' : [
      \   '-shell-escape',
      \   '-verbose',
      \   '-file-line-error',
      \   '-synctex=1',
      \   '-interaction=nonstopmode',
      \ ],
      \}
]])

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
          \ 'sections': 0,
          \ 'styles': 1,
          \}
]])
