return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    opts_extend = { "ensure_installed" },
    opts = { ensure_installed = { "comment", "diff", "printf", "regex", "bash" } },
    config = function(_, opts)
      require("nvim-treesitter").install(opts.ensure_installed)

      local available = require("nvim-treesitter.config").get_available()

      local installed_cache = {}
      for _, parser in ipairs(vim.api.nvim_get_runtime_file("parser/*", true)) do
        installed_cache[vim.fn.fnamemodify(parser, ":t:r")] = true
      end
      for _, parser in ipairs(require("nvim-treesitter.config").installed_parsers()) do
        installed_cache[parser] = true
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter", { clear = true }),
        callback = function(ev)
          local bufnr, ft = ev.buf, ev.match

          if installed_cache[ft] == nil then
            if not vim.tbl_contains(available, ft) then
              installed_cache[ft] = false
              return
            end

            require("nvim-treesitter").install(ft):await(function()
              installed_cache[ft] = true
              vim.treesitter.start(bufnr)
            end)
          elseif installed_cache[ft] then
            vim.treesitter.start(bufnr)
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
