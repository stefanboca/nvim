vim.cmd("setlocal shiftwidth=2 softtabstop=2 expandtab tw=100")

local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
    {
        command = "proselint",
        args = { "--json" },
        filetypes = { "markdown", "tex" },
    },
}
