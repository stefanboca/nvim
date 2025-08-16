return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { enabled = { "lua", "luadoc", "luap" } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = { enabled = { "lua_ls" } },
  },

  {
    "conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
      },
    },
  },

  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
  },

  {
    "blink.cmp",
    opts = {
      sources = {
        default = { "lazydev" },
        per_filetype = {
          lua = { inherit_defaults = true, "lazydev" },
        },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 10, -- show at a higher priority than lsp
          },
        },
      },
    },
  },
}
