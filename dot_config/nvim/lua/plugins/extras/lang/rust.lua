return {
  {
    "crates.nvim",
    opts = {
      completion = {
        blink = {
          use_custom_kind = true,
        },
      },
    },
  },

  {
    "rustaceanvim",
    opts = {
      server = {
        -- stylua: ignore
        on_attach = function(_, bufnr)
          vim.keymap.set("n", "K", function() vim.cmd.RustLsp({"hover", "actions"}) end, { desc = "Hover (Rust)", buffer = bufnr })
          vim.keymap.set("n", "<leader>ce", function() vim.cmd.RustLsp("expandMacro") end, { desc = "Expand Macro (Rust)", buffer = bufnr })
          vim.keymap.set("n", "<leader>co", function() vim.cmd.RustLsp("openDocs") end, { desc = "Open Docs (Rust)", buffer = bufnr })
          vim.keymap.set("n", "<leader>cO", function() vim.cmd.RustLsp("openCargo") end, { desc = "Open Cargo.toml (Rust)", buffer = bufnr })
          vim.keymap.set("n", "<leader>cp", function() vim.cmd.RustLsp("parentModule") end, { desc = "Open Parent Module (Rust)", buffer = bufnr })
          vim.keymap.set("n", "<leader>dR", function() vim.cmd.RustLsp("debuggables") end, { desc = "Debuggables (Rust)", buffer = bufnr })
        end,
        default_settings = {
          -- rust-analyzer language server configuration
          ["rust-analyzer"] = {
            files = {
              excludeDirs = {
                ".direnv",
                ".git",
                ".github",
                ".gitlab",
                "bin",
                "node_modules",
                "target",
                "venv",
                ".venv",
                ".jj",
              },
            },
          },
        },
      },
    },
  },
}
