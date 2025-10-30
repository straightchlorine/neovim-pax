-- fzf-lua
-- https://github.com/ibhagwan/fzf-lua

return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("fzf-lua").setup({
      "default-title",
      fzf_opts = {
        -- options are sent as `<left>=<right>`
        -- set to `false` to remove a flag
        ["--ansi"] = "",
        ["--info"] = "inline",
        ["--height"] = "100%",
        ["--layout"] = "reverse",
        ["--border"] = "none",
      },
      fzf_colors = {
        ["fg"] = { "fg", "CursorLine" },
        ["bg"] = { "bg", "Normal" },
        ["hl"] = { "fg", "Comment" },
        ["fg+"] = { "fg", "Normal" },
        ["bg+"] = { "bg", "CursorLine" },
        ["hl+"] = { "fg", "Statement" },
        ["info"] = { "fg", "PreProc" },
        ["prompt"] = { "fg", "Conditional" },
        ["pointer"] = { "fg", "Exception" },
        ["marker"] = { "fg", "Keyword" },
        ["spinner"] = { "fg", "Label" },
        ["header"] = { "fg", "Comment" },
        ["gutter"] = { "bg", "Normal" },
      },
      keymap = {
        -- These override the default tables completely
        -- no need to set to `false` to disable a bind
        -- to "unbind" a default key set it to `false`
        builtin = {
          -- neovim `:tmap` mappings for the fzf win
          ["<F1>"] = "toggle-help",
          ["<F2>"] = "toggle-fullscreen",
          -- Only valid with the 'builtin' previewer
          ["<F3>"] = "toggle-preview-wrap",
          ["<F4>"] = "toggle-preview",
          -- Rotate preview clockwise/counter-clockwise
          ["<F5>"] = "toggle-preview-ccw",
          ["<F6>"] = "toggle-preview-cw",
          ["<S-down>"] = "preview-page-down",
          ["<S-up>"] = "preview-page-up",
          ["<S-left>"] = "preview-page-reset",
        },
        fzf = {
          -- fzf '--bind=' options
          ["ctrl-z"] = "abort",
          ["ctrl-u"] = "unix-line-discard",
          ["ctrl-f"] = "half-page-down",
          ["ctrl-b"] = "half-page-up",
          ["ctrl-a"] = "beginning-of-line",
          ["ctrl-e"] = "end-of-line",
          ["alt-a"] = "toggle-all",
          -- Unified navigation controls (same as Telescope)
          ["ctrl-n"] = "down",
          ["ctrl-p"] = "up",
          -- Only valid with fzf previewers (bat/cat/git/etc)
          ["f3"] = "toggle-preview-wrap",
          ["f4"] = "toggle-preview",
          ["shift-down"] = "preview-page-down",
          ["shift-up"] = "preview-page-up",
        },
      },
      previewers = {
        cat = {
          cmd = "cat",
          args = "--number",
        },
        bat = {
          cmd = "bat",
          args = "--style=numbers,changes --color always",
          theme = "Coldark-Dark", -- bat preview theme (bat --list-themes)
          config = nil, -- nil uses $BAT_CONFIG_PATH
        },
        head = {
          cmd = "head",
          args = nil,
        },
        git_diff = {
          -- if git-delta exists, use `delta` as previewer, fallback to `diff`
          cmd_deleted = "git show",
          cmd_modified = "git diff",
          cmd_untracked = "git diff --no-index /dev/null",
          -- uncomment if you wish to use git-delta as pager
          -- can also be set under 'git.status.preview_pager'
          -- pager        = "delta --width=$FZF_PREVIEW_COLUMNS",
        },
        man = {
          -- NOTE: remove the `-c` flag when using man-db
          -- replace with `man -P cat %s | col -bx` on OSX
          cmd = "man -c %s | col -bx",
        },
        builtin = {
          syntax = true, -- preview syntax highlight?
          syntax_limit_l = 0, -- syntax limit (lines), 0=nolimit
          syntax_limit_b = 1024 * 1024, -- syntax limit (bytes), 0=nolimit
          limit_b = 1024 * 1024 * 10, -- preview limit (bytes), 0=nolimit
          -- previewer treesitter options:
          -- enable syntax highlighting with treesitter
          treesitter = { enable = true, disable = {} },
        },
      },
      -- provider setup
      files = {
        -- previewer      = "bat",          -- uncomment to override previewer
        prompt = "Files❯ ",
        multiprocess = true, -- run command in a separate process
        git_icons = true, -- show git icons?
        file_icons = true, -- show file icons?
        color_icons = true, -- colorize file|git icons
        -- path_shorten   = 1,              -- 'true' or number, shorten path?
        -- executed command priority is 'cmd' (if exists)
        -- otherwise auto-detect prioritizes `fd`:`rg`:`find`
        -- default options are controlled by 'fd|rg|find|_opts'
        -- NOTE: 'find -printf' requires GNU find
        -- cmd            = "find . -type f -printf '%P\n'",
        find_opts = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
        rg_opts = "--color=never --files --hidden --follow -g '!.git'",
        fd_opts = "--color=never --type f --hidden --follow --exclude .git",
        -- by default, cwd appears in the header only if {opts} contain a cwd
        -- parameter to a different folder than the current working directory
        -- uncomment if you wish to force display of the cwd as part of the
        -- query prompt string (fzf.vim style), header line or both
        -- cwd_header = true,
        cwd_prompt = true,
        cwd_prompt_shorten_len = 32, -- shorten prompt beyond this length
        cwd_prompt_shorten_val = 1, -- shortened path parts length
      },
      git = {
        files = {
          prompt = "GitFiles❯ ",
          cmd = "git ls-files --exclude-standard",
          multiprocess = true, -- run command in a separate process
          git_icons = true, -- show git icons?
          file_icons = true, -- show file icons?
          color_icons = true, -- colorize file|git icons
        },
        status = {
          prompt = "GitStatus❯ ",
          preview_pager = "delta --width=$FZF_PREVIEW_COLUMNS",
        },
        commits = {
          prompt = "Commits❯ ",
          preview = "git show --pretty='%Cred%H%n%Cblue%an <%ae>%n%C(yellow)%cD%n%Cgreen%s' --color=always {1}",
        },
        bcommits = {
          prompt = "BCommits❯ ",
          preview = "git show --pretty='%Cred%H%n%Cblue%an <%ae>%n%C(yellow)%cD%n%Cgreen%s' --color=always {1}",
        },
        branches = {
          prompt = "Branches❯ ",
          preview = "git log --graph --pretty=oneline --abbrev-commit --color {1}",
        },
      },
      grep = {
        prompt = "Rg❯ ",
        input_prompt = "Grep For❯ ",
        multiprocess = true, -- run command in a separate process
        git_icons = true, -- show git icons?
        file_icons = true, -- show file icons?
        color_icons = true, -- colorize file|git icons
        -- executed command priority is 'cmd' (if exists)
        -- otherwise auto-detect prioritizes `rg` over `grep`
        -- default options are controlled by 'rg|grep_opts'
        -- cmd            = "rg --vimgrep",
        rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
        grep_opts = "--binary-files=without-match --line-number --recursive --color=auto --perl-regexp -e",
        -- set to 'true' to always parse globs in both 'grep' and 'live_grep'
        -- search strings will be split using the 'glob_separator' and translated
        -- to '--iglob=' arguments, requires 'rg'
        -- can still be used when 'false' by calling 'live_grep_glob' directly
        glob_flag = "--iglob", -- for case sensitive globs use '--glob'
        glob_separator = "%s%-%-", -- query separator pattern (lua): ' --'
        -- advanced usage: for custom argument parsing define
        -- 'rg_glob_fn' to return a pair (opts, query)
        -- rg_glob_fn = function(query, opts)
        --   ...
        --   return opts, query
        -- end,
      },
      args = {
        prompt = "Args❯ ",
        files_only = true,
        -- actions inherit from 'files' and merge
        actions = { ["ctrl-x"] = { fn = require("fzf-lua.actions").arg_del, reload = true } },
      },
      oldfiles = {
        prompt = "History❯ ",
        cwd_only = false,
        stat_file = true, -- verify files exist on disk
        include_current_session = false, -- include bufs from current session
      },
      buffers = {
        prompt = "Buffers❯ ",
        file_icons = true, -- show file icons?
        color_icons = true, -- colorize file|git icons
        sort_lastused = true, -- sort buffers() by last used
        show_unloaded = true, -- show unloaded buffers
        cwd_only = false, -- buffers for the cwd only
        cwd = nil, -- buffers list for a specific dir
        actions = {
          -- actions inherit from 'files' and merge
          -- these override the default file actions
          ["default"] = require("fzf-lua.actions").buf_edit,
          ["ctrl-s"] = require("fzf-lua.actions").buf_split,
          ["ctrl-v"] = require("fzf-lua.actions").buf_vsplit,
          ["ctrl-t"] = require("fzf-lua.actions").buf_tabedit,
        },
      },
    })

    -- Keymaps for fzf-lua (complementing telescope, not replacing)
    local keymap = vim.keymap
    keymap.set("n", "<leader>Fz", "<cmd>FzfLua<cr>", { desc = "fzf-lua: fzf builtin" })
    keymap.set("n", "<leader>sz", "<cmd>FzfLua live_grep<cr>", { desc = "fzf-lua: live grep" })
    keymap.set("n", "<leader>Bf", "<cmd>FzfLua buffers<cr>", { desc = "fzf-lua: buffers" })
    keymap.set("n", "<leader>Gz", "<cmd>FzfLua git_files<cr>", { desc = "fzf-lua: git files" })
    keymap.set("n", "<leader>Fh", "<cmd>FzfLua help_tags<cr>", { desc = "fzf-lua: help tags" })
    keymap.set("n", "<leader>sk", "<cmd>FzfLua keymaps<cr>", { desc = "fzf-lua: keymaps" })
  end,
}