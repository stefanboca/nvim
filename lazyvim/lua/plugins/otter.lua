return {
  {
    "jmbuhr/otter.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    event = "LazyFile",
    opts = {
      diagnostic_update_events = { "BufWritePost", "InsertLeave", "TextChanged" },
    },
  },
}
