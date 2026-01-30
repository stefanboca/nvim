vim.opt_local.textwidth = 0

MiniDeps.later(function()
  ---@diagnostic disable-next-line: missing-fields
  require("neotest").setup({ adapters = { require("rustaceanvim.neotest") } })
end)
