local null_ls = require("null-ls")

require("lvim.lsp.null-ls.linters").setup {
    { name = "cspell", filetypes = { "markdown" } }
}

require "lvim.lsp.null-ls.code_actions".setup {
    { name = "cspell", filetypes = { "markdown" } }
}
