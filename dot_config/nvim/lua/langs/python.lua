vim.lsp.enable({ "basedpyright", "ruff" })

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "python" } },
  },
  {
    "mason.nvim",
    opts = { ensure_isntalled = { "basedpyright", "ruff", "debugpy" } },
  },

  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      "mfussenegger/nvim-dap-python",
      -- stylua: ignore
      keys = {
        { "<leader>dPt", function() require('dap-python').test_method() end, desc = "Debug Method", ft = "python" },
        { "<leader>dPc", function() require('dap-python').test_class() end, desc = "Debug Class", ft = "python" },
      },
    },
  },

  -- Don't mess up DAP adapters provided by nvim-dap-python
  {
    "jay-babu/mason-nvim-dap.nvim",
    optional = true,
    opts = {
      handlers = {
        python = function() end,
      },
    },
  },

  {
    "joshzcold/python.nvim",
    ft = { "python" },
    ---@module 'python'
    ---@type python.Config
    dependencies = {
      { "mfussenegger/nvim-dap" },
      { "mfussenegger/nvim-dap-python" },
      { "MunifTanjim/nui.nvim" },
    },
    opts = {},
    keys = {
      { "<leader>cv", function() require("python.venv").pick_venv() end, ft = "python", desc = "Select Venv" },
    },
  },
}
