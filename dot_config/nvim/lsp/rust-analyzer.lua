---@type vim.lsp.Config
return {
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
        loadOutDirsFromCheck = true,
        buildScripts = {
          enable = true,
        },
      },
      checkOnSave = true,
      diagnostics = {
        enable = true,
      },
      procMacro = {
        enable = true,
        ignored = {
          ["async-trait"] = { "async_trait" },
          ["napi-derive"] = { "napi" },
          ["async-recursion"] = { "async_recursion" },
        },
      },
      files = {
        excludeDirs = {
          ".direnv",
          ".git",
          ".github",
          ".gitlab",
          ".jj",
          "bin",
          "node_modules",
          "target",
          "venv",
          ".venv",
        },
      },
    },
  },
  on_attach = function(_, bufnr)
    vim.keymap.set("n", "K", "<cmd>RustLsp hover actions<CR>", { desc = "Hover (Rust)", buffer = bufnr })
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
