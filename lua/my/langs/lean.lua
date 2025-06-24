return {
  {
    "Julian/lean.nvim",
    event = { "BufReadPre *.lean", "BufNewFile *.lean" },
    dependencies = { "neovim/nvim-lspconfig" },
    ---@type lean.Config
    opts = {
      mappings = true,
    },
  },
}
