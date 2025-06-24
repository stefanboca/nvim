---@type vim.lsp.Config
return {
  cmd = { vim.env.HOME .. "/src/3rd/ruff/target/release/ty", "server" },
  settings = {
    ty = {
      inlayHints = {
        variableTypes = true,
        functionArgumentNames = true,
      },
      experimental = {
        rename = true,
      },
    },
  },
}
