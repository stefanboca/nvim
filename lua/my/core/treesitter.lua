return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    opts_extend = { "ensure_installed" },
    opts = {
      ensure_installed = { "bash", "c", "comment", "diff", "lua", "printf", "query", "regex", "vim", "vimdoc" },
    },
    config = function(_, opts)
      require("nvim-treesitter").install(opts.ensure_installed or {})

      local function attach(bufnr, winnr)
        vim.treesitter.start(bufnr)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        vim.wo[winnr][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
      end

      -- NOTE: injected language parsers are not auto-installed
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter", { clear = true }),
        callback = function(ev)
          local bufnr, ft = ev.buf, ev.match
          local winnr = vim.api.nvim_get_current_win()

          local ok = pcall(attach, bufnr, winnr)
          if not ok then
            local lang = vim.treesitter.language.get_lang(ft) or ft
            if lang == "" or not vim.tbl_contains(require("nvim-treesitter.config").get_available(), lang) then
              return
            end
            require("nvim-treesitter").install(lang):await(function(_, did_install)
              if did_install then attach(bufnr, winnr) end
            end)
          end
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
