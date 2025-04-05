return {
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function() require("conform").format() end,
        mode = { "n", "v" },
        desc = "Format",
      },
      {
        "<leader>cF",
        function() require("conform").format({ formatters = { "injected" } }) end,
        mode = { "n", "v" },
        desc = "Format Injected Langs",
      },
    },
    ---@type conform.setupOpts
    opts = {
      format_on_save = function(bufnr)
        if vim.g.autoformat == false or vim.b[bufnr].autoformat == false then return end
        return {
          lsp_format = "fallback",
          timeout_ms = 500,
        }
      end,
      default_format_opts = {
        timeout_ms = 3000,
        async = false,
        quiet = false,
        lsp_format = "fallback",
      },
    },
    init = function() vim.o.formatexpr = "v:lua.require'conform'.formatexpr()" end,
  },
}
