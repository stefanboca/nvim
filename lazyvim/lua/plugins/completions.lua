return {
  {
    "saghen/blink.cmp",
    version = "*",
    optional = true,
    build = "cargo build --release",
    opts = {
      keymap = "enter",

      trigger = { signature_help = { enabled = true } },
      fuzzy = { prebuiltBinaries = { download = false } },

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
