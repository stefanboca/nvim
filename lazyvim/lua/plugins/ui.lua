return {
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
    "LazyVim/LazyVim",
    opts = { colorscheme = "tokyonight" },
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
      filesystem = {
        window = {
          fuzzy_finder_mappings = {
            ["<c-j>"] = "move_cursor_down",
            ["<c-k>"] = "move_cursor_up",
          },
        },
      },
    },
  },

  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   dependencies = {
  --     "saifulapm/neotree-file-nesting-config",
  --   },
  --   opts = function(_, opts)
  --     opts.window.mappings["e"] = "toggle_node"
  --     opts.nesting_rules =
  --       vim.tbl_extend("force", opts.nesting_rules or {}, require("neotree-file-nesting-config").nesting_rules)
  --   end,
  -- },

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
