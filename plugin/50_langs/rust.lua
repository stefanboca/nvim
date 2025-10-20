local nmapb_lleader = _G.Config.nmapb_lleader

_G.Config.now_if_args(function()
  _G.Config.new_autocmd("LspAttach", nil, function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client or client.name ~= "rust-analyzer" then return end

    nmapb_lleader("e", "<cmd>RustLsp expandMacro<CR>", "Macro expand")
    nmapb_lleader("o", "<cmd>RustLsp openDocs<CR>", "Docs open")
    nmapb_lleader("O", "<cmd>RustLsp openCargo<CR>", "Cargo.toml open")
    nmapb_lleader("p", "<cmd>RustLsp parentModule<CR>", "Parent Module open")
    nmapb_lleader("R", "<cmd>RustLsp debuggables<CR>", "Debuggables")
  end)
end)
