local nmapb_lleader = _G.Config.nmapb_lleader
local packadd = vim.cmd.packadd

nmapb_lleader("c", '<Cmd>lua require("dap-python").test_class()<CR>', "Debug Class")
nmapb_lleader("t", '<Cmd>lua require("dap-python").test_method()<CR>', "Debug Method")

if not vim.g.nvim_dap_python_init then
  packadd("nvim-dap-python")
  require("dap-python").setup("uv")

  packadd("neotest-python")
  ---@diagnostic disable-next-line: missing-fields
  require("neotest").setup({ adapters = { require("neotest-python") } })

  vim.g.nvim_dap_python_init = true
end
