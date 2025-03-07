vim.lsp.enable("jsonls")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "json", "jsonc", "json5" } },
  },
  {
    "mason.nvim",
    opts = { ensure_installed = { "json-lsp" } },
  },

  { "b0o/SchemaStore.nvim", lazy = true },
}
