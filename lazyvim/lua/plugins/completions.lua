return {
  { "saghen/blink.compat", dev = true, lazy = true },
  {
    "saghen/blink.cmp",
    dev = true,
    event = { "InsertEnter", "CmdlineEnter" },
    optional = true,
    opts = {
      keymap = {
        preset = "enter",
        cmdline = {
          preset = "default",
          ["<Tab>"] = { "select_next", "fallback" },
          ["<S-Tab>"] = { "select_prev", "fallback" },
        },
      },

      completion = {
        list = {
          selection = function(ctx)
            return ctx.mode == "cmdline" and "auto_insert" or "manual"
          end,
        },
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        trigger = {
          prefetch_on_insert = true,
        },
        menu = {
          winblend = vim.o.pumblend,
          direction_priority = { "n", "s" },
          draw = {
            columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "fill", "kind" } },
            components = {
              fill = {
                width = { fill = true },
                text = function()
                  return ""
                end,
              },
            },
          },
        },

        documentation = {
          auto_show = true,
          window = {
            winblend = vim.o.pumblend,
          },
        },

        ghost_text = { enabled = true },
      },

      fuzzy = { prebuilt_binaries = { download = false } },

      signature = {
        -- enabled = true,
        window = { winblend = vim.o.pumblend },
      },

      sources = {
        cmdline = function()
          local type = vim.fn.getcmdtype()
          -- Search forward and backward
          if type == "/" or type == "?" then
            return { "buffer" }
          end
          -- Commands
          if type == ":" then
            return { "cmdline" }
          end
          return {}
        end,
      },
    },
  },

  -- disable noice signature auto-show, because blink handles it
  -- {
  --   "noice.nvim",
  --   opts = {
  --     lsp = {
  --       signature = {
  --         auto_open = {
  --           enabled = false,
  --         },
  --       },
  --     },
  --   },
  -- },
}
