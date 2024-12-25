return {
  -- neo-tree folding rules
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = { mappings = { e = "toggle_node" } },
      nesting_rules = {
        ["README.*"] = {
          ignore_case = true,
          pattern = "README%.(.*)$",
        -- stylua: ignore
        files = { "AUTHORS", "CHANGELOG*", "CONTRIBUT*", "LICENSE*", "RELEASE_NOTES*", "ROADMAP*", "SECURITY*", "GOVERNANCE*" },
        },
        [".gitignore"] = {
          pattern = "%.gitignore$",
          files = { "%.gitattributes", "%.gitmodules" },
        },
        ["pyproject.toml"] = {
          pattern = "pyproject%.toml$",
          files = { "%.python-version", "uv%.lock" },
        },
        ["Cargo.toml"] = {
          pattern = "Cargo%.toml$",
          files = { "*clippy%.toml", "*rustfmt%.toml", "Cargo%.lock", "rust-toolchain%.toml" },
        },
        ["flake.nix"] = {
          pattern = "flake%.nix$",
          files = { "flake%.lock" },
        },
        ["package.json"] = {
          pattern = "package%.json$",
        -- stylua: ignore
        files = { "%.node-version", "%.npm*", "%.pnpm*", "package-lock%.json", "pnpm*", "yarn*", "netlify*", "vercel*", "*eslint*", "*prettier*", "node_modules" },
        },
        ["svelte.config.*"] = {
          pattern = "svelte%.config%.(.*)$",
        -- stylua: ignore
        files = { "postcss%.config%.*", "tailwind%.config%.*", "windi%.config%.*",  "tsconfig%.*", "vite%.config%.*", "%.svelte-kit"},
        },
        ["+layout.svelte"] = {
          pattern = "+layout%.svelte$",
          files = { "+layout%.*" },
        },
        ["+page.svelte"] = {
          pattern = "+page%.svelte$",
          files = { "+page%.*" },
        },
      },
    },
  },

  -- edit browser textboxes in nvim
  {
    "subnut/nvim-ghost.nvim",
    cmd = { "GhostTextStart" },
    init = function()
      vim.g.nvim_ghost_autostart = 0
    end,
  },
}
