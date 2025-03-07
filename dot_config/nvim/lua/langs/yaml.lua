vim.lsp.enable("yamlls")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "yaml" } },
  },
  {
    "mason.nvim",
    opts = { ensure_installed = { "yaml-language-server" } },
  },

  { "b0o/SchemaStore.nvim", lazy = true },
}
