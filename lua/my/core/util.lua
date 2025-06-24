-- Terminal Mappings
local function term_nav(dir)
  ---@param self snacks.terminal
  return function(self)
    return self:is_floating() and "<c-" .. dir .. ">" or vim.schedule(function() vim.cmd.wincmd(dir) end)
  end
end

return {
  {
    "snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      terminal = {
        win = {
          keys = {
            nav_h = { "<C-h>", term_nav("h"), desc = "Go to Left Window", expr = true, mode = "t" },
            nav_j = { "<C-j>", term_nav("j"), desc = "Go to Lower Window", expr = true, mode = "t" },
            nav_k = { "<C-k>", term_nav("k"), desc = "Go to Upper Window", expr = true, mode = "t" },
            nav_l = { "<C-l>", term_nav("l"), desc = "Go to Right Window", expr = true, mode = "t" },
          },
        },
      },
    },
    keys = {
      {
        "<leader>.",
        function() Snacks.scratch({ ft = "lua", win = { width = 0.6, height = 0.6, relative = "editor" } }) end,
        desc = "Toggle Scratch Buffer (lua)",
      },
      { "<leader>S", function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
      { "<leader>dps", function() Snacks.profiler.scratch() end, desc = "Profiler Scratch Buffer" },
    },
  },

  -- session management
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {},
    keys = {
      { "<leader>qS", function() require("persistence").select() end, desc = "Select Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qr", ":restart<CR>", desc = "Restart" },
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
    },
  },

  {
    "echasnovski/mini.hipatterns",
    event = "VeryLazy",
    opts = function()
      return {
        highlighters = {
          hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
        },
      }
    end,
  },

  -- find available keys
  { "meznaric/key-analyzer.nvim", cmd = "KeyAnalyzer", opts = { promotion = false } },

  {
    "snacks.nvim",
    opts = function()
      _G.dd = Snacks.debug.inspect
      _G.bt = Snacks.debug.backtrace
      _G.pp = Snacks.debug.profile
      vim.print = Snacks.debug.inspect
    end,
  },

  -- Un-nest neovim instances
  {
    "willothy/flatten.nvim",
    -- NOTE: disabled for now, because causes neotest to hang
    -- see https://github.com/willothy/flatten.nvim/issues/106
    enabled = false,
    lazy = false,
    priority = 1001,
    ---@type Flatten.PartialConfig
    opts = {
      window = { open = "alternate" },
      block_for = {
        jjdescription = true,
      },
      nest_if_no_args = true,
      hooks = {
        should_nest = function(host)
          if vim.env.HEADLESS_OSV then return true end
          return require("flatten").hooks.should_nest(host)
        end,
      },
    },
  },

  -- libraries used by other plugins
  { "nvim-lua/plenary.nvim" },
  { "gregorias/coop.nvim" },
  { "MunifTanjim/nui.nvim" },
  { "nvim-neotest/nvim-nio" },
}
