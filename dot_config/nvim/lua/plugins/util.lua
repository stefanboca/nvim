return {
  -- async library
  { "gregorias/coop.nvim", version = false, lazy = true },

  -- show available keys
  {
    "meznaric/key-analyzer.nvim",
    cmd = "KeyAnalyzer",
    opts = {},
  },
  {
    "snacks.nvim",
    opts = {
      image = {
        enabled = true,
      },
    },
    keys = {
      {
        "<leader>sZ",
        function() Snacks.picker.zoxide() end,
        desc = "Open a project from zoxide",
      },
    },
  },

  {
    "snacks.nvim",
    opts = function()
      -- set these again, even though they are set in lazy.lua, in order for
      -- backtrace to be correct
      _G.dd = Snacks.debug.inspect
      _G.bt = Snacks.debug.backtrace
      _G.p = Snacks.debug.profile
      vim.print = Snacks.debug.inspect
    end,
  },
}
