vim.lsp.enable({ "basedpyright", "ruff" })

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "python" } },
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

  {
    "joshzcold/python.nvim",
    ft = { "python" },
    ---@type python.Config
    opts = {
      keymaps = {
        mappings = {},
      },
    },
    keys = {
      { "<leader>cv", function() require("python.venv").pick_venv() end, ft = "python", desc = "Select Venv" },
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
