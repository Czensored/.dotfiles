return {
  {
    "R-nvim/R.nvim",
    ft = { "r", "rmd", "quarto", "rnoweb" },
    init = function()
      vim.g.R_auto_start = 1
      vim.g.R_objbr_auto_start = 0
      vim.g.R_nvimpager = "tab"
      vim.g.R_hl_term = 0
    end,
  },
}
