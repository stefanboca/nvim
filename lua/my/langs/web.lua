return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      enabled = {
        "astro",
        "css",
        "graphql",
        "html",
        "html_tags",
        "javascript",
        "jsdoc",
        "scss",
        "svelte",
        "typescript",
        "vue",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = { enabled = { "biome", "vtsls", "svelte", "tailwindcss" } },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        astro = { "biome" },
        css = { "biome" },
        graphql = { "biome" },
        handlebars = { "prettierd" },
        javascript = { "biome" },
        javascriptreact = { "biome" },
        less = { "prettierd" },
        scss = { "prettierd" },
        svelte = { "biome" },
        typescript = { "biome" },
        typescriptreact = { "biome" },
        vue = { "biome" },

        -- In progress (see https://biomejs.dev/internals/language-support/):
        -- html = { "biome" },
        -- use prettierd for now:
        html = { "prettierd" },
      },
    },
  },

  -- Automatically add closing tags for HTML and JSX
  {
    "windwp/nvim-ts-autotag",
    fs = { "handlebars", "html", "javascript", "markdown", "svelte", "typescript", "xml" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
  },
}
