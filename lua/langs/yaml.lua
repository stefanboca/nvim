vim.lsp.enable("yamlls")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "yaml" } },
  },

  { "b0o/SchemaStore.nvim" },
}
