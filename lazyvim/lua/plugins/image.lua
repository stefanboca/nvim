return {
  {
    "3rd/image.nvim",
    depencencies = {
      "leafo/magick",
    },
    event = "VeryLazy",
    opts = {
      backend = "kitty",
    },
    enabled = not vim.g.neovide,
  },
}
