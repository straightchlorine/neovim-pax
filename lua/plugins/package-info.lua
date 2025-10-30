-- package-info.nvim
-- https://github.com/vuki656/package-info.nvim

return {
  "vuki656/package-info.nvim",
  dependencies = "MunifTanjim/nui.nvim",
  opts = {},
  config = function(_, opts)
    require("package-info").setup(opts)

    -- Show dependency versions
    vim.keymap.set({ "n" }, "<leader>ps", require("package-info").show, { desc = "package-info: show dependency versions" })

    -- Hide dependency versions
    vim.keymap.set({ "n" }, "<leader>ph", require("package-info").hide, { desc = "package-info: hide dependency versions" })

    -- Toggle dependency versions
    vim.keymap.set({ "n" }, "<leader>pt", require("package-info").toggle, { desc = "package-info: toggle dependency versions" })

    -- Update dependency on the line
    vim.keymap.set({ "n" }, "<leader>pu", require("package-info").update, { desc = "package-info: update dependency" })

    -- Delete dependency on the line
    vim.keymap.set({ "n" }, "<leader>pd", require("package-info").delete, { desc = "package-info: delete dependency" })

    -- Install a new dependency
    vim.keymap.set({ "n" }, "<leader>pi", require("package-info").install, { desc = "package-info: install dependency" })

    -- Install a different dependency version
    vim.keymap.set({ "n" }, "<leader>pv", require("package-info").change_version, { desc = "package-info: change dependency version" })
  end,
}