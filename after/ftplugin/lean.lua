if not vim.g.lean_init then
  vim.cmd.packadd("lean.nvim")

  require("lean").setup({ mappings = true })

  vim.g.lean_init = true
end
