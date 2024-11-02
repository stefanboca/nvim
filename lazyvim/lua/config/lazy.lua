local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- add LazyVim and import its plugins
  {
    "LazyVim/LazyVim",
    dev = true,
    opts = { colorscheme = "catppuccin" },
    import = "lazyvim.plugins",
  },
  -- import custom plugins
  { import = "plugins" },
}, {
  defaults = {
    lazy = false,
    version = false, -- always use the latest git commit
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
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
