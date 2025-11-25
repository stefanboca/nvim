local now, later = MiniDeps.now, MiniDeps.later
local now_if_args = _G.Config.now_if_args

now(function()
  require("mini.basics").setup({
    options = { extra_ui = true },
    mappings = {
      option_toggle_prefix = "<Leader>o",
      windows = true,
      move_with_alt = true,
    },
  })
  --
end)

now(function()
  require("mini.icons").setup()
  later(MiniIcons.mock_nvim_web_devicons)
end)

now(function()
  local function predicate(notif)
    if not (notif.data.source == "lsp_progress" and notif.data.client_name == "lua_ls") then return true end
    -- Filter out some LSP progress notifications from 'lua_ls'
    return notif.msg:find("Diagnosing") == nil and notif.msg:find("semantic tokens") == nil
  end
  local custom_sort = function(notif_arr) return MiniNotify.default_sort(vim.tbl_filter(predicate, notif_arr)) end
  require("mini.notify").setup({ content = { sort = custom_sort } })
end)

now(function() require("mini.sessions").setup() end)

now(function()
  local starter = require("mini.starter")
  starter.setup({
    items = {
      starter.sections.sessions(),
      starter.sections.recent_files(10, true, true),
      starter.sections.builtin_actions(),
    },
  })
end)

now(function() require("mini.statusline").setup() end)

now(function()
  require("mini.tabline").setup({
    tabpage_section = "right",
  })
end)

now_if_args(function()
  require("mini.misc").setup()

  MiniMisc.setup_auto_root({ ".git", ".jj", ".root" })
  MiniMisc.setup_restore_cursor()
end)

now_if_args(function()
  require("mini.files").setup({
    options = {
      use_as_default_explorer = true,
    },
    windows = {
      preview = true,
      width_preview = 30,
    },
  })

  local function add_marks()
    MiniFiles.set_bookmark("c", vim.fn.stdpath("config"), { desc = "Config" })
    local minideps_plugins = vim.fn.stdpath("data") .. "/site/pack/deps/opt"
    MiniFiles.set_bookmark("p", minideps_plugins, { desc = "Plugins" })
    MiniFiles.set_bookmark("w", vim.fn.getcwd, { desc = "Working directory" })
  end

  local function rename(ev) Snacks.rename.on_rename_file(ev.data.from, ev.data.to) end
  _G.Config.new_autocmd("User", "MiniFilesExplorerOpen", add_marks, "Add bookmarks")
  _G.Config.new_autocmd("User", "MiniFilesActionRename", rename, "Rename file")
end)

later(function() require("mini.extra").setup() end)

later(function()
  local ai = require("mini.ai")
  ai.setup({
    custom_textobjects = {
      B = MiniExtra.gen_ai_spec.buffer(),
      c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
      f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
      o = ai.gen_spec.treesitter({ a = "@block.outer", i = "@block.inner" }),
    },

    search_method = "cover_or_nearest",
  })
end)

later(function() require("mini.align").setup() end)

later(function() require("mini.bracketed").setup() end)

later(function() require("mini.bufremove").setup() end)

later(function()
  local miniclue = require("mini.clue")
  miniclue.setup({
    window = { delay = vim.o.timeoutlen },
    clues = {
      _G.Config.leader_group_clues,
      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      miniclue.gen_clues.square_brackets(),
      miniclue.gen_clues.windows({ submode_resize = true }),
      miniclue.gen_clues.z(),
    },
    -- Explicitly opt-in for set of common keys to trigger clue window
    triggers = {
      { mode = "n", keys = "<Leader>" },
      { mode = "x", keys = "<Leader>" },
      { mode = "n", keys = "\\" },
      { mode = "n", keys = "[" },
      { mode = "n", keys = "]" },
      { mode = "x", keys = "[" },
      { mode = "x", keys = "]" },
      { mode = "i", keys = "<C-x>" },
      { mode = "n", keys = "g" },
      { mode = "x", keys = "g" },
      { mode = "n", keys = "s" },
      { mode = "x", keys = "s" },
      { mode = "n", keys = "'" },
      { mode = "n", keys = "`" },
      { mode = "x", keys = "'" },
      { mode = "x", keys = "`" },
      { mode = "n", keys = '"' },
      { mode = "x", keys = '"' },
      { mode = "i", keys = "<C-r>" },
      { mode = "c", keys = "<C-r>" },
      { mode = "n", keys = "<C-w>" },
      { mode = "n", keys = "z" },
      { mode = "x", keys = "z" },
    },
  })
end)

later(function() require("mini.comment").setup() end)

later(function() require("mini.diff").setup({ view = { style = "sign" } }) end)

later(function() require("mini.git").setup() end)

later(function()
  local hipatterns = require("mini.hipatterns")
  hipatterns.setup({
    highlighters = {
      hex_color = hipatterns.gen_highlighter.hex_color(),
    },
  })
end)

later(function() require("mini.jump").setup() end)

later(function()
  local jump2d = require("mini.jump2d")
  jump2d.setup({
    spotter = jump2d.gen_spotter.pattern("[^%s%p]+"),
    labels = "asdfghjkl;",
    view = { dim = true, n_steps_ahead = 2 },
  })
  vim.keymap.set({ "n", "x", "o" }, "sj", function() MiniJump2d.start(MiniJump2d.builtin_opts.single_character) end)
end)

later(function()
  local map = require("mini.map")
  map.setup({
    -- Use Braille dots to encode text
    symbols = { encode = map.gen_encode_symbols.dot("4x2") },
    -- Show built-in search matches, 'mini.diff' hunks, and diagnostic entries
    integrations = {
      map.gen_integration.builtin_search(),
      map.gen_integration.diff(),
      map.gen_integration.diagnostic({
        error = "DiagnosticFloatingError",
        warn = "DiagnosticFloatingWarn",
        info = "DiagnosticFloatingInfo",
        hint = "DiagnosticFloatingHint",
      }),
    },
  })

  -- Map built-in navigation characters to force map refresh
  for _, key in ipairs({ "n", "N", "*", "#" }) do
    -- Also open enough folds when jumping to the next match
    local rhs = key .. "zv" .. "<Cmd>lua MiniMap.refresh({}, { lines = false, scrollbar = false })<CR>"
    vim.keymap.set("n", key, rhs)
  end
end)

later(function() require("mini.move").setup() end)

later(function() require("mini.operators").setup() end)

later(function() require("mini.pick").setup() end)

later(function() require("mini.splitjoin").setup() end)

later(function() require("mini.surround").setup() end)

later(function() require("mini.trailspace").setup() end)

later(function() require("mini.visits").setup() end)
