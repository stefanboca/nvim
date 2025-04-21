local lspconfig = require("utils.lsp").lspconfig("ruff")

---@type vim.lsp.Config
return {
  on_attach = {
    function(_, bufnr)
      vim.keymap.set(
        "n",
        "<leader>co",
        function()
          vim.lsp.buf.code_action({ apply = true, context = { only = { "source.organizeImports" }, diagnostics = {} } })
        end,
        { desc = "Organize Imports", buffer = bufnr }
      )
    end,
    lspconfig and lspconfig.on_attach,
  },
}
