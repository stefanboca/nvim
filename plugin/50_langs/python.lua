_G.Config.now_if_args(function()
  _G.Config.new_autocmd("LspAttach", nil, function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client or client.name ~= "ruff" then return end
    local function organize()
      vim.lsp.buf.code_action({
        apply = true,
        context = { only = { "source.organizeImports" }, diagnostics = {} },
      })
    end
    _G.Config.nmapb_lleader("o", organize, "Imports organize")
  end)
end)
