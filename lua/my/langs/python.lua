return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "pydoc" } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = { enabled = { "basedpyright", "ruff" } },
  },

  {
    "nvim-dap",
    dependencies = {
      {
        "mfussenegger/nvim-dap-python",
        config = function() require("dap-python").setup("uv") end,
        keys = {
          { "<leader>dPt", function() require("dap-python").test_method() end, desc = "Debug Method", ft = "python" },
          { "<leader>dPc", function() require("dap-python").test_class() end, desc = "Debug Class", ft = "python" },
        },
      },
    },
  },

  { "nvim-neotest/neotest-python" },
  {
    "nvim-neotest/neotest",
    opts = {
      adapters = {
        setmetatable({}, {
          __index = function(_, key) return require("neotest-python")[key] end,
        }),
      },
    },
  },
}
