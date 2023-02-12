-- require("lvim.lsp.manager").setup("ruff_lsp")
require("lvim.lsp.manager").setup("pyright")

local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup { { name = "black", filetype = "python" } }
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--     { name = "ruff", filetype = "python" },
-- }
