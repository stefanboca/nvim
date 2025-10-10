vim.opt_local.spell = true

_G.Config.new_autocmd("BufWritePost", nil, function() vim.cmd.quit() end, "Quit on write")
