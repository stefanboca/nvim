local M = {}

---@param name string
function M.lspconfig(name)
  local lspconfig = loadfile(vim.fn.stdpath("data") .. "/lazy/nvim-lspconfig/lsp/" .. name .. ".lua")
  if lspconfig ~= nil then return lspconfig() end
end

---@type snacks.picker.finder
---@param opts snacks.picker.lsp.config.Config
---@param ctx snacks.picker.finder.ctx
function M.lsp_config_find(opts, ctx)
  local main_buf = vim.api.nvim_win_get_buf(ctx.picker.main)

  local lsps = {}

  for name, _ in pairs(vim.lsp._enabled_configs) do
    lsps[name] = true
  end
  for _, file in ipairs(vim.api.nvim_get_runtime_file("lsp/*.lua", true)) do
    local name = vim.fn.fnamemodify(file, ":t:r")
    if lsps[name] == nil then lsps[name] = false end
  end
  ---@diagnostic disable-next-line:invisible
  for name, _ in pairs(vim.lsp.config._configs) do
    if name ~= "*" and lsps[name] == nil then lsps[name] = false end
  end

  local items = {}

  for name, enabled in pairs(lsps) do
    items[name] = {
      config = vim.lsp.config[name],
      enabled = enabled,
      buffers = {},
      attached = false,
    }
  end

  for _, client in ipairs(vim.lsp.get_clients()) do
    local name = client.name
    items[name] = items[name] or { buffers = {} }
    items[name].config = client.config
    items[name].enabled = true
    items[name].attached = true

    for buf in pairs(client.attached_buffers) do
      items[name].buffers[buf] = true
    end
  end

  ---@param cb async fun(item: snacks.picker.finder.Item)
  return function(cb)
    for name, item in pairs(items) do
      local config = item.config or {}

      local cmd
      local bin
      local installed = true

      if type(config.cmd) == "table" then
        cmd = config.cmd
        if #cmd > 0 then
          bin = vim.fn.exepath(cmd[1])
          if bin == "" then
            bin = cmd[1]
            installed = false
          end
        else
          installed = false
        end
      end

      if
        not (
          (opts.installed == true and not installed)
          or (opts.configured and not item.enabled)
          or (opts.attached == true and not item.attached)
          or (type(opts.attached) == "number" and not item.buffers[opts.attached == 0 and main_buf or opts.attached])
        )
      then
        cb({
          name = name,
          cmd = cmd,
          bin = bin,
          installed = installed,
          enabled = item.enabled,
          buffers = item.buffers,
          attached = item.attached or false,
          attached_buf = item.buffers[main_buf] or false,
          config = config,
          text = name .. " " .. table.concat(config.filetypes or {}, " "),
        })
      end
    end
  end
end

---@param ctx snacks.picker.preview.ctx
function M.lsp_config_preview(ctx)
  local config = ctx.item.config ---@type vim.lsp.ClientConfig
  local item = ctx.item --[[@as snacks.picker.lsp.config.Item]]
  local lines = {} ---@type string[]
  lines[#lines + 1] = "# `" .. item.name .. "`"
  lines[#lines + 1] = ""

  ---@param path string
  local function norm(path) return vim.fn.fnamemodify(path, ":p:~"):gsub("[\\/]$", "") end

  local function list(values)
    return table.concat(vim.tbl_map(function(v) return "`" .. v .. "`" end, values), ", ")
  end

  if item.cmd then lines[#lines + 1] = "- **cmd**: `" .. table.concat(item.cmd, " ") .. "`" end

  if item.installed then
    if item.bin then lines[#lines + 1] = "- **installed**: `" .. norm(item.bin) .. "`" end
    lines[#lines + 1] = "- **enabled**: " .. (item.enabled and "yes" or "no")
  else
    lines[#lines + 1] = "- **installed**: " .. (item.bin and "`" .. item.bin .. "` " or "") .. "not installed"
  end
  local ft = config.filetypes or {}
  if #ft > 0 then lines[#lines + 1] = "- **filetypes**: " .. list(ft) end

  local clients = vim.lsp.get_clients({ name = item.name })
  if #clients > 0 then
    for _, client in ipairs(clients) do
      lines[#lines + 1] = ""
      lines[#lines + 1] = "## Client [id=" .. client.id .. "]"
      lines[#lines + 1] = ""
      local roots = {} ---@type string[]
      for _, ws in ipairs(client.workspace_folders or {}) do
        roots[#roots + 1] = vim.uri_to_fname(ws.uri)
      end
      roots = #roots == 0 and { client.root_dir } or roots
      if #roots > 0 then
        if #roots > 1 then
          lines[#lines + 1] = "- **workspace**:"
          for _, root in ipairs(roots) do
            lines[#lines + 1] = "    - `" .. norm(root) .. "`"
          end
        else
          lines[#lines + 1] = "- **workspace**: `" .. norm(roots[1]) .. "`"
        end
      end
      lines[#lines + 1] = "- **buffers**: " .. list(vim.tbl_keys(client.attached_buffers))
      local settings = vim.inspect(client.settings)
      lines[#lines + 1] = "- **settings**:"
      lines[#lines + 1] = "```lua\n" .. settings .. "\n```"
    end
  end

  if item.docs then
    lines[#lines + 1] = ""
    lines[#lines + 1] = "## Docs"
    lines[#lines + 1] = ""
    lines[#lines + 1] = item.docs
  end
  ctx.preview:set_lines(lines)
  ctx.preview:highlight({ ft = "markdown" })
end

return M
