return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { enabled = { "markdown", "markdown_inline" } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = { enabled = { "marksman" } },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = { markdown = { "prettierd" } },
    },
  },

  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = { markdown = { "markdownlint-cli2" } },
    },
  },

  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    keys = {
      {
        "<leader>cp",
        function()
          local peek = require("peek")
          if peek.is_open() then
            peek.close()
          else
            peek.open()
          end
        end,
        ft = "markdown",
        desc = "Markdown Preview",
      },
    },
  },

  {
    "SCJangra/table-nvim",
    ft = "markdown",
    opts = {},
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    opts = {
      latex = { enabled = false },
      checkbox = { enabled = false },
      completions = {
        lsp = { enabled = true },
      },
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
      heading = {
        sign = false,
        icons = {},
      },
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)
      vim.api.nvim_create_autocmd("User", {
        pattern = "TinyCodeActionWindowEnterMain",
        callback = function(ev) require("render-markdown.state").get(ev.data.buf).win_options.conceallevel = nil end,
      })
      Snacks.toggle({
        name = "Render Markdown",
        get = function() return require("render-markdown.state").enabled end,
        set = function(enabled)
          local m = require("render-markdown")
          if enabled then
            m.enable()
          else
            m.disable()
          end
        end,
      }):map("<leader>um")
    end,
  },
}
