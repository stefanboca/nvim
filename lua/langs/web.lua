return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "typescript", "tsx", "javascript", "jsdoc", "css", "scss", "html" } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = { enabled = { "biome", "vtsls", "svelte", "tailwindcss" } },
  },

  -- Automatically add closing tags for HTML and JSX
  {
    "windwp/nvim-ts-autotag",
    fs = { "handlebars", "html", "javascript", "markdown", "svelte", "typescript", "xml" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        handlebars = { "prettierd" },
        less = { "prettierd" },
        scss = { "prettierd" },

        astro = { "biome" },
        css = { "biome" },
        graphql = { "biome" },
        javascript = { "biome" },
        javascriptreact = { "biome" },
        json = { "biome" },
        jsonc = { "biome" },
        svelte = { "biome" },
        typescript = { "biome" },
        typescriptreact = { "biome" },
        vue = { "biome" },
        -- In progress (see https://biomejs.dev/internals/language-support/):
        -- html = { "biome" },
        -- markdown = { "biome" },
        -- yaml = { "biome" },
        -- use prettierd for now:
        html = { "prettierd" },
        markdown = { "prettierd" },
        yaml = { "prettierd" },
      },
    },
  },
}
