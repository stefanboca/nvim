vim.lsp.enable("tinymist")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "typst" } },
  },
  {
    "mason.nvim",
    opts = { ensure_installed = { "tinymist" } },
  },

  {
    "stevearc/conform.nvim",
    optional = true,
    ---@module 'conform'
    ---@type conform.setupOpts
    opts = {
      formatters_by_ft = {
        typst = { "typstyle" },
      },
    },
  },

  {
    "tinymist.nvim",
    dev = true,
    opts = {},
    cmd = { "TinymistStartPreview", "TinymistStopPreview" },
    keys = {
      {
        "<leader>cp",
        ft = "typst",
        "<cmd>TinymistStartPreview<cr>",
        desc = "Start TinyMist Preview",
      },
    },
  },

  {
    "folke/ts-comments.nvim",
    opts = {
      lang = {
        typst = { "// %s", "/* %s */" },
      },
    },
  },
}
