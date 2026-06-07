-- gitsigns.nvim
-- https://github.com/lewis6991/gitsigns.nvim

return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add = { text = "│" },
      change = { text = "│" },
      delete = { text = "│" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
    },
    watch_gitdir = {
      follow_files = true,
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = bufnr, desc = "git: " .. desc })
      end

      -- hunk navigation
      map("n", "]h", gs.next_hunk, "next hunk")
      map("n", "[h", gs.prev_hunk, "prev hunk")
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "select hunk")

      -- hunk actions (all under <leader>h)
      map("n", "<leader>hp", gs.preview_hunk, "preview hunk")
      map("n", "<leader>hs", gs.stage_hunk, "stage hunk")
      map("n", "<leader>hu", gs.undo_stage_hunk, "undo stage hunk")
      map("n", "<leader>hr", gs.reset_hunk, "reset hunk")
      map("v", "<leader>hs", function()
        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "stage selection")
      map("v", "<leader>hr", function()
        gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "reset selection")

      -- buffer actions
      map("n", "<leader>hS", function()
        local file = vim.api.nvim_buf_get_name(bufnr)
        if file == "" then return end
        vim.fn.system({ "git", "ls-files", "--error-unmatch", file })
        if vim.v.shell_error ~= 0 then
          vim.fn.system({ "git", "add", file })
          vim.notify("Added untracked file to index", vim.log.levels.INFO)
        else
          gs.stage_buffer()
        end
      end, "stage buffer")
      map("n", "<leader>hR", gs.reset_buffer, "reset buffer")

      -- blame
      map("n", "<leader>hb", function()
        gs.blame_line({ full = true })
      end, "blame line")
      map("n", "<leader>hB", gs.toggle_current_line_blame, "toggle line blame")

      -- per-file diff (editable, live-updating native diff split)
      map("n", "<leader>hd", gs.diffthis, "diff this file")
      map("n", "<leader>hD", function()
        gs.diffthis("~")
      end, "diff this file (vs parent)")
      map("n", "<leader>ht", gs.toggle_deleted, "toggle deleted")
    end,
  },
}
