local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("config.profiler")
require("config.options")
require("config.autocmds")

require("lazy").setup({
  { import = "core" },
  { import = "langs" },
}, {
  defaults = {
    lazy = false,
    version = false, -- use the latest git commit by default
  },
  dev = {
    path = "~/data/plugins",
  },
  install = { colorscheme = { "catppuccin", "tokyonight", "habamax" } },
  checker = { enabled = false },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "rplugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

require("config.keymaps")
