---@type vim.lsp.Config
return {
  -- rustaceanvim-specific key
  -- rustaceanvim overrides settings as needed, which doesn't happen with the standard `settings` key
  default_settings = {
    ["rust-analyzer"] = {
      cargo = {
        features = "all",
      },
      diagnostics = {
        experimental = {
          enable = true,
        },
      },
    },
  },
}
