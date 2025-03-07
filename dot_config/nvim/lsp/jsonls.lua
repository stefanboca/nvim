---@type vim.lsp.Config
return {
  cmd = { "vscode-json-language-server", "--stdio" },
  filetypes = { "json", "jsonc" },
  settings = {
    json = {
      format = {
        enable = true,
      },
      validate = { enable = true },
    },
  },
  before_init = function(_, config) config.settings.json.schemas = require("schemastore").json.schemas() end,
}
