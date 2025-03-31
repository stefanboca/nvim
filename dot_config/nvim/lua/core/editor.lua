return {
  -- search/replace in multiple files
  {
    "MagicDuck/grug-far.nvim",
    opts = { headerMaxWidth = 80 },
    cmd = "GrugFar",
    keys = {
      {
        "<leader>sr",
        function()
          local grug = require("grug-far")
          local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
          grug.open({
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          })
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
    },
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    ---@type Flash.Config
    opts = {
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
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts_extend = { "spec" },
    opts = {
      preset = "helix",
      defaults = {},
      spec = {
        {
          mode = { "n", "v" },
          { "<leader><tab>", group = "tabs" },
          { "<leader>c", group = "code" },
          { "<leader>d", group = "debug" },
          { "<leader>dp", group = "profiler" },
          { "<leader>f", group = "file/find" },
          { "<leader>g", group = "git" },
          { "<leader>gh", group = "hunks" },
          { "<leader>q", group = "quit/session" },
          { "<leader>s", group = "search" },
          { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
          { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
          { "[", group = "prev" },
          { "]", group = "next" },
          { "g", group = "goto" },
          { "gs", group = "surround" },
          { "z", group = "fold" },
          {
            "<leader>b",
            group = "buffer",
          },
          {
            "<leader>w",
            group = "windows",
            proxy = "<c-w>",
          },
          { "gx", desc = "Open with system app" },
        },
      },
    },
    keys = {
      {
        "<leader>?",
        function() require("which-key").show({ global = false }) end,
        desc = "Buffer Keymaps (which-key)",
      },
      {
        "<c-w><space>",
        function() require("which-key").show({ keys = "<c-w>", loop = true }) end,
        desc = "Window Hydra Mode (which-key)",
      },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = require("gitsigns")
        local function map(mode, l, r, desc) vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc }) end

        map("n", "]h", function() gs.nav_hunk("next") end, "Next Hunk")
        map("n", "[h", function() gs.nav_hunk("prev") end, "Prev Hunk")
        map({ "n", "v" }, "<leader>ghr", function() gs.reset_hunk() end, "Reset Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
      end,
    },
  },

  -- Finds and lists all of the TODO, HACK, BUG, etc comment
  -- in your project and loads them into a browsable list.
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "VeryLazy",
    opts = {
      keywords = {
        SAFETY = { color = "warning", alt = { "safety", "Safety" } },
        INVARIANT = { color = "hint", alt = { "invariant", "Invariant" } },
      },
    },
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
      {
        "<leader>xT",
        "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>",
        desc = "Todo/Fix/Fixme (Trouble)",
      },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
  },

  {
    "monaqa/dial.nvim",
    opts = {},
    keys = {
      { "<C-a>", function() require("dial.map").manipulate("increment", "normal") end, mode = "n", desc = "Increment" },
      {
        "g<C-a>",
        function() require("dial.map").manipulate("increment", "gnormal") end,
        mode = "n",
        desc = "Increment",
      },
      { "<C-x>", function() require("dial.map").manipulate("decrement", "normal") end, mode = "n", desc = "Decrement" },
      {
        "g<C-x>",
        function() require("dial.map").manipulate("decrement", "gnormal") end,
        mode = "n",
        desc = "Decrement",
      },
      { "<C-a>", function() require("dial.map").manipulate("increment", "visual") end, mode = "v", desc = "Increment" },
      {
        "g<C-a>",
        function() require("dial.map").manipulate("increment", "gvisual") end,
        mode = "v",
        desc = "Increment",
      },
      { "<C-x>", function() require("dial.map").manipulate("decrement", "visual") end, mode = "v", desc = "Decrement" },
      {
        "g<C-x>",
        function() require("dial.map").manipulate("decrement", "gvisual") end,
        mode = "v",
        desc = "Decrement",
      },
    },
  },
}
