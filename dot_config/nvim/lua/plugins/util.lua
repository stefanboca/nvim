return {
  -- async library
  { "gregorias/coop.nvim", version = false, lazy = true },

  -- image library
  { "leafo/magick", lazy = true },
  {
    "3rd/image.nvim",
    lazy = true,
    opts = {},
    cond = not vim.g.neovide,
  },

  -- show available keys
  {
    "meznaric/key-analyzer.nvim",
    cmd = "KeyAnalyzer",
    opts = {},
  },
}
