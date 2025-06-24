vim.filetype.add({ extension = { koto = "koto" } })

return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters = { koto = { command = "koto", args = { "--format" } } },
      formatters_by_ft = { koto = { "koto" } },
    },
  },
}
