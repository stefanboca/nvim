return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "markdown", "markdown_inline" } },
  },
  {
    "mason.nvim",
    opts = { ensure_installed = { "markdownlint-cli2", "markdown-toc" } },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters = {
        ["markdown-toc"] = {
          condition = function(_, ctx)
            for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
              if line:find("<!%-%- toc %-%->") then return true end
            end
          end,
        },
        ["markdownlint-cli2"] = {
          condition = function(_, ctx)
            local diag = vim.tbl_filter(function(d) return d.source == "markdownlint" end, vim.diagnostic.get(ctx.buf))
            return #diag > 0
          end,
        },
      },
      formatters_by_ft = {
        ["markdown"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        markdown = { "markdownlint-cli2" },
      },
    },
  },

  {
    "toppair/peek.nvim",
    build = "deno task --quiet build:fast",
    keys = {
      {
        -- TODO: show toggle
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
    "render-markdown.nvim",
    opts = {
      completions = {
        lsp = {
          enabled = true,
        },
      },
    },
  },
}
