local function select_next_file_no_wrap()
  local view = require("diffview.lib").get_current_view()

  -- File-history views have a different panel model, so retain their default action.
  if not view or not view.panel or type(view.panel.ordered_file_list) ~= "function" then
    require("diffview.actions").select_next_entry()
    return
  end

  local files = view.panel:ordered_file_list()
  local current = view.panel.cur_file
  local current_index = 0

  for index, file in ipairs(files) do
    if file == current then
      current_index = index
      break
    end
  end

  local next_index = math.min(current_index + vim.v.count1, #files)
  if next_index > current_index then
    view:set_file(files[next_index], false, true)
  end
end

local function select_prev_file_no_wrap()
  local view = require("diffview.lib").get_current_view()

  -- File-history views have a different panel model, so retain their default action.
  if not view or not view.panel or type(view.panel.ordered_file_list) ~= "function" then
    require("diffview.actions").select_prev_entry()
    return
  end

  local files = view.panel:ordered_file_list()
  local current = view.panel.cur_file
  local current_index = #files + 1

  for index, file in ipairs(files) do
    if file == current then
      current_index = index
      break
    end
  end

  local prev_index = math.max(current_index - vim.v.count1, 1)
  if prev_index < current_index then
    view:set_file(files[prev_index], false, true)
  end
end

return {
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
      "DiffviewFileHistory",
    },
    keys = {
      {
        "<leader>gD",
        "<cmd>DiffviewOpen origin/HEAD...HEAD<cr>",
        desc = "Git Diff (branch review)",
      },
      {
        "<leader>gH",
        "<cmd>DiffviewFileHistory %<cr>",
        desc = "Git History (current file)",
      },
      {
        "<leader>gq",
        "<cmd>DiffviewClose<cr>",
        desc = "Close Diffview",
      },
    },
    opts = {
      keymaps = {
        view = {
          { "n", "<tab>", select_next_file_no_wrap, { desc = "Open the next file without wrapping" } },
          { "n", "<s-tab>", select_prev_file_no_wrap, { desc = "Open the previous file without wrapping" } },
        },
        file_panel = {
          { "n", "<tab>", select_next_file_no_wrap, { desc = "Open the next file without wrapping" } },
          { "n", "<s-tab>", select_prev_file_no_wrap, { desc = "Open the previous file without wrapping" } },
        },
      },
    },
  },
}
