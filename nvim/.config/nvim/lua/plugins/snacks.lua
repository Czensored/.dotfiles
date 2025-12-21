return {
  "folke/snacks.nvim",
  keys = {
    -- -- List git branches with Snacks_picker to quickly switch to a new branch
    {
      "<M-b>",
      function()
        Snacks.picker.git_branches({
          layout = "select",
        })
      end,
      desc = "Branches",
    },
    -- File picker
    {
      "<leader><space>",
      function()
        Snacks.picker.buffers({
          show_empty = true,
          sort_lastused = true,
        })
      end,
      desc = "Buffers",
    },
  },
  opts = {
    explorer = {},
    picker = {
      hidden = true,
      matcher = {
        frecency = true,
      },
      sources = {
        explorer = {
          layout = { layout = { position = "right" } },
          auto_close = true,
        },
      },
    },
  },
}
