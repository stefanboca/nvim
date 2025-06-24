return {
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "moon",
      plugins = {
        rainbow = true,
      },
    },
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    ---@type CatppuccinOptions
    opts = {
      background = {
        dark = vim.g.catppuccin_flavor,
      },
      custom_highlights = function(colors)
        return {
          MatchParen = { fg = "NONE", bg = colors.surface1, style = { "bold" } },
        }
      end,
      integrations = {
        blink_cmp = true,
        flash = true,
        grug_far = true,
        gitsigns = true,
        leap = true,
        lsp_trouble = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        noice = true,
        notify = true,
        rainbow_delimiters = true, -- used by blink.pairs
        semantic_tokens = true,
        snacks = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
    config = function(_, opts)
      local catppuccin = require("catppuccin")
      catppuccin.setup(opts)
      catppuccin.load()
    end,
    specs = {
      "akinsho/bufferline.nvim",
      opts = function(_, opts) opts.highlights = require("catppuccin.groups.integrations.bufferline").get() end,
    },
  },
}
