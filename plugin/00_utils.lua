_G.dd = function(...)
  vim.print(...)
  return ...
end
_G.bt = function() print(debug.traceback()) end

_G.Config = {}

function _G.Config.nmapb_lleader(suffix, rhs, desc)
  vim.keymap.set("n", "<LocalLeader>" .. suffix, rhs, { desc = desc, buffer = 0 })
end

_G.Config.augroup = vim.api.nvim_create_augroup("custom-config", { clear = true })
function _G.Config.new_autocmd(event, pattern, callback, desc)
  local opts = { group = _G.Config.augroup, pattern = pattern, callback = callback, desc = desc }
  vim.api.nvim_create_autocmd(event, opts)
end
function _G.Config.new_autocmd_lsp_attach(client_name, callback, desc)
  local opts = {
    group = _G.Config.augroup,
    callback = function(ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      if not client or client.name ~= client_name then return end
      callback(ev)
    end,
    desc = desc,
  }
  vim.api.nvim_create_autocmd("LspAttach", opts)
end

_G.Config.now_if_args = vim.fn.argc(-1) > 0 and MiniDeps.now or MiniDeps.later

function _G.Config.debounce(ms, f)
  local timer = assert(vim.uv.new_timer())
  return function(...)
    local argv = { ... }
    timer:start(ms, 0, function()
      timer:stop()
      vim.schedule_wrap(f)(unpack(argv))
    end)
  end
end

function _G.Config.create_quit_on_write()
  local buffer = vim.api.nvim_get_current_buf()
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = vim.api.nvim_create_augroup("quit_on_write." .. buffer, { clear = true }),
    once = true,
    buffer = buffer,
    callback = vim.schedule_wrap(function()
      vim.cmd.bdelete()
      vim.cmd.quit()
    end),
    desc = "Quit on write",
  })
end
