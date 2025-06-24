return {
  {
    "saghen/blink.cmp",
    lazy = false,
    dev = vim.env.NVIM_DEV ~= nil,
    build = "cargo build --release",
    -- dependencies = { "rafamadriz/friendly-snippets" },
    opts_extend = { "sources.default" },
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "enter",
        ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
      },

      cmdline = {
        completion = {
          list = { selection = { preselect = false } },
          menu = { auto_show = true },
        },
      },

      completion = {
        menu = {
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
          border = "rounded",
          direction_priority = { "s", "n" },
          show_documentation = true,
        },
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
          buffer = {
            -- TODO: transform completions lowercase -> uppercase and not uppercase -> lowercase
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
                if raw and raw:match(correct) then
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
}
