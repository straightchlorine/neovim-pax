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

      map("n", "]h", gs.next_hunk, "next hunk")
      map("n", "[h", gs.prev_hunk, "prev hunk")
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "select hunk")
      map("n", "<leader>gh", gs.preview_hunk, "preview hunk")
      map("n", "<leader>hs", gs.stage_hunk, "stage hunk")
      map("n", "<leader>hu", gs.undo_stage_hunk, "undo stage hunk")
      map("n", "<leader>gr", gs.reset_hunk, "reset hunk")
      map("n", "<leader>gS", function()
        local file = vim.api.nvim_buf_get_name(bufnr)
        if file == "" then return end
        local result = vim.fn.system({ "git", "ls-files", "--error-unmatch", file })
        if vim.v.shell_error ~= 0 then
          vim.fn.system({ "git", "add", file })
          vim.notify("Added untracked file to index", vim.log.levels.INFO)
        else
          gs.stage_buffer()
        end
      end, "stage buffer")
      map("n", "<leader>gR", gs.reset_buffer, "reset buffer")

      map("v", "<leader>gs", function()
        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "stage selected hunk")
      map("v", "<leader>gr", function()
        gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "reset selected hunk")

      map("n", "<leader>gb", function()
        gs.blame_line({ full = true })
      end, "blame line")
      map("n", "<leader>gB", gs.toggle_current_line_blame, "toggle blame")
      map("n", "<leader>gv", gs.diffthis, "view diff")
      map("n", "<leader>gV", function()
        gs.diffthis("~")
      end, "view diff against parent")
      map("n", "<leader>gt", gs.toggle_deleted, "toggle deleted")
    end,
  },
}
