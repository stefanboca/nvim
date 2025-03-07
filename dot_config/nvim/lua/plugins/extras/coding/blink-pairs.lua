return {
  {
    "mini.pairs",
    enabled = false,
  },

  {
    "saghen/blink.pairs",
    build = "cargo build --release",

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
    "catpuccin/nvim",
    optional = true,
    opts = {
      integrations = {
        rainbow_delimiters = true,
      },
    },
  },
}
