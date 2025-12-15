function _G.dbg(...)
  vim.print(...)
  return ...
end
function _G.bt() vim.print(debug.traceback()) end

-- Pull in mini.deps without modifying packpath, for MiniDeps.now, MiniDeps.later, etc
_G.MiniDeps = require("mini.deps")

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
function _G.Config.now_if_args_and_ft(ft, ...)
  if vim.bo.ft == ft then
    MiniDeps.now(...)
  else
    _G.Config.now_if_args(...)
  end
end

function _G.Config.on_command(cmd, fn)
  local function load()
    vim.api.nvim_del_user_command(cmd)
    fn()
  end

  local function complete(_, line)
    load()
    return vim.fn.getcompletion(line, "cmdline")
  end

  vim.api.nvim_create_user_command(cmd, function(event)
    load()

    local command = {
      cmd = cmd,
      bang = event.bang or nil,
      mods = event.smods,
      args = event.fargs,
      count = event.count >= 0 and event.range == 0 and event.count or nil,
    }

    if event.range == 1 then
      command.range = { event.line1 }
    elseif event.range == 2 then
      command.range = { event.line1, event.line2 }
    end

    local info = vim.api.nvim_get_commands({})[cmd] or vim.api.nvim_buf_get_commands(0, {})[cmd]
    command.nargs = info.nargs
    if event.args and event.args ~= "" and info.nargs and info.nargs:find("[1?]") then command.args = { event.args } end

    vim.cmd(command)
  end, {
    bang = true,
    range = true,
    nargs = "*",
    complete = complete,
  })
end

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
