return {
  -- comments
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- Better text-objects
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = {},
  },

  {
    "echasnovski/mini.move",
    keys = {
      { "<M-h>", mode = { "n", "v" } },
      { "<M-j>", mode = { "n", "v" } },
      { "<M-k>", mode = { "n", "v" } },
      { "<M-l>", mode = { "n", "v" } },
    },
    opts = {},
  },

  {
    "echasnovski/mini.surround",
    keys = {
      { "gsa", desc = "Add Surrounding", mode = { "n", "v" } },
      { "gsd", desc = "Delete Surrounding" },
      { "gsf", desc = "Find Right Surrounding" },
      { "gsF", desc = "Find Left Surrounding" },
      { "gsh", desc = "Highlight Surrounding" },
      { "gsr", desc = "Replace Surrounding" },
    },
    opts = {
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
      },
    },
  },

  {
    "saghen/blink.pairs",
    event = { "BufReadPre", "BufNewFile" },
    build = "cargo build --release",

    --- @module 'blink.pairs'
    --- @type blink.pairs.Config
    opts = {
      mappings = {
        enabled = true,
        pairs = {
          ["$"] = { "$", filetypes = { "typst" } },
          ["<"] = {
            "<",
            ">",
            when = function()
              local cursor = vim.api.nvim_win_get_cursor(0)
              local row, col = cursor[1], cursor[2]
              local line = vim.api.nvim_get_current_line()

              if line:sub(col - 1, col) == "::" or line:sub(col + 1, col + 1) == ">" then return true end

              if cursor[2] == 0 then return false end
              local captures = vim.treesitter.get_captures_at_pos(0, row - 1, col - 1)
              for _, capture in ipairs(captures) do
                local c = capture.capture
                if c == "type" or c == "function" then return true end
              end

              return false
            end,
            filetypes = { "rust" },
          },
          ["'"] = {
            {
              "'''",
              when = function()
                local cursor = vim.api.nvim_win_get_cursor(0)
                local line = vim.api.nvim_get_current_line()
                return line:sub(cursor[2] - 1, cursor[2]) == "''"
              end,
              filetypes = { "python" },
            },
            {
              "'",
              enter = false,
              space = false,
              when = function()
                local cursor = vim.api.nvim_win_get_cursor(0)
                local col = cursor[2]
                local line = vim.api.nvim_get_current_line()

                -- TODO: only in string or plaintext
                if line:sub(col, col):match("%w") and not (line:sub(col + 1, col + 1) == "'") then return false end

                if vim.bo.filetype ~= "rust" then return true end

                if line:sub(col, col) == "&" or line:sub(col, col) == "<" then return false end

                local node = vim.treesitter.get_node()
                while node ~= nil do
                  if node:type() == "type_parameters" or node:type() == "type_arguments" then return false end
                  node = node:parent()
                end

                return true
              end,
            },
          },
        },
      },
      highlights = {
        enabled = true,
        groups = {
          "RainbowDelimiterRed",
          "RainbowDelimiterOrange",
          "RainbowDelimiterYellow",
          "RainbowDelimiterGreen",
          "RainbowDelimiterCyan",
          "RainbowDelimiterBlue",
          "RainbowDelimiterViolet",
        },
      },
    },
  },

  {
    "danymat/neogen",
    cmd = "Neogen",
    keys = { { "<leader>cn", function() require("neogen").generate() end, desc = "Generate Annotations (Neogen)" } },
    opts = { snippet_engine = "luasnip" },
  },

  {
    "xzbdmw/clasp.nvim",
    opts = {},
    keys = {
      { "<C-;>", function() require("clasp").wrap("next") end, mode = { "n", "i" }, desc = "Cycle pairs" },
    },
  },
}
