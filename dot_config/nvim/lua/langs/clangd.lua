vim.lsp.enable("clangd")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "c", "cpp" } },
  },
  {
    "mason.nvim",
    opts = { ensure_installed = { "clangd" } },
  },
}
