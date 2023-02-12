-- require("lvim.lsp.manager").setup("ruff_lsp")
require("lvim.lsp.manager").setup("pyright")

local null_ls = require("null-ls")

require("lvim.lsp.null-ls.formatters").setup {
    null_ls.builtins.formatting.black,
}

-- require "lvim.lsp.null-ls.linters".setup {
--     null_ls.builtins.diagnostics.ruff,
-- }
