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
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = bufnr, desc = "git: " .. desc })
      end

      -- navigate between hunks
      map("n", "]h", gs.next_hunk, "next hunk")
      map("n", "[h", gs.prev_hunk, "prev hunk")

      -- hunk actions
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "select hunk")

      map("n", "<leader>gh", gs.preview_hunk, "preview hunk")
      map("n", "<leader>gs", gs.stage_hunk, "stage hunk")
      map("n", "<leader>gu", gs.undo_stage_hunk, "undo stage hunk")
      map("n", "<leader>gr", gs.reset_hunk, "reset hunk")

      -- buffer actions
      map("n", "<leader>gS", gs.stage_buffer, "stage buffer")
      map("n", "<leader>gR", gs.reset_buffer, "reset buffer")

      -- visual mode hunk actions
      map("v", "<leader>gs", function()
        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "stage selected hunk")
      map("v", "<leader>gr", function()
        gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "reset selected hunk")

      -- git blame
      map("n", "<leader>gb", function()
        gs.blame_line({ full = true })
      end, "blame line")
      map("n", "<leader>gB", gs.toggle_current_line_blame, "toggle blame")

      -- git diff
      map("n", "<leader>gv", gs.diffthis, "view diff")
      map("n", "<leader>gV", function()
        gs.diffthis("~")
      end, "view diff against parent")

      map("n", "<leader>gt", gs.toggle_deleted, "toggle deleted")
    end,
  },
}
