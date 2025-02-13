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
        if filename == "" then return end
        local dirname = vim.fn.fnamemodify(buf_path, ":~:.:h")

        local ft_icon, ft_hl, is_default = require("mini.icons").get("file", filename)
        if is_default then ft_icon = nil end
        local modified = vim.bo[props.buf].modified
        return {
          ft_icon and { " ", ft_icon, " ", group = ft_hl } or "",
          modified and { " ● ", group = "BufferLineModified" } or " ",
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
        opts = function(_, opts) table.remove(opts.sections.lualine_c, 4) end,
      },
    },
  },

  -- lualine style
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        component_separators = "|",
        section_separators = "",
      },
    },
  },

  -- pretty inline diagnostics
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        set_arrow_to_diag_color = true,
        multilines = {
          enabled = true,
          always_show = true,
        },
        show_all_diags_on_cursorline = true,
        enable_on_insert = false,
        enable_on_select = false,
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        -- rounded floating diagnostic popups
        float = { border = "rounded" },
        -- disable virtual text
        virtual_text = false,
      },
    },
  },

  {
    "lewis6991/satellite.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
