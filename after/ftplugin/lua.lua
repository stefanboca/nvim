if not vim.g.lazydev_init then
  vim.cmd.packad("lazydev.nvim")

  require("lazydev").setup({
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      { path = "snacks.nvim", words = { "Snacks" } },
    },
  })

  vim.g.lazydev_init = true
end
