-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- When wrap is enabled, wrap on word boundaries
vim.o.linebreak = true

vim.o.clipboard = "unnamed"

vim.g.lazyvim_python_lsp = "basedpyright"
vim.g.lazyvim_blink_main = true

vim.g.root_spec = { "lsp", { ".git", "lua", ".jj" }, "cwd" }

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.g.transparent = false

if vim.g.neovide then
  vim.o.pumblend = 80
  vim.o.winblend = 80
  if vim.g.transparent then
    vim.g.neovide_transparency = 0.8
  end

  vim.g.neovide_floating_blur_amount_x = 8.0
  vim.g.neovide_floating_blur_amount_y = 8.0

  vim.g.neovide_floating_shadow = true
  vim.g.neovide_floating_z_height = 10
  vim.g.neovide_light_angle_degrees = 45
  vim.g.neovide_light_radius = 5

  vim.g.neovide_floating_corner_radius = 0.25

  vim.g.neovide_cursor_vfx_mode = "railgun"
end
