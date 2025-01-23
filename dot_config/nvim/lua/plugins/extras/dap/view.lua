return {
  { "rcarriga/nvim-dap-ui", enabled = false },

  {
    "mfussenegger/nvim-dap",
    dependencies = { "igorlfs/nvim-dap-view" },
  },

  {
    "igorlfs/nvim-dap-view",
    keys = {
      {
        "<leader>du",
        function()
          require("dap-view").toggle()
        end,
        desc = "Toggle nvim-dap-view",
      },
      {
        "<leader>de",
        function()
          require("dap-view").add_expr()
        end,
        desc = "Watch Expression",
        mode = { "n", "v" },
      },
    },
    opts = {},
    config = function(_, opts)
      local dap = require("dap")
      local dap_view = require("dap-view")
      dap_view.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dap_view.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dap_view.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dap_view.close()
      end
    end,
  },
}
