local nmapb_lleader = _G.Config.nmapb_lleader

_G.Config.new_autocmd_lsp_attach("rust-analyzer", function()
  nmapb_lleader("e", "<cmd>RustLsp expandMacro<CR>", "Macro expand")
  nmapb_lleader("o", "<cmd>RustLsp openDocs<CR>", "Docs open")
  nmapb_lleader("O", "<cmd>RustLsp openCargo<CR>", "Cargo.toml open")
  nmapb_lleader("p", "<cmd>RustLsp parentModule<CR>", "Parent Module open")
  nmapb_lleader("R", "<cmd>RustLsp debuggables<CR>", "Debuggables")
end)
