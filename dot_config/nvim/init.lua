if vim.loader then
  vim.loader.enable()
end

_G.dd = function(...)
  require("snacks.debug").inspect(...)
end
_G.bt = function()
  require("snacks.debug").backtrace()
end
_G.p = function(...)
  require("snacks.debug").profile(...)
end
vim.print = _G.dd

if vim.env.PROF then
  vim.opt.rtp:append(vim.fn.stdpath("data") .. "lazy/snacks.nvim/")
  --- @diagnostic disable-next-line:missing-fields
  require("snacks.profiler").startup({
    startup = {
      -- event = "UIEnter",
      -- event = "VeryLazy",
    },
  })
end

-- Disable LSP logging
vim.lsp.set_log_level(vim.log.levels.OFF)

require("config.lazy")
