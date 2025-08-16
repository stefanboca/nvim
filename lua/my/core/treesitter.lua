return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    opts_extend = { "enabled" },
    opts = {
      enabled = { "bash", "c", "comment", "diff", "lua", "printf", "query", "regex", "vim", "vimdoc" },
    },
    config = function(_, opts)
      opts.enabled = opts.enabled or {}
      require("nvim-treesitter").install(opts.enabled or {})

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter", { clear = true }),
        pattern = vim.list.unique(
          vim.iter(opts.enabled):map(vim.treesitter.language.get_filetypes):flatten(1):totable()
        ),
        callback = function(ev)
          local lang = vim.treesitter.language.get_lang(ev.match)
          if not lang then return end

          if not vim.b.ts_highlight then vim.treesitter.start(ev.buf, lang) end

          if vim.treesitter.query.get(lang, "indents") ~= nil then
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end

          if vim.treesitter.query.get(lang, "folds") ~= nil then
            vim.wo.foldmethod = "expr"
            vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          end
        end,
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    lazy = true,
    branch = "main",
    -- stylua: ignore
    keys = {
      { "]a", function() require("nvim-treesitter-textobjects.move").goto_next_start("@parameter.inner", "textobjects") end, mode = { "n", "x", "o" } },
      { "]A", function() require("nvim-treesitter-textobjects.move").goto_next_end("@parameter.inner", "textobjects") end, mode = { "n", "x", "o" } },
      { "[a", function() require("nvim-treesitter-textobjects.move").goto_previous_start("@parameter.inner", "textobjects") end, mode = { "n", "x", "o" } },
      { "[A", function() require("nvim-treesitter-textobjects.move").goto_previous_end("@parameter.inner", "textobjects") end, mode = { "n", "x", "o" } },
      { "]c", function() require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects") end, mode = { "n", "x", "o" } },
      { "]C", function() require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects") end, mode = { "n", "x", "o" } },
      { "[c", function() require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects") end, mode = { "n", "x", "o" } },
      { "[C", function() require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects") end, mode = { "n", "x", "o" } },
      { "]f", function() require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects") end, mode = { "n", "x", "o" } },
      { "]F", function() require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects") end, mode = { "n", "x", "o" } },
      { "[f", function() require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects") end, mode = { "n", "x", "o" } },
      { "[F", function() require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects") end, mode = { "n", "x", "o" } },
    },
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
