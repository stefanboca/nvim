return {
  -- {
  --   "folke/drop.nvim",
  --   opts = {
  --     filetype = { "snacks_dashboard" },
  --   },
  -- },

  {
    "catppuccin/nvim",
    optional = true,
    lazy = true,
    opts = {
      background = {
        dark = "macchiato",
      },
      transparent_background = not vim.g.neovide,
      term_colors = true,
    },
  },
  {
    "folke/tokyonight.nvim",
    optional = true,
    opts = {
      style = "night",
      transparent = not vim.g.neovide,
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        component_separators = "|",
        section_separators = "",
      },
    },
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = { mappings = { e = "toggle_node" } },
      nesting_rules = {
        ["README.*"] = {
          ignore_case = true,
          pattern = "README%.(.*)$",
          files = { "AUTHORS", "CHANGELOG*", "CONTRIBUT*", "LICENSE*", "RELEASE_NOTES*", "ROADMAP*", "SECURITY*" },
        },
        [".gitignore"] = {
          pattern = "%.gitignore$",
          files = { "%.gitattributes", "%.gitmodules" },
        },
        ["pyproject.toml"] = {
          pattern = "pyproject%.toml$",
          files = { "%.python-version", "uv%.lock" },
        },
        ["Cargo.toml"] = {
          pattern = "Cargo%.toml$",
          files = { "*clippy%.toml", "*rustfmt%.toml", "Cargo%.lock", "rust-toolchain%.toml" },
        },
        ["flake.nix"] = {
          pattern = "flake%.nix$",
          files = { "flake%.lock" },
        },
        ["package.json"] = {
          pattern = "package%.json$",
          -- stylua: ignore
          files = { "%.node-version", "%.npm*", "%.pnpm*", "package-lock%.json", "pnpm*", "yarn*", "netlify*", "vercel*", "*eslint*", "*prettier*", "node_modules" },
        },
        ["svelte.config.*"] = {
          pattern = "svelte%.config%.(.*)$",
          -- stylua: ignore
          files = { "postcss%.config%.*", "tailwind%.config%.*", "windi%.config%.*",  "tsconfig%.*", "vite%.config%.*", "%.svelte-kit"},
        },
        ["+layout.svelte"] = {
          pattern = "+layout%.svelte$",
          files = { "+layout%.*" },
        },
        ["+page.svelte"] = {
          pattern = "+page%.svelte$",
          files = { "+page%.*" },
        },
      },
    },
  },

  {
    "s1n7ax/nvim-window-picker",
    lazy = true,
    opts = {
      hint = "floating-big-letter",
      show_prompt = false,
      filter_rules = {
        bo = {
          filetype = {
            "Trouble",
            "alpha",
            "dashboard",
            "edgy",
            "fzf",
            "help",
            "lazy",
            "lazyterm",
            "mason",
            "neo-tree",
            "noice",
            "notify",
            "snacks_dashboard",
            "snacks_notif",
            "snacks_terminal",
            "snacks_win",
            "toggleterm",
            "trouble",
          },
          buftype = { "Outline", "Trouble", "nofile", "qf", "terminal", "trouble" },
        },
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "SmiteshP/nvim-navbuddy",
        dev = true,
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim",
        },
        keys = {
          {
            "<leader>cN",
            function()
              require("nvim-navbuddy").open()
            end,
            desc = "Open Navbuddy",
          },
        },
        opts = { lsp = { auto_attach = true } },
      },
    },
  },

  {
    "meznaric/key-analyzer.nvim",
    cmd = "KeyAnalyzer",
    opts = {},
  },
}
