---@type vim.lsp.Config
return {
  cmd = { "harper-ls", "--stdio", "--skip-version-check" },
  settings = {
    ["harper-ls"] = {
      linters = {
        SentenceCapitalization = false,
        SpellCheck = false,
        ToDoHyphen = false,
      },
    },
  },
}
