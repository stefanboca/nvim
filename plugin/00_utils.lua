function _G.dbg(...)
  vim.print(...)
  return ...
end
function _G.bt() vim.print(debug.traceback()) end

-- Pull in mini.deps without modifying packpath, for MiniDeps.now, MiniDeps.later, etc
_G.MiniDeps = require("mini.deps")

_G.Config = {
  augroup = vim.api.nvim_create_augroup("custom-config", { clear = true }),
}

_G.Config.now_if_args = vim.fn.argc(-1) > 0 and MiniDeps.now or MiniDeps.later

---@param event string|string[]
---@param pattern string|string[]?
---@param callback string|function
---@param desc string?
---@param once boolean?
function _G.Config.new_autocmd(event, pattern, callback, desc, once)
  local opts = { group = _G.Config.augroup, pattern = pattern, once = once, callback = callback, desc = desc }
  vim.api.nvim_create_autocmd(event, opts)
end

---@param ms number
---@param f function
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

---@param cmds string|string[]
---@param f function
function _G.Config.on_cmd(cmds, f)
  if type(cmds) ~= "table" then cmds = { cmds } end

  local loaded = false
  local function load()
    if loaded then return end
    for _, cmd in ipairs(cmds) do
      vim.api.nvim_del_user_command(cmd)
    end
    f()
    loaded = true
  end

  local function complete(_, line)
    load()
    return vim.fn.getcompletion(line, "cmdline")
  end

  for _, cmd in ipairs(cmds) do
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
      if event.args and event.args ~= "" and info.nargs and info.nargs:find("[1?]") then
        command.args = { event.args }
      end

      vim.cmd(command)
    end, {
      bang = true,
      range = true,
      nargs = "*",
      complete = complete,
    })
  end
end

---@param suffix string
---@param rhs string|function
---@param desc string
---@param buffer integer?
function _G.Config.nmapb_lleader(suffix, rhs, desc, buffer)
  vim.keymap.set("n", "<LocalLeader>" .. suffix, rhs, { desc = desc, buffer = buffer or 0 })
end
