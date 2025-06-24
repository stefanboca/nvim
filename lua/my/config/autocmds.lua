local function augroup(name) return vim.api.nvim_create_augroup("user_" .. name, { clear = true }) end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then vim.cmd("checktime") end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function() vim.hl.on_yank() end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function(event)
    local exclude = { "gitcommit", "jjdescription" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].last_loc then return end
    vim.b[buf].last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then pcall(vim.api.nvim_win_set_cursor, 0, mark) end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "checkhealth",
    "dbout",
    "gitsigns-blame",
    "grug-far",
    "help",
    "lspinfo",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd.close()
        pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      end, { buffer = event.buf, silent = true, desc = "Quit buffer" })
    end)
  end,
})

if vim.g.quit_on_write ~= nil then
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = augroup("quit_on_write"),
    callback = function()
      require("persistence").stop()
      vim.cmd.quitall()
    end,
  })
end

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("man_unlisted"),
  pattern = { "man" },
  callback = function(event) vim.bo[event.buf].buflisted = false end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown", "jjdescription" },
  callback = function()
    if vim.bo.buftype ~= "" then return end
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("json_conceal"),
  pattern = { "json", "jsonc", "json5" },
  callback = function() vim.opt_local.conceallevel = 0 end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then return end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Sets the current line's color based on the current mode
-- Equivalent to modicator but fast
local mode_hl_groups = {
  ["n"] = "lualine_b_normal",
  ["no"] = "lualine_b_normal",
  ["nov"] = "lualine_b_normal",
  ["noV"] = "lualine_b_normal",
  ["no\22"] = "lualine_b_normal",
  ["niI"] = "lualine_b_normal",
  ["niR"] = "lualine_b_normal",
  ["niV"] = "lualine_b_normal",
  ["nt"] = "lualine_b_normal",
  ["ntT"] = "lualine_b_normal",
  ["v"] = "lualine_b_visual",
  ["vs"] = "lualine_b_visual",
  ["V"] = "lualine_b_visual",
  ["Vs"] = "lualine_b_visual",
  ["\22"] = "lualine_b_visual",
  ["\22s"] = "lualine_b_visual",
  ["s"] = "lualine_b_visual",
  ["S"] = "lualine_b_visual",
  ["\19"] = "lualine_b_visual",
  ["i"] = "lualine_b_insert",
  ["ic"] = "lualine_b_insert",
  ["ix"] = "lualine_b_insert",
  ["R"] = "lualine_b_replace",
  ["Rc"] = "lualine_b_replace",
  ["Rx"] = "lualine_b_replace",
  ["Rv"] = "lualine_b_replace",
  ["Rvc"] = "lualine_b_replace",
  ["Rvx"] = "lualine_b_replace",
  ["c"] = "lualine_b_command",
  ["cv"] = "lualine_b_command",
  ["ce"] = "lualine_b_command",
  ["r"] = "lualine_b_replace",
  ["rm"] = "lualine_b_command",
  ["r?"] = "lualine_b_command",
  ["t"] = "lualine_b_terminal",
}
vim.api.nvim_create_autocmd({ "BufEnter", "ModeChanged" }, {
  callback = function()
    local mode = vim.api.nvim_get_mode().mode
    local mode_hl_group = mode_hl_groups[mode] or "lualine_b_normal"
    local hl = vim.api.nvim_get_hl(0, { name = mode_hl_group, link = false, create = false })
    hl = vim.tbl_extend("force", { bold = true }, hl)
    vim.api.nvim_set_hl(0, "CursorLineNr", hl)
    if hl.bg then vim.api.nvim_set_hl(0, "CursorLine", { bg = hl.bg }) end
  end,
})
