local nmapb_lleader = _G.Config.nmapb_lleader
nmapb_lleader("c", '<Cmd>lua require("dap-python").test_class()<CR>', "Debug Class")
nmapb_lleader("t", '<Cmd>lua require("dap-python").test_method()<CR>', "Debug Method")
