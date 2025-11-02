local add = MiniDeps.add

local function cargo_build_hook(params)
  vim.notify("Building " .. params.name, vim.log.levels.INFO)
  local obj = vim.system({ "cargo", "build", "--release" }, { cwd = params.path, timeout = 300 * 1000 }):wait()
  if obj.code == 0 then
    vim.notify("Building " .. params.name .. " done", vim.log.levels.INFO)
  else
    vim.notify("Building " .. params.name .. " failed", vim.log.levels.ERROR)
  end
end

MiniDeps.now(function()
  if vim.env.NVIM_DEV ~= "blink.lib" then
    add("Saghen/blink.lib")
  else
    vim.cmd.packadd("blink.lib.dev")
  end
end)

_G.Config.now_if_args(function()
  if vim.env.NVIM_DEV ~= "blink.indent" then
    add("Saghen/blink.indent")
  else
    vim.cmd.packadd("blink.indent.dev")
  end

  require("blink.indent").setup({
    scope = {
      highlights = {
        "BlinkPairsRed",
        "BlinkPairsOrange",
        "BlinkPairsYellow",
        "BlinkPairsGreen",
        "BlinkPairsCyan",
        "BlinkPairsBlue",
        "BlinkPairsViolet",
      },
    },
  })
end)

_G.Config.now_if_args(function()
  if vim.env.NVIM_DEV ~= "blink.pairs" then
    add({ source = "Saghen/blink.pairs", hooks = { post_install = cargo_build_hook, post_checkout = cargo_build_hook } })
  else
    vim.cmd.packadd("blink.pairs.dev")
  end

  require("blink.pairs").setup({
    highlights = {
      matchparen = {
        include_surrounding = true,
      },
      enabled = true,
      groups = {
        "BlinkPairsRed",
        "BlinkPairsOrange",
        "BlinkPairsYellow",
        "BlinkPairsGreen",
        "BlinkPairsCyan",
        "BlinkPairsBlue",
        "BlinkPairsViolet",
      },
    },
  })
end)

_G.Config.now_if_args(function()
  if vim.env.NVIM_DEV ~= "blink.cmp" then
    local function build() vim.cmd.BlinkCmp("build") end
    add({ source = "Saghen/blink.cmp", hooks = { post_install = build, post_checkout = build } })
  else
    vim.cmd.packadd("blink.cmp.dev")
  end

  require("blink.cmp").setup({
    keymap = {
      preset = "enter",
      ["<C-k>"] = false, -- conflicts with digraphs
    },

    cmdline = {
      completion = {
        list = { selection = { preselect = false } },
        menu = {
          auto_show = true,
          draw = {
            columns = { { "label", "label_description", gap = 1 } },
          },
        },
      },
    },

    completion = {
      list = { selection = { preselect = false } },
      menu = {
        border = "none",
        direction_priority = { "n", "s" },
        draw = { treesitter = { "lsp" } },
      },
      documentation = { auto_show = true },
      ghost_text = { enabled = true },
    },

    fuzzy = { prebuilt_binaries = { download = false } },

    signature = {
      enabled = true,
      trigger = { show_on_insert = true },
      window = {
        direction_priority = { "s", "n" },
        show_documentation = true,
      },
    },

    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      per_filetype = { lua = { inherit_defaults = true, "lazydev" } },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 10, -- show at a higher priority than lsp
        },
      },
    },
  })
end)
