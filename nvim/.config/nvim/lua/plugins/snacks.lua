return {
  "folke/snacks.nvim",
  keys = {
    -- Use Diffview for full branch reviews instead of the Snacks diff picker
    { "<leader>gD", false },

    -- Open LazyGit
    {
      "<leader>gg",
      function()
        Snacks.lazygit()
      end,
      desc = "Open LazyGit",
    },

    -- List git branches with Snacks picker to quickly switch to a new branch
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
          sort_lastused = true,
        })
      end,
      desc = "Find Files",
    },
  },

  opts = {
    -- LazyGit integration
    lazygit = {
      configure = true,

      -- Make LazyGit take up almost the whole Neovim window
      win = {
        width = 0,
        height = 0,
      },

      -- Make pressing `e` in LazyGit open files in the current Neovim instance
      config = {
        os = {
          editPreset = "nvim-remote",
        },
      },
    },

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
