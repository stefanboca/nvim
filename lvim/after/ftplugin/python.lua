-- require("lvim.lsp.manager").setup("ruff_lsp")
require("lvim.lsp.manager").setup("pyright")
-- require("lvim.lsp.manager").setup("jedi_language_server")
-- require("lvim.lsp.manager").setup("pylyzer")
-- require("lvim.lsp.manager").setup("pyre")
-- require("lvim.lsp.manager").setup("pylsp")

local null_ls = require("null-ls")

require("lvim.lsp.null-ls.formatters").setup {
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.isort,
}

-- require "lvim.lsp.null-ls.linters".setup {
--     null_ls.builtins.diagnostics.mypy,
-- }
