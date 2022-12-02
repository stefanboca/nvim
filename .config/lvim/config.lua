--[[
lvim is the global options object
Linters should be filled in as strings with either a global executable or a path to an executable
]]

vim.opt.clipboard = ""
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.g.better_whitespace_filetypes_blacklist = { "alpha", "dashboard", "diff", "git", "gitcommit", "unite", "qf", "help",
    "markdown", "fugitive", "toggleterm" }

-- general
lvim.log.level = "warn"
lvim.format_on_save = false
lvim.colorscheme = "onedarker"

-- neovide
if vim.g.neovide then
    vim.opt.guifont = "Fira Code:h10"
    vim.g.neovide_cursor_vfx_mode = "pixiedust"
    vim.g.neovide_scroll_animation_length = 0.4
    vim.g.neovide_hide_mouse_when_typing = true
end

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
    -- for input mode
    i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
    },
    -- for normal mode
    n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
    },
}

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
    name = "+Trouble",
    r = { "<cmd>Trouble lsp_references<cr>", "References" },
    f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
    d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
    q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
    l = { "<cmd>Trouble loclist<cr>", "LocationList" },
    w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
}
lvim.builtin.which_key.mappings["R"] = {
    name = "+Rust",
    r = { "<cmd>RustRunnables<Cr>", "Runnables" },
    t = { "<cmd>lua _CARGO_TEST()<cr>", "Cargo Test" },
    m = { "<cmd>RustExpandMacro<Cr>", "Expand Macro" },
    c = { "<cmd>RustOpenCargo<Cr>", "Open Cargo" },
    p = { "<cmd>RustParentModule<Cr>", "Parent Module" },
    d = { "<cmd>RustDebuggables<Cr>", "Debuggables" },
    v = { "<cmd>RustViewCrateGraph<Cr>", "View Crate Graph" },
    R = {
        "<cmd>lua require('rust-tools/workspace_refresh')._reload_workspace_from_cargo_toml()<Cr>",
        "Reload Workspace",
    },
    o = { "<cmd>RustOpenExternalDocs<Cr>", "Open External Docs" },
}
lvim.builtin.which_key.mappings["lo"] = { "<cmd>SymbolsOutline<CR>", "Symbols Outline" }

lvim.builtin.treesitter.ensure_installed = {
    "bash",
    "c",
    "javascript",
    "json",
    "lua",
    "python",
    "typescript",
    "tsx",
    "css",
    "rust",
    "java",
    "yaml",
    "toml",
}
lvim.builtin.treesitter.highlight.enabled = true

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.dap.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"

-- generic LSP settings

---configure a server manually.
---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- NOTE: Requires `:LvimCacheReset` to take effect!!
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })

-- ---remove servers from the skipped list
vim.tbl_map(function(server)
    return server ~= "taplo"
end, lvim.lsp.automatic_configuration.skipped_servers)

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    { name = "black" },
}

-- Additional Plugins
lvim.plugins = {
    {
        "folke/trouble.nvim",
        cmd = "TroubleToggle",
    },
    {
        "ggandor/leap.nvim",
        event = "BufRead",
        config = function()
            require "leap".add_default_mappings()
        end
    },
    {
        "ggandor/flit.nvim",
        event = "BufRead",
        config = function()
            require "flit".setup()
        end
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "BufRead",
        config = function()
            require "lsp_signature".setup()
        end
    },
    {
        "simrat39/symbols-outline.nvim",
        cmd = "SymbolsOutline",
        config = function()
            require "symbols-outline".setup()
        end
    },
    {
        "metakirby5/codi.vim",
        cmd = "Codi",
    },
    {
        "monaqa/dial.nvim",
        event = "BufRead",
        config = function()
            vim.cmd [[
                nmap <C-a> <Plug>(dial-increment)
                nmap <C-x> <Plug>(dial-decrement)
                vmap <C-a> <Plug>(dial-increment)
                vmap <C-x> <Plug>(dial-decrement)
                vmap g<C-a> <Plug>(dial-increment-additional)
                vmap g<C-x> <Plug>(dial-decrement-additional)
        ]]
        end,
    },
    {
        "karb94/neoscroll.nvim",
        event = "WinScrolled",
        config = function()
            require("neoscroll").setup({
                -- All these keys will be mapped to their corresponding default scrolling animation
                mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>",
                    "<C-y>", "<C-e>", "zt", "zz", "zb" },
                hide_cursor = true, -- Hide cursor while scrolling
                stop_eof = true, -- Stop at <EOF> when scrolling downwards
                use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
                respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
                cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
                easing_function = nil, -- Default easing function
                pre_hook = nil, -- Function to run before the scrolling animation starts
                post_hook = nil, -- Function to run after the scrolling animation ends
            })
        end,
        cond = function()
            return vim.g.neovide == nil
        end
    },
    {
        "folke/todo-comments.nvim",
        event = "BufRead",
        config = function()
            require("todo-comments").setup()
        end,
    },
    {
        "itchyny/vim-cursorword",
        event = { "BufEnter", "BufNewFile" },
        config = function()
            vim.api.nvim_command("augroup user_plugin_cursorword")
            vim.api.nvim_command("autocmd!")
            vim.api.nvim_command("autocmd FileType NvimTree,lspsagafinder,dashboard,vista let b:cursorword = 0")
            vim.api.nvim_command("autocmd WinEnter * if &diff || &pvw | let b:cursorword = 0 | endif")
            vim.api.nvim_command("autocmd InsertEnter * let b:cursorword = 0")
            vim.api.nvim_command("autocmd InsertLeave * let b:cursorword = 1")
            vim.api.nvim_command("augroup END")
        end
    },
    { "tpope/vim-repeat" },
    {
        "felipec/vim-sanegx",
        event = "BufRead",
    },
    {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup()
        end
    },
    {
        "aserowy/tmux.nvim",
        config = function()
            require("tmux").setup({
                copy_sync = {
                    enable = false,
                    redirect_to_clipboard = false,
                    sync_clipboard = false,
                    sync_deletes = false,
                    sync_unnamed = false,
                },
                navigation = {
                    enable_default_keybindings = true,
                },
                resize = {
                    enable_default_keybindings = true,
                }
            })
        end
    },
    -- {
    --     "chipsenkbeil/distant.nvim",
    --     config = function()
    --         require("distant").setup {
    --             -- Applies Chip's personal settings to every machine you connect to
    --             --
    --             -- 1. Ensures that distant servers terminate with no connections
    --             -- 2. Provides navigation bindings for remote directories
    --             -- 3. Provides keybinding to jump into a remote file"s parent directory
    --             ["*"] = require("distant.settings").chip_default()
    --         }
    --     end
    -- },
    {
        "ellisonleao/glow.nvim"
    },
    {
        "ntpeters/vim-better-whitespace"
    },
    {
        "evanleck/vim-svelte",
        setup = function()
            vim.g.svelte_preprocessor_tags = { { name = "ts", tag = "script", as = "typescript" } }
            vim.g.svelte_preprocessors = { "ts" }
        end
    },
    {
        "simrat39/rust-tools.nvim",
        config = function()
            local status_ok, rust_tools = pcall(require, "rust-tools")
            if not status_ok then
                return
            end

            local opts = {
                tools = {
                    executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
                    reload_workspace_from_cargo_toml = true,
                    inlay_hints = {
                        auto = true,
                        only_current_line = false,
                        show_parameter_hints = true,
                        parameter_hints_prefix = "<-",
                        other_hints_prefix = "=>",
                        max_len_align = false,
                        max_len_align_padding = 1,
                        right_align = false,
                        right_align_padding = 7,
                        highlight = "Comment",
                    },
                    hover_actions = {
                        border = {
                            { "╭", "FloatBorder" },
                            { "─", "FloatBorder" },
                            { "╮", "FloatBorder" },
                            { "│", "FloatBorder" },
                            { "╯", "FloatBorder" },
                            { "─", "FloatBorder" },
                            { "╰", "FloatBorder" },
                            { "│", "FloatBorder" },
                        },
                        auto_focus = true,
                    },
                },
                server = {
                    on_attach = require("lvim.lsp").common_on_attach,
                    on_init = require("lvim.lsp").common_on_init,
                },
            }

            local path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/") or ""
            local codelldb_path = path .. "adapter/codelldb"
            local liblldb_path = path .. "lldb/lib/liblldb.so"

            if vim.fn.filereadable(codelldb_path) and vim.fn.filereadable(liblldb_path) then
                opts.dap = {
                    adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
                }
            else
                local msg = "Either codelldb or liblldb is not readable."
                    .. "\n codelldb: "
                    .. codelldb_path
                    .. "\n liblldb: "
                    .. liblldb_path
                vim.notify(msg, vim.log.levels.ERROR)
            end

            rust_tools.setup(opts)
        end,
        ft = { "rust", "rs" },
    },
    {
        "saecki/crates.nvim",
        tag = "v0.3.0",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("crates").setup {
                null_ls = {
                    enabled = true,
                    name = "crates.nvim",
                },
            }
        end,
    },
    {
        "j-hui/fidget.nvim",
        config = function()
            require("fidget").setup()
        end,
    },
    {
        'glacambre/firenvim',
        run = function() vim.fn['firenvim#install'](0) end
    }
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands = {
    {
        "BufEnter", {
            pattern = { "*.toml" }, callback = function()
                require("lvim.lsp.manager").setup("taplo")
            end
        }
    }
}
