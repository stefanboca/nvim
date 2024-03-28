return {
  -- Disable native_snippets for now, until support is better
  -- { import = "lazyvim.plugins.extras.coding.native_snippets" },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      opts.completion.completeopt = "menu,menuone,noinsert,noselect"

      local cmp = require("cmp")
      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
      })
    end,
  },
}
