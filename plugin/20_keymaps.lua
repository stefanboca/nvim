---@param lhs string
local function imap(lhs, rhs, desc) vim.keymap.set("i", lhs, rhs, { desc = desc }) end
local function nmap(lhs, rhs, desc) vim.keymap.set("n", lhs, rhs, { desc = desc }) end
local function xmap(lhs, rhs, desc) vim.keymap.set("x", lhs, rhs, { desc = desc }) end
local function nmap_leader(suffix, rhs, desc) vim.keymap.set("n", "<Leader>" .. suffix, rhs, { desc = desc }) end
local function xmap_leader(suffix, rhs, desc) vim.keymap.set("x", "<Leader>" .. suffix, rhs, { desc = desc }) end
local nmapb_lleader = _G.Config.nmapb_lleader

-- Clear search
vim.keymap.set({ "i", "n", "s" }, "<Esc>", function()
  vim.cmd("noh")
  return "<Esc>"
end, { expr = true, silent = true })

-- Add undo break-points
imap(",", ",<c-g>u")
imap(".", ".<c-g>u")
imap(";", ";<c-g>u")

-- Paste linewise before/after current line
nmap("[p", '<Cmd>exe "put! " . v:register<CR>', "Paste Above")
nmap("]p", '<Cmd>exe "put "  . v:register<CR>', "Paste Below")

-- upload to pastebin
nmap_leader("p", '"+p', "Paste from clipboard")
xmap_leader("y", '"+y', "Yank to clipboard")
xmap_leader("Y", function()
  local curl = require("plenary.curl")
  local strings = require("plenary.strings")
  local filetype_to_extensions = {
    clojure = "clj",
    crystal = "cr",
    elixir = "ex",
    erlang = "erl",
    fennel = "fnl",
    haskell = "hs",
    javascript = "js",
    javascriptreact = "jsx",
    julia = "jl",
    markdown = "md",
    moonscript = "moon",
    ocaml = "ml",
    purescript = "purs",
    python = "py",
    racket = "rkt",
    reason = "re",
    ruby = "rb",
    rust = "rs",
    scheme = "scm",
    typescript = "ts",
    typescriptreact = "tsx",
  }

  vim.cmd.normal({ '"zy', bang = true })
  local selected_text = strings.dedent(vim.fn.getreg("z"))

  local response = curl.post("https://paste.super.fish/", {
    method = "POST",
    body = selected_text,
  })

  local redirect_url = response.body
  local extension = filetype_to_extensions[vim.bo.filetype] or (vim.bo.filetype == "" and "txt" or vim.bo.filetype)
  if redirect_url then
    vim.fn.setreg("+", "https://paste.super.fish" .. redirect_url .. "." .. extension)
    vim.notify("Copied to clipboard and system clipboard")
  else
    vim.notify("Failed to upload to pastebin")
  end
end, "Upload selection to paste bin")

-- Cycle pairs
local cycle_pairs = '<Cmd>lua require("clasp").wrap("next")<CR>'
imap("<C-;>", cycle_pairs, "Cycle pairs")
nmap("<C-;>", cycle_pairs, "Cycle pairs")

-- Remap macro recording to Q
nmap("q", "<nop>")
vim.keymap.set("n", "Q", "q", { desc = "Record macro", noremap = true })

-- better indenting
xmap("<", "<gv")
xmap(">", ">gv")

-- Comment above and below
nmap("gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", "Add Comment Below")
nmap("gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", "Add Comment Above")

_G.Config.leader_group_clues = {
  { mode = "n", keys = "<Leader><Tab>", desc = "+Tab" },
  { mode = "n", keys = "<Leader>b", desc = "+Buffer" },
  { mode = "n", keys = "<Leader>d", desc = "+Debug" },
  { mode = "n", keys = "<Leader>dP", desc = "+Profile" },
  { mode = "n", keys = "<Leader>e", desc = "+Explore/Edit" },
  { mode = "n", keys = "<Leader>f", desc = "+Find" },
  { mode = "n", keys = "<Leader>g", desc = "+Git" },
  { mode = "n", keys = "<Leader>l", desc = "+Language" },
  { mode = "n", keys = "<Leader>m", desc = "+Map" },
  { mode = "n", keys = "<Leader>o", desc = "+Other" },
  { mode = "n", keys = "<Leader>s", desc = "+Session" },
  { mode = "n", keys = "<Leader>t", desc = "+Test" },
  { mode = "n", keys = "<Leader>v", desc = "+Visits" },

  { mode = "x", keys = "<Leader>d", desc = "+Debug" },
  { mode = "x", keys = "<Leader>g", desc = "+Git" },
  { mode = "x", keys = "<Leader>l", desc = "+Language" },
}

local error_first = "<Cmd>lua MiniBracketed.diagnostic('first', {severity=vim.diagnostic.severity.ERROR})<CR>"
local error_backward = "<Cmd>lua MiniBracketed.diagnostic('backward', {severity=vim.diagnostic.severity.ERROR})<CR>"
local error_forward = "<Cmd>lua MiniBracketed.diagnostic('forward', {severity=vim.diagnostic.severity.ERROR})<CR>"
local error_last = "<Cmd>lua MiniBracketed.diagnostic('last', {severity=vim.diagnostic.severity.ERROR})<CR>"
nmap("[E", error_first, "Error first")
nmap("[e", error_backward, "Error backward")
nmap("]e", error_forward, "Error forward")
nmap("]E", error_last, "Error last")

local toggle_scratch = '<Cmd>lua Snacks.scratch({ft="lua",win={width=0.6,height=0.6,relative="editor"}})<CR>'
nmap_leader(".", toggle_scratch, "Toggle scratch")
nmap_leader("ba", "<Cmd>b#<CR>", "Alternate")
nmap_leader("bd", "<Cmd>lua MiniBufremove.delete()<CR>", "Delete")
nmap_leader("bD", "<Cmd>lua MiniBufremove.delete(0, true)<CR>", "Delete!")
nmap_leader("bs", toggle_scratch, "Toggle scratch")
nmap_leader("bS", "<Cmd>lua Snacks.scratch.select()<CR>", "Scratch select")
nmap_leader("bw", "<Cmd>lua MiniBufremove.wipeout()<CR>", "Wipeout")
nmap_leader("bW", "<Cmd>lua MiniBufremove.wipeout(0, true)<CR>", "Wipeout!")
nmap_leader("bo", "<Cmd>lua Snacks.bufdelete.other()<CR>", "Delete Other")

nmap_leader("<Tab>l", "<Cmd>tablast<CR>", "Tab last")
nmap_leader("<Tab>o", "<Cmd>tabonly<CR>", "Tab only")
nmap_leader("<Tab>f", "<Cmd>tabfirst<CR>", "Tab first")
nmap_leader("<Tab><Tab>", "<Cmd>tabnew<CR>", "Tab new")
nmap_leader("<Tab>]", "<Cmd>tabnext<CR>", "Tab next")
nmap_leader("<Tab>d", "<Cmd>tabclose<CR>", "Tab close")
nmap_leader("<Tab>[", "<Cmd>tabprevious<CR>", "Tab backward")

local explore_at_file = "<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>"
nmap_leader("ed", "<Cmd>lua MiniFiles.open()<CR>", "Directory")
nmap_leader("ef", explore_at_file, "File directory")
nmap_leader("el", "<Cmd>Trouble loclist toggle<CR>", "Locations")
nmap_leader("en", "<Cmd>lua MiniNotify.show_history()<CR>", "Notifications")
nmap_leader("eq", "<Cmd>Trouble qflist toggle<CR>", "Quickfix")
nmap_leader("es", "<Cmd>Trouble symbols toggle<CR>", "Symbols")
nmap_leader("eS", "<Cmd>Trouble lsp toggle<CR>", "LSP")
nmap_leader("er", "<Cmd>Trouble lsp_references<CR>", "References (lsp)")
nmap_leader("ex", "<Cmd>Trouble diagnostics toggle filter.buf=0<CR>", "Diagnostics (buf)")
nmap_leader("eX", "<Cmd>Trouble diagnostics toggle<CR>", "Diagnostics (all)")

nmap_leader(" ", "<Cmd>Pick files<CR>", "Files")
nmap_leader(",", "<Cmd>Pick buffers<CR>", "Buffers")
nmap_leader("/", "<Cmd>Pick grep_live<CR>", "Grep live")
nmap_leader("f/", '<Cmd>Pick history scope="/"<CR>', '"/" history')
nmap_leader("f:", '<Cmd>Pick history scope=":"<CR>', '":" history')
nmap_leader('f"', "<Cmd>Pick registers<CR>", "Registers")
nmap_leader("fa", "<Cmd>lua Snacks.picker.autocmds()<CR>", "Autocmds")
nmap_leader("fb", "<Cmd>Pick buffers<CR>", "Buffers")
nmap_leader("fd", '<Cmd>Pick diagnostic scope="all"<CR>', "Diagnostic workspace")
nmap_leader("fD", '<Cmd>Pick diagnostic scope="current"<CR>', "Diagnostic buffer")
nmap_leader("ff", "<Cmd>Pick files<CR>", "Files")
nmap_leader("fg", "<Cmd>Pick grep_live<CR>", "Grep live")
nmap_leader("fG", '<Cmd>Pick grep pattern="<cword>"<CR>', "Grep current word")
nmap_leader("fh", "<Cmd>Pick help<CR>", "Help tags")
nmap_leader("fH", "<Cmd>Pick hl_groups<CR>", "Highlight groups")
nmap_leader("fi", "<Cmd>lua Snacks.picker.icons()<CR>", "Icons")
nmap_leader("fj", "<Cmd>lua Snacks.picker.jumps()<CR>", "Jumps")
nmap_leader("fk", "<Cmd>Pick keymaps<CR>", "Keymaps")
nmap_leader("fl", '<Cmd>Pick buf_lines scope="current"<CR>', "Lines (buf)")
nmap_leader("fL", '<Cmd>Pick buf_lines scope="all"<CR>', "Lines (all)")
nmap_leader("fm", "<Cmd>Pick marks<CR>", "Marks")
nmap_leader("fo", "<Cmd>Pick oldfiles<CR>", "Oldfiles")
nmap_leader("fR", "<Cmd>Pick resume<CR>", "Resume")
nmap_leader("fr", '<Cmd>Pick lsp scope="references"<CR>', "References (LSP)")
nmap_leader("fs", '<Cmd>Pick lsp scope="document_symbol"<CR>', "Symbols document")
nmap_leader("fS", '<Cmd>Pick lsp scope="workspace_symbol_live"<CR>', "Symbols workspace (live)")
nmap_leader("fu", "<Cmd>lua Snacks.picker.undo()<CR>", "Undo")
nmap_leader("fV", "<Cmd>Pick visit_paths<CR>", "Visit paths (cwd)")
nmap_leader("fv", '<Cmd>Pick visit_paths cwd=""<CR>', "Visit paths (all)")

local jjui = nil
local function jjui_toggle()
  if jjui == nil then
    local Terminal = require("toggleterm.terminal").Terminal
    jjui = Terminal:new({ cmd = "jjui", hidden = true })
  end
  jjui:toggle(nil, "float")
end

local git_log_cmd = [[Git log --pretty=format:\%h\ \%as\ │\ \%s --topo-order]]
local git_log_buf_cmd = git_log_cmd .. " --follow -- %"
nmap_leader("ga", "<Cmd>Git diff --cached<CR>", "Added diff")
nmap_leader("gA", "<Cmd>Git diff --cached -- %<CR>", "Added diff buffer")
nmap_leader("gj", jjui_toggle, "JJUI Toggle")
nmap_leader("gd", "<Cmd>Git diff<CR>", "Diff")
nmap_leader("gD", "<Cmd>Git diff -- %<CR>", "Diff buffer")
nmap_leader("gl", "<Cmd>" .. git_log_cmd .. "<CR>", "Log")
nmap_leader("gL", "<Cmd>" .. git_log_buf_cmd .. "<CR>", "Log buffer")
nmap_leader("go", "<Cmd>lua MiniDiff.toggle_overlay()<CR>", "Toggle overlay")
nmap_leader("gs", "<Cmd>lua MiniGit.show_at_cursor()<CR>", "Show at cursor")
nmap_leader("gS", "<Cmd>lua MiniGit.show_diff_source()<CR>", "Show diff source")
xmap_leader("gs", "<Cmd>lua MiniGit.show_at_cursor()<CR>", "Show at selection")
xmap_leader("gS", "<Cmd>lua MiniGit.show_range_history()<CR>", "Show range")

local formatting_cmd = '<Cmd>lua require("conform").format()<CR>'
local formatting_injected_cmd = '<Cmd>lua require("conform").format({formatters={"injected"}})<CR>'
nmap_leader("la", '<Cmd>lua require("tiny-code-action").code_action()<CR>', "Actions")
nmap_leader("lc", "<Cmd>lua vim.lsp.codelens.run()<CR>", "Codelens run")
nmap_leader("lC", "<Cmd>lua vim.lsp.codelens.run()<CR>", "Codelens refresh")
nmap_leader("ld", "<Cmd>lua vim.diagnostic.open_float()<CR>", "Diagnostic popup")
nmap_leader("lD", "<Cmd>Trouble lsp_declarations<CR>", "Declaration")
nmap_leader("lf", formatting_cmd, "Format")
nmap_leader("lF", formatting_injected_cmd, "Format injected")
nmap_leader("ln", '<Cmd>lua require("neogen").generate()<CR>', "Annotations generate (neogen)")
nmap_leader("li", "<Cmd>Trouble lsp_implementations<CR>", "Implementation (lsp)")
nmap_leader("lI", "<Cmd>Trouble lsp_incoming_calls<CR>", "Incoming calls (lsp)")
nmap_leader("lO", "<Cmd>Trouble lsp_outgoing_calls<CR>", "Outgoing calls (lsp)")
nmap_leader("lr", '<Cmd>lua require("live-rename").rename({cursorpos=0})<CR>', "Rename (lsp)")
nmap_leader("lR", "<Cmd>lua Snacks.rename.rename_file()<CR>", "Rename file")
nmap_leader("ll", "<Cmd>lua Snacks.picker.lsp_config()<CR>", "LSP config")
nmap_leader("ls", "<Cmd>Trouble lsp_definitions<CR>", "Source definition (lsp)")
nmap_leader("lt", "<Cmd>Trouble lsp_type_definitions<CR>", "Type definition (lsp)")
xmap_leader("lf", formatting_cmd, "Format selection")
xmap_leader("lF", formatting_injected_cmd, "Format selection injected")

nmap_leader("mf", "<Cmd>lua MiniMap.toggle_focus()<CR>", "Focus (toggle)")
nmap_leader("mr", "<Cmd>lua MiniMap.refresh()<CR>", "Refresh")
nmap_leader("ms", "<Cmd>lua MiniMap.toggle_side()<CR>", "Side (toggle)")
nmap_leader("mt", "<Cmd>lua MiniMap.toggle()<CR>", "Toggle")

local function inlay_hint_toggle()
  local enable = not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
  vim.lsp.inlay_hint.enable(enable, { bufnr = 0 })
  if enable then
    print("  inlayhint")
  else
    print("noinlayhint")
  end
end
local function treesitter_toggle()
  local enable = not vim.b.ts_highlight
  if enable then
    vim.treesitter.start()
    print("  treesitter")
  else
    vim.treesitter.stop()
    print("notreesitter")
  end
end
local function autoformat_toggle(global)
  local v = global and vim.g or vim.b
  local msg = "autoformat" .. (global and "" or "local")
  return function()
    local disable = not v.autoformat_disable
    if disable then
      v.autoformat_disable = true
      print("no" .. msg)
    else
      vim.g.autoformat_disable = nil
      vim.b.autoformat_disable = nil
      print("  " .. msg)
    end
  end
end
nmap_leader("or", "<Cmd>lua MiniMisc.resize_window()<CR>", "Resize to default width")
nmap_leader("ot", "<Cmd>lua MiniTrailspace.trim()<CR>", "Trim trailspace")
nmap_leader("oz", "<Cmd>lua MiniMisc.zoom()<CR>", "Toggle zoom")
nmap_leader("oH", inlay_hint_toggle, "Toggle inlay hint")
nmap_leader("oT", treesitter_toggle, "Toggle treesitter")
nmap_leader("of", autoformat_toggle(false), "Toggle autoformat (buf)")
nmap_leader("oF", autoformat_toggle(true), "Toggle autoformat (all)")

local session_new = 'MiniSessions.write(vim.fn.input("Session name: "))'
nmap_leader("sd", '<Cmd>lua MiniSessions.select("delete")<CR>', "Delete")
nmap_leader("sn", "<Cmd>lua " .. session_new .. "<CR>", "New")
nmap_leader("sr", '<Cmd>lua MiniSessions.select("read")<CR>', "Read")
nmap_leader("sw", "<Cmd>lua MiniSessions.write()<CR>", "Write current")
nmap_leader("sR", "<Cmd>restart<CR>", "Restart")
nmap_leader("sq", "<cmd>qa<cr>", "Quit All")

local function make_pick_core(cwd, desc)
  return function()
    local sort_latest = MiniVisits.gen_sort.default({ recency_weight = 1 })
    local local_opts = { cwd = cwd, filter = "core", sort = sort_latest }
    MiniExtra.pickers.visit_paths(local_opts, { source = { name = desc } })
  end
end
nmap_leader("vc", make_pick_core("", "Core visits (all)"), "Core visits (all)")
nmap_leader("vC", make_pick_core(nil, "Core visits (cwd)"), "Core visits (cwd)")
nmap_leader("vv", '<Cmd>lua MiniVisits.add_label("core")<CR>', 'Add "core" label')
nmap_leader("vV", '<Cmd>lua MiniVisits.remove_label("core")<CR>', 'Remove "core" label')
nmap_leader("vl", "<Cmd>lua MiniVisits.add_label()<CR>", "Add label")
nmap_leader("vL", "<Cmd>lua MiniVisits.remove_label()<CR>", "Remove label")

nmap("<C-a>", '<Cmd>lua require("dial.map").manipulate("increment", "normal")<CR>', "Increment")
nmap("g<C-a>", '<Cmd>lua require("dial.map").manipulate("increment", "gnormal")<CR>', "Increment")
xmap("<C-a>", '<Cmd>lua require("dial.map").manipulate("increment", "visual")<CR>', "Increment")
xmap("g<C-a>", '<Cmd>lua require("dial.map").manipulate("increment", "gvisual")<CR>', "Increment")
nmap("<C-x>", '<Cmd>lua require("dial.map").manipulate("decrement", "normal")<CR>', "Decrement")
nmap("g<C-x>", '<Cmd>lua require("dial.map").manipulate("decrement", "gnormal")<CR>', "Decrement")
xmap("<C-x>", '<Cmd>lua require("dial.map").manipulate("decrement", "visual")<CR>', "Decrement")
xmap("g<C-x>", '<Cmd>lua require("dial.map").manipulate("decrement", "gvisual")<CR>', "Decrement")

local set_conditional_breakpoint = '<Cmd>lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>'
nmap_leader("db", '<Cmd>lua require("dap").toggle_breakpoint()<CR>', "Toggle breakpoint")
nmap_leader("dB", set_conditional_breakpoint, "Breakpoint conditional")
nmap_leader("dc", '<Cmd>lua require("dap").continue()<CR>', "Continue")
nmap_leader("dC", '<Cmd>lua require("dap").run_to_cursor()<CR>', "Run to cursor")
nmap_leader("de", '<Cmd>lua require("dap-view").add_expr()<CR>', "Expression watch")
nmap_leader("dg", '<Cmd>lua require("dap").goto_()<CR>', "Go to line (no execute)")
nmap_leader("di", '<Cmd>lua require("dap").setp_into()<CR>', "Step into")
nmap_leader("dj", '<Cmd>lua require("dap").down()<CR>', "Down")
nmap_leader("dk", '<Cmd>lua require("dap").up()<CR>', "Up")
nmap_leader("dl", '<Cmd>lua require("dap").run_last()<CR>', "Run last")
nmap_leader("dL", '<Cmd>lua require("osv").launch({port=8086})<CR>', "OSV launch")
nmap_leader("do", '<Cmd>lua require("dap").step_out()<CR>', "Step out")
nmap_leader("dO", '<Cmd>lua require("dap").step_over()<CR>', "Step over")
nmap_leader("dp", '<Cmd>lua require("dap").pause()<CR>', "Pause")
nmap_leader("dt", '<Cmd>lua require("dap").terminate()<CR>', "Terminate")
nmap_leader("du", '<Cmd>lua require("dap-view").toggle()<CR>', "Toggle nvim-dap-view")
nmap_leader("dw", '<Cmd>lua require("dap.ui.widgets").hover()<CR>', "Hover")

xmap_leader("de", '<Cmd>lua require("dap-view").add_expr()<CR>', "Expression watch")

nmap_leader("ta", '<Cmd>lua require("neotest").run.run(vim.uv.cwd())<CR>', "Run (all)")
nmap_leader("tf", '<Cmd>lua require("neotest").run.run(vim.fn.expand("%"))<CR>', "Run (file)")
nmap_leader("tl", '<Cmd>lua require("neotest").run.run_last()<CR>', "Run (last)")
nmap_leader("tO", '<Cmd>lua require("neotest").output_panel.toggle()<CR>', "Toggle output panel")
nmap_leader("tr", '<Cmd>lua require("neotest").run.run()<CR>', "Run (nearest)")
nmap_leader("ts", '<Cmd>lua require("neotest").summary.toggle()<CR>', "Toggle summary")
nmap_leader("tS", '<Cmd>lua require("neotest").run.stop()<CR>', "Stop")

nmap("]r", "<Cmd>lua Snacks.words.jump(vim.v.count1)<CR>", "Reference forward")
nmap("[r", "<Cmd>lua Snacks.words.jump(-vim.v.count1)<CR>", "Reference backward")

nmap_leader("dPs", "<Cmd>lua Snacks.profiler.scratch()<CR>", "Scratch")
nmap_leader("dPp", "<Cmd>lua Snacks.profiler.toggle()<CR>", "Profiler toggle")
nmap_leader("dPh", "<Cmd>lua Snacks.profiler.ui.toggle()<CR>", "Highlights toggle")

_G.Config.new_autocmd("LspAttach", nil, function(ev)
  local client = vim.lsp.get_client_by_id(ev.data.client_id)
  if not client or client.name ~= "rust-analyzer" then return end
  nmapb_lleader("e", "<cmd>RustLsp expandMacro<CR>", "Macro expand", ev.buf)
  nmapb_lleader("o", "<cmd>RustLsp openDocs<CR>", "Docs open", ev.buf)
  nmapb_lleader("O", "<cmd>RustLsp openCargo<CR>", "Cargo.toml open", ev.buf)
  nmapb_lleader("p", "<cmd>RustLsp parentModule<CR>", "Parent Module open", ev.buf)
  nmapb_lleader("R", "<cmd>RustLsp debuggables<CR>", "Debuggables", ev.buf)
end)

local function organize()
  vim.lsp.buf.code_action({ apply = true, context = { only = { "source.organizeImports" }, diagnostics = {} } })
end
_G.Config.new_autocmd("LspAttach", nil, function(ev)
  local client = vim.lsp.get_client_by_id(ev.data.client_id)
  if not client or client.name ~= "ruff" then return end
  nmapb_lleader("o", organize, "Imports organize", ev.buf)
end)
