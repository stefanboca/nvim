local render_math_spec = {
  "render-math.nvim",
  lazy = false,
  dev = true,
  opts = {},
}

local blink_cmp_spec = {
  {
    "saghen/blink.cmp",
    dev = true,
    dependencies = {
      { "dmitmel/cmp-digraphs" },
      { "chrisgrieser/cmp-nerdfont" },
      { "hrsh7th/cmp-emoji" },
      -- {
      --   "uga-rosa/cmp-dictionary",
      --   opts = { exact_length = 2, paths = { "/home/doctorwho/.dotfiles/some_words.txt" } },
      --   lazy = true,
      -- },
    },
    opts = {
      sources = {
        completion = {
          enabled_providers = { "emoji", "nerdfont", "digraphs" },
        },
        providers = {
          emoji = {
            name = "emoji",
            module = "blink.compat.source",
            score_offset = -3,
          },
          nerdfont = {
            name = "nerdfont",
            module = "blink.compat.source",
            score_offset = -3,
          },
          dictionary = {
            name = "dictionary",
            module = "blink.compat.source",
            score_offset = 3,
          },
          digraphs = {
            name = "digraphs",
            module = "blink.compat.source",
            score_offset = -3,
          },
        },
      },
    },
  },
}

return {
  { "gonstoll/wezterm-types", lazy = true },
  {
    "folke/lazydev.nvim",
    dependencies = {},
    opts_extend = { "library" },
    opts = {
      library = {
        { path = "wezterm-types", mods = { "wezterm" } },
      },
    },
  },

  -- render_math_spec,
  -- blink_cmp_spec,
}
