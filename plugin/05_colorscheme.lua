MiniDeps.now(function()
  local catppuccin = require("catppuccin")
  catppuccin.setup({
    background = { dark = "mocha" },
    dim_inactive = { enabled = true },
    lsp_styles = { enabled = true },
    integrations = {
      -- keep-sorted start
      blink_cmp = { enabled = true, style = "bordered" },
      blink_indent = true,
      blink_pairs = true,
      dap = true,
      diffview = true,
      grug_far = true,
      lsp_trouble = true,
      mini = { enabled = true },
      neogit = true,
      neotest = true,
      snacks = { enabled = true },
      treesitter_context = true,
      -- keep-sorted end
    },
    custom_highlights = function(C)
      return {
        MatchParen = { fg = "NONE", bg = C.surface1, style = { "bold" } },

        -- Use fg insted of bg
        ["@comment.error"] = { fg = C.red, bg = "NONE" },
        ["@comment.warning"] = { fg = C.yellow, bg = "NONE" },
        ["@comment.hint"] = { fg = C.blue, bg = "NONE" },
        ["@comment.todo"] = { fg = C.flamingo, bg = "NONE" },
        ["@comment.note"] = { fg = C.rosewater, bg = "NONE" },

        -- Remove italic, make underline blue
        MiniTablineCurrent = { fg = C.text, bg = C.base, sp = C.blue, style = { "bold", "underline" } },
        -- Remove italic, add blue underline
        MiniTablineModifiedCurrent = { fg = C.red, bg = C.none, sp = C.blue, style = { "bold", "underline" } },
        -- Make it more readable
        MiniTablineTabpagesection = { fg = C.text, bg = C.mantle },
      }
    end,
  })
  catppuccin.load()
end)
