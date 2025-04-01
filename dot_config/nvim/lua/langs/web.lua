vim.lsp.enable({ "biome", "vtsls", "svelte", "tailwindcss" })

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "typescript", "tsx", "javascript", "jsdoc", "css", "scss", "html" } },
  },
  {
    "mason.nvim",
    opts = {
      ensure_installed = { "biome", "prettier", "vtsls", "svelte-language-server", "tailwindcss-language-server" },
    },
  },

  -- Automatically add closing tags for HTML and JSX
  {
    "windwp/nvim-ts-autotag",
    lazy = true,
    fs = { "handlebars", "html", "javascript", "markdown", "svelte", "typescript", "xml" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        handlebars = { "prettier" },
        less = { "prettier" },
        scss = { "prettier" },

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
        -- use prettier for now:
        html = { "prettier" },
        markdown = { "prettier" },
        yaml = { "prettier" },
      },
    },
  },
}
