vim.api.nvim_create_autocmd("User", {
  pattern = "TSUpdate",
  callback = function()
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.parsers").lean = {
      ---@diagnostic disable-next-line: missing-fields
      install_info = {
        url = "https://github.com/Julian/tree-sitter-lean",
      },
    }
  end,
})

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { enabled = { "lean" } },
  },

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
