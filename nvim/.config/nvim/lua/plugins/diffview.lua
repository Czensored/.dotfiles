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
    opts = {},
  },
}
