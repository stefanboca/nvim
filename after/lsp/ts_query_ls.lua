---@type vim.lsp.Config
return {
  init_options = {
    parser_install_directories = {
      -- set in init.lua
      vim.g.treesitter_runtime_dir .. "/parser",
    },
  },
}
