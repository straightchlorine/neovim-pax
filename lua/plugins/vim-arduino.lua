-- vim-arduino
-- https://github.com/stevearc/vim-arduino

return {
  "stevearc/vim-arduino",
  ft = "arduino",
  config = function()
    local function attach(buf)
      local function map(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { buffer = buf, desc = desc })
      end
      map("<leader>aa", "<cmd>ArduinoAttach<CR>", "arduino: attach")
      map("<leader>av", "<cmd>ArduinoVerify<CR>", "arduino: verify")
      map("<leader>au", "<cmd>ArduinoUpload<CR>", "arduino: upload")
      map("<leader>aS", "<cmd>ArduinoUploadAndSerial<CR>", "arduino: upload and serial")
      map("<leader>as", "<cmd>ArduinoSerial<CR>", "arduino: serial")
      map("<leader>ab", "<cmd>ArduinoChooseBoard<CR>", "arduino: board")
      map("<leader>ap", "<cmd>ArduinoChooseProgrammer<CR>", "arduino: programmer")
    end

    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("ArduinoMaps", { clear = true }),
      pattern = "arduino",
      callback = function(ev)
        attach(ev.buf)
      end,
    })
    if vim.bo.filetype == "arduino" then
      attach(0)
    end
  end,
}
