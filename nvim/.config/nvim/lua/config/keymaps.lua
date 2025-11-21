-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- vim.keymap.set("i", "jj", "<Esc>", { desc = "Escape insert mode", noremap = false, silent = true })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })

vim.keymap.set("n", "cx", ":!chmod +x %<cr>", { desc = "make file excecutable" })

-- Map Option+Delete in insert mode to delete previous word
vim.keymap.set("i", "<A-BS>", "<C-w>", { desc = "Delete previous word" })

-- Copy absolute path
vim.keymap.set("n", "<leader>cpf", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify("Copied absolute path:\n" .. path, vim.log.levels.INFO)
end, { desc = "Copy full (absolute) file path" })

-- Copy relative path (to current working directory)
vim.keymap.set("n", "<leader>cpr", function()
  local path = vim.fn.expand("%:.")
  vim.fn.setreg("+", path)
  vim.notify("Copied relative path:\n" .. path, vim.log.levels.INFO)
end, { desc = "Copy relative file path" })

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
  if vim.fn.spellbadword()[1] == "" then
    vim.cmd.normal({ "[s", bang = true })
  end
  if vim.fn.spellbadword()[1] ~= "" then
    vim.cmd.normal({ "1z=", bang = true }) -- accept first suggestion
  elseif vim.notify then
    vim.notify("No misspellings found", vim.log.levels.INFO)
  end
  vim.cmd.stopinsert()
end, { desc = "Fix current misspelling or jump to previous and fix", silent = true })

-- Notify word count
vim.keymap.set({ "n", "v" }, "<leader>wc", function()
  local wc = vim.fn.wordcount()
  local words = wc.visual_words or wc.words or 0
  local scope = wc.visual_words and " (selection)" or ""
  local msg = string.format("Word count%s: %d", scope, words)

  vim.notify(msg, vim.log.levels.INFO, { title = "Word Count" })
end, { desc = "Show word count", silent = true })
