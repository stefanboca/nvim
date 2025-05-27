---@type vim.lsp.Config
return {
  cmd = { vim.env.HOME .. "/data/software/utils/ruff/target/release/ty", "server" },
  settings = {
    experimental = {
      completions = {
        enable = true,
      },
    },
  },
}
