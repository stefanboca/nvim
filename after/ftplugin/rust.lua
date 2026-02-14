vim.opt_local.textwidth = 0

if not vim.g.neotest_rust_init then
  ---@diagnostic disable-next-line: missing-fields
  require("neotest").setup({ adapters = { require("rustaceanvim.neotest") } })

  vim.g.neotest_rust_init = true
end
