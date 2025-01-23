return {
  {
    "render-markdown.nvim",
    enabled = false,
  },

  {
    "OXY2DEV/markview.nvim",
    ft = { "markdown", "typst", "latex", "yaml", "html" },
    opts = function()
      local presets = require("markview.presets")
      ---@type mkv.config
      return {
        preview = {
          hybrid_modes = { "i" },
          enable_hybrid_mode = true,
          linewise_hybrid_mode = true,
          edit_range = { 2, 2 },
          icon_provider = "mini",
        },
        markdown = {
          headings = presets.headings.marker,
          horizontal_rules = presets.horizontal_rules.thick,
          tables = presets.tables.rounded,
        },
        typst = {
          headings = presets.headings.marker,
          code_blocks = {
            style = "simple",
            pad_amount = 0,
          },
          list_items = {
            indent_size = 0,
            shift_width = 0,
          },
          math_blocks = {
            pad_amount = 0,
          },
          raw_blocks = {
            pad_amount = 0,
          },
        },
      }
    end,
    config = function(_, opts)
      require("markview").setup(opts)
      Snacks.toggle({
        name = "Markview",
        get = function()
          return require("markview").state.enable
        end,
        set = function(enabled)
          local commands = require("markview").commands
          if enabled then
            commands.Start()
            commands.Enable()
          else
            commands.Stop()
            commands.Disable()
          end
        end,
      }):map("<leader>um")
    end,
  },
}
