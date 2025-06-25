-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- vim.keymap.set("i", "jj", "<Esc>", { desc = "Escape insert mode", noremap = false, silent = true })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })

local harpoon = require("harpoon")

vim.keymap.set("n", "<leader>a", function()
  harpoon:list():add()
end, { desc = "Add to Harpoon" })

vim.keymap.set("n", "<leader>h", function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, { desc = "Harpoon Menu" })

-- Select files <leader>1 to <leader>4
for i = 1, 4 do
  vim.keymap.set("n", "<leader>" .. i, function()
    harpoon:list():select(i)
  end, { desc = "Harpoon to file " .. i })

  -- Remove file at index i
  vim.keymap.set("n", "<leader>r" .. i, function()
    harpoon:list():remove_at(i)
  end, { desc = "Remove Harpoon file " .. i })
end

-- Clear all Harpoon entries
vim.keymap.set("n", "<leader>rc", function()
  harpoon:list():clear()
end, { desc = "Clear all Harpoon entries" })
