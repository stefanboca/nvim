---@type vim.lsp.Config
return {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
      workspace = {
        ignoreSubmodules = true,
        checkThirdParty = false,
      },
      codeLens = {
        enable = true,
      },
      completion = {
        callSnippet = "Replace",
      },
      telemetry = { enable = false },
    },
  },
}
