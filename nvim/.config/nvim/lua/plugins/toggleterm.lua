return {
  "akinsho/toggleterm.nvim",
  opts = {
    direction = "horizontal",
    size = 25,
    open_mapping = [[<C-t>]],
    start_in_insert = true,
    insert_mappings = false,
    terminal_mappings = true,

    on_open = function(term)
      vim.defer_fn(function()
        vim.cmd("startinsert")
      end, 20)
    end,
  },
}
