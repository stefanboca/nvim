return {
  { "saghen/blink.compat" },
  {
    "saghen/blink.cmp",
    version = false,
    optional = true,
    build = "cargo build --release",
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
          draw = {
            columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "kind" } },
          },
        },

        documentation = {
          auto_show = false,
          window = {
            winblend = vim.o.pumblend,
          },
        },

        ghost_text = { enabled = true },
      },

      fuzzy = { prebuilt_binaries = { download = false } },

      signatures = {
        enabled = true,
        window = { winblend = vim.o.pumblend },
      },

      appearence = {
        kind_icons = LazyVim.config.icons.kinds,
      },
    },
  },

  {
    "catppuccin/nvim",
    optional = true,
    opts = {
      integrations = {
        blink_cmp = true,
      },
    },
  },
}
