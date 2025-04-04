return {
  {
    "mason.nvim",
    opts = { ensure_isntalled = { "codelldb" } },
  },

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
    opts = {},
    config = function(_, opts)
      ---@type rustaceanvim.Config
      vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts)
    end,
  },
}
