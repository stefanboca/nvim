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
      float = {
        transparent = false,
        solid = false,
      },
      custom_highlights = function(c)
        local hls = {
          MatchParen = { fg = "NONE", bg = c.surface1, style = { "bold" } },
        }

        local function pairs_hl(color, fg)
          hls["BlinkPairs" .. color] = { fg = fg }
          hls["BlinkIndentUnderline" .. color] = { default = true, sp = fg, underline = true }
        end

        pairs_hl("Red", c.red)
        pairs_hl("Orange", c.peach)
        pairs_hl("Yellow", c.yellow)
        pairs_hl("Green", c.green)
        pairs_hl("Cyan", c.teal)
        pairs_hl("Blue", c.blue)
        pairs_hl("Violet", c.mauve)

        return hls
      end,
      auto_integrations = true,
      integrations = {
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            warnings = { "undercurl" },
          },
        },
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
