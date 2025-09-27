return {
  "Wansmer/treesj",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    use_default_keymaps = false,
  },
  keys = {
    { "gS", function() require("treesj").toggle() end, desc = "Split/Join toggle", silent = true },
    { "gJ", function() require("treesj").toggle({ split = false }) end, desc = "Join", silent = true },
  },
}
