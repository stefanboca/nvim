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
          draw = "reversed",
          winblend = vim.o.pumblend,
        },
        documentation = {
          winblend = vim.o.pumblend,
        },
        signature_help = {
          winblend = vim.o.pumblend,
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
