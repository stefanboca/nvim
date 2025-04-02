---@type vim.lsp.Config
return {
  cmd = { "biome", "lsp-proxy" },
  filetypes = {
    "astro",
    "css",
    "graphql",
    "javascript",
    "javascript.jsx",
    "javascriptreact",
    "json",
    "jsonc",
    "svelte",
    "typescript",
    "typescript.tsx",
    "typescriptreact",
    "vue",
  },
  root_markers = { "biome.json", "biome.jsonc", "package.json" },
  workspace_required = true,
}
