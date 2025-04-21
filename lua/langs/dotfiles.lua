vim.lsp.enable({ "bashls", "fish-lsp" })

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "git_config" },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        fish = { "fish_indent" },
        sh = { "shfmt" },
      },
    },
  },
}
