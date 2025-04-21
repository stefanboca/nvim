vim.lsp.enable("jsonls")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "json", "jsonc", "json5" } },
  },

  { "b0o/SchemaStore.nvim" },
}
