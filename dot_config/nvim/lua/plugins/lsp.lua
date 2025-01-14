return {
  -- update diagnostics in insert mode
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        update_in_insert = true,
      },
    },
  },

  {
    "jmbuhr/otter.nvim",
    lazy = true,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
  },
}
