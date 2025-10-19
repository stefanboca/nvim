local nmapb_leader = _G.Config.nmapb_leader

_G.Config.now_if_args(function()
  _G.Config.new_autocmd("LspAttach", nil, function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client or client.name ~= "rust-analyzer" then return end

    vim.b.miniclue_config = { clues = { { { mode = "n", keys = "<Leader>r", desc = "+Rust" } } } }

    nmapb_leader("re", "<cmd>RustLsp expandMacro<CR>", "Macro expand")
    nmapb_leader("ro", "<cmd>RustLsp openDocs<CR>", "Docs open")
    nmapb_leader("rO", "<cmd>RustLsp openCargo<CR>", "Cargo.toml open")
    nmapb_leader("rp", "<cmd>RustLsp parentModule<CR>", "Parent Module open")
    nmapb_leader("rR", "<cmd>RustLsp debuggables<CR>", "Debuggables")
  end)
end)
