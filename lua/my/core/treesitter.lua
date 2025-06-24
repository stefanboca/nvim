return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    opts_extend = { "enable" },
    opts = {
      enable = { "bash", "c", "comment", "diff", "lua", "printf", "query", "regex", "vim", "vimdoc" },
    },
    config = function(_, opts)
      opts.enable = opts.enable or {}
      require("nvim-treesitter").install(opts.enable or {})

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter", { clear = true }),
        pattern = vim.list.unique(
          vim.iter(opts.enable):map(vim.treesitter.language.get_filetypes):flatten(1):totable()
        ),
        callback = function(ev)
          local winnr = vim.api.nvim_get_current_win()

          vim.treesitter.start(ev.buf)
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          vim.wo[winnr][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        end,
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = true,
    branch = "main",
    keys = function()
      local move = require("nvim-treesitter-textobjects.move")
      return {
        { "]a", function() move.goto_next_start("@parameter.inner", "textobjects") end, mode = { "n", "x", "o" } },
        { "]A", function() move.goto_next_end("@parameter.inner", "textobjects") end, mode = { "n", "x", "o" } },
        { "[a", function() move.goto_previous_start("@parameter.inner", "textobjects") end, mode = { "n", "x", "o" } },
        { "[A", function() move.goto_previous_end("@parameter.inner", "textobjects") end, mode = { "n", "x", "o" } },
        { "]c", function() move.goto_next_start("@class.outer", "textobjects") end, mode = { "n", "x", "o" } },
        { "]C", function() move.goto_next_end("@class.outer", "textobjects") end, mode = { "n", "x", "o" } },
        { "[c", function() move.goto_previous_start("@class.outer", "textobjects") end, mode = { "n", "x", "o" } },
        { "[C", function() move.goto_previous_end("@class.outer", "textobjects") end, mode = { "n", "x", "o" } },
        { "]f", function() move.goto_next_start("@function.outer", "textobjects") end, mode = { "n", "x", "o" } },
        { "]F", function() move.goto_next_end("@function.outer", "textobjects") end, mode = { "n", "x", "o" } },
        { "[f", function() move.goto_previous_start("@function.outer", "textobjects") end, mode = { "n", "x", "o" } },
        { "[F", function() move.goto_previous_end("@function.outer", "textobjects") end, mode = { "n", "x", "o" } },
      }
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    opts = {
      mode = "cursor",
      max_lines = 3,
    },
  },
}
