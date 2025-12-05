---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
      completion = {
        callSnippet = true,
      },
    },
  },
}
