return {
  { "rcarriga/nvim-dap-ui", enabled = false },

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "igorlfs/nvim-dap-view",
    },
    keys = {
      { "<leader>dr", false },
      { "<leader>du", false },
      {
        "<leader>dS",
        function()
          local widgets = require("dap.ui.widgets")
          widgets.centered_float(widgets.scopes, { border = "rounded" })
        end,
        desc = "View Scopes",
      },
    },
  },

  {
    "igorlfs/nvim-dap-view",
    keys = {
      { "<leader>du", function() require("dap-view").toggle() end, desc = "Toggle nvim-dap-view" },
      { "<leader>de", function() require("dap-view").add_expr() end, desc = "Watch Expression", mode = { "n", "v" } },
    },
    opts = {
      winbar = {
        sections = { "watches", "exceptions", "breakpoints", "threads", "repl", "console" },
      },
    },
    config = function(_, opts)
      local dap = require("dap")
      local dap_view = require("dap-view")
      dap_view.setup(opts)

      dap.listeners.after.event_initialized["dap-view-config"] = function() dap_view.open() end
      dap.listeners.before.event_terminated["dap-view-config"] = function() dap_view.close() end
      dap.listeners.before.event_exited["dap-view-config"] = function() dap_view.close() end
    end,
  },
}
