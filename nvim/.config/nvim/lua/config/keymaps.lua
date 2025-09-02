-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- vim.keymap.set("i", "jj", "<Esc>", { desc = "Escape insert mode", noremap = false, silent = true })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })

local harpoon = require("harpoon")

vim.keymap.set("n", "<leader>ha", function()
  harpoon:list():add()
end, { desc = "Add to Harpoon" })

vim.keymap.set("n", "<leader>hh", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon Menu" })

-- Select files <leader>1 to <leader>4
for i = 1, 4 do
  vim.keymap.set("n", "<leader>" .. i, function()
    harpoon:list():select(i)
  end, { desc = "Harpoon to file " .. i })

  -- Remove file at index i
  vim.keymap.set("n", "<leader>hr" .. i, function()
    harpoon:list():remove_at(i)
  end, { desc = "Remove Harpoon file " .. i })
end

vim.keymap.set("n", "<leader>hc", function()
  harpoon:list():clear()
end, { desc = "Clear all Harpoon entries" })

vim.keymap.set({ "n", "i" }, "<C-j>", function()
  local back = (vim.fn.mode() == "i")
  if vim.fn.spellbadword()[1] == "" then
    vim.cmd.normal({ "]s", bang = true }) -- jump to next misspelling
  end
  if vim.fn.spellbadword()[1] ~= "" then
    vim.cmd.normal({ "1z=", bang = true }) -- accept first suggestion
  elseif vim.notify then
    vim.notify("No misspellings found", vim.log.levels.INFO)
  end
  if back then
    vim.cmd.startinsert()
  end
end, { desc = "Fix current misspelling or jump to next and fix", silent = true })
