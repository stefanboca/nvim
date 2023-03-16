local null_ls = require("null-ls")

require("lvim.lsp.null-ls.formatters").setup {
    null_ls.builtins.formatting.gersemi
}
