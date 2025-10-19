vim.b.miniclue_config = { clues = { { { mode = "n", keys = "<Leader>dP", desc = "+Python" } } } }

local function nmap_leader(suffix, rhs, desc)
  vim.keymap.set("n", "<Leader>" .. suffix, rhs, { desc = desc, buffer = 0 })
end
nmap_leader("dPc", '<Cmd>lua require("dap-python").test_class()<CR>', "Debug Class")
nmap_leader("dPt", '<Cmd>lua require("dap-python").test_method()<CR>', "Debug Method")
