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
        enabled = true,
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

        providers = {
          buffer = {
            -- Keep first letter capitalization
            transform_items = function(a, items)
              local keyword = a.get_keyword()
              local correct, case
              if keyword:match("^%l") then
                correct = "^%u%l+$"
                case = string.lower
              elseif keyword:match("^%u") then
                correct = "^%l+$"
                case = string.upper
              else
                return items
              end

              -- avoid duplicates from the corrections
              local seen = {}
              local out = {}
              for _, item in ipairs(items) do
                local raw = item.insertText
                if raw:match(correct) then
                  local text = case(raw:sub(1, 1)) .. raw:sub(2)
                  item.insertText = text
                  item.label = text
                end
                if not seen[item.insertText] then
                  seen[item.insertText] = true
                  table.insert(out, item)
                end
              end
              return out
            end,
          },
        },
      },
    },
    spec = {
      -- disable noice signature auto-show, because blink handles it
      { "noice.nvim", opts = { lsp = { signature = { auto_open = { enabled = false } } } } },
    },
  },
}
