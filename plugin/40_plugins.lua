local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later
local now_if_args = _G.Config.now_if_args

now(function() add("brianhuster/unnest.nvim") end)

now(function()
  add("nvim-lua/plenary.nvim")
  add("nvim-neotest/nvim-nio")
  -- add("ManifTanjim/nui.nvim")
end)

now(function()
  add({ name = "catppuccin", source = "catppuccin/nvim" })

  local catppuccin = require("catppuccin")
  catppuccin.setup({
    background = { dark = "mocha" },
    dim_inactive = { enabled = true },
    lsp_styles = { enabled = true },
    auto_integrations = true,
    custom_highlights = function(c)
      local hls = {
        MatchParen = { fg = "NONE", bg = c.surface1, style = { "bold" } },
        ["@comment.error"] = { fg = c.red, bg = "NONE" },
        ["@comment.warning"] = { fg = c.yellow, bg = "NONE" },
        ["@comment.hint"] = { fg = c.blue, bg = "NONE" },
        ["@comment.todo"] = { fg = c.flamingo, bg = "NONE" },
        ["@comment.note"] = { fg = c.rosewater, bg = "NONE" },
      }

      local function pairs_hl(color, fg)
        hls["BlinkPairs" .. color] = { fg = fg }
        hls["BlinkIndentUnderline" .. color] = { default = true, sp = fg, underline = true }
      end

      pairs_hl("Red", c.red)
      pairs_hl("Orange", c.peach)
      pairs_hl("Yellow", c.yellow)
      pairs_hl("Green", c.green)
      pairs_hl("Cyan", c.teal)
      pairs_hl("Blue", c.blue)
      pairs_hl("Violet", c.mauve)

      return hls
    end,
  })
  catppuccin.load()
end)

later(function() vim.cmd.packadd("nvim.undotree") end)

now_if_args(function()
  add({
    source = "nvim-treesitter/nvim-treesitter",
    checkout = "main",
    hooks = { post_checkout = function() vim.cmd("TSUpdate") end },
  })
  add({ source = "nvim-treesitter/nvim-treesitter-textobjects", checkout = "main" })
  add({ source = "nvim-treesitter/nvim-treesitter-context" })

  local languages = {
    "astro",
    "bash",
    "c",
    "cmake",
    "comment",
    "cpp",
    "css",
    "diff",
    "dockerfile",
    "dot",
    "ecma",
    "fish",
    "glsl",
    "graphql",
    "html",
    "html_tags",
    "java",
    "javascript",
    "jsdoc",
    "json",
    "json5",
    "jsonc",
    "jsx",
    "just",
    "kdl",
    "koto",
    "lua",
    "luadoc",
    "luap",
    "markdown",
    "markdown_inline",
    "nix",
    "printf",
    "pydoc",
    "python",
    "query",
    "re2c",
    "regex",
    "rust",
    "scss",
    "svelte",
    "toml",
    "typescript",
    "typst",
    "vim",
    "vimdoc",
    "vue",
    "yaml",
    "zig",
  }

  require("nvim-treesitter").install(languages)

  local filetypes = vim.list.unique(vim.iter(languages):map(vim.treesitter.language.get_filetypes):flatten(1):totable())

  local ts_start = function(ev)
    vim.treesitter.start(ev.buf)

    local lang = vim.treesitter.language.get_lang(ev.match)
    if not lang then return end
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

  -- NOTE: lean TS parser is installed but not enabled
  _G.Config.new_autocmd("User", "TSUpdate", function()
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.parsers").lean = { install_info = { url = "https://github.com/Julian/tree-sitter-lean" } }
  end, "Install tree-sitter lean")

  vim.filetype.add({ extension = { koto = "koto" } })
end)

now_if_args(function() add("avm99963/vim-jjdescription") end)

now_if_args(function()
  add("neovim/nvim-lspconfig")
  add("b0o/SchemaStore.nvim")

  vim.lsp.log.set_level(vim.env.NVIM_LSP_DEBUG ~= nil and vim.log.levels.TRACE or vim.log.levels.OFF)
  vim.lsp.inlay_hint.enable()

  vim.lsp.enable({
    "bashls",
    "biome",
    "clangd",
    "docker_langauge_server",
    "fish_lsp",
    "glsl_analyzer",
    "harper_ls",
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
    "ty",
    "vstls",
    "yamlls",
    "zls",
  })
end)

now_if_args(function()
  add("Julian/lean.nvim")
  require("lean").setup({ mappings = true })
end)

now_if_args(function()
  add("folke/lazydev.nvim")
  require("lazydev").setup({
    library = {
      { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      { path = vim.fn.stdpath("data") .. "/site/pack/deps/start/mini.nvim", words = { "Mini%u%l*" } },
      { path = "snacks.nvim", words = { "Snacks" } },
    },
  })
end)

now_if_args(function()
  add("Saecki/crates.nvim")
  add({ source = "mrcjkb/rustaceanvim" })

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
end)

later(function()
  add("rachartier/tiny-code-action.nvim")
  require("tiny-code-action").setup({
    backend = "difftastic",
    picker = {
      "buffer",
      opts = {
        hotkeys = true,
        hotkeys_mode = "sequential",
        auto_preview = true,
      },
    },
  })
end)

later(function()
  add("windwp/nvim-ts-autotag")
  require("nvim-ts-autotag").setup()
end)

later(function()
  add("saecki/live-rename.nvim")
  -- add("rachartier/tiny-code-action.nvim")
end)

later(function()
  add("stevearc/conform.nvim")

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
      koto = { command = "koto", args = { "--format" } },
      typstyle = { prepend_args = { "--wrap-text", "--column", "100" } }, -- TODO: make `columns` dynamic, based on textwidth
    },
    formatters_by_ft = {
      astro = { "biome" },
      css = { "biome" },
      docker = { "dockerfmt" },
      fish = { "fish_indent" },
      graphql = { "biome" },
      handlebars = { "prettierd" },
      html = { "prettierd" },
      javascript = { "biome" },
      javascriptreact = { "biome" },
      json = { "biome" },
      json5 = { "biome" },
      jsonc = { "biome" },
      just = { "just" },
      koto = { "koto" },
      less = { "prettierd" },
      lua = { "stylua" },
      markdown = { "prettierd" },
      nix = { "alejandra" },
      query = { "format-queries" },
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
    },
  })

  -- vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
end)

later(function()
  add("mfussenegger/nvim-lint")

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
  add("mfussenegger/nvim-dap")
  add("igorlfs/nvim-dap-view")
  add("theHamsta/nvim-dap-virtual-text")
  add("jbyuki/one-small-step-for-vimkind")
  add("mfussenegger/nvim-dap-python")

  require("nvim-dap-virtual-text").setup({})
  vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
  vim.fn.sign_define(
    "DapStopped",
    { text = "󰁕 ", texthl = "DiagnosticWarn", linehl = "DapStoppedLine", numhl = "DapStoppedLine" }
  )
  vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DiagnosticInfo", priority = 1000 })
  vim.fn.sign_define("DapBreakpointCondition", { text = " ", texthl = "DiagnosticInfo", priority = 1000 })
  vim.fn.sign_define("DapBreakpointRejected", { text = " ", texthl = "DiagnosticError", priority = 1000 })
  vim.fn.sign_define("DapLogPoint", { text = ".>", texthl = "DiagnosticInfo" })

  local dap_view = require("dap-view")
  dap_view.setup({
    winbar = {
      controls = { enabled = true },
      sections = { "watches", "exceptions", "breakpoints", "scopes", "threads", "repl", "console" },
    },
  })

  local dap = require("dap")
  dap.listeners.after.event_initialized["dap-view-config"] = function() dap_view.open() end
  dap.listeners.before.event_terminated["dap-view-config"] = function() dap_view.close() end
  dap.listeners.before.event_exited["dap-view-config"] = function() dap_view.close() end

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

  require("dap-python").setup("uv")
end)

later(function()
  add("nvim-neotest/neotest")
  add("nvim-neotest/neotest-python")

  ---@diagnostic disable-next-line: missing-fields
  require("neotest").setup({
    ---@diagnostic disable-next-line: missing-fields
    status = { virtual_text = true },
    ---@diagnostic disable-next-line: missing-fields
    output = { open_on_run = false },
    ---@diagnostic disable-next-line: missing-fields
    summary = { animated = false },
    adapters = {
      require("neotest-python"),
      require("rustaceanvim.neotest"),
    },
  })
end)

later(function() add("MagicDuck/grug-far.nvim") end)

later(function()
  add("monaqa/dial.nvim")

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
  add("danymat/neogen")

  require("neogen").setup()
end)

later(function() add("xzbdmw/clasp.nvim") end)

later(function()
  add("akinsho/toggleterm.nvim")
  require("toggleterm").setup({
    size = function() return vim.o.lines / 3 end,
    open_mapping = "<C-/>",
  })
end)

later(function()
  add("folke/trouble.nvim")

  require("trouble").setup({ focus = true, preview = { type = "float" } })
end)

later(function()
  add("folke/snacks.nvim")

  require("snacks").setup({
    picker = { enabled = true },
    words = { enabled = true },
  })
end)
