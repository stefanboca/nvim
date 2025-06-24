---@type vim.lsp.Config
return {
  cmd = { vim.env.HOME .. "/src/3rd/ruff/target/release/ty", "server" },
  settings = {
    ty = {
      experimental = {
        rename = true,
      },
    },
  },
}
