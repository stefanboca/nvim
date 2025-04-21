---@type vim.lsp.Config
return {
  -- rustaceanvim-specific key
  -- rustaceanvim overrides settings as needed, which doesn't happen with the standard `settings` key
  default_settings = {
    ["rust-analyzer"] = {
      cargo = {
        features = "all",
      },
    },
  },
  on_attach = function(_, bufnr)
    vim.keymap.set("n", "<leader>ce", "<cmd>RustLsp expandMacro<CR>", { desc = "Expand Macro (Rust)", buffer = bufnr })
    vim.keymap.set("n", "<leader>co", "<cmd>RustLsp openDocs<CR>", { desc = "Open Docs (Rust)", buffer = bufnr })
    vim.keymap.set("n", "<leader>cO", "<cmd>RustLsp openCargo<CR>", { desc = "Open Cargo.toml (Rust)", buffer = bufnr })
    vim.keymap.set(
      "n",
      "<leader>cp",
      "<cmd>RustLsp parentModule<CR>",
      { desc = "Open Parent Module (Rust)", buffer = bufnr }
    )
    vim.keymap.set("n", "<leader>dR", "<cmd>RustLsp debuggables<CR>", { desc = "Debuggables (Rust)", buffer = bufnr })
  end,
}
