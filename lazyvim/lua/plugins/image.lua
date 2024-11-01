return {
  { "leafo/magick" },
  {
    "3rd/image.nvim",
    event = "VeryLazy",
    opts = {
      backend = "kitty",
    },
    enabled = not vim.g.neovide,
  },
}
