local now_if_args, later = _G.Config.now_if_args, MiniDeps.later
local packadd = vim.cmd.packadd

-- now(function()
--   add("lewis6991/async.nvim")
-- end)

now_if_args(function()
  packadd("nvim-treesitter-textobjects")
  packadd("nvim-treesitter-context")

  local treesitter = require("nvim-treesitter")

  local filetypes = vim.list.unique(
    vim.iter(treesitter.get_available()):map(vim.treesitter.language.get_filetypes):flatten(1):totable()
  )

  local ts_start = function(ev)
    local lang = vim.treesitter.language.get_lang(ev.match)
    if not lang then return end
    vim.treesitter.start(ev.buf)

    if vim.treesitter.query.get(lang, "indents") ~= nil then
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
    if vim.treesitter.query.get(lang, "folds") ~= nil then
      vim.wo.foldmethod = "expr"
      vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end
  end
  _G.Config.new_autocmd("FileType", filetypes, ts_start, "Start tree-sitter")

  require("treesitter-context").setup({
    mode = "cursor",
    max_lines = 3,
  })

  vim.filetype.add({ extension = { koto = "koto" } })
end)

now_if_args(function()
  packadd("nvim-lspconfig")

  vim.lsp.log.set_level(vim.env.SNV_LSP_DEBUG ~= nil and vim.log.levels.TRACE or vim.log.levels.OFF)
  vim.lsp.inlay_hint.enable()

  vim.lsp.enable({
    -- keep-sorted start
    "bashls",
    "biome",
    "clangd",
    "docker_language_server",
    "fish_lsp",
    "glsl_analyzer",
    "jdtls",
    "jsonls",
    "just",
    "koto",
    "lua_ls",
    "marksman",
    "neocmake",
    "nil_ls",
    "ruff",
    "svelte",
    "tailwindcss",
    "tinymist",
    "tombi",
    "ts_query_ls",
    "ty",
    "vtsls",
    "yamlls",
    "zls",
    -- keep-sorted end
  })
end)

later(function() packadd("nvim.undotree") end)

later(function() packadd("live-rename.nvim") end)

later(function()
  packadd("tiny-code-action.nvim")
  require("tiny-code-action").setup({
    backend = "difftastic",
    picker = { "snacks" },
  })
end)

later(function()
  packadd("nvim-ts-autotag")
  require("nvim-ts-autotag").setup()
end)

later(function()
  packadd("conform.nvim")

  require("conform").setup({
    format_on_save = function(bufnr)
      if vim.g.autoformat_disable == true or vim.b[bufnr].autoformat_disable == true then return end
      return { timeout_ms = 800 }
    end,
    default_format_opts = {
      timeout_ms = 3000,
      async = false,
      quiet = false,
      lsp_format = "fallback",
    },
    formatters = {
      ["keep-sorted"] = {
        condition = function(_, ctx)
          return vim.api.nvim_buf_call(ctx.buf, function() return vim.fn.search("keep-sorted", "nw") ~= 0 end)
        end,
      },
      koto = { command = "koto", args = { "--format" } },
      typstyle = {
        prepend_args = function(_, ctx)
          local tw = vim.bo[ctx.buf].textwidth
          return tw > 0 and { "--wrap-text", "--column", tw } or {}
        end,
      },
    },
    formatters_by_ft = {
      ["*"] = { "keep-sorted" },
      -- keep-sorted start
      astro = { "biome" },
      c = { "clang-format" },
      cpp = { "clang-format" },
      css = { "biome" },
      docker = { "dockerfmt" },
      fish = { "fish_indent" },
      graphql = { "biome" },
      handlebars = { "prettierd" },
      html = { "biome" },
      javascript = { "biome" },
      javascriptreact = { "biome" },
      json = { "biome" },
      json5 = { "biome" },
      jsonc = { "biome" },
      just = { "just" },
      kdl = { "kdlfmt" },
      koto = { "koto" },
      less = { "prettierd" },
      lua = { "stylua" },
      markdown = { "prettierd" },
      nix = { "alejandra" },
      python = { "ruff_format", "ruff_organize_imports" },
      query = { lsp_format = "prefer" },
      rust = { "rustfmt" },
      scss = { "prettierd" },
      sh = { "shfmt" },
      svelte = { "biome" },
      toml = { "tombi" },
      typescript = { "biome" },
      typescriptreact = { "biome" },
      typst = { "typstyle" },
      vue = { "biome" },
      yaml = { "prettierd" },
      -- keep-sorted end
    },
  })
end)

later(function()
  packadd("nvim-lint")

  require("lint").linters_by_ft = {
    cmake = { "cmakelint" },
    dockerfile = { "hadolint" },
    markdown = { "markdownlint-cli2" },
    nix = { "deadnix", "statix" },
    fish = { "fish" },
  }

  _G.Config.new_autocmd(
    { "BufWritePost", "BufReadPost", "InsertLeave" },
    nil,
    _G.Config.debounce(300, function() require("lint").try_lint() end),
    "Run linters"
  )
end)

later(function()
  packadd("nvim-dap")

  local dap = require("dap")

  local sign = vim.fn.sign_define
  sign("DapStopped", { text = "󰁕 ", texthl = "DapStopped", priority = 1000 })
  sign("DapBreakpoint", { text = " ", texthl = "DapBreakpoint", priority = 1000 })
  sign("DapBreakpointCondition", { text = " ", texthl = "DapBreakpointCondition", priority = 1000 })
  sign("DapBreakpointRejected", { text = " ", texthl = "DapBreakpointRejected", priority = 1000 })
  sign("DapLogPoint", { text = ".>", texthl = "DapLogPoint", priority = 1000 })

  packadd("one-small-step-for-vimkind")
  dap.adapters.nlua = function(callback, config)
    callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
  end
  dap.configurations.lua = {
    {
      type = "nlua",
      request = "attach",
      name = "Attach to running Neovim instance",
    },
  }

  packadd("nvim-dap-virtual-text")
  require("nvim-dap-virtual-text").setup({})

  packadd("nvim-dap-view")
  local dap_view = require("dap-view")
  dap_view.setup({
    winbar = {
      controls = { enabled = true },
      sections = { "watches", "exceptions", "breakpoints", "scopes", "threads", "repl", "console" },
    },
  })
  dap.listeners.after.event_initialized["dap-view-config"] = function() dap_view.open() end
  dap.listeners.before.event_terminated["dap-view-config"] = function() dap_view.close() end
  dap.listeners.before.event_exited["dap-view-config"] = function() dap_view.close() end
end)

later(function()
  packadd("neotest")

  ---@diagnostic disable-next-line: missing-fields
  require("neotest").setup({
    ---@diagnostic disable-next-line: missing-fields
    status = { virtual_text = true },
    ---@diagnostic disable-next-line: missing-fields
    output = { open_on_run = false },
    ---@diagnostic disable-next-line: missing-fields
    summary = { animated = false },
  })
end)

later(function()
  packadd("dial.nvim")

  local augend = require("dial.augend")
  require("dial.config").augends:register_group({
    default = {
      augend.integer.alias.decimal_int,
      augend.integer.alias.hex,
      augend.semver.alias.semver,
      augend.constant.alias.bool,
      augend.constant.new({ elements = { "True", "False" } }),
      augend.constant.new({ elements = { "and", "or" } }),
      augend.constant.new({ elements = { "&&", "||" }, word = false }),
      augend.constant.new({ elements = { "+", "-" }, word = false }),
      augend.constant.alias.alpha,
      augend.constant.alias.Alpha,
    },
  })
end)

later(function()
  packadd("neogen")
  require("neogen").setup({})
end)

later(function() require("clasp").setup({ pairs = { ["$"] = "$" } }) end)

later(function()
  packadd("toggleterm.nvim")
  require("toggleterm").setup({
    size = function() return vim.o.lines / 3 end,
    open_mapping = "<C-/>",
  })
end)

later(function()
  packadd("trouble.nvim")
  require("trouble").setup({ focus = true, auto_preview = false, preview = { type = "float" } })
end)

later(function()
  packadd("snacks.nvim")
  require("snacks").setup({
    picker = { enabled = false, ui_select = false },
    words = { enabled = true },
  })
end)

later(function()
  packadd("neogit")
  require("neogit").setup({})
end)

_G.Config.on_cmd("DiffEditor", function()
  packadd("hunk.nvim")

  require("hunk").setup({
    keys = {
      global = {
        accept = { "<LocalLeader><CR>" },
        focus_tree = { "<LocalLeader>e" },
      },
      diff = {
        prev_hunk = { "[h", "<C-p>" },
        next_hunk = { "]h", "<C-n>" },
      },
    },
  })
end)

_G.Config.new_autocmd("BufRead", "Cargo.toml", function()
  packadd("crates.nvim")

  require("crates").setup({
    completion = {
      blink = { use_custom_kind = true },
      crates = { enabled = true },
    },
    lsp = {
      enabled = true,
      actions = true,
      completion = true,
      hover = true,
    },
  })

  later(function()
    ---@diagnostic disable-next-line: missing-fields
    require("neotest").setup({ adapters = { require("rustaceanvim.neotest") } })
  end)
end, "load crates.nvim", true)
