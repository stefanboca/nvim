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
    config = function(_, opts)
      -- FIXME: remove on merge of https://github.com/folke/lazydev.nvim/pull/96
      require("lazydev.lsp").supports = function(client)
        return client and vim.tbl_contains({ "lua_ls", "emmylua_ls" }, client.name)
      end
      require("lazydev").setup(opts)
    end,
  },

  {
    "blink.cmp",
    opts = {
      sources = {
        default = { "lazydev" },
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
