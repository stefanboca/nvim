vim.cmd("setlocal formatexpr= shiftwidth=2 softtabstop=2 expandtab tw=100")

local null_ls = require("null-ls")

require("lvim.lsp.null-ls.formatters").setup {
    null_ls.builtins.formatting.latexindent
}

require("lvim.lsp.null-ls.linters").setup {
    -- null_ls.builtins.diagnostics.proselint,
    { name = "cspell", filetypes = { "tex" } }
    -- null_ls.builtins.diagnostics.chktex,
    -- null_ls.builtins.diagnostics.vale
}

require "lvim.lsp.null-ls.code_actions".setup {
    -- null_ls.builtins.code_actions.proselint,
    { name = "cspell", filetypes = { "tex" } }
}
