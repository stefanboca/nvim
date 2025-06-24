return {
  -- Better text-objects
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = function()
      local spec_treesitter = require("mini.ai").gen_spec.treesitter
      return {
        custom_textobjects = {
          B = spec_treesitter({ a = "@block.outer", i = "@block.inner" }),
          C = spec_treesitter({ a = "@class.outer", i = "@class.inner" }),
          F = spec_treesitter({ a = "@function.outer", i = "@function.inner" }),
        },
      }
    end,
  },

  {
    "echasnovski/mini.move",
    keys = {
      { "<M-h>", mode = { "n", "x" } },
      { "<M-j>", mode = { "n", "x" } },
      { "<M-k>", mode = { "n", "x" } },
      { "<M-l>", mode = { "n", "x" } },
    },
    opts = {},
  },

  {
    "echasnovski/mini.surround",
    keys = {
      { "gsa", desc = "Add Surrounding", mode = { "n", "x" } },
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
    dev = vim.env.NVIM_DEV == "pairs",
    event = { "BufReadPre", "BufNewFile" },
    build = "cargo build --release",

    --- @module 'blink.pairs'
    --- @type blink.pairs.Config
    opts = {
      highlights = {
        enabled = true,
        groups = {
          "BlinkPairsRed",
          "BlinkPairsOrange",
          "BlinkPairsYellow",
          "BlinkPairsGreen",
          "BlinkPairsCyan",
          "BlinkPairsBlue",
          "BlinkPairsViolet",
        },
      },
    },
  },

  {
    "danymat/neogen",
    cmd = "Neogen",
    keys = { { "<leader>cn", function() require("neogen").generate() end, desc = "Generate Annotations (Neogen)" } },
    opts = {},
  },

  {
    "xzbdmw/clasp.nvim",
    opts = {},
    keys = {
      { "<C-;>", function() require("clasp").wrap("next") end, mode = { "n", "i" }, desc = "Cycle pairs" },
    },
  },
}
