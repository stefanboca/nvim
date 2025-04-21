local function on_attach(bufnr, client_id)
  local client = vim.lsp.get_client_by_id(client_id)
  if not client then return end

  local function has(method) return client:supports_method(method, bufnr) end

  local function map(mode, lhs, rhs, opts)
    opts.silent = opts.silent ~= false
    opts.buffer = bufnr
    vim.keymap.set(mode, lhs, rhs, opts)
  end

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

vim.lsp.set_log_level(vim.log.levels.OFF)

local register_handler = vim.lsp.handlers["client/registerCapability"]
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
  root_markers = { ".jj" },
  handlers = {
    ["client/registerCapability"] = function(err, res, ctx)
      for _, bufnr in ipairs(vim.lsp.get_buffers_by_client_id(ctx.client_id)) do
        on_attach(bufnr, ctx.client_id)
      end
      return register_handler(err, res, ctx)
    end,
  },
})

vim.lsp.inlay_hint.enable()

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev) on_attach(ev.buf, ev.data.client_id) end,
})

-- vim.lsp.enable("harper_ls")

return {
  {
    "neovim/nvim-lspconfig",
    config = false,
    init = function()
      -- prepend to load first and allow custom settings to override
      vim.opt.rtp:prepend(vim.fn.stdpath("data") .. "/lazy/nvim-lspconfig")
    end,
  },

  -- rename in-place with the LSP and live feedback
  {
    "saecki/live-rename.nvim",
    keys = {
      { "cr", function() require("live-rename").rename() end, desc = "Rename" },
    },
  },

  -- patch snacks lsp_config picker for vim.lsp.config instead of the old nvim_lspconfig api
  {
    "snacks.nvim",
    keys = {
      { "<leader>cl", function() Snacks.picker.lsp_config() end, desc = "Lsp Info" },
    },
    opts = function()
      ---@param opts snacks.picker.lsp.config.Config
      ---@type snacks.picker.finder
      Snacks.picker.sources.lsp_config.finder = function(opts, ctx)
        local main_buf = vim.api.nvim_win_get_buf(ctx.picker.main)

        local items = {} ---@type table<string, snacks.picker.lsp.config.Item>
        for _, client in ipairs(vim.lsp.get_clients()) do
          items[client.name] = items[client.name]
            or {
              name = client.name,
              buffers = {},
              config = client.config,
              attached = true,
              enabled = true,
              cmd = client.config.cmd,
            }
          for buf in pairs(client.attached_buffers) do
            items[client.name].buffers[buf] = true
          end
          items[client.name].attached_buf = items[client.name].buffers[main_buf]
        end

        for name, config in pairs(vim.lsp._enabled_configs) do
          items[name] = items[name]
            or {
              name = name,
              buffers = {},
              enabled = true,
              config = config.resolved_config,
            }
        end

        for _, f in ipairs(vim.api.nvim_get_runtime_file("lsp/*.lua", true)) do
          local name = vim.fn.fnamemodify(f, ":t:r")
          if name and name ~= "" and items[name] == nil then
            items[name] = items[name]
              or {
                name = name,
                buffers = {},
                config = vim.lsp.config[name],
                enabled = false,
              }
          end
        end

        ---@param cb async fun(item: snacks.picker.finder.Item)
        return function(cb)
          local bins = Snacks.picker.util.get_bins()
          for name, item in pairs(items) do
            local config = item.config or {}
            config = vim.deepcopy(config)
            local cmd = item.cmd or type(config.cmd) == "table" and config.cmd or nil
            local bin ---@type string?
            local installed = false
            if type(cmd) == "table" and #cmd > 0 then
              ---@type string[]
              cmd = vim.deepcopy(cmd)
              cmd[1] = svim.fs.normalize(cmd[1])
              if cmd[1]:find("/") then
                installed = vim.fn.filereadable(cmd[1]) == 1
                bin = cmd[1]
              else
                bin = bins[cmd[1]] or cmd[1]
                installed = bins[cmd[1]] ~= nil
              end
              cmd[1] = vim.fs.basename(cmd[1])
            end
            local want = (not opts.installed or installed) and (not opts.configured or item.enabled)
            if opts.attached == true and not item.attached then
              want = false
            elseif type(opts.attached) == "number" then
              local buf = opts.attached == 0 and main_buf or opts.attached
              if not item.buffers[buf] then want = false end
            end
            if want then
              cb({
                name = name,
                cmd = cmd,
                bin = bin,
                installed = installed,
                enabled = item.enabled or false,
                buffers = item.buffers,
                attached = item.attached or false,
                attached_buf = item.attached_buf or false,
                text = name .. " " .. table.concat(config.filetypes or {}, " "),
                config = config,
              })
            end
          end
        end
      end
    end,
  },
}
