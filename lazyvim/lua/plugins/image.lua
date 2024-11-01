return {
  {
    "leafo/magick",
    lazy = true,
  },
  {
    "3rd/image.nvim",
    event = "VeryLazy",
    opts = {
      backend = "kitty",
    },
    enabled = not vim.g.neovide,
  },
}
