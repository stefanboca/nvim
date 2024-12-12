return {
  { "saghen/blink.compat", lazy = true },
  {
    "saghen/blink.cmp",
    dev = true,
    optional = true,
    opts = {
      keymap = {
        preset = "enter",
      },

      completion = {
        keyword = { range = "full" },
        list = {
          selection = "manual",
        },
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          winblend = vim.o.pumblend,
          direction_priority = { "n", "s" },
          draw = {
            columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "fill", "kind" } },
            components = {
              fill = {
                width = { fill = true },
                text = function()
                  return ""
                end,
              },
            },
          },
        },

        documentation = {
          auto_show = true,
          window = {
            winblend = vim.o.pumblend,
          },
        },

        ghost_text = { enabled = true },
      },

      fuzzy = { prebuilt_binaries = { download = false } },

      signature = {
        enabled = true,
        window = { winblend = vim.o.pumblend },
      },

      sources = {
        providers = {
          lazydev = {
            fallbacks = { "lsp" },
          },
        },
      },
    },
  },
}
