vim.loader.enable()

if vim.env.NVIM_PROFILE ~= nil then
  local snacks = vim.fn.stdpath("data") .. "/site/pack/deps/opt/snacks.nvim"
  vim.opt.rtp:append(snacks)
  require("snacks.profiler").startup({
    -- stop profiler on this event. Defaults to `VimEnter`
    startup = { event = "UIEnter" },
  })
end

require("mini.deps").setup()
