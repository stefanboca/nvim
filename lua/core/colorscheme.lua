return {
  {
    "folke/tokyonight.nvim",
    cond = vim.g.colorscheme == "tokyonight",
    lazy = false,
    priority = 1000,
    ---@module 'tokyonight'
    ---@type tokyonight.Config
    opts = {
      style = "moon",
      plugins = {
        rainbow = true,
      },
    },
    config = function(_, opts) require("tokyonight").load(opts) end,
  },

  {
    "catppuccin/nvim",
    cond = vim.g.colorscheme == "catppuccin",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    ---@module 'catppuccin.types'
    ---@type CatppuccinOptions
    opts = {
      background = {
        dark = "macchiato",
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
      require("catppuccin").setup(opts)
      require("catppuccin").load()
    end,
    specs = {
      {
        "akinsho/bufferline.nvim",
        opts = function(_, opts)
          if vim.g.colorscheme == "catppuccin" then
            opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
          end
        end,
      },
    },
  },
}
