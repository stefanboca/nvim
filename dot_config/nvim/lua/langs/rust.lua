return {
  -- LSP for Cargo.toml
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = {
        blink = { use_custom_kind = true },
        crates = { enabled = true },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },

  {
    "mrcjkb/rustaceanvim",
    ft = { "rust" },
    dependencies = { "blink.cmp" }, -- load blink lsp capabilities
    ---@type rustaceanvim.Opts
    opts = {},
    config = function(_, opts) vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts) end,
  },

  {
    "nvim-neotest/neotest",
    opts = {
      adapters = {
        setmetatable({}, {
          __index = function(_, key) return require("rustaceanvim.neotest")[key] end,
        }),
      },
    },
  },
}
