local M = {}

local open_previews = {}

local function map_start(client, bufnr)
  vim.keymap.set(
    "n",
    "<localleader>p",
    function() M.preview_start(client, bufnr) end,
    { buffer = bufnr, desc = "Start Typst Preview" }
  )
end

local function on_start(client, bufnr, result)
  vim.keymap.del("n", "<localleader>p", { buffer = bufnr })

  vim.keymap.set(
    "n",
    "<localleader>p",
    function() M.preview_open(bufnr) end,
    { buffer = bufnr, desc = "Open Typst Preview" }
  )
  vim.keymap.set(
    "n",
    "<localleader>S",
    function() M.preview_stop(client, bufnr) end,
    { buffer = bufnr, desc = "Stop Typst Preview" }
  )
  vim.keymap.set("n", "<localleader>s", function()
    open_previews[bufnr].scroll_enabled = not open_previews[bufnr].scroll_enabled
    if open_previews[bufnr].scroll_enabled then
      vim.notify("Autoscroll enabled", vim.log.levels.INFO)
    else
      vim.notify("Autoscroll disabled", vim.log.levels.INFO)
    end
  end, { buffer = bufnr, desc = "Toggle Autoscroll" })

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
    callback = function() M.preview_stop(client, bufnr) end,
  })

  local uri = "http://" .. result.staticServerAddr
  vim.ui.open(uri)
  open_previews[bufnr] = {
    uri = uri,
    scroll_enabled = true,
    client_id = client.id,
  }
end

function M.preview_start(client, bufnr)
  if open_previews[bufnr] then return end

  local file = vim.api.nvim_buf_get_name(bufnr)

  client:exec_cmd({
    command = "tinymist.doStartPreview",
    title = "Start Preview",
    arguments = {
      {
        "--partial-rendering",
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
      vim.notify("Failed to start preview: " .. err, vim.log.levels.ERROR)
      return
    end

    on_start(client, bufnr, result)
  end)
end

function M.preview_open(bufnr)
  if not open_previews[bufnr] then return end

  vim.notify("Opening preview", vim.log.levels.INFO)
  vim.ui.open(open_previews[bufnr].uri)
end

local function on_stop(client, bufnr)
  if not open_previews[bufnr] then return end
  open_previews[bufnr] = nil

  vim.notify("Stopped preview " .. tostring(bufnr))

  vim.api.nvim_del_augroup_by_name("tinymist_preview." .. tostring(bufnr))
  vim.keymap.del("n", "<localleader>p", { buffer = bufnr })
  vim.keymap.del("n", "<localleader>s", { buffer = bufnr })
  vim.keymap.del("n", "<localleader>S", { buffer = bufnr })

  if client then map_start(client, bufnr) end
end

---@param client vim.lsp.Client
---@param bufnr integer
function M.preview_stop(client, bufnr)
  if not open_previews[bufnr] then return end

  client:exec_cmd({
    command = "tinymist.doKillPreview",
    title = "Stop Preview",
    arguments = { tostring(bufnr) },
  }, { bufnr = bufnr })

  on_stop(client, bufnr)
end

function M.preview_dispose(err, result, ctx)
  if err then return end
  local bufnr = tonumber(result.taskId)
  if bufnr then on_stop(vim.lsp.get_client_by_id(ctx.client_id), bufnr) end
end

function M.on_attach(client, bufnr) map_start(client, bufnr) end

function M.on_exit(_, _, client_id)
  local client = vim.lsp.get_client_by_id(client_id)
  for bufnr, data in pairs(open_previews) do
    if data.client_id == client_id then on_stop(client, bufnr) end
  end
end

return M
