return {
  {
    "jmbuhr/otter.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = function()
      vim.api.nvim_create_user_command("OtterActivate", function()
        require("otter").activate()
      end, { desc = "Activate Otter for the current buffer" })
      vim.api.nvim_create_user_command("OtterDeactivate", function()
        require("otter").deactivate()
      end, { desc = "Deactivate Otter for the current buffer" })

      return {
        diagnostic_update_events = { "BufWritePost", "InsertLeave" },
      }
    end,
  },
}
