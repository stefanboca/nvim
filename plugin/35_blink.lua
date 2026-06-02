local now_if_args = _G.Config.now_if_args
local packadd = _G.Config.packadd

MiniDeps.now(function() packadd("blink.lib") end)

now_if_args(function()
  packadd("blink.indent")

  require("blink.indent").setup({
    scope = {
      highlights = {
        "BlinkIndentViolet",
        "BlinkIndentBlue",
        "BlinkIndentCyan",
        "BlinkIndentGreen",
        "BlinkIndentYellow",
        "BlinkIndentOrange",
        "BlinkIndentRed",
      },
    },
  })
end)

now_if_args(function()
  packadd("blink.pairs")

  require("blink.pairs").setup({
    highlights = {
      matchparen = {
        include_surrounding = true,
      },
      enabled = true,
      groups = {
        "BlinkPairsPurple",
        "BlinkPairsBlue",
        "BlinkPairsCyan",
        "BlinkPairsGreen",
        "BlinkPairsYellow",
        "BlinkPairsOrange",
        "BlinkPairsRed",
      },
    },
  })
end)

now_if_args(function()
  packadd("blink.cmp")

  require("blink.cmp").setup({
    appearance = {
      nerd_font_variant = "normal",
    },

    keymap = {
      preset = "enter",
      ["<C-k>"] = false, -- conflicts with digraphs
    },

    cmdline = {
      completion = {
        list = { selection = { preselect = false } },
        menu = {
          auto_show = true,
          draw = {
            columns = { { "label", "label_description", gap = 1 } },
          },
        },
      },
    },

    completion = {
      list = { selection = { preselect = false } },
      menu = {
        border = "none",
        direction_priority = { "n", "s" },
        draw = { treesitter = { "lsp" } },
      },
      documentation = { auto_show = true },
      ghost_text = { enabled = true },
    },

    fuzzy = {
      implementation = "rust",
    },

    signature = {
      enabled = true,
      trigger = { show_on_insert = true },
      window = {
        direction_priority = { "s", "n" },
        show_documentation = true,
      },
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      per_filetype = { lua = { inherit_defaults = true, "lazydev" } },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 10, -- show at a higher priority than lsp
        },
      },
    },
  })
end)
