return {
  { "leafo/magick", lazy = true },
  {
    "3rd/image.nvim",
    lazy = true,
    opts = {},
    cond = not vim.g.neovide,
  },
}
