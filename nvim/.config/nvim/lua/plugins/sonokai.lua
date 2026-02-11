return {
  "sainnhe/sonokai",
  lazy = true,
  init = function()
    -- Pick a variant: "default", "atlantis", "andromeda", "shusia", "maia", "espresso"
    vim.g.sonokai_style = "espresso"

    -- Examples of other common toggles
    vim.g.sonokai_better_performance = 1
    -- vim.g.sonokai_transparent_background = 1
  end,
}
