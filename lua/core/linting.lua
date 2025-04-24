return {
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    opts = {
      ---@type string[]
      events = { "BufWritePost", "BufReadPost", "InsertLeave" },
    },
    config = function(_, opts)
      require("lint").linters_by_ft = opts.linters_by_ft or {}

      local function debounce(ms, fn)
        local timer = assert(vim.uv.new_timer())
        return function(...)
          local argv = { ... }
          timer:start(ms, 0, function()
            timer:stop()
            vim.schedule_wrap(fn)(unpack(argv))
          end)
        end
      end

      vim.api.nvim_create_autocmd(opts.events, {
        group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
        callback = debounce(100, function() require("lint").try_lint() end),
      })
    end,
  },
}
