local markdown_foldexpr = "v:lua.vim.treesitter.foldexpr()"

local function set_markdown_folds()
  vim.wo.foldmethod = "expr"
  vim.wo.foldexpr = markdown_foldexpr
  vim.wo.foldenable = true
  vim.wo.foldlevel = 99
end

-- local function repair_markdown_foldexpr()
--   local repaired = false
--
--   if vim.wo.foldmethod ~= "expr" then
--     vim.wo.foldmethod = "expr"
--     repaired = true
--   end
--
--   if vim.wo.foldexpr ~= markdown_foldexpr then
--     vim.wo.foldexpr = markdown_foldexpr
--     repaired = true
--   end
--
--   if not vim.wo.foldenable then
--     vim.wo.foldenable = true
--   end
-- end

set_markdown_folds()

-- vim.api.nvim_create_autocmd({ "BufWinEnter", "WinEnter" }, {
--   buffer = 0,
--   callback = repair_markdown_foldexpr,
--   desc = "Keep Markdown folds on Tree-sitter foldexpr",
-- })
