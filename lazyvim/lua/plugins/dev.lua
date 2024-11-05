_G.dd = function(...)
  Snacks.debug.inspect(...)
end
_G.bt = function()
  Snacks.debug.backtrace()
end

local render_math_spec = {
  "render-math.nvim",
  lazy = false,
  dev = true,
  opts = {},
}

local jjsigns_spec = {
  "jjsigns.nvim",
  lazy = false,
  dev = true,
  opts = {
    auto_attach = true,
    debug = {
      enabled = true,
      verbose = true,
    },
  },
}

local blink_cmp_spec = {
  { "dmitmel/cmp-digraphs", lazy = true },
  { "chrisgrieser/cmp-nerdfont", lazy = true },
  { "hrsh7th/cmp-emoji", lazy = true },
  {
    "uga-rosa/cmp-dictionary",
    opts = { exact_length = 2, paths = { "/home/doctorwho/.dotfiles/some_words.txt" } },
    lazy = true,
  },
  {
    "saghen/blink.cmp",
    dev = true,
    opts = {
      sources = {
        completion = {
          enabled_providers = {},
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
  { "saghen/blink.compat", dev = true },

  -- jjsigns_spec,
  -- render_math_spec,
  -- blink_cmp_spec
}
