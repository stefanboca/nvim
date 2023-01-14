vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- neovide
if vim.g.neovide then
    vim.opt.guifont = "Fira Code:h10"
    vim.g.neovide_cursor_vfx_mode = "pixiedust"
    vim.g.neovide_scroll_animation_length = 0.4
    vim.g.neovide_hide_mouse_when_typing = true
end

-- general
lvim.leader = "space"
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "onedarker"
lvim.builtin.cmp.cmdline.enable = true

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
    i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
    },
    n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
    },
}

lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope Projects<CR>", "Projects" }
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
    R = { "<cmd>lua require('rust-tools/workspace_refresh')._reload_workspace_from_cargo_toml()<Cr>", "Reload Workspace" },
    o = { "<cmd>RustOpenExternalDocs<Cr>", "Open External Docs" },
}
lvim.builtin.which_key.mappings["lo"] = { "<cmd>SymbolsOutline<CR>", "Symbols Outline" }
lvim.builtin.which_key.mappings["lR"] = { ":IncRename ", "Immediate Rename" }
lvim.builtin.which_key.mappings["lt"] = { "<cmd>lua require('whitespace-nvim').trim()<Cr>", "Trim Whitespace" }
lvim.builtin.which_key.mappings["sn"] = { "<cmd>Noice telescope<CR>", "Noice" }

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

---configure a server manually.
---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- NOTE: Requires `:LvimCacheReset` to take effect!!
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })

-- ---remove servers from the skipped list
-- vim.tbl_map(function(server)
--     return server ~= "taplo"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup {
    { name = "black" },
}
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {}

-- Additional Plugins
lvim.plugins = {
    {
        "folke/trouble.nvim",
        cmd = "TroubleToggle",
    },
    {
        "ggandor/leap.nvim",
        config = function()
            require("leap").add_default_mappings()
        end
    },
    {
        "ggandor/flit.nvim",
        event = "BufRead",
        config = function()
            require("flit").setup {}
        end
    },
    {
        "simrat39/symbols-outline.nvim",
        cmd = "SymbolsOutline",
        config = function()
            require("symbols-outline").setup {}
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
            require("neoscroll").setup {
                -- All these keys will be mapped to their corresponding default scrolling animation
                mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>",
                    "<C-y>", "<C-e>", "zt", "zz", "zb" },
                hide_cursor = true, -- Hide cursor while scrolling
                stop_eof = true, -- Stop at <EOF> when scrolling downwards
                respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
                cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
            }
        end,
        cond = not vim.g.neovide,
        enabled = false
    },
    {
        "declancm/cinnamon.nvim",
        config = function()
            require("cinnamon").setup {
                default_delay = 5,
            }
        end,
        enabled = false
    },
    {
        "folke/todo-comments.nvim",
        event = "BufRead",
        config = function()
            require("todo-comments").setup {}
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
            require("nvim-surround").setup {}
        end
    },
    {
        "aserowy/tmux.nvim",
        config = function()
            require("tmux").setup {
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
            }
        end
    },
    {
        "chipsenkbeil/distant.nvim",
        config = function()
            require("distant").setup {
                -- Applies Chip's personal settings to every machine you connect to
                --
                -- 1. Ensures that distant servers terminate with no connections
                -- 2. Provides navigation bindings for remote directories
                -- 3. Provides keybinding to jump into a remote file"s parent directory
                ["*"] = require("distant.settings").chip_default()
            }
        end,
        enabled = false
    },
    {
        "ellisonleao/glow.nvim"
    },
    {
        'johnfrankmorgan/whitespace.nvim',
        config = function()
            require("whitespace-nvim").setup {
                highlight = "DiffDelete",
                ignored_filetypes = { "TelescopePrompt", "Trouble", "help", "alpha", "dashboard", "diff", "git",
                    "gitcommit", "unite", "qf", "markdown", "fugitive", "toggleterm", "lazy" }
            }
        end
    },
    {
        "evanleck/vim-svelte",
        init = function()
            vim.g.svelte_preprocessor_tags = { { name = "ts", tag = "script", as = "typescript" } }
            vim.g.svelte_preprocessors = { "ts" }
        end
    },
    {
        "saecki/crates.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
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
        "glacambre/firenvim",
        build = function()
            vim.fn["firenvim#install"](0)
        end
    },
    {
        "lervag/vimtex",
        init = function()
            vim.g.vimtex_view_method = "zathura"
        end
    },
    { "MunifTanjim/nui.nvim" },
    { "rcarriga/nvim-notify" },
    {
        "folke/noice.nvim",
        config = function()
            require("noice").setup {
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                },
                -- you can enable a preset for easier configuration
                presets = {
                    bottom_search = false, -- use a classic bottom cmdline for search
                    command_palette = true, -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = true, -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = true, -- add a border to hover docs and signature help
                },
            }
        end,
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        cond = not vim.g.neovide
    },
    {
        "smjonas/inc-rename.nvim",
        config = function()
            require("inc_rename").setup {}
        end,
    },
    {
        "stevearc/dressing.nvim",
        config = function()
            require("dressing").setup {}
        end
    },
    {
        "simrat39/rust-tools.nvim",
        config = function()
            local extensions_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/") or ""

            require("rust-tools").setup {
                tools = {
                    executor = require("rust-tools/executors").quickfix, -- can be quickfix or termopen
                    hover_actions = {
                        auto_focus = true,
                    },
                },
                server = {
                    on_attach = require("lvim.lsp").common_on_attach,
                    on_init = require("lvim.lsp").common_on_init,
                },
                dap = {
                    adapter = require("rust-tools.dap").get_codelldb_adapter(extensions_path .. "adapter/codelldb",
                        extensions_path .. "lldb/lib/liblldb.so"),
                }
            }
        end,
    },
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
