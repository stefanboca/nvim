vim.lsp.enable("neocmake")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "cmake" } },
  },

  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        cmake = { "cmakelint" },
      },
    },
  },
}
