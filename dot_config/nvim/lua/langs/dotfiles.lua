vim.lsp.enable("bashls")

local chezmoi_pattern = os.getenv("HOME") .. "/.local/share/chezmoi/*"

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "git_config" },
    },
  },
  {
    "mason.nvim",
    opts = { ensure_installed = { "bash-language-server" } },
  },

  -- highlighting for chezmoi files template files
  {
    "alker0/chezmoi.vim",
    init = function() vim.g["chezmoi#use_tmp_buffer"] = true end,
  },
  {
    "xvzc/chezmoi.nvim",
    cmd = { "ChezmoiEdit" },
    event = { "BufRead " .. chezmoi_pattern, "BufNewFile " .. chezmoi_pattern },
    opts = {
      notifications = { on_watch = true },
    },
    init = function()
      -- run chezmoi edit on file enter
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = { chezmoi_pattern },
        callback = function(ev)
          vim.schedule(function() require("chezmoi.commands.__edit").watch(ev.buf) end)
        end,
      })
    end,
  },

  -- Filetype icons
  {
    "echasnovski/mini.icons",
    opts = {
      file = {
        [".chezmoiignore"] = { glyph = "", hl = "MiniIconsGrey" },
        [".chezmoiremove"] = { glyph = "", hl = "MiniIconsGrey" },
        [".chezmoiroot"] = { glyph = "", hl = "MiniIconsGrey" },
        [".chezmoiversion"] = { glyph = "", hl = "MiniIconsGrey" },
        ["bash.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
        ["json.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
        ["ps1.tmpl"] = { glyph = "󰨊", hl = "MiniIconsGrey" },
        ["sh.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
        ["toml.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
        ["yaml.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
        ["zsh.tmpl"] = { glyph = "", hl = "MiniIconsGrey" },
      },
    },
  },
}
