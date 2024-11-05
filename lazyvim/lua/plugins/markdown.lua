return {
  {
    "iamcco/markdown-preview.nvim",
    enabled = false,
  },

  {
    "toppair/peek.nvim",
    ft = { "markdown" },
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
}
