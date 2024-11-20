return {
  { "leafo/magick", lazy = true },
  {
    "3rd/image.nvim",
    event = "LazyFile",
    lazy = true,
    opts = {},
    cond = not vim.g.neovide,
  },
}
