vim.b.miniclue_config = { clues = { { { mode = "n", keys = "<Leader>dP", desc = "+Python" } } } }

local nmapb_leader = _G.Config.nmapb_leader
nmapb_leader("dPc", '<Cmd>lua require("dap-python").test_class()<CR>', "Debug Class")
nmapb_leader("dPt", '<Cmd>lua require("dap-python").test_method()<CR>', "Debug Method")
