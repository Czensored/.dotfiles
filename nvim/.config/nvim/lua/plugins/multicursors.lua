return {
  "mg979/vim-visual-multi",
  branch = "master",
  lazy = false,
  init = function()
    vim.g.VM_default_mappings = 1

    -- remap Goto Next/Prev to avoid conflicts with LazyVim
    vim.g.VM_maps = {
      ["Goto Next"] = "",
      ["Goto Prev"] = "",
    }
    vim.g.VM_silent_exit = 1
  end,
}
