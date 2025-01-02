return {
  -- don't skip next on `$` (for typst/latex/etc)
  {
    "echasnovski/mini.pairs",
    opts = {
      skip_next = [=[[%w%%%'%[%"%.%`]]=],
    },
  },

  -- wezterm type definitions for lua config
  { "gonstoll/wezterm-types", lazy = true },
  {
    "folke/lazydev.nvim",
    opts_extend = { "library" },
    opts = {
      library = {
        { path = "wezterm-types", mods = { "wezterm" } },
      },
    },
  },
}
