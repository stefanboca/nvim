local now_if_args = _G.Config.now_if_args
local packadd = vim.cmd.packadd

MiniDeps.now(function()
  if vim.env.SNV_DEV ~= "blink.lib" then
    packadd("blink.lib")
  else
    packadd("blink.lib.dev")
  end
end)

now_if_args(function()
  if vim.env.SNV_DEV ~= "blink.indent" then
    packadd("blink.indent")
  else
    packadd("blink.indent.dev")
  end

  require("blink.indent").setup({
    scope = {
      highlights = {
        "BlinkIndentViolet",
        "BlinkIndentBlue",
        "BlinkIndentCyan",
        "BlinkIndentGreen",
        "BlinkIndentYellow",
        "BlinkIndentOrange",
        "BlinkIndentRed",
      },
    },
  })
end)

now_if_args(function()
  if vim.env.SNV_DEV ~= "blink.pairs" then
    packadd("blink.pairs")
  else
    packadd("blink.pairs.dev")
  end

  require("blink.pairs").setup({
    highlights = {
      matchparen = {
        include_surrounding = true,
      },
      enabled = true,
      groups = {
        "BlinkPairsPurple",
        "BlinkPairsBlue",
        "BlinkPairsCyan",
        "BlinkPairsGreen",
        "BlinkPairsYellow",
        "BlinkPairsOrange",
        "BlinkPairsRed",
      },
    },
  })
end)

now_if_args(function()
  if vim.env.SNV_DEV ~= "blink.cmp" then
    packadd("blink.cmp")
  else
    packadd("blink.cmp.dev")
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

    fuzzy = {
      implementation = "rust",
      prebuilt_binaries = { download = false },
    },

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
