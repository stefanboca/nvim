return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "yaml" } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = { enabled = { "yamlls" } },
  },

  { "b0o/SchemaStore.nvim" },
}
