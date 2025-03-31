if os.getenv("NVIM_PROFILE") == "start" then
  local snacks = vim.fn.stdpath("data") .. "/lazy/snacks.nvim"
  vim.opt.rtp:append(snacks)
  ---@diagnostic disable-next-line: missing-fields
  require("snacks.profiler").startup({
    -- stop profiler on this event. Defaults to `VimEnter`
    startup = {
      -- event = 'VimEnter',
      -- event = "UIEnter",
      event = "VeryLazy",
    },
  })
end
