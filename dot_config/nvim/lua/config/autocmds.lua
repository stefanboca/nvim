-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name) return vim.api.nvim_create_augroup("custom_" .. name, { clear = true }) end

-- TODO: why doesn't FileType fire when opening files from the cli?

-- autoclose on write for interactuve vcs tasks
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("vcs_delete"),
  pattern = { "gitcommit", "gitrebase", "jj", "jjdescription" },
  callback = function(event)
    vim.opt_local.spell = true

    vim.api.nvim_create_autocmd("BufWritePost", {
      group = augroup("vcs_delete_buf_" .. event.buf),
      buffer = event.buf,
      once = true,
      callback = vim.schedule_wrap(function()
        Snacks.bufdelete({ buf = event.buf, wipe = true })
        if vim.g.desc_quit_on_write then
          require("persistence").stop()
          vim.cmd([[quit]])
        end
      end),
    })
  end,
})
