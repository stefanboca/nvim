vim.loader.enable()

if vim.env.NVIM_PROFILE ~= nil then
  local snacks = vim.fn.stdpath("data") .. "/site/pack/deps/opt/snacks.nvim"
  vim.opt.rtp:append(snacks)
  require("snacks.profiler").startup({
    -- stop profiler on this event. Defaults to `VimEnter`
    startup = { event = "UIEnter" },
  })
end

local mini_path = vim.fn.stdpath("data") .. "/site/pack/deps/start/mini.deps"
if not vim.uv.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')
  local origin = "https://github.com/nvim-mini/mini.nvim"
  local clone_cmd = { "git", "clone", "--filter=blob:none", origin, mini_path }
  vim.fn.system(clone_cmd)
  vim.cmd("packadd mini.nvim | helptags ALL")
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

require("mini.deps").setup()
