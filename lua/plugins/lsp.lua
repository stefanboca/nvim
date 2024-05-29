return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        update_in_insert = true,
        virtual_text = false,
        float = {
          spacing = 4,
          border = "rounded",
          focusable = true,
          source = "if_many",
        },
      },
    },
  },
}
