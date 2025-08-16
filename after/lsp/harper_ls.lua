---@type vim.lsp.Config
return {
  settings = {
    ["harper-ls"] = {
      linters = {
        LongSentences = false,
        SentenceCapitalization = false,
        SpellCheck = false,
        ToDoHyphen = false,
      },
    },
  },
}
