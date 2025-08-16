return {
  {
    "Julian/lean.nvim",
    event = { "BufReadPre *.lean", "BufNewFile *.lean" },
    dependencies = { "neovim/nvim-lspconfig" },
    ---@module 'lean.config'
    ---@type lean.Config
    opts = {
      mappings = true,
    },
  },
}
