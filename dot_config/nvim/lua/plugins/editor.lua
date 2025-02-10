return {
  -- edit browser textboxes in nvim
  {
    "subnut/nvim-ghost.nvim",
    cmd = { "GhostTextStart" },
    init = function()
      vim.g.nvim_ghost_autostart = 0
    end,
  },

  {
    "todo-comments.nvim",
    opts = {
      keywords = {
        SAFETY = { color = "warning", alt = { "safety", "Safety" } },
        INVARIANT = { color = "hint", alt = { "invariant", "Invariant" } },
      },
    },
  },

  {
    "flash.nvim",
    opts = {
      search = {
        exclude = {
          "blink-cmp-menu",
          "blink-cmp-documentation",
          "blink-cmp-signature",
          -- default values:
          "notify",
          "cmp_menu",
          "noice",
          "flash_prompt",
          function(win)
            -- exclude non-focusable windows
            return not vim.api.nvim_win_get_config(win).focusable
          end,
        },
      },
    },
  },
}
