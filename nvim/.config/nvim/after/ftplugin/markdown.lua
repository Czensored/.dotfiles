vim.opt_local.textwidth = 80
vim.opt_local.formatexpr = ""
vim.opt_local.formatoptions:append("a")

vim.keymap.set("n", "<leader>uw", function()
  if vim.opt_local.textwidth:get() == 80 then
    vim.opt_local.textwidth = 0
    vim.notify("Markdown wrap width disabled", vim.log.levels.INFO)
  else
    vim.opt_local.textwidth = 80
    vim.notify("Markdown wrap width set to 80", vim.log.levels.INFO)
  end
end, { buffer = true, desc = "Toggle Markdown textwidth" })
