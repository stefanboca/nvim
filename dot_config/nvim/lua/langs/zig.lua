vim.lsp.enable("zls")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "zig" } },
  },
  {
    "mason.nvim",
    opts = { ensure_installed = { "zls" } },
  },
}
