return {
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
