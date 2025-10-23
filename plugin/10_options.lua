vim.g.mapleader = " "
vim.g.maplocalleader = [[\]]

vim.o.mouse = "a" -- Enable mouse
vim.o.switchbuf = "usetab" -- Use already opened buffers when switching
vim.o.undofile = true -- Enable persistent undo
vim.o.autowrite = true
vim.o.timeoutlen = 500
vim.g.clipboard = "osc52"

vim.o.shada = "'100,<50,s10,:1000,/100,@100,h" -- Limit ShaDa file (for startup)

-- Enable all filetype plugins and syntax (if not enabled, for better startup)
vim.cmd("filetype plugin indent on")
if vim.fn.exists("syntax_on") ~= 1 then vim.cmd("syntax enable") end

-- UI =========================================================================
vim.o.breakindent = true -- Indent wrapped lines to match line start
vim.o.breakindentopt = "list:-1" -- Add padding for lists (if 'wrap' is set)
vim.o.colorcolumn = "+1" -- Draw column on the right of maximum width
vim.o.confirm = true
vim.o.cursorline = true -- Enable current line highlighting
vim.o.linebreak = true -- Wrap lines at 'breakat' (if 'wrap' is set)
vim.o.list = true -- Show helpful text indicators
vim.o.number = true -- Show line numbers
vim.o.pumheight = 10 -- Make popup menu smaller
vim.o.ruler = false -- Don't show cursor coordinates
vim.o.scrolloff = 4 -- Minimum number of lines above and below cursor
vim.o.shortmess = "CFOSWaco" -- Disable some built-in completion messages
vim.o.showcmd = false -- Don't show (partial) commnd in last line of screen
vim.o.showmode = false -- Don't show mode in command line
vim.o.sidescrolloff = 8
vim.o.signcolumn = "yes" -- Always show signcolumn (less flicker)
vim.o.smoothscroll = true -- Scrolling works with screen lines
vim.o.splitbelow = true -- Horizontal splits will be below
vim.o.splitkeep = "screen" -- Reduce scroll during window split
vim.o.splitright = true -- Vertical splits will be to the right
vim.o.termguicolors = true
vim.o.winborder = "rounded"
vim.o.winborder = "single" -- Use border in floating windows
vim.o.winminwidth = 4
vim.o.wrap = false -- Don't visually wrap lines (toggle with \w)
vim.opt.shortmess:append({ W = true, I = true, c = true, C = true })

vim.o.cursorlineopt = "screenline,number" -- Show cursor line per screen line

-- Special UI symbols. More is set via 'mini.basics' later.
vim.o.fillchars = "eob: ,fold:╌,foldopen:,foldclose:,diff:╱"
vim.o.listchars = "extends:…,nbsp:␣,precedes:…,tab:> "

-- Folds (see `:h fold-commands`, `:h zM`, `:h zR`, `:h zA`, `:h zj`)
vim.o.foldlevel = 10 -- Fold nothing by default; set to 0 or 1 to fold
vim.o.foldmethod = "indent" -- Fold based on indent level
vim.o.foldnestmax = 10 -- Limit number of fold levels
vim.o.foldtext = "" -- Show text under fold with its highlighting

-- Editing ====================================================================
vim.o.autoindent = true -- Use auto indent
vim.o.expandtab = true -- Convert tabs to spaces
vim.o.formatoptions = "rqnl1j" -- Improve comment editing
vim.o.ignorecase = true -- Ignore case during search
vim.o.inccommand = "nosplit"
vim.o.incsearch = true -- Show search matches while typing
vim.o.infercase = true -- Infer case in built-in completion
vim.o.shiftround = true -- Round indentation
vim.o.shiftwidth = 2 -- Use this number of spaces for indentation
vim.o.smartcase = true -- Respect case if search pattern has upper case
vim.o.smartindent = true -- Make indenting smart
vim.o.spelloptions = "camel" -- Treat camelCase word parts as separate words
vim.o.tabstop = 2 -- Show tab as this number of spaces
vim.o.virtualedit = "block" -- Allow going past end of line in blockwise mode

vim.o.iskeyword = "@,48-57,_,192-255,-" -- Treat dash as `word` textobject part

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- Pattern for a start of numbered list (used in `gw`). This reads as
-- "Start of list item is: at least one special character (digit, -, +, *)
-- possibly followed by punctuation (. or `)`) followed by at least one space".
vim.o.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]

vim.o.grepformat = "%f:%l:%c:%m"
vim.o.grepprg = "rg --vimgrep --no-heading --smart-case"

-- Built-in completion
vim.o.complete = ".,w,b,kspell" -- Use less sources
vim.o.completeopt = "menuone,noselect,fuzzy,nosort" -- Use custom behavior

if vim.env.IN_NIX_SHELL then vim.o.shell = "fish" end

if vim.env.NVIM_DEV ~= nil then
  vim.o.swapfile = false
  vim.o.shada = ""
end

if vim.g.neovide then
  vim.g.neovide_floating_blur_amount_x = 1.0
  vim.g.neovide_floating_blur_amount_y = 1.0

  vim.g.neovide_floating_shadow = true
  vim.g.neovide_floating_z_height = 10
  vim.g.neovide_light_angle_degrees = 45
  vim.g.neovide_light_radius = 5

  vim.g.neovide_floating_corner_radius = 0.5

  vim.g.neovide_cursor_vfx_mode = "railgun"
end

require("vim._extui").enable({})

-- Autocommands ===============================================================

-- Don't auto-wrap comments and don't insert comment leader after hitting 'o'.
local function f() vim.cmd("setlocal formatoptions-=c formatoptions-=o") end
_G.Config.new_autocmd("FileType", nil, f, "Proper 'formatoptions'")

-- Check if we need to reload the file when it changed
_G.Config.new_autocmd({ "FocusGained", "TermClose", "TermLeave" }, nil, function()
  if vim.o.buftype ~= "nofile" then vim.cmd("checktime") end
end, "Check time")

-- Resize splits if window got resized.
_G.Config.new_autocmd("VimResized", nil, function()
  local current_tab = vim.fn.tabpagenr()
  vim.cmd("tabdo wincmd =")
  vim.cmd("tabnext " .. current_tab)
end, "Resize splits")

-- Auto create dir when saving a file, in case some intermediate directory does not exist
_G.Config.new_autocmd("BufWritePre", nil, function(event)
  if event.match:match("^%w%w+:[\\/][\\/]") then return end
  local file = vim.uv.fs_realpath(event.match) or event.match
  vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
end, "Create dir on save")

-- make it easier to close man-files when opened inline
_G.Config.new_autocmd(
  "FileType",
  { "man" },
  function(event) vim.bo[event.buf].buflisted = false end,
  "Delist man buffers"
)

-- Native terminal lsp progress
-- TODO: remove once LspProgress is deprecated
_G.Config.new_autocmd("LspProgress", nil, function(ev)
  local value = ev.data.params.value
  if value.kind == "begin" then
    vim.api.nvim_ui_send("\027]9;4;1;0\027\\")
  elseif value.kind == "end" then
    vim.api.nvim_ui_send("\027]9;4;0\027\\")
  elseif value.kind == "report" then
    vim.api.nvim_ui_send(string.format("\027]9;4;1;%d\027\\", value.percentage or 0))
  end
end, "Lsp Progress")

-- Close some filetypes with <q>
_G.Config.new_autocmd("FileType", {
  "checkhealth",
  "dap-float",
  "grug-far",
  "help",
  "lspinfo",
  "neotest-output-panel",
  "neotest-summary",
  "nvim-undotree",
  "qf",
}, function(event)
  vim.bo[event.buf].buflisted = false
  vim.schedule(function()
    vim.keymap.set("n", "q", function()
      vim.cmd.close()
      pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
    end, { buffer = event.buf, silent = true, desc = "Quit buffer" })
  end)
end, "Close with q")

-- Sets the current line's color based on the current mode
-- Equivalent to modicator but fast
local CTRL_S = vim.api.nvim_replace_termcodes("<C-S>", true, true, true)
local CTRL_V = vim.api.nvim_replace_termcodes("<C-V>", true, true, true)
local mode_hl_groups = {
  ["n"] = "MiniStatuslineModeNormal",
  ["v"] = "MiniStatuslineModeVisual",
  ["V"] = "MiniStatuslineModeVisual",
  [CTRL_V] = "MiniStatuslineModeVisual",
  ["s"] = "MiniStatuslineModeVisual",
  ["S"] = "MiniStatuslineModeVisual",
  [CTRL_S] = "MiniStatuslineModeVisual",
  ["i"] = "MiniStatuslineModeInsert",
  ["R"] = "MiniStatuslineModeReplace",
  ["c"] = "MiniStatuslineModeCommand",
}
vim.api.nvim_create_autocmd({ "BufEnter", "ModeChanged" }, {
  callback = function()
    local mode = vim.api.nvim_get_mode().mode
    local mode_hl_group = mode_hl_groups[mode] or "MiniStatuslineModeOther"
    local cursorline_hl = vim.api.nvim_get_hl(0, { name = "CursorLine", link = false, create = false })
    local hl = vim.api.nvim_get_hl(0, { name = mode_hl_group, link = false, create = false })
    hl = vim.tbl_extend("force", cursorline_hl, { fg = hl.bg, bold = true })
    vim.api.nvim_set_hl(0, "CursorLineNr", hl)
  end,
})

-- Diagnostics ================================================================
local diagnostic_opts = {
  signs = {
    priority = 9999,
    severity = { min = "WARN", max = "ERROR" },
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
  underline = true,
  virtual_lines = function(_, bufnr)
    if vim.bo[bufnr] ~= "lean" then return false end
    return {
      severity = { max = vim.diagnostic.severity.WARN },
      prefix = " ●",
      suffix = " ",
    }
  end,
  virtual_text = {
    current_line = true,
    severity = { min = "ERROR", max = "ERROR" },
    prefix = " ●",
    suffix = " ",
  },
  severity_sort = true,
  update_in_insert = false,
}
MiniDeps.later(function() vim.diagnostic.config(diagnostic_opts) end)
