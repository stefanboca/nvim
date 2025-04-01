vim.diagnostic.config({
  underline = true,
  update_in_insert = true,
  float = { border = "rounded", source = "if_many" },
  virtual_text = false,
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
})

return {
  -- better diagnostics list and others
  {
    "folke/trouble.nvim",
    lazy = true,
    cmd = { "Trouble" },
    opts = {
      modes = {
        lsp = {
          win = { position = "right" },
        },
      },
    },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics" },
      { "<leader>cs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols" },
      { "<leader>cS", "<cmd>Trouble lsp toggle<cr>", desc = "LSP references/definitions/..." },
      { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List" },
    },
  },

  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        show_source = true,
        set_arrow_to_diag_color = true,
        multilines = {
          enabled = true,
          always_show = true,
        },
        show_all_diags_on_cursorline = true,
        enable_on_insert = false,
        enable_on_select = false,
      },
    },
  },
}
