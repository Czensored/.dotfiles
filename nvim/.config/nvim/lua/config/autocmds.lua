-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
-- Auto-save current buffer on various "focus lost" events
-- Auto-save on FocusLost, BufLeave, or TermOpen
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave", "TermOpen", "VimLeavePre" }, {
  pattern = "*",
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    if vim.bo[buf].modifiable and vim.bo[buf].modified and vim.bo[buf].buftype == "" then
      vim.cmd("silent! write")
    end
  end,
  desc = "Auto-save current buffer on focus loss, buffer switch, terminal open, or exiting Neovim",
})

