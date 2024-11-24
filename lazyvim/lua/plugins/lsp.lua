return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        update_in_insert = true,
        float = {
          spacing = 4,
          border = "rounded",
          focusable = true,
          source = "if_many",
        },
        virtual_text = false,
      },
    },
  },

  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        -- softwrap = 20,
        multiple_diag_under_cursor = true,
        multilines = true,
        show_all_diags_on_cursorline = true,
        enable_on_insert = true,
      },
    },
    config = function(_, opts)
      local diags = require("tiny-inline-diagnostic.diagnostic")
      Snacks.toggle({
        name = "Diagnostics",
        get = function()
          return diags.enabled
        end,
        set = diags.toggle,
      }):map("<leader>ud")
      require("tiny-inline-diagnostic").setup(opts)
    end,
  },
}
