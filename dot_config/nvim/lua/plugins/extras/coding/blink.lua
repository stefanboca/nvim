return {
  { "saghen/blink.compat", optional = true, dev = true, lazy = true },
  {
    "saghen/blink.cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    build = { "RUSTFLAGS=-Ctarget-cpu=native cargo build --release" },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "enter",
      },

      cmdline = {
        enabled = true,
        keymap = {
          preset = "default",
          ["<Tab>"] = { "accept" },
          ["<C-Space>"] = { "show_and_insert" },
        },
        completion = {
          menu = {
            draw = {
              columns = { { "label", "label_description", gap = 1 } },
            },
          },
          ghost_text = {
            enabled = true,
          },
        },
      },

      completion = {
        list = {
          selection = {
            preselect = false,
          },
        },
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          winblend = vim.o.pumblend,
          direction_priority = { "n", "s" },
        },

        documentation = {
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
        providers = {
          snippets = {
            opts = {
              filter_snippets = function(ft, file)
                return not (string.match(file, "friendly.snippets") and string.match(file, "framework"))
              end,
            },
          },
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
  },

  -- disable noice signature auto-show, because blink handles it
  {
    "noice.nvim",
    optional = true,
    opts = { lsp = { signature = { auto_open = { enabled = false } } } },
  },
}
