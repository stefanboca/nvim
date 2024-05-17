return {
  {
    "lervag/vimtex",
    config = function()
      vim.g.vimtex_view_method = "zathura"
    end,
    enabled = false,
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
    opts = {
      server = {
        on_attach = function(_, bufnr)
          local function mapping(cmd)
            return function()
              vim.cmd.RustLsp(cmd)
            end
          end

          require("which-key").register({
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
