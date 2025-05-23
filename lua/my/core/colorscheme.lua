return {
  {
    "folke/tokyonight.nvim",
    lazy = vim.g.colorscheme ~= "tokyonight",
    priority = 1000,
    ---@module 'tokyonight'
    ---@type tokyonight.Config
    opts = {
      style = "moon",
      plugins = {
        rainbow = true,
      },
    },
    config = function(_, opts)
      if vim.g.colorscheme == "tokyonight" then
        opts = vim.tbl_deep_extend("force", opts, { style = vim.g.colorscheme_style })
      end
      require("tokyonight").load(opts)
    end,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = vim.g.colorscheme ~= "catppuccin",
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
      if vim.g.colorscheme == "catppuccin" then
        opts = vim.tbl_deep_extend("force", opts, { background = { dark = vim.g.colorscheme_style } })
        require("catppuccin").setup(opts)
        require("catppuccin").load()
      else
        require("catppuccin").setup(opts)
      end
    end,
    specs = vim.g.colorscheme == "catppuccin" and {
      "akinsho/bufferline.nvim",
      opts = function(_, opts) opts.highlights = require("catppuccin.groups.integrations.bufferline").get() end,
    } or nil,
  },
}
