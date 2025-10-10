_G.dd = function(...)
  vim.print(...)
  return ...
end
_G.bt = function() print(debug.traceback()) end

_G.Config = {}

_G.Config.augroup = vim.api.nvim_create_augroup("custom-config", { clear = true })
function _G.Config.new_autocmd(event, pattern, callback, desc)
  local opts = { group = _G.Config.augroup, pattern = pattern, callback = callback, desc = desc }
  vim.api.nvim_create_autocmd(event, opts)
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
