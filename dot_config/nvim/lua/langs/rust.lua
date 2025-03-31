return {
  {
    "mason.nvim",
    opts = { ensure_isntalled = { "codelldb" } },
  },

  -- LSP for Cargo.toml
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = {
        blink = { use_custom_kind = true },
        crates = { enabled = true },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },

  {
    "mrcjkb/rustaceanvim",
    ft = { "rust" },
    dependencies = { "blink.cmp" },
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
      },
    },
    config = function(_, opts)
      local package_path = require("mason-registry").get_package("codelldb"):get_install_path() .. "/extenstions/"
      local codelldb = package_path .. "adapter/codelldb"
      local library_path = package_path .. "lldb/lib/liblldb.so"
      opts.dap = {
        adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb, library_path),
      }

      vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts)
    end,
  },
}
