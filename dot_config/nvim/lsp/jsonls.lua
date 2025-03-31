local has_schemastore, schemastore = pcall(require, "schemastore")
local schemas = has_schemastore and schemastore.json.schemas() or {}

---@type vim.lsp.Config
return {
  settings = {
    json = {
      format = {
        enable = true,
      },
      schemas = schemas,
      validate = { enable = true },
    },
  },
}
