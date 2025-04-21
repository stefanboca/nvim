---@type vim.lsp.Config
return {
  cmd = { vim.env.HOME .. "/data/software/utils/ruff/target/release/red_knot", "server" },
  filetypes = { "python" },
  root_marksrs = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "pyrightconfig.json",
  },
}
