-- Un-nest neovim instances

local saved_terminals = {}

return {
  "willothy/flatten.nvim",
  -- Ensure that it runs first to minimize delay when opening file from terminal
  lazy = false,
  priority = 9001,
  opts = {
    window = {
      open = "alternate",
    },
    block_for = {
      jj = true,
      jjdescription = true,
    },
    nest_if_no_args = true,
    hooks = {
      should_nest = function(host)
        if vim.env.HEADLESS_OSV then return true end
        return require("flatten").hooks.should_nest(host)
      end,
      pre_open = function()
        for _, terminal in ipairs(Snacks.terminal.list()) do
          if terminal:valid() then saved_terminals[#saved_terminals + 1] = terminal end
        end
      end,
      post_open = function(opts)
        if opts.is_blocking then
          for _, terminal in ipairs(saved_terminals) do
            terminal:hide()
          end
        else
          vim.api.nvim_set_current_win(opts.winnr)
        end
      end,
      block_end = vim.schedule_wrap(function()
        for _, terminal in ipairs(saved_terminals) do
          terminal:show()
        end
        saved_terminals = {}
      end),
    },
  },
}
