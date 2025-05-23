return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    opts_extend = { "ensure_installed" },
    opts = { ensure_installed = { "comment", "diff", "printf", "regex", "bash", "vim", "vimdoc" } },
    config = function(_, opts)
      require("nvim-treesitter").install(opts.ensure_installed or {})

      local available = require("nvim-treesitter.config").get_available()

      local installed_cache = {}
      for _, parser in ipairs(require("nvim-treesitter.config").installed_parsers()) do
        installed_cache[parser] = true
      end

      local function attach(bufnr, winnr)
        vim.treesitter.start(bufnr)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        vim.wo[winnr][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter", { clear = true }),
        callback = function(ev)
          local bufnr, ft = ev.buf, ev.match
          local winnr = vim.api.nvim_get_current_win()

          if installed_cache[ft] == nil then
            if not vim.tbl_contains(available, ft) then
              installed_cache[ft] = false
              return
            end

            require("nvim-treesitter").install(ft):await(function()
              installed_cache[ft] = true
              attach(bufnr, winnr)
            end)
          elseif installed_cache[ft] then
            attach(bufnr, winnr)
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
        { "]f", function() move.goto_next_start("@function.outer", "textobjects") end, mode = { "n", "x", "o" } },
        { "]F", function() move.goto_next_end("@function.outer", "textobjects") end, mode = { "n", "x", "o" } },
        { "[f", function() move.goto_previous_start("@function.outer", "textobjects") end, mode = { "n", "x", "o" } },
        { "[F", function() move.goto_previous_end("@function.outer", "textobjects") end, mode = { "n", "x", "o" } },
        { "]a", function() move.goto_next_start("@parameter.inner", "textobjects") end, mode = { "n", "x", "o" } },
        { "]A", function() move.goto_next_end("@parameter.inner", "textobjects") end, mode = { "n", "x", "o" } },
        { "[a", function() move.goto_previous_start("@parameter.inner", "textobjects") end, mode = { "n", "x", "o" } },
        { "[A", function() move.goto_previous_end("@parameter.inner", "textobjects") end, mode = { "n", "x", "o" } },
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
