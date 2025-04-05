return {
  {
    "folke/tokyonight.nvim",
    opts = { style = "storm" },
  },

  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
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
        mason = true,
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
          if (vim.g.colors_name or ""):find("catppuccin") then
            opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
          end
        end,
      },
    },
  },
}
