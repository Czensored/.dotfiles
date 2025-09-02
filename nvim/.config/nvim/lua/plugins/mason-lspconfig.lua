return {
  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    opts = {
      ensure_installed = {
        "rust_analyzer", -- rust
        "taplo", -- toml
        "clangd", -- c++
        "lua_ls", -- lua
        "pyright", -- python
        "ts_ls", -- javascript, typescript
        "html", -- html
      },
    },
  },
}
