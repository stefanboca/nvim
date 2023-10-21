return {
  {
    "saecki/crates.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = { "BufRead Cargo.toml" },
    config = true,
    opts = {
      src = {
        cmp = {
          enabled = true,
        },
      },
      null_ls = {
        enabled = true,
        name = "crates.nvim",
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "saecki/crates.nvim",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, {
        name = "crates",
      })
    end,
  },
}
