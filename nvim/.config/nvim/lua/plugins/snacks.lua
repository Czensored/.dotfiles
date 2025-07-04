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
        Snacks.picker.files({
          finder = "files",
          format = "file",
          show_empty = true,
          supports_live = true,
          hidden = true,
          ignored = false,
        })
      end,
      desc = "Find Files",
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
          auto_close = true,
        },
      },
    },
  },
}
