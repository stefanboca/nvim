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

      trigger = {
        completion = { keyword_range = "full" },
        signature_help = { enabled = true },
      },
      fuzzy = { prebuilt_binaries = { download = false } },

      windows = {
        autocomplete = {
          selection = "manual",
          draw = {
            columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
          },
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
