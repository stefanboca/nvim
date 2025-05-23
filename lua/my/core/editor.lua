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
      "f",
      "F",
      "t",
      "T",
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
      plugins = {
        -- disabled because it makes yank to clipboard really slow for some reason
        registers = false,
      },
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

  {
    "monaqa/dial.nvim",
    keys = function()
      local keys = {
        { "<C-a>", dir = "increment", mode = "normal" },
        { "g<C-a>", dir = "increment", mode = "gnormal" },
        { "<C-a>", dir = "increment", mode = "visual" },
        { "g<C-a>", dir = "increment", mode = "gvisual" },
        { "<C-x>", dir = "decrement", mode = "normal" },
        { "g<C-x>", dir = "decrement", mode = "gnormal" },
        { "<C-x>", dir = "decrement", mode = "visual" },
        { "g<C-x>", dir = "decrement", mode = "gvisual" },
      }

      return vim.tbl_map(function(key)
        return {
          key[1],
          function() require("dial.map").manipulate(key.dir, key.mode) end,
          mode = key.mode:find("normal") and "n" or "v",
          desc = key.mode:gsub("^%l", string.upper),
        }
      end, keys)
    end,

    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal_int,
          augend.integer.alias.hex,
          augend.semver.alias.semver,
          augend.constant.alias.bool,
          augend.constant.new({ elements = { "True", "False" } }),
          augend.constant.new({ elements = { "and", "or" } }),
          augend.constant.new({ elements = { "&&", "||" }, word = false }),
          augend.constant.new({ elements = { "+", "-" }, word = false }),
          augend.constant.alias.alpha,
          augend.constant.alias.Alpha,
        },
      })
    end,
  },
}
