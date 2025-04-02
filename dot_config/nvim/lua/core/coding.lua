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
    keys = {
      { "<M-h>", mode = { "n", "v" } },
      { "<M-j>", mode = { "n", "v" } },
      { "<M-k>", mode = { "n", "v" } },
      { "<M-l>", mode = { "n", "v" } },
    },
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
    event = { "BufReadPre", "BufNewFile" },
    build = "cargo build --release",
    dev = true,

    --- @module 'blink.pairs'
    --- @type blink.pairs.Config
    opts = {
      mappings = {
        enabled = true,
        pairs = {
          ["$"] = { "$", filetypes = { "typst" } },
          ["'"] = {
            {
              "'''",
              "'''",
              when = function()
                local cursor = vim.api.nvim_win_get_cursor(0)
                local line = vim.api.nvim_get_current_line()
                return line:sub(cursor[2] - 1, cursor[2]) == "''"
              end,
              space = false,
              filetypes = { "python" },
            },
            { "'", space = false },
          },
          ['"'] = {
            { 'r#"', '"#', filetypes = { "rust" }, space = false, priority = 100 },
            {
              '"""',
              '"""',
              when = function()
                local cursor = vim.api.nvim_win_get_cursor(0)
                local line = vim.api.nvim_get_current_line()
                return line:sub(cursor[2] - 1, cursor[2]) == '""'
              end,
              space = false,
              filetypes = { "python", "elixir", "julia", "kotlin", "scala", "sbt" },
            },
            { '"', enter = false, space = false },
          },
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
      { "<C-;>", function() require("clasp").wrap("next") end, mode = { "n", "i" }, desc = "Cycle pairs" },
    },
  },
}
