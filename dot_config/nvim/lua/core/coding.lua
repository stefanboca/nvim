return {
  -- comments
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- Better text-objects
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = {},
  },

  {
    "echasnovski/mini.move",
    event = "VeryLazy",
    opts = {},
  },

  {
    "echasnovski/mini.surround",
    keys = {
      { "gsa", desc = "Add Surrounding", mode = { "n", "v" } },
      { "gsd", desc = "Delete Surrounding" },
      { "gsf", desc = "Find Right Surrounding" },
      { "gsF", desc = "Find Left Surrounding" },
      { "gsh", desc = "Highlight Surrounding" },
      { "gsr", desc = "Replace Surrounding" },
    },
    opts = {
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
      },
    },
  },

  {
    "saghen/blink.pairs",
    build = "cargo build --release",
    dev = true,

    --- @module 'blink.pairs'
    --- @type blink.pairs.Config
    opts = {
      mappings = {
        enabled = true,
        pairs = {
          ["$"] = { "$", filetypes = { "typst" } },
        },
      },
      highlights = {
        enabled = true,
        groups = {
          "RainbowDelimiterRed",
          "RainbowDelimiterOrange",
          "RainbowDelimiterYellow",
          "RainbowDelimiterGreen",
          "RainbowDelimiterCyan",
          "RainbowDelimiterBlue",
          "RainbowDelimiterViolet",
        },
      },
    },
  },

  {
    "danymat/neogen",
    cmd = "Neogen",
    keys = { { "<leader>cn", function() require("neogen").generate() end, desc = "Generate Annotations (Neogen)" } },
    opts = { snippet_engine = "luasnip" },
  },

  {
    "xzbdmw/clasp.nvim",
    opts = {},
    keys = {
      { "<C-p>", function() require("clasp").wrap("next") end, desc = "Cycle pairs", mode = "n" },
    },
  },
}
