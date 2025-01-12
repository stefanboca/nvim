return {
  -- colorscheme transparency and styles
  {
    "catppuccin",
    opts = {
      background = {
        dark = "macchiato",
      },
      transparent_background = not vim.g.neovide and vim.g.transparent,
      term_colors = true,
    },
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "storm",
      transparent = not vim.g.neovide and vim.g.transparent,
    },
  },

  -- buffer paths in top right of window
  {
    "b0o/incline.nvim",
    opts = {
      window = {
        padding = 0,
        margin = { horizontal = 0, vertical = 0 },
      },
      render = function(props)
        local buf_path = vim.api.nvim_buf_get_name(props.buf)
        local filename = vim.fn.fnamemodify(buf_path, ":t")
        if filename == "" then
          return
        end
        local dirname = vim.fn.fnamemodify(buf_path, ":~:.:h")

        local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
        local modified = vim.bo[props.buf].modified
        return {
          ft_icon and { " ", ft_icon, " ", guifg = ft_color } or "",
          modified and { " ● ", group = "BufferCurrentMod" } or " ",
          dirname ~= "." and { dirname, "/", group = "Comment" } or "",
          { filename, gui = "bold" },
          " ",
        }
      end,
    },
    specs = {
      -- Remove path from lualine
      {
        "nvim-lualine/lualine.nvim",
        opts = function(_, opts)
          table.remove(opts.sections.lualine_c, 4)
        end,
      },
    },
  },

  -- lyaline style
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        component_separators = "|",
        section_separators = "",
      },
    },
  },
  -- Macro recording indicator
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, {
        function()
          local record_id = vim.fn.reg_recording()
          return (record_id ~= "") and ("recording @" .. record_id) or ""
        end,
        color = { gui = "bold" },
      })
    end,
  },

  -- window picker for neo-tree
  {
    "s1n7ax/nvim-window-picker",
    lazy = true,
    opts = {
      hint = "floating-big-letter",
      show_prompt = false,
      filter_rules = {
        bo = {
          -- stylua: ignore
          filetype = { "Trouble", "alpha", "dashboard", "edgy", "fzf", "help", "lazy", "lazyterm", "mason", "neo-tree", "noice", "notify", "snacks_dashboard", "snacks_notif", "snacks_terminal", "snacks_win", "toggleterm", "trouble", },
          buftype = { "Outline", "Trouble", "nofile", "qf", "terminal", "trouble" },
        },
      },
    },
  },

  -- pretty inline diagnostics
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        multiple_diag_under_cursor = true,
        multilines = {
          enabled = true,
          always_show = true,
        },
        show_all_diags_on_cursorline = true,
        enable_on_insert = true,
      },
    },
    config = function(_, opts)
      local diags = require("tiny-inline-diagnostic.diagnostic")
      Snacks.toggle({
        name = "Diagnostics",
        get = function()
          return diags.enabled
        end,
        set = diags.toggle,
      }):map("<leader>ud")
      require("tiny-inline-diagnostic").setup(opts)
    end,
    specs = { { "neovim/nvim-lspconfig", opts = { diagnostics = { virtual_text = false } } } },
  },
  -- rounded float diagnostics
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        float = { border = "rounded" },
      },
    },
  },
}
