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
      background = { dark = vim.g.catppuccin_flavor },
      dim_inactive = { enabled = true },
      lsp_styles = { enabled = true },
      auto_integrations = true,
      custom_highlights = function(c)
        local hls = {
          MatchParen = { fg = "NONE", bg = c.surface1, style = { "bold" } },
          ["@comment.error"] = { fg = c.red, bg = "NONE" },
          ["@comment.warning"] = { fg = c.yellow, bg = "NONE" },
          ["@comment.hint"] = { fg = c.blue, bg = "NONE" },
          ["@comment.todo"] = { fg = c.flamingo, bg = "NONE" },
          ["@comment.note"] = { fg = c.rosewater, bg = "NONE" },
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
    },
    config = function(_, opts)
      local catppuccin = require("catppuccin")
      catppuccin.setup(opts)
      catppuccin.load()
    end,
    specs = {
      "akinsho/bufferline.nvim",
      opts = function(_, opts) opts.highlights = require("catppuccin.special..bufferline").get_theme() end,
    },
  },
}
