local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

---@diagnostic disable-next-line:duplicate-set-field
vim.deprecate = function() end

require("my.config.profiler")
require("my.config.options")
require("my.config.autocmds")

require("lazy").setup({
  { import = "my.core" },
  { import = "my.langs" },
}, {
  defaults = {
    lazy = true,
    version = false, -- use the latest git commit by default
  },
  dev = {
    path = "~/data/plugins",
  },
  install = { colorscheme = { vim.g.colorscheme } },
  checker = { enabled = false },
  performance = {
    rtp = {
      -- allows nix to add plugins (eg for ghostty syntax files)
      reset = false,
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

require("my.config.keymaps")
