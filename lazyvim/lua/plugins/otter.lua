return {
  {
    "jmbuhr/otter.nvim",
    lazy = false,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      diagnostic_update_events = { "BufWritePost", "InsertLeave", "TextChanged" },
    },
  },
}
