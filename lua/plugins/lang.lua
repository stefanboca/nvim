return {
  { import = "lazyvim.plugins.extras.lang.clangd" },
  { import = "lazyvim.plugins.extras.lang.cmake" },
  { import = "lazyvim.plugins.extras.lang.docker" },
  { import = "lazyvim.plugins.extras.lang.java" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.markdown" },
  { import = "lazyvim.plugins.extras.lang.python" },
  { import = "lazyvim.plugins.extras.lang.rust" },
  { import = "lazyvim.plugins.extras.lang.tex" },
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.tailwind" },
  { import = "lazyvim.plugins.extras.lang.yaml" },
  {
    "IndianBoy42/tree-sitter-just",
    ft = { "just" },
    config = function(opts)
      require("tree-sitter-just").setup(opts)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "just",
        "svelte",
      },
    },
  },
  {
    "lervag/vimtex",
    config = function()
      vim.g.vimtex_view_method = "zathura"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        texlab = {
          settings = {
            texlab = {
              build = {
                executable = "tectonic",
                args = { "-X", "compile", "%f", "--synctex", "--keep-logs", "--keep-intermediates" },
              },
            },
          },
        },
      },
    },
  },
  {
    "mrcjkb/rustaceanvim",
    -- dependencies = {
    --   "folke/which-key.nvim",
    -- },
    opts = {
      server = {
        on_attach = function(_, bufnr)
          local wk = require("which-key")

          local function mapping(cmd)
            return function()
              vim.cmd.RustLsp(cmd)
            end
          end

          wk.register({
            ["<leader>cR"] = {
              name = "+Rust",
              c = { mapping("codeAction"), "Code Action" },
              o = { mapping("openCargo"), "Open Cargo.toml" },
              O = { mapping("openDocs"), "Open docs" },
              r = { mapping("run"), "Run" },
              R = { mapping("runnables"), "Runnables" },
              m = { mapping("expandMacro"), "Expand Macro" },
            },
            ["<leader>dr"] = { mapping("debuggables"), "Rust Debuggables" },
          }, { buffer = bufnr })
        end,
      },
    },
  },
}
