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
