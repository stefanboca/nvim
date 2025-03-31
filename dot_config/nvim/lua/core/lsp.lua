local function on_attach(bufnr, client_id)
  local client = vim.lsp.get_client_by_id(client_id)
  if not client then return end

  local function has(method) return client:supports_method(method, bufnr) end

  local function map(mode, lhs, rhs, opts)
    opts.silent = opts.silent ~= false
    opts.buffer = bufnr
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  map("n", "<leader>cl", "<cmd>checkhealth vim.lsp<CR>", { desc = "Lsp Info" })
  map("n", "gr", function() Snacks.picker.lsp_references() end, { nowait = true, desc = "References" })
  map("n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
  map("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto Type Definition" })
  map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
  map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
  map("n", "<leader>cR", function() Snacks.rename.rename_file() end, { desc = "Rename File" })

  if has("textDocument/definition") then
    map("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
  end

  if has("textDocument/documentSymbol") then
    map("n", "<leader>ss", function() Snacks.picker.lsp_symbols() end, { desc = "LSP Symbols" })
  end
  if has("workspace/symbols") then
    map("n", "<leader>sS", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "LSP Workspace Symbols" })
  end

  if has("textDocument/signatureHelp") then
    map("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature Help" })
    map("i", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
  end

  if has("textDocument/codeAction") then
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
  end
  if has("textDocument/codeLens") then
    map({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run, { desc = "Run Codelens" })
    map({ "n", "v" }, "<leader>cC", vim.lsp.codelens.refresh, { desc = "Refresh Codelens" })
  end
  if has("textDocument/documentHighlight") then
    map("n", "]]", function() Snacks.words.jump(vim.v.count1) end, { desc = "Next Reference" })
    map("n", "[[", function() Snacks.words.jump(-vim.v.count1) end, { desc = "Prev Reference" })
  end

  if has("textDocument/foldingRange") then
    local win = vim.api.nvim_get_current_win()
    vim.wo[win][0].foldexpr = 'v"lua.vim.lsp.foldexpr()"'
  end
end

vim.lsp.config("*", {
  capabilities = {
    textDocument = {
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      },
    },
    workspace = {
      fileOperations = {
        didRename = true,
        willRename = true,
      },
    },
  },
  root_markers = { ".git", ".jj" },
})

vim.lsp.set_log_level(vim.log.levels.OFF)

local lsps = {}
for _, file in ipairs(vim.api.nvim_get_runtime_file("lsp/*.lua", true)) do
  table.insert(lsps, vim.fn.fnamemodify(file, ":t:r"))
end
vim.lsp.enable(lsps)

vim.lsp.inlay_hint.enable()

-- vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
--   callback = function(ev) vim.lsp.codelens.refresh({ bufnr = ev.buf }) end,
-- })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev) on_attach(ev.buf, ev.data.client_id) end,
})
local register_handler = vim.lsp.handlers["client/registerCapability"]
vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
  for _, bufnr in ipairs(vim.lsp.get_buffers_by_client_id(ctx.client_id)) do
    on_attach(bufnr, ctx.client_id)
  end
  return register_handler(err, res, ctx)
end

return {
  -- cmdline tools and lsp servers
  {

    "williamboman/mason.nvim",
    lazy = false,
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts_extend = { "ensure_installed" },
    config = function(_, opts)
      require("mason").setup(opts)
      for _, tool in ipairs(opts.ensure_installed) do
        local p = require("mason-registry").get_package(tool)
        if not p:is_installed() then p:install() end
      end
    end,
  },

  -- rename in-place with the LSP and live feedback
  {
    "saecki/live-rename.nvim",
    keys = {
      { "cr", function() require("live-rename").rename() end, desc = "Rename" },
    },
  },

  {
    "b0o/SchemaStore.nvim",
    lazy = true,
  },
}
