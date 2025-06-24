---@param client vim.lsp.Client
---@param bufnr integer
local function on_attach(client, bufnr)
  local function has(method) return client:supports_method(method, bufnr) end

  local function map(mode, lhs, rhs, opts)
    opts.noremap = opts.noremap ~= false
    opts.silent = opts.silent ~= false
    opts.buffer = bufnr
    vim.keymap.set(mode, lhs, rhs, opts)
  end

  map("n", "gr", function() Snacks.picker.lsp_references() end, { nowait = true, desc = "References" })
  map("n", "gI", function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
  map("n", "gy", function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto Type Definition" })
  map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
  map("n", "K", function() vim.lsp.buf.hover({ border = "rounded", anchor_bias = "below" }) end, { desc = "Hover" })
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

  if has("textDocument/codeAction") then
    map(
      { "n", "x" },
      "<leader>ca",
      function() require("tiny-code-action").code_action({}) end,
      { desc = "Code Action" }
    )
  end
  if has("textDocument/codeLens") then
    map({ "n", "x" }, "<leader>cc", vim.lsp.codelens.run, { desc = "Run Codelens" })
    map({ "n", "x" }, "<leader>cC", vim.lsp.codelens.refresh, { desc = "Refresh Codelens" })
  end
  if has("textDocument/documentHighlight") then
    map("n", "]]", function() Snacks.words.jump(vim.v.count1) end, { desc = "Next Reference" })
    map("n", "[[", function() Snacks.words.jump(-vim.v.count1) end, { desc = "Prev Reference" })
  end

  if has("textDocument/documentColor") then vim.lsp.document_color.enable(true, bufnr, { style = "virtual" }) end
end

return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    opts_extend = { "enabled" },
    opts = { enabled = { "harper_ls" } },
    config = function(_, opts)
      local register_handler = vim.lsp.handlers["client/registerCapability"]
      vim.lsp.config("*", {
        capabilities = {
          textDocument = { foldingRange = { dynamicRegistration = false, lineFoldingOnly = true } },
          workspace = { fileOperations = { didRename = true, willRename = true } },
        },
        handlers = {
          ["client/registerCapability"] = function(err, res, ctx)
            local client = vim.lsp.get_client_by_id(ctx.client_id)
            if not client then return end
            for bufnr, _ in pairs(client.attached_buffers) do
              on_attach(client, bufnr)
            end
            return register_handler(err, res, ctx)
          end,
        },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if not client then return end

          for server, server_on_attach in pairs(opts.on_attach or {}) do
            if server == client.name then server_on_attach(client, ev.buf) end
          end
          on_attach(client, ev.buf)
        end,
      })

      vim.lsp.set_log_level(vim.env.NVIM_LSP_DEBUG ~= nil and vim.log.levels.TRACE or vim.log.levels.OFF)
      vim.lsp.enable(opts.enabled or {})
      vim.lsp.inlay_hint.enable()
    end,
  },

  -- Rename in-place with the LSP and live feedback
  {
    "saecki/live-rename.nvim",
    keys = { { "cr", function() require("live-rename").rename() end, desc = "Rename" } },
  },

  {
    "rachartier/tiny-code-action.nvim",
    opts = {
      backend = "difftastic",
      picker = {
        "snacks",
      },
    },
  },

  -- Patch snacks lsp_config picker for vim.lsp.config instead of the old nvim_lspconfig API
  {
    "snacks.nvim",
    keys = { { "<leader>cl", function() Snacks.picker.lsp_config() end, desc = "Lsp Info" } },
    opts = function()
      Snacks.picker.sources.lsp_config.finder = require("my.utils.lsp").lsp_config_find
      Snacks.picker.sources.lsp_config.preview = require("my.utils.lsp").lsp_config_preview
    end,
  },
}
