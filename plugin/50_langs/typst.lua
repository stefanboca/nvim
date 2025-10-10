_G.Tinymist = {}
local open_previews = {}

local function map(suffix, cb, bufnr, desc)
  vim.keymap.set("n", "<LocalLeader>" .. suffix, cb, { buffer = bufnr, desc = desc })
end
local function unmap(suffix, bufnr) vim.keymap.del("n", "<LocalLeader>" .. suffix, { buffer = bufnr }) end

local function map_start(client, bufnr)
  map("p", function() _G.Tinymist.preview_start(client, bufnr) end, bufnr, "Typst start preview")
end
local function on_start(client, bufnr, result)
  unmap("p", bufnr)

  map("p", function() _G.Tinymist.preview_open(bufnr) end, bufnr, "Typst open preview")
  map("S", function() _G.Tinymist.preview_stop(client, bufnr) end, bufnr, "Typst stop preview")
  map("s", function() _G.Tinymist.toggle_autoscroll(bufnr) end, bufnr, "Autoscroll toggle")

  local group = vim.api.nvim_create_augroup("tinymist_preview." .. tostring(bufnr), { clear = true })
  vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    group = group,
    buffer = bufnr,
    callback = function()
      if not (open_previews[bufnr] and open_previews[bufnr].scroll_enabled) then return end
      if not client.attached_buffers[bufnr] or client:is_stopped() then return true end

      local cursor = vim.api.nvim_win_get_cursor(0)
      local filepath = vim.api.nvim_buf_get_name(bufnr)
      vim.schedule(
        function()
          client:exec_cmd({
            command = "tinymist.scrollPreview",
            title = "Scroll Preview",
            arguments = {
              tostring(bufnr),
              { event = "panelScrollTo", filepath = filepath, line = cursor[1] - 1, character = cursor[2] },
            },
          }, { bufnr = bufnr })
        end
      )
    end,
  })

  vim.api.nvim_create_autocmd("BufDelete", {
    group = group,
    buffer = bufnr,
    callback = function() _G.Tinymist.preview_stop(client, bufnr) end,
  })

  local uri = "http://" .. result.staticServerAddr
  vim.ui.open(uri)
  open_previews[bufnr] = {
    uri = uri,
    scroll_enabled = true,
    client_id = client.id,
  }
end
function _G.Tinymist.preview_start(client, bufnr)
  if open_previews[bufnr] then return end

  local file = vim.api.nvim_buf_get_name(bufnr)

  client:exec_cmd({
    command = "tinymist.doStartPreview",
    title = "Start Preview",
    arguments = {
      {
        "--partial-rendering",
        "true",
        "--data-plane-host",
        "127.0.0.1:0",
        "--control-plane-host",
        "127.0.0.1:0",
        "--static-file-host",
        "127.0.0.1:0",
        "--task-id",
        tostring(bufnr),
        "--",
        file,
      },
    },
  }, { bufnr = bufnr }, function(err, result)
    if err then
      vim.notify("Failed to start preview: " .. err.message or err, vim.log.levels.ERROR)
      return
    end

    on_start(client, bufnr, result)
  end)
end
function _G.Tinymist.preview_open(bufnr)
  if not open_previews[bufnr] then return end

  vim.notify("Opening preview", vim.log.levels.INFO)
  vim.ui.open(open_previews[bufnr].uri)
end
local function on_stop(client, bufnr)
  if not open_previews[bufnr] then return end
  open_previews[bufnr] = nil

  vim.notify("Stopped preview " .. tostring(bufnr))

  vim.api.nvim_del_augroup_by_name("tinymist_preview." .. tostring(bufnr))
  unmap("p", bufnr)
  unmap("s", bufnr)
  unmap("S", bufnr)

  if client then map_start(client, bufnr) end
end

---@param client vim.lsp.Client
---@param bufnr integer
function _G.Tinymist.preview_stop(client, bufnr)
  if not open_previews[bufnr] then return end

  client:exec_cmd({
    command = "tinymist.doKillPreview",
    title = "Stop Preview",
    arguments = { tostring(bufnr) },
  }, { bufnr = bufnr })

  on_stop(client, bufnr)
end
function _G.Tinymist.preview_dispose(err, result, ctx)
  if err then return end
  local bufnr = tonumber(result.taskId)
  if bufnr then on_stop(vim.lsp.get_client_by_id(ctx.client_id), bufnr) end
end
function _G.Tinymist.toggle_autoscroll(bufnr)
  open_previews[bufnr].scroll_enabled = not open_previews[bufnr].scroll_enabled
  if open_previews[bufnr].scroll_enabled then
    print("  autoscroll")
  else
    print("noautoscroll")
  end
end
function _G.Tinymist.on_attach(client, bufnr) map_start(client, bufnr) end
function _G.Tinymist.on_exit(client)
  for bufnr, data in pairs(open_previews) do
    if data.client_id == client.client_id then on_stop(client, bufnr) end
  end
end

_G.Config.now_if_args(function()
  _G.Config.new_autocmd("LspAttach", nil, function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client or client.name ~= "tinymist" then return end
    _G.Tinymist.on_attach(client, ev.buf)
  end)
  _G.Config.new_autocmd("LspDetach", nil, function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client or client.name ~= "tinymist" then return end
    _G.Tinymist.on_exit(client)
  end)

  vim.lsp.config("tinymist", {
    handlers = {
      ["tinymist/preview/scrollSource"] = _G.Tinymist.preview_scrollSource,
      ["tinymist/preview/dispose"] = _G.Tinymist.preview_dispose,
    },
  })
end)
