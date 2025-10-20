local function organize()
  vim.lsp.buf.code_action({ apply = true, context = { only = { "source.organizeImports" }, diagnostics = {} } })
end

_G.Config.new_autocmd_lsp_attach("ruff", function() _G.Config.nmapb_lleader("o", organize, "Imports organize") end)
