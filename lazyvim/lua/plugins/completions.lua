return {
  {
    "saghen/blink.cmp",
    version = false,
    optional = true,
    build = "cargo build --release",
    opts = {
      keymap = {
        preset = "enter",
      },

      trigger = { signature_help = { enabled = true } },
      fuzzy = { prebuilt_binaries = { download = false } },

      windows = {
        autocomplete = {
          selection = "manual",
          draw = "simple",
        },
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
